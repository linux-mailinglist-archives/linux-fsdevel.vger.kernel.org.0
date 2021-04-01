Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42325350B8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhDABJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhDABJF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7208261059;
        Thu,  1 Apr 2021 01:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239344;
        bh=LQ2Jixpq/Q2X9GM6a1vOWfK8/PmPYuhw4i8Q4kSwSjY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gc5510UfO7fQXbbQFtT8lUCbfZ8fg7IhzB49/EzmgqlJy/84Gel6mhuULCtfOtYSW
         k0VkVqWNLbarWqUbrLa9HZ5kSd9TDBxKZZDD5wVmOZNzzXTvVrn4h/XimdLc5klthb
         5U/WUNPSRVoPaJDNm6++dgQsqU7aKF2EVOcOSCvPTQ2SEd5y4ZPHNp3MOrZ7bpHRSg
         JSsSCenmw81T4McaOEVdQZigP/3gNkSCc1AR+k60ymn4ZCWoHTLh9MX5AFJJKHSofz
         WKuX7Bsp+qXDomOJi9X8G0Dex7OVHizOA/RhI8YDbfwjPy+RfuMSWTXVeVy5n76DGD
         8QerviyKu+GJw==
Subject: [PATCH 03/18] xfs: allow setting and clearing of log incompat feature
 flags
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:03 -0700
Message-ID: <161723934343.3149451.16679733325094950568.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Log incompat feature flags in the superblock exist for one purpose: to
protect the contents of a dirty log from replay on a kernel that isn't
prepared to handle those dirty contents.  This means that they can be
cleared if (a) we know the log is clean and (b) we know that there
aren't any other threads in the system that might be setting or relying
upon a log incompat flag.

Therefore, clear the log incompat flags when we've finished recovering
the log, when we're unmounting cleanly, remounting read-only, or
freezing; and provide a function so that subsequent patches can start
using this.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h |   15 ++++++
 fs/xfs/xfs_log.c           |   14 ++++++
 fs/xfs/xfs_log_recover.c   |   16 ++++++
 fs/xfs/xfs_mount.c         |  110 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h         |    2 +
 5 files changed, 157 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 9620795a6e08..7e9c964772c9 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -495,6 +495,21 @@ xfs_sb_has_incompat_log_feature(
 	return (sbp->sb_features_log_incompat & feature) != 0;
 }
 
+static inline void
+xfs_sb_remove_incompat_log_features(
+	struct xfs_sb	*sbp)
+{
+	sbp->sb_features_log_incompat &= ~XFS_SB_FEAT_INCOMPAT_LOG_ALL;
+}
+
+static inline void
+xfs_sb_add_incompat_log_features(
+	struct xfs_sb	*sbp,
+	unsigned int	features)
+{
+	sbp->sb_features_log_incompat |= features;
+}
+
 /*
  * V5 superblock specific feature checks
  */
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 06041834daa3..cf73bc9f4d18 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -945,6 +945,20 @@ int
 xfs_log_quiesce(
 	struct xfs_mount	*mp)
 {
+	/*
+	 * Clear log incompat features since we're quiescing the log.  Report
+	 * failures, though it's not fatal to have a higher log feature
+	 * protection level than the log contents actually require.
+	 */
+	if (xfs_clear_incompat_log_features(mp)) {
+		int error;
+
+		error = xfs_sync_sb(mp, false);
+		if (error)
+			xfs_warn(mp,
+	"Failed to clear log incompat features on quiesce");
+	}
+
 	cancel_delayed_work_sync(&mp->m_log->l_work);
 	xfs_log_force(mp, XFS_LOG_SYNC);
 
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index ce1a7928eb2d..fdba9b55822e 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3480,6 +3480,22 @@ xlog_recover_finish(
 		 */
 		xfs_log_force(log->l_mp, XFS_LOG_SYNC);
 
+		/*
+		 * Now that we've recovered the log and all the intents, we can
+		 * clear the log incompat feature bits in the superblock
+		 * because there's no longer anything to protect.  We rely on
+		 * the AIL push to write out the updated superblock after
+		 * everything else.
+		 */
+		if (xfs_clear_incompat_log_features(log->l_mp)) {
+			error = xfs_sync_sb(log->l_mp, false);
+			if (error < 0) {
+				xfs_alert(log->l_mp,
+	"Failed to clear log incompat features on recovery");
+				return error;
+			}
+		}
+
 		xlog_recover_process_iunlinks(log);
 
 		xlog_recover_check_summary(log);
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index b7e653180d22..f16036e1986b 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1333,6 +1333,116 @@ xfs_force_summary_recalc(
 	xfs_fs_mark_checked(mp, XFS_SICK_FS_COUNTERS);
 }
 
+/*
+ * Enable a log incompat feature flag in the primary superblock.  The caller
+ * cannot have any other transactions in progress.
+ */
+int
+xfs_add_incompat_log_feature(
+	struct xfs_mount	*mp,
+	uint32_t		feature)
+{
+	struct xfs_dsb		*dsb;
+	int			error;
+
+	ASSERT(hweight32(feature) == 1);
+	ASSERT(!(feature & XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN));
+
+	/*
+	 * Force the log to disk and kick the background AIL thread to reduce
+	 * the chances that the bwrite will stall waiting for the AIL to unpin
+	 * the primary superblock buffer.  This isn't a data integrity
+	 * operation, so we don't need a synchronous push.
+	 */
+	error = xfs_log_force(mp, XFS_LOG_SYNC);
+	if (error)
+		return error;
+	xfs_ail_push_all(mp->m_ail);
+
+	/*
+	 * Lock the primary superblock buffer to serialize all callers that
+	 * are trying to set feature bits.
+	 */
+	xfs_buf_lock(mp->m_sb_bp);
+	xfs_buf_hold(mp->m_sb_bp);
+
+	if (XFS_FORCED_SHUTDOWN(mp)) {
+		error = -EIO;
+		goto rele;
+	}
+
+	if (xfs_sb_has_incompat_log_feature(&mp->m_sb, feature))
+		goto rele;
+
+	/*
+	 * Write the primary superblock to disk immediately, because we need
+	 * the log_incompat bit to be set in the primary super now to protect
+	 * the log items that we're going to commit later.
+	 */
+	dsb = mp->m_sb_bp->b_addr;
+	xfs_sb_to_disk(dsb, &mp->m_sb);
+	dsb->sb_features_log_incompat |= cpu_to_be32(feature);
+	error = xfs_bwrite(mp->m_sb_bp);
+	if (error)
+		goto shutdown;
+
+	/*
+	 * Add the feature bits to the incore superblock before we unlock the
+	 * buffer.
+	 */
+	xfs_sb_add_incompat_log_features(&mp->m_sb, feature);
+	xfs_buf_relse(mp->m_sb_bp);
+
+	/* Log the superblock to disk. */
+	return xfs_sync_sb(mp, false);
+shutdown:
+	xfs_force_shutdown(mp, SHUTDOWN_META_IO_ERROR);
+rele:
+	xfs_buf_relse(mp->m_sb_bp);
+	return error;
+}
+
+/*
+ * Clear all the log incompat flags from the superblock.
+ *
+ * The caller cannot be in a transaction, must ensure that the log does not
+ * contain any log items protected by any log incompat bit, and must ensure
+ * that there are no other threads that depend on the state of the log incompat
+ * feature flags in the primary super.
+ *
+ * Returns true if the superblock is dirty.
+ */
+bool
+xfs_clear_incompat_log_features(
+	struct xfs_mount	*mp)
+{
+	bool			ret = false;
+
+	if (!xfs_sb_version_hascrc(&mp->m_sb) ||
+	    !xfs_sb_has_incompat_log_feature(&mp->m_sb,
+				XFS_SB_FEAT_INCOMPAT_LOG_ALL) ||
+	    XFS_FORCED_SHUTDOWN(mp))
+		return false;
+
+	/*
+	 * Update the incore superblock.  We synchronize on the primary super
+	 * buffer lock to be consistent with the add function, though at least
+	 * in theory this shouldn't be necessary.
+	 */
+	xfs_buf_lock(mp->m_sb_bp);
+	xfs_buf_hold(mp->m_sb_bp);
+
+	if (xfs_sb_has_incompat_log_feature(&mp->m_sb,
+				XFS_SB_FEAT_INCOMPAT_LOG_ALL)) {
+		xfs_info(mp, "Clearing log incompat feature flags.");
+		xfs_sb_remove_incompat_log_features(&mp->m_sb);
+		ret = true;
+	}
+
+	xfs_buf_relse(mp->m_sb_bp);
+	return ret;
+}
+
 /*
  * Update the in-core delayed block counter.
  *
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 63d0dc1b798d..eb45684b186a 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -453,6 +453,8 @@ int	xfs_zero_extent(struct xfs_inode *ip, xfs_fsblock_t start_fsb,
 struct xfs_error_cfg * xfs_error_get_cfg(struct xfs_mount *mp,
 		int error_class, int error);
 void xfs_force_summary_recalc(struct xfs_mount *mp);
+int xfs_add_incompat_log_feature(struct xfs_mount *mp, uint32_t feature);
+bool xfs_clear_incompat_log_features(struct xfs_mount *mp);
 void xfs_mod_delalloc(struct xfs_mount *mp, int64_t delta);
 
 void xfs_hook_init(struct xfs_hook_chain *chain);

