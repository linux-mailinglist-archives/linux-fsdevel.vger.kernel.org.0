Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608DD3CF825
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbhGTKCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236316AbhGTKBb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:01:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0181F6120A;
        Tue, 20 Jul 2021 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777725;
        bh=48p5SktWQnG4Xtm6YWB+LBfmo/67jqliAdjGDqH4Ew4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPiw7V4NmfeLFrjHoNxS+cw0ZoSb5Ezona/D1KGiT/kDV6Lw274XV6MF35mEWeWDu
         DVgCL6eb7Ck1j70i49ST2Vq4GGbABtdSwM55pIQh4XMS8NviEm7bvH5TvoynZD4xKl
         MFkI22bHRXCixDFQ1wiVLPvjvMCgH446yDpx96zq9tR0/kh+ZnWoCL1qjQqtOh73nJ
         XtWkKUiXvmhxkj/R22FUwG/QuxY+tFkz0MhPy0JR0Xua9ixXk4Z+DRZE6mWpo2rACO
         StjVREDhzIzoFDhf3LzLo5gzGUBpjfdqFOQi7YzVqlu2eb3WDfKXTmhXxTS2388oGG
         82zfW1L1sXNpg==
Date:   Tue, 20 Jul 2021 13:41:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 009/138] mm: Add folio_try_get_rcu()
Message-ID: <YPaod1Yt4B4MF1lk@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-10-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:55AM +0100, Matthew Wilcox (Oracle) wrote:
> This is the equivalent of page_cache_get_speculative().  Also add
> folio_ref_try_add_rcu (the equivalent of page_cache_add_speculative)
> and folio_get_unless_zero() (the equivalent of get_page_unless_zero()).
> 
> The new kernel-doc attempts to explain from the user's point of view
> when to use folio_try_get_rcu() and when to use folio_get_unless_zero(),
> because there seems to be some confusion currently between the users of
> page_cache_get_speculative() and get_page_unless_zero().
> 
> Reimplement page_cache_add_speculative() and page_cache_get_speculative()
> as wrappers around the folio equivalents, but leave get_page_unless_zero()
> alone for now.  This commit reduces text size by 3 bytes due to slightly
> different register allocation & instruction selections.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/page_ref.h | 66 +++++++++++++++++++++++++++++++
>  include/linux/pagemap.h  | 84 ++--------------------------------------
>  mm/filemap.c             | 20 ++++++++++
>  3 files changed, 90 insertions(+), 80 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 717d53c9ddf1..2e677e6ad09f 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -247,6 +247,72 @@ static inline bool folio_ref_add_unless(struct folio *folio, int nr, int u)
>  	return page_ref_add_unless(&folio->page, nr, u);
>  }
>  
> +/**
> + * folio_try_get - Attempt to increase the refcount on a folio.
> + * @folio: The folio.
> + *
> + * If you do not already have a reference to a folio, you can attempt to
> + * get one using this function.  It may fail if, for example, the folio
> + * has been freed since you found a pointer to it, or it is frozen for
> + * the purposes of splitting or migration.
> + *
> + * Return: True if the reference count was successfully incremented.
> + */
> +static inline bool folio_try_get(struct folio *folio)
> +{
> +	return folio_ref_add_unless(folio, 1, 0);
> +}
> +
> +static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
> +{
> +#ifdef CONFIG_TINY_RCU
> +	/*
> +	 * The caller guarantees the folio will not be freed from interrupt
> +	 * context, so (on !SMP) we only need preemption to be disabled
> +	 * and TINY_RCU does that for us.
> +	 */
> +# ifdef CONFIG_PREEMPT_COUNT
> +	VM_BUG_ON(!in_atomic() && !irqs_disabled());
> +# endif
> +	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
> +	folio_ref_add(folio, count);
> +#else
> +	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
> +		/* Either the folio has been freed, or will be freed. */
> +		return false;
> +	}
> +#endif
> +	return true;
> +}
> +
> +/**
> + * folio_try_get_rcu - Attempt to increase the refcount on a folio.
> + * @folio: The folio.
> + *
> + * This is a version of folio_try_get() optimised for non-SMP kernels.
> + * If you are still holding the rcu_read_lock() after looking up the
> + * page and know that the page cannot have its refcount decreased to
> + * zero in interrupt context, you can use this instead of folio_try_get().
> + *
> + * Example users include get_user_pages_fast() (as pages are not unmapped
> + * from interrupt context) and the page cache lookups (as pages are not
> + * truncated from interrupt context).  We also know that pages are not
> + * frozen in interrupt context for the purposes of splitting or migration.
> + *
> + * You can also use this function if you're holding a lock that prevents
> + * pages being frozen & removed; eg the i_pages lock for the page cache
> + * or the mmap_sem or page table lock for page tables.  In this case,
> + * it will always succeed, and you could have used a plain folio_get(),
> + * but it's sometimes more convenient to have a common function called
> + * from both locked and RCU-protected contexts.
> + *
> + * Return: True if the reference count was successfully incremented.
> + */
> +static inline bool folio_try_get_rcu(struct folio *folio)
> +{
> +	return folio_ref_try_add_rcu(folio, 1);
> +}
> +
>  static inline int page_ref_freeze(struct page *page, int count)
>  {
>  	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ed02aa522263..db1726b1bc1c 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -172,91 +172,15 @@ static inline struct address_space *page_mapping_file(struct page *page)
>  	return page_mapping(page);
>  }
>  
> -/*
> - * speculatively take a reference to a page.
> - * If the page is free (_refcount == 0), then _refcount is untouched, and 0
> - * is returned. Otherwise, _refcount is incremented by 1 and 1 is returned.
> - *
> - * This function must be called inside the same rcu_read_lock() section as has
> - * been used to lookup the page in the pagecache radix-tree (or page table):
> - * this allows allocators to use a synchronize_rcu() to stabilize _refcount.
> - *
> - * Unless an RCU grace period has passed, the count of all pages coming out
> - * of the allocator must be considered unstable. page_count may return higher
> - * than expected, and put_page must be able to do the right thing when the
> - * page has been finished with, no matter what it is subsequently allocated
> - * for (because put_page is what is used here to drop an invalid speculative
> - * reference).
> - *
> - * This is the interesting part of the lockless pagecache (and lockless
> - * get_user_pages) locking protocol, where the lookup-side (eg. find_get_page)
> - * has the following pattern:
> - * 1. find page in radix tree
> - * 2. conditionally increment refcount
> - * 3. check the page is still in pagecache (if no, goto 1)
> - *
> - * Remove-side that cares about stability of _refcount (eg. reclaim) has the
> - * following (with the i_pages lock held):
> - * A. atomically check refcount is correct and set it to 0 (atomic_cmpxchg)
> - * B. remove page from pagecache
> - * C. free the page
> - *
> - * There are 2 critical interleavings that matter:
> - * - 2 runs before A: in this case, A sees elevated refcount and bails out
> - * - A runs before 2: in this case, 2 sees zero refcount and retries;
> - *   subsequently, B will complete and 1 will find no page, causing the
> - *   lookup to return NULL.
> - *
> - * It is possible that between 1 and 2, the page is removed then the exact same
> - * page is inserted into the same position in pagecache. That's OK: the
> - * old find_get_page using a lock could equally have run before or after
> - * such a re-insertion, depending on order that locks are granted.
> - *
> - * Lookups racing against pagecache insertion isn't a big problem: either 1
> - * will find the page or it will not. Likewise, the old find_get_page could run
> - * either before the insertion or afterwards, depending on timing.
> - */
> -static inline int __page_cache_add_speculative(struct page *page, int count)
> +static inline bool page_cache_add_speculative(struct page *page, int count)
>  {
> -#ifdef CONFIG_TINY_RCU
> -# ifdef CONFIG_PREEMPT_COUNT
> -	VM_BUG_ON(!in_atomic() && !irqs_disabled());
> -# endif
> -	/*
> -	 * Preempt must be disabled here - we rely on rcu_read_lock doing
> -	 * this for us.
> -	 *
> -	 * Pagecache won't be truncated from interrupt context, so if we have
> -	 * found a page in the radix tree here, we have pinned its refcount by
> -	 * disabling preempt, and hence no need for the "speculative get" that
> -	 * SMP requires.
> -	 */
> -	VM_BUG_ON_PAGE(page_count(page) == 0, page);
> -	page_ref_add(page, count);
> -
> -#else
> -	if (unlikely(!page_ref_add_unless(page, count, 0))) {
> -		/*
> -		 * Either the page has been freed, or will be freed.
> -		 * In either case, retry here and the caller should
> -		 * do the right thing (see comments above).
> -		 */
> -		return 0;
> -	}
> -#endif
>  	VM_BUG_ON_PAGE(PageTail(page), page);
> -
> -	return 1;
> -}
> -
> -static inline int page_cache_get_speculative(struct page *page)
> -{
> -	return __page_cache_add_speculative(page, 1);
> +	return folio_ref_try_add_rcu((struct folio *)page, count);
>  }
>  
> -static inline int page_cache_add_speculative(struct page *page, int count)
> +static inline bool page_cache_get_speculative(struct page *page)
>  {
> -	return __page_cache_add_speculative(page, count);
> +	return page_cache_add_speculative(page, 1);
>  }
>  
>  /**
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d1458ecf2f51..634adeacc4c1 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1746,6 +1746,26 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(page_cache_prev_miss);
>  
> +/*
> + * Lockless page cache protocol:
> + * On the lookup side:
> + * 1. Load the folio from i_pages
> + * 2. Increment the refcount if it's not zero
> + * 3. If the folio is not found by xas_reload(), put the refcount and retry
> + *
> + * On the removal side:
> + * A. Freeze the page (by zeroing the refcount if nobody else has a reference)
> + * B. Remove the page from i_pages
> + * C. Return the page to the page allocator
> + *
> + * This means that any page may have its reference count temporarily
> + * increased by a speculative page cache (or fast GUP) lookup as it can
> + * be allocated by another user before the RCU grace period expires.
> + * Because the refcount temporarily acquired here may end up being the
> + * last refcount on the page, any page allocation must be freeable by
> + * put_folio().

    ^ folio_get()

> + */
> +
>  /*
>   * mapping_get_entry - Get a page cache entry.
>   * @mapping: the address_space to search
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
