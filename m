Return-Path: <linux-fsdevel+bounces-15742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41EE892873
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0620B1C20EFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF12C15C9;
	Sat, 30 Mar 2024 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QojW9igw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B84801;
	Sat, 30 Mar 2024 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759387; cv=none; b=hTp/4dw2KRvbjZBZfSeyWPPP2IodC30LWqf4NJHF+y/S057AM93lLMX7LaM8wbw0zb9OQz8xS0EZ9dEEV076Vgrp7k9dpzLjAWHuDxnc1rFVSiltQzIRR+UBS4p6/wtsLELyGAfCKygm+6dpyGN06BOW3Z1+LR0TfFVxScXoW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759387; c=relaxed/simple;
	bh=UnzsECvFAnQT6bMmRAHHSYPz9zT1trrX/GCXdbKeheA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY8W2HCxD3sk2216id2kxHiwRF93pashmOkobdQgiGkmzJV9jg0MJXxHltoKUrHhJVzkk41mlXficMrxGjE3618+VIaIFnzM8k6RyKSOTipLDmDgJYbj692M+LesW+/F/Y2EAGLnBiPQZt5GHmbwlMSx2m5QPlt6WCmZt8UyTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QojW9igw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A341C433C7;
	Sat, 30 Mar 2024 00:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759387;
	bh=UnzsECvFAnQT6bMmRAHHSYPz9zT1trrX/GCXdbKeheA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QojW9igwTjWLwzjaeoVbxxI1izEjCECCUYTLj1NPFq+YQ7WfgdIN3Dwhr8TrIDXHk
	 yZNMmOHOINbgwJKYEtZzxTk8udAKF9blRMe+78lCnBxhjkhFbwOoayRwmgVZlLsW2F
	 pewO1fthfwrG7v0dLB9oRiouKHmEs3PPgnpFCGWs/l9CnW40RNf+IRrNkfnWpVRrmK
	 P3RZYXw/DkE6RJVALymRXk4ZRUHOjmTeoLRC/GuoOzZpdcnVXnQdTThOecPSXD1iEW
	 +s2ZAAMFydeJZ2RpO6W9dDbl8ndHS4HFnIt4Hz0+qXqAo54Z69PU+oPLlpxhibfZ5w
	 n9lNSzM8oR/gA==
Date: Fri, 29 Mar 2024 17:43:06 -0700
Subject: [PATCH 27/29] xfs: make it possible to disable fsverity
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175869006.1988170.17755870506078239341.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create an experimental ioctl so that we can turn off fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs_staging.h |    3 ++
 fs/xfs/xfs_fsverity.c          |   73 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h          |    3 ++
 fs/xfs/xfs_ioctl.c             |    6 +++
 4 files changed, 85 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_fs_staging.h b/fs/xfs/libxfs/xfs_fs_staging.h
index 899a56a569d50..4c29167a2b190 100644
--- a/fs/xfs/libxfs/xfs_fs_staging.h
+++ b/fs/xfs/libxfs/xfs_fs_staging.h
@@ -229,4 +229,7 @@ struct xfs_map_freesp {
  */
 #define XFS_IOC_MAP_FREESP	_IOWR('X', 64, struct xfs_map_freesp)
 
+/* Turn off fs-verity */
+#define FS_IOC_DISABLE_VERITY	_IO('f', 133)
+
 #endif /* __XFS_FS_STAGING_H__ */
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index bfa5c70beec24..f57d8acbd858a 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -792,3 +792,76 @@ const struct fsverity_operations xfs_fsverity_ops = {
 	.drop_merkle_tree_block		= xfs_fsverity_drop_merkle,
 	.fail_validation		= xfs_fsverity_fail_validation,
 };
+
+/* Turn off fs-verity. */
+int
+xfs_fsverity_disable(
+	struct file		*file)
+{
+	struct inode		*inode = file_inode(file);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	u64			merkle_tree_size;
+	unsigned int		merkle_blocksize;
+	int			error;
+
+	BUILD_BUG_ON(FS_IOC_DISABLE_VERITY == FS_IOC_ENABLE_VERITY);
+
+	if (!xfs_has_verity(mp))
+		return -EOPNOTSUPP;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	xfs_ilock(ip, XFS_IOLOCK_EXCL);
+
+	if (!IS_VERITY(inode)) {
+		error = 0;
+		goto out_iolock;
+	}
+
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
+		error = -EBUSY;
+		goto out_iolock;
+	}
+
+	error = xfs_qm_dqattach(ip);
+	if (error)
+		goto out_iolock;
+
+	error = fsverity_merkle_tree_geometry(inode, &merkle_blocksize,
+			&merkle_tree_size);
+	if (error)
+		goto out_iolock;
+
+	xfs_fsverity_cache_drop(ip);
+
+	/* Clear fsverity inode flag */
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange, 0, 0, false,
+			&tp);
+	if (error)
+		goto out_iolock;
+
+	ip->i_diflags2 &= ~XFS_DIFLAG2_VERITY;
+
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	if (error)
+		goto out_iolock;
+
+	inode->i_flags &= ~S_VERITY;
+	fsverity_cleanup_inode(inode);
+
+	/* Remove the fsverity xattrs. */
+	error = xfs_fsverity_delete_metadata(ip, merkle_tree_size,
+			merkle_blocksize);
+	if (error)
+		goto out_iolock;
+
+out_iolock:
+	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
+	return error;
+}
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
index 21ba0d82f26d8..4b9fff6b0d2c4 100644
--- a/fs/xfs/xfs_fsverity.h
+++ b/fs/xfs/xfs_fsverity.h
@@ -17,6 +17,8 @@ struct xfs_icwalk;
 int xfs_fsverity_scan_inode(struct xfs_inode *ip, struct xfs_icwalk *icw);
 
 extern const struct fsverity_operations xfs_fsverity_ops;
+
+int xfs_fsverity_disable(struct file *file);
 #else
 # define xfs_fsverity_cache_init(ip)		((void)0)
 # define xfs_fsverity_cache_drop(ip)		((void)0)
@@ -24,6 +26,7 @@ extern const struct fsverity_operations xfs_fsverity_ops;
 # define xfs_fsverity_register_shrinker(mp)	(0)
 # define xfs_fsverity_unregister_shrinker(mp)	((void)0)
 # define xfs_fsverity_scan_inode(ip, icw)	(0)
+# define xfs_fsverity_disable(ip)			(-EOPNOTSUPP)
 #endif	/* CONFIG_FS_VERITY */
 
 #endif	/* __XFS_FSVERITY_H__ */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0aa0ceb9ec153..24deaaf5eb0f5 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -44,6 +44,7 @@
 #include "xfs_file.h"
 #include "xfs_exchrange.h"
 #include "xfs_rtgroup.h"
+#include "xfs_fsverity.h"
 
 #include <linux/mount.h>
 #include <linux/namei.h>
@@ -2712,6 +2713,11 @@ xfs_file_ioctl(
 	case XFS_IOC_MAP_FREESP:
 		return xfs_ioc_map_freesp(filp, arg);
 
+#ifdef CONFIG_XFS_EXPERIMENTAL_IOCTLS
+	case FS_IOC_DISABLE_VERITY:
+		return xfs_fsverity_disable(filp);
+#endif
+
 	case FS_IOC_ENABLE_VERITY:
 		if (!xfs_has_verity(mp))
 			return -EOPNOTSUPP;


