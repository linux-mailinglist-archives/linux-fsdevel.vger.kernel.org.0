Return-Path: <linux-fsdevel+bounces-44353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3EAA67D3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7523421AEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D9E1EEA20;
	Tue, 18 Mar 2025 19:44:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787816F8F5;
	Tue, 18 Mar 2025 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327055; cv=none; b=CWm3FXcelWjWWmGb8dwlY9J9nwb+BL+7d989X0H/6CWb3CaIWlHbp1dD9XlSZwlP9Y/b3dOf05zu+4R6Wq/AEHUXy+SYZC11OlEGR/gve54yERH2ueoZLBTJLv8W4LRpQWqbIaA0stovZZ1s26QU9oV7VLXBrncCy+BcjG78/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327055; c=relaxed/simple;
	bh=BACGuoqehswM9fmxKSuC7MPf9JKTlGy7hJSvI8vEnys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/8/0P6vgZh2LYcbKeDriIXM6/6Gt76W3w+e/FeG2JrdrpdC3+FMm6kCIG8fE+oz3IClMuOs5boeE8ZFS85ZvCdxo9kt6EZfkdCzRT4XCASp2b8RGOwochbbw1ZCvJ+LowchmNBTEz0dARYD6fnzXltF66Tdvr4N8QlAspGnHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 6D92E1C005E;
	Tue, 18 Mar 2025 15:44:12 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 1/3] libfs: rework dcache_readdir to use an internal function with callback
Date: Tue, 18 Mar 2025 15:41:09 -0400
Message-ID: <20250318194111.19419-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
References: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.  Preparatory to using the internal function to
iterate a directory with just a dentry not a file.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/libfs.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8444f5cc4064..816bfe6c0430 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -189,28 +189,21 @@ EXPORT_SYMBOL(dcache_dir_lseek);
  * for ramfs-type trees they can't go away without unlink() or rmdir(),
  * both impossible due to the lock on directory.
  */
-
-int dcache_readdir(struct file *file, struct dir_context *ctx)
+static void internal_readdir(struct dentry *dentry, struct dentry *cursor,
+			     void *data, bool start,
+			     bool (*callback)(void *, struct dentry *))
 {
-	struct dentry *dentry = file->f_path.dentry;
-	struct dentry *cursor = file->private_data;
 	struct dentry *next = NULL;
 	struct hlist_node **p;
 
-	if (!dir_emit_dots(file, ctx))
-		return 0;
-
-	if (ctx->pos == 2)
+	if (start)
 		p = &dentry->d_children.first;
 	else
 		p = &cursor->d_sib.next;
 
 	while ((next = scan_positives(cursor, p, 1, next)) != NULL) {
-		if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
-			      d_inode(next)->i_ino,
-			      fs_umode_to_dtype(d_inode(next)->i_mode)))
+		if (!callback(data, next))
 			break;
-		ctx->pos++;
 		p = &next->d_sib.next;
 	}
 	spin_lock(&dentry->d_lock);
@@ -219,6 +212,30 @@ int dcache_readdir(struct file *file, struct dir_context *ctx)
 		hlist_add_before(&cursor->d_sib, &next->d_sib);
 	spin_unlock(&dentry->d_lock);
 	dput(next);
+}
+
+static bool dcache_readdir_callback(void *data, struct dentry *entry)
+{
+	struct dir_context *ctx = data;
+
+	if (!dir_emit(ctx, entry->d_name.name, entry->d_name.len,
+		      d_inode(entry)->i_ino,
+		      fs_umode_to_dtype(d_inode(entry)->i_mode)))
+		return false;
+	ctx->pos++;
+	return true;
+}
+
+int dcache_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct dentry *cursor = file->private_data;
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
+
+	internal_readdir(dentry, cursor, ctx, ctx->pos == 2,
+			 dcache_readdir_callback);
 
 	return 0;
 }
-- 
2.43.0


