Return-Path: <linux-fsdevel+bounces-28039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C4966298
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C51F23150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900591B4C24;
	Fri, 30 Aug 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0tpD4eM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1551AF4F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023183; cv=none; b=aXlrervd+7QfgIoPFuYJ+0eAQ3PO7OA0CpvJvmaotjjn6BIrzGc4ne73YGW6K8BSll0PMGEYjkAzms/va8ZVI95zQ/RcK1myGvaHW3cVw5af7E7joZnVAI+Y7BR1StihgPljvLDWigmH0GycPOc/7dz9S9P2kAF37cGedHSVwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023183; c=relaxed/simple;
	bh=l65jWK5+JGZmVWppDzjyXx1NF8+EjedCBbQVuso34UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctVbOpcoPirx0trj4RhhD8IHaiP6PJtU1NcPeeguFAaolSXdUpgxEGsPl9DxLTnAdgHaVK75vWpRBYf0/kbi+5CmDuXWN60fh47OTp8usZFSvhWEhAakK/SHTNTVvU2Cs5ZLsoxrUS5Rp0JbgPb3sK0JW1ojdiX3V90iFqzlvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0tpD4eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD9C4AF0C;
	Fri, 30 Aug 2024 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023182;
	bh=l65jWK5+JGZmVWppDzjyXx1NF8+EjedCBbQVuso34UE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F0tpD4eM/sr+WII47YEtwqHAa0Oaky9Ukd+g/OFZhZpINI0+9zFNvE/id1Tm5QWmb
	 z/t5KFTlQNj2G91sV0RKE35VMGQxwGsuksEpa7Dsh8r5XZyI+5+0i3IM6KrpuXd5pB
	 2AIOmL85c39Ka9OZ2Fk9IhwdQQybK8c84crKfCFZlsgziHJWBvsL1Lf4Zj5exbRWFH
	 qjy1/UICe3Dl60qjaUmY4BMaROq0Jq69UuExnVpfpbfRUvPPd6KWR5nvwwVG2tHVXn
	 0E4DLo1I2oC8k2c520t7Nd2f4CMFzQZrRf0WxDTGC/4uJ6Ego/DCKEJojK1sASiYyF
	 CjWEYfpBhr3Rw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:58 +0200
Subject: [PATCH RFC 17/20] ubifs: store cookie in private data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-17-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4912; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l65jWK5+JGZmVWppDzjyXx1NF8+EjedCBbQVuso34UE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDzX/956b5XOd0rvStY9MVg0ObzzpEO1cO/MBMEy0
 x06lmGPO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyxYPhn07PVy5Fi/OXjhuc
 1t+VNqf5aOQf8/CTT782Lsh/ZZNi9pKRYZvMVokotgM/Yx2cZsxplk/Z/3TWs4m3eHISJ7Kc7N/
 BxgwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the cookie to detect concurrent seeks on directories in
file->private_data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ubifs/dir.c | 65 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index c77ea57fe696..76bcafa92200 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -555,6 +555,11 @@ static unsigned int vfs_dent_type(uint8_t type)
 	return 0;
 }
 
+struct ubifs_dir_data {
+	struct ubifs_dent_node *dent;
+	u64 cookie;
+};
+
 /*
  * The classical Unix view for directory is that it is a linear array of
  * (name, inode number) entries. Linux/VFS assumes this model as well.
@@ -582,6 +587,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 	struct inode *dir = file_inode(file);
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
 	bool encrypted = IS_ENCRYPTED(dir);
+	struct ubifs_dir_data *data = file->private_data;
 
 	dbg_gen("dir ino %lu, f_pos %#llx", dir->i_ino, ctx->pos);
 
@@ -604,27 +610,27 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 		fstr_real_len = fstr.len;
 	}
 
-	if (file->f_version == 0) {
+	if (data->cookie == 0) {
 		/*
-		 * The file was seek'ed, which means that @file->private_data
+		 * The file was seek'ed, which means that @data->dent
 		 * is now invalid. This may also be just the first
 		 * 'ubifs_readdir()' invocation, in which case
-		 * @file->private_data is NULL, and the below code is
+		 * @data->dent is NULL, and the below code is
 		 * basically a no-op.
 		 */
-		kfree(file->private_data);
-		file->private_data = NULL;
+		kfree(data->dent);
+		data->dent = NULL;
 	}
 
 	/*
-	 * 'generic_file_llseek()' unconditionally sets @file->f_version to
-	 * zero, and we use this for detecting whether the file was seek'ed.
+	 * 'ubifs_dir_llseek()' sets @data->cookie to zero, and we use this
+	 * for detecting whether the file was seek'ed.
 	 */
-	file->f_version = 1;
+	data->cookie = 1;
 
 	/* File positions 0 and 1 correspond to "." and ".." */
 	if (ctx->pos < 2) {
-		ubifs_assert(c, !file->private_data);
+		ubifs_assert(c, !data->dent);
 		if (!dir_emit_dots(file, ctx)) {
 			if (encrypted)
 				fscrypt_fname_free_buffer(&fstr);
@@ -641,10 +647,10 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 		}
 
 		ctx->pos = key_hash_flash(c, &dent->key);
-		file->private_data = dent;
+		data->dent = dent;
 	}
 
-	dent = file->private_data;
+	dent = data->dent;
 	if (!dent) {
 		/*
 		 * The directory was seek'ed to and is now readdir'ed.
@@ -658,7 +664,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 		ctx->pos = key_hash_flash(c, &dent->key);
-		file->private_data = dent;
+		data->dent = dent;
 	}
 
 	while (1) {
@@ -701,15 +707,15 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 
-		kfree(file->private_data);
+		kfree(data->dent);
 		ctx->pos = key_hash_flash(c, &dent->key);
-		file->private_data = dent;
+		data->dent = dent;
 		cond_resched();
 	}
 
 out:
-	kfree(file->private_data);
-	file->private_data = NULL;
+	kfree(data->dent);
+	data->dent = NULL;
 
 	if (encrypted)
 		fscrypt_fname_free_buffer(&fstr);
@@ -733,7 +739,10 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 /* Free saved readdir() state when the directory is closed */
 static int ubifs_dir_release(struct inode *dir, struct file *file)
 {
-	kfree(file->private_data);
+	struct ubifs_dir_data *data = file->private_data;
+
+	kfree(data->dent);
+	kfree(data);
 	file->private_data = NULL;
 	return 0;
 }
@@ -1712,6 +1721,24 @@ int ubifs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
+static int ubifs_dir_open(struct inode *inode, struct file *file)
+{
+	struct ubifs_dir_data	*data;
+
+	data = kzalloc(sizeof(struct ubifs_dir_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	file->private_data = data;
+	return 0;
+}
+
+static loff_t ubifs_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct ubifs_dir_data *data = file->private_data;
+
+	return generic_llseek_cookie(file, offset, whence, &data->cookie);
+}
+
 const struct inode_operations ubifs_dir_inode_operations = {
 	.lookup      = ubifs_lookup,
 	.create      = ubifs_create,
@@ -1732,7 +1759,9 @@ const struct inode_operations ubifs_dir_inode_operations = {
 };
 
 const struct file_operations ubifs_dir_operations = {
-	.llseek         = generic_file_llseek,
+	.open		= ubifs_dir_open,
+	.release	= ubifs_dir_release,
+	.llseek         = ubifs_dir_llseek,
 	.release        = ubifs_dir_release,
 	.read           = generic_read_dir,
 	.iterate_shared = ubifs_readdir,

-- 
2.45.2


