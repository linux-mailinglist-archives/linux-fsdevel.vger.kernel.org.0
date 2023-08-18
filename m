Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCA780529
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 06:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357894AbjHREm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 00:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357879AbjHREmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:42:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6FB3AA7;
        Thu, 17 Aug 2023 21:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692333724; x=1723869724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qOndlZcwodsuQ/+GG0u1jnSqAmzd8rk/nEVIbm2c48w=;
  b=NKTbJxT+LCpyBXvLI9YKVU9ycKdA/oABnhrzySh7o9LyN3w9esfFOAP1
   lDVvo4ybYVPSV7IauKcFytT2Q89kXxxBfXq0a1Uu2neOp1layU5fmDwB+
   Sd9/0wQBPSFa4TCrUT5J6R6bTduaXeOwng4+EO4XoGxoVOcfCG5YrVoHc
   OAVlcJqAbnCY4pSsHuVwW5GUmxZCGTZkTdnxxUFO8CT2e+wUejKK13TN7
   KwoiMs13XBlXiTHcoyrl+FChKy2hMLmc0HU81XNQ6byEZyLKNm5bIJQmM
   1Aew351OEo3oVUWPWua4cMqpEyumJP6wxo99cAPixZIKciULMNXrkX03D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363171560"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="363171560"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 21:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800324891"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="800324891"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 21:42:00 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWrJ9-00026a-2H;
        Fri, 18 Aug 2023 04:41:59 +0000
Date:   Fri, 18 Aug 2023 12:41:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] mm: Change calling convention for ->huge_fault
Message-ID: <202308181255.bMCo950t-lkp@intel.com>
References: <20230817200150.1230317-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817200150.1230317-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Change-calling-convention-for-huge_fault/20230818-040348
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230817200150.1230317-1-willy%40infradead.org
patch subject: [PATCH] mm: Change calling convention for ->huge_fault
config: hexagon-randconfig-r035-20230818 (https://download.01.org/0day-ci/archive/20230818/202308181255.bMCo950t-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308181255.bMCo950t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308181255.bMCo950t-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> mm/memory.c:4876:39: error: use of undeclared identifier 'PTE_SHIFT'
    4876 |                 return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
         |                                                     ^
   include/linux/pgtable.h:8:32: note: expanded from macro 'PMD_ORDER'
       8 | #define PMD_ORDER       (PMD_SHIFT - PTE_SHIFT)
         |                                      ^
   mm/memory.c:4896:39: error: use of undeclared identifier 'PTE_SHIFT'
    4896 |                         ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
         |                                                            ^
   include/linux/pgtable.h:8:32: note: expanded from macro 'PMD_ORDER'
       8 | #define PMD_ORDER       (PMD_SHIFT - PTE_SHIFT)
         |                                      ^
   6 warnings and 2 errors generated.
--
   In file included from fs/xfs/xfs_trace.c:6:
   In file included from fs/xfs/xfs.h:22:
   In file included from fs/xfs/xfs_linux.h:31:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/xfs/xfs_trace.c:6:
   In file included from fs/xfs/xfs.h:22:
   In file included from fs/xfs/xfs_linux.h:31:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/xfs/xfs_trace.c:6:
   In file included from fs/xfs/xfs.h:22:
   In file included from fs/xfs/xfs_linux.h:31:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from fs/xfs/xfs_trace.c:45:
   In file included from fs/xfs/xfs_trace.h:4428:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:94:
>> fs/xfs/xfs_trace.h:805:19: error: use of undeclared identifier 'PTE_SHIFT'
     805 | TRACE_DEFINE_ENUM(PMD_ORDER);
         |                   ^
   include/linux/pgtable.h:8:32: note: expanded from macro 'PMD_ORDER'
       8 | #define PMD_ORDER       (PMD_SHIFT - PTE_SHIFT)
         |                                      ^
   In file included from fs/xfs/xfs_trace.c:45:
   In file included from fs/xfs/xfs_trace.h:4428:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:94:
   fs/xfs/xfs_trace.h:806:19: error: use of undeclared identifier 'PTE_SHIFT'
     806 | TRACE_DEFINE_ENUM(PUD_ORDER);
         |                   ^
   include/linux/pgtable.h:9:32: note: expanded from macro 'PUD_ORDER'
       9 | #define PUD_ORDER       (PUD_SHIFT - PTE_SHIFT)
         |                                      ^
   In file included from fs/xfs/xfs_trace.c:45:
   In file included from fs/xfs/xfs_trace.h:4428:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
   fs/xfs/xfs_trace.h:831:6: error: use of undeclared identifier 'PTE_SHIFT'
     831 |                         { PMD_ORDER,    "PMD" },
         |                           ^
   include/linux/pgtable.h:8:32: note: expanded from macro 'PMD_ORDER'
       8 | #define PMD_ORDER       (PMD_SHIFT - PTE_SHIFT)
         |                                      ^
   In file included from fs/xfs/xfs_trace.c:45:
   In file included from fs/xfs/xfs_trace.h:4428:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
   fs/xfs/xfs_trace.h:832:6: error: use of undeclared identifier 'PTE_SHIFT'
     832 |                         { PUD_ORDER,    "PUD" }),
         |                           ^
   include/linux/pgtable.h:9:32: note: expanded from macro 'PUD_ORDER'
       9 | #define PUD_ORDER       (PUD_SHIFT - PTE_SHIFT)
         |                                      ^
   6 warnings and 4 errors generated.


vim +/PTE_SHIFT +4876 mm/memory.c

  4869	
  4870	static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
  4871	{
  4872		struct vm_area_struct *vma = vmf->vma;
  4873		if (vma_is_anonymous(vma))
  4874			return do_huge_pmd_anonymous_page(vmf);
  4875		if (vma->vm_ops->huge_fault)
> 4876			return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
  4877		return VM_FAULT_FALLBACK;
  4878	}
  4879	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
