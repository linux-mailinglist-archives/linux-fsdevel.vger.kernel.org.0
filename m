Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C42BA47F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgKTIUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:20:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:36012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTIUr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:20:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605860446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4a0fEP6U1rgdeJLoiRQjCZPEdSZnqyYQTwOxKSahTFU=;
        b=QCl/dZLWlQ0gGmXIhnT6rpxMxOTHOvjzTUyMWbXOaxsOb9PpWd6pVoVAFO+Lpp8o+ypglr
        PhtBPPjzanRlbJBqzsDouPaG0zOhdx0ZN8jW7tk9d+6ULQiBs3wLiblKYPWWXpQz6R5Aeh
        NzbqKnHIPQeEW3Fbs9KU3A02JR13XxE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9C44ACB0;
        Fri, 20 Nov 2020 08:20:45 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:20:44 +0100
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
Subject: Re: [PATCH v5 16/21] mm/hugetlb: Flush work when dissolving hugetlb
 page
Message-ID: <20201120082044.GF3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-17-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-17-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:20, Muchun Song wrote:
> We should flush work when dissolving a hugetlb page to make sure that
> the hugetlb page is freed to the buddy.

Why? This explanation on its own doen't really help to understand what
is the point of the patch.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b853aacd5c16..9aad0b63d369 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1328,6 +1328,12 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
>  }
>  static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
>  
> +static inline void flush_hpage_update_work(struct hstate *h)
> +{
> +	if (free_vmemmap_pages_per_hpage(h))
> +		flush_work(&hpage_update_work);
> +}
> +
>  static inline void __update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	/* No need to allocate vmemmap pages */
> @@ -1928,6 +1934,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  int dissolve_free_huge_page(struct page *page)
>  {
>  	int rc = -EBUSY;
> +	struct hstate *h = NULL;
>  
>  	/* Not to disrupt normal path by vainly holding hugetlb_lock */
>  	if (!PageHuge(page))
> @@ -1941,8 +1948,9 @@ int dissolve_free_huge_page(struct page *page)
>  
>  	if (!page_count(page)) {
>  		struct page *head = compound_head(page);
> -		struct hstate *h = page_hstate(head);
>  		int nid = page_to_nid(head);
> +
> +		h = page_hstate(head);
>  		if (h->free_huge_pages - h->resv_huge_pages == 0)
>  			goto out;
>  
> @@ -1956,6 +1964,14 @@ int dissolve_free_huge_page(struct page *page)
>  	}
>  out:
>  	spin_unlock(&hugetlb_lock);
> +
> +	/*
> +	 * We should flush work before return to make sure that
> +	 * the HugeTLB page is freed to the buddy.
> +	 */
> +	if (!rc && h)
> +		flush_hpage_update_work(h);
> +
>  	return rc;
>  }
>  
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
