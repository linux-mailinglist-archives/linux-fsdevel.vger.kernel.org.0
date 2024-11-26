Return-Path: <linux-fsdevel+bounces-35924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B709D9AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A761216289E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047B1DB344;
	Tue, 26 Nov 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsK6NV8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7D1DAC90
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636497; cv=none; b=Ib+bHzlRxst1aHYdMg61XvTav9HlLRbNequ5zhOiQr0p1Y2kNQy7F/sgNt3VDYKJW2ChhgFYa/sfQZWBxBALl74c5f/I0mqpOjvH1qUise7ZABBiw5KUg/9GYnjPiepoV+Yh6CI4Onn/vZqGYfTVxot/7Q07SbU20/UqwD3kuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636497; c=relaxed/simple;
	bh=tMz/47mxpsuDcyrl6vBlEBAasdrsXvapQPHriWB0vcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKz2+praieyHTE+uy13S6ydoAy1uX/iH7WsslJPfxBkZro48yPhWl0lNd8N/8gRMzPhOEPY1vso83MxDrhTfIHrpSz2SAz6MoRKO2AZY05+4sbXd8VpWWGiyB9UuaPsLF1Lmw2nU/oru9tHGILJNlXtJ4IUpthxzb62Tnt7aqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsK6NV8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA74C4CED3;
	Tue, 26 Nov 2024 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732636497;
	bh=tMz/47mxpsuDcyrl6vBlEBAasdrsXvapQPHriWB0vcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsK6NV8jA66kTudkpuY9LMmdM8pQatvG2B2mhSyAac4M/AEOF25/vatqmM9Falwci
	 yj7mYfpwIf2l+hqSnEoF+aP5ks6Sa9qzjw4ccEmVHYRy4GL0VFDkDcsJNEqWotFeud
	 presvLu/aV0ui65cWMC7eg09NrL7cNa2Nq2ua9M6mxyMZYUPfoiJYim0q/GAjg3Md5
	 VO5R3CDpPk9qijalnRWIXExd8XetVGsblXaetFQ8LqpSTHEuyY/f27mhUzno/q2yQp
	 FjMxtZUy+R4esvZFh/CugOAt1+qwdk6nNVWCiKHQe0RHfsWh95kIV/HLyZBzAJto/H
	 HCyI48l739NTg==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2 4/5] libfs: Refactor end-of-directory detection for simple_offset directories
Date: Tue, 26 Nov 2024 10:54:43 -0500
Message-ID: <20241126155444.2556-5-cel@kernel.org>
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

This mechanism seems have been misunderstood more than once. Make
the code more self-documentary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 54 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e6c46b13fc71..be641a84047a 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -453,6 +453,34 @@ void simple_offset_destroy(struct offset_ctx *octx)
 	mtree_destroy(&octx->mt);
 }
 
+static void offset_set_eod(struct file *file)
+{
+	file->private_data = ERR_PTR(-ENOENT);
+}
+
+static void offset_clear_eod(struct file *file)
+{
+	file->private_data = NULL;
+}
+
+static bool offset_at_eod(struct file *file)
+{
+	return file->private_data == ERR_PTR(-ENOENT);
+}
+
+/**
+ * offset_dir_open - Open a directory descriptor
+ * @inode: directory to be opened
+ * @file: struct file to instantiate
+ *
+ * Returns zero on success, or a negative errno value.
+ */
+static int offset_dir_open(struct inode *inode, struct file *file)
+{
+	offset_clear_eod(file);
+	return 0;
+}
+
 /**
  * offset_dir_llseek - Advance the read position of a directory descriptor
  * @file: an open directory whose position is to be updated
@@ -478,8 +506,8 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 		return -EINVAL;
 	}
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	file->private_data = NULL;
+	/* ->private_data is protected by f_pos_lock */
+	offset_clear_eod(file);
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -510,15 +538,20 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
 {
+	struct dentry *dir = file->f_path.dentry;
+	struct inode *inode = d_inode(dir);
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
 
 	while (true) {
 		dentry = offset_find_next(octx, ctx->pos);
-		if (!dentry)
-			return ERR_PTR(-ENOENT);
+		if (!dentry) {
+			/* ->private_data is protected by f_pos_lock */
+			offset_set_eod(file);
+			return;
+		}
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -528,7 +561,6 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
 	}
-	return NULL;
 }
 
 /**
@@ -561,16 +593,14 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == DIR_OFFSET_MIN)
-		file->private_data = NULL;
-	else if (file->private_data == ERR_PTR(-ENOENT))
-		return 0;
-	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
+	/* ->private_data is protected by f_pos_lock */
+	if (!offset_at_eod(file))
+		offset_iterate_dir(file, ctx);
 	return 0;
 }
 
 const struct file_operations simple_offset_dir_operations = {
+	.open		= offset_dir_open,
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
-- 
2.47.0


