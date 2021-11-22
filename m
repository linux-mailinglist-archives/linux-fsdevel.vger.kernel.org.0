Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9BD458759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 01:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhKVAMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 19:12:09 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45392 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232057AbhKVAMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 19:12:08 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 984F98A111D;
        Mon, 22 Nov 2021 11:08:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mowt9-00BfsY-Fr; Mon, 22 Nov 2021 11:08:51 +1100
Date:   Mon, 22 Nov 2021 11:08:51 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <20211122000851.GE449541@dread.disaster.area>
References: <20211114231834.GM449541@dread.disaster.area>
 <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
 <20211115222417.GO449541@dread.disaster.area>
 <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
 <YZPVSTDIWroHNvFS@bfoster>
 <20211117002251.GR449541@dread.disaster.area>
 <YZVQUSCWWgOs+cRB@bfoster>
 <20211117214852.GU449541@dread.disaster.area>
 <YZf+lRsb0lBWdYgN@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZf+lRsb0lBWdYgN@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=619adf9d
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=HsDoLlocmGUuF16g:21 a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=D-SAqdW0K9F_pD15-20A:9 a=CjuIK1q_8ugA:10 a=hl_xKfOxWho2XEkUDbUg:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 02:44:21PM -0500, Brian Foster wrote:
> On Thu, Nov 18, 2021 at 08:48:52AM +1100, Dave Chinner wrote:
> > On Wed, Nov 17, 2021 at 01:56:17PM -0500, Brian Foster wrote:
> > > On Wed, Nov 17, 2021 at 11:22:51AM +1100, Dave Chinner wrote:
> > > Only a single grace period is required to cover
> > > (from the rcuwalk perspective) the entire set of inodes queued for
> > > inactivation. That leaves at least a few fairly straightforward options:
> > > 
> > > 1. Use queue_rcu_work() to schedule the inactivation task. We'd probably
> > > have to isolate the list to process first from the queueing context
> > > rather than from workqueue context to ensure we don't process recently
> > > added inodes that haven't sat for a grace period.
> > 
> > No, that takes too long. Long queues simply mean deferred
> > inactivation is working on cold CPU caches and that means we take a
> > 30-50% performance hit on inode eviction overhead for inodes that
> > need inactivation (e.g. unlinked inodes) just by having to load all
> > the inode state into CPU caches again.
> > 
> > Numbers I recorded at the time indicate that inactivation that
> > doesn't block on IO or the log typically takes between 200-500us
> > of CPU time, so the deferred batch sizes are sized to run about
> > 10-15ms worth of deferred processing at a time. Filling a batch
> > takes memory reclaim about 200uS to fill when running
> > dispose_list() to evict inodes.
> > 
> > The problem with using RCU grace periods is that they delay the
> > start of the work for at least 10ms, sometimes hundreds of ms.
> > Using queue_rcu_work() means we will need to go back to unbound
> > depth queues to avoid blocking waiting for grace period expiry to
> > maintain perfomrance. THis means having tens of thousands of inodes
> > queued for inactivation before the workqueue starts running. These
> > are the sorts of numbers that caused all the problems Darrick was
> > having with performance, and that was all cold cache loading
> > overhead which is unavoidable with such large queue depths....
> > 
> 
> Hm, Ok. I recall the large queue depth issues on the earlier versions
> but had not caught up with the subsequent changes that limit (percpu)
> batch size, etc. The cond sync rcu approach is easy enough to hack in
> (i.e., sample gp on destroy, cond_sync_rcu() on inactivate) that I ran a
> few experiments on opposing ends of the spectrum wrt to concurrency.
> 
> The short of it is that I do see about a 30% hit in the single threaded
> sustained removal case with current batch sizes. If the workload scales
> out to many (64) cpus, the impact dissipates, I suspect because we've
> already distributed the workload across percpu wq tasks and thus drive
> the rcu subsystem with context switches and other quiescent states that
> progress grace periods. The single threaded perf hit mitigates at about
> 4x the current throttling threshold.

I doubt that thread count increases are actually mitigating the perf
hit. Performance hits hard limits on concurrent rm -rf threads due
to CIL lock contention at 7-800,000 transactions/s
(hence the scalability patchset) regardless of the concurrency of
the workload. With that bottleneck removed, the system then hits
contention limits on VFS locks during
inode instantiation/reclaim. This typically happens at 1.1-1.2
million transactions/s during unlink.

Essentially, if you have a slower per-thread fs modification
workload, you can can increase the concurrency to more threads and
CPUs but the system will eventually still hit the same throughput
limits. Hence a per-thread performance degradataion will still reach
the same peak throughput levels, it will just take a few more
threads to reach that limit. IOWs, scale doesn't make the
per-thread degradation go away, it just allows more threads to run
at full (but degraded) performance before the scalabilty limit
threshold is hit.

> > We could, potentially, use a separate lockless queue for unlinked
> > inodes and defer that to after a grace period, but then rm -rf
> > workloads will go much, much slower.
> > 
> 
> I don't quite follow what you mean by a separate lockless queue..?

I was thinking separating unlinked symlinks into their own queue
that can be processed after a grace period....

> In
> any event, another experiment I ran in light of the above results that
> might be similar was to put the inode queueing component of
> destroy_inode() behind an rcu callback. This reduces the single threaded
> perf hit from the previous approach by about 50%. So not entirely
> baseline performance, but it's back closer to baseline if I double the
> throttle threshold (and actually faster at 4x). Perhaps my crude
> prototype logic could be optimized further to not rely on percpu
> threshold changes to match the baseline.
> 
> My overall takeaway from these couple hacky experiments is that the
> unconditional synchronous rcu wait is indeed probably too heavy weight,
> as you point out. The polling or callback (or perhaps your separate
> queue) approach seems to be in the ballpark of viability, however,
> particularly when we consider the behavior of scaled or mixed workloads
> (since inactive queue processing seems to be size driven vs. latency
> driven).
> 
> So I dunno.. if you consider the various severity and complexity
> tradeoffs, this certainly seems worth more consideration to me. I can
> think of other potentially interesting ways to experiment with
> optimizing the above or perhaps tweak queueing to better facilitate
> taking advantage of grace periods, but it's not worth going too far down
> that road if you're wedded to the "busy inodes" approach.

I'm not wedded to "busy inodes" but, as your experiments are
indicating, trying to handle rcu grace periods into the deferred
inactivation path isn't completely mitigating the impact of having
to wait for a grace period for recycling of inodes.

I suspect a rethink on the inode recycling mechanism is needed. THe
way it is currently implemented was a brute force solution - it is
simple and effective. However, we need more nuance in the recycling
logic now.  That is, if we are recycling an inode that is clean, has
nlink >=1 and has not been unlinked, it means the VFS evicted it too
soon and we are going to re-instantiate it as the identical inode
that was evicted from cache.

So how much re-initialisation do we actually need for that inode?
Almost everything in the inode is still valid; the problems come
from inode_init_always() resetting the entire internal inode state
and XFS then having to set them up again.  The internal state is
already largely correct when we start recycling, and the identity of
the recycled inode does not change when nlink >= 1. Hence eliding
inode_init_always() would also go a long way to avoiding the need
for a RCU grace period to pass before we can make the inode visible
to the VFS again.

If we can do that, then the only indoes that need a grace period
before they can be recycled are unlinked inodes as they change
identity when being recycled. That identity change absolutely
requires a grace period to expire before the new instantiation can
be made visible.  Given the arbitrary delay that this can introduce
for an inode allocation operation, it seems much better suited to
detecting busy inodes than waiting for a global OS state change to
occur...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
