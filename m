Return-Path: <linux-fsdevel+bounces-19011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611038BF673
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C041F23B51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30925632;
	Wed,  8 May 2024 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tXRO1kMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212C22338
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150585; cv=none; b=czNK6uwAHZ65ClzpHRcOLlW1kokG+2H6ikLreJ7aZspMS1rmI6dhizCn0rk3iXAcu+PBWyGvC+PRRMkvmUOZ46TXZihTYECTBiqBOFVqwNjvvimXQW5+6LwZNzdB3PhMVGF9RewcLp5HGFd9p+uA3cvXSqWi+FVCOnzwRwrPZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150585; c=relaxed/simple;
	bh=vsn5RA6dJh10d0LFvF5Wh6an43jQZ2DgTxMqluUInIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCLAzwFB1XBPT/Ipj2A+3EIUDZZzH0Kdas2/9/Y5VsuniTcLdEzDItZPxyED5/eWJ68MZWwKzqc3e2oZ1GVXM97tnOUCLq2raxB7YC16TdXMcT0dzbok9FJ3gAHZdkpLpHx89niD85m49cnNMXK77oia5W8eOsP3c14vjx/5/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tXRO1kMj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=S2yDGez8CmwR7HOIt6alJvJjwhN30c1saUmRuDwXzwY=; b=tXRO1kMj2bxGNptsSl0I3SyEgu
	wWjM2SI7YdJDnOikV6h4I8ACDIvI1P/aZggP/VGYz42+an6zWeY4BfXaPmADcH94lCPzfoVKhB5Ie
	vLeAslJfarrizOxULCw5fIY1GGJ+4ezDV3mTsDSjCdI23c/J7wkxnXniLkLZoheWGrn20XU/4qotC
	IODzxSTNLdwBBMeTdLEMg8PQO32UEkQhG+RjZ7F/wcFXfmt6YC223S7Qu1boJAeuI4W6PFKYl2JTE
	yOiYaWswBOy3dBZFLbBlDSprXTSkd/qZtvgqNtun0dbsqfBU1KOEWF6Kq5vm3tyHATIEcQWnY07ln
	CT+T1HJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b14-00FvpW-1q;
	Wed, 08 May 2024 06:43:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 1 7/7] missing helpers: bdev_unhash(), bdev_drop()
Date: Wed,  8 May 2024 07:43:01 +0100
Message-Id: <20240508064301.3797191-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

bdev_unhash(): make block device invisible to lookups by device number
bdev_drop(): drop reference to associated inode.

Both are internal, for use by genhd and partition-related code - similar
to bdev_add().  The logics in there (especially the lifetime-related
parts of it) ought to be cleaned up, but that's a separate story; here
we just encapsulate getting to associated inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c            | 10 ++++++++++
 block/blk.h             |  2 ++
 block/genhd.c           |  6 +++---
 block/partitions/core.c |  6 +++---
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 536233ac3e99..28e6f0423857 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -451,6 +451,16 @@ void bdev_add(struct block_device *bdev, dev_t dev)
 	insert_inode_hash(bdev->bd_inode);
 }
 
+void bdev_unhash(struct block_device *bdev)
+{
+	remove_inode_hash(bdev->bd_inode);
+}
+
+void bdev_drop(struct block_device *bdev)
+{
+	iput(bdev->bd_inode);
+}
+
 long nr_blockdev_pages(void)
 {
 	struct inode *inode;
diff --git a/block/blk.h b/block/blk.h
index d9f584984bc4..e3347e1030d5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -428,6 +428,8 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
 void bdev_add(struct block_device *bdev, dev_t dev);
+void bdev_unhash(struct block_device *bdev);
+void bdev_drop(struct block_device *bdev);
 
 int blk_alloc_ext_minor(void);
 void blk_free_ext_minor(unsigned int minor);
diff --git a/block/genhd.c b/block/genhd.c
index bb29a68e1d67..93f5118b7d41 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -656,7 +656,7 @@ void del_gendisk(struct gendisk *disk)
 	 */
 	mutex_lock(&disk->open_mutex);
 	xa_for_each(&disk->part_tbl, idx, part)
-		remove_inode_hash(part->bd_inode);
+		bdev_unhash(part);
 	mutex_unlock(&disk->open_mutex);
 
 	/*
@@ -1191,7 +1191,7 @@ static void disk_release(struct device *dev)
 	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
 		disk->fops->free_disk(disk);
 
-	iput(disk->part0->bd_inode);	/* frees the disk */
+	bdev_drop(disk->part0);	/* frees the disk */
 }
 
 static int block_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -1381,7 +1381,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	disk->part0->bd_disk = NULL;
-	iput(disk->part0->bd_inode);
+	bdev_drop(disk->part0);
 out_free_bdi:
 	bdi_put(disk->bdi);
 out_free_bioset:
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b11e88c82c8c..2b75e325c63b 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -243,7 +243,7 @@ static const struct attribute_group *part_attr_groups[] = {
 static void part_release(struct device *dev)
 {
 	put_disk(dev_to_bdev(dev)->bd_disk);
-	iput(dev_to_bdev(dev)->bd_inode);
+	bdev_drop(dev_to_bdev(dev));
 }
 
 static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -469,7 +469,7 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 	 * Just delete the partition and invalidate it.
 	 */
 
-	remove_inode_hash(part->bd_inode);
+	bdev_unhash(part);
 	invalidate_bdev(part);
 	drop_partition(part);
 	ret = 0;
@@ -655,7 +655,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		 * it cannot be looked up any more even when openers
 		 * still hold references.
 		 */
-		remove_inode_hash(part->bd_inode);
+		bdev_unhash(part);
 
 		/*
 		 * If @disk->open_partitions isn't elevated but there's
-- 
2.39.2


