Return-Path: <linux-fsdevel+bounces-19305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09E8C2FBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 07:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174DE1C21701
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781347F7A;
	Sat, 11 May 2024 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1IkTPj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845BB27452;
	Sat, 11 May 2024 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715406999; cv=none; b=NdlTfMwks9ZhqdEVEmHVm1rfZo6M6wotLTV0mLFXaiIEY3ISdN+x+FgQYmTRCadbfyin7Ndy7L/X7CwlEa+Lf8SAcwCMTfuKmY8CFWtDKoBzHsFscFw3y/IhdYF9DvHp3Is5xRjBElF6npCX22waQ4cVpTV1iPkV3ySny+xWXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715406999; c=relaxed/simple;
	bh=9c1YrJVoYXvpOrqx8Si67leFWzfTJAePXpqpB7BacIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2tVze9gKUQoy7Hp4j1m1b4bZyMq2SDUN/WjQ3poL6OLzCdsO2tcZMkAB09YC1R8nZCIg27qyOH7ittgWNCb/n0AWENO5MlhfsnMHVFK0aSk+9sMBGA8s08OB7jqj27Okf9SaOTRR3utFsGzqKYDonWnIoG/Iq19cEHGrY/UJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1IkTPj+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715406997; x=1746942997;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9c1YrJVoYXvpOrqx8Si67leFWzfTJAePXpqpB7BacIA=;
  b=l1IkTPj+49027VY61PyqmLZMzCcgjzSRYc3Z+xLDdwuiA6DQPxykl+EA
   xmK2sAxEi8XCtB+B5Z1KGtuNMISzybPDHL/AZKeFD0M8+5fQfDiB4pnzC
   kkTzunpWwQIqyxQtfThDBt30f/knai7llLmXs20GT6fsqe+4yZouDq6md
   TL4ZwDlVkyv7rJpM0KOK8Rjd1HNUFScciy5qLbfbbQAC9UmRDkTLKJwPY
   5Wdwzs9m8JX0GA58CNHE0l8CsdIi7JVe/0xQszLt35gSUmEJ9z5iVCx1z
   yP9mNGb0BoV+qNgkFmc36rw9tFZMOsOHo5+raET1AuJFxYdKmu1Hf3yuM
   A==;
X-CSE-ConnectionGUID: k2xb+Og8TLaG9ww3i4YfPQ==
X-CSE-MsgGUID: p6L7pNJRS8+9RTFz3ANMgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="15241211"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="15241211"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:56:36 -0700
X-CSE-ConnectionGUID: v3YQjbwbQe+9E/9E/PWR/g==
X-CSE-MsgGUID: LUXDQDhqQxuGvmH07QDRQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="60676274"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:56:33 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  David Hildenbrand <david@redhat.com>,  Hugh Dickins
 <hughd@google.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/12] mm/swap: reduce swap cache search space
In-Reply-To: <20240510114747.21548-13-ryncsn@gmail.com> (Kairui Song's message
	of "Fri, 10 May 2024 19:47:47 +0800")
References: <20240510114747.21548-1-ryncsn@gmail.com>
	<20240510114747.21548-13-ryncsn@gmail.com>
Date: Sat, 11 May 2024 13:54:40 +0800
Message-ID: <87jzk0hp0f.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> Currently we use one swap_address_space for every 64M chunk to reduce lock
> contention, this is like having a set of smaller swap files inside one
> swap device. But when doing swap cache look up or insert, we are
> still using the offset of the whole large swap device. This is OK for
> correctness, as the offset (key) is unique.
>
> But Xarray is specially optimized for small indexes, it creates the
> radix tree levels lazily to be just enough to fit the largest key
> stored in one Xarray. So we are wasting tree nodes unnecessarily.
>
> For 64M chunk it should only take at most 3 levels to contain everything.
> But if we are using the offset from the whole swap device, the offset (key)
> value will be way beyond 64M, and so will the tree level.
>
> Optimize this by using a new helper swap_cache_index to get a swap
> entry's unique offset in its own 64M swap_address_space.
>
> I see a ~1% performance gain in benchmark and actual workload with
> high memory pressure.
>
> Test with `time memhog 128G` inside a 8G memcg using 128G swap (ramdisk
> with SWP_SYNCHRONOUS_IO dropped, tested 3 times, results are stable. The
> test result is similar but the improvement is smaller if SWP_SYNCHRONOUS_IO
> is enabled, as swap out path can never skip swap cache):
>
> Before:
> 6.07user 250.74system 4:17.26elapsed 99%CPU (0avgtext+0avgdata 8373376maxresident)k
> 0inputs+0outputs (55major+33555018minor)pagefaults 0swaps
>
> After (1.8% faster):
> 6.08user 246.09system 4:12.58elapsed 99%CPU (0avgtext+0avgdata 8373248maxresident)k
> 0inputs+0outputs (54major+33555027minor)pagefaults 0swaps
>
> Similar result with MySQL and sysbench using swap:
> Before:
> 94055.61 qps
>
> After (0.8% faster):
> 94834.91 qps
>
> Radix tree slab usage is also very slightly lower.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/huge_memory.c |  2 +-
>  mm/memcontrol.c  |  2 +-
>  mm/mincore.c     |  2 +-
>  mm/shmem.c       |  2 +-
>  mm/swap.h        | 15 +++++++++++++++
>  mm/swap_state.c  | 17 +++++++++--------
>  mm/swapfile.c    |  6 +++---
>  7 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 317de2afd371..fcc0e86a2589 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2838,7 +2838,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	split_page_memcg(head, order, new_order);
>  
>  	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> -		offset = swp_offset(folio->swap);
> +		offset = swap_cache_index(folio->swap);
>  		swap_cache = swap_address_space(folio->swap);
>  		xa_lock(&swap_cache->i_pages);
>  	}
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d127c9c5fabf..024aeb64d0be 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6153,7 +6153,7 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
>  	 * Because swap_cache_get_folio() updates some statistics counter,
>  	 * we call find_get_page() with swapper_space directly.
>  	 */
> -	page = find_get_page(swap_address_space(ent), swp_offset(ent));
> +	page = find_get_page(swap_address_space(ent), swap_cache_index(ent));
>  	entry->val = ent.val;
>  
>  	return page;
> diff --git a/mm/mincore.c b/mm/mincore.c
> index dad3622cc963..e31cf1bde614 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -139,7 +139,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  			} else {
>  #ifdef CONFIG_SWAP
>  				*vec = mincore_page(swap_address_space(entry),
> -						    swp_offset(entry));
> +						    swap_cache_index(entry));
>  #else
>  				WARN_ON(1);
>  				*vec = 1;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fa2a0ed97507..326315c12feb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1756,7 +1756,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>  
>  	old = *foliop;
>  	entry = old->swap;
> -	swap_index = swp_offset(entry);
> +	swap_index = swap_cache_index(entry);
>  	swap_mapping = swap_address_space(entry);
>  
>  	/*
> diff --git a/mm/swap.h b/mm/swap.h
> index 82023ab93205..2c0e96272d49 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -27,6 +27,7 @@ void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
>  /* One swap address space for each 64M swap space */
>  #define SWAP_ADDRESS_SPACE_SHIFT	14
>  #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
> +#define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
>  extern struct address_space *swapper_spaces[];
>  #define swap_address_space(entry)			    \
>  	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
> @@ -40,6 +41,15 @@ static inline loff_t swap_dev_pos(swp_entry_t entry)
>  	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
>  }
>  
> +/*
> + * Return the swap cache index of the swap entry.
> + */
> +static inline pgoff_t swap_cache_index(swp_entry_t entry)
> +{
> +	BUILD_BUG_ON((SWP_OFFSET_MASK | SWAP_ADDRESS_SPACE_MASK) != SWP_OFFSET_MASK);
> +	return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
> +}
> +
>  void show_swap_cache_info(void);
>  bool add_to_swap(struct folio *folio);
>  void *get_shadow_from_swap_cache(swp_entry_t entry);
> @@ -86,6 +96,11 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
>  	return NULL;
>  }
>  
> +static inline pgoff_t swap_cache_index(swp_entry_t entry)
> +{
> +	return 0;
> +}
> +
>  static inline void show_swap_cache_info(void)
>  {
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 642c30d8376c..6e86c759dc1d 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -72,7 +72,7 @@ void show_swap_cache_info(void)
>  void *get_shadow_from_swap_cache(swp_entry_t entry)
>  {
>  	struct address_space *address_space = swap_address_space(entry);
> -	pgoff_t idx = swp_offset(entry);
> +	pgoff_t idx = swap_cache_index(entry);
>  	void *shadow;
>  
>  	shadow = xa_load(&address_space->i_pages, idx);
> @@ -89,7 +89,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
>  			gfp_t gfp, void **shadowp)
>  {
>  	struct address_space *address_space = swap_address_space(entry);
> -	pgoff_t idx = swp_offset(entry);
> +	pgoff_t idx = swap_cache_index(entry);
>  	XA_STATE_ORDER(xas, &address_space->i_pages, idx, folio_order(folio));
>  	unsigned long i, nr = folio_nr_pages(folio);
>  	void *old;
> @@ -144,7 +144,7 @@ void __delete_from_swap_cache(struct folio *folio,
>  	struct address_space *address_space = swap_address_space(entry);
>  	int i;
>  	long nr = folio_nr_pages(folio);
> -	pgoff_t idx = swp_offset(entry);
> +	pgoff_t idx = swap_cache_index(entry);
>  	XA_STATE(xas, &address_space->i_pages, idx);
>  
>  	xas_set_update(&xas, workingset_update_node);
> @@ -253,13 +253,14 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
>  
>  	for (;;) {
>  		swp_entry_t entry = swp_entry(type, curr);
> +		unsigned long index = curr & SWAP_ADDRESS_SPACE_MASK;
>  		struct address_space *address_space = swap_address_space(entry);
> -		XA_STATE(xas, &address_space->i_pages, curr);
> +		XA_STATE(xas, &address_space->i_pages, index);
>  
>  		xas_set_update(&xas, workingset_update_node);
>  
>  		xa_lock_irq(&address_space->i_pages);
> -		xas_for_each(&xas, old, end) {
> +		xas_for_each(&xas, old, min(index + (end - curr), SWAP_ADDRESS_SPACE_PAGES)) {
>  			if (!xa_is_value(old))
>  				continue;
>  			xas_store(&xas, NULL);
> @@ -350,7 +351,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
>  {
>  	struct folio *folio;
>  
> -	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
> +	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
>  	if (!IS_ERR(folio)) {
>  		bool vma_ra = swap_use_vma_readahead();
>  		bool readahead;
> @@ -420,7 +421,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
>  	si = get_swap_device(swp);
>  	if (!si)
>  		return ERR_PTR(-ENOENT);
> -	index = swp_offset(swp);
> +	index = swap_cache_index(swp);
>  	folio = filemap_get_folio(swap_address_space(swp), index);
>  	put_swap_device(si);
>  	return folio;
> @@ -447,7 +448,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * that would confuse statistics.
>  		 */
>  		folio = filemap_get_folio(swap_address_space(entry),
> -						swp_offset(entry));
> +					  swap_cache_index(entry));
>  		if (!IS_ERR(folio))
>  			goto got_folio;
>  
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0b0ae6e8c764..4f0e8b2ac8aa 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -142,7 +142,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>  	struct folio *folio;
>  	int ret = 0;
>  
> -	folio = filemap_get_folio(swap_address_space(entry), offset);
> +	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
>  	if (IS_ERR(folio))
>  		return 0;
>  	/*
> @@ -2158,7 +2158,7 @@ static int try_to_unuse(unsigned int type)
>  	       (i = find_next_to_unuse(si, i)) != 0) {
>  
>  		entry = swp_entry(type, i);
> -		folio = filemap_get_folio(swap_address_space(entry), i);
> +		folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
>  		if (IS_ERR(folio))
>  			continue;
>  
> @@ -3476,7 +3476,7 @@ EXPORT_SYMBOL_GPL(swapcache_mapping);
>  
>  pgoff_t __folio_swap_cache_index(struct folio *folio)
>  {
> -	return swp_offset(folio->swap);
> +	return swap_cache_index(folio->swap);
>  }
>  EXPORT_SYMBOL_GPL(__folio_swap_cache_index);

