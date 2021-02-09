Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE223144BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 01:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBIAPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 19:15:30 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:43081 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhBIAP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:15:29 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id DF30DCFE5;
        Tue,  9 Feb 2021 11:14:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l9Gg1-00DKLW-Tb; Tue, 09 Feb 2021 11:14:45 +1100
Date:   Tue, 9 Feb 2021 11:14:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCHSET 0/3] Improve IOCB_NOWAIT O_DIRECT
Message-ID: <20210209001445.GP4626@dread.disaster.area>
References: <20210208221829.17247-1-axboe@kernel.dk>
 <20210208232846.GO4626@dread.disaster.area>
 <44fec531-b2fd-f569-538a-64449a5c371b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44fec531-b2fd-f569-538a-64449a5c371b@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8
        a=DdZlDw2NG71Ak8dpQpwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:37:26PM -0700, Jens Axboe wrote:
> On 2/8/21 4:28 PM, Dave Chinner wrote:
> > On Mon, Feb 08, 2021 at 03:18:26PM -0700, Jens Axboe wrote:
> >> Hi,
> >>
> >> Ran into an issue with IOCB_NOWAIT and O_DIRECT, which causes a rather
> >> serious performance issue. If IOCB_NOWAIT is set, the generic/iomap
> >> iterators check for page cache presence in the given range, and return
> >> -EAGAIN if any is there. This is rather simplistic and looks like
> >> something that was never really finished. For !IOCB_NOWAIT, we simply
> >> call filemap_write_and_wait_range() to issue (if any) and wait on the
> >> range. The fact that we have page cache entries for this range does
> >> not mean that we cannot safely do O_DIRECT IO to/from it.
> >>
> >> This series adds filemap_range_needs_writeback(), which checks if
> >> we have pages in the range that do require us to call
> >> filemap_write_and_wait_range(). If we don't, then we can proceed just
> >> fine with IOCB_NOWAIT.
> > 
> > Not exactly. If it is a write we are doing, we _must_ invalidate
> > the page cache pages over the range of the DIO write to maintain
> > some level of cache coherency between the DIO write and the page
> > cache contents. i.e. the DIO write makes the page cache contents
> > stale, so the page cache has to be invalidated before the DIO write
> > is started, and again when it completes to toss away racing updates
> > (mmap) while the DIO write was in flight...
> > 
> > Page invalidation can block (page locks, waits on writeback, taking
> > the mmap_sem to zap page tables, etc), and it can also fail because
> > pages are dirty (e.g. writeback+invalidation racing with mmap).
> > 
> > And if it fails because dirty pages then we fall back to buffered
> > IO, which serialises readers and writes and will block.
> 
> Right, not disagreeing with any of that.
> 
> >> The problem manifested itself in a production environment, where someone
> >> is doing O_DIRECT on a raw block device. Due to other circumstances,
> >> blkid was triggered on this device periodically, and blkid very helpfully
> >> does a number of page cache reads on the device. Now the mapping has
> >> page cache entries, and performance falls to pieces because we can no
> >> longer reliably do IOCB_NOWAIT O_DIRECT.
> > 
> > If it was a DIO write, then the pages would have been invalidated
> > on the first write and the second write would issued with NOWAIT
> > just fine.
> > 
> > So the problem sounds to me like DIO reads from the block device are
> > not invalidating the page cache over the read range, so they persist
> > and prevent IOCB_NOWAIT IO from being submitted.
> 
> That is exactly the case I ran into indeed.
> 
> > Historically speaking, this is why XFS always used to invalidate the
> > page cache for DIO - it didn't want to leave cached clean pages that
> > would prevent future DIOs from being issued concurrently because
> > coherency with the page cache caused performance issues. We
> > optimised away this invalidation because the data in the page cache
> > is still valid after a flush+DIO read, but it sounds to me like
> > there are still corner cases where "always invalidate cached pages"
> > is the right thing for DIO to be doing....
> > 
> > Not sure what the best way to go here it - the patch isn't correct
> > for NOWAIT DIO writes, but it looks necessary for reads. And I'm not
> > sure that we want to go back to "invalidate everything all the time"
> > either....
> 
> We still do the invalidation for writes with the patch for writes,
> nothing has changed there. We just skip the
> filemap_write_and_wait_range() if there's nothing to write. And if
> there's nothing to write, _hopefully_ the invalidation should go
> smoothly unless someone dirtied/locked/put-under-writeback the page
> since we did the check. But that's always going to be racy, and there's
> not a whole lot we can do about that.

Sure, but if someone has actually mapped the range and is accessing
it, then PTEs will need zapping and mmap_sem needs to be taken in
write mode. If there's continual racing access, you've now got the
mmap_sem regularly being taken exclusively in the IOCB_NOWAIT path
and that means it will get serialised against other threads in the
task doing page faults and other mm context operations.  The "needs
writeback" check you've added does nothing to alleviate this
potential blocking point for the write path.

That's my point - you're exposing obvious new blocking points for
IOCB_NOWAIT DIO writes, not removing them. It may not happen very
often, but the whack-a-mole game you are playing with IOCB_NOWAIT is
"we found an even rarer blocking condition that it is critical to
our application". While this patch whacks this specific mole in the
read path, it also exposes the write path to another rare blocking
condition that will eventually end up being the mole that needs to
be whacked...

Perhaps the needs-writeback optimisation should only be applied to
the DIO read path?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
