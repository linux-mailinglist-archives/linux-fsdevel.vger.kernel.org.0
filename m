Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977E44DE720
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 09:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbiCSIqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 04:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiCSIqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:46:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A160D5;
        Sat, 19 Mar 2022 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647679516; x=1679215516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k5pfSFVTly+M3cSKghoKNsmKVoZp5T4ZrPis3GmwE5I=;
  b=Szk1moaNW4nERKKnxbL4qvo3fkk0vr1MsAI6XWzfLWwBvERl6bqa3qYs
   AyecNVWdeaCnAj66fkZ8tQSDYgJnC6anyO5C56fHksOMsYgab8vL/l/yE
   n4nC21DEA19a7ptbNFpuI/RVSHOM8SLyIgu0bK/7J1Rh4HIHFeZn0qEX/
   56JsJAccBJOh86CTkJVHK1J/qkkRZjMChbCSmUKnhMCyzRxElSfmn0oF2
   CvuLoH6Q+dazhiUQGjX5+0Ec6DfQsuVWUVin9Yc5EZEKm9v+EX3BPhQAc
   5ffnBdWus9ikq/b07628QiKomjpB/+Ssxpo99z2j9ZY5/YyX8B1deWWzY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="237230279"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="237230279"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 01:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="542300135"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2022 01:45:10 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVUhw-000FmU-IK; Sat, 19 Mar 2022 08:45:08 +0000
Date:   Sat, 19 Mar 2022 16:44:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, david@fromorbit.com,
        djwong@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v6 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Message-ID: <202203191635.vyoiL17f-lkp@intel.com>
References: <20220319062833.3136528-5-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319062833.3136528-5-jane.chu@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jane,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on nvdimm/libnvdimm-for-next]
[also build test ERROR on device-mapper-dm/for-next linus/master v5.17-rc8 next-20220318]
[cannot apply to tip/x86/mm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jane-Chu/DAX-poison-recovery/20220319-143144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
config: s390-randconfig-r044-20220318 (https://download.01.org/0day-ci/archive/20220319/202203191635.vyoiL17f-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/203570f765a6ad07eb5809850478a25a5257f7e2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jane-Chu/DAX-poison-recovery/20220319-143144
        git checkout 203570f765a6ad07eb5809850478a25a5257f7e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/s390/block/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/s390/block/dcssblk.c:24:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/s390/block/dcssblk.c:24:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/s390/block/dcssblk.c:24:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/s390/block/dcssblk.c:53:63: error: too few arguments to function call, expected 6, have 5
           rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
                ~~~~~~~~~~~~~~~~~                                       ^
   include/linux/dax.h:186:6: note: 'dax_direct_access' declared here
   long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
        ^
   12 warnings and 1 error generated.


vim +53 drivers/s390/block/dcssblk.c

7a2765f6e82063f Dan Williams 2017-01-26  46  
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  47  static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  48  				       pgoff_t pgoff, size_t nr_pages)
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  49  {
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  50  	long rc;
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  51  	void *kaddr;
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  52  
79fa974ff6bc3f7 Vivek Goyal  2020-02-28 @53  	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  54  	if (rc < 0)
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  55  		return rc;
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  56  	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  57  	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  58  	return 0;
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  59  }
79fa974ff6bc3f7 Vivek Goyal  2020-02-28  60  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
