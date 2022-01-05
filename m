Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF982484C56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 03:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbiAECK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 21:10:28 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55341 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231898AbiAECK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:10:27 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4FC2010A8446;
        Wed,  5 Jan 2022 13:10:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n4vks-00BStI-58; Wed, 05 Jan 2022 13:10:22 +1100
Date:   Wed, 5 Jan 2022 13:10:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220105021022.GL945095@dread.disaster.area>
References: <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
 <20220104215227.GJ945095@dread.disaster.area>
 <20220104231230.GG31606@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104231230.GG31606@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61d4fe12
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=uJAmoYyjuOSHMeoTmPgA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:12:30PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 05, 2022 at 08:52:27AM +1100, Dave Chinner wrote:
> > On Tue, Jan 04, 2022 at 11:22:27AM -0800, Darrick J. Wong wrote:
> > > On Tue, Jan 04, 2022 at 10:14:27AM -0800, hch@infradead.org wrote:
> > > > On Tue, Jan 04, 2022 at 06:08:24PM +0000, Matthew Wilcox wrote:
> > > > > I think it's fine to put in a fix like this now that's readily
> > > > > backportable.  For folios, I can't help but think we want a
> > > > > restructuring to iterate per-extent first, then per-folio and finally
> > > > > per-sector instead of the current model where we iterate per folio,
> > > > > looking up the extent for each sector.
> > > > 
> > > > We don't look up the extent for each sector.  We look up the extent
> > > > once and then add as much of it as we can to the bio until either the
> > > > bio is full or the extent ends.  In the first case we then allocate
> > > > a new bio and add it to the ioend.
> > > 
> > > Can we track the number of folios that have been bio_add_folio'd to the
> > > iomap_ioend, and make iomap_can_add_to_ioend return false when the
> > > number of folios reaches some threshold?  I think that would solve the
> > > problem of overly large ioends while not splitting folios across ioends
> > > unnecessarily.
> > 
> > See my reply to Christoph up thread.
> > 
> > The problem is multiple blocks per page/folio - bio_add_folio() will
> > get called for the same folio many times, and we end up not knowing
> > when a new page/folio is attached. Hence dynamically calculating it
> > as we build the bios is .... convoluted.
> 
> Hm.  Indulge me in a little more frame-shifting for a moment --
> 
> As I see it, the problem here is that we're spending too much time
> calling iomap_finish_page_writeback over and over and over, right?
> 
> If we have a single page with a single mapping that fits in a single
> bio, that means we call bio_add_page once, and on the other end we call
> iomap_finish_page_writeback once.
> 
> If we have (say) an 8-page folio with 4 blocks per page, in the worst
> case we'd create 32 different ioends, each with a single-block bio,
> which means 32 calls to iomap_finish_page_writeback, right?

Yes, but in this case, we've had to issue and complete 32 bios and
ioends to get one call to end_page_writeback(). That is overhead we
cannot avoid if we have worst-case physical fragmentation of the
filesystem. But, quite frankly, if that's the case we just don't
care about performance of IO completion - performance will suck
because we're doing 32 IOs instead of 1 for that data, not because
IO completion has to do more work per page/folio....

> From what I can see, the number of bio_add_folio calls is proportional
> to the amount of ioend work we do without providing any external signs
> of life to the watchdog, right?
> 
> So forget the number of folios or the byte count involved.  Isn't the
> number of future iomap_finish_page_writeback calls exactly the metric
> that we want to decide when to cut off ioend submission?

Isn't that exactly what I suggested by counting bio segments in the
ioend at bio submission time? I mean, iomap_finish_page_writeback()
iterates bio segments, not pages, folios or filesystem blocks....

> > Hence generic iomap code will only end up calling
> > iomap_finish_ioends() with the same ioend that was submitted. i.e.
> > capped to 4096 pages by this patch. THerefore it does not need
> > cond_resched() calls - the place that needs it is where the ioends
> > are merged and then finished. That is, in the filesystem completion
> > processing that does the merging....
> 
> Huh?  I propose adding cond_resched to iomap_finish_ioends (plural),

Which is only called from XFS on merged ioends after XFS has
processed the merged ioend.....

> which walks a list of ioends and calls iomap_finish_ioend (singular) on
> each ioend.  IOWs, we'd call cond_resched in between finishing one ioend
> and starting on the next one.  Isn't that where ioends are finished?
> 
> (I'm starting to wonder if we're talking past each other?)
> 
> So looking at xfs_end_io:
> 
> /* Finish all pending io completions. */
> void
> xfs_end_io(
> 	struct work_struct	*work)
> {
> 	struct xfs_inode	*ip =
> 		container_of(work, struct xfs_inode, i_ioend_work);
> 	struct iomap_ioend	*ioend;
> 	struct list_head	tmp;
> 	unsigned long		flags;
> 
> 	spin_lock_irqsave(&ip->i_ioend_lock, flags);
> 	list_replace_init(&ip->i_ioend_list, &tmp);
> 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
> 
> 	iomap_sort_ioends(&tmp);
> 	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
> 			io_list))) {
> 		list_del_init(&ioend->io_list);
> 
> Here we pull the first ioend off the sorted list of ioends.
> 
> 		iomap_ioend_try_merge(ioend, &tmp);
> 
> Now we've merged that first ioend with as many subsequent ioends as we
> could merge.  Let's say there were 200 ioends, each 100MB.  Now ioend

Ok, so how do we get to this completion state right now?

1. an ioend is a physically contiguous extent so submission is
   broken down into an ioend per physical extent.
2. we merge logically contiguous ioends at completion.

So, if we have 200 ioends of 100MB each that are logically
contiguous we'll currently always merge them into a single 20GB
ioend that gets processed as a single entity even if submission
broke them up because they were physically discontiguous.

Now, with this patch we add:

3. Individual ioends are limited to 16MB.
4. completion can only merge physically contiguous ioends.
5. we cond_resched() between physically contiguous ioend completion.

Submission will break that logically contiguous 20GB dirty range
down into 200x6x16MB ioends.

Now completion will only merge ioends that are both physically and
logically contiguous. That results in a maximum merged ioend chain
size of 100MB at completion. They'll get merged one 100MB chunk at a
time.

> is a chain (of those other 199 ioends) representing 20GB of data.
> 
> 		xfs_end_ioend(ioend);

We now do one conversion transaction for the entire 100MB extent,
then....

> At the end of this routine, we call iomap_finish_ioends on the 20GB
> ioend chain.  This now has to mark 5.2 million pages...

run iomap_finish_ioends() on 100MB of pages, which is about 25,000
pages, not 5 million...

> 		cond_resched();
> 
> ...before we get to the cond_resched.

... and so in this scenario this patch reduces the time between
reschedule events by a factor of 200 - the number of physical
extents the ioends map....

That's kind of my point - we can't ignore why the filesystem needs
merging or how it should optimise merging for it's own purposes in
this discussion. Because logically merged ioends require the
filesystem to do internal loops over physical discontiguities,
requiring us to drive cond_resched() into both the iomap loops and
the lower layer filesystem loops.

i.e. when we have ioend merging based on logical contiguity, we need
to limit the number of the loops the filesystem does internally, not
just the loops that the ioend code is doing...

> I'd really rather do the
> cond_resched between each of those 200 ioends that (supposedly) are
> small enough not to trip the hangcheck timers.
> 
> 	}
> }
> /*
>  * Mark writeback finished on a chain of ioends.  Caller must not call
>  * this function from atomic/softirq context.
>  */
> void
> iomap_finish_ioends(struct iomap_ioend *ioend, int error)
> {
> 	struct list_head tmp;
> 
> 	list_replace_init(&ioend->io_list, &tmp);
> 	iomap_finish_ioend(ioend, error);
> 
> 	while (!list_empty(&tmp)) {
> 		cond_resched();
> 
> So I propose doing it ^^^ here instead.
> 
> 		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
> 		list_del_init(&ioend->io_list);
> 		iomap_finish_ioend(ioend, error);
> 	}
> }

Yes, but this only addresses a single aspect of the issue when
filesystem driven merging is used. That is, we might have just had
to do a long unbroken loop in xfs_end_ioend() that might have to run
conversion of several thousand physical extents that the logically
merged ioends might have covered. Hence even with the above, we'd
still need to add cond_resched() calls to the XFS code. Hence from
an XFS IO completion point of view, we only want to merge to
physical extent boundaries and issue cond_resched() at physical
extent boundaries because that's what our filesystem completion
processing loops on, not pages/folios.

Hence my point that we cannot ignore what the filesystem is doing
with these merged ioends and only think about iomap in isolation.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
