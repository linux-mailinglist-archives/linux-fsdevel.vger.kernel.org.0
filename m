Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C492AC42B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 19:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgKISvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 13:51:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:43674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgKISvo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:51:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B3C3AB95;
        Mon,  9 Nov 2020 18:51:42 +0000 (UTC)
Date:   Mon, 9 Nov 2020 19:51:38 +0100
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
Subject: Re: [PATCH v3 09/21] mm/hugetlb: Free the vmemmap pages associated
 with each hugetlb page
Message-ID: <20201109185138.GD17356@linux>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108141113.65450-10-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 08, 2020 at 10:11:01PM +0800, Muchun Song wrote:
> +static inline int freed_vmemmap_hpage(struct page *page)
> +{
> +	return atomic_read(&page->_mapcount) + 1;
> +}
> +
> +static inline int freed_vmemmap_hpage_inc(struct page *page)
> +{
> +	return atomic_inc_return_relaxed(&page->_mapcount) + 1;
> +}
> +
> +static inline int freed_vmemmap_hpage_dec(struct page *page)
> +{
> +	return atomic_dec_return_relaxed(&page->_mapcount) + 1;
> +}

Are these relaxed any different that the normal ones on x86_64? 
I got confused following the macros.

> +static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
> +					 unsigned long start,
> +					 unsigned int nr_free,
> +					 struct list_head *free_pages)
> +{
> +	/* Make the tail pages are mapped read-only. */
> +	pgprot_t pgprot = PAGE_KERNEL_RO;
> +	pte_t entry = mk_pte(reuse, pgprot);
> +	unsigned long addr;
> +	unsigned long end = start + (nr_free << PAGE_SHIFT);

See below.

> +static void __free_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
> +					 unsigned long addr,
> +					 struct list_head *free_pages)
> +{
> +	unsigned long next;
> +	unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
> +	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
> +	struct page *reuse = NULL;
> +
> +	addr = start;
> +	do {
> +		unsigned int nr_pages;
> +		pte_t *ptep;
> +
> +		ptep = pte_offset_kernel(pmd, addr);
> +		if (!reuse)
> +			reuse = pte_page(ptep[-1]);

Can we define a proper name for that instead of -1?

e.g: TAIL_PAGE_REUSE or something like that. 

> +
> +		next = vmemmap_hpage_addr_end(addr, end);
> +		nr_pages = (next - addr) >> PAGE_SHIFT;
> +		__free_huge_page_pte_vmemmap(reuse, ptep, addr, nr_pages,
> +					     free_pages);

Why not passing next instead of nr_pages? I think it makes more sense.
As a bonus we can kill the variable.

> +static void split_vmemmap_huge_page(struct hstate *h, struct page *head,
> +				    pmd_t *pmd)
> +{
> +	pgtable_t pgtable;
> +	unsigned long start = (unsigned long)head & VMEMMAP_HPAGE_MASK;
> +	unsigned long addr = start;
> +	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> +
> +	while (nr-- && (pgtable = vmemmap_pgtable_withdraw(head))) {

The same with previous patches, I would scrap "nr" and its use.

> +		VM_BUG_ON(freed_vmemmap_hpage(pgtable));

I guess here we want to check whether we already call free_huge_page_vmemmap
on this range?
For this to have happened, the locking should have failed, right?

> +static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +	pmd_t *pmd;
> +	spinlock_t *ptl;
> +	LIST_HEAD(free_pages);
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return;
> +
> +	pmd = vmemmap_to_pmd(head);
> +	ptl = vmemmap_pmd_lock(pmd);
> +	if (vmemmap_pmd_huge(pmd)) {
> +		VM_BUG_ON(!pgtable_pages_to_prealloc_per_hpage(h));

I think that checking for free_vmemmap_pages_per_hpage is enough.
In the end, pgtable_pages_to_prealloc_per_hpage uses free_vmemmap_pages_per_hpage.


-- 
Oscar Salvador
SUSE L3
