Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B216C29D7E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbgJ1W2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732872AbgJ1W1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:48 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B0C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 15:27:48 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u127so1232090oib.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 15:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFVMIrLdCxV+8cp8GWoWf3/5fAgqPZAXfATkx0X3HRI=;
        b=086mSmYNIKquvUs/3FC33XpsVOTW3Qu76/x5SHnCISOWO7PoMcOtMKpnf6YwvyXtWB
         aVkxPco0eXT5sebizGVALWfK7l/mloGkmvFhYSfkvujPlWMxB92gkENSYqGfl/x6A47O
         3ZsD+s4AZackwpMGyzvoCgDtJebFSPTaVA7tlY8X+3YCmb15eBdQgtNLDFbvShQ5GLna
         lNq6bCm/nv0eq30LsJk1kNX7UMGNtOS00lVj+I8U5Hd583ZZjtjGuemnrMdPZlxe+XdA
         cwmZsRIQWvOaEfEo/LFog+Pqh9o1/M8GEIQcLQWrazWaiqpdou1KIDcg3GmFkasnHgel
         ZjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFVMIrLdCxV+8cp8GWoWf3/5fAgqPZAXfATkx0X3HRI=;
        b=Blkez+sUUWUoQ9MciPwhT2n6FledI5cL1mJ/UX71PdIUyOcGvr+6kvGKnBsajcjPZ7
         lupwcOI+8MXV87cITVK9CxSNZrTwf7v8QOuNCmKngfbu3xE8JswrFGQPAT915nhZGiP1
         vjnnNPG9MLn97wlJmV1vV/iqLiFWR1Hk+6iM3DInz9jX074Rzr3SpsUJ24KeeVCFC33b
         4Y6CL5A+QhbtQE+8UyOp6RPVdi9EsCYoYT+pxsRkYiS+Z/hrd98l1ZXjJHRtYZgO0jU3
         /8+QWj4ew5gmCg4a9Jei+5AFL3LGwjNPJvdRyBaM/flp0cqMeAzf0QzCcnJAzkDWMfVa
         FdKw==
X-Gm-Message-State: AOAM533QMsypIunLEOJEdcc8fzHVNQ/27CthJFRXdCavXzVsiDUxhJ9q
        QTb60nCjLpzATT/urIIilQsuzwjeJcVXmnesLudRqSLClUL10i7b
X-Google-Smtp-Source: ABdhPJz39oMPi6YrX9/B/1ZjqP5C8IWRl2J8WjAA1b9U6+Ei/bQPgo8wmN0cxwmD0qErFckBlhXeahkf6JuLDLeWbzA=
X-Received: by 2002:a17:90b:198d:: with SMTP id mv13mr5681238pjb.13.1603870040809;
 Wed, 28 Oct 2020 00:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-6-songmuchun@bytedance.com> <81a7a7f0-fe0e-42e4-8de0-9092b033addc@oracle.com>
In-Reply-To: <81a7a7f0-fe0e-42e4-8de0-9092b033addc@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 28 Oct 2020 15:26:44 +0800
Message-ID: <CAMZfGtVV5eZS-LFtU89WSdMGCib8WX0AojkL-4X+_5yvuMz2Ew@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 05/19] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 8:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/26/20 7:51 AM, Muchun Song wrote:
> > On some architectures, the vmemmap areas use huge page mapping.
> > If we want to free the unused vmemmap pages, we have to split
> > the huge pmd firstly. So we should pre-allocate pgtable to split
> > huge pmd.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/x86/include/asm/hugetlb.h |   5 ++
> >  include/linux/hugetlb.h        |  17 +++++
> >  mm/hugetlb.c                   | 117 +++++++++++++++++++++++++++++++++
> >  3 files changed, 139 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> > index 1721b1aadeb1..f5e882f999cd 100644
> > --- a/arch/x86/include/asm/hugetlb.h
> > +++ b/arch/x86/include/asm/hugetlb.h
> > @@ -5,6 +5,11 @@
> >  #include <asm/page.h>
> >  #include <asm-generic/hugetlb.h>
> >
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +#define VMEMMAP_HPAGE_SHIFT                  PMD_SHIFT
> > +#define arch_vmemmap_support_huge_mapping()  boot_cpu_has(X86_FEATURE_PSE)
> > +#endif
> > +
> >  #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
> >
> >  #endif /* _ASM_X86_HUGETLB_H */
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index eed3dd3bd626..ace304a6196c 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -593,6 +593,23 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
> >
> >  #include <asm/hugetlb.h>
> >
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +#ifndef arch_vmemmap_support_huge_mapping
> > +static inline bool arch_vmemmap_support_huge_mapping(void)
> > +{
> > +     return false;
> > +}
> > +#endif
> > +
> > +#ifndef VMEMMAP_HPAGE_SHIFT
> > +#define VMEMMAP_HPAGE_SHIFT          PMD_SHIFT
> > +#endif
> > +#define VMEMMAP_HPAGE_ORDER          (VMEMMAP_HPAGE_SHIFT - PAGE_SHIFT)
> > +#define VMEMMAP_HPAGE_NR             (1 << VMEMMAP_HPAGE_ORDER)
> > +#define VMEMMAP_HPAGE_SIZE           ((1UL) << VMEMMAP_HPAGE_SHIFT)
> > +#define VMEMMAP_HPAGE_MASK           (~(VMEMMAP_HPAGE_SIZE - 1))
> > +#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
> > +
> >  #ifndef is_hugepage_only_range
> >  static inline int is_hugepage_only_range(struct mm_struct *mm,
> >                                       unsigned long addr, unsigned long len)
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f1b2b733b49b..d6ae9b6876be 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1295,11 +1295,108 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> >  #define RESERVE_VMEMMAP_NR   2U
> >
> > +#define page_huge_pte(page)  ((page)->pmd_huge_pte)
> > +
>
> I am not good at function names.  The following suggestions may be too
> verbose.  However, they helped me understand purpose of routines.
>
> >  static inline unsigned int nr_free_vmemmap(struct hstate *h)
>
>         perhaps?                free_vmemmap_pages_per_hpage()
>
> >  {
> >       return h->nr_free_vmemmap_pages;
> >  }
> >
> > +static inline unsigned int nr_vmemmap(struct hstate *h)
>
>         perhaps?                vmemmap_pages_per_hpage()
>
> > +{
> > +     return nr_free_vmemmap(h) + RESERVE_VMEMMAP_NR;
> > +}
> > +
> > +static inline unsigned long nr_vmemmap_size(struct hstate *h)
>
>         perhaps?                vmemmap_pages_size_per_hpage()
>
> > +{
> > +     return (unsigned long)nr_vmemmap(h) << PAGE_SHIFT;
> > +}
> > +
> > +static inline unsigned int nr_pgtable(struct hstate *h)
>
>         perhaps?        pgtable_pages_to_prealloc_per_hpage()

Good suggestions. Thanks. I will apply this.

>
> > +{
> > +     unsigned long vmemmap_size = nr_vmemmap_size(h);
> > +
> > +     if (!arch_vmemmap_support_huge_mapping())
> > +             return 0;
> > +
> > +     /*
> > +      * No need pre-allocate page tabels when there is no vmemmap pages
> > +      * to free.
> > +      */
> > +     if (!nr_free_vmemmap(h))
> > +             return 0;
> > +
> > +     return ALIGN(vmemmap_size, VMEMMAP_HPAGE_SIZE) >> VMEMMAP_HPAGE_SHIFT;
> > +}
> > +
> > +static inline void vmemmap_pgtable_init(struct page *page)
> > +{
> > +     page_huge_pte(page) = NULL;
> > +}
> > +
>
> I see the following routines follow the pattern for vmemmap manipulation
> in dax.

Did you mean move those functions to mm/sparse-vmemmap.c?

>
> > +static void vmemmap_pgtable_deposit(struct page *page, pte_t *pte_p)
> > +{
> > +     pgtable_t pgtable = virt_to_page(pte_p);
> > +
> > +     /* FIFO */
> > +     if (!page_huge_pte(page))
> > +             INIT_LIST_HEAD(&pgtable->lru);
> > +     else
> > +             list_add(&pgtable->lru, &page_huge_pte(page)->lru);
> > +     page_huge_pte(page) = pgtable;
> > +}
> > +
> > +static pte_t *vmemmap_pgtable_withdraw(struct page *page)
> > +{
> > +     pgtable_t pgtable;
> > +
> > +     /* FIFO */
> > +     pgtable = page_huge_pte(page);
> > +     if (unlikely(!pgtable))
> > +             return NULL;
> > +     page_huge_pte(page) = list_first_entry_or_null(&pgtable->lru,
> > +                                                    struct page, lru);
> > +     if (page_huge_pte(page))
> > +             list_del(&pgtable->lru);
> > +     return page_to_virt(pgtable);
> > +}
> > +
> > +static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> > +{
> > +     int i;
> > +     pte_t *pte_p;
> > +     unsigned int nr = nr_pgtable(h);
> > +
> > +     if (!nr)
> > +             return 0;
> > +
> > +     vmemmap_pgtable_init(page);
> > +
> > +     for (i = 0; i < nr; i++) {
> > +             pte_p = pte_alloc_one_kernel(&init_mm);
> > +             if (!pte_p)
> > +                     goto out;
> > +             vmemmap_pgtable_deposit(page, pte_p);
> > +     }
> > +
> > +     return 0;
> > +out:
> > +     while (i-- && (pte_p = vmemmap_pgtable_withdraw(page)))
> > +             pte_free_kernel(&init_mm, pte_p);
> > +     return -ENOMEM;
> > +}
> > +
> > +static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
> > +{
> > +     pte_t *pte_p;
> > +
> > +     if (!nr_pgtable(h))
> > +             return;
> > +
> > +     while ((pte_p = vmemmap_pgtable_withdraw(page)))
> > +             pte_free_kernel(&init_mm, pte_p);
> > +}
> > +
> >  static void __init hugetlb_vmemmap_init(struct hstate *h)
> >  {
> >       unsigned int order = huge_page_order(h);
> > @@ -1323,6 +1420,15 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
> >  static inline void hugetlb_vmemmap_init(struct hstate *h)
> >  {
> >  }
> > +
> > +static inline int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
> > +{
> > +}
> >  #endif
> >
> >  static void update_and_free_page(struct hstate *h, struct page *page)
> > @@ -1531,6 +1637,9 @@ void free_huge_page(struct page *page)
> >
> >  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> >  {
> > +     /* Must be called before the initialization of @page->lru */
> > +     vmemmap_pgtable_free(h, page);
> > +
> >       INIT_LIST_HEAD(&page->lru);
> >       set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> >       set_hugetlb_cgroup(page, NULL);
> > @@ -1783,6 +1892,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
> >       if (!page)
> >               return NULL;
> >
> > +     if (vmemmap_pgtable_prealloc(h, page)) {
> > +             if (hstate_is_gigantic(h))
> > +                     free_gigantic_page(page, huge_page_order(h));
> > +             else
> > +                     put_page(page);
> > +             return NULL;
> > +     }
> > +
>
> It seems a bit strange that we will fail a huge page allocation if
> vmemmap_pgtable_prealloc fails.  Not sure, but it almost seems like we shold
> allow the allocation and log a warning?  It is somewhat unfortunate that
> we need to allocate a page to free pages.

Yeah, it seems unfortunate. But if we allocate success, we can free some
vmemmap pages later. Like a compromise :) . If we can successfully allocate
a huge page, I also prefer to be able to successfully allocate another one page.
If we allow the allocation when vmemmap_pgtable_prealloc fails, we also
need to mark this page that vmemmap has not been released. Seems
increase complexity.

Thanks.

>
> >       if (hstate_is_gigantic(h))
> >               prep_compound_gigantic_page(page, huge_page_order(h));
> >       prep_new_huge_page(h, page, page_to_nid(page));
> >
>
>
> --
> Mike Kravetz



-- 
Yours,
Muchun
