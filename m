Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C22AC20F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 18:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgKIRVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 12:21:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730706AbgKIRVt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:21:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEEADAD07;
        Mon,  9 Nov 2020 17:21:47 +0000 (UTC)
Date:   Mon, 9 Nov 2020 18:21:44 +0100
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
Subject: Re: [PATCH v3 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
Message-ID: <20201109172144.GB17356@linux>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108141113.65450-6-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 08, 2020 at 10:10:57PM +0800, Muchun Song wrote:
> +static inline unsigned int pgtable_pages_to_prealloc_per_hpage(struct hstate *h)
> +{
> +	unsigned long vmemmap_size = vmemmap_pages_size_per_hpage(h);
> +
> +	/*
> +	 * No need pre-allocate page tabels when there is no vmemmap pages
> +	 * to free.
 s /tabels/tables/

> +static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> +{
> +	int i;
> +	pgtable_t pgtable;
> +	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> +
> +	if (!nr)
> +		return 0;
> +
> +	vmemmap_pgtable_init(page);
> +
> +	for (i = 0; i < nr; i++) {
> +		pte_t *pte_p;
> +
> +		pte_p = pte_alloc_one_kernel(&init_mm);
> +		if (!pte_p)
> +			goto out;
> +		vmemmap_pgtable_deposit(page, virt_to_page(pte_p));
> +	}
> +
> +	return 0;
> +out:
> +	while (i-- && (pgtable = vmemmap_pgtable_withdraw(page)))
> +		pte_free_kernel(&init_mm, page_to_virt(pgtable));

	would not be enough to:

	while (pgtable = vmemmap_pgtable_withdrag(page))
		pte_free_kernel(&init_mm, page_to_virt(pgtable));

> +	return -ENOMEM;
> +}
> +
> +static void vmemmap_pgtable_free(struct hstate *h, struct page *page)
> +{
> +	pgtable_t pgtable;
> +	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> +
> +	if (!nr)
> +		return;

We can get rid of "nr" and its check and keep only the check below, right?
AFAICS, they go together, e.g: if page_huge_pte does not return null,
it means that we preallocated a pagetable, and viceversa.


> +
> +	pgtable = page_huge_pte(page);
> +	if (!pgtable)
> +		return;
> +
> +	while (nr-- && (pgtable = vmemmap_pgtable_withdraw(page)))
> +		pte_free_kernel(&init_mm, page_to_virt(pgtable));

	Same as above, that "nr" can go?

-- 
Oscar Salvador
SUSE L3
