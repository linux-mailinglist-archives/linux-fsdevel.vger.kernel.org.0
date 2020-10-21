Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC84294A3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 11:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437422AbgJUJNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 05:13:22 -0400
Received: from mx2.veeam.com ([64.129.123.6]:43086 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437310AbgJUJNW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:13:22 -0400
Received: from mail.veeam.com (spbmbx01.amust.local [172.17.17.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 6B6274140D;
        Wed, 21 Oct 2020 05:04:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1603271073; bh=JSi3Kq6ZGuJnAZO0zg7GP5rzMygIgXWjW7CqzrK5R5U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iHvCqXuKnESdUm7GeC8TEY8PP/iALPp47D/d1uCovL/5EihJX8QMl5IBP7gGWXxLG
         EMUCgBEPZ/YGO9HOicz3askXT/Hi1CyIRJ2JPBK8dJZAVQYKI2LLFrawHoNcLet/zy
         biE/KVTA7+Z64mN78x0hrAyQEsLZJWTqSN7lLIzY=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 spbmbx01.amust.local (172.17.17.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.595.3;
 Wed, 21 Oct 2020 12:04:29 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <hch@infradead.org>,
        <darrick.wong@oracle.com>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <len.brown@intel.com>, <pavel@ucw.cz>, <akpm@linux-foundation.org>,
        <johannes.thumshirn@wdc.com>, <ming.lei@redhat.com>,
        <jack@suse.cz>, <tj@kernel.org>, <gustavo@embeddedor.com>,
        <bvanassche@acm.org>, <osandov@fb.com>, <koct9i@gmail.com>,
        <damien.lemoal@wdc.com>, <steve@sk2.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mm@kvack.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH 1/2] Block layer filter - second version
Date:   Wed, 21 Oct 2020 12:04:08 +0300
Message-ID: <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: spbmbx01.amust.local (172.17.17.171) To
 spbmbx01.amust.local (172.17.17.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A295605D26A677562
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/Kconfig               |  11 ++
 block/Makefile              |   1 +
 block/blk-core.c            |  52 +++++--
 block/blk-filter-internal.h |  29 ++++
 block/blk-filter.c          | 286 ++++++++++++++++++++++++++++++++++++
 block/partitions/core.c     |  14 +-
 fs/block_dev.c              |   6 +-
 fs/direct-io.c              |   2 +-
 fs/iomap/direct-io.c        |   2 +-
 include/linux/bio.h         |   4 +-
 include/linux/blk-filter.h  |  76 ++++++++++
 include/linux/genhd.h       |   8 +-
 kernel/power/swap.c         |   2 +-
 mm/page_io.c                |   4 +-
 14 files changed, 471 insertions(+), 26 deletions(-)
 create mode 100644 block/blk-filter-internal.h
 create mode 100644 block/blk-filter.c
 create mode 100644 include/linux/blk-filter.h

diff --git a/block/Kconfig b/block/Kconfig
index bbad5e8bbffe..a308801b4376 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -204,6 +204,17 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_FILTER
+	bool "Enable support for block layer filters"
+	default y
+	depends on MODULES
+	help
+	  Enabling this lets third-party kernel modules intercept
+	  bio requests for any block device. This allows them to implement
+	  changed block tracking and snapshots without any reconfiguration of
+	  the existing setup. For example, this option allows snapshotting of
+	  a block device without adding it to LVM.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..b8ee50b8e031 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o blk-crypto.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
+obj-$(CONFIG_BLK_FILTER)	+= blk-filter.o
diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..cc06402af695 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1216,23 +1216,20 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 EXPORT_SYMBOL(submit_bio_noacct);
 
 /**
- * submit_bio - submit a bio to the block device layer for I/O
- * @bio: The &struct bio which describes the I/O
- *
- * submit_bio() is used to submit I/O requests to block devices.  It is passed a
- * fully set up &struct bio that describes the I/O that needs to be done.  The
- * bio will be send to the device described by the bi_disk and bi_partno fields.
+ * submit_bio_direct - submit a bio to the block device layer for I/O
+ * bypass filter.
+ * @bio:  The bio describing the location in memory and on the device.
  *
- * The success/failure status of the request, along with notification of
- * completion, is delivered asynchronously through the ->bi_end_io() callback
- * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
- * been called.
+ * Description:
+ *    This is a version of submit_bio() that shall only be used for I/O
+ *    that cannot be intercepted by block layer filters.
+ *    All file systems and other upper level users of the block layer
+ *    should use submit_bio() instead.
+ *    Use this function to access the swap partition and directly access
+ *    the block device file.
  */
-blk_qc_t submit_bio(struct bio *bio)
+blk_qc_t submit_bio_direct(struct bio *bio)
 {
-	if (blkcg_punt_bio_submit(bio))
-		return BLK_QC_T_NONE;
-
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
 	 * go through the normal accounting stuff before submission.
@@ -1282,8 +1279,35 @@ blk_qc_t submit_bio(struct bio *bio)
 
 	return submit_bio_noacct(bio);
 }
+EXPORT_SYMBOL(submit_bio_direct);
+
+/**
+ * submit_bio - submit a bio to the block device layer for I/O
+ * @bio: The &struct bio which describes the I/O
+ *
+ * submit_bio() is used to submit I/O requests to block devices.  It is passed a
+ * fully set up &struct bio that describes the I/O that needs to be done.  The
+ * bio will be send to the device described by the bi_disk and bi_partno fields.
+ *
+ * The success/failure status of the request, along with notification of
+ * completion, is delivered asynchronously through the ->bi_end_io() callback
+ * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
+ * been called.
+ */
+void submit_bio(struct bio *bio)
+{
+	if (blkcg_punt_bio_submit(bio))
+		return;
+
+#ifdef CONFIG_BLK_FILTER
+	blk_filter_submit_bio(bio);
+#else
+	submit_bio_direct(bio);
+#endif
+}
 EXPORT_SYMBOL(submit_bio);
 
+
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
  *                              for the new queue limits
diff --git a/block/blk-filter-internal.h b/block/blk-filter-internal.h
new file mode 100644
index 000000000000..d456a09f50db
--- /dev/null
+++ b/block/blk-filter-internal.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ *
+ * Block device filters internal declarations
+ */
+
+#ifndef BLK_FILTER_INTERNAL_H
+#define BLK_FILTER_INTERNAL_H
+
+#ifdef CONFIG_BLK_FILTER
+#include <linux/blk-filter.h>
+
+void blk_filter_part_add(struct hd_struct *part, dev_t devt);
+
+void blk_filter_part_del(struct hd_struct *part);
+
+#else /* CONFIG_BLK_FILTER */
+
+
+static inline void blk_filter_part_add(struct hd_struct *part, dev_t devt)
+{ };
+
+static inline void blk_filter_part_del(struct hd_struct *part)
+{ };
+
+#endif /* CONFIG_BLK_FILTER */
+
+#endif
diff --git a/block/blk-filter.c b/block/blk-filter.c
new file mode 100644
index 000000000000..f6de16c45a16
--- /dev/null
+++ b/block/blk-filter.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/genhd.h>
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include "blk-filter-internal.h"
+#include <linux/rwsem.h>
+
+
+LIST_HEAD(filters);
+DECLARE_RWSEM(filters_lock);
+
+static void blk_filter_release(struct kref *kref)
+{
+	struct blk_filter *flt = container_of(kref, struct blk_filter, kref);
+
+	kfree(flt);
+}
+
+static inline void blk_filter_get(struct blk_filter *flt)
+{
+	kref_get(&flt->kref);
+}
+
+static inline void blk_filter_put(struct blk_filter *flt)
+{
+	kref_put(&flt->kref, blk_filter_release);
+}
+
+
+/**
+ * blk_filter_part_add() - Notify filters when a new partition is added.
+ * @part: The partition for new block device.
+ * @devt: Device id for new block device.
+ *
+ * Description:
+ *    When the block device is appears in the system, call the filter
+ *    callback to notify that the block device appears.
+ */
+void blk_filter_part_add(struct hd_struct *part, dev_t devt)
+{
+	down_read(&filters_lock);
+	if (!list_empty(&filters)) {
+		struct list_head *_list_head;
+
+		list_for_each(_list_head, &filters) {
+			void *filter_data;
+			bool attached = false;
+			struct blk_filter *flt;
+
+			flt = list_entry(_list_head, struct blk_filter, link);
+
+			attached = flt->ops->part_add(devt, &filter_data);
+			if (attached) {
+				blk_filter_get(flt);
+				part->filter = flt;
+				part->filter_data = filter_data;
+				break;
+			}
+		}
+	}
+	up_read(&filters_lock);
+}
+
+/**
+ * blk_filter_part_del() - Notify filters when the partition is deleted.
+ * @part: The partition of block device.
+ *
+ * Description:
+ *    When the block device is destroying and the partition is releasing,
+ *    call the filter callback to notify that the block device will be
+ *    deleted.
+ */
+void blk_filter_part_del(struct hd_struct *part)
+{
+	struct blk_filter *flt = part->filter;
+
+	if (!flt)
+		return;
+
+	flt->ops->part_del(part->filter_data);
+
+	part->filter_data = NULL;
+	part->filter = NULL;
+	blk_filter_put(flt);
+}
+
+
+/**
+ * blk_filter_submit_bio() - Send new bio to filters for processing.
+ * @bio: The new bio for block I/O layer.
+ *
+ * Description:
+ *    This function is an implementation of block layer filter
+ *    interception. If the filter is attached to this block device,
+ *    then bio will be redirected to the filter kernel module.
+ */
+void blk_filter_submit_bio(struct bio *bio)
+{
+	bool intercepted = false;
+	struct hd_struct *part;
+
+	bio_get(bio);
+
+	part = disk_get_part(bio->bi_disk, bio->bi_partno);
+	if (unlikely(!part)) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+
+		bio_put(bio);
+		return;
+	}
+
+	down_read(&part->filter_rw_lockup);
+
+	if (part->filter)
+		intercepted = part->filter->ops->filter_bio(bio, part->filter_data);
+
+	up_read(&part->filter_rw_lockup);
+
+	if (!intercepted)
+		submit_bio_direct(bio);
+
+	disk_put_part(part);
+
+	bio_put(bio);
+}
+EXPORT_SYMBOL(blk_filter_submit_bio);
+
+/**
+ * blk_filter_register() - Register block layer filter.
+ * @ops: New filter callbacks.
+ *
+ * Return:
+ *     Filter ID, a pointer to the service structure of the filter.
+ *
+ * Description:
+ *    Create new filter structure.
+ *    Use blk_filter_attach to attach devices to filter.
+ */
+void *blk_filter_register(struct blk_filter_ops *ops)
+{
+	struct blk_filter *flt;
+
+	flt = kzalloc(sizeof(struct blk_filter), GFP_KERNEL);
+	if (!flt)
+		return NULL;
+
+	kref_init(&flt->kref);
+	flt->ops = ops;
+
+	down_write(&filters_lock);
+	list_add_tail(&flt->link, &filters);
+	up_write(&filters_lock);
+
+	return flt;
+}
+EXPORT_SYMBOL(blk_filter_register);
+
+/**
+ * blk_filter_unregister() - Unregister block layer filter.
+ * @filter: filter identifier.
+ *
+ * Description:
+ *    Before call blk_filter_unregister() and unload filter module all
+ *    partitions MUST be detached. Otherwise, the system will have a
+ *    filter with non-existent interception functions.
+ */
+void blk_filter_unregister(void *filter)
+{
+	struct blk_filter *flt = filter;
+
+	down_write(&filters_lock);
+	list_del(&flt->link);
+	up_write(&filters_lock);
+
+	blk_filter_put(flt);
+}
+EXPORT_SYMBOL(blk_filter_unregister);
+
+/**
+ * blk_filter_attach() - Attach block layer filter.
+ * @devt: The block device identification number.
+ * @filter: Filter identifier.
+ * @filter_data: Specific filters data for this device.
+ *
+ * Return:
+ *    Return code.
+ *    -ENODEV - cannot find this device, it is OK if the device does not exist yet.
+ *    -EALREADY - this device is already attached to this filter.
+ *    -EBUSY - this device is already attached to the another filter.
+ *
+ * Description:
+ *    Attach the device to the block layer filter.
+ *    Only one filter can be attached to a single device.
+ */
+int blk_filter_attach(dev_t devt, void *filter, void *filter_data)
+{
+	int ret = 0;
+	struct blk_filter *flt = filter;
+	struct block_device *blk_dev;
+
+
+	blk_dev = bdget(devt);
+	if (!blk_dev)
+		return -ENODEV;
+
+	blk_filter_freeze(blk_dev);
+
+	if (blk_dev->bd_part->filter) {
+		if (blk_dev->bd_part->filter == flt)
+			ret = -EALREADY;
+		else
+			ret = -EBUSY;
+	} else {
+		blk_filter_get(flt);
+		blk_dev->bd_part->filter = flt;
+		blk_dev->bd_part->filter_data = filter_data;
+	}
+
+	blk_filter_thaw(blk_dev);
+
+	bdput(blk_dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(blk_filter_attach);
+
+/**
+ * blk_filter_detach() - Detach block layer filter.
+ * @devt: The block device identification number.
+ *
+ * Description:
+ *    Detach the device from the block layer filter.
+ *    Do not forget detach all devices before calling the
+ *    blk_filter_unregister() function and unload the module!
+ */
+void blk_filter_detach(dev_t devt)
+{
+	struct blk_filter *flt;
+	struct block_device *blk_dev;
+
+	blk_dev = bdget(devt);
+	if (!blk_dev)
+		return;
+
+	blk_filter_freeze(blk_dev);
+
+	flt = blk_dev->bd_part->filter;
+	if (flt) {
+		blk_dev->bd_part->filter_data = NULL;
+		blk_dev->bd_part->filter = NULL;
+		blk_filter_put(flt);
+	}
+
+	blk_filter_thaw(blk_dev);
+
+	bdput(blk_dev);
+}
+EXPORT_SYMBOL(blk_filter_detach);
+
+/**
+ * blk_filter_freeze() - Lock bio submitting.
+ * @bdev: The block device pointer.
+ *
+ * Description:
+ *    Stop bio processing.
+ */
+void blk_filter_freeze(struct block_device *bdev)
+{
+	down_write(&bdev->bd_part->filter_rw_lockup);
+}
+EXPORT_SYMBOL(blk_filter_freeze);
+
+/**
+ * blk_filter_thaw() - Unlock bio submitting.
+ * @bdev: The block device pointer.
+ *
+ * Description:
+ *    Resume bio processing.
+ */
+void blk_filter_thaw(struct block_device *bdev)
+{
+	up_write(&bdev->bd_part->filter_rw_lockup);
+}
+EXPORT_SYMBOL(blk_filter_thaw);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 722406b841df..6b845e98b9a1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -11,6 +11,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
 #include "check.h"
+#include "../blk-filter-internal.h"
 
 static int (*check_part[])(struct parsed_partitions *) = {
 	/*
@@ -320,9 +321,11 @@ int hd_ref_init(struct hd_struct *part)
  */
 void delete_partition(struct gendisk *disk, struct hd_struct *part)
 {
-	struct disk_part_tbl *ptbl =
-		rcu_dereference_protected(disk->part_tbl, 1);
+	struct disk_part_tbl *ptbl;
+
+	blk_filter_part_del(part);
 
+	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
 	/*
 	 * ->part_tbl is referenced in this part's release handler, so
 	 *  we have to hold the disk device
@@ -412,6 +415,9 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	p->nr_sects = len;
 	p->partno = partno;
 	p->policy = get_disk_ro(disk);
+#ifdef CONFIG_BLK_FILTER
+	init_rwsem(&p->filter_rw_lockup);
+#endif
 
 	if (info) {
 		struct partition_meta_info *pinfo;
@@ -469,6 +475,9 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	/* everything is up and running, commence */
 	rcu_assign_pointer(ptbl->part[partno], p);
 
+	/*inform filter about a new partition*/
+	blk_filter_part_add(p, devt);
+
 	/* suppress uevent if the disk suppresses it */
 	if (!dev_get_uevent_suppress(ddev))
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
@@ -552,6 +561,7 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 		goto out_unlock;
 
 	sync_blockdev(bdevp);
+
 	invalidate_bdev(bdevp);
 
 	delete_partition(bdev->bd_disk, part);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8ae833e00443..431eae17fd8f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -237,7 +237,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(&bio, iocb);
 
-	qc = submit_bio(&bio);
+	qc = submit_bio_direct(&bio);
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio.bi_private))
@@ -400,7 +400,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				polled = true;
 			}
 
-			qc = submit_bio(bio);
+			qc = submit_bio_direct(bio);
 
 			if (polled)
 				WRITE_ONCE(iocb->ki_cookie, qc);
@@ -421,7 +421,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			atomic_inc(&dio->ref);
 		}
 
-		submit_bio(bio);
+		submit_bio_direct(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 183299892465..d9bb1b6f6814 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -459,7 +459,7 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 		sdio->submit_io(bio, dio->inode, sdio->logical_offset_in_bio);
 		dio->bio_cookie = BLK_QC_T_NONE;
 	} else
-		dio->bio_cookie = submit_bio(bio);
+		dio->bio_cookie = submit_bio_direct(bio);
 
 	sdio->bio = NULL;
 	sdio->boundary = 0;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..e05f20ce8b5f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -73,7 +73,7 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 				file_inode(dio->iocb->ki_filp),
 				iomap, bio, pos);
 	else
-		dio->submit.cookie = submit_bio(bio);
+		dio->submit.cookie = submit_bio_direct(bio);
 }
 
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..5b0a32697207 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -10,6 +10,7 @@
 #include <linux/ioprio.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
+#include <linux/blk-filter.h>
 
 #define BIO_DEBUG
 
@@ -411,7 +412,8 @@ static inline struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned int nr_iovecs)
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, NULL);
 }
 
-extern blk_qc_t submit_bio(struct bio *);
+extern blk_qc_t submit_bio_direct(struct bio *bio);
+extern void submit_bio(struct bio *bio);
 
 extern void bio_endio(struct bio *);
 
diff --git a/include/linux/blk-filter.h b/include/linux/blk-filter.h
new file mode 100644
index 000000000000..f3e79e5b4586
--- /dev/null
+++ b/include/linux/blk-filter.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * API declarations for kernel modules utilizing block device filters
+ */
+
+#ifndef BLK_FILTER_H
+#define BLK_FILTER_H
+
+#ifdef CONFIG_BLK_FILTER
+#include <linux/kref.h>
+
+struct blk_filter_ops {
+	/*
+	 * Intercept bio callback.
+	 *
+	 * Returns true if the request was intercepted and placed in the
+	 * queue for processing. Otherwise submit_bio_direct() calling
+	 * needed.
+	 */
+	bool (*filter_bio)(struct bio *bio, void *filter_data);
+
+	/*
+	 * Callback to a request to add block device to the filter.
+	 *
+	 * Returns true if the block device will be filtered.
+	 * p_filter_data gets a pointer to data that is unique to
+	 * this device.
+	 */
+	bool (*part_add)(dev_t devt, void **p_filter_data);
+
+	/*
+	 * Callback to remove block device from the filter.
+	 */
+	void (*part_del)(void *filter_data);
+};
+
+struct blk_filter {
+	struct list_head link;
+	struct kref kref;
+	struct blk_filter_ops *ops;
+};
+
+/*
+ * Register/unregister device to filter
+ */
+void *blk_filter_register(struct blk_filter_ops *ops);
+
+void blk_filter_unregister(void *filter);
+
+/*
+ * Attach/detach device to filter
+ */
+int blk_filter_attach(dev_t devt, void *filter, void *filter_data);
+
+void blk_filter_detach(dev_t devt);
+
+/*
+ * For a consistent state of the file system use the freeze_bdev/thaw_bdav.
+ * But in addition, to ensure that the filter is not in the state of
+ * intercepting the next BIO, you need to call black_filter_freeze/blk_filter_thaw.
+ * This is especially actual if there is no file system on the disk.
+ */
+
+void blk_filter_freeze(struct block_device *bdev);
+
+void blk_filter_thaw(struct block_device *bdev);
+
+/*
+ * Filters intercept function
+ */
+void blk_filter_submit_bio(struct bio *bio);
+
+#endif /* CONFIG_BLK_FILTER */
+
+#endif
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4ab853461dff..514fab6b947e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -4,7 +4,7 @@
 
 /*
  * 	genhd.h Copyright (C) 1992 Drew Eckhardt
- *	Generic hard disk header file by  
+ *	Generic hard disk header file by
  * 		Drew Eckhardt
  *
  *		<drew@colorado.edu>
@@ -75,6 +75,12 @@ struct hd_struct {
 	int make_it_fail;
 #endif
 	struct rcu_work rcu_work;
+
+#ifdef CONFIG_BLK_FILTER
+	struct rw_semaphore filter_rw_lockup; /* for freezing block device*/
+	struct blk_filter *filter; /* block layer filter*/
+	void *filter_data; /*specific for each block device filters data*/
+#endif
 };
 
 /**
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 01e2858b5fe3..5287346b87a1 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -283,7 +283,7 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
 		bio->bi_end_io = hib_end_io;
 		bio->bi_private = hb;
 		atomic_inc(&hb->count);
-		submit_bio(bio);
+		submit_bio_direct(bio);
 	} else {
 		error = submit_bio_wait(bio);
 		bio_put(bio);
diff --git a/mm/page_io.c b/mm/page_io.c
index e485a6e8a6cd..4540426400b3 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -362,7 +362,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-	submit_bio(bio);
+	submit_bio_direct(bio);
 out:
 	return ret;
 }
@@ -434,7 +434,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 	count_vm_event(PSWPIN);
 	bio_get(bio);
-	qc = submit_bio(bio);
+	qc = submit_bio_direct(bio);
 	while (synchronous) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio->bi_private))
-- 
2.20.1

