import org.gicentre.utils.stat.*;        // For chart classes.

////////////////////new total://///////////////
JSONArray values;
JSONObject corona;
//////////////////////////////////////////////
Table table;
String[] provinceNames = {"WC", "KZN", "GP", "MP", "LP", "NW", "FS", "EC", "NC", "UNKNOWN", "total"};

int[] provinces = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int[] lat = {110, 370, 305, 360, 325, 235, 250, 250, 130, 290, 340};
int[] lon = {355, 210, 130, 125, 65, 145, 225, 315, 240, 370, 350};
int total = 0;

float[] risingTotal= {0};

PImage map1;

BarChart barChart;
PFont titleFont,smallFont;

void setup() {
  //titleFont = loadFont("Helvetica-22.vlw");
  //smallFont = loadFont("Helvetica-12.vlw");
  //textFont(smallFont);

  barChart = new BarChart(this);
  
  total = 0; //double check we get this right at the start
  noLoop(); //new try this
  size(640, 480);

  textSize(20);
  map1 = loadImage("map.gif");
  background(0);
  //image(map1, 0, 0, width, height);

  //offline for testing:
  //  table = loadTable("data.csv", "header, csv");

  //online:  
  table = loadTable("https://raw.githubusercontent.com/dsfsi/covid19za/master/data/covid19za_provincial_cumulative_timeline_confirmed.csv", "header, csv");
  for (TableRow row : table.rows()) {
    total++;
    float nextTotal = row.getInt(provinceNames[provinces.length-1]);
    //println(total + ": " + nextTotal);
    if(nextTotal > 0){
    risingTotal = append(risingTotal, nextTotal);
    }
  }
  //println(risingTotal);
  barChart.setData(risingTotal);
  barChart.setBarColour(color(200,80,80,100));
  barChart.setBarGap(2); 
  //barChart.setValueFormat("$###,###");
  barChart.showValueAxis(true); 
  barChart.showCategoryAxis(false); 
  
  barChart.draw(10,10,width-20,height-20);

int d = day();    // Values from 1 - 31
int m = month();  // Values from 1 - 12
int y = year();   // 2003, 2004, 2005, etc.

text("Daily Increase in Cases Up until " + d + "/" + m + "/" + y, 70, 30);
  //println(total);
/*
  TableRow row = table.getRow(total-1);
  //println(row);

  /////////////////////////////////////////////Error Check: ///////////////////////////////////////////////////////
  // these dssi guys are making problems with the data, the provincial data could be 0 or null... check for that:
  //check for 0 data in provinces (this happened on 1st April, what a joke):
  if (row.getInt(provinceNames[0]) == 0) {
    total--; //use previous row then if 0
    row = table.getRow(total-1);
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//load data into array:
  for (int i = 0; i < provinces.length; i++) {
    int provinceData = row.getInt(provinceNames[i]); //number of cases in eg EC loaded
    provinces[i] = provinceData; 
    //println(provinces[i]);
  }

//print data as text on top of map:
  for (int i = 0; i < provinces.length; i++) {
    fill(0);
    //adjust text co-ordinates
    float latAdj = map(lat[i], 0, 450, 0, width);
    float lonAdj = map(lon[i], 0, 383, 0, height);
    text(provinces[i], latAdj, lonAdj);
    println("total " + provinceNames[i] + ": " + provinces[i]);
  }

  //add unknown province:
  float latAdj2 = map(290, 0, 450, 0, width);
  float lonAdj2 = map(370, 0, 383, 0, height);
  text("unknown province:", latAdj2-180, lonAdj2);
  */
}
