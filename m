Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E4E322572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 06:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBWFhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 00:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBWFhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:37:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E74C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 21:36:31 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id ba1so9170190plb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 21:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYv0eQvZ2yLg52Ysz8rEXt1oFGhcA0fO7nVu09GhKJo=;
        b=VattKy++i+crfizvJnT73A/PHg1AtsrF5LZKhRwrP1CZNswQmtI1W9/4DUf8jf6i2G
         zEMSevQvsTShQLwkFgFPZYH90PTBzEgydaZt4L5P+QCclNIA/apqgEpKRAQ76OK57B8x
         MTfWZrGzOMGawr83aStTDvgb5GT7Y5hwhEUhAWPS2umyeZu/mr5nPyN+aHgaCWO/w51j
         SVj12JJohl6IjYxMyCFVaAQQHQf0wS9Wnj1SW/j1ojzvSs16Nd/Y+tyqJK4/JFdfpdpr
         y5hsC7AwbQsZ0H8bJ/pGjOHX+7SRS8gI7N9sVSl67fLMxAFt5SDNPI4GO2UJpyCQkBri
         iLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYv0eQvZ2yLg52Ysz8rEXt1oFGhcA0fO7nVu09GhKJo=;
        b=BIsTGLg1S+/ra1sJgly4QHIixQYY4K43On1TLu5LefXoViV4pSgfJfseu9Jayy4OFh
         jCzl7R6N4ZJ5ZvtdEtEn/Z7apeCeScNUeaNSD6Cc3537dpV4rJ2wE74xtmZ2oSJ4lcLM
         AVPPRf866nY+dJz2iGQXY29md8Rk4F3hlLoyNH/WCKBAfMSUQChY5q9t9eNeE2CFJTBY
         iIl83iuohos9c8A/wv8nPSd6GBK/GQmyhKqXfcwMG3uwTfV1zI1S52QlPnj+FeNEZsK+
         eAeq+p3vVvyNZE3K6ci5Be212ys9EW6XFC8eTDf2suIemh3lIMQzY6YPnQL3CgLQhFIj
         LofQ==
X-Gm-Message-State: AOAM533/+85YDxVsrvvCWPOtc6nrlw6H2bRfFHawpCNst17/4/YyYGYS
        j1HsAndHWQd3yRtRVaojHBZiyxvq49fEcJNWCr8bn7kf0PMiZxJQ
X-Google-Smtp-Source: ABdhPJwgy93EhnypmyOsAuzu+K13tuFOTwwVMC+wgLV+s9q0JC7Q5wYzJvFv7InURvV6eIQwIvRUymiZpeNaJcG+gQk=
X-Received: by 2002:a17:902:9341:b029:e1:7b4e:57a8 with SMTP id
 g1-20020a1709029341b02900e17b4e57a8mr25102009plp.34.1614058590565; Mon, 22
 Feb 2021 21:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com> <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
In-Reply-To: <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 23 Feb 2021 13:35:53 +0800
Message-ID: <CAMZfGtVeJ7Vs-K3ChqLfWkWYpHvZZ-jnBKo67ague50be-MSbQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
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

On Tue, Feb 23, 2021 at 8:01 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/19/21 2:49 AM, Muchun Song wrote:
> > When we free a HugeTLB page to the buddy allocator, we should allocate
> > the vmemmap pages associated with it. But we may cannot allocate vmemmap
> > pages when the system is under memory pressure, in this case, we just
> > refuse to free the HugeTLB page instead of looping forever trying to
> > allocate the pages. This changes some behavior (list below) on some
> > corner cases.
>
> Thank you for listing changes in behavior and possible side effects of
> not being able to allocate vmemmmap and free huge page to buddy!
>
> I will not repeat Michal's comment about the check for an atomic context
> in free_huge_page path.
>
> >
> >  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> >
> >     Need try again later by the user.
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
> >     pressure, offlining/unplug can be expected to fail.
> >
> >  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
> >     alloc_contig_range() - once we have that handling in place. Mainly
> >     affects CMA and virtio-mem.
> >
> >     Similar to 3). virito-mem will handle migration errors gracefully.
> >     CMA might be able to fallback on other free areas within the CMA
> >     region.
> >
> > We do not want to use GFP_ATOMIC to allocate vmemmap pages. Because it
> > grants access to memory reserves and we do not think it is reasonable
> > to use memory reserves. We use GFP_KERNEL in alloc_huge_page_vmemmap().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/mm/hugetlbpage.rst |  8 +++
> >  include/linux/mm.h                           |  2 +
> >  mm/hugetlb.c                                 | 81 ++++++++++++++++++++--------
> >  mm/hugetlb_vmemmap.c                         | 22 ++++++++
> >  mm/hugetlb_vmemmap.h                         |  6 +++
> >  mm/sparse-vmemmap.c                          | 75 +++++++++++++++++++++++++-
> >  6 files changed, 171 insertions(+), 23 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index f7b1c7462991..fb8f649e5635 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -60,6 +60,10 @@ HugePages_Surp
> >          the pool above the value in ``/proc/sys/vm/nr_hugepages``. The
> >          maximum number of surplus huge pages is controlled by
> >          ``/proc/sys/vm/nr_overcommit_hugepages``.
> > +     Note: When the feature of freeing unused vmemmap pages associated
> > +     with each hugetlb page is enabled, the number of the surplus huge
>
> Small wording change:
>
>         with each hugetlb page is enabled, the number of surplus huge

Thanks. I will update this.

>
> > +     pages may be temporarily larger than the maximum number of surplus
> > +     huge pages when the system is under memory pressure.
> >  Hugepagesize
> >       is the default hugepage size (in Kb).
> >  Hugetlb
> > @@ -80,6 +84,10 @@ returned to the huge page pool when freed by a task.  A user with root
> >  privileges can dynamically allocate more or free some persistent huge pages
> >  by increasing or decreasing the value of ``nr_hugepages``.
> >
> > +Note: When the feature of freeing unused vmemmap pages associated with each
> > +hugetlb page is enabled, we can failed to free the huge pages triggered by
>
> Small wording change:
>
>    hugetlb page is enabled, we can fail to free the huge pages triggered by

Thanks. I will update this.

>
> > +the user when ths system is under memory pressure.  Please try again later.
> > +
> >  Pages that are used as huge pages are reserved inside the kernel and cannot
> >  be used for other purposes.  Huge pages cannot be swapped out under
> >  memory pressure.
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index d7dddf334779..33c5911afe18 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2981,6 +2981,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
> >
> >  void vmemmap_remap_free(unsigned long start, unsigned long end,
> >                       unsigned long reuse);
> > +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> > +                     unsigned long reuse, gfp_t gfp_mask);
> >
> >  void *sparse_buffer_alloc(unsigned long size);
> >  struct page * __populate_section_memmap(unsigned long pfn,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 4cfca27c6d32..bcf856974c48 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1305,37 +1305,68 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >                                               unsigned int order) { }
> >  #endif
> >
> > -static void update_and_free_page(struct hstate *h, struct page *page)
> > +static int update_and_free_page(struct hstate *h, struct page *page)
> > +     __releases(&hugetlb_lock) __acquires(&hugetlb_lock)
> >  {
> >       int i;
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
> > +     set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > +     set_page_refcounted(page);
>
> I think you added the set_page_refcounted() because the huge page will
> appear as just a compound page without a reference after dropping the
> hugetlb lock?

Right.

> It might be better to set the reference before modifying
> the destructor.  Otherwise, page scanning code could find the non-hugetlb
> compound page with no reference.  I could not find any code where this
> would be a problem, but I think it would be safer to set the reference
> first.

Make sense to me. It is better to set the refcount first.

>
> > +     spin_unlock(&hugetlb_lock);
>
> I really like the way this code is structured.  It is much simpler than
> previous versions with retries or workqueue.  There is nothing wrong with
> always dropping the lock here.  However, I wonder if we should think about
> optimizing for the case where this feature is not enabled and we are not
> freeing a 1G huge page.  I suspect this will be the most common case for
> some time, and there is no need to drop the lock in this case.
>
> Please do not change the code based on my comment.  I just wanted to bring
> this up for thought.

At least make sense to me. It may take a long time to free a 1G
huge page. Dropping the lock may be a good choice. But I also
want to listen to Oscar and Michal's opinion on this.

>
> Is it as simple as checking?
>         if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
>                 spin_unlock(&hugetlb_lock);

>
>         /* before return */
>         if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
>                 spin_lock(&hugetlb_lock);
>
> > +
> > +     if (alloc_huge_page_vmemmap(h, page)) {
> > +             int zeroed;
> > +
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
> > +              * This page is now managed by the hugetlb allocator and has
> > +              * no users -- drop the last reference.
> > +              */
> > +             zeroed = put_page_testzero(page);
> > +             VM_BUG_ON_PAGE(!zeroed, page);
> > +             arch_clear_hugepage_flags(page);
> > +             enqueue_huge_page(h, page);
> > +
> > +             return -ENOMEM;
> > +     }
> > +
> >       for (i = 0; i < pages_per_huge_page(h); i++) {
> >               page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
> >                               1 << PG_referenced | 1 << PG_dirty |
> >                               1 << PG_active | 1 << PG_private |
> >                               1 << PG_writeback);
> >       }
> > -     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> > -     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> > -     set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > -     set_page_refcounted(page);
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
> > +     spin_lock(&hugetlb_lock);
> > +
> > +     return 0;
> >  }
> >
> >  struct hstate *size_to_hstate(unsigned long size)
> > @@ -1403,9 +1434,9 @@ static void __free_huge_page(struct page *page)
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
> > @@ -1693,6 +1724,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> >                       struct page *page =
> >                               list_entry(h->hugepage_freelists[node].next,
> >                                         struct page, lru);
> > +                     ClearHPageFreed(page);
>
> Quick question.  Is this change directly related to the vmemmap changes,
> or is it a cleanup that you noticed?

Just a cleanup. Maybe there should be a separate patch for this.

>
> >                       list_del(&page->lru);
> >                       h->free_huge_pages--;
> >                       h->free_huge_pages_node[node]--;
> > @@ -1700,8 +1732,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> >                               h->surplus_huge_pages--;
> >                               h->surplus_huge_pages_node[node]--;
> >                       }
> > -                     update_and_free_page(h, page);
> > -                     ret = 1;
> > +                     ret = !update_and_free_page(h, page);
> >                       break;
> >               }
> >       }
> > @@ -1714,10 +1745,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
> > @@ -1768,12 +1803,14 @@ int dissolve_free_huge_page(struct page *page)
> >                       SetPageHWPoison(page);
> >                       ClearPageHWPoison(head);
> >               }
> > +             ClearHPageFreed(page);
> >               list_del(&head->lru);
> >               h->free_huge_pages--;
> >               h->free_huge_pages_node[nid]--;
> >               h->max_huge_pages--;
> > -             update_and_free_page(h, head);
> > -             rc = 0;
> > +             rc = update_and_free_page(h, head);
> > +             if (rc)
> > +                     h->max_huge_pages++;
>
> Since update_and_free_page failed, the number of surplus pages was
> incremented.  Surplus pages are the number of pages greater than
> max_huge_pages.  Since we are incrementing max_huge_pages, we should
> decrement (undo) the addition to surplus_huge_pages and
> surplus_huge_pages_node[nid].  So, I think we want
>                         h->surplus_huge_pages--;
>                         h->surplus_huge_pages_node[nid]--;
> here as well.

You are right. Thanks for reminding me of this.

>
> >       }
> >  out:
> >       spin_unlock(&hugetlb_lock);
>
> In previous version of this patch series, we discussed and refined the
> vmemmap manipulation routines below.  They still look good to me.
>
> In general, I like the approach taken in this patch.  Hopefully, others
> will comment and we can move the series forward.
> --
> Mike Kravetz
>
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 0209b736e0b4..29a3380f3b20 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -198,6 +198,28 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> >       return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> >  }
> >
> > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > +{
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
> > +}
> > +
> >  void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> >  {
> >       unsigned long vmemmap_addr = (unsigned long)head;
> > diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> > index 6923f03534d5..e5547d53b9f5 100644
> > --- a/mm/hugetlb_vmemmap.h
> > +++ b/mm/hugetlb_vmemmap.h
> > @@ -11,8 +11,14 @@
> >  #include <linux/hugetlb.h>
> >
> >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
> >  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
> >  #else
> > +static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> >  {
> >  }
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
