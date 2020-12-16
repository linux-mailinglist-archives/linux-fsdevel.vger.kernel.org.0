Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D409E2DC150
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 14:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgLPNbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 08:31:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:44052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgLPNbq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:31:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B194AC7B;
        Wed, 16 Dec 2020 13:31:04 +0000 (UTC)
Date:   Wed, 16 Dec 2020 14:30:59 +0100
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
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, naoya.horiguchi@nec.com
Subject: Re: [PATCH v9 06/11] mm/hugetlb: Set the PageHWPoison to the raw
 error page
Message-ID: <20201216133059.GC29394@linux>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213154534.54826-7-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 11:45:29PM +0800, Muchun Song wrote:
> Because we reuse the first tail vmemmap page frame and remap it
> with read-only, we cannot set the PageHWPosion on a tail page.
> So we can use the head[4].private to record the real error page
> index and set the raw error page PageHWPoison later.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

+CC Naoya

> ---
>  mm/hugetlb.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 542e6cb81321..29de425f879a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1347,6 +1347,43 @@ static inline void __update_and_free_page(struct hstate *h, struct page *page)
>  		schedule_work(&hpage_update_work);
>  }
>  
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
>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> @@ -1363,6 +1400,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
>  	int i;
>  
>  	alloc_huge_page_vmemmap(h, page);
> +	hwpoison_subpage_deliver(h, page);
>  
>  	for (i = 0; i < pages_per_huge_page(h); i++) {
>  		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1840,14 +1878,8 @@ int dissolve_free_huge_page(struct page *page)
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
> +		hwpoison_subpage_set(h, head, page);
>  		list_del(&head->lru);
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
> -- 
> 2.11.0
> 

-- 
Oscar Salvador
SUSE L3
