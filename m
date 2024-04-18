Return-Path: <linux-fsdevel+bounces-17258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2078AA1F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 20:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1E2811AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334217AD63;
	Thu, 18 Apr 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T62taqkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3283A07;
	Thu, 18 Apr 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464516; cv=none; b=lxkLWyZIGj+DffkfbZK2/RJdZg4wjgrRNgOycyET2ZPc/9coekmoI6K6kgQwm1OqHc3brbQyiCAUKKYRrOUZRMB7XNVnxGLHHnlw9A0QFDF/OsSL+4TXSq+yq6kLpHqurlmNI9NqPamWHFJ6MO+tT0FR1WHZYvua5Y9Q60DdngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464516; c=relaxed/simple;
	bh=di7AEMML3XBmS6NNk5yHpV2YGbf6QjEDD4R85XDT5mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij5iXbEUWHSxK6EhluAofAudkALBtt/xZWGoFTpsPjlFyu0tpBONLTHqn6nvkXnEtJBCL++cg+M36D9ngSN10ylI664prGfuHgianNna4EheDPLL/klEboZhjXUZR4kH8UWvKq7tqgl3413owA7MhwY5je0yTJgvrEvT/Ddztvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T62taqkf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713464514; x=1745000514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=di7AEMML3XBmS6NNk5yHpV2YGbf6QjEDD4R85XDT5mo=;
  b=T62taqkfFat9gpksDnMh8APP/37qV7ucPb2P7cVWPrhwtkJrNsE2GKjw
   8iV1lBqyRmuhoXqCVNT68tmX3oNFyd6FxZMZg7dpNHG5UanjE+Edj+5Pa
   O9QracNts7YwboQcz0a85ZA6ByHENfTI8fxJ+GK//jAQdNaId5W11dVBN
   CDcXYy52fmLDwEoBlcc0qQqTl0CJjcRBqYyIUm3n8lLlREfV1R89brUoW
   zACrfN5rDZK4UmzeACLvvVFrqM2Z8LZJIAq7gllSoznmeXroawQVS4qeT
   IGbU3midrcmbhTapFePhAiW7nIHSNy2AVIcEO10l8ydPR5NyEPnnOU7l6
   Q==;
X-CSE-ConnectionGUID: ij1xVX3BRtSGKa/BN7U7PA==
X-CSE-MsgGUID: wkXhNfWpRguTRl+NXL5w0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8898352"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8898352"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 11:21:53 -0700
X-CSE-ConnectionGUID: W6zduy+0QkW3zModnl3a/g==
X-CSE-MsgGUID: JpytdpXORt2rOjRS5AKkpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27531776"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 18 Apr 2024 11:21:49 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxWOJ-00095q-0X;
	Thu, 18 Apr 2024 18:21:47 +0000
Date: Fri, 19 Apr 2024 02:21:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 8/8] mm/swap: reduce swap cache search space
Message-ID: <202404190258.wljFnvCL-lkp@intel.com>
References: <20240417160842.76665-9-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417160842.76665-9-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on ceph-client/testing]
[also build test ERROR on ceph-client/for-linus trondmy-nfs/linux-next konis-nilfs2/upstream jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev cifs/for-next linus/master v6.9-rc4]
[cannot apply to akpm-mm/mm-everything next-20240418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/NFS-remove-nfs_page_lengthg-and-usage-of-page_index/20240418-001343
base:   https://github.com/ceph/ceph-client.git testing
patch link:    https://lore.kernel.org/r/20240417160842.76665-9-ryncsn%40gmail.com
patch subject: [PATCH 8/8] mm/swap: reduce swap cache search space
config: i386-buildonly-randconfig-002-20240419 (https://download.01.org/0day-ci/archive/20240419/202404190258.wljFnvCL-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190258.wljFnvCL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190258.wljFnvCL-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/huge_memory.c: In function '__split_huge_page':
>> mm/huge_memory.c:2906:12: error: implicit declaration of function 'swap_cache_index' [-Werror=implicit-function-declaration]
    2906 |   offset = swap_cache_index(folio->swap);
         |            ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/swap_cache_index +2906 mm/huge_memory.c

  2888	
  2889	static void __split_huge_page(struct page *page, struct list_head *list,
  2890			pgoff_t end, unsigned int new_order)
  2891	{
  2892		struct folio *folio = page_folio(page);
  2893		struct page *head = &folio->page;
  2894		struct lruvec *lruvec;
  2895		struct address_space *swap_cache = NULL;
  2896		unsigned long offset = 0;
  2897		int i, nr_dropped = 0;
  2898		unsigned int new_nr = 1 << new_order;
  2899		int order = folio_order(folio);
  2900		unsigned int nr = 1 << order;
  2901	
  2902		/* complete memcg works before add pages to LRU */
  2903		split_page_memcg(head, order, new_order);
  2904	
  2905		if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> 2906			offset = swap_cache_index(folio->swap);
  2907			swap_cache = swap_address_space(folio->swap);
  2908			xa_lock(&swap_cache->i_pages);
  2909		}
  2910	
  2911		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
  2912		lruvec = folio_lruvec_lock(folio);
  2913	
  2914		ClearPageHasHWPoisoned(head);
  2915	
  2916		for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
  2917			__split_huge_page_tail(folio, i, lruvec, list, new_order);
  2918			/* Some pages can be beyond EOF: drop them from page cache */
  2919			if (head[i].index >= end) {
  2920				struct folio *tail = page_folio(head + i);
  2921	
  2922				if (shmem_mapping(folio->mapping))
  2923					nr_dropped++;
  2924				else if (folio_test_clear_dirty(tail))
  2925					folio_account_cleaned(tail,
  2926						inode_to_wb(folio->mapping->host));
  2927				__filemap_remove_folio(tail, NULL);
  2928				folio_put(tail);
  2929			} else if (!PageAnon(page)) {
  2930				__xa_store(&folio->mapping->i_pages, head[i].index,
  2931						head + i, 0);
  2932			} else if (swap_cache) {
  2933				__xa_store(&swap_cache->i_pages, offset + i,
  2934						head + i, 0);
  2935			}
  2936		}
  2937	
  2938		if (!new_order)
  2939			ClearPageCompound(head);
  2940		else {
  2941			struct folio *new_folio = (struct folio *)head;
  2942	
  2943			folio_set_order(new_folio, new_order);
  2944		}
  2945		unlock_page_lruvec(lruvec);
  2946		/* Caller disabled irqs, so they are still disabled here */
  2947	
  2948		split_page_owner(head, order, new_order);
  2949	
  2950		/* See comment in __split_huge_page_tail() */
  2951		if (folio_test_anon(folio)) {
  2952			/* Additional pin to swap cache */
  2953			if (folio_test_swapcache(folio)) {
  2954				folio_ref_add(folio, 1 + new_nr);
  2955				xa_unlock(&swap_cache->i_pages);
  2956			} else {
  2957				folio_ref_inc(folio);
  2958			}
  2959		} else {
  2960			/* Additional pin to page cache */
  2961			folio_ref_add(folio, 1 + new_nr);
  2962			xa_unlock(&folio->mapping->i_pages);
  2963		}
  2964		local_irq_enable();
  2965	
  2966		if (nr_dropped)
  2967			shmem_uncharge(folio->mapping->host, nr_dropped);
  2968		remap_page(folio, nr);
  2969	
  2970		if (folio_test_swapcache(folio))
  2971			split_swap_cluster(folio->swap);
  2972	
  2973		/*
  2974		 * set page to its compound_head when split to non order-0 pages, so
  2975		 * we can skip unlocking it below, since PG_locked is transferred to
  2976		 * the compound_head of the page and the caller will unlock it.
  2977		 */
  2978		if (new_order)
  2979			page = compound_head(page);
  2980	
  2981		for (i = 0; i < nr; i += new_nr) {
  2982			struct page *subpage = head + i;
  2983			struct folio *new_folio = page_folio(subpage);
  2984			if (subpage == page)
  2985				continue;
  2986			folio_unlock(new_folio);
  2987	
  2988			/*
  2989			 * Subpages may be freed if there wasn't any mapping
  2990			 * like if add_to_swap() is running on a lru page that
  2991			 * had its mapping zapped. And freeing these pages
  2992			 * requires taking the lru_lock so we do the put_page
  2993			 * of the tail pages after the split is complete.
  2994			 */
  2995			free_page_and_swap_cache(subpage);
  2996		}
  2997	}
  2998	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

