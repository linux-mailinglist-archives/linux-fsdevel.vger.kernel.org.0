Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761EE2DCB3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 04:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLQDUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 22:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgLQDUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 22:20:44 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7027EC0617B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 19:19:58 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c22so3932538pgg.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 19:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbs7EgWZM52eCkELY86Hx3Zy59sL0MGXRI9ZDzydt2c=;
        b=DjbHeqrJr1G09b1tq/4/bGl9ph/QpMnxYiVt/4LUikyVkDynO0Z+2OztDUd8jKixY+
         Kjj+U6omCQFXxlfIyKkqy6hd/h2uJp6nU7+Xn2BXnlFSvE0bhqIJ5ojY52b+JZ4Zm0DU
         N/u2hmCHQ/k6VYjzZC1eQG3H4ePsUALhLZ6n+rian726xsArim630rX4iJfPntTj0ZXL
         btZaJndxj/OLEl2+0Dn18H/gvmVq0GOsMzzqv2QaTRC8OhJSG1xZ4yXBr61XkEo/2ZvP
         4r+vJdF1oYQO7WiPkVdRuynOFCHEk/67kIobjm4rfscCONh3xpui46H5urXVcKEi4qhj
         8XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbs7EgWZM52eCkELY86Hx3Zy59sL0MGXRI9ZDzydt2c=;
        b=W/fCk7ABnBHwFKCHUQrjVJ6H0UPnxZuHWgzpCNb1tH+qno0NyUfUqptaHUrU50ozP6
         qW/7+GUVFqrHDDiNzZHQeLWWUhPY03ETtWnX1zVYDASt7+Ti8/pKPnYKShGZyi5V5l6S
         dubQqDeQHHng0s9c+Jpb1/0Vpi9lRIlc5BMPLhA7Gj7suTjN2EAlJ3QZL3Eu+CK45GO3
         yvRdBWekejd+fu4a1LiKPQRcqc7anDHbqmbeOlhC+6Fgx6+y/AscsRfHt3pIPj4yUbCq
         vZuTEBzvVHEExzdwYoQS5pi6/oNkR0f7jjOfbp/FjX1g/6+RCphNixOL2frklLtmW1Fo
         VTRA==
X-Gm-Message-State: AOAM533yDSjKJ2zBNNRfORHYoqWLpwSkiaNbOG2UqfU53JEOi9nh4JRF
        6RZhZsUUpSHkL4WduRA5msLr5Lnue3NmelQrn9Af8w==
X-Google-Smtp-Source: ABdhPJy/YaJPtY/hqJbcS/FGGKfDszH2srApx17B+zdeojgzKxeVpXHtauVm3SP3eS9HwXVXuS1t+NctH625G9fRFWY=
X-Received: by 2002:a63:50a:: with SMTP id 10mr7737721pgf.273.1608175197760;
 Wed, 16 Dec 2020 19:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-5-songmuchun@bytedance.com> <6b555fb8-6fd5-049a-49c1-4dc8a3f66766@oracle.com>
In-Reply-To: <6b555fb8-6fd5-049a-49c1-4dc8a3f66766@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 17 Dec 2020 11:19:21 +0800
Message-ID: <CAMZfGtUu7P2eJSv9jhLWxaYsNidHZZpDPSTZLC7VprMaLKmgmg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 04/11] mm/hugetlb: Defer freeing of
 HugeTLB pages
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

On Thu, Dec 17, 2020 at 7:48 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/13/20 7:45 AM, Muchun Song wrote:
> > In the subsequent patch, we will allocate the vmemmap pages when free
> > HugeTLB pages. But update_and_free_page() is called from a non-task
> > context(and hold hugetlb_lock), so we can defer the actual freeing in
> > a workqueue to prevent use GFP_ATOMIC to allocate the vmemmap pages.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> It is unfortunate we need to add this complexitty, but I can not think
> of another way.  One small comment (no required change) below.
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thank you.

>
> > ---
> >  mm/hugetlb.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  mm/hugetlb_vmemmap.c | 12 --------
> >  mm/hugetlb_vmemmap.h | 17 ++++++++++++
> >  3 files changed, 88 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 140135fc8113..0ff9b90e524f 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1292,15 +1292,76 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >                                               unsigned int order) { }
> >  #endif
> >
> > -static void update_and_free_page(struct hstate *h, struct page *page)
> > +static void __free_hugepage(struct hstate *h, struct page *page);
> > +
> > +/*
> > + * As update_and_free_page() is be called from a non-task context(and hold
> > + * hugetlb_lock), we can defer the actual freeing in a workqueue to prevent
> > + * use GFP_ATOMIC to allocate a lot of vmemmap pages.
> > + *
> > + * update_hpage_vmemmap_workfn() locklessly retrieves the linked list of
> > + * pages to be freed and frees them one-by-one. As the page->mapping pointer
> > + * is going to be cleared in update_hpage_vmemmap_workfn() anyway, it is
> > + * reused as the llist_node structure of a lockless linked list of huge
> > + * pages to be freed.
> > + */
> > +static LLIST_HEAD(hpage_update_freelist);
> > +
> > +static void update_hpage_vmemmap_workfn(struct work_struct *work)
> >  {
> > -     int i;
> > +     struct llist_node *node;
> > +     struct page *page;
> > +
> > +     node = llist_del_all(&hpage_update_freelist);
> >
> > +     while (node) {
> > +             page = container_of((struct address_space **)node,
> > +                                  struct page, mapping);
> > +             node = node->next;
> > +             page->mapping = NULL;
> > +             __free_hugepage(page_hstate(page), page);
> > +
> > +             cond_resched();
> > +     }
> > +}
> > +static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
> > +
> > +static inline void __update_and_free_page(struct hstate *h, struct page *page)
> > +{
> > +     /* No need to allocate vmemmap pages */
> > +     if (!free_vmemmap_pages_per_hpage(h)) {
> > +             __free_hugepage(h, page);
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap
> > +      * pages.
> > +      *
> > +      * Only call schedule_work() if hpage_update_freelist is previously
> > +      * empty. Otherwise, schedule_work() had been called but the workfn
> > +      * hasn't retrieved the list yet.
> > +      */
> > +     if (llist_add((struct llist_node *)&page->mapping,
> > +                   &hpage_update_freelist))
> > +             schedule_work(&hpage_update_work);
> > +}
> > +
> > +static void update_and_free_page(struct hstate *h, struct page *page)
> > +{
> >       if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> >               return;
> >
> >       h->nr_huge_pages--;
> >       h->nr_huge_pages_node[page_to_nid(page)]--;
> > +
> > +     __update_and_free_page(h, page);
> > +}
> > +
> > +static void __free_hugepage(struct hstate *h, struct page *page)
> > +{
> > +     int i;
> > +
>
> Can we add a comment here saying that this is where the call to allocate
> vmemmmap pages will be inserted in a later patch.  Such a comment would
> help a bit to understand the restructuring of the code.

OK. Will do. Thanks.

>
> --
> Mike Kravetz
>
> >       for (i = 0; i < pages_per_huge_page(h); i++) {
> >               page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
> >                               1 << PG_referenced | 1 << PG_dirty |
> > @@ -1313,13 +1374,17 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> >       set_page_refcounted(page);
> >       if (hstate_is_gigantic(h)) {
> >               /*
> > -              * Temporarily drop the hugetlb_lock, because
> > -              * we might block in free_gigantic_page().
> > +              * Temporarily drop the hugetlb_lock only when this type of
> > +              * HugeTLB page does not support vmemmap optimization (which
> > +              * contex do not hold the hugetlb_lock), because we might block
> > +              * in free_gigantic_page().
> >                */
> > -             spin_unlock(&hugetlb_lock);
> > +             if (!free_vmemmap_pages_per_hpage(h))
> > +                     spin_unlock(&hugetlb_lock);
> >               destroy_compound_gigantic_page(page, huge_page_order(h));
> >               free_gigantic_page(page, huge_page_order(h));
> > -             spin_lock(&hugetlb_lock);
> > +             if (!free_vmemmap_pages_per_hpage(h))
> > +                     spin_lock(&hugetlb_lock);
> >       } else {
> >               __free_pages(page, huge_page_order(h));
> >       }



-- 
Yours,
Muchun
