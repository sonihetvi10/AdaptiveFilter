img =imread('cameraman.tif')

figure(),

imshow(img)

title('original image')

img1 = imnoise (img,'gaussian',0.)


figure()
imshow(img1)

title('corrupted image with salt and pepper noise')

img2 = medfilt2(img1)

figure()

imshow(img2)

title('median filter output with 3x3 window')

img3 =medfilt2(img1,[5,5])

figure()
imshow(img3)

title('median filter output with 5x5 window')


ip_edge =zeros(size(img1)+20);

ip_edge(11:end-10,11:end-10)=double(img1);


smax=9


for i=11:266
    
     for j=11:266
        
          sx=3;
 
           sy=3;
        
           while ((sx<=smax) & (sy<=smax))
           
           ip_edge_min = ip_edge (i, j);
           
           ip_edge_max = ip_edge (i, j);
           
           ip_edge_median = median(median(ip_edge((i-floor(sx/2)):(i+floor(sx/2)),(floor(sy/2)):(j+floor(sy/2)))));
         
           for k= (i-floor (sx/2)) :( i+floor (sx/2))
               
                   for l= (j-floor (sy/2)) :( j+floor (sy/2))
                 
                          if ip_edge (k, l) < ip_edge_min
                      
                               ip_edge_min = ip_edge (k, l);
                 
                               end 
                 
                           if ip_edge (k, l) > ip_edge_max
                
                              ip_edge_max = ip_edge (k, l);
              
                      end 
        
                     end 
     
                  end 
      
 A = ip_edge_median - ip_edge_min;
        
 B = ip_edge_median - ip_edge_max;
        
 if (A>0) & (B<0)
             
     C = ip_edge (i, j) - ip_edge_min;
              
      D = ip_edge (i,j) - ip_edge_max;
        
          if (C>0) & (D<0)
                  
             pledge (i, j) = ip_edge (i, j);
                
                break
         
               else
                  
                       ip_edge (i, j) = ip_edge_median;
                
              break
             
               end 
          
                    else 
             
                         sx=sx+2;
          
                          sy=sy+2;
        
                           if (sx>smax) & (sy>smax)
                
                           ip_edge(i,j) = ip_edge(i,j);
               
end 
        
end
        
end 
  
end 

end 

figure(), 
clf;

imshow(ip_edge,[]);
title('adaptive median filter')
