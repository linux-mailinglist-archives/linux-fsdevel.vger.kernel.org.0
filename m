Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F306D7FDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjDEOpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbjDEOpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:45:17 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D343C0E;
        Wed,  5 Apr 2023 07:45:07 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 3E9BF4125C;
        Tue,  4 Apr 2023 10:09:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1680617359;
        bh=bQ9B/XP0SHQuNkNS06/UEVIyFwRCvUAGo366qln/h5E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dzr4b5n8pYMRf/AyAiYEipIpjzxO21TnCW7lSVBoU9SBY5gkQ+bwq64Fw35s/8WJN
         wR97WzmBJRH3puwGmUDIQolubm9N5giAl60C7EwdBwNNP/RwA7jExqkWDDwnbX0sAt
         ghOZ8PT9Mk61FQgiqonPY5X3eSGEnexbQ2DhldNc9MVPyA8/PcmxtqNJKEZGC5006+
         jnhMqgjnLKgCTWCxPHCF0FIQEGQJV0HBdcf/6XC6sdfuJv4UkoGP9FnaGRVJDvnZTY
         UFQl/3WKwTuDOxxX6E/OZMHPhs82zsFcOIONv5hniLMAZ2ghiqrYKaQcol9xiREpT4
         3vCAsCIahQrkQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Apr 2023 16:09:13 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v3 10/11] blksnap: snapshot and snapshot image block device
Date:   Tue, 4 Apr 2023 16:08:34 +0200
Message-ID: <20230404140835.25166-11-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230404140835.25166-1-sergei.shtepa@veeam.com>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554657367
X-Veeam-MMEX: True
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The struck snapshot combines block devices, for which a snapshot is
created, block devices of their snapshot images, as well as a difference
storage.
There may be several snapshots at the same time, but they should not
contain common block devices. This can be used for cases when backup is
scheduled once an hour for some block devices, and once a day for
others, and once a week for others. In this case, it is possible that
three snapshots are used at the same time.
Snapshot images of block devices provides the read and write operations.
They redirect I/O units to the original block device or to differential
storage devices.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/snapimage.c | 120 +++++++++
 drivers/block/blksnap/snapimage.h |  10 +
 drivers/block/blksnap/snapshot.c  | 433 ++++++++++++++++++++++++++++++
 drivers/block/blksnap/snapshot.h  |  68 +++++
 4 files changed, 631 insertions(+)
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h
 create mode 100644 drivers/block/blksnap/snapshot.c
 create mode 100644 drivers/block/blksnap/snapshot.h

diff --git a/drivers/block/blksnap/snapimage.c b/drivers/block/blksnap/snapimage.c
new file mode 100644
index 000000000000..328abb376780
--- /dev/null
+++ b/drivers/block/blksnap/snapimage.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+/*
+ * Present the snapshot image as a block device.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME "-image: " fmt
+#include <linux/slab.h>
+#include <linux/cdrom.h>
+#include <linux/blk-mq.h>
+#include <linux/build_bug.h>
+#include <uapi/linux/blksnap.h>
+#include "snapimage.h"
+#include "tracker.h"
+#include "diff_area.h"
+#include "chunk.h"
+#include "cbt_map.h"
+
+/*
+ * The snapshot supports write operations.  This allows for example to delete
+ * some files from the file system before backing up the volume. The data can
+ * be stored only in the difference storage. Therefore, before partially
+ * overwriting this data, it should be read from the original block device.
+ */
+static void snapimage_submit_bio(struct bio *bio)
+{
+	struct tracker *tracker = bio->bi_bdev->bd_disk->private_data;
+	struct diff_area *diff_area = tracker->diff_area;
+
+	if (diff_area_is_corrupted(diff_area)) {
+		bio_io_error(bio);
+		return;
+	}
+
+	/*
+	 * The change tracking table should represent that the snapshot data
+	 * has been changed.
+	 */
+	if (op_is_write(bio_op(bio)))
+		cbt_map_set_both(tracker->cbt_map, bio->bi_iter.bi_sector,
+				 bio_sectors(bio));
+
+	while (bio->bi_iter.bi_size) {
+		if (!diff_area_submit_chunk(diff_area, bio)) {
+			bio_io_error(bio);
+			return;
+		}
+	}
+	bio_endio(bio);
+}
+
+const struct block_device_operations bd_ops = {
+	.owner = THIS_MODULE,
+	.submit_bio = snapimage_submit_bio,
+};
+
+void snapimage_free(struct tracker *tracker)
+{
+	struct gendisk *disk = tracker->snap_disk;
+
+	if (!disk)
+		return;
+
+	pr_debug("Snapshot image disk %s delete\n", disk->disk_name);
+	del_gendisk(disk);
+	put_disk(disk);
+
+	tracker->snap_disk = NULL;
+}
+
+int snapimage_create(struct tracker *tracker)
+{
+	int ret = 0;
+	dev_t dev_id = tracker->dev_id;
+	struct gendisk *disk;
+
+	pr_info("Create snapshot image device for original device [%u:%u]\n",
+		MAJOR(dev_id), MINOR(dev_id));
+
+	disk = blk_alloc_disk(NUMA_NO_NODE);
+	if (!disk) {
+		pr_err("Failed to allocate disk\n");
+		return -ENOMEM;
+	}
+
+	disk->flags = GENHD_FL_NO_PART;
+	disk->fops = &bd_ops;
+	disk->private_data = tracker;
+	set_capacity(disk, tracker->cbt_map->device_capacity);
+	ret = snprintf(disk->disk_name, DISK_NAME_LEN, "%s_%d:%d",
+		       BLKSNAP_IMAGE_NAME, MAJOR(dev_id), MINOR(dev_id));
+	if (ret < 0) {
+		pr_err("Unable to set disk name for snapshot image device: invalid device id [%d:%d]\n",
+		       MAJOR(dev_id), MINOR(dev_id));
+		ret = -EINVAL;
+		goto fail_cleanup_disk;
+	}
+	pr_debug("Snapshot image disk name [%s]\n", disk->disk_name);
+
+	blk_queue_physical_block_size(disk->queue,
+					tracker->diff_area->physical_blksz);
+	blk_queue_logical_block_size(disk->queue,
+					tracker->diff_area->logical_blksz);
+
+	ret = add_disk(disk);
+	if (ret) {
+		pr_err("Failed to add disk [%s] for snapshot image device\n",
+		       disk->disk_name);
+		goto fail_cleanup_disk;
+	}
+	tracker->snap_disk = disk;
+
+	pr_debug("Image block device [%d:%d] has been created\n",
+		disk->major, disk->first_minor);
+
+	return 0;
+
+fail_cleanup_disk:
+	put_disk(disk);
+	return ret;
+}
diff --git a/drivers/block/blksnap/snapimage.h b/drivers/block/blksnap/snapimage.h
new file mode 100644
index 000000000000..cb2df7019eb8
--- /dev/null
+++ b/drivers/block/blksnap/snapimage.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_SNAPIMAGE_H
+#define __BLKSNAP_SNAPIMAGE_H
+
+struct tracker;
+
+void snapimage_free(struct tracker *tracker);
+int snapimage_create(struct tracker *tracker);
+#endif /* __BLKSNAP_SNAPIMAGE_H */
diff --git a/drivers/block/blksnap/snapshot.c b/drivers/block/blksnap/snapshot.c
new file mode 100644
index 000000000000..2f2108bb23b6
--- /dev/null
+++ b/drivers/block/blksnap/snapshot.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-snapshot: " fmt
+
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+#include <linux/build_bug.h>
+#include <uapi/linux/blksnap.h>
+#include "snapshot.h"
+#include "tracker.h"
+#include "diff_storage.h"
+#include "diff_area.h"
+#include "snapimage.h"
+#include "cbt_map.h"
+
+LIST_HEAD(snapshots);
+DECLARE_RWSEM(snapshots_lock);
+
+static void snapshot_free(struct kref *kref)
+{
+	struct snapshot *snapshot = container_of(kref, struct snapshot, kref);
+
+	pr_info("Release snapshot %pUb\n", &snapshot->id);
+
+
+	while (!list_empty(&snapshot->trackers)) {
+		struct tracker *tracker;
+
+		tracker = list_first_entry(&snapshot->trackers, struct tracker,
+					   link);
+		list_del(&tracker->link);
+		tracker_release_snapshot(tracker);
+		tracker_put(tracker);
+	}
+
+	diff_storage_put(snapshot->diff_storage);
+	snapshot->diff_storage = NULL;
+
+	kfree(snapshot);
+}
+
+static inline void snapshot_get(struct snapshot *snapshot)
+{
+	kref_get(&snapshot->kref);
+};
+static inline void snapshot_put(struct snapshot *snapshot)
+{
+	if (likely(snapshot))
+		kref_put(&snapshot->kref, snapshot_free);
+};
+
+static struct snapshot *snapshot_new(void)
+{
+	int ret;
+	struct snapshot *snapshot = NULL;
+
+	snapshot = kzalloc(sizeof(struct snapshot), GFP_KERNEL);
+	if (!snapshot)
+		return ERR_PTR(-ENOMEM);
+
+	snapshot->diff_storage = diff_storage_new();
+	if (!snapshot->diff_storage) {
+		ret = -ENOMEM;
+		goto fail_free_snapshot;
+	}
+
+	INIT_LIST_HEAD(&snapshot->link);
+	kref_init(&snapshot->kref);
+	uuid_gen(&snapshot->id);
+	init_rwsem(&snapshot->rw_lock);
+	snapshot->is_taken = false;
+	INIT_LIST_HEAD(&snapshot->trackers);
+
+	return snapshot;
+
+fail_free_snapshot:
+	kfree(snapshot);
+
+	return ERR_PTR(ret);
+}
+
+void __exit snapshot_done(void)
+{
+	struct snapshot *snapshot;
+
+	pr_debug("Cleanup snapshots\n");
+	do {
+		down_write(&snapshots_lock);
+		snapshot = list_first_entry_or_null(&snapshots, struct snapshot,
+						    link);
+		if (snapshot)
+			list_del(&snapshot->link);
+		up_write(&snapshots_lock);
+
+		snapshot_put(snapshot);
+	} while (snapshot);
+}
+
+
+int snapshot_create(uuid_t *id)
+{
+	struct snapshot *snapshot = NULL;
+
+	snapshot = snapshot_new();
+	if (IS_ERR(snapshot)) {
+		pr_err("Unable to create snapshot: failed to allocate snapshot structure\n");
+		return PTR_ERR(snapshot);
+	}
+
+	uuid_copy(id, &snapshot->id);
+
+	down_write(&snapshots_lock);
+	list_add_tail(&snapshot->link, &snapshots);
+	up_write(&snapshots_lock);
+
+	pr_info("Snapshot %pUb was created\n", id);
+	return 0;
+}
+
+static struct snapshot *snapshot_get_by_id(const uuid_t *id)
+{
+	struct snapshot *snapshot = NULL;
+	struct snapshot *s;
+
+	down_read(&snapshots_lock);
+	if (list_empty(&snapshots))
+		goto out;
+
+	list_for_each_entry(s, &snapshots, link) {
+		if (uuid_equal(&s->id, id)) {
+			snapshot = s;
+			snapshot_get(snapshot);
+			break;
+		}
+	}
+out:
+	up_read(&snapshots_lock);
+	return snapshot;
+}
+
+int snapshot_add_device(const uuid_t *id, struct tracker *tracker)
+{
+	int ret = 0;
+	struct snapshot *snapshot = NULL;
+
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return -ESRCH;
+
+	down_write(&snapshot->rw_lock);
+	if (!list_empty(&snapshot->trackers)) {
+		struct tracker *tr;
+
+		list_for_each_entry(tr, &snapshot->trackers, link) {
+			if ((tr == tracker) ||
+			    (tr->dev_id == tracker->dev_id)) {
+				ret = -EALREADY;
+				break;
+			}
+		}
+	}
+	if (!ret) {
+		tracker_get(tracker);
+		list_add_tail(&tracker->link, &snapshot->trackers);
+	}
+	up_write(&snapshot->rw_lock);
+
+	snapshot_put(snapshot);
+
+	return 0;
+}
+
+int snapshot_destroy(const uuid_t *id)
+{
+	struct snapshot *snapshot = NULL;
+
+	pr_info("Destroy snapshot %pUb\n", id);
+	down_write(&snapshots_lock);
+	if (!list_empty(&snapshots)) {
+		struct snapshot *s = NULL;
+
+		list_for_each_entry(s, &snapshots, link) {
+			if (uuid_equal(&s->id, id)) {
+				snapshot = s;
+				list_del(&snapshot->link);
+				break;
+			}
+		}
+	}
+	up_write(&snapshots_lock);
+
+	if (!snapshot) {
+		pr_err("Unable to destroy snapshot: cannot find snapshot by id %pUb\n",
+		       id);
+		return -ENODEV;
+	}
+	snapshot_put(snapshot);
+
+	return 0;
+}
+
+int snapshot_append_storage(const uuid_t *id, const char *bdev_path,
+			    struct blksnap_sectors __user *ranges,
+			    unsigned int range_count)
+{
+	int ret = 0;
+	struct snapshot *snapshot;
+
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return -ESRCH;
+
+	ret = diff_storage_append_block(snapshot->diff_storage, bdev_path,
+					ranges, range_count);
+	snapshot_put(snapshot);
+	return ret;
+}
+
+static int snapshot_take_trackers(struct snapshot *snapshot)
+{
+	int ret = 0;
+	struct tracker *tracker;
+
+	down_write(&snapshot->rw_lock);
+
+	if (list_empty(&snapshot->trackers)) {
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	list_for_each_entry(tracker, &snapshot->trackers, link) {
+		struct diff_area *diff_area =
+			diff_area_new(tracker->dev_id, snapshot->diff_storage);
+
+		if (IS_ERR(diff_area)) {
+			ret = PTR_ERR(diff_area);
+			break;
+		}
+		tracker->diff_area = diff_area;
+	}
+	if (ret)
+		goto fail;
+
+	/* Try to flush and freeze file system on each original block device. */
+	list_for_each_entry(tracker, &snapshot->trackers, link) {
+		if (freeze_bdev(tracker->diff_area->orig_bdev))
+			pr_warn("Failed to freeze device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else {
+			pr_debug("Device [%u:%u] was frozen\n",
+				MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		}
+	}
+
+	/*
+	 * Take snapshot - switch CBT tables and enable COW logic
+	 * for each tracker.
+	 */
+	list_for_each_entry(tracker, &snapshot->trackers, link) {
+		ret = tracker_take_snapshot(tracker);
+		if (ret) {
+			pr_err("Unable to take snapshot: failed to capture snapshot %pUb\n",
+			       &snapshot->id);
+			break;
+		}
+	}
+
+	if (!ret)
+		snapshot->is_taken = true;
+
+	/* Thaw file systems on original block devices. */
+	list_for_each_entry(tracker, &snapshot->trackers, link) {
+		if (thaw_bdev(tracker->diff_area->orig_bdev))
+			pr_warn("Failed to thaw device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else
+			pr_debug("Device [%u:%u] was unfrozen\n",
+				MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+	}
+fail:
+
+	up_write(&snapshot->rw_lock);
+	return ret;
+}
+
+/*
+ * Sometimes a snapshot is in the state of corrupt immediately
+ * after it is taken.
+ */
+static int snapshot_check_trackers(struct snapshot *snapshot)
+{
+	int ret = 0;
+	struct tracker *tracker;
+
+	down_read(&snapshot->rw_lock);
+
+	list_for_each_entry(tracker, &snapshot->trackers, link) {
+		if (unlikely(diff_area_is_corrupted(tracker->diff_area))) {
+			pr_err("Unable to create snapshot for device [%u:%u]: diff area is corrupted\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+			ret = -EFAULT;
+			break;
+		}
+	}
+
+	up_read(&snapshot->rw_lock);
+
+	return ret;
+}
+
+/*
+ * Create all image block devices.
+ */
+static int snapshot_take_images(struct snapshot *snapshot)
+{
+	int ret = 0;
+	struct tracker *tracker;
+
+	down_write(&snapshot->rw_lock);
+
+	list_for_each_entry(tracker, &snapshot->trackers, link) {
+		ret = snapimage_create(tracker);
+
+		if (ret) {
+			pr_err("Failed to create snapshot image for device [%u:%u] with error=%d\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id),
+			       ret);
+			break;
+		}
+	}
+
+	up_write(&snapshot->rw_lock);
+	return ret;
+}
+
+static int snapshot_release_trackers(struct snapshot *snapshot)
+{
+	int ret = 0;
+	struct tracker *tracker;
+
+	down_write(&snapshot->rw_lock);
+
+	list_for_each_entry(tracker, &snapshot->trackers, link)
+		tracker_release_snapshot(tracker);
+
+	up_write(&snapshot->rw_lock);
+	return ret;
+}
+
+int snapshot_take(const uuid_t *id)
+{
+	int ret = 0;
+	struct snapshot *snapshot;
+
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return -ESRCH;
+
+	if (!snapshot->is_taken) {
+		ret = snapshot_take_trackers(snapshot);
+		if (!ret) {
+			ret = snapshot_check_trackers(snapshot);
+			if (!ret)
+				ret = snapshot_take_images(snapshot);
+		}
+
+		if (ret)
+			snapshot_release_trackers(snapshot);
+	} else
+		ret = -EALREADY;
+
+	snapshot_put(snapshot);
+
+	if (ret)
+		pr_err("Unable to take snapshot %pUb\n", &snapshot->id);
+	else
+		pr_info("Snapshot %pUb was taken successfully\n",
+			&snapshot->id);
+	return ret;
+}
+
+int snapshot_collect(unsigned int *pcount,
+		     struct blksnap_uuid __user *id_array)
+{
+	int ret = 0;
+	int inx = 0;
+	struct snapshot *s;
+
+	pr_debug("Collect snapshots\n");
+
+	down_read(&snapshots_lock);
+	if (list_empty(&snapshots))
+		goto out;
+
+	if (!id_array) {
+		list_for_each_entry(s, &snapshots, link)
+			inx++;
+		goto out;
+	}
+
+	list_for_each_entry(s, &snapshots, link) {
+		if (inx >= *pcount) {
+			ret = -ENODATA;
+			goto out;
+		}
+
+		if (copy_to_user(id_array[inx].b, &s->id.b, sizeof(uuid_t))) {
+			pr_err("Unable to collect snapshots: failed to copy data to user buffer\n");
+			goto out;
+		}
+
+		inx++;
+	}
+out:
+	up_read(&snapshots_lock);
+	*pcount = inx;
+	return ret;
+}
+
+struct event *snapshot_wait_event(const uuid_t *id, unsigned long timeout_ms)
+{
+	struct snapshot *snapshot;
+	struct event *event;
+
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return ERR_PTR(-ESRCH);
+
+	event = event_wait(&snapshot->diff_storage->event_queue, timeout_ms);
+
+	snapshot_put(snapshot);
+	return event;
+}
diff --git a/drivers/block/blksnap/snapshot.h b/drivers/block/blksnap/snapshot.h
new file mode 100644
index 000000000000..bfc3139aa89e
--- /dev/null
+++ b/drivers/block/blksnap/snapshot.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_SNAPSHOT_H
+#define __BLKSNAP_SNAPSHOT_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/kref.h>
+#include <linux/uuid.h>
+#include <linux/spinlock.h>
+#include <linux/rwsem.h>
+#include <linux/fs.h>
+#include "event_queue.h"
+
+struct tracker;
+struct diff_storage;
+/**
+ * struct snapshot - Snapshot structure.
+ * @link:
+ *	The list header allows to store snapshots in a linked list.
+ * @kref:
+ *	Protects the structure from being released during the processing of
+ *	an ioctl.
+ * @id:
+ *	UUID of snapshot.
+ * @rw_lock:
+ *	Protects the structure from being modified by different threads.
+ * @is_taken:
+ *	Flag that the snapshot was taken.
+ * @diff_storage:
+ *	A pointer to the difference storage of this snapshot.
+ * @trackers:
+ *	List of block device trackers.
+ *
+ * A snapshot corresponds to a single backup session and provides snapshot
+ * images for multiple block devices. Several backup sessions can be
+ * performed at the same time, which means that several snapshots can
+ * exist at the same time. However, the original block device can only
+ * belong to one snapshot. Creating multiple snapshots from the same block
+ * device is not allowed.
+ */
+struct snapshot {
+	struct list_head link;
+	struct kref kref;
+	uuid_t id;
+
+	struct rw_semaphore rw_lock;
+
+	bool is_taken;
+	struct diff_storage *diff_storage;
+	struct list_head trackers;
+};
+
+void __exit snapshot_done(void);
+
+int snapshot_create(uuid_t *id);
+int snapshot_destroy(const uuid_t *id);
+int snapshot_add_device(const uuid_t *id, struct tracker *tracker);
+int snapshot_append_storage(const uuid_t *id, const char *bdev_path,
+			    struct blksnap_sectors __user *ranges,
+			    unsigned int range_count);
+int snapshot_take(const uuid_t *id);
+int snapshot_collect(unsigned int *pcount,
+		     struct blksnap_uuid __user *id_array);
+struct event *snapshot_wait_event(const uuid_t *id, unsigned long timeout_ms);
+
+#endif /* __BLKSNAP_SNAPSHOT_H */
-- 
2.20.1

