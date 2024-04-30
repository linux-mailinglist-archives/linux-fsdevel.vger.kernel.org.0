Return-Path: <linux-fsdevel+bounces-18254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A558B68B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9CE28363C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C07110A3C;
	Tue, 30 Apr 2024 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsZ/7gmu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B22101DE;
	Tue, 30 Apr 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447822; cv=none; b=lVi8usBX5crp0lGReIw+KxZKsc6tJED8wn6wOZbGALXoi2XZkj9a3Ts1jOl4Hyv4RcXGwKkQS0nDrPT008eqiuGUiiCSkbIbfG0tulOqEUXO1lvRk1aDbpQug4w8ddUhUit3GEpmXtOm5i0Bey8qyW8WLTHawTwtQaOAt18jwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447822; c=relaxed/simple;
	bh=Km5UncDH2YB10uPS5kqBLLtNh5A/FULlD9bScC2ld/U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pV6AqzjEd2yIIId/sb/d+Y8FWrd3W22sw2fdn9mfkbEmBohqrDFCMAlRLPGev1Uwk5n+sCZOQJZ/qJiuHgClWdIe953WJZbrB0ffFzs/JiRopQlUBtwOdac5t+saqMgS6ZDgzXcO2tr5cKiTeXQEPz0A7cKyPmPukUXlkd11xig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsZ/7gmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B7AC116B1;
	Tue, 30 Apr 2024 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447822;
	bh=Km5UncDH2YB10uPS5kqBLLtNh5A/FULlD9bScC2ld/U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JsZ/7gmuG3Qj9tAvLN2wFRHTjf1XJ9Zf8qa+NAnL9TzqG+4O33swQFZAb+hOdQPFx
	 VvuHN19Koc5PbWdRW+2cqKHRRO4TrVASZ3MwegdQpyoeTC2M4sO/SevFiGIv8Nvh9W
	 xHptLv/DDNqELGMdSt4TXyf5NNaxIH0F2w0ayfx49jdCaQIJQMRVlK1Vv2CSt5sRzb
	 EiK7uk8RNpq09IHjRBSP0Bm6Kc9UwRygfOv6jLBHt2eXhy4PxM8QoDa7Kp95lsirkP
	 ggw2r3mYxquSVPuda3ahOIF0lGqB++kaHs7MExxtpNkTkhd+Vjpvr217TA6zy0xuQg
	 8pfMZ1/BMglWA==
Date: Mon, 29 Apr 2024 20:30:21 -0700
Subject: [PATCH 24/26] xfs: report verity failures through the health system
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680775.957659.13934229412323879338.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_fs.h     |    1 +
 fs/xfs/libxfs/xfs_health.h |    4 +++-
 fs/xfs/xfs_fsverity.c      |   11 +++++++++++
 fs/xfs/xfs_health.c        |    1 +
 4 files changed, 16 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index edc019d89702d..bc529d862af75 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -424,6 +424,7 @@ struct xfs_bulkstat {
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
index e2de99272b7da..87edf23954336 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -22,6 +22,7 @@
 #include "xfs_ag.h"
 #include "xfs_fsverity.h"
 #include "xfs_icache.h"
+#include "xfs_health.h"
 #include <linux/fsverity.h>
 
 /*
@@ -930,6 +931,15 @@ xfs_fsverity_drop_merkle(
 	block->context = NULL;
 }
 
+static void
+xfs_fsverity_file_corrupt(
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
@@ -937,4 +947,5 @@ const struct fsverity_operations xfs_fsverity_ops = {
 	.read_merkle_tree_block		= xfs_fsverity_read_merkle,
 	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
 	.drop_merkle_tree_block		= xfs_fsverity_drop_merkle,
+	.file_corrupt			= xfs_fsverity_file_corrupt,
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
 


