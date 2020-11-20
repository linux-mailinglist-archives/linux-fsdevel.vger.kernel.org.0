Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9800B2BA47B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKTITn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:19:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:34916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgKTITm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:19:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605860381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QW9DfTvL/tP0pjyHObZ8HmfOn6WmxLL7a59EjdlXOnw=;
        b=Ej6er/FVxpJaDeALJNOBDD/dPe9P1i6ApIgIIaZINCNGCZGJuTHTpfc8cFPrJXlMjyPso6
        7uCprUYzOh1UkFKX4H/cjLrMoQxK3KUtrRU9YB9ijmodh/taJY0flyr9MNiMdfX3R5D202
        iT4VJBQEQ05ZaPtRwumvhUgP/b4vF4k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D13B3AC0C;
        Fri, 20 Nov 2020 08:19:40 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:19:40 +0100
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
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 15/21] mm/hugetlb: Set the PageHWPoison to the raw
 error page
Message-ID: <20201120081940.GE3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-16-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-16-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:19, Muchun Song wrote:
> Because we reuse the first tail page, if we set PageHWPosion on a
> tail page. It indicates that we may set PageHWPoison on a series
> of pages. So we can use the head[4].mapping to record the real
> error page index and set the raw error page PageHWPoison later.

This really begs more explanation. Maybe I misremember but If there
is a HWPoison hole in a hugepage then the whole page is demolished, no?
If that is the case then why do we care about tail pages?
 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c         | 11 +++--------
>  mm/hugetlb_vmemmap.h | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 055604d07046..b853aacd5c16 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1383,6 +1383,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
>  	int i;
>  
>  	alloc_huge_page_vmemmap(h, page);
> +	subpage_hwpoison_deliver(page);
>  
>  	for (i = 0; i < pages_per_huge_page(h); i++) {
>  		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1944,14 +1945,8 @@ int dissolve_free_huge_page(struct page *page)
>  		int nid = page_to_nid(head);
>  		if (h->free_huge_pages - h->resv_huge_pages == 0)
>  			goto out;
> -		/*
> -		 * Move PageHWPoison flag from head page to the raw error page,
> -		 * which makes any subpages rather than the error page reusable.
> -		 */
> -		if (PageHWPoison(head) && page != head) {
> -			SetPageHWPoison(page);
> -			ClearPageHWPoison(head);
> -		}
> +
> +		set_subpage_hwpoison(head, page);
>  		list_del(&head->lru);
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 779d3cb9333f..65e94436ffff 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -20,6 +20,29 @@ void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
>  void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
>  
> +static inline void subpage_hwpoison_deliver(struct page *head)
> +{
> +	struct page *page = head;
> +
> +	if (PageHWPoison(head))
> +		page = head + page_private(head + 4);
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
> +static inline void set_subpage_hwpoison(struct page *head, struct page *page)
> +{
> +	if (PageHWPoison(head))
> +		set_page_private(head + 4, page - head);
> +}
> +
>  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
>  {
>  	return h->nr_free_vmemmap_pages;
> @@ -56,6 +79,22 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>  }
>  
> +static inline void subpage_hwpoison_deliver(struct page *head)
> +{
> +}
> +
> +static inline void set_subpage_hwpoison(struct page *head, struct page *page)
> +{
> +	/*
> +	 * Move PageHWPoison flag from head page to the raw error page,
> +	 * which makes any subpages rather than the error page reusable.
> +	 */
> +	if (PageHWPoison(head) && page != head) {
> +		SetPageHWPoison(page);
> +		ClearPageHWPoison(head);
> +	}
> +}
> +
>  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
>  {
>  	return 0;
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
