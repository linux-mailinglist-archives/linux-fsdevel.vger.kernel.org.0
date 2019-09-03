Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992C4A6869
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfICMO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 08:14:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:40134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbfICMO1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:14:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BF44AD3C;
        Tue,  3 Sep 2019 12:14:25 +0000 (UTC)
Date:   Tue, 3 Sep 2019 14:14:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 2/2] mm,thp: Add experimental config option
 RO_EXEC_FILEMAP_HUGE_FAULT_THP
Message-ID: <20190903121424.GT14028@dhcp22.suse.cz>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-3-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902092341.26712-3-william.kucharski@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 02-09-19 03:23:41, William Kucharski wrote:
> Add filemap_huge_fault() to attempt to satisfy page
> faults on memory-mapped read-only text pages using THP when possible.

This deserves much more description of how the thing is implemented and
expected to work. For one thing it is not really clear to me why you
need CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP at all. You need a support
from the filesystem anyway. So who is going to enable/disable this
config?

I cannot really comment on fs specific parts but filemap_huge_fault
sounds convoluted so much I cannot wrap my head around it. One thing
stand out though. The generic filemap_huge_fault depends on ->readpage
doing the right thing which sounds quite questionable to me. If nothing
else  I would expect ->readpages to do the job.

I am sorry to chime in at v5 without studying all previous 4 versions
(ENOTIME) but if those are deliberate decisions then they should better
be described in the changelog.

> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  include/linux/mm.h |   2 +
>  mm/Kconfig         |  15 ++
>  mm/filemap.c       | 398 +++++++++++++++++++++++++++++++++++++++++++--
>  mm/huge_memory.c   |   3 +
>  mm/mmap.c          |  39 ++++-
>  mm/rmap.c          |   4 +-
>  mm/vmscan.c        |   2 +-
>  7 files changed, 446 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0334ca97c584..2a5311721739 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2433,6 +2433,8 @@ extern void truncate_inode_pages_final(struct address_space *);
>  
>  /* generic vm_area_ops exported for stackable file systems */
>  extern vm_fault_t filemap_fault(struct vm_fault *vmf);
> +extern vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
> +			enum page_entry_size pe_size);
>  extern void filemap_map_pages(struct vm_fault *vmf,
>  		pgoff_t start_pgoff, pgoff_t end_pgoff);
>  extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 56cec636a1fc..2debaded0e4d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -736,4 +736,19 @@ config ARCH_HAS_PTE_SPECIAL
>  config ARCH_HAS_HUGEPD
>  	bool
>  
> +config RO_EXEC_FILEMAP_HUGE_FAULT_THP
> +	bool "read-only exec filemap_huge_fault THP support (EXPERIMENTAL)"
> +	depends on TRANSPARENT_HUGE_PAGECACHE && SHMEM
> +
> +	help
> +	    Introduce filemap_huge_fault() to automatically map executable
> +	    read-only pages of mapped files of suitable size and alignment
> +	    using THP if possible.
> +
> +	    This is marked experimental because it is a new feature and is
> +	    dependent upon filesystmes implementing readpages() in a way
> +	    that will recognize large THP pages and read file content to
> +	    them without polluting the pagecache with PAGESIZE pages due
> +	    to readahead.
> +
>  endmenu
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 38b46fc00855..5947d432a4e6 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -199,13 +199,12 @@ static void unaccount_page_cache_page(struct address_space *mapping,
>  	nr = hpage_nr_pages(page);
>  
>  	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
> -	if (PageSwapBacked(page)) {
> +
> +	if (PageSwapBacked(page))
>  		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
> -		if (PageTransHuge(page))
> -			__dec_node_page_state(page, NR_SHMEM_THPS);
> -	} else {
> -		VM_BUG_ON_PAGE(PageTransHuge(page), page);
> -	}
> +
> +	if (PageTransHuge(page))
> +		__dec_node_page_state(page, NR_SHMEM_THPS);
>  
>  	/*
>  	 * At this point page must be either written or cleaned by
> @@ -303,6 +302,9 @@ static void page_cache_delete_batch(struct address_space *mapping,
>  			break;
>  		if (xa_is_value(page))
>  			continue;
> +
> +VM_BUG_ON_PAGE(xa_is_internal(page), page);
> +
>  		if (!tail_pages) {
>  			/*
>  			 * Some page got inserted in our range? Skip it. We
> @@ -315,6 +317,11 @@ static void page_cache_delete_batch(struct address_space *mapping,
>  				continue;
>  			}
>  			WARN_ON_ONCE(!PageLocked(page));
> +
> +			/*
> +			 * If a THP is in the page cache, set the succeeding
> +			 * cache entries for the PMD-sized page to NULL.
> +			 */
>  			if (PageTransHuge(page) && !PageHuge(page))
>  				tail_pages = HPAGE_PMD_NR - 1;
>  			page->mapping = NULL;
> @@ -324,8 +331,6 @@ static void page_cache_delete_batch(struct address_space *mapping,
>  			 */
>  			i++;
>  		} else {
> -			VM_BUG_ON_PAGE(page->index + HPAGE_PMD_NR - tail_pages
> -					!= pvec->pages[i]->index, page);
>  			tail_pages--;
>  		}
>  		xas_store(&xas, NULL);
> @@ -881,7 +886,10 @@ static int __add_to_page_cache_locked(struct page *page,
>  		mapping->nrpages++;
>  
>  		/* hugetlb pages do not participate in page cache accounting */
> -		if (!huge)
> +		if (PageTransHuge(page) && !huge)
> +			__mod_node_page_state(page_pgdat(page),
> +				NR_FILE_PAGES, HPAGE_PMD_NR);
> +		else
>  			__inc_node_page_state(page, NR_FILE_PAGES);
>  unlock:
>  		xas_unlock_irq(&xas);
> @@ -1663,7 +1671,8 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>  no_page:
>  	if (!page && (fgp_flags & FGP_CREAT)) {
>  		int err;
> -		if ((fgp_flags & FGP_WRITE) && mapping_cap_account_dirty(mapping))
> +		if ((fgp_flags & FGP_WRITE) &&
> +			mapping_cap_account_dirty(mapping))
>  			gfp_mask |= __GFP_WRITE;
>  		if (fgp_flags & FGP_NOFS)
>  			gfp_mask &= ~__GFP_FS;
> @@ -2643,6 +2652,372 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  }
>  EXPORT_SYMBOL(filemap_fault);
>  
> +#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> +/*
> + * There is a change coming to store only the head page of a compound page in
> + * the head cache.
> + *
> + * When that change is present in the kernel, remove this #define
> + */
> +#define	PAGE_CACHE_STORE_COMPOUND_TAIL_PAGES
> +
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
> +		xas_set(xas, hindex);
> +		page = xas_find(xas, hindex_max);
> +
> +		if (xas_retry(xas, page))
> +			continue;
> +
> +		/*
> +		 * A found entry is unusable if:
> +		 *	+ the entry is an Xarray value, not a pointer
> +		 *	+ the entry is an internal Xarray node
> +		 *	+ the entry is not a compound page
> +		 *	+ the order of the compound page is < HPAGE_PMD_ORDER
> +		 *	+ the page index is not what we expect it to be
> +		 */
> +		if (!page)
> +			break;
> +
> +		if (xa_is_value(page) || xa_is_internal(page))
> +			return false;
> +
> +#ifdef PAGE_CACHE_STORE_COMPOUND_TAIL_PAGES
> +		if ((!PageCompound(page)) || (page != compound_head(page)))
> +#else
> +		if (!PageCompound(page))
> +#endif
> +			return false;
> +
> +		if (compound_order(page) < HPAGE_PMD_ORDER)
> +			return false;
> +
> +		if (page->index != hindex)
> +			return false;
> +
> +		break;
> +	}
> +
> +	*pagep = page;
> +	return true;
> +}
> +
> +/**
> + * filemap_huge_fault - read in file data for page fault handling to THP
> + * @vmf:	struct vm_fault containing details of the fault
> + * @pe_size:	large page size to map, currently this must be PE_SIZE_PMD
> + *
> + * filemap_huge_fault() is invoked via the vma operations vector for a
> + * mapped memory region to read in file data to a transparent huge page during
> + * a page fault.
> + *
> + * If for any reason we can't allocate a THP, map it or add it to the page
> + * cache, VM_FAULT_FALLBACK will be returned which will cause the fault
> + * handler to try mapping the page using a PAGESIZE page, usually via
> + * filemap_fault() if so speicifed in the vma operations vector.
> + *
> + * Returns either VM_FAULT_FALLBACK or the result of calling allcc_set_pte()
> + * to map the new THP.
> + *
> + * NOTE: This routine depends upon the file system's readpage routine as
> + *       specified in the address space operations vector to recognize when it
> + *	 is being passed a large page and to read the approprate amount of data
> + *	 in full and without polluting the page cache for the large page itself
> + *	 with PAGESIZE pages to perform a buffered read or to pollute what
> + *	 would be the page cache space for any succeeding pages with PAGESIZE
> + *	 pages due to readahead.
> + *
> + *	 It is VITAL that this routine not be enabled without such filesystem
> + *	 support. As there is no way to determine how many bytes were read by
> + *	 the readpage() operation, if only a PAGESIZE page is read, this routine
> + *	 will map the THP containing only the first PAGESIZE bytes of file data
> + *	 to satisfy the fault, which is never the result desired.
> + */
> +vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
> +		enum page_entry_size pe_size)
> +{
> +	struct file *filp = vmf->vma->vm_file;
> +	struct address_space *mapping = filp->f_mapping;
> +	struct vm_area_struct *vma = vmf->vma;
> +
> +	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> +	pgoff_t hindex = round_down(vmf->pgoff, HPAGE_PMD_NR);
> +	pgoff_t hindex_max = hindex + HPAGE_PMD_NR - 1;
> +
> +	struct page *cached_page, *hugepage;
> +	struct page *new_page = NULL;
> +
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
> +	unsigned long nr;
> +
> +	int error;
> +	bool retry_lookup = true;
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
> +	    (haddr < vma->vm_start ||
> +	    ((haddr + HPAGE_PMD_SIZE) > vma->vm_end)))
> +		return ret;
> +
> +retry_lookup:
> +	rcu_read_lock();
> +
> +	if (!filemap_huge_check_pagecache_usable(&xas, &cached_page, hindex,
> +	    hindex_max)) {
> +		/* found a conflicting entry in the page cache, so fallback */
> +		rcu_read_unlock();
> +		return ret;
> +	} else if (cached_page) {
> +		/* found a valid cached page, so map it */
> +		rcu_read_unlock();
> +		lock_page(cached_page);
> +
> +		/* was the cached page truncated while waiting for the lock? */
> +		if (unlikely(cached_page->mapping != mapping)) {
> +			unlock_page(cached_page);
> +
> +			/* retry once */
> +			if (retry_lookup) {
> +				retry_lookup = false;
> +				goto retry_lookup;
> +			}
> +
> +			return ret;
> +		}
> +
> +		if (unlikely(!PageUptodate(cached_page))) {
> +			unlock_page(cached_page);
> +			return ret;
> +		}
> +
> +		VM_BUG_ON_PAGE(cached_page->index != hindex, cached_page);
> +
> +		hugepage = cached_page;
> +		goto map_huge;
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
> +	/* i_pages is locked here */
> +
> +	/*
> +	 * Double check that an entry did not sneak into the page cache while
> +	 * creating Xarray entries for the new page.
> +	 */
> +	if (!filemap_huge_check_pagecache_usable(&xas, &cached_page, hindex,
> +	    hindex_max)) {
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
> +		xas_unlock_irq(&xas);
> +
> +		lock_page(cached_page);
> +
> +		/* was the cached page truncated while waiting for the lock? */
> +		if (unlikely(cached_page->mapping != mapping)) {
> +			unlock_page(cached_page);
> +
> +			/* retry once */
> +			if (retry_lookup) {
> +				retry_lookup = false;
> +				goto retry_lookup;
> +			}
> +
> +			return ret;
> +		}
> +
> +		if (unlikely(!PageUptodate(cached_page))) {
> +			unlock_page(cached_page);
> +			return ret;
> +		}
> +
> +		VM_BUG_ON_PAGE(cached_page->index != hindex, cached_page);
> +
> +		hugepage = cached_page;
> +		goto map_huge;
> +	}
> +
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
> +	mapping->nrpages += HPAGE_PMD_NR;
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
> +		ret = VM_FAULT_SIGBUS;
> +		goto delete_hugepage_from_page_cache;
> +	}
> +
> +	if (wait_on_page_locked_killable(new_page)) {
> +		ret = VM_FAULT_SIGSEGV;
> +		goto delete_hugepage_from_page_cache;
> +	}
> +
> +	if (!PageUptodate(new_page)) {
> +		/* EIO */
> +		ret = VM_FAULT_SIGBUS;
> +		goto delete_hugepage_from_page_cache;
> +	}
> +
> +	lock_page(new_page);
> +
> +	/* did the page get truncated while waiting for the lock? */
> +	if (unlikely(new_page->mapping != mapping)) {
> +		unlock_page(new_page);
> +		goto delete_hugepage_from_page_cache;
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
> +	VM_BUG_ON_PAGE(!(PageTransHuge(hugepage)), hugepage);
> +
> +	if (likely(!(ret & VM_FAULT_ERROR))) {
> +		vmf->address = haddr;
> +		vmf->page = hugepage;
> +
> +		page_ref_add(hugepage, HPAGE_PMD_NR);
> +		count_vm_event(THP_FILE_MAPPED);
> +	} else {
> +		if (new_page) {
> +			__mod_node_page_state(page_pgdat(new_page),
> +				NR_FILE_PAGES, -HPAGE_PMD_NR);
> +			__mod_node_page_state(page_pgdat(new_page),
> +				NR_SHMEM, -HPAGE_PMD_NR);
> +			__dec_node_page_state(new_page, NR_SHMEM_THPS);
> +
> +delete_hugepage_from_page_cache:
> +			xas_lock_irq(&xas);
> +			xas_set(&xas, hindex);
> +
> +			for (nr = 0; nr < HPAGE_PMD_NR; nr++) {
> +				xas_store(&xas, NULL);
> +				xas_next(&xas);
> +			}
> +
> +			new_page->mapping = NULL;
> +			xas_unlock_irq(&xas);
> +
> +			mapping->nrpages -= HPAGE_PMD_NR;
> +			unlock_page(new_page);
> +			page_ref_dec(new_page);	/* decrement page coche ref */
> +			put_page(new_page);	/* done with page */
> +			return ret;
> +		}
> +	}
> +
> +	unlock_page(hugepage);
> +	return ret;
> +}
> +EXPORT_SYMBOL(filemap_huge_fault);
> +#endif
> +
>  void filemap_map_pages(struct vm_fault *vmf,
>  		pgoff_t start_pgoff, pgoff_t end_pgoff)
>  {
> @@ -2925,7 +3300,8 @@ struct page *read_cache_page(struct address_space *mapping,
>  EXPORT_SYMBOL(read_cache_page);
>  
>  /**
> - * read_cache_page_gfp - read into page cache, using specified page allocation flags.
> + * read_cache_page_gfp - read into page cache, using specified page allocation
> + *			 flags.
>   * @mapping:	the page's address_space
>   * @index:	the page index
>   * @gfp:	the page allocator flags to use if allocating
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index de1f15969e27..ea3dbb6fa538 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -544,8 +544,11 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  
>  	if (addr)
>  		goto out;
> +
> +#ifndef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
>  	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
>  		goto out;
> +#endif
>  
>  	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
>  	if (addr)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7e8c3e8ae75f..d8b3bce71075 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1391,6 +1391,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	struct mm_struct *mm = current->mm;
>  	int pkey = 0;
>  
> +	unsigned long vm_maywrite = VM_MAYWRITE;
> +
>  	*populate = 0;
>  
>  	if (!len)
> @@ -1426,10 +1428,41 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	if (mm->map_count > sysctl_max_map_count)
>  		return -ENOMEM;
>  
> -	/* Obtain the address to map to. we verify (or select) it and ensure
> +	/*
> +	 * Obtain the address to map to. we verify (or select) it and ensure
>  	 * that it represents a valid section of the address space.
>  	 */
> -	addr = get_unmapped_area(file, addr, len, pgoff, flags);
> +
> +#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> +	/*
> +	 * If THP is enabled, it's a read-only executable that is
> +	 * MAP_PRIVATE mapped, the length is larger than a PMD page
> +	 * and either it's not a MAP_FIXED mapping or the passed address is
> +	 * properly aligned for a PMD page, attempt to get an appropriate
> +	 * address at which to map a PMD-sized THP page, otherwise call the
> +	 * normal routine.
> +	 */
> +	if ((prot & PROT_READ) && (prot & PROT_EXEC) &&
> +		(!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE) &&
> +		(!(flags & MAP_FIXED)) && len >= HPAGE_PMD_SIZE) {
> +		addr = thp_get_unmapped_area(file, addr, len, pgoff, flags);
> +
> +		if (addr && (!(addr & ~HPAGE_PMD_MASK))) {
> +			/*
> +			 * If we got a suitable THP mapping address, shut off
> +			 * VM_MAYWRITE for the region, since it's never what
> +			 * we would want.
> +			 */
> +			vm_maywrite = 0;
> +		} else
> +			addr = get_unmapped_area(file, addr, len, pgoff, flags);
> +	} else {
> +#endif
> +		addr = get_unmapped_area(file, addr, len, pgoff, flags);
> +#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> +	}
> +#endif
> +
>  	if (offset_in_page(addr))
>  		return addr;
>  
> @@ -1451,7 +1484,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	 * of the memory object, so we don't do any here.
>  	 */
>  	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
> -			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> +			mm->def_flags | VM_MAYREAD | vm_maywrite | VM_MAYEXEC;
>  
>  	if (flags & MAP_LOCKED)
>  		if (!can_do_mlock())
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 003377e24232..aacc6e330329 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1192,7 +1192,7 @@ void page_add_file_rmap(struct page *page, bool compound)
>  		}
>  		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
>  			goto out;
> -		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
> +
>  		__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
>  	} else {
>  		if (PageTransCompound(page) && page_mapping(page)) {
> @@ -1232,7 +1232,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
>  		}
>  		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
>  			goto out;
> -		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
> +
>  		__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
>  	} else {
>  		if (!atomic_add_negative(-1, &page->_mapcount))
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a6c5d0b28321..47a19c59c9a2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -930,7 +930,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  	 * Note that if SetPageDirty is always performed via set_page_dirty,
>  	 * and thus under the i_pages lock, then this ordering is not required.
>  	 */
> -	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
> +	if (unlikely(PageTransHuge(page)))
>  		refcount = 1 + HPAGE_PMD_NR;
>  	else
>  		refcount = 2;
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
