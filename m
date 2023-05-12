Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136BE6FFF48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 05:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbjELD3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 23:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbjELD3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 23:29:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE48D468A;
        Thu, 11 May 2023 20:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683862178; x=1715398178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lBlSQ3BMuIsBMzqP5MXr7LJILFqu/kbdes1s9Q9K/0U=;
  b=CYC3Zh+/05yfyvHQ9n2WWCQbyxsj6VRjxLwidst/qUP0sFv8feBK/3y1
   k4ipWhNZbutqT2b2zwgYfkBY3pHVepbWF+CUnqu37BWcswrOC+AS5iCGA
   c2viguLmSMXM4CQyG9qUX2/rHu8mN3EaPsVUoAsOtLdkSb3txk1tFYL6G
   4BTPnBo351OsSlnPnDJpG35nAKWB4P66AXgdBXr3qVj8u5R4wLKfCct5D
   4nQaDt5qqLM5MMfah2c9yzt5YtICFMnvlDGC8+lyiTEaCAA2AU2goLkHh
   MuyAf9ZtWW++en/oQ3gxjWpayClGd57yf6rLFxU2vEnvqbkTTCZ+bzhH5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335209090"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335209090"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 20:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="844244719"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="844244719"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2023 20:29:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxJTK-0004SC-0g;
        Fri, 12 May 2023 03:29:34 +0000
Date:   Fri, 12 May 2023 11:28:57 +0800
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
Message-ID: <202305121114.JAbwVHjS-lkp@intel.com>
References: <ZF2E6i4pqJr7m436@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF2E6i4pqJr7m436@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-handle_mm_fault_one/20230512-081554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/ZF2E6i4pqJr7m436%40x1n
patch subject: [PATCH 1/3] mm: handle_mm_fault_one()
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20230512/202305121114.JAbwVHjS-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0a03a4870c8a62e3ba52a0f9b50b307f509acb2b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Xu/mm-handle_mm_fault_one/20230512-081554
        git checkout 0a03a4870c8a62e3ba52a0f9b50b307f509acb2b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305121114.JAbwVHjS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
>> include/linux/mm.h:2371:6: error: use of undeclared identifier 'fault'
           if (fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED))
               ^
>> include/linux/mm.h:2396:20: error: use of undeclared identifier 'mm'
                   mmap_read_unlock(mm);
                                    ^
   2 errors generated.
   make[2]: *** [scripts/Makefile.build:114: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1287: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/fault +2371 include/linux/mm.h

  2362	
  2363	static inline bool
  2364	mm_should_release_mmap(unsigned long flags, vm_fault_t retval)
  2365	{
  2366		/* The caller explicitly requested to keep the mmap read lock */
  2367		if (flags & FAULT_FLAG_RETRY_NOWAIT)
  2368			return false;
  2369	
  2370		/* If the mmap read lock is already released, we're all good */
> 2371		if (fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED))
  2372			return false;
  2373	
  2374		/* Otherwise always release it */
  2375		return true;
  2376	}
  2377	
  2378	/*
  2379	 * This is mostly handle_mm_fault(), but it also take care of releasing
  2380	 * mmap or vma read lock as long as possible (e.g. when !RETRY_NOWAIT).
  2381	 *
  2382	 * Normally it's the case when we got a hardware page fault, where we want
  2383	 * to release the lock right after the page fault. And it's not for case
  2384	 * like GUP where it can fault a range of pages continuously with mmap lock
  2385	 * being held during the process.
  2386	 */
  2387	static inline vm_fault_t
  2388	handle_mm_fault_one(struct vm_area_struct *vma, unsigned long address,
  2389			    unsigned int flags, struct pt_regs *regs)
  2390	{
  2391		vm_fault_t retval = handle_mm_fault(vma, address, flags, regs);
  2392	
  2393		if (flags & FAULT_FLAG_VMA_LOCK)
  2394			vma_end_read(vma);
  2395		else if (mm_should_release_mmap(flags, retval))
> 2396			mmap_read_unlock(mm);
  2397	
  2398		return retval;
  2399	}
  2400	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
