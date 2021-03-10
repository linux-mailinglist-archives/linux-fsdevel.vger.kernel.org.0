Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96333417F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 16:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhCJP2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 10:28:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:45746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233087AbhCJP2B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:28:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615390080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rV2+nGi9H+LnzHxy4iouC60dKrTmppkWVNroc466CSU=;
        b=YZL8nOyZeCwufqUC87IWBmJFM0SB1zh3XusV6PGa0yANnsbREDb4TQblLI/+0nUQ+xNf6X
        FTe8cUwCBbHK+MAdOrch4O6veeJXY6FKhGO+pIi6XwEXC5/Y0CwVxq2SgMsOg6WBK3Wcw9
        bdM4pvcjyxGGdxAlmdOR0bLFzrh6AF0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08259ABD7;
        Wed, 10 Mar 2021 15:28:00 +0000 (UTC)
Date:   Wed, 10 Mar 2021 16:27:59 +0100
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
Subject: Re: [PATCH v18 5/9] mm: hugetlb: set the PageHWPoison to the raw
 error page
Message-ID: <YEjlf/yV+hz+NksO@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102807.59745-6-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-03-21 18:28:03, Muchun Song wrote:
> Because we reuse the first tail vmemmap page frame and remap it
> with read-only, we cannot set the PageHWPosion on some tail pages.
> So we can use the head[4].private (There are at least 128 struct
> page structures associated with the optimized HugeTLB page, so
> using head[4].private is safe) to record the real error page index
> and set the raw error page PageHWPoison later.

Can we have more poisoned tail pages? Also who does consume that index
and set the HWPoison on the proper tail page?
 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: David Rientjes <rientjes@google.com>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> ---
>  mm/hugetlb.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 377e0c1b283f..c0c1b7635ca9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1304,6 +1304,74 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
> +{
> +	struct page *page;
> +
> +	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
> +		return;
> +
> +	page = head + page_private(head + 4);
> +
> +	/*
> +	 * Move PageHWPoison flag from head page to the raw error page,
> +	 * which makes any subpages rather than the error page reusable.
> +	 */
> +	if (page != head) {
> +		SetPageHWPoison(page);
> +		ClearPageHWPoison(head);
> +	}
> +}
> +
> +static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
> +					struct page *page)
> +{
> +	if (!PageHWPoison(head))
> +		return;
> +
> +	if (free_vmemmap_pages_per_hpage(h)) {
> +		set_page_private(head + 4, page - head);
> +	} else if (page != head) {
> +		/*
> +		 * Move PageHWPoison flag from head page to the raw error page,
> +		 * which makes any subpages rather than the error page reusable.
> +		 */
> +		SetPageHWPoison(page);
> +		ClearPageHWPoison(head);
> +	}
> +}
> +
> +static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
> +{
> +	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
> +		return;
> +
> +	set_page_private(head + 4, 0);
> +}
> +#else
> +static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
> +{
> +}
> +
> +static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
> +					struct page *page)
> +{
> +	if (PageHWPoison(head) && page != head) {
> +		/*
> +		 * Move PageHWPoison flag from head page to the raw error page,
> +		 * which makes any subpages rather than the error page reusable.
> +		 */
> +		SetPageHWPoison(page);
> +		ClearPageHWPoison(head);
> +	}
> +}
> +
> +static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
> +{
> +}
> +#endif
> +
>  static int update_and_free_page(struct hstate *h, struct page *page)
>  	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
>  {
> @@ -1357,6 +1425,8 @@ static int update_and_free_page(struct hstate *h, struct page *page)
>  		return -ENOMEM;
>  	}
>  
> +	hwpoison_subpage_deliver(h, page);
> +
>  	for (i = 0; i < pages_per_huge_page(h);
>  	     i++, subpage = mem_map_next(subpage, page, i)) {
>  		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1801,14 +1871,7 @@ int dissolve_free_huge_page(struct page *page)
>  			goto retry;
>  		}
>  
> -		/*
> -		 * Move PageHWPoison flag from head page to the raw error page,
> -		 * which makes any subpages rather than the error page reusable.
> -		 */
> -		if (PageHWPoison(head) && page != head) {
> -			SetPageHWPoison(page);
> -			ClearPageHWPoison(head);
> -		}
> +		hwpoison_subpage_set(h, head, page);
>  		list_del(&head->lru);
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
> @@ -1818,6 +1881,7 @@ int dissolve_free_huge_page(struct page *page)
>  			h->surplus_huge_pages--;
>  			h->surplus_huge_pages_node[nid]--;
>  			h->max_huge_pages++;
> +			hwpoison_subpage_clear(h, head);
>  		}
>  	}
>  out:
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
