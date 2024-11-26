Return-Path: <linux-fsdevel+bounces-35925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED7E9D9B10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 17:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62DCB29872
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9261DAC9A;
	Tue, 26 Nov 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aukl0fCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87C1DA61B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636498; cv=none; b=rnMhQB9mrPvFFcbZ69bS5BmdyMk3ciS7nwVraREjiEDVx5XC/8hvdlwuYh+lDgg/OFWjiYDw0T5lND6cDgPNS3+bOWOQSIvvnTtz3ToSKlLOSjigV50JBUo9LqZTQ+ZRXkmQYst72cha5KqmiS3wH4YKTqn1W3y89TuA3IOnnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636498; c=relaxed/simple;
	bh=l4XCZVlwO/32TPnzhT69mYkOXGa3rUk3rjWN4U/BZdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsZmWM/ZfA9482I7NUmoW/ZjFKjO2xZYl6FyqwqybLUetC5wCn3ris4SbPsg6ttUhQArBe9xXkakXe1Rk3hMkEv4sDTJCgpaLOl2kyI3g0dZBxsW1181nNZWLYUs+NAHRRhinCX5u9H3vsKcsOWFxI51ZJtoFWazofpoxUxqJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aukl0fCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3870BC4CED7;
	Tue, 26 Nov 2024 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732636498;
	bh=l4XCZVlwO/32TPnzhT69mYkOXGa3rUk3rjWN4U/BZdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aukl0fCDiCZH1mltSMfE078b+QiSx1oYrncyG7BPLLeBrJpI/mYBPvRwqP1VOvqOE
	 4aTKsTb5LJePJEXAnF7uz+znj+PvK2gAXJF6PcrL4fsAqfdVwHAR3Ps38LP1lCeO/v
	 AaMJZKZaQJoXpdnpHVK0hvWY0RNqxnymlHPEqP8d9JLHUsZvdUWdBioiU/veJtU/hw
	 kc7H44lmJRBVOsJm3BZWhBscorvatt1RzkelvzMeMSfZteV/eE8AphXPhC/j8ShCkn
	 wonsfhF5alWIOvuXOnRfGI0/r5d7g/iEDUc2lstZe411KI0GGiaX1bfHbZTcQYo5jQ
	 uun6vWQx5mkwg==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2 5/5] libfs: Refactor offset_iterate_dir()
Date: Tue, 26 Nov 2024 10:54:44 -0500
Message-ID: <20241126155444.2556-6-cel@kernel.org>
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

This line in offset_iterate_dir():

		ctx->pos = dentry2offset(dentry) + 1;

assumes that the next child entry has an offset value that is
greater than the current child entry. Since directory offsets are
actually cookies, this heuristic is not always correct.

We have tested the current code with a limited offset range to see
if this is an operational problem. It doesn't seem to be, but doing
a "+ 1" on what is supposed to be an opaque cookie is very likely
wrong and brittle.

Instead of using the mtree to emit entries in the order of their
offset values, use it only to map the initial ctx->pos to a starting
entry. Then use the directory's d_children list, which is already
maintained by the dcache, to find the next child to emit, as the
simple cursor-based implementation still does.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 18 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index be641a84047a..862b4203d389 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -241,9 +241,9 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
-/* 0 is '.', 1 is '..', so always start with offset 2 or more */
 enum {
-	DIR_OFFSET_MIN	= 2,
+	DIR_OFFSET_FIRST	= 2,	/* seek to the first real entry */
+	DIR_OFFSET_MIN		= 3,	/* lowest real offset value */
 };
 
 static void offset_set(struct dentry *dentry, long offset)
@@ -267,7 +267,7 @@ void simple_offset_init(struct offset_ctx *octx)
 {
 	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE);
 	lockdep_set_class(&octx->mt.ma_lock, &simple_offset_lock_class);
-	octx->next_offset = DIR_OFFSET_MIN;
+	octx->next_offset = 0;
 }
 
 /**
@@ -511,10 +511,30 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
-static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
+static noinline_for_stack struct dentry *offset_dir_first(struct file *file)
 {
+	struct dentry *child, *found = NULL, *dir = file->f_path.dentry;
+
+	spin_lock(&dir->d_lock);
+	child = d_first_child(dir);
+	if (child && simple_positive(child)) {
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		if (simple_positive(child))
+			found = dget_dlock(child);
+		spin_unlock(&child->d_lock);
+	}
+	spin_unlock(&dir->d_lock);
+	return found;
+}
+
+static noinline_for_stack struct dentry *
+offset_dir_lookup(struct file *file, loff_t offset)
+{
+	struct dentry *child, *found = NULL, *dir = file->f_path.dentry;
+	struct inode *inode = d_inode(dir);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
+
 	MA_STATE(mas, &octx->mt, offset, offset);
-	struct dentry *child, *found = NULL;
 
 	rcu_read_lock();
 	child = mas_find(&mas, LONG_MAX);
@@ -538,29 +558,62 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
+/*
+ * This is find_next_child() without the dput() tail. We might
+ * combine offset_dir_next() and find_next_child().
+ */
+static struct dentry *offset_dir_next(struct dentry *dentry)
+{
+	struct dentry *parent = dentry->d_parent;
+	struct dentry *d, *found = NULL;
+
+	spin_lock(&parent->d_lock);
+	d = d_next_sibling(dentry);
+	hlist_for_each_entry_from(d, d_sib) {
+		if (simple_positive(d)) {
+			spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
+			if (simple_positive(d))
+				found = dget_dlock(d);
+			spin_unlock(&d->d_lock);
+			if (likely(found))
+				break;
+		}
+	}
+	spin_unlock(&parent->d_lock);
+	return found;
+}
+
 static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
 {
-	struct dentry *dir = file->f_path.dentry;
-	struct inode *inode = d_inode(dir);
-	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
-	struct dentry *dentry;
+	struct dentry *dentry, *next = NULL;
+
+	if (ctx->pos == DIR_OFFSET_FIRST)
+		dentry = offset_dir_first(file);
+	else
+		dentry = offset_dir_lookup(file, ctx->pos);
+	if (!dentry) {
+		/* ->private_data is protected by f_pos_lock */
+		offset_set_eod(file);
+		return;
+	}
 
 	while (true) {
-		dentry = offset_find_next(octx, ctx->pos);
-		if (!dentry) {
-			/* ->private_data is protected by f_pos_lock */
-			offset_set_eod(file);
-			return;
-		}
-
 		if (!offset_dir_emit(ctx, dentry)) {
-			dput(dentry);
+			ctx->pos = dentry2offset(dentry);
+			break;
+		}
+
+		next = offset_dir_next(dentry);
+		if (!next) {
+			offset_set_eod(file);
 			break;
 		}
 
-		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
+		dentry = next;
 	}
+
+	dput(dentry);
 }
 
 /**
-- 
2.47.0


