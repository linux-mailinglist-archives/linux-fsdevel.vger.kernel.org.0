Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8987B16FD08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBZLLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:11:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728047AbgBZLLw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:11:52 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 870352894852E0BADC16;
        Wed, 26 Feb 2020 19:11:45 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 19:11:40 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>
Subject: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Date:   Wed, 26 Feb 2020 19:18:47 +0800
Message-ID: <20200226111851.55348-4-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20200226111851.55348-1-yuyufen@huawei.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We reported a kernel crash:

[201962.639350] Call trace:
[201962.644403]  string+0x28/0xa0
[201962.650501]  vsnprintf+0x5f0/0x748
[201962.657472]  seq_vprintf+0x70/0x98
[201962.664442]  seq_printf+0x7c/0xa0
[201962.671238]  __blkg_prfill_rwstat+0x84/0x128
[201962.679949]  blkg_prfill_rwstat_field+0x94/0xc0
[201962.689182]  blkcg_print_blkgs+0xcc/0x140
[201962.697370]  blkg_print_stat_bytes+0x4c/0x60
[201962.706083]  cgroup_seqfile_show+0x58/0xc0
[201962.714446]  kernfs_seq_show+0x44/0x50
[201962.722112]  seq_read+0xd4/0x4a8
[201962.728732]  kernfs_fop_read+0x16c/0x218
[201962.736748]  __vfs_read+0x60/0x188
[201962.743717]  vfs_read+0x94/0x150
[201962.750338]  ksys_read+0x6c/0xd8
[201962.756958]  __arm64_sys_read+0x24/0x30
[201962.764800]  el0_svc_common+0x78/0x130
[201962.772466]  el0_svc_handler+0x38/0x78
[201962.780131]  el0_svc+0x8/0xc

__blkg_prfill_rwstat() tries to get the device name by 'bdi->dev',
while the device and kobj->name has been freed by bdi_unregister().
Then, blkg_dev_name() will return an invalid name pointer, resulting
in crash on string(). The race as following:

CPU1                          CPU2
blkg_print_stat_bytes
                              __scsi_remove_device
                              del_gendisk
                                bdi_unregister

                                put_device(bdi->dev)
                                  kfree(bdi->dev)
__blkg_prfill_rwstat
  blkg_dev_name
    //use the freed bdi->dev
    dev_name(blkg->q->backing_dev_info->dev)
                                bdi->dev = NULL

We fix the bug by protecting the device lifetime with RCU.
call_rcu() will free the device until all of the readers complete.

Since both of blkg_dev_name() and device name have been protected
by rcu_read_lock/unlock(). Thus, we don't need to do it again.
Just use rcu_dereference() to fetch rcu_dev here.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/bfq-iosched.c              |  2 +-
 block/blk-cgroup.c               |  8 ++++--
 block/genhd.c                    |  4 +--
 fs/ext4/super.c                  |  2 +-
 include/linux/backing-dev-defs.h |  8 +++++-
 include/linux/backing-dev.h      |  4 +--
 mm/backing-dev.c                 | 59 +++++++++++++++++++++++++++++++++-------
 7 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8c436abfaf14..00904611b8e4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4978,7 +4978,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	switch (ioprio_class) {
 	default:
-		dev_err(bfqq->bfqd->queue->backing_dev_info->dev,
+		dev_err(&bfqq->bfqd->queue->backing_dev_info->rcu_dev->dev,
 			"bfq: bad prio class %d\n", ioprio_class);
 		/* fall through */
 	case IOPRIO_CLASS_NONE:
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a229b94d5390..7ab1af3925c5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -494,9 +494,13 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 
 const char *blkg_dev_name(struct blkcg_gq *blkg)
 {
+	struct bdi_rcu_device *rcu_dev;
+
+	rcu_dev = rcu_dereference(blkg->q->backing_dev_info->rcu_dev);
+
 	/* some drivers (floppy) instantiate a queue w/o disk registered */
-	if (blkg->q->backing_dev_info->dev)
-		return dev_name(blkg->q->backing_dev_info->dev);
+	if (rcu_dev)
+		return dev_name(&rcu_dev->dev);
 	return NULL;
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..bd406b0fb471 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -668,9 +668,9 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
 	disk_part_iter_exit(&piter);
 
-	if (disk->queue->backing_dev_info->dev) {
+	if (disk->queue->backing_dev_info->rcu_dev) {
 		err = sysfs_create_link(&ddev->kobj,
-			  &disk->queue->backing_dev_info->dev->kobj,
+			  &disk->queue->backing_dev_info->rcu_dev->dev.kobj,
 			  "bdi");
 		WARN_ON(err);
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ff1b764b0c0e..7781773f9f77 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -388,7 +388,7 @@ static int block_device_ejected(struct super_block *sb)
 	struct inode *bd_inode = sb->s_bdev->bd_inode;
 	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
 
-	return bdi->dev == NULL;
+	return bdi->rcu_dev == NULL;
 }
 
 static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 4fc87dee005a..3d2294c428c1 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -13,6 +13,7 @@
 #include <linux/workqueue.h>
 #include <linux/kref.h>
 #include <linux/refcount.h>
+#include <linux/device.h>
 
 struct page;
 struct device;
@@ -185,6 +186,11 @@ struct bdi_writeback {
 #endif
 };
 
+struct bdi_rcu_device {
+	struct device dev;
+	struct rcu_head rcu_head;
+};
+
 struct backing_dev_info {
 	u64 id;
 	struct rb_node rb_node; /* keyed by ->id */
@@ -219,7 +225,7 @@ struct backing_dev_info {
 #endif
 	wait_queue_head_t wb_waitq;
 
-	struct device *dev;
+	struct bdi_rcu_device *rcu_dev;
 	struct device *owner;
 
 	struct timer_list laptop_mode_wb_timer;
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index f88197c1ffc2..67e429b203a1 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -509,9 +509,9 @@ extern const char *bdi_unknown_name;
 
 static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
 {
-	if (!bdi || !bdi->dev)
+	if (!bdi || !bdi->rcu_dev)
 		return bdi_unknown_name;
-	return dev_name(bdi->dev);
+	return dev_name(&bdi->rcu_dev->dev);
 }
 
 #endif	/* _LINUX_BACKING_DEV_H */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 62f05f605fb5..b29c0ad43477 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -850,7 +850,7 @@ static int bdi_init(struct backing_dev_info *bdi)
 {
 	int ret;
 
-	bdi->dev = NULL;
+	bdi->rcu_dev = NULL;
 
 	kref_init(&bdi->refcnt);
 	bdi->min_ratio = 0;
@@ -930,20 +930,44 @@ struct backing_dev_info *bdi_get_by_id(u64 id)
 	return bdi;
 }
 
+static void bdi_device_release(struct device *dev)
+{
+	struct bdi_rcu_device *rcu_dev = container_of(dev,
+			struct bdi_rcu_device, dev);
+	kfree(rcu_dev);
+}
+
 int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 {
 	struct device *dev;
 	struct rb_node *parent, **p;
+	struct bdi_rcu_device *rcu_dev;
+	int retval = -ENODEV;
 
-	if (bdi->dev)	/* The driver needs to use separate queues per device */
+	/* The driver needs to use separate queues per device */
+	if (bdi->rcu_dev)
 		return 0;
 
-	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
-	if (IS_ERR(dev))
-		return PTR_ERR(dev);
+	rcu_dev = kzalloc(sizeof(struct bdi_rcu_device), GFP_KERNEL);
+	if (!rcu_dev)
+		return -ENOMEM;
+
+	/* initialize device */
+	dev = &rcu_dev->dev;
+	device_initialize(dev);
+	dev->class = bdi_class;
+	dev->release = bdi_device_release;
+	dev_set_drvdata(dev, (void *)bdi);
+	retval = kobject_set_name_vargs(&dev->kobj, fmt, args);
+	if (retval)
+		goto error;
+
+	retval = device_add(dev);
+	if (retval)
+		goto error;
 
 	cgwb_bdi_register(bdi);
-	bdi->dev = dev;
+	bdi->rcu_dev = rcu_dev;
 
 	bdi_debug_register(bdi, dev_name(dev));
 	set_bit(WB_registered, &bdi->wb.state);
@@ -962,6 +986,10 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 
 	trace_writeback_bdi_register(bdi);
 	return 0;
+
+error:
+	put_device(&rcu_dev->dev);
+	return retval;
 }
 EXPORT_SYMBOL(bdi_register_va);
 
@@ -1005,17 +1033,28 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 	synchronize_rcu_expedited();
 }
 
+static void bdi_put_device_rcu(struct rcu_head *rcu)
+{
+	struct bdi_rcu_device *rcu_dev = container_of(rcu,
+			struct bdi_rcu_device, rcu_head);
+	put_device(&rcu_dev->dev);
+}
+
 void bdi_unregister(struct backing_dev_info *bdi)
 {
+	struct bdi_rcu_device *rcu_dev = bdi->rcu_dev;
+
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
 	cgwb_bdi_unregister(bdi);
 
-	if (bdi->dev) {
+	if (rcu_dev) {
 		bdi_debug_unregister(bdi);
-		device_unregister(bdi->dev);
-		bdi->dev = NULL;
+		get_device(&rcu_dev->dev);
+		device_unregister(&rcu_dev->dev);
+		rcu_assign_pointer(bdi->rcu_dev, NULL);
+		call_rcu(&rcu_dev->rcu_head, bdi_put_device_rcu);
 	}
 
 	if (bdi->owner) {
@@ -1031,7 +1070,7 @@ static void release_bdi(struct kref *ref)
 
 	if (test_bit(WB_registered, &bdi->wb.state))
 		bdi_unregister(bdi);
-	WARN_ON_ONCE(bdi->dev);
+	WARN_ON_ONCE(bdi->rcu_dev);
 	wb_exit(&bdi->wb);
 	cgwb_bdi_exit(bdi);
 	kfree(bdi);
-- 
2.16.2.dirty

