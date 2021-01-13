Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA72F570D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 02:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbhANB6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 20:58:13 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33679 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729559AbhAMXm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:42:56 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2E0603E9D56;
        Thu, 14 Jan 2021 09:49:39 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kzoxL-006B9A-JF; Thu, 14 Jan 2021 09:49:35 +1100
Date:   Thu, 14 Jan 2021 09:49:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: Re: [PATCH 09/10] iomap: add a IOMAP_DIO_NOALLOC flag
Message-ID: <20210113224935.GJ331610@dread.disaster.area>
References: <20210112162616.2003366-1-hch@lst.de>
 <20210112162616.2003366-10-hch@lst.de>
 <20210112232923.GD331610@dread.disaster.area>
 <20210113153215.GA1284163@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113153215.GA1284163@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=JDRsW_cnHUdvuFr_4FIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 13, 2021 at 10:32:15AM -0500, Brian Foster wrote:
> On Wed, Jan 13, 2021 at 10:29:23AM +1100, Dave Chinner wrote:
> > On Tue, Jan 12, 2021 at 05:26:15PM +0100, Christoph Hellwig wrote:
> > > Add a flag to request that the iomap instances do not allocate blocks
> > > by translating it to another new IOMAP_NOALLOC flag.
> > 
> > Except "no allocation" that is not what XFS needs for concurrent
> > sub-block DIO.
> > 
> > We are trying to avoid external sub-block IO outside the range of
> > the user data IO (COW, sub-block zeroing, etc) so that we don't
> > trash adjacent sub-block IO in flight. This means we can't do
> > sub-block zeroing and that then means we can't map unwritten extents
> > or allocate new extents for the sub-block IO.  It also means the IO
> > range cannot span EOF because that triggers unconditional sub-block
> > zeroing in iomap_dio_rw_actor().
> > 
> > And because we may have to map multiple extents to fully span an IO
> > range, we have to guarantee that subsequent extents for the IO are
> > also written otherwise we have a partial write abort case. Hence we
> > have single extent limitations as well.
> > 
> > So "no allocation" really doesn't describe what we want this flag to
> > at all.
> > 
> > If we're going to use a flag for this specific functionality, let's
> > call it what it is: IOMAP_DIO_UNALIGNED/IOMAP_UNALIGNED and do two
> > things with it.
> > 
> > 	1. Make unaligned IO a formal part of the iomap_dio_rw()
> > 	behaviour so it can do the common checks to for things that
> > 	need exclusive serialisation for unaligned IO (i.e. avoid IO
> > 	spanning EOF, abort if there are cached pages over the
> > 	range, etc).
> > 
> > 	2. require the filesystem mapping callback do only allow
> > 	unaligned IO into ranges that are contiguous and don't
> > 	require mapping state changes or sub-block zeroing to be
> > 	performed during the sub-block IO.
> > 
> > 
> 
> Something I hadn't thought about before is whether applications might
> depend on current unaligned dio serialization for coherency and thus
> break if the kernel suddenly allows concurrent unaligned dio to pass
> through. Should this be something that is explicitly requested by
> userspace?

If applications are relying on an undocumented, implementation
specific behaviour of a filesystem that only occurs for IOs of a
certain size for implicit data coherency between independent,
non-overlapping DIOs and/or page cache IO, then they are already
broken and need fixing because that behaviour is not guaranteed to
occur. e.g. 512 byte block size filesystem does not provide such
serialisation, so if the app depends on 512 byte DIOs being
serialised completely by the filesytem then it already fails on 512
byte block size filesystems.

So, no, we simply don't care about breaking broken applications that
are already broken.

> That aside, I agree that the DIO_UNALIGNED approach seems a bit more
> clear than NOALLOC, but TBH the more I look at this the more Christoph's
> first approach seems cleanest to me. It is a bit unfortunate to
> duplicate the mapping lookups and have the extra ILOCK cycle, but the
> lock is shared and only taken when I/O is unaligned. I don't really see
> why that is a show stopper yet it's acceptable to fall back to exclusive
> dio if the target range happens to be discontiguous (but otherwise
> mapped/written).

Unnecessary lock cycles in the fast path are always bad. The whole
reason this change is being done is for performance to bring it up
to par with block aligned IO. Adding an extra lock cycle to the
ILOCK on every IO will halve the performance on high IOPs hardware
because the ILOCK will be directly exposed to userspace IO
submission and hence become the contention point instead of the
IOLOCK.

IOWs, the fact taht we take the ILOCK 2x per IO instead of once
means that the ILOCK becomes the performance limiting lock (because
even shared locking causes cacheline contention) and changes the
entire lock profile for the IO path when unaligned IO is being done.

This is also ignoring the fact that the ILOCK is held in exclusive
mode during IO completion while doing file size and extent
manipulation transactions. IOWs we can block waiting on IO
completion before we even decide if we can do the IO with shared
locking. Hence there are new IO submission serialisation points in
the fast path that will also slow down the cases where we have to do
exclusive locking....

So, yeah, I can only see bad things occurring by lifting the ILOCK
up into the high level IO path. And, of course, once it's taken
there, people will find new reasons to expand it's scope and the
problems will only get worse...

> So I dunno... to me, I would start with that approach and then as the
> implementation soaks, perhaps see if we can find a way to optimize away
> the extra cycle and lookup.

I don't see how we can determine if we can do the unlaigned IO
holding a shared lock without doing an extent lookup. It's the
underlying extent state that makes shared locking possible, and I
can't think of any other state we can look at to make this decision.

Hence I think this path is simply a dead end with no possibility of
further optimisation. Of course, if you can solve the problem
without needing an extent lookup, then we can talk about how to
avoid racing with actual extent mapping changes done under the
ILOCK... :)

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
