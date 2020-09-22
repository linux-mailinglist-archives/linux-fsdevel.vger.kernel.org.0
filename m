Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A792B274D7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 01:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgIVXp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 19:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVXp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:45:26 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEDAC061755;
        Tue, 22 Sep 2020 16:45:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n13so17845491edo.10;
        Tue, 22 Sep 2020 16:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eur0c/gmZNk8P6f78jo1NHwEQ+tOFk1+xmmaxrVS+oE=;
        b=jkdDpaVVZOHOY0VpgyT2Tm9MJgoOHSa0tB1vmqyX3jja9rTQrqQsA3DI9jDY4IUuWe
         Lot1/7nsGlI6X46ryKWik2GzEnmKlkneq9H/7AUJEGsRW2hQNw03yskaiL+W9r+/WhDP
         tQB0JZNSbGR5wNVLu2aWNh81N8eVh66FzOAjUhTF9rZOP/STogLZAvbMZzm4flT4ghqB
         WMVevt6rwOiDrdKEbjQuJTaeQOTL189dGQ74/AlzSSatwjuihHdKHK0QKVj20KBF1zzk
         n1bGhpQcx7ozPXHHLvozdJb8zYKQbdnvb3OjkRFiucr3s5qGggPPLm/OqeLGI/j5K6FI
         eIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eur0c/gmZNk8P6f78jo1NHwEQ+tOFk1+xmmaxrVS+oE=;
        b=CYaXb3VJI4+lSzGJ7Ir6CNW7YTQgH9nElW00kUVlm38T/lX9UP8zrgG5SGwvw6su7x
         Yf9lOHFZuykRxfxv77lq5jW9mBsfqxQtTlAgyOkTqH+a8NWu+u7nJ05VSGbjqVBXqIc6
         bWf/D0dnhv3JKRePJ+vhDXkYdWtmEApk43naTIhfgYGZPRIB74H7YgTsi2PenQ6RzEZO
         V1fbXyX2n7Y8MJQCU0mr0+mOzMVgvuBXKa2i6oWfseb4LiyiriCIQDruVabW0+8hzjUB
         l16Dvg6PPLnqc+QGgLlQWbXpRV6ewPSU/Q3LO5lbgkqegZOwn9J3lz3QYT+uJKdOoh3x
         sW5w==
X-Gm-Message-State: AOAM533idoeAQnrK+P4Z9xtvf/AQAMe83oFIqp6d/Hg440GaFnxnsBUn
        EI4MzL9zKULYO5DqWPcgH5A+wd54E1Ux/yVFoiG6frYrhtcU7A==
X-Google-Smtp-Source: ABdhPJyOxe2zHA1W3VCwhFJPxfHSpYC2kzhrcW4zHOUnaK3ApZowjuqd32Ss1rC5AkGq0T/8vFZNvsTtJap3CNtSt5E=
X-Received: by 2002:a50:ed02:: with SMTP id j2mr6891235eds.137.1600818324281;
 Tue, 22 Sep 2020 16:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200916185823.5347-1-shy828301@gmail.com> <20200917023742.GT12096@dread.disaster.area>
 <CAHbLzkrGB_=KBgD1sMpW33QjWSGTXNnLy3JtVUyHc2Omsa3gWA@mail.gmail.com> <20200921003231.GZ12096@dread.disaster.area>
In-Reply-To: <20200921003231.GZ12096@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 22 Sep 2020 16:45:12 -0700
Message-ID: <CAHbLzkqAWiO4uhGBmbUjgs6EmQazYQXHPxR2-MWo4X8zxZ7gfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Remove shrinker's nr_deferred
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 20, 2020 at 5:32 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Sep 17, 2020 at 05:12:08PM -0700, Yang Shi wrote:
> > On Wed, Sep 16, 2020 at 7:37 PM Dave Chinner <david@fromorbit.com> wrote:
> > > On Wed, Sep 16, 2020 at 11:58:21AM -0700, Yang Shi wrote:
> > > It clamps the worst case freeing to half the cache, and that is
> > > exactly what you are seeing. This, unfortunately, won't be enough to
> > > fix the windup problem once it's spiralled out of control. It's
> > > fairly rare for this to happen - it takes effort to find an adverse
> > > workload that will cause windup like this.
> >
> > I'm not sure if it is very rare, but my reproducer definitely could
> > generate huge amount of deferred objects easily. In addition it might
> > be easier to run into this case with hundreds of memcgs. Just imaging
> > hundreds memcgs run limit reclaims with __GFP_NOFS, the amount of
> > deferred objects can be built up easily.
>
> This is the first time I've seen a report that indicates excessive
> wind-up is occurring in years. That definitely makes it a rare
> problem in the real world.
>
> > On our production machine, I saw much more absurd deferred objects,
> > check the below tracing result out:
> >
> > <...>-48776 [032] .... 27970562.458916: mm_shrink_slab_start:
> > super_cache_scan+0x0/0x1a0 ffff9a83046f3458: nid: 0 objects to shrink
> > 2531805877005 gfp_flags GFP_HIGHUSER_MOVABLE pgs_scanned 32 lru_pgs
> > 9300 cache items 1667 delta 11 total_scan 833
> >
> > There are 2.5 trillion deferred objects on one node! So total > 5 trillion!
>
> Sure, I'm not saying it's impossible to trigger, just that there are
> not many common workloads that actually cause it to occur. And,
> really, if it's wound up that far before you've noticed a problem,
> then wind-up itself isn't typically a serious problem for
> systems....

Actually the problem was observed some time ago, I just got some time
to look into the root cause.

This kind of problem may be more common with memcg environment. For
example, a misconfigured memcg may incur excessive __GFP_NOFS limit
reclaims.

>
> > > So, with all that said, a year ago I actually fixed this problem
> > > as part of some work I did to provide non-blocking inode reclaim
> > > infrastructure in the shrinker for XFS inode reclaim.
> > > See this patch:
> > >
> > > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> >
> > Thanks for this. I remembered the patches, but I admitted I was not
> > aware deferred objects could go wild like that.
>
> Not many people are....
>
> > > It did two things. First it ensured all the deferred work was done
> > > by kswapd so that some poor direct reclaim victim didn't hit a
> > > massive reclaim latency spike because of windup. Secondly, it
> > > clamped the maximum windup to the maximum single pass reclaim scan
> > > limit, which is (freeable * 2) objects.
> > >
> > > Finally it also changed the amount of deferred work a single kswapd
> > > pass did to be directly proportional to the reclaim priority. Hence
> > > as we get closer to OOM, kswapd tries much harder to get the
> > > deferred work backlog down to zero. This means that a single, low
> > > priority reclaim pass will never reclaim half the cache - only
> > > sustained memory pressure and _reclaim priority windup_ will do
> > > that.
> >
> > Other than these, there are more problems:
> >
> > - The amount of deferred objects seem get significantly overestimated
> > and unbounded. For example, if one lru has 1000 objects, the amount of
> > reclaimables is bounded to 1000, but the amount of deferred is not. It
> > may go much bigger than 1000, right? As the above tracing result
> > shows, 2.5 trillion deferred objects on one node, assuming all of them
> > are dentry (192 bytes per object), so the total size of deferred on
> > one node is ~480TB! Or this is a bug?
>
> As the above patchset points out: it can get out of control because
> it is unbounded. The above patchset bounds the deferred work to (2 *
> current cache item count) and so it cannot ever spiral out of
> control like this.

I was thinking about cap it to (2 * freeable) too before I looked into
your patches :-)

>
> > - The deferred will be reset by the reclaimer who gets there first,
> > then other concurrent reclaimers just see 0 or very few deferred
> > objects.
>
> No, not exactly.
>
> The current behaviour is that the deferred count is drained by the
> current shrinker context, then it does whatever work it can, then it
> puts the remainder of the work that was not done back on the
> deferred count. This was done so that only a single reclaim context
> tried to execute the deferred work (i.e. to prevent the deferred
> work being run multiple times by concurrent reclaim contexts), but
> if the work didn't get done it was still accounted and would get
> done later.

Yes, definitely. I should articulated it at the first place.

>
> A side effect of this was that nothing ever zeros the deferred
> count, however, because there is no serialisation between concurrent
> shrinker contexts. That's why it can wind up if the number of
> GFP_NOFS reclaim contexts greatly exceeds the number of GFP_KERNEL
> reclaim contexts.
>
> This is what the above patchset fixes - deferred work is only ever
> done by kswapd(), which means it doesn't have to care about multiple
> reclaim contexts doing deferred work. This simplifies it right down,
> and it allows us to bound the quantity of deferred work as a single
> reclaimer will be doing it all...
>
> > So the clamp may not happen on the lrus which have most
> > objects. For example, memcg A's dentry lru has 1000 objects, memcg B's
> > dentry lru has 1 million objects, but memcg A's limit reclaim is run
> > first, then just 500 was clamped.
>
> Yup, that's a memcg bug. memcg's were grafted onto the side of the
> shrinker infrastructure, and one of the parts of the shrinker
> behaviour that was not made per-memcg was the amount of work
> deferred from the per-memcg shrinker invocation. If you want memcgs
> to behave correctly w.r.t. work deferred inside a specific memcg
> shrinker context, then the deferred work accounting needs to be made
> per-memcg, not just a global per-node count.
>
> The first step to doing this, however, is fixing up the problems we
> currently have with deferred work, and that is the patchset I
> pointed you to above. We have to push the defered work to the kswapd
> context so that it can process all the deferred work for all of the
> memcgs in the system in a single reclaim context; if the memcg is
> just doing GFP_NOFS allocations, then just deferring the work to the
> next GFP_KERNEL direct reclaim that specific memcg enters is not
> going to be sufficient.

But kswapd may be not called in some cases at all. For example, the
system may have some memcgs configured, every memcg reaches its limit
and does limit reclaim, but the global memory usage is not high enough
to wake up kswapd. The deferred objects can get windup, and limit
reclaim can't bring it down under control.

By making nr_deferred per memcg, memcg limit reclaim could bring the
deferred objects under control.

>
> > - Currently the deferred objects are account per shrinker, it sounds
> > not very fair, particularly given the environment with hundreds of
> > memcgs. Some memcgs may not do a lot __GFP_NOFS allocations, but the
> > clamp may hit them. So, off the top of my head, I'm wondering whether
> > it sounds better to have deferred per-memcg, so who generates deferred
> > who gets punished.
>
> Yup, see above.
>
> > - Some workloads, i.e. git server, don't want that clamp behavior or
> > wish it goes more mild. For example, the ratio between vfs caches and
> > page caches is 10:1 on some our production servers.
>
> The overall system cache balancing has nothing to do with deferred
> work clamping. The deferred work mechanism is there to make sure
> unrealised reclaim pressure is fed back into the reclaim subsystem
> to tell it it needs to do more work...
>
> > - Waiting for kswapd to clamp those deferred may be too late, and it
> > may not be able to drive deferred down to a reasonable number at all.
> > IMHO avoiding the amount of deferred objects goes out of control at
> > the first place may be much more important.
>
> kswapd is the only guaranteed reclaim context that can make
> progress on deferred work. Windup is an indications that it hasn't
> been kicked soon enough. One of the advantages of deferring work to
> kswapd is that now we have a -algorithmic trigger- for shrinker
> reclaim contexts kicking kswapd sooner than we currently do. e.g. if
> the deferred work reaches 1/4 the size of the current cache, kick
> kswapd to start doing the work we are deferring. This might require
> marking memcgs and shrinkers as "needing deferred work" similar to
> how we currently mark memcg shrinkers as "containing shrinkable
> items" so that we can run kswapd quickly on just the memcgs/shrinker
> contexts that need deferred work to be done....

This seems feasible, but it sounds like we need introduce another "watermark".

IMHO we could make shrinker behave more fair among memcgs and keep
deferred objects under control just by making nr_deferred per memcg
and capping nr_deferred to (2 * freeable) or whatever reasonable
number.

Both kswapd and global direct reclaim would traverse all memcgs and
they get nr_deferred from each memcg, they can guarantee all memcgs
get shrunk at a fair rate. We could shrink harder in kswapd, but both
kswapd and direct reclaim should do shrink according to priority. This
should be able to mitigate direct reclaim latency.

Limit reclaim would traverse all memcgs under reclaim root, it could
help keep deferred objects under control for "limit reclaim only"
case.

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
