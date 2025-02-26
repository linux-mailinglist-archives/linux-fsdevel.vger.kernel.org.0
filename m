Return-Path: <linux-fsdevel+bounces-42688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8BBA462E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67D0168AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F58221F17;
	Wed, 26 Feb 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXrDxxV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7B192B77;
	Wed, 26 Feb 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580263; cv=none; b=Dx6EPGvcFfDkVKF/Raxge+xXWD4UpsiHpOHxtW1S8GyJ3kgjMOPkJ2aoClPbrmYko9iBAX5HzUX5d1wLevkJRxDWcn+l/+PVSyvcrcbR7jsUBX8IBRYp+HAgPcbAOoeM6J19H9BQAdaMGvsaoZtfMvspSt5IhTgNKrRo2Bj8sfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580263; c=relaxed/simple;
	bh=E3sm61jZe/lp7YwwF12TBEhOBv3rz1T48nGVqAYjySU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxbgcTBhjuocgxYtQzerYaJOqt2L9dx5LE8L8Ru/9BBOhrZFNcI4qR2Xb2cRfbIbrSqvM+swCb1ZQqdz3Q/fsTb2RHiDZRxoMDu1ePdjNcEnjRz5n/td+wipxc3lXVX0U44NOvBvvij89ZR5EJvp2eXvx3/Aow+6IvZl1hsOkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXrDxxV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A7DC4CED6;
	Wed, 26 Feb 2025 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740580262;
	bh=E3sm61jZe/lp7YwwF12TBEhOBv3rz1T48nGVqAYjySU=;
	h=From:To:Cc:Subject:Date:From;
	b=nXrDxxV2jqRVqz5FCBgOTaYTmI5+m217Z/CYjCjWvU7rj2aLrTkv1dHiyOzEVJWqT
	 jXfCRi3VG6kVj/b5m89RRcmrVGZebbqrHOpWaA1AJwr0i4pghUHCHM1FY9a7pnY4FO
	 DAMP6/B8mN+r5Kejke5yiklaPvrfFv0I3ALmwUls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] Revert "libfs: Use d_children list to iterate simple_offset directories"
Date: Wed, 26 Feb 2025 15:29:45 +0100
Message-ID: <2025022644-blinked-broadness-c810@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 158
X-Developer-Signature: v=1; a=openpgp-sha256; l=4709; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=E3sm61jZe/lp7YwwF12TBEhOBv3rz1T48nGVqAYjySU=; b=owGbwMvMwCRo6H6F97bub03G02pJDOn7VSOYerSvm4q/NDy4oPboNBt25pQr9o+c1126qBiY2 izitnNhRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzk/0mGeRbTnAWCb0Y+mllp OCkgWbBsob3zDYYF60T6Xebv7eFNi/C9e5dHaKuE7dcCAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.

There are reports of this commit breaking Chrome's rendering mode.  As
no one seems to want to do a root-cause, let's just revert it for now as
it is affecting people using the latest release as well as the stable
kernels that it has been backported to.

Link: https://lore.kernel.org/r/874j0lvy89.wl-tiwai@suse.de
Fixes: b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset directories")
Cc: stable <stable@kernel.org>
Reported-by: Takashi Iwai <tiwai@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/libfs.c | 90 ++++++++++++++++++------------------------------------
 1 file changed, 29 insertions(+), 61 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8444f5cc4064..96f491f82f99 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -247,13 +247,12 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
 
 /* simple_offset_add() never assigns these to a dentry */
 enum {
-	DIR_OFFSET_FIRST	= 2,		/* Find first real entry */
 	DIR_OFFSET_EOD		= S32_MAX,
 };
 
 /* simple_offset_add() allocation range */
 enum {
-	DIR_OFFSET_MIN		= DIR_OFFSET_FIRST + 1,
+	DIR_OFFSET_MIN		= 2,
 	DIR_OFFSET_MAX		= DIR_OFFSET_EOD - 1,
 };
 
@@ -458,82 +457,51 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
-static struct dentry *find_positive_dentry(struct dentry *parent,
-					   struct dentry *dentry,
-					   bool next)
+static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
 {
-	struct dentry *found = NULL;
-
-	spin_lock(&parent->d_lock);
-	if (next)
-		dentry = d_next_sibling(dentry);
-	else if (!dentry)
-		dentry = d_first_child(parent);
-	hlist_for_each_entry_from(dentry, d_sib) {
-		if (!simple_positive(dentry))
-			continue;
-		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-		if (simple_positive(dentry))
-			found = dget_dlock(dentry);
-		spin_unlock(&dentry->d_lock);
-		if (likely(found))
-			break;
-	}
-	spin_unlock(&parent->d_lock);
-	return found;
-}
-
-static noinline_for_stack struct dentry *
-offset_dir_lookup(struct dentry *parent, loff_t offset)
-{
-	struct inode *inode = d_inode(parent);
-	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
+	MA_STATE(mas, &octx->mt, offset, offset);
 	struct dentry *child, *found = NULL;
 
-	MA_STATE(mas, &octx->mt, offset, offset);
-
-	if (offset == DIR_OFFSET_FIRST)
-		found = find_positive_dentry(parent, NULL, false);
-	else {
-		rcu_read_lock();
-		child = mas_find(&mas, DIR_OFFSET_MAX);
-		found = find_positive_dentry(parent, child, false);
-		rcu_read_unlock();
-	}
+	rcu_read_lock();
+	child = mas_find(&mas, DIR_OFFSET_MAX);
+	if (!child)
+		goto out;
+	spin_lock(&child->d_lock);
+	if (simple_positive(child))
+		found = dget_dlock(child);
+	spin_unlock(&child->d_lock);
+out:
+	rcu_read_unlock();
 	return found;
 }
 
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
+	long offset = dentry2offset(dentry);
 
-	return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
-			inode->i_ino, fs_umode_to_dtype(inode->i_mode));
+	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
+			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
+static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
-	struct dentry *dir = file->f_path.dentry;
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
 
-	dentry = offset_dir_lookup(dir, ctx->pos);
-	if (!dentry)
-		goto out_eod;
 	while (true) {
-		struct dentry *next;
-
-		ctx->pos = dentry2offset(dentry);
-		if (!offset_dir_emit(ctx, dentry))
-			break;
-
-		next = find_positive_dentry(dir, dentry, true);
-		dput(dentry);
-
-		if (!next)
+		dentry = offset_find_next(octx, ctx->pos);
+		if (!dentry)
 			goto out_eod;
-		dentry = next;
+
+		if (!offset_dir_emit(ctx, dentry)) {
+			dput(dentry);
+			break;
+		}
+
+		ctx->pos = dentry2offset(dentry) + 1;
+		dput(dentry);
 	}
-	dput(dentry);
 	return;
 
 out_eod:
@@ -572,7 +540,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 	if (ctx->pos != DIR_OFFSET_EOD)
-		offset_iterate_dir(file, ctx);
+		offset_iterate_dir(d_inode(dir), ctx);
 	return 0;
 }
 
-- 
2.48.1


