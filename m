Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1583228D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 11:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBWK2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 05:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhBWK2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:28:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1CDC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 02:27:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cx11so1504203pjb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 02:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsAlBEioJWPlE/SfmIRHP8CqLqTdFtcrzccsM5cB+R0=;
        b=Ys/7GJocBf6sJ4nFA3vG4a8OX6mw+NdBaUqZ12DWzrV3fZccA3R4QYfl3pLfZPTFTc
         36b47Oq/dFpsrhWFkqM1lnReccu6RUOyMP8EQSEA4RQW7hHWsVs5XExtJw4q2djMEBP7
         oH2lkscq41McTnJskdNFbT3LcWlovKmlUnG55WZo1nX9InAPpRIRDewHJITEbGXxS+W8
         QJ1Jl0LrGvEf4yht4eLQKVZooAiGg0HSpZJsQotql2FReOt2Ab1bY37Tuyt7x/pDPBnO
         P2XYO5w7gVCunLge1+dYnKJWht7vv4xAJLZiy6xSQc7dWTrcBw6cMAhH7q2R/deehLib
         5i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsAlBEioJWPlE/SfmIRHP8CqLqTdFtcrzccsM5cB+R0=;
        b=juvUwuwKLHctVO1ADZXviU04A6qfJapYVSeLhN0PdPSFFAWhm10EjXmR9NrhtKtxfe
         2Kw+XEPsT4DocYJzywVY/S6AxOQfl/Tf/0MyWVE+92HSfUL9Oq81708F69Gou6O3ldpd
         IqdH318hT5os2DwLDzn+Gd+qbFGlwVV9j0S4kOVeZQQaZ29RlwRU/l7WNVLQ/3y14YOt
         UPhlpN0hTyyiYvf7SWcknwz770SkEdxEVWbl4zAeJs22O2qMFsu3FiRhDdqSJaql1NEf
         A02oFQ7EqZpfyz1dbna3/UhMcyrj5766NUK7CXPihVZ3M9pwWnn1eq/RPFp+zkvh1cdP
         PpAQ==
X-Gm-Message-State: AOAM532jE9WukKUKqpF6QDRRd0a42g9PVtF/KG+LAb6sAybZGZmIHePp
        OW3a7Tmh3wS+UBWP/4th1+8g8fTb2+hQ7f0w14O6vw==
X-Google-Smtp-Source: ABdhPJzoTOm14qBpXTrTOy4tiMVrs/RUpxAE2Rzm0OLejTjzGP7Zp5z6bsLhSG9DlKlA1aw3h9BenJT+PO3lsTYt9hQ=
X-Received: by 2002:a17:90a:f18d:: with SMTP id bv13mr7273299pjb.13.1614076064700;
 Tue, 23 Feb 2021 02:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com> <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
 <20210223092740.GA1998@linux>
In-Reply-To: <20210223092740.GA1998@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 23 Feb 2021 18:27:07 +0800
Message-ID: <CAMZfGtVRSBkKe=tKAKLY8dp_hywotq3xL+EJZNjXuSKt3HK3bQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 5:28 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Feb 22, 2021 at 04:00:27PM -0800, Mike Kravetz wrote:
> > > -static void update_and_free_page(struct hstate *h, struct page *page)
> > > +static int update_and_free_page(struct hstate *h, struct page *page)
> > > +   __releases(&hugetlb_lock) __acquires(&hugetlb_lock)
> > >  {
> > >     int i;
> > > +   int nid = page_to_nid(page);
> > >
> > >     if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> > > -           return;
> > > +           return 0;
> > >
> > >     h->nr_huge_pages--;
> > > -   h->nr_huge_pages_node[page_to_nid(page)]--;
> > > +   h->nr_huge_pages_node[nid]--;
> > > +   VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> > > +   VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> > > +   set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > > +   set_page_refcounted(page);
> >
> > I think you added the set_page_refcounted() because the huge page will
> > appear as just a compound page without a reference after dropping the
> > hugetlb lock?  It might be better to set the reference before modifying
> > the destructor.  Otherwise, page scanning code could find the non-hugetlb
> > compound page with no reference.  I could not find any code where this
> > would be a problem, but I think it would be safer to set the reference
> > first.
>
> But we already had set_page_refcounted() before this patchset there.
> Are the worries only because we drop the lock? AFAICS, the "page-scanning"
> problem could have happened before as well?
> Although, what does page scanning mean in this context?
>
> I am not opposed to move it above, but I would like to understand the concern
> here.
>
> >
> > > +   spin_unlock(&hugetlb_lock);
> >
> > I really like the way this code is structured.  It is much simpler than
> > previous versions with retries or workqueue.  There is nothing wrong with
> > always dropping the lock here.  However, I wonder if we should think about
> > optimizing for the case where this feature is not enabled and we are not
> > freeing a 1G huge page.  I suspect this will be the most common case for
> > some time, and there is no need to drop the lock in this case.
> >
> > Please do not change the code based on my comment.  I just wanted to bring
> > this up for thought.
> >
> > Is it as simple as checking?
> >         if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> >                 spin_unlock(&hugetlb_lock);
> >
> >         /* before return */
> >         if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> >                 spin_lock(&hugetlb_lock);
>
> AFAIK, we at least need the hstate_is_gigantic? Comment below says that
> free_gigantic_page might block, so we need to drop the lock.
> And I am fine with the change overall.
>
> Unless I am missing something, we should not need to drop the lock unless
> we need to allocate vmemmap pages (apart from gigantic pages).
>
> >
> > > +
> > > +   if (alloc_huge_page_vmemmap(h, page)) {
> > > +           int zeroed;
> > > +
> > > +           spin_lock(&hugetlb_lock);
> > > +           INIT_LIST_HEAD(&page->lru);
> > > +           set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> > > +           h->nr_huge_pages++;
> > > +           h->nr_huge_pages_node[nid]++;
>
> I think prep_new_huge_page() does this for us?

Actually, there are some differences. e.g. prep_new_huge_page()
will reset hugetlb cgroup and ClearHPageFreed, but we do not need
them here. And prep_new_huge_page will acquire and release
the hugetlb_lock. But here we also need hold the lock to update
the surplus counter and enqueue the page to the free list.
So I do not think reuse prep_new_huge_page is a good idea.

>
> > > +
> > > +           /*
> > > +            * If we cannot allocate vmemmap pages, just refuse to free the
> > > +            * page and put the page back on the hugetlb free list and treat
> > > +            * as a surplus page.
> > > +            */
> > > +           h->surplus_huge_pages++;
> > > +           h->surplus_huge_pages_node[nid]++;
> > > +
> > > +           /*
> > > +            * This page is now managed by the hugetlb allocator and has
> > > +            * no users -- drop the last reference.
> > > +            */
> > > +           zeroed = put_page_testzero(page);
> > > +           VM_BUG_ON_PAGE(!zeroed, page);
>
> Can this actually happen? AFAIK, page landed in update_and_free_page should be
> zero refcounted, then we increase the reference, and I cannot see how the
> reference might have changed in the meantime.

I am not sure whether other modules get the page and then put the
page. I see gather_surplus_pages does the same thing. So I copied
from there. I try to look at the memory_failure routine.


CPU0:                           CPU1:
                                set_compound_page_dtor(HUGETLB_PAGE_DTOR);
memory_failure_hugetlb
  get_hwpoison_page
    __get_hwpoison_page
      get_page_unless_zero
                                put_page_testzero()

Maybe this can happen. But it is a very corner case. If we want to
deal with this. We can put_page_testzero() first and then
set_compound_page_dtor(HUGETLB_PAGE_DTOR).

>
> I am all for catching corner cases, but not sure how realistic this is.
> Moreover, if we __ever__ get there, things can get nasty.
>
> We basically will have an in-use page in the free hugetlb pool, so corruption
> will happen. At that point, a plain BUG_ON might be better.
>
> But as I said, I do not think we need that.
>
> I yet need to look further, but what I have seen so far looks good.
>
> --
> Oscar Salvador
> SUSE L3
