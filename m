Return-Path: <linux-fsdevel+bounces-55675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7807B0DA3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613B41C2234E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F92E9EDA;
	Tue, 22 Jul 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSVWm+JV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286072E9756;
	Tue, 22 Jul 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189082; cv=none; b=iL1F1Pvbb0bgBQMgKYiUkr7AQHbxufGBKNDa/OBejjuUw8tWq2kENCfzB8YrgCeRV5K8WFQSoXRIxjWqBaM/6VO1P093W3OmzNBXDzcJup/3b8qnsxPz9xN6oPNjH8LXe5fnAAz8Xz16hEb1Pk0VLebUeerXrAbylW+8CK8licg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189082; c=relaxed/simple;
	bh=xYzF4p6W7DNhkVGHh4PL2OzcqGIvaM5JGBNQel9SWnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJAhvbf95vycpdTIdh8uxQGOOhWy+S7RiBbqHyVfvGewe5p/QohicRuduBeLG36Poom6ON10FeDhrwHWWE2Clu2NuumTgrtgAup0bXpZcmwgbeRm3PuQJIzYav0wruJFShbbZwq/A0EX6y0+U6bbbIc4y1Z3ETINnlLyImLpAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSVWm+JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6BAC4CEF1;
	Tue, 22 Jul 2025 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189081;
	bh=xYzF4p6W7DNhkVGHh4PL2OzcqGIvaM5JGBNQel9SWnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSVWm+JVt5jt+rn2CD99Hh4GXLI18xZXfNCrkHFipWEVruNc5Qy7WXhCh+ljodI2b
	 zBff2rYt2zl/81wJPzFX4vXE3nNuao5+UeGecO1DGxvC8FqMbJWgBuxYgYPneE/S4r
	 wsFuwGeILDoGDscks9DkYH3wt8/THu5dy4o5mzajKPrvFpP/jn2storEeNLXCGGIB5
	 7ndj/fhrfQQJFdVbOQy2XdDX12TJGxjfwF5j2OUmzDEdRYhuQkqsPSKcl0//V/TtVq
	 9b4Gmp0mTNEoe55g3WSHyUHuDVTa/t8TQOSgorcJ4+LcjgStR245JLffn3wqJIxB+I
	 PC8Ee9KBcgiEg==
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
Subject: [PATCH RFC DRAFT v2 05/13] f2fs: move fscrypt to filesystem inode
Date: Tue, 22 Jul 2025 14:57:11 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-5-782f1fdeaeba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5326; i=brauner@kernel.org; h=from:subject:message-id; bh=xYzF4p6W7DNhkVGHh4PL2OzcqGIvaM5JGBNQel9SWnQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd22SYnm8+b3e7vZ3yXPUdjWFpXi5rC/4nXO8SuR9j fointLjHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpf8jI0DxRoODtwyDj0pzN K1mYfNZelLgvyqF4+vlHq6cT9iotXsbwV9R0nnHmiudWjqmpcgf3Jtr9sn7RuGuJfNu3MkG7z7V 3WAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/f2fs.h  |  4 ++++
 fs/f2fs/file.c  |  4 ++++
 fs/f2fs/inode.c |  1 +
 fs/f2fs/namei.c | 25 +++++++++++++++++++++++++
 fs/f2fs/super.c |  3 +++
 5 files changed, 37 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9333a22b9a01..152990273c68 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -905,6 +905,9 @@ struct f2fs_inode_info {
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_fscrypt_info; /* filesystem encryption info */
+#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
@@ -4297,6 +4300,7 @@ extern const struct inode_operations f2fs_dir_inode_operations;
 extern const struct inode_operations f2fs_symlink_inode_operations;
 extern const struct inode_operations f2fs_encrypted_symlink_inode_operations;
 extern const struct inode_operations f2fs_special_inode_operations;
+extern const struct inode_operations f2fs_encrypted_nop_inode_operations;
 extern struct kmem_cache *f2fs_inode_entry_slab;
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6bd3de64f2a8..f0003672a42c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1150,6 +1150,10 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 }
 
 const struct inode_operations f2fs_file_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
 	.get_inode_acl	= f2fs_get_acl,
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 083d52a42bfb..73bfb9853c25 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -583,6 +583,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		return inode;
 	}
 
+	inode->i_op = &f2fs_encrypted_nop_inode_operations;
 	if (is_meta_ino(sbi, ino))
 		goto make_now;
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 07e333ee21b7..998b0c31f728 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -216,6 +216,13 @@ static void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
 		file_set_hot(inode);
 }
 
+const struct inode_operations f2fs_encrypted_nop_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt = offsetof(struct f2fs_inode_info, i_fscrypt_info) -
+		     offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
+};
+
 static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 						struct inode *dir, umode_t mode,
 						const char *name)
@@ -249,6 +256,8 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 	fi->i_crtime = inode_get_mtime(inode);
 	inode->i_generation = get_random_u32();
 
+	inode->i_op = &f2fs_encrypted_nop_inode_operations;
+
 	if (S_ISDIR(inode->i_mode))
 		fi->i_current_depth = 1;
 
@@ -1325,6 +1334,10 @@ static int f2fs_encrypted_symlink_getattr(struct mnt_idmap *idmap,
 }
 
 const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
 	.get_link	= f2fs_encrypted_get_link,
 	.getattr	= f2fs_encrypted_symlink_getattr,
 	.setattr	= f2fs_setattr,
@@ -1332,6 +1345,10 @@ const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
 };
 
 const struct inode_operations f2fs_dir_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
 	.create		= f2fs_create,
 	.lookup		= f2fs_lookup,
 	.link		= f2fs_link,
@@ -1353,6 +1370,10 @@ const struct inode_operations f2fs_dir_inode_operations = {
 };
 
 const struct inode_operations f2fs_symlink_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
 	.get_link	= f2fs_get_link,
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
@@ -1360,6 +1381,10 @@ const struct inode_operations f2fs_symlink_inode_operations = {
 };
 
 const struct inode_operations f2fs_special_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
 	.get_inode_acl	= f2fs_get_acl,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbf1dad6843f..9f8e5ae13dc9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1453,6 +1453,9 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
+#ifdef CONFIG_FS_ENCRYPTION
+	fi->i_fscrypt_info = NULL;
+#endif
 
 	return &fi->vfs_inode;
 }

-- 
2.47.2


