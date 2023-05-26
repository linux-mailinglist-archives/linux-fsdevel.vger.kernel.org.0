Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA1711C01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjEZBF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjEZBFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:05:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A5F125;
        Thu, 25 May 2023 18:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0752560C3F;
        Fri, 26 May 2023 01:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693E5C433D2;
        Fri, 26 May 2023 01:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063122;
        bh=Op/+e031SmaVVcRXMMAFCXNHvL6xt1AEkE6Rd8qXEOY=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=TJgcl1smDJw0cROFIH4qrn0LRF3AlQ3GuDu5i+Yqz5N4fXc0SzpkRkAEIr7j/YsKk
         4N3UfEMt0hHoGixNiftYx6ZizK8Ap9fU6U2qW41a1LZrR6/d8+LLGJPc633DrOoIvU
         uT3Z/7zR3go1ZhLntidJCh4WZgEQspSM3lh9zGOua+9Q8dW8naNjnQUQr98/z9RTQJ
         cE4ZGicEkweNeTqn538ltFt4HzeQAKMTsog/8bCSHURuHS3IHoAe87K+KtpUyqNXue
         ZeO2LYfrxlazdcszy0WJRgfXmo9xniKIf9hfWm8NYCfbKtBnqOXeyBOBpSvATJxS+G
         Srxo9AAbtFSGg==
Date:   Thu, 25 May 2023 18:05:22 -0700
Subject: [PATCH 3/9] xfs: create buftarg helpers to abstract block_device
 operations
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506061894.3733082.5871675246659728914.stgit@frogsfrogsfrogs>
In-Reply-To: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
References: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

In the next few patches, we're going into introduce buffer targets that
are not block devices.  Introduce block_device helpers so that the
compiler can check that we're not feeding an xfile object to something
expecting a block device.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_aops.c        |    5 ++++-
 fs/xfs/xfs_bmap_util.c   |    8 ++++----
 fs/xfs/xfs_buf.h         |   37 +++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_discard.c     |    8 ++++----
 fs/xfs/xfs_file.c        |    6 +++---
 fs/xfs/xfs_ioctl.c       |    3 ++-
 fs/xfs/xfs_iomap.c       |    4 ++--
 fs/xfs/xfs_log.c         |    4 ++--
 fs/xfs/xfs_log_cil.c     |    3 ++-
 fs/xfs/xfs_log_recover.c |    3 ++-
 fs/xfs/xfs_super.c       |    4 ++--
 11 files changed, 62 insertions(+), 23 deletions(-)


diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2ef78aa1d3f6..90f9fdbda20b 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -569,7 +569,10 @@ xfs_iomap_swapfile_activate(
 	struct file			*swap_file,
 	sector_t			*span)
 {
-	sis->bdev = xfs_inode_buftarg(XFS_I(file_inode(swap_file)))->bt_bdev;
+	struct xfs_inode		*ip = XFS_I(file_inode(swap_file));
+	struct xfs_buftarg		*btp = xfs_inode_buftarg(ip);
+
+	sis->bdev = xfs_buftarg_bdev(btp);
 	return iomap_swapfile_activate(sis, swap_file, span,
 			&xfs_read_iomap_ops);
 }
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fbb675563208..a847dbd76537 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -62,10 +62,10 @@ xfs_zero_extent(
 	xfs_daddr_t		sector = xfs_fsb_to_db(ip, start_fsb);
 	sector_t		block = XFS_BB_TO_FSBT(mp, sector);
 
-	return blkdev_issue_zeroout(target->bt_bdev,
-		block << (mp->m_super->s_blocksize_bits - 9),
-		count_fsb << (mp->m_super->s_blocksize_bits - 9),
-		GFP_NOFS, 0);
+	return xfs_buftarg_zeroout(target,
+			block << (mp->m_super->s_blocksize_bits - 9),
+			count_fsb << (mp->m_super->s_blocksize_bits - 9),
+			GFP_NOFS, 0);
 }
 
 #ifdef CONFIG_XFS_RT
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d17ec9274d99..dd7964bc76d7 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -378,8 +378,41 @@ extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
 extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
 
-#define xfs_getsize_buftarg(buftarg)	block_size((buftarg)->bt_bdev)
-#define xfs_readonly_buftarg(buftarg)	bdev_read_only((buftarg)->bt_bdev)
+static inline struct block_device *
+xfs_buftarg_bdev(struct xfs_buftarg *btp)
+{
+	return btp->bt_bdev;
+}
+
+static inline unsigned int
+xfs_getsize_buftarg(struct xfs_buftarg *btp)
+{
+	return block_size(btp->bt_bdev);
+}
+
+static inline bool
+xfs_readonly_buftarg(struct xfs_buftarg *btp)
+{
+	return bdev_read_only(btp->bt_bdev);
+}
+
+static inline int
+xfs_buftarg_flush(struct xfs_buftarg *btp)
+{
+	return blkdev_issue_flush(btp->bt_bdev);
+}
+
+static inline int
+xfs_buftarg_zeroout(
+	struct xfs_buftarg	*btp,
+	sector_t		sector,
+	sector_t		nr_sects,
+	gfp_t			gfp_mask,
+	unsigned		flags)
+{
+	return blkdev_issue_zeroout(btp->bt_bdev, sector, nr_sects, gfp_mask,
+			flags);
+}
 
 int xfs_buf_reverify(struct xfs_buf *bp, const struct xfs_buf_ops *ops);
 bool xfs_verify_magic(struct xfs_buf *bp, __be32 dmagic);
diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 96f2263fe9b7..3d074d094bf4 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -29,7 +29,7 @@ xfs_trim_extents(
 	uint64_t		*blocks_trimmed)
 {
 	struct xfs_mount	*mp = pag->pag_mount;
-	struct block_device	*bdev = mp->m_ddev_targp->bt_bdev;
+	struct block_device	*bdev = xfs_buftarg_bdev(mp->m_ddev_targp);
 	struct xfs_btree_cur	*cur;
 	struct xfs_buf		*agbp;
 	struct xfs_agf		*agf;
@@ -150,8 +150,8 @@ xfs_ioc_trim(
 	struct fstrim_range __user	*urange)
 {
 	struct xfs_perag	*pag;
-	unsigned int		granularity =
-		bdev_discard_granularity(mp->m_ddev_targp->bt_bdev);
+	struct block_device	*bdev = xfs_buftarg_bdev(mp->m_ddev_targp);
+	unsigned int		granularity = bdev_discard_granularity(bdev);
 	struct fstrim_range	range;
 	xfs_daddr_t		start, end, minlen;
 	xfs_agnumber_t		agno;
@@ -160,7 +160,7 @@ xfs_ioc_trim(
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (!bdev_max_discard_sectors(mp->m_ddev_targp->bt_bdev))
+	if (!bdev_max_discard_sectors(bdev))
 		return -EOPNOTSUPP;
 
 	/*
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index aede746541f8..2380067aa154 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -164,9 +164,9 @@ xfs_file_fsync(
 	 * inode size in case of an extending write.
 	 */
 	if (XFS_IS_REALTIME_INODE(ip))
-		error = blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev);
+		error = xfs_buftarg_flush(mp->m_rtdev_targp);
 	else if (mp->m_logdev_targp != mp->m_ddev_targp)
-		error = blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);
+		error = xfs_buftarg_flush(mp->m_ddev_targp);
 
 	/*
 	 * Any inode that has dirty modifications in the log is pinned.  The
@@ -189,7 +189,7 @@ xfs_file_fsync(
 	 */
 	if (!log_flushed && !XFS_IS_REALTIME_INODE(ip) &&
 	    mp->m_logdev_targp == mp->m_ddev_targp) {
-		err2 = blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);
+		err2 = xfs_buftarg_flush(mp->m_ddev_targp);
 		if (err2 && !error)
 			error = err2;
 	}
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 55bb01173cde..0667e088a289 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1762,6 +1762,7 @@ xfs_ioc_setlabel(
 	char			__user *newlabel)
 {
 	struct xfs_sb		*sbp = &mp->m_sb;
+	struct block_device	*bdev = xfs_buftarg_bdev(mp->m_ddev_targp);
 	char			label[XFSLABEL_MAX + 1];
 	size_t			len;
 	int			error;
@@ -1808,7 +1809,7 @@ xfs_ioc_setlabel(
 	error = xfs_update_secondary_sbs(mp);
 	mutex_unlock(&mp->m_growlock);
 
-	invalidate_bdev(mp->m_ddev_targp->bt_bdev);
+	invalidate_bdev(bdev);
 
 out:
 	mnt_drop_write_file(filp);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 0ff46e3997e0..559e8e785595 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -129,7 +129,7 @@ xfs_bmbt_to_iomap(
 	if (mapping_flags & IOMAP_DAX)
 		iomap->dax_dev = target->bt_daxdev;
 	else
-		iomap->bdev = target->bt_bdev;
+		iomap->bdev = xfs_buftarg_bdev(target);
 	iomap->flags = iomap_flags;
 
 	if (xfs_ipincount(ip) &&
@@ -154,7 +154,7 @@ xfs_hole_to_iomap(
 	iomap->type = IOMAP_HOLE;
 	iomap->offset = XFS_FSB_TO_B(ip->i_mount, offset_fsb);
 	iomap->length = XFS_FSB_TO_B(ip->i_mount, end_fsb - offset_fsb);
-	iomap->bdev = target->bt_bdev;
+	iomap->bdev = xfs_buftarg_bdev(target);
 	iomap->dax_dev = target->bt_daxdev;
 }
 
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index fc61cc024023..b32a8e57f576 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1938,7 +1938,7 @@ xlog_write_iclog(
 	 * writeback throttle from throttling log writes behind background
 	 * metadata writeback and causing priority inversions.
 	 */
-	bio_init(&iclog->ic_bio, log->l_targ->bt_bdev, iclog->ic_bvec,
+	bio_init(&iclog->ic_bio, xfs_buftarg_bdev(log->l_targ), iclog->ic_bvec,
 		 howmany(count, PAGE_SIZE),
 		 REQ_OP_WRITE | REQ_META | REQ_SYNC | REQ_IDLE);
 	iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart + bno;
@@ -1959,7 +1959,7 @@ xlog_write_iclog(
 		 * avoid shutdown re-entering this path and erroring out again.
 		 */
 		if (log->l_targ != log->l_mp->m_ddev_targp &&
-		    blkdev_issue_flush(log->l_mp->m_ddev_targp->bt_bdev)) {
+		    xfs_buftarg_flush(log->l_mp->m_ddev_targp)) {
 			xlog_force_shutdown(log, SHUTDOWN_LOG_IO_ERROR);
 			return;
 		}
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index eccbfb99e894..12cd2874048f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -742,7 +742,8 @@ xlog_discard_busy_extents(
 		trace_xfs_discard_extent(mp, busyp->agno, busyp->bno,
 					 busyp->length);
 
-		error = __blkdev_issue_discard(mp->m_ddev_targp->bt_bdev,
+		error = __blkdev_issue_discard(
+				xfs_buftarg_bdev(mp->m_ddev_targp),
 				XFS_AGB_TO_DADDR(mp, busyp->agno, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_NOFS, &bio);
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 322eb2ee6c55..6b1f37bc3e95 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -137,7 +137,8 @@ xlog_do_io(
 	nbblks = round_up(nbblks, log->l_sectBBsize);
 	ASSERT(nbblks > 0);
 
-	error = xfs_rw_bdev(log->l_targ->bt_bdev, log->l_logBBstart + blk_no,
+	error = xfs_rw_bdev(xfs_buftarg_bdev(log->l_targ),
+			log->l_logBBstart + blk_no,
 			BBTOB(nbblks), data, op);
 	if (error && !xlog_is_shutdown(log)) {
 		xfs_alert(log->l_mp,
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 67ebb9d5ed21..f661aaaeac35 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -408,13 +408,13 @@ xfs_close_devices(
 	struct xfs_mount	*mp)
 {
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
-		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
+		struct block_device *logdev = xfs_buftarg_bdev(mp->m_logdev_targp);
 
 		xfs_free_buftarg(mp->m_logdev_targp);
 		xfs_blkdev_put(logdev);
 	}
 	if (mp->m_rtdev_targp) {
-		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
+		struct block_device *rtdev = xfs_buftarg_bdev(mp->m_rtdev_targp);
 
 		xfs_free_buftarg(mp->m_rtdev_targp);
 		xfs_blkdev_put(rtdev);

