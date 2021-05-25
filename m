Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB138FCA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhEYIYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:24:33 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46085 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232315AbhEYIYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:24:18 -0400
Received: from dread.disaster.area (pa49-180-230-185.pa.nsw.optusnet.com.au [49.180.230.185])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5C3AB1043D65;
        Tue, 25 May 2021 18:21:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1llSK1-004zCd-E1; Tue, 25 May 2021 18:21:53 +1000
Date:   Tue, 25 May 2021 18:21:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <20210525082153.GJ2817@dread.disaster.area>
References: <YKcouuVR/y/L4T58@T590>
 <20210521071727.GA11473@lst.de>
 <YKdhuUZBtKMxDpsr@T590>
 <20210521073547.GA11955@lst.de>
 <YKdwtzp+WWQ3krhI@T590>
 <20210521083635.GA15311@lst.de>
 <YKd1VS5gkzQRn+7x@T590>
 <20210524235538.GI2817@dread.disaster.area>
 <YKyDCw430gD6pTBC@T590>
 <YKyZJiY7GySlIsZ7@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKyZJiY7GySlIsZ7@T590>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=dUIOjvib2kB+GiIc1vUx8g==:117 a=dUIOjvib2kB+GiIc1vUx8g==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=8DuwvNAz0v95KENdmnYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 02:28:54PM +0800, Ming Lei wrote:
> On Tue, May 25, 2021 at 12:54:35PM +0800, Ming Lei wrote:
> > On Tue, May 25, 2021 at 09:55:38AM +1000, Dave Chinner wrote:
> > > On Fri, May 21, 2021 at 04:54:45PM +0800, Ming Lei wrote:
> > > > On Fri, May 21, 2021 at 10:36:35AM +0200, Christoph Hellwig wrote:
> > > > > On Fri, May 21, 2021 at 04:35:03PM +0800, Ming Lei wrote:
> > > > > > Just wondering why the ioend isn't submitted out after it becomes full?
> > > > > 
> > > > > block layer plugging?  Although failing bio allocations will kick that,
> > > > > so that is not a deadlock risk.
> > > > 
> > > > These ioends are just added to one list stored on local stack variable(submit_list),
> > > > how can block layer plugging observe & submit them out?
> > > 
> > > We ignore that, as the commit histoy says:
> > > 
> > > commit e10de3723c53378e7cf441529f563c316fdc0dd3
> > > Author: Dave Chinner <dchinner@redhat.com>
> > > Date:   Mon Feb 15 17:23:12 2016 +1100
> > > 
> > >     xfs: don't chain ioends during writepage submission
> > > 
> > >     Currently we can build a long ioend chain during ->writepages that
> > >     gets attached to the writepage context. IO submission only then
> > >     occurs when we finish all the writepage processing. This means we
> > >     can have many ioends allocated and pending, and this violates the
> > >     mempool guarantees that we need to give about forwards progress.
> > >     i.e. we really should only have one ioend being built at a time,
> > >     otherwise we may drain the mempool trying to allocate a new ioend
> > >     and that blocks submission, completion and freeing of ioends that
> > >     are already in progress.
> > > 
> > >     To prevent this situation from happening, we need to submit ioends
> > >     for IO as soon as they are ready for dispatch rather than queuing
> > >     them for later submission. This means the ioends have bios built
> > >     immediately and they get queued on any plug that is current active.
> > >     Hence if we schedule away from writeback, the ioends that have been
> > >     built will make forwards progress due to the plug flushing on
> > >     context switch. This will also prevent context switches from
> > >     creating unnecessary IO submission latency.
> > > 
> > >     We can't completely avoid having nested IO allocation - when we have
> > >     a block size smaller than a page size, we still need to hold the
> > >     ioend submission until after we have marked the current page dirty.
> > >     Hence we may need multiple ioends to be held while the current page
> > >     is completely mapped and made ready for IO dispatch. We cannot avoid
> > >     this problem - the current code already has this ioend chaining
> > >     within a page so we can mostly ignore that it occurs.
> > > 
> > >     Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > >     Reviewed-by: Christoph Hellwig <hch@lst.de>
> > >     Signed-off-by: Dave Chinner <david@fromorbit.com>
> > > 
> > > IOWs, this nesting for block size < page size has been out there
> > > for many years now and we've yet to have anyone report that
> > > writeback deadlocks have occurred.
> > > 
> > > There's a mistake in that commit message - we can't submit the
> > > ioends on a page until we've marked the page as under writeback, not
> > > dirty. That's because we cannot have ioends completing on a a page
> > > that isn't under writeback because calling end_page_writeback() on
> > > it when it isn't under writeback will BUG(). Hence we have to build
> > > all the submission state before we mark the page as under writeback
> > > and perform the submission(s) to avoid completion racing with
> > > submission.
> > > 
> > > Hence we can't actually avoid nesting ioend allocation here within a
> > > single page - the constraints of page cache writeback require it.
> > > Hence the construction of the iomap_ioend_bioset uses a pool size of:
> > > 
> > > 	4 * (PAGE_SIZE / SECTOR_SIZE)
> > > 
> > > So that we always have enough ioends cached in the mempool to
> > > guarantee forwards progress of writeback of any single page under
> > > writeback.
> > 
> > OK, looks it is just for subpage IO, so there isn't such issue
> > in case of multiple ioends.
> 
> Thinking of further, this way is still fragile, suppose there are 8
> contexts in which writeback is working on at the same time, and each
> needs to allocate 6 ioends, so all contexts may not move on when
> allocating its 6th ioend.

Again - the reality is that nobody is reporting deadlocks in
production workloads, and some workloads (like file servers) can be
running hundreds of concurrent IO writeback contexts at the same
time to the same filesystem whilst under heavy memory pressure.

Yes, in theory it can deadlock. In practice? Nobody is reporting
deadlocks, so either the deadlock is so extremely rare we just don't
care about it or the theory is wrong.

Either way, I'll take "works in practice" over "theoretically
perfect" every day of the week. As Linus likes to say: "perfect is
the enemy of good".

> > > But that is a completely separate problem to this:
> > > 
> > > > Chained bios have been submitted already, but all can't be completed/freed
> > > > until the whole ioend is done, that submission won't make forward progress.
> > > 
> > > This is a problem caused by having unbound contiguous ioend sizes,
> > > not a problem caused by chaining bios. We can throw 256 pages into
> > > a bio, so when we are doing huge contiguous IOs, we can map a
> > > lot of sequential dirty pages into a contiguous extent into a very
> > > long bio chain. But if we cap the max ioend size to, say, 4096
> > > pages, then we've effectively capped the number of bios that can be
> > > nested by such a writeback chain.
> > 
> > If the 4096 pages are not continuous, there may be 4096/256=16 bios
> > allocated for single ioend, and one is allocated from iomap_ioend_bioset,
> > another 15 is allocated by bio_alloc() from fs_bio_set which just
> > reserves 2 bios.

Which completely misses the point that bounding the chain length
means we could guarantee forwards progress, simply by increasing the
reservation on the bioset or using a custom bioset with a large
enough reservation.

> > > I was about to point you at the patchset that fixes this, but you've
> > > already found it and are claiming that this nesting is an unfixable
> > > problem. Capping the size of the ioend also bounds the depth of the
> > > allocation nesting that will occur, and that fixes the whole nseting
> > > deadlock problem: If the mempool reserves are deeper than than the
> > > maximum chain nesting that can occur, then there is no deadlock.
> > > 
> > > However, this points out what the real problem here is: that bio
> > > allocation is designed to deadlock when nesting bio allocation rather
> > > than fail. Hence at the iomap level we've go no way of knowing that
> > > we should terminate and submit the current bio chain and start a new
> > > ioend+bio chain because we will hang before there's any indication
> > > that a deadlock could occur.
> > 
> > Most of reservation is small, such as fs_bio_set, so bio_alloc_bioset()
> > documents that 'never allocate more than 1 bio at a time'. Actually
> > iomap_chain_bio() does allocate a new one, then submits the old one.
> > 'fs_bio_set' reserves two bios, so the order(alloc before submit) is fine,
> 
> It may not be fine when more than one context is involved in writeback.

Which brings me back to "theory vs reality". In theory, the
fs_bio_set is shared by all filesytsems and all of them can have
multiple writeback contexts active at the same time all chaining
bios. So even the fs_bio_set doesn't have the reservation space
available to guarantee forwards progress in even slighlty complex
multiple context writeback.

The big assumption in the forwards progress guarantee that mempools
provide is that the no dependencies between bio allocations from the
same bioset. bio chaining is an obvious dependency, but stuff like
concurrent submission, needing to do metadata IO whilst building
bios (i.e delayed allocation), stacked filesystems (e.g. loop
devices) create deep, disconnected nested dependencies between
filesystems, bios and biosets.

Nesting happens. Deep nesting happens. But the evidence is that
systems aren't deadlocking during bio allocation despite what the
theory says.

So rather than telling us "this can't work", how about trying to
find out why it has been working so well for the past 5 years or so?
Maybe we'll all learn something we didn't know about the code in the
process...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
