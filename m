Return-Path: <linux-fsdevel+bounces-3741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C23B7F79EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239C3281458
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4A228E25;
	Fri, 24 Nov 2023 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mg29T9fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596C52126
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:00:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700845220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zT8W0511OjWhWNR4kOTUZaAUsYLmsetenUDLVK6jUuQ=;
	b=mg29T9fvYzHSof4M/GR7M9Li/3bW2JN/FuWllDj5AiebiSH6KK1o3K2doCoizULEhzm3N7
	+3p2wfQxpifJDNYkZ9uMLCwwdXqJGp0dyPJWh4N2Y4TCRoBSD7YE9QAgcxIfQuIfRNkw5S
	DWu1R4Ss0ksk8oNiTyRbXJtLwa8esko=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v6 09/11] blksnap: snapshot and snapshot image block device
Date: Fri, 24 Nov 2023 17:59:31 +0100
Message-Id: <20231124165933.27580-10-sergei.shtepa@linux.dev>
In-Reply-To: <20231124165933.27580-1-sergei.shtepa@linux.dev>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sergei Shtepa <sergei.shtepa@veeam.com>

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
 drivers/block/blksnap/snapimage.c | 134 +++++++++
 drivers/block/blksnap/snapimage.h |  10 +
 drivers/block/blksnap/snapshot.c  | 440 ++++++++++++++++++++++++++++++
 drivers/block/blksnap/snapshot.h  |  64 +++++
 4 files changed, 648 insertions(+)
 create mode 100644 drivers/block/blksnap/snapimage.c
 create mode 100644 drivers/block/blksnap/snapimage.h
 create mode 100644 drivers/block/blksnap/snapshot.c
 create mode 100644 drivers/block/blksnap/snapshot.h

diff --git a/drivers/block/blksnap/snapimage.c b/drivers/block/blksnap/snapimage.c
new file mode 100644
index 000000000000..6efd39d2ce79
--- /dev/null
+++ b/drivers/block/blksnap/snapimage.c
@@ -0,0 +1,134 @@
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
+	unsigned int old_nofs;
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
+	old_nofs = memalloc_nofs_save();
+	while (bio->bi_iter.bi_size && is_success)
+		is_success = diff_area_submit_chunk(diff_area, bio);
+	memalloc_nofs_restore(old_nofs);
+	current->blk_filter = prev_filter;
+
+	if (is_success)
+		bio_endio(bio);
+	else
+		bio_io_error(bio);
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
index 000000000000..21d94f12b5fc
--- /dev/null
+++ b/drivers/block/blksnap/snapshot.c
@@ -0,0 +1,440 @@
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
+int snapshot_create(struct blksnap_snapshot_create *arg)
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
+	export_uuid(arg->id.b, &snapshot->id);
+
+	ret = diff_storage_set_diff_storage(snapshot->diff_storage,
+					    arg->diff_storage_fd,
+					    arg->diff_storage_limit_sect);
+	if (ret) {
+		pr_err("Unable to create snapshot: invalid difference storage file\n");
+		snapshot_put(snapshot);
+		return ret;
+	}
+
+	down_write(&snapshots_lock);
+	list_add_tail(&snapshot->link, &snapshots);
+	up_write(&snapshots_lock);
+
+	pr_info("Snapshot %pUb was created\n", arg->id.b);
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
+		if (thaw_bdev(tracker->diff_area->orig_bdev))
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
index 000000000000..8d24926bf86e
--- /dev/null
+++ b/drivers/block/blksnap/snapshot.h
@@ -0,0 +1,64 @@
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
+int snapshot_create(struct blksnap_snapshot_create *arg);
+int snapshot_destroy(const uuid_t *id);
+int snapshot_add_device(const uuid_t *id, struct tracker *tracker);
+int snapshot_take(const uuid_t *id);
+int snapshot_collect(unsigned int *pcount,
+		     struct blksnap_uuid __user *id_array);
+struct event *snapshot_wait_event(const uuid_t *id, unsigned long timeout_ms);
+
+#endif /* __BLKSNAP_SNAPSHOT_H */
-- 
2.20.1


