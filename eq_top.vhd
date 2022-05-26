library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity eq_top is
   port(
      clk: in std_logic;
      sw  : in  std_logic_vector(15 downto 0);
      sseg : out std_logic_vector(7 downto 0);
      an: out std_logic_vector(7 downto 0) 
   );
end eq_top;

architecture struc_arch of eq_top is
    signal led0, led1, led2, led3 : std_logic_vector (7 downto 0);
    signal led4, led5, led6, led7 : std_logic_vector (7 downto 0); 
    signal inc3, inc2, inc1, inc0 : std_logic_vector (3 downto 0);
begin
   hex_sseg0 : entity work.hex_to_sseg
      port map(
         hex => sw(3 downto 0),
         dp => '1',
         sseg => led0
      ); 
   hex_sseg1 : entity work.hex_to_sseg
      port map(
         hex    => sw(7 downto 4),
         dp     => '1',
         sseg   => led1
      ); 
   hex_sseg2 : entity work.hex_to_sseg
       port map(
          hex    => sw(11 downto 8),
          dp     => '1',
          sseg   => led2
       ); 
   hex_sseg3 : entity work.hex_to_sseg
        port map(
            hex    => sw(15 downto 12),
            dp     => '1',
            sseg   => led3
        );
        
   hex_sseg4 : entity work.hex_to_sseg
              port map(
                 hex => inc0,
                 dp => '1',
                 sseg => led4
              ); 
           hex_sseg5 : entity work.hex_to_sseg
              port map(
                 hex    => inc1,
                 dp     => '1',
                 sseg   => led5
              ); 
           hex_sseg6 : entity work.hex_to_sseg
               port map(
                  hex    => inc2,
                  dp     => '1',
                  sseg   => led6
               ); 
           hex_sseg7 : entity work.hex_to_sseg
                port map(
                    hex    => inc3,
                    dp     => '1',
                    sseg   => led7
                );
        
   inc0 <= std_logic_vector(unsigned(sw(3 downto 0)) + 1);
   inc1 <= std_logic_vector(unsigned(sw(7 downto 4)) + 1);
   inc2 <= std_logic_vector(unsigned(sw(11 downto 8)) + 1);
   inc3 <= std_logic_vector(unsigned(sw(15 downto 12)) + 1);
        
   prog: entity work.led_mux8
      port map(
         clk        => clk,
         reset      => '0',
         in0        => led0,
         in1        => led1,
         in2        => led2,
         in3        => led3,
         in4        => led4,
         in5        => led5,
         in6        => led6, 
         in7        => led7,
         an         => an(7 downto 0),
         sseg       => sseg(7 downto 0)
      );
end struc_arch;