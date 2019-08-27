Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE359F479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 22:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfH0UtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 16:49:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfH0UtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IgMURQLJu7u0D0Wqt1eXz6G6I/vTlCovbHV7cqJoV78=; b=GSibIXII1l81fPzayYuzE+PlU
        Ld1X6hx9DocAap0TGmmRFx/YMj33gACLwKcF6K6a/QFq1ATuoFyey+RmUtD5cFtGcSTzA/PQWjDP1
        qJHMA6CcooraHhab5WZzbBwZeDCpKiYI1YDvF+Pn05PqDTBzUTLA8gvcsxtD13WagKhxeqpXM2pPk
        qq9QCafRP04v1oqhnbejwuopbHaLVLiqTWt5DiKXNpgABl8gshgw5UYxXI1paU4cZYCGxgCUx1msg
        Y0pZf8tOBmwABuy0BQGOqNagt9qv+AXX262Iw6PdQaQherWHx/3RQPGFGRZLGAgGpt5nFT+iGOiR+
        4rk4ZgCLw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2iOj-0006XQ-BI; Tue, 27 Aug 2019 20:49:01 +0000
Date:   Tue, 27 Aug 2019 13:49:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH v4 2/2] mm,thp: Add experimental config option
 RO_EXEC_FILEMAP_HUGE_FAULT_THP
Message-ID: <20190827204901.GA6590@bombadil.infradead.org>
References: <20190815054412.26713-1-william.kucharski@oracle.com>
 <20190815054412.26713-3-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815054412.26713-3-william.kucharski@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 11:44:12PM -0600, William Kucharski wrote:
> @@ -1663,7 +1662,8 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>  no_page:
>  	if (!page && (fgp_flags & FGP_CREAT)) {
>  		int err;
> -		if ((fgp_flags & FGP_WRITE) && mapping_cap_account_dirty(mapping))
> +		if ((fgp_flags & FGP_WRITE) &&
> +			mapping_cap_account_dirty(mapping))

This change seems extraneous?

> +#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> +/*
> + * Check for an entry in the page cache which would conflict with the address
> + * range we wish to map using a THP or is otherwise unusable to map a large
> + * cached page.
> + *
> + * The routine will return true if a usable page is found in the page cache
> + * (and *pagep will be set to the address of the cached page), or if no
> + * cached page is found (and *pagep will be set to NULL).
> + */
> +static bool
> +filemap_huge_check_pagecache_usable(struct xa_state *xas,
> +	struct page **pagep, pgoff_t hindex, pgoff_t hindex_max)
> +{
> +	struct page *page;
> +
> +	while (1) {
> +		page = xas_find(xas, hindex_max);
> +
> +		if (xas_retry(xas, page)) {
> +			xas_set(xas, hindex);
> +			continue;
> +		}
> +
> +		/*
> +		 * A found entry is unusable if:
> +		 *	+ the entry is an Xarray value, not a pointer
> +		 *	+ the entry is an internal Xarray node
> +		 *	+ the entry is not a Transparent Huge Page
> +		 *	+ the entry is not a compound page
> +		 *	+ the entry is not the head of a compound page
> +		 *	+ the entry is a page page with an order other than

double word?  I might drop this comment altogether; it's describing what
the next few lines of code do, rather than why they do it.

> +		 *	  HPAGE_PMD_ORDER
> +		 *	+ the page's index is not what we expect it to be
> +		 *	+ the page is not up-to-date
> +		 */
> +		if (!page)
> +			break;
> +
> +		if (xa_is_value(page) || xa_is_internal(page))
> +			return false;
> +
> +		VM_BUG_ON_PAGE(PageHuge(page), page);

I thought we were going to drop this test because hugetlbfs was never
going to call this function?

> +		if ((!PageCompound(page)) || (page != compound_head(page)))
> +			return false;

We're only storing head pages in the page cache, so page != compound_page
shouldn't be possible ...

> +		VM_BUG_ON_PAGE(compound_order(page) != HPAGE_PMD_ORDER, page);

I'd like to see the page cache supporting orders other than 0 and 9,
so consider the case where we see an order-10 page or an order-8 page --
the first should be OK, the second should return false.  So I'd combine
the previous check with this one and do:

		if (compound_order(page) < HPAGE_PMD_ORDER)
			return false;

> +		if (page->index != hindex || !PageUptodate(page))
> +			return false;

It's OK if the page isn't uptodate here.  We'll wait for it to become
unlocked in the caller, and then it will either be uptodate, or it'll
be in an error state.

> +	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> +	pgoff_t hindex = round_down(vmf->pgoff, HPAGE_PMD_NR);
> +	pgoff_t hindex_max = hindex + HPAGE_PMD_NR;

I believe this is 1 too high.  The XArray code works on inclusive 'max'.

> +	struct page *cached_page, *hugepage;
> +	struct page *new_page = NULL;
> +
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
> +	unsigned long nr;
> +
> +	int error;
> +
> +	XA_STATE_ORDER(xas, &mapping->i_pages, hindex, HPAGE_PMD_ORDER);
> +
> +	/*
> +	 * Return VM_FAULT_FALLBACK if:
> +	 *
> +	 *	+ pe_size != PE_SIZE_PMD
> +	 *	+ FAULT_FLAG_WRITE is set in vmf->flags
> +	 *	+ vma isn't aligned to allow a PMD mapping
> +	 *	+ PMD would extend beyond the end of the vma
> +	 */
> +	if (pe_size != PE_SIZE_PMD || (vmf->flags & FAULT_FLAG_WRITE) ||
> +		(haddr < vma->vm_start ||
> +		(haddr + HPAGE_PMD_SIZE > vma->vm_end)))
> +		return ret;

A general point on indentation ... we tend to prefer not using one tab
to indent subsequent lines of the conditional because there's no visual
distinction between the continued condition and the statement inside
the conditional.  So either this:

+	if (pe_size != PE_SIZE_PMD || (vmf->flags & FAULT_FLAG_WRITE) ||
+	    (haddr < vma->vm_start || (haddr + HPAGE_PMD_SIZE > vma->vm_end)))
+		return ret;

or this:

+	if (pe_size != PE_SIZE_PMD || (vmf->flags & FAULT_FLAG_WRITE) ||
+			(haddr < vma->vm_start ||
+			(haddr + HPAGE_PMD_SIZE > vma->vm_end)))
+		return ret;

> +	rcu_read_lock();
> +
> +	if (!filemap_huge_check_pagecache_usable(&xas, &cached_page, hindex,
> +		hindex_max)) {
> +		/* found a conflicting entry in the page cache, so fallback */
> +		rcu_read_unlock();
> +		return ret;
> +	} else if (cached_page) {
> +		/* found a valid cached page, so map it */
> +		lock_page(cached_page);
> +
> +		/* was the cached page truncated while waiting for the lock? */
> +		if (unlikely(page_mapping(cached_page) != mapping)) {
> +			unlock_page(cached_page);
> +			rcu_read_unlock();
> +			return ret;
> +		}
> +
> +		VM_BUG_ON_PAGE(cached_page->index != hindex, cached_page);
> +
> +		hugepage = cached_page;
> +		goto map_huge;

I think you're missing an rcu_read_unlock() before the goto.  I don't
think you should call lock_page() with the RCU read lock held, because
it can sleep.  So the rcu_read_unlock() should be moved before the
lock_page().

> +	}
> +
> +	rcu_read_unlock();
> +
> +	/* allocate huge THP page in VMA */
> +	new_page = __page_cache_alloc(vmf->gfp_mask | __GFP_COMP |
> +		__GFP_NOWARN | __GFP_NORETRY, HPAGE_PMD_ORDER);
> +
> +	if (unlikely(!new_page))
> +		return ret;
> +
> +	do {
> +		xas_lock_irq(&xas);
> +		xas_set(&xas, hindex);
> +		xas_create_range(&xas);
> +
> +		if (!(xas_error(&xas)))
> +			break;
> +
> +		xas_unlock_irq(&xas);
> +
> +		if (!xas_nomem(&xas, GFP_KERNEL)) {
> +			/* error creating range, so free THP and fallback */
> +			if (new_page)
> +				put_page(new_page);
> +
> +			return ret;
> +		}
> +	} while (1);
> +
> +	/*
> +	 * Double check that an entry did not sneak into the page cache while
> +	 * creating Xarray entries for the new page.
> +	 */
> +	if (!filemap_huge_check_pagecache_usable(&xas, &cached_page, hindex,
> +		hindex_max)) {
> +		/*
> +		 * An unusable entry was found, so delete the newly allocated
> +		 * page and fallback.
> +		 */
> +		put_page(new_page);
> +		xas_unlock_irq(&xas);
> +		return ret;
> +	} else if (cached_page) {
> +		/*
> +		 * A valid large page was found in the page cache, so free the
> +		 * newly allocated page and map the cached page instead.
> +		 */
> +		put_page(new_page);
> +		new_page = NULL;
> +		lock_page(cached_page);
> +
> +		/* was the cached page truncated while waiting for the lock? */
> +		if (unlikely(page_mapping(cached_page) != mapping)) {
> +			unlock_page(cached_page);
> +			xas_unlock_irq(&xas);
> +			return ret;
> +		}
> +
> +		VM_BUG_ON_PAGE(cached_page->index != hindex, cached_page);
> +
> +		hugepage = cached_page;
> +		goto map_huge;
> +	}
> +
> +	get_page(new_page);
> +	prep_transhuge_page(new_page);
> +	new_page->mapping = mapping;
> +	new_page->index = hindex;
> +	__SetPageLocked(new_page);
> +
> +	count_vm_event(THP_FILE_ALLOC);
> +	xas_set(&xas, hindex);
> +
> +	for (nr = 0; nr < HPAGE_PMD_NR; nr++) {
> +#ifdef PAGE_CACHE_STORE_COMPOUND_TAIL_PAGES
> +		/*
> +		 * Store pointers to both head and tail pages of a compound
> +		 * page in the page cache.
> +		 */
> +		xas_store(&xas, new_page + nr);
> +#else
> +		/*
> +		 * All entries for a compound page in the page cache should
> +		 * point to the head page.
> +		 */
> +		xas_store(&xas, new_page);
> +#endif
> +		xas_next(&xas);
> +	}
> +
> +	xas_unlock_irq(&xas);
> +
> +	/*
> +	 * The readpage() operation below is expected to fill the large
> +	 * page with data without polluting the page cache with
> +	 * PAGESIZE entries due to a buffered read and/or readahead().
> +	 *
> +	 * A filesystem's vm_operations_struct huge_fault field should
> +	 * never point to this routine without such a capability, and
> +	 * without it a call to this routine would eventually just
> +	 * fall through to the normal fault op anyway.
> +	 */
> +	error = mapping->a_ops->readpage(vmf->vma->vm_file, new_page);
> +
> +	if (unlikely(error)) {
> +		new_page->mapping = NULL;
> +		put_page(new_page);

Do we also need to remove it from the page cache?

> +		return ret;
> +	}
> +
> +	/* XXX - use wait_on_page_locked_killable() instead? */
> +	wait_on_page_locked(new_page);

Yes ...

	if (wait_on_page_locked_killable(new_page))
		return VM_FAULT_SIGSEGV;

> +	if (!PageUptodate(new_page)) {
> +		/* EIO */
> +		new_page->mapping = NULL;
> +		put_page(new_page);

Again, do we keep the page in cache if we couldn't read the whole page?

> +		return ret;
> +	}
> +
> +	lock_page(new_page);
> +
> +	/* did the page get truncated while waiting for the lock? */
> +	if (unlikely(new_page->mapping != mapping)) {
> +		unlock_page(new_page);
> +		put_page(new_page);
> +		return ret;
> +	}
> +
> +	__inc_node_page_state(new_page, NR_SHMEM_THPS);
> +	__mod_node_page_state(page_pgdat(new_page),
> +		NR_FILE_PAGES, HPAGE_PMD_NR);
> +	__mod_node_page_state(page_pgdat(new_page),
> +		NR_SHMEM, HPAGE_PMD_NR);
> +
> +	hugepage = new_page;
> +
> +map_huge:
> +	/* map hugepage at the PMD level */
> +
> +	ret = alloc_set_pte(vmf, vmf->memcg, hugepage);
> +
> +	VM_BUG_ON_PAGE((!(pmd_trans_huge(*vmf->pmd))), hugepage);
> +
> +	if (likely(!(ret & VM_FAULT_ERROR))) {
> +		vmf->address = haddr;
> +		vmf->page = hugepage;
> +
> +		page_ref_add(hugepage, HPAGE_PMD_NR);

We called get_page() earlier (on one of the paths to this point); haven't
we now incremented the refcount by 513?

