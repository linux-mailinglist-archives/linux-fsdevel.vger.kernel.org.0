Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CED577DD21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbjHPJSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbjHPJR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:17:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF24A173F;
        Wed, 16 Aug 2023 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692177475; x=1723713475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zwwmpOW207j3wPu+ifgrfWePdPO66yRkiGRCHXKVykM=;
  b=NiJlrvcRIfIdke8Fs5vR64S9B1TTF3k0f5JFmA0pgrfkIvO5Dh4ikMMB
   k1KdOiJsuknzXTbl0ve2eGFfAOSONM1/vjpXLwAiMUJD2VDlQwvBkJxNN
   lR8TzFZTzU6Bb/GpMhsUsNclcV5LvJPfUHe2VCH4YXL4Beyg7DGiNhHCW
   8Ywf/CXRYSwXOyao5mrAMXTzzOJCNK33KGg6lbSwMgXqmscR+p+EaVL4+
   z+WKuz/HRxfSiPMRL3BYamKpMIhSeiWQflaclbyeA4DTXWqFrNOVt6LPZ
   2e1JfqhkdBHmKSm5c04xjZKZt0P8wBQG6Uu7h6VE7qnid8bOflU4oht5I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376212911"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="376212911"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 02:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799500182"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="799500182"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2023 02:17:47 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWCew-0000AX-2d;
        Wed, 16 Aug 2023 09:17:46 +0000
Date:   Wed, 16 Aug 2023 17:17:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>
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
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>,
        kernel@collabora.com, Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v30 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202308161737.upLWpu8Q-lkp@intel.com>
References: <20230816065925.850879-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816065925.850879-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20230815]
[cannot apply to linus/master v6.5-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230816-150412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230816065925.850879-3-usama.anjum%40collabora.com
patch subject: [PATCH v30 2/6] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230816/202308161737.upLWpu8Q-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308161737.upLWpu8Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308161737.upLWpu8Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/pagewalk.h:5,
                    from fs/proc/task_mmu.c:2:
   fs/proc/task_mmu.c: In function 'pagemap_scan_get_args':
>> fs/proc/task_mmu.c:2269:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2269 |         if (!access_ok((void __user *)arg->start, arg->end - arg->start))
         |                        ^
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   fs/proc/task_mmu.c:2269:14: note: in expansion of macro 'access_ok'
    2269 |         if (!access_ok((void __user *)arg->start, arg->end - arg->start))
         |              ^~~~~~~~~
   fs/proc/task_mmu.c:2273:36: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2273 |         if (arg->vec && !access_ok((void __user *)arg->vec,
         |                                    ^
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   fs/proc/task_mmu.c:2273:26: note: in expansion of macro 'access_ok'
    2273 |         if (arg->vec && !access_ok((void __user *)arg->vec,
         |                          ^~~~~~~~~
   fs/proc/task_mmu.c: In function 'pagemap_scan_init_bounce_buffer':
   fs/proc/task_mmu.c:2310:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2310 |         p->vec_out = (struct page_region __user *)p->arg.vec;
         |                      ^
   fs/proc/task_mmu.c: At top level:
   fs/proc/task_mmu.c:1998:13: warning: 'pagemap_scan_backout_range' defined but not used [-Wunused-function]
    1998 | static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +2269 fs/proc/task_mmu.c

  2245	
  2246	static int pagemap_scan_get_args(struct pm_scan_arg *arg,
  2247					 unsigned long uarg)
  2248	{
  2249		if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
  2250			return -EFAULT;
  2251	
  2252		if (arg->size != sizeof(struct pm_scan_arg))
  2253			return -EINVAL;
  2254	
  2255		/* Validate requested features */
  2256		if (arg->flags & ~PM_SCAN_FLAGS)
  2257			return -EINVAL;
  2258		if ((arg->category_inverted | arg->category_mask |
  2259		     arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
  2260			return -EINVAL;
  2261	
  2262		arg->start = untagged_addr((unsigned long)arg->start);
  2263		arg->end = untagged_addr((unsigned long)arg->end);
  2264		arg->vec = untagged_addr((unsigned long)arg->vec);
  2265	
  2266		/* Validate memory pointers */
  2267		if (!IS_ALIGNED(arg->start, PAGE_SIZE))
  2268			return -EINVAL;
> 2269		if (!access_ok((void __user *)arg->start, arg->end - arg->start))
  2270			return -EFAULT;
  2271		if (!arg->vec && arg->vec_len)
  2272			return -EINVAL;
  2273		if (arg->vec && !access_ok((void __user *)arg->vec,
  2274				      arg->vec_len * sizeof(struct page_region)))
  2275			return -EFAULT;
  2276	
  2277		/* Fixup default values */
  2278		arg->end = ALIGN(arg->end, PAGE_SIZE);
  2279		arg->walk_end = 0;
  2280		if (!arg->max_pages)
  2281			arg->max_pages = ULONG_MAX;
  2282	
  2283		return 0;
  2284	}
  2285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
