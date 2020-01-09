Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F713638A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgAIXAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:00:55 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36906 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgAIXAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:00:55 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2C1713A2514;
        Fri, 10 Jan 2020 10:00:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ipgnD-0006Po-Kh; Fri, 10 Jan 2020 10:00:43 +1100
Date:   Fri, 10 Jan 2020 10:00:43 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200109230043.GS23195@dread.disaster.area>
References: <20191231125908.GD6788@bombadil.infradead.org>
 <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area>
 <20200109110751.GF27035@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109110751.GF27035@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=7NUmg-gWyWJ-mk-1jyYA:9
        a=cHm1g4NX5QZt850k:21 a=Qy9puI25PZ6SXe2p:21 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:07:51PM +0100, Jan Kara wrote:
> On Tue 07-01-20 10:21:00, Dave Chinner wrote:
> > On Mon, Jan 06, 2020 at 12:55:14PM +0100, Michal Hocko wrote:
> > > On Tue 31-12-19 04:59:08, Matthew Wilcox wrote:
> > > > 
> > > > I don't want to present this topic; I merely noticed the problem.
> > > > I nominate Jens Axboe and Michael Hocko as session leaders.  See the
> > > > thread here:
> > > 
> > > Thanks for bringing this up Matthew! The change in the behavior came as
> > > a surprise to me. I can lead the session for the MM side.
> > > 
> > > > https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
> > > > 
> > > > Summary: Congestion is broken and has been for years, and everybody's
> > > > system is sleeping waiting for congestion that will never clear.
> > > > 
> > > > A good outcome for this meeting would be:
> > > > 
> > > >  - MM defines what information they want from the block stack.
> > > 
> > > The history of the congestion waiting is kinda hairy but I will try to
> > > summarize expectations we used to have and we can discuss how much of
> > > that has been real and what followed up as a cargo cult. Maybe we just
> > > find out that we do not need functionality like that anymore. I believe
> > > Mel would be a great contributor to the discussion.
> > 
> > We most definitely do need some form of reclaim throttling based on
> > IO congestion, because it is trivial to drive the system into swap
> > storms and OOM killer invocation when there are large dirty slab
> > caches that require IO to make reclaim progress and there's little
> > in the way of page cache to reclaim.
> 
> Agreed, but I guess the question is how do we implement that in a reliable
> fashion? More on that below...
....
> > Hence it seems to me that having IO load feedback to the memory
> > reclaim algorithms is most definitely required for memory reclaim to
> > be able to make the correct decisions about what to reclaim. If the
> > shrinker for the cache that uses 50% of RAM in the machine is saying
> > "backoff needed" and it's underlying device is
> > congested and limiting object reclaim rates, then it's a pretty good
> > indication that reclaim should back off and wait for IO progress to
> > be made instead of trying to reclaim from other LRUs that hold an
> > insignificant amount of memory compared to the huge cache that is
> > backed up waiting on IO completion to make progress....
> 
> Yes and I think here's the key detail: Reclaim really needs to wait for
> slab object cleaning to progress so that slab cache can be shrinked.  This
> is related, but not always in a straightforward way, with IO progress and
> even less with IO congestion on some device. I can easily imagine that e.g.
> cleaning of inodes to reclaim inode slab may not be efficient enough to
> utilize full paralelism of a fast storage so the storage will not ever
> become congested

XFS can currently write back inodes at several hundred MB/s if the
underlying storage is capable of sustaining that. i.e. it can drive
hundreds of thousands of metadata IOPS if the underlying storage can
handle that. With the non-blocking reclaim mods, it's all async
writeback, so at least for XFS we will be able to drive fast devices
into congestion.

> - sure it's an inefficiency that could be fixed but should
> it misguide reclaim?

The problem is that even cleaning inodes at this rate, I can't get
reclaim to actually do the right thing. Reclaim is already going
wrong for really fast devices..

> I don't think so... So I think that to solve this
> problem in a robust way, we need to provide a mechanism for slab shrinkers
> to say something like "hang on, I can reclaim X objects you asked for but
> it will take time, I'll signal to you when they are reclaimable". This way
> we avoid blocking in the shrinker and can do more efficient async batched
> reclaim and on mm side we have the freedom to either wait for slab reclaim
> to progress (if this slab is fundamental to memory pressure) or just go try
> reclaim something else. Of course, the devil is in the details :).

That's pretty much exactly what my non-blocking XFS inode reclaim
patches do. It tries to scan, but when it can't make progress it
sets a "need backoff" flag and defers the remaining work and expects
the high level code to make a sensible back-off decision.

The problem is that the decision the high level code makes at the
moment is not sensible - it is "back off for a bit, then increase
the reclaim priority and reclaim from the page cache again. That;s
what is driving the swap storms - inode reclaim says "back-off" and
stops trying to do reclaim, and that causes the high level code to
reclaim the page cache harder.

OTOH, if we *block in the inode shrinker* as we do now, then we
don't increase reclaim priority (and hence the amount of page cache
scanning) and so the reclaim algorithms don't drive deeply into
swap-storm conditions.

That's the fundamental problem here - we need to throttle reclaim
without *needing to restart the entire high level reclaim loop*.
This is an architecture problem more than anything - node and memcg
aware shrinkers outnumber the page cache LRU zones by a large
number, but we can't throttle on individual shrinkers and wait for
them to make progress like we can individual page LRU zone lists.
Hence if we want to throttle an individual shrinker, the *only
reliable option* we currently have is for the shrinker to block
itself.

I note that we handle similar "need more individual work" conditions
in other writeback situations. e.g. the BDI has a "b_more_io" list
to park inodes that require more writeback than a single pass. This
allows writeback to *fairly* revisit inodes that require large
amounts of writeback to do more writeback without needing to start a
whole new BDI dirty inode writeback pass.

I suspect that this is the sort of thing we need for reclaim - we
need to park shrinker instances that needed backoff onto a "need
more reclaim" list that we continue to iterate and back-off on until
we've done the reclaim work that this specific reclaim priority pass
required us to do.

And, realistically, to make this all work in a consistent manner,
the zone LRU walkers really should be transitioned to run as shrinker
instances that are node and memcg aware, and so they do individual
backoff and throttling in the same manner that large slab caches do.
This way we end up with an integrated, consistent high level reclaim
management architecture that automatically balances page cache vs
slab cache reclaim balance...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
