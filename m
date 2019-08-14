Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2CE8C9B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 04:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfHNCwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 22:52:46 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56391 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbfHNCwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:52:46 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4FE0C361163;
        Wed, 14 Aug 2019 12:52:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hxjNq-0007K4-DZ; Wed, 14 Aug 2019 12:51:30 +1000
Date:   Wed, 14 Aug 2019 12:51:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] block: annotate refault stalls from IO submission
Message-ID: <20190814025130.GI7777@dread.disaster.area>
References: <20190808190300.GA9067@cmpxchg.org>
 <20190809221248.GK7689@dread.disaster.area>
 <20190813174625.GA21982@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813174625.GA21982@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=bDTW_sOx19nDKLnYJhUA:9 a=cnofGfEq4Fq2u8Yj:21
        a=FLub2pyhoGWWgdtb:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 01:46:25PM -0400, Johannes Weiner wrote:
> On Sat, Aug 10, 2019 at 08:12:48AM +1000, Dave Chinner wrote:
> > On Thu, Aug 08, 2019 at 03:03:00PM -0400, Johannes Weiner wrote:
> > > psi tracks the time tasks wait for refaulting pages to become
> > > uptodate, but it does not track the time spent submitting the IO. The
> > > submission part can be significant if backing storage is contended or
> > > when cgroup throttling (io.latency) is in effect - a lot of time is
> > 
> > Or the wbt is throttling.
> > 
> > > spent in submit_bio(). In that case, we underreport memory pressure.
> > > 
> > > Annotate submit_bio() to account submission time as memory stall when
> > > the bio is reading userspace workingset pages.
> > 
> > PAtch looks fine to me, but it raises another question w.r.t. IO
> > stalls and reclaim pressure feedback to the vm: how do we make use
> > of the pressure stall infrastructure to track inode cache pressure
> > and stalls?
> > 
> > With the congestion_wait() and wait_iff_congested() being entire
> > non-functional for block devices since 5.0, there is no IO load
> > based feedback going into memory reclaim from shrinkers that might
> > require IO to free objects before they can be reclaimed. This is
> > directly analogous to page reclaim writing back dirty pages from
> > the LRU, and as I understand it one of things the PSI is supposed
> > to be tracking.
> >
> > Lots of workloads create inode cache pressure and often it can
> > dominate the time spent in memory reclaim, so it would seem to me
> > that having PSI only track/calculate pressure and stalls from LRU
> > pages misses a fair chunk of the memory pressure and reclaim stalls
> > that can be occurring.
> 
> psi already tracks the entire reclaim operation. So if reclaim calls
> into the shrinker and the shrinker scans inodes, initiates IO, or even
> waits on IO, that time is accounted for as memory pressure stalling.

hmmmm - reclaim _scanning_ is considered a stall event? i.e. even if
scanning does not block, it's still accounting that _time_ as a
memory pressure stall?

I'm probably missing it, but I don't see anything in vmpressure()
that actually accounts for time spent scanning.  AFAICT it accounts
for LRU objects scanned and reclaimed from memcgs, and then the
memory freed from the shrinkers is accounted only to the
sc->target_mem_cgroup once all memcgs have been iterated.

So, AFAICT, there's no time aspect to this, and the amount of
scanning that shrinkers do is not taken into account, so pressure
can't really be determined properly there. It seems like what the
shrinkers reclaim will actually give an incorrect interpretation of
pressure right now...

> If you can think of asynchronous events that are initiated from
> reclaim but cause indirect stalls in other contexts, contexts which
> can clearly link the stall back to reclaim activity, we can annotate
> them using psi_memstall_enter() / psi_memstall_leave().

Well, I was more thinking that issuing/waiting on IOs is a stall
event, not scanning.

The IO-less inode reclaim stuff for XFS really needs the main
reclaim loop to back off under heavy IO load, but we cannot put the
entire metadata writeback path under psi_memstall_enter/leave()
because:

	a) it's not linked to any user context - it's a
	per-superblock kernel thread; and

	b) it's designed to always be stalled on IO when there is
	metadata writeback pressure. That pressure most often comes from
	running out of journal space rather than memory pressure, and
	really there is no way to distinguish between the two from
	the writeback context.

Hence I don't think the vmpressure mechanism does what the memory
reclaim scanning loops really need because they do not feed back a
clear picture of the load on the IO subsystem load into the reclaim
loops.....

> In that vein, what would be great to have is be a distinction between
> read stalls on dentries/inodes that have never been touched before
> versus those that have been recently reclaimed - analogous to cold
> page faults vs refaults.

See my "nonblocking inode reclaim for XFS" series. It adds new
measures of that the shrinkers feed back to the main reclaim loop.

One of those measures is the number of objects scanned. Shrinkers
already report the number of objects they free, but that it tossed
away and not used by the main reclaim loop.

As for cold faults vs refaults, we could only report that for
dentries - if the inode is still cached in memory, then the dentry
hits the inode cache (hot fault), otherwise it's got to fetch the
inode from disk (cold fault). There is no mechanisms for tracking
inodes that have been recently reclaimed - the VFS uses a hash for
tracking cached inodes and so there's nothign you can drop
exceptional entries into to track reclaim state.

That said, we /could/ do this with the XFS inode cache. It uses
radix trees to index the cache, not the VFS level inode hash. Hence
we could place exceptional entries into the tree on reclaim to do
working set tracking similar to the way the page cache is used to
track the working set of pages.

The other thing we could do here is similar to the dentry cache - we
often have inode metadata buffers in the buffer cache (we have a
multi-level cache heirarchy that spans most of the metadata in the
active working set in XFS) and so if we miss the inode cache we
might hit the inode buffer in the buffer cache (hot fault).  If we
miss the inode cache and have to do IO to read the inodes, then it's
a cold fault.

That might be misleading, however, because the inode buffers cache
32 physical inodes and so reading 32 sequential cold inodes would
give 1 cold fault and 31 hot faults, even though those 31 inodes
have never been referenced by the workload before and that's not
ideal.

To complicate matters further, we can thrash the buffer cache,
resulting in cached inodes that have no backing buffer in memory.
then we we go to write the inode, we have to read in the inode
buffer before we can write it. This may have nothing to do with
working set thrashing, too. e.g. we have an inode that has been
referenced over and over again by the workload for several hours,
then a relatime update occurs and the inode is dirtied. when
writeback occurs, the inode buffer is nowhere to be found because it
was cycled out of the buffer cache hours ago and hasn't been
referenced since. hence I think we're probably best to ignore the
underlying filesystem metadata cache for the purposes of measuring
and detecting inode cache working set thrashing...

> It would help psi, sure, but more importantly it would help us better
> balance pressure between filesystem metadata and the data pages. We
> would be able to tell the difference between a `find /' and actual
> thrashing, where hot inodes are getting kicked out and reloaded
> repeatedly - and we could backfeed that pressure to the LRU pages to
> allow the metadata caches to grow as needed.

Well, hot inodes getting kicked out and immmediate re-used is
something we largely already handle via caching inode buffers in the
buffer cache.  So inode cache misses on XFS likely happen a lot more
than is obvious as we only see inode cache thrashing when we have
misses the metadata cache, not the inode cache.

> For example, it could make sense to swap out a couple of completely
> unused anonymous pages if it means we could hold the metadata
> workingset fully in memory. But right now we cannot do that, because
> we cannot risk swapping just because somebody runs find /.

I have workloads that run find to produce slab cache memory
pressure. On 5.2, they cause the system to swap madly because
there's no file page cache to reclaim and so the only reclaim that
can be done is inodes/dentries and swapping anonymous pages.

And swap it does - if we don't throttle reclaim sufficiently to
allow IO to make progress, then direct relcaim ends up in priority
windup and I see lots of OOM kills on swap-in. I found quite a few
ways to end up in "reclaim doesn't throttle on IO sufficiently and
OOM kills" in the last 3-4 weeks...

> I have semi-seriously talked to Josef about this before, but it wasn't
> quite obvious where we could track non-residency or eviction
> information for inodes, dentries etc. Maybe you have an idea?

See above - I think only XFS could track working inodes because of
it's unique caching infrastructure. Dentries largely don't matter,
because dentry cache misses either hit or miss the inode cache and
that's the working set that largely matters in terms of detecting
IO-related thrashing...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
