Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C2484A3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 22:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiADVwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 16:52:32 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36146 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230369AbiADVwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:52:31 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0305010A84BE;
        Wed,  5 Jan 2022 08:52:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n4rjH-00BOQi-Fo; Wed, 05 Jan 2022 08:52:27 +1100
Date:   Wed, 5 Jan 2022 08:52:27 +1100
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
Message-ID: <20220104215227.GJ945095@dread.disaster.area>
References: <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104192227.GA398655@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61d4c19e
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=VEDfoT-fhBuhpAzWpJsA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 11:22:27AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 04, 2022 at 10:14:27AM -0800, hch@infradead.org wrote:
> > On Tue, Jan 04, 2022 at 06:08:24PM +0000, Matthew Wilcox wrote:
> > > I think it's fine to put in a fix like this now that's readily
> > > backportable.  For folios, I can't help but think we want a
> > > restructuring to iterate per-extent first, then per-folio and finally
> > > per-sector instead of the current model where we iterate per folio,
> > > looking up the extent for each sector.
> > 
> > We don't look up the extent for each sector.  We look up the extent
> > once and then add as much of it as we can to the bio until either the
> > bio is full or the extent ends.  In the first case we then allocate
> > a new bio and add it to the ioend.
> 
> Can we track the number of folios that have been bio_add_folio'd to the
> iomap_ioend, and make iomap_can_add_to_ioend return false when the
> number of folios reaches some threshold?  I think that would solve the
> problem of overly large ioends while not splitting folios across ioends
> unnecessarily.

See my reply to Christoph up thread.

The problem is multiple blocks per page/folio - bio_add_folio() will
get called for the same folio many times, and we end up not knowing
when a new page/folio is attached. Hence dynamically calculating it
as we build the bios is .... convoluted.

Alternatively, we could ask the bio how many segments it has
attached before we switch it out (or submit it) and add that to the
ioend count. THat's probably the least invasive way of doing this,
as we already have wrapper functions for chaining and submitting
bios on ioends....

> As for where to put a cond_resched() call, I think we'd need to change
> iomap_ioend_can_merge to avoid merging two ioends if their folio count
> exceeds the same(?) threshold,

That I'm not so sure about. If the ioends are physically contiguous,
we do *much less* CPU work by doing a single merged extent
conversion transaction than doing one transaction per unmerged
ioend. i.e. we save a lot of completion CPU time by merging
physically contiguous ioends, but we save none by merging physically
discontiguous ioends.

Yes, I can see that we probably still want to limit the ultimate
size of the merged, physically contiguous ioend, but I don't think
it's anywhere near as small as the IO submission sized chunks need
to be.

> and then one could put the cond_resched
> after each iomap_finish_ioend call in iomap_finish_ioends, and declare
> that iomap_finish_ioends cannot be called from atomic context.

iomap does not do ioend merging by itself. The filesystem decides if
merging is to be done - only XFS calls iomap_ioend_try_merge() right
now, so it's the only filesystem that uses completion merging.

Hence generic iomap code will only end up calling
iomap_finish_ioends() with the same ioend that was submitted. i.e.
capped to 4096 pages by this patch. THerefore it does not need
cond_resched() calls - the place that needs it is where the ioends
are merged and then finished. That is, in the filesystem completion
processing that does the merging....

> I forget if anyone ever benchmarked the actual overhead of cond_resched,
> but if my dim memory serves, it's not cheap but also not expensive.

The overhead is noise if called once per ioend.

> Limiting each ioend to (say) 16k folios and not letting small ioends
> merge into something bigger than that for the completion seems (to me
> anyway) a balance between stalling out on marking pages after huge IOs
> vs. losing the ability to coalesce xfs_end_ioend calls when a contiguous
> range of file range has been written back but the backing isn't.

Remember, we only end up in xfs_end_ioend() for COW, unwritten
conversion or extending the file. For pure overwrites, we already
go through the generic iomap_writepage_end_bio() ->
iomap_finish_ioend() (potentially in softirq context) path and don't
do any completion merging at all. Hence for this path we need
submission side ioend size limiting as there's only one ioend to
process per completion...

Largely this discussion is about heuristics. The submission side
needs to have a heuristic to limit single ioend sizes because of the
above completion path, and any filesystem that does merging needs
other heuristics that match the mechanisms it uses merging to
optimise.

Hence I think that we want the absolute minimum heuristics in the
iomap code that limit the size of a single ioend completion so the
generic iomap paths do not need "cond_resched()" magic sprinkled
through them, whilst filesystems that do merging need to control and
handle merged ioends appropriately.

filesystems that do merging need to have their own heuristics to
control merging and avoid creating huge ioends. The current merging
code has one user - XFS - and so it's largely XFS specific behaviour
it encodes. IT might just be simpler to move the merging heuristics
back up into the XFS layer for the moment and worry about generic
support when some other filesystem wants to use completion
merging...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
