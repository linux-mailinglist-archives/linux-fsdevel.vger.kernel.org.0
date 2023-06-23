Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D061E73C4A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 01:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFWXEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 19:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFWXEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:04:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E31FE1;
        Fri, 23 Jun 2023 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687561468; x=1719097468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVIQAV24ZZvBUxLB5YkM+5OKqW2afiYkE/iBheQy6a8=;
  b=b0Hxu8jJp+bOqPUDlgMVBE6ygq97lcDOM1v0qTjOTIUeTai7X9dSpyMR
   Vyy5oWIPESs73kw8CS0pIDhUchhyXtC0j5B8DBKHi/VosUFZTdTglFY4S
   +hDquckGBDsQyE4DSDKaE8RlZ4XYFYnJ00EhVTwuCIXhN2z7ePvdNHKd4
   9obiyUbVjSnZPUSsKDwB1YHmd81r/bEKndfdTaRwDYzrOvkTblGlQd2n9
   06SvONnxWVz6vpdUu5sLPUWF8GBjfU+iIjSnQ8Q0SBLK8t1G7BvrDiG1W
   YRuoiJsM6Zmo1EdkmV6dXgGB+LFKsguL23CB+6ZDTNmxadVa94MFhNehv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="358372884"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="358372884"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 16:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="860031392"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="860031392"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2023 16:04:21 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCppE-0008a3-1H;
        Fri, 23 Jun 2023 23:04:20 +0000
Date:   Sat, 24 Jun 2023 07:03:31 +0800
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
Subject: Re: [PATCH v20 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202306240610.V4FYUL8b-lkp@intel.com>
References: <20230621072404.2918101-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621072404.2918101-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20230623]
[cannot apply to linus/master v6.4-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230621-171253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230621072404.2918101-3-usama.anjum%40collabora.com
patch subject: [PATCH v20 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: s390-randconfig-s043-20230622 (https://download.01.org/0day-ci/archive/20230624/202306240610.V4FYUL8b-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230624/202306240610.V4FYUL8b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306240610.V4FYUL8b-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/proc/task_mmu.c:2209:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct page_region [noderef] __user *vec @@     got struct page_region * @@
   fs/proc/task_mmu.c:2209:13: sparse:     expected struct page_region [noderef] __user *vec
   fs/proc/task_mmu.c:2209:13: sparse:     got struct page_region *

vim +2209 fs/proc/task_mmu.c

  2193	
  2194	static long do_pagemap_scan(struct mm_struct *mm, unsigned long __arg)
  2195	{
  2196		struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)__arg;
  2197		unsigned long long start, end, walk_start, walk_end;
  2198		unsigned long long empty_slots, vec_index = 0;
  2199		struct mmu_notifier_range range;
  2200		struct page_region __user *vec;
  2201		struct pagemap_scan_private p;
  2202		struct pm_scan_arg arg;
  2203		int ret = 0;
  2204	
  2205		if (copy_from_user(&arg, uarg, sizeof(arg)))
  2206			return -EFAULT;
  2207	
  2208		start = untagged_addr((unsigned long)arg.start);
> 2209		vec = (struct page_region *)untagged_addr((unsigned long)arg.vec);
  2210	
  2211		ret = pagemap_scan_args_valid(&arg, start, vec);
  2212		if (ret)
  2213			return ret;
  2214	
  2215		end = start + arg.len;
  2216		p.max_pages = arg.max_pages;
  2217		p.found_pages = 0;
  2218		p.required_mask = arg.required_mask;
  2219		p.anyof_mask = arg.anyof_mask;
  2220		p.excluded_mask = arg.excluded_mask;
  2221		p.return_mask = arg.return_mask;
  2222		p.flags = arg.flags;
  2223		p.flags |= ((p.required_mask | p.anyof_mask | p.excluded_mask) &
  2224			    PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
  2225		p.cur_buf.start = p.cur_buf.len = p.cur_buf.flags = 0;
  2226		p.vec_buf = NULL;
  2227		p.vec_buf_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
  2228	
  2229		/*
  2230		 * Allocate smaller buffer to get output from inside the page walk
  2231		 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
  2232		 * we want to return output to user in compact form where no two
  2233		 * consecutive regions should be continuous and have the same flags.
  2234		 * So store the latest element in p.cur_buf between different walks and
  2235		 * store the p.cur_buf at the end of the walk to the user buffer.
  2236		 */
  2237		if (IS_PM_SCAN_GET(p.flags)) {
  2238			p.vec_buf = kmalloc_array(p.vec_buf_len, sizeof(*p.vec_buf),
  2239						  GFP_KERNEL);
  2240			if (!p.vec_buf)
  2241				return -ENOMEM;
  2242		}
  2243	
  2244		if (IS_PM_SCAN_WP(p.flags)) {
  2245			mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
  2246						mm, start, end);
  2247			mmu_notifier_invalidate_range_start(&range);
  2248		}
  2249	
  2250		walk_start = walk_end = start;
  2251		while (walk_end < end && !ret) {
  2252			if (IS_PM_SCAN_GET(p.flags)) {
  2253				p.vec_buf_index = 0;
  2254	
  2255				/*
  2256				 * All data is copied to cur_buf first. When more data
  2257				 * is found, we push cur_buf to vec_buf and copy new
  2258				 * data to cur_buf. Subtract 1 from length as the
  2259				 * index of cur_buf isn't counted in length.
  2260				 */
  2261				empty_slots = arg.vec_len - vec_index;
  2262				p.vec_buf_len = min(p.vec_buf_len, empty_slots - 1);
  2263			}
  2264	
  2265			walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
  2266			if (walk_end > end)
  2267				walk_end = end;
  2268	
  2269			ret = mmap_read_lock_killable(mm);
  2270			if (ret)
  2271				goto free_data;
  2272			ret = walk_page_range(mm, walk_start, walk_end,
  2273					      &pagemap_scan_ops, &p);
  2274			mmap_read_unlock(mm);
  2275	
  2276			if (ret && ret != PM_SCAN_BUFFER_FULL &&
  2277			    ret != PM_SCAN_FOUND_MAX_PAGES)
  2278				goto free_data;
  2279	
  2280			walk_start = walk_end;
  2281			if (IS_PM_SCAN_GET(p.flags) && p.vec_buf_index) {
  2282				if (copy_to_user(&vec[vec_index], p.vec_buf,
  2283						 p.vec_buf_index * sizeof(*p.vec_buf))) {
  2284					/*
  2285					 * Return error even though the OP succeeded
  2286					 */
  2287					ret = -EFAULT;
  2288					goto free_data;
  2289				}
  2290				vec_index += p.vec_buf_index;
  2291			}
  2292		}
  2293	
  2294		if (p.cur_buf.len) {
  2295			if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p.cur_buf))) {
  2296				ret = -EFAULT;
  2297				goto free_data;
  2298			}
  2299			vec_index++;
  2300		}
  2301	
  2302		ret = vec_index;
  2303	
  2304	free_data:
  2305		if (IS_PM_SCAN_WP(p.flags))
  2306			mmu_notifier_invalidate_range_end(&range);
  2307	
  2308		kfree(p.vec_buf);
  2309		return ret;
  2310	}
  2311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
