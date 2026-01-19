Return-Path: <linux-fsdevel+bounces-74367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F035D39E5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8936730133F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BA2550D5;
	Mon, 19 Jan 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p5VkIJc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AA26E71F;
	Mon, 19 Jan 2026 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803810; cv=none; b=pYtS2KR+eQmu6dbw8iOsJHlWbPZlZbn+5kmRyggesnd68XWXE56GirPrTWoLDsmO3AEm+54zLwaFmnKjMxXOiH10yvhrlVq4Bwnm0ez5wsaje7bBvKpiCmi7MBVHtW7uGGQDMlgzI0AGZ7MJsxzUhVvP+gclztxYNpAzTTMFMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803810; c=relaxed/simple;
	bh=z+uUHIdg4MtfqkIOnDMaQEKWFTaNHW2r4hL886qlDRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2BghSvECDnJXIvnpJgMGRpZsA8HiiYCtdT7Bv4xHpA9pdBIywNOkQoIrAj8K/qKI3+plduatsa3R527TT0k18Uhkbt/X4DCJtotVjIsUI3j8xEEYNzlMCj0dlPypNcP0SQmfxvN9nKBRlR+VHZAbzJvSiJ52XGpeGgM1lOEVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p5VkIJc1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IlyUwc1mP9pL1SgxcpD6ik9XMxsk9b3WWjDEnoXnp6I=; b=p5VkIJc13jggEAYsVa5jj2wAk2
	+n43xiI1J0oFZfHw3KMz5R1mZX52YA3ootKBI04jRX//zy8JrqFsryzyto6ywspxsUUfh+iHAecRe
	EKoy+t7v/88RqDKlEJUmcT2jhnlxjSoIRxl/QSCam8a+RvUlYtsWUY1IFg86op2puHDHRGq5398w4
	mfohWbLNHh/zkLomiNCd03/pyWXYsnUdG36LeETmaf/QxYlgaJXOlfIomsiNNczCTlvfuSz5Opsxz
	oSHtGpzgdr4p8/p8Bgb62GKskZyZEvH9gqTbfPQzG62WODLrohYsTc4vvNKKSTiWqPQOTE40kSdI5
	LqWMGsDA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhifb-00000001Ool-44WS;
	Mon, 19 Jan 2026 06:23:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 5/6] fsverity: pass struct file to ->write_merkle_tree_block
Date: Mon, 19 Jan 2026 07:22:46 +0100
Message-ID: <20260119062250.3998674-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119062250.3998674-1-hch@lst.de>
References: <20260119062250.3998674-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This will make an iomap implementation of the method easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/verity.c        | 5 +++--
 fs/ext4/verity.c         | 6 +++---
 fs/f2fs/verity.c         | 6 +++---
 fs/verity/enable.c       | 9 +++++----
 include/linux/fsverity.h | 4 ++--
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index e79e67280a4b..8a4426f8b5fb 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -774,16 +774,17 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 /*
  * fsverity op that writes a Merkle tree block into the btree.
  *
- * @inode:	inode to write a Merkle tree block for
+ * @file:	file to write a Merkle tree block for
  * @buf:	Merkle tree block to write
  * @pos:	the position of the block in the Merkle tree (in bytes)
  * @size:	the Merkle tree block size (in bytes)
  *
  * Returns 0 on success or negative error code on failure
  */
-static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
+static int btrfs_write_merkle_tree_block(struct file *file, const void *buf,
 					 u64 pos, unsigned int size)
 {
+	struct inode *inode = file_inode(file);
 	loff_t merkle_pos = merkle_file_pos(inode);
 
 	if (merkle_pos < 0)
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 7a980a8059bd..2cd6fe2fbf64 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -380,12 +380,12 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 	return folio_file_page(folio, index);
 }
 
-static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
+static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
 					u64 pos, unsigned int size)
 {
-	pos += ext4_verity_metadata_pos(inode);
+	pos += ext4_verity_metadata_pos(file_inode(file));
 
-	return pagecache_write(inode, buf, size, pos);
+	return pagecache_write(file_inode(file), buf, size, pos);
 }
 
 const struct fsverity_operations ext4_verityops = {
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index c30b70fbcc0d..4326fd72cc72 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -278,12 +278,12 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 	return folio_file_page(folio, index);
 }
 
-static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
+static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
 					u64 pos, unsigned int size)
 {
-	pos += f2fs_verity_metadata_pos(inode);
+	pos += f2fs_verity_metadata_pos(file_inode(file));
 
-	return pagecache_write(inode, buf, size, pos);
+	return pagecache_write(file_inode(file), buf, size, pos);
 }
 
 const struct fsverity_operations f2fs_verityops = {
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 91cada0d455c..2a285b04e8d4 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -41,14 +41,15 @@ static int hash_one_block(const struct merkle_tree_params *params,
 	return 0;
 }
 
-static int write_merkle_tree_block(struct inode *inode, const u8 *buf,
+static int write_merkle_tree_block(struct file *file, const u8 *buf,
 				   unsigned long index,
 				   const struct merkle_tree_params *params)
 {
+	struct inode *inode = file_inode(file);
 	u64 pos = (u64)index << params->log_blocksize;
 	int err;
 
-	err = inode->i_sb->s_vop->write_merkle_tree_block(inode, buf, pos,
+	err = inode->i_sb->s_vop->write_merkle_tree_block(file, buf, pos,
 							  params->block_size);
 	if (err)
 		fsverity_err(inode, "Error %d writing Merkle tree block %lu",
@@ -135,7 +136,7 @@ static int build_merkle_tree(struct file *filp,
 			err = hash_one_block(params, &buffers[level]);
 			if (err)
 				goto out;
-			err = write_merkle_tree_block(inode,
+			err = write_merkle_tree_block(filp,
 						      buffers[level].data,
 						      level_offset[level],
 						      params);
@@ -155,7 +156,7 @@ static int build_merkle_tree(struct file *filp,
 			err = hash_one_block(params, &buffers[level]);
 			if (err)
 				goto out;
-			err = write_merkle_tree_block(inode,
+			err = write_merkle_tree_block(filp,
 						      buffers[level].data,
 						      level_offset[level],
 						      params);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 27abf5b867bb..deb6b2303d64 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -109,7 +109,7 @@ struct fsverity_operations {
 	/**
 	 * Write a Merkle tree block to the given inode.
 	 *
-	 * @inode: the inode for which the Merkle tree is being built
+	 * @file: the file for which the Merkle tree is being built
 	 * @buf: the Merkle tree block to write
 	 * @pos: the position of the block in the Merkle tree (in bytes)
 	 * @size: the Merkle tree block size (in bytes)
@@ -119,7 +119,7 @@ struct fsverity_operations {
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
-	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
+	int (*write_merkle_tree_block)(struct file *file, const void *buf,
 				       u64 pos, unsigned int size);
 };
 
-- 
2.47.3


