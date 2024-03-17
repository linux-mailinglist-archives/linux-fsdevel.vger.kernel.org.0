Return-Path: <linux-fsdevel+bounces-14589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF34A87DE67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2FA1C20F90
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E477C1CD13;
	Sun, 17 Mar 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBeExkEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43C1CD03;
	Sun, 17 Mar 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692792; cv=none; b=b5al7jHJKUPN2FDsbksbTt9zBZdQZDQ3p6/x8eDEAdcqM84d/X7SYr7hqTkkdbTFgMD++Tyvi8g59auDTHswgtzeq6eqPqE1YRV7bcs7iUfO6hTTmjcAoAPYrZJRtS8g2mj5DfTLnhgc90u+CUVMGt9NvpFuJ2XYn88W9+d57n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692792; c=relaxed/simple;
	bh=RWvS6hYxLBMDy+8cpkZisjZ45FWaV2WRXSY+F3T1zmE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHD/spy0ukzALNOu8uDMExloG3GPA4BhSysgw26FeYPmQiwNbHRmpLd9tfUfgtHCNLB3/PvIqYTrPEOpK4SBwe38RoV/VnOCxnbf50YmtWeOYQ2MsUMSpqARwSPENuyigaNObGfCbx6ouZwNmQnINpPkzNmcDkN1fi2Wh0LsuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBeExkEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238E7C433C7;
	Sun, 17 Mar 2024 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692792;
	bh=RWvS6hYxLBMDy+8cpkZisjZ45FWaV2WRXSY+F3T1zmE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YBeExkEl7o9MoPb0fHR7H4RoHzqptejFdRXmeyw2G9u3p7yGSd5lfvJlqGAo3fbje
	 wkAyoZuAMeJV2DkWw6M0Q/yUbQrzhzHfH9ch6Xh8qp8l1kTNQ+8GAUZIzvhBg9RYvt
	 nm5/OpD5v1jLhAL1XPbHzjSSvhqGU3BHUnfkwG7phnJTLJxUC4u+2sE7ZM8gXtd1/V
	 JMWfsqWMlH2mrKzCqlEP4rb96LdJCacoSoJG4VEB9r1F4RNIWbphNVMBfUXPiniGJM
	 lTmYAVIYK6vGDunPMMg4yEujvP0+nlv6Y1OC/CAN0CzYetqL97Of0tkpo+iXkNRpBE
	 jVsILZ0hllX0Q==
Date: Sun, 17 Mar 2024 09:26:31 -0700
Subject: [PATCH 12/40] fsverity: pass the new tree size and block size to
 ->begin_enable_verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246107.2684506.3326500566486167316.stgit@frogsfrogsfrogs>
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
index 966630523502..c52f32bd43c7 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -579,7 +579,8 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
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
index da2095a81349..a8ae8c912cb5 100644
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
index b4461b9f47a3..f6ad6523ce95 100644
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
index 945eba0092ab..496a361c0a81 100644
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
index d12a95623614..c5f3564f2cb8 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -80,6 +80,8 @@ struct fsverity_operations {
 	 * Begin enabling verity on the given file.
 	 *
 	 * @filp: a readonly file descriptor for the file
+	 * @merkle_tree_size: total bytes the new Merkle tree will take up
+	 * @tree_blocksize: the new Merkle tree block size
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


