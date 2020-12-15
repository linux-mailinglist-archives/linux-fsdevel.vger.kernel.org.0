Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C282DB7B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 01:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgLPAH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 19:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgLPAAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:00:53 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41EFC0613D3;
        Tue, 15 Dec 2020 16:00:12 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id 6so15562070ejz.5;
        Tue, 15 Dec 2020 16:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWNs84euS5+GSv9nRk8flYq+n+pWmoelKQH47Nr99CU=;
        b=I/AuV4JDGG7VDvzUf1ACX4rHlnyKX8woLAg1gUm1neAgUHcC20JjUUqw3/OpuzbXTV
         Ij5CYI4N5/4vrBX7jcmTyEGO9ju8njXHhcDjDGESneDsj8n0zfJGNF55/jgBmMUDIWuI
         3Z8A670wDo/YgnlA8gdeGj1tfGk3MhZkrJ1SWBkC+rsp5qWK0RIWFj5KPLjt2spsBdZs
         8sPNx2OhKTIkrqph4cwpG4OartZeCNifKv2WjeRzklU/fVVhdsP5ksUETdbLMYcLaxmV
         2pLJpR2Lhfw6KY0egqc2JfBaAMxAXaiFgKl2wOU4bdwC9fEhb4OEbxFZAOSOgQuNP8Pw
         FwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWNs84euS5+GSv9nRk8flYq+n+pWmoelKQH47Nr99CU=;
        b=gBKPI1zdLl/SW3R9rToqqT+eCxiux5T6AbLp0v+e5IC/mm5K/n6+1pGu5CshRHHwJ1
         406Epnyapbj9nXdsaIalv8PGH405oQ/LkiufdDzdGxK23cKSALApYWCVbLqYM+rXIEzH
         ZuMSRaCgjC9qK/JMv2YTF9LKvxFNzcfjIjHxZL75//cVkuHoJUItrQcs/XWNBwZx+JzE
         uymRwEEWOt85jjwPYOtFhyoxizhHwFXG5wleIoWV5D0D/zNNup4L5inoIIM7yf0+EuEc
         GtYzyew0dzWeBUVxRs7FK7ovNPSbygBK6zzEMJDzZiqe47g1Cnf7o4oRyaVWxq6nUkRX
         pouA==
X-Gm-Message-State: AOAM533J1CuajIzFkarMapVA6Oqiry8cMfyQfpnDMyPor6hMaNlUpMTE
        +QY0+5LMUn3UcEL1x+4pYnuKNOldRUEtpzPnybA=
X-Google-Smtp-Source: ABdhPJxasHIw68sJydp5dBN/h2PRm+ei926F1sGziqBSdmJcWbqrJEocf2hXr7y33TE0K40Pt1NLsJngefAgGo1niUA=
X-Received: by 2002:a17:906:cd06:: with SMTP id oz6mr29096141ejb.25.1608076811384;
 Tue, 15 Dec 2020 16:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-10-shy828301@gmail.com>
 <20201215032337.GP3913616@dread.disaster.area>
In-Reply-To: <20201215032337.GP3913616@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 15 Dec 2020 15:59:59 -0800
Message-ID: <CAHbLzkp20yNvQiknPM92DbdqYS03ZKcXwH1WQfsdnAC2TLRT0w@mail.gmail.com>
Subject: Re: [v2 PATCH 9/9] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
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

On Mon, Dec 14, 2020 at 7:23 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Dec 14, 2020 at 02:37:22PM -0800, Yang Shi wrote:
> > The number of deferred objects might get windup to an absurd number, and it results in
> > clamp of slab objects.  It is undesirable for sustaining workingset.
> >
> > So shrink deferred objects proportional to priority and cap nr_deferred to twice of
> > cache items.
>
> This completely changes the work accrual algorithm without any
> explaination of how it works, what the theory behind the algorithm
> is, what the work accrual ramp up and damp down curve looks like,
> what workloads it is designed to benefit, how it affects page
> cache vs slab cache balance and system performance, what OOM stress
> testing has been done to ensure pure slab cache pressure workloads
> don't easily trigger OOM kills, etc.

Actually this patch does two things:
1. Take nr_deferred into account priority.
2. Cap nr_deferred to twice of freeable

Actually the idea is borrowed from you patch:
https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/,
the difference is that your patch restrains the change for kswapd
only, but mine is extended to direct reclaim and limit reclaim.

>
> You're going to need a lot more supporting evidence that this is a
> well thought out algorithm that doesn't obviously introduce
> regressions. The current code might fall down in one corner case,
> but there are an awful lot of corner cases where it does work.
> Please provide some evidence that it not only works in your corner
> case, but also doesn't introduce regressions for other slab cache
> intensive and mixed cache intensive worklaods...

I agree the change may cause some workload regressed out of blue. I
tested with kernel build and vfs metadata heavy workloads, I wish I
could cover more. But I'm not filesystem developer, do you have any
typical workloads that I could try to run to see if they have
regression?

>
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 40 +++++-----------------------------------
> >  1 file changed, 5 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 693a41e89969..58f4a383f0df 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -525,7 +525,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >        */
> >       nr = count_nr_deferred(shrinker, shrinkctl);
> >
> > -     total_scan = nr;
> >       if (shrinker->seeks) {
> >               delta = freeable >> priority;
> >               delta *= 4;
> > @@ -539,37 +538,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >               delta = freeable / 2;
> >       }
> >
> > +     total_scan = nr >> priority;
>
> When there is low memory pressure, this will throw away a large
> amount of the work that is deferred. If we are not defering in
> amounts larger than ~4000 items, every pass through this code will
> zero the deferred work.
>
> Hence when we do get substantial pressure, that deferred work is no
> longer being tracked. While it may help your specific corner case,
> it's likely to significantly change the reclaim balance of slab
> caches, especially under GFP_NOFS intensive workloads where we can
> only defer the work to kswapd.
>
> Hence I think this is still a problematic approach as it doesn't
> address the reason why deferred counts are increasing out of
> control in the first place....

For our workload the deferred counts are mainly contributed by
multiple memcgs' limit reclaim per my analysis. So, the most crucial
step is to make nr_deferred memcg aware so that the auxiliary memcgs
won't have interference to the main workload.

If the test may take too long I'd prefer drop this patch for now since
it is not that critical to our workload, I really hope have
nr_deferred memcg aware part get into upstream soon.

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
