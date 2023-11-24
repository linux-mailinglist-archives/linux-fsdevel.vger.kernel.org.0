Return-Path: <linux-fsdevel+bounces-3722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B47F796E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AC1281D56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA322381C4;
	Fri, 24 Nov 2023 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MuKuGOZk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975EE1BDA;
	Fri, 24 Nov 2023 08:39:11 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700843950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJneZ4OkvbVOWh1hD/tfiGQQTqVpGmWXope7DfL6eJ4=;
	b=MuKuGOZkS+oqiGOv9VQYz20A/I5nuIqVO45z2Dk3HAIyl4zN7Wdj2OcI+9JH3oNfLbmEMV
	I8eYueBRTy4nCSZveHWJr7cJJc4WohjvEcmgMvcWv786cFxYbs/LrFCi79v2QBXpjISt9l
	3MnAV0BCxo2ZPbpVyYwCS7gM5gBnmUA=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	mgorman@suse.de,
	vschneid@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v6 05/11] blksnap: module management interface functions
Date: Fri, 24 Nov 2023 17:38:30 +0100
Message-Id: <20231124163836.27256-6-sergei.shtepa@linux.dev>
In-Reply-To: <20231124163836.27256-1-sergei.shtepa@linux.dev>
References: <20231124163836.27256-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sergei Shtepa <sergei.shtepa@veeam.com>

Contains callback functions for loading and unloading the module and
implementation of module management interface functions. The module
parameters and other mandatory declarations for the kernel module are
also defined.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 MAINTAINERS                    |   1 +
 drivers/block/blksnap/main.c   | 475 +++++++++++++++++++++++++++++++++
 drivers/block/blksnap/params.h |  16 ++
 3 files changed, 492 insertions(+)
 create mode 100644 drivers/block/blksnap/main.c
 create mode 100644 drivers/block/blksnap/params.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9770c4d4b15d..6f666d772cf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3598,6 +3598,7 @@ M:	Sergei Shtepa <sergei.shtepa@veeam.com>
 L:	linux-block@vger.kernel.org
 S:	Supported
 F:	Documentation/block/blksnap.rst
+F:	drivers/block/blksnap/*
 F:	include/uapi/linux/blksnap.h
 
 BLOCK LAYER
diff --git a/drivers/block/blksnap/main.c b/drivers/block/blksnap/main.c
new file mode 100644
index 000000000000..a8ae824d580f
--- /dev/null
+++ b/drivers/block/blksnap/main.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/build_bug.h>
+#include <uapi/linux/blksnap.h>
+#include "snapimage.h"
+#include "snapshot.h"
+#include "tracker.h"
+#include "chunk.h"
+#include "params.h"
+
+/*
+ * The power of 2 for minimum tracking block size.
+ *
+ * If we make the tracking block size small, we will get detailed information
+ * about the changes, but the size of the change tracker table will be too
+ * large, which will lead to inefficient memory usage.
+ */
+static unsigned int tracking_block_minimum_shift = 16;
+
+/*
+ * The maximum number of tracking blocks.
+ *
+ * A table is created in RAM to store information about the status of all
+ * tracking blocks. So, if the size of the tracking block is small, then the
+ * size of the table turns out to be large and memory is consumed inefficiently.
+ * As the size of the block device grows, the size of the tracking block size
+ * should also grow. For this purpose, the limit of the maximum number of block
+ * size is set.
+ */
+static unsigned int tracking_block_maximum_count = 2097152;
+
+/*
+ * The power of 2 for maximum tracking block size.
+ *
+ * On very large capacity disks, the block size may be too large. To prevent
+ * this, the maximum block size is limited. If the limit on the maximum block
+ * size has been reached, then the number of blocks may exceed the
+ * &tracking_block_maximum_count.
+ */
+static unsigned int tracking_block_maximum_shift = 26;
+
+/*
+ * The power of 2 for minimum chunk size.
+ *
+ * The size of the chunk depends on how much data will be copied to the
+ * difference storage when at least one sector of the block device is changed.
+ * If the size is small, then small I/O units will be generated, which will
+ * reduce performance. Too large a chunk size will lead to inefficient use of
+ * the difference storage.
+ */
+static unsigned int chunk_minimum_shift = 18;
+
+/*
+ * The power of 2 for maximum number of chunks.
+ *
+ * A table is created in RAM to store information about the state of the chunks.
+ * So, if the size of the chunk is small, then the size of the table turns out
+ * to be large and memory is consumed inefficiently. As the size of the block
+ * device grows, the size of the chunk should also grow. For this purpose, the
+ * maximum number of chunks is set.
+ *
+ * The table expands dynamically when new chunks are allocated. Therefore,
+ * memory consumption also depends on the intensity of writing to the block
+ * device under the snapshot.
+ */
+static unsigned int chunk_maximum_count_shift = 40;
+
+/*
+ * The power of 2 for maximum chunk size.
+ *
+ * On very large capacity disks, the chunk size may be too large. To prevent
+ * this, the maximum block size is limited. If the limit on the maximum chunk
+ * size has been reached, then the number of chunks may exceed the
+ * &chunk_maximum_count.
+ */
+static unsigned int chunk_maximum_shift = 26;
+
+/*
+ * The maximum number of chunks in queue.
+ *
+ * The chunk is not immediately stored to the difference storage. The chunks
+ * are put in a store queue. The store queue allows to postpone the operation
+ * of storing a chunks data to the difference storage and perform it later in
+ * the worker thread.
+ */
+static unsigned int chunk_maximum_in_queue = 16;
+
+/*
+ * The size of the pool of preallocated difference buffers.
+ *
+ * A buffer can be allocated for each chunk. After use, this buffer is not
+ * released immediately, but is sent to the pool of free buffers. However, if
+ * there are too many free buffers in the pool, then these free buffers will
+ * be released immediately.
+ */
+static unsigned int free_diff_buffer_pool_size = 128;
+
+/*
+ * The minimum allowable size of the difference storage in sectors.
+ *
+ * The difference storage is a part of the disk space allocated for storing
+ * snapshot data. If the free space in difference storage is less than half of
+ * this value, then the process of increasing the size of the difference storage
+ * file will begin. The size of the difference storage file is increased in
+ * portions, the size of which is determined by this value.
+ */
+static unsigned int diff_storage_minimum = 2097152;
+
+#define VERSION_STR "2.0.0.0"
+static const struct blksnap_version version = {
+	.major = 2,
+	.minor = 0,
+	.revision = 0,
+	.build = 0,
+};
+
+unsigned int get_tracking_block_minimum_shift(void)
+{
+	return tracking_block_minimum_shift;
+}
+
+unsigned int get_tracking_block_maximum_shift(void)
+{
+	return tracking_block_maximum_shift;
+}
+
+unsigned int get_tracking_block_maximum_count(void)
+{
+	return tracking_block_maximum_count;
+}
+
+unsigned int get_chunk_minimum_shift(void)
+{
+	return chunk_minimum_shift;
+}
+
+unsigned int get_chunk_maximum_shift(void)
+{
+	return chunk_maximum_shift;
+}
+
+unsigned long get_chunk_maximum_count(void)
+{
+	/*
+	 * The XArray is used to store chunks. And 'unsigned long' is used as
+	 * chunk number parameter. So, The number of chunks cannot exceed the
+	 * limits of ULONG_MAX.
+	 */
+	if ((chunk_maximum_count_shift >> 3) < sizeof(unsigned long))
+		return (1ul << chunk_maximum_count_shift);
+	return ULONG_MAX;
+}
+
+unsigned int get_chunk_maximum_in_queue(void)
+{
+	return chunk_maximum_in_queue;
+}
+
+unsigned int get_free_diff_buffer_pool_size(void)
+{
+	return free_diff_buffer_pool_size;
+}
+
+sector_t get_diff_storage_minimum(void)
+{
+	return (sector_t)diff_storage_minimum;
+}
+
+static int ioctl_version(struct blksnap_version __user *user_version)
+{
+	if (copy_to_user(user_version, &version, sizeof(version))) {
+		pr_err("Unable to get version: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static_assert(sizeof(uuid_t) == sizeof(struct blksnap_uuid),
+	"Invalid size of struct blksnap_uuid.");
+
+static int ioctl_snapshot_create(struct blksnap_snapshot_create __user *uarg)
+{
+	struct blksnap_snapshot_create karg;
+	int ret;
+
+	if (copy_from_user(&karg, uarg, sizeof(karg))) {
+		pr_err("Unable to create snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	ret = snapshot_create(&karg);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(uarg, &karg, sizeof(karg))) {
+		pr_err("Unable to create snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int ioctl_snapshot_destroy(struct blksnap_uuid __user *user_id)
+{
+	uuid_t kernel_id;
+
+	if (copy_from_user(kernel_id.b, user_id->b, sizeof(uuid_t))) {
+		pr_err("Unable to destroy snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return snapshot_destroy(&kernel_id);
+}
+
+static int ioctl_snapshot_take(struct blksnap_uuid __user *user_id)
+{
+	uuid_t kernel_id;
+
+	if (copy_from_user(kernel_id.b, user_id->b, sizeof(uuid_t))) {
+		pr_err("Unable to take snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return snapshot_take(&kernel_id);
+}
+
+static int ioctl_snapshot_collect(struct blksnap_snapshot_collect __user *uarg)
+{
+	int ret;
+	struct blksnap_snapshot_collect karg;
+
+	if (copy_from_user(&karg, uarg, sizeof(karg))) {
+		pr_err("Unable to collect available snapshots: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	ret = snapshot_collect(&karg.count, u64_to_user_ptr(karg.ids));
+
+	if (copy_to_user(uarg, &karg, sizeof(karg))) {
+		pr_err("Unable to collect available snapshots: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return ret;
+}
+
+static_assert(sizeof(struct blksnap_snapshot_event) == 4096,
+	"The size struct blksnap_snapshot_event should be equal to the size of the page.");
+
+static int ioctl_snapshot_wait_event(struct blksnap_snapshot_event __user *uarg)
+{
+	int ret = 0;
+	struct blksnap_snapshot_event *karg;
+	struct event *ev;
+
+	karg = kzalloc(sizeof(struct blksnap_snapshot_event), GFP_KERNEL);
+	if (!karg)
+		return -ENOMEM;
+
+	/* Copy only snapshot ID and timeout*/
+	if (copy_from_user(karg, uarg, sizeof(uuid_t) + sizeof(__u32))) {
+		pr_err("Unable to get snapshot event. Invalid user buffer\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ev = snapshot_wait_event((uuid_t *)karg->id.b, karg->timeout_ms);
+	if (IS_ERR(ev)) {
+		ret = PTR_ERR(ev);
+		goto out;
+	}
+
+	pr_debug("Received event=%lld code=%d data_size=%d\n", ev->time,
+		 ev->code, ev->data_size);
+	karg->code = ev->code;
+	karg->time_label = ev->time;
+
+	if (ev->data_size > sizeof(karg->data)) {
+		pr_err("Event size %d is too big\n", ev->data_size);
+		ret = -ENOSPC;
+		/* If we can't copy all the data, we copy only part of it. */
+	}
+	memcpy(karg->data, ev->data, ev->data_size);
+	event_free(ev);
+
+	if (copy_to_user(uarg, karg, sizeof(struct blksnap_snapshot_event))) {
+		pr_err("Unable to get snapshot event. Invalid user buffer\n");
+		ret = -EINVAL;
+	}
+out:
+	kfree(karg);
+
+	return ret;
+}
+
+static long blksnap_ctrl_unlocked_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	void *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case IOCTL_BLKSNAP_VERSION:
+		return ioctl_version(argp);
+	case IOCTL_BLKSNAP_SNAPSHOT_CREATE:
+		return ioctl_snapshot_create(argp);
+	case IOCTL_BLKSNAP_SNAPSHOT_DESTROY:
+		return ioctl_snapshot_destroy(argp);
+	case IOCTL_BLKSNAP_SNAPSHOT_TAKE:
+		return ioctl_snapshot_take(argp);
+	case IOCTL_BLKSNAP_SNAPSHOT_COLLECT:
+		return ioctl_snapshot_collect(argp);
+	case IOCTL_BLKSNAP_SNAPSHOT_WAIT_EVENT:
+		return ioctl_snapshot_wait_event(argp);
+	default:
+		return -ENOTTY;
+	}
+
+}
+
+static const struct file_operations blksnap_ctrl_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= blksnap_ctrl_unlocked_ioctl,
+};
+
+static struct miscdevice blksnap_ctrl_misc = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= BLKSNAP_CTL,
+	.fops		= &blksnap_ctrl_fops,
+};
+
+static inline sector_t chunk_minimum_sectors(void)
+{
+	return (1ull << (chunk_minimum_shift - SECTOR_SHIFT));
+};
+
+static int __init parameters_init(void)
+{
+	pr_debug("tracking_block_minimum_shift: %d\n",
+		 tracking_block_minimum_shift);
+	pr_debug("tracking_block_maximum_shift: %d\n",
+		 tracking_block_maximum_shift);
+	pr_debug("tracking_block_maximum_count: %d\n",
+		 tracking_block_maximum_count);
+
+	pr_debug("chunk_minimum_shift: %d\n", chunk_minimum_shift);
+	pr_debug("chunk_maximum_shift: %d\n", chunk_maximum_shift);
+	pr_debug("chunk_maximum_count_shift: %u\n", chunk_maximum_count_shift);
+
+	pr_debug("chunk_maximum_in_queue: %d\n", chunk_maximum_in_queue);
+	pr_debug("free_diff_buffer_pool_size: %d\n",
+		 free_diff_buffer_pool_size);
+	pr_debug("diff_storage_minimum: %d\n", diff_storage_minimum);
+
+	if (tracking_block_maximum_shift < tracking_block_minimum_shift) {
+		tracking_block_maximum_shift = tracking_block_minimum_shift;
+		pr_warn("fixed tracking_block_maximum_shift: %d\n",
+			 tracking_block_maximum_shift);
+	}
+
+	if (chunk_minimum_shift < PAGE_SHIFT) {
+		chunk_minimum_shift = PAGE_SHIFT;
+		pr_warn("fixed chunk_minimum_shift: %d\n",
+			 chunk_minimum_shift);
+	}
+	if (chunk_maximum_shift < chunk_minimum_shift) {
+		chunk_maximum_shift = chunk_minimum_shift;
+		pr_warn("fixed chunk_maximum_shift: %d\n",
+			 chunk_maximum_shift);
+	}
+	if (diff_storage_minimum < (chunk_minimum_sectors() * 2)) {
+		diff_storage_minimum = chunk_minimum_sectors() * 2;
+		pr_warn("fixed diff_storage_minimum: %d\n",
+			 diff_storage_minimum);
+	}
+	if (diff_storage_minimum & (chunk_minimum_sectors() - 1)) {
+		diff_storage_minimum &= ~(chunk_minimum_sectors() - 1);
+		pr_warn("fixed diff_storage_minimum: %d\n",
+			 diff_storage_minimum);
+	}
+
+	return 0;
+}
+
+static int __init blksnap_init(void)
+{
+	int ret;
+
+	pr_debug("Loading\n");
+	pr_debug("Version: %s\n", VERSION_STR);
+
+	ret = parameters_init();
+	if (ret)
+		return ret;
+
+	ret = chunk_init();
+	if (ret)
+		goto fail_chunk_init;
+
+	ret = tracker_init();
+	if (ret)
+		goto fail_tracker_init;
+
+	ret = misc_register(&blksnap_ctrl_misc);
+	if (ret)
+		goto fail_misc_register;
+
+	return 0;
+
+fail_misc_register:
+	tracker_done();
+fail_tracker_init:
+	chunk_done();
+fail_chunk_init:
+
+	return ret;
+}
+
+static void __exit blksnap_exit(void)
+{
+	pr_debug("Unloading module\n");
+
+	misc_deregister(&blksnap_ctrl_misc);
+
+	chunk_done();
+	snapshot_done();
+	tracker_done();
+
+	pr_debug("Module was unloaded\n");
+}
+
+module_init(blksnap_init);
+module_exit(blksnap_exit);
+
+module_param_named(tracking_block_minimum_shift, tracking_block_minimum_shift,
+		   uint, 0644);
+MODULE_PARM_DESC(tracking_block_minimum_shift,
+		 "The power of 2 for minimum tracking block size");
+module_param_named(tracking_block_maximum_count, tracking_block_maximum_count,
+		   uint, 0644);
+MODULE_PARM_DESC(tracking_block_maximum_count,
+		 "The maximum number of tracking blocks");
+module_param_named(tracking_block_maximum_shift, tracking_block_maximum_shift,
+		   uint, 0644);
+MODULE_PARM_DESC(tracking_block_maximum_shift,
+		 "The power of 2 for maximum trackings block size");
+module_param_named(chunk_minimum_shift, chunk_minimum_shift, uint, 0644);
+MODULE_PARM_DESC(chunk_minimum_shift,
+		 "The power of 2 for minimum chunk size");
+module_param_named(chunk_maximum_count_shift, chunk_maximum_count_shift,
+		   uint, 0644);
+MODULE_PARM_DESC(chunk_maximum_count_shift,
+		 "The power of 2 for maximum number of chunks");
+module_param_named(chunk_maximum_shift, chunk_maximum_shift, uint, 0644);
+MODULE_PARM_DESC(chunk_maximum_shift,
+		 "The power of 2 for maximum snapshots chunk size");
+module_param_named(chunk_maximum_in_queue, chunk_maximum_in_queue, uint, 0644);
+MODULE_PARM_DESC(chunk_maximum_in_queue,
+		 "The maximum number of chunks in store queue");
+module_param_named(free_diff_buffer_pool_size, free_diff_buffer_pool_size,
+		   uint, 0644);
+MODULE_PARM_DESC(free_diff_buffer_pool_size,
+		 "The size of the pool of preallocated difference buffers");
+module_param_named(diff_storage_minimum, diff_storage_minimum, uint, 0644);
+MODULE_PARM_DESC(diff_storage_minimum,
+	"The minimum allowable size of the difference storage in sectors");
+
+MODULE_DESCRIPTION("Block Device Snapshots Module");
+MODULE_VERSION(VERSION_STR);
+MODULE_AUTHOR("Veeam Software Group GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/block/blksnap/params.h b/drivers/block/blksnap/params.h
new file mode 100644
index 000000000000..3ec4cce4de39
--- /dev/null
+++ b/drivers/block/blksnap/params.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_PARAMS_H
+#define __BLKSNAP_PARAMS_H
+
+unsigned int get_tracking_block_minimum_shift(void);
+unsigned int get_tracking_block_maximum_shift(void);
+unsigned int get_tracking_block_maximum_count(void);
+unsigned int get_chunk_minimum_shift(void);
+unsigned int get_chunk_maximum_shift(void);
+unsigned long get_chunk_maximum_count(void);
+unsigned int get_chunk_maximum_in_queue(void);
+unsigned int get_free_diff_buffer_pool_size(void);
+sector_t get_diff_storage_minimum(void);
+
+#endif /* __BLKSNAP_PARAMS_H */
-- 
2.20.1


