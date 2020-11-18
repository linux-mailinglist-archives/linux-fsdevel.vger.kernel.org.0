Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0B2B8702
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKRVsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:48:11 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35737 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbgKRVsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:48:11 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0015058B8B8;
        Thu, 19 Nov 2020 08:48:06 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kfVJ7-00CaBq-Rt; Thu, 19 Nov 2020 08:48:05 +1100
Date:   Thu, 19 Nov 2020 08:48:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
Message-ID: <20201118214805.GS7391@dread.disaster.area>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
 <20201118071941.GN7391@dread.disaster.area>
 <9ef0f890-f115-41f3-15fc-28f21810379f@kernel.dk>
 <20201118203723.GP7391@dread.disaster.area>
 <95d51836-9dc0-24c3-9aad-678d68613907@kernel.dk>
 <20201118211506.GQ7391@dread.disaster.area>
 <83997a78-7662-42ba-1e0d-9b543d3e3194@kernel.dk>
 <20201118213341.GR7391@dread.disaster.area>
 <83c8c94e-0d70-bd9a-d5b2-0621c1d977ac@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c8c94e-0d70-bd9a-d5b2-0621c1d977ac@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=5GEKdLpIFTKpUNbAVaAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 02:36:47PM -0700, Jens Axboe wrote:
> On 11/18/20 2:33 PM, Dave Chinner wrote:
> > On Wed, Nov 18, 2020 at 02:19:30PM -0700, Jens Axboe wrote:
> >>>>> Can you provide an actual event trace of the IOs in question that
> >>>>> are failing in your tests (e.g. from something like `trace-cmd
> >>>>> record -e xfs_file\* -e xfs_i\* -e xfs_\*write -e iomap\*` over the
> >>>>> sequential that reproduces the issue) so that there's no ambiguity
> >>>>> over how this problem is occurring in your systems?
> >>>>
> >>>> Let me know if you still want this!
> >>>
> >>> No, it makes sense now :)
> >>
> >> What's the next step here? Are you working on an XFS fix for this?
> > 
> > I'm just building the patch now for testing.
> 
> Nice, you're fast...

Only when I understand exactly what is happening :/

Patch below.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


xfs: don't allow NOWAIT DIO across extent boundaries

From: Dave Chinner <dchinner@redhat.com>

Jens has reported a situation where partial direct IOs can be issued
and completed yet still return -EAGAIN. We don't want this to report
a short IO as we want XFS to complete user DIO entirely or not at
all.

This partial IO situation can occur on a write IO that is split
across an allocated extent and a hole, and the second mapping is
returning EAGAIN because allocation would be required.

The trivial reproducer:

$ sudo xfs_io -fdt -c "pwrite 0 4k" -c "pwrite -V 1 -b 8k -N 0 8k" /mnt/scr/foo
wrote 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0001 sec (27.509 MiB/sec and 7042.2535 ops/sec)
pwrite: Resource temporarily unavailable
$

The pwritev2(0, 8kB, RWF_NOWAIT) call returns EAGAIN having done
the first 4kB write:

 xfs_file_direct_write: dev 259:1 ino 0x83 size 0x1000 offset 0x0 count 0x2000
 iomap_apply:          dev 259:1 ino 0x83 pos 0 length 8192 flags WRITE|DIRECT|NOWAIT (0x31) ops xfs_direct_write_iomap_ops caller iomap_dio_rw actor iomap_dio_actor
 xfs_ilock_nowait:     dev 259:1 ino 0x83 flags ILOCK_SHARED caller xfs_ilock_for_iomap
 xfs_iunlock:          dev 259:1 ino 0x83 flags ILOCK_SHARED caller xfs_direct_write_iomap_begin
 xfs_iomap_found:      dev 259:1 ino 0x83 size 0x1000 offset 0x0 count 8192 fork data startoff 0x0 startblock 24 blockcount 0x1
 iomap_apply_dstmap:   dev 259:1 ino 0x83 bdev 259:1 addr 102400 offset 0 length 4096 type MAPPED flags DIRTY

Here the first iomap loop has mapped the first 4kB of the file and
issued the IO, and we enter the second iomap_apply loop:

 iomap_apply: dev 259:1 ino 0x83 pos 4096 length 4096 flags WRITE|DIRECT|NOWAIT (0x31) ops xfs_direct_write_iomap_ops caller iomap_dio_rw actor iomap_dio_actor
 xfs_ilock_nowait:     dev 259:1 ino 0x83 flags ILOCK_SHARED caller xfs_ilock_for_iomap
 xfs_iunlock:          dev 259:1 ino 0x83 flags ILOCK_SHARED caller xfs_direct_write_iomap_begin

And we exit with -EAGAIN out because we hit the allocate case trying
to make the second 4kB block.

Then IO completes on the first 4kB and the original IO context
completes and unlocks the inode, returning -EAGAIN to userspace:

 xfs_end_io_direct_write: dev 259:1 ino 0x83 isize 0x1000 disize 0x1000 offset 0x0 count 4096
 xfs_iunlock:          dev 259:1 ino 0x83 flags IOLOCK_SHARED caller xfs_file_dio_aio_write

There are other vectors to the same problem when we re-enter the
mapping code if we have to make multiple mappinfs under NOWAIT
conditions. e.g. failing trylocks, COW extents being found,
allocation being required, and so on.

Avoid all these potential problems by only allowing IOMAP_NOWAIT IO
to go ahead if the mapping we retrieve for the IO spans an entire
allocated extent. This avoids the possibility of subsequent mappings
to complete the IO from triggering NOWAIT semantics by any means as
NOWAIT IO will now only enter the mapping code once per NOWAIT IO.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 3abb8b9d6f4c..7b9ff824e82d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -706,6 +706,23 @@ xfs_ilock_for_iomap(
 	return 0;
 }
 
+/*
+ * Check that the imap we are going to return to the caller spans the entire
+ * range that the caller requested for the IO.
+ */
+static bool
+imap_spans_range(
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	if (imap->br_startoff > offset_fsb)
+		return false;
+	if (imap->br_startoff + imap->br_blockcount < end_fsb)
+		return false;
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -766,6 +783,18 @@ xfs_direct_write_iomap_begin(
 	if (imap_needs_alloc(inode, flags, &imap, nimaps))
 		goto allocate_blocks;
 
+	/*
+	 * NOWAIT IO needs to span the entire requested IO with a single map so
+	 * that we avoid partial IO failures due to the rest of the IO range not
+	 * covered by this map triggering an EAGAIN condition when it is
+	 * subsequently mapped and aborting the IO.
+	 */
+	if ((flags & IOMAP_NOWAIT) &&
+	    !imap_spans_range(&imap, offset_fsb, end_fsb)) {
+		error = -EAGAIN;
+		goto out_unlock;
+	}
+
 	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
