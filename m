Return-Path: <linux-fsdevel+bounces-57216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C3B1F941
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B12165E4C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72584268C55;
	Sun, 10 Aug 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbO0fBqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5021C19D;
	Sun, 10 Aug 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812811; cv=none; b=YOPV6mPRhISo2k3Sq/uwnhT/AYUj4J8WqYUubg2T3B8P4k8xP6kT9ZZcjmLBeQ3Zx8SbmW2udoXEElbezm9Ba+NFxVxVawUpiJm80TEFhcnRREdAnzjG7vXrtJvN36Z5k8KimvFOAGNU+0QDO+jsN3VPHL/Y3kwV8uCyRJytRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812811; c=relaxed/simple;
	bh=0W2QfxH3SEgQE9yRuqSbCQDiVKMNeIT6t0Ume6h8gTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWr0TEemErEYzjY6+DjRNZc9eB+3H7FWqeuVTTv3P2S4M/2pjciFDTbzbxkJv5zkqY9DRoD9f6PTlG0HO8f4ERCz3Hray5rgBgaSHyd8a9AuAdCOMLi+XwdD81jPBP1f9YQ0oFfVeKvGAVrGhkvadZ5SosMjdgniyNTrA93izoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbO0fBqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFA2C4CEF0;
	Sun, 10 Aug 2025 08:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812811;
	bh=0W2QfxH3SEgQE9yRuqSbCQDiVKMNeIT6t0Ume6h8gTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbO0fBqNeeMZN0WDI+kgBFdzKJGAGVEHnaPJxNqqowTDLniJGOt0j4uw17U+6FdFo
	 H1Rc+/DvLZMsGO2D5fctgnRrjZXcK7So5ofrPTD2H2yqTs1twguCtFJ2JNW4cMPtPp
	 TrBjF8WHO/Fqi8b5bl1QcFjUuAV1wELwTmlaoVQa+YVbKZI//49bHAJwmSo25dwBt1
	 9Velrja88wsmjHCfWt9uhUSDzFuUBb8Ukug6Giba73mFWBZs8MnCbze0Ch6npBgJ7e
	 PSD9t23xAMkrpUHkqc+5V+32XM9Fgs/eeDPf3ADl5GWNi5DG2oJSS8jBlPWdvKu8/N
	 WR+Wmk3zLpjvA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 09/13] ext4: move verity info pointer to fs-specific part of inode
Date: Sun, 10 Aug 2025 00:57:02 -0700
Message-ID: <20250810075706.172910-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810075706.172910-1-ebiggers@kernel.org>
References: <20250810075706.172910-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the fsverity_info pointer into the filesystem-specific part of the
inode by adding the field ext4_inode_info::i_verity_info and configuring
fsverity_operations::inode_info_offs accordingly.

This is a prerequisite for a later commit that removes
inode::i_verity_info, saving memory and improving cache efficiency on
filesystems that don't support fsverity.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/ext4/ext4.h   | 4 ++++
 fs/ext4/super.c  | 3 +++
 fs/ext4/verity.c | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c897109dadb15..6cb784a56b3ba 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1184,10 +1184,14 @@ struct ext4_inode_info {
 	kprojid_t i_projid;
 
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info *i_crypt_info;
 #endif
+
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_verity_info;
+#endif
 };
 
 /*
  * File system states
  */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0c3059ecce37c..46138a6cb32a3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1471,10 +1471,13 @@ static void init_once(void *foo)
 	inode_init_once(&ei->vfs_inode);
 	ext4_fc_init_inode(&ei->vfs_inode);
 #ifdef CONFIG_FS_ENCRYPTION
 	ei->i_crypt_info = NULL;
 #endif
+#ifdef CONFIG_FS_VERITY
+	ei->i_verity_info = NULL;
+#endif
 }
 
 static int __init init_inodecache(void)
 {
 	ext4_inode_cachep = kmem_cache_create_usercopy("ext4_inode_cache",
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index d9203228ce979..b0acb0c503137 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -387,10 +387,12 @@ static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
 
 	return pagecache_write(inode, buf, size, pos);
 }
 
 const struct fsverity_operations ext4_verityops = {
+	.inode_info_offs	= (int)offsetof(struct ext4_inode_info, i_verity_info) -
+				  (int)offsetof(struct ext4_inode_info, vfs_inode),
 	.begin_enable_verity	= ext4_begin_enable_verity,
 	.end_enable_verity	= ext4_end_enable_verity,
 	.get_verity_descriptor	= ext4_get_verity_descriptor,
 	.read_merkle_tree_page	= ext4_read_merkle_tree_page,
 	.write_merkle_tree_block = ext4_write_merkle_tree_block,
-- 
2.50.1


