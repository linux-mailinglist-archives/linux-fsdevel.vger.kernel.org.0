Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBE2A7FA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 14:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgKENZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 08:25:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:40974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKENXq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:23:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FDAAABDE;
        Thu,  5 Nov 2020 13:23:45 +0000 (UTC)
Date:   Thu, 5 Nov 2020 14:23:41 +0100
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
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/19] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
Message-ID: <20201105132337.GA7552@linux>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145114.59424-6-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:51:00PM +0800, Muchun Song wrote:
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +#define VMEMMAP_HPAGE_SHIFT			PMD_SHIFT
> +#define arch_vmemmap_support_huge_mapping()	boot_cpu_has(X86_FEATURE_PSE)

I do not think you need this.
We already have hugepages_supported().

> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +#ifndef arch_vmemmap_support_huge_mapping
> +static inline bool arch_vmemmap_support_huge_mapping(void)
> +{
> +	return false;
> +}

Same as above

>  static inline unsigned int nr_free_vmemmap(struct hstate *h)
>  {
>  	return h->nr_free_vmemmap_pages;
>  }
>  
> +static inline unsigned int nr_vmemmap(struct hstate *h)
> +{
> +	return nr_free_vmemmap(h) + RESERVE_VMEMMAP_NR;
> +}
> +
> +static inline unsigned long nr_vmemmap_size(struct hstate *h)
> +{
> +	return (unsigned long)nr_vmemmap(h) << PAGE_SHIFT;
> +}
> +
> +static inline unsigned int nr_pgtable(struct hstate *h)
> +{
> +	unsigned long vmemmap_size = nr_vmemmap_size(h);
> +
> +	if (!arch_vmemmap_support_huge_mapping())
> +		return 0;
> +
> +	/*
> +	 * No need pre-allocate page tabels when there is no vmemmap pages
> +	 * to free.
> +	 */
> +	if (!nr_free_vmemmap(h))
> +		return 0;
> +
> +	return ALIGN(vmemmap_size, VMEMMAP_HPAGE_SIZE) >> VMEMMAP_HPAGE_SHIFT;
> +}

IMHO, Mike's naming suggestion fit much better.

> +static void vmemmap_pgtable_deposit(struct page *page, pte_t *pte_p)
> +{
> +	pgtable_t pgtable = virt_to_page(pte_p);
> +
> +	/* FIFO */
> +	if (!page_huge_pte(page))
> +		INIT_LIST_HEAD(&pgtable->lru);
> +	else
> +		list_add(&pgtable->lru, &page_huge_pte(page)->lru);
> +	page_huge_pte(page) = pgtable;
> +}

I think it would make more sense if this took a pgtable argument
instead of a pte_t *.

> +static pte_t *vmemmap_pgtable_withdraw(struct page *page)
> +{
> +	pgtable_t pgtable;
> +
> +	/* FIFO */
> +	pgtable = page_huge_pte(page);
> +	if (unlikely(!pgtable))
> +		return NULL;

AFAICS, above check only needs to be run once.
It think we can move it to vmemmap_pgtable_free, can't we?

> +	page_huge_pte(page) = list_first_entry_or_null(&pgtable->lru,
> +						       struct page, lru);
> +	if (page_huge_pte(page))
> +		list_del(&pgtable->lru);
> +	return page_to_virt(pgtable);
> +}

At the risk of adding more code, I think it would be nice to return a
pagetable_t?
So it is more coherent with the name of the function and with what
we are doing.

It is a pitty we cannot converge these and pgtable_trans_huge_*.
They share some code but it is different enough.

> +static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> +{
> +	int i;
> +	pte_t *pte_p;
> +	unsigned int nr = nr_pgtable(h);
> +
> +	if (!nr)
> +		return 0;
> +
> +	vmemmap_pgtable_init(page);

Maybe just open code this one?

> +static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
> +{
> +	pte_t *pte_p;
> +
> +	if (!nr_pgtable(h))
> +		return;
> +
> +	while ((pte_p = vmemmap_pgtable_withdraw(page)))
> +		pte_free_kernel(&init_mm, pte_p);

As mentioned above, move the pgtable_t check from vmemmap_pgtable_withdraw
in here.

  
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
> +	/* Must be called before the initialization of @page->lru */
> +	vmemmap_pgtable_free(h, page);
> +
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>  	set_hugetlb_cgroup(page, NULL);
> @@ -1783,6 +1892,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
>  	if (!page)
>  		return NULL;
>  
> +	if (vmemmap_pgtable_prealloc(h, page)) {
> +		if (hstate_is_gigantic(h))
> +			free_gigantic_page(page, huge_page_order(h));
> +		else
> +			put_page(page);
> +		return NULL;
> +	}
> +

I must confess I am bit puzzled.

IIUC, in this patch we are just adding the helpers to create/tear the page
tables.
I do not think we actually need to call vmemmap_pgtable_prealloc/vmemmap_pgtable_free, do we?
In the end, we are just allocating pages for pagetables and then free them shortly.

I think it would make more sense to add the calls when they need to be?


-- 
Oscar Salvador
SUSE L3
