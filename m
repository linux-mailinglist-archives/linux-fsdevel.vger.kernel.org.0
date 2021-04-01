Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13AC350B8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhDABJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhDABI7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B486861059;
        Thu,  1 Apr 2021 01:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239338;
        bh=189Xjyt2zE8gnXbWMKz7YX6fXDRuvX2WRRq+QhKwu5c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FwVPTtzRCmHVjB6todaQAyXE9rWshqkf+AMjQvjtKBkXYuIXtPKrrF/pueTVKn2g6
         ew3Nk6rngDQ2heSKoICL7sD7kImYR9X6Cly10TCCWFG9NSvMq4xE33Mo1T//iy1ZgT
         KjJM97w4Xg87/Tuuomd+BIFV0bobU/cMDrekFKTLrmaksYU22SibdDNA/f0tIdAO9v
         XrF3G6zwNZG6f8nRj1Br1KWDKGUIRu6bOSgDY7j3EQZZqdaI1UrIe2k+My88Uxfeyo
         pL2MuE+D8zEWasVR0nIZGWQG2mt6LsRW7N/Owi2MuHbEsuU5/WRf+32yOIQYFL6ruI
         gM3B1oVKfoB3w==
Subject: [PATCH 02/18] xfs: support two inodes in the defer capture structure
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:08:57 -0700
Message-ID: <161723933765.3149451.18195162751019604410.stgit@magnolia>
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

Make it so that xfs_defer_ops_capture_and_commit can capture two inodes.
This will be needed by the atomic extent swap log item so that it can
recover an operation involving two inodes.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_defer.c  |   48 ++++++++++++++++++++++++++++++--------------
 fs/xfs/libxfs/xfs_defer.h  |    9 ++++++--
 fs/xfs/xfs_bmap_item.c     |    2 +-
 fs/xfs/xfs_extfree_item.c  |    2 +-
 fs/xfs/xfs_log_recover.c   |   14 ++++++++-----
 fs/xfs/xfs_refcount_item.c |    2 +-
 fs/xfs/xfs_rmap_item.c     |    2 +-
 7 files changed, 52 insertions(+), 27 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index eff4a127188e..a7d1357687d0 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -628,7 +628,8 @@ xfs_defer_move(
 static struct xfs_defer_capture *
 xfs_defer_ops_capture(
 	struct xfs_trans		*tp,
-	struct xfs_inode		*capture_ip)
+	struct xfs_inode		*capture_ip1,
+	struct xfs_inode		*capture_ip2)
 {
 	struct xfs_defer_capture	*dfc;
 
@@ -658,9 +659,13 @@ xfs_defer_ops_capture(
 	 * Grab an extra reference to this inode and attach it to the capture
 	 * structure.
 	 */
-	if (capture_ip) {
-		ihold(VFS_I(capture_ip));
-		dfc->dfc_capture_ip = capture_ip;
+	if (capture_ip1) {
+		ihold(VFS_I(capture_ip1));
+		dfc->dfc_capture_ip1 = capture_ip1;
+	}
+	if (capture_ip2 && capture_ip2 != capture_ip1) {
+		ihold(VFS_I(capture_ip2));
+		dfc->dfc_capture_ip2 = capture_ip2;
 	}
 
 	return dfc;
@@ -673,8 +678,10 @@ xfs_defer_ops_release(
 	struct xfs_defer_capture	*dfc)
 {
 	xfs_defer_cancel_list(mp, &dfc->dfc_dfops);
-	if (dfc->dfc_capture_ip)
-		xfs_irele(dfc->dfc_capture_ip);
+	if (dfc->dfc_capture_ip1)
+		xfs_irele(dfc->dfc_capture_ip1);
+	if (dfc->dfc_capture_ip2)
+		xfs_irele(dfc->dfc_capture_ip2);
 	kmem_free(dfc);
 }
 
@@ -684,22 +691,26 @@ xfs_defer_ops_release(
  * of the deferred ops operate on an inode, the caller must pass in that inode
  * so that the reference can be transferred to the capture structure.  The
  * caller must hold ILOCK_EXCL on the inode, and must unlock it before calling
- * xfs_defer_ops_continue.
+ * xfs_defer_ops_continue.  Do not pass a null capture_ip1 and a non-null
+ * capture_ip2.
  */
 int
 xfs_defer_ops_capture_and_commit(
 	struct xfs_trans		*tp,
-	struct xfs_inode		*capture_ip,
+	struct xfs_inode		*capture_ip1,
+	struct xfs_inode		*capture_ip2,
 	struct list_head		*capture_list)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_defer_capture	*dfc;
 	int				error;
 
-	ASSERT(!capture_ip || xfs_isilocked(capture_ip, XFS_ILOCK_EXCL));
+	ASSERT(!capture_ip1 || xfs_isilocked(capture_ip1, XFS_ILOCK_EXCL));
+	ASSERT(!capture_ip2 || xfs_isilocked(capture_ip2, XFS_ILOCK_EXCL));
+	ASSERT(capture_ip2 == NULL || capture_ip1 != NULL);
 
 	/* If we don't capture anything, commit transaction and exit. */
-	dfc = xfs_defer_ops_capture(tp, capture_ip);
+	dfc = xfs_defer_ops_capture(tp, capture_ip1, capture_ip2);
 	if (!dfc)
 		return xfs_trans_commit(tp);
 
@@ -724,17 +735,24 @@ void
 xfs_defer_ops_continue(
 	struct xfs_defer_capture	*dfc,
 	struct xfs_trans		*tp,
-	struct xfs_inode		**captured_ipp)
+	struct xfs_inode		**captured_ipp1,
+	struct xfs_inode		**captured_ipp2)
 {
 	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
 	ASSERT(!(tp->t_flags & XFS_TRANS_DIRTY));
 
 	/* Lock and join the captured inode to the new transaction. */
-	if (dfc->dfc_capture_ip) {
-		xfs_ilock(dfc->dfc_capture_ip, XFS_ILOCK_EXCL);
-		xfs_trans_ijoin(tp, dfc->dfc_capture_ip, 0);
+	if (dfc->dfc_capture_ip1 && dfc->dfc_capture_ip2) {
+		xfs_lock_two_inodes(dfc->dfc_capture_ip1, XFS_ILOCK_EXCL,
+				    dfc->dfc_capture_ip2, XFS_ILOCK_EXCL);
+		xfs_trans_ijoin(tp, dfc->dfc_capture_ip1, 0);
+		xfs_trans_ijoin(tp, dfc->dfc_capture_ip2, 0);
+	} else if (dfc->dfc_capture_ip1) {
+		xfs_ilock(dfc->dfc_capture_ip1, XFS_ILOCK_EXCL);
+		xfs_trans_ijoin(tp, dfc->dfc_capture_ip1, 0);
 	}
-	*captured_ipp = dfc->dfc_capture_ip;
+	*captured_ipp1 = dfc->dfc_capture_ip1;
+	*captured_ipp2 = dfc->dfc_capture_ip2;
 
 	/* Move captured dfops chain and state to the transaction. */
 	list_splice_init(&dfc->dfc_dfops, &tp->t_dfops);
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index 05472f71fffe..f5e3ca17aa26 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -87,7 +87,8 @@ struct xfs_defer_capture {
 	 * An inode reference that must be maintained to complete the deferred
 	 * work.
 	 */
-	struct xfs_inode	*dfc_capture_ip;
+	struct xfs_inode	*dfc_capture_ip1;
+	struct xfs_inode	*dfc_capture_ip2;
 };
 
 /*
@@ -95,9 +96,11 @@ struct xfs_defer_capture {
  * This doesn't normally happen except log recovery.
  */
 int xfs_defer_ops_capture_and_commit(struct xfs_trans *tp,
-		struct xfs_inode *capture_ip, struct list_head *capture_list);
+		struct xfs_inode *capture_ip1, struct xfs_inode *capture_ip2,
+		struct list_head *capture_list);
 void xfs_defer_ops_continue(struct xfs_defer_capture *d, struct xfs_trans *tp,
-		struct xfs_inode **captured_ipp);
+		struct xfs_inode **captured_ipp1,
+		struct xfs_inode **captured_ipp2);
 void xfs_defer_ops_release(struct xfs_mount *mp, struct xfs_defer_capture *d);
 
 #endif /* __XFS_DEFER_H__ */
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 895a56b16029..bba73ddd0585 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -551,7 +551,7 @@ xfs_bui_item_recover(
 	 * Commit transaction, which frees the transaction and saves the inode
 	 * for later replay activities.
 	 */
-	error = xfs_defer_ops_capture_and_commit(tp, ip, capture_list);
+	error = xfs_defer_ops_capture_and_commit(tp, ip, NULL, capture_list);
 	if (error)
 		goto err_unlock;
 
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index c767918c0c3f..ebfc7de8083e 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -632,7 +632,7 @@ xfs_efi_item_recover(
 
 	}
 
-	return xfs_defer_ops_capture_and_commit(tp, NULL, capture_list);
+	return xfs_defer_ops_capture_and_commit(tp, NULL, NULL, capture_list);
 
 abort_error:
 	xfs_trans_cancel(tp);
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index b227a6ad9f5d..ce1a7928eb2d 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2439,7 +2439,7 @@ xlog_finish_defer_ops(
 {
 	struct xfs_defer_capture *dfc, *next;
 	struct xfs_trans	*tp;
-	struct xfs_inode	*ip;
+	struct xfs_inode	*ip1, *ip2;
 	int			error = 0;
 
 	list_for_each_entry_safe(dfc, next, capture_list, dfc_list) {
@@ -2465,12 +2465,16 @@ xlog_finish_defer_ops(
 		 * from recovering a single intent item.
 		 */
 		list_del_init(&dfc->dfc_list);
-		xfs_defer_ops_continue(dfc, tp, &ip);
+		xfs_defer_ops_continue(dfc, tp, &ip1, &ip2);
 
 		error = xfs_trans_commit(tp);
-		if (ip) {
-			xfs_iunlock(ip, XFS_ILOCK_EXCL);
-			xfs_irele(ip);
+		if (ip1) {
+			xfs_iunlock(ip1, XFS_ILOCK_EXCL);
+			xfs_irele(ip1);
+		}
+		if (ip2) {
+			xfs_iunlock(ip2, XFS_ILOCK_EXCL);
+			xfs_irele(ip2);
 		}
 		if (error)
 			return error;
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 07ebccbbf4df..427d8259a36d 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -554,7 +554,7 @@ xfs_cui_item_recover(
 	}
 
 	xfs_refcount_finish_one_cleanup(tp, rcur, error);
-	return xfs_defer_ops_capture_and_commit(tp, NULL, capture_list);
+	return xfs_defer_ops_capture_and_commit(tp, NULL, NULL, capture_list);
 
 abort_error:
 	xfs_refcount_finish_one_cleanup(tp, rcur, error);
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 49cebd68b672..deb852a3c5f6 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -584,7 +584,7 @@ xfs_rui_item_recover(
 	}
 
 	xfs_rmap_finish_one_cleanup(tp, rcur, error);
-	return xfs_defer_ops_capture_and_commit(tp, NULL, capture_list);
+	return xfs_defer_ops_capture_and_commit(tp, NULL, NULL, capture_list);
 
 abort_error:
 	xfs_rmap_finish_one_cleanup(tp, rcur, error);

