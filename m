Return-Path: <linux-fsdevel+bounces-3737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF6E7F79DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB050281D1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8CF364A1;
	Fri, 24 Nov 2023 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jL5ZrF8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bc])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70151BD3
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:00:08 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700845207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmWDk8Y68Mao3PzWdDlZiK1voP/L3e+BCM9sV+PzBf0=;
	b=jL5ZrF8L9sNR/TMyHd8GQPVJVrA2s9k8ODf21idQfM+N9aCVi966USdfL5V0ZDrYpEGkj+
	Z0x5NLriwSsNvHgz7lFWQ8UIH8cQZA938QlffBoRPPHxB7saqhJB0FD+SRkbhZ6yUd7EKU
	2BpUcsGWnOaiRpui1GAP295bDYKcZKE=
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
Subject: [PATCH v6 06/11] blksnap: handling and tracking I/O units
Date: Fri, 24 Nov 2023 17:59:28 +0100
Message-Id: <20231124165933.27580-7-sergei.shtepa@linux.dev>
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

The struct tracker contains callback functions for handling a I/O units
of a block device. When a write request is handled, the change block
tracking (CBT) map functions are called and initiates the process of
copying data from the original block device to the change store.
Registering and unregistering the tracker is provided by the functions
blkfilter_register() and blkfilter_unregister().
The struct cbt_map allows to store the history of block device changes.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/cbt_map.c | 228 +++++++++++++++++++++
 drivers/block/blksnap/cbt_map.h |  90 +++++++++
 drivers/block/blksnap/tracker.c | 344 ++++++++++++++++++++++++++++++++
 drivers/block/blksnap/tracker.h |  78 ++++++++
 4 files changed, 740 insertions(+)
 create mode 100644 drivers/block/blksnap/cbt_map.c
 create mode 100644 drivers/block/blksnap/cbt_map.h
 create mode 100644 drivers/block/blksnap/tracker.c
 create mode 100644 drivers/block/blksnap/tracker.h

diff --git a/drivers/block/blksnap/cbt_map.c b/drivers/block/blksnap/cbt_map.c
new file mode 100644
index 000000000000..7b6ebe225c48
--- /dev/null
+++ b/drivers/block/blksnap/cbt_map.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-cbt_map: " fmt
+
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <uapi/linux/blksnap.h>
+#include "cbt_map.h"
+#include "params.h"
+
+static inline unsigned long long count_by_shift(sector_t capacity,
+						unsigned long long shift)
+{
+	sector_t blk_size = 1ull << (shift - SECTOR_SHIFT);
+
+	return round_up(capacity, blk_size) / blk_size;
+}
+
+static void cbt_map_calculate_block_size(struct cbt_map *cbt_map)
+{
+	unsigned long long count;
+	unsigned long long shift = get_tracking_block_minimum_shift();
+
+	pr_debug("Device capacity %llu sectors\n", cbt_map->device_capacity);
+	/*
+	 * The size of the tracking block is calculated based on the size of
+	 * the disk so that the CBT table does not exceed a reasonable size.
+	 */
+	count = count_by_shift(cbt_map->device_capacity, shift);
+	pr_debug("Blocks count %llu\n", count);
+	while (count > get_tracking_block_maximum_count()) {
+		if (shift >= get_tracking_block_maximum_shift()) {
+			pr_info("The maximum allowable CBT block size has been reached.\n");
+			break;
+		}
+		shift = shift + 1ull;
+		count = count_by_shift(cbt_map->device_capacity, shift);
+		pr_debug("Blocks count %llu\n", count);
+	}
+
+	cbt_map->blk_size_shift = shift;
+	cbt_map->blk_count = count;
+	pr_debug("The optimal CBT block size was calculated as %llu bytes\n",
+		 (1ull << cbt_map->blk_size_shift));
+}
+
+static int cbt_map_allocate(struct cbt_map *cbt_map)
+{
+	unsigned char *read_map = NULL;
+	unsigned char *write_map = NULL;
+	size_t size = cbt_map->blk_count;
+
+	pr_debug("Allocate CBT map of %zu blocks\n", size);
+
+	if (cbt_map->read_map || cbt_map->write_map)
+		return -EINVAL;
+
+	read_map = __vmalloc(size, GFP_NOIO | __GFP_ZERO);
+	if (!read_map)
+		return -ENOMEM;
+
+	write_map = __vmalloc(size, GFP_NOIO | __GFP_ZERO);
+	if (!write_map) {
+		vfree(read_map);
+		return -ENOMEM;
+	}
+
+	cbt_map->read_map = read_map;
+	cbt_map->write_map = write_map;
+
+	cbt_map->snap_number_previous = 0;
+	cbt_map->snap_number_active = 1;
+	generate_random_uuid(cbt_map->generation_id.b);
+	cbt_map->is_corrupted = false;
+
+	return 0;
+}
+
+static void cbt_map_deallocate(struct cbt_map *cbt_map)
+{
+	cbt_map->is_corrupted = false;
+
+	if (cbt_map->read_map) {
+		vfree(cbt_map->read_map);
+		cbt_map->read_map = NULL;
+	}
+
+	if (cbt_map->write_map) {
+		vfree(cbt_map->write_map);
+		cbt_map->write_map = NULL;
+	}
+}
+
+int cbt_map_reset(struct cbt_map *cbt_map, sector_t device_capacity)
+{
+	cbt_map_deallocate(cbt_map);
+
+	cbt_map->device_capacity = device_capacity;
+	cbt_map_calculate_block_size(cbt_map);
+
+	return cbt_map_allocate(cbt_map);
+}
+
+void cbt_map_destroy(struct cbt_map *cbt_map)
+{
+	pr_debug("CBT map destroy\n");
+
+	cbt_map_deallocate(cbt_map);
+	kfree(cbt_map);
+}
+
+struct cbt_map *cbt_map_create(struct block_device *bdev)
+{
+	struct cbt_map *cbt_map = NULL;
+	int ret;
+
+	pr_debug("CBT map create\n");
+
+	cbt_map = kzalloc(sizeof(struct cbt_map), GFP_KERNEL);
+	if (cbt_map == NULL)
+		return NULL;
+
+	cbt_map->device_capacity = bdev_nr_sectors(bdev);
+	cbt_map_calculate_block_size(cbt_map);
+
+	ret = cbt_map_allocate(cbt_map);
+	if (ret) {
+		pr_err("Failed to create tracker. errno=%d\n", abs(ret));
+		cbt_map_destroy(cbt_map);
+		return NULL;
+	}
+
+	spin_lock_init(&cbt_map->locker);
+	cbt_map->is_corrupted = false;
+
+	return cbt_map;
+}
+
+void cbt_map_switch(struct cbt_map *cbt_map)
+{
+	pr_debug("CBT map switch\n");
+	spin_lock(&cbt_map->locker);
+
+	cbt_map->snap_number_previous = cbt_map->snap_number_active;
+	++cbt_map->snap_number_active;
+	if (cbt_map->snap_number_active == 256) {
+		cbt_map->snap_number_active = 1;
+
+		memset(cbt_map->write_map, 0, cbt_map->blk_count);
+
+		generate_random_uuid(cbt_map->generation_id.b);
+
+		pr_debug("CBT reset\n");
+	} else
+		memcpy(cbt_map->read_map, cbt_map->write_map,
+		       cbt_map->blk_count);
+	spin_unlock(&cbt_map->locker);
+}
+
+static inline int _cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start,
+			       sector_t sector_cnt, u8 snap_number,
+			       unsigned char *map)
+{
+	int res = 0;
+	u8 num;
+	size_t inx;
+	size_t cbt_block_first = (size_t)(
+		sector_start >> (cbt_map->blk_size_shift - SECTOR_SHIFT));
+	size_t cbt_block_last = (size_t)(
+		(sector_start + sector_cnt - 1) >>
+		(cbt_map->blk_size_shift - SECTOR_SHIFT));
+
+	for (inx = cbt_block_first; inx <= cbt_block_last; ++inx) {
+		if (unlikely(inx >= cbt_map->blk_count)) {
+			pr_err("Block index is too large\n");
+			pr_err("Block #%zu was demanded, map size %zu blocks\n",
+			       inx, cbt_map->blk_count);
+			res = -EINVAL;
+			break;
+		}
+
+		num = map[inx];
+		if (num < snap_number)
+			map[inx] = snap_number;
+	}
+	return res;
+}
+
+int cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start,
+		sector_t sector_cnt)
+{
+	int res;
+
+	spin_lock(&cbt_map->locker);
+	if (unlikely(cbt_map->is_corrupted)) {
+		spin_unlock(&cbt_map->locker);
+		return -EINVAL;
+	}
+	res = _cbt_map_set(cbt_map, sector_start, sector_cnt,
+			   (u8)cbt_map->snap_number_active, cbt_map->write_map);
+	if (unlikely(res))
+		cbt_map->is_corrupted = true;
+
+	spin_unlock(&cbt_map->locker);
+
+	return res;
+}
+
+int cbt_map_set_both(struct cbt_map *cbt_map, sector_t sector_start,
+		     sector_t sector_cnt)
+{
+	int res;
+
+	spin_lock(&cbt_map->locker);
+	if (unlikely(cbt_map->is_corrupted)) {
+		spin_unlock(&cbt_map->locker);
+		return -EINVAL;
+	}
+	res = _cbt_map_set(cbt_map, sector_start, sector_cnt,
+			   (u8)cbt_map->snap_number_active, cbt_map->write_map);
+	if (!res)
+		res = _cbt_map_set(cbt_map, sector_start, sector_cnt,
+				   (u8)cbt_map->snap_number_previous,
+				   cbt_map->read_map);
+	spin_unlock(&cbt_map->locker);
+
+	return res;
+}
diff --git a/drivers/block/blksnap/cbt_map.h b/drivers/block/blksnap/cbt_map.h
new file mode 100644
index 000000000000..95dc17e6bcec
--- /dev/null
+++ b/drivers/block/blksnap/cbt_map.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_CBT_MAP_H
+#define __BLKSNAP_CBT_MAP_H
+
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/uuid.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+
+struct blksnap_sectors;
+
+/**
+ * struct cbt_map - The table of changes for a block device.
+ *
+ * @locker:
+ *	Locking for atomic modification of structure members.
+ * @blk_size_shift:
+ *	The power of 2 used to specify the change tracking block size.
+ * @blk_count:
+ *	The number of change tracking blocks.
+ * @device_capacity:
+ *	The actual capacity of the device.
+ * @read_map:
+ *	A table of changes available for reading. This is the table that can
+ *	be read after taking a snapshot.
+ * @write_map:
+ *	The current table for tracking changes.
+ * @snap_number_active:
+ *	The current sequential number of changes. This is the number that is
+ *	written to the current table when the block data changes.
+ * @snap_number_previous:
+ *	The previous sequential number of changes. This number is used to
+ *	identify the blocks that were changed between the penultimate snapshot
+ *	and the last snapshot.
+ * @generation_id:
+ *	UUID of the generation of changes.
+ * @is_corrupted:
+ *	A flag that the change tracking data is no longer reliable.
+ *
+ * The change block tracking map is a byte table. Each byte stores the
+ * sequential number of changes for one block. To determine which blocks have
+ * changed since the previous snapshot with the change number 4, it is enough
+ * to find all bytes with the number more than 4.
+ *
+ * Since one byte is allocated to track changes in one block, the change table
+ * is created again at the 255th snapshot. At the same time, a new unique
+ * generation identifier is generated. Tracking changes is possible only for
+ * tables of the same generation.
+ *
+ * There are two tables on the change block tracking map. One is available for
+ * reading, and the other is available for writing. At the moment of taking
+ * a snapshot, the tables are synchronized. The user's process, when calling
+ * the corresponding ioctl, can read the readable table. At the same time, the
+ * change tracking mechanism continues to work with the writable table.
+ *
+ * To provide the ability to mount a snapshot image as writeable, it is
+ * possible to make changes to both of these tables simultaneously.
+ *
+ */
+struct cbt_map {
+	spinlock_t locker;
+
+	size_t blk_size_shift;
+	size_t blk_count;
+	sector_t device_capacity;
+
+	unsigned char *read_map;
+	unsigned char *write_map;
+
+	unsigned long snap_number_active;
+	unsigned long snap_number_previous;
+	uuid_t generation_id;
+
+	bool is_corrupted;
+};
+
+struct cbt_map *cbt_map_create(struct block_device *bdev);
+int cbt_map_reset(struct cbt_map *cbt_map, sector_t device_capacity);
+
+void cbt_map_destroy(struct cbt_map *cbt_map);
+
+void cbt_map_switch(struct cbt_map *cbt_map);
+int cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start,
+		sector_t sector_cnt);
+int cbt_map_set_both(struct cbt_map *cbt_map, sector_t sector_start,
+		     sector_t sector_cnt);
+
+#endif /* __BLKSNAP_CBT_MAP_H */
diff --git a/drivers/block/blksnap/tracker.c b/drivers/block/blksnap/tracker.c
new file mode 100644
index 000000000000..2b8978a2f42e
--- /dev/null
+++ b/drivers/block/blksnap/tracker.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-tracker: " fmt
+
+#include <linux/slab.h>
+#include <linux/blk-mq.h>
+#include <linux/sched/mm.h>
+#include <linux/build_bug.h>
+#include <uapi/linux/blksnap.h>
+#include "tracker.h"
+#include "cbt_map.h"
+#include "diff_area.h"
+#include "snapimage.h"
+#include "snapshot.h"
+
+void tracker_free(struct kref *kref)
+{
+	struct tracker *tracker = container_of(kref, struct tracker, kref);
+
+	might_sleep();
+
+	pr_debug("Free tracker for device [%u:%u]\n", MAJOR(tracker->dev_id),
+		 MINOR(tracker->dev_id));
+
+	if (tracker->diff_area)
+		diff_area_put(tracker->diff_area);
+	if (tracker->cbt_map)
+		cbt_map_destroy(tracker->cbt_map);
+
+	kfree(tracker);
+}
+
+static bool tracker_submit_bio(struct bio *bio)
+{
+	struct blkfilter *flt = bio->bi_bdev->bd_filter;
+	struct tracker *tracker = container_of(flt, struct tracker, filter);
+	sector_t count = bio_sectors(bio);
+	struct bvec_iter copy_iter;
+
+	if (!op_is_write(bio_op(bio)) || !count)
+		return false;
+
+	copy_iter = bio->bi_iter;
+	if (bio_flagged(bio, BIO_REMAPPED))
+		copy_iter.bi_sector -= bio->bi_bdev->bd_start_sect;
+
+	if (cbt_map_set(tracker->cbt_map, copy_iter.bi_sector, count))
+		return false;
+
+	if (!atomic_read(&tracker->snapshot_is_taken))
+		return false;
+	/*
+	 * The diff_area is not blocked from releasing now, because
+	 * changing the value of the snapshot_is_taken is performed when
+	 * the block device queue is frozen in tracker_release_snapshot().
+	 */
+	if (diff_area_is_corrupted(tracker->diff_area))
+		return false;
+
+	return diff_area_cow(bio, tracker->diff_area, &copy_iter);
+}
+
+static struct blkfilter *tracker_attach(struct block_device *bdev)
+{
+	struct tracker *tracker = NULL;
+	struct cbt_map *cbt_map;
+
+	pr_debug("Creating tracker for device [%u:%u]\n",
+		 MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+
+	cbt_map = cbt_map_create(bdev);
+	if (!cbt_map) {
+		pr_err("Failed to create CBT map for device [%u:%u]\n",
+		       MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+		return ERR_PTR(-ENOMEM);
+	}
+
+	tracker = kzalloc(sizeof(struct tracker), GFP_KERNEL);
+	if (tracker == NULL) {
+		cbt_map_destroy(cbt_map);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	tracker->orig_bdev = bdev;
+	mutex_init(&tracker->ctl_lock);
+	INIT_LIST_HEAD(&tracker->link);
+	kref_init(&tracker->kref);
+	tracker->dev_id = bdev->bd_dev;
+	atomic_set(&tracker->snapshot_is_taken, false);
+	tracker->cbt_map = cbt_map;
+	tracker->diff_area = NULL;
+
+	pr_debug("New tracker for device [%u:%u] was created\n",
+		 MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+
+	return &tracker->filter;
+}
+
+static void tracker_detach(struct blkfilter *flt)
+{
+	struct tracker *tracker = container_of(flt, struct tracker, filter);
+
+	pr_debug("Detach tracker from device [%u:%u]\n",
+		 MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+
+	tracker_put(tracker);
+}
+
+static int ctl_cbtinfo(struct tracker *tracker, __u8 __user *buf, __u32 *plen)
+{
+	struct cbt_map *cbt_map = tracker->cbt_map;
+	struct blksnap_cbtinfo arg;
+
+	if (!cbt_map)
+		return -ESRCH;
+
+	if (*plen < sizeof(arg))
+		return -EINVAL;
+
+	arg.device_capacity = (__u64)(cbt_map->device_capacity << SECTOR_SHIFT);
+	arg.block_size = (__u32)(1 << cbt_map->blk_size_shift);
+	arg.block_count = (__u32)cbt_map->blk_count;
+	export_uuid(arg.generation_id.b, &cbt_map->generation_id);
+	arg.changes_number = (__u8)cbt_map->snap_number_previous;
+
+	if (copy_to_user(buf, &arg, sizeof(arg)))
+		return -ENODATA;
+
+	*plen = sizeof(arg);
+	return 0;
+}
+
+static int ctl_cbtmap(struct tracker *tracker, __u8 __user *buf, __u32 *plen)
+{
+	struct cbt_map *cbt_map = tracker->cbt_map;
+	struct blksnap_cbtmap arg;
+
+	if (!cbt_map)
+		return -ESRCH;
+
+	if (unlikely(cbt_map->is_corrupted)) {
+		pr_err("CBT table was corrupted\n");
+		return -EFAULT;
+	}
+
+	if (*plen < sizeof(arg))
+		return -EINVAL;
+
+	if (copy_from_user(&arg, buf, sizeof(arg)))
+		return -ENODATA;
+
+	if (arg.length > (cbt_map->blk_count - arg.offset))
+		return -ENODATA;
+
+	if (copy_to_user(u64_to_user_ptr(arg.buffer),
+			 cbt_map->read_map + arg.offset, arg.length))
+
+		return -EINVAL;
+
+	*plen = 0;
+	return 0;
+}
+
+static int ctl_cbtdirty(struct tracker *tracker, __u8 __user *buf, __u32 *plen)
+{
+	struct cbt_map *cbt_map = tracker->cbt_map;
+	struct blksnap_cbtdirty arg;
+	unsigned int inx;
+
+	if (!cbt_map)
+		return -ESRCH;
+
+	if (*plen < sizeof(arg))
+		return -EINVAL;
+
+	if (copy_from_user(&arg, buf, sizeof(arg)))
+		return -ENODATA;
+
+	for (inx = 0; inx < arg.count; inx++) {
+		struct blksnap_sectors range;
+		int ret;
+
+		if (copy_from_user(&range, u64_to_user_ptr(arg.dirty_sectors),
+				   sizeof(range)))
+			return -ENODATA;
+
+		ret = cbt_map_set_both(cbt_map, range.offset, range.count);
+		if (ret)
+			return ret;
+	}
+	*plen = 0;
+	return 0;
+}
+
+static int ctl_snapshotadd(struct tracker *tracker,
+			   __u8 __user *buf, __u32 *plen)
+{
+	struct blksnap_snapshotadd arg;
+
+	if (*plen < sizeof(arg))
+		return -EINVAL;
+
+	if (copy_from_user(&arg, buf, sizeof(arg)))
+		return -ENODATA;
+
+	*plen = 0;
+	return  snapshot_add_device((uuid_t *)&arg.id, tracker);
+}
+static int ctl_snapshotinfo(struct tracker *tracker,
+			    __u8 __user *buf, __u32 *plen)
+{
+	struct blksnap_snapshotinfo arg = {0};
+
+	if (*plen < sizeof(arg))
+		return -EINVAL;
+
+	if (copy_from_user(&arg, buf, sizeof(arg)))
+		return -ENODATA;
+
+	if (tracker->diff_area && diff_area_is_corrupted(tracker->diff_area))
+		arg.error_code = tracker->diff_area->error_code;
+	else
+		arg.error_code = 0;
+
+	if (tracker->snap_disk)
+		strscpy(arg.image, tracker->snap_disk->disk_name,
+			IMAGE_DISK_NAME_LEN);
+
+	if (copy_to_user(buf, &arg, sizeof(arg)))
+		return -ENODATA;
+
+	*plen = sizeof(arg);
+	return 0;
+}
+
+static int (*const ctl_table[])(struct tracker *tracker,
+				__u8 __user *buf, __u32 *plen) = {
+	ctl_cbtinfo,
+	ctl_cbtmap,
+	ctl_cbtdirty,
+	ctl_snapshotadd,
+	ctl_snapshotinfo,
+};
+
+static int tracker_ctl(struct blkfilter *flt, const unsigned int cmd,
+		       __u8 __user *buf, __u32 *plen)
+{
+	int ret = 0;
+	struct tracker *tracker = container_of(flt, struct tracker, filter);
+
+	if (cmd > ARRAY_SIZE(ctl_table))
+		return -ENOTTY;
+
+	mutex_lock(&tracker->ctl_lock);
+	ret = ctl_table[cmd](tracker, buf, plen);
+	mutex_unlock(&tracker->ctl_lock);
+
+	return ret;
+}
+
+static struct blkfilter_operations tracker_ops = {
+	.owner		= THIS_MODULE,
+	.name		= "blksnap",
+	.attach		= tracker_attach,
+	.detach		= tracker_detach,
+	.ctl		= tracker_ctl,
+	.submit_bio	= tracker_submit_bio,
+};
+
+int tracker_take_snapshot(struct tracker *tracker)
+{
+	int ret = 0;
+	bool cbt_reset_needed = false;
+	struct block_device *orig_bdev = tracker->orig_bdev;
+	sector_t capacity;
+	unsigned int current_flag;
+
+	blk_mq_freeze_queue(orig_bdev->bd_queue);
+	current_flag = memalloc_noio_save();
+
+	if (tracker->cbt_map->is_corrupted) {
+		cbt_reset_needed = true;
+		pr_warn("Corrupted CBT table detected. CBT fault\n");
+	}
+
+	capacity = bdev_nr_sectors(orig_bdev);
+	if (tracker->cbt_map->device_capacity != capacity) {
+		cbt_reset_needed = true;
+		pr_warn("Device resize detected. CBT fault\n");
+	}
+
+	if (cbt_reset_needed) {
+		ret = cbt_map_reset(tracker->cbt_map, capacity);
+		if (ret) {
+			pr_err("Failed to create tracker. errno=%d\n",
+			       abs(ret));
+			return ret;
+		}
+	}
+
+	cbt_map_switch(tracker->cbt_map);
+	atomic_set(&tracker->snapshot_is_taken, true);
+
+	memalloc_noio_restore(current_flag);
+	blk_mq_unfreeze_queue(orig_bdev->bd_queue);
+
+	return 0;
+}
+
+void tracker_release_snapshot(struct tracker *tracker)
+{
+	struct diff_area *diff_area = tracker->diff_area;
+
+	if (unlikely(!diff_area))
+		return;
+
+	snapimage_free(tracker);
+
+	blk_mq_freeze_queue(tracker->orig_bdev->bd_queue);
+
+	pr_debug("Tracker for device [%u:%u] release snapshot\n",
+		 MAJOR(tracker->dev_id), MINOR(tracker->dev_id));
+
+	atomic_set(&tracker->snapshot_is_taken, false);
+	tracker->diff_area = NULL;
+
+	blk_mq_unfreeze_queue(tracker->orig_bdev->bd_queue);
+
+	diff_area_put(diff_area);
+}
+
+int __init tracker_init(void)
+{
+	pr_debug("Register filter '%s'", tracker_ops.name);
+
+	return blkfilter_register(&tracker_ops);
+}
+
+void tracker_done(void)
+{
+	pr_debug("Unregister filter '%s'", tracker_ops.name);
+
+	blkfilter_unregister(&tracker_ops);
+}
diff --git a/drivers/block/blksnap/tracker.h b/drivers/block/blksnap/tracker.h
new file mode 100644
index 000000000000..05ecc3c3c819
--- /dev/null
+++ b/drivers/block/blksnap/tracker.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_TRACKER_H
+#define __BLKSNAP_TRACKER_H
+
+#include <linux/blk-filter.h>
+#include <linux/kref.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/rwsem.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+
+struct cbt_map;
+struct diff_area;
+
+/**
+ * struct tracker - Tracker for a block device.
+ *
+ * @filter:
+ *	The block device filter structure.
+ * @orig_bdev:
+ *	The original block device this trackker is attached to.
+ * @ctl_lock:
+ *	The mutex blocks simultaneous management of the tracker from different
+ *	treads.
+ * @link:
+ *	List header. Allows to combine trackers into a list in a snapshot.
+ * @kref:
+ *	The reference counter allows to control the lifetime of the tracker.
+ * @dev_id:
+ *	Original block device ID.
+ * @snapshot_is_taken:
+ *	Indicates that a snapshot was taken for the device whose I/O unit are
+ *	handled by this tracker.
+ * @cbt_map:
+ *	Pointer to a change block tracker map.
+ * @diff_area:
+ *	Pointer to a difference area.
+ * @snap_disk:
+ *	Snapshot image disk.
+ *
+ * The goal of the tracker is to handle I/O unit. The tracker detectes the range
+ * of sectors that will change and transmits them to the CBT map and to the
+ * difference area.
+ */
+struct tracker {
+	struct blkfilter filter;
+	struct block_device *orig_bdev;
+	struct mutex ctl_lock;
+	struct list_head link;
+	struct kref kref;
+	dev_t dev_id;
+
+	atomic_t snapshot_is_taken;
+
+	struct cbt_map *cbt_map;
+	struct diff_area *diff_area;
+	struct gendisk *snap_disk;
+};
+
+int __init tracker_init(void);
+void tracker_done(void);
+
+void tracker_free(struct kref *kref);
+static inline void tracker_put(struct tracker *tracker)
+{
+	if (likely(tracker))
+		kref_put(&tracker->kref, tracker_free);
+};
+static inline void tracker_get(struct tracker *tracker)
+{
+	kref_get(&tracker->kref);
+};
+int tracker_take_snapshot(struct tracker *tracker);
+void tracker_release_snapshot(struct tracker *tracker);
+
+#endif /* __BLKSNAP_TRACKER_H */
-- 
2.20.1


