Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2315F2BA474
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKTIQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:16:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:33834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgKTIQn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:16:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605860202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=og4mLwEhlnEzEqYT0FKs57kE8f8M05otNa+C82lXQrM=;
        b=kSYx8Hg6CjpxVrqTTqfDalDMPPgEs2qfsAszYOsU6jfHy5txl4GLOCHOCOyp4pZL2TQ2WC
        hGb8nQDf//mUId99M3gQuxknMO4+AyEru0pfJLsmOmj3uqdIU8L9UmxqIGftAsZeykjKWg
        9d5v0k8SL12tD2A3t2a3KkRXTEiWf/w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2DE83ACB0;
        Fri, 20 Nov 2020 08:16:42 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:16:38 +0100
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
Subject: Re: [PATCH v5 13/21] mm/hugetlb: Use PG_slab to indicate split pmd
Message-ID: <20201120081638.GD3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-14-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-14-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:17, Muchun Song wrote:
> When we allocate hugetlb page from buddy, we may need split huge pmd
> to pte. When we free the hugetlb page, we can merge pte to pmd. So
> we need to distinguish whether the previous pmd has been split. The
> page table is not allocated from slab. So we can reuse the PG_slab
> to indicate that the pmd has been split.

PageSlab is used outside of the slab allocator proper and that code
might get confused by this AFAICS.

From the above description it is not really clear why this is needed
though. Who is supposed to use this? Say you are allocating a fresh
hugetlb page. Once you have it, nobody else can be interfering. It is
exclusive to the caller. The later machinery can check the vmemmap page
tables to find out whether a split is needed or not. Or do I miss
something?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 06e2b8a7b7c8..e2ddc73ce25f 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -293,6 +293,25 @@ static void remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
>  	flush_tlb_kernel_range(start, end);
>  }
>  
> +static inline bool pmd_split(pmd_t *pmd)
> +{
> +	return PageSlab(pmd_page(*pmd));
> +}
> +
> +static inline void set_pmd_split(pmd_t *pmd)
> +{
> +	/*
> +	 * We should not use slab for page table allocation. So we can set
> +	 * PG_slab to indicate that the pmd has been split.
> +	 */
> +	__SetPageSlab(pmd_page(*pmd));
> +}
> +
> +static inline void clear_pmd_split(pmd_t *pmd)
> +{
> +	__ClearPageSlab(pmd_page(*pmd));
> +}
> +
>  static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
>  					  unsigned long start,
>  					  unsigned long end,
> @@ -357,11 +376,12 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
>  	ptl = vmemmap_pmd_lock(pmd);
>  	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &remap_pages,
>  				    __remap_huge_page_pte_vmemmap);
> -	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
> +	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd)) && pmd_split(pmd)) {
>  		/*
>  		 * Todo:
>  		 * Merge pte to huge pmd if it has ever been split.
>  		 */
> +		clear_pmd_split(pmd);
>  	}
>  	spin_unlock(ptl);
>  }
> @@ -443,8 +463,10 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  	BUG_ON(!pmd);
>  
>  	ptl = vmemmap_pmd_lock(pmd);
> -	if (vmemmap_pmd_huge(pmd))
> +	if (vmemmap_pmd_huge(pmd)) {
>  		split_vmemmap_huge_page(head, pmd);
> +		set_pmd_split(pmd);
> +	}
>  
>  	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
>  				    __free_huge_page_pte_vmemmap);
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
