Return-Path: <linux-fsdevel+bounces-10983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C49884F93F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E932944A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86384A33;
	Fri,  9 Feb 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tyamziiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF583CB9
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494650; cv=none; b=GRCq761LQzRiZxtizwMq9vJeoLjrlhjm3YN2m7oyRSxe5ND9X+31Bo2XO2IcEBTqDdk4z7x/2Je4FkMCcbIsrO2lSbadA8/Hs/aEtTWE47jrjRqlqD/S10thDlVg9UoQiLQ2Pwl7NNtbqQjnZHOtxL5F5X+MeGULbnzbBwpov7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494650; c=relaxed/simple;
	bh=8fN7ec6cGUVWI3k1PNcAqi7NciTygaFbn6A2ASdB7GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jnjxM5v5m7Fhqf1jXUKZRUI1iBjOirF9YHToEcPHf70LAiA9BxzI9YlCWw7X0v84LtcQL208JR+SVhmV47aB2BCFC8M/yPys/vBuzQyejyGsZm5C/QFydd44mPpeB32Ou862QDALVw9pdtZnNsjpCLFlMlx7Ws5t3eKop74ngrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tyamziiG; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707494646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APuuQPjltHIb5RRLilsOdVSjNknCvurtSwxYEvNPfv8=;
	b=tyamziiGQfKbP5jrqTJnUNB8dxrXo+E8Jkrr/jl4ZCgui32LugLTJbbcyJlaDK7xvcJgIJ
	V4lrLNQNSDcWWvLSm6t4CtOxUeTZ6/h/pOZK6UMuNOWnh53YIK8ynFxUDKy7QjqOn4fRBa
	a2aMuZKcldvnqkoJq9BPAwwXbOD8V+Q=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 7/8] block: snapshot and snapshot image block device
Date: Fri,  9 Feb 2024 17:02:03 +0100
Message-Id: <20240209160204.1471421-8-sergei.shtepa@linux.dev>
In-Reply-To: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
References: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

Events are used to fast notify the user-space of a change in the
snapshot state. For example, if an error occurred while snapshot holding
when reading data from the original block device or from the difference
storage, the thread polling this queue will read a message about it.

Signed-off-by: Sergei Shtepa <sergei.shtepa@linux.dev>
---
 drivers/block/blksnap/event_queue.c |  81 +++++
 drivers/block/blksnap/event_queue.h |  64 ++++
 drivers/block/blksnap/snapimage.c   | 135 ++++++++
 drivers/block/blksnap/snapimage.h   |  10 +
 drivers/block/blksnap/snapshot.c    | 462 ++++++++++++++++++++++++++++
 drivers/block/blksnap/snapshot.h    |  65 ++++
 6 files changed, 817 insertions(+)
 create mode 100644 drivers/block/blksnap/event_queue.c
 create mode 100644 drivers/block/blksnap/event_queue.h
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h
 create mode 100644 drivers/block/blksnap/snapshot.c
 create mode 100644 drivers/block/blksnap/snapshot.h

diff --git a/drivers/block/blksnap/event_queue.c b/drivers/block/blksnap/event_queue.c
new file mode 100644
index 000000000000..afa4e8511eeb
--- /dev/null
+++ b/drivers/block/blksnap/event_queue.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-event_queue: " fmt
+
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include "event_queue.h"
+
+void event_queue_init(struct event_queue *event_queue)
+{
+	INIT_LIST_HEAD(&event_queue->list);
+	spin_lock_init(&event_queue->lock);
+	init_waitqueue_head(&event_queue->wq_head);
+}
+
+void event_queue_done(struct event_queue *event_queue)
+{
+	struct event *event;
+
+	spin_lock(&event_queue->lock);
+	while (!list_empty(&event_queue->list)) {
+		event = list_first_entry(&event_queue->list, struct event,
+					 link);
+		list_del(&event->link);
+		event_free(event);
+	}
+	spin_unlock(&event_queue->lock);
+}
+
+int event_gen(struct event_queue *event_queue, int code,
+	      const void *data, int data_size)
+{
+	struct event *event;
+
+	event = kzalloc(sizeof(struct event) + data_size + 1, GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
+
+	event->time = ktime_get();
+	event->code = code;
+	event->data_size = data_size;
+	memcpy(event->data, data, data_size);
+
+	pr_debug("Generate event: time=%lld code=%d data_size=%d\n",
+		 event->time, event->code, event->data_size);
+
+	spin_lock(&event_queue->lock);
+	list_add_tail(&event->link, &event_queue->list);
+	spin_unlock(&event_queue->lock);
+
+	wake_up(&event_queue->wq_head);
+	return 0;
+}
+
+struct event *event_wait(struct event_queue *event_queue,
+			 unsigned long timeout_ms)
+{
+	int ret;
+
+	ret = wait_event_interruptible_timeout(event_queue->wq_head,
+				!list_empty(&event_queue->list), timeout_ms);
+	if (ret >= 0) {
+		struct event *event = ERR_PTR(-ENOENT);
+
+		spin_lock(&event_queue->lock);
+		if (!list_empty(&event_queue->list)) {
+			event = list_first_entry(&event_queue->list,
+						 struct event, link);
+			list_del(&event->link);
+		}
+		spin_unlock(&event_queue->lock);
+		return event;
+	}
+	if (ret == -ERESTARTSYS) {
+		pr_debug("event waiting interrupted\n");
+		return ERR_PTR(-EINTR);
+	}
+
+	pr_err("Failed to wait event. errno=%d\n", abs(ret));
+	return ERR_PTR(ret);
+}
diff --git a/drivers/block/blksnap/event_queue.h b/drivers/block/blksnap/event_queue.h
new file mode 100644
index 000000000000..4980789ee83a
--- /dev/null
+++ b/drivers/block/blksnap/event_queue.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_EVENT_QUEUE_H
+#define __BLKSNAP_EVENT_QUEUE_H
+
+#include <linux/types.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+/**
+ * struct event - An event to be passed to the user space.
+ * @link:
+ *	The list header allows to combine events from the queue.
+ * @time:
+ *	A timestamp indicates when an event occurred.
+ * @code:
+ *	Event code.
+ * @data_size:
+ *	The number of bytes in the event data array.
+ * @data:
+ *	An array of event data.
+ *
+ * Events can be different, so they contain different data. The size of the
+ * data array is not defined exactly, but it has limitations. The size of
+ * the event structure is limited by the PAGE_SIZE (4096 bytes).
+ */
+struct event {
+	struct list_head link;
+	ktime_t time;
+	int code;
+	int data_size;
+	char data[];
+};
+
+/**
+ * struct event_queue - A queue of &struct event.
+ * @list:
+ *	Linked list for storing events.
+ * @lock:
+ *	Spinlock allows to guarantee safety of the linked list.
+ * @wq_head:
+ *	A wait queue allows to put a user thread in a waiting state until
+ *	an event appears in the linked list.
+ */
+struct event_queue {
+	struct list_head list;
+	spinlock_t lock;
+	struct wait_queue_head wq_head;
+};
+
+void event_queue_init(struct event_queue *event_queue);
+void event_queue_done(struct event_queue *event_queue);
+
+int event_gen(struct event_queue *event_queue, int code,
+	      const void *data, int data_size);
+struct event *event_wait(struct event_queue *event_queue,
+			 unsigned long timeout_ms);
+static inline void event_free(struct event *event)
+{
+	kfree(event);
+};
+#endif /* __BLKSNAP_EVENT_QUEUE_H */
diff --git a/drivers/block/blksnap/snapimage.c b/drivers/block/blksnap/snapimage.c
new file mode 100644
index 000000000000..2e87f3380cbc
--- /dev/null
+++ b/drivers/block/blksnap/snapimage.c
@@ -0,0 +1,135 @@
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
+	unsigned int flags;
+	struct blkfilter *prev_filter;
+	bool is_success = true;
+
+	/*
+	 * We can use the diff_area here without fear that it will be released.
+	 * The diff_area is not blocked from releasing now, because
+	 * snapimage_free() is calling before diff_area_put() in
+	 * tracker_release_snapshot().
+	 */
+	if (diff_area_is_corrupted(diff_area)) {
+		bio_io_error(bio);
+		return;
+	}
+
+	flags = memalloc_noio_save();
+	/*
+	 * The change tracking table should indicate that the image block device
+	 * is different from the original device. At the next snapshot, such
+	 * blocks must be inevitably reread.
+	 */
+	if (op_is_write(bio_op(bio)))
+		cbt_map_set_both(tracker->cbt_map, bio->bi_iter.bi_sector,
+				 bio_sectors(bio));
+
+	prev_filter = current->blk_filter;
+	current->blk_filter = &tracker->filter;
+	while (bio->bi_iter.bi_size && is_success)
+		is_success = diff_area_submit_chunk(diff_area, bio);
+	current->blk_filter = prev_filter;
+
+	if (is_success)
+		bio_endio(bio);
+	else
+		bio_io_error(bio);
+
+	memalloc_noio_restore(flags);
+}
+
+static const struct block_device_operations bd_ops = {
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
index 000000000000..db5ff325fa58
--- /dev/null
+++ b/drivers/block/blksnap/snapshot.c
@@ -0,0 +1,462 @@
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
+static LIST_HEAD(snapshots);
+static DECLARE_RWSEM(snapshots_lock);
+
+static void snapshot_free(struct kref *kref)
+{
+	struct snapshot *snapshot = container_of(kref, struct snapshot, kref);
+
+	pr_info("Release snapshot %pUb\n", &snapshot->id);
+	while (!list_empty(&snapshot->trackers)) {
+		struct tracker *tracker;
+
+		tracker = list_first_entry(&snapshot->trackers, struct tracker,
+					   link);
+		list_del_init(&tracker->link);
+		tracker_release_snapshot(tracker);
+		tracker_put(tracker);
+	}
+
+	diff_storage_put(snapshot->diff_storage);
+	snapshot->diff_storage = NULL;
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
+int snapshot_create(const char *filename, sector_t limit_sect,
+		    struct blksnap_uuid *id)
+{
+	int ret;
+	struct snapshot *snapshot = NULL;
+
+	snapshot = snapshot_new();
+	if (IS_ERR(snapshot)) {
+		pr_err("Unable to create snapshot: failed to allocate snapshot structure\n");
+		return PTR_ERR(snapshot);
+	}
+
+	if (!filename) {
+		pr_err("Unable to create snapshot: difference storage file is not set\n");
+		snapshot_put(snapshot);
+		return ret;
+	}
+	ret = diff_storage_set_diff_storage(snapshot->diff_storage,
+					    filename, limit_sect);
+	if (ret) {
+		pr_err("Unable to create snapshot: invalid difference storage file\n");
+		snapshot_put(snapshot);
+		return ret;
+	}
+
+	export_uuid(id->b, &snapshot->id);
+
+	down_write(&snapshots_lock);
+	list_add_tail(&snapshot->link, &snapshots);
+	up_write(&snapshots_lock);
+
+	pr_info("Snapshot %pUb was created\n", id->b);
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
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (tracker->orig_bdev->bd_disk->queue->integrity.profile) {
+		pr_err("Blksnap is not compatible with data integrity\n");
+		ret = -EPERM;
+		goto out_up;
+	} else
+		pr_debug("Data integrity not found\n");
+#endif
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	if (tracker->orig_bdev->bd_disk->queue->crypto_profile) {
+		pr_err("Blksnap is not compatible with hardware inline encryption\n");
+		ret = -EPERM;
+		goto out_up;
+	} else
+		pr_debug("Inline encryption not found\n");
+#endif
+	snapshot = snapshot_get_by_id(id);
+	if (!snapshot)
+		return -ESRCH;
+
+	down_write(&snapshot->rw_lock);
+	if (tracker->dev_id == snapshot->diff_storage->dev_id) {
+		pr_err("The block device %d:%d is already being used as difference storage\n",
+			MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		goto out_up;
+	}
+	if (!list_empty(&snapshot->trackers)) {
+		struct tracker *tr;
+
+		list_for_each_entry(tr, &snapshot->trackers, link) {
+			if ((tr == tracker) ||
+			    (tr->dev_id == tracker->dev_id)) {
+				ret = -EALREADY;
+				goto out_up;
+			}
+		}
+	}
+	if (list_empty(&tracker->link)) {
+		tracker_get(tracker);
+		list_add_tail(&tracker->link, &snapshot->trackers);
+	} else
+		ret = -EBUSY;
+out_up:
+	up_write(&snapshot->rw_lock);
+
+	snapshot_put(snapshot);
+
+	return ret;
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
+			diff_area_new(tracker, snapshot->diff_storage);
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
+	/*
+	 * Try to flush and freeze file system on each original block device.
+	 */
+	list_for_each_entry(tracker, &snapshot->trackers, link) {
+		if (bdev_freeze(tracker->diff_area->orig_bdev))
+			pr_warn("Failed to freeze device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else {
+			pr_debug("Device [%u:%u] was frozen\n",
+				MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		}
+	}
+
+	/*
+	 * Take snapshot - switch CBT tables and enable COW logic for each
+	 * tracker.
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
+	/*
+	 * Thaw file systems on original block devices.
+	 */
+	list_for_each_entry(tracker, &snapshot->trackers, link) {
+		if (bdev_thaw(tracker->diff_area->orig_bdev))
+			pr_warn("Failed to thaw device [%u:%u]\n",
+			       MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+		else
+			pr_debug("Device [%u:%u] was unfrozen\n",
+				MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+	}
+fail:
+	if (ret) {
+		list_for_each_entry(tracker, &snapshot->trackers, link) {
+			if (tracker->diff_area) {
+				diff_area_put(tracker->diff_area);
+				tracker->diff_area = NULL;
+			}
+		}
+	}
+	up_write(&snapshot->rw_lock);
+	return ret;
+}
+
+/*
+ * Sometimes a snapshot is in the state of corrupt immediately after it is
+ * taken.
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
index 000000000000..2cacdd4a080a
--- /dev/null
+++ b/drivers/block/blksnap/snapshot.h
@@ -0,0 +1,65 @@
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
+ * images for multiple block devices. Several backup sessions can be performed
+ * at the same time, which means that several snapshots can exist at the same
+ * time. However, the original block device can only belong to one snapshot.
+ * Creating multiple snapshots from the same block device is not allowed.
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
+int snapshot_create(const char *filename, sector_t limit_sect,
+		    struct blksnap_uuid *id);
+int snapshot_destroy(const uuid_t *id);
+int snapshot_add_device(const uuid_t *id, struct tracker *tracker);
+int snapshot_take(const uuid_t *id);
+int snapshot_collect(unsigned int *pcount,
+		     struct blksnap_uuid __user *id_array);
+struct event *snapshot_wait_event(const uuid_t *id, unsigned long timeout_ms);
+
+#endif /* __BLKSNAP_SNAPSHOT_H */
-- 
2.34.1


