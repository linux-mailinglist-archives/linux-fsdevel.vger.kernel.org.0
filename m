Return-Path: <linux-fsdevel+bounces-57217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED4B1F944
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC88D16B2C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81EB26CE05;
	Sun, 10 Aug 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqdcDpAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D412641E3;
	Sun, 10 Aug 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812812; cv=none; b=H4dUnBmv0107jYWb4CDfY0O61hnUaKkbxX/NhgiYIBTiOq4IbIvqJ1342+n4rOPnyYx+wY0sZOpo5+e8g0/E0FI4Ao6eksJ7UpmuYUvJFk+aPhvUe/OEsTif9K7L91O6quCMSIxARcesvNu+zDLe5HIL/lrjTAufVpAri4cWDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812812; c=relaxed/simple;
	bh=mAk2HuPLK15i8Ku+xAc7HePI/XnULAPP/YM3x9265tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py4KCtso7wxOIf9GCUli+wyGUhvMrDuiVDs9+q9oe8wj9tk7Bxv4BPLwE6P0QhdPLlLo9ijl5X/7jWKf4z5PDjlqGlQWzukTwFGbn0QfuMegP4ivj6NtQZ+0iCktgmib7chp55vRng5s8qWg9DoHVsHBDaqAIX3R8vRJGxlYalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqdcDpAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2C7C4CEF9;
	Sun, 10 Aug 2025 08:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812812;
	bh=mAk2HuPLK15i8Ku+xAc7HePI/XnULAPP/YM3x9265tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqdcDpAJoSITR9lcMi9rlgGgii+Fo12miTFMisZBALLfiW83XRzb99WcY11e9R1JD
	 WeC0crLpN370pkZOLTdGtu23gELfMSDcGRhPaANxbgwBfCOvNFm6D7ZsONCOCe3VOK
	 rUBV4j1Rp0yBAc5FpGToXFDIVEd3qeu0NRivNT+KOyxmLtdL5ZaRz38uzC/FfzYw7l
	 l2bhPafvNTlsflkyOGHdI20ETqliyQ6oOSmIxUcgCQ2DsVt4WpC6NCxQAMWZAgdtx2
	 4YB1bMU10EdiocZzGg+uwT/kwQ64HeB5Mt7XSptyLK5vU9hctWLtl+zK0ag2BP1JLj
	 93jGZQmovo8rQ==
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
Subject: [PATCH v5 10/13] f2fs: move verity info pointer to fs-specific part of inode
Date: Sun, 10 Aug 2025 00:57:03 -0700
Message-ID: <20250810075706.172910-11-ebiggers@kernel.org>
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
inode by adding the field f2fs_inode_info::i_verity_info and configuring
fsverity_operations::inode_info_offs accordingly.

This is a prerequisite for a later commit that removes
inode::i_verity_info, saving memory and improving cache efficiency on
filesystems that don't support fsverity.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/f2fs.h   | 3 +++
 fs/f2fs/super.c  | 3 +++
 fs/f2fs/verity.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2f5c30c069c3c..6e465bbc85ee5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -908,10 +908,13 @@ struct f2fs_inode_info {
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info *i_crypt_info; /* filesystem encryption info */
 #endif
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_verity_info; /* filesystem verity info */
+#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
 					struct f2fs_extent *i_ext)
 {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b42b55280d9e3..1db024b20e29b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -481,10 +481,13 @@ static void init_once(void *foo)
 
 	inode_init_once(&fi->vfs_inode);
 #ifdef CONFIG_FS_ENCRYPTION
 	fi->i_crypt_info = NULL;
 #endif
+#ifdef CONFIG_FS_VERITY
+	fi->i_verity_info = NULL;
+#endif
 }
 
 #ifdef CONFIG_QUOTA
 static const char * const quotatypes[] = INITQFNAMES;
 #define QTYPE2NAME(t) (quotatypes[t])
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 2287f238ae09e..f0ab9a3c7a82b 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -285,10 +285,12 @@ static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
 
 	return pagecache_write(inode, buf, size, pos);
 }
 
 const struct fsverity_operations f2fs_verityops = {
+	.inode_info_offs	= (int)offsetof(struct f2fs_inode_info, i_verity_info) -
+				  (int)offsetof(struct f2fs_inode_info, vfs_inode),
 	.begin_enable_verity	= f2fs_begin_enable_verity,
 	.end_enable_verity	= f2fs_end_enable_verity,
 	.get_verity_descriptor	= f2fs_get_verity_descriptor,
 	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
 	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
-- 
2.50.1


