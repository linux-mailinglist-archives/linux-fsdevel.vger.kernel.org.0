Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153A6780639
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 09:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358143AbjHRHR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 03:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358168AbjHRHRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:17:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D9030E6;
        Fri, 18 Aug 2023 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692343026; x=1723879026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hy9L/G7orcg7EKsXBpzuKk+u1iVyRUCiRiiWR/KGdJc=;
  b=ad4gmbNApLfKRjeaWiqnmvu0rQeYRN1LQtOiWrN1KujaJjI7LZBSaMXn
   fmo/Zq9JAJJsClh64urJGpkOa46H0iVVpAACIak+XLTBmyz1kYQ8lrkrU
   AwZCJ4RBroqoOFLp2Yytkpt5xkDGhPdZlFB7kkhgiFBGiIskYEfwWRf6a
   uaHGzB42ykNx74LXke3NNyJzoDP+zj6+JpuN+XsnOQJ4e8qo1PMDvjMKk
   0WEG6SkwhO1/5mgNurAlJ5jzMELAv9XVXXatAFfq2C/rqnnrz+FJIJdtW
   /HtlnpkboLRT0lE1Ll3uS4dPHjGssGFDI2suETLJ7TCkOgHiT5PFOImry
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="404017518"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="404017518"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800379640"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="800379640"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2023 00:16:42 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWtir-0002D4-2R;
        Fri, 18 Aug 2023 07:16:41 +0000
Date:   Fri, 18 Aug 2023 15:16:04 +0800
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
Subject: Re: [PATCH v32 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202308181520.yCq9Z26w-lkp@intel.com>
References: <20230816113049.1697849-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816113049.1697849-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20230817]
[cannot apply to linus/master v6.5-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230816-193454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230816113049.1697849-3-usama.anjum%40collabora.com
patch subject: [PATCH v32 2/6] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230818/202308181520.yCq9Z26w-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308181520.yCq9Z26w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308181520.yCq9Z26w-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_thp_entry':
>> fs/proc/task_mmu.c:2077:28: error: 'HPAGE_SIZE' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
    2077 |         if (end != start + HPAGE_SIZE) {
         |                            ^~~~~~~~~~
         |                            PAGE_SIZE
   fs/proc/task_mmu.c:2077:28: note: each undeclared identifier is reported only once for each function it appears in


vim +2077 fs/proc/task_mmu.c

  2044	
  2045	static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
  2046					  unsigned long end, struct mm_walk *walk)
  2047	{
  2048	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  2049		struct pagemap_scan_private *p = walk->private;
  2050		struct vm_area_struct *vma = walk->vma;
  2051		unsigned long categories;
  2052		spinlock_t *ptl;
  2053		int ret = 0;
  2054	
  2055		ptl = pmd_trans_huge_lock(pmd, vma);
  2056		if (!ptl)
  2057			return -ENOENT;
  2058	
  2059		categories = p->cur_vma_category | pagemap_thp_category(*pmd);
  2060	
  2061		if (!pagemap_scan_is_interesting_page(categories, p))
  2062			goto out_unlock;
  2063	
  2064		ret = pagemap_scan_output(categories, p, start, &end);
  2065		if (start == end)
  2066			goto out_unlock;
  2067	
  2068		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
  2069			goto out_unlock;
  2070		if (~categories & PAGE_IS_WRITTEN)
  2071			goto out_unlock;
  2072	
  2073		/*
  2074		 * Break huge page into small pages if the WP operation
  2075		 * needs to be performed on a portion of the huge page.
  2076		 */
> 2077		if (end != start + HPAGE_SIZE) {
  2078			spin_unlock(ptl);
  2079			split_huge_pmd(vma, pmd, start);
  2080			pagemap_scan_backout_range(p, start, end);
  2081			/* Report as if there was no THP */
  2082			return -ENOENT;
  2083		}
  2084	
  2085		make_uffd_wp_pmd(vma, start, pmd);
  2086		flush_tlb_range(vma, start, end);
  2087	out_unlock:
  2088		spin_unlock(ptl);
  2089		return ret;
  2090	#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
  2091		return -ENOENT;
  2092	#endif
  2093	}
  2094	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
