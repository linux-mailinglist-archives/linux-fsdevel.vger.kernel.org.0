Return-Path: <linux-fsdevel+bounces-19024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3878F8BF701
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B386B222E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C029CEE;
	Wed,  8 May 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwDU9yN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12215E86;
	Wed,  8 May 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153252; cv=none; b=KEHyKuMiH5iS7o5f2rMFTATVtTnOJe8WvXbx3KJhjwZKIn/gekTXJGqI0kN+REy3VxE7i7tk+ILPEqFSHVkXyjfaU+LQVcvwUJhhjPHJj98s4606fYGuKMpPsjYEEhQcNkd/qmp+AzrEhmtwG5Hk3DAYrc96Fwzm5Zu0EsacBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153252; c=relaxed/simple;
	bh=xpiIG4jtRdopAx9ftVv9Or6scywdE5EJln5/82QX6r8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HD+sTVNDb0Wdbi8ME4a7J24DoOBvFXEzoTp4s2VPhRAcgSZN2QHfw8bmitc8EMXq8biYGSN9F8A4UMPuiQCkjVlj102IIWfVo2NHtiYjxw2qIa4NJiOYIzS/90wqCGzAU/eMBwpI+/ie4q27jVIMlYcSnQqlBWSi6vc8sVaHtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwDU9yN3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715153242; x=1746689242;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xpiIG4jtRdopAx9ftVv9Or6scywdE5EJln5/82QX6r8=;
  b=gwDU9yN372ZxglrqIn2L22LdMkLrIYXq6+2Ojdj/3P5PQwA6dfQ1eS7n
   jzFUsuSCxCTcpHdXNHnb1gIuK/Nav1ZzYpFTfKMFC7gJAeGFcv5weFJn8
   FgJjrYsfSfezhnacyKfm3qBMH7nNYo2ZXM3+x/9M0LxBJO2uYCVdxMWJZ
   cF8E1NluQDU0iIV+b7k4LkSIlkLHc91bn3Dun9u4ZVvL/vqJf3d5JmEf8
   dMRv/w8R3P3AA4Ozv5hy7uSmxwPkcsTcuBz9jLJGOXZDe+0taYG8TMctt
   K8F2XQcNekMvrCpi4W4w9Lnxyi5JQw9vQo0YUiL+tY6h8ypXa6j4C+cMI
   w==;
X-CSE-ConnectionGUID: 65JsRRVCToCYltz0MPCWVA==
X-CSE-MsgGUID: 44DW16tySGCzpnakCpLMLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21663411"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="21663411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:27:21 -0700
X-CSE-ConnectionGUID: NBe1FuQAThmdWztbgDdFOw==
X-CSE-MsgGUID: uWPDLiAUTJuJBFrnpymrPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28736485"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:27:17 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] mm/swap: reduce swap cache search space
In-Reply-To: <20240502084939.30250-5-ryncsn@gmail.com> (Kairui Song's message
	of "Thu, 2 May 2024 16:49:39 +0800")
References: <20240502084609.28376-1-ryncsn@gmail.com>
	<20240502084939.30250-5-ryncsn@gmail.com>
Date: Wed, 08 May 2024 15:25:25 +0800
Message-ID: <874jb8lq8q.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> ---
>  mm/huge_memory.c |  2 +-
>  mm/memcontrol.c  |  2 +-
>  mm/mincore.c     |  2 +-
>  mm/shmem.c       |  2 +-
>  mm/swap.h        | 15 +++++++++++++++
>  mm/swap_state.c  | 19 ++++++++++---------
>  mm/swapfile.c    |  6 +++---
>  7 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d35d526ed48f..45829cc049d2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2918,7 +2918,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	split_page_memcg(head, order, new_order);
>  
>  	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> -		offset = swp_offset(folio->swap);
> +		offset = swap_cache_index(folio->swap);
>  		swap_cache = swap_address_space(folio->swap);
>  		xa_lock(&swap_cache->i_pages);
>  	}
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d11536ef59ef..81b005c459cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6165,7 +6165,7 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
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
> index 82023ab93205..93e3e1b58a7f 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -27,6 +27,7 @@ void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
>  /* One swap address space for each 64M swap space */
>  #define SWAP_ADDRESS_SPACE_SHIFT	14
>  #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
> +#define SWAP_ADDRESS_SPACE_MASK		(BIT(SWAP_ADDRESS_SPACE_SHIFT) - 1)

#define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
?

We can use BIT() in SWAP_ADDRESS_SPACE_PAGES definition.

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
> index 642c30d8376c..09415d4c7843 100644
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
> @@ -248,18 +248,19 @@ void delete_from_swap_cache(struct folio *folio)
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>  				unsigned long end)
>  {
> -	unsigned long curr = begin;
> +	unsigned long curr = begin, offset;

Better to rename "offset" as "index" to avoid confusion?

>  	void *old;
>  
>  	for (;;) {
> +		offset = curr & SWAP_ADDRESS_SPACE_MASK;
>  		swp_entry_t entry = swp_entry(type, curr);
>  		struct address_space *address_space = swap_address_space(entry);
> -		XA_STATE(xas, &address_space->i_pages, curr);
> +		XA_STATE(xas, &address_space->i_pages, offset);
>  
>  		xas_set_update(&xas, workingset_update_node);
>  
>  		xa_lock_irq(&address_space->i_pages);
> -		xas_for_each(&xas, old, end) {
> +		xas_for_each(&xas, old, offset + min(end - curr, SWAP_ADDRESS_SPACE_PAGES)) {

Is there a bug in the original code?  It doesn't check SWAP_ADDRESS_SPACE_PAGES.

And should it be changed to

        xas_for_each(&xas, old, min(offset + end - curr, SWAP_ADDRESS_SPACE_PAGES))

?

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

--
Best Regards,
Huang, Ying

