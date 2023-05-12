Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0002E6FFFB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 06:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbjELEuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 00:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELEuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 00:50:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E5510FC;
        Thu, 11 May 2023 21:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683867042; x=1715403042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iC5D+xXe0zxzN4xqOa5SMpSOusDzpmsICbpoP7xO44Q=;
  b=WMxR5dMHCytiwefGiwHnzlXBx+hdsZEeYmtZRGcu+aogfRPDJGBGAuhD
   CG/9YJmc2jJf+NC7UJXnBQrHtxyKGe64jsPH2ZB8hsFAYDrAa0KDDWraL
   Jz/aExl/clO40bbve5mCk40EOJXhpExn1C647ZT5RSAKyBNc2E79GWutU
   z9KoONKdDfk1qGVVoBWsvCSypeCQNWG3h76wY3XPuEfVG2HBxIgTCoIkZ
   JffNiKFiL6GdLxyQB6TSAcafOz9PHJdafkad/bdkpCUcsnyW0tU91Yv6Z
   6IH3HCSBZniIgjbI3QYFdfMpJu43Z8+23gKcpWNWx+YBY5QZ+xsamefIu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="330320713"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="330320713"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 21:50:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="732883561"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="732883561"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2023 21:50:37 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxKjk-0004XE-1a;
        Fri, 12 May 2023 04:50:36 +0000
Date:   Fri, 12 May 2023 12:49:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] mm: handle_mm_fault_one()
Message-ID: <202305121214.bxn0gOdr-lkp@intel.com>
References: <ZF2E6i4pqJr7m436@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF2E6i4pqJr7m436@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-handle_mm_fault_one/20230512-081554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/ZF2E6i4pqJr7m436%40x1n
patch subject: [PATCH 1/3] mm: handle_mm_fault_one()
config: hexagon-randconfig-r045-20230511 (https://download.01.org/0day-ci/archive/20230512/202305121214.bxn0gOdr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0a03a4870c8a62e3ba52a0f9b50b307f509acb2b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Xu/mm-handle_mm_fault_one/20230512-081554
        git checkout 0a03a4870c8a62e3ba52a0f9b50b307f509acb2b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305121214.bxn0gOdr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:12:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   include/linux/mm.h:2371:6: error: use of undeclared identifier 'fault'
           if (fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED))
               ^
   include/linux/mm.h:2371:6: error: use of undeclared identifier 'fault'
   include/linux/mm.h:2371:6: error: use of undeclared identifier 'fault'
   include/linux/mm.h:2396:20: error: use of undeclared identifier 'mm'
                   mmap_read_unlock(mm);
                                    ^
>> drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:200:48: warning: shift count >= width of type [-Wshift-count-overflow]
           if (!dma_set_mask_and_coherent(dsaf_dev->dev, DMA_BIT_MASK(64ULL)))
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
>> drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:200:48: warning: shift count >= width of type [-Wshift-count-overflow]
           if (!dma_set_mask_and_coherent(dsaf_dev->dev, DMA_BIT_MASK(64ULL)))
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
>> drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:200:48: warning: shift count >= width of type [-Wshift-count-overflow]
           if (!dma_set_mask_and_coherent(dsaf_dev->dev, DMA_BIT_MASK(64ULL)))
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   9 warnings and 4 errors generated.


vim +200 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c

8413b3be4d77dae Kejian Yan                   2016-06-03   40  
336a443bd9ddca3 YueHaibing                   2018-07-26   41  static int hns_dsaf_get_cfg(struct dsaf_device *dsaf_dev)
511e6bc071db148 huangdaode                   2015-09-17   42  {
511e6bc071db148 huangdaode                   2015-09-17   43  	int ret, i;
511e6bc071db148 huangdaode                   2015-09-17   44  	u32 desc_num;
511e6bc071db148 huangdaode                   2015-09-17   45  	u32 buf_size;
422c3107ed2cc62 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23   46) 	u32 reset_offset = 0;
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23   47) 	u32 res_idx = 0;
48189d6aaf1ed1b yankejian                    2016-01-20   48  	const char *mode_str;
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23   49) 	struct regmap *syscon;
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23   50) 	struct resource *res;
453cafbce5bd256 Peter Chen                   2016-08-01   51  	struct device_node *np = dsaf_dev->dev->of_node, *np_temp;
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23   52) 	struct platform_device *pdev = to_platform_device(dsaf_dev->dev);
511e6bc071db148 huangdaode                   2015-09-17   53  
8413b3be4d77dae Kejian Yan                   2016-06-03   54  	if (dev_of_node(dsaf_dev->dev)) {
13ac695e7ea16cb Salil                        2015-12-03   55  		if (of_device_is_compatible(np, "hisilicon,hns-dsaf-v1"))
511e6bc071db148 huangdaode                   2015-09-17   56  			dsaf_dev->dsaf_ver = AE_VERSION_1;
13ac695e7ea16cb Salil                        2015-12-03   57  		else
13ac695e7ea16cb Salil                        2015-12-03   58  			dsaf_dev->dsaf_ver = AE_VERSION_2;
8413b3be4d77dae Kejian Yan                   2016-06-03   59  	} else if (is_acpi_node(dsaf_dev->dev->fwnode)) {
8413b3be4d77dae Kejian Yan                   2016-06-03   60  		if (acpi_dev_found(hns_dsaf_acpi_match[0].id))
8413b3be4d77dae Kejian Yan                   2016-06-03   61  			dsaf_dev->dsaf_ver = AE_VERSION_1;
8413b3be4d77dae Kejian Yan                   2016-06-03   62  		else if (acpi_dev_found(hns_dsaf_acpi_match[1].id))
8413b3be4d77dae Kejian Yan                   2016-06-03   63  			dsaf_dev->dsaf_ver = AE_VERSION_2;
8413b3be4d77dae Kejian Yan                   2016-06-03   64  		else
8413b3be4d77dae Kejian Yan                   2016-06-03   65  			return -ENXIO;
8413b3be4d77dae Kejian Yan                   2016-06-03   66  	} else {
8413b3be4d77dae Kejian Yan                   2016-06-03   67  		dev_err(dsaf_dev->dev, "cannot get cfg data from of or acpi\n");
8413b3be4d77dae Kejian Yan                   2016-06-03   68  		return -ENXIO;
8413b3be4d77dae Kejian Yan                   2016-06-03   69  	}
511e6bc071db148 huangdaode                   2015-09-17   70  
6162928c76dcba2 Kejian Yan                   2016-06-03   71  	ret = device_property_read_string(dsaf_dev->dev, "mode", &mode_str);
511e6bc071db148 huangdaode                   2015-09-17   72  	if (ret) {
511e6bc071db148 huangdaode                   2015-09-17   73  		dev_err(dsaf_dev->dev, "get dsaf mode fail, ret=%d!\n", ret);
511e6bc071db148 huangdaode                   2015-09-17   74  		return ret;
511e6bc071db148 huangdaode                   2015-09-17   75  	}
511e6bc071db148 huangdaode                   2015-09-17   76  	for (i = 0; i < DSAF_MODE_MAX; i++) {
511e6bc071db148 huangdaode                   2015-09-17   77  		if (g_dsaf_mode_match[i] &&
511e6bc071db148 huangdaode                   2015-09-17   78  		    !strcmp(mode_str, g_dsaf_mode_match[i]))
511e6bc071db148 huangdaode                   2015-09-17   79  			break;
511e6bc071db148 huangdaode                   2015-09-17   80  	}
511e6bc071db148 huangdaode                   2015-09-17   81  	if (i >= DSAF_MODE_MAX ||
511e6bc071db148 huangdaode                   2015-09-17   82  	    i == DSAF_MODE_INVALID || i == DSAF_MODE_ENABLE) {
511e6bc071db148 huangdaode                   2015-09-17   83  		dev_err(dsaf_dev->dev,
511e6bc071db148 huangdaode                   2015-09-17   84  			"%s prs mode str fail!\n", dsaf_dev->ae_dev.name);
511e6bc071db148 huangdaode                   2015-09-17   85  		return -EINVAL;
511e6bc071db148 huangdaode                   2015-09-17   86  	}
511e6bc071db148 huangdaode                   2015-09-17   87  	dsaf_dev->dsaf_mode = (enum dsaf_mode)i;
511e6bc071db148 huangdaode                   2015-09-17   88  
511e6bc071db148 huangdaode                   2015-09-17   89  	if (dsaf_dev->dsaf_mode > DSAF_MODE_ENABLE)
511e6bc071db148 huangdaode                   2015-09-17   90  		dsaf_dev->dsaf_en = HRD_DSAF_NO_DSAF_MODE;
511e6bc071db148 huangdaode                   2015-09-17   91  	else
511e6bc071db148 huangdaode                   2015-09-17   92  		dsaf_dev->dsaf_en = HRD_DSAF_MODE;
511e6bc071db148 huangdaode                   2015-09-17   93  
511e6bc071db148 huangdaode                   2015-09-17   94  	if ((i == DSAF_MODE_ENABLE_16VM) ||
511e6bc071db148 huangdaode                   2015-09-17   95  	    (i == DSAF_MODE_DISABLE_2PORT_8VM) ||
511e6bc071db148 huangdaode                   2015-09-17   96  	    (i == DSAF_MODE_DISABLE_6PORT_2VM))
511e6bc071db148 huangdaode                   2015-09-17   97  		dsaf_dev->dsaf_tc_mode = HRD_DSAF_8TC_MODE;
511e6bc071db148 huangdaode                   2015-09-17   98  	else
511e6bc071db148 huangdaode                   2015-09-17   99  		dsaf_dev->dsaf_tc_mode = HRD_DSAF_4TC_MODE;
511e6bc071db148 huangdaode                   2015-09-17  100  
8413b3be4d77dae Kejian Yan                   2016-06-03  101  	if (dev_of_node(dsaf_dev->dev)) {
453cafbce5bd256 Peter Chen                   2016-08-01  102  		np_temp = of_parse_phandle(np, "subctrl-syscon", 0);
453cafbce5bd256 Peter Chen                   2016-08-01  103  		syscon = syscon_node_to_regmap(np_temp);
453cafbce5bd256 Peter Chen                   2016-08-01  104  		of_node_put(np_temp);
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  105) 		if (IS_ERR_OR_NULL(syscon)) {
8413b3be4d77dae Kejian Yan                   2016-06-03  106  			res = platform_get_resource(pdev, IORESOURCE_MEM,
8413b3be4d77dae Kejian Yan                   2016-06-03  107  						    res_idx++);
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  108) 			if (!res) {
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  109) 				dev_err(dsaf_dev->dev, "subctrl info is needed!\n");
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  110) 				return -ENOMEM;
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  111) 			}
8413b3be4d77dae Kejian Yan                   2016-06-03  112  
8413b3be4d77dae Kejian Yan                   2016-06-03  113  			dsaf_dev->sc_base = devm_ioremap_resource(&pdev->dev,
8413b3be4d77dae Kejian Yan                   2016-06-03  114  								  res);
b3dc93501e34b6e Wei Yongjun                  2016-08-23  115  			if (IS_ERR(dsaf_dev->sc_base))
96329a181bfbbac Wei Yongjun                  2016-07-05  116  				return PTR_ERR(dsaf_dev->sc_base);
511e6bc071db148 huangdaode                   2015-09-17  117  
8413b3be4d77dae Kejian Yan                   2016-06-03  118  			res = platform_get_resource(pdev, IORESOURCE_MEM,
8413b3be4d77dae Kejian Yan                   2016-06-03  119  						    res_idx++);
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  120) 			if (!res) {
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  121) 				dev_err(dsaf_dev->dev, "serdes-ctrl info is needed!\n");
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  122) 				return -ENOMEM;
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  123) 			}
8413b3be4d77dae Kejian Yan                   2016-06-03  124  
8413b3be4d77dae Kejian Yan                   2016-06-03  125  			dsaf_dev->sds_base = devm_ioremap_resource(&pdev->dev,
8413b3be4d77dae Kejian Yan                   2016-06-03  126  								   res);
b3dc93501e34b6e Wei Yongjun                  2016-08-23  127  			if (IS_ERR(dsaf_dev->sds_base))
96329a181bfbbac Wei Yongjun                  2016-07-05  128  				return PTR_ERR(dsaf_dev->sds_base);
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  129) 		} else {
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  130) 			dsaf_dev->sub_ctrl = syscon;
511e6bc071db148 huangdaode                   2015-09-17  131  		}
8413b3be4d77dae Kejian Yan                   2016-06-03  132  	}
511e6bc071db148 huangdaode                   2015-09-17  133  
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  134) 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ppe-base");
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  135) 	if (!res) {
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  136) 		res = platform_get_resource(pdev, IORESOURCE_MEM, res_idx++);
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  137) 		if (!res) {
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  138) 			dev_err(dsaf_dev->dev, "ppe-base info is needed!\n");
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  139) 			return -ENOMEM;
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  140) 		}
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  141) 	}
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  142) 	dsaf_dev->ppe_base = devm_ioremap_resource(&pdev->dev, res);
b3dc93501e34b6e Wei Yongjun                  2016-08-23  143  	if (IS_ERR(dsaf_dev->ppe_base))
96329a181bfbbac Wei Yongjun                  2016-07-05  144  		return PTR_ERR(dsaf_dev->ppe_base);
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  145) 	dsaf_dev->ppe_paddr = res->start;
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  146) 
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  147) 	if (!HNS_DSAF_IS_DEBUG(dsaf_dev)) {
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  148) 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  149) 						   "dsaf-base");
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  150) 		if (!res) {
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  151) 			res = platform_get_resource(pdev, IORESOURCE_MEM,
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  152) 						    res_idx);
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  153) 			if (!res) {
511e6bc071db148 huangdaode                   2015-09-17  154  				dev_err(dsaf_dev->dev,
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  155) 					"dsaf-base info is needed!\n");
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  156) 				return -ENOMEM;
511e6bc071db148 huangdaode                   2015-09-17  157  			}
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  158) 		}
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  159) 		dsaf_dev->io_base = devm_ioremap_resource(&pdev->dev, res);
b3dc93501e34b6e Wei Yongjun                  2016-08-23  160  		if (IS_ERR(dsaf_dev->io_base))
96329a181bfbbac Wei Yongjun                  2016-07-05  161  			return PTR_ERR(dsaf_dev->io_base);
831d828bf2cc853 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  162) 	}
511e6bc071db148 huangdaode                   2015-09-17  163  
6162928c76dcba2 Kejian Yan                   2016-06-03  164  	ret = device_property_read_u32(dsaf_dev->dev, "desc-num", &desc_num);
511e6bc071db148 huangdaode                   2015-09-17  165  	if (ret < 0 || desc_num < HNS_DSAF_MIN_DESC_CNT ||
511e6bc071db148 huangdaode                   2015-09-17  166  	    desc_num > HNS_DSAF_MAX_DESC_CNT) {
511e6bc071db148 huangdaode                   2015-09-17  167  		dev_err(dsaf_dev->dev, "get desc-num(%d) fail, ret=%d!\n",
511e6bc071db148 huangdaode                   2015-09-17  168  			desc_num, ret);
f6c2df1e5b913f9 Qianqian Xie                 2016-06-21  169  		return -EINVAL;
511e6bc071db148 huangdaode                   2015-09-17  170  	}
511e6bc071db148 huangdaode                   2015-09-17  171  	dsaf_dev->desc_num = desc_num;
511e6bc071db148 huangdaode                   2015-09-17  172  
6162928c76dcba2 Kejian Yan                   2016-06-03  173  	ret = device_property_read_u32(dsaf_dev->dev, "reset-field-offset",
6162928c76dcba2 Kejian Yan                   2016-06-03  174  				       &reset_offset);
422c3107ed2cc62 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  175) 	if (ret < 0) {
422c3107ed2cc62 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  176) 		dev_dbg(dsaf_dev->dev,
422c3107ed2cc62 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  177) 			"get reset-field-offset fail, ret=%d!\r\n", ret);
422c3107ed2cc62 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  178) 	}
422c3107ed2cc62 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  179) 	dsaf_dev->reset_offset = reset_offset;
422c3107ed2cc62 Yisen.Zhuang\(Zhuangyuzeng\  2016-04-23  180) 
6162928c76dcba2 Kejian Yan                   2016-06-03  181  	ret = device_property_read_u32(dsaf_dev->dev, "buf-size", &buf_size);
511e6bc071db148 huangdaode                   2015-09-17  182  	if (ret < 0) {
511e6bc071db148 huangdaode                   2015-09-17  183  		dev_err(dsaf_dev->dev,
511e6bc071db148 huangdaode                   2015-09-17  184  			"get buf-size fail, ret=%d!\r\n", ret);
f6c2df1e5b913f9 Qianqian Xie                 2016-06-21  185  		return ret;
511e6bc071db148 huangdaode                   2015-09-17  186  	}
511e6bc071db148 huangdaode                   2015-09-17  187  	dsaf_dev->buf_size = buf_size;
511e6bc071db148 huangdaode                   2015-09-17  188  
511e6bc071db148 huangdaode                   2015-09-17  189  	dsaf_dev->buf_size_type = hns_rcb_buf_size2type(buf_size);
511e6bc071db148 huangdaode                   2015-09-17  190  	if (dsaf_dev->buf_size_type < 0) {
511e6bc071db148 huangdaode                   2015-09-17  191  		dev_err(dsaf_dev->dev,
511e6bc071db148 huangdaode                   2015-09-17  192  			"buf_size(%d) is wrong!\n", buf_size);
f6c2df1e5b913f9 Qianqian Xie                 2016-06-21  193  		return -EINVAL;
511e6bc071db148 huangdaode                   2015-09-17  194  	}
511e6bc071db148 huangdaode                   2015-09-17  195  
a24274aa5c2328a Kejian Yan                   2016-06-03  196  	dsaf_dev->misc_op = hns_misc_op_get(dsaf_dev);
a24274aa5c2328a Kejian Yan                   2016-06-03  197  	if (!dsaf_dev->misc_op)
a24274aa5c2328a Kejian Yan                   2016-06-03  198  		return -ENOMEM;
a24274aa5c2328a Kejian Yan                   2016-06-03  199  
511e6bc071db148 huangdaode                   2015-09-17 @200  	if (!dma_set_mask_and_coherent(dsaf_dev->dev, DMA_BIT_MASK(64ULL)))
511e6bc071db148 huangdaode                   2015-09-17  201  		dev_dbg(dsaf_dev->dev, "set mask to 64bit\n");
511e6bc071db148 huangdaode                   2015-09-17  202  	else
511e6bc071db148 huangdaode                   2015-09-17  203  		dev_err(dsaf_dev->dev, "set mask to 64bit fail!\n");
511e6bc071db148 huangdaode                   2015-09-17  204  
511e6bc071db148 huangdaode                   2015-09-17  205  	return 0;
511e6bc071db148 huangdaode                   2015-09-17  206  }
511e6bc071db148 huangdaode                   2015-09-17  207  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
