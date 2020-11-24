Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514E72C2791
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbgKXN26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388190AbgKXN25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45FC0613D6;
        Tue, 24 Nov 2020 05:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VSLNoQYrcMsDvA0bIyZ6Cp7YvcFLkKctZqyVVMQzWQQ=; b=Xj5f5+5votDpJMSn8jQCWmHw9/
        XXRQ59s5rv/9zlsKYdfsZBWD1P7YKJYsYlYIC7zCjRk8UlazwByqEbxTzz9ghIwV/RVYFaLz+qmsz
        rjW5dlfsEfLdWPMXVrkJP/LKQ+33LmrzdwOtA4aTpSIJMj8z0Ph+ufU4vLwfoLzFbM1J8mFrrVhUi
        Hbpb1ukVNbEJylCu6liovwieggVlh1pq8+rv6Tt0xtV9nnseQ4/e+tgqCCReJQlC9YaLQhQ6++QvO
        27SlLu3NX5YpgagCH0eM/PxZn+v1bTyB7UCCJDLuBLHXUrGXyo/4Ba5cEzZoaY+J8FxE4Ehch1F4M
        EerU96dQ==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNA-0006eF-Jo; Tue, 24 Nov 2020 13:28:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 30/45] block: remove the nr_sects field in struct hd_struct
Date:   Tue, 24 Nov 2020 14:27:36 +0100
Message-Id: <20201124132751.3747337-31-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the hd_struct always has a block device attached to it, there is
no need for having two size field that just get out of sync.

Additional the field in hd_struct did not use proper serializiation,
possibly allowing for torn writes.  By only using the block_device field
this problem also gets fixed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bio.c                        |  4 +-
 block/blk-core.c                   |  2 +-
 block/blk.h                        | 53 ----------------------
 block/genhd.c                      | 55 +++++++++++-----------
 block/partitions/core.c            | 17 ++++---
 drivers/block/loop.c               |  1 -
 drivers/block/nbd.c                |  2 +-
 drivers/block/xen-blkback/common.h |  4 +-
 drivers/md/bcache/super.c          |  2 +-
 drivers/s390/block/dasd_ioctl.c    |  4 +-
 drivers/target/target_core_pscsi.c |  7 +--
 fs/block_dev.c                     | 73 +-----------------------------
 fs/f2fs/super.c                    |  2 +-
 fs/pstore/blk.c                    |  2 +-
 include/linux/genhd.h              | 29 +++---------
 kernel/trace/blktrace.c            |  2 +-
 16 files changed, 60 insertions(+), 199 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1fe..669bb47a31988e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -613,8 +613,8 @@ void guard_bio_eod(struct bio *bio)
 	rcu_read_lock();
 	part = __disk_get_part(bio->bi_disk, bio->bi_partno);
 	if (part)
-		maxsector = part_nr_sects_read(part);
-	else
+		maxsector = bdev_nr_sectors(part->bdev);
+	else	
 		maxsector = get_capacity(bio->bi_disk);
 	rcu_read_unlock();
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 2db8bda43b6e6d..988f45094a387b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -755,7 +755,7 @@ static inline int blk_partition_remap(struct bio *bio)
 		goto out;
 
 	if (bio_sectors(bio)) {
-		if (bio_check_eod(bio, part_nr_sects_read(p)))
+		if (bio_check_eod(bio, bdev_nr_sectors(p->bdev)))
 			goto out;
 		bio->bi_iter.bi_sector += p->start_sect;
 		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
diff --git a/block/blk.h b/block/blk.h
index c4839abcfa27eb..09cee7024fb43e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -387,59 +387,6 @@ static inline void hd_free_part(struct hd_struct *part)
 	percpu_ref_exit(&part->ref);
 }
 
-/*
- * Any access of part->nr_sects which is not protected by partition
- * bd_mutex or gendisk bdev bd_mutex, should be done using this
- * accessor function.
- *
- * Code written along the lines of i_size_read() and i_size_write().
- * CONFIG_PREEMPTION case optimizes the case of UP kernel with preemption
- * on.
- */
-static inline sector_t part_nr_sects_read(struct hd_struct *part)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	sector_t nr_sects;
-	unsigned seq;
-	do {
-		seq = read_seqcount_begin(&part->nr_sects_seq);
-		nr_sects = part->nr_sects;
-	} while (read_seqcount_retry(&part->nr_sects_seq, seq));
-	return nr_sects;
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
-	sector_t nr_sects;
-
-	preempt_disable();
-	nr_sects = part->nr_sects;
-	preempt_enable();
-	return nr_sects;
-#else
-	return part->nr_sects;
-#endif
-}
-
-/*
- * Should be called with mutex lock held (typically bd_mutex) of partition
- * to provide mutual exlusion among writers otherwise seqcount might be
- * left in wrong state leaving the readers spinning infinitely.
- */
-static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	preempt_disable();
-	write_seqcount_begin(&part->nr_sects_seq);
-	part->nr_sects = size;
-	write_seqcount_end(&part->nr_sects_seq);
-	preempt_enable();
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
-	preempt_disable();
-	part->nr_sects = size;
-	preempt_enable();
-#else
-	part->nr_sects = size;
-#endif
-}
-
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
diff --git a/block/genhd.c b/block/genhd.c
index 16c6b13242105b..8ace0628ac20b7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -38,6 +38,16 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
+void set_capacity(struct gendisk *disk, sector_t sectors)
+{
+	struct block_device *bdev = disk->part0.bdev;
+
+	spin_lock(&bdev->bd_size_lock);
+	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	spin_unlock(&bdev->bd_size_lock);
+}
+EXPORT_SYMBOL(set_capacity);
+
 /*
  * Set disk capacity and notify if the size is not currently zero and will not
  * be set to zero.  Returns true if a uevent was sent, otherwise false.
@@ -45,18 +55,22 @@ static void disk_release_events(struct gendisk *disk);
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 {
 	sector_t capacity = get_capacity(disk);
+	char *envp[] = { "RESIZE=1", NULL };
 
 	set_capacity(disk, size);
-	revalidate_disk_size(disk, true);
-
-	if (capacity != size && capacity != 0 && size != 0) {
-		char *envp[] = { "RESIZE=1", NULL };
-
-		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
-		return true;
-	}
 
-	return false;
+	/*
+	 * Only print a message and send a uevent if the gendisk is user visible
+	 * and alive.  This avoids spamming the log and udev when setting the
+	 * initial capacity during probing.
+	 */
+	if (size == capacity ||
+	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
+		return false;
+	pr_info("%s: detected capacity change from %lld to %lld\n",
+		disk->disk_name, size, capacity);
+	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	return true;
 }
 EXPORT_SYMBOL_GPL(set_capacity_and_notify);
 
@@ -245,7 +259,7 @@ struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
 		part = rcu_dereference(ptbl->part[piter->idx]);
 		if (!part)
 			continue;
-		if (!part_nr_sects_read(part) &&
+		if (!bdev_nr_sectors(part->bdev) &&
 		    !(piter->flags & DISK_PITER_INCL_EMPTY) &&
 		    !(piter->flags & DISK_PITER_INCL_EMPTY_PART0 &&
 		      piter->idx == 0))
@@ -282,7 +296,7 @@ EXPORT_SYMBOL_GPL(disk_part_iter_exit);
 static inline int sector_in_part(struct hd_struct *part, sector_t sector)
 {
 	return part->start_sect <= sector &&
-		sector < part->start_sect + part_nr_sects_read(part);
+		sector < part->start_sect + bdev_nr_sectors(part->bdev);
 }
 
 /**
@@ -978,8 +992,8 @@ void __init printk_all_partitions(void)
 
 			printk("%s%s %10llu %s %s", is_part0 ? "" : "  ",
 			       bdevt_str(part_devt(part), devt_buf),
-			       (unsigned long long)part_nr_sects_read(part) >> 1
-			       , disk_name(disk, part->partno, name_buf),
+			       bdev_nr_sectors(part->bdev) >> 1,
+			       disk_name(disk, part->partno, name_buf),
 			       part->info ? part->info->uuid : "");
 			if (is_part0) {
 				if (dev->parent && dev->parent->driver)
@@ -1071,7 +1085,7 @@ static int show_partition(struct seq_file *seqf, void *v)
 	while ((part = disk_part_iter_next(&piter)))
 		seq_printf(seqf, "%4d  %7d %10llu %s\n",
 			   MAJOR(part_devt(part)), MINOR(part_devt(part)),
-			   (unsigned long long)part_nr_sects_read(part) >> 1,
+			   bdev_nr_sectors(part->bdev) >> 1,
 			   disk_name(sgp, part->partno, buf));
 	disk_part_iter_exit(&piter);
 
@@ -1153,8 +1167,7 @@ ssize_t part_size_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 
-	return sprintf(buf, "%llu\n",
-		(unsigned long long)part_nr_sects_read(p));
+	return sprintf(buf, "%llu\n", bdev_nr_sectors(p->bdev));
 }
 
 ssize_t part_stat_show(struct device *dev,
@@ -1610,16 +1623,6 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
 	rcu_assign_pointer(ptbl->part[0], &disk->part0);
 
-	/*
-	 * set_capacity() and get_capacity() currently don't use
-	 * seqcounter to read/update the part0->nr_sects. Still init
-	 * the counter as we can read the sectors in IO submission
-	 * patch using seqence counters.
-	 *
-	 * TODO: Ideally set_capacity() and get_capacity() should be
-	 * converted to make use of bd_mutex and sequence counters.
-	 */
-	hd_sects_seq_init(&disk->part0);
 	if (hd_ref_init(&disk->part0))
 		goto out_free_bdstats;
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 508b46da53eee5..92ffa55bdfddfd 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -85,6 +85,13 @@ static int (*check_part[])(struct parsed_partitions *) = {
 	NULL
 };
 
+static void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
+{
+	spin_lock(&bdev->bd_size_lock);
+	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	spin_unlock(&bdev->bd_size_lock);
+}
+
 static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
 {
 	struct parsed_partitions *state;
@@ -295,7 +302,7 @@ static void hd_struct_free_work(struct work_struct *work)
 	put_device(disk_to_dev(disk));
 
 	part->start_sect = 0;
-	part->nr_sects = 0;
+	bdev_set_nr_sectors(part->bdev, 0);
 	part_stat_set_all(part, 0);
 	put_device(part_to_dev(part));
 }
@@ -412,11 +419,10 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		goto out_free_stats;
 	p->bdev = bdev;
 
-	hd_sects_seq_init(p);
 	pdev = part_to_dev(p);
 
 	p->start_sect = start;
-	p->nr_sects = len;
+	bdev_set_nr_sectors(bdev, len);
 	p->partno = partno;
 	p->policy = get_disk_ro(disk);
 
@@ -509,7 +515,7 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter))) {
 		if (part->partno == skip_partno ||
-		    start >= part->start_sect + part->nr_sects ||
+		    start >= part->start_sect + bdev_nr_sectors(part->bdev) ||
 		    start + length <= part->start_sect)
 			continue;
 		overlap = true;
@@ -600,8 +606,7 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 	if (partition_overlaps(bdev->bd_disk, start, length, partno))
 		goto out_unlock;
 
-	part_nr_sects_write(part, length);
-	bd_set_nr_sectors(bdevp, length);
+	bdev_set_nr_sectors(bdevp, length);
 
 	ret = 0;
 out_unlock:
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d643c67be6acea..d2ce1ddc192d78 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1241,7 +1241,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	set_capacity(lo->lo_disk, 0);
 	loop_sysfs_exit(lo);
 	if (bdev) {
-		bd_set_nr_sectors(bdev, 0);
 		/* let user-space know about this change */
 		kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 	}
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 45b0423ef2c53d..014683968ce174 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1132,7 +1132,7 @@ static void nbd_bdev_reset(struct block_device *bdev)
 {
 	if (bdev->bd_openers > 1)
 		return;
-	bd_set_nr_sectors(bdev, 0);
+	set_capacity(bdev->bd_disk, 0);
 }
 
 static void nbd_parse_flags(struct nbd_device *nbd)
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index c6ea5d38c509a6..0762db247b41b3 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -358,9 +358,7 @@ struct pending_req {
 };
 
 
-#define vbd_sz(_v)	((_v)->bdev->bd_part ? \
-			 (_v)->bdev->bd_part->nr_sects : \
-			  get_capacity((_v)->bdev->bd_disk))
+#define vbd_sz(_v)	bdev_nr_sectors((_v)->bdev)
 
 #define xen_blkif_get(_b) (atomic_inc(&(_b)->refcnt))
 #define xen_blkif_put(_b)				\
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index c55d3c58a7ef55..04fa40868fbe10 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1408,7 +1408,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 			q->limits.raid_partial_stripes_expensive;
 
 	ret = bcache_device_init(&dc->disk, block_size,
-			 dc->bdev->bd_part->nr_sects - dc->sb.data_offset,
+			 bdev_nr_sectors(dc->bdev) - dc->sb.data_offset,
 			 dc->bdev, &bcache_cached_ops);
 	if (ret)
 		return ret;
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 3359559517bfcf..304eba1acf163c 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -54,8 +54,6 @@ dasd_ioctl_enable(struct block_device *bdev)
 		return -ENODEV;
 
 	dasd_enable_device(base);
-	/* Formatting the dasd device can change the capacity. */
-	bd_set_nr_sectors(bdev, get_capacity(base->block->gdp));
 	dasd_put_device(base);
 	return 0;
 }
@@ -88,7 +86,7 @@ dasd_ioctl_disable(struct block_device *bdev)
 	 * Set i_size to zero, since read, write, etc. check against this
 	 * value.
 	 */
-	bd_set_nr_sectors(bdev, 0);
+	set_capacity(bdev->bd_disk, 0);
 	dasd_put_device(base);
 	return 0;
 }
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 4e37fa9b409d52..a70c33c49f0960 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1027,12 +1027,7 @@ static u32 pscsi_get_device_type(struct se_device *dev)
 
 static sector_t pscsi_get_blocks(struct se_device *dev)
 {
-	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
-
-	if (pdv->pdv_bd && pdv->pdv_bd->bd_part)
-		return pdv->pdv_bd->bd_part->nr_sects;
-
-	return 0;
+	return bdev_nr_sectors(PSCSI_DEV(dev)->pdv_bd);
 }
 
 static void pscsi_req_done(struct request *req, blk_status_t status)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 1e5c6d0eb92677..02536d9fa29945 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1203,70 +1203,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
 #endif
 
-/**
- * check_disk_size_change - checks for disk size change and adjusts bdev size.
- * @disk: struct gendisk to check
- * @bdev: struct bdev to adjust.
- * @verbose: if %true log a message about a size change if there is any
- *
- * This routine checks to see if the bdev size does not match the disk size
- * and adjusts it if it differs. When shrinking the bdev size, its all caches
- * are freed.
- */
-static void check_disk_size_change(struct gendisk *disk,
-		struct block_device *bdev, bool verbose)
-{
-	loff_t disk_size, bdev_size;
-
-	spin_lock(&bdev->bd_size_lock);
-	disk_size = (loff_t)get_capacity(disk) << 9;
-	bdev_size = i_size_read(bdev->bd_inode);
-	if (disk_size != bdev_size) {
-		if (verbose) {
-			printk(KERN_INFO
-			       "%s: detected capacity change from %lld to %lld\n",
-			       disk->disk_name, bdev_size, disk_size);
-		}
-		i_size_write(bdev->bd_inode, disk_size);
-	}
-	spin_unlock(&bdev->bd_size_lock);
-}
-
-/**
- * revalidate_disk_size - checks for disk size change and adjusts bdev size.
- * @disk: struct gendisk to check
- * @verbose: if %true log a message about a size change if there is any
- *
- * This routine checks to see if the bdev size does not match the disk size
- * and adjusts it if it differs. When shrinking the bdev size, its all caches
- * are freed.
- */
-void revalidate_disk_size(struct gendisk *disk, bool verbose)
-{
-	struct block_device *bdev;
-
-	/*
-	 * Hidden disks don't have associated bdev so there's no point in
-	 * revalidating them.
-	 */
-	if (disk->flags & GENHD_FL_HIDDEN)
-		return;
-
-	bdev = bdget_disk(disk, 0);
-	if (bdev) {
-		check_disk_size_change(disk, bdev, verbose);
-		bdput(bdev);
-	}
-}
-
-void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
-{
-	spin_lock(&bdev->bd_size_lock);
-	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	spin_unlock(&bdev->bd_size_lock);
-}
-EXPORT_SYMBOL(bd_set_nr_sectors);
-
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate)
@@ -1300,8 +1236,6 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 			disk->fops->revalidate_disk(disk);
 	}
 
-	check_disk_size_change(disk, bdev, !invalidate);
-
 	if (get_capacity(disk)) {
 		ret = blk_add_partitions(disk, bdev);
 		if (ret == -EAGAIN)
@@ -1344,10 +1278,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 			if (disk->fops->open)
 				ret = disk->fops->open(bdev, mode);
 
-			if (!ret) {
-				bd_set_nr_sectors(bdev, get_capacity(disk));
+			if (!ret)
 				set_init_blocksize(bdev);
-			}
 
 			/*
 			 * If the device is invalidated, rescan partition
@@ -1375,12 +1307,11 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 			mutex_unlock(&whole->bd_mutex);
 
 			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
-			if (!bdev->bd_part || !bdev->bd_part->nr_sects) {
+			if (!bdev_nr_sectors(bdev)) {
 				__blkdev_put(whole, mode, 1);
 				ret = -ENXIO;
 				goto out_clear;
 			}
-			bd_set_nr_sectors(bdev, bdev->bd_part->nr_sects);
 			set_init_blocksize(bdev);
 		}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 00eff2f5180790..d4e7fab352bacb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3151,7 +3151,7 @@ static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx,
 static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 {
 	struct block_device *bdev = FDEV(devi).bdev;
-	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	sector_t nr_sectors = bdev_nr_sectors(bdev);
 	struct f2fs_report_zones_args rep_zone_arg;
 	int ret;
 
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index fcd5563dde063c..777a26f7bbe2aa 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -245,7 +245,7 @@ static struct block_device *psblk_get_bdev(void *holder,
 			return bdev;
 	}
 
-	nr_sects = part_nr_sects_read(bdev->bd_part);
+	nr_sects = bdev_nr_sectors(bdev);
 	if (!nr_sects) {
 		pr_err("not enough space for '%s'\n", blkdev);
 		blkdev_put(bdev, mode);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index dcf86a3d4dedc4..0dbd254bca51aa 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -52,15 +52,6 @@ struct partition_meta_info {
 
 struct hd_struct {
 	sector_t start_sect;
-	/*
-	 * nr_sects is protected by sequence counter. One might extend a
-	 * partition while IO is happening to it and update of nr_sects
-	 * can be non-atomic on 32bit machines with 64bit sector_t.
-	 */
-	sector_t nr_sects;
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	seqcount_t nr_sects_seq;
-#endif
 	unsigned long stamp;
 	struct disk_stats __percpu *dkstats;
 	struct percpu_ref ref;
@@ -255,13 +246,6 @@ static inline void disk_put_part(struct hd_struct *part)
 		put_device(part_to_dev(part));
 }
 
-static inline void hd_sects_seq_init(struct hd_struct *p)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	seqcount_init(&p->nr_sects_seq);
-#endif
-}
-
 /*
  * Smarter partition iterator without context limits.
  */
@@ -319,13 +303,15 @@ static inline sector_t get_start_sect(struct block_device *bdev)
 {
 	return bdev->bd_part->start_sect;
 }
-static inline sector_t get_capacity(struct gendisk *disk)
+
+static inline sector_t bdev_nr_sectors(struct block_device *bdev)
 {
-	return disk->part0.nr_sects;
+	return i_size_read(bdev->bd_inode) >> 9;
 }
-static inline void set_capacity(struct gendisk *disk, sector_t size)
+
+static inline sector_t get_capacity(struct gendisk *disk)
 {
-	disk->part0.nr_sects = size;
+	return bdev_nr_sectors(disk->part0.bdev);
 }
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
@@ -359,10 +345,9 @@ int __register_blkdev(unsigned int major, const char *name,
 	__register_blkdev(major, name, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
 
-void revalidate_disk_size(struct gendisk *disk, bool verbose);
 bool bdev_check_media_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
-void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
+void set_capacity(struct gendisk *disk, sector_t size);
 
 /* for drivers/char/raw.c: */
 int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f1022945e3460b..7076d588a50d69 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -465,7 +465,7 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 
 	if (part) {
 		bt->start_lba = part->start_sect;
-		bt->end_lba = part->start_sect + part->nr_sects;
+		bt->end_lba = part->start_sect + bdev_nr_sectors(bdev);
 	} else {
 		bt->start_lba = 0;
 		bt->end_lba = -1ULL;
-- 
2.29.2

