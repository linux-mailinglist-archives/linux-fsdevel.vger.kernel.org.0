Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DF5366422
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 05:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhDUDnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 23:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbhDUDnm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 23:43:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F802C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 20:43:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h11so9736525pfn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 20:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmKEWuh5kX+xwliBF/7UPbgNwt5vdw/WaIbOHk7+c2c=;
        b=D7SzKgyrUNQwXWF1oBPoS5L/TdTX7IV6DZcj4o3bXAG/nI1PLwARVLHG05VNer8PrQ
         LqQMbArJmBX7eFaejaAcIQ+iDUsJRbdJudzkznKNK9i5Pj3hwzk3PZ3XrBB612K+qNVW
         5eOZ9jXYCAGMnI7SMy2msbQj7sxWn7Kbwb6IQHRN+1DnNysKm6li7qWZ8HbocKa5HKgy
         9cwTk9BczWKoSi9OqrNCmmRzVETsKrujTohOO8EO5gyyhP8jrBrHibLeN8qoNfx3wYK+
         5PuE0RuIe7cSKlOmBrSiRb8uRzi3YAmBRGLNr/JV5aGCt7oYM/N+jrwUD0Sa/mCRj6Xa
         DZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmKEWuh5kX+xwliBF/7UPbgNwt5vdw/WaIbOHk7+c2c=;
        b=B66dVGUQsSI18dorPWOk+ZYTyKwZl5UK8oPF1DtcbNuQewBHFbP9be19ehXvXYvAL5
         osiWpaHMFrIcOYim2HXjJxSnXWSlncsF4nabZFeZBFqxquCdrLRQlDl/Pipaxb5LnavD
         RgEwYVE8Ij1iwGqDQ99dtu08G3tfl/aPtC2ARYV98lOUSTAxPH17q0zludLZalbdUpjN
         rpzhrdS+7jvdmckCPVyqPAkhuicSHzQo+BKA9Kl0Lrq5F4+NHQK3QPWBmmvRrTzvoYkO
         l0HwtB/PqLoQXdikl79tZyEjMiYLf+tQZSSelYtHUOnE633mwEUiVcrGmzDeMer0Ll/X
         7PJA==
X-Gm-Message-State: AOAM531/QZeaS/lKtcC/mfWobIPF4bNHERZo9JGm44rGMy8D3R5DCL3h
        /t3ayxuldLTWllTR/L7HrinQS0nylzv6dl33KXQ4dw==
X-Google-Smtp-Source: ABdhPJxJBozIBcM52f25VJKMAu9Q4Z49o+wvjiK79PClh8TFh0Gj5u1gwWUVmU2G1T3AbtNVtkTL5Fx4chmzwPXwWD4=
X-Received: by 2002:a05:6a00:8c7:b029:20f:1cf4:d02 with SMTP id
 s7-20020a056a0008c7b029020f1cf40d02mr28230925pfu.49.1618976588944; Tue, 20
 Apr 2021 20:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-7-songmuchun@bytedance.com> <5f914142-009b-3bfc-9cb2-46154f610e29@oracle.com>
 <CAMZfGtV+_mNRumR1RBWiu6OOqhUsTZyBvp--39CJHEEFKMX5Eg@mail.gmail.com> <8de3d7a0-f100-5d50-fe54-b83af07570f4@oracle.com>
In-Reply-To: <8de3d7a0-f100-5d50-fe54-b83af07570f4@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 11:42:31 +0800
Message-ID: <CAMZfGtWMSjYS_Xqb8qXfvzsQCZG7Vn2hUxpxiOqLrPXgy80Suw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v20 6/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
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

On Wed, Apr 21, 2021 at 1:48 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 4/20/21 1:46 AM, Muchun Song wrote:
> > On Tue, Apr 20, 2021 at 7:20 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 4/15/21 1:40 AM, Muchun Song wrote:
> >>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> >>> index 0abed7e766b8..6e970a7d3480 100644
> >>> --- a/include/linux/hugetlb.h
> >>> +++ b/include/linux/hugetlb.h
> >>> @@ -525,6 +525,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> >>>   *   code knows it has only reference.  All other examinations and
> >>>   *   modifications require hugetlb_lock.
> >>>   * HPG_freed - Set when page is on the free lists.
> >>> + * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
> >>>   *   Synchronization: hugetlb_lock held for examination and modification.
> >>
> >> I like the per-page flag.  In previous versions of the series, you just
> >> checked the free_vmemmap_pages_per_hpage() to determine if vmemmmap
> >> should be allocated.  Is there any change in functionality that makes is
> >> necessary to set the flag in each page, or is it mostly for flexibility
> >> going forward?
> >
> > Actually, only the routine of dissolving the page cares whether
> > the page is on the buddy free list when update_and_free_page
> > returns. But we cannot change the return type of the
> > update_and_free_page (e.g. change return type from 'void' to 'int').
> > Why? If the hugepage is freed through a kworker, we cannot
> > know the return value when update_and_free_page returns.
> > So adding a return value seems odd.
> >
> > In the dissolving routine, We can allocate vmemmap pages first,
> > if it is successful, then we can make sure that
> > update_and_free_page can successfully free page. So I need
> > some stuff to mark the page which does not need to allocate
> > vmemmap pages.
> >
> > On the surface, we seem to have a straightforward method
> > to do this.
> >
> > Add a new parameter 'alloc_vmemmap' to update_and_free_page() to
> > indicate that the caller is already allocated the vmemmap pages.
> > update_and_free_page() do not need to allocate. Just like below.
> >
> >    void update_and_free_page(struct hstate *h, struct page *page, bool atomic,
> >            bool alloc_vmemmap)
> >    {
> >        if (alloc_vmemmap)
> >            // allocate vmemmap pages
> >    }
> >
> > But if the page is freed through a kworker. How to pass
> > 'alloc_vmemmap' to the kworker? We can embed this
> > information into the per-page flag. So if we introduce
> > HPG_vmemmap_optimized, the parameter of
> > alloc_vmemmap is also necessary.
> >
> > So it seems that introducing HPG_vmemmap_optimized is
> > a good choice.
>
> Thanks for the explanation!
>
> Agree that the flag is a good choice.  How about adding a comment like
> this above the alloc_huge_page_vmemmap call in dissolve_free_huge_page?
>
> /*
>  * Normally update_and_free_page will allocate required vmemmmap before
>  * freeing the page.  update_and_free_page will fail to free the page
>  * if it can not allocate required vmemmap.  We need to adjust
>  * max_huge_pages if the page is not freed.  Attempt to allocate
>  * vmemmmap here so that we can take appropriate action on failure.
>  */

Thanks. I will add this comment.

>
> ...
> >>> +static void add_hugetlb_page(struct hstate *h, struct page *page,
> >>> +                          bool adjust_surplus)
> >>> +{
> >>
> >> We need to be a bit careful with hugepage specific flags that may be
> >> set.  The routine remove_hugetlb_page which is called for 'page' before
> >> this routine will not clear any of the hugepage specific flags.  If the
> >> calling path goes through free_huge_page, most but not all flags are
> >> cleared.
> >>
> >> We had a discussion about clearing the page->private field in Oscar's
> >> series.  In the case of 'new' pages we can assume page->private is
> >> cleared, but perhaps we should not make that assumption here.  Since we
> >> hope to rarely call this routine, it might be safer to do something
> >> like:
> >>
> >>         set_page_private(page, 0);
> >>         SetHPageVmemmapOptimized(page);
> >
> > Agree. Thanks for your reminder. I will fix this.
> >
> >>
> >>> +     int nid = page_to_nid(page);
> >>> +
> >>> +     lockdep_assert_held(&hugetlb_lock);
> >>> +
> >>> +     INIT_LIST_HEAD(&page->lru);
> >>> +     h->nr_huge_pages++;
> >>> +     h->nr_huge_pages_node[nid]++;
> >>> +
> >>> +     if (adjust_surplus) {
> >>> +             h->surplus_huge_pages++;
> >>> +             h->surplus_huge_pages_node[nid]++;
> >>> +     }
> >>> +
> >>> +     set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> >>> +
> >>> +     /*
> >>> +      * The refcount can possibly be increased by memory-failure or
> >>> +      * soft_offline handlers.
> >>> +      */
> >>> +     if (likely(put_page_testzero(page))) {
> >>
> >> In the existing code there is no such test.  Is the need for the test
> >> because of something introduced in the new code?
> >
> > No.
> >
> >> Or, should this test be in the existing code?
> >
> > Yes. gather_surplus_pages should be fixed. I can fix it
> > in a separate patch.
> >
> > The possible bad scenario:
> >
> > CPU0:                           CPU1:
> >                                 set_compound_page_dtor(HUGETLB_PAGE_DTOR);
> > memory_failure_hugetlb
> >   get_hwpoison_page
> >     __get_hwpoison_page
> >       get_page_unless_zero
> >                                 put_page_testzero()
> >
> >   put_page(page)
> >
> >
> > More details and discussion can refer to:
> >
> > https://lore.kernel.org/linux-doc/CAMZfGtVRSBkKe=tKAKLY8dp_hywotq3xL+EJZNjXuSKt3HK3bQ@mail.gmail.com/
> >
>
> Thanks you!  I did not remember that discussion.
>
> It would be helpful to add a separate patch for gather_surplus_pages.
> Otherwise, we have the VM_BUG_ON there and not in add_hugetlb_page.
>

Agree. Will do.

> --
> Mike Kravetz
