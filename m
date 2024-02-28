Return-Path: <linux-fsdevel+bounces-13051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C986A9C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB11288BB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F232C85F;
	Wed, 28 Feb 2024 08:23:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493992D022;
	Wed, 28 Feb 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108605; cv=none; b=Xd3Wnhqh9ZGp6w9j+5vE/J4kKR03VFnpY7f4Du7PL6oL1+VzqUj3hO5vVFL9kuHikq4CeabNst1MYYBGq2tWaUDzMN0SEDtIYcwrdgvL+UtFevxvl7HfynfMssBDzDEZJ6alqc1aNuSnypE4NuO2kIbKTg+lwunWmsVAEzWrRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108605; c=relaxed/simple;
	bh=ef6VRjDBpTumPy5z6hG934B/OFyEkgoBDp12P2hkrNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/TuDZft70ob8It8YpUVG7VBBnyGkdIdK6YB9kIuNgv084qbLQOPZqfxhmckUXC0qOtjhyUfm6rBEILQw9vkuSdvyJRonIiuM2Xna8P/abR6OdX9wpFFL0SofpJST0pSrQ7KCpbIBF6GuRMZQKLVT4lBGdVcOamZe3dQpt5jEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44509C15;
	Wed, 28 Feb 2024 00:24:01 -0800 (PST)
Received: from [10.57.67.95] (unknown [10.57.67.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C87393F6C4;
	Wed, 28 Feb 2024 00:23:19 -0800 (PST)
Message-ID: <2ce685a2-20c9-4287-a40f-30b0f0c59d49@arm.com>
Date: Wed, 28 Feb 2024 08:23:17 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] mm: thp: split huge page to any lower order pages
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Zach O'Keefe
 <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-8-zi.yan@sent.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240226205534.1603748-8-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zi,


On 26/02/2024 20:55, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> To split a THP to any lower order pages, we need to reform THPs on
> subpages at given order and add page refcount based on the new page
> order. Also we need to reinitialize page_deferred_list after removing
> the page from the split_queue, otherwise a subsequent split will
> see list corruption when checking the page_deferred_list again.
> 
> Note: Anonymous order-1 folio is not supported because _deferred_list,
> which is used by partially mapped folios, is stored in subpage 2 and an
> order-1 folio only has subpage 0 and 1. File-backed order-1 folios are
> fine, since they do not use _deferred_list.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/huge_mm.h |  21 +++++---
>  mm/huge_memory.c        | 110 +++++++++++++++++++++++++++++++---------
>  2 files changed, 99 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 5adb86af35fc..de0c89105076 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -265,10 +265,11 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  
>  void folio_prep_large_rmappable(struct folio *folio);
>  bool can_split_folio(struct folio *folio, int *pextra_pins);
> -int split_huge_page_to_list(struct page *page, struct list_head *list);
> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +		unsigned int new_order);
>  static inline int split_huge_page(struct page *page)
>  {
> -	return split_huge_page_to_list(page, NULL);
> +	return split_huge_page_to_list_to_order(page, NULL, 0);
>  }
>  void deferred_split_folio(struct folio *folio);
>  
> @@ -422,7 +423,8 @@ can_split_folio(struct folio *folio, int *pextra_pins)
>  	return false;
>  }
>  static inline int
> -split_huge_page_to_list(struct page *page, struct list_head *list)
> +split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +		unsigned int new_order)
>  {
>  	return 0;
>  }
> @@ -519,17 +521,20 @@ static inline bool thp_migration_supported(void)
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -static inline int split_folio_to_list(struct folio *folio,
> -		struct list_head *list)
> +static inline int split_folio_to_list_to_order(struct folio *folio,
> +		struct list_head *list, int new_order)
>  {
> -	return split_huge_page_to_list(&folio->page, list);
> +	return split_huge_page_to_list_to_order(&folio->page, list, new_order);
>  }
>  
> -static inline int split_folio(struct folio *folio)
> +static inline int split_folio_to_order(struct folio *folio, int new_order)
>  {
> -	return split_folio_to_list(folio, NULL);
> +	return split_folio_to_list_to_order(folio, NULL, new_order);
>  }
>  
> +#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
> +#define split_folio(f) split_folio_to_order(f, 0)
> +
>  /*
>   * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
>   * limitations in the implementation like arm64 MTE can override this to
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b2df788c11fa..8b47a96a28f9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2770,7 +2770,6 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>  		struct lruvec *lruvec, struct list_head *list)
>  {
>  	VM_BUG_ON_PAGE(!PageHead(head), head);
> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>  	lockdep_assert_held(&lruvec->lru_lock);
>  
> @@ -2791,7 +2790,8 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>  }
>  
>  static void __split_huge_page_tail(struct folio *folio, int tail,
> -		struct lruvec *lruvec, struct list_head *list)
> +		struct lruvec *lruvec, struct list_head *list,
> +		unsigned int new_order)
>  {
>  	struct page *head = &folio->page;
>  	struct page *page_tail = head + tail;
> @@ -2861,10 +2861,15 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
>  	 * which needs correct compound_head().
>  	 */
>  	clear_compound_head(page_tail);
> +	if (new_order) {
> +		prep_compound_page(page_tail, new_order);
> +		folio_prep_large_rmappable(new_folio);
> +	}
>  
>  	/* Finally unfreeze refcount. Additional reference from page cache. */
> -	page_ref_unfreeze(page_tail, 1 + (!folio_test_anon(folio) ||
> -					  folio_test_swapcache(folio)));
> +	page_ref_unfreeze(page_tail,
> +		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
> +			     folio_nr_pages(new_folio) : 0));
>  
>  	if (folio_test_young(folio))
>  		folio_set_young(new_folio);
> @@ -2882,7 +2887,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
>  }
>  
>  static void __split_huge_page(struct page *page, struct list_head *list,
> -		pgoff_t end)
> +		pgoff_t end, unsigned int new_order)
>  {
>  	struct folio *folio = page_folio(page);
>  	struct page *head = &folio->page;
> @@ -2890,11 +2895,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	struct address_space *swap_cache = NULL;
>  	unsigned long offset = 0;
>  	int i, nr_dropped = 0;
> +	unsigned int new_nr = 1 << new_order;
>  	int order = folio_order(folio);
>  	unsigned int nr = 1 << order;
>  
>  	/* complete memcg works before add pages to LRU */
> -	split_page_memcg(head, order, 0);
> +	split_page_memcg(head, order, new_order);
>  
>  	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>  		offset = swp_offset(folio->swap);
> @@ -2907,8 +2913,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  
>  	ClearPageHasHWPoisoned(head);
>  
> -	for (i = nr - 1; i >= 1; i--) {
> -		__split_huge_page_tail(folio, i, lruvec, list);
> +	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
> +		__split_huge_page_tail(folio, i, lruvec, list, new_order);
>  		/* Some pages can be beyond EOF: drop them from page cache */
>  		if (head[i].index >= end) {
>  			struct folio *tail = page_folio(head + i);
> @@ -2929,24 +2935,30 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		}
>  	}
>  
> -	ClearPageCompound(head);
> +	if (!new_order)
> +		ClearPageCompound(head);
> +	else {
> +		struct folio *new_folio = (struct folio *)head;
> +
> +		folio_set_order(new_folio, new_order);
> +	}
>  	unlock_page_lruvec(lruvec);
>  	/* Caller disabled irqs, so they are still disabled here */
>  
> -	split_page_owner(head, order, 0);
> +	split_page_owner(head, order, new_order);
>  
>  	/* See comment in __split_huge_page_tail() */
>  	if (PageAnon(head)) {
>  		/* Additional pin to swap cache */
>  		if (PageSwapCache(head)) {
> -			page_ref_add(head, 2);
> +			page_ref_add(head, 1 + new_nr);
>  			xa_unlock(&swap_cache->i_pages);
>  		} else {
>  			page_ref_inc(head);
>  		}
>  	} else {
>  		/* Additional pin to page cache */
> -		page_ref_add(head, 2);
> +		page_ref_add(head, 1 + new_nr);
>  		xa_unlock(&head->mapping->i_pages);
>  	}
>  	local_irq_enable();
> @@ -2958,7 +2970,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	if (folio_test_swapcache(folio))
>  		split_swap_cluster(folio->swap);
>  
> -	for (i = 0; i < nr; i++) {
> +	/*
> +	 * set page to its compound_head when split to non order-0 pages, so
> +	 * we can skip unlocking it below, since PG_locked is transferred to
> +	 * the compound_head of the page and the caller will unlock it.
> +	 */
> +	if (new_order)
> +		page = compound_head(page);
> +
> +	for (i = 0; i < nr; i += new_nr) {
>  		struct page *subpage = head + i;
>  		if (subpage == page)
>  			continue;
> @@ -2992,29 +3012,36 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
>  }
>  
>  /*
> - * This function splits huge page into normal pages. @page can point to any
> - * subpage of huge page to split. Split doesn't change the position of @page.
> + * This function splits huge page into pages in @new_order. @page can point to
> + * any subpage of huge page to split. Split doesn't change the position of
> + * @page.
> + *
> + * NOTE: order-1 anonymous folio is not supported because _deferred_list,
> + * which is used by partially mapped folios, is stored in subpage 2 and an
> + * order-1 folio only has subpage 0 and 1. File-backed order-1 folios are OK,
> + * since they do not use _deferred_list.
>   *
>   * Only caller must hold pin on the @page, otherwise split fails with -EBUSY.
>   * The huge page must be locked.
>   *
>   * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
>   *
> - * Both head page and tail pages will inherit mapping, flags, and so on from
> - * the hugepage.
> + * Pages in new_order will inherit mapping, flags, and so on from the hugepage.
>   *
> - * GUP pin and PG_locked transferred to @page. Rest subpages can be freed if
> - * they are not mapped.
> + * GUP pin and PG_locked transferred to @page or the compound page @page belongs
> + * to. Rest subpages can be freed if they are not mapped.
>   *
>   * Returns 0 if the hugepage is split successfully.
>   * Returns -EBUSY if the page is pinned or if anon_vma disappeared from under
>   * us.
>   */
> -int split_huge_page_to_list(struct page *page, struct list_head *list)
> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> +				     unsigned int new_order)
>  {
>  	struct folio *folio = page_folio(page);
>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> -	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> +	/* reset xarray order to new order after split */
> +	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
>  	int extra_pins, ret;
> @@ -3024,6 +3051,34 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>  
> +	/* Cannot split anonymous THP to order-1 */
> +	if (new_order == 1 && folio_test_anon(folio)) {
> +		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> +		return -EINVAL;
> +	}
> +
> +	if (new_order) {
> +		/* Only swapping a whole PMD-mapped folio is supported */
> +		if (folio_test_swapcache(folio)) {
> +			VM_WARN_ONCE(1,
> +				"Cannot split swap-cached folio to non-0 order");

My understanding may be wrong here, but can't the folio be moved to swapcache
asynchronously? How does the caller guarrantee that the folio is not in
swapcache and will not be moved between the call to
split_huge_page_to_list_to_order() and this test? If the caller can't prevent
it, then isn't it wrong to raise a warning here? Perhaps you just have to fail
to split?

I'm guessing this restriction is because swap only supports order-0 and
pmd-order folios currently? (And you only have split_swap_cluster() to downgrade
from pmd-order to order-0). Perhaps you need my series that allows swapping out
any order THP? Current version at [1] but I'm working on a new version.

[1] https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@arm.com/

Thanks,
Ryan


> +			return -EINVAL;
> +		}
> +		/* Split shmem folio to non-zero order not supported */
> +		if (shmem_mapping(folio->mapping)) {
> +			VM_WARN_ONCE(1,
> +				"Cannot split shmem folio to non-0 order");
> +			return -EINVAL;
> +		}
> +		/* No split if the file system does not support large folio */
> +		if (!mapping_large_folio_support(folio->mapping)) {
> +			VM_WARN_ONCE(1,
> +				"Cannot split file folio to non-0 order");
> +			return -EINVAL;
> +		}
> +	}
> +
> +
>  	is_hzp = is_huge_zero_page(&folio->page);
>  	if (is_hzp) {
>  		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");
> @@ -3120,14 +3175,21 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  		if (folio_order(folio) > 1 &&
>  		    !list_empty(&folio->_deferred_list)) {
>  			ds_queue->split_queue_len--;
> -			list_del(&folio->_deferred_list);
> +			/*
> +			 * Reinitialize page_deferred_list after removing the
> +			 * page from the split_queue, otherwise a subsequent
> +			 * split will see list corruption when checking the
> +			 * page_deferred_list.
> +			 */
> +			list_del_init(&folio->_deferred_list);
>  		}
>  		spin_unlock(&ds_queue->split_queue_lock);
>  		if (mapping) {
>  			int nr = folio_nr_pages(folio);
>  
>  			xas_split(&xas, folio, folio_order(folio));
> -			if (folio_test_pmd_mappable(folio)) {
> +			if (folio_test_pmd_mappable(folio) &&
> +			    new_order < HPAGE_PMD_ORDER) {
>  				if (folio_test_swapbacked(folio)) {
>  					__lruvec_stat_mod_folio(folio,
>  							NR_SHMEM_THPS, -nr);
> @@ -3139,7 +3201,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  			}
>  		}
>  
> -		__split_huge_page(page, list, end);
> +		__split_huge_page(page, list, end, new_order);
>  		ret = 0;
>  	} else {
>  		spin_unlock(&ds_queue->split_queue_lock);


