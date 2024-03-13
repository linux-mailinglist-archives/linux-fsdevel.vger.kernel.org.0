Return-Path: <linux-fsdevel+bounces-14339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15487B1D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 20:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB6DB2B7B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB2514533A;
	Wed, 13 Mar 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9V5s+K0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76C145328;
	Wed, 13 Mar 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352621; cv=none; b=Uo/cM7wTBUPDYmNNQProBq5qafHkxe/tYIFA5j4jveCfTKErXvZsXHlUtvyAe2jQO5w9BZtl2yESGFyjIU/6t53JS/FeUd2Itsb6iGZJ3e/ng4ADLh1ONsCEE+ddG+QoK6gocmuNTE14Lj2B6UCMGpbVinVSQqv7RYMe4XCe+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352621; c=relaxed/simple;
	bh=IbdxCYJ2BOtFhytk6YBJUGUCJBZ0PkrYYAYsg50vfqg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuOT0+vcOzC/P91ExPhNIcs0WTGqqMEjQJOzleH2cgFSCxpBQOr/Ygwr54qgpRwRUk+EvF8BrEqcvOBnx72rMOCSGHMp54ofilpjB7rTm3H+CL7eKAKb2KdROq2yoTBF5OTLbZaXywhtcR2MhXJ6eFxqTSfZ1XFaYRJIhksbwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9V5s+K0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EFAC433C7;
	Wed, 13 Mar 2024 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352621;
	bh=IbdxCYJ2BOtFhytk6YBJUGUCJBZ0PkrYYAYsg50vfqg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=V9V5s+K014XjtIcD2gE5copbAH5iN82hVkYuOjAqlGxzf0qiGrFoHKTfzlvewC41Y
	 VvtdKXyKBOIRqhd7dQno6+X1ODp/toqZKD4niwzdOQcBWCmzuVQ+YDbqRU1CXKwMfF
	 VwYiBzTi3C9zSoS+k7zng31oyMkav6fhbb0BZIeK0DU7d7akzReQd0APeLbUatqRV3
	 fwvaQ8qTd08nFp0P+yBbSUT0OsCZj2XOayz/DwUDPs/9fmGqDEhtdM+MMoW3lj5Apd
	 72919oXtxNt4gtbO/7NiLQpozXkn6HpjFAjBMVnctFfVPbermdBlmmHLFjYFFxAkSW
	 uDfyaDxbfDKfQ==
Date: Wed, 13 Mar 2024 10:57:00 -0700
Subject: [PATCH 17/29] xfs: initialize fs-verity on file open and cleanup on
 inode destruction
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223631.2613863.8250273414508285661.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
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
index 632653e00906..74dba917be93 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -31,6 +31,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1228,10 +1229,17 @@ xfs_file_open(
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
index 6828c48b15e9..a09739beb8f3 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -49,6 +49,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -664,6 +665,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 


