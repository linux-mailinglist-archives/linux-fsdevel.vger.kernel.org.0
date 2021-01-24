Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8A6301A40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jan 2021 07:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAXGtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 01:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbhAXGto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 01:49:44 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDBBC061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Jan 2021 22:49:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 11so6528013pfu.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Jan 2021 22:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ou29vBChwtGGpt5awRgoNwT4J6UK005g3gZPSo0SPQ=;
        b=HTMkogxYpRgXOSj6V7yS6/nZscXDdTdTA8ldDiwjUcp7cOI2oT0U1OVAhR8D961Hx6
         4A3+QEHRoi4l2/iM0FvPial7LpoonVi77pRl+uSsoAFA68YpJTDx0iDNlMoUx8CoRlGc
         rMNgOBfgfZZ3yEQU21DdkeXtYiIr8ihECDP8iEQkggsQiP5gXpQpO8FjVuoCnQESrqcM
         m62DooRdER78VTurUcgiXxKn+w/BBBk+dRwElEVDKNUk4pnmnxsybpIqnfoSipRIxzTy
         DGzYDamA7V9r94QdLHbUxyIUp2qFut7MiLR2e9XtspkZG2bOw2knwChe/eoqpT6/oPaR
         MHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ou29vBChwtGGpt5awRgoNwT4J6UK005g3gZPSo0SPQ=;
        b=EKpihww8bQirjCBD5Giet3F5w/8XXTqyIQL7NW/8jDesk0hjYuZR7lJ08IqJczqnTN
         b2vcFVr4zDod6Yw6O0StBVf9vMfMR9t2BYYhBFLl3RhFL8j7rMnXh1ZX3yIufjg2aG+Q
         4THKWlC/hp7xADSB9YzfvFZgHkThzxUBikj1m0mHMhbp9ZuZ9x4MY5fbIhwuekiPIwU3
         qCseGoEkbNA3suXHDzGu9ynl0k92Jqpht8I2ywvOBekTF03o3PudyVp9wyXGrJT6Y4+O
         o74kwG3vF8BEkFWyRcvnMG/NCvaIZrWjya71txgIfT+qzCzGVF9L0vGxpfQ3l1GXLkkg
         uqjQ==
X-Gm-Message-State: AOAM531QTKrchUIgBLr0sH1NN61pitsehw+Y4731KCS0MNkI36fKGX6/
        ingpEnEZdJ3VYZsdakB5k0LuBBc/W6vjYPl+vfXoVA==
X-Google-Smtp-Source: ABdhPJxi59YWCADRapudyosxFSteIZm49SBGLQ8YwpUWvHs1qWbcqO1PempR2Xr96mZXXpOV711EIrLYuCDLJKkjLv4=
X-Received: by 2002:a62:2984:0:b029:1b4:72bd:f2bf with SMTP id
 p126-20020a6229840000b02901b472bdf2bfmr2722138pfp.59.1611470943571; Sat, 23
 Jan 2021 22:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-4-songmuchun@bytedance.com> <20210123175259.GA3555@localhost.localdomain>
In-Reply-To: <20210123175259.GA3555@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 24 Jan 2021 14:48:27 +0800
Message-ID: <CAMZfGtXsEGQM+g6V9mMYZDA7XECS7S6fTiM_Pab5Uq-1Eu979Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 03/12] mm: hugetlb: free the vmemmap
 pages associated with each HugeTLB page
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
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 24, 2021 at 1:53 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> X-Gm-Spam: 0
> X-Gm-Phishy: 0
>
> On Sun, Jan 17, 2021 at 11:10:44PM +0800, Muchun Song wrote:
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
>
> Overall looks good to me.
> A few nits below, plus what Mike has already said.
>
> I was playing the other day (just for un) to see how hard would be to adapt
> this to ppc64 but did not have the time :-)

I have no idea about ppc64. But for aarch64, it is easy to adapt
this to aarch64 (I have finished this part of the work). Is the size
of the struct page 64 bytes for ppc64? If so, I think that it also
easy.

>
> > --- /dev/null
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -0,0 +1,211 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Free some vmemmap pages of HugeTLB
> > + *
> > + * Copyright (c) 2020, Bytedance. All rights reserved.
> > + *
> > + *     Author: Muchun Song <songmuchun@bytedance.com>
> > + *
> > + * The struct page structures (page structs) are used to describe a physical
> > + * page frame. By default, there is a one-to-one mapping from a page frame to
> > + * it's corresponding page struct.
> > + *
> > + * The HugeTLB pages consist of multiple base page size pages and is supported
> "HugeTLB pages ..."

Thanks.

>
> > + * When the system boot up, every HugeTLB page has more than one struct page
> > + * structs whose size is (unit: pages):
>               ^^^^ which?

I am not a native English. Thanks for pointing this out.

> > + *
> > + *    struct_size = HugeTLB_Size / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
> > + *
> > + * Where HugeTLB_Size is the size of the HugeTLB page. We know that the size
> > + * of the HugeTLB page is always n times PAGE_SIZE. So we can get the following
> > + * relationship.
> > + *
> > + *    HugeTLB_Size = n * PAGE_SIZE
> > + *
> > + * Then,
> > + *
> > + *    struct_size = n * PAGE_SIZE / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
> > + *                = n * sizeof(struct page) / PAGE_SIZE
> > + *
> > + * We can use huge mapping at the pud/pmd level for the HugeTLB page.
> > + *
> > + * For the HugeTLB page of the pmd level mapping, then
> > + *
> > + *    struct_size = n * sizeof(struct page) / PAGE_SIZE
> > + *                = PAGE_SIZE / sizeof(pte_t) * sizeof(struct page) / PAGE_SIZE
> > + *                = sizeof(struct page) / sizeof(pte_t)
> > + *                = 64 / 8
> > + *                = 8 (pages)
> > + *
> > + * Where n is how many pte entries which one page can contains. So the value of
> > + * n is (PAGE_SIZE / sizeof(pte_t)).
> > + *
> > + * This optimization only supports 64-bit system, so the value of sizeof(pte_t)
> > + * is 8. And this optimization also applicable only when the size of struct page
> > + * is a power of two. In most cases, the size of struct page is 64 (e.g. x86-64
> > + * and arm64). So if we use pmd level mapping for a HugeTLB page, the size of
> > + * struct page structs of it is 8 pages whose size depends on the size of the
> > + * base page.
> > + *
> > + * For the HugeTLB page of the pud level mapping, then
> > + *
> > + *    struct_size = PAGE_SIZE / sizeof(pmd_t) * struct_size(pmd)
> > + *                = PAGE_SIZE / 8 * 8 (pages)
> > + *                = PAGE_SIZE (pages)
>
> I would try to condense above information and focus on what are the
> key points you want people to get.
> E.g: A 2MB HugeTLB page on x86_64 consists in 8 page frames while 1GB
> HugeTLB page consists in 4096.
> If you do not want to be that specific you can always write down the
> formula, and maybe put the X86_64 example at the end.
> But as I said, I would try to make it more brief.
>
> Maybe others disagree though.

I want to make the formula more general. Because the PAGE_SIZE
can be different on arm64. But you are right, I should make it brief
and easy to understand. I will add some examples at the end of the
formula. Thanks.

>
>
> > + *
> > + * Where the struct_size(pmd) is the size of the struct page structs of a
> > + * HugeTLB page of the pmd level mapping.
>
> [...]
>
> > +void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > +{
> > +     unsigned long vmemmap_addr = (unsigned long)head;
> > +     unsigned long vmemmap_end, vmemmap_reuse;
> > +
> > +     if (!free_vmemmap_pages_per_hpage(h))
> > +             return;
> > +
> > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > +
>
> I would like to see a comment there explaining why those variables get
> they value they do.

OK. Will add a comment here.

>
> > +/**
> > + * vmemmap_remap_walk - walk vmemmap page table
> > + *
> > + * @remap_pte:               called for each non-empty PTE (lowest-level) entry.
> > + * @reuse_page:              the page which is reused for the tail vmemmap pages.
> > + * @reuse_addr:              the virtual address of the @reuse_page page.
> > + * @vmemmap_pages:   the list head of the vmemmap pages that can be freed.
>
> Let us align the tabs there.

It is already aligned. :)

>
> > +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> > +                           unsigned long end,
> > +                           struct vmemmap_remap_walk *walk)
> > +{
> > +     pte_t *pte;
> > +
> > +     pte = pte_offset_kernel(pmd, addr);
> > +
> > +     /*
> > +      * The reuse_page is found 'first' in table walk before we start
> > +      * remapping (which is calling @walk->remap_pte).
> > +      */
> > +     if (walk->reuse_addr == addr) {
> > +             BUG_ON(pte_none(*pte));
>
> If it is found first, would not be
>
>         if (!walk->reuse_page) {
>                 BUG_ON(walk->reuse_addr != addr)
>                 ...
>         }
>
> more intuitive?

Good. More intuitive. Thanks.

>
>
> > +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> > +                             struct vmemmap_remap_walk *walk)
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
> > +     /*
> > +      * We do not change the mapping of the vmemmap virtual address range
> > +      * [@start, @start + PAGE_SIZE) which is belong to the reuse range.
>                                         "which belongs to"

Thanks. Will fix it.

>
> > +      * So we not need to flush the TLB.
> > +      */
> > +     flush_tlb_kernel_range(start - PAGE_SIZE, end);
>
> you already commented on on this one.

Yeah, will fix it.

>
> > +/**
> > + * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
> > + *                   to the page which @reuse is mapped, then free vmemmap
> > + *                   pages.
> > + * @start:   start address of the vmemmap virtual address range.
>
> Well, it is the start address of the range we want to remap.
> Reading it made me think that it is really the __start__ address
> of the vmemmap range.

Sorry for confusing. I will fix it. Thanks.

>
> > +void vmemmap_remap_free(unsigned long start, unsigned long end,
> > +                     unsigned long reuse)
> > +{
> > +     LIST_HEAD(vmemmap_pages);
> > +     struct vmemmap_remap_walk walk = {
> > +             .remap_pte      = vmemmap_remap_pte,
> > +             .reuse_addr     = reuse,
> > +             .vmemmap_pages  = &vmemmap_pages,
> > +     };
> > +
> > +     /*
> > +      * In order to make remapping routine most efficient for the huge pages,
> > +      * the routine of vmemmap page table walking has the following rules
> > +      * (see more details from the vmemmap_pte_range()):
> > +      *
> > +      * - The @reuse address is part of the range that we are walking.
> > +      * - The @reuse address is the first in the complete range.
> > +      *
> > +      * So we need to make sure that @start and @reuse meet the above rules.
>
> You say that "reuse" and "start" need to meet some  rules, but in the
> paragraph above you only seem to point "reuse" rules?

OK. I should make the comment more clear. I will update it
and point out the relationship between @start and @reuse.

Thanks a lot.

>
>
> --
> Oscar Salvador
> SUSE L3
