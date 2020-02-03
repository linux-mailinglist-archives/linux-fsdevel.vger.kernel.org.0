Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6069B15089D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 15:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgBCOn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 09:43:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:53498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbgBCOn3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:43:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C534DAE61;
        Mon,  3 Feb 2020 14:43:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7F69D1E0D5D; Mon,  3 Feb 2020 15:43:24 +0100 (CET)
Date:   Mon, 3 Feb 2020 15:43:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/12] mm/gup: page->hpage_pinned_refcount: exact pin
 counts for huge pages
Message-ID: <20200203144324.GF18591@quack2.suse.cz>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-9-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-9-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 31-01-20 19:40:25, John Hubbard wrote:
> For huge pages (and in fact, any compound page), the
> GUP_PIN_COUNTING_BIAS scheme tends to overflow too easily, each tail
> page increments the head page->_refcount by GUP_PIN_COUNTING_BIAS
> (1024). That limits the number of huge pages that can be pinned.
> 
> This patch removes that limitation, by using an exact form of pin
> counting for compound pages of order > 1. The "order > 1" is required
> because this approach uses the 3rd struct page in the compound page, and
> order 1 compound pages only have two pages, so that won't work there.
> 
> A new struct page field, hpage_pinned_refcount, has been added,
> replacing a padding field in the union (so no new space is used).
> 
> This enhancement also has a useful side effect: huge pages and compound
> pages (of order > 1) do not suffer from the "potential false positives"
> problem that is discussed in the page_dma_pinned() comment block. That
> is because these compound pages have extra space for tracking things, so
> they get exact pin counts instead of overloading page->_refcount.
> 
> Documentation/core-api/pin_user_pages.rst is updated accordingly.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/core-api/pin_user_pages.rst | 40 +++++-------
>  include/linux/mm.h                        | 26 ++++++++
>  include/linux/mm_types.h                  |  7 +-
>  mm/gup.c                                  | 78 ++++++++++++++++++++---
>  mm/hugetlb.c                              |  6 ++
>  mm/page_alloc.c                           |  2 +
>  mm/rmap.c                                 |  6 ++
>  7 files changed, 133 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
> index 9829345428f8..3f72b1ea1104 100644
> --- a/Documentation/core-api/pin_user_pages.rst
> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -52,8 +52,22 @@ Which flags are set by each wrapper
>  
>  For these pin_user_pages*() functions, FOLL_PIN is OR'd in with whatever gup
>  flags the caller provides. The caller is required to pass in a non-null struct
> -pages* array, and the function then pin pages by incrementing each by a special
> -value. For now, that value is +1, just like get_user_pages*().::
> +pages* array, and the function then pins pages by incrementing each by a special
> +value: GUP_PIN_COUNTING_BIAS.
> +
> +For huge pages (and in fact, any compound page of more than 2 pages), the
> +GUP_PIN_COUNTING_BIAS scheme is not used. Instead, an exact form of pin counting
> +is achieved, by using the 3rd struct page in the compound page. A new struct
> +page field, hpage_pinned_refcount, has been added in order to support this.
> +
> +This approach for compound pages avoids the counting upper limit problems that
> +are discussed below. Those limitations would have been aggravated severely by
> +huge pages, because each tail page adds a refcount to the head page. And in
> +fact, testing revealed that, without a separate hpage_pinned_refcount field,
> +page overflows were seen in some huge page stress tests.
> +
> +This also means that huge pages and compound pages (of order > 1) do not suffer
> +from the false positives problem that is mentioned below.::
>  
>   Function
>   --------
> @@ -99,27 +113,6 @@ pages:
>  This also leads to limitations: there are only 31-10==21 bits available for a
>  counter that increments 10 bits at a time.
>  
> -TODO: for 1GB and larger huge pages, this is cutting it close. That's because
> -when pin_user_pages() follows such pages, it increments the head page by "1"
> -(where "1" used to mean "+1" for get_user_pages(), but now means "+1024" for
> -pin_user_pages()) for each tail page. So if you have a 1GB huge page:
> -
> -* There are 256K (18 bits) worth of 4 KB tail pages.
> -* There are 21 bits available to count up via GUP_PIN_COUNTING_BIAS (that is,
> -  10 bits at a time)
> -* There are 21 - 18 == 3 bits available to count. Except that there aren't,
> -  because you need to allow for a few normal get_page() calls on the head page,
> -  as well. Fortunately, the approach of using addition, rather than "hard"
> -  bitfields, within page->_refcount, allows for sharing these bits gracefully.
> -  But we're still looking at about 8 references.
> -
> -This, however, is a missing feature more than anything else, because it's easily
> -solved by addressing an obvious inefficiency in the original get_user_pages()
> -approach of retrieving pages: stop treating all the pages as if they were
> -PAGE_SIZE. Retrieve huge pages as huge pages. The callers need to be aware of
> -this, so some work is required. Once that's in place, this limitation mostly
> -disappears from view, because there will be ample refcounting range available.
> -
>  * Callers must specifically request "dma-pinned tracking of pages". In other
>    words, just calling get_user_pages() will not suffice; a new set of functions,
>    pin_user_page() and related, must be used.
> @@ -228,5 +221,6 @@ References
>  * `Some slow progress on get_user_pages() (Apr 2, 2019) <https://lwn.net/Articles/784574/>`_
>  * `DMA and get_user_pages() (LPC: Dec 12, 2018) <https://lwn.net/Articles/774411/>`_
>  * `The trouble with get_user_pages() (Apr 30, 2018) <https://lwn.net/Articles/753027/>`_
> +* `LWN kernel index: get_user_pages() <https://lwn.net/Kernel/Index/#Memory_management-get_user_pages>`
>  
>  John Hubbard, October, 2019
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ca787c606f0e..fdcd137b9981 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -770,6 +770,24 @@ static inline unsigned int compound_order(struct page *page)
>  	return page[1].compound_order;
>  }
>  
> +static inline bool hpage_pincount_available(struct page *page)
> +{
> +	/*
> +	 * Can the page->hpage_pinned_refcount field be used? That field is in
> +	 * the 3rd page of the compound page, so the smallest (2-page) compound
> +	 * pages cannot support it.
> +	 */
> +	page = compound_head(page);
> +	return PageCompound(page) && compound_order(page) > 1;
> +}
> +
> +static inline int compound_pincount(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
> +	page = compound_head(page);
> +	return atomic_read(compound_pincount_ptr(page));
> +}
> +
>  static inline void set_compound_order(struct page *page, unsigned int order)
>  {
>  	page[1].compound_order = order;
> @@ -1084,6 +1102,11 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
>   * refcounts, and b) all the callers of this routine are expected to be able to
>   * deal gracefully with a false positive.
>   *
> + * For huge pages, the result will be exactly correct. That's because we have
> + * more tracking data available: the 3rd struct page in the compound page is
> + * used to track the pincount (instead using of the GUP_PIN_COUNTING_BIAS
> + * scheme).
> + *
>   * For more information, please see Documentation/vm/pin_user_pages.rst.
>   *
>   * @page:	pointer to page to be queried.
> @@ -1092,6 +1115,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
>   */
>  static inline bool page_maybe_dma_pinned(struct page *page)
>  {
> +	if (hpage_pincount_available(page))
> +		return compound_pincount(page) > 0;
> +
>  	/*
>  	 * page_ref_count() is signed. If that refcount overflows, then
>  	 * page_ref_count() returns a negative value, and callers will avoid
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e87bb864bdb2..01e9717b8529 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -137,7 +137,7 @@ struct page {
>  		};
>  		struct {	/* Second tail page of compound page */
>  			unsigned long _compound_pad_1;	/* compound_head */
> -			unsigned long _compound_pad_2;
> +			atomic_t hpage_pinned_refcount;
>  			/* For both global and memcg */
>  			struct list_head deferred_list;
>  		};
> @@ -226,6 +226,11 @@ static inline atomic_t *compound_mapcount_ptr(struct page *page)
>  	return &page[1].compound_mapcount;
>  }
>  
> +static inline atomic_t *compound_pincount_ptr(struct page *page)
> +{
> +	return &page[2].hpage_pinned_refcount;
> +}
> +
>  /*
>   * Used for sizing the vmemmap region on some architectures
>   */
> diff --git a/mm/gup.c b/mm/gup.c
> index 6e8b773c233a..c10d0d051c5b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -29,6 +29,22 @@ struct follow_page_context {
>  	unsigned int page_mask;
>  };
>  
> +static void hpage_pincount_add(struct page *page, int refs)
> +{
> +	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
> +	VM_BUG_ON_PAGE(page != compound_head(page), page);
> +
> +	atomic_add(refs, compound_pincount_ptr(page));
> +}
> +
> +static void hpage_pincount_sub(struct page *page, int refs)
> +{
> +	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
> +	VM_BUG_ON_PAGE(page != compound_head(page), page);
> +
> +	atomic_sub(refs, compound_pincount_ptr(page));
> +}
> +
>  /*
>   * Return the compound head page with ref appropriately incremented,
>   * or NULL if that failed.
> @@ -70,8 +86,25 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
>  	if (flags & FOLL_GET)
>  		return try_get_compound_head(page, refs);
>  	else if (flags & FOLL_PIN) {
> -		refs *= GUP_PIN_COUNTING_BIAS;
> -		return try_get_compound_head(page, refs);
> +		/*
> +		 * When pinning a compound page of order > 1 (which is what
> +		 * hpage_pincount_available() checks for), use an exact count to
> +		 * track it, via hpage_pincount_add/_sub().
> +		 *
> +		 * However, be sure to *also* increment the normal page refcount
> +		 * field at least once, so that the page really is pinned.
> +		 */
> +		if (!hpage_pincount_available(page))
> +			refs *= GUP_PIN_COUNTING_BIAS;
> +
> +		page = try_get_compound_head(page, refs);
> +		if (!page)
> +			return NULL;
> +
> +		if (hpage_pincount_available(page))
> +			hpage_pincount_add(page, refs);
> +
> +		return page;
>  	}
>  
>  	WARN_ON_ONCE(1);
> @@ -106,12 +139,25 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>  	if (flags & FOLL_GET)
>  		return try_get_page(page);
>  	else if (flags & FOLL_PIN) {
> +		int refs = 1;
> +
>  		page = compound_head(page);
>  
>  		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>  			return false;
>  
> -		page_ref_add(page, GUP_PIN_COUNTING_BIAS);
> +		if (hpage_pincount_available(page))
> +			hpage_pincount_add(page, 1);
> +		else
> +			refs = GUP_PIN_COUNTING_BIAS;
> +
> +		/*
> +		 * Similar to try_grab_compound_head(): even if using the
> +		 * hpage_pincount_add/_sub() routines, be sure to
> +		 * *also* increment the normal page refcount field at least
> +		 * once, so that the page really is pinned.
> +		 */
> +		page_ref_add(page, refs);
>  	}
>  
>  	return true;
> @@ -120,12 +166,17 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>  #ifdef CONFIG_DEV_PAGEMAP_OPS
>  static bool __unpin_devmap_managed_user_page(struct page *page)
>  {
> -	int count;
> +	int count, refs = 1;
>  
>  	if (!page_is_devmap_managed(page))
>  		return false;
>  
> -	count = page_ref_sub_return(page, GUP_PIN_COUNTING_BIAS);
> +	if (hpage_pincount_available(page))
> +		hpage_pincount_sub(page, 1);
> +	else
> +		refs = GUP_PIN_COUNTING_BIAS;
> +
> +	count = page_ref_sub_return(page, refs);
>  
>  	/*
>  	 * devmap page refcounts are 1-based, rather than 0-based: if
> @@ -157,6 +208,8 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
>   */
>  void unpin_user_page(struct page *page)
>  {
> +	int refs = 1;
> +
>  	page = compound_head(page);
>  
>  	/*
> @@ -168,7 +221,12 @@ void unpin_user_page(struct page *page)
>  	if (__unpin_devmap_managed_user_page(page))
>  		return;
>  
> -	if (page_ref_sub_and_test(page, GUP_PIN_COUNTING_BIAS))
> +	if (hpage_pincount_available(page))
> +		hpage_pincount_sub(page, 1);
> +	else
> +		refs = GUP_PIN_COUNTING_BIAS;
> +
> +	if (page_ref_sub_and_test(page, refs))
>  		__put_page(page);
>  }
>  EXPORT_SYMBOL(unpin_user_page);
> @@ -2200,8 +2258,12 @@ static int record_subpages(struct page *page, unsigned long addr,
>  
>  static void put_compound_head(struct page *page, int refs, unsigned int flags)
>  {
> -	if (flags & FOLL_PIN)
> -		refs *= GUP_PIN_COUNTING_BIAS;
> +	if (flags & FOLL_PIN) {
> +		if (hpage_pincount_available(page))
> +			hpage_pincount_sub(page, refs);
> +		else
> +			refs *= GUP_PIN_COUNTING_BIAS;
> +	}
>  
>  	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
>  	/*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 487e998fd38e..07059d936f7b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1009,6 +1009,9 @@ static void destroy_compound_gigantic_page(struct page *page,
>  	struct page *p = page + 1;
>  
>  	atomic_set(compound_mapcount_ptr(page), 0);
> +	if (hpage_pincount_available(page))
> +		atomic_set(compound_pincount_ptr(page), 0);
> +
>  	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>  		clear_compound_head(p);
>  		set_page_refcounted(p);
> @@ -1287,6 +1290,9 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
>  		set_compound_head(p, page);
>  	}
>  	atomic_set(compound_mapcount_ptr(page), -1);
> +
> +	if (hpage_pincount_available(page))
> +		atomic_set(compound_pincount_ptr(page), 0);
>  }
>  
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 15e908ad933b..c205b912f108 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -689,6 +689,8 @@ void prep_compound_page(struct page *page, unsigned int order)
>  		set_compound_head(p, page);
>  	}
>  	atomic_set(compound_mapcount_ptr(page), -1);
> +	if (hpage_pincount_available(page))
> +		atomic_set(compound_pincount_ptr(page), 0);
>  }
>  
>  #ifdef CONFIG_DEBUG_PAGEALLOC
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b3e381919835..e45b9b991e2f 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1178,6 +1178,9 @@ void page_add_new_anon_rmap(struct page *page,
>  		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
>  		/* increment count (starts at -1) */
>  		atomic_set(compound_mapcount_ptr(page), 0);
> +		if (hpage_pincount_available(page))
> +			atomic_set(compound_pincount_ptr(page), 0);
> +
>  		__inc_node_page_state(page, NR_ANON_THPS);
>  	} else {
>  		/* Anon THP always mapped first with PMD */
> @@ -1974,6 +1977,9 @@ void hugepage_add_new_anon_rmap(struct page *page,
>  {
>  	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
>  	atomic_set(compound_mapcount_ptr(page), 0);
> +	if (hpage_pincount_available(page))
> +		atomic_set(compound_pincount_ptr(page), 0);
> +
>  	__page_set_anon_rmap(page, vma, address, 1);
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */
> -- 
> 2.25.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
