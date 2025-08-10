Return-Path: <linux-fsdevel+bounces-57211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D122B1F91A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548B87AC6AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486092472BD;
	Sun, 10 Aug 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEb0L+26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EDD24418E;
	Sun, 10 Aug 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812809; cv=none; b=Fpxt+PbWjWpW++0OIYRosK2k6niAE9UFxMdbDpwQFLLYj+lNp5aPCzPZ2/UqCc3gRARAu/nqCFQD8zNwBMRk7PT0o+ys/B+dTg2l+tAVrZ5eTg0aPo112MD/sEmtyhrFZxsS7hlZbNaDNuRtoVe71lMX/TX3f8fZQN/Lcyr4TS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812809; c=relaxed/simple;
	bh=Dg7N4Yxhd1Q0fVMr+QNgQgiF2vNBJPVNwSrIaGVuBhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaFxRTHiW6JrT0zuSEoZ5EAWTpe58Xpx+vMzLTsKr58P8kN9duORvDwr6eJCyzpmdYVf99ox2b4nzA6fTLTqxaDFdzqqK0PBA6rRm7cF2hIE+yGGygrMoqazz/QIhx1BtJQ4AvzcmEjaDKs70mkI1XK4izrTpLISSNTjQWYuYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEb0L+26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C70C4CEF8;
	Sun, 10 Aug 2025 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812809;
	bh=Dg7N4Yxhd1Q0fVMr+QNgQgiF2vNBJPVNwSrIaGVuBhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEb0L+26rIN6EuClQPwD6XWh/x1ogGk1gHqNfKeABEaGso81WskiRPvahQXrAuCOZ
	 w2k9gwPcM4MVzy2Xtu93ICIZqwGAZiFUmW03irgpEFgGPONzVBlgA6iWwZdW2VAjvp
	 ckA/LCdmP5MZbWj/9vUZG482qZtgY9xS1gsOTEm/SHQJRHZ0jQf5v0AOB5kVLhzAr5
	 SOjntj25+qR6WW2NoRSLMXpdEylk+m4qP1c0l4gHM7T7zu0GwfPp1aBhPwApR2RcmI
	 cIXrdjVQsfxC0fsbYUTOYO6xUsGL+VNBvyFbKBM5ODIr83OGKk7cOz9+EyNoG4ihpm
	 vskpt49wZ+FMw==
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
Subject: [PATCH v5 04/13] f2fs: move crypt info pointer to fs-specific part of inode
Date: Sun, 10 Aug 2025 00:56:57 -0700
Message-ID: <20250810075706.172910-5-ebiggers@kernel.org>
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

Move the fscrypt_inode_info pointer into the filesystem-specific part of
the inode by adding the field f2fs_inode_info::i_crypt_info and
configuring fscrypt_operations::inode_info_offs accordingly.

This is a prerequisite for a later commit that removes
inode::i_crypt_info, saving memory and improving cache efficiency with
filesystems that don't support fscrypt.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/f2fs.h  | 3 +++
 fs/f2fs/super.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46be7560548ce..2f5c30c069c3c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -905,10 +905,13 @@ struct f2fs_inode_info {
 	unsigned char i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_crypt_info; /* filesystem encryption info */
+#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
 					struct f2fs_extent *i_ext)
 {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e16c4e2830c29..b42b55280d9e3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -478,10 +478,13 @@ static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
 static void init_once(void *foo)
 {
 	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
 
 	inode_init_once(&fi->vfs_inode);
+#ifdef CONFIG_FS_ENCRYPTION
+	fi->i_crypt_info = NULL;
+#endif
 }
 
 #ifdef CONFIG_QUOTA
 static const char * const quotatypes[] = INITQFNAMES;
 #define QTYPE2NAME(t) (quotatypes[t])
@@ -3568,10 +3571,12 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 	*num_devs = sbi->s_ndevs;
 	return devs;
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
+	.inode_info_offs	= (int)offsetof(struct f2fs_inode_info, i_crypt_info) -
+				  (int)offsetof(struct f2fs_inode_info, vfs_inode),
 	.needs_bounce_pages	= 1,
 	.has_32bit_inodes	= 1,
 	.supports_subblock_data_units = 1,
 	.legacy_key_prefix	= "f2fs:",
 	.get_context		= f2fs_get_context,
@@ -3579,11 +3584,11 @@ static const struct fscrypt_operations f2fs_cryptops = {
 	.get_dummy_policy	= f2fs_get_dummy_policy,
 	.empty_dir		= f2fs_empty_dir,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
 	.get_devices		= f2fs_get_devices,
 };
-#endif
+#endif /* CONFIG_FS_ENCRYPTION */
 
 static struct inode *f2fs_nfs_get_inode(struct super_block *sb,
 		u64 ino, u32 generation)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-- 
2.50.1


