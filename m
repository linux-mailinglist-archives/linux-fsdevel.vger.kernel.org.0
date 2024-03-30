Return-Path: <linux-fsdevel+bounces-15709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68889282D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD4C282664
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732F23D2;
	Sat, 30 Mar 2024 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4rECkrH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39571C3D;
	Sat, 30 Mar 2024 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758871; cv=none; b=ptaesI9tmeSicSYSEqfr5WvF+sQ7oPXNlRdYzmWDFGs04hM0V5u0nxHsJ5RiTH8+fFn7AqcRUgFkMZxv11tl6UYoRsw+D+1LLQ8Unc1i4/DyX5T3d0cnO3m6aK+xmzH86KXRunoZMuLn2XZeP5DK2PdGWG5LhAXvQGGHiDeWWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758871; c=relaxed/simple;
	bh=svrSqktoBzWVoqHP062pgAOGwYwEZp5JltSD1P7BLQQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOKMP3awuWs2hvvpNBGrisOV8LcQ2rKRkv0EWAbs7XDxx9Ey4Sq97P9L71YL8RrXakjBdS583uGQynUfc10hy09SICYUZBdHFUKXZmcdqsz33tKKb6PLUEHkfIiI60wetMhSxAxADPtDF4KC+XikKF2qWyK1u37ZCxFOwQutW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4rECkrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90019C433F1;
	Sat, 30 Mar 2024 00:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758870;
	bh=svrSqktoBzWVoqHP062pgAOGwYwEZp5JltSD1P7BLQQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=n4rECkrHQF+HhXhdtWkJe2Z3eWi72LkxMQAA3PEdkBFtqYGvdpXoUotwBI4Ni5w58
	 DK2WsYaXEOaMUYXANXiFa3mgNdnTsH08HSvAkAqfXsJ5Jo/kKYtbqXjNhupJF/PD2c
	 brBg2Um0LnD7ShFXWmfvlZYuRTSeOW8cQOVLgJm2WI3ZsH4XHLCMAwk0LmzQ67b1OW
	 0n7nUw30gMlrinryYscvShDcfqJSGIdHrmWSf9AB3KL1EidoK0OsUCYCUqENppgW0w
	 7P6LwYpM201Y5lkxlNiWzwZK6WSgs3gYrLS/yxIHMiry5nwNrP4HM/bX76D1IEZtTI
	 rmj4KD5Y0wiUg==
Date: Fri, 29 Mar 2024 17:34:30 -0700
Subject: [PATCH 07/13] fsverity: pass the new tree size and block size to
 ->begin_enable_verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175867981.1987804.2143506550606185399.stgit@frogsfrogsfrogs>
In-Reply-To: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
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
index 52de58d6f021f..030d7094d80fc 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -82,6 +82,8 @@ struct fsverity_operations {
 	 * Begin enabling verity on the given file.
 	 *
 	 * @filp: a readonly file descriptor for the file
+	 * @merkle_tree_size: total bytes the new Merkle tree will take up
+	 * @tree_blocksize: the new Merkle tree block size
 	 *
 	 * The filesystem must do any needed filesystem-specific preparations
 	 * for enabling verity, e.g. evicting inline data.  It also must return
@@ -91,7 +93,8 @@ struct fsverity_operations {
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
-	int (*begin_enable_verity)(struct file *filp);
+	int (*begin_enable_verity)(struct file *filp, u64 merkle_tree_size,
+				   unsigned int tree_blocksize);
 
 	/**
 	 * End enabling verity on the given file.


