Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA84E7299B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbjFIMVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjFIMVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:21:40 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329E3583;
        Fri,  9 Jun 2023 05:21:37 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 7843841D63;
        Fri,  9 Jun 2023 08:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1686312188;
        bh=EO/SkXV19dass/HmzJL1BcRfUBYeuxs+ohaD556a/ZM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZizslHRjuXB5V271Sjrl8nLNybgZqWCPEF/cRh51+EVQpCQHAYlvzKDztqCI3QQvg
         yEgyMA7n8EFP3x296zasmrTDu9htHfErOjO+HxXFup7kuKiz5pA0SZsKUU8WLifQ6W
         wazfvH6fKN1nPXMgPd676CLCEp8Ri+fKaLB6pItUrxYVrCh/v9svigZJgEATtXuqb3
         gpg3X3j2Ph+av+6w4QQV/Xl3Ae9UkXIbO7CEfCPttvtJLfq6h9WQcjtNI54K1VgUT1
         mPSYYmCgi683WS870vsTPv973kCM0oscWdfWPn693iTnercgNOcND98hI/yRhV1ArO
         1UuhSG9uAfOxg==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 14:03:03 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <sergei.shtepa@veeam.com>
Subject: [PATCH v4 05/11] blksnap: module management interface functions
Date:   Fri, 9 Jun 2023 13:58:52 +0200
Message-ID: <20230609115858.4737-5-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230609115858.4737-1-sergei.shtepa@veeam.com>
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554627C6B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Contains callback functions for loading and unloading the module and
implementation of module management interface functions. The module
parameters and other mandatory declarations for the kernel module are
also defined.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 MAINTAINERS                    |   1 +
 drivers/block/blksnap/main.c   | 483 +++++++++++++++++++++++++++++++++
 drivers/block/blksnap/params.h |  16 ++
 3 files changed, 500 insertions(+)
 create mode 100644 drivers/block/blksnap/main.c
 create mode 100644 drivers/block/blksnap/params.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cbd551d3897..e306b729fd10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3597,6 +3597,7 @@ M:	Sergei Shtepa <sergei.shtepa@veeam.com>
 L:	linux-block@vger.kernel.org
 S:	Supported
 F:	Documentation/block/blksnap.rst
+F:	drivers/block/blksnap/*
 F:	include/uapi/linux/blksnap.h

 BLOCK LAYER
diff --git a/drivers/block/blksnap/main.c b/drivers/block/blksnap/main.c
new file mode 100644
index 000000000000..7bb37c191fda
--- /dev/null
+++ b/drivers/block/blksnap/main.c
@@ -0,0 +1,483 @@
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
+ * If we make the tracking block size small, we will get detailed information
+ * about the changes, but the size of the change tracker table will be too
+ * large, which will lead to inefficient memory usage.
+ */
+static unsigned int tracking_block_minimum_shift = 16;
+
+/*
+ * The maximum number of tracking blocks.
+ * A table is created to store information about the status of all tracking
+ * blocks in RAM. So, if the size of the tracking block is small, then the size
+ * of the table turns out to be large and memory is consumed inefficiently.
+ * As the size of the block device grows, the size of the tracking block
+ * size should also grow. For this purpose, the limit of the maximum
+ * number of block size is set.
+ */
+static unsigned int tracking_block_maximum_count = 2097152;
+
+/*
+ * The power of 2 for maximum tracking block size.
+ * On very large capacity disks, the block size may be too large. To prevent
+ * this, the maximum block size is limited.
+ * If the limit on the maximum block size has been reached, then the number of
+ * blocks may exceed the tracking_block_maximum_count.
+ */
+static unsigned int tracking_block_maximum_shift = 26;
+
+/*
+ * The power of 2 for minimum chunk size.
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
+ * To store information about the state of the chunks, a table is created
+ * in RAM. So, if the size of the chunk is small, then the size of the table
+ * turns out to be large and memory is consumed inefficiently.
+ * As the size of the block device grows, the size of the chunk should also
+ * grow. For this purpose, the maximum number of chunks is set.
+ * The table expands dynamically when new chunks are allocated. Therefore,
+ * memory consumption also depends on the intensity of writing to the block
+ * device under the snapshot.
+ */
+static unsigned int chunk_maximum_count_shift = 40;
+
+/*
+ * The power of 2 for maximum chunk size.
+ * On very large capacity disks, the block size may be too large. To prevent
+ * this, the maximum block size is limited.
+ * If the limit on the maximum block size has been reached, then the number of
+ * blocks may exceed the chunk_maximum_count.
+ */
+static unsigned int chunk_maximum_shift = 26;
+/*
+ * The maximum number of chunks in queue.
+ * The chunk is not immediately stored to the difference storage. The chunks
+ * are put in a store queue. The store queue allows to postpone the operation
+ * of storing a chunks data to the difference storage and perform it later in
+ * the worker thread.
+ */
+static unsigned int chunk_maximum_in_queue = 16;
+
+/*
+ * The size of the pool of preallocated difference buffers.
+ * A buffer can be allocated for each chunk. After use, this buffer is not
+ * released immediately, but is sent to the pool of free buffers.
+ * However, if there are too many free buffers in the pool, then these free
+ * buffers will be released immediately.
+ */
+static unsigned int free_diff_buffer_pool_size = 128;
+
+/*
+ * The minimum allowable size of the difference storage in sectors.
+ * The difference storage is a part of the disk space allocated for storing
+ * snapshot data. If there is less free space in the storage than the minimum,
+ * an event is generated about the lack of free space.
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
+	return (1ul << chunk_maximum_count_shift);
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
+unsigned int get_diff_storage_minimum(void)
+{
+	return diff_storage_minimum;
+}
+
+static int ioctl_version(unsigned long arg)
+{
+	struct blksnap_version __user *user_version =
+		(struct blksnap_version __user *)arg;
+
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
+static int ioctl_snapshot_create(unsigned long arg)
+{
+	struct blksnap_uuid __user *user_id = (struct blksnap_uuid __user *)arg;
+	uuid_t kernel_id;
+	int ret;
+
+	ret = snapshot_create(&kernel_id);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(user_id->b, kernel_id.b, sizeof(uuid_t))) {
+		pr_err("Unable to create snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int ioctl_snapshot_destroy(unsigned long arg)
+{
+	struct blksnap_uuid __user *user_id = (struct blksnap_uuid __user *)arg;
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
+static int ioctl_snapshot_append_storage(unsigned long arg)
+{
+	int ret;
+	struct blksnap_snapshot_append_storage __user *uarg =
+		(struct blksnap_snapshot_append_storage __user *)arg;
+	struct blksnap_snapshot_append_storage karg;
+	char *bdev_path = NULL;
+
+	pr_debug("Append difference storage\n");
+
+	if (copy_from_user(&karg, uarg, sizeof(karg))) {
+		pr_err("Unable to append difference storage: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	bdev_path = strndup_user(u64_to_user_ptr(karg.bdev_path),
+				 karg.bdev_path_size);
+	if (IS_ERR(bdev_path)) {
+		pr_err("Unable to append difference storage: invalid block device name buffer\n");
+		return PTR_ERR(bdev_path);
+	}
+
+	ret = snapshot_append_storage((uuid_t *)karg.id.b, bdev_path,
+				      u64_to_user_ptr(karg.ranges), karg.count);
+	kfree(bdev_path);
+	return ret;
+}
+
+static int ioctl_snapshot_take(unsigned long arg)
+{
+	struct blksnap_uuid __user *user_id = (struct blksnap_uuid __user *)arg;
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
+static int ioctl_snapshot_collect(unsigned long arg)
+{
+	int ret;
+	struct blksnap_snapshot_collect karg;
+
+	if (copy_from_user(&karg, (const void __user *)arg, sizeof(karg))) {
+		pr_err("Unable to collect available snapshots: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	ret = snapshot_collect(&karg.count, u64_to_user_ptr(karg.ids));
+
+	if (copy_to_user((void __user *)arg, &karg, sizeof(karg))) {
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
+static int ioctl_snapshot_wait_event(unsigned long arg)
+{
+	int ret = 0;
+	struct blksnap_snapshot_event __user *uarg =
+		(struct blksnap_snapshot_event __user *)arg;
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
+static int (*const blksnap_ioctl_table[])(unsigned long arg) = {
+	ioctl_version,
+	ioctl_snapshot_create,
+	ioctl_snapshot_destroy,
+	ioctl_snapshot_append_storage,
+	ioctl_snapshot_take,
+	ioctl_snapshot_collect,
+	ioctl_snapshot_wait_event,
+};
+
+static_assert(
+	sizeof(blksnap_ioctl_table) ==
+	((blksnap_ioctl_snapshot_wait_event + 1) * sizeof(void *)),
+	"The size of table blksnap_ioctl_table does not match the enum blksnap_ioctl.");
+
+static long ctrl_unlocked_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	int nr = _IOC_NR(cmd);
+
+	if (nr > (sizeof(blksnap_ioctl_table) / sizeof(void *)))
+		return -ENOTTY;
+
+	if (!blksnap_ioctl_table[nr])
+		return -ENOTTY;
+
+	return blksnap_ioctl_table[nr](arg);
+}
+
+static const struct file_operations blksnap_ctrl_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= ctrl_unlocked_ioctl,
+};
+
+static struct miscdevice blksnap_ctrl_misc = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= BLKSNAP_CTL,
+	.fops		= &blksnap_ctrl_fops,
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
+	if (chunk_maximum_shift < chunk_minimum_shift) {
+		chunk_maximum_shift = chunk_minimum_shift;
+		pr_warn("fixed chunk_maximum_shift: %d\n",
+			 chunk_maximum_shift);
+	}
+
+	/*
+	 * The XArray is used to store chunks. And 'unsigned long' is used as
+	 * chunk number parameter. So, The number of chunks cannot exceed the
+	 * limits of ULONG_MAX.
+	 */
+	if (sizeof(unsigned long) < 4u)
+		chunk_maximum_count_shift = min(16u, chunk_maximum_count_shift);
+	else if (sizeof(unsigned long) == 4)
+		chunk_maximum_count_shift = min(32u, chunk_maximum_count_shift);
+	else if (sizeof(unsigned long) >= 8)
+		chunk_maximum_count_shift = min(64u, chunk_maximum_count_shift);
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
index 000000000000..85606e1a8746
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
+unsigned int get_diff_storage_minimum(void);
+
+#endif /* __BLKSNAP_PARAMS_H */
--
2.20.1

