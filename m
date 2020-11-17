Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF62B6838
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 16:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgKQPGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 10:06:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:59424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgKQPGR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:06:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5304AF95;
        Tue, 17 Nov 2020 15:06:14 +0000 (UTC)
Date:   Tue, 17 Nov 2020 16:06:10 +0100
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
        mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
Message-ID: <20201117150604.GA15679@linux>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113105952.11638-6-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 06:59:36PM +0800, Muchun Song wrote:
> +#define page_huge_pte(page)		((page)->pmd_huge_pte)

Seems you do not need this one anymore.

> +void vmemmap_pgtable_free(struct page *page)
> +{
> +	struct page *pte_page, *t_page;
> +
> +	list_for_each_entry_safe(pte_page, t_page, &page->lru, lru) {
> +		list_del(&pte_page->lru);
> +		pte_free_kernel(&init_mm, page_to_virt(pte_page));
> +	}
> +}
> +
> +int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> +{
> +	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> +
> +	/* Store preallocated pages on huge page lru list */
> +	INIT_LIST_HEAD(&page->lru);
> +
> +	while (nr--) {
> +		pte_t *pte_p;
> +
> +		pte_p = pte_alloc_one_kernel(&init_mm);
> +		if (!pte_p)
> +			goto out;
> +		list_add(&virt_to_page(pte_p)->lru, &page->lru);
> +	}

Definetely this looks better and easier to handle.
Btw, did you explore Matthew's hint about instead of allocating a new page,
using one of the ones you are going to free to store the ptes?
I am not sure whether it is feasible at all though.


> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -9,12 +9,24 @@
>  #ifndef _LINUX_HUGETLB_VMEMMAP_H
>  #define _LINUX_HUGETLB_VMEMMAP_H
>  #include <linux/hugetlb.h>
> +#include <linux/mm.h>

why do we need this here?

-- 
Oscar Salvador
SUSE L3
