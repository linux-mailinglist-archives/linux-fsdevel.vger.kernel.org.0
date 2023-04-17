Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9616E4D58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDQPeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 11:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDQPeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:34:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DE4AF13;
        Mon, 17 Apr 2023 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681745615; x=1713281615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mETGBZwVEG/Xrc1N4yHAc/0CcMbvk6722ZuBpaiz+VI=;
  b=duWqpIZGwuD6F6ecbajh6Q0i0kX7f0lkSQncn7f43Bvd3w4KHj2s6/Jf
   802gW+oiR91GFTlCoReHoo5O0isJNF/jyrTpvsTNo4dDKm+i4DFkpVa+O
   dDZlworC/0BTUtwXTRYcYOKJ+2VBAh5YNH4xJliZLCyN9bRAPRtiAN3EW
   wcpy8z73Zh5Sf8GI/qubKvYrCrb658AUx559twO5x1W5cPin9BElafTX6
   maDoHgK+uBUWXDWGAUGJrT18o42bbR8AmAvuiO2Xq4a+XpLtnIZYyPXCU
   K5AC4yNYR02Z8yvunNWrPo4e5KP26CyYQNzo4NBV5GP8daGwfgE+Ckx5R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="347665461"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="347665461"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 08:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684193562"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="684193562"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Apr 2023 08:28:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poQmi-000cXN-1I;
        Mon, 17 Apr 2023 15:28:52 +0000
Date:   Mon, 17 Apr 2023 23:28:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v13 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202304172319.CjlksY4s-lkp@intel.com>
References: <20230417125630.1146906-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417125630.1146906-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[cannot apply to linus/master v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230417-210005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230417125630.1146906-3-usama.anjum%40collabora.com
patch subject: [PATCH v13 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: i386-randconfig-a003-20230417 (https://download.01.org/0day-ci/archive/20230417/202304172319.CjlksY4s-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2e7e6f5bd3b9c28493f9871282fe8f14e2263962
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230417-210005
        git checkout 2e7e6f5bd3b9c28493f9871282fe8f14e2263962
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304172319.CjlksY4s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_pte_hole':
   fs/proc/task_mmu.c:2059:14: error: invalid use of undefined type 'struct pagemap_scan_private'
    2059 |         if (p->max_pages && p->found_pages + n_pages > p->max_pages)
         |              ^~
   fs/proc/task_mmu.c:2059:30: error: invalid use of undefined type 'struct pagemap_scan_private'
    2059 |         if (p->max_pages && p->found_pages + n_pages > p->max_pages)
         |                              ^~
   fs/proc/task_mmu.c:2059:57: error: invalid use of undefined type 'struct pagemap_scan_private'
    2059 |         if (p->max_pages && p->found_pages + n_pages > p->max_pages)
         |                                                         ^~
   fs/proc/task_mmu.c:2060:28: error: invalid use of undefined type 'struct pagemap_scan_private'
    2060 |                 n_pages = p->max_pages - p->found_pages;
         |                            ^~
   fs/proc/task_mmu.c:2060:43: error: invalid use of undefined type 'struct pagemap_scan_private'
    2060 |                 n_pages = p->max_pages - p->found_pages;
         |                                           ^~
   fs/proc/task_mmu.c:2062:15: error: implicit declaration of function 'pagemap_scan_output' [-Werror=implicit-function-declaration]
    2062 |         ret = pagemap_scan_output(false, vma->vm_file, false, false, p, addr,
         |               ^~~~~~~~~~~~~~~~~~~
   fs/proc/task_mmu.c: At top level:
   fs/proc/task_mmu.c:2068:22: error: 'pagemap_scan_test_walk' undeclared here (not in a function); did you mean 'pagemap_scan_pte_hole'?
    2068 |         .test_walk = pagemap_scan_test_walk,
         |                      ^~~~~~~~~~~~~~~~~~~~~~
         |                      pagemap_scan_pte_hole
   fs/proc/task_mmu.c:2069:22: error: 'pagemap_scan_pmd_entry' undeclared here (not in a function); did you mean 'pagemap_scan_pte_hole'?
    2069 |         .pmd_entry = pagemap_scan_pmd_entry,
         |                      ^~~~~~~~~~~~~~~~~~~~~~
         |                      pagemap_scan_pte_hole
   fs/proc/task_mmu.c: In function 'pagemap_scan_args_valid':
   fs/proc/task_mmu.c:2080:27: error: 'PM_SCAN_OPS' undeclared (first use in this function); did you mean 'PM_SCAN_OP_WP'?
    2080 |         if (arg->flags & ~PM_SCAN_OPS)
         |                           ^~~~~~~~~~~
         |                           PM_SCAN_OP_WP
   fs/proc/task_mmu.c:2080:27: note: each undeclared identifier is reported only once for each function it appears in
   fs/proc/task_mmu.c:2085:35: error: 'PM_SCAN_BITS_ALL' undeclared (first use in this function); did you mean 'CPU_BITS_ALL'?
    2085 |              arg->return_mask) & ~PM_SCAN_BITS_ALL)
         |                                   ^~~~~~~~~~~~~~~~
         |                                   CPU_BITS_ALL
   fs/proc/task_mmu.c:2106:14: error: implicit declaration of function 'PM_SCAN_DO_UFFD_WP'; did you mean 'PM_SCAN_OP_WP'? [-Werror=implicit-function-declaration]
    2106 |         if (!PM_SCAN_DO_UFFD_WP(arg))
         |              ^~~~~~~~~~~~~~~~~~
         |              PM_SCAN_OP_WP
   fs/proc/task_mmu.c: In function 'do_pagemap_scan':
   fs/proc/task_mmu.c:2123:37: error: storage size of 'p' isn't known
    2123 |         struct pagemap_scan_private p;
         |                                     ^
   fs/proc/task_mmu.c:2148:21: error: 'PAGEMAP_WALK_SIZE' undeclared (first use in this function); did you mean 'PAGE_TABLE_SIZE'?
    2148 |         p.vec_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
         |                     ^~~~~~~~~~~~~~~~~
         |                     PAGE_TABLE_SIZE
   In file included from include/linux/kernel.h:27,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/pagewalk.h:5,
                    from fs/proc/task_mmu.c:2:
   include/linux/minmax.h:36:9: error: first argument to '__builtin_choose_expr' not a constant
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:25: note: in expansion of macro '__careful_cmp'
      67 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/task_mmu.c:2173:29: note: in expansion of macro 'min'
    2173 |                 p.vec_len = min(p.vec_len, empty_slots);
         |                             ^~~
   fs/proc/task_mmu.c:2175:63: error: 'PAGEMAP_WALK_MASK' undeclared (first use in this function)
    2175 |                 walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
         |                                                               ^~~~~~~~~~~~~~~~~
   fs/proc/task_mmu.c:2186:53: error: 'PM_SCAN_FOUND_MAX_PAGES' undeclared (first use in this function)
    2186 |                 if (ret && ret != -ENOSPC && ret != PM_SCAN_FOUND_MAX_PAGES)
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~
>> fs/proc/task_mmu.c:2123:37: warning: unused variable 'p' [-Wunused-variable]
    2123 |         struct pagemap_scan_private p;
         |                                     ^
   fs/proc/task_mmu.c: At top level:
   fs/proc/task_mmu.c:2240:27: error: 'pagemap_read' undeclared here (not in a function); did you mean 'filemap_read'?
    2240 |         .read           = pagemap_read,
         |                           ^~~~~~~~~~~~
         |                           filemap_read
   fs/proc/task_mmu.c:2241:27: error: 'pagemap_open' undeclared here (not in a function); did you mean 'pid_maps_open'?
    2241 |         .open           = pagemap_open,
         |                           ^~~~~~~~~~~~
         |                           pid_maps_open
   fs/proc/task_mmu.c:2242:27: error: 'pagemap_release' undeclared here (not in a function); did you mean 'proc_map_release'?
    2242 |         .release        = pagemap_release,
         |                           ^~~~~~~~~~~~~~~
         |                           proc_map_release
   fs/proc/task_mmu.c:2246:2: error: #endif without #if
    2246 | #endif /* CONFIG_PROC_PAGE_MONITOR */
         |  ^~~~~
   cc1: some warnings being treated as errors


vim +/p +2123 fs/proc/task_mmu.c

  2115	
  2116	static long do_pagemap_scan(struct mm_struct *mm,
  2117				   struct pm_scan_arg __user *uarg)
  2118	{
  2119		unsigned long start, end, walk_start, walk_end;
  2120		unsigned long empty_slots, vec_index = 0;
  2121		struct mmu_notifier_range range;
  2122		struct page_region __user *vec;
> 2123		struct pagemap_scan_private p;
  2124		struct pm_scan_arg arg;
  2125		int ret = 0;
  2126	
  2127		if (copy_from_user(&arg, uarg, sizeof(arg)))
  2128			return -EFAULT;
  2129	
  2130		start = untagged_addr((unsigned long)arg.start);
  2131		vec = (struct page_region *)untagged_addr((unsigned long)arg.vec);
  2132	
  2133		ret = pagemap_scan_args_valid(&arg, start, vec);
  2134		if (ret)
  2135			return ret;
  2136	
  2137		end = start + arg.len;
  2138		p.max_pages = arg.max_pages;
  2139		p.found_pages = 0;
  2140		p.flags = arg.flags;
  2141		p.required_mask = arg.required_mask;
  2142		p.anyof_mask = arg.anyof_mask;
  2143		p.excluded_mask = arg.excluded_mask;
  2144		p.return_mask = arg.return_mask;
  2145		p.cur.len = 0;
  2146		p.cur.start = 0;
  2147		p.vec = NULL;
  2148		p.vec_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
  2149	
  2150		/*
  2151		 * Allocate smaller buffer to get output from inside the page walk
  2152		 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
  2153		 * we want to return output to user in compact form where no two
  2154		 * consecutive regions should be continuous and have the same flags.
  2155		 * So store the latest element in p.cur between different walks and
  2156		 * store the p.cur at the end of the walk to the user buffer.
  2157		 */
  2158		p.vec = kmalloc_array(p.vec_len, sizeof(*p.vec), GFP_KERNEL);
  2159		if (!p.vec)
  2160			return -ENOMEM;
  2161	
  2162		if (p.flags & PM_SCAN_OP_WP) {
  2163			mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
  2164						vma->vm_mm, start, end);
  2165			mmu_notifier_invalidate_range_start(&range);
  2166		}
  2167	
  2168		walk_start = walk_end = start;
  2169		while (walk_end < end && !ret) {
  2170			p.vec_index = 0;
  2171	
  2172			empty_slots = arg.vec_len - vec_index;
  2173			p.vec_len = min(p.vec_len, empty_slots);
  2174	
  2175			walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
  2176			if (walk_end > end)
  2177				walk_end = end;
  2178	
  2179			ret = mmap_read_lock_killable(mm);
  2180			if (ret)
  2181				goto free_data;
  2182			ret = walk_page_range(mm, walk_start, walk_end,
  2183					      &pagemap_scan_ops, &p);
  2184			mmap_read_unlock(mm);
  2185	
  2186			if (ret && ret != -ENOSPC && ret != PM_SCAN_FOUND_MAX_PAGES)
  2187				goto free_data;
  2188	
  2189			walk_start = walk_end;
  2190			if (p.vec_index) {
  2191				if (copy_to_user(&vec[vec_index], p.vec,
  2192						 p.vec_index * sizeof(*p.vec))) {
  2193					/*
  2194					 * Return error even though the OP succeeded
  2195					 */
  2196					ret = -EFAULT;
  2197					goto free_data;
  2198				}
  2199				vec_index += p.vec_index;
  2200			}
  2201		}
  2202	
  2203		if (p.flags & PM_SCAN_OP_WP) {
  2204			mmu_notifier_invalidate_range_end(&range);
  2205			flush_tlb_mm_range(mm, start, end, PAGE_SHIFT, false);
  2206		}
  2207	
  2208		if (p.cur.len) {
  2209			if (copy_to_user(&vec[vec_index], &p.cur, sizeof(*p.vec))) {
  2210				ret = -EFAULT;
  2211				goto free_data;
  2212			}
  2213			vec_index++;
  2214		}
  2215	
  2216		ret = vec_index;
  2217	
  2218	free_data:
  2219		kfree(p.vec);
  2220		return ret;
  2221	}
  2222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
