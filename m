Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0D310ABC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 12:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhBEL4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 06:56:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:37476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231992AbhBELy4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:54:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFC76ACBA;
        Fri,  5 Feb 2021 11:54:08 +0000 (UTC)
Date:   Fri, 5 Feb 2021 12:54:03 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 4/8] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20210205115351.GA16428@linux>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204035043.36609-5-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:50:39AM +0800, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate the
> vmemmap pages associated with it. But we may cannot allocate vmemmap pages
> when the system is under memory pressure, in this case, we just refuse to
> free the HugeTLB page instead of looping forever trying to allocate the
> pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

[...]

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4cfca27c6d32..5518283aa667 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1397,16 +1397,26 @@ static void __free_huge_page(struct page *page)
>  		h->resv_huge_pages++;
>  
>  	if (HPageTemporary(page)) {
> -		list_del(&page->lru);
>  		ClearHPageTemporary(page);
> +
> +		if (alloc_huge_page_vmemmap(h, page, GFP_ATOMIC)) {
> +			h->surplus_huge_pages++;
> +			h->surplus_huge_pages_node[nid]++;
> +			goto enqueue;
> +		}
> +		list_del(&page->lru);
>  		update_and_free_page(h, page);
>  	} else if (h->surplus_huge_pages_node[nid]) {
> +		if (alloc_huge_page_vmemmap(h, page, GFP_ATOMIC))
> +			goto enqueue;
> +
>  		/* remove the page from active list */
>  		list_del(&page->lru);
>  		update_and_free_page(h, page);
>  		h->surplus_huge_pages--;
>  		h->surplus_huge_pages_node[nid]--;
>  	} else {
> +enqueue:
>  		arch_clear_hugepage_flags(page);
>  		enqueue_huge_page(h, page);

Ok, we just keep them in the pool in case we fail to allocate.


> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ddd872ab6180..0bd6b8d7282d 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -169,6 +169,8 @@
>   * (last) level. So this type of HugeTLB page can be optimized only when its
>   * size of the struct page structs is greater than 2 pages.

[...]

> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head, gfp_t gfp_mask)
> +{
> +	int ret;
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +	unsigned long vmemmap_end, vmemmap_reuse;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return 0;
> +
> +	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> +	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> +	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> +
> +	/*
> +	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
> +	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> +	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
> +	 * When a HugeTLB page is freed to the buddy allocator, previously
> +	 * discarded vmemmap pages must be allocated and remapping.
> +	 */
> +	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> +				  gfp_mask | __GFP_NOWARN | __GFP_THISNODE);

Why don't you set all the GFP flags here?

vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse, GFP_ATOMIC|
                    __GFP_NOWARN | __GFP_THISNODE) ?

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 50c1dc00b686..277eb43aebd5 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c

[...]

> +static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> +				   gfp_t gfp_mask, struct list_head *list)

I think it would make more sense for this function to get the nid and the
nr_pages to allocate directly.

> +{
> +	unsigned long addr;
> +	int nid = page_to_nid((const void *)start);

Uh, that void is a bit ugly. page_to_nid(struct page *)start).
Do not need the const either.

> +	struct page *page, *next;
> +
> +	for (addr = start; addr < end; addr += PAGE_SIZE) {
> +		page = alloc_pages_node(nid, gfp_mask, 0);
> +		if (!page)
> +			goto out;
> +		list_add_tail(&page->lru, list);
> +	}

and replace this by while(--nr_pages) etc.

I did not really go in depth, but looks good to me, and much more simply
overall.

The only thing I am not sure about is the use of GFP_ATOMIC.
It has been raised before than when we are close to OOM, the user might want
to try to free up some memory by dissolving free_huge_pages, and so we might
want to dip in the reserves.

Given the fact that we are prepared to fail, and that we do not retry, I would
rather use GFP_KERNEL than to have X pages atomically allocated and then realize
we need to drop them on the ground because we cannot go further at some point.
I think those reserves would be better off used by someone else in that
situation.

But this is just my thoughs, and given the fact that there seems to be a consensus
of susing GFP_ATOMIC.

-- 
Oscar Salvador
SUSE L3
