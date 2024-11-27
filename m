Return-Path: <linux-fsdevel+bounces-36018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8D9DAAC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9753C28160D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D01FF7D6;
	Wed, 27 Nov 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAQrJMwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FD20012E
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721304; cv=none; b=M6UTaRVkN8NxKYmSXqJHjSCBbsIlQ6U7gF5vRgGIhanKAjPo8He1YKepIquogckg3x7+cFXG4IyRewARIdL3/RBBX09yYVAtyieYVR3TajgAO6L4EjCMg6nYTsRiNTA1KJFpoxGtIS1x8FKFFptLsW97lMhWVz93D/0VOdR+izo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721304; c=relaxed/simple;
	bh=cm3XNveZKUOxWBzRqaJXCYdMMoTxeTEl5G9Suuio1jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFct24M6tZF4/Q/MQKrQroFe7SK5M6tIREWE/Xlnp/wi676TNC4kjYCPIOU7okc0uYOsdwJCVYiVFtXWSXn0ncdMLmgG/KHn2eflz7u3ZdH6LrkM/3QctBmEP/eW0IU8wX9yEJimZMV/GJXcWCTN4MkThr+qiSbzMJKNIrk3xdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAQrJMwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338BBC4CED8;
	Wed, 27 Nov 2024 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732721303;
	bh=cm3XNveZKUOxWBzRqaJXCYdMMoTxeTEl5G9Suuio1jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAQrJMwO3HcTBcQJtl9J0sN0/3Y2EaWG1HoGPOJVdXnlxSk8tgna/zSNZUpzF60BQ
	 3dRUcDoFH67L8gUn89drpvzoZcl7it2YQwMoAFiks5/PUQxhDyxKmxYM+O6WWJEWlc
	 FQIyCfAcqppQ5YYaKu+sco2Dy80Ug5cJOo/6T5axaEkQ0ldr4nCmcLxGs/KcL9CdM5
	 BlWKRM9OkdVQQzbHH6nPFhE7I9pZ907/6bqzK6KGTHGDpC9RAkEXw7UyaOuPFGjwcU
	 SCblQFp8y4T4FtLnBq7x0hIIAL/rlW8ih3aD8uw47R+heJXIeKxMQXLr0mcP36v18G
	 g0Y5KKEt0904g==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v3 5/5] libfs: Refactor offset_iterate_dir()
Date: Wed, 27 Nov 2024 10:28:15 -0500
Message-ID: <20241127152815.151781-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127152815.151781-1-cel@kernel.org>
References: <20241127152815.151781-1-cel@kernel.org>
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
 fs/libfs.c | 95 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 21 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 0deff5390abb..2616421bbe0e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -241,9 +241,9 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
-/* 0 is '.', 1 is '..', so always start with offset 2 or more */
 enum {
-	DIR_OFFSET_MIN	= 2,
+	DIR_OFFSET_FIRST	= 2,	/* seek to the first real entry */
+	DIR_OFFSET_MIN		= 3,	/* minimum allocated offset value */
 };
 
 static void offset_set(struct dentry *dentry, long offset)
@@ -507,19 +507,53 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
-static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
+/* Cf. find_next_child() */
+static struct dentry *find_next_sibling_locked(struct dentry *dentry)
 {
-	MA_STATE(mas, &octx->mt, offset, offset);
+	struct dentry *found = NULL;
+
+	hlist_for_each_entry_from(dentry, d_sib) {
+		if (!simple_positive(dentry))
+			continue;
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+		if (simple_positive(dentry))
+			found = dget_dlock(dentry);
+		spin_unlock(&dentry->d_lock);
+		if (likely(found))
+			break;
+	}
+	return found;
+}
+
+static noinline_for_stack struct dentry *offset_dir_first(struct file *file)
+{
+	struct dentry *parent = file->f_path.dentry;
+	struct dentry *found;
+
+	spin_lock(&parent->d_lock);
+	found = find_next_sibling_locked(d_first_child(parent));
+	spin_unlock(&parent->d_lock);
+	return found;
+}
+
+static noinline_for_stack struct dentry *
+offset_dir_lookup(struct file *file, loff_t offset)
+{
+	struct dentry *parent = file->f_path.dentry;
 	struct dentry *child, *found = NULL;
+	struct inode *inode = d_inode(parent);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
+
+	MA_STATE(mas, &octx->mt, offset, offset);
 
 	rcu_read_lock();
 	child = mas_find(&mas, LONG_MAX);
 	if (!child)
 		goto out;
-	spin_lock(&child->d_lock);
-	if (simple_positive(child))
-		found = dget_dlock(child);
-	spin_unlock(&child->d_lock);
+
+	spin_lock(&parent->d_lock);
+	found = find_next_sibling_locked(child);
+	spin_unlock(&parent->d_lock);
 out:
 	rcu_read_unlock();
 	return found;
@@ -534,29 +568,48 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
+static struct dentry *offset_dir_next(struct dentry *child)
+{
+	struct dentry *parent = child->d_parent;
+	struct dentry *found;
+
+	spin_lock(&parent->d_lock);
+	found = find_next_sibling_locked(d_next_sibling(child));
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


