Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83230F9C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 18:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhBDRco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 12:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbhBDRb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:31:26 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF378C061356;
        Thu,  4 Feb 2021 09:29:21 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f1so5749096lfu.3;
        Thu, 04 Feb 2021 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1ahJvFsrZks1Lk0ripDXnB6weXUyAGbfZ45blD5PTU=;
        b=RSpK0Teg2yPbyx+tN32lHdP56HoEVGFGksT+JkghM2BilhAM++ndPSiHehfezfx0vv
         2usPaDOoocqRjyGUkmvCzcEjiTOnJ2PIaLjJOc5JFg5xEG5bXNPJN0F0VhbqgEjH47jN
         p4Dk8zw7m3i1JeiIVok9xhDnXN5EfMus1K9zEGqO1LCYAF1uYpHYDTl+HaMoKtVH4rVa
         5I3b+VYivjxIgN7ELRhDJjjgz6Tfosbc/n7fZ6IeoDnX+lFZ0AYzwojGYqztUBUc33c2
         Wi/aYf0LBhH1zzgtE7od4YXuk3tNwtoeK3gDzNkKvZs5U/GFOTgTWZFsccOJVHz+HqgM
         nF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1ahJvFsrZks1Lk0ripDXnB6weXUyAGbfZ45blD5PTU=;
        b=DdtRT9pajkg5Yl5jbwWRf3IjTnQNn9wxnlA+/4QJZhnym6lBI0ICIAbg8LRqZTL2HC
         KfGWTJbUeXsuTzlijuFQITrjoRjUlbARErFPwi6KiiaTdp4NdzvyUbBkLDFkpplMLUeO
         nk7ZGhSB2hpvnnE6zMGFgyzL742GuqMVgvfaCnqXKl04Ddwvo7p7mQ7/mlqIke1qZqAB
         DPZ1VxmICXXdth2kzzAGjdTIglNVpG/KjOG3+dd+T1n9bz7RhHNkWWhJ40UDM0mWohVl
         t7pVOwoZNuYcq27laFBCpmBZ7pss28iSpYemGBabt6G7gFKcRc1Ou2TI/rJGymsUwhm6
         MY1w==
X-Gm-Message-State: AOAM533JiKyq3kO7K5xhra2oCA+AueBaV2lMDQFx5G+c7PRkey3uhNWq
        BBEK1CjmZQ4T2pcTB59mdtiJc6W0zGgPhXf3buM=
X-Google-Smtp-Source: ABdhPJwT/uirdmDDpof36RQ4WHOo7qc+S6n5DG40Du1EdYVt6nWCd+lES33v9igd/hfr1ZQ/k/YbFx5uatDCgLJ9eOA=
X-Received: by 2002:a19:23c5:: with SMTP id j188mr265462lfj.430.1612459759029;
 Thu, 04 Feb 2021 09:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20210203172042.800474-1-shy828301@gmail.com> <20210203172042.800474-12-shy828301@gmail.com>
 <8c11f94a-bd1a-3311-2160-0f2c83994a53@virtuozzo.com>
In-Reply-To: <8c11f94a-bd1a-3311-2160-0f2c83994a53@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 4 Feb 2021 09:29:06 -0800
Message-ID: <CAHbLzkp6du=4rRcy2hxQrWo_2GX9QUcZuAyFqe_hiimDr6axyQ@mail.gmail.com>
Subject: Re: [v6 PATCH 11/11] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 4, 2021 at 2:23 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 03.02.2021 20:20, Yang Shi wrote:
> > The number of deferred objects might get windup to an absurd number, and it
> > results in clamp of slab objects.  It is undesirable for sustaining workingset.
> >
> > So shrink deferred objects proportional to priority and cap nr_deferred to twice
> > of cache items.
> >
> > The idea is borrowed fron Dave Chinner's patch:
> > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> >
> > Tested with kernel build and vfs metadata heavy workload in our production
> > environment, no regression is spotted so far.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> For some time I was away from this do_shrink_slab() magic formulas and recent changes,
> so I hope somebody else, who is being in touch with this, can review.

Yes, I agree it is intimidating. The patch has been tested in our test
and production environment for a couple of months, so far no
regression is spotted. Of course it doesn't mean it will not incur
regression for other workloads. My plan is to leave it stay in -mm
then linux-next for a while for a broader test. The first 10 patches
could go to Linus's tree separately.

>
> > ---
> >  mm/vmscan.c | 40 +++++-----------------------------------
> >  1 file changed, 5 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 574d920c4cab..d0a86170854b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -649,7 +649,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >        */
> >       nr = count_nr_deferred(shrinker, shrinkctl);
> >
> > -     total_scan = nr;
> >       if (shrinker->seeks) {
> >               delta = freeable >> priority;
> >               delta *= 4;
> > @@ -663,37 +662,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >               delta = freeable / 2;
> >       }
> >
> > +     total_scan = nr >> priority;
> >       total_scan += delta;
> > -     if (total_scan < 0) {
> > -             pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
> > -                    shrinker->scan_objects, total_scan);
> > -             total_scan = freeable;
> > -             next_deferred = nr;
> > -     } else
> > -             next_deferred = total_scan;
> > -
> > -     /*
> > -      * We need to avoid excessive windup on filesystem shrinkers
> > -      * due to large numbers of GFP_NOFS allocations causing the
> > -      * shrinkers to return -1 all the time. This results in a large
> > -      * nr being built up so when a shrink that can do some work
> > -      * comes along it empties the entire cache due to nr >>>
> > -      * freeable. This is bad for sustaining a working set in
> > -      * memory.
> > -      *
> > -      * Hence only allow the shrinker to scan the entire cache when
> > -      * a large delta change is calculated directly.
> > -      */
> > -     if (delta < freeable / 4)
> > -             total_scan = min(total_scan, freeable / 2);
> > -
> > -     /*
> > -      * Avoid risking looping forever due to too large nr value:
> > -      * never try to free more than twice the estimate number of
> > -      * freeable entries.
> > -      */
> > -     if (total_scan > freeable * 2)
> > -             total_scan = freeable * 2;
> > +     total_scan = min(total_scan, (2 * freeable));
> >
> >       trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> >                                  freeable, delta, total_scan, priority);
> > @@ -732,10 +703,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >               cond_resched();
> >       }
> >
> > -     if (next_deferred >= scanned)
> > -             next_deferred -= scanned;
> > -     else
> > -             next_deferred = 0;
> > +     next_deferred = max_t(long, (nr - scanned), 0) + total_scan;
> > +     next_deferred = min(next_deferred, (2 * freeable));
> > +
> >       /*
> >        * move the unused scan count back into the shrinker in a
> >        * manner that handles concurrent updates.
>
> Thanks
>
>
