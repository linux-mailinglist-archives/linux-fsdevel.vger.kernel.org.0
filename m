Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1133473E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhCJSzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhCJSy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:54:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9BC061760;
        Wed, 10 Mar 2021 10:54:55 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l12so29729106edt.3;
        Wed, 10 Mar 2021 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCDxaGO708+X0teCPcVi8bHUICJsi0qAoQCk7DCWrm0=;
        b=W54dGvzKeEQj36UI1YNvIo0e0n9dnRX+M2d4SRvvDIdyWZWBNHyaN95Xj7OAVTID4n
         pypMk45/5ZRvASY2Nskn1yyxsDnyEAEXM3+exSbRxQpNcU1HoOK8i96BHa8ehpoVLCso
         aZSCerrRY5Hagfg23Xb+k/NBNgI7mv/rcGIoYLK6WGiLA/apwmiSAT6SoE2TmMZv/z+k
         QASS4FQdtLAo6lVvZcv20YutFcbB5ujMMGrAPqOW1GmRAd4w2kYm6ZZ71h0DQk7HVB3F
         Wnv8RKNO4r4l2w6NdxeHVW0bpo0S1CeNx7dlfzt2H0EzCIFmsaf8bViLk6J/cTlsQ9uw
         VvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCDxaGO708+X0teCPcVi8bHUICJsi0qAoQCk7DCWrm0=;
        b=O+ViDwrl0IRgKG6dDQo3IipMdLcVQTPGahugviAE11hPg5aYIVnnSKShhSjATg22Xd
         REdftVQfztniBakxS+2HuXCPFDoZTWPKz5fbdQY9grH75DWyUD1DGtiAC+nO93P7sZu6
         QzvvWl34OkxFLY5sYYgRxTHONAaw0Np2cPslmhlaOAU0uPPHkkVfZl/JXmB1fHcBBfyd
         cOxehD1TrMxeOgbBHuFZwKEvitjq5nuujzTAOTPsUhKzNwKB4voiJmXDAz8y9cUVkwsA
         SHi95bykXmajypIDiOw61udCefdvoxUD9DUjtAh/dXdpM+1eOQXuCshbvM+EGUk6SBNF
         CHOA==
X-Gm-Message-State: AOAM531ZjL5dcnJiX1gEAQq/gREpkLG2Wi2xTQtnuCKuyELAGOtT/1Gh
        1YHJCLJOxMaanQC3+aLi/nMcr7Woh49z2oQtwctI6lwF
X-Google-Smtp-Source: ABdhPJzOGs67SJl3s6Uz/HOwfE+ahgbUdkBg2mI0WmFCXJdpulSCNIQlnKZ6EQhNewup3jytaAbP6Q5GczinJqDq29o=
X-Received: by 2002:aa7:df86:: with SMTP id b6mr4886439edy.294.1615402494435;
 Wed, 10 Mar 2021 10:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20210310174603.5093-1-shy828301@gmail.com> <20210310174603.5093-14-shy828301@gmail.com>
 <CALvZod5q5LDEfUMuvO7V2hTf+oCsBGXKZn3tBByOXL952wqbRw@mail.gmail.com>
In-Reply-To: <CALvZod5q5LDEfUMuvO7V2hTf+oCsBGXKZn3tBByOXL952wqbRw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 10 Mar 2021 10:54:43 -0800
Message-ID: <CAHbLzkpX0h2_FpeOWfrK3AO8RY4GE=wDqgSwFt69vn+roo6U3A@mail.gmail.com>
Subject: Re: [v9 PATCH 13/13] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:24 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Mar 10, 2021 at 9:46 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > The number of deferred objects might get windup to an absurd number, and it
> > results in clamp of slab objects.  It is undesirable for sustaining workingset.
> >
> > So shrink deferred objects proportional to priority and cap nr_deferred to twice
> > of cache items.
> >
> > The idea is borrowed from Dave Chinner's patch:
> > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> >
> > Tested with kernel build and vfs metadata heavy workload in our production
> > environment, no regression is spotted so far.
>
> Did you run both of these workloads in the same cgroup or separate cgroups?

Both are covered.

>
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 46 +++++++++++-----------------------------------
> >  1 file changed, 11 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 9a2dfeaa79f4..6a0a91b23597 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -662,7 +662,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >          */
> >         nr = xchg_nr_deferred(shrinker, shrinkctl);
> >
> > -       total_scan = nr;
> >         if (shrinker->seeks) {
> >                 delta = freeable >> priority;
> >                 delta *= 4;
> > @@ -676,37 +675,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >                 delta = freeable / 2;
> >         }
> >
> > +       total_scan = nr >> priority;
> >         total_scan += delta;
> > -       if (total_scan < 0) {
> > -               pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
> > -                      shrinker->scan_objects, total_scan);
> > -               total_scan = freeable;
> > -               next_deferred = nr;
> > -       } else
> > -               next_deferred = total_scan;
> > -
> > -       /*
> > -        * We need to avoid excessive windup on filesystem shrinkers
> > -        * due to large numbers of GFP_NOFS allocations causing the
> > -        * shrinkers to return -1 all the time. This results in a large
> > -        * nr being built up so when a shrink that can do some work
> > -        * comes along it empties the entire cache due to nr >>>
> > -        * freeable. This is bad for sustaining a working set in
> > -        * memory.
> > -        *
> > -        * Hence only allow the shrinker to scan the entire cache when
> > -        * a large delta change is calculated directly.
> > -        */
> > -       if (delta < freeable / 4)
> > -               total_scan = min(total_scan, freeable / 2);
> > -
> > -       /*
> > -        * Avoid risking looping forever due to too large nr value:
> > -        * never try to free more than twice the estimate number of
> > -        * freeable entries.
> > -        */
> > -       if (total_scan > freeable * 2)
> > -               total_scan = freeable * 2;
> > +       total_scan = min(total_scan, (2 * freeable));
> >
> >         trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> >                                    freeable, delta, total_scan, priority);
> > @@ -745,10 +716,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >                 cond_resched();
> >         }
> >
> > -       if (next_deferred >= scanned)
> > -               next_deferred -= scanned;
> > -       else
> > -               next_deferred = 0;
> > +       /*
> > +        * The deferred work is increased by any new work (delta) that wasn't
> > +        * done, decreased by old deferred work that was done now.
> > +        *
> > +        * And it is capped to two times of the freeable items.
> > +        */
> > +       next_deferred = max_t(long, (nr + delta - scanned), 0);
> > +       next_deferred = min(next_deferred, (2 * freeable));
> > +
> >         /*
> >          * move the unused scan count back into the shrinker in a
> >          * manner that handles concurrent updates.
> > --
> > 2.26.2
> >
