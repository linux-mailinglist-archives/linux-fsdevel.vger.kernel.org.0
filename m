Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BCF32B4EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450204AbhCCFbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352284AbhCCDht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:37:49 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE0BC061794
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 19:36:53 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id j12so15251862pfj.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 19:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTMryjaTvh2wKFJu9U4EHLpdtApuKbpjoaxmZUgghdQ=;
        b=jR19KJ8g1smUjBkdUvPbV/1817bIABiu1oHeaJIRY4zmWrG7OxqYmA2Pl3dzQgOAnB
         yjKibpa/iNglJoonF32ygZdpAgJdAOcmJvPkZvYfAklKJUFCqkNZfDQpqYJ0uqDyamPE
         KHS59zk/836zjEl74fHGVDaJG/e3QREo4nPMk+iaZuk1RxSJIAXaIVV22lvMmOwMsI+O
         9eHRNVmMwlJWz5MJvn7e1+39N/ezkY98/bWb4EJ1B8/+zoR7sdToPgLopFXLhedZL4s/
         TePM6iHx19OLKNuv/GjjFsmhmIIjF+Zy2J8oeo9oBWAVNxY2a0tJwKi7Im1Nc1dzCZ6v
         xPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTMryjaTvh2wKFJu9U4EHLpdtApuKbpjoaxmZUgghdQ=;
        b=XLMTmDDORVbb7nCqWPaWhtIyml8/sZVFt6VTQt/Ok4TQGUI+zJIqE/gSXjDQU78fwc
         rQ8d+RMZFW6VO1IssoiT5ncf160MJoK+StpAeXPnNIas206CDtsK+WeAFINRRyN52sfB
         XIN5L9Cat4JW5k5844JLCoUAQcG5ljHGo1thMYZbqZaYPyZakGxbeqZfW2GLFOWYGWfq
         GzwaDqYxv0GHTZt9lL5dB/uYkZTj4I5lFxZxNizkoKMXVmQt0jbUopF/pBlzSW1ElZik
         7keFQDRXDKXMH0gZ2YMore8HW/kEMW2cHa6Dt6FU9Tg+LWzG9gM1QBrs52wHaIN9NMW7
         59YQ==
X-Gm-Message-State: AOAM5314zHNL0ynAmlac5C7fOkmEDT+cp/ZPX+jNM8GRQtjB7w2tPufA
        8fNhtDom0PyDUMUea8VECv7MpDbUbi78yJbAwQsotw==
X-Google-Smtp-Source: ABdhPJwmbnmb8g9XU9OFPO1UJLsiotlnvJd4wBv4z5zW6y9O/vy8cljBEGLKehSgurcgGCob0FJ6nYCRLCjhxpN0jHM=
X-Received: by 2002:a63:161c:: with SMTP id w28mr9523890pgl.341.1614742612916;
 Tue, 02 Mar 2021 19:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-5-songmuchun@bytedance.com> <af0ee246-7a07-b82f-020f-bcc204631859@oracle.com>
In-Reply-To: <af0ee246-7a07-b82f-020f-bcc204631859@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 3 Mar 2021 11:36:16 +0800
Message-ID: <CAMZfGtXxhQGeGFQO4mc0ctUtuq4haGCUmF=vFOHVvwzKryr=tw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v17 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 3, 2021 at 10:04 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/25/21 5:21 AM, Muchun Song wrote:
> > When we free a HugeTLB page to the buddy allocator, we should allocate
> > the vmemmap pages associated with it. But we may cannot allocate vmemmap
> > pages when the system is under memory pressure, in this case, we just
> > refuse to free the HugeTLB page instead of looping forever trying to
> > allocate the pages. This changes some behavior (list below) on some
> > cassociated with it.orner cases.
>
> Suggest rewording this as:
>
> When we free a HugeTLB page to the buddy allocator, we need to allocate
> the vmemmap pages associated with it.  However, we may not be able to
> allocate the vmemmap pages when the system is under memory pressure.  In
> this case, we just refuse to free the HugeTLB page.  This changes behavior
> in some corner cases as listed below:

Thanks Mike. I will use this.

>
> >
> >  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> >
> >     Need try again later by the user.
>
>         User needs to try again later.
> >
> >  2) Failing to free a surplus huge page when freed by the application.
> >
> >     Try again later when freeing a huge page next time.
> >
> >  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
> >     offline_pages().
> >
> >     This is a bit unfortunate if we have plenty of ZONE_MOVABLE memory
> >     but are low on kernel memory. For example, migration of huge pages
> >     would still work, however, dissolving the free page does not work.
> >     This is a corner cases. When the system is that much under memory
> >     pressure, offlining/unplug can be expected to fail. This is
> >     unfortunate because it prevents from the memory offlining which
> >     shouldn't happen for movable zones. People depending on the memory
> >     hotplug and movable zone should carefuly consider whether savings
> >     on unmovable memory are worth losing their hotplug functionality
> >     in some situations.
> >
>
> Possible wording change:
>       This can happen when we have plenty of ZONE_MOVABLE memory, but
>       not enough kernel memory to allocate vmemmmap pages.  We may even
>       be able to migrate huge page contents, but will not be able to
>       dissolve the source huge page.  This will prevent an offline
>       operation and is unfortunate as memory offlining is expected to
>       succeed on movable zones.  Users that depend on memory hotplug
>       to succeed for movable zones should carefully consider whether the
>       memory savings gained from this feature are worth the risk of
>       possibly not being able to offline memory in certain situations.

OK. Will use. Thanks.

>
> >  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
> >     alloc_contig_range() - once we have that handling in place. Mainly
> >     affects CMA and virtio-mem.
> >
> >     Similar to 3). virito-mem will handle migration errors gracefully.
> >     CMA might be able to fallback on other free areas within the CMA
> >     region.
> >
> > Vmemmap pages are allocated from the page freeing context. In order for
> > those allocations to be not disruptive (e.g. trigger oom killer)
> > __GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
> > because a non sleeping allocation would be too fragile and it could fail
> > too easily under memory pressure. GFP_ATOMIC or other modes to access
> > memory reserves is not used because we want to prevent consuming
> > reserves under heavy hugetlb freeing.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/mm/hugetlbpage.rst |  8 +++
> >  include/linux/mm.h                           |  2 +
> >  mm/hugetlb.c                                 | 92 +++++++++++++++++++++-------
> >  mm/hugetlb_vmemmap.c                         | 32 ++++++----
> >  mm/hugetlb_vmemmap.h                         | 23 +++++++
> >  mm/sparse-vmemmap.c                          | 75 ++++++++++++++++++++++-
> >  6 files changed, 197 insertions(+), 35 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index f7b1c7462991..6988895d09a8 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -60,6 +60,10 @@ HugePages_Surp
> >          the pool above the value in ``/proc/sys/vm/nr_hugepages``. The
> >          maximum number of surplus huge pages is controlled by
> >          ``/proc/sys/vm/nr_overcommit_hugepages``.
> > +     Note: When the feature of freeing unused vmemmap pages associated
> > +     with each hugetlb page is enabled, the number of surplus huge pages
> > +     may be temporarily larger than the maximum number of surplus huge
> > +     pages when the system is under memory pressure.
> >  Hugepagesize
> >       is the default hugepage size (in Kb).
> >  Hugetlb
> > @@ -80,6 +84,10 @@ returned to the huge page pool when freed by a task.  A user with root
> >  privileges can dynamically allocate more or free some persistent huge pages
> >  by increasing or decreasing the value of ``nr_hugepages``.
> >
> > +Note: When the feature of freeing unused vmemmap pages associated with each
> > +hugetlb page is enabled, we can fail to free the huge pages triggered by
> > +the user when ths system is under memory pressure.  Please try again later.
> > +
> >  Pages that are used as huge pages are reserved inside the kernel and cannot
> >  be used for other purposes.  Huge pages cannot be swapped out under
> >  memory pressure.
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 4ddfc31f21c6..77693c944a36 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2973,6 +2973,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
> >
> >  void vmemmap_remap_free(unsigned long start, unsigned long end,
> >                       unsigned long reuse);
> > +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> > +                     unsigned long reuse, gfp_t gfp_mask);
> >
> >  void *sparse_buffer_alloc(unsigned long size);
> >  struct page * __populate_section_memmap(unsigned long pfn,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 43fed6785322..b6e4e3f31ad2 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1304,16 +1304,59 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >                                               unsigned int order) { }
> >  #endif
> >
> > -static void update_and_free_page(struct hstate *h, struct page *page)
> > +static int update_and_free_page(struct hstate *h, struct page *page)
> > +     __releases(&hugetlb_lock) __acquires(&hugetlb_lock)
> >  {
> >       int i;
> >       struct page *subpage = page;
> > +     int nid = page_to_nid(page);
> >
> >       if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> > -             return;
> > +             return 0;
> >
> >       h->nr_huge_pages--;
> > -     h->nr_huge_pages_node[page_to_nid(page)]--;
> > +     h->nr_huge_pages_node[nid]--;
> > +     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> > +     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> > +     set_page_refcounted(page);
> > +     set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > +
> > +     /*
> > +      * If the vmemmap pages associated with the HugeTLB page can be
> > +      * optimized or the page is gigantic, we might block in
> > +      * alloc_huge_page_vmemmap() or free_gigantic_page(). In both
> > +      * cases, drop the hugetlb_lock.
> > +      */
> > +     if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> > +             spin_unlock(&hugetlb_lock);
> > +
> > +     if (alloc_huge_page_vmemmap(h, page)) {
> > +             spin_lock(&hugetlb_lock);
> > +             INIT_LIST_HEAD(&page->lru);
> > +             set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> > +             h->nr_huge_pages++;
> > +             h->nr_huge_pages_node[nid]++;
> > +
> > +             /*
> > +              * If we cannot allocate vmemmap pages, just refuse to free the
> > +              * page and put the page back on the hugetlb free list and treat
> > +              * as a surplus page.
> > +              */
> > +             h->surplus_huge_pages++;
> > +             h->surplus_huge_pages_node[nid]++;
> > +
> > +             /*
> > +              * The refcount can be perfectly increased by memory-failure or
>
> Reword             The refcount can possibly be increased by memory-failure or
>                    soft_offline handlers.

Make sense.

>
> > +              * soft_offline handlers.
> > +              */
> > +             if (likely(put_page_testzero(page))) {
> > +                     arch_clear_hugepage_flags(page);
> > +                     enqueue_huge_page(h, page);
> > +             }
> > +
> > +             return -ENOMEM;
> > +     }
> > +
> >       for (i = 0; i < pages_per_huge_page(h);
> >            i++, subpage = mem_map_next(subpage, page, i)) {
> >               subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> > @@ -1321,22 +1364,18 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> >                               1 << PG_active | 1 << PG_private |
> >                               1 << PG_writeback);
> >       }
> > -     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> > -     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> > -     set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > -     set_page_refcounted(page);
> > +
> >       if (hstate_is_gigantic(h)) {
> > -             /*
> > -              * Temporarily drop the hugetlb_lock, because
> > -              * we might block in free_gigantic_page().
> > -              */
> > -             spin_unlock(&hugetlb_lock);
> >               destroy_compound_gigantic_page(page, huge_page_order(h));
> >               free_gigantic_page(page, huge_page_order(h));
> > -             spin_lock(&hugetlb_lock);
> >       } else {
> >               __free_pages(page, huge_page_order(h));
> >       }
> > +
> > +     if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> > +             spin_lock(&hugetlb_lock);
> > +
> > +     return 0;
> >  }
> >
> >  struct hstate *size_to_hstate(unsigned long size)
> > @@ -1404,9 +1443,9 @@ static void __free_huge_page(struct page *page)
> >       } else if (h->surplus_huge_pages_node[nid]) {
> >               /* remove the page from active list */
> >               list_del(&page->lru);
> > -             update_and_free_page(h, page);
> >               h->surplus_huge_pages--;
> >               h->surplus_huge_pages_node[nid]--;
> > +             update_and_free_page(h, page);
> >       } else {
> >               arch_clear_hugepage_flags(page);
> >               enqueue_huge_page(h, page);
> > @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
> >       /*
> >        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> >        */
> > -     if (!in_task()) {
> > +     if (!in_atomic()) {
>
> That should be "if (in_atomic()) instead of "if (!in_atomic())"

Very thanks. It is my mistake. I will fix it.

>
> Do note that there is an ongoing discussion about calling free_huge_page
> in various contexts.
>
> https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/

Thanks for your reminder. I will take a closer look at what the problem is.

>
> This discussion/issue is independent of this patch.  Since that issue
> deals with existing code, we will need to come up with a solution there
> first.  A solution there may impact how free_huge_page is structured and
> may impact this patch.
>
> The in_atomic() check is insufficient to handle all cases.  It is better
> than !in_task(), but still does not cover all cases.
>
> The rest of the patch looks good to me.
> --
> Mike Kravetz
>
> >               /*
> >                * Only call schedule_work() if hpage_freelist is previously
> >                * empty. Otherwise, schedule_work() had been called but the
> > @@ -1699,8 +1738,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> >                               h->surplus_huge_pages--;
> >                               h->surplus_huge_pages_node[node]--;
> >                       }
> > -                     update_and_free_page(h, page);
> > -                     ret = 1;
> > +                     ret = !update_and_free_page(h, page);
> >                       break;
> >               }
> >       }
> > @@ -1713,10 +1751,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> >   * nothing for in-use hugepages and non-hugepages.
> >   * This function returns values like below:
> >   *
> > - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
> > - *          (allocated or reserved.)
> > - *       0: successfully dissolved free hugepages or the page is not a
> > - *          hugepage (considered as already dissolved)
> > + *  -ENOMEM: failed to allocate vmemmap pages to free the freed hugepages
> > + *           when the system is under memory pressure and the feature of
> > + *           freeing unused vmemmap pages associated with each hugetlb page
> > + *           is enabled.
> > + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
> > + *           (allocated or reserved.)
> > + *       0:  successfully dissolved free hugepages or the page is not a
> > + *           hugepage (considered as already dissolved)
> >   */
> >  int dissolve_free_huge_page(struct page *page)
> >  {
> > @@ -1771,8 +1813,12 @@ int dissolve_free_huge_page(struct page *page)
> >               h->free_huge_pages--;
> >               h->free_huge_pages_node[nid]--;
> >               h->max_huge_pages--;
> > -             update_and_free_page(h, head);
> > -             rc = 0;
> > +             rc = update_and_free_page(h, head);
> > +             if (rc) {
> > +                     h->surplus_huge_pages--;
> > +                     h->surplus_huge_pages_node[nid]--;
> > +                     h->max_huge_pages++;
> > +             }
> >       }
> >  out:
> >       spin_unlock(&hugetlb_lock);
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 0209b736e0b4..f7ab3d99250a 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -181,21 +181,31 @@
> >  #define RESERVE_VMEMMAP_NR           2U
> >  #define RESERVE_VMEMMAP_SIZE         (RESERVE_VMEMMAP_NR << PAGE_SHIFT)
> >
> > -/*
> > - * How many vmemmap pages associated with a HugeTLB page that can be freed
> > - * to the buddy allocator.
> > - *
> > - * Todo: Returns zero for now, which means the feature is disabled. We will
> > - * enable it once all the infrastructure is there.
> > - */
> > -static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> > +static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> >  {
> > -     return 0;
> > +     return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> >  }
> >
> > -static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> >  {
> > -     return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> > +     unsigned long vmemmap_addr = (unsigned long)head;
> > +     unsigned long vmemmap_end, vmemmap_reuse;
> > +
> > +     if (!free_vmemmap_pages_per_hpage(h))
> > +             return 0;
> > +
> > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > +     /*
> > +      * The pages which the vmemmap virtual address range [@vmemmap_addr,
> > +      * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > +      * the range is mapped to the page which @vmemmap_reuse is mapped to.
> > +      * When a HugeTLB page is freed to the buddy allocator, previously
> > +      * discarded vmemmap pages must be allocated and remapping.
> > +      */
> > +     return vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> > +                                GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> >  }
> >
> >  void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> > index 6923f03534d5..a37771b0b82a 100644
> > --- a/mm/hugetlb_vmemmap.h
> > +++ b/mm/hugetlb_vmemmap.h
> > @@ -11,10 +11,33 @@
> >  #include <linux/hugetlb.h>
> >
> >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
> >  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
> > +
> > +/*
> > + * How many vmemmap pages associated with a HugeTLB page that can be freed
> > + * to the buddy allocator.
> > + *
> > + * Todo: Returns zero for now, which means the feature is disabled. We will
> > + * enable it once all the infrastructure is there.
> > + */
> > +static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> > +{
> > +     return 0;
> > +}
> >  #else
> > +static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> >  {
> >  }
> > +
> > +static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> > +{
> > +     return 0;
> > +}
> >  #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
> >  #endif /* _LINUX_HUGETLB_VMEMMAP_H */
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index d3076a7a3783..60fc6cd6cd23 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -40,7 +40,8 @@
> >   * @remap_pte:               called for each lowest-level entry (PTE).
> >   * @reuse_page:              the page which is reused for the tail vmemmap pages.
> >   * @reuse_addr:              the virtual address of the @reuse_page page.
> > - * @vmemmap_pages:   the list head of the vmemmap pages that can be freed.
> > + * @vmemmap_pages:   the list head of the vmemmap pages that can be freed
> > + *                   or is mapped from.
> >   */
> >  struct vmemmap_remap_walk {
> >       void (*remap_pte)(pte_t *pte, unsigned long addr,
> > @@ -237,6 +238,78 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
> >       free_vmemmap_page_list(&vmemmap_pages);
> >  }
> >
> > +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> > +                             struct vmemmap_remap_walk *walk)
> > +{
> > +     pgprot_t pgprot = PAGE_KERNEL;
> > +     struct page *page;
> > +     void *to;
> > +
> > +     BUG_ON(pte_page(*pte) != walk->reuse_page);
> > +
> > +     page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> > +     list_del(&page->lru);
> > +     to = page_to_virt(page);
> > +     copy_page(to, (void *)walk->reuse_addr);
> > +
> > +     set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> > +}
> > +
> > +static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> > +                                gfp_t gfp_mask, struct list_head *list)
> > +{
> > +     unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
> > +     int nid = page_to_nid((struct page *)start);
> > +     struct page *page, *next;
> > +
> > +     while (nr_pages--) {
> > +             page = alloc_pages_node(nid, gfp_mask, 0);
> > +             if (!page)
> > +                     goto out;
> > +             list_add_tail(&page->lru, list);
> > +     }
> > +
> > +     return 0;
> > +out:
> > +     list_for_each_entry_safe(page, next, list, lru)
> > +             __free_pages(page, 0);
> > +     return -ENOMEM;
> > +}
> > +
> > +/**
> > + * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
> > + *                    to the page which is from the @vmemmap_pages
> > + *                    respectively.
> > + * @start:   start address of the vmemmap virtual address range that we want
> > + *           to remap.
> > + * @end:     end address of the vmemmap virtual address range that we want to
> > + *           remap.
> > + * @reuse:   reuse address.
> > + * @gpf_mask:        GFP flag for allocating vmemmap pages.
> > + */
> > +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> > +                     unsigned long reuse, gfp_t gfp_mask)
> > +{
> > +     LIST_HEAD(vmemmap_pages);
> > +     struct vmemmap_remap_walk walk = {
> > +             .remap_pte      = vmemmap_restore_pte,
> > +             .reuse_addr     = reuse,
> > +             .vmemmap_pages  = &vmemmap_pages,
> > +     };
> > +
> > +     /* See the comment in the vmemmap_remap_free(). */
> > +     BUG_ON(start - reuse != PAGE_SIZE);
> > +
> > +     might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> > +
> > +     if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
> > +             return -ENOMEM;
> > +
> > +     vmemmap_remap_range(reuse, end, &walk);
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Allocate a block of memory to be used to back the virtual memory map
> >   * or to back the page tables that are used to create the mapping.
> >
