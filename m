Return-Path: <linux-fsdevel+bounces-15724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632EE89284E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE5F2827FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA01366;
	Sat, 30 Mar 2024 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SexWY1ED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A377E8;
	Sat, 30 Mar 2024 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759105; cv=none; b=f484w4+jw+wa/dCZhwx+D8xonb8p74A7xn/K4VchaZ6k0MWSNWiJr4FgVeKo4ZAoIO4GbQOg0+LQBXnWcJaHyBS4I8vFJeRoR0RGE3O70wpXdP3LB1OPr1lOIL+oQoiw5h8RKtGbw3dDpIc243ZZA4qgjc8gFKEaKPmQVpa/1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759105; c=relaxed/simple;
	bh=eiWHecNvYqhB+6cSUmRbC7ZUB5W/5z51JKcGRv96OrI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMytp4nZInT8wBVpgoZ/18zQ3RW4LoHQ9Lhz8TPp48rBs1UbHgwAY1fTwC19YMWoWWdjuRVOg0IJ0qJyipdqf00ezYRikqGzl5sZ3yVE4TA8sVXmLWbQKAmHawVeDUNWqy+D4ihg7NN/R4fyxkLDyx1HvXGSoJkyMcAHtI0KxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SexWY1ED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365B2C433F1;
	Sat, 30 Mar 2024 00:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759105;
	bh=eiWHecNvYqhB+6cSUmRbC7ZUB5W/5z51JKcGRv96OrI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SexWY1EDz+P7YBiwf+QEHGeEodbIPW22oz4qsye4+MT3KMUvk8p77p4zTxgwgFckr
	 jMlXlDCQsL7ov1dykqBybosLt8shciGLLa65zXJBplGNNHJzbDJGqcO5umiThwDeg9
	 dWg8B2sjQd1/bfDiFclhOdsVhHnJniMvKPbVtrahmWkoVekDcT429+sS47k8ZJ4ECk
	 qQFKqxoLI2qu80KfMNwLNzyrmK6qLMS/J3SylOwkMitUif7/dQBLxZW6jchopZggM/
	 pPxfbV+ctuNKPUvuHQ83mlIysPWdgiIfc+CbHT3PCo6cCHQEi1J3eN5imo+dxg/xIv
	 PL1ROTV0Fdn4Q==
Date: Fri, 29 Mar 2024 17:38:24 -0700
Subject: [PATCH 09/29] xfs: initialize fs-verity on file open and cleanup on
 inode destruction
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868710.1988170.10919521002440903345.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  |    8 ++++++++
 fs/xfs/xfs_super.c |    2 ++
 2 files changed, 10 insertions(+)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 6162d6c12b76d..ce57f5007308a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -32,6 +32,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1413,10 +1414,17 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5304004646b40..42a1e1f23d3b3 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -52,6 +52,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -671,6 +672,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 


