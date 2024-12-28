Return-Path: <linux-fsdevel+bounces-38206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A3A9FDBCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 18:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DC4161B20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE1198857;
	Sat, 28 Dec 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGHkO4sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9C198833
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735408531; cv=none; b=Yfqe+x4+kSmg06ujIo4D1YSlVspFYQkjreiMuyoT16qaFeE+XNaJYYMnLj10v2162hlRxoQrZoRU8snBLxP++oQwga4iZ5uutd/yNcCVgkMU7Kn6MzCMixZELedXEduaJT8FTJknsKLtG81ZaROKDR34TJ0GmhoI1XRqnNkEZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735408531; c=relaxed/simple;
	bh=44QvGk8cIKJkG2AbH47kX36uIs9FlMTaiShWTtz/ZcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkoCNwCWgFA1x++IDz/cRO+C2FkX8mG7YMI1DnZrZL8Z0woEfJVB1A7b53XiIO8x8OLIZZ5aEZqV6k+j052iQsx+mWUF7n9odRbyYDEYllIn0tPUruPbBxr4d4dDT6V6CxvD7VsZP9odWthHaVvFEqoyKe/eFR6N41U2ksUdY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGHkO4sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E53DC4CEDD;
	Sat, 28 Dec 2024 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735408531;
	bh=44QvGk8cIKJkG2AbH47kX36uIs9FlMTaiShWTtz/ZcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGHkO4sy4HrHvpB8SLIsBftKGlob3Y95jIV20+LqDjkuubgCgBp8qFAcAK5Fyj8G7
	 brz14rgKpeBEykZnI3EHT6iMSv2V5q/3SB7jCob0Bo64VO5FG1UmkL9Mq8mBRdnslm
	 LTd6np81J77a2AJ2+9DlXJSAQiKQehAT/UxsopL35XOJ4iCJD7gyfwKJpfLq2NUMX3
	 /EdIhLT6f2fKRwpfPRC8USHkCUXZoI92E6Oj/VKi/9iAg5E0qJ5QQoEo/CU5PNtoIy
	 CYqin619Ts4VWpGorEiJiKrlXr8Aac9zFI+VLdJr7zTo8JrOSijNrppBVh9usbkXTL
	 BWQ+I5KvQXstg==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Liam.Howlett@oracle.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 3/5] Revert "libfs: fix infinite directory reads for offset dir"
Date: Sat, 28 Dec 2024 12:55:19 -0500
Message-ID: <20241228175522.1854234-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241228175522.1854234-1-cel@kernel.org>
References: <20241228175522.1854234-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The current directory offset allocator (based on mtree_alloc_cyclic)
stores the next offset value to return in octx->next_offset. This
mechanism typically returns values that increase monotonically over
time. Eventually, though, the newly allocated offset value wraps
back to a low number (say, 2) which is smaller than other already-
allocated offset values.

Yu Kuai <yukuai3@huawei.com> reports that, after commit 64a7ce76fb90
("libfs: fix infinite directory reads for offset dir"), if a
directory's offset allocator wraps, existing entries are no longer
visible via readdir/getdents because offset_readdir() stops listing
entries once an entry's offset is larger than octx->next_offset.
These entries vanish persistently -- they can be looked up, but will
never again appear in readdir(3) output.

The reason for this is that the commit treats directory offsets as
monotonically increasing integer values rather than opaque cookies,
and introduces this comparison:

	if (dentry2offset(dentry) >= last_index) {

On 64-bit platforms, the directory offset value upper bound is
2^63 - 1. Directory offsets will monotonically increase for millions
of years without wrapping.

On 32-bit platforms, however, LONG_MAX is 2^31 - 1. The allocator
can wrap after only a few weeks (at worst).

Revert commit 64a7ce76fb90 ("libfs: fix infinite directory reads for
offset dir") to prepare for a fix that can work properly on 32-bit
systems and might apply to recent LTS kernels where shmem employs
the simple_offset mechanism.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8380d9314ebd..8c9364a0174c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -422,14 +422,6 @@ void simple_offset_destroy(struct offset_ctx *octx)
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
@@ -443,9 +435,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct inode *inode = file->f_inode;
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -459,8 +448,7 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	if (!offset)
-		file->private_data = (void *)ctx->next_offset;
+	file->private_data = NULL;
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -491,7 +479,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
+static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
@@ -499,21 +487,17 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
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
@@ -540,19 +524,22 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
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


