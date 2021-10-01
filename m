Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E266841F6A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhJAVJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJAVJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:09:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9E5C061775;
        Fri,  1 Oct 2021 14:08:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v10so39553319edj.10;
        Fri, 01 Oct 2021 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsjTuS01OWyAiv5jzPDJK7nI7OXAtfzB78KCIx/PZ2s=;
        b=nmjVVVJUzIaGOMd2Ez9MncVBsQftTFkxVlmU81mHfpKglskE8/1IJ8cU4Rx9bvp1KH
         APKmkczWks8+GdpU1gnbKg3qoY80lATu4fOvBksxGg/ZTlzo4I4svGKdC9aBfYYGXwER
         ukWCBRkNXxe5f24KiUPXc15tBuEmh38tUJYn/0mnKKLk0wZ72ZrS1u1d8cObVGBsJH82
         ZcYiXNfZAUnk1JZDObr+iH4YIlRsxJnzroIpelTIWtU7RWn+QNRHe2wgJ7Bd7chnsUv5
         d+58J/52gRlQiAGPBvB5PTVY/7F4g+4ATUNYYOk+FrULDR9tO3tHQ6oHfM9JuuShGXNr
         BScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsjTuS01OWyAiv5jzPDJK7nI7OXAtfzB78KCIx/PZ2s=;
        b=3JnpE2fHqkXrkqkhEP9ofIJ4MGZkMvCm5FacfuwPtqDXiOHWnHCuvetM2DoDH4lM7N
         IR7dNeV98p6bab0lrCaNYpkUpKRdjCBleYLlECWDq/udplCb84xZJHGp8sva9pm14v/r
         sSBTsG+TxFNhivFkyKDYjTRyL8YmuLp3WW4i9KbT5S4LvbeQ3GypW7fKppozlPgsPIZd
         LEh4AcjHeP9XePKqOQ7aKgnYr6TwKX391gXZztw8824Qpu8o3i7xlmUSUHzXzO0RThLQ
         ffUIkJs+20I4B+L1lh3az9I2zHdZk27OhoAqt4XBzHKFxrnwPJw81TLh8XgIWpk5c3eW
         dx/A==
X-Gm-Message-State: AOAM531I6wzuudJmFqXbckdcZAzz8fZq+cAkxYA58gM70OLiOE2HURJX
        4K3TAZfwAXRWpwvg6HamH27m2iH1oy0J7/oor38=
X-Google-Smtp-Source: ABdhPJzaxRyXbpY5V9tLY9TTm6Jg0RXZDwe28BXKRxqBijswVUPXv+dFb8IhcLIVyB9Bg/oQv+znrRMt50zGtM2djtw=
X-Received: by 2002:a17:906:3854:: with SMTP id w20mr63006ejc.537.1633122489844;
 Fri, 01 Oct 2021 14:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <20211001072300.GC1364952@u2004>
In-Reply-To: <20211001072300.GC1364952@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 1 Oct 2021 14:07:56 -0700
Message-ID: <CAHbLzko6E4HKCKoQefgaqb1aqBsJUevnAFDKpL+rHLuSXZSxSw@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
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

On Fri, Oct 1, 2021 at 12:23 AM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
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
> > is found hwpoisoned by memory failure and cleared when the THP is freed or
> > split.
> >
> > Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> > Cc: <stable@vger.kernel.org>
> > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> ...
> > @@ -668,6 +673,20 @@ PAGEFLAG_FALSE(DoubleMap)
> >       TESTSCFLAG_FALSE(DoubleMap)
> >  #endif
> >
> > +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > +/*
> > + * PageHasPoisoned indicates that at least on subpage is hwpoisoned in the
>
> Maybe you meant as follow?
>
> + * PageHasHWPoisoned indicates that at least one subpage is hwpoisoned in the

Yeah, thanks for catching it. It is a typo because the flag was called
PageHasPoisoned. But "poisoned" seems ambiguous for some cases since,
for example, some memory sanitizers use "poisoned", so I renamed it to
PageHasHWPoisoned to make it less ambiguous.

>
> Thanks,
> Naoya Horiguchi
