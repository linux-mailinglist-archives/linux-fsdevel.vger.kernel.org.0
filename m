Return-Path: <linux-fsdevel+bounces-22528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02991873C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C11528759D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6719D18EFE4;
	Wed, 26 Jun 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPv+SDn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271118E758;
	Wed, 26 Jun 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418986; cv=none; b=UkE6E3Lto6R3TbZgyOqb1qBOqRybfpZrVT1w4nntNkT7CYKGLgqQ7dYU1AVJkVdTJ7JPh5gMKzoY2+MtzK0p/ItD7bMFGwvVivV3uR+ZkSthMRKUAtJCnrOewnbN0OpuizKfl6EZxnNg6O/1CJ3HWC3nFCOdx6idk1CkwInBcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418986; c=relaxed/simple;
	bh=6gFjRqnmAlZ+KmWeNakm51Ebba0HMPjTrguhw4sm/E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne7ONDYM4siVWJW6R29+PHHY34RqM3SYiY+qmdU/K7275DL6Haq7Pw3dMhSGDmEQGvWnoe1PwlgFqMzYM/XnShP4PP/2kYp87/M0CzTgqYFhU4nSuXQCParwq7W9sLQhCTLFhfYrdq++ifpdsO7HwYSV+nl8MYHaDRJK/ptREXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPv+SDn7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719418984; x=1750954984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6gFjRqnmAlZ+KmWeNakm51Ebba0HMPjTrguhw4sm/E0=;
  b=YPv+SDn7/EhbHb3HgVmYD1gHLPuUSgtsAH/+SVu0IMUDFIzLBUn+NavU
   DeNMJQxUwS8PREfnIyBJRjHNsWle//Hr2XzOw8crUDtGkLS/WBWSDimcm
   j878TWe3w7agPSbOeFSqmCd1qCzvUVAtTcP0WVB4su1zNSeNmC1gjcFrf
   fuN3sBkLnQI+1iiHXvA8qCtwWJU+/8zisrVs4sxnm6Qb41m4n4oP0iqo4
   hMyfCVynLvrCQDfcTJAkSDuCNb0RZ3jn8/FTWG6dR9d8lZM4LpOgd53sS
   ORus+ZB/O/FjJHsJv5sp9BCIJbVTf9qLT+ZJWn3jkHm1KJxyTUJYC2Jlq
   w==;
X-CSE-ConnectionGUID: EB1HoWh4R6ikNx7AIbO69A==
X-CSE-MsgGUID: Eul6hx8DTPWticHZs8pJhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16651449"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16651449"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:23:03 -0700
X-CSE-ConnectionGUID: aqVxw+UeSm2pAi9hLFlh0g==
X-CSE-MsgGUID: 49XKsDlLR0O245zfXBJvQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43930121"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2024 09:23:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMVQ9-000FNi-1r;
	Wed, 26 Jun 2024 16:22:57 +0000
Date: Thu, 27 Jun 2024 00:21:13 +0800
From: kernel test robot <lkp@intel.com>
To: ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org,
	willy@infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, vbabka@suse.cz,
	svetly.todorov@memverge.com, ran.xiaokai@zte.com.cn,
	baohua@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
Message-ID: <202406262300.iAURISyJ-lkp@intel.com>
References: <20240626024924.1155558-3-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626024924.1155558-3-ranxiaokai627@163.com>

Hi ran,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ran-xiaokai/mm-Constify-folio_order-folio_test_pmd_mappable/20240626-113027
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240626024924.1155558-3-ranxiaokai627%40163.com
patch subject: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240626/202406262300.iAURISyJ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406262300.iAURISyJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406262300.iAURISyJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/proc/page.c:151:35: error: passing 'const struct folio *' to parameter of type 'struct folio *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     151 |         else if (folio_test_pmd_mappable(folio)) {
         |                                          ^~~~~
   include/linux/huge_mm.h:438:58: note: passing argument to parameter 'folio' here
     438 | static inline bool folio_test_pmd_mappable(struct folio *folio)
         |                                                          ^
   1 error generated.


vim +151 fs/proc/page.c

   108	
   109	u64 stable_page_flags(const struct page *page)
   110	{
   111		const struct folio *folio;
   112		unsigned long k;
   113		unsigned long mapping;
   114		bool is_anon;
   115		u64 u = 0;
   116	
   117		/*
   118		 * pseudo flag: KPF_NOPAGE
   119		 * it differentiates a memory hole from a page with no flags
   120		 */
   121		if (!page)
   122			return 1 << KPF_NOPAGE;
   123		folio = page_folio(page);
   124	
   125		k = folio->flags;
   126		mapping = (unsigned long)folio->mapping;
   127		is_anon = mapping & PAGE_MAPPING_ANON;
   128	
   129		/*
   130		 * pseudo flags for the well known (anonymous) memory mapped pages
   131		 */
   132		if (page_mapped(page))
   133			u |= 1 << KPF_MMAP;
   134		if (is_anon) {
   135			u |= 1 << KPF_ANON;
   136			if (mapping & PAGE_MAPPING_KSM)
   137				u |= 1 << KPF_KSM;
   138		}
   139	
   140		/*
   141		 * compound pages: export both head/tail info
   142		 * they together define a compound page's start/end pos and order
   143		 */
   144		if (page == &folio->page)
   145			u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
   146		else
   147			u |= 1 << KPF_COMPOUND_TAIL;
   148	
   149		if (folio_test_hugetlb(folio))
   150			u |= 1 << KPF_HUGE;
 > 151		else if (folio_test_pmd_mappable(folio)) {
   152			u |= 1 << KPF_THP;
   153			if (is_huge_zero_folio(folio))
   154				u |= 1 << KPF_ZERO_PAGE;
   155		} else if (is_zero_pfn(page_to_pfn(page)))
   156			u |= 1 << KPF_ZERO_PAGE;
   157	
   158		/*
   159		 * Caveats on high order pages: PG_buddy and PG_slab will only be set
   160		 * on the head page.
   161		 */
   162		if (PageBuddy(page))
   163			u |= 1 << KPF_BUDDY;
   164		else if (page_count(page) == 0 && is_free_buddy_page(page))
   165			u |= 1 << KPF_BUDDY;
   166	
   167		if (PageOffline(page))
   168			u |= 1 << KPF_OFFLINE;
   169		if (PageTable(page))
   170			u |= 1 << KPF_PGTABLE;
   171		if (folio_test_slab(folio))
   172			u |= 1 << KPF_SLAB;
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

