Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E806747A15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 00:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGDWQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 18:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGDWQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 18:16:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1B610CF;
        Tue,  4 Jul 2023 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688508968; x=1720044968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qMlFVc3XwF8I4lMX1o5km6Btsew8JhnZvoFefo4wFsQ=;
  b=neAkueNT+XSwR1RngPF6oJjmV6H4t4WaH+Lh5+6Wrx7+8+H7RVY8PGac
   hgaWuwcBvwYMHzJHV8XSE2FbuchvLbnl7JBl/WOT7dyctxlTEYq90ocO3
   lDFWhiEjMMuqnGfiPdUaQTG5KxIYFhfqwRDNSpBqvwojp887on5kyPAtP
   6d0YXwie7I9/MlKewYK9s8tw06/Nws9ZMJZdi/Hd7UX1anicSQh+Pjzoy
   blXBuUYvbjON9H6xmqHzvm3/T2rreMhYLEJKJrkvPAKuwNkyIXSfG/Arw
   4GfBPgEI/idCc6f+U1IENTVTnKfl5l5W5nMj+RMQU9P9lTZ0+t3hsPk61
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="365765401"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="365765401"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 15:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="788963030"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="788963030"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2023 15:16:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGoJU-000IaX-23;
        Tue, 04 Jul 2023 22:16:00 +0000
Date:   Wed, 5 Jul 2023 06:15:56 +0800
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
Subject: Re: [PATCH v22 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202307050619.OArmlJne-lkp@intel.com>
References: <20230628095426.1886064-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628095426.1886064-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master next-20230704]
[cannot apply to v6.4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230628-180259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230628095426.1886064-3-usama.anjum%40collabora.com
patch subject: [PATCH v22 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230705/202307050619.OArmlJne-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230705/202307050619.OArmlJne-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307050619.OArmlJne-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
>> fs/proc/task_mmu.c:1996:39: error: 'HPAGE_SIZE' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
    1996 |                             n_pages < HPAGE_SIZE/PAGE_SIZE) {
         |                                       ^~~~~~~~~~
         |                                       PAGE_SIZE
   fs/proc/task_mmu.c:1996:39: note: each undeclared identifier is reported only once for each function it appears in


vim +1996 fs/proc/task_mmu.c

  1959	
  1960	static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
  1961					  unsigned long end, struct mm_walk *walk)
  1962	{
  1963		bool is_written, flush = false, interesting = true;
  1964		struct pagemap_scan_private *p = walk->private;
  1965		struct vm_area_struct *vma = walk->vma;
  1966		unsigned long bitmap, addr = end;
  1967		pte_t *pte, *orig_pte, ptent;
  1968		spinlock_t *ptl;
  1969		int ret = 0;
  1970	
  1971		arch_enter_lazy_mmu_mode();
  1972	
  1973	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  1974		ptl = pmd_trans_huge_lock(pmd, vma);
  1975		if (ptl) {
  1976			unsigned long n_pages = (end - start)/PAGE_SIZE;
  1977	
  1978			if (n_pages > p->max_pages - p->found_pages)
  1979				n_pages = p->max_pages - p->found_pages;
  1980	
  1981			is_written = !is_pmd_uffd_wp(*pmd);
  1982	
  1983			bitmap = PM_SCAN_FLAGS(is_written, false,
  1984					       pmd_present(*pmd), is_swap_pmd(*pmd),
  1985					       pmd_present(*pmd) && is_zero_pfn(pmd_pfn(*pmd)));
  1986	
  1987			if (IS_PM_SCAN_GET(p->flags))
  1988				interesting = pagemap_scan_is_interesting_page(bitmap, p);
  1989	
  1990			if (interesting) {
  1991				/*
  1992				 * Break huge page into small pages if the WP operation
  1993				 * need to be performed is on a portion of the huge page.
  1994				 */
  1995				if (is_written && IS_PM_SCAN_WP(p->flags) &&
> 1996				    n_pages < HPAGE_SIZE/PAGE_SIZE) {
  1997					spin_unlock(ptl);
  1998	
  1999					split_huge_pmd(vma, pmd, start);
  2000					goto process_smaller_pages;
  2001				}
  2002	
  2003				if (IS_PM_SCAN_GET(p->flags))
  2004					ret = pagemap_scan_output(bitmap, p, start, n_pages);
  2005	
  2006				if (IS_PM_SCAN_WP(p->flags) && is_written && ret >= 0) {
  2007					make_uffd_wp_pmd(vma, start, pmd);
  2008					flush_tlb_range(vma, start, end);
  2009				}
  2010			}
  2011	
  2012			spin_unlock(ptl);
  2013			arch_leave_lazy_mmu_mode();
  2014	
  2015			return ret;
  2016		}
  2017	
  2018	process_smaller_pages:
  2019	#endif
  2020	
  2021		orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
  2022		if (!pte) {
  2023			walk->action = ACTION_AGAIN;
  2024			return 0;
  2025		}
  2026	
  2027		for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
  2028			ptent = ptep_get(pte);
  2029			is_written = !is_pte_uffd_wp(ptent);
  2030	
  2031			bitmap = PM_SCAN_FLAGS(is_written, pagemap_scan_is_file(vma, ptent, addr),
  2032					       pte_present(ptent), is_swap_pte(ptent),
  2033					       pte_present(ptent) && is_zero_pfn(pte_pfn(ptent)));
  2034	
  2035			if (IS_PM_SCAN_GET(p->flags)) {
  2036				interesting = pagemap_scan_is_interesting_page(bitmap, p);
  2037				if (interesting)
  2038					ret = pagemap_scan_output(bitmap, p, addr, 1);
  2039			}
  2040	
  2041			if (IS_PM_SCAN_WP(p->flags) && is_written && interesting &&
  2042			    ret >= 0) {
  2043				make_uffd_wp_pte(vma, addr, pte);
  2044				flush = true;
  2045			}
  2046		}
  2047	
  2048		if (flush)
  2049			flush_tlb_range(vma, start, addr);
  2050	
  2051		pte_unmap_unlock(orig_pte, ptl);
  2052		arch_leave_lazy_mmu_mode();
  2053	
  2054		cond_resched();
  2055		return ret;
  2056	}
  2057	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
