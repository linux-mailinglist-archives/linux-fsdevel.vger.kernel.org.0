Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB102447694
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Nov 2021 23:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhKGW7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 17:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKGW7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 17:59:49 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEAFC061570
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Nov 2021 14:57:06 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id v23so1930936iom.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Nov 2021 14:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RebPem4JpE4mB4OJtTQZy2L2GaM9mG2MaLdV09WqJcg=;
        b=mPTLupB64aZ2QM4mBWnq0q+0PHVWP/bhluc7ceNJTm2huiXeKrQ08OSpVCUDIB5yan
         UWZWXiqXsDD96WNHzQyY3r3KiCMNSNqPz8/M2Si1J+EzepdUfWA1zqK7lHhcYg9bGhFy
         iNBbtQflST2T/7iDK4fI9OTHNml2PMPkjECwxhDr9tPCsPrFJOu2iPyG7sopDgwkx/2O
         hJra1He9MBRMeMwYqc+N+RxUHTNAQJvvYOEuK/kqxEtNOWct0lI62OcafKqSFDXKjfhB
         eOhKOMBFyMgf9gRl5e7/DWK4rpDjqxTn6u/QWx13wl3BOeKZHDYiP/has5Uavvo/8OHk
         Hg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RebPem4JpE4mB4OJtTQZy2L2GaM9mG2MaLdV09WqJcg=;
        b=vsunWMKGhdugVBa3l4PFWUr+I49QNK43qqLaVFNmvLXAkJmW9Zj7CyABzBaYeNO23t
         aE41byElu98w1oC7AGg8EByNJzV2qfSCnWvQkdJQcsDiQOwyQEosiHV1QF/fLnyIupSW
         GqAJSxYu6wpL6xG0Y4vRfgwraZEUw8qpishTUpbycpoqv8P6eRopbJLXLpefwf66wdRS
         1A1qrVCfAugIAYAVB0zbNs/fyByj8a7uJ+TS2kpEpohJ8sz9RTZucp7QW9Xr9dESyJ/a
         u1W0l+LSn1IbrUj+H5iMDsD3PQZWcacJc+UBB/T2bmtNWABehX0Pvz1B5RoTHTaUshEh
         gdcQ==
X-Gm-Message-State: AOAM533kj/dbFGopYNH7NBKC/XzrjITDNufuVhIFcfblaJwPo0JDoVjG
        Q29WWU/jPWR66mAEpF2kqCSgeKlp8w74YZoWcaab6w==
X-Google-Smtp-Source: ABdhPJydanDuSxNR4ZI8wTqn6wBCad3XUyIruyTxU+exyenKO7UViEs/+nqwHY97xgGdhlhgN7uayzwO1vxGrAhDsI8=
X-Received: by 2002:a05:6602:150b:: with SMTP id g11mr10098027iow.89.1636325825560;
 Sun, 07 Nov 2021 14:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20211104214636.450782-1-almasrymina@google.com>
 <YYRZNWZqHy9+11KW@casper.infradead.org> <CAHS8izPisLXTmAsvZR6w2piSXPidVvJMHfQR7oikJgkuTJyRQA@mail.gmail.com>
In-Reply-To: <CAHS8izPisLXTmAsvZR6w2piSXPidVvJMHfQR7oikJgkuTJyRQA@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 7 Nov 2021 14:56:54 -0800
Message-ID: <CAHS8izN=hqycemLjF5SVqWAUJ2WyeghjSwHEuP8Aq62UfjgRMg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add PM_THP to /proc/pid/pagemap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Hildenbrand <david@redhat.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 4, 2021 at 3:45 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Thu, Nov 4, 2021 at 3:08 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Nov 04, 2021 at 02:46:35PM -0700, Mina Almasry wrote:
> > > Add PM_THP to allow userspace to detect whether a given virt address is
> > > currently mapped by a hugepage or not.
> >
> > Well, no, that's not what that means.
> >
>
> Sorry, that was the intention, but I didn't implement the intention correctly.
>
> > > @@ -1396,6 +1397,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
> > >               flags |= PM_FILE;
> > >       if (page && page_mapcount(page) == 1)
> > >               flags |= PM_MMAP_EXCLUSIVE;
> > > +     if (page && PageTransCompound(page))
> > > +             flags |= PM_THP;
> >
> > All that PageTransCompound() does is call PageCompound().  It doesn't
> > tell you if the underlying allocation is PMD sized, nor properly aligned.
> >

Sorry Matthew again for getting this check wrong. After taking a
deeper look, you're completely correct. My check was returning true on
all compound pages without regard to whether they are actually THP, or
whether they're mapped at the PMD level.

I've renamed the flag from PM_THP to PM_HUGE_THP_MAPPING to be more
accurate, and it looks to me like the correct check is if we're in
pagemap_pmd_range() and the underlying page is_transparent_huegpage(),
then we set the flag.

I'm about to upload v3 with this new check; please take another look.
Thank you for catching this.

> > And you didn't answer my question about whether you want information about
> > whether a large page is being used that's not quite as large as a PMD.
> >
>
> Sorry, I thought the implementation would make it clear but I didn't
> do that correctly. Right now and for the foreseeable future what I
> want to know is whether the page is mapped by a PMD. All the below
> work for me:
>
> 1. Flag is set if the page is either a PMD size THP page.
> 2. Flag is set if the page is either a PMD size THP page or PMD size
> hugetlbfs page.
> 3. Flag is set if the page is either a PMD size THP page or PMD size
> hugetlbfs page or contig PTE size hugetlbfs page.
>
> I prefer #2 and I think it's maybe most extensible for future use
> cases that 1 flag tells whether the page is PMD hugepage and another
> flag is a large cont PTE page.
