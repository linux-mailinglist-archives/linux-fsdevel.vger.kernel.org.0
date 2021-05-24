Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF05C38F68E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 01:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhEXX5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 19:57:15 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:40035 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhEXX5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 19:57:12 -0400
Received: from dread.disaster.area (pa49-180-237-17.pa.nsw.optusnet.com.au [49.180.237.17])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 4DCF66B337;
        Tue, 25 May 2021 09:55:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1llKQ6-004r2D-NQ; Tue, 25 May 2021 09:55:38 +1000
Date:   Tue, 25 May 2021 09:55:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <20210524235538.GI2817@dread.disaster.area>
References: <YKcouuVR/y/L4T58@T590>
 <20210521071727.GA11473@lst.de>
 <YKdhuUZBtKMxDpsr@T590>
 <20210521073547.GA11955@lst.de>
 <YKdwtzp+WWQ3krhI@T590>
 <20210521083635.GA15311@lst.de>
 <YKd1VS5gkzQRn+7x@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKd1VS5gkzQRn+7x@T590>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=oWiKotyBKwPJNwc9RtRBNA==:117 a=oWiKotyBKwPJNwc9RtRBNA==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=--ljmbci5Jw-3h57E20A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 04:54:45PM +0800, Ming Lei wrote:
> On Fri, May 21, 2021 at 10:36:35AM +0200, Christoph Hellwig wrote:
> > On Fri, May 21, 2021 at 04:35:03PM +0800, Ming Lei wrote:
> > > Just wondering why the ioend isn't submitted out after it becomes full?
> > 
> > block layer plugging?  Although failing bio allocations will kick that,
> > so that is not a deadlock risk.
> 
> These ioends are just added to one list stored on local stack variable(submit_list),
> how can block layer plugging observe & submit them out?

We ignore that, as the commit histoy says:

commit e10de3723c53378e7cf441529f563c316fdc0dd3
Author: Dave Chinner <dchinner@redhat.com>
Date:   Mon Feb 15 17:23:12 2016 +1100

    xfs: don't chain ioends during writepage submission

    Currently we can build a long ioend chain during ->writepages that
    gets attached to the writepage context. IO submission only then
    occurs when we finish all the writepage processing. This means we
    can have many ioends allocated and pending, and this violates the
    mempool guarantees that we need to give about forwards progress.
    i.e. we really should only have one ioend being built at a time,
    otherwise we may drain the mempool trying to allocate a new ioend
    and that blocks submission, completion and freeing of ioends that
    are already in progress.

    To prevent this situation from happening, we need to submit ioends
    for IO as soon as they are ready for dispatch rather than queuing
    them for later submission. This means the ioends have bios built
    immediately and they get queued on any plug that is current active.
    Hence if we schedule away from writeback, the ioends that have been
    built will make forwards progress due to the plug flushing on
    context switch. This will also prevent context switches from
    creating unnecessary IO submission latency.

    We can't completely avoid having nested IO allocation - when we have
    a block size smaller than a page size, we still need to hold the
    ioend submission until after we have marked the current page dirty.
    Hence we may need multiple ioends to be held while the current page
    is completely mapped and made ready for IO dispatch. We cannot avoid
    this problem - the current code already has this ioend chaining
    within a page so we can mostly ignore that it occurs.

    Signed-off-by: Dave Chinner <dchinner@redhat.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Dave Chinner <david@fromorbit.com>

IOWs, this nesting for block size < page size has been out there
for many years now and we've yet to have anyone report that
writeback deadlocks have occurred.

There's a mistake in that commit message - we can't submit the
ioends on a page until we've marked the page as under writeback, not
dirty. That's because we cannot have ioends completing on a a page
that isn't under writeback because calling end_page_writeback() on
it when it isn't under writeback will BUG(). Hence we have to build
all the submission state before we mark the page as under writeback
and perform the submission(s) to avoid completion racing with
submission.

Hence we can't actually avoid nesting ioend allocation here within a
single page - the constraints of page cache writeback require it.
Hence the construction of the iomap_ioend_bioset uses a pool size of:

	4 * (PAGE_SIZE / SECTOR_SIZE)

So that we always have enough ioends cached in the mempool to
guarantee forwards progress of writeback of any single page under
writeback.

But that is a completely separate problem to this:

> Chained bios have been submitted already, but all can't be completed/freed
> until the whole ioend is done, that submission won't make forward progress.

This is a problem caused by having unbound contiguous ioend sizes,
not a problem caused by chaining bios. We can throw 256 pages into
a bio, so when we are doing huge contiguous IOs, we can map a
lot of sequential dirty pages into a contiguous extent into a very
long bio chain. But if we cap the max ioend size to, say, 4096
pages, then we've effectively capped the number of bios that can be
nested by such a writeback chain.

I was about to point you at the patchset that fixes this, but you've
already found it and are claiming that this nesting is an unfixable
problem. Capping the size of the ioend also bounds the depth of the
allocation nesting that will occur, and that fixes the whole nseting
deadlock problem: If the mempool reserves are deeper than than the
maximum chain nesting that can occur, then there is no deadlock.

However, this points out what the real problem here is: that bio
allocation is designed to deadlock when nesting bio allocation rather
than fail. Hence at the iomap level we've go no way of knowing that
we should terminate and submit the current bio chain and start a new
ioend+bio chain because we will hang before there's any indication
that a deadlock could occur.

And then the elephant in the room: reality.

We've been nesting bio allocations via this chaining in production
systems under heavy memory pressure for 5 years now and we don't
have a single bug report indicating that this code deadlocks. So
while there's a theoretical problem, evidence points to it not being
an issue in practice.

Hence I don't think there is any need to urgently turn this code
upside down. I'd much prefer that bio allocation would fail rather
than deadlock, because then we can set a flag in the writepage
context that says "do single bio ioend submission only" for the
duration of that writeback context. And with that, the forwards
progress problem is solved whilst still allowing us to chain as
deeply as we want when there is no memory pressure....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
