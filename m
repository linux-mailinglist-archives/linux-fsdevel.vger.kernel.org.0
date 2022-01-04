Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F617484B19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 00:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiADXMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 18:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiADXMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:12:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D6AC061761;
        Tue,  4 Jan 2022 15:12:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AAFEB8180E;
        Tue,  4 Jan 2022 23:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA60C36AEB;
        Tue,  4 Jan 2022 23:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641337950;
        bh=Yf6MofU3n/PJrCEzTDimDv1eEr90cfnJFcWJcjgoozk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnjIAMi78qiDFJ9t84AF9Nr7ZTFz416wrXcOAVq87s/Vnnbr21SWJHmWo0eEHETr4
         xN6MGv7ZAOocGG9+12XjmSznzziF6LR6OTBumC/fntKlTqjYf9i2E+W0JM5GyjmQZ2
         a9qbTtDXeOK6RwZeK1lby2FfBPbu3Rn4ByoP9vacUUwhvEUHfggctx/cFuj1dJ7gpb
         K20WYVHGJwBMpwLtN0D5XDclEGB2yd6xs2TchDHCVSXEwqJCUhOdiEzeYz55Gua3Nj
         E2tr3MyyucjGAHiNqDY5lMEnMI/hG8T285vlocx8Dkwwk07DWI+F9lgPNSPVzO3aGa
         poO/51zSVjAlA==
Date:   Tue, 4 Jan 2022 15:12:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220104231230.GG31606@magnolia>
References: <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
 <20220104215227.GJ945095@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104215227.GJ945095@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:52:27AM +1100, Dave Chinner wrote:
> On Tue, Jan 04, 2022 at 11:22:27AM -0800, Darrick J. Wong wrote:
> > On Tue, Jan 04, 2022 at 10:14:27AM -0800, hch@infradead.org wrote:
> > > On Tue, Jan 04, 2022 at 06:08:24PM +0000, Matthew Wilcox wrote:
> > > > I think it's fine to put in a fix like this now that's readily
> > > > backportable.  For folios, I can't help but think we want a
> > > > restructuring to iterate per-extent first, then per-folio and finally
> > > > per-sector instead of the current model where we iterate per folio,
> > > > looking up the extent for each sector.
> > > 
> > > We don't look up the extent for each sector.  We look up the extent
> > > once and then add as much of it as we can to the bio until either the
> > > bio is full or the extent ends.  In the first case we then allocate
> > > a new bio and add it to the ioend.
> > 
> > Can we track the number of folios that have been bio_add_folio'd to the
> > iomap_ioend, and make iomap_can_add_to_ioend return false when the
> > number of folios reaches some threshold?  I think that would solve the
> > problem of overly large ioends while not splitting folios across ioends
> > unnecessarily.
> 
> See my reply to Christoph up thread.
> 
> The problem is multiple blocks per page/folio - bio_add_folio() will
> get called for the same folio many times, and we end up not knowing
> when a new page/folio is attached. Hence dynamically calculating it
> as we build the bios is .... convoluted.

Hm.  Indulge me in a little more frame-shifting for a moment --

As I see it, the problem here is that we're spending too much time
calling iomap_finish_page_writeback over and over and over, right?

If we have a single page with a single mapping that fits in a single
bio, that means we call bio_add_page once, and on the other end we call
iomap_finish_page_writeback once.

If we have (say) an 8-page folio with 4 blocks per page, in the worst
case we'd create 32 different ioends, each with a single-block bio,
which means 32 calls to iomap_finish_page_writeback, right?

From what I can see, the number of bio_add_folio calls is proportional
to the amount of ioend work we do without providing any external signs
of life to the watchdog, right?

So forget the number of folios or the byte count involved.  Isn't the
number of future iomap_finish_page_writeback calls exactly the metric
that we want to decide when to cut off ioend submission?

That was what I was getting at this morning; too bad the description I
came up with made it sound like I wanted to count actual folios, not
solely the calls to bio_add_folio.

> Alternatively, we could ask the bio how many segments it has
> attached before we switch it out (or submit it) and add that to the
> ioend count. THat's probably the least invasive way of doing this,
> as we already have wrapper functions for chaining and submitting
> bios on ioends....
> 
> > As for where to put a cond_resched() call, I think we'd need to change
> > iomap_ioend_can_merge to avoid merging two ioends if their folio count
> > exceeds the same(?) threshold,
> 
> That I'm not so sure about. If the ioends are physically contiguous,
> we do *much less* CPU work by doing a single merged extent
> conversion transaction than doing one transaction per unmerged
> ioend. i.e. we save a lot of completion CPU time by merging
> physically contiguous ioends, but we save none by merging physically
> discontiguous ioends.
> 
> Yes, I can see that we probably still want to limit the ultimate
> size of the merged, physically contiguous ioend, but I don't think
> it's anywhere near as small as the IO submission sized chunks need
> to be.

Good point.  Yes, higher limits for the merging makes sense.

> > and then one could put the cond_resched
> > after each iomap_finish_ioend call in iomap_finish_ioends, and declare
> > that iomap_finish_ioends cannot be called from atomic context.
> 
> iomap does not do ioend merging by itself. The filesystem decides if
> merging is to be done - only XFS calls iomap_ioend_try_merge() right
> now, so it's the only filesystem that uses completion merging.

I know, I remember that code.

> Hence generic iomap code will only end up calling
> iomap_finish_ioends() with the same ioend that was submitted. i.e.
> capped to 4096 pages by this patch. THerefore it does not need
> cond_resched() calls - the place that needs it is where the ioends
> are merged and then finished. That is, in the filesystem completion
> processing that does the merging....

Huh?  I propose adding cond_resched to iomap_finish_ioends (plural),
which walks a list of ioends and calls iomap_finish_ioend (singular) on
each ioend.  IOWs, we'd call cond_resched in between finishing one ioend
and starting on the next one.  Isn't that where ioends are finished?

(I'm starting to wonder if we're talking past each other?)

So looking at xfs_end_io:

/* Finish all pending io completions. */
void
xfs_end_io(
	struct work_struct	*work)
{
	struct xfs_inode	*ip =
		container_of(work, struct xfs_inode, i_ioend_work);
	struct iomap_ioend	*ioend;
	struct list_head	tmp;
	unsigned long		flags;

	spin_lock_irqsave(&ip->i_ioend_lock, flags);
	list_replace_init(&ip->i_ioend_list, &tmp);
	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);

	iomap_sort_ioends(&tmp);
	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
			io_list))) {
		list_del_init(&ioend->io_list);

Here we pull the first ioend off the sorted list of ioends.

		iomap_ioend_try_merge(ioend, &tmp);

Now we've merged that first ioend with as many subsequent ioends as we
could merge.  Let's say there were 200 ioends, each 100MB.  Now ioend
is a chain (of those other 199 ioends) representing 20GB of data.

		xfs_end_ioend(ioend);

At the end of this routine, we call iomap_finish_ioends on the 20GB
ioend chain.  This now has to mark 5.2 million pages...

		cond_resched();

...before we get to the cond_resched.  I'd really rather do the
cond_resched between each of those 200 ioends that (supposedly) are
small enough not to trip the hangcheck timers.

	}
}
/*
 * Mark writeback finished on a chain of ioends.  Caller must not call
 * this function from atomic/softirq context.
 */
void
iomap_finish_ioends(struct iomap_ioend *ioend, int error)
{
	struct list_head tmp;

	list_replace_init(&ioend->io_list, &tmp);
	iomap_finish_ioend(ioend, error);

	while (!list_empty(&tmp)) {
		cond_resched();

So I propose doing it ^^^ here instead.

		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
		list_del_init(&ioend->io_list);
		iomap_finish_ioend(ioend, error);
	}
}


> > I forget if anyone ever benchmarked the actual overhead of cond_resched,
> > but if my dim memory serves, it's not cheap but also not expensive.
> 
> The overhead is noise if called once per ioend.
> 
> > Limiting each ioend to (say) 16k folios and not letting small ioends
> > merge into something bigger than that for the completion seems (to me
> > anyway) a balance between stalling out on marking pages after huge IOs
> > vs. losing the ability to coalesce xfs_end_ioend calls when a contiguous
> > range of file range has been written back but the backing isn't.
> 
> Remember, we only end up in xfs_end_ioend() for COW, unwritten
> conversion or extending the file. For pure overwrites, we already
> go through the generic iomap_writepage_end_bio() ->
> iomap_finish_ioend() (potentially in softirq context) path and don't
> do any completion merging at all. Hence for this path we need
> submission side ioend size limiting as there's only one ioend to
> process per completion...
> 
> Largely this discussion is about heuristics. The submission side
> needs to have a heuristic to limit single ioend sizes because of the
> above completion path, and any filesystem that does merging needs
> other heuristics that match the mechanisms it uses merging to
> optimise.

Yep, agreed.

> Hence I think that we want the absolute minimum heuristics in the
> iomap code that limit the size of a single ioend completion so the
> generic iomap paths do not need "cond_resched()" magic sprinkled
> through them, whilst filesystems that do merging need to control and
> handle merged ioends appropriately.

Agreed.  I think the only point of conflict about this part of the
solution is how we figure out when an ioend has gotten too big -- byte
counts are the {obvious,backportable} solution as you say, but I also
feel that byte counts are a (somewhat poor) proxy for the amount of work
that will have to be done.

> filesystems that do merging need to have their own heuristics to
> control merging and avoid creating huge ioends. The current merging
> code has one user - XFS - and so it's largely XFS specific behaviour
> it encodes. IT might just be simpler to move the merging heuristics
> back up into the XFS layer for the moment and worry about generic
> support when some other filesystem wants to use completion
> merging...

<nod> At the moment, iomap_finish_ioends (plural) is how that one
filesystem that uses ioend merging finishes a merged ioend chain.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
