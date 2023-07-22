Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026F475DCCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGVN5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jul 2023 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGVN5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jul 2023 09:57:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533A30D6;
        Sat, 22 Jul 2023 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690034224; x=1721570224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5MIlRC2+zWqTR3u8Tn1LD4aunQEqMpb9fo+8qASwafs=;
  b=jOOhUbJJOCPd00pMC3Jc1wo2HXdDydI3qPKDfzsCByRrEE3ExoJgQuaz
   3KwzlkWoUHho1Nq53tURWBQFkT8vDiK2OPr2u0JT6USOr2fLkHOHJuPLz
   YuI4FOpzdamtcOzpn6bUaljU1SH/rgj7TusNBJxd/akdrIgE3VFwdawbk
   VSsc9u1vFU3XwHjd8AvD6nY1t96HODjExVPBlZ8AxACiVnyjV3232Outn
   yfVwrnQLbrtllyRsAlES6ySUFUHPJ8FbKc6f6sQg8UOE32sl2rzrYtSLW
   1nLz/vhnuawXUY+gyJOfbanF4QfS+BI9Md2UvzOd2av891Y5ZTv0S95Ps
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="367223274"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="367223274"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 06:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="702357374"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="702357374"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2023 06:56:56 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qND62-0008Lr-0Z;
        Sat, 22 Jul 2023 13:56:34 +0000
Date:   Sat, 22 Jul 2023 21:55:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>, Greg KH <greg@kroah.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Message-ID: <202307222107.GdtIG4nq-lkp@intel.com>
References: <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michał,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.5-rc2 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/fs-proc-task_mmu-Implement-IOCTL-for-efficient-page-table-scanning/20230722-082500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/ZLshsAj5PbsEAHhP%40qmqm.qmqm.pl
patch subject: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230722/202307222107.GdtIG4nq-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307222107.GdtIG4nq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307222107.GdtIG4nq-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/proc/task_mmu.c:1921:6: error: call to undeclared function 'userfaultfd_wp_async'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
               ^
>> fs/proc/task_mmu.c:2047:13: error: use of undeclared identifier 'addr'
           if (end != addr + HPAGE_SIZE) {
                      ^
   2 errors generated.


vim +/addr +2047 fs/proc/task_mmu.c

  1913	
  1914	static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
  1915					  struct mm_walk *walk)
  1916	{
  1917		struct pagemap_scan_private *p = walk->private;
  1918		struct vm_area_struct *vma = walk->vma;
  1919		unsigned long vma_category = 0;
  1920	
> 1921		if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
  1922			vma_category |= PAGE_IS_WPASYNC;
  1923		else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
  1924			return -EPERM;
  1925	
  1926		if (vma->vm_flags & VM_PFNMAP)
  1927			return 1;
  1928	
  1929		if (!pagemap_scan_is_interesting_vma(vma_category, p))
  1930			return 1;
  1931	
  1932		p->cur_vma_category = vma_category;
  1933		return 0;
  1934	}
  1935	
  1936	static bool pagemap_scan_push_range(unsigned long categories,
  1937					    struct pagemap_scan_private *p,
  1938					    unsigned long addr, unsigned long end)
  1939	{
  1940		struct page_region *cur_buf = &p->cur_buf;
  1941	
  1942		/*
  1943		 * When there is no output buffer provided at all, the sentinel values
  1944		 * won't match here. There is no other way for `cur_buf->end` to be
  1945		 * non-zero other than it being non-empty.
  1946		 */
  1947		if (addr == cur_buf->end && categories == cur_buf->categories) {
  1948			cur_buf->end = end;
  1949			return true;
  1950		}
  1951	
  1952		if (cur_buf->end) {
  1953			if (p->vec_buf_index >= p->vec_buf_len)
  1954				return false;
  1955	
  1956			memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
  1957			       sizeof(*p->vec_buf));
  1958			++p->vec_buf_index;
  1959		}
  1960	
  1961		cur_buf->start = addr;
  1962		cur_buf->end = end;
  1963		cur_buf->categories = categories;
  1964		return true;
  1965	}
  1966	
  1967	static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
  1968					       unsigned long addr, unsigned long end)
  1969	{
  1970		struct page_region *cur_buf = &p->cur_buf;
  1971	
  1972		if (cur_buf->start != addr)
  1973			cur_buf->end = addr;
  1974		else
  1975			cur_buf->start = cur_buf->end = 0;
  1976	
  1977		p->end_addr = 0;
  1978		p->found_pages -= (end - addr) / PAGE_SIZE;
  1979	}
  1980	
  1981	static int pagemap_scan_output(unsigned long categories,
  1982				       struct pagemap_scan_private *p,
  1983				       unsigned long addr, unsigned long *end)
  1984	{
  1985		unsigned long n_pages, total_pages;
  1986		int ret = 0;
  1987	
  1988		if (!pagemap_scan_is_interesting_page(categories, p)) {
  1989			*end = addr;
  1990			return 0;
  1991		}
  1992	
  1993		if (!p->vec_buf)
  1994			return 0;
  1995	
  1996		categories &= p->arg.return_mask;
  1997	
  1998		n_pages = (*end - addr) / PAGE_SIZE;
  1999		if (check_add_overflow(p->found_pages, n_pages, &total_pages) || total_pages > p->arg.max_pages) {
  2000			size_t n_too_much = total_pages - p->arg.max_pages;
  2001			*end -= n_too_much * PAGE_SIZE;
  2002			n_pages -= n_too_much;
  2003			ret = -ENOSPC;
  2004		}
  2005	
  2006		if (!pagemap_scan_push_range(categories, p, addr, *end)) {
  2007			*end = addr;
  2008			n_pages = 0;
  2009			ret = -ENOSPC;
  2010		}
  2011	
  2012		p->found_pages += n_pages;
  2013		if (ret)
  2014			p->end_addr = *end;
  2015		return ret;
  2016	}
  2017	
  2018	static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
  2019					  unsigned long end, struct mm_walk *walk)
  2020	{
  2021	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  2022		struct pagemap_scan_private *p = walk->private;
  2023		struct vm_area_struct *vma = walk->vma;
  2024		unsigned long categories;
  2025		spinlock_t *ptl;
  2026		int ret = 0;
  2027	
  2028		ptl = pmd_trans_huge_lock(pmd, vma);
  2029		if (!ptl)
  2030			return -ENOENT;
  2031	
  2032		categories = p->cur_vma_category | pagemap_thp_category(*pmd);
  2033	
  2034		ret = pagemap_scan_output(categories, p, start, &end);
  2035		if (start == end)
  2036			goto out_unlock;
  2037	
  2038		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
  2039			goto out_unlock;
  2040		if (~categories & PAGE_IS_WRITTEN)
  2041			goto out_unlock;
  2042	
  2043		/*
  2044		 * Break huge page into small pages if the WP operation
  2045		 * need to be performed is on a portion of the huge page.
  2046		 */
> 2047		if (end != addr + HPAGE_SIZE) {
  2048			spin_unlock(ptl);
  2049			split_huge_pmd(vma, pmd, start);
  2050			pagemap_scan_backout_range(p, start, end);
  2051			return -ENOENT;
  2052		}
  2053	
  2054		make_uffd_wp_pmd(vma, start, pmd);
  2055		flush_tlb_range(vma, start, end);
  2056	out_unlock:
  2057		spin_unlock(ptl);
  2058		return ret;
  2059	#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
  2060		return -ENOENT;
  2061	#endif
  2062	}
  2063	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
