Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9395D362DA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 06:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhDQEPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 00:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhDQEOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:14:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203EC061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 21:13:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t22so14661534ply.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 21:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylgfgCTB63uVvdacThJs9TcQmae/fWoutKmKR8VmUn4=;
        b=y4PC6dhtLnxM+GheU9KrGq+aZszXhMW31nY1EERC+Q72IGwebhRGazT63ogIYWDj9U
         bDAh3OQw+ccOX2q0qvSG2KEEMjFgOT4A45hkFRtshiPAth22yLZ2MF3dhsUkV5YBqEvl
         4dOGTAwsLEvtH1HBM5TYHtqF7EqdsZ3Ek8cIgdkIsk0M0SGrv5+rYesR4Ol/RBZGkTPr
         bqq+nda5GpPH4KS5Belg9AP4J6t5ACS7h9yC4GhWf+1yzPr8RMMLCdWP+JznF/FtmnFo
         Oef0zZVhvFSkR9DoOF6bQ9aQykFqqsHWSvCrnJ/Cj/lnFL/OABVuwCXJ5q3/sotSBdg4
         p8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylgfgCTB63uVvdacThJs9TcQmae/fWoutKmKR8VmUn4=;
        b=iNlCW2i+BGlZBc+45Ljv01JdWtvEzgG1WmQsP9ZV5peTDTwH9E0bOrsKrg647MJzDn
         LQAlT/kiPOqojByrCUS7spRdJhOBp8qnxhGn4d60ewBDCUE/CYxJLJM+lveD9wUSiRV4
         5Pu3siUfqzNc+rLx44wFY34oq4Q/gr3j263ZtmKgTtL3nxwoColU8z/ec2EPon66EngY
         4kJB7FUeXBLtSF47zd8yhvitaCslEm4PDFgF5GJsUcg1+6EBQgSn53N22zuOrqMFbkVd
         oEbk8vB+bKmh8/v2zFwsDmxhC3srQStP855d30VxYFFiJHInDaOKBkOyC8w1uIBmgV4B
         usdA==
X-Gm-Message-State: AOAM533HCIqJeWeX2Nr56sLQbgqQLjf8sKwDxYGE9R6OaQjmHDHqJ0hl
        OPc5y0p8ureaMTgiroeu6cjbxkAbchsKdZByIiFeRQ==
X-Google-Smtp-Source: ABdhPJyTA/qdCYB5+347wvSUfF0S0QefLWSkq+r4WoEHhHvTfIvW8GVDcnUKBnDhsKr6eX5RccpxInyNQNh1cYXazl8=
X-Received: by 2002:a17:90a:a895:: with SMTP id h21mr13280750pjq.13.1618632833248;
 Fri, 16 Apr 2021 21:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-6-songmuchun@bytedance.com> <33a4f2fe-72c2-a3a1-9205-461ddde9b162@oracle.com>
In-Reply-To: <33a4f2fe-72c2-a3a1-9205-461ddde9b162@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 17 Apr 2021 12:13:17 +0800
Message-ID: <CAMZfGtWXpTfeHeuHJdX5hjd03sNabZeh7Uzw7sPqgOFCWQDDZA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v20 5/9] mm: hugetlb: defer freeing of
 HugeTLB pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com,
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
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 17, 2021 at 7:56 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 4/15/21 1:40 AM, Muchun Song wrote:
> > In the subsequent patch, we should allocate the vmemmap pages when
> > freeing a HugeTLB page. But update_and_free_page() can be called
> > under any context, so we cannot use GFP_KERNEL to allocate vmemmap
> > pages. However, we can defer the actual freeing in a kworker to
> > prevent from using GFP_ATOMIC to allocate the vmemmap pages.
>
> Thanks!  I knew we would need to introduce a kworker for this when I
> removed the kworker previously used in free_huge_page.

Yeah, but another choice is using GFP_ATOMIC to allocate vmemmap
pages when we are in an atomic context. If not atomic context, just
use GFP_KERNEL. In this case, we can drop kworker.

>
> > The __update_and_free_page() is where the call to allocate vmemmmap
> > pages will be inserted.
>
> This patch adds the functionality required for __update_and_free_page
> to potentially sleep and fail.  More questions will come up in the
> subsequent patch when code must deal with the failures.

Right. More questions are welcome.

>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c         | 73 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  mm/hugetlb_vmemmap.c | 12 ---------
> >  mm/hugetlb_vmemmap.h | 17 ++++++++++++
> >  3 files changed, 85 insertions(+), 17 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 923d05e2806b..eeb8f5480170 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1376,7 +1376,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
> >       h->nr_huge_pages_node[nid]--;
> >  }
> >
> > -static void update_and_free_page(struct hstate *h, struct page *page)
> > +static void __update_and_free_page(struct hstate *h, struct page *page)
> >  {
> >       int i;
> >       struct page *subpage = page;
> > @@ -1399,12 +1399,73 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> >       }
> >  }
> >
> > +/*
> > + * As update_and_free_page() can be called under any context, so we cannot
> > + * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
> > + * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
> > + * the vmemmap pages.
> > + *
> > + * free_hpage_workfn() locklessly retrieves the linked list of pages to be
> > + * freed and frees them one-by-one. As the page->mapping pointer is going
> > + * to be cleared in free_hpage_workfn() anyway, it is reused as the llist_node
> > + * structure of a lockless linked list of huge pages to be freed.
> > + */
> > +static LLIST_HEAD(hpage_freelist);
> > +
> > +static void free_hpage_workfn(struct work_struct *work)
> > +{
> > +     struct llist_node *node;
> > +
> > +     node = llist_del_all(&hpage_freelist);
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
>
> The VM_BUG_ON_PAGE(!PageHuge(page), page) in page_hstate is going to
> trigger because a previous call to remove_hugetlb_page() will
> set_compound_page_dtor(page, NULL_COMPOUND_DTOR)

Sorry, I did not realise that. Thanks for your reminder.

>
> Note how h(hstate) is grabbed before calling update_and_free_page in
> existing code.
>
> We could potentially drop the !PageHuge(page) in page_hstate.  Or,
> perhaps just use 'size_to_hstate(page_size(page))' in free_hpage_workfn.

I prefer not to change the behavior of page_hstate(). So I
should use 'size_to_hstate(page_size(page))' directly.

Thanks Mike.


> --
> Mike Kravetz
