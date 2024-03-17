Return-Path: <linux-fsdevel+bounces-14608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A187DEA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4451F21B55
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D95221;
	Sun, 17 Mar 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3+Yr3ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712F17EF;
	Sun, 17 Mar 2024 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693089; cv=none; b=YBDBHG7A2SpHBOuRyG+8POrn7B6PjeyH+1/tQd0CjH67FVkBCJbSaQ+lBonxLuXKFGVmGqqoB0rIDsjEU2MH7XxWZnH4cdhgSDYlpqNY4V7U1Tp12P4IQayBDxzpNyr3zp5TFpQ7yt1zeDju6HXd7Gf29U7w5BC5qrxIh9rSybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693089; c=relaxed/simple;
	bh=ZY0U/nov57RCmogmbrq6wE5MUGAayV8eQiH4hfO1k2M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnaCdL/lsZpKM24vHbKSbE9aS0XrcYOimjtb1msKHPTixPLzDqM64lD9dAJDdLZyXV90q9E9UozhJ9UuuYC2HtI9YAbpp62ACVyVr9YP1W3i6dtvJFcJ/qj0UeefBkNefe8yJqPA3DTICKZWrz2ZCQqqloKW95kwpHCn4aZRR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3+Yr3ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E29C433C7;
	Sun, 17 Mar 2024 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693089;
	bh=ZY0U/nov57RCmogmbrq6wE5MUGAayV8eQiH4hfO1k2M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=W3+Yr3lnVFTF/x8KNv0I6179PqbVyAKLZvof15TU6PJw3JRtPtL63+VZyqUkyyL6C
	 OwVkzide+6G1ZM7He5RNMGx8XlY5L2wkpyAcp0Ewv94D1y5hWd+hoyZju3fyjQNUDd
	 Y52mXI4fmdVp8CLLKA8NQBI8nqob1jlyJ7a4UVj+j04VfN7YCxNLaU3cWjObQAiTUb
	 YQO+TnFCa7F6g2NeRZTW/NTXHEpP9hB3e+tgwDKl/0mit/OOqhJKpmpWa+jzHKfgCT
	 /TeTJddcpTiut08Key5ZNqKViCN9r8thdR2RS8/rUtErHcCmEwEQy6B0tSRYJciAnT
	 +okcKzirSHZ0w==
Date: Sun, 17 Mar 2024 09:31:28 -0700
Subject: [PATCH 31/40] xfs: better reporting and error handling in
 xfs_drop_merkle_tree
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246408.2684506.9245902616854244173.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

xfs_drop_merkle_tree is responsible for removing the fsverity metadata
after a failed attempt to enable fsverity for a file.  However, if the
enablement process fails before the verity descriptor is written to the
file, the cleanup function will trip the WARN_ON.  The error code in
that case is ENOATTR, which isn't worth logging about.

Fix that return code handling, fix the tree block removal loop not to
return early with ENOATTR, and improve the logging so that we actually
capture what kind of error occurred.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_verity.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)


diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index db43e017f10e..32891ae42c47 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -472,15 +472,14 @@ xfs_verity_begin_enable(
 			tree_blocksize);
 }
 
+/* Try to remove all the fsverity metadata after a failed enablement. */
 static int
-xfs_drop_merkle_tree(
+xfs_verity_drop_incomplete_tree(
 	struct xfs_inode		*ip,
 	u64				merkle_tree_size,
 	unsigned int			tree_blocksize)
 {
 	struct xfs_verity_merkle_key	name;
-	int				error = 0;
-	u64				offset = 0;
 	struct xfs_da_args		args = {
 		.dp			= ip,
 		.whichfork		= XFS_ATTR_FORK,
@@ -491,6 +490,8 @@ xfs_drop_merkle_tree(
 		/* NULL value make xfs_attr_set remove the attr */
 		.value			= NULL,
 	};
+	u64				offset;
+	int				error;
 
 	if (!merkle_tree_size)
 		return 0;
@@ -498,6 +499,8 @@ xfs_drop_merkle_tree(
 	for (offset = 0; offset < merkle_tree_size; offset += tree_blocksize) {
 		xfs_verity_merkle_key_to_disk(&name, offset);
 		error = xfs_attr_set(&args);
+		if (error == -ENOATTR)
+			error = 0;
 		if (error)
 			return error;
 	}
@@ -505,7 +508,8 @@ xfs_drop_merkle_tree(
 	args.name = (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME;
 	args.namelen = XFS_VERITY_DESCRIPTOR_NAME_LEN;
 	error = xfs_attr_set(&args);
-
+	if (error == -ENOATTR)
+		return 0;
 	return error;
 }
 
@@ -564,9 +568,16 @@ xfs_verity_end_enable(
 		inode->i_flags |= S_VERITY;
 
 out:
-	if (error)
-		WARN_ON_ONCE(xfs_drop_merkle_tree(ip, merkle_tree_size,
-						  tree_blocksize));
+	if (error) {
+		int	error2;
+
+		error2 = xfs_verity_drop_incomplete_tree(ip, merkle_tree_size,
+				tree_blocksize);
+		if (error2)
+			xfs_alert(ip->i_mount,
+ "ino 0x%llx failed to clean up new fsverity metadata, err %d",
+					ip->i_ino, error2);
+	}
 
 	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
 	return error;


