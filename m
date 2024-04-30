Return-Path: <linux-fsdevel+bounces-18219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40518B685C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D971F21BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C79FC12;
	Tue, 30 Apr 2024 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0CA/qHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46271078F;
	Tue, 30 Apr 2024 03:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447290; cv=none; b=tTOd7w1B6xxtUvn6d/YXYK3uy/GpIz1fy+JzGk1fEiMrCDn791VicYxG4kkZKU2BiIJp6ZUKtSDHVcYU6Za5Xmhhx3KxJRHO4E9nDimbb9TfYV3fszPrn+/PRur/NUTT0PJq5BKy5+PHoXp3+6n6V+8dqIgH3gFB1hRhsaPm4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447290; c=relaxed/simple;
	bh=CbRTOCKDougg9vXJRC+qgDE9f8bZu3gwJjD7nVuAa0o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4p5r/OiPPE5sFPDOpy8UQVXKG7nUntvuwMgKH7ljvcit0k2g3RmEvoHfr4Kxio9es2vQ8Mzv+qGht1/9ALYS0yrLUR8bt9iAWYpSTDd5kV2GMxMp+fUs8VlhW6WH6BIxuU57wNb2m8W1sd9q6nlL5qaJhm8KjLtG8qAMLawDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0CA/qHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779D2C4AF14;
	Tue, 30 Apr 2024 03:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447290;
	bh=CbRTOCKDougg9vXJRC+qgDE9f8bZu3gwJjD7nVuAa0o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Z0CA/qHKi9uZNYA3lguOuGbjEw+1oqxn9oYdVFw+mA6KWHs+dKkSovOJhOa4/PCIl
	 GzPTbz1BKT8krIyLHSOZvYpQzoDfUU3o69w7rALiQXa09gW7LrHlO1wsI4JZRVhDx6
	 XOT/SU7bJOM6KNJm/b/wHqAriSjOu4JwIOCGrJSyul1nXixnmr8SSP4C2B4qsXeKe8
	 jhsm0P41XemLLnHfpTVtfulsus3QZx/JJUk2wTcZwv9eSP8s8sL/PKBtxcfKT5iw3M
	 RYXT8LHmz6ccPkaxwV2Qw1y+pWhN1nTIko8J1eRQCHkVJ1EmMSIJR9c7IIqRGKga/Z
	 Ow7g5JQ2B+FSw==
Date: Mon, 29 Apr 2024 20:21:30 -0700
Subject: [PATCH 08/18] fsverity: pass the new tree size and block size to
 ->begin_enable_verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679726.955480.10915180747584592972.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
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

When starting up the process of enabling fsverity on a file, pass the
new size of the merkle tree and the merkle tree block size to the fs
implementation.  XFS will want this information later to try to clean
out a failed previous enablement attempt.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/verity.c        |    3 ++-
 fs/ext4/verity.c         |    3 ++-
 fs/f2fs/verity.c         |    3 ++-
 fs/verity/enable.c       |    3 ++-
 include/linux/fsverity.h |    5 ++++-
 5 files changed, 12 insertions(+), 5 deletions(-)


diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 647a22e07748e..a3235571bf02d 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -578,7 +578,8 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
  *
  * Returns 0 on success, negative error code on failure.
  */
-static int btrfs_begin_enable_verity(struct file *filp)
+static int btrfs_begin_enable_verity(struct file *filp, u64 merkle_tree_size,
+				     unsigned int tree_blocksize)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(filp));
 	struct btrfs_root *root = inode->root;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index da2095a813492..a8ae8c912cb5d 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -99,7 +99,8 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 	return 0;
 }
 
-static int ext4_begin_enable_verity(struct file *filp)
+static int ext4_begin_enable_verity(struct file *filp, u64 merkle_tree_size,
+				    unsigned int tree_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	const int credits = 2; /* superblock and inode for ext4_orphan_add() */
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 8fdac653ff8e8..595d702c2c5c4 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -115,7 +115,8 @@ struct fsverity_descriptor_location {
 	__le64 pos;
 };
 
-static int f2fs_begin_enable_verity(struct file *filp)
+static int f2fs_begin_enable_verity(struct file *filp, u64 merkle_tree_size,
+				    unsigned int tree_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	int err;
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 9f743f9160100..1d4a6de960149 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -237,7 +237,8 @@ static int enable_verity(struct file *filp,
 	if (IS_VERITY(inode))
 		err = -EEXIST;
 	else
-		err = vops->begin_enable_verity(filp);
+		err = vops->begin_enable_verity(filp, params.tree_size,
+				      params.block_size);
 	inode_unlock(inode);
 	if (err)
 		goto out;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index c3f04bc0166d3..7c51d7cf835ec 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -80,6 +80,8 @@ struct fsverity_operations {
 	 * Begin enabling verity on the given file.
 	 *
 	 * @filp: a readonly file descriptor for the file
+	 * @merkle_tree_size: total bytes the Merkle tree will take up
+	 * @tree_blocksize: the Merkle tree block size
 	 *
 	 * The filesystem must do any needed filesystem-specific preparations
 	 * for enabling verity, e.g. evicting inline data.  It also must return
@@ -89,7 +91,8 @@ struct fsverity_operations {
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
-	int (*begin_enable_verity)(struct file *filp);
+	int (*begin_enable_verity)(struct file *filp, u64 merkle_tree_size,
+				   unsigned int tree_blocksize);
 
 	/**
 	 * End enabling verity on the given file.


