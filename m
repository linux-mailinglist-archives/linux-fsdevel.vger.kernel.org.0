Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C959E17518D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 02:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCBBgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 20:36:11 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38075 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbgCBBgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 20:36:10 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 194C97E946A;
        Mon,  2 Mar 2020 12:36:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j8a02-0005W8-C2; Mon, 02 Mar 2020 12:36:02 +1100
Date:   Mon, 2 Mar 2020 12:36:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V5 06/12] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200302013602.GG10776@dread.disaster.area>
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200227052442.22524-7-ira.weiny@intel.com>
 <20200302012644.GF10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20200302012644.GF10776@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=SS2py6AdgQ4A:10 a=7-415B0cAAAA:8
        a=rGxbxzf4koUqW12_8dsA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
        a=CjuIK1q_8ugA:10 a=20KFwNOVAAAA:8 a=v-gsBvOia3DiEux-IwgA:9
        a=pUglIknb_-KEOjkPfI0A:9 a=SfCetT9bQnuQAJUP:21 a=HiPI2jbP1wO4qq58:21
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2020 at 12:26:44PM +1100, Dave Chinner wrote:
> >  	/*
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 1784478270e1..3a7863ba51b9 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2293,6 +2293,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  		 * and return.  Otherwise fallthrough to buffered io for
> >  		 * the rest of the read.  Buffered reads will not work for
> >  		 * DAX files, so don't bother trying.
> > +		 *
> > +		 * IS_DAX is protected under ->read_iter lock
> >  		 */
> >  		if (retval < 0 || !count || iocb->ki_pos >= size ||
> >  		    IS_DAX(inode))
> 
> This check is in the DIO path, be we can't do DIO on DAX enabled
> files to begin with, so we can only get here if S_DAX is not set on
> the file.
> 
> Further, if IOCB_DIRECT is set, neither ext4 nor XFS call
> generic_file_read_iter(); they run the iomap_dio_rw() path directly
> instead. Only ext2 calls generic_file_read_iter() to do direct IO,
> so it's the only filesystem that needs this IS_DAX() check in it.
> 
> I think we should fix ext2 to be implemented like ext4 and XFS -
> they implement the buffered IO fallback, should it be required,
> themselves and never use generic_file_read_iter() for direct IO.
> 
> That would allow us to add this to generic_file_read_iter():
> 
> 	if (WARN_ON_ONCE(IS_DAX(inode))
> 		return -EINVAL;
> 
> to indicate that this should never be called directly on a DAX
> capable filesystem. This places all the responsibility for managing
> DAX behaviour on the filesystem, which then allows us to reason more
> solidly about how the filesystem IO paths use and check the S_DAX
> flag.
> 
> i.e. changing the on-disk flag already locks out the filesystem IO
> path via the i_rwsem(), and all the filesystem IO paths (buffered,
> direct IO and dax) are serialised by this flag. Hence we can check
> once in the filesystem path once we have the i_rwsem held and
> know that S_DAX will not change until we release it.
> 
> ..... and now I realise what I was sitting on the fence about....
> 
> I don't like the aops locking in call_read/write_iter() because it
> is actually redundant: the filesystem should be doing the necessary
> locking in the IO path via the i_rwsem to prevent S_DAX from
> changing while it is doing the IO.
> 
> IOWs, we need to restructure the locking inside the filesystem
> read_iter and write_iter methods so that the i_rwsem protects the
> S_DAX flag from changing dynamically. They all do:
> 
> 	if (dax)
> 		do_dax_io()
> 	if (direct)
> 		do_direct_io()
> 	do_buffered_io()
> 
> And then we take the i_rwsem inside each of those functions and do
> the IO. What we actually need to do is something like this:
> 
> 	inode_lock_shared()
> 	if (dax)
> 		do_dax_io()
> 	if (direct)
> 		do_direct_io()
> 	do_buffered_io()
> 	inode_unlock_shared()
> 
> And remove the inode locking from inside the individual IO methods
> themselves. It's a bit more complex than this because buffered
> writes require exclusive locking, but this completely removes the
> need for holding an aops lock over these methods.
> 
> I've attached a couple of untested patches (I've compiled them, so
> they must be good!) to demonstrate what I mean for the XFS IO path.
> The read side removes a heap of duplicate code, but the write side
> is .... unfortunately complex. Have to think about that more.

And now with patches...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xfs-io-s_dax-locking

xfs: pulling read IO path locking up to protect S_DAX checks

From: Dave Chinner <dchinner@redhat.com>

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_file.c | 77 +++++++++++++++++--------------------------------------
 1 file changed, 24 insertions(+), 53 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b8a4a3f29b36..7d31a0e76b68 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -176,28 +176,12 @@ xfs_file_dio_aio_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
-	size_t			count = iov_iter_count(to);
-	ssize_t			ret;
-
-	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
-
-	if (!count)
-		return 0; /* skip atime */
+	trace_xfs_file_direct_read(XFS_I(file_inode(iocb->ki_filp)),
+					iov_iter_count(to), iocb->ki_pos);
 
 	file_accessed(iocb->ki_filp);
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	}
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
+	return iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
 			is_sync_kiocb(iocb));
-	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
-
-	return ret;
 }
 
 static noinline ssize_t
@@ -205,27 +189,12 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
-	size_t			count = iov_iter_count(to);
-	ssize_t			ret = 0;
-
-	trace_xfs_file_dax_read(ip, count, iocb->ki_pos);
-
-	if (!count)
-		return 0; /* skip atime */
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	}
-
-	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
-	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
+	trace_xfs_file_dax_read(XFS_I(file_inode(iocb->ki_filp)),
+					iov_iter_count(to), iocb->ki_pos);
 
 	file_accessed(iocb->ki_filp);
-	return ret;
+	return dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
+
 }
 
 STATIC ssize_t
@@ -233,21 +202,10 @@ xfs_file_buffered_aio_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
-	ssize_t			ret;
-
-	trace_xfs_file_buffered_read(ip, iov_iter_count(to), iocb->ki_pos);
+	trace_xfs_file_buffered_read(XFS_I(file_inode(iocb->ki_filp)),
+					iov_iter_count(to), iocb->ki_pos);
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	}
-	ret = generic_file_read_iter(iocb, to);
-	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
-
-	return ret;
+	return generic_file_read_iter(iocb, to);
 }
 
 STATIC ssize_t
@@ -256,7 +214,8 @@ xfs_file_read_iter(
 	struct iov_iter		*to)
 {
 	struct inode		*inode = file_inode(iocb->ki_filp);
-	struct xfs_mount	*mp = XFS_I(inode)->i_mount;
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
 	ssize_t			ret = 0;
 
 	XFS_STATS_INC(mp, xs_read_calls);
@@ -264,6 +223,16 @@ xfs_file_read_iter(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
+	if (!iov_iter_count(to))
+		return 0; /* skip atime */
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED))
+			return -EAGAIN;
+	} else {
+		xfs_ilock(ip, XFS_IOLOCK_SHARED);
+	}
+
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
 	else if (iocb->ki_flags & IOCB_DIRECT)
@@ -271,6 +240,8 @@ xfs_file_read_iter(
 	else
 		ret = xfs_file_buffered_aio_read(iocb, to);
 
+	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
+
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);
 	return ret;

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xfs-io-s_dax-write-locking

xfs: pull write IO locking up to protect S_DAX

From: Dave Chinner <dchinner@redhat.com>

Much more complex than the read side because of all the lock
juggling we for the different types of writes and all the various
metadata updates a write might need prior to dispatching the data
IO.

Not really happy about the way the high level logic turned out;
could probably be make cleaner and smarter with a bit more thought.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_file.c | 205 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 115 insertions(+), 90 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7d31a0e76b68..b7c2bb09b945 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -250,9 +250,9 @@ xfs_file_read_iter(
 /*
  * Common pre-write limit and setup checks.
  *
- * Called with the iolocked held either shared and exclusive according to
- * @iolock, and returns with it held.  Might upgrade the iolock to exclusive
- * if called for a direct write beyond i_size.
+ * Called without the iolocked held, but will lock it according to @iolock, and
+ * returns with it held on both success and error.  Might upgrade the iolock to
+ * exclusive if called for a direct write beyond i_size.
  */
 STATIC ssize_t
 xfs_file_aio_write_checks(
@@ -268,6 +268,13 @@ xfs_file_aio_write_checks(
 	bool			drained_dio = false;
 	loff_t			isize;
 
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!xfs_ilock_nowait(ip, *iolock))
+			return -EAGAIN;
+	} else {
+		xfs_ilock(ip, *iolock);
+	}
+
 restart:
 	error = generic_write_checks(iocb, from);
 	if (error <= 0)
@@ -325,7 +332,7 @@ xfs_file_aio_write_checks(
 			drained_dio = true;
 			goto restart;
 		}
-	
+
 		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
 		error = iomap_zero_range(inode, isize, iocb->ki_pos - isize,
 				NULL, &xfs_buffered_write_iomap_ops);
@@ -449,19 +456,14 @@ static const struct iomap_dio_ops xfs_dio_write_ops = {
  * Returns with locks held indicated by @iolock and errors indicated by
  * negative return values.
  */
-STATIC ssize_t
-xfs_file_dio_aio_write(
+static int
+xfs_file_dio_write_lock_mode(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	struct file		*file = iocb->ki_filp;
-	struct address_space	*mapping = file->f_mapping;
-	struct inode		*inode = mapping->host;
+	struct inode		*inode = file_inode(iocb->ki_filp);
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	ssize_t			ret = 0;
-	int			unaligned_io = 0;
-	int			iolock;
 	size_t			count = iov_iter_count(from);
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 
@@ -478,35 +480,37 @@ xfs_file_dio_aio_write(
 	 */
 	if ((iocb->ki_pos & mp->m_blockmask) ||
 	    ((iocb->ki_pos + count) & mp->m_blockmask)) {
-		unaligned_io = 1;
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			/* unaligned dio always waits, bail */
+			return -EAGAIN;
+		}
 
 		/*
 		 * We can't properly handle unaligned direct I/O to reflink
 		 * files yet, as we can't unshare a partial block.
 		 */
 		if (xfs_is_cow_inode(ip)) {
-			trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos, count);
+			trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos,
+							count);
 			return -EREMCHG;
 		}
-		iolock = XFS_IOLOCK_EXCL;
-	} else {
-		iolock = XFS_IOLOCK_SHARED;
-	}
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		/* unaligned dio always waits, bail */
-		if (unaligned_io)
-			return -EAGAIN;
-		if (!xfs_ilock_nowait(ip, iolock))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, iolock);
+		return XFS_IOLOCK_EXCL;
 	}
+	return XFS_IOLOCK_SHARED;
+}
 
-	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
-	if (ret)
-		goto out;
-	count = iov_iter_count(from);
+STATIC ssize_t
+xfs_file_dio_aio_write(
+	struct kiocb		*iocb,
+	struct iov_iter		*from,
+	int			iolock)
+{
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	ssize_t			ret = 0;
+	bool			unaligned_io = 0;
+	size_t			count = iov_iter_count(from);
 
 	/*
 	 * If we are doing unaligned IO, we can't allow any other overlapping IO
@@ -515,7 +519,9 @@ xfs_file_dio_aio_write(
 	 * iolock if we had to take the exclusive lock in
 	 * xfs_file_aio_write_checks() for other reasons.
 	 */
-	if (unaligned_io) {
+	if ((iocb->ki_pos & mp->m_blockmask) ||
+	    ((iocb->ki_pos + count) & mp->m_blockmask)) {
+		unaligned_io = true;
 		inode_dio_wait(inode);
 	} else if (iolock == XFS_IOLOCK_EXCL) {
 		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
@@ -530,7 +536,6 @@ xfs_file_dio_aio_write(
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
 			   &xfs_dio_write_ops,
 			   is_sync_kiocb(iocb) || unaligned_io);
-out:
 	xfs_iunlock(ip, iolock);
 
 	/*
@@ -544,26 +549,15 @@ xfs_file_dio_aio_write(
 static noinline ssize_t
 xfs_file_dax_write(
 	struct kiocb		*iocb,
-	struct iov_iter		*from)
+	struct iov_iter		*from,
+	int			iolock)
 {
-	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct inode		*inode = file_inode(iocb->ki_filp);
 	struct xfs_inode	*ip = XFS_I(inode);
-	int			iolock = XFS_IOLOCK_EXCL;
 	ssize_t			ret, error = 0;
 	size_t			count;
 	loff_t			pos;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!xfs_ilock_nowait(ip, iolock))
-			return -EAGAIN;
-	} else {
-		xfs_ilock(ip, iolock);
-	}
-
-	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
-	if (ret)
-		goto out;
-
 	pos = iocb->ki_pos;
 	count = iov_iter_count(from);
 
@@ -573,7 +567,6 @@ xfs_file_dax_write(
 		i_size_write(inode, iocb->ki_pos);
 		error = xfs_setfilesize(ip, pos, ret);
 	}
-out:
 	xfs_iunlock(ip, iolock);
 	if (error)
 		return error;
@@ -590,26 +583,13 @@ xfs_file_dax_write(
 STATIC ssize_t
 xfs_file_buffered_aio_write(
 	struct kiocb		*iocb,
-	struct iov_iter		*from)
+	struct iov_iter		*from,
+	int			iolock,
+	bool			flush_on_enospc)
 {
-	struct file		*file = iocb->ki_filp;
-	struct address_space	*mapping = file->f_mapping;
-	struct inode		*inode = mapping->host;
+	struct inode		*inode = file_inode(iocb->ki_filp);
 	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret;
-	int			enospc = 0;
-	int			iolock;
-
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		return -EOPNOTSUPP;
-
-write_retry:
-	iolock = XFS_IOLOCK_EXCL;
-	xfs_ilock(ip, iolock);
-
-	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
-	if (ret)
-		goto out;
 
 	/* We can write back this queue in page reclaim */
 	current->backing_dev_info = inode_to_bdi(inode);
@@ -617,8 +597,6 @@ xfs_file_buffered_aio_write(
 	trace_xfs_file_buffered_write(ip, iov_iter_count(from), iocb->ki_pos);
 	ret = iomap_file_buffered_write(iocb, from,
 			&xfs_buffered_write_iomap_ops);
-	if (likely(ret >= 0))
-		iocb->ki_pos += ret;
 
 	/*
 	 * If we hit a space limit, try to free up some lingering preallocated
@@ -629,34 +607,35 @@ xfs_file_buffered_aio_write(
 	 * also behaves as a filter to prevent too many eofblocks scans from
 	 * running at the same time.
 	 */
-	if (ret == -EDQUOT && !enospc) {
+	if (ret == -EDQUOT && flush_on_enospc) {
+		int	made_progress;
+
 		xfs_iunlock(ip, iolock);
-		enospc = xfs_inode_free_quota_eofblocks(ip);
-		if (enospc)
-			goto write_retry;
-		enospc = xfs_inode_free_quota_cowblocks(ip);
-		if (enospc)
-			goto write_retry;
-		iolock = 0;
-	} else if (ret == -ENOSPC && !enospc) {
+		made_progress = xfs_inode_free_quota_eofblocks(ip);
+		if (made_progress)
+			return -EAGAIN;
+		made_progress = xfs_inode_free_quota_cowblocks(ip);
+		if (made_progress)
+			return -EAGAIN;
+		return ret;
+	}
+	if (ret == -ENOSPC && flush_on_enospc) {
 		struct xfs_eofblocks eofb = {0};
 
-		enospc = 1;
 		xfs_flush_inodes(ip->i_mount);
 
 		xfs_iunlock(ip, iolock);
 		eofb.eof_flags = XFS_EOF_FLAGS_SYNC;
 		xfs_icache_free_eofblocks(ip->i_mount, &eofb);
 		xfs_icache_free_cowblocks(ip->i_mount, &eofb);
-		goto write_retry;
+		return -EAGAIN;
 	}
 
 	current->backing_dev_info = NULL;
-out:
-	if (iolock)
-		xfs_iunlock(ip, iolock);
-
+	xfs_iunlock(ip, iolock);
 	if (ret > 0) {
+		iocb->ki_pos += ret;
+
 		XFS_STATS_ADD(ip->i_mount, xs_write_bytes, ret);
 		/* Handle various SYNC-type writes */
 		ret = generic_write_sync(iocb, ret);
@@ -675,6 +654,8 @@ xfs_file_write_iter(
 	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret;
 	size_t			ocount = iov_iter_count(from);
+	int			iolock;
+	bool			flush_on_enospc = true;
 
 	XFS_STATS_INC(ip->i_mount, xs_write_calls);
 
@@ -684,22 +665,66 @@ xfs_file_write_iter(
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
 		return -EIO;
 
-	if (IS_DAX(inode))
-		return xfs_file_dax_write(iocb, from);
-
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	/*
+	 * Set up the initial locking state - only direct IO uses shared locking
+	 * for writes, and buffered IO does not support IOCB_NOWAIT.
+	 */
+relock:
+	if (IS_DAX(inode)) {
+		iolock = XFS_IOLOCK_EXCL;
+	} else if (iocb->ki_flags & IOCB_DIRECT) {
 		/*
 		 * Allow a directio write to fall back to a buffered
 		 * write *only* in the case that we're doing a reflink
 		 * CoW.  In all other directio scenarios we do not
 		 * allow an operation to fall back to buffered mode.
 		 */
-		ret = xfs_file_dio_aio_write(iocb, from);
-		if (ret != -EREMCHG)
-			return ret;
+		iolock = xfs_file_dio_write_lock_mode(iocb, from);
+		if (iolock == -EREMCHG) {
+			iocb->ki_flags &= ~IOCB_DIRECT;
+			iolock = XFS_IOLOCK_EXCL;
+		}
+		if (iolock < 0)
+			return iolock;
+	} else if (iocb->ki_flags & IOCB_NOWAIT) {
+		/* buffered writes do not support IOCB_NOWAIT */
+		return -EOPNOTSUPP;
+	} else {
+		iolock = XFS_IOLOCK_EXCL;
 	}
 
-	return xfs_file_buffered_aio_write(iocb, from);
+	ret = xfs_file_aio_write_checks(iocb, from, &iolock);
+	if (ret) {
+		xfs_iunlock(ip, iolock);
+		return ret;
+	}
+
+	/*
+	 * If the IO mode switched while we were locking meaning we hold
+	 * the wrong lock type right now, start again.
+	 */
+	if ((IS_DAX(inode) || !(iocb->ki_flags & IOCB_DIRECT)) &&
+	    iolock != XFS_IOLOCK_EXCL) {
+		xfs_iunlock(ip, iolock);
+		goto relock;
+	}
+
+	if (IS_DAX(inode)) {
+		ret = xfs_file_dax_write(iocb, from, iolock);
+	} else if (iocb->ki_flags & IOCB_DIRECT) {
+		ret = xfs_file_dio_aio_write(iocb, from, iolock);
+		ASSERT(ret != -EREMCHG);
+	} else {
+		ret = xfs_file_buffered_aio_write(iocb, from, iolock,
+						flush_on_enospc);
+		if (ret == -EAGAIN && flush_on_enospc) {
+			/* inode already unlocked, but need another attempt */
+			flush_on_enospc = false;
+			goto relock;
+		}
+		ASSERT(ret != -EAGAIN);
+	}
+	return ret;
 }
 
 static void

--4Ckj6UjgE2iN1+kY--
