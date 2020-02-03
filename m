Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67634150860
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 15:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgBCO3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 09:29:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:44822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgBCO3W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:29:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 81218AD11;
        Mon,  3 Feb 2020 14:29:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BAFC11E0D5D; Mon,  3 Feb 2020 15:29:15 +0100 (CET)
Date:   Mon, 3 Feb 2020 15:29:15 +0100
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
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 07/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200203142915.GE18591@quack2.suse.cz>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-8-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200201034029.4063170-8-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 31-01-20 19:40:24, John Hubbard wrote:
> Add tracking of pages that were pinned via FOLL_PIN. This tracking is
> implemented via overloading of page->_refcount: pins are added by
> adding GUP_PIN_COUNTING_BIAS (1024) to the refcount. This provides a
> fuzzy indication of pinning, and it can have false positives (and that's
> OK). Please see the pre-existing
> Documentation/core-api/pin_user_pages.rst for details.
> 
> As mentioned in pin_user_pages.rst, callers who effectively set FOLL_PIN
> (typically via pin_user_pages*()) are required to ultimately free such
> pages via unpin_user_page().
> 
> Please also note the limitation, discussed in pin_user_pages.rst under
> the "TODO: for 1GB and larger huge pages" section. (That limitation will
> be removed in a following patch.)
> 
> The effect of a FOLL_PIN flag is similar to that of FOLL_GET, and may be
> thought of as "FOLL_GET for DIO and/or RDMA use".
> 
> Pages that have been pinned via FOLL_PIN are identifiable via a
> new function call:
> 
>    bool page_maybe_dma_pinned(struct page *page);
> 
> What to do in response to encountering such a page, is left to later
> patchsets. There is discussion about this in [1], [2], [3], and [4].
> 
> This also changes a BUG_ON(), to a WARN_ON(), in follow_page_mask().
> 
> [1] Some slow progress on get_user_pages() (Apr 2, 2019):
>     https://lwn.net/Articles/784574/
> [2] DMA and get_user_pages() (LPC: Dec 12, 2018):
>     https://lwn.net/Articles/774411/
> [3] The trouble with get_user_pages() (Apr 30, 2018):
>     https://lwn.net/Articles/753027/
> [4] LWN kernel index: get_user_pages():
>     https://lwn.net/Kernel/Index/#Memory_management-get_user_pages
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/core-api/pin_user_pages.rst |   6 +-
>  include/linux/mm.h                        |  82 +++++--
>  mm/gup.c                                  | 254 +++++++++++++++++-----
>  mm/huge_memory.c                          |  29 ++-
>  mm/hugetlb.c                              |  38 ++--
>  5 files changed, 318 insertions(+), 91 deletions(-)
> 
> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
> index 1d490155ecd7..9829345428f8 100644
> --- a/Documentation/core-api/pin_user_pages.rst
> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -173,8 +173,8 @@ CASE 4: Pinning for struct page manipulation only
>  -------------------------------------------------
>  Here, normal GUP calls are sufficient, so neither flag needs to be set.
>  
> -page_dma_pinned(): the whole point of pinning
> -=============================================
> +page_maybe_dma_pinned(): the whole point of pinning
> +===================================================
>  
>  The whole point of marking pages as "DMA-pinned" or "gup-pinned" is to be able
>  to query, "is this page DMA-pinned?" That allows code such as page_mkclean()
> @@ -186,7 +186,7 @@ and debates (see the References at the end of this document). It's a TODO item
>  here: fill in the details once that's worked out. Meanwhile, it's safe to say
>  that having this available: ::
>  
> -        static inline bool page_dma_pinned(struct page *page)
> +        static inline bool page_maybe_dma_pinned(struct page *page)
>  
>  ...is a prerequisite to solving the long-running gup+DMA problem.
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 73a044ed6981..ca787c606f0e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1001,6 +1001,8 @@ static inline void get_page(struct page *page)
>  	page_ref_inc(page);
>  }
>  
> +bool __must_check try_grab_page(struct page *page, unsigned int flags);
> +
>  static inline __must_check bool try_get_page(struct page *page)
>  {
>  	page = compound_head(page);
> @@ -1029,29 +1031,79 @@ static inline void put_page(struct page *page)
>  		__put_page(page);
>  }
>  
> -/**
> - * unpin_user_page() - release a gup-pinned page
> - * @page:            pointer to page to be released
> +/*
> + * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overload
> + * the page's refcount so that two separate items are tracked: the original page
> + * reference count, and also a new count of how many pin_user_pages() calls were
> + * made against the page. ("gup-pinned" is another term for the latter).
> + *
> + * With this scheme, pin_user_pages() becomes special: such pages are marked as
> + * distinct from normal pages. As such, the unpin_user_page() call (and its
> + * variants) must be used in order to release gup-pinned pages.
> + *
> + * Choice of value:
> + *
> + * By making GUP_PIN_COUNTING_BIAS a power of two, debugging of page reference
> + * counts with respect to pin_user_pages() and unpin_user_page() becomes
> + * simpler, due to the fact that adding an even power of two to the page
> + * refcount has the effect of using only the upper N bits, for the code that
> + * counts up using the bias value. This means that the lower bits are left for
> + * the exclusive use of the original code that increments and decrements by one
> + * (or at least, by much smaller values than the bias value).
>   *
> - * Pages that were pinned via pin_user_pages*() must be released via either
> - * unpin_user_page(), or one of the unpin_user_pages*() routines. This is so
> - * that eventually such pages can be separately tracked and uniquely handled. In
> - * particular, interactions with RDMA and filesystems need special handling.
> + * Of course, once the lower bits overflow into the upper bits (and this is
> + * OK, because subtraction recovers the original values), then visual inspection
> + * no longer suffices to directly view the separate counts. However, for normal
> + * applications that don't have huge page reference counts, this won't be an
> + * issue.
>   *
> - * unpin_user_page() and put_page() are not interchangeable, despite this early
> - * implementation that makes them look the same. unpin_user_page() calls must
> - * be perfectly matched up with pin*() calls.
> + * Locking: the lockless algorithm described in page_cache_get_speculative()
> + * and page_cache_gup_pin_speculative() provides safe operation for
> + * get_user_pages and page_mkclean and other calls that race to set up page
> + * table entries.
>   */
> -static inline void unpin_user_page(struct page *page)
> -{
> -	put_page(page);
> -}
> +#define GUP_PIN_COUNTING_BIAS (1U << 10)
>  
> +void unpin_user_page(struct page *page);
>  void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>  				 bool make_dirty);
> -
>  void unpin_user_pages(struct page **pages, unsigned long npages);
>  
> +/**
> + * page_maybe_dma_pinned() - report if a page is pinned for DMA.
> + *
> + * This function checks if a page has been pinned via a call to
> + * pin_user_pages*().
> + *
> + * For non-huge pages, the return value is partially fuzzy: false is not fuzzy,
> + * because it means "definitely not pinned for DMA", but true means "probably
> + * pinned for DMA, but possibly a false positive due to having at least
> + * GUP_PIN_COUNTING_BIAS worth of normal page references".
> + *
> + * False positives are OK, because: a) it's unlikely for a page to get that many
> + * refcounts, and b) all the callers of this routine are expected to be able to
> + * deal gracefully with a false positive.
> + *
> + * For more information, please see Documentation/vm/pin_user_pages.rst.
> + *
> + * @page:	pointer to page to be queried.
> + * @Return:	True, if it is likely that the page has been "dma-pinned".
> + *		False, if the page is definitely not dma-pinned.
> + */
> +static inline bool page_maybe_dma_pinned(struct page *page)
> +{
> +	/*
> +	 * page_ref_count() is signed. If that refcount overflows, then
> +	 * page_ref_count() returns a negative value, and callers will avoid
> +	 * further incrementing the refcount.
> +	 *
> +	 * Here, for that overflow case, use the signed bit to count a little
> +	 * bit higher via unsigned math, and thus still get an accurate result.
> +	 */
> +	return ((unsigned int)page_ref_count(compound_head(page))) >=
> +		GUP_PIN_COUNTING_BIAS;
> +}
> +
>  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>  #define SECTION_IN_PAGE_FLAGS
>  #endif
> diff --git a/mm/gup.c b/mm/gup.c
> index e899d2e6398c..6e8b773c233a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -44,6 +44,135 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>  	return head;
>  }
>  
> +/*
> + * try_grab_compound_head() - attempt to elevate a page's refcount, by a
> + * flags-dependent amount.
> + *
> + * "grab" names in this file mean, "look at flags to decide whether to use
> + * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
> + *
> + * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
> + * same time. (That's true throughout the get_user_pages*() and
> + * pin_user_pages*() APIs.) Cases:
> + *
> + *    FOLL_GET: page's refcount will be incremented by 1.
> + *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
> + *
> + * Return: head page (with refcount appropriately incremented) for success, or
> + * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
> + * considered failure, and furthermore, a likely bug in the caller, so a warning
> + * is also emitted.
> + */
> +static __maybe_unused struct page *try_grab_compound_head(struct page *page,
> +							  int refs,
> +							  unsigned int flags)
> +{
> +	if (flags & FOLL_GET)
> +		return try_get_compound_head(page, refs);
> +	else if (flags & FOLL_PIN) {
> +		refs *= GUP_PIN_COUNTING_BIAS;
> +		return try_get_compound_head(page, refs);
> +	}
> +
> +	WARN_ON_ONCE(1);
> +	return NULL;
> +}
> +
> +/**
> + * try_grab_page() - elevate a page's refcount by a flag-dependent amount
> + *
> + * This might not do anything at all, depending on the flags argument.
> + *
> + * "grab" names in this file mean, "look at flags to decide whether to use
> + * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
> + *
> + * @page:    pointer to page to be grabbed
> + * @flags:   gup flags: these are the FOLL_* flag values.
> + *
> + * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
> + * time. Cases:
> + *
> + *    FOLL_GET: page's refcount will be incremented by 1.
> + *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
> + *
> + * Return: true for success, or if no action was required (if neither FOLL_PIN
> + * nor FOLL_GET was set, nothing is done). False for failure: FOLL_GET or
> + * FOLL_PIN was set, but the page could not be grabbed.
> + */
> +bool __must_check try_grab_page(struct page *page, unsigned int flags)
> +{
> +	WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == (FOLL_GET | FOLL_PIN));
> +
> +	if (flags & FOLL_GET)
> +		return try_get_page(page);
> +	else if (flags & FOLL_PIN) {
> +		page = compound_head(page);
> +
> +		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> +			return false;
> +
> +		page_ref_add(page, GUP_PIN_COUNTING_BIAS);
> +	}
> +
> +	return true;
> +}
> +
> +#ifdef CONFIG_DEV_PAGEMAP_OPS
> +static bool __unpin_devmap_managed_user_page(struct page *page)
> +{
> +	int count;
> +
> +	if (!page_is_devmap_managed(page))
> +		return false;
> +
> +	count = page_ref_sub_return(page, GUP_PIN_COUNTING_BIAS);
> +
> +	/*
> +	 * devmap page refcounts are 1-based, rather than 0-based: if
> +	 * refcount is 1, then the page is free and the refcount is
> +	 * stable because nobody holds a reference on the page.
> +	 */
> +	if (count == 1)
> +		free_devmap_managed_page(page);
> +	else if (!count)
> +		__put_page(page);
> +
> +	return true;
> +}
> +#else
> +static bool __unpin_devmap_managed_user_page(struct page *page)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_DEV_PAGEMAP_OPS */
> +
> +/**
> + * unpin_user_page() - release a dma-pinned page
> + * @page:            pointer to page to be released
> + *
> + * Pages that were pinned via pin_user_pages*() must be released via either
> + * unpin_user_page(), or one of the unpin_user_pages*() routines. This is so
> + * that such pages can be separately tracked and uniquely handled. In
> + * particular, interactions with RDMA and filesystems need special handling.
> + */
> +void unpin_user_page(struct page *page)
> +{
> +	page = compound_head(page);
> +
> +	/*
> +	 * For devmap managed pages we need to catch refcount transition from
> +	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
> +	 * page is free and we need to inform the device driver through
> +	 * callback. See include/linux/memremap.h and HMM for details.
> +	 */
> +	if (__unpin_devmap_managed_user_page(page))
> +		return;
> +
> +	if (page_ref_sub_and_test(page, GUP_PIN_COUNTING_BIAS))
> +		__put_page(page);
> +}
> +EXPORT_SYMBOL(unpin_user_page);
> +
>  /**
>   * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
>   * @pages:  array of pages to be maybe marked dirty, and definitely released.
> @@ -230,10 +359,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  	}
>  
>  	page = vm_normal_page(vma, address, pte);
> -	if (!page && pte_devmap(pte) && (flags & FOLL_GET)) {
> +	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
>  		/*
> -		 * Only return device mapping pages in the FOLL_GET case since
> -		 * they are only valid while holding the pgmap reference.
> +		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
> +		 * case since they are only valid while holding the pgmap
> +		 * reference.
>  		 */
>  		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
>  		if (*pgmap)
> @@ -271,11 +401,10 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		goto retry;
>  	}
>  
> -	if (flags & FOLL_GET) {
> -		if (unlikely(!try_get_page(page))) {
> -			page = ERR_PTR(-ENOMEM);
> -			goto out;
> -		}
> +	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
> +	if (unlikely(!try_grab_page(page, flags))) {
> +		page = ERR_PTR(-ENOMEM);
> +		goto out;
>  	}
>  	if (flags & FOLL_TOUCH) {
>  		if ((flags & FOLL_WRITE) &&
> @@ -537,7 +666,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>  	/* make this handle hugepd */
>  	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
>  	if (!IS_ERR(page)) {
> -		BUG_ON(flags & FOLL_GET);
> +		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
>  		return page;
>  	}
>  
> @@ -1675,6 +1804,15 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>  {
>  	return 0;
>  }
> +
> +static long __get_user_pages_remote(struct task_struct *tsk,
> +				    struct mm_struct *mm,
> +				    unsigned long start, unsigned long nr_pages,
> +				    unsigned int gup_flags, struct page **pages,
> +				    struct vm_area_struct **vmas, int *locked)
> +{
> +	return 0;
> +}
>  #endif /* !CONFIG_MMU */
>  
>  /*
> @@ -1877,7 +2015,10 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
>  		struct page *page = pages[--(*nr)];
>  
>  		ClearPageReferenced(page);
> -		put_page(page);
> +		if (flags & FOLL_PIN)
> +			unpin_user_page(page);
> +		else
> +			put_page(page);
>  	}
>  }
>  
> @@ -1919,7 +2060,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>  		page = pte_page(pte);
>  
> -		head = try_get_compound_head(page, 1);
> +		head = try_grab_compound_head(page, 1, flags);
>  		if (!head)
>  			goto pte_unmap;
>  
> @@ -1980,7 +2121,10 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  		}
>  		SetPageReferenced(page);
>  		pages[*nr] = page;
> -		get_page(page);
> +		if (unlikely(!try_grab_page(page, flags))) {
> +			undo_dev_pagemap(nr, nr_start, flags, pages);
> +			return 0;
> +		}
>  		(*nr)++;
>  		pfn++;
>  	} while (addr += PAGE_SIZE, addr != end);
> @@ -2056,6 +2200,9 @@ static int record_subpages(struct page *page, unsigned long addr,
>  
>  static void put_compound_head(struct page *page, int refs, unsigned int flags)
>  {
> +	if (flags & FOLL_PIN)
> +		refs *= GUP_PIN_COUNTING_BIAS;
> +
>  	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
>  	/*
>  	 * Calling put_page() for each ref is unnecessarily slow. Only the last
> @@ -2099,7 +2246,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(head, refs);
> +	head = try_grab_compound_head(head, refs, flags);
>  	if (!head)
>  		return 0;
>  
> @@ -2159,7 +2306,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pmd_page(orig), refs);
> +	head = try_grab_compound_head(pmd_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
> @@ -2193,7 +2340,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pud_page(orig), refs);
> +	head = try_grab_compound_head(pud_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
> @@ -2222,7 +2369,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pgd_page(orig), refs);
> +	head = try_grab_compound_head(pgd_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
> @@ -2505,11 +2652,11 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
>  
>  /**
>   * get_user_pages_fast() - pin user pages in memory
> - * @start:	starting user address
> - * @nr_pages:	number of pages from start to pin
> - * @gup_flags:	flags modifying pin behaviour
> - * @pages:	array that receives pointers to the pages pinned.
> - *		Should be at least nr_pages long.
> + * @start:      starting user address
> + * @nr_pages:   number of pages from start to pin
> + * @gup_flags:  flags modifying pin behaviour
> + * @pages:      array that receives pointers to the pages pinned.
> + *              Should be at least nr_pages long.
>   *
>   * Attempt to pin user pages in memory without taking mm->mmap_sem.
>   * If not successful, it will fall back to taking the lock and
> @@ -2543,9 +2690,12 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>  /**
>   * pin_user_pages_fast() - pin user pages in memory without taking locks
>   *
> - * For now, this is a placeholder function, until various call sites are
> - * converted to use the correct get_user_pages*() or pin_user_pages*() API. So,
> - * this is identical to get_user_pages_fast().
> + * Nearly the same as get_user_pages_fast(), except that FOLL_PIN is set. See
> + * get_user_pages_fast() for documentation on the function arguments, because
> + * the arguments here are identical.
> + *
> + * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> + * see Documentation/vm/pin_user_pages.rst for further details.
>   *
>   * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
>   * is NOT intended for Case 2 (RDMA: long-term pins).
> @@ -2553,21 +2703,24 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>  int pin_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages)
>  {
> -	/*
> -	 * This is a placeholder, until the pin functionality is activated.
> -	 * Until then, just behave like the corresponding get_user_pages*()
> -	 * routine.
> -	 */
> -	return get_user_pages_fast(start, nr_pages, gup_flags, pages);
> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> +		return -EINVAL;
> +
> +	gup_flags |= FOLL_PIN;
> +	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
>  }
>  EXPORT_SYMBOL_GPL(pin_user_pages_fast);
>  
>  /**
>   * pin_user_pages_remote() - pin pages of a remote process (task != current)
>   *
> - * For now, this is a placeholder function, until various call sites are
> - * converted to use the correct get_user_pages*() or pin_user_pages*() API. So,
> - * this is identical to get_user_pages_remote().
> + * Nearly the same as get_user_pages_remote(), except that FOLL_PIN is set. See
> + * get_user_pages_remote() for documentation on the function arguments, because
> + * the arguments here are identical.
> + *
> + * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> + * see Documentation/vm/pin_user_pages.rst for details.
>   *
>   * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
>   * is NOT intended for Case 2 (RDMA: long-term pins).
> @@ -2577,22 +2730,24 @@ long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>  			   unsigned int gup_flags, struct page **pages,
>  			   struct vm_area_struct **vmas, int *locked)
>  {
> -	/*
> -	 * This is a placeholder, until the pin functionality is activated.
> -	 * Until then, just behave like the corresponding get_user_pages*()
> -	 * routine.
> -	 */
> -	return get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags, pages,
> -				     vmas, locked);
> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> +		return -EINVAL;
> +
> +	gup_flags |= FOLL_PIN;
> +	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
> +				       pages, vmas, locked);
>  }
>  EXPORT_SYMBOL(pin_user_pages_remote);
>  
>  /**
>   * pin_user_pages() - pin user pages in memory for use by other devices
>   *
> - * For now, this is a placeholder function, until various call sites are
> - * converted to use the correct get_user_pages*() or pin_user_pages*() API. So,
> - * this is identical to get_user_pages().
> + * Nearly the same as get_user_pages(), except that FOLL_TOUCH is not set, and
> + * FOLL_PIN is set.
> + *
> + * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> + * see Documentation/vm/pin_user_pages.rst for details.
>   *
>   * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
>   * is NOT intended for Case 2 (RDMA: long-term pins).
> @@ -2601,11 +2756,12 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages,
>  		    struct vm_area_struct **vmas)
>  {
> -	/*
> -	 * This is a placeholder, until the pin functionality is activated.
> -	 * Until then, just behave like the corresponding get_user_pages*()
> -	 * routine.
> -	 */
> -	return get_user_pages(start, nr_pages, gup_flags, pages, vmas);
> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> +		return -EINVAL;
> +
> +	gup_flags |= FOLL_PIN;
> +	return __gup_longterm_locked(current, current->mm, start, nr_pages,
> +				     pages, vmas, gup_flags);
>  }
>  EXPORT_SYMBOL(pin_user_pages);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b08b199f9a11..580098e115bd 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -958,6 +958,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	 */
>  	WARN_ONCE(flags & FOLL_COW, "mm: In follow_devmap_pmd with FOLL_COW set");
>  
> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
> +			 (FOLL_PIN | FOLL_GET)))
> +		return NULL;
> +
>  	if (flags & FOLL_WRITE && !pmd_write(*pmd))
>  		return NULL;
>  
> @@ -973,7 +978,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	 * device mapped pages can only be returned if the
>  	 * caller will manage the page reference count.
>  	 */
> -	if (!(flags & FOLL_GET))
> +	if (!(flags & (FOLL_GET | FOLL_PIN)))
>  		return ERR_PTR(-EEXIST);
>  
>  	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
> @@ -981,7 +986,8 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	if (!*pgmap)
>  		return ERR_PTR(-EFAULT);
>  	page = pfn_to_page(pfn);
> -	get_page(page);
> +	if (!try_grab_page(page, flags))
> +		page = ERR_PTR(-ENOMEM);
>  
>  	return page;
>  }
> @@ -1101,6 +1107,11 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
>  	if (flags & FOLL_WRITE && !pud_write(*pud))
>  		return NULL;
>  
> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
> +			 (FOLL_PIN | FOLL_GET)))
> +		return NULL;
> +
>  	if (pud_present(*pud) && pud_devmap(*pud))
>  		/* pass */;
>  	else
> @@ -1112,8 +1123,10 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
>  	/*
>  	 * device mapped pages can only be returned if the
>  	 * caller will manage the page reference count.
> +	 *
> +	 * At least one of FOLL_GET | FOLL_PIN must be set, so assert that here:
>  	 */
> -	if (!(flags & FOLL_GET))
> +	if (!(flags & (FOLL_GET | FOLL_PIN)))
>  		return ERR_PTR(-EEXIST);
>  
>  	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
> @@ -1121,7 +1134,8 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
>  	if (!*pgmap)
>  		return ERR_PTR(-EFAULT);
>  	page = pfn_to_page(pfn);
> -	get_page(page);
> +	if (!try_grab_page(page, flags))
> +		page = ERR_PTR(-ENOMEM);
>  
>  	return page;
>  }
> @@ -1497,8 +1511,13 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  
>  	page = pmd_page(*pmd);
>  	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
> +
> +	if (!try_grab_page(page, flags))
> +		return ERR_PTR(-ENOMEM);
> +
>  	if (flags & FOLL_TOUCH)
>  		touch_pmd(vma, addr, pmd, flags);
> +
>  	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
>  		/*
>  		 * We don't mlock() pte-mapped THPs. This way we can avoid
> @@ -1535,8 +1554,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  skip_mlock:
>  	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
>  	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
> -	if (flags & FOLL_GET)
> -		get_page(page);
>  
>  out:
>  	return page;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dd8737a94bec..487e998fd38e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4375,19 +4375,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
>  		page = pte_page(huge_ptep_get(pte));
>  
> -		/*
> -		 * Instead of doing 'try_get_page()' below in the same_page
> -		 * loop, just check the count once here.
> -		 */
> -		if (unlikely(page_count(page) <= 0)) {
> -			if (pages) {
> -				spin_unlock(ptl);
> -				remainder = 0;
> -				err = -ENOMEM;
> -				break;
> -			}
> -		}
> -
>  		/*
>  		 * If subpage information not requested, update counters
>  		 * and skip the same_page loop below.
> @@ -4405,7 +4392,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  same_page:
>  		if (pages) {
>  			pages[i] = mem_map_offset(page, pfn_offset);
> -			get_page(pages[i]);
> +			if (!try_grab_page(pages[i], flags)) {
> +				spin_unlock(ptl);
> +				remainder = 0;
> +				err = -ENOMEM;
> +				WARN_ON_ONCE(1);
> +				break;
> +			}
>  		}
>  
>  		if (vmas)
> @@ -4965,6 +4958,12 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  	struct page *page = NULL;
>  	spinlock_t *ptl;
>  	pte_t pte;
> +
> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
> +			 (FOLL_PIN | FOLL_GET)))
> +		return NULL;
> +
>  retry:
>  	ptl = pmd_lockptr(mm, pmd);
>  	spin_lock(ptl);
> @@ -4977,8 +4976,11 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  	pte = huge_ptep_get((pte_t *)pmd);
>  	if (pte_present(pte)) {
>  		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
> -		if (flags & FOLL_GET)
> -			get_page(page);
> +		if (unlikely(!try_grab_page(page, flags))) {
> +			WARN_ON_ONCE(1);
> +			page = NULL;
> +			goto out;
> +		}
>  	} else {
>  		if (is_hugetlb_entry_migration(pte)) {
>  			spin_unlock(ptl);
> @@ -4999,7 +5001,7 @@ struct page * __weak
>  follow_huge_pud(struct mm_struct *mm, unsigned long address,
>  		pud_t *pud, int flags)
>  {
> -	if (flags & FOLL_GET)
> +	if (flags & (FOLL_GET | FOLL_PIN))
>  		return NULL;
>  
>  	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> @@ -5008,7 +5010,7 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
>  struct page * __weak
>  follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int flags)
>  {
> -	if (flags & FOLL_GET)
> +	if (flags & (FOLL_GET | FOLL_PIN))
>  		return NULL;
>  
>  	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> -- 
> 2.25.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
