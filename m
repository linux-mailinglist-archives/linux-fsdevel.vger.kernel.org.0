Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9635629E578
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 08:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgJ2H5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgJ2HYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CA2C05BD43
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 23:14:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z24so1497382pgk.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VtAN6G22pJOh6fcjwqaPieJIRASqqNS7bQLlv3fatE=;
        b=Mo3bTUZT4n1TxUsRmamPvW/bRHY3F8JOUuPfToXe1PjgrhXDMzJPLZtchyHCADEh1X
         ikB2FzbirVTnhNxtInNO+UexRZKi2oh9K3cxQpYUHhr7DTtwUyUNJT8dqQomEDt+2yUv
         H5jfIHOY+WFFlH/uHJoCss+ozuxv5O3pZ8ElaCCEqgZDqSEihGLR9jtghXJ/yON/Ibsp
         r2eah1oE3HUeyd/h5tYUReK7MAYCPCYTsGzX8LFmhTtrD5gWLMA7dvbNZZdaYloe51AL
         RGGPF5++MEahejDHAJcDpWm/+UD024PFb1JSLfIae5W1pyK9K7jmyHNcShTDqNOEAWuO
         wzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VtAN6G22pJOh6fcjwqaPieJIRASqqNS7bQLlv3fatE=;
        b=O6JIP467NjeOKy2q3aJQH4blUSM71ryOPCZkjLeamf7xtAzaTU3KMrjuoms+OMcEYq
         ldqOJTSseV3QTkhZxxmuDkRIG0YS1AfCzv71p3BkYv3sE4NciZJxqzGpTfoYUsiCLwjf
         Lf4wXc0eM9oH0I6neGGRZaXewfNMUoByup+5ssB9QCOc+pxsj0R6egVy7hI/yVmvzxej
         rDYTgn3/DW/H8Q6EZtNOH79dpI2vWwK+SNKvnbaa5TSYmvrfCwT4LmvwROKQtNHd0kht
         hZVnzvnPtASIEUhrXMa/9xCEDcrxFNu3r9y9f/w4VYyMuoRPBDEr9r7TJYcqKokh+0ll
         1axA==
X-Gm-Message-State: AOAM530IzDwjrRPQEEDo6dkE6ywNUT/v+IQ5qU+GfcUPgK/pB7e96Lwr
        fIxAm5q85e2MA3qlU+IOpp/QgTh1NmoVERgovu0Xpg==
X-Google-Smtp-Source: ABdhPJymW0ni/MD9aGSwED4oKtgCt2QhumQXM0N101k9iTMY9fZPgtViehJ3XByHjnsp5g4EcZhrjzKGnDJ9S8M9pYg=
X-Received: by 2002:a63:7408:: with SMTP id p8mr2604482pgc.273.1603952053682;
 Wed, 28 Oct 2020 23:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-8-songmuchun@bytedance.com> <8658f431-56c4-9774-861a-9c3b54d1910a@oracle.com>
In-Reply-To: <8658f431-56c4-9774-861a-9c3b54d1910a@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Oct 2020 14:13:36 +0800
Message-ID: <CAMZfGtUUkkkeENXOOLPacverqyudxntTenMKrtpfHnLOBJaX5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 07/19] mm/hugetlb: Free the vmemmap
 pages associated with each hugetlb page
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

On Thu, Oct 29, 2020 at 7:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/26/20 7:51 AM, Muchun Song wrote:
> > When we allocate a hugetlb page from the buddy, we should free the
> > unused vmemmap pages associated with it. We can do that in the
> > prep_new_huge_page().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/x86/include/asm/hugetlb.h          |   7 +
> >  arch/x86/include/asm/pgtable_64_types.h |   8 +
> >  include/linux/hugetlb.h                 |   7 +
> >  mm/hugetlb.c                            | 190 ++++++++++++++++++++++++
> >  4 files changed, 212 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> > index f5e882f999cd..7c3eb60c2198 100644
> > --- a/arch/x86/include/asm/hugetlb.h
> > +++ b/arch/x86/include/asm/hugetlb.h
> > @@ -4,10 +4,17 @@
> >
> >  #include <asm/page.h>
> >  #include <asm-generic/hugetlb.h>
> > +#include <asm/pgtable.h>
> >
> >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> >  #define VMEMMAP_HPAGE_SHIFT                  PMD_SHIFT
> >  #define arch_vmemmap_support_huge_mapping()  boot_cpu_has(X86_FEATURE_PSE)
> > +
> > +#define vmemmap_pmd_huge vmemmap_pmd_huge
> > +static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> > +{
> > +     return pmd_large(*pmd);
> > +}
> >  #endif
> >
> >  #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
> > diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> > index 52e5f5f2240d..bedbd2e7d06c 100644
> > --- a/arch/x86/include/asm/pgtable_64_types.h
> > +++ b/arch/x86/include/asm/pgtable_64_types.h
> > @@ -139,6 +139,14 @@ extern unsigned int ptrs_per_p4d;
> >  # define VMEMMAP_START               __VMEMMAP_BASE_L4
> >  #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
> >
> > +/*
> > + * VMEMMAP_SIZE - allows the whole linear region to be covered by
> > + *                a struct page array.
> > + */
> > +#define VMEMMAP_SIZE         (1UL << (__VIRTUAL_MASK_SHIFT - PAGE_SHIFT - \
> > +                                      1 + ilog2(sizeof(struct page))))
> > +#define VMEMMAP_END          (VMEMMAP_START + VMEMMAP_SIZE)
> > +
> >  #define VMALLOC_END          (VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
> >
> >  #define MODULES_VADDR                (__START_KERNEL_map + KERNEL_IMAGE_SIZE)
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index ace304a6196c..919f47d77117 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -601,6 +601,13 @@ static inline bool arch_vmemmap_support_huge_mapping(void)
> >  }
> >  #endif
> >
> > +#ifndef vmemmap_pmd_huge
>
> Let's add
> #define vmemmap_pmd_huge vmemmap_pmd_huge
> just in case code gets moved around in header file.

OK, will do.

>
> > +static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> > +{
> > +     return pmd_huge(*pmd);
> > +}
> > +#endif
> > +
> >  #ifndef VMEMMAP_HPAGE_SHIFT
> >  #define VMEMMAP_HPAGE_SHIFT          PMD_SHIFT
> >  #endif
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index d6ae9b6876be..aa012d603e06 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1293,10 +1293,20 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >  #endif
> >
> >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +#include <linux/bootmem_info.h>
> > +
> >  #define RESERVE_VMEMMAP_NR   2U
> > +#define RESERVE_VMEMMAP_SIZE (RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>
> Since RESERVE_VMEMMAP_SIZE is not used here, perhaps it should be added
> in the patch where it is first used.

Will do.

>
> >
> >  #define page_huge_pte(page)  ((page)->pmd_huge_pte)
> >
> > +#define vmemmap_hpage_addr_end(addr, end)                            \
> > +({                                                                   \
> > +     unsigned long __boundary;                                       \
> > +     __boundary = ((addr) + VMEMMAP_HPAGE_SIZE) & VMEMMAP_HPAGE_MASK;\
> > +     (__boundary - 1 < (end) - 1) ? __boundary : (end);              \
> > +})
> > +
> >  static inline unsigned int nr_free_vmemmap(struct hstate *h)
> >  {
> >       return h->nr_free_vmemmap_pages;
> > @@ -1416,6 +1426,181 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
> >       pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
> >               h->nr_free_vmemmap_pages, h->name);
> >  }
> > +
> > +static inline spinlock_t *vmemmap_pmd_lockptr(pmd_t *pmd)
> > +{
> > +     static DEFINE_SPINLOCK(pgtable_lock);
> > +
> > +     return &pgtable_lock;
> > +}
>
> This is just a global lock.  Correct?  And hugetlb specific?

Yes, it is a global lock. Originally, I wanted to use the pmd lock(e.g.
pmd_lockptr()). But we need to allocate memory for the spinlock and
initialize it when ALLOC_SPLIT_PTLOCKS. It may increase the
complexity.

And I think that here alloc/free hugetlb pages is not a frequent operation.
So I finally use a global lock. Maybe it is enough.

>
> It should be OK as the page table entries for huegtlb pages will not
> overlap with other entries.

Does "hugetlb specific" mean the pmd lock? or per hugetlb lock?
If it is pmd lock, this is fine to me. If not, it may not be enough.
Because the lock also guards the splitting of pmd pgtable.

Thanks.
>
> > +
> > +/*
> > + * Walk a vmemmap address to the pmd it maps.
> > + */
> > +static pmd_t *vmemmap_to_pmd(const void *page)
> > +{
> > +     unsigned long addr = (unsigned long)page;
> > +     pgd_t *pgd;
> > +     p4d_t *p4d;
> > +     pud_t *pud;
> > +     pmd_t *pmd;
> > +
> > +     if (addr < VMEMMAP_START || addr >= VMEMMAP_END)
> > +             return NULL;
> > +
> > +     pgd = pgd_offset_k(addr);
> > +     if (pgd_none(*pgd))
> > +             return NULL;
> > +     p4d = p4d_offset(pgd, addr);
> > +     if (p4d_none(*p4d))
> > +             return NULL;
> > +     pud = pud_offset(p4d, addr);
> > +
> > +     WARN_ON_ONCE(pud_bad(*pud));
> > +     if (pud_none(*pud) || pud_bad(*pud))
> > +             return NULL;
> > +     pmd = pmd_offset(pud, addr);
> > +
> > +     return pmd;
> > +}
>
> That routine is not really hugetlb specific.  Perhaps we could move it
> to sparse-vmemmap.c?  Or elsewhere?

Yeah, we can move it to sparse-vmemmap.c, maybe better.

>
> --
> Mike Kravetz



-- 
Yours,
Muchun
