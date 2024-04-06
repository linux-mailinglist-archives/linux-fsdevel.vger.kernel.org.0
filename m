Return-Path: <linux-fsdevel+bounces-16271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6489A9E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD6A1F218D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B12D051;
	Sat,  6 Apr 2024 09:17:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCF1EB48;
	Sat,  6 Apr 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395069; cv=none; b=feRkUrBH2ybStQ0h7oMsk0U8CIy4OVYZUVw+szmIU5mUvKSwC0yCaj2MumUhCcWta3A04vYEXVYbPVJ/Q56/VnZSLPNKxmsZ8No8lHqlbCOJ3w54y5ZtP+1fzyNA83Oa7eyDn4aEtnUFXagUYv9T3zmxpjzJgAGimT5jPJUIwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395069; c=relaxed/simple;
	bh=WyMUYItZQMIEqD1988qNBPb2DZ7ZwiQAtYkhpZgr4Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBW5t/Kaol3yOrou6Jvdf1O2QM8ZGxeFQZ1cuTo5a4PgHqo/B0viFS80uGESXrPudPGitK4LtBbT6ypJ44Jqb1/ag6X3lWV1Pp8lkD0CGjXMi6KSWH9uRwUWTUv4MPsiq/jH3/aXXJRRLoKzhHovsK6DgyHkxyu78MAnckpoeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVB72nG3z4f3l20;
	Sat,  6 Apr 2024 17:17:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D95411A0B8A;
	Sat,  6 Apr 2024 17:17:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S8;
	Sat, 06 Apr 2024 17:17:43 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 04/26] block: prevent direct access of bd_inode
Date: Sat,  6 Apr 2024 17:09:08 +0800
Message-Id: <20240406090930.2252838-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S8
X-Coremail-Antispam: 1UD129KBjvAXoWfXr15ZF13Cw4rtw4DAFy5urg_yoW8JF1xZo
	W3Jr13Xr4rJrW5W3yxGas7AFyjq39rCws5CFn8Zr1Dua1rtw1jkw17Ga15AFyru3WrKr1I
	vryxJFyrJFW5CFs3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Add helpers to access bd_inode, prepare to remove the field 'bd_inode'
after removing all the access from filesystems and drivers.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c            | 58 +++++++++++++++++++++++++++--------------
 block/blk-zoned.c       |  4 +--
 block/blk.h             |  2 ++
 block/fops.c            |  2 +-
 block/genhd.c           |  9 ++++---
 block/ioctl.c           |  8 +++---
 block/partitions/core.c |  8 +++---
 7 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index d53bf2f46b43..c0b30392563a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -43,6 +43,21 @@ static inline struct bdev_inode *BDEV_I(struct inode *inode)
 	return container_of(inode, struct bdev_inode, vfs_inode);
 }
 
+static inline struct bdev_inode *BDEV_B(struct block_device *bdev)
+{
+	return container_of(bdev, struct bdev_inode, bdev);
+}
+
+struct inode *bdev_inode(struct block_device *bdev)
+{
+	return &BDEV_B(bdev)->vfs_inode;
+}
+
+struct address_space *bdev_mapping(struct block_device *bdev)
+{
+	return BDEV_B(bdev)->vfs_inode.i_mapping;
+}
+
 struct block_device *I_BDEV(struct inode *inode)
 {
 	return &BDEV_I(inode)->bdev;
@@ -57,7 +72,7 @@ EXPORT_SYMBOL(file_bdev);
 
 static void bdev_write_inode(struct block_device *bdev)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int ret;
 
 	spin_lock(&inode->i_lock);
@@ -76,7 +91,7 @@ static void bdev_write_inode(struct block_device *bdev)
 /* Kill _all_ buffers and pagecache , dirty or not.. */
 static void kill_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_mapping(bdev);
 
 	if (mapping_empty(mapping))
 		return;
@@ -88,7 +103,7 @@ static void kill_bdev(struct block_device *bdev)
 /* Invalidate clean unused buffers and pagecache. */
 void invalidate_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_mapping(bdev);
 
 	if (mapping->nrpages) {
 		invalidate_bh_lrus();
@@ -116,7 +131,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 			goto invalidate;
 	}
 
-	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
+	truncate_inode_pages_range(bdev_mapping(bdev), lstart, lend);
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
@@ -126,7 +141,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 	 * Someone else has handle exclusively open. Try invalidating instead.
 	 * The 'end' argument is inclusive so the rounding is safe.
 	 */
-	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
+	return invalidate_inode_pages2_range(bdev_mapping(bdev),
 					     lstart >> PAGE_SHIFT,
 					     lend >> PAGE_SHIFT);
 }
@@ -134,14 +149,14 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 static void set_init_blocksize(struct block_device *bdev)
 {
 	unsigned int bsize = bdev_logical_block_size(bdev);
-	loff_t size = i_size_read(bdev->bd_inode);
+	loff_t size = i_size_read(bdev_inode(bdev));
 
 	while (bsize < PAGE_SIZE) {
 		if (size & bsize)
 			break;
 		bsize <<= 1;
 	}
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	bdev_inode(bdev)->i_blkbits = blksize_bits(bsize);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -155,9 +170,9 @@ int set_blocksize(struct block_device *bdev, int size)
 		return -EINVAL;
 
 	/* Don't change the size if it is same as current */
-	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
+	if (bdev_inode(bdev)->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		bdev_inode(bdev)->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -196,7 +211,7 @@ int sync_blockdev(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_write_and_wait(bdev->bd_inode->i_mapping);
+	return filemap_write_and_wait(bdev_mapping(bdev));
 }
 EXPORT_SYMBOL(sync_blockdev);
 
@@ -415,19 +430,22 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
 	spin_lock(&bdev->bd_size_lock);
-	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	i_size_write(bdev_inode(bdev), (loff_t)sectors << SECTOR_SHIFT);
 	bdev->bd_nr_sectors = sectors;
 	spin_unlock(&bdev->bd_size_lock);
 }
 
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
+	struct inode *inode;
+
 	if (bdev_stable_writes(bdev))
-		mapping_set_stable_writes(bdev->bd_inode->i_mapping);
+		mapping_set_stable_writes(bdev_mapping(bdev));
 	bdev->bd_dev = dev;
-	bdev->bd_inode->i_rdev = dev;
-	bdev->bd_inode->i_ino = dev;
-	insert_inode_hash(bdev->bd_inode);
+	inode = bdev_inode(bdev);
+	inode->i_rdev = dev;
+	inode->i_ino = dev;
+	insert_inode_hash(inode);
 }
 
 long nr_blockdev_pages(void)
@@ -893,7 +911,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		bdev_file->f_mode |= FMODE_NOWAIT;
 	if (mode & BLK_OPEN_RESTRICT_WRITES)
 		bdev_file->f_mode |= FMODE_WRITE_RESTRICTED;
-	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
+	bdev_file->f_mapping = bdev_mapping(bdev);
 	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
 	bdev_file->private_data = holder;
 
@@ -955,13 +973,13 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		return ERR_PTR(-ENXIO);
 
 	flags = blk_to_file_flags(mode);
-	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
+	bdev_file = alloc_file_pseudo_noaccount(bdev_inode(bdev),
 			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
 	if (IS_ERR(bdev_file)) {
 		blkdev_put_no_open(bdev);
 		return bdev_file;
 	}
-	ihold(bdev->bd_inode);
+	ihold(bdev_inode(bdev));
 
 	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
 	if (ret) {
@@ -1238,13 +1256,13 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 
 bool disk_live(struct gendisk *disk)
 {
-	return !inode_unhashed(disk->part0->bd_inode);
+	return !inode_unhashed(bdev_inode(disk->part0));
 }
 EXPORT_SYMBOL_GPL(disk_live);
 
 unsigned int block_size(struct block_device *bdev)
 {
-	return 1 << bdev->bd_inode->i_blkbits;
+	return 1 << bdev_inode(bdev)->i_blkbits;
 }
 EXPORT_SYMBOL_GPL(block_size);
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index da0f4b2a8fa0..7e6805250317 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -398,7 +398,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
-		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_lock(bdev_mapping(bdev));
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
 			goto fail;
@@ -420,7 +420,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	if (cmd == BLKRESETZONE)
-		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_unlock(bdev_mapping(bdev));
 
 	return ret;
 }
diff --git a/block/blk.h b/block/blk.h
index 5cac4e29ae17..a34bb590cce6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -427,6 +427,8 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+struct inode *bdev_inode(struct block_device *bdev);
+struct address_space *bdev_mapping(struct block_device *bdev);
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
 void bdev_add(struct block_device *bdev, dev_t dev);
 
diff --git a/block/fops.c b/block/fops.c
index af6c244314af..58b427051c0d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -669,7 +669,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(bdev);
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
 	ssize_t ret;
diff --git a/block/genhd.c b/block/genhd.c
index bb29a68e1d67..9a7d1b7e9e95 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -656,7 +656,7 @@ void del_gendisk(struct gendisk *disk)
 	 */
 	mutex_lock(&disk->open_mutex);
 	xa_for_each(&disk->part_tbl, idx, part)
-		remove_inode_hash(part->bd_inode);
+		remove_inode_hash(bdev_inode(part));
 	mutex_unlock(&disk->open_mutex);
 
 	/*
@@ -745,7 +745,7 @@ void invalidate_disk(struct gendisk *disk)
 	struct block_device *bdev = disk->part0;
 
 	invalidate_bdev(bdev);
-	bdev->bd_inode->i_mapping->wb_err = 0;
+	bdev_mapping(bdev)->wb_err = 0;
 	set_capacity(disk, 0);
 }
 EXPORT_SYMBOL(invalidate_disk);
@@ -1191,7 +1191,8 @@ static void disk_release(struct device *dev)
 	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
 		disk->fops->free_disk(disk);
 
-	iput(disk->part0->bd_inode);	/* frees the disk */
+	/* frees the disk */
+	iput(bdev_inode(disk->part0));
 }
 
 static int block_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -1381,7 +1382,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	disk->part0->bd_disk = NULL;
-	iput(disk->part0->bd_inode);
+	iput(bdev_inode(disk->part0));
 out_free_bdi:
 	bdi_put(disk->bdi);
 out_free_bioset:
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaa..0f78806abb62 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -97,7 +97,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, len;
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -151,12 +151,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
-	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_lock(bdev_mapping(bdev));
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
-	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_unlock(bdev_mapping(bdev));
 	return err;
 }
 
@@ -166,7 +166,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, end, len;
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b11e88c82c8c..ddd418758fa4 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -243,7 +243,7 @@ static const struct attribute_group *part_attr_groups[] = {
 static void part_release(struct device *dev)
 {
 	put_disk(dev_to_bdev(dev)->bd_disk);
-	iput(dev_to_bdev(dev)->bd_inode);
+	iput(bdev_inode(dev_to_bdev(dev)));
 }
 
 static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -469,7 +469,7 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 	 * Just delete the partition and invalidate it.
 	 */
 
-	remove_inode_hash(part->bd_inode);
+	remove_inode_hash(bdev_inode(part));
 	invalidate_bdev(part);
 	drop_partition(part);
 	ret = 0;
@@ -655,7 +655,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		 * it cannot be looked up any more even when openers
 		 * still hold references.
 		 */
-		remove_inode_hash(part->bd_inode);
+		remove_inode_hash(bdev_inode(part));
 
 		/*
 		 * If @disk->open_partitions isn't elevated but there's
@@ -704,7 +704,7 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
-	struct address_space *mapping = state->disk->part0->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_mapping(state->disk->part0);
 	struct folio *folio;
 
 	if (n >= get_capacity(state->disk)) {
-- 
2.39.2


