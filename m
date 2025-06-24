Return-Path: <linux-fsdevel+bounces-52771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A53AE663C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0314192054C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3529A31D;
	Tue, 24 Jun 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tr+kfLYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F22E630
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771295; cv=none; b=uZV/DKhobs5nepQ5Ndbs5MxqHwuknSkh3OVqrSN+ULM0DKh9iXJxjTXlysF17pm/YyK7GHyxWv9qjWm+8TkFDjKHEA8C8asRM/Zd7HBPEqN75a+erQzMvVlJBIYOBj96Vw6PeakuW4yiRFcCwbJK27k4PWAwu7wtPZQ5WcvGbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771295; c=relaxed/simple;
	bh=womBofzyzv4XtwzXr/ExJJbM50ZkdLaGbszfe5gtBbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RqaaH/u2dwd71z4Mfn2lhafjZypeDsoPeIUN8nbOnSSR7CS6vrNTwnDikUOcIgw/QTTa+5zXwLZY9vI/G9z1wtP7EIoWCeeG1uQW/QHWURx2dbMlRTZvWLzV0tnRYRY6/KC4zEhkhLfFILbPFx9FVtxH9qizO3k9JCoasZ9LXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tr+kfLYm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=1WIGuwyixrCQiQHMhX22Gbslvq/boOsSF5zsHu2WLV4=; b=tr+kfLYm9JbAscqVQwla8iKjCX
	g7B1DO3/cEIRtxd5VCdM1RbS4C+MrDPaaJFtQSB78nEPiGd5/m2YBAWixqdcDgrYMkTKocK6rCz6U
	tZHJI/446GXjBRVdJf8WSjucbLtBuvtpHKw4dYcSh4pRQaclQZ0OpeqAxoi9avnnfvtRSoaZPfcs7
	uwQxPgdWBg6dgQZBrP3wo6mpg79IPyyiHMYovkEIKVNU8WfT5bPtaS9/cYhOTdrjQGbCWErMS1YMQ
	T8fgo3YaXWA+UEpCifK957yj97UtB8B6hJO9ERohD2QSVoc/5a6fOJWWxDPcieHLnupOuBmuPyRuy
	DBapDGwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU3ad-00000006fie-2tQa;
	Tue, 24 Jun 2025 13:21:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?=E9=99=88=E6=B6=9B=E6=B6=9B=20Taotao=20Chen?= <chentaotao@didiglobal.com>
Subject: [PATCH] fs: Remove three arguments from block_write_end()
Date: Tue, 24 Jun 2025 14:21:27 +0100
Message-ID: <20250624132130.1590285-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

block_write_end() looks like it can be used as a ->write_end()
implementation.  However, it can't as it does not unlock nor put
the folio.  Since it does not use the 'file', 'mapping' nor 'fsdata'
arguments, remove them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/fops.c                | 2 +-
 fs/buffer.c                 | 7 +++----
 fs/ext2/dir.c               | 2 +-
 fs/ext4/inode.c             | 5 ++---
 fs/iomap/buffered-io.c      | 3 +--
 fs/minix/dir.c              | 2 +-
 fs/nilfs2/dir.c             | 2 +-
 fs/nilfs2/recovery.c        | 3 +--
 fs/ufs/dir.c                | 2 +-
 include/linux/buffer_head.h | 4 +---
 10 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 1309861d4c2c..35cea0cb304d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -507,7 +507,7 @@ static int blkdev_write_end(struct file *file, struct address_space *mapping,
 		void *fsdata)
 {
 	int ret;
-	ret = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
+	ret = block_write_end(pos, len, copied, folio);
 
 	folio_unlock(folio);
 	folio_put(folio);
diff --git a/fs/buffer.c b/fs/buffer.c
index 8cf4a1dc481e..aa23cc093a5a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2271,9 +2271,8 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(block_write_begin);
 
-int block_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct folio *folio, void *fsdata)
+int block_write_end(loff_t pos, unsigned len, unsigned copied,
+		struct folio *folio)
 {
 	size_t start = pos - folio_pos(folio);
 
@@ -2312,7 +2311,7 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 	loff_t old_size = inode->i_size;
 	bool i_size_changed = false;
 
-	copied = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
+	copied = block_write_end(pos, len, copied, folio);
 
 	/*
 	 * No need to use i_size_read() here, the i_size cannot change under us
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 402fecf90a44..b07b3b369710 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -87,7 +87,7 @@ static void ext2_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 	struct inode *dir = mapping->host;
 
 	inode_inc_iversion(dir);
-	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
+	block_write_end(pos, len, len, folio);
 
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd..e6aa7ca6d842 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1424,7 +1424,7 @@ static int ext4_write_end(struct file *file,
 		return ext4_write_inline_data_end(inode, pos, len, copied,
 						  folio);
 
-	copied = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
+	copied = block_write_end(pos, len, copied, folio);
 	/*
 	 * it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
@@ -3144,8 +3144,7 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	 * block_write_end() will mark the inode as dirty with I_DIRTY_PAGES
 	 * flag, which all that's needed to trigger page writeback.
 	 */
-	copied = block_write_end(NULL, mapping, pos, len, copied,
-			folio, NULL);
+	copied = block_write_end(pos, len, copied, folio);
 	new_i_size = pos + copied;
 
 	/*
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..775e8f1f0286 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -923,8 +923,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		size_t bh_written;
 
-		bh_written = block_write_end(NULL, iter->inode->i_mapping, pos,
-					len, copied, folio, NULL);
+		bh_written = block_write_end(pos, len, copied, folio);
 		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
 		return bh_written == copied;
 	}
diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index dd2a425b41f0..19052fc47e9e 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -45,7 +45,7 @@ static void dir_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 	struct address_space *mapping = folio->mapping;
 	struct inode *dir = mapping->host;
 
-	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
+	block_write_end(pos, len, len, folio);
 
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 9b7f8e9655a2..6ca3d74be1e1 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -96,7 +96,7 @@ static void nilfs_commit_chunk(struct folio *folio,
 	int err;
 
 	nr_dirty = nilfs_page_count_clean_buffers(folio, from, to);
-	copied = block_write_end(NULL, mapping, pos, len, len, folio, NULL);
+	copied = block_write_end(pos, len, len, folio);
 	if (pos + copied > dir->i_size)
 		i_size_write(dir, pos + copied);
 	if (IS_DIRSYNC(dir))
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 22aecf6e2344..a9c61d0492cb 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -560,8 +560,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 		if (unlikely(err))
 			goto failed_folio;
 
-		block_write_end(NULL, inode->i_mapping, pos, blocksize,
-				blocksize, folio, NULL);
+		block_write_end(pos, blocksize, blocksize, folio);
 
 		folio_unlock(folio);
 		folio_put(folio);
diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 88d0062cfdb9..0388a1bae326 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -48,7 +48,7 @@ static void ufs_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 	struct inode *dir = mapping->host;
 
 	inode_inc_iversion(dir);
-	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
+	block_write_end(pos, len, len, folio);
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
 		mark_inode_dirty(dir);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 0029ff880e27..178eb90e9cf3 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -262,9 +262,7 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block);
 int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block);
-int block_write_end(struct file *, struct address_space *,
-				loff_t, unsigned len, unsigned copied,
-				struct folio *, void *);
+int block_write_end(loff_t pos, unsigned len, unsigned copied, struct folio *);
 int generic_write_end(struct file *, struct address_space *,
 				loff_t, unsigned len, unsigned copied,
 				struct folio *, void *);
-- 
2.47.2


