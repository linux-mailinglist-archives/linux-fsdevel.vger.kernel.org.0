Return-Path: <linux-fsdevel+bounces-71122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FECB6185
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 14:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA033026AC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F8278E5D;
	Thu, 11 Dec 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Km+6MOEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734823EAB8;
	Thu, 11 Dec 2025 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461140; cv=none; b=W/wAwvmskyuGmsfRt1kSQiAzjZgSW/08OSa9ljQw3TJiLrg1C/Lsg4JRMB/HsdfvHW2HRQ9wUriHW2UNu9JbEn+o3WCQEY/+WU7FLfAEAOY+heFYYSTlrXEXbs8dqrtOzjSfW9St1jIOvCKlMtGElfnLCFYLse2tYcA4Jt7KO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461140; c=relaxed/simple;
	bh=laxVb/9Nh1maX2sbFZa/zeozujhX7WWwWNt3zQmNSwc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=liUHxzATVeIOv/tATFrDLpT3+qkbfZwMXEQjCXCoj4uIxY1kn2zh1GaLX7B4ZmxRwjSmtJbFnP0Ms4EtOr+sULxMz/379TwjWBJDCt5d7muSYO1ls5d++9GGk50+8FKkjvsTedcuDocxOJrMHbfmojMnkrb5IyhQdoyOzE1irkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Km+6MOEg; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D30C81D99;
	Thu, 11 Dec 2025 13:48:46 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=Km+6MOEg;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E27AA3AC;
	Thu, 11 Dec 2025 13:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1765461136;
	bh=vtN4ZDJ6vCDexffheE6S86WtIePMsvDWLEsPJ1Dlt7g=;
	h=From:To:CC:Subject:Date;
	b=Km+6MOEg+UJ8HUSm4mvbUizpQMIhGSMIg9LMU8cMVVQx58ew20qHp55B7ph+ue9M9
	 ruoUBn4iqUq24yQmLmJenorOE71ZdkQqHj+fLyb/hb8fjlWwuH/i6ojubd9vKRP5io
	 g75SKbAH663ywfhOMu6Bin90try+5jPuh1bfc9Qs=
Received: from localhost.localdomain (172.30.20.154) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 11 Dec 2025 16:52:16 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: allow readdir() to finish after directory mutations without rewinddir()
Date: Thu, 11 Dec 2025 14:52:06 +0100
Message-ID: <20251211135206.14006-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

This patch introduces a per-directory version counter that increments on
each directory modification (indx_insert_entry() / indx_delete_entry()).
ntfs_readdir() uses this version to detect whether the directory has
changed since enumeration began. If readdir() reaches end-of-directory
but the version has changed, the walk restarts from the beginning of the
index tree instead of returning prematurely. This provides rmdir-like
behavior for tools that remove entries as they enumerate them.

Prior to this change, bonnie++ directory operations could fail due to
premature termination of readdir() during concurrent index updates.
With this patch applied, bonnie++ completes successfully with no errors.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c     | 102 ++++++++++++++++++++++++++++++++-------------
 fs/ntfs3/index.c   |   2 +
 fs/ntfs3/ntfs_fs.h |   1 +
 3 files changed, 76 insertions(+), 29 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 1dbb661ffe0f..24cb64d5521a 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -392,33 +392,77 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
  * ntfs_readdir - file_operations::iterate_shared
  *
  * Use non sorted enumeration.
- * We have an example of broken volume where sorted enumeration
- * counts each name twice.
+ * Sorted enumeration may result infinite loop if names tree contains loop.
  */
 static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	const struct INDEX_ROOT *root;
-	u64 vbo;
 	size_t bit;
-	loff_t eod;
 	int err = 0;
 	struct inode *dir = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(dir);
 	struct super_block *sb = dir->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	loff_t i_size = i_size_read(dir);
-	u32 pos = ctx->pos;
+	u64 pos = ctx->pos;
 	u8 *name = NULL;
 	struct indx_node *node = NULL;
 	u8 index_bits = ni->dir.index_bits;
+	size_t max_bit = i_size >> ni->dir.index_bits;
+	loff_t eod = i_size + sbi->record_size;
 
 	/* Name is a buffer of PATH_MAX length. */
 	static_assert(NTFS_NAME_LEN * 4 < PATH_MAX);
 
-	eod = i_size + sbi->record_size;
+	if (!pos) {
+		/*
+		 * ni->dir.version increments each directory change.
+		 * Save the initial value of ni->dir.version.
+		 */
+		file->private_data = (void *)ni->dir.version;
+	}
 
-	if (pos >= eod)
-		return 0;
+	if (pos >= eod) {
+		if (file->private_data == (void *)ni->dir.version) {
+			/* No changes since first readdir. */
+			return 0;
+		}
+
+		/*
+		 * Handle directories that changed after the initial readdir().
+		 *
+		 * Some user space code implements recursive removal like this instead
+		 * of calling rmdir(2) directly:
+		 *
+		 *      fd = opendir(path);
+		 *      while ((dent = readdir(fd)))
+		 *              unlinkat(dirfd(fd), dent->d_name, 0);
+		 *      closedir(fd);
+		 *
+		 * POSIX leaves unspecified what readdir() should return once the
+		 * directory has been modified after opendir()/rewinddir(), so this
+		 * pattern is not guaranteed to work on all filesystems or platforms.
+		 *
+		 * In ntfs3 the internal name tree may be reshaped while entries are
+		 * being removed, so there is no stable anchor for continuing a
+		 * single-pass walk based on the original readdir() order.
+		 *
+		 * In practice some widely used tools (for example certain rm(1)
+		 * implementations) have used this readdir()/unlink() loop, and some
+		 * filesystems behave in a way that effectively makes it work in the
+		 * common case.
+		 *
+		 * The code below follows that practice and tries to provide
+		 * "rmdir-like" behaviour for such callers on ntfs3, even though the
+		 * situation is not strictly defined by the APIs.
+		 *
+		 * Apple documents the same readdir()/unlink() issue and a workaround
+		 * for HFS file systems in:
+		 * https://web.archive.org/web/20220122122948/https:/support.apple.com/kb/TA21420?locale=en_US
+		 */
+		ctx->pos = pos = 3;
+		file->private_data = (void *)ni->dir.version;
+	}
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
@@ -454,35 +498,31 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	if (pos >= sbi->record_size) {
 		bit = (pos - sbi->record_size) >> index_bits;
 	} else {
+		/*
+		 * Add each name from root in 'ctx'.
+		 */
 		err = ntfs_read_hdr(sbi, ni, &root->ihdr, 0, pos, name, ctx);
 		if (err)
 			goto out;
 		bit = 0;
 	}
 
-	if (!i_size) {
-		ctx->pos = eod;
-		goto out;
-	}
-
-	for (;;) {
-		vbo = (u64)bit << index_bits;
-		if (vbo >= i_size) {
-			ctx->pos = eod;
-			goto out;
-		}
-
+	/*
+	 * Enumerate indexes until the end of dir.
+	 */
+	for (; bit < max_bit; bit += 1) {
+		/* Get the next used index. */
 		err = indx_used_bit(&ni->dir, ni, &bit);
 		if (err)
 			goto out;
 
 		if (bit == MINUS_ONE_T) {
-			ctx->pos = eod;
-			goto out;
+			/* no more used indexes. end of dir. */
+			break;
 		}
 
-		vbo = (u64)bit << index_bits;
-		if (vbo >= i_size) {
+		if (bit >= max_bit) {
+			/* Corrupted directory. */
 			err = -EINVAL;
 			goto out;
 		}
@@ -492,20 +532,24 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		if (err)
 			goto out;
 
+		/*
+		 * Add each name from index in 'ctx'.
+		 */
 		err = ntfs_read_hdr(sbi, ni, &node->index->ihdr,
-				    vbo + sbi->record_size, pos, name, ctx);
+				    ((u64)bit << index_bits) + sbi->record_size,
+				    pos, name, ctx);
 		if (err)
 			goto out;
-
-		bit += 1;
 	}
 
 out:
-
 	__putname(name);
 	put_indx_node(node);
 
-	if (err == 1) {
+	if (!err) {
+		/* End of directory. */
+		ctx->pos = eod;
+	} else if (err == 1) {
 		/* 'ctx' is full. */
 		err = 0;
 	} else if (err == -ENOENT) {
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index f0cfa000ffbb..d08bee3c20fa 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -2002,6 +2002,7 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 					      fnd->level - 1, fnd);
 	}
 
+	indx->version += 1;
 out:
 	fnd_put(fnd_a);
 out1:
@@ -2649,6 +2650,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		mi->dirty = true;
 	}
 
+	indx->version += 1;
 out:
 	fnd_put(fnd2);
 out1:
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 18b14f7db4ad..cee7b73b9670 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -191,6 +191,7 @@ struct ntfs_index {
 	struct runs_tree alloc_run;
 	/* read/write access to 'bitmap_run'/'alloc_run' while ntfs_readdir */
 	struct rw_semaphore run_lock;
+	size_t version; /* increment each change */
 
 	/*TODO: Remove 'cmp'. */
 	NTFS_CMP_FUNC cmp;
-- 
2.43.0


