Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2F40A670
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhINGGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 02:06:44 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48644 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239812AbhINGGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:06:40 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 74FF288194E;
        Tue, 14 Sep 2021 16:05:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mQ1ZH-00CH3R-CT; Tue, 14 Sep 2021 16:05:19 +1000
Date:   Tue, 14 Sep 2021 16:05:19 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] XFS: remove congestion_wait() loop from kmem_alloc()
Message-ID: <20210914060519.GJ2361455@dread.disaster.area>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838439.13293.5032214643474179966.stgit@noble.brown>
 <20210914013117.GG2361455@dread.disaster.area>
 <163159005180.3992.2350725240228509854@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163159005180.3992.2350725240228509854@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=8gt0TS_iLB6qLJAy30IA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 01:27:31PM +1000, NeilBrown wrote:
> On Tue, 14 Sep 2021, Dave Chinner wrote:
> > On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > > Documentation commment in gfp.h discourages indefinite retry loops on
> > > ENOMEM and says of __GFP_NOFAIL that it
> > > 
> > >     is definitely preferable to use the flag rather than opencode
> > >     endless loop around allocator.
> > > 
> > > So remove the loop, instead specifying __GFP_NOFAIL if KM_MAYFAIL was
> > > not given.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/xfs/kmem.c |   16 ++++------------
> > >  1 file changed, 4 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> > > index 6f49bf39183c..f545f3633f88 100644
> > > --- a/fs/xfs/kmem.c
> > > +++ b/fs/xfs/kmem.c
> > > @@ -13,19 +13,11 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
> > >  {
> > >  	int	retries = 0;
> > >  	gfp_t	lflags = kmem_flags_convert(flags);
> > > -	void	*ptr;
> > >  
> > >  	trace_kmem_alloc(size, flags, _RET_IP_);
> > >  
> > > -	do {
> > > -		ptr = kmalloc(size, lflags);
> > > -		if (ptr || (flags & KM_MAYFAIL))
> > > -			return ptr;
> > > -		if (!(++retries % 100))
> > > -			xfs_err(NULL,
> > > -	"%s(%u) possible memory allocation deadlock size %u in %s (mode:0x%x)",
> > > -				current->comm, current->pid,
> > > -				(unsigned int)size, __func__, lflags);
> > > -		congestion_wait(BLK_RW_ASYNC, HZ/50);
> > > -	} while (1);
> > > +	if (!(flags & KM_MAYFAIL))
> > > +		lflags |= __GFP_NOFAIL;
> > > +
> > > +	return kmalloc(size, lflags);
> > >  }
> > 
> > Which means we no longer get warnings about memory allocation
> > failing - kmem_flags_convert() sets __GFP_NOWARN for all allocations
> > in this loop. Hence we'll now get silent deadlocks through this code
> > instead of getting warnings that memory allocation is failing
> > repeatedly.
> 
> Yes, that is a problem.  Could we just clear __GFP_NOWARN when setting
> __GFP_NOFAIL?

Probably.

> Or is the 1-in-100 important? I think default warning is 1 every 10
> seconds.

1-in-100 is an arbitrary number to prevent spamming of logs unless
there is a real likelihood of there being a memory allocation
deadlock. We've typically only ever seen this when trying to do
high-order allocations (e.g. 64kB for xattr buffers) and failing
repeatedly in extreme memory pressure events. It's a canary that we
leave in the logs so that when a user reports problems we know that
they've been running under extended extreme low memory conditions
and can adjust the triage process accordingly.

So, we could remove __GFP_NOWARN, as long as the core allocator code
has sufficient rate limiting that it won't spam the logs due to
extended failure looping...

> > I also wonder about changing the backoff behaviour here (it's a 20ms
> > wait right now because there are not early wakeups) will affect the
> > behaviour, as __GFP_NOFAIL won't wait for that extra time between
> > allocation attempts....
> 
> The internal backoff is 100ms if there is much pending writeout, and
> there are 16 internal retries.  If there is not much pending writeout, I
> think it just loops with cond_resched().
> So adding 20ms can only be at all interesting when the only way to
> reclaim memory is something other than writeout.  I don't know how to
> think about that.

Any cache that uses a shrinker to reclaim (e.g. dentry, inodes, fs
metadata, etc due to recursive directory traversals) can cause
reclaim looping and priority escalation without there being any page
cache writeback or reclaim possible. Especially when you have
GFP_NOFS allocation context and all your memory is in VFS level
caches. At that point, direct reclaim cannot (and will not) make
forwards progress, so we still have to wait for some other
GFP_KERNEL context reclaim (e.g. kswapd) to make progress reclaiming
memory while we wait.

Fundamentally, the memory reclaim backoff code doesn't play well
with shrinkers. Patches from an old patchset which pushed lack of
shrinker progress back up into the vmscan level backoff algorithms
was something I was experimenting with a few years ago. e.g.

https://lore.kernel.org/linux-xfs/20191031234618.15403-16-david@fromorbit.com/
https://lore.kernel.org/linux-xfs/20191031234618.15403-17-david@fromorbit.com/

We didn't end up going this way to solve the XFS inode reclaim
problems - I ended up solving that entirely by pinning XFS buffer
cache memory and modifying the XFS inode shrinker - but it was this
patchset that first exposed the fact that congestion_wait() was no
longer functioning as intended. See the last few paragraphs of the
(long) cover letter for v1 of that patchset here:

https://lore.kernel.org/linux-xfs/20190801021752.4986-1-david@fromorbit.com/

So, yeah, I know full well that congestion_wait() is mostly just
an unconditional timeout these days...

> > And, of course, how did you test this? Sometimes we see
> > unpredicted behaviours as a result of "simple" changes like this
> > under low memory conditions...
> 
> I suspect this is close to untestable.  While I accept that there might
> be a scenario where the change might cause some macro effect, it would
> most likely be some interplay with some other subsystem struggling with
> memory.  Testing XFS by itself would be unlikely to find it.

Filesystem traversal workloads (e.g. chown -R) are the ones that
hammer memory allocation from GFP_NOFS context which creates memory
pressure that cannot be balanced by direct reclaim as direct reclaim
cannot reclaim filesystem caches in this situation. This is where I
would expect extra backoff on failing GFP_NOFS allocations to have
some effect...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
