Return-Path: <linux-fsdevel+bounces-3894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D787F99D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D8A280CB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C975D1947A;
	Mon, 27 Nov 2023 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5FD10CC;
	Sun, 26 Nov 2023 22:23:44 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SdwWt5q75z4f3jMJ;
	Mon, 27 Nov 2023 14:23:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 937FF1A08F4;
	Mon, 27 Nov 2023 14:23:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhDeNWRlxeA8CA--.60190S10;
	Mon, 27 Nov 2023 14:23:40 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	ming.lei@redhat.com,
	axboe@kernel.dk,
	roger.pau@citrix.com,
	colyli@suse.de,
	kent.overstreet@gmail.com,
	joern@lazybastard.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	sth@linux.ibm.com,
	hoeppner@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	nico@fluxnic.net,
	xiang@kernel.org,
	chao@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	agruenba@redhat.com,
	jack@suse.com,
	konishi.ryusuke@gmail.com,
	dchinner@redhat.com,
	linux@weissschuh.net,
	min15.li@samsung.com,
	yukuai3@huawei.com,
	dlemoal@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	hare@suse.de,
	p.raghav@samsung.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH block/for-next v2 16/16] block: use new helper to get inode from block_device
Date: Mon, 27 Nov 2023 14:22:52 +0800
Message-Id: <20231127062252.2367645-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127062252.2367645-1-yukuai1@huaweicloud.com>
References: <20231127062252.2367645-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhDeNWRlxeA8CA--.60190S10
X-Coremail-Antispam: 1UD129KBjvAXoW3KF4xKFWxJw43WF1Dtw17Awb_yoW8JF1xCo
	W3Jr43Xrs5JrW3G3yxG3s7Aa4jq39rCws5CFn8urn8ua4Fyw1jk347Ga15AFyru3WrKF1x
	ZryxAF1rXFW5CF4fn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOj7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s
	0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfU
	UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Which is more efficiency, and also remove the field 'bd_inode' since it's
not used anymore.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c              | 39 ++++++++++++++++++++++-----------------
 block/blk-zoned.c         |  4 ++--
 block/fops.c              |  4 ++--
 block/genhd.c             |  8 ++++----
 block/ioctl.c             |  8 ++++----
 block/partitions/core.c   |  9 +++++----
 include/linux/blk_types.h |  3 +--
 include/linux/blkdev.h    |  4 ++--
 8 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7509389095b7..8af89cf91ae1 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -43,7 +43,7 @@ EXPORT_SYMBOL(I_BDEV);
 
 static void bdev_write_inode(struct block_device *bdev)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int ret;
 
 	spin_lock(&inode->i_lock);
@@ -62,7 +62,7 @@ static void bdev_write_inode(struct block_device *bdev)
 /* Kill _all_ buffers and pagecache , dirty or not.. */
 static void kill_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 
 	if (mapping_empty(mapping))
 		return;
@@ -74,7 +74,7 @@ static void kill_bdev(struct block_device *bdev)
 /* Invalidate clean unused buffers and pagecache. */
 void invalidate_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 
 	if (mapping->nrpages) {
 		invalidate_bh_lrus();
@@ -102,7 +102,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 			goto invalidate;
 	}
 
-	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
+	truncate_inode_pages_range(bdev_inode(bdev)->i_mapping, lstart, lend);
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
@@ -112,7 +112,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 	 * Someone else has handle exclusively open. Try invalidating instead.
 	 * The 'end' argument is inclusive so the rounding is safe.
 	 */
-	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
+	return invalidate_inode_pages2_range(bdev_inode(bdev)->i_mapping,
 					     lstart >> PAGE_SHIFT,
 					     lend >> PAGE_SHIFT);
 }
@@ -120,18 +120,21 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 static void set_init_blocksize(struct block_device *bdev)
 {
 	unsigned int bsize = bdev_logical_block_size(bdev);
-	loff_t size = i_size_read(bdev->bd_inode);
+	struct inode *inode = bdev_inode(bdev);
+	loff_t size = i_size_read(inode);
 
 	while (bsize < PAGE_SIZE) {
 		if (size & bsize)
 			break;
 		bsize <<= 1;
 	}
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	inode->i_blkbits = blksize_bits(bsize);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
 {
+	struct inode *inode;
+
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
 	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
 		return -EINVAL;
@@ -141,9 +144,10 @@ int set_blocksize(struct block_device *bdev, int size)
 		return -EINVAL;
 
 	/* Don't change the size if it is same as current */
-	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
+	inode = bdev_inode(bdev);
+	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -178,7 +182,7 @@ int sync_blockdev_nowait(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_flush(bdev->bd_inode->i_mapping);
+	return filemap_flush(bdev_inode(bdev)->i_mapping);
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
@@ -190,13 +194,13 @@ int sync_blockdev(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_write_and_wait(bdev->bd_inode->i_mapping);
+	return filemap_write_and_wait(bdev_inode(bdev)->i_mapping);
 }
 EXPORT_SYMBOL(sync_blockdev);
 
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
 {
-	return filemap_write_and_wait_range(bdev->bd_inode->i_mapping,
+	return filemap_write_and_wait_range(bdev_inode(bdev)->i_mapping,
 			lstart, lend);
 }
 EXPORT_SYMBOL(sync_blockdev_range);
@@ -395,7 +399,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
 	bdev->bd_partno = partno;
-	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
 	if (partno)
 		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
@@ -413,17 +416,19 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
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
+	struct inode *inode = bdev_inode(bdev);
+
 	bdev->bd_dev = dev;
-	bdev->bd_inode->i_rdev = dev;
-	bdev->bd_inode->i_ino = dev;
-	insert_inode_hash(bdev->bd_inode);
+	inode->i_rdev = dev;
+	inode->i_ino = dev;
+	insert_inode_hash(inode);
 }
 
 long nr_blockdev_pages(void)
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 619ee41a51cc..6b91f6d45590 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -401,7 +401,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
-		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_lock(bdev_inode(bdev)->i_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
 			goto fail;
@@ -424,7 +424,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	if (cmd == BLKRESETZONE)
-		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_unlock(bdev_inode(bdev)->i_mapping);
 
 	return ret;
 }
diff --git a/block/fops.c b/block/fops.c
index 0abaac705daf..45ee180448ed 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -605,7 +605,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (bdev_nowait(handle->bdev))
 		filp->f_mode |= FMODE_NOWAIT;
 
-	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
+	filp->f_mapping = bdev_inode(handle->bdev)->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
 	filp->private_data = handle;
 	return 0;
@@ -657,7 +657,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(bdev);
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
 	ssize_t ret;
diff --git a/block/genhd.c b/block/genhd.c
index c9d06f72c587..643936a47547 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -653,7 +653,7 @@ void del_gendisk(struct gendisk *disk)
 	 */
 	mutex_lock(&disk->open_mutex);
 	xa_for_each(&disk->part_tbl, idx, part)
-		remove_inode_hash(part->bd_inode);
+		remove_inode_hash(bdev_inode(part));
 	mutex_unlock(&disk->open_mutex);
 
 	/*
@@ -742,7 +742,7 @@ void invalidate_disk(struct gendisk *disk)
 	struct block_device *bdev = disk->part0;
 
 	invalidate_bdev(bdev);
-	bdev->bd_inode->i_mapping->wb_err = 0;
+	bdev_inode(bdev)->i_mapping->wb_err = 0;
 	set_capacity(disk, 0);
 }
 EXPORT_SYMBOL(invalidate_disk);
@@ -1188,7 +1188,7 @@ static void disk_release(struct device *dev)
 	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
 		disk->fops->free_disk(disk);
 
-	iput(disk->part0->bd_inode);	/* frees the disk */
+	iput(bdev_inode(disk->part0));	/* frees the disk */
 }
 
 static int block_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -1378,7 +1378,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	disk->part0->bd_disk = NULL;
-	iput(disk->part0->bd_inode);
+	iput(bdev_inode(disk->part0));
 out_free_bdi:
 	bdi_put(disk->bdi);
 out_free_bioset:
diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..185336f3d4f2 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,7 +89,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, len;
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -143,12 +143,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
-	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_lock(bdev_inode(bdev)->i_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
-	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_unlock(bdev_inode(bdev)->i_mapping);
 	return err;
 }
 
@@ -158,7 +158,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, end, len;
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index f47ffcfdfcec..ac678c340e19 100644
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
@@ -483,7 +483,7 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 	 * Just delete the partition and invalidate it.
 	 */
 
-	remove_inode_hash(part->bd_inode);
+	remove_inode_hash(bdev_inode(part));
 	invalidate_bdev(part);
 	drop_partition(part);
 	ret = 0;
@@ -669,7 +669,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		 * it cannot be looked up any more even when openers
 		 * still hold references.
 		 */
-		remove_inode_hash(part->bd_inode);
+		remove_inode_hash(bdev_inode(part));
 
 		/*
 		 * If @disk->open_partitions isn't elevated but there's
@@ -718,7 +718,8 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
-	struct address_space *mapping = state->disk->part0->bd_inode->i_mapping;
+	struct address_space *mapping =
+			bdev_inode(state->disk->part0)->i_mapping;
 	struct folio *folio;
 
 	if (n >= get_capacity(state->disk)) {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 06de8393dcd1..e9baebe53b2a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -50,8 +50,7 @@ struct block_device {
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	atomic_t		bd_openers;
-	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
-	struct inode *		bd_inode;	/* will die */
+	spinlock_t		bd_size_lock; /* for i_size updates */
 	void *			bd_claiming;
 	void *			bd_holder;
 	const struct blk_holder_ops *bd_holder_ops;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..ef625ebefc7d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -211,7 +211,7 @@ struct gendisk {
 
 static inline bool disk_live(struct gendisk *disk)
 {
-	return !inode_unhashed(disk->part0->bd_inode);
+	return !inode_unhashed(bdev_inode(disk->part0));
 }
 
 /**
@@ -1339,7 +1339,7 @@ static inline unsigned int blksize_bits(unsigned int size)
 
 static inline unsigned int block_size(struct block_device *bdev)
 {
-	return 1 << bdev->bd_inode->i_blkbits;
+	return 1 << bdev_inode(bdev)->i_blkbits;
 }
 
 int kblockd_schedule_work(struct work_struct *work);
-- 
2.39.2


