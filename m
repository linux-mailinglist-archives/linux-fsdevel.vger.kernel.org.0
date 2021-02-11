Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114C331911D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 18:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBKRcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 12:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhBKRaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:30:00 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F921C061788;
        Thu, 11 Feb 2021 09:29:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f1so9251005lfu.3;
        Thu, 11 Feb 2021 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2BqX2C9xZ0tvZx8kWx5WCPacXA4lbnom4Z0hj5ICR8=;
        b=qjStwinyIak01ZE0CTrknqWtcIGDuf5y25gvfJyxgAJ/tAeUhOgX4xmVTAd0/Sb5/n
         caiwYDhhIT7wddkXXoCO3cAE7RRnvfUZQP6xO0cZc4x3EZHJgNdWON4X+1QpIBhE5WZm
         gRm/T8uf5Yn72iYfC3rzmfHP6NH2dPZBW50/dzMMGppSCHBpMk5qhkW+jQwmANu2A++Y
         qyfLUWPMLrG2qPWGuLltCFXkV4JtmczeGwib+SsHhaPEf1y/I8e/jrkWNczXjFK0MfGo
         mumeZXC90V/bYVjBtPEjt5h+vkr9IgDotOZaY65ZMAA+ZT5eTi04cIeLoCulfv2tpYI0
         19sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2BqX2C9xZ0tvZx8kWx5WCPacXA4lbnom4Z0hj5ICR8=;
        b=WEKR/kgllW80AsaXHWhdXZ6b9tPvUrixousxQIVr4ytxHIgmxZosY2zqn9xmmKx0GZ
         bgD4u+lB6PJhKJjnt9twiye6WPE89Sl9TBayAqRwuSHwVpLJJ4XHqembgsqyl2peacfQ
         n46p94oehsoIeMWB//I1n4v7RFv2LYiErRSfOR3ouYgv6qtPwbs2JwCcMaalEek09IRk
         mXaoZoOI9UFqL089CEgv1CrTCxms6fFf2sRoZtIM0/x+xm2GokdCR23CPwK57HoBo6Iv
         yHMG44tTOcInz1xvxgrdpIZZYa4dY1HvD4eHaOrkFXKcpSEkb43sXoGxsu4nXNmpnx79
         e24w==
X-Gm-Message-State: AOAM5323UGA5Ksw4DNZ6NJR0KUnGD6F8ioUc/WQXYd1rLY6u6lyjW+Qx
        6327Wx64bwPMUPFpna8gd8NLgXXTIJuzCQqAKeM=
X-Google-Smtp-Source: ABdhPJwubO0DBK93M/nIhHEGIX4oy5U5kDS4N2nkKEfH+z8IKuTRk6V5y9n/DiElSdFdVD658u00d++oPwp9MiahZXM=
X-Received: by 2002:a19:6447:: with SMTP id b7mr4763884lfj.206.1613064553614;
 Thu, 11 Feb 2021 09:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-13-shy828301@gmail.com>
 <acd1915c-306b-08a8-9e0f-b06c1e09fb4c@suse.cz>
In-Reply-To: <acd1915c-306b-08a8-9e0f-b06c1e09fb4c@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 11 Feb 2021 09:29:01 -0800
Message-ID: <CAHbLzkpF9+NUp2yUf_yKHHngKXGDya4Mj3ZTc-2rm3yFNw_==A@mail.gmail.com>
Subject: Re: [v7 PATCH 12/12] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
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

On Thu, Feb 11, 2021 at 5:10 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/9/21 6:46 PM, Yang Shi wrote:
> > The number of deferred objects might get windup to an absurd number, and it
> > results in clamp of slab objects.  It is undesirable for sustaining workingset.
> >
> > So shrink deferred objects proportional to priority and cap nr_deferred to twice
> > of cache items.
>
> Makes sense to me, minimally it's simpler than the old code and avoiding absurd
> growth of nr_deferred should be a good thing, as well as the "proportional to
> priority" part.

Thanks.

>
> I just suspect there's a bit of unnecessary bias in the implementation, as
> explained below:
>
> > The idea is borrowed from Dave Chinner's patch:
> > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> >
> > Tested with kernel build and vfs metadata heavy workload in our production
> > environment, no regression is spotted so far.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 40 +++++-----------------------------------
> >  1 file changed, 5 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 66163082cc6f..d670b119d6bd 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -654,7 +654,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >        */
> >       nr = count_nr_deferred(shrinker, shrinkctl);
> >
> > -     total_scan = nr;
> >       if (shrinker->seeks) {
> >               delta = freeable >> priority;
> >               delta *= 4;
> > @@ -668,37 +667,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >               delta = freeable / 2;
> >       }
> >
> > +     total_scan = nr >> priority;
> >       total_scan += delta;
>
> So, our scan goal consists of the part based on freeable objects (delta), plus a
> part of the defferred objects (nr >> priority). Fine.
>
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
>
> Probably unnecessary as we cap next_deferred below anyway? So total_scan cannot
> grow without limits anymore. But can't hurt.
>
> >       trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> >                                  freeable, delta, total_scan, priority);
> > @@ -737,10 +708,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >               cond_resched();
> >       }
> >
> > -     if (next_deferred >= scanned)
> > -             next_deferred -= scanned;
> > -     else
> > -             next_deferred = 0;
> > +     next_deferred = max_t(long, (nr - scanned), 0) + total_scan;
>
> And here's the bias I think. Suppose we scanned 0 due to e.g. GFP_NOFS. We count
> as newly deferred both the "delta" part of total_scan, which is fine, but also
> the "nr >> priority" part, where we failed to our share of the "reduce
> nr_deferred" work, but I don't think it means we should also increase
> nr_deferred by that amount of failed work.

Here "nr" is the saved deferred work since the last scan, "scanned" is
the scanned work in this round, total_scan is the *unscanned" work
which is actually "total_scan - scanned" (total_scan is decreased by
scanned in each loop). So, the logic is "decrease any scanned work
from deferred then add newly unscanned work to deferred". IIUC this is
what "deferred" means even before this patch.

> OTOH if we succeed and scan exactly the whole goal, we are subtracting from
> nr_deferred both the "nr >> priority" part, which is correct, but also delta,
> which was new work, not deferred one, so that's incorrect IMHO as well.

I don't think so. The deferred comes from new work, why not dec new
work from deferred?

And, the old code did:

if (next_deferred >= scanned)
                next_deferred -= scanned;
        else
                next_deferred = 0;

IIUC, it also decreases the new work (the scanned includes both last
deferred and new delata).

> So the calculation should probably be something like this?
>
>         next_deferred = max_t(long, nr + delta - scanned, 0);
>
> Thanks,
> Vlastimil
>
> > +     next_deferred = min(next_deferred, (2 * freeable));
> > +
> >       /*
> >        * move the unused scan count back into the shrinker in a
> >        * manner that handles concurrent updates.
> >
>
