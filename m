Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7C3020EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 05:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbhAYD7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 22:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbhAYD7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:59:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D55C06174A
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 19:59:04 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i63so7634334pfg.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 19:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JawmNI2cw7dC+renZYHY4PhE5rPmyLgqTpnvi0+Z94E=;
        b=i+XW3lJuJx4xsB43+d4WmMeA1XBib0Lbd67jLeCEJwWlNJqNf/dI0LfOc90u9wTZB9
         9Ow/6b92TQ/NSL4xfgGz2BGnq7FmCxeMEfQ8498E8+skKsd4ruCVqTU8ng+yV3fVgo2o
         RXy8JUE019jPedU7S9UnxT01GI/L6C6t3PR0myctdR6Qe37/ZDZPcoK5k0FAN2OgW0bP
         PzXZ5qayVhE4BId7InEM1+ya+SN0bfusauctEnFobR7X2oOS/E0BD/Us9RKejDvJX7bR
         WkRgZVOfO2N95U6srshwm1Jn1PU3l+BzCbI8tAN3W6iKuG6hnoUS54DctdsYZwq32Sro
         OZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JawmNI2cw7dC+renZYHY4PhE5rPmyLgqTpnvi0+Z94E=;
        b=h3gZL263Nz0FkHEa/Dk3q/Mgf4pTQWVx2wYn4yOc1FxcI0ZllbU1qDZbyzTYyeBVQG
         MmJhCadNwsl3YQ04zQBuM2Avj/NZOAAGcTOtepC/3xQ+jcRIi9uapxY28oQIDK2b8V5l
         cz0s3mUnrNuXByuTptrasgatyWoIKIRvbm48ZzppREth3AvnIqwJ6gce1smE+lycU8xB
         4j/tyDEhqLOAYJE7jurDaTchdgP0QCycBCHr9ijSfnAlj3gumSWYgeIGe/RLDEANRedr
         MoBAgWWi9l55QX/ht2G4W/AwnJFm1uHJO3aKxOs2pxXZEBpAXncjniTI7zsFh0V4nIzI
         f8/Q==
X-Gm-Message-State: AOAM531RTZc6RhjUFyEbONrwYD9rQcXvWcXCQJxWeVN61+vonhRR8DwA
        cNs14QcgAZ3Mdvz1bzmSrM3twJEHiTOYNNbxziFLPw==
X-Google-Smtp-Source: ABdhPJwo/Nr8Bv+3rC1BGZXCTci7+PJcz19l2647770oGa45hpUmoQp0YwA1O7f0Gn40pHg0K5qRzCdFyHIVSmtZFa0=
X-Received: by 2002:a62:7694:0:b029:1b9:8d43:95af with SMTP id
 r142-20020a6276940000b02901b98d4395afmr16376787pfc.2.1611547143936; Sun, 24
 Jan 2021 19:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-5-songmuchun@bytedance.com> <59d18082-248a-7014-b917-625d759c572@google.com>
In-Reply-To: <59d18082-248a-7014-b917-625d759c572@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 25 Jan 2021 11:58:27 +0800
Message-ID: <CAMZfGtX0a3am_PLy3L8pmPW1qU+zwFJqUzzXd3e0Tt3Nen6SpA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 04/12] mm: hugetlb: defer freeing of
 HugeTLB pages
To:     David Rientjes <rientjes@google.com>
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
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
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

On Mon, Jan 25, 2021 at 7:55 AM David Rientjes <rientjes@google.com> wrote:
>
>
> On Sun, 17 Jan 2021, Muchun Song wrote:
>
> > In the subsequent patch, we should allocate the vmemmap pages when
> > freeing HugeTLB pages. But update_and_free_page() is always called
> > with holding hugetlb_lock, so we cannot use GFP_KERNEL to allocate
> > vmemmap pages. However, we can defer the actual freeing in a kworker
> > to prevent from using GFP_ATOMIC to allocate the vmemmap pages.
> >
> > The update_hpage_vmemmap_workfn() is where the call to allocate
> > vmemmmap pages will be inserted.
> >
>
> I think it's reasonable to assume that userspace can release free hugetlb
> pages from the pool on oom conditions when reclaim has become too
> expensive.  This approach now requires that we can allocate vmemmap pages
> in a potential oom condition as a prerequisite for freeing memory, which
> seems less than ideal.
>
> And, by doing this through a kworker, we can presumably get queued behind
> another work item that requires memory to make forward progress in this
> oom condition.
>
> Two thoughts:
>
> - We're going to be freeing the hugetlb page after we can allocate the
>   vmemmap pages, so why do we need to allocate with GFP_KERNEL?  Can't we
>   simply dip into memory reserves using GFP_ATOMIC (and thus can be
>   holding hugetlb_lock) because we know we'll be freeing more memory than
>   we'll be allocating?

Right.

>   I think requiring a GFP_KERNEL allocation to block
>   to free memory for vmemmap when we'll be freeing memory ourselves is
>   dubious.  This simplifies all of this.

Thanks for your thoughts. I just thought that we can go to reclaim
when there is no memory in the system. But we cannot block when
using GFP_KERNEL. Actually, we cannot deal with fail of memory
allocating. In the next patch, I try to sleep 100ms and then try again
to allocate memory when allocating memory fails.

>
> - If the answer is that we actually have to use GFP_KERNEL for other
>   reasons, what are your thoughts on pre-allocating the vmemmap as opposed
>   to deferring to a kworker?  In other words, preallocate the necessary
>   memory with GFP_KERNEL and put it on a linked list in struct hstate
>   before acquiring hugetlb_lock.

put_page() can be used in an atomic context. Actually, we cannot sleep
in the __free_huge_page(). It seems a little tricky. Right?

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  mm/hugetlb.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  mm/hugetlb_vmemmap.c | 12 ---------
> >  mm/hugetlb_vmemmap.h | 17 ++++++++++++
> >  3 files changed, 89 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 140135fc8113..c165186ec2cf 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1292,15 +1292,85 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >                                               unsigned int order) { }
> >  #endif
> >
> > -static void update_and_free_page(struct hstate *h, struct page *page)
> > +static void __free_hugepage(struct hstate *h, struct page *page);
> > +
> > +/*
> > + * As update_and_free_page() is always called with holding hugetlb_lock, so we
> > + * cannot use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
> > + * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
> > + * the vmemmap pages.
> > + *
> > + * The update_hpage_vmemmap_workfn() is where the call to allocate vmemmmap
> > + * pages will be inserted.
> > + *
> > + * update_hpage_vmemmap_workfn() locklessly retrieves the linked list of pages
> > + * to be freed and frees them one-by-one. As the page->mapping pointer is going
> > + * to be cleared in update_hpage_vmemmap_workfn() anyway, it is reused as the
> > + * llist_node structure of a lockless linked list of huge pages to be freed.
> > + */
> > +static LLIST_HEAD(hpage_update_freelist);
> > +
> > +static void update_hpage_vmemmap_workfn(struct work_struct *work)
> >  {
> > -     int i;
> > +     struct llist_node *node;
> > +
> > +     node = llist_del_all(&hpage_update_freelist);
> > +
> > +     while (node) {
> > +             struct page *page;
> > +             struct hstate *h;
> > +
> > +             page = container_of((struct address_space **)node,
> > +                                  struct page, mapping);
> > +             node = node->next;
> > +             page->mapping = NULL;
> > +             h = page_hstate(page);
> > +
> > +             spin_lock(&hugetlb_lock);
> > +             __free_hugepage(h, page);
> > +             spin_unlock(&hugetlb_lock);
> >
> > +             cond_resched();
>
> Wouldn't it be better to hold hugetlb_lock for the iteration rather than
> constantly dropping it and reacquiring it?  Use
> cond_resched_lock(&hugetlb_lock) instead?

Great. We can use it. Thanks.
