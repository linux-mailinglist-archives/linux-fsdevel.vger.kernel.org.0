Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5B5939C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 07:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfF1Fqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 01:46:54 -0400
Received: from verein.lst.de ([213.95.11.210]:45106 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfF1Fqy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:46:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 350AF68C7B; Fri, 28 Jun 2019 07:37:17 +0200 (CEST)
Date:   Fri, 28 Jun 2019 07:37:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] xfs: remove XFS_TRANS_NOFS
Message-ID: <20190628053717.GB26902@lst.de>
References: <20190627104836.25446-1-hch@lst.de> <20190627104836.25446-7-hch@lst.de> <20190627223030.GS5171@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627223030.GS5171@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 03:30:30PM -0700, Darrick J. Wong wrote:
> I think the wording of this is too indirect.  The reason we need to set
> NOFS is because we could be doing writeback as part of reclaiming
> memory, which means that we cannot recurse back into filesystems to
> satisfy the memory allocation needed to create a transaction.  The NOFS
> part applies to any memory allocation, of course.
> 
> If you're fine with the wording below I'll just edit that into the
> patch:
> 
> 	/*
> 	 * We can allocate memory here while doing writeback on behalf of
> 	 * memory reclaim.  To avoid memory allocation deadlocks set the
> 	 * task-wide nofs context for the following operations.
> 	 */
> 	nofs_flag = memalloc_nofs_save();

Fine with me.

> >  	trace_xfs_end_io_direct_write(ip, offset, size);
> > @@ -395,10 +396,11 @@ xfs_dio_write_end_io(
> >  	 */
> >  	XFS_STATS_ADD(ip->i_mount, xs_write_bytes, size);
> >  
> > +	nofs_flag = memalloc_nofs_save();
> 
> Hmm, do we need this here?  I can't remember if there was a need for
> setting NOFS under xfs_reflink_end_cow from a dio completion or if that
> was purely the buffered writeback case...

We certainly had to add it for the unwritten extent conversion, maybe
the corner case just didn't manage to show up for COW yet:


commit 80641dc66a2d6dfb22af4413227a92b8ab84c7bb
Author: Christoph Hellwig <hch@infradead.org>
Date:   Mon Oct 19 04:00:03 2009 +0000

    xfs: I/O completion handlers must use NOFS allocations
    
    When completing I/O requests we must not allow the memory allocator to
    recurse into the filesystem, as we might deadlock on waiting for the
    I/O completion otherwise.  The only thing currently allocating normal
    GFP_KERNEL memory is the allocation of the transaction structure for
    the unwritten extent conversion.  Add a memflags argument to
    _xfs_trans_alloc to allow controlling the allocator behaviour.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reported-by: Thomas Neumann <tneumann@users.sourceforge.net>
    Tested-by: Thomas Neumann <tneumann@users.sourceforge.net>
    Reviewed-by: Alex Elder <aelder@sgi.com>
    Signed-off-by: Alex Elder <aelder@sgi.com>

diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 2d0b3e1da9e6..6f83f58c099f 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -611,7 +611,7 @@ xfs_fs_log_dummy(
 	xfs_inode_t	*ip;
 	int		error;
 
-	tp = _xfs_trans_alloc(mp, XFS_TRANS_DUMMY1);
+	tp = _xfs_trans_alloc(mp, XFS_TRANS_DUMMY1, KM_SLEEP);
 	error = xfs_trans_reserve(tp, 0, XFS_ICHANGE_LOG_RES(mp), 0, 0, 0);
 	if (error) {
 		xfs_trans_cancel(tp, 0);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 67ae5555a30a..7294abce6ef2 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -860,8 +860,15 @@ xfs_iomap_write_unwritten(
 		 * set up a transaction to convert the range of extents
 		 * from unwritten to real. Do allocations in a loop until
 		 * we have covered the range passed in.
+		 *
+		 * Note that we open code the transaction allocation here
+		 * to pass KM_NOFS--we can't risk to recursing back into
+		 * the filesystem here as we might be asked to write out
+		 * the same inode that we complete here and might deadlock
+		 * on the iolock.
 		 */
-		tp = xfs_trans_alloc(mp, XFS_TRANS_STRAT_WRITE);
+		xfs_wait_for_freeze(mp, SB_FREEZE_TRANS);
+		tp = _xfs_trans_alloc(mp, XFS_TRANS_STRAT_WRITE, KM_NOFS);
 		tp->t_flags |= XFS_TRANS_RESERVE;
 		error = xfs_trans_reserve(tp, resblks,
 				XFS_WRITE_LOG_RES(mp), 0,
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 8b6c9e807efb..4d509f742bd2 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1471,7 +1471,7 @@ xfs_log_sbcount(
 	if (!xfs_sb_version_haslazysbcount(&mp->m_sb))
 		return 0;
 
-	tp = _xfs_trans_alloc(mp, XFS_TRANS_SB_COUNT);
+	tp = _xfs_trans_alloc(mp, XFS_TRANS_SB_COUNT, KM_SLEEP);
 	error = xfs_trans_reserve(tp, 0, mp->m_sb.sb_sectsize + 128, 0, 0,
 					XFS_DEFAULT_LOG_COUNT);
 	if (error) {
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 66b849358e62..237badcbac3b 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -236,19 +236,20 @@ xfs_trans_alloc(
 	uint		type)
 {
 	xfs_wait_for_freeze(mp, SB_FREEZE_TRANS);
-	return _xfs_trans_alloc(mp, type);
+	return _xfs_trans_alloc(mp, type, KM_SLEEP);
 }
 
 xfs_trans_t *
 _xfs_trans_alloc(
 	xfs_mount_t	*mp,
-	uint		type)
+	uint		type,
+	uint		memflags)
 {
 	xfs_trans_t	*tp;
 
 	atomic_inc(&mp->m_active_trans);
 
-	tp = kmem_zone_zalloc(xfs_trans_zone, KM_SLEEP);
+	tp = kmem_zone_zalloc(xfs_trans_zone, memflags);
 	tp->t_magic = XFS_TRANS_MAGIC;
 	tp->t_type = type;
 	tp->t_mountp = mp;
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index ed47fc77759c..a0574f593f52 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -924,7 +924,7 @@ typedef struct xfs_trans {
  * XFS transaction mechanism exported interfaces.
  */
 xfs_trans_t	*xfs_trans_alloc(struct xfs_mount *, uint);
-xfs_trans_t	*_xfs_trans_alloc(struct xfs_mount *, uint);
+xfs_trans_t	*_xfs_trans_alloc(struct xfs_mount *, uint, uint);
 xfs_trans_t	*xfs_trans_dup(xfs_trans_t *);
 int		xfs_trans_reserve(xfs_trans_t *, uint, uint, uint,
 				  uint, uint);
