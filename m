Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E249433D2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhJSRSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhJSRSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:18:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFEC06161C;
        Tue, 19 Oct 2021 10:15:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so15275571edj.1;
        Tue, 19 Oct 2021 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wLiwP4PYVuwZlz+x1fvIxqOli9YkMfOKg6xVp14qC0=;
        b=WNTE6p3/rRu5nmONgyL2GNOQC7z66zi8i93DgsBF6i+zt5yx88xgKqUiGt0Ln/XRaV
         9mMC90w/5eGldjApqDvaVEpOXq/vLB5l4ZZXsPI/LlTlOn47m7o1Z+bNdhm13iyODNfU
         EoTjbEChsVbzByPB0MeDmKl2No3GvLQAtc2w5K0iitmwY3/dNj4rs5FNE1kIKnClCHVJ
         ZFOWa1c7DtvqyJCzhHX5jpc8yilgkngyR58RE5yrEav2f6tYC276bkZ8/U2hmkYDaQ7Y
         a0u/CDT6G3/jmqouslWUfQnX0D1F+tBaIpqJb5FRrvZN92Jx4L58XIOTaFVXVeyYledc
         h71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wLiwP4PYVuwZlz+x1fvIxqOli9YkMfOKg6xVp14qC0=;
        b=0K34OBDt2BI8ZtUeezgPWeDQ/s/xg7f+n6kcXc+GCByTmU5y7S3L4PuAniHVrniWcy
         oNSPMIKiczlsFzQWtRpONwh1VQ0DbBTnvdBVQhvTj4VEyQPShn+BPu51tiiBKLv/o8dQ
         jjE+1paNa4m0+J7eM1hIftgTbquNbV5HEfzqonWHUU4FMeziX85oBWCFffGTZvftSD3d
         M1zmGF8o4NoPcTs3Zks+wlPrIBiD9pCEBjduugmEh3noW9Rcf6/FNR6qlZy38eWWuPwM
         WwcEAYMQ5pocpOvzWdV7oQM8H8eQYuMhOgjBbYtgg//yjSFnJjHp6jBvFqejvMYu7vDo
         icGg==
X-Gm-Message-State: AOAM533t8ReEOtagLOjx1swOh37fu67yeJK6g1jET0bkN7QAH9w2yoGu
        w0SMQSusVdPlK9F542VyQ3ggds7C/r3f88QU5uo=
X-Google-Smtp-Source: ABdhPJw6KRtuVxdOWZolXkTawVlKMD9h6KwTx8eKOvZlJHgz580cbU+s2ftquocEH01jFU+8R96YSNXhuIhD6kky33w=
X-Received: by 2002:a17:907:170a:: with SMTP id le10mr37958289ejc.537.1634663602907;
 Tue, 19 Oct 2021 10:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211014191615.6674-1-shy828301@gmail.com> <20211014191615.6674-3-shy828301@gmail.com>
 <20211019055053.GA2268449@u2004>
In-Reply-To: <20211019055053.GA2268449@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 19 Oct 2021 10:13:11 -0700
Message-ID: <CAHbLzkqySvKyKu+1GF-j2xpimDO+kiTadEJpBrMUkjwhQXkkpg@mail.gmail.com>
Subject: Re: [v4 PATCH 2/6] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:51 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Thu, Oct 14, 2021 at 12:16:11PM -0700, Yang Shi wrote:
> > When handling shmem page fault the THP with corrupted subpage could be PMD
> > mapped if certain conditions are satisfied.  But kernel is supposed to
> > send SIGBUS when trying to map hwpoisoned page.
> >
> > There are two paths which may do PMD map: fault around and regular fault.
> >
> > Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> > the thing was even worse in fault around path.  The THP could be PMD mapped as
> > long as the VMA fits regardless what subpage is accessed and corrupted.  After
> > this commit as long as head page is not corrupted the THP could be PMD mapped.
> >
> > In the regular fault path the THP could be PMD mapped as long as the corrupted
> > page is not accessed and the VMA fits.
> >
> > This loophole could be fixed by iterating every subpage to check if any
> > of them is hwpoisoned or not, but it is somewhat costly in page fault path.
> >
> > So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> > indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> > is found hwpoisoned by memory failure and after the refcount is bumped
> > successfully, then cleared when the THP is freed or split.
> >
> > The soft offline path doesn't need this since soft offline handler just
> > marks a subpage hwpoisoned when the subpage is migrated successfully.
> > But shmem THP didn't get split then migrated at all.
> >
> > Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> > Cc: <stable@vger.kernel.org>
> > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/page-flags.h | 23 +++++++++++++++++++++++
> >  mm/huge_memory.c           |  2 ++
> >  mm/memory-failure.c        | 14 ++++++++++++++
> >  mm/memory.c                |  9 +++++++++
> >  mm/page_alloc.c            |  4 +++-
> >  5 files changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index a558d67ee86f..901723d75677 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -171,6 +171,15 @@ enum pageflags {
> >       /* Compound pages. Stored in first tail page's flags */
> >       PG_double_map = PG_workingset,
> >
> > +#ifdef CONFIG_MEMORY_FAILURE
> > +     /*
> > +      * Compound pages. Stored in first tail page's flags.
> > +      * Indicates that at least one subpage is hwpoisoned in the
> > +      * THP.
> > +      */
> > +     PG_has_hwpoisoned = PG_mappedtodisk,
> > +#endif
> > +
> >       /* non-lru isolated movable page */
> >       PG_isolated = PG_reclaim,
> >
> > @@ -668,6 +677,20 @@ PAGEFLAG_FALSE(DoubleMap)
> >       TESTSCFLAG_FALSE(DoubleMap)
> >  #endif
> >
> > +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > +/*
> > + * PageHasHWPoisoned indicates that at least on subpage is hwpoisoned in the
>
> At least "one" subpage?
>
> > + * compound page.
> > + *
> > + * This flag is set by hwpoison handler.  Cleared by THP split or free page.
> > + */
> > +PAGEFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
> > +     TESTSCFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
> > +#else
> > +PAGEFLAG_FALSE(HasHWPoisoned)
> > +     TESTSCFLAG_FALSE(HasHWPoisoned)
> > +#endif
> > +
> >  /*
> >   * Check if a page is currently marked HWPoisoned. Note that this check is
> >   * best effort only and inherently racy: there is no way to synchronize with
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 5e9ef0fc261e..0574b1613714 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2426,6 +2426,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >       /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> >       lruvec = lock_page_lruvec(head);
> >
> > +     ClearPageHasHWPoisoned(head);
> > +
> >       for (i = nr - 1; i >= 1; i--) {
> >               __split_huge_page_tail(head, i, lruvec, list);
> >               /* Some pages can be beyond EOF: drop them from page cache */
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 73f68699e7ab..2809d12f16af 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1694,6 +1694,20 @@ int memory_failure(unsigned long pfn, int flags)
> >       }
> >
> >       if (PageTransHuge(hpage)) {
> > +             /*
> > +              * The flag must be set after the refcount is bumpped
>
> s/bumpped/bumped/ ?
>
> > +              * otherwise it may race with THP split.
> > +              * And the flag can't be set in get_hwpoison_page() since
> > +              * it is called by soft offline too and it is just called
> > +              * for !MF_COUNT_INCREASE.  So here seems to be the best
> > +              * place.
> > +              *
> > +              * Don't need care about the above error handling paths for
> > +              * get_hwpoison_page() since they handle either free page
> > +              * or unhandlable page.  The refcount is bumpped iff the
>
> There's another "bumpped".

Thanks for catching these typos, will fix them in the next version.

>
> Otherwise looks good to me.
>
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> > +              * page is a valid handlable page.
> > +              */
> > +             SetPageHasHWPoisoned(hpage);
> >               if (try_to_split_thp_page(p, "Memory Failure") < 0) {
> >                       action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
> >                       res = -EBUSY;
> > diff --git a/mm/memory.c b/mm/memory.c
> > index adf9b9ef8277..c52be6d6b605 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3906,6 +3906,15 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> >       if (compound_order(page) != HPAGE_PMD_ORDER)
> >               return ret;
> >
> > +     /*
> > +      * Just backoff if any subpage of a THP is corrupted otherwise
> > +      * the corrupted page may mapped by PMD silently to escape the
> > +      * check.  This kind of THP just can be PTE mapped.  Access to
> > +      * the corrupted subpage should trigger SIGBUS as expected.
> > +      */
> > +     if (unlikely(PageHasHWPoisoned(page)))
> > +             return ret;
> > +
> >       /*
> >        * Archs like ppc64 need additional space to store information
> >        * related to pte entry. Use the preallocated table for that.
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index b37435c274cf..7f37652f0287 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1312,8 +1312,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >
> >               VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
> >
> > -             if (compound)
> > +             if (compound) {
> >                       ClearPageDoubleMap(page);
> > +                     ClearPageHasHWPoisoned(page);
> > +             }
> >               for (i = 1; i < (1 << order); i++) {
> >                       if (compound)
> >                               bad += free_tail_pages_check(page, page + i);
> > --
> > 2.26.2
> >
