Return-Path: <linux-fsdevel+bounces-23845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C845A933FEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A861F253FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F83143898;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q5lSOmBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64E1802A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231244; cv=none; b=YB/IT8wCDQCxwApCeiKO8hbmU6F4e6awOSJPtN1sPJ78LCyvU9Myz41+wrrtPghr69kdod0zAHdvOGsopiA8udGYxO6+kE6jOf/uX+mOh8cNpvm/kRYGRU6ZpdVoL8QcYBXokWVI/RMgidfAKSY+PFkwi+kEKrpJOZd/FWhne1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231244; c=relaxed/simple;
	bh=XsLa3wjPwY4tvC3JlDDsaQReAiwZgHVqUI2My++KozM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SenJQep0thw2+PwpnCbz1N97sqtxwM3wxcFs8/vDJzLdiophNeQvZXqMlUDIqDtPAXfKVmG4yKi2AMDYc+mQXYR1Ohr0R9TZf+nEhVy86p58NWu9aV1aWx/2Xdn0bQK8i2SBPieukiTaYdA3C4mPqoaM2JoLdqVJobgu5C70yA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q5lSOmBF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=M1qncU5r5DL7sEbkUTF9LvxrOOhkwhsEagnCN69UexQ=; b=q5lSOmBFsEylKnoWtKey9f8BU7
	JHcBXtbK6eQm15ylJMZ4kdkRj6NOYXFAos8t1r+NOXf4uIhPNDYOK/nOMdUMWZXLdydKYV+jt+prq
	/tYZEGtYnTGPiRDpTXiPwVgorv8+5ATurtn9nC2A8aWAfaMU2YhYfSLfegIG7Nudcvea6TX4BoWFM
	xj+PE970GL+fcYUjwKay9D81dKLKAyBC3Xe0dfnKG4mIlGfX1zrtLSsDk1ZUBiRal2JZrb/ehbNF2
	yznmlxwmL2L/zQX5XOMOkfiyqrDKZGMLTcN67n3LztuFLsV1HALqyCDOPZCDL+YJ4yixThE85CExf
	Tk9GOrjw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sC-00000000zuT-2m3R;
	Wed, 17 Jul 2024 15:47:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/23] buffer: Convert block_write_end() to take a folio
Date: Wed, 17 Jul 2024 16:46:57 +0100
Message-ID: <20240717154716.237943-8-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers now have a folio, so pass it in instead of converting
from a folio to a page and back to a folio again.  Saves a call
to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/fops.c                | 2 +-
 fs/buffer.c                 | 5 ++---
 fs/ext2/dir.c               | 2 +-
 fs/ext4/inode.c             | 4 ++--
 fs/iomap/buffered-io.c      | 2 +-
 fs/minix/dir.c              | 2 +-
 fs/nilfs2/dir.c             | 2 +-
 fs/nilfs2/recovery.c        | 2 +-
 fs/sysv/dir.c               | 2 +-
 fs/ufs/dir.c                | 2 +-
 include/linux/buffer_head.h | 4 ++--
 11 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index da44fedb23e5..df0e762cf397 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -462,7 +462,7 @@ static int blkdev_write_end(struct file *file, struct address_space *mapping,
 {
 	struct folio *folio = page_folio(page);
 	int ret;
-	ret = block_write_end(file, mapping, pos, len, copied, page, fsdata);
+	ret = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
 
 	folio_unlock(folio);
 	folio_put(folio);
diff --git a/fs/buffer.c b/fs/buffer.c
index 448338810802..acba3dfe55d8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2247,9 +2247,8 @@ EXPORT_SYMBOL(block_write_begin);
 
 int block_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	size_t start = pos - folio_pos(folio);
 
 	if (unlikely(copied < len)) {
@@ -2288,7 +2287,7 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 	loff_t old_size = inode->i_size;
 	bool i_size_changed = false;
 
-	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
+	copied = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
 
 	/*
 	 * No need to use i_size_read() here, the i_size cannot change under us
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 087457061c6e..60605fbdd0eb 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -87,7 +87,7 @@ static void ext2_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 	struct inode *dir = mapping->host;
 
 	inode_inc_iversion(dir);
-	block_write_end(NULL, mapping, pos, len, len, &folio->page, NULL);
+	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..1e4831d83adc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1315,7 +1315,7 @@ static int ext4_write_end(struct file *file,
 		return ext4_write_inline_data_end(inode, pos, len, copied,
 						  folio);
 
-	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
+	copied = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
 	/*
 	 * it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
@@ -3029,7 +3029,7 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	 * flag, which all that's needed to trigger page writeback.
 	 */
 	copied = block_write_end(NULL, mapping, pos, len, copied,
-			&folio->page, NULL);
+			folio, NULL);
 	new_i_size = pos + copied;
 
 	/*
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86ac..9b4ca3811a24 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -900,7 +900,7 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t bh_written;
 
 		bh_written = block_write_end(NULL, iter->inode->i_mapping, pos,
-					len, copied, &folio->page, NULL);
+					len, copied, folio, NULL);
 		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
 		return bh_written == copied;
 	}
diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 5f9e2fc91003..dd2a425b41f0 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -45,7 +45,7 @@ static void dir_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 	struct address_space *mapping = folio->mapping;
 	struct inode *dir = mapping->host;
 
-	block_write_end(NULL, mapping, pos, len, len, &folio->page, NULL);
+	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 4a29b0138d75..66af42f88ca7 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -96,7 +96,7 @@ static void nilfs_commit_chunk(struct folio *folio,
 	int err;
 
 	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, from, to);
-	copied = block_write_end(NULL, mapping, pos, len, len, &folio->page, NULL);
+	copied = block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 	if (pos + copied > dir->i_size)
 		i_size_write(dir, pos + copied);
 	if (IS_DIRSYNC(dir))
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 15653701b1c8..40c5dfbc9d41 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -533,7 +533,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_page;
 
 		block_write_end(NULL, inode->i_mapping, pos, blocksize,
-				blocksize, page, NULL);
+				blocksize, folio, NULL);
 
 		folio_unlock(folio);
 		folio_put(folio);
diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 27eaa5273ba7..639307e2ff8c 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -33,7 +33,7 @@ static void dir_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 	struct address_space *mapping = folio->mapping;
 	struct inode *dir = mapping->host;
 
-	block_write_end(NULL, mapping, pos, len, len, &folio->page, NULL);
+	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
 		mark_inode_dirty(dir);
diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 3b3cd84f1f7f..1579561118f5 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -48,7 +48,7 @@ static void ufs_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 	struct inode *dir = mapping->host;
 
 	inode_inc_iversion(dir);
-	block_write_end(NULL, mapping, pos, len, len, &folio->page, NULL);
+	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
 		mark_inode_dirty(dir);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 14acf1bbe0ce..3a3fec154536 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -262,8 +262,8 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(struct file *, struct address_space *,
-				loff_t, unsigned, unsigned,
-				struct page *, void *);
+				loff_t, unsigned len, unsigned copied,
+				struct folio *, void *);
 int generic_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
 				struct page *, void *);
-- 
2.43.0


