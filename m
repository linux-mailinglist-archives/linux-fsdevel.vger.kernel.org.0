Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A37D32E3FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 09:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEIzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 03:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEIzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:55:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B6EC061574;
        Fri,  5 Mar 2021 00:55:09 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y67so1694256pfb.2;
        Fri, 05 Mar 2021 00:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1c/300224UQ0F2MjYyP06p0AAeJjdkXiWE40kXHb4Bw=;
        b=Jjf9dMwPufwcLkero5NeeBPvmWJISybWrIlyBpcnGrNySxWGLkpmII40EGSru16FYB
         N4UlmrobNPbStQIlZ7ZrVTC8Lu9vFHahNgvaG3kfG2jer10wKIsPAeiZiYDpt5l1K2nk
         QWqjHhgVmcyuk1P1kF75chiCGYb0TMcBVP+wB7RC/NeWt2pVznlt21r5hJkmC+VbVj97
         Cc7AGIx8yL/5DyFej7dQb6L9v95Vl6BC+QxTzmdEV/S67C/tBiIkCO4vnvXyWqPu+JNg
         GEOnGvGEjJD2zeBTeWaFRm45PW+rLl/t9z0bQQvnZB41sCHbsBiOs05GuM2710T24maz
         G9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1c/300224UQ0F2MjYyP06p0AAeJjdkXiWE40kXHb4Bw=;
        b=jiGE2WuCGqJ7CyUQoGfIHYjXoFz3H5OvqSyh3lXmZum+rDHS4N4GRQRnfUKFdUjHap
         PhunMc5OYadT0whC+gpY03WHGfYbXyoYh2ah5xzJsCgl7os1xr7OMnE6jUZN6J/Vw0TE
         ufJalxdNixVbpE+cVIIEesXVgJ9mJGiUrVJ2QvoPqLIOyayj1kcOfjeAGFp64fVt0yg8
         IYj0gwCcNf78CBF1OJ6CUeoxGmcyo93bOOjyus5qHQaRamp9hznD1cCNsTKCZIbPPaZL
         pR3v7zodGYbvny85lVA4Xqp8Pte2u/fOrjpC4lywxnKJjixG/mZ8pZFGt8xWPnewC7ht
         wsow==
X-Gm-Message-State: AOAM532jCP/uP4cmhYdWs3on7KV4qzDjDjbWkmYTx7QGfW0bEMRStWS8
        /6tPzZ0ga6MqOOnmH14GPjA=
X-Google-Smtp-Source: ABdhPJwx58egiIsMhWEGfzqlE3lDiKqSBAbeCNl+aCzgotRQkRGRb5WjXoBCmH8IFjx/eanZUuW4zQ==
X-Received: by 2002:a63:c349:: with SMTP id e9mr7583044pgd.20.1614934508556;
        Fri, 05 Mar 2021 00:55:08 -0800 (PST)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id i11sm1892175pfo.29.2021.03.05.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 00:55:06 -0800 (PST)
Date:   Fri, 5 Mar 2021 19:55:02 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v17 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20210305085502.GD1223287@balbir-desktop>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225132130.26451-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 09:21:25PM +0800, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate
> the vmemmap pages associated with it. But we may cannot allocate vmemmap
> pages when the system is under memory pressure, in this case, we just
> refuse to free the HugeTLB page instead of looping forever trying to
> allocate the pages. This changes some behavior (list below) on some
> corner cases.
> 
>  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> 
>     Need try again later by the user.
> 
>  2) Failing to free a surplus huge page when freed by the application.
> 
>     Try again later when freeing a huge page next time.
> 
>  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
>     offline_pages().
> 
>     This is a bit unfortunate if we have plenty of ZONE_MOVABLE memory
>     but are low on kernel memory. For example, migration of huge pages
>     would still work, however, dissolving the free page does not work.
>     This is a corner cases. When the system is that much under memory
>     pressure, offlining/unplug can be expected to fail. This is
>     unfortunate because it prevents from the memory offlining which
>     shouldn't happen for movable zones. People depending on the memory
>     hotplug and movable zone should carefuly consider whether savings
>     on unmovable memory are worth losing their hotplug functionality
>     in some situations.
> 
>  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
>     alloc_contig_range() - once we have that handling in place. Mainly
>     affects CMA and virtio-mem.
> 
>     Similar to 3). virito-mem will handle migration errors gracefully.
>     CMA might be able to fallback on other free areas within the CMA
>     region.
> 
> Vmemmap pages are allocated from the page freeing context. In order for
> those allocations to be not disruptive (e.g. trigger oom killer)
> __GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
> because a non sleeping allocation would be too fragile and it could fail
> too easily under memory pressure. GFP_ATOMIC or other modes to access
> memory reserves is not used because we want to prevent consuming
> reserves under heavy hugetlb freeing.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst |  8 +++
>  include/linux/mm.h                           |  2 +
>  mm/hugetlb.c                                 | 92 +++++++++++++++++++++-------
>  mm/hugetlb_vmemmap.c                         | 32 ++++++----
>  mm/hugetlb_vmemmap.h                         | 23 +++++++
>  mm/sparse-vmemmap.c                          | 75 ++++++++++++++++++++++-
>  6 files changed, 197 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index f7b1c7462991..6988895d09a8 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -60,6 +60,10 @@ HugePages_Surp
>          the pool above the value in ``/proc/sys/vm/nr_hugepages``. The
>          maximum number of surplus huge pages is controlled by
>          ``/proc/sys/vm/nr_overcommit_hugepages``.
> +	Note: When the feature of freeing unused vmemmap pages associated
> +	with each hugetlb page is enabled, the number of surplus huge pages
> +	may be temporarily larger than the maximum number of surplus huge
> +	pages when the system is under memory pressure.
>  Hugepagesize
>  	is the default hugepage size (in Kb).
>  Hugetlb
> @@ -80,6 +84,10 @@ returned to the huge page pool when freed by a task.  A user with root
>  privileges can dynamically allocate more or free some persistent huge pages
>  by increasing or decreasing the value of ``nr_hugepages``.
>  
> +Note: When the feature of freeing unused vmemmap pages associated with each
> +hugetlb page is enabled, we can fail to free the huge pages triggered by
> +the user when ths system is under memory pressure.  Please try again later.
> +
>  Pages that are used as huge pages are reserved inside the kernel and cannot
>  be used for other purposes.  Huge pages cannot be swapped out under
>  memory pressure.
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4ddfc31f21c6..77693c944a36 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2973,6 +2973,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  
>  void vmemmap_remap_free(unsigned long start, unsigned long end,
>  			unsigned long reuse);
> +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> +			unsigned long reuse, gfp_t gfp_mask);
>  
>  void *sparse_buffer_alloc(unsigned long size);
>  struct page * __populate_section_memmap(unsigned long pfn,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 43fed6785322..b6e4e3f31ad2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1304,16 +1304,59 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> -static void update_and_free_page(struct hstate *h, struct page *page)
> +static int update_and_free_page(struct hstate *h, struct page *page)
> +	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
>  {
>  	int i;
>  	struct page *subpage = page;
> +	int nid = page_to_nid(page);
>  
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> -		return;
> +		return 0;
>  
>  	h->nr_huge_pages--;
> -	h->nr_huge_pages_node[page_to_nid(page)]--;
> +	h->nr_huge_pages_node[nid]--;
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> +	set_page_refcounted(page);
> +	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +
> +	/*
> +	 * If the vmemmap pages associated with the HugeTLB page can be
> +	 * optimized or the page is gigantic, we might block in
> +	 * alloc_huge_page_vmemmap() or free_gigantic_page(). In both
> +	 * cases, drop the hugetlb_lock.
> +	 */
> +	if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> +		spin_unlock(&hugetlb_lock);
> +
> +	if (alloc_huge_page_vmemmap(h, page)) {
> +		spin_lock(&hugetlb_lock);
> +		INIT_LIST_HEAD(&page->lru);
> +		set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> +		h->nr_huge_pages++;
> +		h->nr_huge_pages_node[nid]++;
> +
> +		/*
> +		 * If we cannot allocate vmemmap pages, just refuse to free the
> +		 * page and put the page back on the hugetlb free list and treat
> +		 * as a surplus page.
> +		 */
> +		h->surplus_huge_pages++;
> +		h->surplus_huge_pages_node[nid]++;
> +
> +		/*
> +		 * The refcount can be perfectly increased by memory-failure or
> +		 * soft_offline handlers.
> +		 */
> +		if (likely(put_page_testzero(page))) {
> +			arch_clear_hugepage_flags(page);
> +			enqueue_huge_page(h, page);
> +		}
> +
> +		return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < pages_per_huge_page(h);
>  	     i++, subpage = mem_map_next(subpage, page, i)) {
>  		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1321,22 +1364,18 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  				1 << PG_active | 1 << PG_private |
>  				1 << PG_writeback);
>  	}
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> -	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> -	set_page_refcounted(page);
> +
>  	if (hstate_is_gigantic(h)) {
> -		/*
> -		 * Temporarily drop the hugetlb_lock, because
> -		 * we might block in free_gigantic_page().
> -		 */
> -		spin_unlock(&hugetlb_lock);
>  		destroy_compound_gigantic_page(page, huge_page_order(h));
>  		free_gigantic_page(page, huge_page_order(h));
> -		spin_lock(&hugetlb_lock);
>  	} else {
>  		__free_pages(page, huge_page_order(h));
>  	}
> +
> +	if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> +		spin_lock(&hugetlb_lock);
> +
> +	return 0;
>  }
>  
>  struct hstate *size_to_hstate(unsigned long size)
> @@ -1404,9 +1443,9 @@ static void __free_huge_page(struct page *page)
>  	} else if (h->surplus_huge_pages_node[nid]) {
>  		/* remove the page from active list */
>  		list_del(&page->lru);
> -		update_and_free_page(h, page);
>  		h->surplus_huge_pages--;
>  		h->surplus_huge_pages_node[nid]--;
> +		update_and_free_page(h, page);
>  	} else {
>  		arch_clear_hugepage_flags(page);
>  		enqueue_huge_page(h, page);
> @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
>  	/*
>  	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
>  	 */
> -	if (!in_task()) {
> +	if (!in_atomic()) {
>  		/*
>  		 * Only call schedule_work() if hpage_freelist is previously
>  		 * empty. Otherwise, schedule_work() had been called but the
> @@ -1699,8 +1738,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  				h->surplus_huge_pages--;
>  				h->surplus_huge_pages_node[node]--;
>  			}
> -			update_and_free_page(h, page);
> -			ret = 1;
> +			ret = !update_and_free_page(h, page);
>  			break;
>  		}
>  	}
> @@ -1713,10 +1751,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>   * nothing for in-use hugepages and non-hugepages.
>   * This function returns values like below:
>   *
> - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
> - *          (allocated or reserved.)
> - *       0: successfully dissolved free hugepages or the page is not a
> - *          hugepage (considered as already dissolved)
> + *  -ENOMEM: failed to allocate vmemmap pages to free the freed hugepages
> + *           when the system is under memory pressure and the feature of
> + *           freeing unused vmemmap pages associated with each hugetlb page
> + *           is enabled.
> + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
> + *           (allocated or reserved.)
> + *       0:  successfully dissolved free hugepages or the page is not a
> + *           hugepage (considered as already dissolved)
>   */
>  int dissolve_free_huge_page(struct page *page)
>  {
> @@ -1771,8 +1813,12 @@ int dissolve_free_huge_page(struct page *page)
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
>  		h->max_huge_pages--;
> -		update_and_free_page(h, head);
> -		rc = 0;
> +		rc = update_and_free_page(h, head);
> +		if (rc) {
> +			h->surplus_huge_pages--;
> +			h->surplus_huge_pages_node[nid]--;
> +			h->max_huge_pages++;
> +		}
>  	}
>  out:
>  	spin_unlock(&hugetlb_lock);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 0209b736e0b4..f7ab3d99250a 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -181,21 +181,31 @@
>  #define RESERVE_VMEMMAP_NR		2U
>  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>  
> -/*
> - * How many vmemmap pages associated with a HugeTLB page that can be freed
> - * to the buddy allocator.
> - *
> - * Todo: Returns zero for now, which means the feature is disabled. We will
> - * enable it once all the infrastructure is there.
> - */
> -static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> +static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>  {
> -	return 0;
> +	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
>  }
>  
> -static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
> -	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +	unsigned long vmemmap_end, vmemmap_reuse;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return 0;
> +
> +	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> +	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> +	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;

This is where I think some optimization is possible, once we are done with
vmemmap_end calculation, we can use 6 pages (for 2MiB huge page) as pages
for struct page. Is there a reason to not do so?

Balbir
