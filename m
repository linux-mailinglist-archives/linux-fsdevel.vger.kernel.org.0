Return-Path: <linux-fsdevel+bounces-55674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4339EB0DA3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECBE1C225C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8282EA142;
	Tue, 22 Jul 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uShbMP2U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18F2E9ED6;
	Tue, 22 Jul 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189079; cv=none; b=HL7wqfzwNbhsLX7SAKiF2r4ccXuS9Tda6XjSXHTus+kbQ/OqqcI9cQyEbIZ61BNLqZ5BOdACNdKdm4FC+BrO0lHhDWKWrh6OYlDKHM2SV0KsxEw0StRCiwoQTqRyqjYOKouIBr1t+WyZKbMoepKTR8WlizgulrlSq6xo60ob0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189079; c=relaxed/simple;
	bh=IyPWzRdjp9CW1j3CJtVKq04N8AY/dhOMNOFt3g9JJs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juRyHhDBWrHkDpXnBXVwfk4Y20mvBq5UNUxiPDxiL2PTGrwOQoWuTf9uNvPd4vnFDhlCyN2HOoUmyK+cE38EaCvicX/c2puYLMCKjNI1kWALo8oKbhLnxRAQeM4xIjDZqoXFGBFBQ6uJXVCo8wf47qB8ClpfF0oRGtAG4LHFLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uShbMP2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA2BC4CEEB;
	Tue, 22 Jul 2025 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189078;
	bh=IyPWzRdjp9CW1j3CJtVKq04N8AY/dhOMNOFt3g9JJs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uShbMP2UR/BedQno+mP72WiV5Kkq8uHMwFoCOx6eTM4KtMDWq5Tcm5lXtAgYUFcAr
	 Yh2xCS2//adPqWqJjxbFiXyawNp7dFsaDXczrISAO8XAr2QApFCDIhnRyCQVBYOBMg
	 /F5tOuEKtBRY/oi/leZJnhir4QZHzUzWoo+zwwhJEipTyNvhebsMSqkQY+Yqpq+dEv
	 6r4RRSYiPmMa9UM6P1uLF7ZiOL71ugU5gyyVR8IeDP2t+tem13x/7vUghLPhRiYVQ/
	 icIRpqi2FWDG+z87YoYDLWzfFz8d4QJ8cBEnUtaU5WloaR/IWwjGkRBUeUrb8oKLk7
	 a0NtHBAFOCEtg==
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
Subject: [PATCH RFC DRAFT v2 04/13] ubifs: move fscrypt to filesystem inode
Date: Tue, 22 Jul 2025 14:57:10 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-4-782f1fdeaeba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5175; i=brauner@kernel.org; h=from:subject:message-id; bh=IyPWzRdjp9CW1j3CJtVKq04N8AY/dhOMNOFt3g9JJs0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd22c2DGlf79TtcOBNwqHz3oI3s9Zk3vUoKr9zwWHu hDxB+89O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyVZCRoUXsHKcp+7dl865u +FsuXs90YGG5wfewuohg1/vHo7mtuBgZdooHMFSc7Tn3e0HShvL4dz5l3SGhUUuWPwn1sLuT9jS XEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ubifs/dir.c   | 52 ++++++++++++++++++++++++++++------------------------
 fs/ubifs/file.c  |  8 ++++++++
 fs/ubifs/super.c |  8 ++++++++
 fs/ubifs/ubifs.h |  3 +++
 4 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 3c3d3ad4fa6c..7d3c70c057c2 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -104,14 +104,6 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 	simple_inode_init_ts(inode);
 	inode->i_mapping->nrpages = 0;
 
-	if (!is_xattr) {
-		err = fscrypt_prepare_new_inode(dir, inode, &encrypted);
-		if (err) {
-			ubifs_err(c, "fscrypt_prepare_new_inode failed: %i", err);
-			goto out_iput;
-		}
-	}
-
 	switch (mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_mapping->a_ops = &ubifs_file_address_operations;
@@ -136,6 +128,14 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 		BUG();
 	}
 
+	if (!is_xattr) {
+		err = fscrypt_prepare_new_inode(dir, inode, &encrypted);
+		if (err) {
+			ubifs_err(c, "fscrypt_prepare_new_inode failed: %i", err);
+			goto out_iput;
+		}
+	}
+
 	ui->flags = inherit_flags(dir, mode);
 	ubifs_set_inode_flags(inode);
 	if (S_ISREG(mode))
@@ -1740,22 +1740,26 @@ static loff_t ubifs_dir_llseek(struct file *file, loff_t offset, int whence)
 }
 
 const struct inode_operations ubifs_dir_inode_operations = {
-	.lookup      = ubifs_lookup,
-	.create      = ubifs_create,
-	.link        = ubifs_link,
-	.symlink     = ubifs_symlink,
-	.unlink      = ubifs_unlink,
-	.mkdir       = ubifs_mkdir,
-	.rmdir       = ubifs_rmdir,
-	.mknod       = ubifs_mknod,
-	.rename      = ubifs_rename,
-	.setattr     = ubifs_setattr,
-	.getattr     = ubifs_getattr,
-	.listxattr   = ubifs_listxattr,
-	.update_time = ubifs_update_time,
-	.tmpfile     = ubifs_tmpfile,
-	.fileattr_get = ubifs_fileattr_get,
-	.fileattr_set = ubifs_fileattr_set,
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ubifs_inode, i_fscrypt_info) -
+			  offsetof(struct ubifs_inode, vfs_inode),
+#endif
+	.lookup		= ubifs_lookup,
+	.create      	= ubifs_create,
+	.link        	= ubifs_link,
+	.symlink     	= ubifs_symlink,
+	.unlink      	= ubifs_unlink,
+	.mkdir       	= ubifs_mkdir,
+	.rmdir       	= ubifs_rmdir,
+	.mknod       	= ubifs_mknod,
+	.rename      	= ubifs_rename,
+	.setattr     	= ubifs_setattr,
+	.getattr     	= ubifs_getattr,
+	.listxattr   	= ubifs_listxattr,
+	.update_time 	= ubifs_update_time,
+	.tmpfile     	= ubifs_tmpfile,
+	.fileattr_get	= ubifs_fileattr_get,
+	.fileattr_set 	= ubifs_fileattr_set,
 };
 
 const struct file_operations ubifs_dir_operations = {
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index bf311c38d9a8..93ab562f7107 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1632,6 +1632,10 @@ const struct address_space_operations ubifs_file_address_operations = {
 };
 
 const struct inode_operations ubifs_file_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ubifs_inode, i_fscrypt_info) -
+			  offsetof(struct ubifs_inode, vfs_inode),
+#endif
 	.setattr     = ubifs_setattr,
 	.getattr     = ubifs_getattr,
 	.listxattr   = ubifs_listxattr,
@@ -1641,6 +1645,10 @@ const struct inode_operations ubifs_file_inode_operations = {
 };
 
 const struct inode_operations ubifs_symlink_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ubifs_inode, i_fscrypt_info) -
+			  offsetof(struct ubifs_inode, vfs_inode),
+#endif
 	.get_link    = ubifs_get_link,
 	.setattr     = ubifs_setattr,
 	.getattr     = ubifs_symlink_getattr,
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f3e3b2068608..f18b38ee5c0c 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -100,6 +100,13 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
 	return err;
 }
 
+static const struct inode_operations ubifs_encrypted_nop_inode_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ubifs_inode, i_fscrypt_info) -
+			  offsetof(struct ubifs_inode, vfs_inode),
+#endif
+};
+
 struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 {
 	int err;
@@ -118,6 +125,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 		return inode;
 	ui = ubifs_inode(inode);
 
+	inode->i_op = &ubifs_encrypted_nop_inode_operations;
 	ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
 	if (!ino) {
 		err = -ENOMEM;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 256dbaeeb0de..0442782a54ab 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -416,6 +416,9 @@ struct ubifs_inode {
 	pgoff_t read_in_a_row;
 	int data_len;
 	void *data;
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_fscrypt_info;
+#endif
 };
 
 /**

-- 
2.47.2


