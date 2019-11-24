Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2C71083DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 15:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfKXOxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 09:53:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:50277 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfKXOxT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 09:53:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 06:53:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,238,1571727600"; 
   d="gz'50?scan'50,208,50";a="233157644"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Nov 2019 06:53:17 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iYtGH-000AfE-0l; Sun, 24 Nov 2019 22:53:17 +0800
Date:   Sun, 24 Nov 2019 22:52:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        darrick.wong@oracle.com, sandeen@sandeen.net
Subject: Re: [PATCH 4/5] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <201911242203.bV0i78w8%lkp@intel.com>
References: <20191122085320.124560-5-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="brqgdvcvwxapppby"
Content-Disposition: inline
In-Reply-To: <20191122085320.124560-5-cmaiolino@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--brqgdvcvwxapppby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Carlos,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hch-configfs/for-next]
[also build test ERROR on v5.4-rc8 next-20191122]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Carlos-Maiolino/Refactor-ioctl_fibmap-internal-interface/20191124-165458
base:   git://git.infradead.org/users/hch/configfs.git for-next
config: riscv-allnoconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/inode.c:7:0:
   include/linux/fs.h: In function 'bmap':
   include/linux/fs.h:2869:31: error: parameter name omitted
    static inline int bmap(struct inode *,  sector_t *)
                                  ^~~~~
   include/linux/fs.h:2869:31: error: parameter name omitted
   fs/inode.c: At top level:
>> fs/inode.c:1608:5: error: redefinition of 'bmap'
    int bmap(struct inode *inode, sector_t *block)
        ^~~~
   In file included from fs/inode.c:7:0:
   include/linux/fs.h:2869:19: note: previous definition of 'bmap' was here
    static inline int bmap(struct inode *,  sector_t *)
                      ^~~~

vim +/bmap +1608 fs/inode.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  1593  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1594  /**
^1da177e4c3f41 Linus Torvalds  2005-04-16  1595   *	bmap	- find a block number in a file
1dc338a4af8188 Carlos Maiolino 2019-11-22  1596   *	@inode:  inode owning the block number being requested
1dc338a4af8188 Carlos Maiolino 2019-11-22  1597   *	@block: pointer containing the block to find
^1da177e4c3f41 Linus Torvalds  2005-04-16  1598   *
1dc338a4af8188 Carlos Maiolino 2019-11-22  1599   *	Replaces the value in *block with the block number on the device holding
1dc338a4af8188 Carlos Maiolino 2019-11-22  1600   *	corresponding to the requested block number in the file.
1dc338a4af8188 Carlos Maiolino 2019-11-22  1601   *	That is, asked for block 4 of inode 1 the function will replace the
1dc338a4af8188 Carlos Maiolino 2019-11-22  1602   *	4 in *block, with disk block relative to the disk start that holds that
1dc338a4af8188 Carlos Maiolino 2019-11-22  1603   *	block of the file.
1dc338a4af8188 Carlos Maiolino 2019-11-22  1604   *
1dc338a4af8188 Carlos Maiolino 2019-11-22  1605   *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into a
1dc338a4af8188 Carlos Maiolino 2019-11-22  1606   *	hole, returns 0 and *block is also set to 0.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1607   */
1dc338a4af8188 Carlos Maiolino 2019-11-22 @1608  int bmap(struct inode *inode, sector_t *block)
^1da177e4c3f41 Linus Torvalds  2005-04-16  1609  {
1dc338a4af8188 Carlos Maiolino 2019-11-22  1610  	if (!inode->i_mapping->a_ops->bmap)
1dc338a4af8188 Carlos Maiolino 2019-11-22  1611  		return -EINVAL;
1dc338a4af8188 Carlos Maiolino 2019-11-22  1612  
1dc338a4af8188 Carlos Maiolino 2019-11-22  1613  	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
1dc338a4af8188 Carlos Maiolino 2019-11-22  1614  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1615  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  1616  EXPORT_SYMBOL(bmap);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1617  

:::::: The code at line 1608 was first introduced by commit
:::::: 1dc338a4af818855d7878307b8026c6af9e6304a fs: Enable bmap() function to properly return errors

:::::: TO: Carlos Maiolino <cmaiolino@redhat.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--brqgdvcvwxapppby
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICP9i2l0AAy5jb25maWcAnVxtc9u2sv7eX8FJZ+4kc5rUsZ00PXf8AQJBCRVJMAQp2fnC
USTa0cSWfPXSJvfXn12QFEFyoeTeTps62MUSL4vdZxcL//rLrx47HrZPi8N6uXh8/O49lJty
tziUK+9+/Vj+t+crL1aZJ3yZvQHmcL05fvt9t94v//bevbl+c/F6t3zvTcvdpnz0+HZzv344
Qvf1dvPLr7/Av79C49MzSNr92zO93l+/fkQZrx+WS+/lmPNX3h8oB3i5igM5LjgvpC6AcvO9
aYK/FDORaqnimz8uri8uTrwhi8cn0oUlYsJ0wXRUjFWmWkE1Yc7SuIjY3UgUeSxjmUkWyk/C
bxmzSSqYX8g4UPBHkTE9BaKZ0Nis0KO3Lw/H53bYo1RNRVyouNBR0gpC6YWIZwVLx0UoI5nd
XF3istQDUlEiQ1FkQmfeeu9ttgcU3DJMYBgiHdBraqg4C5vpv3jRdrMJBcszRXQe5TL0C83C
DLvWjb4IWB5mxUTpLGaRuHnxcrPdlK8s2fpOz2TCyeHyVGldRCJS6V3BsozxCcmXaxHKETGo
CZsJWCs+gVGDzsG3YCJhs/Yy/ejtj5/33/eH8qld+7GIRSpBb9KPhZ6oubX80OKriMm4bdMJ
S7VAErT96pWblbe974mmJEewLhIGGPuhSC3lrFk4rPlUzESc6Wa42fqp3O2pEU8+FQn0Ur7k
ZhB1c6yQIuED5KoZMq0mcjwpUqGLTEaw612eeoaD0TSDSVIhoiQD8bGwR9O0z1SYxxlL78hP
11w2rTr4Sf57tth/9Q7wXW8BY9gfFoe9t1gut8fNYb15aJcjk3xaQIeCca7gWzIedwaiJTmj
n/iEGUrKc08PNwE+c1cAzf4U/LUQt7A31HHTFbPdXTf96yF1P9XKldPqB0Jqo0CaT4RfqVGj
QHr5pVwdwXp69+XicNyVe9Ncf4ugNjLNCdJ5kqg002CEsreXH+xp8nGq8kTTZ3gi+DRR0Ak1
KlMprYzVcNG2GFkkTypCRmvNKJyCrZkZ+5j6xKqAqVYJaDPY5SJQKR4X+F/EYt7R0T6bhh+o
nQM7koWws1wAN9jELGVGUE2vttwWbE47mKmUnvxYZBE4haI2UDTTnQ70WY6gsib0uVJa3pLn
+XTwYIum9OrmY7qdgeELctdo8kzckhSRKNcc5ThmYeCTRDN4B81YSgdNT8CDkBQmFdkuVZHD
ctCzZv5MwrzrjaAXEz44YmkqHfs9xY53Ed13lARndxm1yHjVgFJ0+LDwfRt8GB+I+l6c3Em7
6fztxfXA1tYALCl399vd02KzLD3xd7kBU8jAVHA0hmD6K7Ncy2nFk6b1JyW2AmdRJa4wBtyl
s4h3WAZgidZbHTIKFOgwH9mLoEM1cvaHrUzHogEybrYA/FYoNRg5OIOKVrcu44SlPthql87m
QQBILmHwcdAEAGBgOh0HVwUyHGhrvfJdfNkswfvrkcxaFUml5rP2r8bcRxFLijT2C+AEDAaQ
5+2Hcwzs9ubyumGIIsuzfQIgUPgRu7ps22bMdLu5+vMEG+qWd+/bFpi7CgItspuLb/fmn/Ki
+aczliBkGZw5gMZsFIreTCqE5iaLUPCsQZmR8kXY45gzUETjV1lYTHIw1uHIAoB3uvWNNTXQ
Fh1g69Q4iIbNcvqmGeAgTGCsh/QTGoSIYpSyDBURfCDBoPNo2DqZC0BylrwAfIBgaXgHf8cZ
t5RknOHaFCEcuxD2pUYMWw6a81gu6xis1U8FCEMGciZIrev2Mx2Tx8UBD793+P5c2qLMEqez
q0tJnNWa+P5adty02SWYgB+qOeXtT3QW33XcMLtNJncadeFyTNkGiwEwzrhrJ6KE6JHloN31
gnegH54piD1ZQcc2QZKTS9ddJ9sed0Bbi/zfXlxQkc+n4vLdhT0gaLnqsvak0GJuQMzAkLcI
Eccy2kKn7TPu9d6KvCMfrJKoAsm6e4ezUovtP4A4wSUsHson8AiWnNbCRfRKubp2AuvFbvll
fQBNhPG+XpXP0Ln7mUGoaA7lRKlpz4eCCQOPA+HEOFe5Hp420A8TbNXhfq83pg9ALesoWveo
POx/zbjUVIz7nKYdMUBlWAo/txMEdUrCkMAxZGDZAMbWoZgtZibTrBcj4UQoy4c2DfYAgntw
WX3riV8TYVC7PYDL/WkPXMU5P9P3Meb7TRIhU4mv5nHVA6ygyi3LBoEOnMMRTHsOftX6iHF1
Bjt2TqcIzLQH8LXSHa5mrz8v9uXK+1op/PNue79+rKLM1reeYTvZ1TAfy9gkQDi/efHwr3+9
GDrnH+joKcWCeFtHmMF4a9k05eehcGBJDP+IYy1jPJrgGWFoeYxMdQKjSzdZq4p+jkb2nacy
E67ONrHb+6RUUSTVfNSEruJbuTweFp8fS5NJ9AyMPHSsxEjGQZShMtJLUZE1T2VCReOnD9eM
CClsjbGaz8mPwOw7sGoq8KySpsw1PTO/qHza7r57EWUjG9d0DsM04Aii3ZyFHY92QkYVjViW
unNXGhgUXxRVP8v4tOJm8Aee0j7gMiYBgyOz8ZWUroQQDmuSGTJYJ31z3UP7HONtYpzotSE0
89MiO6HbNt7SEdGlsStmpABwTfeb64s/Twg0FsJHg2sM5TTqQJBQsJgzPqHDbR4xsv1TohQd
1n0a5XQo8MmceEVrFQwOxwb2vh95Nc4pT4qRiPkkYillCU5qn2RoDwSXtYrUmulWPiuRKKgD
ZfZaYDT7l9kNo8t++fcagj9/t/67CiE7ro13UB78lZ4z56yb5Gkd/npZy/bUEEfkVUg5EWHi
CMx9McuiJKCXEhY59hn6GVfm0ogPZBqBDxJVRnwwzGC9e/pnsSu9x+1iVe7s8QXzIlSYoCdt
RL+jhaBBPeYm/0UbmdPkRjn8mQJod83eMIhZ6nAnFQPeHtRiwAtEakalyE6BCWgnSJRcaFut
HJtVwcnj3lsZPenkJ+1mS79j7UjBZFR6xM+siyAV2OqmAry+yRx3I0BFy5dB9G4LqKIpmoTm
RGjdaev4OoUAD5DcDKxMZWPtwcC6pq58JxhaDBQHyhWD4fX08fl5uzvYa9dpr5zKer/srHKz
QHkU3eEw6TRbDDhL56DcOGzcVPqkpIzOgNxiouK20H4gHPZslrBYOjzoJTlnIQDoRt7emnUz
WkMp/rzit+9pt9vtWt2ylN8We09u9ofd8cmkqPZf4NStvMNusdkjnwcAr/RWsIDrZ/zRXuj/
R2/TnT0eAAl6QTJmgADqg77a/rPBw+49bTEx773clf9zXEPY5clL/qq5EpWbAyDPCBbtv7xd
+WhuW9vF6LHgIarOXEPTXAZE80wl3dY2NafAo+R6sA/tRybb/aEnriXyxW5FDcHJvwVQDUq6
3+48fYDZ2b7oJVc6emW5k9PYrXE3V3Jn1snSGT5RpK50Dkw9bC3rFmvBmyMARARittGjOtSz
fT4ehqLafHSc5EPFn8BKGj2RvysPu3QOssYLQRoSsEj0T9JpjJTQdgWJYVbfBCVfLEGFKZOS
ZbQRA7fgSswDaeqi4cRYaNxdTw3b9Uqi09UqnfCYn8vTZhz+6ycdWgsW3g2+29wgDpbBijjN
94oszcF7jpTKhq6+0oVLTqrAJSc/abNb3Fe0CYWAz9Ee0YRJ/660sdPJ0AAkWeItH7fLr33z
IzYmsgGIjrf0eLEKiHGu0imidhOaA7SKEkxhH7Ygr/QOX0pvsVqtERVAfGyk7t/Yp3n4MWtw
MuZZSsPscSJVr1bgRJu/dVydzQHpsJnj3sxQ0Y/TcWFFx8xuSB+DyTzqRjStHk5EGjF6HnOW
8YmvqBtgrUd43adlFXq1m6ypjOcIQhWSfdSLYSrYcHw8rO+PG5PYbUzB6mR+W/QV+AUGjiFA
I3HLHQet5ZqE3KdVFnkiPCl0QIXkiXx/ffm2SCIHcJhkHBCTlvzKKWIqoiSk4y8zgOz91Z9/
OMk6endB6w4b3b67uDC43N37TnOHBiA5kwWLrq7e3RaZ5uzMKmUfo9sPNNA5u22WjRLjPHRe
NEXCl6y5oxiGX7vF85f1ck8ZLz91mPk0Kvyk4F0wWAEi6EIEAXZzxccT7yU7rtZbQApJgxRe
DarHWgk/1aEK1XaLp9L7fLy/B4vuDx1bMCIXm+xWRTaL5dfH9cOXA0AQUPgzHh+oWI6mdR08
Oe7f+TTEC54zrE3w9IMvn+Ky/i5a5kPlMRVS5WBu1ITLIoTgKYSQPwY1sRLJSG8vtqxr7FGR
h4nsO3GLfMpNTLjf6zrQF2wz8HrVxYLYnnz5vseCRC9cfEffPDRXMWBa/OItF3JGLuAZOd05
jZk/driC7C5xhD3YMVWweHouM0eRWxQ5jr6INFY8kcRYzItQ+LTrYhwCOLD7EJR1IVqDhX3G
qa1LM15pHH2o0VoPYsMq+xOxUR5QVzz6LuZFIPvFK/Xi9/pZM8hvfakTV5icOxCwufyoMhj0
HJBBKljaOB9MIlovd9v99v7gTb4/l7vXM+/hWELAsx+G3T9iteafsXHvCv+UaJwi1A2VmubJ
zeDWCNNOSedaBpwtAIr6Rqkpmn0Cs88NXDLW6Z/t7qu9/Choon1ah1qBeH+MuYrIsa7IcuZW
2DEOGwrhjUT/zqIaqOmkt8ddB3A0JwtLg6p8TqcFwvuRtTTVnawh2XEZKds6YEyGI0WXMklY
m9zpE9PyaXsoMX6ljA7mzjLMQNDInuhcCX1+2j+Q8pJIN6pLS+z07Fn2uexClCrEhbG91Kb6
0FOwc1/Wz6+8/XO5XN+fkncnU8ueHrcP0IyX//bwGsdLkKt+IBBicVe3IbXypbvtYrXcPrn6
kfQqSXab/B7synIPprz0Pm538qNLyI9YDe/6TXTrEjCgGeLH4+IRhuYcO0m394uDEg826xZv
Hr8NZHZTbzNOlx1QnU95i5/SAivkiRCKBKlwJBFvMyfeNRdY9Elz2JxkHg1WAtOXSxjlMC0D
FD6Rie3NGMQo/cDBquLuyLH2wJi5IgkdMYdM8HLelaAw4aIpJgCvHxJZAAiMOzXGbfxa59WR
gcSEPCqmKmYIKS6dXBh3QywhYi4AgP8Eyxk5gQ4LCZFH9LEPzDpsEbiOEP4ExHdWXHLLissP
cYSpB0eO2ObCaZJ7113BXjzOGT3piNMTSNkQzLDNarddrzqlTLGfKumT42nYLaDEaJ8S99Ni
VbZvjjnk5XrzQMULOqMjLBlnsOrZhBwSIdIKbjAVTYkMHCkhLR0+UocycmbqsLgTfo4FpzFz
Xf9Jw8LuZWJ9vQaGutr0jvmbsVD6WEAX6MJcU9MxrrhFRw481Q21chS1I1LFVzFTV5EwSICT
k94l/etqmwPgp3TlRmOVycBhCSta4SwnD9iZ3h9zldEbi8X3gb4uHNefFdlFDXKsBadp9U1W
j1ztzmL5pRdUa+JWvQFqFXdlIfflcbU15RLEdiOqcg3H0MALhH4q6L0xpfZ0Kqmp7ySQ+ilc
HcsxizM00mzcfV5g/kcsYmOzhnOybBOAV6N4MLpMOIrHY0dBeh5Lrnx6VTtHpoJ95fK4Wx++
U5HaVNw5Lv0Ez1GfIQAU2ri4DByVo2S65iXX0YQ2TXW00XKukru2CrpT1Nhnoz+XMdwO5MHa
mGEBQHPq6oqQdirMui4OdXTzAkMFvJf77fviafEb3s49rze/7Rf3JchZr35bbw7lA67di07t
5pfFblVu0NK2S2oX96w368N68bj+3yZfdTrrMqsL/frvqQwJ3+PhupyG7rA2DTNWnzt5uyUf
/SH1SkCJGZ3wYl99rBOAJlENzEC4/rxbwDd32+NhvekaBARSdGg8khnWXIAxJ4oxszTmoDUB
3gDjxtMsoYgbqnVKU78LPU4oAK05C4eiEi4xFGQdYMlTMDNcZg7HlvK3712UInt74Uu6kA3J
MssLqkoBaKbK3ma+usTysMBR11AzAIwVo7sPRNeKcu0aCrKwdA6e9QwHbJSL+t4p2Umg8/Ch
HJmPuV6S8g8OZIfXco41aoOnT3BoKJVAcw8bbxfIVU0II7q1bdjuR6xtMNVlWFSM9Wdoovq1
tUjrlbS1OTYcUMhSAeo6EeDILKqeS1U9UbCTcgVD6C1cj7nwTWr/XVa7tIHfyQCiaY/HjjWr
rcDgTHft4fJrVU1rWp93YDe/mqvB1VO5fyCqyVWslQFdY/NEoTFiN384OT7mUmQ37ZsUoTW+
KBlIuG7H7BxHk0fDx+evzftQQCLLr3vDuqwfpVPusiqZwpffNN40BZJFhJfC5qUksfxByiJh
XpnfXF5cf+juQmIKy52PybBK13yBaddNO47PhXbMc3F88QnqSarG6bWkKeztPbStZIMzNW8k
Ab9EzJXc7jNVj+pVHFJ56bY0vFoa87oUxml/u0M5N3OVQoA7F2zaFHq6Upc/t/UWXmNjdDJ3
ultL1fn6VKSxCIdr1q8itqGCX34+Pjw0pegnJwmaLW4zEWtXwFFJRsYz5aTmydU8diyZIcOa
ahW7Ap/qK2r0F2zouSLCCtPkeCLPcM3OKW1d7YzQhnJs1UuIKdMstt7nNCjWNJtBmFr6LvRp
l7j/roLFXM3qZ1sJJ5R90iudq6teQZ4XAnQ8Pld6M1lsHroXICowVc95ApKqZxuOqSMR4hAw
v/h7JEim+UeyPsAKnOnx2DsNAQMCRtULgSk6Bte5aH9hRkXENDs+0biwJmkeeVdbL2J/aPF6
q4kipkIkPWWrICPm7E8b5b3cAw43ZSK/eU/HQ/mthB/Kw/LNmzevhvaYumboaxc+Xz5bB5vO
tSsMqxggWInQBIQwhTNsdR7B+OfGo9JiTU4CNCPDCkwnWJnPq8H/wD3/H9avE0nVjxnpT6PV
BvMC8aYGdAObfabMqjaBla04tz7SMdHaov2Ars8ZKpMoka5rwIqHpzCTGH+ryzB/gb+ggTTI
+JsfzFMt5zYhxw/30jA5l9v8eomPmkJ11i+QsKxZb2ZgJyr/lxKer0Gp9QoVIk1VCtb2LzF4
g2FlnjCuJHns4D7IY97+3oS0d6t5oo5TlkxoHv8uZni2gt5vXiCIxVxmE+olXU2OqodgqcC4
r8dSv8OvxmDAhCUEGw0KHt6QB2f2DB/bRdWWY+/+HXOLH0TkVAvjY+PCZxk+SUzT3J1n1CxK
XM/D8hE4NGKTTDucYzmOoyqyGEb/FX7/D3Ptq6rzSQAA

--brqgdvcvwxapppby--
