Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C42F3E69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394294AbhALWH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:07:29 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:60470 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393928AbhALWH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:07:28 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id B1A17821E4F;
        Wed, 13 Jan 2021 09:06:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kzRoH-005pII-3Q; Wed, 13 Jan 2021 09:06:41 +1100
Date:   Wed, 13 Jan 2021 09:06:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: Re: [PATCH 6/6] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210112220641.GT331610@dread.disaster.area>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <20210112010746.1154363-7-david@fromorbit.com>
 <X/19MZHQtcnj9NDc@infradead.org>
 <20210112170133.GD1137163@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112170133.GD1137163@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=wvGhdvRZP3sx8CLwV_cA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:01:33PM -0500, Brian Foster wrote:
> On Tue, Jan 12, 2021 at 11:42:57AM +0100, Christoph Hellwig wrote:
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index bba33be17eff..f5c75404b8a5 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -408,7 +408,7 @@ xfs_file_aio_write_checks(
> > >  			drained_dio = true;
> > >  			goto restart;
> > >  		}
> > > -	
> > > +
> > 
> > Spurious unrelated whitespace change.
> > 
> > >  	struct iomap_dio_rw_args args = {
> > >  		.iocb			= iocb,
> > >  		.iter			= from,
> > >  		.ops			= &xfs_direct_write_iomap_ops,
> > >  		.dops			= &xfs_dio_write_ops,
> > >  		.wait_for_completion	= is_sync_kiocb(iocb),
> > > -		.nonblocking		= (iocb->ki_flags & IOCB_NOWAIT),
> > > +		.nonblocking		= true,
> > 
> > I think this is in many ways wrong.  As far as I can tell you want this
> > so that we get the imap_spans_range in xfs_direct_write_iomap_begin. But
> > we should not trigger any of the other checks, so we'd really need
> > another flag instead of reusing this one.
> > 
> 
> It's really the br_state != XFS_EXT_NORM check that we want for the
> unaligned case, isn't it?

We can only submit unaligned DIO with a shared IOLOCK to a written
range, which means we need to abort the IO if we hit a COW range
(imap_needs_cow()), a hole (imap_needs_alloc()), the range spans
multiple extents (imap_spans_range()) and, finally, unwritten
extents (the new check I added).

IOMAP_NOWAIT aborts on all these cases and returns EAGAIN.

> > imap_spans_range is a bit pessimistic for avoiding the exclusive lock,

No, it's absolutely required.

If the sub-block aligned dio spans multiple extents, we don't know
what locking is required for that next extent until iomap_apply()
loops and calls us again for that range. WHile the first range might
be written and OK to issue, the next extent range could
require allocation, COW or unwritten extent conversion and so would
require exclusive IO locking.  And so we end up with partial IO
submission, which causes all sorts of problems...

IOWs, if the unaligned dio cannot be mapped to a single written
extent, we can't do it under shared locking conditions - it must be
done under exclusive locking to maintain the "no partial submission"
rules we have for DIO.

> > but I guess we could live that if it is clearly documented as helping
> > with the implementation, but we really should not automatically trigger
> > all the other effects of nowait I/O.
> 
> Regardless, I agree on this point.

The only thing that IOMAP_NOWAIT does that might be questionable is
the xfs_ilock_nowait() call on the ILOCK. We want it to abort shared
IO if we don't have the extents read in - Christoph's patch made
this trigger exclusive IO, too and so of all the things that
IOMAP_NOWAIT triggers, the -only thing- we can raise a question
about is the trylock.

And, quite frankly, if something is modifying the inode metadata
while we are trying to sub-block DIO, I want the sub-block DIO to
fall back to exclusive locking just to be safe. It may not be
necessary, but right now I'd prefer to err on the side of caution
and be conservative about when this optimisation triggers. If we get
it wrong, we corrupt data....

> I don't have a strong opinion in general on this approach vs. the
> other, but it does seem odd to me to overload the broader nowait
> semantics with the unaligned I/O checks. I see that it works for
> the primary case we care about, but this also means things like
> the _has_page() check now trigger exclusivity for the unaligned
> case where that doesn't seem to be necessary.

Actually, it's another case of being safe rather than sorry. In the
sub-block DIO is racing with mmap or write() dirtying the page that
spans the DIO range, we end up issuing concurrent IOs to the same
LBA range, something that results in undefined behaviour and is
something we must absolutely not do.

That is:

	DIO	(1024, 512)
		submit_bio (1024, 512)
		.....
	mmap
		(0, 4096)
		touch byte 0
		page dirty

	DIO	(2048, 512)
		filemap_write_and_wait_range(2048, 512)
		submit_bio(0, 4096)
		.....

and now we have overlapping concurrent IO in flight even though
usrespace has not done any overlapping modifications at all.
Overlapping IO should never be issued by the filesystem as the
result is undefined. Yes, the application should not be mixing
mmap+DIO, but we the filesystem in this case is doing something even
worse and something we tell userspace developers that *they should
never do*. We can trivially avoid this corruption case by falling
back to exclusive locking for subblock dio if writeback and/or page
cache invalidation may be required.

IOWs, IOMAP_NOWAIT gives us exactly the behaviour we need here for
serialising concurrent sub-block dio against page cache based IO...

> I do like the
> previous cleanups so I suspect if we worked this into a new
> 'subblock_io' flag that indicates to the lower layer whether the
> filesystem can allow zeroing, that might clean much of this up.

Allow zeroing where, exactly? e.g. some filesystems do zeroing in
their allocation routines during mapping. IOWs, this strikes me as
encoding specific filesystem implementation requirements into the
generic API as opposed to using generic functionality to implement
specific FS behavioural requirements.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
