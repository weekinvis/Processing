int[][] grid;
int tamanhoGrid = 150;

void setup() {
  size(700, 700);
  grid = criaGrid();
}

int[][] criaGrid() {
   int[][] Grid;
   Grid = new int[tamanhoGrid][tamanhoGrid];
   
   for(int p = 0; p < tamanhoGrid; p++) {
     for(int q = 0; q < tamanhoGrid; q++) {
       Grid[p][q] = random(1) < 0.4 ? 1 : Grid[p][q];
       Grid[p][q] = random(1) < 0.4 ? 2 : Grid[p][q];
     }
   }
   
   return Grid;
  
}

void mostraGrid() {
   float altura = height / (float)tamanhoGrid;
   float largura = width / (float)tamanhoGrid;
   
   for(int p = 0; p < tamanhoGrid; p++) {
     for(int q = 0; q < tamanhoGrid; q++) {
        switch(grid[p][q]) {
           case 1:
             fill(#0FF55D);
             break;
           case 2:
             fill(#40A0F2);
             break;
           default:
             fill(255);
             break;
             
        }
        rect(q*largura, p*altura, largura, altura);
     }
   }
}

int contaVizinhos(int p, int q) {
   int soma = -1;
   for(int r = -1; r <= 1; r++) {
     for(int s = -1; s <= 1; s++) {
       if(grid[(tamanhoGrid + p + r) % tamanhoGrid][(tamanhoGrid + q + s) % tamanhoGrid] == grid[p][q]) {
         soma++;
       }
         
     }
   }
  return soma;
}

void atualizaGrid() {
   int[][] novoGrid = new int[tamanhoGrid][tamanhoGrid];
   int vizinhos;
   
   for(int p = 0; p < tamanhoGrid; p++) {
     for(int q = 0; q < tamanhoGrid; q++) {
        if(grid[p][q] == 0) {
          continue;
        }
        vizinhos = contaVizinhos(p, q);
        if(vizinhos < 3) {
           while(true) {
            int r = (int)random(tamanhoGrid);
            int s = (int)random(tamanhoGrid); 
            
            if(grid[r][s] == 0 && novoGrid[r][s] == 0) {
               novoGrid[r][s] = grid[p][q];
               novoGrid[p][q] = 0;
              break;
            }
          }
        }
       else {
         novoGrid[p][q] = grid[p][q];
       }
     }
   }
  grid = novoGrid;
  
}

void draw() {
  mostraGrid();
  atualizaGrid();
  if(mousePressed) grid = criaGrid();
}
