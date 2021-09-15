Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8752940CFC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 01:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhIOXB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhIOXB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:01:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3AC061574;
        Wed, 15 Sep 2021 16:00:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i6so9516675edu.1;
        Wed, 15 Sep 2021 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nltJ0c5xqWabGNNnlxRN9ln0d5IBRKYNVc2lgIfvxnY=;
        b=WqLurfwgJxMS9w0nNydHuK94Aeqdw597EXpTd60q59wLdj1XvSGD6r9JhdTC7PzYcw
         0E8JmtfKeJADqtU2mT79i1Vgwy2YWvd4+N+tSMqlvqYqw/ouTvnMVriiFGTDHwRX9+HD
         oSt84YbHQUQJJmgcEDLiPkD8Lx1dHnTL6/wxhbANVioWEw3nEwqzrTvNNhQub61S+jD/
         laUdfyzqLF7Lc9doDZgNw/dXsPBIksEIaNWcaQ1NlhREaBJlFRfUHxsmH4XrQlGTFfVW
         wNRVTATnVkk99BoU3uDexHhtXTusYz5Zydyh3C1hpJHOJ/Gquo1gmYoWRSSlc9iw0jiT
         1yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nltJ0c5xqWabGNNnlxRN9ln0d5IBRKYNVc2lgIfvxnY=;
        b=5S6icUHaO9rhnUmxV00J+luoSt5zgSvYdU+wKDU/jg6BX2Hh4dRNjQysHlZcx+4797
         spVwGbNiHmhz5Zs+yz28HYqlBXu6JiEsikN9Ya8/ns8wFDRSau61ibP9QSpIXOS931Xw
         9wsLNTIODVLw7lR5/qK5cb0kH5/PihanxnDfTwaopiZAAMog+z94jkwhZnfucaJcXmBx
         3r34hXzKrBcFBEaJyli0mxhaZkF7ATceGbGhsGoHiUzqyA+ZCr7VKiiHEBwNA2EhA6F+
         8T5WA5tSRpHcK6OC/sbhSbbhE1ksS0DrIkSCpkcOD3ooVtfvJyhQlBG4luDp4d/Ms9Aj
         ZjFQ==
X-Gm-Message-State: AOAM5313ww43T4ccwXv7iaFN1xXhJ1qBh1ylzAQhPBc8E6wtgyEGkHOk
        wkbt9phGkFkm8V2R80Wo6xottkWEiIenGwPoYNU=
X-Google-Smtp-Source: ABdhPJx2oYFOG9XGy0H5HuwfHqv5JmHfHMbjvopXptYJP3svQKk7UHimfy9HWHzMxYns52+t/zXbY1hpa/ktosi9rpA=
X-Received: by 2002:a05:6402:16d3:: with SMTP id r19mr2689714edx.363.1631746836792;
 Wed, 15 Sep 2021 16:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210914183718.4236-1-shy828301@gmail.com> <20210914183718.4236-3-shy828301@gmail.com>
 <20210915114947.2zh7inouztenth6o@box.shutemov.name> <CAHbLzkpjAf+V5b40UFH2gWSRN4gVqoFmjHr9_wME2ofWC7Mfkw@mail.gmail.com>
In-Reply-To: <CAHbLzkpjAf+V5b40UFH2gWSRN4gVqoFmjHr9_wME2ofWC7Mfkw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Sep 2021 16:00:24 -0700
Message-ID: <CAHbLzkoyEcKMwg04SRWtWaMZCO3HLpP2BA2_kv3ASuGN6=tE2Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: khugepaged: check if file page is on LRU after
 locking page
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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

On Wed, Sep 15, 2021 at 10:48 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Sep 15, 2021 at 4:49 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Tue, Sep 14, 2021 at 11:37:16AM -0700, Yang Shi wrote:
> > > The khugepaged does check if the page is on LRU or not but it doesn't
> > > hold page lock.  And it doesn't check this again after holding page
> > > lock.  So it may race with some others, e.g. reclaimer, migration, etc.
> > > All of them isolates page from LRU then lock the page then do something.
> > >
> > > But it could pass the refcount check done by khugepaged to proceed
> > > collapse.  Typically such race is not fatal.  But if the page has been
> > > isolated from LRU before khugepaged it likely means the page may be not
> > > suitable for collapse for now.
> > >
> > > The other more fatal case is the following patch will keep the poisoned
> > > page in page cache for shmem, so khugepaged may collapse a poisoned page
> > > since the refcount check could pass.  3 refcounts come from:
> > >   - hwpoison
> > >   - page cache
> > >   - khugepaged
> > >
> > > Since it is not on LRU so no refcount is incremented from LRU isolation.
> > >
> > > This is definitely not expected.  Checking if it is on LRU or not after
> > > holding page lock could help serialize against hwpoison handler.
> > >
> > > But there is still a small race window between setting hwpoison flag and
> > > bump refcount in hwpoison handler.  It could be closed by checking
> > > hwpoison flag in khugepaged, however this race seems unlikely to happen
> > > in real life workload.  So just check LRU flag for now to avoid
> > > over-engineering.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  mm/khugepaged.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 045cc579f724..bdc161dc27dc 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -1808,6 +1808,12 @@ static void collapse_file(struct mm_struct *mm,
> > >                       goto out_unlock;
> > >               }
> > >
> > > +             /* The hwpoisoned page is off LRU but in page cache */
> > > +             if (!PageLRU(page)) {
> > > +                     result = SCAN_PAGE_LRU;
> > > +                     goto out_unlock;
> > > +             }
> > > +
> > >               if (isolate_lru_page(page)) {
> >
> > isolate_lru_page() should catch the case, no? TestClearPageLRU would fail
> > and we get here.
>
> Hmm... you are definitely right. How could I miss this point.
>
> It might be because of I messed up the page state by some tests which
> may do hole punch then reread the same index. That could drop the
> poisoned page then collapse succeed. But I'm not sure. Anyway I didn't
> figure out how the poisoned page could be collapsed. It seems
> impossible. I will drop this patch.

I think I figured out the problem. This problem happened after the
page cache split patch and if the hwpoisoned page is not head page. It
is because THP split will unfreeze the refcount of tail pages to 2
(restore refcount from page cache) then dec refcount to 1. The
refcount pin from hwpoison is gone and it is still on LRU. Then
khugepged locked the page before hwpoison, the refcount is expected to
khugepaged.

The worse thing is it seems this problem is applicable to anonymous
page too. Once the anonymous THP is split by hwpoison the pin from
hwpoison is gone too the refcount is 1 (comes from PTE map). Then
khugepaged could collapse it to huge page again. It may incur data
corruption.

And the poisoned page may be freed back to buddy since the lost refcount pin.

If the poisoned page is head page, the code is fine since hwpoison
doesn't put the refcount for head page after split.

The fix is simple, just keep the refcount pin for hwpoisoned subpage.

>
> >
> > >                       result = SCAN_DEL_PAGE_LRU;
> > >                       goto out_unlock;
> > > --
> > > 2.26.2
> > >
> > >
> >
> > --
> >  Kirill A. Shutemov
