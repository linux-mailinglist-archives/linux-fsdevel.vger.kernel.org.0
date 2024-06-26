Return-Path: <linux-fsdevel+bounces-22524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26009918659
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A535A1F22969
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89FE18E767;
	Wed, 26 Jun 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpC0nL8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2618C359;
	Wed, 26 Jun 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417349; cv=none; b=pSCaW48XF0eGTc7TEDJA36tMkSBFZyJaiySDcYxBagHvMmU73hByvw46fdM376OLzUAltAvm6hlJTC//T4i19JsnQRsOO4+7rQl2lYE7tZN4NIZT0HymJZSoPPTbWYat3KeNvd8da4BL3TjzSvvzEwthS2maX7VVKfOwPhh0hfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417349; c=relaxed/simple;
	bh=CeD1BpysJWSTFuj1KyyszSxPpuc82ziNUeFqfvA+DXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAp6vXp1kyuGpgvQxz6iGJX6Xs2ipUsbakMhLO1PQKvq1qJZBgm5wfQq5+RKZrk7Pa1OGQkiSFhubfblqASbfxVwKVWKX/BCIHWyh/ZTeZ2GCCYHnzPfPyI4TBOBKbzENHxwAnrHQg/z+gzFoEQYB8UlRq5XV6mPOPWKVt4dF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpC0nL8G; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719417348; x=1750953348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CeD1BpysJWSTFuj1KyyszSxPpuc82ziNUeFqfvA+DXQ=;
  b=WpC0nL8GLUbhkPw+kcSCmVkviBgNNlQM+ymtmsiGtAEyAA6zSctKmdZN
   bC/ye1heSzv5/WnU/OpZiydcjbj6hj+13enar7GtJjInOcSA5ZZl12HC7
   XysCv/7nnThm5X33CMficeUTgnTyHhbZvNaVbaiok2eqxtCMM7QBGvvW6
   9xnMXieSS3ZPcae7qpckZ28mXTC3RvmGJQ7sSZTWSRPPmDBaI6AE3paPH
   S0peCoirxgtZo+Urk9wUVSXU2cAtKIB/6MEEJCTvCmP0ZFpdTeUkQ9Dka
   Nn7wKTvaqs9aCh7d57vtX29bO+DHIDgqJKIvgNKLe6hv1OL+Wn1g+IrfU
   A==;
X-CSE-ConnectionGUID: CaYDzttJSqC4v/vzTZcRuA==
X-CSE-MsgGUID: 5VdbDuz8TpGXCAd8oMSMeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16629307"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16629307"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 08:55:47 -0700
X-CSE-ConnectionGUID: RUe9N2q+S8m1FWE7fRgjAw==
X-CSE-MsgGUID: qlt0LCO8Q7qzNcR0H0VxYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44112607"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Jun 2024 08:55:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMUzl-000FMS-19;
	Wed, 26 Jun 2024 15:55:41 +0000
Date: Wed, 26 Jun 2024 23:55:15 +0800
From: kernel test robot <lkp@intel.com>
To: ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org,
	willy@infradead.org
Cc: oe-kbuild-all@lists.linux.dev, vbabka@suse.cz,
	svetly.todorov@memverge.com, ran.xiaokai@zte.com.cn,
	baohua@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
Message-ID: <202406262203.FFeFYbhP-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ran-xiaokai/mm-Constify-folio_order-folio_test_pmd_mappable/20240626-113027
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240626024924.1155558-3-ranxiaokai627%40163.com
patch subject: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
config: parisc-allnoconfig (https://download.01.org/0day-ci/archive/20240626/202406262203.FFeFYbhP-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406262203.FFeFYbhP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406262203.FFeFYbhP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/proc/page.c: In function 'stable_page_flags':
>> fs/proc/page.c:151:42: warning: passing argument 1 of 'folio_test_pmd_mappable' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     151 |         else if (folio_test_pmd_mappable(folio)) {
         |                                          ^~~~~
   In file included from include/linux/mm.h:1120,
                    from include/linux/memblock.h:12,
                    from fs/proc/page.c:2:
   include/linux/huge_mm.h:438:58: note: expected 'struct folio *' but argument is of type 'const struct folio *'
     438 | static inline bool folio_test_pmd_mappable(struct folio *folio)
         |                                            ~~~~~~~~~~~~~~^~~~~


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

