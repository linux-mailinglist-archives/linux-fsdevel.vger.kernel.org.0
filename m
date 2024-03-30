Return-Path: <linux-fsdevel+bounces-15740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9A89286F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D41F21C2B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33B10FF;
	Sat, 30 Mar 2024 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jid0INa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC7197;
	Sat, 30 Mar 2024 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759356; cv=none; b=Iimtb+gga7sMX1q9UxRI7KfJ+st5d95IF2S2p33ULK8S9dMLwIVqYhp05Jvy7DHLGAwPeMBElp/CaV9FSiAbBpmg/vg/sipuENS77PvbyKX7IqBA+QO3JBqJhYAzxqxbAOSeFDTVa2VCohMXmiUJd6xKIF6CUhx3y2f9frcwaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759356; c=relaxed/simple;
	bh=8pYZlx8lk1D5Bg7zw5US39SbDrzkgI1K10/ab0zfdqc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTYcv89JuHaAvZmj1TPg1yxqfoKAxs6Esv436HluX9xOjBedDCtgGV5ykvFEdl+EUk7S/5Nxta2UeY49N41iRslKdHF4yNddWuCgOfdyH6SnwES243svLbeMw0sTfZXPYQrKg0skEhle4ND4T9oJXUoaPC7j5G2rCmDn+iZ0U7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jid0INa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F86C433C7;
	Sat, 30 Mar 2024 00:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759355;
	bh=8pYZlx8lk1D5Bg7zw5US39SbDrzkgI1K10/ab0zfdqc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jid0INa+nM8by57K4c+BWBBFAvYogHdU5Ecx3NpCAmwKmLfi0BZ3q4sJOw1fMQ91z
	 /KNF+3e7FW1Vi/8B3xn3iTbLveLos+frHsAdsxkB0ZdzvN4PVGfnPdiciW+wP3D476
	 hy2wKhYUMiAyVYCpbg2GRHgaAYhOFU+J0ji3hYS30foAEdkL6nLD9y5Mu3ZexJxRcN
	 XITjfK1wax+iQH4gEHgu0QmfYcdE6tsiawi8yjIlEqgZnBGvX7uFcEqpKTsS9d4xGp
	 SJcQbo+0NBBRcN/SPBCyur/PVaV+SiLEYpZj21l2HC9YSPEl+aafoRy/xch7xp2Rlc
	 mtJeJPTIcZu7w==
Date: Fri, 29 Mar 2024 17:42:35 -0700
Subject: [PATCH 25/29] xfs: report verity failures through the health system
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868973.1988170.8154641065699724886.stgit@frogsfrogsfrogs>
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

Record verity failures and report them through the health system.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h     |    1 +
 fs/xfs/libxfs/xfs_health.h |    4 +++-
 fs/xfs/xfs_fsverity.c      |   11 +++++++++++
 fs/xfs/xfs_health.c        |    1 +
 4 files changed, 16 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index af45a246eb1c1..d22f3423ddc76 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -426,6 +426,7 @@ struct xfs_bulkstat {
 #define XFS_BS_SICK_SYMLINK	(1 << 6)  /* symbolic link remote target */
 #define XFS_BS_SICK_PARENT	(1 << 7)  /* parent pointers */
 #define XFS_BS_SICK_DIRTREE	(1 << 8)  /* directory tree structure */
+#define XFS_BS_SICK_DATA	(1 << 9)  /* file data */
 
 /*
  * Project quota id helpers (previously projid was 16bit only
diff --git a/fs/xfs/libxfs/xfs_health.h b/fs/xfs/libxfs/xfs_health.h
index 89b80e957917e..0f8533335e25f 100644
--- a/fs/xfs/libxfs/xfs_health.h
+++ b/fs/xfs/libxfs/xfs_health.h
@@ -105,6 +105,7 @@ struct xfs_rtgroup;
 /* Don't propagate sick status to ag health summary during inactivation */
 #define XFS_SICK_INO_FORGET	(1 << 12)
 #define XFS_SICK_INO_DIRTREE	(1 << 13)  /* directory tree structure */
+#define XFS_SICK_INO_DATA	(1 << 14)  /* file data */
 
 /* Primary evidence of health problems in a given group. */
 #define XFS_SICK_FS_PRIMARY	(XFS_SICK_FS_COUNTERS | \
@@ -143,7 +144,8 @@ struct xfs_rtgroup;
 				 XFS_SICK_INO_XATTR | \
 				 XFS_SICK_INO_SYMLINK | \
 				 XFS_SICK_INO_PARENT | \
-				 XFS_SICK_INO_DIRTREE)
+				 XFS_SICK_INO_DIRTREE | \
+				 XFS_SICK_INO_DATA)
 
 #define XFS_SICK_INO_ZAPPED	(XFS_SICK_INO_BMBTD_ZAPPED | \
 				 XFS_SICK_INO_BMBTA_ZAPPED | \
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 2806466ceaeab..bfa5c70beec24 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -21,6 +21,7 @@
 #include "xfs_quota.h"
 #include "xfs_fsverity.h"
 #include "xfs_icache.h"
+#include "xfs_health.h"
 #include <linux/fsverity.h>
 
 /*
@@ -773,6 +774,15 @@ xfs_fsverity_drop_merkle(
 	block->context = NULL;
 }
 
+static void
+xfs_fsverity_fail_validation(
+	struct inode		*inode,
+	loff_t			pos,
+	size_t			len)
+{
+	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
+}
+
 const struct fsverity_operations xfs_fsverity_ops = {
 	.begin_enable_verity		= xfs_fsverity_begin_enable,
 	.end_enable_verity		= xfs_fsverity_end_enable,
@@ -780,4 +790,5 @@ const struct fsverity_operations xfs_fsverity_ops = {
 	.read_merkle_tree_block		= xfs_fsverity_read_merkle,
 	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
 	.drop_merkle_tree_block		= xfs_fsverity_drop_merkle,
+	.fail_validation		= xfs_fsverity_fail_validation,
 };
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 33059d979857a..ce7385c207d37 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -591,6 +591,7 @@ static const struct ioctl_sick_map ino_map[] = {
 	{ XFS_SICK_INO_DIR_ZAPPED,	XFS_BS_SICK_DIR },
 	{ XFS_SICK_INO_SYMLINK_ZAPPED,	XFS_BS_SICK_SYMLINK },
 	{ XFS_SICK_INO_DIRTREE,	XFS_BS_SICK_DIRTREE },
+	{ XFS_SICK_INO_DATA,	XFS_BS_SICK_DATA },
 	{ 0, 0 },
 };
 


