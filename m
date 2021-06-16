Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C434B3A9C74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 15:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhFPNt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhFPNt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:49:57 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AE0C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 06:47:51 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j15so1049988vsf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzh7jOfPYY3BS7Rth6BMrlZwOex7e90TciQGZWtPoX0=;
        b=ALzWREQUL8uWIqXU4g/KaqMfoQ/cgY2isuer19rssa3Ngs+WYEZmsh8Qi5kOucaiWM
         1BBwfAXn8n68F096mX8Q5/Su+wSTtNN1DnSKVnBVzX1227E1qmLkUKLrarUSKj1cLy1g
         t51q6C5Kg1vnh6XLg78AoDHmAT+HRB/862jfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzh7jOfPYY3BS7Rth6BMrlZwOex7e90TciQGZWtPoX0=;
        b=NBz9RYsp3plRiXVQJPBe8NePW0nDf+yJfZu3vbvG3a6lf7wKZMMCvuoF5JJNbTu8VY
         BGUj7eaKHJO6FNLtPQ7CmKxvHkSqkVQut+nTLDxwluFHE71OupD5WHBhl88A2TN3AyEQ
         8Mg71ZY/+1v3tb0NLnELxyOM5OjfsfOxVUFdd+UxC7zP5X9zT+IgTbjitlLULmRCHDpR
         lxCn/LD3HJFA5YXwoCnSKyAFmwnzq6Dg+E8K2b1or3SG/fOHEDDC3RvjAvwfjQYxklHE
         IGGVv9uMCAlLe0AYJAgJz9A1cTvMvMnXQ13KVfYelvHgQXR0JOxgRqsS2goAqJPMgHBY
         JL/A==
X-Gm-Message-State: AOAM532OPXyWmRTSFHQyjLv/DBRyhA7S5ODVNgdC5ILzlVlXfWVCqw0z
        K/SKdG2gQNFYerM+M+nPDZhvSuSuzMVDL2tCEAtqRQ==
X-Google-Smtp-Source: ABdhPJwNthpZJuF5InfK/UVVbfqlCa8mWwZIlSOk9EE2GVKGUfovydc1w9igkiJiwmBG1yGalqwZ/ghjBhT+0QhqmPM=
X-Received: by 2002:a67:f659:: with SMTP id u25mr10008319vso.9.1623851270260;
 Wed, 16 Jun 2021 06:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <016b2fe2-0d52-95c9-c519-40b14480587a@gmail.com>
 <CAJfpeguzkDQ5VL3m19jrepf1YjFeJ2=q99TurTX6DRpAKz+Omg@mail.gmail.com> <YMn1s19wMQdGDQuQ@casper.infradead.org>
In-Reply-To: <YMn1s19wMQdGDQuQ@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Jun 2021 15:47:39 +0200
Message-ID: <CAJfpegsMNc-deQvdOntZJHU2bW34JF=e0gwxPe19eFXp1t0PFQ@mail.gmail.com>
Subject: Re: Possible bogus "fuse: trying to steal weird page" warning related
 to PG_workingset.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Jun 2021 at 14:59, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jun 16, 2021 at 02:31:32PM +0200, Miklos Szeredi wrote:
> > On Mon, 14 Jun 2021 at 11:56, Thomas Lindroth <thomas.lindroth@gmail.com> wrote:
> > >
> > > Hi. I recently upgraded to kernel series 5.10 from 4.19 and I now get warnings like
> > > this in dmesg:
> > >
> > > page:00000000e966ec4e refcount:1 mapcount:0 mapping:0000000000000000 index:0xd3414 pfn:0x14914a
> > > flags: 0x8000000000000077(locked|referenced|uptodate|lru|active|workingset)
> > > raw: 8000000000000077 ffffdc7f4d312b48 ffffdc7f452452c8 0000000000000000
> > > raw: 00000000000d3414 0000000000000000 00000001ffffffff ffff8fd080123000
> > > page dumped because: fuse: trying to steal weird page
> > >
> > > The warning in fuse_check_page() doesn't check for PG_workingset which seems to be what
> > > trips the warning. I'm not entirely sure this is a bogus warning but there used to be
> > > similar bogus warnings caused by a missing PG_waiters check. The PG_workingset
> > > page flag was introduced in 4.20 which explains why I get the warning now.
> > >
> > > I only get the new warning if I do writes to a fuse fs (mergerfs) and at the same
> > > time put the system under memory pressure by running many qemu VMs.
> >
> > AFAICT fuse is trying to steal a pagecache page from a pipe buffer
> > created by splice(2).    The page looks okay, but I have no idea what
> > PG_workingset means in this context.
> >
> > Matthew, can you please help?
>
> PG_workingset was introduced by Johannes:
>
>     mm: workingset: tell cache transitions from workingset thrashing
>
>     Refaults happen during transitions between workingsets as well as in-place
>     thrashing.  Knowing the difference between the two has a range of
>     applications, including measuring the impact of memory shortage on the
>     system performance, as well as the ability to smarter balance pressure
>     between the filesystem cache and the swap-backed workingset.
>
>     During workingset transitions, inactive cache refaults and pushes out
>     established active cache.  When that active cache isn't stale, however,
>     and also ends up refaulting, that's bonafide thrashing.
>
>     Introduce a new page flag that tells on eviction whether the page has been
>     active or not in its lifetime.  This bit is then stored in the shadow
>     entry, to classify refaults as transitioning or thrashing.
>
> so I think it's fine for you to ignore when stealing a page.

I have problem understanding what a workingset is.  Is it related to
swap?  If so, how can such a page be part of a file mapping?

Thanks,
Miklos
