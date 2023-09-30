Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1068E7B4068
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 15:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjI3NHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 09:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3NHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:07:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E4E6;
        Sat, 30 Sep 2023 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696079220; x=1727615220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wfmlaQ/yZCImQAuL1Y8jKhC6VFeirk/jHwd2wi9Cg6c=;
  b=VnpBKIPIVi+RYdWM0FnVj7CWf7jR8YYvudTmYiSxRS9JurY1XqgP+gJM
   COQtOCuHmaOTcQRN3g/4PQle9ddtihM4WNzo7PVyermdxB+cjYag8IsH3
   CQGGN/iztf1cAOrHDKHfN8kAWPKsMrZMbxGwLFV74Z9Db9ztJzTfdJ4kM
   s1Uyw0sNFMhik8TNe57JgZuhOsoL8NaJhBV1zSbGgvJJfNVaECCBRQtSX
   HULpVvj30spCm8A+jJXGVK5VjrZ1JZIrYtDqQZByz0JI3rl58DFdT4Itp
   ZQqjE1RuFzlQwNNAjwRol3r9LzP2O8gar/pu92NGWhSHvtZ+P12m0vVEc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="385269675"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="385269675"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 06:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="923829876"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="923829876"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2023 06:06:55 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmZgL-00049f-0e;
        Sat, 30 Sep 2023 13:06:53 +0000
Date:   Sat, 30 Sep 2023 21:05:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        joey.gouly@arm.com, maz@kernel.org, oliver.upton@linux.dev,
        shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 11/20] arm64: enable ARCH_HAS_PKEYS on arm64
Message-ID: <202309302050.SO3QXUkm-lkp@intel.com>
References: <20230927140123.5283-12-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927140123.5283-12-joey.gouly@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Joey,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on linus/master v6.6-rc3 next-20230929]
[cannot apply to akpm-mm/mm-everything kvmarm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joey-Gouly/arm64-sysreg-add-system-register-POR_EL-0-1/20230927-221459
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230927140123.5283-12-joey.gouly%40arm.com
patch subject: [PATCH v1 11/20] arm64: enable ARCH_HAS_PKEYS on arm64
config: arm64-randconfig-001-20230930 (https://download.01.org/0day-ci/archive/20230930/202309302050.SO3QXUkm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302050.SO3QXUkm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309302050.SO3QXUkm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/hwcap.h:50,
                    from arch/arm64/include/asm/cpufeature.h:12,
                    from arch/arm64/include/asm/ptrace.h:11,
                    from arch/arm64/include/asm/irqflags.h:10,
                    from include/linux/irqflags.h:17,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/pagewalk.h:5,
                    from fs/proc/task_mmu.c:2:
   fs/proc/task_mmu.c: In function 'show_smap_vma_flags':
   include/linux/mm.h:346:25: error: 'VM_HIGH_ARCH_2' undeclared (first use in this function)
     346 | # define VM_PKEY_BIT0   VM_HIGH_ARCH_2  /* A protection key is a 3-bit value on arm64 */
         |                         ^~~~~~~~~~~~~~
   include/linux/log2.h:158:30: note: in definition of macro 'ilog2'
     158 |         __builtin_constant_p(n) ?       \
         |                              ^
   fs/proc/task_mmu.c:689:24: note: in expansion of macro 'VM_PKEY_BIT0'
     689 |                 [ilog2(VM_PKEY_BIT0)]   = "",
         |                        ^~~~~~~~~~~~
   include/linux/mm.h:346:25: note: each undeclared identifier is reported only once for each function it appears in
     346 | # define VM_PKEY_BIT0   VM_HIGH_ARCH_2  /* A protection key is a 3-bit value on arm64 */
         |                         ^~~~~~~~~~~~~~
   include/linux/log2.h:158:30: note: in definition of macro 'ilog2'
     158 |         __builtin_constant_p(n) ?       \
         |                              ^
   fs/proc/task_mmu.c:689:24: note: in expansion of macro 'VM_PKEY_BIT0'
     689 |                 [ilog2(VM_PKEY_BIT0)]   = "",
         |                        ^~~~~~~~~~~~
>> include/linux/log2.h:157:1: error: array index in initializer not of integer type
     157 | ( \
         | ^
   fs/proc/task_mmu.c:689:18: note: in expansion of macro 'ilog2'
     689 |                 [ilog2(VM_PKEY_BIT0)]   = "",
         |                  ^~~~~
   include/linux/log2.h:157:1: note: (near initialization for 'mnemonics')
     157 | ( \
         | ^
   fs/proc/task_mmu.c:689:18: note: in expansion of macro 'ilog2'
     689 |                 [ilog2(VM_PKEY_BIT0)]   = "",
         |                  ^~~~~
   include/linux/mm.h:347:25: error: 'VM_HIGH_ARCH_3' undeclared (first use in this function)
     347 | # define VM_PKEY_BIT1   VM_HIGH_ARCH_3
         |                         ^~~~~~~~~~~~~~
   include/linux/log2.h:158:30: note: in definition of macro 'ilog2'
     158 |         __builtin_constant_p(n) ?       \
         |                              ^
   fs/proc/task_mmu.c:690:24: note: in expansion of macro 'VM_PKEY_BIT1'
     690 |                 [ilog2(VM_PKEY_BIT1)]   = "",
         |                        ^~~~~~~~~~~~
>> include/linux/log2.h:157:1: error: array index in initializer not of integer type
     157 | ( \
         | ^
   fs/proc/task_mmu.c:690:18: note: in expansion of macro 'ilog2'
     690 |                 [ilog2(VM_PKEY_BIT1)]   = "",
         |                  ^~~~~
   include/linux/log2.h:157:1: note: (near initialization for 'mnemonics')
     157 | ( \
         | ^
   fs/proc/task_mmu.c:690:18: note: in expansion of macro 'ilog2'
     690 |                 [ilog2(VM_PKEY_BIT1)]   = "",
         |                  ^~~~~
   include/linux/mm.h:348:25: error: 'VM_HIGH_ARCH_4' undeclared (first use in this function)
     348 | # define VM_PKEY_BIT2   VM_HIGH_ARCH_4
         |                         ^~~~~~~~~~~~~~
   include/linux/log2.h:158:30: note: in definition of macro 'ilog2'
     158 |         __builtin_constant_p(n) ?       \
         |                              ^
   fs/proc/task_mmu.c:691:24: note: in expansion of macro 'VM_PKEY_BIT2'
     691 |                 [ilog2(VM_PKEY_BIT2)]   = "",
         |                        ^~~~~~~~~~~~
>> include/linux/log2.h:157:1: error: array index in initializer not of integer type
     157 | ( \
         | ^
   fs/proc/task_mmu.c:691:18: note: in expansion of macro 'ilog2'
     691 |                 [ilog2(VM_PKEY_BIT2)]   = "",
         |                  ^~~~~
   include/linux/log2.h:157:1: note: (near initialization for 'mnemonics')
     157 | ( \
         | ^
   fs/proc/task_mmu.c:691:18: note: in expansion of macro 'ilog2'
     691 |                 [ilog2(VM_PKEY_BIT2)]   = "",
         |                  ^~~~~


vim +157 include/linux/log2.h

b311e921b385b5a Robert P. J. Day 2007-10-16   69  
f0d1b0b30d250a0 David Howells    2006-12-08   70  /**
dbef91ec5482239 Martin Wilck     2018-04-18   71   * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigned value
a1c4d24e02d093e Randy Dunlap     2017-09-30   72   * @n: parameter
f0d1b0b30d250a0 David Howells    2006-12-08   73   *
dbef91ec5482239 Martin Wilck     2018-04-18   74   * Use this where sparse expects a true constant expression, e.g. for array
dbef91ec5482239 Martin Wilck     2018-04-18   75   * indices.
f0d1b0b30d250a0 David Howells    2006-12-08   76   */
dbef91ec5482239 Martin Wilck     2018-04-18   77  #define const_ilog2(n)				\
f0d1b0b30d250a0 David Howells    2006-12-08   78  (						\
f0d1b0b30d250a0 David Howells    2006-12-08   79  	__builtin_constant_p(n) ? (		\
474c90156c8dcc2 Linus Torvalds   2017-03-02   80  		(n) < 2 ? 0 :			\
f0d1b0b30d250a0 David Howells    2006-12-08   81  		(n) & (1ULL << 63) ? 63 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   82  		(n) & (1ULL << 62) ? 62 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   83  		(n) & (1ULL << 61) ? 61 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   84  		(n) & (1ULL << 60) ? 60 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   85  		(n) & (1ULL << 59) ? 59 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   86  		(n) & (1ULL << 58) ? 58 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   87  		(n) & (1ULL << 57) ? 57 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   88  		(n) & (1ULL << 56) ? 56 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   89  		(n) & (1ULL << 55) ? 55 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   90  		(n) & (1ULL << 54) ? 54 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   91  		(n) & (1ULL << 53) ? 53 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   92  		(n) & (1ULL << 52) ? 52 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   93  		(n) & (1ULL << 51) ? 51 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   94  		(n) & (1ULL << 50) ? 50 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   95  		(n) & (1ULL << 49) ? 49 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   96  		(n) & (1ULL << 48) ? 48 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   97  		(n) & (1ULL << 47) ? 47 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   98  		(n) & (1ULL << 46) ? 46 :	\
f0d1b0b30d250a0 David Howells    2006-12-08   99  		(n) & (1ULL << 45) ? 45 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  100  		(n) & (1ULL << 44) ? 44 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  101  		(n) & (1ULL << 43) ? 43 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  102  		(n) & (1ULL << 42) ? 42 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  103  		(n) & (1ULL << 41) ? 41 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  104  		(n) & (1ULL << 40) ? 40 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  105  		(n) & (1ULL << 39) ? 39 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  106  		(n) & (1ULL << 38) ? 38 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  107  		(n) & (1ULL << 37) ? 37 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  108  		(n) & (1ULL << 36) ? 36 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  109  		(n) & (1ULL << 35) ? 35 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  110  		(n) & (1ULL << 34) ? 34 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  111  		(n) & (1ULL << 33) ? 33 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  112  		(n) & (1ULL << 32) ? 32 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  113  		(n) & (1ULL << 31) ? 31 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  114  		(n) & (1ULL << 30) ? 30 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  115  		(n) & (1ULL << 29) ? 29 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  116  		(n) & (1ULL << 28) ? 28 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  117  		(n) & (1ULL << 27) ? 27 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  118  		(n) & (1ULL << 26) ? 26 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  119  		(n) & (1ULL << 25) ? 25 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  120  		(n) & (1ULL << 24) ? 24 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  121  		(n) & (1ULL << 23) ? 23 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  122  		(n) & (1ULL << 22) ? 22 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  123  		(n) & (1ULL << 21) ? 21 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  124  		(n) & (1ULL << 20) ? 20 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  125  		(n) & (1ULL << 19) ? 19 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  126  		(n) & (1ULL << 18) ? 18 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  127  		(n) & (1ULL << 17) ? 17 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  128  		(n) & (1ULL << 16) ? 16 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  129  		(n) & (1ULL << 15) ? 15 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  130  		(n) & (1ULL << 14) ? 14 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  131  		(n) & (1ULL << 13) ? 13 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  132  		(n) & (1ULL << 12) ? 12 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  133  		(n) & (1ULL << 11) ? 11 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  134  		(n) & (1ULL << 10) ? 10 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  135  		(n) & (1ULL <<  9) ?  9 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  136  		(n) & (1ULL <<  8) ?  8 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  137  		(n) & (1ULL <<  7) ?  7 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  138  		(n) & (1ULL <<  6) ?  6 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  139  		(n) & (1ULL <<  5) ?  5 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  140  		(n) & (1ULL <<  4) ?  4 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  141  		(n) & (1ULL <<  3) ?  3 :	\
f0d1b0b30d250a0 David Howells    2006-12-08  142  		(n) & (1ULL <<  2) ?  2 :	\
474c90156c8dcc2 Linus Torvalds   2017-03-02  143  		1) :				\
dbef91ec5482239 Martin Wilck     2018-04-18  144  	-1)
dbef91ec5482239 Martin Wilck     2018-04-18  145  
dbef91ec5482239 Martin Wilck     2018-04-18  146  /**
dbef91ec5482239 Martin Wilck     2018-04-18  147   * ilog2 - log base 2 of 32-bit or a 64-bit unsigned value
dbef91ec5482239 Martin Wilck     2018-04-18  148   * @n: parameter
dbef91ec5482239 Martin Wilck     2018-04-18  149   *
dbef91ec5482239 Martin Wilck     2018-04-18  150   * constant-capable log of base 2 calculation
dbef91ec5482239 Martin Wilck     2018-04-18  151   * - this can be used to initialise global variables from constant data, hence
dbef91ec5482239 Martin Wilck     2018-04-18  152   * the massive ternary operator construction
dbef91ec5482239 Martin Wilck     2018-04-18  153   *
dbef91ec5482239 Martin Wilck     2018-04-18  154   * selects the appropriately-sized optimised version depending on sizeof(n)
dbef91ec5482239 Martin Wilck     2018-04-18  155   */
dbef91ec5482239 Martin Wilck     2018-04-18  156  #define ilog2(n) \
dbef91ec5482239 Martin Wilck     2018-04-18 @157  ( \
dbef91ec5482239 Martin Wilck     2018-04-18  158  	__builtin_constant_p(n) ?	\
2f78788b55baa34 Jakub Jelinek    2020-12-15  159  	((n) < 2 ? 0 :			\
2f78788b55baa34 Jakub Jelinek    2020-12-15  160  	 63 - __builtin_clzll(n)) :	\
f0d1b0b30d250a0 David Howells    2006-12-08  161  	(sizeof(n) <= 4) ?		\
f0d1b0b30d250a0 David Howells    2006-12-08  162  	__ilog2_u32(n) :		\
f0d1b0b30d250a0 David Howells    2006-12-08  163  	__ilog2_u64(n)			\
f0d1b0b30d250a0 David Howells    2006-12-08  164   )
f0d1b0b30d250a0 David Howells    2006-12-08  165  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
