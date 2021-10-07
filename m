Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA698425EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbhJGVap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 17:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbhJGVao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:30:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6DC061570;
        Thu,  7 Oct 2021 14:28:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t16so6495164eds.9;
        Thu, 07 Oct 2021 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tdt4Z6gD2SotM9uwBoNTC6A69WAvkEP9uA/es2f4JS4=;
        b=Cfe0j/2pn6srl6JwVwT8bmkvO+wYhRtDDv1zN9zG5YrUJHeQF9vH973c2rokmdxlX9
         Xqs6VgzC+hqkI8npkwsUvtK8GG92bRK0CTb3SkDbiOC49eMqHiht71PzsxeXRm3ybBBU
         RZAZ15EDnfzffHDxqYnwTP6MIfFWue6KSqngkA6yFbvxAGC2Nk3nKYmsF6s6NgxMmWUp
         /Sbgb5ubtGhc7iPzOeHvEVZ1xsoAL4l6peXtkuYBped76CIsmFXnVq2nD4t8KUb3mv83
         wBB0QwhRmvm7nvgSoD7Rnpv1oOvBvvV9+Zv1V/gthePStZhT79eH8oe0psbopfU0niam
         aB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tdt4Z6gD2SotM9uwBoNTC6A69WAvkEP9uA/es2f4JS4=;
        b=goBMF9fLc896iSGLDrHT4ryvNNhIFGKBwxLOcCV/y0gS/ZAh0+xsSbxEgpjslWwQVm
         4eplFr2ubNqU0klKcFrECwE4bgmDBB66+33GSRWY75ZP/9rp8wfGTjzLyOA2rkYa8E0K
         cZiY/EYYHOoccbVOpA3nQb6YRxvgotjHyz3QnRNUHvlI6tLRVXYyrtL8/SRKAsMY/eWf
         4uhEsqtDYwyc1ObZu/0E6IXS6bWEzCBQus+pVdbMopQxs42d4XRJJt9SFG3tfKqp3/fN
         djBHLmbAH9ZQHTAum7QU8m7UlGu9PVzZHNdexeC3R/JOmhLlrRxrdZRCVOcbmsLQD6e7
         J4aA==
X-Gm-Message-State: AOAM532t/J7wL3Da/cvyP0t12oBOoNd3zXRic2ydy+6BSmaIEmlQvJxL
        BTfZ/Ehjp6i9Nj3w5eTODWl0o8XZTw77HjQPZvE=
X-Google-Smtp-Source: ABdhPJwHkpqhpEJHk4pkSK+KRd3OlC6ir1ygi5FBtU+rV+Hkg2+HxQdGjDo1rMbJYY+cRLTQIipIoIhIIBl/0K9D7r4=
X-Received: by 2002:a50:ff14:: with SMTP id a20mr9740127edu.81.1633642128408;
 Thu, 07 Oct 2021 14:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s> <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
In-Reply-To: <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Oct 2021 14:28:35 -0700
Message-ID: <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 6, 2021 at 4:57 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 1:15 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > > @@ -1148,8 +1148,12 @@ static int __get_hwpoison_page(struct page *page)
> > >               return -EBUSY;
> > >
> > >       if (get_page_unless_zero(head)) {
> > > -             if (head == compound_head(page))
> > > +             if (head == compound_head(page)) {
> > > +                     if (PageTransHuge(head))
> > > +                             SetPageHasHWPoisoned(head);
> > > +
> > >                       return 1;
> > > +             }
> > >
> > >               pr_info("Memory failure: %#lx cannot catch tail\n",
> > >                       page_to_pfn(page));
> >
> > Sorry for the late comments.
> >
> > I'm wondering whether it's ideal to set this bit here, as get_hwpoison_page()
> > sounds like a pure helper to get a refcount out of a sane hwpoisoned page.  I'm
> > afraid there can be side effect that we set this without being noticed, so I'm
> > also wondering we should keep it in memory_failure().
> >
> > Quotting comments for get_hwpoison_page():
> >
> >  * get_hwpoison_page() takes a page refcount of an error page to handle memory
> >  * error on it, after checking that the error page is in a well-defined state
> >  * (defined as a page-type we can successfully handle the memor error on it,
> >  * such as LRU page and hugetlb page).
> >
> > For example, I see that both unpoison_memory() and soft_offline_page() will
> > call it too, does it mean that we'll also set the bits e.g. even when we want
> > to inject an unpoison event too?
>
> unpoison_memory() should be not a problem since it will just bail out
> once THP is met as the comment says:
>
> /*
> * unpoison_memory() can encounter thp only when the thp is being
> * worked by memory_failure() and the page lock is not held yet.
> * In such case, we yield to memory_failure() and make unpoison fail.
> */
>
>
> And I think we should set the flag for soft offline too, right? The
> soft offline does set the hwpoison flag for the corrupted sub page and
> doesn't split file THP, so it should be captured by page fault as
> well. And yes for poison injection.

Err... I must be blind. The soft offline does *NOT* set hwpoison flag
for any page. So your comment does stand. The flag should be set
outside get_hwpoison_page().

>
> But your comment reminds me that get_hwpoison_page() is just called
> when !MF_COUNT_INCREASED, so it means MADV_HWPOISON still could
> escape. This needs to be covered too.
>
> BTW, I did the test with MADV_HWPOISON, but I didn't test this change
> (moving flag set after get_page_unless_zero()) since I thought it was
> just a trivial change and did overlook this case.
>
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
