Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3876B154F53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 00:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgBFXTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 18:19:38 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59560 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBFXTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:19:38 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CC86A43FC90;
        Fri,  7 Feb 2020 10:19:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1izqQi-0006T3-CC; Fri, 07 Feb 2020 10:19:28 +1100
Date:   Fri, 7 Feb 2020 10:19:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200206231928.GA21953@dread.disaster.area>
References: <20191231125908.GD6788@bombadil.infradead.org>
 <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area>
 <20200109110751.GF27035@quack2.suse.cz>
 <20200109230043.GS23195@dread.disaster.area>
 <20200205160551.GI3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205160551.GI3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=4pT8fvi3S_HZPPAHfQYA:9 a=O9jS6mhRQeBvtLDA:21
        a=i43f7ykdj1vAvfeC:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 04:05:51PM +0000, Mel Gorman wrote:
> This thread is ancient but I'm only getting to it now, to express an
> interest in the general discussion as much as anything else.
> 
> On Fri, Jan 10, 2020 at 10:00:43AM +1100, Dave Chinner wrote:
> > > I don't think so... So I think that to solve this
> > > problem in a robust way, we need to provide a mechanism for slab shrinkers
> > > to say something like "hang on, I can reclaim X objects you asked for but
> > > it will take time, I'll signal to you when they are reclaimable". This way
> > > we avoid blocking in the shrinker and can do more efficient async batched
> > > reclaim and on mm side we have the freedom to either wait for slab reclaim
> > > to progress (if this slab is fundamental to memory pressure) or just go try
> > > reclaim something else. Of course, the devil is in the details :).
> > 
> > That's pretty much exactly what my non-blocking XFS inode reclaim
> > patches do. It tries to scan, but when it can't make progress it
> > sets a "need backoff" flag and defers the remaining work and expects
> > the high level code to make a sensible back-off decision.
> > 
> > The problem is that the decision the high level code makes at the
> > moment is not sensible - it is "back off for a bit, then increase
> > the reclaim priority and reclaim from the page cache again. That;s
> > what is driving the swap storms - inode reclaim says "back-off" and
> > stops trying to do reclaim, and that causes the high level code to
> > reclaim the page cache harder.
> > 
> > OTOH, if we *block in the inode shrinker* as we do now, then we
> > don't increase reclaim priority (and hence the amount of page cache
> > scanning) and so the reclaim algorithms don't drive deeply into
> > swap-storm conditions.
> > 
> > That's the fundamental problem here - we need to throttle reclaim
> > without *needing to restart the entire high level reclaim loop*.
> > This is an architecture problem more than anything - node and memcg
> > aware shrinkers outnumber the page cache LRU zones by a large
> > number, but we can't throttle on individual shrinkers and wait for
> > them to make progress like we can individual page LRU zone lists.
> > Hence if we want to throttle an individual shrinker, the *only
> > reliable option* we currently have is for the shrinker to block
> > itself.
> > 
> 
> Despite the topic name, I learning towards thinking that this is not a
> congestion issue as such. The throttling mechanism based on BDI partially
> solved old problems of swap storm, direct relaim issued writeback
> (historical) or excessive scanning leading to premature OOM kill. When
> reclaim stopped issuing waiting on writeback it had to rely on congestion
> control instead and it always was a bit fragile but mostly worked until
> hardware moved on, storage got faster, memories got larger, or did
> something crazy like buy a second disk.

That's because the code didn't evolve with the changing capabilities
of the hardware. Nobody cared because it "mostly worked" and then
when it didn't they worked around it in other ways. e.g. the block
layer writeback throttle largely throttles swap storms by limiting
the amount of swap IO memory reclaim can issue. THe issue is that it
doesn't prevent swap storms, just moves them "back out of sight" so
no-one cares that about them much again...

> The  commonmreason that stalling would occur is because large amounts of
> dirty/writeback pages were encountered at the tail of the LRU leading to
> large amounts of CPU time spent on useless scanning and increasing scan
> rates until OOM occurred. It never took into account any other factor
> like shrinker state.
> 
> But fundamentally what gets a process into trouble is when "reclaim
> efficiency" drops. Efficiency is the ratio between reclaim scan and
> reclaim steal with perfect efficiency being one page scanned results in
> one page reclaimed. As long as reclaim efficiency is perfect, a system
> may be thrashing but it's not stalling on writeback. It may still be
> stalling on read but that tends to be less harmful.
> 
> Blocking on "congestion" caught one very bad condition where efficiency
> drops -- excessive dirty/writeback pages on the tail of the file LRU. It
> happened to be a common condition such as if a USB stick was being written
> but not the only one. When it happened, excessive clean file pages would
> be taken, swap storms occur and the system thrashes while the dirty
> pages are being cleaned.
> 
> In roughly in order of severity the most relevant causes of efficiency
> drops that come to mind are
> 
> o page is unevictable due to mlock (goes to separate list)
> o page is accessed and gets activated
> o THP has to be split and does another lap through the LRU
> o page could not be unmapped (probably heavily shared and should be
>   activated anyway)
> o page is dirty/writeback and goes back on the LRU
> o page has associated buffers that cannot be freed

One of the issues I see here is the focus on the congestion problem
entirely form the point of view of page reclaim. What I tried to
point out above is that we have *all* the same issues with inode
reclaim in the shrinker.

The common reason for stalling inode reclaim is large amounts of
dirty/writeback inodes on the tail of the LRU.

Inode reclaim efficiency drops occur because:

o All LRUs are currently performing reclaim scans, so new direct
  scans only cause lock and/or IO contention rather than increase scan
  rates.
o inode is unevictable because it is currently pinned by the journal
o inode has been referenced and activated, so gets skipped
o inode is locked, so does another lap through the LRU
o inode is dirty/writeback, so does another lap of the LRU

IOWs shrinkers have exactly the same problems as the page LRU
reclaim. This is why I'm advocating for this problem to be solved in
a generic manner, not as a solution focussed entirely around the
requirements of page reclaim.

> While I'm nowhere near having enough time to write a prototype, I think
> it could be throttle reclaim based on recent allocation rate and the
> contributors to poor reclaim efficiency.
> 
> Recent allocation rate is appropriate because processes dirtying memory
> should get caught in balance_dirty_page. It's only heavy allocators that
> can drive excessive reclaim for multiple unrelated processes. So first,
> try and keep a rough track of the recent allocation rate or maybe just
> something like the number of consecutive allocations that entered the
> slow path due to a low watermark failure.

Inode dirtying is throttled by the filesystem journal space, which
has nothing really to do with memory pressure. And inode allocation
isn't throttled in any way at all, except by memory reclaim when
there is memory pressure.

That's the underlying reason that we've traditionally had to
throttle reclaim under heavy inode allocation pressure - blocking
reclaim on "congestion" in the inode shrinker caught this very bad
condition where efficiency drops off a cliff....

Hence a solution that relies on measuring recent allocation rate
needs to first add all that infrastructure for every shrinker that
does allocation. A solution that only works for the page LRU
infrastructure is not a viable solution to the problems being raised
here.

> Once a task enters direct reclaim, track the reasons for poor reclaim
> efficiency (like the list above but maybe add shrinkers) and calculate a
> score based on weight. An accessed page would have a light weight, a dirty
> page would have a heavy weight. Shrinkers could apply some unknown weight
> but I don't know what might be sensible or what the relative weighting
> would be.

I'm not sure what a weighting might acheive given we might be
scanning millions of objects (we can have hundreds of millions of
cached inodes on the LRUs). An aggregated weight does not indicate
whether we skipped lots of referenced clean inode that would
otherwise be trivial to reclaim, or we skipped a smaller amount of
dirty inodes that will take a *long time* to reclaim because they
require IO....

> If direct reclaim should continue for another loop, wait on a per-node
> waitqueue until kswapd frees pages above the high watermark or a
> timeout. The length of the timeout would depend on how heavy an allocator
> the process is and the reasons why reclaim efficiency was dropping. The
> timeout costs should accumulate while a task remains in direct reclaim
> to limit the chance that an unrelated process is punished.
> 
> It's all hand-waving but I think this would be enough to detect a heavy
> allocator encountering lots of dirty pages at the tail of the LRU at high
> frequency without relying on BDI congestion detection. The downside is if
> the system really is thrashing then a light allocator can become a heavy
> allocator because it's trying to read itself from swap or fetch hot data.

But detecting an abundance dirty pages/inodes on the LRU doesn't
really solve the problem of determining if and/or how long we should
wait for IO before we try to free more objects. There is no problem
with having lots of dirty pages/inodes on the LRU as long as the IO
subsystem keeps up with the rate at which reclaim is asking them to
be written back via async mechanisms (bdi writeback, metadata
writeback, etc).

The problem comes when we cannot make efficient progress cleaning
pages/inodes on the LRU because the IO subsystem is overloaded and
cannot clean pages/inodes any faster. At this point, we have to wait
for the IO subsystem to make progress and without feedback from the
IO subsystem, we have no idea how fast that progress is made. Hence
we have no idea how long we need to wait before trying to reclaim
again. i.e. the answer can be different depending on hardware
behaviour, not just the current instantaneous reclaim and IO state.

That's the fundamental problem we need to solve, and realistically
it can only be done with some level of feedback from the IO
subsystem.

I'd be quite happy to attach a BDI to the reclaim feedback
structure and tell the high level code "wait on this bdi for X
completions or X milliseconds" rather than the current global "any
BDI that completes an IO and is not congested breaks waiters out of
congestion_wait".  This would also solve the problem of
wait_iff_congested() waiting on any congested BDI (or being woken by
any uncongested BDI) rather than the actual BDI the shrinker is
operating/waiting on.

Further, we can actually refine this by connecting the memcg the
object belongs to to the blk_cgroup that the object is cleaned
through (e.g.  wb_get_lookup()) from inside reclaim.  Hence we
should be able to determine if the blkcg that backs the memcg we are
reclaiming from is slow because it is being throttled, even though
the backing device itself is not congested. IOWs, we will not block
memcg reclaim on IO congestion caused by other memcgs....

> > And, realistically, to make this all work in a consistent manner,
> > the zone LRU walkers really should be transitioned to run as shrinker
> > instances that are node and memcg aware, and so they do individual
> > backoff and throttling in the same manner that large slab caches do.
> > This way we end up with an integrated, consistent high level reclaim
> > management architecture that automatically balances page cache vs
> > slab cache reclaim balance...
> 
> That'd probably make more sense but I don't think it would be mandatory
> to get some basic replacement for wait_iff_congested working.

Sure, that's the near term issue, but long term it jsut makes no
sense to treat shrinker relcaim differently from page reclaim
because they have all the same requirements for IO backoff feedback
and control.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
