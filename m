Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EEE2DC8C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 23:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgLPWKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 17:10:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52398 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgLPWKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:10:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGLxlsK166473;
        Wed, 16 Dec 2020 22:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vhFv25hoY0CRSWKhoXTc4DRbTyXQsg0xqg0Pa15g/Ss=;
 b=LKK23LzbDHHLIjlBqWPFDMap+iLSdYbKa57kBqBvjtin/nVl/BKqvh71nwEV2QraAq6D
 8m7EbHj0X9IMtalnoIsYeoRTaEgdZy3VkmbIL0ZNQ3XF34PuZqxWAGT+weQkN3KXFDbd
 11o9qoknTc79ICFQfvXuaso+82dx5UYQdM3NcA6ZfiuG9FOFgA9gAE7EcwygtrVsV20X
 WXSZZlNjS/PQL+Q/emGh81lvJzV9Gfx8tzQAxA+/ynp2QbS4sdNkO+y+FcarjqHal6+e
 l8s0Z1DTeCyx1Ao+UEjgkl38TR2+fQHYYOUjapicanSKPYmgmP586JSSoLBXOQLipTD5 Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35cntman5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 22:08:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGM6D3I087364;
        Wed, 16 Dec 2020 22:08:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35d7syfd6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 22:08:42 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGM8YCd030207;
        Wed, 16 Dec 2020 22:08:34 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 14:08:33 -0800
Subject: Re: [PATCH v9 03/11] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5936a766-505a-eab0-42a6-59aab2585880@oracle.com>
Date:   Wed, 16 Dec 2020 14:08:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201213154534.54826-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160137
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/20 7:45 AM, Muchun Song wrote:
> Every HugeTLB has more than one struct page structure. We __know__ that
> we only use the first 4(HUGETLB_CGROUP_MIN_ORDER) struct page structures
> to store metadata associated with each HugeTLB.
> 
> There are a lot of struct page structures associated with each HugeTLB
> page. For tail pages, the value of compound_head is the same. So we can
> reuse first page of tail page structures. We map the virtual addresses
> of the remaining pages of tail page structures to the first tail page
> struct, and then free these page frames. Therefore, we need to reserve
> two pages as vmemmap areas.
> 
> When we allocate a HugeTLB page from the buddy, we can free some vmemmap
> pages associated with each HugeTLB page. It is more appropriate to do it
> in the prep_new_huge_page().
> 
> The free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
> pages associated with a HugeTLB page can be freed, returns zero for
> now, which means the feature is disabled. We will enable it once all
> the infrastructure is there.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/bootmem_info.h |  27 +++++-
>  include/linux/mm.h           |   2 +
>  mm/Makefile                  |   1 +
>  mm/hugetlb.c                 |   3 +
>  mm/hugetlb_vmemmap.c         | 209 +++++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h         |  20 +++++
>  mm/sparse-vmemmap.c          | 170 +++++++++++++++++++++++++++++++++++
>  7 files changed, 431 insertions(+), 1 deletion(-)
>  create mode 100644 mm/hugetlb_vmemmap.c
>  create mode 100644 mm/hugetlb_vmemmap.h

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 16183d85a7d5..78c527617e8d 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -27,8 +27,178 @@
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched.h>
> +#include <linux/pgtable.h>
> +#include <linux/bootmem_info.h>
> +
>  #include <asm/dma.h>
>  #include <asm/pgalloc.h>
> +#include <asm/tlbflush.h>
> +
> +/*
> + * vmemmap_rmap_walk - walk vmemmap page table

I am not sure if 'rmap' should be part of these names.  rmap today is mostly
about reverse mapping lookup.  Did you use rmap for 'remap', or because this
code is patterned after the page table walking rmap code?  Just think the
naming could cause some confusion.

> + *
> + * @rmap_pte:		called for each non-empty PTE (lowest-level) entry.
> + * @reuse:		the page which is reused for the tail vmemmap pages.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
> + */
> +struct vmemmap_rmap_walk {
> +	void (*rmap_pte)(pte_t *pte, unsigned long addr,
> +			 struct vmemmap_rmap_walk *walk);
> +	struct page *reuse;
> +	struct list_head *vmemmap_pages;
> +};
> +
> +/*
> + * The index of the pte page table which is mapped to the tail of the
> + * vmemmap page.
> + */
> +#define VMEMMAP_TAIL_PAGE_REUSE		-1

That is the index/offset from the range to be remapped.  See comments below.

> +
> +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> +			      unsigned long end, struct vmemmap_rmap_walk *walk)
> +{
> +	pte_t *pte;
> +
> +	pte = pte_offset_kernel(pmd, addr);
> +	do {
> +		BUG_ON(pte_none(*pte));
> +
> +		if (!walk->reuse)
> +			walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);

It may be just me, but I don't like the pte[-1] here.  It certainly does work
as designed because we want to remap all pages in the range to the page before
the range (at offset -1).  But, we do not really validate this 'reuse' page.
There is the BUG_ON(pte_none(*pte)) as a sanity check, but we do nothing similar
for pte[-1].  Based on the usage for HugeTLB pages, we can be confident that
pte[-1] is actually a pte.  In discussions with Oscar, you mentioned another
possible use for these routines.

Don't change anything based on my opinion only.  I would like to see what
others think as well.

> +
> +		if (walk->rmap_pte)
> +			walk->rmap_pte(pte, addr, walk);
> +	} while (pte++, addr += PAGE_SIZE, addr != end);
> +}
> +
> +static void vmemmap_pmd_range(pud_t *pud, unsigned long addr,
> +			      unsigned long end, struct vmemmap_rmap_walk *walk)
> +{
> +	pmd_t *pmd;
> +	unsigned long next;
> +
> +	pmd = pmd_offset(pud, addr);
> +	do {
> +		BUG_ON(pmd_none(*pmd));
> +
> +		next = pmd_addr_end(addr, end);
> +		vmemmap_pte_range(pmd, addr, next, walk);
> +	} while (pmd++, addr = next, addr != end);
> +}
> +
> +static void vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
> +			      unsigned long end, struct vmemmap_rmap_walk *walk)
> +{
> +	pud_t *pud;
> +	unsigned long next;
> +
> +	pud = pud_offset(p4d, addr);
> +	do {
> +		BUG_ON(pud_none(*pud));
> +
> +		next = pud_addr_end(addr, end);
> +		vmemmap_pmd_range(pud, addr, next, walk);
> +	} while (pud++, addr = next, addr != end);
> +}
> +
> +static void vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
> +			      unsigned long end, struct vmemmap_rmap_walk *walk)
> +{
> +	p4d_t *p4d;
> +	unsigned long next;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	do {
> +		BUG_ON(p4d_none(*p4d));
> +
> +		next = p4d_addr_end(addr, end);
> +		vmemmap_pud_range(p4d, addr, next, walk);
> +	} while (p4d++, addr = next, addr != end);
> +}
> +
> +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> +				struct vmemmap_rmap_walk *walk)
> +{
> +	unsigned long addr = start;
> +	unsigned long next;
> +	pgd_t *pgd;
> +
> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +
> +	pgd = pgd_offset_k(addr);
> +	do {
> +		BUG_ON(pgd_none(*pgd));
> +
> +		next = pgd_addr_end(addr, end);
> +		vmemmap_p4d_range(pgd, addr, next, walk);
> +	} while (pgd++, addr = next, addr != end);
> +
> +	flush_tlb_kernel_range(start, end);
> +}
> +
> +/*
> + * Free a vmemmap page. A vmemmap page can be allocated from the memblock
> + * allocator or buddy allocator. If the PG_reserved flag is set, it means
> + * that it allocated from the memblock allocator, just free it via the
> + * free_bootmem_page(). Otherwise, use __free_page().
> + */
> +static inline void free_vmemmap_page(struct page *page)
> +{
> +	if (PageReserved(page))
> +		free_bootmem_page(page);
> +	else
> +		__free_page(page);
> +}
> +
> +/* Free a list of the vmemmap pages */
> +static void free_vmemmap_page_list(struct list_head *list)
> +{
> +	struct page *page, *next;
> +
> +	list_for_each_entry_safe(page, next, list, lru) {
> +		list_del(&page->lru);
> +		free_vmemmap_page(page);
> +	}
> +}
> +
> +static void vmemmap_remap_reuse_pte(pte_t *pte, unsigned long addr,
> +				    struct vmemmap_rmap_walk *walk)

See vmemmap_remap_reuse rename suggestion below.  I would suggest reuse
be dropped from the name here and just be called 'vmemmap_remap_pte'.

> +{
> +	/*
> +	 * Make the tail pages are mapped with read-only to catch
> +	 * illegal write operation to the tail pages.
> +	 */
> +	pgprot_t pgprot = PAGE_KERNEL_RO;
> +	pte_t entry = mk_pte(walk->reuse, pgprot);
> +	struct page *page;
> +
> +	page = pte_page(*pte);
> +	list_add(&page->lru, walk->vmemmap_pages);
> +
> +	set_pte_at(&init_mm, addr, pte, entry);
> +}
> +
> +/**
> + * vmemmap_remap_reuse - remap the vmemmap virtual address range

My original commnet here was:

Not sure if the word '_reuse' is best in this function name.  To me, the name
implies this routine will reuse vmemmap pages.  Perhaps, it makes more sense
to rename as 'vmemmap_remap_free'?  It will first remap, then free vmemmap.

But, then I looked at the code above and perhaps you are using the word
'_reuse' because the page before the range will be reused?  The vmemmap
page at offset VMEMMAP_TAIL_PAGE_REUSE (-1).

> + *                       [start, start + size) to the page which
> + *                       [start - PAGE_SIZE, start) is mapped.
> + * @start:	start address of the vmemmap virtual address range
> + * @end:	size of the vmemmap virtual address range

      ^^^^ should be @size:

-- 
Mike Kravetz

> + */
> +void vmemmap_remap_reuse(unsigned long start, unsigned long size)
> +{
> +	unsigned long end = start + size;
> +	LIST_HEAD(vmemmap_pages);
> +
> +	struct vmemmap_rmap_walk walk = {
> +		.rmap_pte	= vmemmap_remap_reuse_pte,
> +		.vmemmap_pages	= &vmemmap_pages,
> +	};
> +
> +	vmemmap_remap_range(start, end, &walk);
> +	free_vmemmap_page_list(&vmemmap_pages);
> +}
>  
>  /*
>   * Allocate a block of memory to be used to back the virtual memory map
> 
