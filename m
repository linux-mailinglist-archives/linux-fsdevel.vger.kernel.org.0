Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEFA2DFB08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 11:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLUK1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 05:27:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:52474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgLUK1y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:27:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 966B6AFF0;
        Mon, 21 Dec 2020 10:27:12 +0000 (UTC)
Date:   Mon, 21 Dec 2020 11:27:07 +0100
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
Subject: Re: [PATCH v10 04/11] mm/hugetlb: Defer freeing of HugeTLB pages
Message-ID: <20201221102703.GA15804@linux>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217121303.13386-5-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 08:12:56PM +0800, Muchun Song wrote:
> In the subsequent patch, we will allocate the vmemmap pages when free
> HugeTLB pages. But update_and_free_page() is called from a non-task
> context(and hold hugetlb_lock), so we can defer the actual freeing in
> a workqueue to prevent from using GFP_ATOMIC to allocate the vmemmap
> pages.

I think we would benefit from a more complete changelog, at least I had
to stare at the code for a while in order to grasp what are we trying
to do and the reasons behind.

> +static void __free_hugepage(struct hstate *h, struct page *page);
> +
> +/*
> + * As update_and_free_page() is be called from a non-task context(and hold
> + * hugetlb_lock), we can defer the actual freeing in a workqueue to prevent
> + * use GFP_ATOMIC to allocate a lot of vmemmap pages.

The above implies that update_and_free_page() is __always__ called from a 
non-task context, but that is not always the case?

> +static void update_hpage_vmemmap_workfn(struct work_struct *work)
>  {
> -	int i;
> +	struct llist_node *node;
> +	struct page *page;
>  
> +	node = llist_del_all(&hpage_update_freelist);
> +
> +	while (node) {
> +		page = container_of((struct address_space **)node,
> +				     struct page, mapping);
> +		node = node->next;
> +		page->mapping = NULL;
> +		__free_hugepage(page_hstate(page), page);
> +
> +		cond_resched();
> +	}
> +}
> +static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);

I wonder if this should be moved to hugetlb_vmemmap.c

> +/*
> + * This is where the call to allocate vmemmmap pages will be inserted.
> + */

I think this should go in the changelog.

> +static void __free_hugepage(struct hstate *h, struct page *page)
> +{
> +	int i;
> +
>  	for (i = 0; i < pages_per_huge_page(h); i++) {
>  		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
>  				1 << PG_referenced | 1 << PG_dirty |
> @@ -1313,13 +1377,17 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	set_page_refcounted(page);
>  	if (hstate_is_gigantic(h)) {
>  		/*
> -		 * Temporarily drop the hugetlb_lock, because
> -		 * we might block in free_gigantic_page().
> +		 * Temporarily drop the hugetlb_lock only when this type of
> +		 * HugeTLB page does not support vmemmap optimization (which
> +		 * context do not hold the hugetlb_lock), because we might
> +		 * block in free_gigantic_page().

"
 /*
  * Temporarily drop the hugetlb_lock, because we might block
  * in free_gigantic_page(). Only drop it in case the vmemmap
  * optimization is disabled, since that context does not hold
  * the lock.
  */
" ?

 
Oscar Salvador
SUSE L3
