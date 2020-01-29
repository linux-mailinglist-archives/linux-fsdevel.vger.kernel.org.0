Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202A314CBB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgA2Nvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 08:51:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38559 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgA2Nvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:51:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so11937718lfm.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 05:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lAFyaT8xBS4NOjrRZ7HQYXo6D1hJiqIBc7kvGta7AeQ=;
        b=Cad93VeNzVDWfQR97uHssKoBfNCfakU8nIlHn/QXsThIyzJvvNxpejkOfGnFfDsMZX
         O6Hnp5ffrsRWv1tArfmsQD8+atWFPmXGLyooqmQdW1gNBmon5Hs5YlBeiIGm0LJx7Yrb
         wrZ8qYDhGCi1ywb/Fbpx6gwPh6pbLnd6I9yFkbB0QO4Lp0LJExJlAk32WC7G5RntJ4hQ
         l2iGnPQXUWYUGg/7MFc/NIyqgQvzQ5KB0UrhN+ROAzFjQ8wBYWXwS0U7BeLC9XZATRGy
         CTCkRAxbciRfXY8qFjfzY8Umey8uWov61tlVwaN07A2vjI4F1g7TnciNunbhZ9qRJ9np
         y8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lAFyaT8xBS4NOjrRZ7HQYXo6D1hJiqIBc7kvGta7AeQ=;
        b=grJ9QUdLWgowgbN8iGY/eyQ8oqUNBeJlWWMwB6hneihCMfaQ5n7B1bdRpuprCcdWkM
         vaVcrJ6VNzHIRjDTW5l3qqoa1AaERJ4kwBbwZhPbcy/dSXu2kmO7ibfg1uKBrG3c7aev
         MBZwpbzEm5BigoBaDEYL1iTZvWeEIX4u0639hvD5vhwLoFt3UHD4HqvSagWbtpKY+Xc6
         Xe9AstxyqUs/Bz63ZwiRmYLewYaZA0oznFODhPSYy/c4N2tUfF0DLlhHakcjrf533nTc
         NeKhDJb0L0CBFHiyeSQHSRtzPQhn9Rt8R5BsTb9xy9IUGVBf3YKnn9KpqnJdK5ZB/FZk
         qJyA==
X-Gm-Message-State: APjAAAU4nlH8wgDyFbQjUHS/3h8s4b3/PPZRKYcN/O6jlO9a1X0Z6mHD
        Ur7vRDbBVvMHui2p87UWuDuMCg==
X-Google-Smtp-Source: APXvYqwr2NXUdaKVxASzysCtuI3nZxqKi3YgFv+4wzpL9t6YIjXdqRm2bu4/0eN+zo6eaIa41qyDng==
X-Received: by 2002:a05:6512:64:: with SMTP id i4mr5590642lfo.55.1580305906216;
        Wed, 29 Jan 2020 05:51:46 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g15sm992157ljk.8.2020.01.29.05.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 05:51:45 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1DAE8100AFE; Wed, 29 Jan 2020 16:51:53 +0300 (+03)
Date:   Wed, 29 Jan 2020 16:51:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 4/8] mm/gup: track FOLL_PIN pages
Message-ID: <20200129135153.knie7ptvsxcgube6@box>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200129032417.3085670-5-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 07:24:13PM -0800, John Hubbard wrote:
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
> Please also not the limitation, discussed in pin_user_pages.rst under

s/not/note/

> the "TODO: for 1GB and larger huge pages" section. (That limitation will
> be removed in a following patch.)
> 
> The effect of a FOLL_PIN flag is similar to that of FOLL_GET, and may be
> thought of as "FOLL_GET for DIO and/or RDMA use".
> 
> Pages that have been pinned via FOLL_PIN are identifiable via a
> new function call:
> 
>    bool page_dma_pinned(struct page *page);
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
> ---
>  include/linux/mm.h       |  83 +++++++++--
>  include/linux/page_ref.h |  10 ++
>  mm/gup.c                 | 293 +++++++++++++++++++++++++++++++--------
>  mm/huge_memory.c         |  29 +++-
>  mm/hugetlb.c             |  38 ++---
>  5 files changed, 354 insertions(+), 99 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 080f8ac8bfb7..c5d0f4a66788 100644
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
> @@ -1029,29 +1031,80 @@ static inline void put_page(struct page *page)
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
> + * page_dma_pinned() - report if a page is pinned for DMA.
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

I wounder if we should reverse the logic and name -- page_not_dma_pinned()
or something -- too emphasise that we can only know for sure when the page
is not pinned, but not necessary when it is.

> + *
> + * For more information, please see Documentation/vm/pin_user_pages.rst.
> + *
> + * @page:	pointer to page to be queried.
> + * @Return:	True, if it is likely that the page has been "dma-pinned".
> + *		False, if the page is definitely not dma-pinned.
> + */
> +static inline bool page_dma_pinned(struct page *page)
> +{
> +	/*
> +	 * page_ref_count() is signed. If that refcount overflows, then
> +	 * page_ref_count() returns a negative value, and callers will avoid
> +	 * further incrementing the refcount.
> +	 *
> +	 * Here, for that overflow case, use the signed bit to count a little
> +	 * bit higher via unsigned math, and thus still get an accurate result
> +	 * from page_dma_pinned().
> +	 */
> +	return ((unsigned int)page_ref_count(compound_head(page))) >=
> +		GUP_PIN_COUNTING_BIAS;

Do you expect it too be called on tail pages?

> +}
> +
>  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>  #define SECTION_IN_PAGE_FLAGS
>  #endif
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 14d14beb1f7f..b9cbe553d1e7 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -102,6 +102,16 @@ static inline void page_ref_sub(struct page *page, int nr)
>  		__page_ref_mod(page, -nr);
>  }
>  
> +static inline int page_ref_sub_return(struct page *page, int nr)
> +{
> +	int ret = atomic_sub_return(nr, &page->_refcount);
> +
> +	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
> +		__page_ref_mod(page, -nr);
> +
> +	return ret;
> +}
> +

I see opportunity to split the patch further.

>  static inline void page_ref_inc(struct page *page)
>  {
>  	atomic_inc(&page->_refcount);
> diff --git a/mm/gup.c b/mm/gup.c
> index 9e117998274c..7a96490dcc54 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -44,6 +44,136 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
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

Maybe overflow detection? At least under VM_BUG_ON()?

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
> +	if (flags & FOLL_GET)
> +		return try_get_page(page);
> +	else if (flags & FOLL_PIN) {
> +		page = compound_head(page);
> +
> +		if (WARN_ON_ONCE(flags & FOLL_GET))

This is always false -- you won't get to the branch if FOLL_GET is set.

Maybe

	WARN_ON_ONCE(flags & (FOLL_GET|FOLL_PIN) == FOLL_GET|FOLL_PIN);

at the start of the function?

> +			return false;
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
> @@ -230,10 +360,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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
> @@ -271,11 +402,10 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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
> @@ -537,7 +667,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>  	/* make this handle hugepd */
>  	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
>  	if (!IS_ERR(page)) {
> -		BUG_ON(flags & FOLL_GET);
> +		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
>  		return page;
>  	}
>  
> @@ -1675,6 +1805,15 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
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
> @@ -1870,13 +2009,17 @@ static inline pte_t gup_get_pte(pte_t *ptep)
>  #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
>  
>  static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
> +					    unsigned int flags,
>  					    struct page **pages)
>  {
>  	while ((*nr) - nr_start) {
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
> @@ -1909,7 +2052,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  
>  			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
>  			if (unlikely(!pgmap)) {
> -				undo_dev_pagemap(nr, nr_start, pages);
> +				undo_dev_pagemap(nr, nr_start, flags, pages);
>  				goto pte_unmap;
>  			}
>  		} else if (pte_special(pte))
> @@ -1918,7 +2061,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>  		page = pte_page(pte);
>  
> -		head = try_get_compound_head(page, 1);
> +		head = try_grab_compound_head(page, 1, flags);
>  		if (!head)
>  			goto pte_unmap;
>  
> @@ -1974,12 +2117,15 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  
>  		pgmap = get_dev_pagemap(pfn, pgmap);
>  		if (unlikely(!pgmap)) {
> -			undo_dev_pagemap(nr, nr_start, pages);
> +			undo_dev_pagemap(nr, nr_start, flags, pages);
>  			return 0;
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
> @@ -2001,7 +2147,7 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		return 0;
>  
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> -		undo_dev_pagemap(nr, nr_start, pages);
> +		undo_dev_pagemap(nr, nr_start, flags, pages);
>  		return 0;
>  	}
>  	return 1;
> @@ -2019,7 +2165,7 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		return 0;
>  
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
> -		undo_dev_pagemap(nr, nr_start, pages);
> +		undo_dev_pagemap(nr, nr_start, flags, pages);
>  		return 0;
>  	}
>  	return 1;
> @@ -2053,8 +2199,11 @@ static int record_subpages(struct page *page, unsigned long addr,
>  	return nr;
>  }
>  
> -static void put_compound_head(struct page *page, int refs)
> +static void put_compound_head(struct page *page, int refs, unsigned int flags)
>  {
> +	if (flags & FOLL_PIN)
> +		refs *= GUP_PIN_COUNTING_BIAS;
> +
>  	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
>  	/*
>  	 * Calling put_page() for each ref is unnecessarily slow. Only the last
> @@ -2098,12 +2247,12 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(head, refs);
> +	head = try_grab_compound_head(head, refs, flags);
>  	if (!head)
>  		return 0;
>  
>  	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> -		put_compound_head(head, refs);
> +		put_compound_head(head, refs, flags);
>  		return 0;
>  	}
>  
> @@ -2158,12 +2307,12 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pmd_page(orig), refs);
> +	head = try_grab_compound_head(pmd_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> -		put_compound_head(head, refs);
> +		put_compound_head(head, refs, flags);
>  		return 0;
>  	}
>  
> @@ -2192,12 +2341,12 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pud_page(orig), refs);
> +	head = try_grab_compound_head(pud_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
> -		put_compound_head(head, refs);
> +		put_compound_head(head, refs, flags);
>  		return 0;
>  	}
>  
> @@ -2221,12 +2370,12 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pgd_page(orig), refs);
> +	head = try_grab_compound_head(pgd_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
>  	if (unlikely(pgd_val(orig) != pgd_val(*pgdp))) {
> -		put_compound_head(head, refs);
> +		put_compound_head(head, refs, flags);
>  		return 0;
>  	}
>  
> @@ -2389,6 +2538,14 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long len, end;
>  	unsigned long flags;
>  	int nr = 0;
> +	/*
> +	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
> +	 * because gup fast is always a "pin with a +1 page refcount" request.
> +	 */
> +	unsigned int gup_flags = FOLL_GET;
> +
> +	if (write)
> +		gup_flags |= FOLL_WRITE;
>  
>  	start = untagged_addr(start) & PAGE_MASK;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
> @@ -2414,7 +2571,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
>  	    gup_fast_permitted(start, end)) {
>  		local_irq_save(flags);
> -		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
> +		gup_pgd_range(start, end, gup_flags, pages, &nr);
>  		local_irq_restore(flags);
>  	}
>  
> @@ -2453,7 +2610,7 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
>  	int nr = 0, ret = 0;
>  
>  	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
> -				       FOLL_FORCE | FOLL_PIN)))
> +				       FOLL_FORCE | FOLL_PIN | FOLL_GET)))
>  		return -EINVAL;
>  
>  	start = untagged_addr(start) & PAGE_MASK;
> @@ -2496,11 +2653,11 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
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
> @@ -2520,6 +2677,13 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
>  		return -EINVAL;
>  
> +	/*
> +	 * The caller may or may not have explicitly set FOLL_GET; either way is
> +	 * OK. However, internally (within mm/gup.c), gup fast variants must set
> +	 * FOLL_GET, because gup fast is always a "pin with a +1 page refcount"
> +	 * request.
> +	 */
> +	gup_flags |= FOLL_GET;
>  	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
>  }
>  EXPORT_SYMBOL_GPL(get_user_pages_fast);
> @@ -2527,9 +2691,12 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
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
> @@ -2537,21 +2704,24 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
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
> @@ -2561,22 +2731,24 @@ long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
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
> @@ -2585,11 +2757,12 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
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
> index 0a55dec68925..b1079aaa6f24 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -958,6 +958,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	 */
>  	WARN_ONCE(flags & FOLL_COW, "mm: In follow_devmap_pmd with FOLL_COW set");
>  
> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
> +			 (FOLL_PIN | FOLL_GET)))

Too many parentheses.

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

Ditto.

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

Ditto.

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
 Kirill A. Shutemov
