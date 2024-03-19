`timescale 1ns / 1ps

 
module pwm(
input clk, rst, 
output reg dout
);
 
parameter period = 100;
integer count = 0;
integer ton   = 0;
reg nc      = 1'b0;
reg key=1'b0;

 
always@(posedge clk)
begin
     if(rst == 1'b1)
        begin
         count <= 0;
         ton   <= 0;
         nc  <= 1'b0;
        end   
     else 
       begin
            if(count <= ton) 
              begin
              count <= count + 1;
              dout  <= 1'b1;
              nc  <= 1'b0;
              end
            else if (count < period)
              begin
              count <= count + 1;
              dout <= 1'b0;
              nc <= 1'b0;
              end
            else
               begin
               nc  <= 1'b1;
               count <= 0;
               end
       end
end
 
 
always@(posedge clk)
begin
     if(rst == 1'b0) 
     begin 
             if(nc == 1'b1)
                begin
                    if(key == 1'b1 && ton==0) begin
                       key <= 0;
                        ton <= 0;
                       end
                     else if (key==0 && ton<period) begin
                       key<=0;
                       ton <= ton+5;
                       end
                     else begin
                     key<=1;
                     ton=ton-5;
                     end
                end
     end   
end
endmodule
