Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9D2DCB9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 05:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLQEH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 23:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgLQEH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 23:07:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE877C0617B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 20:06:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y8so14404859plp.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 20:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuQTsm5m78rhlvOaQpHCZ0Hy/MeDPaNHg0VT5s/kHYM=;
        b=1LoQvEKMIYgQcUpFFzzAuB3i3uLtLEzZI2cxrr21ZhixUFJoeznemU9MvY7i+2t7Xq
         Ap3/zHcE4UUBJCwwbGrXrEfVHf/gwgI/gKcytUrP1zHoe9hszsNNBWGfMHHun7kC/fo2
         CRvXpyevmVDetwvl104xCgbVhMOJ1dX9i/cYwFeIleppDtziIDTtEbE0oTgPviLFznLw
         qWae2+cJl38TL13fpZeZNoPT3drlSOEjYj1sKcN+PcNoaJohUj8ww0O6Lb0sr42owa1L
         y8H1u1Wbz/WX5iGCRHmcUw5ARlJDsEanRzdRhmX4JxLpg/XNBJHR2u1BNYUt8Ol9k8NU
         aR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuQTsm5m78rhlvOaQpHCZ0Hy/MeDPaNHg0VT5s/kHYM=;
        b=udBTP0nngMG+C2qRK+NDoNDoJqi0QaVISnd3DlO8DtW/COwqgq8hxCRo7iAdUMYkEP
         i10x7DDJiYBYYC9WOLlLA3r5HIlEF86pirjIBtpa0MSPUpO+3SoJ2hAHXX05oGUhvreh
         7d6Jq6wzN0BtxJ0WhUaxkv0hBP87nfMaXDTLgLyMLeJg8IFRuICuKgm2BhTNiT4bGj/T
         ZRtI0HFZwTltJqGbJzEzOEYC++IG+fHNbzgTx+jL6CHjAgtpD5xKH2HvSVpum83lyet8
         +cm8E8U9ni4PW5Xay7xd+eU+itc+337XnHFfsle73TisCstKxfPoL+/D1N6ySP/hF/fc
         Ir3w==
X-Gm-Message-State: AOAM530qW/8kWKf8Txn0R/VHiXn09ksnIY2isNrJEm1fxm1d+aL1wEGj
        r94vjVWBS9NwzGpxumCOaY1piPWJGm23jfEhXCOGtQ==
X-Google-Smtp-Source: ABdhPJyaPTdCa5ikXoniElng2cjsW6oqyjFvGVlQ86dsmp5zc7Oapc7xBkAFMeQCq7H+mZ58wjmyxm3fUwnsF58z4uA=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr6219952pjh.13.1608178006045;
 Wed, 16 Dec 2020 20:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-4-songmuchun@bytedance.com> <5936a766-505a-eab0-42a6-59aab2585880@oracle.com>
In-Reply-To: <5936a766-505a-eab0-42a6-59aab2585880@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 17 Dec 2020 12:06:09 +0800
Message-ID: <CAMZfGtXmQrdLeMs4dz60aPuLzNogEdN35EAeLRT-26gZtW64vA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 03/11] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 6:08 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/13/20 7:45 AM, Muchun Song wrote:
> > Every HugeTLB has more than one struct page structure. We __know__ that
> > we only use the first 4(HUGETLB_CGROUP_MIN_ORDER) struct page structures
> > to store metadata associated with each HugeTLB.
> >
> > There are a lot of struct page structures associated with each HugeTLB
> > page. For tail pages, the value of compound_head is the same. So we can
> > reuse first page of tail page structures. We map the virtual addresses
> > of the remaining pages of tail page structures to the first tail page
> > struct, and then free these page frames. Therefore, we need to reserve
> > two pages as vmemmap areas.
> >
> > When we allocate a HugeTLB page from the buddy, we can free some vmemmap
> > pages associated with each HugeTLB page. It is more appropriate to do it
> > in the prep_new_huge_page().
> >
> > The free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
> > pages associated with a HugeTLB page can be freed, returns zero for
> > now, which means the feature is disabled. We will enable it once all
> > the infrastructure is there.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/bootmem_info.h |  27 +++++-
> >  include/linux/mm.h           |   2 +
> >  mm/Makefile                  |   1 +
> >  mm/hugetlb.c                 |   3 +
> >  mm/hugetlb_vmemmap.c         | 209 +++++++++++++++++++++++++++++++++++++++++++
> >  mm/hugetlb_vmemmap.h         |  20 +++++
> >  mm/sparse-vmemmap.c          | 170 +++++++++++++++++++++++++++++++++++
> >  7 files changed, 431 insertions(+), 1 deletion(-)
> >  create mode 100644 mm/hugetlb_vmemmap.c
> >  create mode 100644 mm/hugetlb_vmemmap.h
>
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index 16183d85a7d5..78c527617e8d 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -27,8 +27,178 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sched.h>
> > +#include <linux/pgtable.h>
> > +#include <linux/bootmem_info.h>
> > +
> >  #include <asm/dma.h>
> >  #include <asm/pgalloc.h>
> > +#include <asm/tlbflush.h>
> > +
> > +/*
> > + * vmemmap_rmap_walk - walk vmemmap page table
>
> I am not sure if 'rmap' should be part of these names.  rmap today is mostly
> about reverse mapping lookup.  Did you use rmap for 'remap', or because this
> code is patterned after the page table walking rmap code?  Just think the
> naming could cause some confusion.

Yeah. I should use "remap" to avoid confusion.

>
> > + *
> > + * @rmap_pte:                called for each non-empty PTE (lowest-level) entry.
> > + * @reuse:           the page which is reused for the tail vmemmap pages.
> > + * @vmemmap_pages:   the list head of the vmemmap pages that can be freed.
> > + */
> > +struct vmemmap_rmap_walk {
> > +     void (*rmap_pte)(pte_t *pte, unsigned long addr,
> > +                      struct vmemmap_rmap_walk *walk);
> > +     struct page *reuse;
> > +     struct list_head *vmemmap_pages;
> > +};
> > +
> > +/*
> > + * The index of the pte page table which is mapped to the tail of the
> > + * vmemmap page.
> > + */
> > +#define VMEMMAP_TAIL_PAGE_REUSE              -1
>
> That is the index/offset from the range to be remapped.  See comments below.

You are right. I need to update the comment.

>
> > +
> > +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> > +                           unsigned long end, struct vmemmap_rmap_walk *walk)
> > +{
> > +     pte_t *pte;
> > +
> > +     pte = pte_offset_kernel(pmd, addr);
> > +     do {
> > +             BUG_ON(pte_none(*pte));
> > +
> > +             if (!walk->reuse)
> > +                     walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
>
> It may be just me, but I don't like the pte[-1] here.  It certainly does work
> as designed because we want to remap all pages in the range to the page before
> the range (at offset -1).  But, we do not really validate this 'reuse' page.
> There is the BUG_ON(pte_none(*pte)) as a sanity check, but we do nothing similar
> for pte[-1].  Based on the usage for HugeTLB pages, we can be confident that
> pte[-1] is actually a pte.  In discussions with Oscar, you mentioned another
> possible use for these routines.

Yeah, we should add a BUG_ON for pte[-1].

>
> Don't change anything based on my opinion only.  I would like to see what
> others think as well.
>
> > +
> > +             if (walk->rmap_pte)
> > +                     walk->rmap_pte(pte, addr, walk);
> > +     } while (pte++, addr += PAGE_SIZE, addr != end);
> > +}
> > +
> > +static void vmemmap_pmd_range(pud_t *pud, unsigned long addr,
> > +                           unsigned long end, struct vmemmap_rmap_walk *walk)
> > +{
> > +     pmd_t *pmd;
> > +     unsigned long next;
> > +
> > +     pmd = pmd_offset(pud, addr);
> > +     do {
> > +             BUG_ON(pmd_none(*pmd));
> > +
> > +             next = pmd_addr_end(addr, end);
> > +             vmemmap_pte_range(pmd, addr, next, walk);
> > +     } while (pmd++, addr = next, addr != end);
> > +}
> > +
> > +static void vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
> > +                           unsigned long end, struct vmemmap_rmap_walk *walk)
> > +{
> > +     pud_t *pud;
> > +     unsigned long next;
> > +
> > +     pud = pud_offset(p4d, addr);
> > +     do {
> > +             BUG_ON(pud_none(*pud));
> > +
> > +             next = pud_addr_end(addr, end);
> > +             vmemmap_pmd_range(pud, addr, next, walk);
> > +     } while (pud++, addr = next, addr != end);
> > +}
> > +
> > +static void vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
> > +                           unsigned long end, struct vmemmap_rmap_walk *walk)
> > +{
> > +     p4d_t *p4d;
> > +     unsigned long next;
> > +
> > +     p4d = p4d_offset(pgd, addr);
> > +     do {
> > +             BUG_ON(p4d_none(*p4d));
> > +
> > +             next = p4d_addr_end(addr, end);
> > +             vmemmap_pud_range(p4d, addr, next, walk);
> > +     } while (p4d++, addr = next, addr != end);
> > +}
> > +
> > +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> > +                             struct vmemmap_rmap_walk *walk)
> > +{
> > +     unsigned long addr = start;
> > +     unsigned long next;
> > +     pgd_t *pgd;
> > +
> > +     VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> > +     VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> > +
> > +     pgd = pgd_offset_k(addr);
> > +     do {
> > +             BUG_ON(pgd_none(*pgd));
> > +
> > +             next = pgd_addr_end(addr, end);
> > +             vmemmap_p4d_range(pgd, addr, next, walk);
> > +     } while (pgd++, addr = next, addr != end);
> > +
> > +     flush_tlb_kernel_range(start, end);
> > +}
> > +
> > +/*
> > + * Free a vmemmap page. A vmemmap page can be allocated from the memblock
> > + * allocator or buddy allocator. If the PG_reserved flag is set, it means
> > + * that it allocated from the memblock allocator, just free it via the
> > + * free_bootmem_page(). Otherwise, use __free_page().
> > + */
> > +static inline void free_vmemmap_page(struct page *page)
> > +{
> > +     if (PageReserved(page))
> > +             free_bootmem_page(page);
> > +     else
> > +             __free_page(page);
> > +}
> > +
> > +/* Free a list of the vmemmap pages */
> > +static void free_vmemmap_page_list(struct list_head *list)
> > +{
> > +     struct page *page, *next;
> > +
> > +     list_for_each_entry_safe(page, next, list, lru) {
> > +             list_del(&page->lru);
> > +             free_vmemmap_page(page);
> > +     }
> > +}
> > +
> > +static void vmemmap_remap_reuse_pte(pte_t *pte, unsigned long addr,
> > +                                 struct vmemmap_rmap_walk *walk)
>
> See vmemmap_remap_reuse rename suggestion below.  I would suggest reuse
> be dropped from the name here and just be called 'vmemmap_remap_pte'.

OK. Will do that.

>
> > +{
> > +     /*
> > +      * Make the tail pages are mapped with read-only to catch
> > +      * illegal write operation to the tail pages.
> > +      */
> > +     pgprot_t pgprot = PAGE_KERNEL_RO;
> > +     pte_t entry = mk_pte(walk->reuse, pgprot);
> > +     struct page *page;
> > +
> > +     page = pte_page(*pte);
> > +     list_add(&page->lru, walk->vmemmap_pages);
> > +
> > +     set_pte_at(&init_mm, addr, pte, entry);
> > +}
> > +
> > +/**
> > + * vmemmap_remap_reuse - remap the vmemmap virtual address range
>
> My original commnet here was:
>
> Not sure if the word '_reuse' is best in this function name.  To me, the name
> implies this routine will reuse vmemmap pages.  Perhaps, it makes more sense
> to rename as 'vmemmap_remap_free'?  It will first remap, then free vmemmap.

The vmemmap_remap_free is also a good name to me.
In the next patch, we can use vmemmap_remap_alloc for
allocating vmemmap pages. Looks very symmetrical. :-)

Thanks Mike.

>
> But, then I looked at the code above and perhaps you are using the word
> '_reuse' because the page before the range will be reused?  The vmemmap

Yeah. You are right.

> page at offset VMEMMAP_TAIL_PAGE_REUSE (-1).
>
> > + *                       [start, start + size) to the page which
> > + *                       [start - PAGE_SIZE, start) is mapped.
> > + * @start:   start address of the vmemmap virtual address range
> > + * @end:     size of the vmemmap virtual address range
>
>       ^^^^ should be @size:

Oh, Yeah. Forgot to update it. Thanks.

>
> --
> Mike Kravetz
>
> > + */
> > +void vmemmap_remap_reuse(unsigned long start, unsigned long size)
> > +{
> > +     unsigned long end = start + size;
> > +     LIST_HEAD(vmemmap_pages);
> > +
> > +     struct vmemmap_rmap_walk walk = {
> > +             .rmap_pte       = vmemmap_remap_reuse_pte,
> > +             .vmemmap_pages  = &vmemmap_pages,
> > +     };
> > +
> > +     vmemmap_remap_range(start, end, &walk);
> > +     free_vmemmap_page_list(&vmemmap_pages);
> > +}
> >
> >  /*
> >   * Allocate a block of memory to be used to back the virtual memory map
> >



-- 
Yours,
Muchun
