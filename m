Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5072C27BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgKXN3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbgKXN3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:29:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7383C0613D6;
        Tue, 24 Nov 2020 05:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hd58vTxwYflslTooUzvIkiEUZh8oqfMehzvRdiTDmRg=; b=YCNB4naCKZWhAaCsg1kYokxu80
        rDFjtrYT7lEuIA8sVbt3CobuCxtFPj2/8pE/tRoK9WUNzb1EdlB5LEPyHhE8AJLIRh3/PtVC8ov/2
        mjdWUOy4bTyT5WfIjImo/Xyw0j7f7zyydciqCBDbZljVfC1fZErmHDGOhwC9Dzd0ePKxnsPI1bPv+
        6cChoKXYn89Zvu9rflA5Px/7sSzxUQ2digOs8X0WWZZ+SFnJJoixr4SYXxUPnXKXDp3K+ri7V80Kr
        UHQMztu7BO6hhSivmU18rXD88ntr13ZGE1Ci0+MS7lPzbgMA19Bp2MZIaWuGvdI9AR6vpqR8mTh6B
        IrrZC5xw==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNM-0006gV-JV; Tue, 24 Nov 2020 13:28:57 +0000
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
Subject: [PATCH 37/45] block: allocate struct hd_struct as part of struct bdev_inode
Date:   Tue, 24 Nov 2020 14:27:43 +0100
Message-Id: <20201124132751.3747337-38-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allocate hd_struct together with struct block_device to pre-load
the lifetime rule changes in preparation of merging the two structures.

Note that part0 was previously embedded into struct gendisk, but is
a separate allocation now, and already points to the block_device instead
of the hd_struct.  The lifetime of struct gendisk is still controlled by
the struct device embedded in the part0 hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c                   | 16 ++++---
 block/blk-flush.c                  |  2 +-
 block/blk-merge.c                  |  2 -
 block/blk.h                        | 21 ----------
 block/genhd.c                      | 50 +++++++++-------------
 block/partitions/core.c            | 67 +++---------------------------
 drivers/block/drbd/drbd_receiver.c |  2 +-
 drivers/block/drbd/drbd_worker.c   |  3 +-
 drivers/block/zram/zram_drv.c      |  2 +-
 drivers/md/dm.c                    |  4 +-
 drivers/md/md.c                    |  2 +-
 fs/block_dev.c                     | 37 +++++------------
 include/linux/blk_types.h          |  2 +-
 include/linux/genhd.h              | 14 +++----
 include/linux/part_stat.h          |  4 +-
 15 files changed, 60 insertions(+), 168 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d64ffcb6f9ae5d..9ea70275fc1cfe 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -714,7 +714,8 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 
 static noinline int should_fail_bio(struct bio *bio)
 {
-	if (should_fail_request(&bio->bi_disk->part0, bio->bi_iter.bi_size))
+	if (should_fail_request(bio->bi_disk->part0->bd_part,
+			bio->bi_iter.bi_size))
 		return -EIO;
 	return 0;
 }
@@ -831,7 +832,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		if (unlikely(blk_partition_remap(bio)))
 			goto end_io;
 	} else {
-		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
+		if (unlikely(bio_check_ro(bio, bio->bi_disk->part0->bd_part)))
 			goto end_io;
 		if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
 			goto end_io;
@@ -1203,7 +1204,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		return ret;
 
 	if (rq->rq_disk &&
-	    should_fail_request(&rq->rq_disk->part0, blk_rq_bytes(rq)))
+	    should_fail_request(rq->rq_disk->part0->bd_part, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
 	if (blk_crypto_insert_cloned_request(rq))
@@ -1272,7 +1273,7 @@ static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
 	if (part->partno) {
-		part = &part_to_disk(part)->part0;
+		part = part_to_disk(part)->part0->bd_part;
 		goto again;
 	}
 }
@@ -1309,8 +1310,6 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
-
-		hd_struct_put(part);
 	}
 }
 
@@ -1354,7 +1353,7 @@ EXPORT_SYMBOL_GPL(part_start_io_acct);
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 				 unsigned int op)
 {
-	return __part_start_io_acct(&disk->part0, sectors, op);
+	return __part_start_io_acct(disk->part0->bd_part, sectors, op);
 }
 EXPORT_SYMBOL(disk_start_io_acct);
 
@@ -1376,14 +1375,13 @@ void part_end_io_acct(struct hd_struct *part, struct bio *bio,
 		      unsigned long start_time)
 {
 	__part_end_io_acct(part, bio_op(bio), start_time);
-	hd_struct_put(part);
 }
 EXPORT_SYMBOL_GPL(part_end_io_acct);
 
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		      unsigned long start_time)
 {
-	__part_end_io_acct(&disk->part0, op, start_time);
+	__part_end_io_acct(disk->part0->bd_part, op, start_time);
 }
 EXPORT_SYMBOL(disk_end_io_acct);
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index e32958f0b68750..fcd0a60574dff8 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -139,7 +139,7 @@ static void blk_flush_queue_rq(struct request *rq, bool add_front)
 
 static void blk_account_io_flush(struct request *rq)
 {
-	struct hd_struct *part = &rq->rq_disk->part0;
+	struct hd_struct *part = rq->rq_disk->part0->bd_part;
 
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcf5e458060337..cb351ab9b77dbd 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -683,8 +683,6 @@ static void blk_account_io_merge_request(struct request *req)
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
 		part_stat_unlock();
-
-		hd_struct_put(req->part);
 	}
 }
 
diff --git a/block/blk.h b/block/blk.h
index 0bd4b58bcbaf77..32ac41f7557fcc 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -363,27 +363,6 @@ int bdev_del_partition(struct block_device *bdev, int partno);
 int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int disk_expand_part_tbl(struct gendisk *disk, int target);
-int hd_ref_init(struct hd_struct *part);
-
-/* no need to get/put refcount of part0 */
-static inline int hd_struct_try_get(struct hd_struct *part)
-{
-	if (part->partno)
-		return percpu_ref_tryget_live(&part->ref);
-	return 1;
-}
-
-static inline void hd_struct_put(struct hd_struct *part)
-{
-	if (part->partno)
-		percpu_ref_put(&part->ref);
-}
-
-static inline void hd_free_part(struct hd_struct *part)
-{
-	bdput(part->bdev);
-	percpu_ref_exit(&part->ref);
-}
 
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
diff --git a/block/genhd.c b/block/genhd.c
index 8aed77cc8ad169..3bbf6d3a69ec63 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -40,7 +40,7 @@ static void disk_release_events(struct gendisk *disk);
 
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
-	struct block_device *bdev = disk->part0.bdev;
+	struct block_device *bdev = disk->part0;
 
 	spin_lock(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
@@ -308,9 +308,7 @@ static inline int sector_in_part(struct hd_struct *part, sector_t sector)
  * primarily used for stats accounting.
  *
  * CONTEXT:
- * RCU read locked.  The returned partition pointer is always valid
- * because its refcount is grabbed except for part0, which lifetime
- * is same with the disk.
+ * RCU read locked.
  *
  * RETURNS:
  * Found partition on success, part0 is returned if no partition matches
@@ -326,26 +324,19 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 	ptbl = rcu_dereference(disk->part_tbl);
 
 	part = rcu_dereference(ptbl->last_lookup);
-	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
+	if (part && sector_in_part(part, sector))
 		goto out_unlock;
 
 	for (i = 1; i < ptbl->len; i++) {
 		part = rcu_dereference(ptbl->part[i]);
 
 		if (part && sector_in_part(part, sector)) {
-			/*
-			 * only live partition can be cached for lookup,
-			 * so use-after-free on cached & deleting partition
-			 * can be avoided
-			 */
-			if (!hd_struct_try_get(part))
-				break;
 			rcu_assign_pointer(ptbl->last_lookup, part);
 			goto out_unlock;
 		}
 	}
 
-	part = &disk->part0;
+	part = disk->part0->bd_part;
 out_unlock:
 	rcu_read_unlock();
 	return part;
@@ -671,8 +662,8 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
-	disk->part0.bdev->bd_holder_dir =
-			kobject_create_and_add("holders", &ddev->kobj);
+	disk->part0->bd_holder_dir =
+		kobject_create_and_add("holders", &ddev->kobj);
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 
 	if (disk->flags & GENHD_FL_HIDDEN) {
@@ -738,7 +729,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk->flags |= GENHD_FL_UP;
 
-	retval = blk_alloc_devt(&disk->part0, &devt);
+	retval = blk_alloc_devt(disk->part0->bd_part, &devt);
 	if (retval) {
 		WARN_ON(1);
 		return;
@@ -765,7 +756,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
 		bdi_set_owner(bdi, dev);
-		bdev_add(disk->part0.bdev, devt);
+		bdev_add(disk->part0, devt);
 	}
 	register_disk(parent, disk, groups);
 	if (register_queue)
@@ -872,11 +863,11 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_unregister_queue(disk);
 
-	kobject_put(disk->part0.bdev->bd_holder_dir);
+	kobject_put(disk->part0->bd_holder_dir);
 	kobject_put(disk->slave_dir);
 
-	part_stat_set_all(&disk->part0, 0);
-	disk->part0.bdev->bd_stamp = 0;
+	part_stat_set_all(disk->part0->bd_part, 0);
+	disk->part0->bd_stamp = 0;
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
@@ -989,7 +980,7 @@ void __init printk_all_partitions(void)
 		 */
 		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
 		while ((part = disk_part_iter_next(&piter))) {
-			bool is_part0 = part == &disk->part0;
+			bool is_part0 = part == disk->part0->bd_part;
 
 			printk("%s%s %10llu %s %s", is_part0 ? "" : "  ",
 			       bdevt_str(part_devt(part), devt_buf),
@@ -1444,7 +1435,7 @@ static void disk_release(struct device *dev)
 	disk_release_events(disk);
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
-	hd_free_part(&disk->part0);
+	bdput(disk->part0);
 	if (disk->queue)
 		blk_put_queue(disk->queue);
 	kfree_rcu(disk, rcu);
@@ -1610,8 +1601,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	if (!disk)
 		return NULL;
 
-	disk->part0.bdev = bdev_alloc(disk, 0);
-	if (!disk->part0.bdev)
+	disk->part0 = bdev_alloc(disk, 0);
+	if (!disk->part0)
 		goto out_free_disk;
 
 	disk->node_id = node_id;
@@ -1619,10 +1610,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 		goto out_bdput;
 
 	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
-	rcu_assign_pointer(ptbl->part[0], &disk->part0);
-
-	if (hd_ref_init(&disk->part0))
-		goto out_bdput;
+	rcu_assign_pointer(ptbl->part[0], disk->part0->bd_part);
 
 	disk->minors = minors;
 	rand_initialize_disk(disk);
@@ -1632,7 +1620,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	return disk;
 
 out_bdput:
-	bdput(disk->part0.bdev);
+	bdput(disk->part0);
 out_free_disk:
 	kfree(disk);
 	return NULL;
@@ -1671,9 +1659,9 @@ void set_disk_ro(struct gendisk *disk, int flag)
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
-	if (disk->part0.bdev->bd_read_only != flag) {
+	if (disk->part0->bd_read_only != flag) {
 		set_disk_ro_uevent(disk, flag);
-		disk->part0.bdev->bd_read_only = flag;
+		disk->part0->bd_read_only = flag;
 	}
 
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index fd00428e437a63..4b0352cb29e132 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -265,9 +265,9 @@ static const struct attribute_group *part_attr_groups[] = {
 static void part_release(struct device *dev)
 {
 	struct hd_struct *p = dev_to_part(dev);
+
 	blk_free_devt(dev->devt);
-	hd_free_part(p);
-	kfree(p);
+	bdput(p->bdev);
 }
 
 static int part_uevent(struct device *dev, struct kobj_uevent_env *env)
@@ -288,46 +288,6 @@ struct device_type part_type = {
 	.uevent		= part_uevent,
 };
 
-static void hd_struct_free_work(struct work_struct *work)
-{
-	struct hd_struct *part =
-		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
-	struct gendisk *disk = part_to_disk(part);
-
-	/*
-	 * Release the disk reference acquired in delete_partition here.
-	 * We can't release it in hd_struct_free because the final put_device
-	 * needs process context and thus can't be run directly from a
-	 * percpu_ref ->release handler.
-	 */
-	put_device(disk_to_dev(disk));
-
-	part->bdev->bd_start_sect = 0;
-	bdev_set_nr_sectors(part->bdev, 0);
-	part_stat_set_all(part, 0);
-	put_device(part_to_dev(part));
-}
-
-static void hd_struct_free(struct percpu_ref *ref)
-{
-	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
-	struct gendisk *disk = part_to_disk(part);
-	struct disk_part_tbl *ptbl =
-		rcu_dereference_protected(disk->part_tbl, 1);
-
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
-
-	INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
-	queue_rcu_work(system_wq, &part->rcu_work);
-}
-
-int hd_ref_init(struct hd_struct *part)
-{
-	if (percpu_ref_init(&part->ref, hd_struct_free, 0, GFP_KERNEL))
-		return -ENOMEM;
-	return 0;
-}
-
 /*
  * Must be called either with bd_mutex held, before a disk can be opened or
  * after all disk users are gone.
@@ -342,8 +302,8 @@ void delete_partition(struct hd_struct *part)
 	 * ->part_tbl is referenced in this part's release handler, so
 	 *  we have to hold the disk device
 	 */
-	get_device(disk_to_dev(disk));
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
+	rcu_assign_pointer(ptbl->last_lookup, NULL);
 	kobject_put(part->bdev->bd_holder_dir);
 	device_del(part_to_dev(part));
 
@@ -353,7 +313,7 @@ void delete_partition(struct hd_struct *part)
 	 */
 	remove_inode_hash(part->bdev->bd_inode);
 
-	percpu_ref_kill(&part->ref);
+	put_device(part_to_dev(part));
 }
 
 static ssize_t whole_disk_show(struct device *dev,
@@ -406,15 +366,11 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (ptbl->part[partno])
 		return ERR_PTR(-EBUSY);
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return ERR_PTR(-EBUSY);
-
 	bdev = bdev_alloc(disk, partno);
 	if (!bdev)
-		goto out_free;
-	p->bdev = bdev;
+		return ERR_PTR(-ENOMEM);
 
+	p = bdev->bd_part;
 	pdev = part_to_dev(p);
 
 	bdev->bd_start_sect = start;
@@ -463,13 +419,6 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 			goto out_del;
 	}
 
-	err = hd_ref_init(p);
-	if (err) {
-		if (flags & ADDPART_FLAG_WHOLEDISK)
-			goto out_remove_file;
-		goto out_del;
-	}
-
 	/* everything is up and running, commence */
 	bdev_add(bdev, devt);
 	rcu_assign_pointer(ptbl->part[partno], p);
@@ -481,11 +430,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 
 out_bdput:
 	bdput(bdev);
-out_free:
-	kfree(p);
 	return ERR_PTR(err);
-out_remove_file:
-	device_remove_file(pdev, &dev_attr_whole_disk);
 out_del:
 	kobject_put(bdev->bd_holder_dir);
 	device_del(pdev);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index dc333dbe523281..9e5c2fdfda3629 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2802,7 +2802,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
+	curr_events = (int)part_stat_read_accum(disk->part0->bd_part, sectors) -
 			atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index ba56f3f05312f0..343f56b86bb766 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1678,7 +1678,8 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	atomic_set(&device->rs_sect_in, 0);
 	atomic_set(&device->rs_sect_ev, 0);
 	device->rs_in_flight = 0;
-	device->rs_last_events = (int)part_stat_read_accum(&disk->part0, sectors);
+	device->rs_last_events =
+		(int)part_stat_read_accum(disk->part0->bd_part, sectors);
 
 	/* Updating the RCU protected object in place is necessary since
 	   this function gets called from atomic context.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 88baa6158eaee1..153858734cd47d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1687,7 +1687,7 @@ static void zram_reset_device(struct zram *zram)
 	zram->disksize = 0;
 
 	set_capacity_and_notify(zram->disk, 0);
-	part_stat_set_all(&zram->disk->part0, 0);
+	part_stat_set_all(zram->disk->part0->bd_part, 0);
 
 	up_write(&zram->init_lock);
 	/* I/O operation under all of CPU are done so let's free */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 48051db006f30c..1b2db4d530ea71 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1607,7 +1607,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 				 * (by eliminating DM's splitting and just using bio_split)
 				 */
 				part_stat_lock();
-				__dm_part_stat_sub(&dm_disk(md)->part0,
+				__dm_part_stat_sub(dm_disk(md)->part0->bd_part,
 						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
 				part_stat_unlock();
 
@@ -2242,7 +2242,7 @@ EXPORT_SYMBOL_GPL(dm_put);
 static bool md_in_flight_bios(struct mapped_device *md)
 {
 	int cpu;
-	struct hd_struct *part = &dm_disk(md)->part0;
+	struct hd_struct *part = dm_disk(md)->part0->bd_part;
 	long sum = 0;
 
 	for_each_possible_cpu(cpu) {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7ce6047c856ea2..3696c2d77a4dd7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8441,7 +8441,7 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_disk;
-		curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
+		curr_events = (int)part_stat_read_accum(disk->part0->bd_part, sectors) -
 			      atomic_read(&disk->sync_io);
 		/* sync IO will cause sync_io to increase before the disk_stats
 		 * as sync_io is counted when a request starts, and
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0b8d6009486643..1538b20ca4bd43 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -39,6 +39,7 @@
 
 struct bdev_inode {
 	struct block_device bdev;
+	struct hd_struct hd;
 	struct inode vfs_inode;
 };
 
@@ -885,6 +886,9 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		iput(inode);
 		return NULL;
 	}
+	bdev->bd_part = &BDEV_I(inode)->hd;
+	memset(bdev->bd_part, 0, sizeof(*bdev->bd_part));
+	bdev->bd_part->bdev = bdev;
 	return bdev;
 }
 
@@ -1275,15 +1279,10 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
 static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	int ret;
+	int ret = 0;
 
 	if (!bdev->bd_openers) {
 		if (!bdev_is_partition(bdev)) {
-			ret = -ENXIO;
-			bdev->bd_part = disk_get_part(disk, 0);
-			if (!bdev->bd_part)
-				goto out_clear;
-
 			ret = 0;
 			if (disk->fops->open)
 				ret = disk->fops->open(bdev, mode);
@@ -1302,7 +1301,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 
 			if (ret)
-				goto out_clear;
+				return ret;
 		} else {
 			struct block_device *whole = bdget_disk(disk, 0);
 
@@ -1311,16 +1310,14 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 			if (ret) {
 				mutex_unlock(&whole->bd_mutex);
 				bdput(whole);
-				goto out_clear;
+				return ret;
 			}
 			whole->bd_part_count++;
 			mutex_unlock(&whole->bd_mutex);
 
-			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
 			if (!bdev_nr_sectors(bdev)) {
 				__blkdev_put(whole, mode, 1);
-				ret = -ENXIO;
-				goto out_clear;
+				return -ENXIO;
 			}
 			set_init_blocksize(bdev);
 		}
@@ -1329,7 +1326,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 	} else {
 		if (!bdev_is_partition(bdev)) {
-			ret = 0;
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
 			/* the same as first opener case, read comment there */
@@ -1342,11 +1338,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 	}
 	bdev->bd_openers++;
 	return 0;
-
- out_clear:
-	disk_put_part(bdev->bd_part);
-	bdev->bd_part = NULL;
-	return ret;
 }
 
 static struct block_device *get_bdev_disk_and_module(dev_t dev)
@@ -1569,18 +1560,12 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 		sync_blockdev(bdev);
 		kill_bdev(bdev);
 		bdev_write_inode(bdev);
-
-		if (!bdev_is_partition(bdev) && disk->fops->release)
-			disk->fops->release(disk, mode);
-
-		disk_put_part(bdev->bd_part);
-		bdev->bd_part = NULL;
 		if (bdev_is_partition(bdev))
 			victim = bdev_whole(bdev);
-	} else {
-		if (!bdev_is_partition(bdev) && disk->fops->release)
-			disk->fops->release(disk, mode);
 	}
+
+	if (!bdev_is_partition(bdev) && disk->fops->release)
+		disk->fops->release(disk, mode);
 	mutex_unlock(&bdev->bd_mutex);
 	bdput(bdev);
 	if (victim)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 758cf71c9aa2a6..6edea5c1625909 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -59,7 +59,7 @@ struct block_device {
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
-	((_bdev)->bd_disk->part0.bdev)
+	((_bdev)->bd_disk->part0)
 
 #define bdev_kobj(_bdev) \
 	(&part_to_dev((_bdev)->bd_part)->kobj)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 08d00b526b0a3b..6e16c264439bdb 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -19,11 +19,12 @@
 #include <linux/blk_types.h>
 #include <asm/local.h>
 
-#define dev_to_disk(device)	container_of((device), struct gendisk, part0.__dev)
 #define dev_to_part(device)	container_of((device), struct hd_struct, __dev)
-#define disk_to_dev(disk)	(&(disk)->part0.__dev)
 #define part_to_dev(part)	(&((part)->__dev))
 
+#define dev_to_disk(device)	(dev_to_part(device)->bdev->bd_disk)
+#define disk_to_dev(disk)	(part_to_dev((disk)->part0->bd_part))
+
 extern const struct device_type disk_type;
 extern struct device_type part_type;
 extern struct class block_class;
@@ -51,12 +52,9 @@ struct partition_meta_info {
 };
 
 struct hd_struct {
-	struct percpu_ref ref;
-
 	struct block_device *bdev;
 	struct device __dev;
 	int partno;
-	struct rcu_work rcu_work;
 };
 
 /**
@@ -168,7 +166,7 @@ struct gendisk {
 	 * helpers.
 	 */
 	struct disk_part_tbl __rcu *part_tbl;
-	struct hd_struct part0;
+	struct block_device *part0;
 
 	const struct block_device_operations *fops;
 	struct request_queue *queue;
@@ -279,7 +277,7 @@ extern void set_disk_ro(struct gendisk *disk, int flag);
 
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0.bdev->bd_read_only;
+	return disk->part0->bd_read_only;
 }
 
 extern void disk_block_events(struct gendisk *disk);
@@ -303,7 +301,7 @@ static inline sector_t bdev_nr_sectors(struct block_device *bdev)
 
 static inline sector_t get_capacity(struct gendisk *disk)
 {
-	return bdev_nr_sectors(disk->part0.bdev);
+	return bdev_nr_sectors(disk->part0);
 }
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 87ad60106e1db0..680de036691ef9 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -59,8 +59,8 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
 	if ((part)->partno)						\
-		__part_stat_add(&part_to_disk((part))->part0,		\
-				field, addnd);				\
+		__part_stat_add(part_to_disk((part))->part0->bd_part,	\
+			field, addnd); \
 } while (0)
 
 #define part_stat_dec(part, field)					\
-- 
2.29.2

