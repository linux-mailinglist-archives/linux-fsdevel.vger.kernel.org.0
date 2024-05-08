Return-Path: <linux-fsdevel+bounces-19020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A360E8BF67E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A571F23C9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E53729421;
	Wed,  8 May 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hMJdkAxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9FC20DDB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150696; cv=none; b=L7xXNBsyhDFvVvCwpJ0JJGu4ASws/YhfYubwgjWS//mtVUmVsRYDJaynaJpJGL/BDqqsZ8NZdiA8GmowP9ZDbGsJPCw1pzeJw4kC350a2l6PbK1LpJc/BB+LVRJ6IyPf8UY4bfCAMhpDxV9u+ljSjplXLHTnUJiWC9T2jhP9MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150696; c=relaxed/simple;
	bh=vCNf73QWbVARrAHz8H/zJ//vU+udyllOMiCvzoktYUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDkdrP7KWZWi9025jYD73ywjE4VvcvROo488EWPl+UM0Z2CFtrD3eoF4U2tof57UHlHJV1GC/fCxP1YUCOAZE8qv/SFqYbk7d6SexM4vOLJ9rTBGekfkpkTGLFj9bTZ/G4H2AbXNTx4TNWNnJP4MkXPOoDu/x48UCt1Bz+90OpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hMJdkAxt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PDJKMN+d1JTIbEo4sAiAeNMI+fNYvnr+oQKOIK580Tc=; b=hMJdkAxt+Jcuknm84jscboIZti
	HGTlrxwXw3BKedLc0iCbBjVTCxG06wGRT/ZFbIuX7hvMw9Vtuw8x2VjUUk/yRdJfwupWmz626q6Wm
	LaR9+8FdwnyVgsYnKw68IR/S5TO5esDL4ooHxW3+4G7F6s/LenngAJNQIiNMoFFlKWOH8BUtmmGyY
	X5o6FxaxPVWU0qmCvFWCQy0fjiHuULXEwQrrrM+XhhVjwiOtCykSP8pyjgz+NWoid+Zyb+IVAgZ3u
	6KqIh/8VElnNYZlSfCxT2OIC/MtD+T0ObTErEkvZ6ZnlmwVzfXKwkdts+Zv4XkLYOIu2fi85MYc1g
	nBD3dj2g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2r-00Fvzq-25;
	Wed, 08 May 2024 06:44:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 07/10] block/bdev.c: use the knowledge of inode/bdev coallocation
Date: Wed,  8 May 2024 07:44:49 +0100
Message-Id: <20240508064452.3797817-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Here we know that bdevfs inodes are coallocated with struct block_device
and we can get to ->bd_inode value without any dereferencing.  Introduce
an inlined helper (static, *not* exported, purely internal for bdev.c)
that gets an associated inode by block_device - BD_INODE(bdev).

NOTE: leave it static; nobody outside of block/bdev.c has any business
playing with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 00017af92a51..a8c66cc1d6b8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -43,6 +43,11 @@ static inline struct bdev_inode *BDEV_I(struct inode *inode)
 	return container_of(inode, struct bdev_inode, vfs_inode);
 }
 
+static inline struct inode *BD_INODE(struct block_device *bdev)
+{
+	return &container_of(bdev, struct bdev_inode, bdev)->vfs_inode;
+}
+
 struct block_device *I_BDEV(struct inode *inode)
 {
 	return &BDEV_I(inode)->bdev;
@@ -57,7 +62,7 @@ EXPORT_SYMBOL(file_bdev);
 
 static void bdev_write_inode(struct block_device *bdev)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = BD_INODE(bdev);
 	int ret;
 
 	spin_lock(&inode->i_lock);
@@ -134,14 +139,14 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 static void set_init_blocksize(struct block_device *bdev)
 {
 	unsigned int bsize = bdev_logical_block_size(bdev);
-	loff_t size = i_size_read(bdev->bd_inode);
+	loff_t size = i_size_read(BD_INODE(bdev));
 
 	while (bsize < PAGE_SIZE) {
 		if (size & bsize)
 			break;
 		bsize <<= 1;
 	}
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	BD_INODE(bdev)->i_blkbits = blksize_bits(bsize);
 }
 
 int set_blocksize(struct file *file, int size)
@@ -437,29 +442,30 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
 	spin_lock(&bdev->bd_size_lock);
-	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	i_size_write(BD_INODE(bdev), (loff_t)sectors << SECTOR_SHIFT);
 	bdev->bd_nr_sectors = sectors;
 	spin_unlock(&bdev->bd_size_lock);
 }
 
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
+	struct inode *inode = BD_INODE(bdev);
 	if (bdev_stable_writes(bdev))
 		mapping_set_stable_writes(bdev->bd_mapping);
 	bdev->bd_dev = dev;
-	bdev->bd_inode->i_rdev = dev;
-	bdev->bd_inode->i_ino = dev;
-	insert_inode_hash(bdev->bd_inode);
+	inode->i_rdev = dev;
+	inode->i_ino = dev;
+	insert_inode_hash(inode);
 }
 
 void bdev_unhash(struct block_device *bdev)
 {
-	remove_inode_hash(bdev->bd_inode);
+	remove_inode_hash(BD_INODE(bdev));
 }
 
 void bdev_drop(struct block_device *bdev)
 {
-	iput(bdev->bd_inode);
+	iput(BD_INODE(bdev));
 }
 
 long nr_blockdev_pages(void)
@@ -987,13 +993,13 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		return ERR_PTR(-ENXIO);
 
 	flags = blk_to_file_flags(mode);
-	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
+	bdev_file = alloc_file_pseudo_noaccount(BD_INODE(bdev),
 			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
 	if (IS_ERR(bdev_file)) {
 		blkdev_put_no_open(bdev);
 		return bdev_file;
 	}
-	ihold(bdev->bd_inode);
+	ihold(BD_INODE(bdev));
 
 	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
 	if (ret) {
@@ -1270,13 +1276,13 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 
 bool disk_live(struct gendisk *disk)
 {
-	return !inode_unhashed(disk->part0->bd_inode);
+	return !inode_unhashed(BD_INODE(disk->part0));
 }
 EXPORT_SYMBOL_GPL(disk_live);
 
 unsigned int block_size(struct block_device *bdev)
 {
-	return 1 << bdev->bd_inode->i_blkbits;
+	return 1 << BD_INODE(bdev)->i_blkbits;
 }
 EXPORT_SYMBOL_GPL(block_size);
 
-- 
2.39.2


