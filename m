Return-Path: <linux-fsdevel+bounces-14599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DD487DE91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7451F21366
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAD1CF8F;
	Sun, 17 Mar 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwIBJPet"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B01CD15;
	Sun, 17 Mar 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692948; cv=none; b=IKd9tAs370Q3A6yM9/SDJa3fK3zjZOb5uSQD1dge7D61ZV3d/7I5/S2cmq+kIa6E6c1/Rv/Ulf0d12b5AdhqnPxJ+eP+O7xX8ti6QZxUW+iI5mt/KqbB4oTK4YAx9iGumOcv1XSl9HYsUycqP9QFO6aaFaDWz8Vn4nX0HQiVQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692948; c=relaxed/simple;
	bh=IbdxCYJ2BOtFhytk6YBJUGUCJBZ0PkrYYAYsg50vfqg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pv4QvfP9axszSZvOxl/vE9FePhk2Q8Iz+EYTPNwD7xySyw78Vm+Ry4uhTC+aBG97v/TFWEuSBlX2X3xySMXJQ7+jQ4iPvzYjogy6itdeWB6XosVvLXXJZi+Prp4qJz6Tdughu2sYVsL/97E/2FIJ08//EufHHgH6zqw5XEIO/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwIBJPet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F4C433C7;
	Sun, 17 Mar 2024 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692948;
	bh=IbdxCYJ2BOtFhytk6YBJUGUCJBZ0PkrYYAYsg50vfqg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XwIBJPetXg1Q+TfFgD8Ss/E8dAC+X5aXqFmhBzRppxd0MwOOFMdISwUv/1WJFqjH0
	 9IT74pBuItW93agyDlBmy3atbgouadP67VwPH+uYi2/juc8zeVUYf4ht9qm9KEziDv
	 cnJk0t+cSxmF+J0Vu9xmIydbbyK9qLnXwngRXNJ/tLkkx+ztI36G3B90ZodtnWVZ1l
	 eSiGZKZ3CbedV0vIFF1SHMO2tGor1zmyMQ6DyfZAx5KuQ4l/w2p39WzjuufIKJYmRT
	 53xWRV61Uvgtj0hh5+jIH3wZqJBdj53htVZziTeiC9bsuW/fZ7AcXXyOFkuJ1ya/9A
	 21HRswJvh/ddQ==
Date: Sun, 17 Mar 2024 09:29:08 -0700
Subject: [PATCH 22/40] xfs: initialize fs-verity on file open and cleanup on
 inode destruction
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246265.2684506.1419479199273543604.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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
 


