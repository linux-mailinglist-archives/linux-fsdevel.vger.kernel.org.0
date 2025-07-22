Return-Path: <linux-fsdevel+bounces-55673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAF1B0DA45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800C17B1C4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B32E9742;
	Tue, 22 Jul 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h47HXN1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C82E9EBB;
	Tue, 22 Jul 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189076; cv=none; b=Mzo0/N33H9uS7QrjpdXYsIQ7ohV1UKwvFzwpa54JYmsnBLdHePzsNpXWSb8fzYnJSxTAF89gwcSxYD5zPxZoAThqiuhJN5PvU4caI1KvHEeH2qS2k7WYLGelcxvuo/QlxXGbQv1rsHsPy5FnN6HSaeL63KoST4lfqKa9WzVOIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189076; c=relaxed/simple;
	bh=Cp2bKFGS0dARy/SMGpQMGR4hokrmHMq2JXUYhvTX4ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0cdj0+zfkFbkrABGRLFWTozs/gZbRcTEY89ipsD5j3ptE+sOaLQQYBjKOVIjzozFa93thq3voaXHF6LlFIY7HB8kl0UGIxXy/84Y+ExlAN6ZRdryhCz/Gtx+MVEj05v+x2PmkFFcHNRXa5g2hWpK/CrWWJ8pQex7o+znqMeiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h47HXN1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA87C4CEEB;
	Tue, 22 Jul 2025 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189075;
	bh=Cp2bKFGS0dARy/SMGpQMGR4hokrmHMq2JXUYhvTX4ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h47HXN1HGsReWHQN+GSDxkLEybgMEVthBTqS8cLLoRXNl4y3bRe6aKiN0z+hO60oQ
	 EM0U3SSiCQW58O8ImKGbahmGBCvxhc/IcpibkUEdh28P4LA1WzHYTqaoQ2km3kxLA5
	 vM3267TlH8S94Q1/O4ETlUQ365Di4mx8TuZORfCVrFG+jaY6ZInLYm2a2+8ub2I91O
	 4RzeEMeoM38Uv4tRE5IO6toeK5tgVYcslhz6RwGWxem0nhDTEU2iBdu61lOFfzyHXb
	 wHxDJBSP/OsAbF93IDga6sRFh3WxmODFuGPOEYJZ6fi5tHFg8IQfMbxrOGG47mfwHe
	 bbg990hVZLNlA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH RFC DRAFT v2 03/13] ext4: move fscrypt to filesystem inode
Date: Tue, 22 Jul 2025 14:57:09 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-3-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=6366; i=brauner@kernel.org; h=from:subject:message-id; bh=Cp2bKFGS0dARy/SMGpQMGR4hokrmHMq2JXUYhvTX4ok=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd22UXTalm9mYz105pi1Po9dh9rQsIXGxsx7Wc/O4c twOSMR3lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATMSEh5HhnlKsxovMG0mH7p/Y u4XvpIrYneTN7VNuqguvaruUL63wneGfmfCGr3dFHGUmBe7W+PJWTH9Tr3t2lMOp/yfeVC4W8v7 CDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/ext4.h    |  5 +++++
 fs/ext4/file.c    |  4 ++++
 fs/ext4/ialloc.c  |  2 ++
 fs/ext4/inode.c   |  1 +
 fs/ext4/mballoc.c |  3 +++
 fs/ext4/namei.c   | 15 +++++++++++++++
 fs/ext4/super.c   |  3 +++
 fs/ext4/symlink.c | 12 ++++++++++++
 8 files changed, 45 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..e9710366d87a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1197,6 +1197,10 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info	*i_fscrypt_info;
+#endif
 };
 
 /*
@@ -3604,6 +3608,7 @@ int ext4_enable_quotas(struct super_block *sb);
 extern const struct file_operations ext4_dir_operations;
 
 /* file.c */
+extern const struct inode_operations ext4_encrypted_nop_operations;
 extern const struct inode_operations ext4_file_inode_operations;
 extern const struct file_operations ext4_file_operations;
 extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 21df81347147..9bdee2757bdf 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -981,6 +981,10 @@ const struct file_operations ext4_file_operations = {
 };
 
 const struct inode_operations ext4_file_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_file_getattr,
 	.listxattr	= ext4_listxattr,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 79aa3df8d019..cf1f9c307b9c 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -979,6 +979,8 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	} else
 		inode_init_owner(idmap, inode, dir, mode);
 
+	inode->i_op = &ext4_encrypted_nop_operations;
+
 	if (ext4_has_feature_project(sb) &&
 	    ext4_test_inode_flag(dir, EXT4_INODE_PROJINHERIT))
 		ei->i_projid = EXT4_I(dir)->i_projid;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd..ce385d9c1683 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5163,6 +5163,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		return inode;
 	}
 
+	inode->i_op = &ext4_encrypted_nop_operations;
 	ei = EXT4_I(inode);
 	iloc.bh = NULL;
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1e98c5be4e0a..9b93ee2bfd6a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3417,6 +3417,9 @@ static int ext4_mb_init_backend(struct super_block *sb)
 		ext4_msg(sb, KERN_ERR, "can't get new inode");
 		goto err_freesgi;
 	}
+
+	sbi->s_buddy_cache->i_op = &ext4_encrypted_nop_operations;
+
 	/* To avoid potentially colliding with an valid on-disk inode number,
 	 * use EXT4_BAD_INO for the buddy cache inode number.  This inode is
 	 * not in the inode hash, so it should never be found by iget(), but
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a178ac229489..fb953834265c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4206,7 +4206,18 @@ static int ext4_rename2(struct mnt_idmap *idmap,
 /*
  * directories can handle most operations...
  */
+const struct inode_operations ext4_encrypted_nop_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
+};
+
 const struct inode_operations ext4_dir_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.create		= ext4_create,
 	.lookup		= ext4_lookup,
 	.link		= ext4_link,
@@ -4228,6 +4239,10 @@ const struct inode_operations ext4_dir_inode_operations = {
 };
 
 const struct inode_operations ext4_special_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..6085d6c9169b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1412,6 +1412,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	spin_lock_init(&ei->i_fc_lock);
+#ifdef CONFIG_FS_ENCRYPTION
+	ei->i_fscrypt_info = NULL;
+#endif
 	return &ei->vfs_inode;
 }
 
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 645240cc0229..6b67a9a5c02c 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -115,6 +115,10 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
 }
 
 const struct inode_operations ext4_encrypted_symlink_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.get_link	= ext4_encrypted_get_link,
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_encrypted_symlink_getattr,
@@ -122,6 +126,10 @@ const struct inode_operations ext4_encrypted_symlink_inode_operations = {
 };
 
 const struct inode_operations ext4_symlink_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.get_link	= ext4_get_link,
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
@@ -129,6 +137,10 @@ const struct inode_operations ext4_symlink_inode_operations = {
 };
 
 const struct inode_operations ext4_fast_symlink_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.get_link	= simple_get_link,
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,

-- 
2.47.2


