Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC72DC3B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 17:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLPQFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 11:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgLPQFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:05:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE196C0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 08:04:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x12so12709249plr.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RX3whZHXdCkIXTHwCl+qju/eiJyA5eQwVsPDKDwXV4=;
        b=p+oG3SEUPCszmzmnsi+kLxx6UGLXEZGUp7o3tpKZo6V4XvCsrjBPx5DOuQZRwYXXIW
         i5gRNK4mcz7826XW6XgIR9Dj7MabqAzJwlS4P0BICr10MNy/06rthTApGHXhOXwZMzy1
         SBwDIhOLLbyAFzIJdADwLH64uyvswZ5Nn4uzbfMOQDjVLJjAhuvTBbvjG9YH4uvo2WRa
         vEiP2zkZ70aTCRz8OVT5vDSIJ3llS9uH3kydVEHUGqfvrxe6UMc1+VZl7GcNYOhWQJwV
         15ESXSi2JU+zZPs0f//VM6zQOmuWKMjbnKonE25Y8U7JmHErl3//GXpwIl7b3fczHKcS
         V0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RX3whZHXdCkIXTHwCl+qju/eiJyA5eQwVsPDKDwXV4=;
        b=nutBwjexE8EdQgUhh+uDP5N/ejh/92t7cHLS5qpz6q2zqhyHAHI87+SXsPuGWnXfuH
         GCmjCmITpBdCAZsWX9RG6aI3Zv5oPi6BXa5ryMMecGpW6pW13bW2iqZgqvXgTtGCM/WD
         sEPOzMCzK6BHAs4ep63vMgGv1FUMhoa0hCo6ZEOwXCpqQMwl2V2KGBMyN5FLIOq56pSy
         28KY15YRczxwzKaJ25RYLPgolFXdQEjFaKC1Fr2gn4LdU96edHKuPxXVUYAg846n/Pxp
         Eg4tD53pT6fvJ2WIek0GXvaeX01UcyfCDXQ74kJeuvuS7YyAsMNjvjBcz9ec7RIfsEl7
         RKtg==
X-Gm-Message-State: AOAM532Bw4ZBY4mGSgvVIU0oylv2TeXTMgzWZcQx8A6VnwzEeUOwLOq2
        4v2P6YE4vHcW0IChJ2VXAulkPbZaz7BPgoql6EAH3Q==
X-Google-Smtp-Source: ABdhPJzIuJ+U4OPcn2mdTAvw/RIz93xWB9newNxQKKykSN2TiRztb321Wu/njI799+1Q7SketJ34xlDd6qnwC2l2n2g=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr3589507pjr.229.1608134688046;
 Wed, 16 Dec 2020 08:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-9-songmuchun@bytedance.com> <20201216144052.GF29394@linux>
In-Reply-To: <20201216144052.GF29394@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 17 Dec 2020 00:04:11 +0800
Message-ID: <CAMZfGtUj4jng7Ay+c0h=N3b88+sz+A6Awa2r2DT+j9PFrXXBGQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 08/11] mm/hugetlb: Add a kernel
 parameter hugetlb_free_vmemmap
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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

On Wed, Dec 16, 2020 at 10:40 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Dec 13, 2020 at 11:45:31PM +0800, Muchun Song wrote:
> > Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
> > freeing unused vmemmap pages associated with each hugetlb page on boot.
> I guess this should read "to enable the feature"?
> AFAICS, it is disabled by default.
>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks Oscar.

>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
> >  arch/x86/mm/init_64.c                           |  8 ++++++--
> >  include/linux/hugetlb.h                         | 19 +++++++++++++++++++
> >  mm/hugetlb_vmemmap.c                            | 16 ++++++++++++++++
> >  5 files changed, 53 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 3ae25630a223..9e6854f21d55 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1551,6 +1551,15 @@
> >                       Documentation/admin-guide/mm/hugetlbpage.rst.
> >                       Format: size[KMG]
> >
> > +     hugetlb_free_vmemmap=
> > +                     [KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> > +                     this controls freeing unused vmemmap pages associated
> > +                     with each HugeTLB page.
> > +                     Format: { on | off (default) }
> > +
> > +                     on:  enable the feature
> > +                     off: disable the feature
> > +
> >       hung_task_panic=
> >                       [KNL] Should the hung task detector generate panics.
> >                       Format: 0 | 1
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index f7b1c7462991..3a23c2377acc 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -145,6 +145,9 @@ default_hugepagesz
> >
> >       will all result in 256 2M huge pages being allocated.  Valid default
> >       huge page size is architecture dependent.
> > +hugetlb_free_vmemmap
> > +     When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
> > +     unused vmemmap pages associated with each HugeTLB page.
> >
> >  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
> >  indicates the current number of pre-allocated huge pages of the default size.
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index 0435bee2e172..1bce5f20e6ca 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/gfp.h>
> >  #include <linux/kcore.h>
> >  #include <linux/bootmem_info.h>
> > +#include <linux/hugetlb.h>
> >
> >  #include <asm/processor.h>
> >  #include <asm/bios_ebda.h>
> > @@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> >  {
> >       int err;
> >
> > -     if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> > +     if (is_hugetlb_free_vmemmap_enabled() ||
> > +         end - start < PAGES_PER_SECTION * sizeof(struct page))
> >               err = vmemmap_populate_basepages(start, end, node, NULL);
> >       else if (boot_cpu_has(X86_FEATURE_PSE))
> >               err = vmemmap_populate_hugepages(start, end, node, altmap);
> > @@ -1585,6 +1587,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
> >       pmd_t *pmd;
> >       unsigned int nr_pmd_pages;
> >       struct page *page;
> > +     bool base_mapping = !boot_cpu_has(X86_FEATURE_PSE) ||
> > +                         is_hugetlb_free_vmemmap_enabled();
> >
> >       for (; addr < end; addr = next) {
> >               pte_t *pte = NULL;
> > @@ -1610,7 +1614,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
> >               }
> >               get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
> >
> > -             if (!boot_cpu_has(X86_FEATURE_PSE)) {
> > +             if (base_mapping) {
> >                       next = (addr + PAGE_SIZE) & PAGE_MASK;
> >                       pmd = pmd_offset(pud, addr);
> >                       if (pmd_none(*pmd))
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index ebca2ef02212..7f47f0eeca3b 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -770,6 +770,20 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +extern bool hugetlb_free_vmemmap_enabled;
> > +
> > +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> > +{
> > +     return hugetlb_free_vmemmap_enabled;
> > +}
> > +#else
> > +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> > +{
> > +     return false;
> > +}
> > +#endif
> > +
> >  #else        /* CONFIG_HUGETLB_PAGE */
> >  struct hstate {};
> >
> > @@ -923,6 +937,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
> >                                       pte_t *ptep, pte_t pte, unsigned long sz)
> >  {
> >  }
> > +
> > +static inline bool is_hugetlb_free_vmemmap_enabled(void)
> > +{
> > +     return false;
> > +}
> >  #endif       /* CONFIG_HUGETLB_PAGE */
> >
> >  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 02201c2e3dfa..64ad929cac61 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -180,6 +180,22 @@
> >  #define RESERVE_VMEMMAP_NR           2U
> >  #define RESERVE_VMEMMAP_SIZE         (RESERVE_VMEMMAP_NR << PAGE_SHIFT)
> >
> > +bool hugetlb_free_vmemmap_enabled;
> > +
> > +static int __init early_hugetlb_free_vmemmap_param(char *buf)
> > +{
> > +     if (!buf)
> > +             return -EINVAL;
> > +
> > +     if (!strcmp(buf, "on"))
> > +             hugetlb_free_vmemmap_enabled = true;
> > +     else if (strcmp(buf, "off"))
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
> > +
> >  static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> >  {
> >       return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> > --
> > 2.11.0
> >
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
