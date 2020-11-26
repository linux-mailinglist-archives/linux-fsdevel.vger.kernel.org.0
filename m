Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A442C54C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbgKZNHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389827AbgKZNHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A47C0613D4;
        Thu, 26 Nov 2020 05:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VzFX3+ZCs78JNYE/XScalDQfSpiep1bmuD58jpIQ/Yk=; b=B0kpn+AnYI/LomifSFe7oHmKPt
        w2i1Bg9CQ23fESTZYYV68Wbfv/PT/EhV+GdskiD5MS0X64SOi9n/k3f4RolH5oWmTokdW83YLNnYf
        hSeDImeYnPxUVca5RrXHObeiensbd9h4zzb+BxIY2jnl+iWMweiYtnQEBpXA9CBeVaOouzL8hAL1E
        kI7aZ2CRQSFPf9PHf1+c4m7u5rYUMo4TxXvOYNOkcl2yTYVBO+vj2G/hA5FPRJWq6T/dKOOC56SEv
        A8wI6DJOCh6p+2z8iQvaFi8LxEIJ99X+sxH1e3cRGW1gdT/NHOpLHJnyiO2bo/ZGZZBLJkokYly8t
        wbyptvqA==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGzK-00042u-RG; Thu, 26 Nov 2020 13:07:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 24/44] block: simplify bdev/disk lookup in blkdev_get
Date:   Thu, 26 Nov 2020 14:04:02 +0100
Message-Id: <20201126130422.92945-25-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To simplify block device lookup and a few other upcoming areas, make sure
that we always have a struct block_device available for each disk and
each partition, and only find existing block devices in bdget.  The only
downside of this is that each device and partition uses a little more
memory.  The upside will be that a lot of code can be simplified.

With that all we need to look up the block device is to lookup the inode
and do a few sanity checks on the gendisk, instead of the separate lookup
for the gendisk.  For blk-cgroup which wants to access a gendisk without
opening it, a new blkdev_{get,put}_no_open low-level interface is added
to replace the previous get_gendisk use.

Note that the change to look up block device directly instead of the two
step lookup using struct gendisk causes a subtile change in behavior:
accessing a non-existing partition on an existing block device can now
cause a call to request_module.  That call is harmless, and in practice
no recent system will access these nodes as they aren't created by udev
and static /dev/ setups are unusual.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         |  42 ++++----
 block/blk-iocost.c         |  36 +++----
 block/blk.h                |   2 +-
 block/genhd.c              | 210 +++++--------------------------------
 block/partitions/core.c    |  29 ++---
 fs/block_dev.c             | 178 +++++++++++++++++--------------
 include/linux/blk-cgroup.h |   4 +-
 include/linux/blkdev.h     |   6 ++
 include/linux/genhd.h      |   7 +-
 9 files changed, 193 insertions(+), 321 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 54fbe1e80cc41a..19650eb42b9f00 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -556,22 +556,22 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
 }
 
 /**
- * blkg_conf_prep - parse and prepare for per-blkg config update
+ * blkcg_conf_open_bdev - parse and open bdev for per-blkg config update
  * @inputp: input string pointer
  *
  * Parse the device node prefix part, MAJ:MIN, of per-blkg config update
- * from @input and get and return the matching gendisk.  *@inputp is
+ * from @input and get and return the matching bdev.  *@inputp is
  * updated to point past the device node prefix.  Returns an ERR_PTR()
  * value on error.
  *
  * Use this function iff blkg_conf_prep() can't be used for some reason.
  */
-struct gendisk *blkcg_conf_get_disk(char **inputp)
+struct block_device *blkcg_conf_open_bdev(char **inputp)
 {
 	char *input = *inputp;
 	unsigned int major, minor;
-	struct gendisk *disk;
-	int key_len, part;
+	struct block_device *bdev;
+	int key_len;
 
 	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) != 2)
 		return ERR_PTR(-EINVAL);
@@ -581,16 +581,16 @@ struct gendisk *blkcg_conf_get_disk(char **inputp)
 		return ERR_PTR(-EINVAL);
 	input = skip_spaces(input);
 
-	disk = get_gendisk(MKDEV(major, minor), &part);
-	if (!disk)
+	bdev = blkdev_get_no_open(MKDEV(major, minor));
+	if (!bdev)
 		return ERR_PTR(-ENODEV);
-	if (part) {
-		put_disk_and_module(disk);
+	if (bdev_is_partition(bdev)) {
+		blkdev_put_no_open(bdev);
 		return ERR_PTR(-ENODEV);
 	}
 
 	*inputp = input;
-	return disk;
+	return bdev;
 }
 
 /**
@@ -607,18 +607,18 @@ struct gendisk *blkcg_conf_get_disk(char **inputp)
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx)
-	__acquires(rcu) __acquires(&disk->queue->queue_lock)
+	__acquires(rcu) __acquires(&bdev->bd_disk->queue->queue_lock)
 {
-	struct gendisk *disk;
+	struct block_device *bdev;
 	struct request_queue *q;
 	struct blkcg_gq *blkg;
 	int ret;
 
-	disk = blkcg_conf_get_disk(&input);
-	if (IS_ERR(disk))
-		return PTR_ERR(disk);
+	bdev = blkcg_conf_open_bdev(&input);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
 
-	q = disk->queue;
+	q = bdev->bd_disk->queue;
 
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
@@ -689,7 +689,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto success;
 	}
 success:
-	ctx->disk = disk;
+	ctx->bdev = bdev;
 	ctx->blkg = blkg;
 	ctx->body = input;
 	return 0;
@@ -700,7 +700,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
 fail:
-	put_disk_and_module(disk);
+	blkdev_put_no_open(bdev);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
@@ -723,11 +723,11 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  * with blkg_conf_prep().
  */
 void blkg_conf_finish(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->disk->queue->queue_lock) __releases(rcu)
+	__releases(&ctx->bdev->bd_disk->queue->queue_lock) __releases(rcu)
 {
-	spin_unlock_irq(&ctx->disk->queue->queue_lock);
+	spin_unlock_irq(&ctx->bdev->bd_disk->queue->queue_lock);
 	rcu_read_unlock();
-	put_disk_and_module(ctx->disk);
+	blkdev_put_no_open(ctx->bdev);
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index bbe86d1199dc5b..8e20fe4bddecf7 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3120,23 +3120,23 @@ static const match_table_t qos_tokens = {
 static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
-	struct gendisk *disk;
+	struct block_device *bdev;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
 	char *p;
 	int ret;
 
-	disk = blkcg_conf_get_disk(&input);
-	if (IS_ERR(disk))
-		return PTR_ERR(disk);
+	bdev = blkcg_conf_open_bdev(&input);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(disk->queue);
+	ioc = q_to_ioc(bdev->bd_disk->queue);
 	if (!ioc) {
-		ret = blk_iocost_init(disk->queue);
+		ret = blk_iocost_init(bdev->bd_disk->queue);
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(disk->queue);
+		ioc = q_to_ioc(bdev->bd_disk->queue);
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3231,12 +3231,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
-	put_disk_and_module(disk);
+	blkdev_put_no_open(bdev);
 	return nbytes;
 einval:
 	ret = -EINVAL;
 err:
-	put_disk_and_module(disk);
+	blkdev_put_no_open(bdev);
 	return ret;
 }
 
@@ -3287,23 +3287,23 @@ static const match_table_t i_lcoef_tokens = {
 static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
-	struct gendisk *disk;
+	struct block_device *bdev;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
 	char *p;
 	int ret;
 
-	disk = blkcg_conf_get_disk(&input);
-	if (IS_ERR(disk))
-		return PTR_ERR(disk);
+	bdev = blkcg_conf_open_bdev(&input);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(disk->queue);
+	ioc = q_to_ioc(bdev->bd_disk->queue);
 	if (!ioc) {
-		ret = blk_iocost_init(disk->queue);
+		ret = blk_iocost_init(bdev->bd_disk->queue);
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(disk->queue);
+		ioc = q_to_ioc(bdev->bd_disk->queue);
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3356,13 +3356,13 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
-	put_disk_and_module(disk);
+	blkdev_put_no_open(bdev);
 	return nbytes;
 
 einval:
 	ret = -EINVAL;
 err:
-	put_disk_and_module(disk);
+	blkdev_put_no_open(bdev);
 	return ret;
 }
 
diff --git a/block/blk.h b/block/blk.h
index dfab98465db9a5..c4839abcfa27eb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -352,7 +352,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
 
 int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
 void blk_free_devt(dev_t devt);
-void blk_invalidate_devt(dev_t devt);
 char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
@@ -384,6 +383,7 @@ static inline void hd_free_part(struct hd_struct *part)
 {
 	free_percpu(part->dkstats);
 	kfree(part->info);
+	bdput(part->bdev);
 	percpu_ref_exit(&part->ref);
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index f46e89226fdf91..bf8fa82f135f4e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -27,17 +27,11 @@
 
 static struct kobject *block_depr;
 
-static DEFINE_XARRAY(bdev_map);
-static DEFINE_MUTEX(bdev_map_lock);
+DECLARE_RWSEM(bdev_lookup_sem);
 
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
-
-/* For extended devt allocation.  ext_devt_lock prevents look up
- * results from going away underneath its user.
- */
-static DEFINE_SPINLOCK(ext_devt_lock);
-static DEFINE_IDR(ext_devt_idr);
+static DEFINE_IDA(ext_devt_ida);
 
 static void disk_check_events(struct disk_events *ev,
 			      unsigned int *clearing_ptr);
@@ -580,14 +574,7 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
 		return 0;
 	}
 
-	/* allocate ext devt */
-	idr_preload(GFP_KERNEL);
-
-	spin_lock_bh(&ext_devt_lock);
-	idx = idr_alloc(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_NOWAIT);
-	spin_unlock_bh(&ext_devt_lock);
-
-	idr_preload_end();
+	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT, GFP_KERNEL);
 	if (idx < 0)
 		return idx == -ENOSPC ? -EBUSY : idx;
 
@@ -606,26 +593,8 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
  */
 void blk_free_devt(dev_t devt)
 {
-	if (devt == MKDEV(0, 0))
-		return;
-
-	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
-		spin_lock_bh(&ext_devt_lock);
-		idr_remove(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
-		spin_unlock_bh(&ext_devt_lock);
-	}
-}
-
-/*
- * We invalidate devt by assigning NULL pointer for devt in idr.
- */
-void blk_invalidate_devt(dev_t devt)
-{
-	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
-		spin_lock_bh(&ext_devt_lock);
-		idr_replace(&ext_devt_idr, NULL, blk_mangle_minor(MINOR(devt)));
-		spin_unlock_bh(&ext_devt_lock);
-	}
+	if (MAJOR(devt) == BLOCK_EXT_MAJOR)
+		ida_free(&ext_devt_ida, blk_mangle_minor(MINOR(devt)));
 }
 
 static char *bdevt_str(dev_t devt, char *buf)
@@ -640,28 +609,6 @@ static char *bdevt_str(dev_t devt, char *buf)
 	return buf;
 }
 
-static void blk_register_region(struct gendisk *disk)
-{
-	int i;
-
-	mutex_lock(&bdev_map_lock);
-	for (i = 0; i < disk->minors; i++) {
-		if (xa_insert(&bdev_map, disk_devt(disk) + i, disk, GFP_KERNEL))
-			WARN_ON_ONCE(1);
-	}
-	mutex_unlock(&bdev_map_lock);
-}
-
-static void blk_unregister_region(struct gendisk *disk)
-{
-	int i;
-
-	mutex_lock(&bdev_map_lock);
-	for (i = 0; i < disk->minors; i++)
-		xa_erase(&bdev_map, disk_devt(disk) + i);
-	mutex_unlock(&bdev_map_lock);
-}
-
 static void disk_scan_partitions(struct gendisk *disk)
 {
 	struct block_device *bdev;
@@ -805,7 +752,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
 		bdi_set_owner(bdi, dev);
-		blk_register_region(disk);
+		bdev_add(disk->part0.bdev, devt);
 	}
 	register_disk(parent, disk, groups);
 	if (register_queue)
@@ -847,8 +794,8 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 	__invalidate_device(bdev, true);
 
 	/*
-	 * Unhash the bdev inode for this device so that it gets evicted as soon
-	 * as last inode reference is dropped.
+	 * Unhash the bdev inode for this device so that it can't be looked
+	 * up any more even if openers still hold references to it.
 	 */
 	remove_inode_hash(bdev->bd_inode);
 	bdput(bdev);
@@ -890,7 +837,8 @@ void del_gendisk(struct gendisk *disk)
 	 * Block lookups of the disk until all bdevs are unhashed and the
 	 * disk is marked as dead (GENHD_FL_UP cleared).
 	 */
-	down_write(&disk->lookup_sem);
+	down_write(&bdev_lookup_sem);
+
 	/* invalidate stuff */
 	disk_part_iter_init(&piter, disk,
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
@@ -903,7 +851,7 @@ void del_gendisk(struct gendisk *disk)
 	invalidate_partition(disk, 0);
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
-	up_write(&disk->lookup_sem);
+	up_write(&bdev_lookup_sem);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
@@ -916,16 +864,6 @@ void del_gendisk(struct gendisk *disk)
 	}
 
 	blk_unregister_queue(disk);
-	
-	if (!(disk->flags & GENHD_FL_HIDDEN))
-		blk_unregister_region(disk);
-	/*
-	 * Remove gendisk pointer from idr so that it cannot be looked up
-	 * while RCU period before freeing gendisk is running to prevent
-	 * use-after-free issues. Note that the device number stays
-	 * "in-use" until we really free the gendisk.
-	 */
-	blk_invalidate_devt(disk_devt(disk));
 
 	kobject_put(disk->part0.holder_dir);
 	kobject_put(disk->slave_dir);
@@ -964,7 +902,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
-static void request_gendisk_module(dev_t devt)
+void blk_request_module(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
@@ -984,84 +922,6 @@ static void request_gendisk_module(dev_t devt)
 		request_module("block-major-%d", MAJOR(devt));
 }
 
-static bool get_disk_and_module(struct gendisk *disk)
-{
-	struct module *owner;
-
-	if (!disk->fops)
-		return false;
-	owner = disk->fops->owner;
-	if (owner && !try_module_get(owner))
-		return false;
-	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj)) {
-		module_put(owner);
-		return false;
-	}
-	return true;
-
-}
-
-/**
- * get_gendisk - get partitioning information for a given device
- * @devt: device to get partitioning information for
- * @partno: returned partition index
- *
- * This function gets the structure containing partitioning
- * information for the given device @devt.
- *
- * Context: can sleep
- */
-struct gendisk *get_gendisk(dev_t devt, int *partno)
-{
-	struct gendisk *disk = NULL;
-
-	might_sleep();
-
-	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
-		mutex_lock(&bdev_map_lock);
-		disk = xa_load(&bdev_map, devt);
-		if (!disk) {
-			mutex_unlock(&bdev_map_lock);
-			request_gendisk_module(devt);
-			mutex_lock(&bdev_map_lock);
-			disk = xa_load(&bdev_map, devt);
-		}
-		if (disk && !get_disk_and_module(disk))
-			disk = NULL;
-		if (disk)
-			*partno = devt - disk_devt(disk);
-		mutex_unlock(&bdev_map_lock);
-	} else {
-		struct hd_struct *part;
-
-		spin_lock_bh(&ext_devt_lock);
-		part = idr_find(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
-		if (part && get_disk_and_module(part_to_disk(part))) {
-			*partno = part->partno;
-			disk = part_to_disk(part);
-		}
-		spin_unlock_bh(&ext_devt_lock);
-	}
-
-	if (!disk)
-		return NULL;
-
-	/*
-	 * Synchronize with del_gendisk() to not return disk that is being
-	 * destroyed.
-	 */
-	down_read(&disk->lookup_sem);
-	if (unlikely((disk->flags & GENHD_FL_HIDDEN) ||
-		     !(disk->flags & GENHD_FL_UP))) {
-		up_read(&disk->lookup_sem);
-		put_disk_and_module(disk);
-		disk = NULL;
-	} else {
-		up_read(&disk->lookup_sem);
-	}
-	return disk;
-}
-
 /**
  * bdget_disk - do bdget() by gendisk and partition number
  * @disk: gendisk of interest
@@ -1559,11 +1419,6 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
  *
  * This function releases all allocated resources of the gendisk.
  *
- * The struct gendisk refcount is incremented with get_gendisk() or
- * get_disk_and_module(), and its refcount is decremented with
- * put_disk_and_module() or put_disk(). Once the refcount reaches 0 this
- * function is called.
- *
  * Drivers which used __device_add_disk() have a gendisk with a request_queue
  * assigned. Since the request_queue sits on top of the gendisk for these
  * drivers we also call blk_put_queue() for them, and we expect the
@@ -1748,16 +1603,17 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	if (!disk)
 		return NULL;
 
+	disk->part0.bdev = bdev_alloc(disk, 0);
+	if (!disk->part0.bdev)
+		goto out_free_disk;
+
 	disk->part0.dkstats = alloc_percpu(struct disk_stats);
 	if (!disk->part0.dkstats)
-		goto out_free_disk;
+		goto out_bdput;
 
-	init_rwsem(&disk->lookup_sem);
 	disk->node_id = node_id;
-	if (disk_expand_part_tbl(disk, 0)) {
-		free_percpu(disk->part0.dkstats);
-		goto out_free_disk;
-	}
+	if (disk_expand_part_tbl(disk, 0))
+		goto out_free_bdstats;
 
 	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
 	rcu_assign_pointer(ptbl->part[0], &disk->part0);
@@ -1773,7 +1629,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	 */
 	hd_sects_seq_init(&disk->part0);
 	if (hd_ref_init(&disk->part0))
-		goto out_free_part0;
+		goto out_free_bdstats;
 
 	disk->minors = minors;
 	rand_initialize_disk(disk);
@@ -1782,8 +1638,10 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	device_initialize(disk_to_dev(disk));
 	return disk;
 
-out_free_part0:
-	hd_free_part(&disk->part0);
+out_free_bdstats:
+	free_percpu(disk->part0.dkstats);
+out_bdput:
+	bdput(disk->part0.bdev);
 out_free_disk:
 	kfree(disk);
 	return NULL;
@@ -1807,26 +1665,6 @@ void put_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(put_disk);
 
-/**
- * put_disk_and_module - decrements the module and gendisk refcount
- * @disk: the struct gendisk to decrement the refcount for
- *
- * This is a counterpart of get_disk_and_module() and thus also of
- * get_gendisk().
- *
- * Context: Any context, but the last reference must not be dropped from
- *          atomic context.
- */
-void put_disk_and_module(struct gendisk *disk)
-{
-	if (disk) {
-		struct module *owner = disk->fops->owner;
-
-		put_disk(disk);
-		module_put(owner);
-	}
-}
-
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
 	char event[] = "DISK_RO=1";
diff --git a/block/partitions/core.c b/block/partitions/core.c
index a02e224115943d..696bd9ff63c64a 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -340,12 +340,11 @@ void delete_partition(struct hd_struct *part)
 	device_del(part_to_dev(part));
 
 	/*
-	 * Remove gendisk pointer from idr so that it cannot be looked up
-	 * while RCU period before freeing gendisk is running to prevent
-	 * use-after-free issues. Note that the device number stays
-	 * "in-use" until we really free the gendisk.
+	 * Remove the block device from the inode hash, so that it cannot be
+	 * looked up any more even when openers still hold references.
 	 */
-	blk_invalidate_devt(part_devt(part));
+	remove_inode_hash(part->bdev->bd_inode);
+
 	percpu_ref_kill(&part->ref);
 }
 
@@ -368,6 +367,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	dev_t devt = MKDEV(0, 0);
 	struct device *ddev = disk_to_dev(disk);
 	struct device *pdev;
+	struct block_device *bdev;
 	struct disk_part_tbl *ptbl;
 	const char *dname;
 	int err;
@@ -402,11 +402,15 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (!p)
 		return ERR_PTR(-EBUSY);
 
+	err = -ENOMEM;
 	p->dkstats = alloc_percpu(struct disk_stats);
-	if (!p->dkstats) {
-		err = -ENOMEM;
+	if (!p->dkstats)
 		goto out_free;
-	}
+
+	bdev = bdev_alloc(disk, partno);
+	if (!bdev)
+		goto out_free_stats;
+	p->bdev = bdev;
 
 	hd_sects_seq_init(p);
 	pdev = part_to_dev(p);
@@ -420,10 +424,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		struct partition_meta_info *pinfo;
 
 		pinfo = kzalloc_node(sizeof(*pinfo), GFP_KERNEL, disk->node_id);
-		if (!pinfo) {
-			err = -ENOMEM;
-			goto out_free_stats;
-		}
+		if (!pinfo)
+			goto out_bdput;
 		memcpy(pinfo, info, sizeof(*info));
 		p->info = pinfo;
 	}
@@ -470,6 +472,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	}
 
 	/* everything is up and running, commence */
+	bdev_add(bdev, devt);
 	rcu_assign_pointer(ptbl->part[partno], p);
 
 	/* suppress uevent if the disk suppresses it */
@@ -479,6 +482,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 
 out_free_info:
 	kfree(p->info);
+out_bdput:
+	bdput(bdev);
 out_free_stats:
 	free_percpu(p->dkstats);
 out_free:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 03f06c1614152b..07b869c2ade501 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -863,31 +863,46 @@ void __init bdev_cache_init(void)
 	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
 }
 
-static struct block_device *bdget(dev_t dev)
+struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 {
 	struct block_device *bdev;
 	struct inode *inode;
 
-	inode = iget_locked(blockdev_superblock, dev);
+	inode = new_inode(blockdev_superblock);
 	if (!inode)
 		return NULL;
+	inode->i_mode = S_IFBLK;
+	inode->i_rdev = 0;
+	inode->i_data.a_ops = &def_blk_aops;
+	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
+
+	bdev = I_BDEV(inode);
+	spin_lock_init(&bdev->bd_size_lock);
+	bdev->bd_disk = disk;
+	bdev->bd_partno = partno;
+	bdev->bd_contains = NULL;
+	bdev->bd_super = NULL;
+	bdev->bd_inode = inode;
+	bdev->bd_part_count = 0;
+	return bdev;
+}
 
-	bdev = &BDEV_I(inode)->bdev;
+void bdev_add(struct block_device *bdev, dev_t dev)
+{
+	bdev->bd_dev = dev;
+	bdev->bd_inode->i_rdev = dev;
+	bdev->bd_inode->i_ino = dev;
+	insert_inode_hash(bdev->bd_inode);
+}
 
-	if (inode->i_state & I_NEW) {
-		spin_lock_init(&bdev->bd_size_lock);
-		bdev->bd_contains = NULL;
-		bdev->bd_super = NULL;
-		bdev->bd_inode = inode;
-		bdev->bd_part_count = 0;
-		bdev->bd_dev = dev;
-		inode->i_mode = S_IFBLK;
-		inode->i_rdev = dev;
-		inode->i_data.a_ops = &def_blk_aops;
-		mapping_set_gfp_mask(&inode->i_data, GFP_USER);
-		unlock_new_inode(inode);
-	}
-	return bdev;
+static struct block_device *bdget(dev_t dev)
+{
+	struct inode *inode;
+
+	inode = ilookup(blockdev_superblock, dev);
+	if (!inode)
+		return NULL;
+	return &BDEV_I(inode)->bdev;
 }
 
 /**
@@ -1000,27 +1015,6 @@ int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
 }
 EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
 
-static struct gendisk *bdev_get_gendisk(struct block_device *bdev, int *partno)
-{
-	struct gendisk *disk = get_gendisk(bdev->bd_dev, partno);
-
-	if (!disk)
-		return NULL;
-	/*
-	 * Now that we hold gendisk reference we make sure bdev we looked up is
-	 * not stale. If it is, it means device got removed and created before
-	 * we looked up gendisk and we fail open in such case. Associating
-	 * unhashed bdev with newly created gendisk could lead to two bdevs
-	 * (and thus two independent caches) being associated with one device
-	 * which is bad.
-	 */
-	if (inode_unhashed(bdev->bd_inode)) {
-		put_disk_and_module(disk);
-		return NULL;
-	}
-	return disk;
-}
-
 static void bd_clear_claiming(struct block_device *whole, void *holder)
 {
 	lockdep_assert_held(&bdev_lock);
@@ -1343,19 +1337,17 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
  *  mutex_lock(part->bd_mutex)
  *    mutex_lock_nested(whole->bd_mutex, 1)
  */
-static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
-		int partno, fmode_t mode)
+static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 {
+	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
 	if (!bdev->bd_openers) {
-		bdev->bd_disk = disk;
 		bdev->bd_contains = bdev;
-		bdev->bd_partno = partno;
 
-		if (!partno) {
+		if (!bdev->bd_partno) {
 			ret = -ENXIO;
-			bdev->bd_part = disk_get_part(disk, partno);
+			bdev->bd_part = disk_get_part(disk, 0);
 			if (!bdev->bd_part)
 				goto out_clear;
 
@@ -1384,7 +1376,7 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
 			struct block_device *whole = bdget_disk(disk, 0);
 
 			mutex_lock_nested(&whole->bd_mutex, 1);
-			ret = __blkdev_get(whole, disk, 0, mode);
+			ret = __blkdev_get(whole, mode);
 			if (ret) {
 				mutex_unlock(&whole->bd_mutex);
 				bdput(whole);
@@ -1394,9 +1386,8 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
 			mutex_unlock(&whole->bd_mutex);
 
 			bdev->bd_contains = whole;
-			bdev->bd_part = disk_get_part(disk, partno);
-			if (!(disk->flags & GENHD_FL_UP) ||
-			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
+			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
+			if (!bdev->bd_part || !bdev->bd_part->nr_sects) {
 				__blkdev_put(whole, mode, 1);
 				bdput(whole);
 				ret = -ENXIO;
@@ -1426,12 +1417,51 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
 
  out_clear:
 	disk_put_part(bdev->bd_part);
-	bdev->bd_disk = NULL;
 	bdev->bd_part = NULL;
 	bdev->bd_contains = NULL;
 	return ret;
 }
 
+struct block_device *blkdev_get_no_open(dev_t dev)
+{
+	struct block_device *bdev = bdget(dev);
+	struct gendisk *disk;
+
+	down_read(&bdev_lookup_sem);
+	if (!bdev) {
+		up_read(&bdev_lookup_sem);
+		blk_request_module(dev);
+		down_read(&bdev_lookup_sem);
+
+		bdev = bdget(dev);
+		if (!bdev)
+			return NULL;
+	}
+
+	disk = bdev->bd_disk;
+	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
+		goto bdput;
+	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
+		goto bdput;
+	if (!try_module_get(bdev->bd_disk->fops->owner))
+		goto put_disk;
+	up_read(&bdev_lookup_sem);
+	return bdev;
+put_disk:
+	put_disk(disk);
+bdput:
+	bdput(bdev);
+	up_read(&bdev_lookup_sem);
+	return NULL;
+}
+
+void blkdev_put_no_open(struct block_device *bdev)
+{
+	module_put(bdev->bd_disk->fops->owner);
+	put_disk(bdev->bd_disk);
+	bdput(bdev);
+}
+
 /**
  * blkdev_get_by_dev - open a block device by device number
  * @dev: device number of block device to open
@@ -1459,7 +1489,6 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	bool unblock_events = true;
 	struct block_device *bdev;
 	struct gendisk *disk;
-	int partno;
 	int ret;
 
 	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
@@ -1469,18 +1498,14 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	if (ret)
 		return ERR_PTR(ret);
 
-	bdev = bdget(dev);
-	if (!bdev)
-		return ERR_PTR(-ENOMEM);
-
 	/*
 	 * If we lost a race with 'disk' being deleted, try again.  See md.c.
 	 */
 retry:
-	ret = -ENXIO;
-	disk = bdev_get_gendisk(bdev, &partno);
-	if (!disk)
-		goto bdput;
+	bdev = blkdev_get_no_open(dev);
+	if (!bdev)
+		return ERR_PTR(-ENXIO);
+	disk = bdev->bd_disk;
 
 	if (mode & FMODE_EXCL) {
 		WARN_ON_ONCE(!holder);
@@ -1488,7 +1513,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		ret = -ENOMEM;
 		claiming = bdget_disk(disk, 0);
 		if (!claiming)
-			goto put_disk;
+			goto put_blkdev;
 		ret = bd_prepare_to_claim(bdev, claiming, holder);
 		if (ret)
 			goto put_claiming;
@@ -1497,12 +1522,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	disk_block_events(disk);
 
 	mutex_lock(&bdev->bd_mutex);
-	ret =__blkdev_get(bdev, disk, partno, mode);
-	if (!(mode & FMODE_EXCL)) {
-		; /* nothing to do here */
-	} else if (ret) {
-		bd_abort_claiming(bdev, claiming, holder);
-	} else {
+	ret =__blkdev_get(bdev, mode);
+	if (ret)
+		goto abort_claiming;
+	if (mode & FMODE_EXCL) {
 		bd_finish_claiming(bdev, claiming, holder);
 
 		/*
@@ -1522,21 +1545,23 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 
 	if (unblock_events)
 		disk_unblock_events(disk);
+	if (mode & FMODE_EXCL)
+		bdput(claiming);
+	return bdev;
 
+abort_claiming:
+	if (mode & FMODE_EXCL)
+		bd_abort_claiming(bdev, claiming, holder);
+	mutex_unlock(&bdev->bd_mutex);
+	disk_unblock_events(disk);
 put_claiming:
 	if (mode & FMODE_EXCL)
 		bdput(claiming);
-put_disk:
-	if (ret)
-		put_disk_and_module(disk);
+put_blkdev:
+	blkdev_put_no_open(bdev);
 	if (ret == -ERESTARTSYS)
 		goto retry;
-bdput:
-	if (ret) {
-		bdput(bdev);
-		return ERR_PTR(ret);
-	}
-	return bdev;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(blkdev_get_by_dev);
 
@@ -1638,7 +1663,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 
 		disk_put_part(bdev->bd_part);
 		bdev->bd_part = NULL;
-		bdev->bd_disk = NULL;
 		if (bdev_is_partition(bdev))
 			victim = bdev->bd_contains;
 		bdev->bd_contains = NULL;
@@ -1696,12 +1720,10 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	 * from userland - e.g. eject(1).
 	 */
 	disk_flush_events(disk, DISK_EVENT_MEDIA_CHANGE);
-
 	mutex_unlock(&bdev->bd_mutex);
 
 	__blkdev_put(bdev, mode, 0);
-	bdput(bdev);
-	put_disk_and_module(disk);
+	blkdev_put_no_open(bdev);
 }
 EXPORT_SYMBOL(blkdev_put);
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index c8fc9792ac776d..b9f3c246c3c908 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -197,12 +197,12 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v);
 
 struct blkg_conf_ctx {
-	struct gendisk			*disk;
+	struct block_device		*bdev;
 	struct blkcg_gq			*blkg;
 	char				*body;
 };
 
-struct gendisk *blkcg_conf_get_disk(char **inputp);
+struct block_device *blkcg_conf_open_bdev(char **inputp);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bdd7339bcda462..5d48b92f5e4348 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1994,6 +1994,12 @@ void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
 		void *holder);
 void blkdev_put(struct block_device *bdev, fmode_t mode);
 
+/* just for blk-cgroup, don't use elsewhere */
+struct block_device *blkdev_get_no_open(dev_t dev);
+void blkdev_put_no_open(struct block_device *bdev);
+
+struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
+void bdev_add(struct block_device *bdev, dev_t dev);
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *bdget_part(struct hd_struct *part);
 struct block_device *bdgrab(struct block_device *bdev);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ca5e356084c353..42a51653c7303e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -65,6 +65,7 @@ struct hd_struct {
 	struct disk_stats __percpu *dkstats;
 	struct percpu_ref ref;
 
+	struct block_device *bdev;
 	struct device __dev;
 	struct kobject *holder_dir;
 	int policy, partno;
@@ -193,7 +194,6 @@ struct gendisk {
 	int flags;
 	unsigned long state;
 #define GD_NEED_PART_SCAN		0
-	struct rw_semaphore lookup_sem;
 	struct kobject *slave_dir;
 
 	struct timer_rand_state *random;
@@ -300,7 +300,6 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
 }
 
 extern void del_gendisk(struct gendisk *gp);
-extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
 extern void set_disk_ro(struct gendisk *disk, int flag);
@@ -338,7 +337,6 @@ int blk_drop_partitions(struct block_device *bdev);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern void put_disk(struct gendisk *disk);
-extern void put_disk_and_module(struct gendisk *disk);
 
 #define alloc_disk_node(minors, node_id)				\
 ({									\
@@ -388,7 +386,10 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 }
 #endif /* CONFIG_SYSFS */
 
+extern struct rw_semaphore bdev_lookup_sem;
+
 dev_t blk_lookup_devt(const char *name, int partno);
+void blk_request_module(dev_t devt);
 #ifdef CONFIG_BLOCK
 void printk_all_partitions(void);
 #else /* CONFIG_BLOCK */
-- 
2.29.2

