Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90B63AD2A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 21:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhFRTUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 15:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhFRTUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:20:30 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A73FC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 12:18:19 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id v17so3751667uar.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eQjQgRVIzfQCCW+6MvJZa2SGNSJvl0nL7v9nL19xDc=;
        b=VkIlRi6fm14IqdOXdDvq2KLrfZY8tfuQXFEorj9L0NfM8NEQT3diRPzRZw0iNiyz8X
         iBUwBNI2iytMYs4pouJadHdMyr2DIdrAqfEjN1Uc1erRZDmp+lXuN4jTnr8u72h+vmpW
         TqYMnniKbZ8XeWAbE6Y1dx8rNNDsfqmXqK/LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eQjQgRVIzfQCCW+6MvJZa2SGNSJvl0nL7v9nL19xDc=;
        b=ahOh8mDLcHAw/RTt5fk+57DsBP/Khz9twcK+HpsZtN0cu/QpL9OE4bELxfDDM+pXF5
         mCe/Nu5U+9aSKsNhiedOZx2YlR9X2AKo4gNjUoh6sAFOWFGa343SwdWdAQUsoZHZi+QM
         rSmIjcRC5qK0+5hamVQrXAgbVEuFFxM8FAelg06LY+55YzNGKMHl91OAvKcGrxMokcMr
         dsE4L0kD5MNnjP22/6mOPYJVLfTFoPjer4uO1kShvLpd1JEEZFJxSgnb7rZA/il/5s+e
         4crx3iTaOjWLgl/nqKlBjIAxh2UDp1rFJonkjDx/hDhehmRBAX7YZ8yMl9MrFwy0rka6
         g3pg==
X-Gm-Message-State: AOAM532biEM64fp2I1kByBNPAMU3eP3uITyssAx90g7dQjHQeOxxvByK
        fkEBVwDFi2GdOSx2+9RbThzq8WVb1uM/AaNsvcj1DQ==
X-Google-Smtp-Source: ABdhPJyetp96XTdXWE4+B8xZ0O8QGmY/YIFAkOXhfMqtwadNzkHorDZFsGa20ISkIi/gNIKKH1CEjwbaj7GtX7+ZQQ4=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr14396988uao.9.1624043898903;
 Fri, 18 Jun 2021 12:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <016b2fe2-0d52-95c9-c519-40b14480587a@gmail.com>
 <CAJfpeguzkDQ5VL3m19jrepf1YjFeJ2=q99TurTX6DRpAKz+Omg@mail.gmail.com>
 <YMn1s19wMQdGDQuQ@casper.infradead.org> <CAJfpegsMNc-deQvdOntZJHU2bW34JF=e0gwxPe19eFXp1t0PFQ@mail.gmail.com>
 <029095d9-399a-e323-15f3-b665e9852eb3@suse.cz> <YMzYCCBaUTfzdFff@cmpxchg.org>
In-Reply-To: <YMzYCCBaUTfzdFff@cmpxchg.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 21:18:08 +0200
Message-ID: <CAJfpegs_TzszV-4VbfbZLosZMbb+uT9iohxYDqzVPDCizfiFNQ@mail.gmail.com>
Subject: Re: Possible bogus "fuse: trying to steal weird page" warning related
 to PG_workingset.
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Thomas Lindroth <thomas.lindroth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 18 Jun 2021 at 19:29, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jun 16, 2021 at 06:48:34PM +0200, Vlastimil Babka wrote:
> > On 6/16/21 3:47 PM, Miklos Szeredi wrote:
> > > On Wed, 16 Jun 2021 at 14:59, Matthew Wilcox <willy@infradead.org> wrote:
> > >>
> > >> > AFAICT fuse is trying to steal a pagecache page from a pipe buffer
> > >> > created by splice(2).    The page looks okay, but I have no idea what
> > >> > PG_workingset means in this context.
> > >> >
> > >> > Matthew, can you please help?
> > >>
> > >> PG_workingset was introduced by Johannes:
> > >>
> > >>     mm: workingset: tell cache transitions from workingset thrashing
> > >>
> > >>     Refaults happen during transitions between workingsets as well as in-place
> > >>     thrashing.  Knowing the difference between the two has a range of
> > >>     applications, including measuring the impact of memory shortage on the
> > >>     system performance, as well as the ability to smarter balance pressure
> > >>     between the filesystem cache and the swap-backed workingset.
> > >>
> > >>     During workingset transitions, inactive cache refaults and pushes out
> > >>     established active cache.  When that active cache isn't stale, however,
> > >>     and also ends up refaulting, that's bonafide thrashing.
> > >>
> > >>     Introduce a new page flag that tells on eviction whether the page has been
> > >>     active or not in its lifetime.  This bit is then stored in the shadow
> > >>     entry, to classify refaults as transitioning or thrashing.
> > >>
> > >> so I think it's fine for you to ignore when stealing a page.
> > >
> > > I have problem understanding what a workingset is.  Is it related to
> >
> > "working set" is the notion of the set of pages that the workload needs to
> > access at the moment/relatively short time window, and it would be beneficial if
> > all of it could fit in the RAM.
> > PG_workinsgset is part of the mechanism that tries to estimate this ideal set of
> > pages, and especially when the workload shifts to another set of pages, in order
> > to guide reclaim better. See the big comment at the top of mm/workingset.c for
> > details
> >
> > > swap?  If so, how can such a page be part of a file mapping?
> >
> > Not related to swap. It was actually first implemented only for file pages (page
> > cache), but then extended to anonymous pages by aae466b0052e ("mm/swap:
> > implement workingset detection for anonymous LRU")
>
> Thanks, yes.
>
> Think of it as similar to PG_active. It's just another usage/heat
> indicator of file and anon pages on the reclaim LRU that, unlike
> PG_active, persists across deactivation and even reclaim (we store it
> in the page cache / swapper cache tree until the page refaults).
>
> So if fuse accepts pages that can legally have PG_active set,
> PG_workingset is fine too.

Thanks, fix pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Miklos
