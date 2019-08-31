Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC541A434C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHaI2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 04:28:13 -0400
Received: from verein.lst.de ([213.95.11.211]:33927 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfHaI2N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 04:28:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 81F1F227A8A; Sat, 31 Aug 2019 10:28:08 +0200 (CEST)
Date:   Sat, 31 Aug 2019 10:28:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        Kai =?iso-8859-1?Q?M=E4kisara_=28Kolumbus=29?= 
        <kai.makisara@kolumbus.fi>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190831082808.GB28527@lst.de>
References: <20190826024838.GN1131@ZenIV.linux.org.uk> <20190826162949.GA9980@ZenIV.linux.org.uk> <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi> <20190826193210.GP1131@ZenIV.linux.org.uk> <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com> <20190827172734.GS1131@ZenIV.linux.org.uk> <20190829222258.GA16625@ZenIV.linux.org.uk> <20190830041042.GB7777@dread.disaster.area> <20190830044439.GV1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830044439.GV1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 05:44:39AM +0100, Al Viro wrote:
> > Not quite right. XFS only returns an error if there is data
> > writeback failure or filesystem corruption or shutdown detected
> > during whatever operation it is performing.
> > 
> > We don't really care what is done with the error that we return;
> > we're just returning an error because that's what the function
> > prototype indicates we should do...
> 
> I thought that xfs_release() and friends followed the prototypes
> you had on IRIX, while xfs_file_release() et.al. were the
> impedance-matching layer for Linux.  Oh, well...

That is how it started out originally.  Since then a lot changed,
including the prototypes.  We could easily do something like the
patch below.  Additionally the read-only check probably should
check FMODE_WRITE instead, but that should be left for a separate
patch:

---
From fbdf4e24ad1505129fb4db38644d11fa9b7e11f0 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sat, 31 Aug 2019 10:24:55 +0200
Subject: xfs: remove xfs_release

We can just move the code directly to xfs_file_release.  Additionally
remove the pointless i_mode verification, and the error returns that
are entirely ignored by the calller of ->release.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  | 63 ++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_inode.c | 80 ----------------------------------------------
 fs/xfs/xfs_inode.h |  1 -
 3 files changed, 60 insertions(+), 84 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index d952d5962e93..cbaba0cc1fa4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1060,10 +1060,67 @@ xfs_dir_open(
 
 STATIC int
 xfs_file_release(
-	struct inode	*inode,
-	struct file	*filp)
+	struct inode		*inode,
+	struct file		*file)
 {
-	return xfs_release(XFS_I(inode));
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if ((mp->m_flags & XFS_MOUNT_RDONLY) || XFS_FORCED_SHUTDOWN(mp))
+		return 0;
+
+	/*
+	 * If we previously truncated this file and removed old data in the
+	 * process, we want to initiate "early" writeout on the last close.
+	 * This is an attempt to combat the notorious NULL files problem which
+	 * is particularly noticeable from a truncate down, buffered (re-)write
+	 * (delalloc), followed by a crash.  What we are effectively doing here
+	 * is significantly reducing the time window where we'd otherwise be
+	 * exposed to that problem.
+	 */
+	if (xfs_iflags_test_and_clear(ip, XFS_ITRUNCATED)) {
+		xfs_iflags_clear(ip, XFS_IDIRTY_RELEASE);
+		if (ip->i_delayed_blks > 0)
+			filemap_flush(inode->i_mapping);
+		return 0;
+	}
+
+	if (inode->i_nlink == 0 || !xfs_can_free_eofblocks(ip, false))
+		return 0;
+
+	/*
+	 * Check if the inode is being opened, written and closed frequently and
+	 * we have delayed allocation blocks outstanding (e.g. streaming writes
+	 * from the NFS server), truncating the blocks past EOF will cause
+	 * fragmentation to occur.
+	 *
+	 * In this case don't do the truncation, but we have to be careful how
+	 * we detect this case. Blocks beyond EOF show up as i_delayed_blks even
+	 * when the inode is clean, so we need to truncate them away first
+	 * before checking for a dirty release.  Hence on the first dirty close
+	 * we will still remove the speculative allocation, but after that we
+	 * will leave it in place.
+	 */
+	if (xfs_iflags_test(ip, XFS_IDIRTY_RELEASE))
+		return 0;
+
+	/*
+	 * If we can't get the iolock just skip truncating the blocks past EOF
+	 * because we could deadlock with the mmap_sem otherwise.  We'll get
+	 * another chance to drop them once the last reference to the inode is
+	 * dropped, so we'll never leak blocks permanently.
+	 */
+	if (xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL)) {
+		xfs_free_eofblocks(ip);
+		xfs_iunlock(ip, XFS_IOLOCK_EXCL);
+	}
+
+	/*
+	 * Delalloc blocks after truncation means it really is dirty.
+	 */
+	if (ip->i_delayed_blks)
+		xfs_iflags_set(ip, XFS_IDIRTY_RELEASE);
+	return 0;
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index cdb97fa027fa..b0e85b7b8dc3 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1590,86 +1590,6 @@ xfs_itruncate_extents_flags(
 	return error;
 }
 
-int
-xfs_release(
-	xfs_inode_t	*ip)
-{
-	xfs_mount_t	*mp = ip->i_mount;
-	int		error;
-
-	if (!S_ISREG(VFS_I(ip)->i_mode) || (VFS_I(ip)->i_mode == 0))
-		return 0;
-
-	/* If this is a read-only mount, don't do this (would generate I/O) */
-	if (mp->m_flags & XFS_MOUNT_RDONLY)
-		return 0;
-
-	if (!XFS_FORCED_SHUTDOWN(mp)) {
-		int truncated;
-
-		/*
-		 * If we previously truncated this file and removed old data
-		 * in the process, we want to initiate "early" writeout on
-		 * the last close.  This is an attempt to combat the notorious
-		 * NULL files problem which is particularly noticeable from a
-		 * truncate down, buffered (re-)write (delalloc), followed by
-		 * a crash.  What we are effectively doing here is
-		 * significantly reducing the time window where we'd otherwise
-		 * be exposed to that problem.
-		 */
-		truncated = xfs_iflags_test_and_clear(ip, XFS_ITRUNCATED);
-		if (truncated) {
-			xfs_iflags_clear(ip, XFS_IDIRTY_RELEASE);
-			if (ip->i_delayed_blks > 0) {
-				error = filemap_flush(VFS_I(ip)->i_mapping);
-				if (error)
-					return error;
-			}
-		}
-	}
-
-	if (VFS_I(ip)->i_nlink == 0)
-		return 0;
-
-	if (xfs_can_free_eofblocks(ip, false)) {
-
-		/*
-		 * Check if the inode is being opened, written and closed
-		 * frequently and we have delayed allocation blocks outstanding
-		 * (e.g. streaming writes from the NFS server), truncating the
-		 * blocks past EOF will cause fragmentation to occur.
-		 *
-		 * In this case don't do the truncation, but we have to be
-		 * careful how we detect this case. Blocks beyond EOF show up as
-		 * i_delayed_blks even when the inode is clean, so we need to
-		 * truncate them away first before checking for a dirty release.
-		 * Hence on the first dirty close we will still remove the
-		 * speculative allocation, but after that we will leave it in
-		 * place.
-		 */
-		if (xfs_iflags_test(ip, XFS_IDIRTY_RELEASE))
-			return 0;
-		/*
-		 * If we can't get the iolock just skip truncating the blocks
-		 * past EOF because we could deadlock with the mmap_sem
-		 * otherwise. We'll get another chance to drop them once the
-		 * last reference to the inode is dropped, so we'll never leak
-		 * blocks permanently.
-		 */
-		if (xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL)) {
-			error = xfs_free_eofblocks(ip);
-			xfs_iunlock(ip, XFS_IOLOCK_EXCL);
-			if (error)
-				return error;
-		}
-
-		/* delalloc blocks after truncation means it really is dirty */
-		if (ip->i_delayed_blks)
-			xfs_iflags_set(ip, XFS_IDIRTY_RELEASE);
-	}
-	return 0;
-}
-
 /*
  * xfs_inactive_truncate
  *
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 558173f95a03..4299905135b2 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -410,7 +410,6 @@ enum layout_break_reason {
 	(((pip)->i_mount->m_flags & XFS_MOUNT_GRPID) || \
 	 (VFS_I(pip)->i_mode & S_ISGID))
 
-int		xfs_release(struct xfs_inode *ip);
 void		xfs_inactive(struct xfs_inode *ip);
 int		xfs_lookup(struct xfs_inode *dp, struct xfs_name *name,
 			   struct xfs_inode **ipp, struct xfs_name *ci_name);
-- 
2.20.1

