Return-Path: <linux-fsdevel+bounces-61516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9693B58981
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936AC1B26491
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65D21A444;
	Tue, 16 Sep 2025 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAiLxc3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB516132F;
	Tue, 16 Sep 2025 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982619; cv=none; b=Ma5SfQuTZmKX0hfOJVaQ/ZEfuGvZVjnMO7nfLUgObKJUalGg5QzkFsicxJR9whVr8bbcQ6oVjtYVPmRObFcidZOsMNdgQUQJuwMHVZJ8oUkmLjYZsPx87KxFfRMMvGWdrg8LSbG7UmTdma68ZMwyy0syMmdhJBxHQFIHGvJ7r/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982619; c=relaxed/simple;
	bh=YmD8XTNeNvQgTQ5LuJcBuPsTBxPfw9pH0TcxjWABQ6Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5MD8hfcYXoEVklLGls57Dqn8eKRmeyHkF1zW6n8RXoHRvLHDo3UrYKlVxOGal8o58OLvNg+iZIdAuwAsiEZZFOBY3qObg1F7tQf4C/J1C/7iUOkqE6wQ1/5qfSPa4WLHFtLfFurjjCrzfxf4USsrf7mxsPQos4+wafU8I4MdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAiLxc3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C4CC4CEF5;
	Tue, 16 Sep 2025 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982619;
	bh=YmD8XTNeNvQgTQ5LuJcBuPsTBxPfw9pH0TcxjWABQ6Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GAiLxc3SZTTVanzDRAHPtFav2SaCJKhagaF7WzwodIJ5LBaAOdgtFN13yti44HGTe
	 +RmFtw0CZiY1N/4hirYQs3NxpvKTzVaZXAntjLHFOpQVP4c/uQaB7EGfyMTkqona98
	 vjhghFeDZXSyXnHTYHnoJfCT7xEhiL8uzK8W71jtmqQSb1c1qCvFWvoMeoyOgmlAPd
	 BlEwN5pglpkIqRrl9E3DJTjc9CzH1bij3mzGMyzBKLPqNrpeE+FG2PGxHrLOQHQjHv
	 x/UiRN0Ye3gMuht3bOjyEKDTcogkHD5ef8bmUrflOCeuHuQMAsCbKtHCw3loewqMlz
	 rjIjjRDAovmrg==
Date: Mon, 15 Sep 2025 17:30:19 -0700
Subject: [PATCH 09/28] fuse: isolate the other regular file IO paths from
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151459.382724.9822315455251396759.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

iomap completely takes over all regular file IO, so we don't need to
access any of the other mechanisms at all.  Gate them off so that we can
eventually overlay them with a union to save space in struct fuse_inode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c    |   14 +++++++++-----
 fs/fuse/file.c   |   18 +++++++++++++-----
 fs/fuse/inode.c  |    3 ++-
 fs/fuse/iomode.c |    2 +-
 4 files changed, 25 insertions(+), 12 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b116e42431ee12..6dbce975dc96b7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1998,6 +1998,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	FUSE_ARGS(args);
 	struct fuse_setattr_in inarg;
 	struct fuse_attr_out outarg;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = false;
 	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
 	loff_t oldsize;
@@ -2055,12 +2056,15 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (err)
 			return err;
 
-		fuse_set_nowrite(inode);
-		fuse_release_nowrite(inode);
+		if (!is_iomap) {
+			fuse_set_nowrite(inode);
+			fuse_release_nowrite(inode);
+		}
 	}
 
 	if (is_truncate) {
-		fuse_set_nowrite(inode);
+		if (!is_iomap)
+			fuse_set_nowrite(inode);
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 		if (trust_local_cmtime && attr->ia_size != inode->i_size)
 			attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
@@ -2132,7 +2136,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!is_wb || is_truncate)
 		i_size_write(inode, outarg.attr.size);
 
-	if (is_truncate) {
+	if (is_truncate && !is_iomap) {
 		/* NOTE: this may release/reacquire fi->lock */
 		__fuse_release_nowrite(inode);
 	}
@@ -2156,7 +2160,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 
 error:
-	if (is_truncate)
+	if (is_truncate && !is_iomap)
 		fuse_release_nowrite(inode);
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8982e0b9661bb1..0f253837b57fdc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -238,6 +238,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int err;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
 	bool is_wb_truncate = is_truncate && fc->writeback_cache;
 	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
@@ -259,7 +260,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 			goto out_inode_unlock;
 	}
 
-	if (is_wb_truncate || dax_truncate)
+	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_set_nowrite(inode);
 
 	err = fuse_do_open(fm, get_node_id(inode), file, false);
@@ -272,7 +273,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 			fuse_truncate_update_attr(inode, file);
 	}
 
-	if (is_wb_truncate || dax_truncate)
+	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_release_nowrite(inode);
 	if (!err) {
 		if (is_truncate)
@@ -520,12 +521,14 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct inode *inode = file->f_mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	const bool need_sync_writes = !fuse_inode_has_iomap(inode);
 	int err;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	inode_lock(inode);
+	if (need_sync_writes)
+		inode_lock(inode);
 
 	/*
 	 * Start writeback against all dirty pages of the inode, then
@@ -536,7 +539,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	if (err)
 		goto out;
 
-	fuse_sync_writes(inode);
+	if (need_sync_writes)
+		fuse_sync_writes(inode);
 
 	/*
 	 * Due to implementation of fuse writeback
@@ -560,7 +564,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 		err = 0;
 	}
 out:
-	inode_unlock(inode);
+	if (need_sync_writes)
+		inode_unlock(inode);
 
 	return err;
 }
@@ -1949,6 +1954,9 @@ static struct fuse_file *__fuse_write_file_get(struct fuse_inode *fi)
 {
 	struct fuse_file *ff;
 
+	if (fuse_inode_has_iomap(&fi->inode))
+		return NULL;
+
 	spin_lock(&fi->lock);
 	ff = list_first_entry_or_null(&fi->write_files, struct fuse_file,
 				      write_entry);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b209db07e60e33..4f348fc575a5c3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -194,7 +194,8 @@ static void fuse_evict_inode(struct inode *inode)
 		if (inode->i_nlink > 0)
 			atomic64_inc(&fc->evict_ctr);
 	}
-	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
+	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode) &&
+	    !fuse_inode_has_iomap(inode)) {
 		WARN_ON(fi->iocachectr != 0);
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c99e285f3183ef..92225dfa6e7ad9 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -204,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (FUSE_IS_DAX(inode) || !ff->args)
+	if (fuse_inode_has_iomap(inode) || FUSE_IS_DAX(inode) || !ff->args)
 		return 0;
 
 	/*


