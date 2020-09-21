Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71D2718D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 02:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIUAci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 20:32:38 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36975 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgIUAch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 20:32:37 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E7AFD8257FB;
        Mon, 21 Sep 2020 10:32:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kK9ku-0005t6-0a; Mon, 21 Sep 2020 10:32:32 +1000
Date:   Mon, 21 Sep 2020 10:32:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Remove shrinker's nr_deferred
Message-ID: <20200921003231.GZ12096@dread.disaster.area>
References: <20200916185823.5347-1-shy828301@gmail.com>
 <20200917023742.GT12096@dread.disaster.area>
 <CAHbLzkrGB_=KBgD1sMpW33QjWSGTXNnLy3JtVUyHc2Omsa3gWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrGB_=KBgD1sMpW33QjWSGTXNnLy3JtVUyHc2Omsa3gWA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=esqhMbhX c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=LuaJjEBImRsqc3FZEm4A:9 a=zWzCIjU0gZrhXPJ-:21 a=Tm-CyRdUtTE8Rimj:21
        a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 05:12:08PM -0700, Yang Shi wrote:
> On Wed, Sep 16, 2020 at 7:37 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Wed, Sep 16, 2020 at 11:58:21AM -0700, Yang Shi wrote:
> > It clamps the worst case freeing to half the cache, and that is
> > exactly what you are seeing. This, unfortunately, won't be enough to
> > fix the windup problem once it's spiralled out of control. It's
> > fairly rare for this to happen - it takes effort to find an adverse
> > workload that will cause windup like this.
> 
> I'm not sure if it is very rare, but my reproducer definitely could
> generate huge amount of deferred objects easily. In addition it might
> be easier to run into this case with hundreds of memcgs. Just imaging
> hundreds memcgs run limit reclaims with __GFP_NOFS, the amount of
> deferred objects can be built up easily.

This is the first time I've seen a report that indicates excessive
wind-up is occurring in years. That definitely makes it a rare
problem in the real world.

> On our production machine, I saw much more absurd deferred objects,
> check the below tracing result out:
> 
> <...>-48776 [032] .... 27970562.458916: mm_shrink_slab_start:
> super_cache_scan+0x0/0x1a0 ffff9a83046f3458: nid: 0 objects to shrink
> 2531805877005 gfp_flags GFP_HIGHUSER_MOVABLE pgs_scanned 32 lru_pgs
> 9300 cache items 1667 delta 11 total_scan 833
> 
> There are 2.5 trillion deferred objects on one node! So total > 5 trillion!

Sure, I'm not saying it's impossible to trigger, just that there are
not many common workloads that actually cause it to occur. And,
really, if it's wound up that far before you've noticed a problem,
then wind-up itself isn't typically a serious problem for
systems....

> > So, with all that said, a year ago I actually fixed this problem
> > as part of some work I did to provide non-blocking inode reclaim
> > infrastructure in the shrinker for XFS inode reclaim.
> > See this patch:
> >
> > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> 
> Thanks for this. I remembered the patches, but I admitted I was not
> aware deferred objects could go wild like that.

Not many people are....

> > It did two things. First it ensured all the deferred work was done
> > by kswapd so that some poor direct reclaim victim didn't hit a
> > massive reclaim latency spike because of windup. Secondly, it
> > clamped the maximum windup to the maximum single pass reclaim scan
> > limit, which is (freeable * 2) objects.
> >
> > Finally it also changed the amount of deferred work a single kswapd
> > pass did to be directly proportional to the reclaim priority. Hence
> > as we get closer to OOM, kswapd tries much harder to get the
> > deferred work backlog down to zero. This means that a single, low
> > priority reclaim pass will never reclaim half the cache - only
> > sustained memory pressure and _reclaim priority windup_ will do
> > that.
> 
> Other than these, there are more problems:
> 
> - The amount of deferred objects seem get significantly overestimated
> and unbounded. For example, if one lru has 1000 objects, the amount of
> reclaimables is bounded to 1000, but the amount of deferred is not. It
> may go much bigger than 1000, right? As the above tracing result
> shows, 2.5 trillion deferred objects on one node, assuming all of them
> are dentry (192 bytes per object), so the total size of deferred on
> one node is ~480TB! Or this is a bug?

As the above patchset points out: it can get out of control because
it is unbounded. The above patchset bounds the deferred work to (2 *
current cache item count) and so it cannot ever spiral out of
control like this.

> - The deferred will be reset by the reclaimer who gets there first,
> then other concurrent reclaimers just see 0 or very few deferred
> objects.

No, not exactly.

The current behaviour is that the deferred count is drained by the
current shrinker context, then it does whatever work it can, then it
puts the remainder of the work that was not done back on the
deferred count. This was done so that only a single reclaim context
tried to execute the deferred work (i.e. to prevent the deferred
work being run multiple times by concurrent reclaim contexts), but
if the work didn't get done it was still accounted and would get
done later.

A side effect of this was that nothing ever zeros the deferred
count, however, because there is no serialisation between concurrent
shrinker contexts. That's why it can wind up if the number of
GFP_NOFS reclaim contexts greatly exceeds the number of GFP_KERNEL
reclaim contexts.

This is what the above patchset fixes - deferred work is only ever
done by kswapd(), which means it doesn't have to care about multiple
reclaim contexts doing deferred work. This simplifies it right down,
and it allows us to bound the quantity of deferred work as a single
reclaimer will be doing it all...

> So the clamp may not happen on the lrus which have most
> objects. For example, memcg A's dentry lru has 1000 objects, memcg B's
> dentry lru has 1 million objects, but memcg A's limit reclaim is run
> first, then just 500 was clamped.

Yup, that's a memcg bug. memcg's were grafted onto the side of the
shrinker infrastructure, and one of the parts of the shrinker
behaviour that was not made per-memcg was the amount of work
deferred from the per-memcg shrinker invocation. If you want memcgs
to behave correctly w.r.t. work deferred inside a specific memcg
shrinker context, then the deferred work accounting needs to be made
per-memcg, not just a global per-node count.

The first step to doing this, however, is fixing up the problems we
currently have with deferred work, and that is the patchset I
pointed you to above. We have to push the defered work to the kswapd
context so that it can process all the deferred work for all of the
memcgs in the system in a single reclaim context; if the memcg is
just doing GFP_NOFS allocations, then just deferring the work to the
next GFP_KERNEL direct reclaim that specific memcg enters is not
going to be sufficient.

> - Currently the deferred objects are account per shrinker, it sounds
> not very fair, particularly given the environment with hundreds of
> memcgs. Some memcgs may not do a lot __GFP_NOFS allocations, but the
> clamp may hit them. So, off the top of my head, I'm wondering whether
> it sounds better to have deferred per-memcg, so who generates deferred
> who gets punished.

Yup, see above.

> - Some workloads, i.e. git server, don't want that clamp behavior or
> wish it goes more mild. For example, the ratio between vfs caches and
> page caches is 10:1 on some our production servers.

The overall system cache balancing has nothing to do with deferred
work clamping. The deferred work mechanism is there to make sure
unrealised reclaim pressure is fed back into the reclaim subsystem
to tell it it needs to do more work...

> - Waiting for kswapd to clamp those deferred may be too late, and it
> may not be able to drive deferred down to a reasonable number at all.
> IMHO avoiding the amount of deferred objects goes out of control at
> the first place may be much more important.

kswapd is the only guaranteed reclaim context that can make
progress on deferred work. Windup is an indications that it hasn't
been kicked soon enough. One of the advantages of deferring work to
kswapd is that now we have a -algorithmic trigger- for shrinker
reclaim contexts kicking kswapd sooner than we currently do. e.g. if
the deferred work reaches 1/4 the size of the current cache, kick
kswapd to start doing the work we are deferring. This might require
marking memcgs and shrinkers as "needing deferred work" similar to
how we currently mark memcg shrinkers as "containing shrinkable
items" so that we can run kswapd quickly on just the memcgs/shrinker
contexts that need deferred work to be done....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
