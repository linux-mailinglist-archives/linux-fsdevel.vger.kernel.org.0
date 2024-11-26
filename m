Return-Path: <linux-fsdevel+bounces-35923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04739D9AD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16028163AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0925E1DAC81;
	Tue, 26 Nov 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By05q8Qa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682431DA631
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636496; cv=none; b=rkqalK/n06KfWCthxBStUeRJrlXAyJCiKuJ04t5WQi0WaL8iTe1f2mjDwEqg1QICgFvuyyFnOI8FyI35qocZJv31sJZrvfx2eQfYGUk1AuOC1KxR8LEMWOBBPnuu345Co2FUz01Iz3b4aeIiuKMZYbOtnuyMfteHkncfRgCqB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636496; c=relaxed/simple;
	bh=G5Isx5LWQiXPXi2iyTyoRug884HtfgCAxYAVKEyJLvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfGsaQGytluyuA0Nmr1FxlvwQSLmPRpiKpQKV02NSh4zyfE83XLJTYoI7qxrjxqju5+ffgEbgD71YT10sIqUNIlNvB1hZAaO9da0XHRSQbBTu8cTDOkHIc3CZZeRUULpgeU7zNu8NDjZNSwqee6O+zbF+TSHBYi4LkTjeZbNiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By05q8Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2F4C4CED2;
	Tue, 26 Nov 2024 15:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732636496;
	bh=G5Isx5LWQiXPXi2iyTyoRug884HtfgCAxYAVKEyJLvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=By05q8QaTXtyBsRr33oV31LREOAX2SwvLMusYu3wtZsr58fcPnb2O6q6OVj5NXrg5
	 K1HCHoPJ9iV1kyOupcUv9D6Ev255H5pDTnKE365/Boa7xD8q261E8HpblyqRdUFGXN
	 6S1Eq4+P6nDCAoOIubvwlhe7PAn+gCCxgqdSx96oVZgn4WfXaNavV4Y5a6wZ+Ef2mg
	 vQCS0Sqr0O1LnmdolPkaIKmcFv9f/BtAUfjFLLQkVEtni3j0/8iy2pkb12EV9Fdy9h
	 2y+NhHSiEobBm0DiCwuxEhfElV5uaHugC2fdXausDp9XXrpmj9Ob5/PLxCqr1E2ofB
	 FlWAyDTdmQJtA==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2 3/5] Revert "libfs: fix infinite directory reads for offset dir"
Date: Tue, 26 Nov 2024 10:54:42 -0500
Message-ID: <20241126155444.2556-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126155444.2556-1-cel@kernel.org>
References: <20241126155444.2556-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Using octx->next_offset to determine the newest entries works only
because the offset value range is 63-bits. If an offset were to
wrap, existing entries are no longer visible to readdir because
offset_readdir() stops listing entries once an entry's offset is
larger than octx->next_offset.

Revert this fix for the infinite readdir loop bug to make room for
a better fix.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index c88ed15437c7..e6c46b13fc71 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -453,14 +453,6 @@ void simple_offset_destroy(struct offset_ctx *octx)
 	mtree_destroy(&octx->mt);
 }
 
-static int offset_dir_open(struct inode *inode, struct file *file)
-{
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
-	file->private_data = (void *)ctx->next_offset;
-	return 0;
-}
-
 /**
  * offset_dir_llseek - Advance the read position of a directory descriptor
  * @file: an open directory whose position is to be updated
@@ -474,9 +466,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct inode *inode = file->f_inode;
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -490,8 +479,7 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	if (!offset)
-		file->private_data = (void *)ctx->next_offset;
+	file->private_data = NULL;
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -522,7 +510,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
+static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
@@ -530,21 +518,17 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
 	while (true) {
 		dentry = offset_find_next(octx, ctx->pos);
 		if (!dentry)
-			return;
-
-		if (dentry2offset(dentry) >= last_index) {
-			dput(dentry);
-			return;
-		}
+			return ERR_PTR(-ENOENT);
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
-			return;
+			break;
 		}
 
 		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
 	}
+	return NULL;
 }
 
 /**
@@ -571,19 +555,22 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
 static int offset_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dir = file->f_path.dentry;
-	long last_index = (long)file->private_data;
 
 	lockdep_assert_held(&d_inode(dir)->i_rwsem);
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	offset_iterate_dir(d_inode(dir), ctx, last_index);
+	/* In this case, ->private_data is protected by f_pos_lock */
+	if (ctx->pos == DIR_OFFSET_MIN)
+		file->private_data = NULL;
+	else if (file->private_data == ERR_PTR(-ENOENT))
+		return 0;
+	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
 	return 0;
 }
 
 const struct file_operations simple_offset_dir_operations = {
-	.open		= offset_dir_open,
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
-- 
2.47.0


