Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1849833415F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhCJPUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 10:20:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:40300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233167AbhCJPTs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:19:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615389586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NH84xqLldcd45A2RcbHMMjzdvw5PYH9+xCTWIfl+GaY=;
        b=rc8GZH6Q5gLGWNm/UPxjOLv7H5GzISHfw+SGj3ByIhEO649bOcHuAaeC3D3Z0KeJ/+1aoq
        /+Fjp5AAnjJttZzxeKr1wglfWKOpHlYn+l2VuXGYyQVul9yTwL/srioThzMLcbpt7blwIP
        dnnbfe4gRKTqnfBKi1hyTrR10jJu9d4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 804FDAE3C;
        Wed, 10 Mar 2021 15:19:46 +0000 (UTC)
Date:   Wed, 10 Mar 2021 16:19:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102807.59745-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-03-21 18:28:02, Muchun Song wrote:
[...]
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
> +		 * The refcount can possibly be increased by memory-failure or
> +		 * soft_offline handlers.

This comment could be more helpful. I believe you want to say this
		/*
		 * HWpoisoning code can increment the reference
		 * count here. If there is a race then bail out
		 * the holder of the additional reference count will
		 * free up the page with put_page.
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
[...]
> @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
>  	/*
>  	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
>  	 */
> -	if (!in_task()) {
> +	if (in_atomic()) {

As I've said elsewhere in_atomic doesn't work for CONFIG_PREEMPT_COUNT=n.
We need this change for other reasons and so it would be better to pull
it out into a separate patch which also makes HUGETLB depend on
PREEMPT_COUNT.

[...]
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

This is quite ugly and confusing. update_and_free_page is careful to do
the proper counters accounting and now you just override it partially.
Why cannot we rely on update_and_free_page do the right thing?

-- 
Michal Hocko
SUSE Labs
