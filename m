Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D0413AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhIUTsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhIUTsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:48:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23BAC061574;
        Tue, 21 Sep 2021 12:46:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v22so592706edd.11;
        Tue, 21 Sep 2021 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJYskgs7jeBr4yMPVcl+ZyAVeMfifuPZi0z0sZaJTaI=;
        b=H2Oqb28GkZUnJxi+XNxATp1ZwxbkFpy4WyVjIFkX0sLYvuKupaIJNp261NfGRwZHmx
         8MHf+x8yc8WXIBhwlOqWrrTKmcYxdOzEm/J9A5TFjgDtDN3bOukLceGOb40pf6y5bskx
         WtSGJN4i6MSWXvDFH9Kja4qsmtmnDcexl1no/dRXRBhBnOgGlADwazB8LQaALoHH2xcJ
         lai+f/+gYK2PV7jrTw1gOsZJeT12TgHdnG3iWa5wZfygK3ab3LodG/WbvCgaIUedHWt1
         PB3muu244Ka8GXz/D+I4e/EMxWBzEGuA+5EAl5N2wsrC/bUmob/YcB94fDQbi+T20B3Y
         P8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJYskgs7jeBr4yMPVcl+ZyAVeMfifuPZi0z0sZaJTaI=;
        b=ZEUdGp4g4IVSKwYFsWOOZ8WVpu7y6ZEyk4XQWwgi7RZyke7sZFRDUY+a0lhpLL2wOt
         fJmtCw2G8HtFVW4gAzgp80x8QYouvRGLVYa4WSSmCVz6IyPAqDTWPCjo/mlpHRaw7T/t
         X0LfFcyXDJB6cHoHc75ut/dQtiFdQ3lfqor2jtAhvzoNaulkCvsA6kMTafirQj6VcsF6
         TWq4LRgH1b1A4XLM8iTLPzY7Vhu9vpmeD/NhHanGGl28TD4yss2YiWnEsJGJc9q0d596
         dlrCq5qm8z71e0KrN7JOP/uzzD+n7VrDg2AhDoyuPwZioCkDmcpJUESxUtEdHgRLnxEo
         7+Yg==
X-Gm-Message-State: AOAM530/8zdgRxP3WgN+385Mr9FXgOxPALpEjtLmMa22n1N0ltqKY94V
        1/FhYy3yqXHsIBp0itxgSM6l3Jn4MEHjrQTTvHT5ub3o
X-Google-Smtp-Source: ABdhPJyKWqGxUmOiDPAkZaf9KvuoLiP56g2D3SFkjxBeNCn1yJ3WWxzbkc9x79vLsbjYIuduZTXEuqTyfGotjuGcUuk=
X-Received: by 2002:a50:e044:: with SMTP id g4mr6460669edl.46.1632253600314;
 Tue, 21 Sep 2021 12:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210914183718.4236-1-shy828301@gmail.com> <20210914183718.4236-5-shy828301@gmail.com>
 <20210921095034.GB817765@u2004>
In-Reply-To: <20210921095034.GB817765@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Sep 2021 12:46:28 -0700
Message-ID: <CAHbLzkrx1DgRVQ14XftgBOeJ1XSdosY__v35A2x=ciUNsDu_pg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: hwpoison: handle non-anonymous THP correctly
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
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

On Tue, Sep 21, 2021 at 2:50 AM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Tue, Sep 14, 2021 at 11:37:18AM -0700, Yang Shi wrote:
> > Currently hwpoison doesn't handle non-anonymous THP, but since v4.8 THP
> > support for tmpfs and read-only file cache has been added.  They could
> > be offlined by split THP, just like anonymous THP.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/memory-failure.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 3e06cb9d5121..6f72aab8ec4a 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1150,13 +1150,16 @@ static int __get_hwpoison_page(struct page *page)
> >
> >       if (PageTransHuge(head)) {
> >               /*
> > -              * Non anonymous thp exists only in allocation/free time. We
> > -              * can't handle such a case correctly, so let's give it up.
> > -              * This should be better than triggering BUG_ON when kernel
> > -              * tries to touch the "partially handled" page.
> > +              * We can't handle allocating or freeing THPs, so let's give
> > +              * it up. This should be better than triggering BUG_ON when
> > +              * kernel tries to touch the "partially handled" page.
> > +              *
> > +              * page->mapping won't be initialized until the page is added
> > +              * to rmap or page cache.  Use this as an indicator for if
> > +              * this is an instantiated page.
> >                */
> > -             if (!PageAnon(head)) {
> > -                     pr_err("Memory failure: %#lx: non anonymous thp\n",
> > +             if (!head->mapping) {
> > +                     pr_err("Memory failure: %#lx: non instantiated thp\n",
> >                               page_to_pfn(page));
> >                       return 0;
> >               }
>
> How about cleaning up this whole "PageTransHuge()" block?  As explained in
> commit 415c64c1453a (mm/memory-failure: split thp earlier in memory error
> handling), this check was introduced to avoid that non-anonymous thp is
> considered as hugetlb and code for hugetlb is executed (resulting in crash).
>
> With recent improvement in __get_hwpoison_page(), this confusion never
> happens (because hugetlb check is done before this check), so this check
> seems to finish its role.

I see. IIUC the !PageAnon check was used to prevent from mistreating
the THP to hugetlb page. But it was actually solved by splitting THP
earlier. If so this check definitely could go away since the worst
case is split failure. Will fix it in the next version.

>
> Thanks,
> Naoya Horiguchi
>
> > @@ -1415,12 +1418,12 @@ static int identify_page_state(unsigned long pfn, struct page *p,
> >  static int try_to_split_thp_page(struct page *page, const char *msg)
> >  {
> >       lock_page(page);
> > -     if (!PageAnon(page) || unlikely(split_huge_page(page))) {
> > +     if (!page->mapping || unlikely(split_huge_page(page))) {
> >               unsigned long pfn = page_to_pfn(page);
> >
> >               unlock_page(page);
> > -             if (!PageAnon(page))
> > -                     pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
> > +             if (!page->mapping)
> > +                     pr_info("%s: %#lx: not instantiated thp\n", msg, pfn);
> >               else
> >                       pr_info("%s: %#lx: thp split failed\n", msg, pfn);
> >               put_page(page);
> > --
> > 2.26.2
> >
