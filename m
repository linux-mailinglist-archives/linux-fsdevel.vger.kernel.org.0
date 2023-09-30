Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF47B402A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 13:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjI3L5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjI3L5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 07:57:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFE8D6;
        Sat, 30 Sep 2023 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696075068; x=1727611068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PdU2bkeAHGUqnJlEXO1kGz3P3YD4ICw84B9+BzRlc2Q=;
  b=J3CC52Ytnr6MAXE1QbzVNTX278WaQnWmiv8tozODM0s+09O+4aSKMYMV
   tGF0W3+7nTWBBnKiCsjbEPZGuWSK0iNDM31muDLWCbmbw/yYbXZgdMwfQ
   ntTUBadPU+GRgEsFB1onRDKYxK0EAuJr92tNWgC/dW47izL909MpN8mY2
   S7RkvdcFoRbezPEhcAO79q1vBQK31xc53TN2H8dEWBCEVhhTQBVK0/GAI
   VxcGdAhSfUQb22uqCzZLJynq9y/dJi5Plfm08aCUAbe2lN99RJLTVDrK2
   BrkYg261Yv8CIg2vDDMJOSFcLPSYzTWRBYa6uxFXEwcWVY0aFepYy1xHd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="413343951"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="413343951"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 04:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="785342863"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="785342863"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2023 04:57:43 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmYbN-00046l-2a;
        Sat, 30 Sep 2023 11:57:41 +0000
Date:   Sat, 30 Sep 2023 19:57:40 +0800
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
Subject: Re: [PATCH v1 09/20] arm64: define VM_PKEY_BIT* for arm64
Message-ID: <202309301944.jGh1qzvm-lkp@intel.com>
References: <20230927140123.5283-10-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927140123.5283-10-joey.gouly@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230927140123.5283-10-joey.gouly%40arm.com
patch subject: [PATCH v1 09/20] arm64: define VM_PKEY_BIT* for arm64
config: arm64-randconfig-001-20230930 (https://download.01.org/0day-ci/archive/20230930/202309301944.jGh1qzvm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309301944.jGh1qzvm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309301944.jGh1qzvm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/proc/meminfo.c:5:
   arch/arm64/include/asm/mman.h: In function 'arch_calc_vm_prot_bits':
>> include/linux/mm.h:346:25: error: 'VM_HIGH_ARCH_2' undeclared (first use in this function)
     346 | # define VM_PKEY_BIT0   VM_HIGH_ARCH_2  /* A protection key is a 3-bit value on arm64 */
         |                         ^~~~~~~~~~~~~~
   arch/arm64/include/asm/mman.h:20:29: note: in expansion of macro 'VM_PKEY_BIT0'
      20 |         ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
         |                             ^~~~~~~~~~~~
   include/linux/mm.h:346:25: note: each undeclared identifier is reported only once for each function it appears in
     346 | # define VM_PKEY_BIT0   VM_HIGH_ARCH_2  /* A protection key is a 3-bit value on arm64 */
         |                         ^~~~~~~~~~~~~~
   arch/arm64/include/asm/mman.h:20:29: note: in expansion of macro 'VM_PKEY_BIT0'
      20 |         ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
         |                             ^~~~~~~~~~~~
>> include/linux/mm.h:347:25: error: 'VM_HIGH_ARCH_3' undeclared (first use in this function)
     347 | # define VM_PKEY_BIT1   VM_HIGH_ARCH_3
         |                         ^~~~~~~~~~~~~~
   arch/arm64/include/asm/mman.h:21:29: note: in expansion of macro 'VM_PKEY_BIT1'
      21 |         ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
         |                             ^~~~~~~~~~~~
>> include/linux/mm.h:348:25: error: 'VM_HIGH_ARCH_4' undeclared (first use in this function)
     348 | # define VM_PKEY_BIT2   VM_HIGH_ARCH_4
         |                         ^~~~~~~~~~~~~~
   arch/arm64/include/asm/mman.h:22:29: note: in expansion of macro 'VM_PKEY_BIT2'
      22 |         ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
         |                             ^~~~~~~~~~~~


vim +/VM_HIGH_ARCH_2 +346 include/linux/mm.h

   343	
   344	#if defined(CONFIG_ARM64)
   345	# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_2
 > 346	# define VM_PKEY_BIT0	VM_HIGH_ARCH_2	/* A protection key is a 3-bit value on arm64 */
 > 347	# define VM_PKEY_BIT1	VM_HIGH_ARCH_3
 > 348	# define VM_PKEY_BIT2	VM_HIGH_ARCH_4
   349	# define VM_PKEY_BIT3	0
   350	# define VM_PKEY_BIT4	0
   351	#endif
   352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
