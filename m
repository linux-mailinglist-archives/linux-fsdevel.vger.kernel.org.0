Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3D724E7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbjFFVI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFFVIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:08:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635461726;
        Tue,  6 Jun 2023 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686085702; x=1717621702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TE+hsFEtgKTdemjU0rpyelI4HlRWI8H2qWCPy0IYQto=;
  b=Lo2BoPp4DzQ0FPA7KvqSqWf2tYuIgndIVvncp/bueojDsE03Tp1bu442
   GvsMgrq0/yUWB/h3lxFKM68pZVs/z+wBf8CNsjCtEsuFBrB4UIZopv9eR
   t1to4/VAgA/NfyGlpHUfz3rWkE08fc5OY36zkMl7YKYBsPFA8swO09YEL
   7XF63LPiI0Iz5maUB6BdGsbzBETMHgRTXrW4fVJuDLqdNHZp6ouOVP6zn
   xEh5wZOA07WGcYIqRVfjiq7593xpOXfz+dI5GjdqC08576hhw9XcdKmD6
   PQvV3VtrRTsbsGFVGkDvrL4z9z1gKuAdva0zzHYpCSx++6nkmUHD6rCML
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422642039"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="422642039"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 14:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="833392520"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="833392520"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2023 14:08:14 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6duY-0005kp-09;
        Tue, 06 Jun 2023 21:08:14 +0000
Date:   Wed, 7 Jun 2023 05:08:11 +0800
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
Subject: Re: [PATCH v17 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202306070414.XDn2ITuw-lkp@intel.com>
References: <20230606060822.1065182-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606060822.1065182-3-usama.anjum@collabora.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20230606]
[cannot apply to linus/master v6.4-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230606-141114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230606060822.1065182-3-usama.anjum%40collabora.com
patch subject: [PATCH v17 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230607/202306070414.XDn2ITuw-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch akpm-mm mm-everything
        git checkout akpm-mm/mm-everything
        b4 shazam https://lore.kernel.org/r/20230606060822.1065182-3-usama.anjum@collabora.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306070414.XDn2ITuw-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
>> fs/proc/task_mmu.c:1960:31: error: 'HPAGE_SIZE' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
    1960 |                     n_pages < HPAGE_SIZE/PAGE_SIZE) {
         |                               ^~~~~~~~~~
         |                               PAGE_SIZE
   fs/proc/task_mmu.c:1960:31: note: each undeclared identifier is reported only once for each function it appears in


vim +1960 fs/proc/task_mmu.c

  1931	
  1932	static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
  1933					  unsigned long end, struct mm_walk *walk)
  1934	{
  1935		struct pagemap_scan_private *p = walk->private;
  1936		struct vm_area_struct *vma = walk->vma;
  1937		unsigned long addr = end;
  1938		pte_t *pte, *orig_pte;
  1939		spinlock_t *ptl;
  1940		bool is_written;
  1941		int ret = 0;
  1942	
  1943		arch_enter_lazy_mmu_mode();
  1944	
  1945	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  1946		ptl = pmd_trans_huge_lock(pmd, vma);
  1947		if (ptl) {
  1948			unsigned long n_pages = (end - start)/PAGE_SIZE;
  1949	
  1950			if (p->max_pages && n_pages > p->max_pages - p->found_pages)
  1951				n_pages = p->max_pages - p->found_pages;
  1952	
  1953			is_written = !is_pmd_uffd_wp(*pmd);
  1954	
  1955			/*
  1956			 * Break huge page into small pages if the WP operation need to
  1957			 * be performed is on a portion of the huge page.
  1958			 */
  1959			if (is_written && IS_PM_SCAN_WP(p->flags) &&
> 1960			    n_pages < HPAGE_SIZE/PAGE_SIZE) {
  1961				spin_unlock(ptl);
  1962	
  1963				split_huge_pmd(vma, pmd, start);
  1964				goto process_smaller_pages;
  1965			}
  1966	
  1967			if (IS_PM_SCAN_GET(p->flags))
  1968				ret = pagemap_scan_output(is_written, vma->vm_file,
  1969							  pmd_present(*pmd),
  1970							  is_swap_pmd(*pmd),
  1971							  p, start, n_pages);
  1972	
  1973			if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
  1974				make_uffd_wp_pmd(vma, addr, pmd);
  1975	
  1976			if (IS_PM_SCAN_WP(p->flags))
  1977				flush_tlb_range(vma, start, end);
  1978	
  1979			spin_unlock(ptl);
  1980	
  1981			arch_leave_lazy_mmu_mode();
  1982			return ret;
  1983		}
  1984	
  1985	process_smaller_pages:
  1986		if (pmd_trans_unstable(pmd)) {
  1987			arch_leave_lazy_mmu_mode();
  1988			walk->action = ACTION_AGAIN;
  1989			return 0;
  1990		}
  1991	#endif
  1992	
  1993		orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
  1994		for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
  1995			is_written = !is_pte_uffd_wp(*pte);
  1996	
  1997			if (IS_PM_SCAN_GET(p->flags))
  1998				ret = pagemap_scan_output(is_written, vma->vm_file,
  1999							  pte_present(*pte),
  2000							  is_swap_pte(*pte),
  2001							  p, addr, 1);
  2002	
  2003			if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
  2004				make_uffd_wp_pte(vma, addr, pte);
  2005		}
  2006	
  2007		if (IS_PM_SCAN_WP(p->flags))
  2008			flush_tlb_range(vma, start, addr);
  2009	
  2010		pte_unmap_unlock(orig_pte, ptl);
  2011		arch_leave_lazy_mmu_mode();
  2012	
  2013		cond_resched();
  2014		return ret;
  2015	}
  2016	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
