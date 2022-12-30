Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAEA659EC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiL3XvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiL3XvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:51:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB664262A;
        Fri, 30 Dec 2022 15:51:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1632B81DCA;
        Fri, 30 Dec 2022 23:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BAFC433D2;
        Fri, 30 Dec 2022 23:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444271;
        bh=6E8jbKf7iy1+nbQHRKu7MpZkjsB/2aoy1V0uNTM6rIM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kJ3Fvu5GjMzcMVl3jyibRIlIRrAZtio1jsftWP6Yp5x5zXEzBw7JGuzc1rakdjqhH
         BV7mrjVG8GVHQCwXYvmtG0i828O776ZE6VJxGCoBt6t7UjRTTIag+GB0Npv7XgLMat
         sRpXUEoXR9pzXWZvklhut8crgg0bdtgvntDbB+AbM3PRso/LYhFGXrFvXJDDsrPmCT
         HKfJ7H+4oYIrFtQsT/dmMG98sBK48fvbCK8qfb/29IqrmMv+5A5KEBXbQZs/J8Sgjw
         NYv2cYM9t7hgut6l+tYU3eGymu8ulau4N1x4rfAqOSVeNcvMUeudVD+Iy3jg8zGgZO
         DCJYLDK/wZP1w==
Subject: [PATCH 04/21] xfs: parameterize all the incompat log feature helpers
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:55 -0800
Message-ID: <167243843579.699466.1331325312571395676.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

We're about to define a new XFS_SB_FEAT_INCOMPAT_LOG_ bit, which means
that callers will soon require the ability to toggle on and off
different log incompat feature bits.  Parameterize the
xlog_{use,drop}_incompat_feat and xfs_sb_remove_incompat_log_features
functions so that callers can specify which feature they're trying to
use and so that we can clear individual log incompat bits as needed.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h |    5 +++--
 fs/xfs/xfs_log.c           |   34 +++++++++++++++++++++++++---------
 fs/xfs/xfs_log.h           |    9 ++++++---
 fs/xfs/xfs_log_priv.h      |    2 +-
 fs/xfs/xfs_log_recover.c   |    3 ++-
 fs/xfs/xfs_mount.c         |   11 +++++------
 fs/xfs/xfs_mount.h         |    2 +-
 fs/xfs/xfs_xattr.c         |    6 +++---
 8 files changed, 46 insertions(+), 26 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 5ba2dae7aa2f..817adb36cb1e 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -404,9 +404,10 @@ xfs_sb_has_incompat_log_feature(
 
 static inline void
 xfs_sb_remove_incompat_log_features(
-	struct xfs_sb	*sbp)
+	struct xfs_sb	*sbp,
+	uint32_t	feature)
 {
-	sbp->sb_features_log_incompat &= ~XFS_SB_FEAT_INCOMPAT_LOG_ALL;
+	sbp->sb_features_log_incompat &= ~feature;
 }
 
 static inline void
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index b32a8e57f576..a0ef09addc84 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1082,7 +1082,7 @@ xfs_log_quiesce(
 	 * failures, though it's not fatal to have a higher log feature
 	 * protection level than the log contents actually require.
 	 */
-	if (xfs_clear_incompat_log_features(mp)) {
+	if (xfs_clear_incompat_log_features(mp, XFS_SB_FEAT_INCOMPAT_LOG_ALL)) {
 		int error;
 
 		error = xfs_sync_sb(mp, false);
@@ -1489,6 +1489,7 @@ xlog_clear_incompat(
 	struct xlog		*log)
 {
 	struct xfs_mount	*mp = log->l_mp;
+	uint32_t		incompat_mask = 0;
 
 	if (!xfs_sb_has_incompat_log_feature(&mp->m_sb,
 				XFS_SB_FEAT_INCOMPAT_LOG_ALL))
@@ -1497,11 +1498,16 @@ xlog_clear_incompat(
 	if (log->l_covered_state != XLOG_STATE_COVER_DONE2)
 		return;
 
-	if (!down_write_trylock(&log->l_incompat_users))
+	if (down_write_trylock(&log->l_incompat_xattrs))
+		incompat_mask |= XFS_SB_FEAT_INCOMPAT_LOG_XATTRS;
+
+	if (!incompat_mask)
 		return;
 
-	xfs_clear_incompat_log_features(mp);
-	up_write(&log->l_incompat_users);
+	xfs_clear_incompat_log_features(mp, incompat_mask);
+
+	if (incompat_mask & XFS_SB_FEAT_INCOMPAT_LOG_XATTRS)
+		up_write(&log->l_incompat_xattrs);
 }
 
 /*
@@ -1618,7 +1624,7 @@ xlog_alloc_log(
 	}
 	log->l_sectBBsize = 1 << log2_size;
 
-	init_rwsem(&log->l_incompat_users);
+	init_rwsem(&log->l_incompat_xattrs);
 
 	xlog_get_iclog_buffer_size(mp, log);
 
@@ -3909,15 +3915,25 @@ xfs_log_check_lsn(
  */
 void
 xlog_use_incompat_feat(
-	struct xlog		*log)
+	struct xlog		*log,
+	enum xlog_incompat_feat	what)
 {
-	down_read(&log->l_incompat_users);
+	switch (what) {
+	case XLOG_INCOMPAT_FEAT_XATTRS:
+		down_read(&log->l_incompat_xattrs);
+		break;
+	}
 }
 
 /* Notify the log that we've finished using log incompat features. */
 void
 xlog_drop_incompat_feat(
-	struct xlog		*log)
+	struct xlog		*log,
+	enum xlog_incompat_feat	what)
 {
-	up_read(&log->l_incompat_users);
+	switch (what) {
+	case XLOG_INCOMPAT_FEAT_XATTRS:
+		up_read(&log->l_incompat_xattrs);
+		break;
+	}
 }
diff --git a/fs/xfs/xfs_log.h b/fs/xfs/xfs_log.h
index 2728886c2963..d187f6445909 100644
--- a/fs/xfs/xfs_log.h
+++ b/fs/xfs/xfs_log.h
@@ -159,8 +159,11 @@ bool	xfs_log_check_lsn(struct xfs_mount *, xfs_lsn_t);
 xfs_lsn_t xlog_grant_push_threshold(struct xlog *log, int need_bytes);
 bool	  xlog_force_shutdown(struct xlog *log, uint32_t shutdown_flags);
 
-void xlog_use_incompat_feat(struct xlog *log);
-void xlog_drop_incompat_feat(struct xlog *log);
-int xfs_attr_use_log_assist(struct xfs_mount *mp);
+enum xlog_incompat_feat {
+	XLOG_INCOMPAT_FEAT_XATTRS = XFS_SB_FEAT_INCOMPAT_LOG_XATTRS,
+};
+
+void xlog_use_incompat_feat(struct xlog *log, enum xlog_incompat_feat what);
+void xlog_drop_incompat_feat(struct xlog *log, enum xlog_incompat_feat what);
 
 #endif	/* __XFS_LOG_H__ */
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 1bd2963e8fbd..a13b5b6b744d 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -447,7 +447,7 @@ struct xlog {
 	uint32_t		l_iclog_roundoff;/* padding roundoff */
 
 	/* Users of log incompat features should take a read lock. */
-	struct rw_semaphore	l_incompat_users;
+	struct rw_semaphore	l_incompat_xattrs;
 };
 
 /*
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 6b1f37bc3e95..81ce08c23306 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3473,7 +3473,8 @@ xlog_recover_finish(
 	 * longer anything to protect.  We rely on the AIL push to write out the
 	 * updated superblock after everything else.
 	 */
-	if (xfs_clear_incompat_log_features(log->l_mp)) {
+	if (xfs_clear_incompat_log_features(log->l_mp,
+				XFS_SB_FEAT_INCOMPAT_LOG_ALL)) {
 		error = xfs_sync_sb(log->l_mp, false);
 		if (error < 0) {
 			xfs_alert(log->l_mp,
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 31f49211fdd6..54cd47882991 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1357,13 +1357,13 @@ xfs_add_incompat_log_feature(
  */
 bool
 xfs_clear_incompat_log_features(
-	struct xfs_mount	*mp)
+	struct xfs_mount	*mp,
+	uint32_t		features)
 {
 	bool			ret = false;
 
 	if (!xfs_has_crc(mp) ||
-	    !xfs_sb_has_incompat_log_feature(&mp->m_sb,
-				XFS_SB_FEAT_INCOMPAT_LOG_ALL) ||
+	    !xfs_sb_has_incompat_log_feature(&mp->m_sb, features) ||
 	    xfs_is_shutdown(mp))
 		return false;
 
@@ -1375,9 +1375,8 @@ xfs_clear_incompat_log_features(
 	xfs_buf_lock(mp->m_sb_bp);
 	xfs_buf_hold(mp->m_sb_bp);
 
-	if (xfs_sb_has_incompat_log_feature(&mp->m_sb,
-				XFS_SB_FEAT_INCOMPAT_LOG_ALL)) {
-		xfs_sb_remove_incompat_log_features(&mp->m_sb);
+	if (xfs_sb_has_incompat_log_feature(&mp->m_sb, features)) {
+		xfs_sb_remove_incompat_log_features(&mp->m_sb, features);
 		ret = true;
 	}
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index ec8b185d45f8..7c48a2b70f6f 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -547,7 +547,7 @@ struct xfs_error_cfg * xfs_error_get_cfg(struct xfs_mount *mp,
 		int error_class, int error);
 void xfs_force_summary_recalc(struct xfs_mount *mp);
 int xfs_add_incompat_log_feature(struct xfs_mount *mp, uint32_t feature);
-bool xfs_clear_incompat_log_features(struct xfs_mount *mp);
+bool xfs_clear_incompat_log_features(struct xfs_mount *mp, uint32_t feature);
 void xfs_mod_delalloc(struct xfs_mount *mp, int64_t delta);
 
 #endif	/* __XFS_MOUNT_H__ */
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 10aa1fd39d2b..e03f199f50c7 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -37,7 +37,7 @@ xfs_attr_grab_log_assist(
 	 * Protect ourselves from an idle log clearing the logged xattrs log
 	 * incompat feature bit.
 	 */
-	xlog_use_incompat_feat(mp->m_log);
+	xlog_use_incompat_feat(mp->m_log, XLOG_INCOMPAT_FEAT_XATTRS);
 
 	/*
 	 * If log-assisted xattrs are already enabled, the caller can use the
@@ -57,7 +57,7 @@ xfs_attr_grab_log_assist(
 
 	return 0;
 drop_incompat:
-	xlog_drop_incompat_feat(mp->m_log);
+	xlog_drop_incompat_feat(mp->m_log, XLOG_INCOMPAT_FEAT_XATTRS);
 	return error;
 }
 
@@ -65,7 +65,7 @@ static inline void
 xfs_attr_rele_log_assist(
 	struct xfs_mount	*mp)
 {
-	xlog_drop_incompat_feat(mp->m_log);
+	xlog_drop_incompat_feat(mp->m_log, XLOG_INCOMPAT_FEAT_XATTRS);
 }
 
 static inline bool

