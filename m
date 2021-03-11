Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9F336C50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 07:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCKGez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 01:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhCKGen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:34:43 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17315C061761
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 22:34:43 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b23so5181574pfo.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 22:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMMUWb6wkhLMBAppMxvapOaONJYk7j8bUa+/YNRBP94=;
        b=rJWEx+ADO8oIMyKvAeH0m8caehRYaxZIaezUA2ITd8u9kXI2G+oMYLwndIXRjqgOiu
         JkAKcqxk9fKJdVRfKbQNKc8HBWLHO1vKUTWGTXzgo2wQJMBxl+afufAGW/UfojT26Twu
         ewSDWMdgA+a9KPS/5OF0YrkTTTajHtWGENtKpRma5dqpGkexo5YHC9m+Tgm28pct8+LX
         RBS9dA4U54sQ+97JI30XtfA8Q9fXfYcBJjTJi8eTYsyuIRzL5MHfBgJwh3wWTPatDqY8
         QeeLccZhySsP+F1UJ0u0+ZQ+putCYgKfAw1lZDrPRVHmrWeYw6IGcg/4tDr9U1AT4Rca
         Iq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMMUWb6wkhLMBAppMxvapOaONJYk7j8bUa+/YNRBP94=;
        b=t+cutBrPFq0pkuYQZ45SlGPvwfLmHgpL/FiA4M4sgTWApNQlxoMi6nAznNMRTqNNhd
         slD0HoBZ/8AlpuqEjL/OogzERnYl0JOjwrbY4ysJr0QUEy32ssgygUVxGlw+9Ki9Kk21
         I4XlyDEVKbK93QdhNnxGcN7pWcFw4sTqg/h4MflZ6pp/LLrRh8MnCGCCQlT4iyDjUFnX
         y8tJqhmdrtSPh+bQaKL92UgaUHTOLZeF7b9k43kwGEP+U+mm5+t035KQsbJi7MQZ606Y
         ubMWz6KpMqIRSoR3tTS4nWcvK2jhv6YvWiEfOeJwr97eZzZqXk9YXJQ8e3Z9VG4d62r4
         Zdiw==
X-Gm-Message-State: AOAM5320sqgh3SPJtZSC8lZRwPNWmRZxCL7dxAsEvvHHhbYsNvfFecA3
        wFveplWhzIMOaHJxQXbLYpcA3BI0Vju1HOU+gzoORA==
X-Google-Smtp-Source: ABdhPJzwBQFtGazIbsVXLKumsvSrTi8d2fb13fZdnf2cMZU66URqGmfZPUDWHywNnxYZFrnuI2DJ/fANdeDreUFkOC8=
X-Received: by 2002:a65:6645:: with SMTP id z5mr5879991pgv.273.1615444482382;
 Wed, 10 Mar 2021 22:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-6-songmuchun@bytedance.com> <YEjlf/yV+hz+NksO@dhcp22.suse.cz>
In-Reply-To: <YEjlf/yV+hz+NksO@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 14:34:04 +0800
Message-ID: <CAMZfGtX28p-42bMCuddsYfE0AWpDbWUoLY32+4vn8L5nptNxqw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 5/9] mm: hugetlb: set the PageHWPoison
 to the raw error page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:28 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 08-03-21 18:28:03, Muchun Song wrote:
> > Because we reuse the first tail vmemmap page frame and remap it
> > with read-only, we cannot set the PageHWPosion on some tail pages.
> > So we can use the head[4].private (There are at least 128 struct
> > page structures associated with the optimized HugeTLB page, so
> > using head[4].private is safe) to record the real error page index
> > and set the raw error page PageHWPoison later.
>
> Can we have more poisoned tail pages? Also who does consume that index
> and set the HWPoison on the proper tail page?

Good point. I look at the routine of memory failure closely.
If we do not clear the HWPoison of the head page, we cannot
poison another tail page.

So we should not set the destructor of the huge page from
HUGETLB_PAGE_DTOR to NULL_COMPOUND_DTOR
before calling alloc_huge_page_vmemmap(). In this case,
the below check of PageHuge() always returns true.

I need to fix this in the previous patch.

memory_failure()
    if (PageHuge(page))
        memory_failure_hugetlb()
            head = compound_head(page)
            if (TestSetPageHWPoison(head))
                return

Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Tested-by: Chen Huang <chenhuang5@huawei.com>
> > Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> > ---
> >  mm/hugetlb.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 72 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 377e0c1b283f..c0c1b7635ca9 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1304,6 +1304,74 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >                                               unsigned int order) { }
> >  #endif
> >
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
> > +{
> > +     struct page *page;
> > +
> > +     if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
> > +             return;
> > +
> > +     page = head + page_private(head + 4);
> > +
> > +     /*
> > +      * Move PageHWPoison flag from head page to the raw error page,
> > +      * which makes any subpages rather than the error page reusable.
> > +      */
> > +     if (page != head) {
> > +             SetPageHWPoison(page);
> > +             ClearPageHWPoison(head);
> > +     }
> > +}
> > +
> > +static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
> > +                                     struct page *page)
> > +{
> > +     if (!PageHWPoison(head))
> > +             return;
> > +
> > +     if (free_vmemmap_pages_per_hpage(h)) {
> > +             set_page_private(head + 4, page - head);
> > +     } else if (page != head) {
> > +             /*
> > +              * Move PageHWPoison flag from head page to the raw error page,
> > +              * which makes any subpages rather than the error page reusable.
> > +              */
> > +             SetPageHWPoison(page);
> > +             ClearPageHWPoison(head);
> > +     }
> > +}
> > +
> > +static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
> > +{
> > +     if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
> > +             return;
> > +
> > +     set_page_private(head + 4, 0);
> > +}
> > +#else
> > +static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
> > +{
> > +}
> > +
> > +static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
> > +                                     struct page *page)
> > +{
> > +     if (PageHWPoison(head) && page != head) {
> > +             /*
> > +              * Move PageHWPoison flag from head page to the raw error page,
> > +              * which makes any subpages rather than the error page reusable.
> > +              */
> > +             SetPageHWPoison(page);
> > +             ClearPageHWPoison(head);
> > +     }
> > +}
> > +
> > +static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
> > +{
> > +}
> > +#endif
> > +
> >  static int update_and_free_page(struct hstate *h, struct page *page)
> >       __releases(&hugetlb_lock) __acquires(&hugetlb_lock)
> >  {
> > @@ -1357,6 +1425,8 @@ static int update_and_free_page(struct hstate *h, struct page *page)
> >               return -ENOMEM;
> >       }
> >
> > +     hwpoison_subpage_deliver(h, page);
> > +
> >       for (i = 0; i < pages_per_huge_page(h);
> >            i++, subpage = mem_map_next(subpage, page, i)) {
> >               subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> > @@ -1801,14 +1871,7 @@ int dissolve_free_huge_page(struct page *page)
> >                       goto retry;
> >               }
> >
> > -             /*
> > -              * Move PageHWPoison flag from head page to the raw error page,
> > -              * which makes any subpages rather than the error page reusable.
> > -              */
> > -             if (PageHWPoison(head) && page != head) {
> > -                     SetPageHWPoison(page);
> > -                     ClearPageHWPoison(head);
> > -             }
> > +             hwpoison_subpage_set(h, head, page);
> >               list_del(&head->lru);
> >               h->free_huge_pages--;
> >               h->free_huge_pages_node[nid]--;
> > @@ -1818,6 +1881,7 @@ int dissolve_free_huge_page(struct page *page)
> >                       h->surplus_huge_pages--;
> >                       h->surplus_huge_pages_node[nid]--;
> >                       h->max_huge_pages++;
> > +                     hwpoison_subpage_clear(h, head);
> >               }
> >       }
> >  out:
> > --
> > 2.11.0
> >
>
> --
> Michal Hocko
> SUSE Labs
