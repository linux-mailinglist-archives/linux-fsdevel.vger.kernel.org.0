Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5D294A41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437428AbgJUJNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 05:13:34 -0400
Received: from mx2.veeam.com ([64.129.123.6]:43094 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437395AbgJUJNe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:13:34 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 05:13:19 EDT
Received: from mail.veeam.com (spbmbx01.amust.local [172.17.17.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id DB942414B3;
        Wed, 21 Oct 2020 05:04:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1603271083; bh=ymx9F+QLBONpq0flzoJaNbbZKTBYTLRblehVnE9o2RE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=zV4R5ODH9Xg2jgnQcnMsTF4PYrboJ+NIfGA6bn0JdT5IJ1DtMc/cQFI6DRv+6O1Qa
         9KYVhY34G8wqwlY2DOonQO7Ro95+naBAF/mYJL5/zmZNzbA3tVwFhJMHQUYoGG7sJT
         jyc2/E5KjqkrjfX6xrtkcyDBxrZnAqMmFlzSwZpg=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 spbmbx01.amust.local (172.17.17.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.595.3;
 Wed, 21 Oct 2020 12:04:34 +0300
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
Subject: [PATCH 2/2] blk-snap - snapshots and change-tracking for block devices
Date:   Wed, 21 Oct 2020 12:04:09 +0300
Message-ID: <1603271049-20681-3-git-send-email-sergei.shtepa@veeam.com>
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
 drivers/block/Kconfig                       |   2 +
 drivers/block/Makefile                      |   1 +
 drivers/block/blk-snap/Kconfig              |  24 +
 drivers/block/blk-snap/Makefile             |  28 +
 drivers/block/blk-snap/big_buffer.c         | 193 ++++
 drivers/block/blk-snap/big_buffer.h         |  24 +
 drivers/block/blk-snap/blk-snap-ctl.h       | 190 ++++
 drivers/block/blk-snap/blk_deferred.c       | 566 +++++++++++
 drivers/block/blk-snap/blk_deferred.h       |  67 ++
 drivers/block/blk-snap/blk_descr_file.c     |  82 ++
 drivers/block/blk-snap/blk_descr_file.h     |  26 +
 drivers/block/blk-snap/blk_descr_mem.c      |  66 ++
 drivers/block/blk-snap/blk_descr_mem.h      |  14 +
 drivers/block/blk-snap/blk_descr_multidev.c |  86 ++
 drivers/block/blk-snap/blk_descr_multidev.h |  25 +
 drivers/block/blk-snap/blk_descr_pool.c     | 190 ++++
 drivers/block/blk-snap/blk_descr_pool.h     |  38 +
 drivers/block/blk-snap/blk_redirect.c       | 507 ++++++++++
 drivers/block/blk-snap/blk_redirect.h       |  73 ++
 drivers/block/blk-snap/blk_util.c           |  33 +
 drivers/block/blk-snap/blk_util.h           |  33 +
 drivers/block/blk-snap/cbt_map.c            | 210 +++++
 drivers/block/blk-snap/cbt_map.h            |  62 ++
 drivers/block/blk-snap/common.h             |  31 +
 drivers/block/blk-snap/ctrl_fops.c          | 691 ++++++++++++++
 drivers/block/blk-snap/ctrl_fops.h          |  19 +
 drivers/block/blk-snap/ctrl_pipe.c          | 562 +++++++++++
 drivers/block/blk-snap/ctrl_pipe.h          |  34 +
 drivers/block/blk-snap/ctrl_sysfs.c         |  73 ++
 drivers/block/blk-snap/ctrl_sysfs.h         |   5 +
 drivers/block/blk-snap/defer_io.c           | 397 ++++++++
 drivers/block/blk-snap/defer_io.h           |  39 +
 drivers/block/blk-snap/main.c               |  82 ++
 drivers/block/blk-snap/params.c             |  58 ++
 drivers/block/blk-snap/params.h             |  29 +
 drivers/block/blk-snap/rangevector.c        |  85 ++
 drivers/block/blk-snap/rangevector.h        |  31 +
 drivers/block/blk-snap/snapimage.c          | 982 ++++++++++++++++++++
 drivers/block/blk-snap/snapimage.h          |  16 +
 drivers/block/blk-snap/snapshot.c           | 225 +++++
 drivers/block/blk-snap/snapshot.h           |  17 +
 drivers/block/blk-snap/snapstore.c          | 929 ++++++++++++++++++
 drivers/block/blk-snap/snapstore.h          |  68 ++
 drivers/block/blk-snap/snapstore_device.c   | 532 +++++++++++
 drivers/block/blk-snap/snapstore_device.h   |  63 ++
 drivers/block/blk-snap/snapstore_file.c     |  52 ++
 drivers/block/blk-snap/snapstore_file.h     |  15 +
 drivers/block/blk-snap/snapstore_mem.c      |  91 ++
 drivers/block/blk-snap/snapstore_mem.h      |  20 +
 drivers/block/blk-snap/snapstore_multidev.c | 118 +++
 drivers/block/blk-snap/snapstore_multidev.h |  22 +
 drivers/block/blk-snap/tracker.c            | 449 +++++++++
 drivers/block/blk-snap/tracker.h            |  38 +
 drivers/block/blk-snap/tracking.c           | 270 ++++++
 drivers/block/blk-snap/tracking.h           |  13 +
 drivers/block/blk-snap/version.h            |   7 +
 56 files changed, 8603 insertions(+)
 create mode 100644 drivers/block/blk-snap/Kconfig
 create mode 100644 drivers/block/blk-snap/Makefile
 create mode 100644 drivers/block/blk-snap/big_buffer.c
 create mode 100644 drivers/block/blk-snap/big_buffer.h
 create mode 100644 drivers/block/blk-snap/blk-snap-ctl.h
 create mode 100644 drivers/block/blk-snap/blk_deferred.c
 create mode 100644 drivers/block/blk-snap/blk_deferred.h
 create mode 100644 drivers/block/blk-snap/blk_descr_file.c
 create mode 100644 drivers/block/blk-snap/blk_descr_file.h
 create mode 100644 drivers/block/blk-snap/blk_descr_mem.c
 create mode 100644 drivers/block/blk-snap/blk_descr_mem.h
 create mode 100644 drivers/block/blk-snap/blk_descr_multidev.c
 create mode 100644 drivers/block/blk-snap/blk_descr_multidev.h
 create mode 100644 drivers/block/blk-snap/blk_descr_pool.c
 create mode 100644 drivers/block/blk-snap/blk_descr_pool.h
 create mode 100644 drivers/block/blk-snap/blk_redirect.c
 create mode 100644 drivers/block/blk-snap/blk_redirect.h
 create mode 100644 drivers/block/blk-snap/blk_util.c
 create mode 100644 drivers/block/blk-snap/blk_util.h
 create mode 100644 drivers/block/blk-snap/cbt_map.c
 create mode 100644 drivers/block/blk-snap/cbt_map.h
 create mode 100644 drivers/block/blk-snap/common.h
 create mode 100644 drivers/block/blk-snap/ctrl_fops.c
 create mode 100644 drivers/block/blk-snap/ctrl_fops.h
 create mode 100644 drivers/block/blk-snap/ctrl_pipe.c
 create mode 100644 drivers/block/blk-snap/ctrl_pipe.h
 create mode 100644 drivers/block/blk-snap/ctrl_sysfs.c
 create mode 100644 drivers/block/blk-snap/ctrl_sysfs.h
 create mode 100644 drivers/block/blk-snap/defer_io.c
 create mode 100644 drivers/block/blk-snap/defer_io.h
 create mode 100644 drivers/block/blk-snap/main.c
 create mode 100644 drivers/block/blk-snap/params.c
 create mode 100644 drivers/block/blk-snap/params.h
 create mode 100644 drivers/block/blk-snap/rangevector.c
 create mode 100644 drivers/block/blk-snap/rangevector.h
 create mode 100644 drivers/block/blk-snap/snapimage.c
 create mode 100644 drivers/block/blk-snap/snapimage.h
 create mode 100644 drivers/block/blk-snap/snapshot.c
 create mode 100644 drivers/block/blk-snap/snapshot.h
 create mode 100644 drivers/block/blk-snap/snapstore.c
 create mode 100644 drivers/block/blk-snap/snapstore.h
 create mode 100644 drivers/block/blk-snap/snapstore_device.c
 create mode 100644 drivers/block/blk-snap/snapstore_device.h
 create mode 100644 drivers/block/blk-snap/snapstore_file.c
 create mode 100644 drivers/block/blk-snap/snapstore_file.h
 create mode 100644 drivers/block/blk-snap/snapstore_mem.c
 create mode 100644 drivers/block/blk-snap/snapstore_mem.h
 create mode 100644 drivers/block/blk-snap/snapstore_multidev.c
 create mode 100644 drivers/block/blk-snap/snapstore_multidev.h
 create mode 100644 drivers/block/blk-snap/tracker.c
 create mode 100644 drivers/block/blk-snap/tracker.h
 create mode 100644 drivers/block/blk-snap/tracking.c
 create mode 100644 drivers/block/blk-snap/tracking.h
 create mode 100644 drivers/block/blk-snap/version.h

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ecceaaa1a66f..c53ef661110f 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -460,4 +460,6 @@ config BLK_DEV_RSXX
 
 source "drivers/block/rnbd/Kconfig"
 
+source "drivers/block/blk-snap/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index e1f63117ee94..312000598944 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
+obj-$(CONFIG_BLK_SNAP)	+= blk-snap/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs	:= null_blk_main.o
diff --git a/drivers/block/blk-snap/Kconfig b/drivers/block/blk-snap/Kconfig
new file mode 100644
index 000000000000..7a2db99a80dd
--- /dev/null
+++ b/drivers/block/blk-snap/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# blk-snap block io layer filter module configuration
+#
+#
+#select BLK_FILTER
+
+config BLK_SNAP
+	tristate "Block device snapshot filter"
+	depends on BLK_FILTER
+	help
+
+	  Allow to create snapshots and track block changes for a block
+	  devices. Designed for creating backups for any block devices
+	  (without device mapper). Snapshots are temporary and are released
+	  then backup is completed. Change block tracking allows you to
+	  create incremental or differential backups.
+
+config BLK_SNAP_SNAPSTORE_MULTIDEV
+	bool "Multi device snapstore configuration support"
+	depends on BLK_SNAP
+	help
+
+	  Allow to create snapstore on multiple block devices.
diff --git a/drivers/block/blk-snap/Makefile b/drivers/block/blk-snap/Makefile
new file mode 100644
index 000000000000..1d628e8e1862
--- /dev/null
+++ b/drivers/block/blk-snap/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+blk-snap-y += blk_deferred.o
+blk-snap-y += blk_descr_file.o
+blk-snap-y += blk_descr_mem.o
+blk-snap-y += blk_descr_multidev.o
+blk-snap-y += blk_descr_pool.o
+blk-snap-y += blk_redirect.o
+blk-snap-y += blk_util.o
+blk-snap-y += cbt_map.o
+blk-snap-y += ctrl_fops.o
+blk-snap-y += ctrl_pipe.o
+blk-snap-y += ctrl_sysfs.o
+blk-snap-y += defer_io.o
+blk-snap-y += main.o
+blk-snap-y += params.o
+blk-snap-y += big_buffer.o
+blk-snap-y += rangevector.o
+blk-snap-y += snapimage.o
+blk-snap-y += snapshot.o
+blk-snap-y += snapstore.o
+blk-snap-y += snapstore_device.o
+blk-snap-y += snapstore_file.o
+blk-snap-y += snapstore_mem.o
+blk-snap-y += snapstore_multidev.o
+blk-snap-y += tracker.o
+blk-snap-y += tracking.o
+
+obj-$(CONFIG_BLK_SNAP)	 += blk-snap.o
diff --git a/drivers/block/blk-snap/big_buffer.c b/drivers/block/blk-snap/big_buffer.c
new file mode 100644
index 000000000000..c0a75255a807
--- /dev/null
+++ b/drivers/block/blk-snap/big_buffer.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+#include <linux/mm.h>
+#include "big_buffer.h"
+
+static inline size_t page_count_calc(size_t buffer_size)
+{
+	size_t page_count = buffer_size / PAGE_SIZE;
+
+	if (buffer_size & (PAGE_SIZE - 1))
+		page_count += 1;
+	return page_count;
+}
+
+struct big_buffer *big_buffer_alloc(size_t buffer_size, int gfp_opt)
+{
+	int res = SUCCESS;
+	struct big_buffer *bbuff;
+	size_t count;
+	size_t inx;
+
+	count = page_count_calc(buffer_size);
+
+	bbuff = kzalloc(sizeof(struct big_buffer) + count * sizeof(void *), gfp_opt);
+	if (bbuff == NULL)
+		return NULL;
+
+	bbuff->pg_cnt = count;
+	for (inx = 0; inx < bbuff->pg_cnt; ++inx) {
+		struct page *pg = alloc_page(gfp_opt);
+
+		if (!pg) {
+			res = -ENOMEM;
+			break;
+		}
+		bbuff->pg[inx] = page_address(pg);
+	}
+
+	if (res != SUCCESS) {
+		big_buffer_free(bbuff);
+		return NULL;
+	}
+
+	return bbuff;
+}
+
+void big_buffer_free(struct big_buffer *bbuff)
+{
+	size_t inx;
+	size_t count = bbuff->pg_cnt;
+
+	if (bbuff == NULL)
+		return;
+
+	for (inx = 0; inx < count; ++inx)
+		if (bbuff->pg[inx] != NULL)
+			free_page((unsigned long)bbuff->pg[inx]);
+
+	kfree(bbuff);
+}
+
+size_t big_buffer_copy_to_user(char __user *dst_user, size_t offset, struct big_buffer *bbuff,
+			       size_t length)
+{
+	size_t left_data_length;
+	int page_inx = offset / PAGE_SIZE;
+	size_t processed_len = 0;
+	size_t unordered = offset & (PAGE_SIZE - 1);
+
+	if (unordered != 0) { //first
+		size_t page_len = min_t(size_t, (PAGE_SIZE - unordered), length);
+
+		left_data_length = copy_to_user(dst_user + processed_len,
+						bbuff->pg[page_inx] + unordered, page_len);
+		if (left_data_length != 0) {
+			pr_err("Failed to copy data from big_buffer to user buffer\n");
+			return processed_len;
+		}
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	while ((processed_len < length) && (page_inx < bbuff->pg_cnt)) {
+		size_t page_len = min_t(size_t, PAGE_SIZE, (length - processed_len));
+
+		left_data_length =
+			copy_to_user(dst_user + processed_len, bbuff->pg[page_inx], page_len);
+		if (left_data_length != 0) {
+			pr_err("Failed to copy data from big_buffer to user buffer\n");
+			break;
+		}
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	return processed_len;
+}
+
+size_t big_buffer_copy_from_user(const char __user *src_user, size_t offset,
+				 struct big_buffer *bbuff, size_t length)
+{
+	size_t left_data_length;
+	int page_inx = offset / PAGE_SIZE;
+	size_t processed_len = 0;
+	size_t unordered = offset & (PAGE_SIZE - 1);
+
+	if (unordered != 0) { //first
+		size_t page_len = min_t(size_t, (PAGE_SIZE - unordered), length);
+
+		left_data_length = copy_from_user(bbuff->pg[page_inx] + unordered,
+						  src_user + processed_len, page_len);
+		if (left_data_length != 0) {
+			pr_err("Failed to copy data from user buffer to big_buffer\n");
+			return processed_len;
+		}
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	while ((processed_len < length) && (page_inx < bbuff->pg_cnt)) {
+		size_t page_len = min_t(size_t, PAGE_SIZE, (length - processed_len));
+
+		left_data_length =
+			copy_from_user(bbuff->pg[page_inx], src_user + processed_len, page_len);
+		if (left_data_length != 0) {
+			pr_err("Failed to copy data from user buffer to big_buffer\n");
+			break;
+		}
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	return processed_len;
+}
+
+void *big_buffer_get_element(struct big_buffer *bbuff, size_t index, size_t sizeof_element)
+{
+	size_t elements_in_page = PAGE_SIZE / sizeof_element;
+	size_t pg_inx = index / elements_in_page;
+	size_t pg_ofs = (index - (pg_inx * elements_in_page)) * sizeof_element;
+
+	if (pg_inx >= bbuff->pg_cnt)
+		return NULL;
+
+	return bbuff->pg[pg_inx] + pg_ofs;
+}
+
+void big_buffer_memset(struct big_buffer *bbuff, int value)
+{
+	size_t inx;
+
+	for (inx = 0; inx < bbuff->pg_cnt; ++inx)
+		memset(bbuff->pg[inx], value, PAGE_SIZE);
+}
+
+void big_buffer_memcpy(struct big_buffer *dst, struct big_buffer *src)
+{
+	size_t inx;
+	size_t count = min_t(size_t, dst->pg_cnt, src->pg_cnt);
+
+	for (inx = 0; inx < count; ++inx)
+		memcpy(dst->pg[inx], src->pg[inx], PAGE_SIZE);
+}
+
+int big_buffer_byte_get(struct big_buffer *bbuff, size_t inx, u8 *value)
+{
+	size_t page_inx = inx >> PAGE_SHIFT;
+	size_t byte_pos = inx & (PAGE_SIZE - 1);
+
+	if (page_inx >= bbuff->pg_cnt)
+		return -ENODATA;
+
+	*value = bbuff->pg[page_inx][byte_pos];
+
+	return SUCCESS;
+}
+
+int big_buffer_byte_set(struct big_buffer *bbuff, size_t inx, u8 value)
+{
+	size_t page_inx = inx >> PAGE_SHIFT;
+	size_t byte_pos = inx & (PAGE_SIZE - 1);
+
+	if (page_inx >= bbuff->pg_cnt)
+		return -ENODATA;
+
+	bbuff->pg[page_inx][byte_pos] = value;
+
+	return SUCCESS;
+}
diff --git a/drivers/block/blk-snap/big_buffer.h b/drivers/block/blk-snap/big_buffer.h
new file mode 100644
index 000000000000..f38ab5288b05
--- /dev/null
+++ b/drivers/block/blk-snap/big_buffer.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+struct big_buffer {
+	size_t pg_cnt;
+	u8 *pg[0];
+};
+
+struct big_buffer *big_buffer_alloc(size_t count, int gfp_opt);
+void big_buffer_free(struct big_buffer *bbuff);
+
+size_t big_buffer_copy_to_user(char __user *dst_user_buffer, size_t offset,
+			       struct big_buffer *bbuff, size_t length);
+size_t big_buffer_copy_from_user(const char __user *src_user_buffer, size_t offset,
+				 struct big_buffer *bbuff, size_t length);
+
+void *big_buffer_get_element(struct big_buffer *bbuff, size_t index, size_t sizeof_element);
+
+void big_buffer_memset(struct big_buffer *bbuff, int value);
+void big_buffer_memcpy(struct big_buffer *dst, struct big_buffer *src);
+
+//byte access
+int big_buffer_byte_get(struct big_buffer *bbuff, size_t inx, u8 *value);
+int big_buffer_byte_set(struct big_buffer *bbuff, size_t inx, u8 value);
diff --git a/drivers/block/blk-snap/blk-snap-ctl.h b/drivers/block/blk-snap/blk-snap-ctl.h
new file mode 100644
index 000000000000..4ffd836836b1
--- /dev/null
+++ b/drivers/block/blk-snap/blk-snap-ctl.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#define MODULE_NAME "blk-snap"
+#define SNAP_IMAGE_NAME "blk-snap-image"
+
+#define SUCCESS 0
+
+#define MAX_TRACKING_DEVICE_COUNT 256
+
+#define BLK_SNAP 'V'
+
+#pragma pack(push, 1)
+//////////////////////////////////////////////////////////////////////////
+// version
+
+#define BLK_SNAP_COMPATIBILITY_SNAPSTORE 0x0000000000000001ull /* rudiment */
+//#define BLK_SNAP_COMPATIBILITY_BTRFS	 0x0000000000000002ull /* rudiment */
+#define BLK_SNAP_COMPATIBILITY_MULTIDEV 0x0000000000000004ull
+
+struct ioctl_compatibility_flags_s {
+	unsigned long long flags;
+};
+#define IOCTL_COMPATIBILITY_FLAGS _IOW(BLK_SNAP, 0, struct ioctl_compatibility_flags_s)
+
+struct ioctl_getversion_s {
+	unsigned short major;
+	unsigned short minor;
+	unsigned short revision;
+	unsigned short build;
+};
+#define IOCTL_GETVERSION _IOW(BLK_SNAP, 1, struct ioctl_getversion_s)
+
+//////////////////////////////////////////////////////////////////////////
+// tracking
+struct ioctl_dev_id_s {
+	int major;
+	int minor;
+};
+#define IOCTL_TRACKING_ADD _IOW(BLK_SNAP, 2, struct ioctl_dev_id_s)
+
+#define IOCTL_TRACKING_REMOVE _IOW(BLK_SNAP, 3, struct ioctl_dev_id_s)
+
+struct cbt_info_s {
+	struct ioctl_dev_id_s dev_id;
+	unsigned long long dev_capacity;
+	unsigned int cbt_map_size;
+	unsigned char snap_number;
+	unsigned char generationId[16];
+};
+struct ioctl_tracking_collect_s {
+	unsigned int count;
+	union {
+		struct cbt_info_s *p_cbt_info;
+		unsigned long long ull_cbt_info;
+	};
+};
+#define IOCTL_TRACKING_COLLECT _IOW(BLK_SNAP, 4, struct ioctl_tracking_collect_s)
+
+#define IOCTL_TRACKING_BLOCK_SIZE _IOW(BLK_SNAP, 5, unsigned int)
+
+struct ioctl_tracking_read_cbt_bitmap_s {
+	struct ioctl_dev_id_s dev_id;
+	unsigned int offset;
+	unsigned int length;
+	union {
+		unsigned char *buff;
+		unsigned long long ull_buff;
+	};
+};
+#define IOCTL_TRACKING_READ_CBT_BITMAP _IOR(BLK_SNAP, 6, struct ioctl_tracking_read_cbt_bitmap_s)
+
+struct block_range_s {
+	unsigned long long ofs; //sectors
+	unsigned long long cnt; //sectors
+};
+
+struct ioctl_tracking_mark_dirty_blocks_s {
+	struct ioctl_dev_id_s image_dev_id;
+	unsigned int count;
+	union {
+		struct block_range_s *p_dirty_blocks;
+		unsigned long long ull_dirty_blocks;
+	};
+};
+#define IOCTL_TRACKING_MARK_DIRTY_BLOCKS                                                           \
+	_IOR(BLK_SNAP, 7, struct ioctl_tracking_mark_dirty_blocks_s)
+//////////////////////////////////////////////////////////////////////////
+// snapshot
+
+struct ioctl_snapshot_create_s {
+	unsigned long long snapshot_id;
+	unsigned int count;
+	union {
+		struct ioctl_dev_id_s *p_dev_id;
+		unsigned long long ull_dev_id;
+	};
+};
+#define IOCTL_SNAPSHOT_CREATE _IOW(BLK_SNAP, 0x10, struct ioctl_snapshot_create_s)
+
+#define IOCTL_SNAPSHOT_DESTROY _IOR(BLK_SNAP, 0x11, unsigned long long)
+
+struct ioctl_snapshot_errno_s {
+	struct ioctl_dev_id_s dev_id;
+	int err_code;
+};
+#define IOCTL_SNAPSHOT_ERRNO _IOW(BLK_SNAP, 0x12, struct ioctl_snapshot_errno_s)
+
+struct ioctl_range_s {
+	unsigned long long left;
+	unsigned long long right;
+};
+
+//////////////////////////////////////////////////////////////////////////
+// snapstore
+struct ioctl_snapstore_create_s {
+	unsigned char id[16];
+	struct ioctl_dev_id_s snapstore_dev_id;
+	unsigned int count;
+	union {
+		struct ioctl_dev_id_s *p_dev_id;
+		unsigned long long ull_dev_id;
+	};
+};
+#define IOCTL_SNAPSTORE_CREATE _IOR(BLK_SNAP, 0x28, struct ioctl_snapstore_create_s)
+
+struct ioctl_snapstore_file_add_s {
+	unsigned char id[16];
+	unsigned int range_count;
+	union {
+		struct ioctl_range_s *ranges;
+		unsigned long long ull_ranges;
+	};
+};
+#define IOCTL_SNAPSTORE_FILE _IOR(BLK_SNAP, 0x29, struct ioctl_snapstore_file_add_s)
+
+struct ioctl_snapstore_memory_limit_s {
+	unsigned char id[16];
+	unsigned long long size;
+};
+#define IOCTL_SNAPSTORE_MEMORY _IOR(BLK_SNAP, 0x2A, struct ioctl_snapstore_memory_limit_s)
+
+struct ioctl_snapstore_cleanup_s {
+	unsigned char id[16];
+	unsigned long long filled_bytes;
+};
+#define IOCTL_SNAPSTORE_CLEANUP _IOW(BLK_SNAP, 0x2B, struct ioctl_snapstore_cleanup_s)
+
+struct ioctl_snapstore_file_add_multidev_s {
+	unsigned char id[16];
+	struct ioctl_dev_id_s dev_id;
+	unsigned int range_count;
+	union {
+		struct ioctl_range_s *ranges;
+		unsigned long long ull_ranges;
+	};
+};
+#define IOCTL_SNAPSTORE_FILE_MULTIDEV                                                              \
+	_IOR(BLK_SNAP, 0x2C, struct ioctl_snapstore_file_add_multidev_s)
+//////////////////////////////////////////////////////////////////////////
+// collect snapshot images
+
+struct image_info_s {
+	struct ioctl_dev_id_s original_dev_id;
+	struct ioctl_dev_id_s snapshot_dev_id;
+};
+
+struct ioctl_collect_snapshot_images_s {
+	int count; //
+	union {
+		struct image_info_s *p_image_info;
+		unsigned long long ull_image_info;
+	};
+};
+#define IOCTL_COLLECT_SNAPSHOT_IMAGES _IOW(BLK_SNAP, 0x30, struct ioctl_collect_snapshot_images_s)
+
+#pragma pack(pop)
+
+// commands for character device interface
+#define BLK_SNAP_CHARCMD_UNDEFINED 0x00
+#define BLK_SNAP_CHARCMD_ACKNOWLEDGE 0x01
+#define BLK_SNAP_CHARCMD_INVALID 0xFF
+// to module commands
+#define BLK_SNAP_CHARCMD_INITIATE 0x21
+#define BLK_SNAP_CHARCMD_NEXT_PORTION 0x22
+#define BLK_SNAP_CHARCMD_NEXT_PORTION_MULTIDEV 0x23
+// from module commands
+#define BLK_SNAP_CHARCMD_HALFFILL 0x41
+#define BLK_SNAP_CHARCMD_OVERFLOW 0x42
+#define BLK_SNAP_CHARCMD_TERMINATE 0x43
diff --git a/drivers/block/blk-snap/blk_deferred.c b/drivers/block/blk-snap/blk_deferred.c
new file mode 100644
index 000000000000..1d0b7d2c4d71
--- /dev/null
+++ b/drivers/block/blk-snap/blk_deferred.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-deferred"
+#include "common.h"
+
+#include "blk_deferred.h"
+#include "blk_util.h"
+#include "snapstore.h"
+#include "params.h"
+
+struct bio_set blk_deferred_bioset = { 0 };
+
+struct dio_bio_complete {
+	struct blk_deferred_request *dio_req;
+	sector_t bio_sect_len;
+};
+
+struct dio_deadlocked_list {
+	struct list_head link;
+
+	struct blk_deferred_request *dio_req;
+};
+
+LIST_HEAD(dio_deadlocked_list);
+DEFINE_RWLOCK(dio_deadlocked_list_lock);
+
+atomic64_t dio_alloc_count = ATOMIC64_INIT(0);
+atomic64_t dio_free_count = ATOMIC64_INIT(0);
+
+void blk_deferred_done(void)
+{
+	struct dio_deadlocked_list *dio_locked;
+
+	do {
+		dio_locked = NULL;
+
+		write_lock(&dio_deadlocked_list_lock);
+		if (!list_empty(&dio_deadlocked_list)) {
+			dio_locked = list_entry(dio_deadlocked_list.next,
+						struct dio_deadlocked_list, link);
+
+			list_del(&dio_locked->link);
+		}
+		write_unlock(&dio_deadlocked_list_lock);
+
+		if (dio_locked) {
+			if (dio_locked->dio_req->sect_len ==
+			    atomic64_read(&dio_locked->dio_req->sect_processed))
+				blk_deferred_request_free(dio_locked->dio_req);
+			else
+				pr_err("Locked defer IO is still in memory\n");
+
+			kfree(dio_locked);
+		}
+	} while (dio_locked);
+}
+
+void blk_deferred_request_deadlocked(struct blk_deferred_request *dio_req)
+{
+	struct dio_deadlocked_list *dio_locked =
+		kzalloc(sizeof(struct dio_deadlocked_list), GFP_KERNEL);
+
+	dio_locked->dio_req = dio_req;
+
+	write_lock(&dio_deadlocked_list_lock);
+	list_add_tail(&dio_locked->link, &dio_deadlocked_list);
+	write_unlock(&dio_deadlocked_list_lock);
+
+	pr_warn("Deadlock with defer IO\n");
+}
+
+void blk_deferred_free(struct blk_deferred_io *dio)
+{
+	size_t inx = 0;
+
+	if (dio->page_array != NULL) {
+		while (dio->page_array[inx] != NULL) {
+			__free_page(dio->page_array[inx]);
+			dio->page_array[inx] = NULL;
+
+			++inx;
+		}
+
+		kfree(dio->page_array);
+		dio->page_array = NULL;
+	}
+	kfree(dio);
+}
+
+struct blk_deferred_io *blk_deferred_alloc(unsigned long block_index,
+					   union blk_descr_unify blk_descr)
+{
+	size_t inx;
+	size_t page_count;
+	struct blk_deferred_io *dio = kmalloc(sizeof(struct blk_deferred_io), GFP_NOIO);
+
+	if (dio == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&dio->link);
+
+	dio->blk_descr = blk_descr;
+	dio->blk_index = block_index;
+
+	dio->sect.ofs = block_index << snapstore_block_shift();
+	dio->sect.cnt = snapstore_block_size();
+
+	page_count = snapstore_block_size() / (PAGE_SIZE / SECTOR_SIZE);
+	/*
+	 * empty pointer on the end
+	 */
+	dio->page_array = kzalloc((page_count + 1) * sizeof(struct page *), GFP_NOIO);
+	if (dio->page_array == NULL) {
+		blk_deferred_free(dio);
+		return NULL;
+	}
+
+	for (inx = 0; inx < page_count; inx++) {
+		dio->page_array[inx] = alloc_page(GFP_NOIO);
+		if (dio->page_array[inx] == NULL) {
+			pr_err("Failed to allocate page\n");
+			blk_deferred_free(dio);
+			return NULL;
+		}
+	}
+
+	return dio;
+}
+
+int blk_deferred_bioset_create(void)
+{
+	return bioset_init(&blk_deferred_bioset, 64, sizeof(struct dio_bio_complete),
+			   BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
+}
+
+void blk_deferred_bioset_free(void)
+{
+	bioset_exit(&blk_deferred_bioset);
+}
+
+struct bio *_blk_deferred_bio_alloc(int nr_iovecs)
+{
+	struct bio *new_bio = bio_alloc_bioset(GFP_NOIO, nr_iovecs, &blk_deferred_bioset);
+
+	if (new_bio == NULL)
+		return NULL;
+
+	new_bio->bi_end_io = blk_deferred_bio_endio;
+	new_bio->bi_private = ((void *)new_bio) - sizeof(struct dio_bio_complete);
+
+	return new_bio;
+}
+
+static void blk_deferred_complete(struct blk_deferred_request *dio_req, sector_t portion_sect_cnt,
+				  int result)
+{
+	atomic64_add(portion_sect_cnt, &dio_req->sect_processed);
+
+	if (dio_req->sect_len == atomic64_read(&dio_req->sect_processed))
+		complete(&dio_req->complete);
+
+	if (result != SUCCESS) {
+		dio_req->result = result;
+		pr_err("Failed to process defer IO request. errno=%d\n", result);
+	}
+}
+
+void blk_deferred_bio_endio(struct bio *bio)
+{
+	int local_err;
+	struct dio_bio_complete *complete_param = (struct dio_bio_complete *)bio->bi_private;
+
+	if (complete_param == NULL) {
+		//bio already complete
+	} else {
+		if (bio->bi_status != BLK_STS_OK)
+			local_err = -EIO;
+		else
+			local_err = SUCCESS;
+
+		blk_deferred_complete(complete_param->dio_req, complete_param->bio_sect_len,
+				      local_err);
+		bio->bi_private = NULL;
+	}
+
+	bio_put(bio);
+}
+
+static inline size_t _page_count_calculate(sector_t size_sector)
+{
+	size_t page_count = size_sector / (PAGE_SIZE / SECTOR_SIZE);
+
+	if (unlikely(size_sector & ((PAGE_SIZE / SECTOR_SIZE) - 1)))
+		page_count += 1;
+
+	return page_count;
+}
+
+sector_t _blk_deferred_submit_pages(struct block_device *blk_dev,
+				    struct blk_deferred_request *dio_req, int direction,
+				    sector_t arr_ofs, struct page **page_array, sector_t ofs_sector,
+				    sector_t size_sector)
+{
+	struct bio *bio = NULL;
+	int nr_iovecs;
+	int page_inx = arr_ofs >> (PAGE_SHIFT - SECTOR_SHIFT);
+	sector_t process_sect = 0;
+
+	nr_iovecs = _page_count_calculate(size_sector);
+
+	while (NULL == (bio = _blk_deferred_bio_alloc(nr_iovecs))) {
+		size_sector = (size_sector >> 1) & ~((PAGE_SIZE / SECTOR_SIZE) - 1);
+		if (size_sector == 0)
+			return 0;
+
+		nr_iovecs = _page_count_calculate(size_sector);
+	}
+
+	bio_set_dev(bio, blk_dev);
+
+	if (direction == READ)
+		bio_set_op_attrs(bio, REQ_OP_READ, 0);
+	else
+		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+
+	bio->bi_iter.bi_sector = ofs_sector;
+
+	{ //add first
+		sector_t unordered = arr_ofs & ((PAGE_SIZE / SECTOR_SIZE) - 1);
+		sector_t bvec_len_sect =
+			min_t(sector_t, ((PAGE_SIZE / SECTOR_SIZE) - unordered), size_sector);
+		struct page *page = page_array[page_inx];
+		unsigned int len = (unsigned int)from_sectors(bvec_len_sect);
+		unsigned int offset = (unsigned int)from_sectors(unordered);
+
+		if (unlikely(page == NULL)) {
+			pr_err("NULL found in page array");
+			bio_put(bio);
+			return 0;
+		}
+		if (unlikely(bio_add_page(bio, page, len, offset) != len)) {
+			bio_put(bio);
+			return 0;
+		}
+		++page_inx;
+		process_sect += bvec_len_sect;
+	}
+
+	while (process_sect < size_sector) {
+		sector_t bvec_len_sect =
+			min_t(sector_t, (PAGE_SIZE / SECTOR_SIZE), (size_sector - process_sect));
+		struct page *page = page_array[page_inx];
+		unsigned int len = (unsigned int)from_sectors(bvec_len_sect);
+
+
+		if (unlikely(page == NULL)) {
+			pr_err("NULL found in page array");
+			break;
+		}
+		if (unlikely(bio_add_page(bio, page, len, 0) != len))
+			break;
+
+		++page_inx;
+		process_sect += bvec_len_sect;
+	}
+
+	((struct dio_bio_complete *)bio->bi_private)->dio_req = dio_req;
+	((struct dio_bio_complete *)bio->bi_private)->bio_sect_len = process_sect;
+
+	submit_bio_direct(bio);
+
+	return process_sect;
+}
+
+sector_t blk_deferred_submit_pages(struct block_device *blk_dev,
+				   struct blk_deferred_request *dio_req, int direction,
+				   sector_t arr_ofs, struct page **page_array, sector_t ofs_sector,
+				   sector_t size_sector)
+{
+	sector_t process_sect = 0;
+
+	do {
+		sector_t portion_sect = _blk_deferred_submit_pages(
+			blk_dev, dio_req, direction, arr_ofs + process_sect, page_array,
+			ofs_sector + process_sect, size_sector - process_sect);
+		if (portion_sect == 0) {
+			pr_err("Failed to submit defer IO pages. Only [%lld] sectors processed\n",
+			       process_sect);
+			break;
+		}
+		process_sect += portion_sect;
+	} while (process_sect < size_sector);
+
+	return process_sect;
+}
+
+struct blk_deferred_request *blk_deferred_request_new(void)
+{
+	struct blk_deferred_request *dio_req = NULL;
+
+	dio_req = kzalloc(sizeof(struct blk_deferred_request), GFP_NOIO);
+	if (dio_req == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&dio_req->dios);
+
+	dio_req->result = SUCCESS;
+	atomic64_set(&dio_req->sect_processed, 0);
+	dio_req->sect_len = 0;
+	init_completion(&dio_req->complete);
+
+	return dio_req;
+}
+
+bool blk_deferred_request_already_added(struct blk_deferred_request *dio_req,
+					unsigned long block_index)
+{
+	bool result = false;
+	struct list_head *_list_head;
+
+	if (list_empty(&dio_req->dios))
+		return result;
+
+	list_for_each(_list_head, &dio_req->dios) {
+		struct blk_deferred_io *dio = list_entry(_list_head, struct blk_deferred_io, link);
+
+		if (dio->blk_index == block_index) {
+			result = true;
+			break;
+		}
+	}
+
+	return result;
+}
+
+int blk_deferred_request_add(struct blk_deferred_request *dio_req, struct blk_deferred_io *dio)
+{
+	list_add_tail(&dio->link, &dio_req->dios);
+	dio_req->sect_len += dio->sect.cnt;
+
+	return SUCCESS;
+}
+
+void blk_deferred_request_free(struct blk_deferred_request *dio_req)
+{
+	if (dio_req != NULL) {
+		while (!list_empty(&dio_req->dios)) {
+			struct blk_deferred_io *dio =
+				list_entry(dio_req->dios.next, struct blk_deferred_io, link);
+
+			list_del(&dio->link);
+
+			blk_deferred_free(dio);
+		}
+		kfree(dio_req);
+	}
+}
+
+void blk_deferred_request_waiting_skip(struct blk_deferred_request *dio_req)
+{
+	init_completion(&dio_req->complete);
+	atomic64_set(&dio_req->sect_processed, 0);
+}
+
+int blk_deferred_request_wait(struct blk_deferred_request *dio_req)
+{
+	u64 start_jiffies = get_jiffies_64();
+	u64 current_jiffies;
+
+	while (wait_for_completion_timeout(&dio_req->complete, (HZ * 1)) == 0) {
+		current_jiffies = get_jiffies_64();
+		if (jiffies_to_msecs(current_jiffies - start_jiffies) > 60 * 1000) {
+			pr_warn("Defer IO request timeout\n");
+			return -EDEADLK;
+		}
+	}
+
+	return dio_req->result;
+}
+
+int blk_deferred_request_read_original(struct block_device *original_blk_dev,
+				       struct blk_deferred_request *dio_copy_req)
+{
+	int res = -ENODATA;
+	struct list_head *_list_head;
+
+	blk_deferred_request_waiting_skip(dio_copy_req);
+
+	if (list_empty(&dio_copy_req->dios))
+		return res;
+
+	list_for_each(_list_head, &dio_copy_req->dios) {
+		struct blk_deferred_io *dio = list_entry(_list_head, struct blk_deferred_io, link);
+
+		sector_t ofs = dio->sect.ofs;
+		sector_t cnt = dio->sect.cnt;
+
+		if (cnt != blk_deferred_submit_pages(original_blk_dev, dio_copy_req, READ, 0,
+						     dio->page_array, ofs, cnt)) {
+			pr_err("Failed to submit reading defer IO request. offset=%lld\n",
+			       dio->sect.ofs);
+			res = -EIO;
+			break;
+		}
+		res = SUCCESS;
+	}
+
+	if (res == SUCCESS)
+		res = blk_deferred_request_wait(dio_copy_req);
+
+	return res;
+}
+
+
+static int _store_file(struct block_device *blk_dev, struct blk_deferred_request *dio_copy_req,
+		       struct blk_descr_file *blk_descr, struct page **page_array)
+{
+	struct list_head *_rangelist_head;
+	sector_t page_array_ofs = 0;
+
+	if (unlikely(list_empty(&blk_descr->rangelist))) {
+		pr_err("Invalid block descriptor");
+		return -EINVAL;
+	}
+	list_for_each(_rangelist_head, &blk_descr->rangelist) {
+		struct blk_range_link *range_link;
+		sector_t process_sect;
+
+		range_link = list_entry(_rangelist_head, struct blk_range_link, link);
+		process_sect = blk_deferred_submit_pages(blk_dev, dio_copy_req, WRITE,
+							 page_array_ofs, page_array,
+							 range_link->rg.ofs, range_link->rg.cnt);
+		if (range_link->rg.cnt != process_sect) {
+			pr_err("Failed to submit defer IO request for storing\n");
+			return -EIO;
+		}
+		page_array_ofs += range_link->rg.cnt;
+	}
+	return SUCCESS;
+}
+
+int blk_deferred_request_store_file(struct block_device *blk_dev,
+				    struct blk_deferred_request *dio_copy_req)
+{
+	struct list_head *_dio_list_head;
+
+	blk_deferred_request_waiting_skip(dio_copy_req);
+
+	if (unlikely(list_empty(&dio_copy_req->dios))) {
+		pr_err("Invalid deferred io request");
+		return -EINVAL;
+	}
+	list_for_each(_dio_list_head, &dio_copy_req->dios) {
+		int res;
+		struct blk_deferred_io *dio;
+
+		dio = list_entry(_dio_list_head, struct blk_deferred_io, link);
+		res = _store_file(blk_dev, dio_copy_req, dio->blk_descr.file, dio->page_array);
+		if (res != SUCCESS)
+			return res;
+	}
+
+	return blk_deferred_request_wait(dio_copy_req);
+}
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+
+static int _store_multidev(struct blk_deferred_request *dio_copy_req,
+			   struct blk_descr_multidev *blk_descr, struct page **page_array)
+{
+	struct list_head *_ranges_list_head;
+	sector_t page_array_ofs = 0;
+
+	if (unlikely(list_empty(&blk_descr->rangelist))) {
+		pr_err("Invalid block descriptor");
+		return -EINVAL;
+	}
+	list_for_each(_ranges_list_head, &blk_descr->rangelist) {
+		sector_t process_sect;
+		struct blk_range_link_ex *range_link;
+
+		range_link = list_entry(_ranges_list_head, struct blk_range_link_ex, link);
+		process_sect = blk_deferred_submit_pages(range_link->blk_dev, dio_copy_req, WRITE,
+							 page_array_ofs, page_array,
+							 range_link->rg.ofs, range_link->rg.cnt);
+		if (range_link->rg.cnt != process_sect) {
+			pr_err("Failed to submit defer IO request for storing\n");
+			return -EIO;
+		}
+
+		page_array_ofs += range_link->rg.cnt;
+	}
+
+	return SUCCESS;
+}
+
+int blk_deferred_request_store_multidev(struct blk_deferred_request *dio_copy_req)
+{
+	struct list_head *_dio_list_head;
+
+	blk_deferred_request_waiting_skip(dio_copy_req);
+
+	if (unlikely(list_empty(&dio_copy_req->dios))) {
+		pr_err("Invalid deferred io request");
+		return -EINVAL;
+	}
+	list_for_each(_dio_list_head, &dio_copy_req->dios) {
+		int res;
+		struct blk_deferred_io *dio;
+
+		dio = list_entry(_dio_list_head, struct blk_deferred_io, link);
+		res = _store_multidev(dio_copy_req, dio->blk_descr.multidev, dio->page_array);
+		if (res != SUCCESS)
+			return res;
+	}
+
+	return blk_deferred_request_wait(dio_copy_req);
+}
+#endif
+
+static size_t _store_pages(void *dst, struct page **page_array, size_t length)
+{
+	size_t page_inx = 0;
+	size_t processed_len = 0;
+
+	while ((processed_len < length) && (page_array[page_inx] != NULL)) {
+		void *src;
+		size_t page_len = min_t(size_t, PAGE_SIZE, (length - processed_len));
+
+		src = page_address(page_array[page_inx]);
+		memcpy(dst + processed_len, src, page_len);
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	return processed_len;
+}
+
+int blk_deferred_request_store_mem(struct blk_deferred_request *dio_copy_req)
+{
+	int res = SUCCESS;
+	sector_t processed = 0;
+
+	if (!list_empty(&dio_copy_req->dios)) {
+		struct list_head *_list_head;
+
+		list_for_each(_list_head, &dio_copy_req->dios) {
+			size_t length;
+			size_t portion;
+			struct blk_deferred_io *dio;
+
+			dio = list_entry(_list_head, struct blk_deferred_io, link);
+			length = snapstore_block_size() * SECTOR_SIZE;
+
+			portion = _store_pages(dio->blk_descr.mem->buff, dio->page_array, length);
+			if (unlikely(portion != length)) {
+				res = -EIO;
+				break;
+			}
+			processed += (sector_t)to_sectors(portion);
+		}
+	}
+
+	blk_deferred_complete(dio_copy_req, processed, res);
+	return res;
+}
diff --git a/drivers/block/blk-snap/blk_deferred.h b/drivers/block/blk-snap/blk_deferred.h
new file mode 100644
index 000000000000..3c516a835c25
--- /dev/null
+++ b/drivers/block/blk-snap/blk_deferred.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#include "blk_descr_file.h"
+#include "blk_descr_mem.h"
+#include "blk_descr_multidev.h"
+
+#define DEFER_IO_DIO_REQUEST_LENGTH 250
+#define DEFER_IO_DIO_REQUEST_SECTORS_COUNT (10 * 1024 * 1024 / SECTOR_SIZE)
+
+struct blk_deferred_io {
+	struct list_head link;
+
+	unsigned long blk_index;
+	union blk_descr_unify blk_descr;
+
+	struct blk_range sect;
+
+	struct page **page_array; //null pointer on tail
+};
+
+struct blk_deferred_request {
+	struct completion complete;
+	sector_t sect_len;
+	atomic64_t sect_processed;
+	int result;
+
+	struct list_head dios;
+};
+
+void blk_deferred_done(void);
+
+struct blk_deferred_io *blk_deferred_alloc(unsigned long block_index,
+					   union blk_descr_unify blk_descr);
+void blk_deferred_free(struct blk_deferred_io *dio);
+
+void blk_deferred_bio_endio(struct bio *bio);
+
+sector_t blk_deferred_submit_pages(struct block_device *blk_dev,
+				   struct blk_deferred_request *dio_req, int direction,
+				   sector_t arr_ofs, struct page **page_array, sector_t ofs_sector,
+				   sector_t size_sector);
+
+struct blk_deferred_request *blk_deferred_request_new(void);
+
+bool blk_deferred_request_already_added(struct blk_deferred_request *dio_req,
+					unsigned long block_index);
+
+int blk_deferred_request_add(struct blk_deferred_request *dio_req, struct blk_deferred_io *dio);
+void blk_deferred_request_free(struct blk_deferred_request *dio_req);
+void blk_deferred_request_deadlocked(struct blk_deferred_request *dio_req);
+
+void blk_deferred_request_waiting_skip(struct blk_deferred_request *dio_req);
+int blk_deferred_request_wait(struct blk_deferred_request *dio_req);
+
+int blk_deferred_bioset_create(void);
+void blk_deferred_bioset_free(void);
+
+int blk_deferred_request_read_original(struct block_device *original_blk_dev,
+				       struct blk_deferred_request *dio_copy_req);
+
+int blk_deferred_request_store_file(struct block_device *blk_dev,
+				    struct blk_deferred_request *dio_copy_req);
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+int blk_deferred_request_store_multidev(struct blk_deferred_request *dio_copy_req);
+#endif
+int blk_deferred_request_store_mem(struct blk_deferred_request *dio_copy_req);
diff --git a/drivers/block/blk-snap/blk_descr_file.c b/drivers/block/blk-snap/blk_descr_file.c
new file mode 100644
index 000000000000..fca298d35744
--- /dev/null
+++ b/drivers/block/blk-snap/blk_descr_file.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-blk_descr"
+#include "common.h"
+
+#include "blk_descr_file.h"
+
+static inline void list_assign(struct list_head *dst, struct list_head *src)
+{
+	dst->next = src->next;
+	dst->prev = src->prev;
+
+	src->next->prev = dst;
+	src->prev->next = dst;
+}
+
+static inline void blk_descr_file_init(struct blk_descr_file *blk_descr,
+				       struct list_head *rangelist)
+{
+	list_assign(&blk_descr->rangelist, rangelist);
+}
+
+static inline void blk_descr_file_done(struct blk_descr_file *blk_descr)
+{
+	struct blk_range_link *range_link;
+
+	while (!list_empty(&blk_descr->rangelist)) {
+		range_link = list_entry(blk_descr->rangelist.next, struct blk_range_link, link);
+
+		list_del(&range_link->link);
+		kfree(range_link);
+	}
+}
+
+void blk_descr_file_pool_init(struct blk_descr_pool *pool)
+{
+	blk_descr_pool_init(pool, 0);
+}
+
+void _blk_descr_file_cleanup(void *descr_array, size_t count)
+{
+	size_t inx;
+	struct blk_descr_file *file_blocks = descr_array;
+
+	for (inx = 0; inx < count; ++inx)
+		blk_descr_file_done(file_blocks + inx);
+}
+
+void blk_descr_file_pool_done(struct blk_descr_pool *pool)
+{
+	blk_descr_pool_done(pool, _blk_descr_file_cleanup);
+}
+
+static union blk_descr_unify _blk_descr_file_allocate(void *descr_array, size_t index, void *arg)
+{
+	union blk_descr_unify blk_descr;
+	struct blk_descr_file *file_blocks = descr_array;
+
+	blk_descr.file = &file_blocks[index];
+
+	blk_descr_file_init(blk_descr.file, (struct list_head *)arg);
+
+	return blk_descr;
+}
+
+int blk_descr_file_pool_add(struct blk_descr_pool *pool, struct list_head *rangelist)
+{
+	union blk_descr_unify blk_descr;
+
+	blk_descr = blk_descr_pool_alloc(pool, sizeof(struct blk_descr_file),
+					 _blk_descr_file_allocate, (void *)rangelist);
+	if (blk_descr.ptr == NULL) {
+		pr_err("Failed to allocate block descriptor\n");
+		return -ENOMEM;
+	}
+
+	return SUCCESS;
+}
+
+union blk_descr_unify blk_descr_file_pool_take(struct blk_descr_pool *pool)
+{
+	return blk_descr_pool_take(pool, sizeof(struct blk_descr_file));
+}
diff --git a/drivers/block/blk-snap/blk_descr_file.h b/drivers/block/blk-snap/blk_descr_file.h
new file mode 100644
index 000000000000..0e9a5e3efdea
--- /dev/null
+++ b/drivers/block/blk-snap/blk_descr_file.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#include "blk_descr_pool.h"
+
+struct blk_descr_file {
+	struct list_head rangelist;
+};
+
+struct blk_range_link {
+	struct list_head link;
+	struct blk_range rg;
+};
+
+void blk_descr_file_pool_init(struct blk_descr_pool *pool);
+void blk_descr_file_pool_done(struct blk_descr_pool *pool);
+
+/*
+ * allocate new empty block in pool
+ */
+int blk_descr_file_pool_add(struct blk_descr_pool *pool, struct list_head *rangelist);
+
+/*
+ * take empty block from pool
+ */
+union blk_descr_unify blk_descr_file_pool_take(struct blk_descr_pool *pool);
diff --git a/drivers/block/blk-snap/blk_descr_mem.c b/drivers/block/blk-snap/blk_descr_mem.c
new file mode 100644
index 000000000000..cd326ac150b6
--- /dev/null
+++ b/drivers/block/blk-snap/blk_descr_mem.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-blk_descr"
+#include "common.h"
+#include "blk_descr_mem.h"
+
+#define SECTION "blk_descr "
+
+static inline void blk_descr_mem_init(struct blk_descr_mem *blk_descr, void *ptr)
+{
+	blk_descr->buff = ptr;
+}
+
+static inline void blk_descr_mem_done(struct blk_descr_mem *blk_descr)
+{
+	blk_descr->buff = NULL;
+}
+
+void blk_descr_mem_pool_init(struct blk_descr_pool *pool, size_t available_blocks)
+{
+	blk_descr_pool_init(pool, available_blocks);
+}
+
+void blk_descr_mem_cleanup(void *descr_array, size_t count)
+{
+	size_t inx;
+	struct blk_descr_mem *mem_blocks = descr_array;
+
+	for (inx = 0; inx < count; ++inx)
+		blk_descr_mem_done(mem_blocks + inx);
+}
+
+void blk_descr_mem_pool_done(struct blk_descr_pool *pool)
+{
+	blk_descr_pool_done(pool, blk_descr_mem_cleanup);
+}
+
+static union blk_descr_unify blk_descr_mem_alloc(void *descr_array, size_t index, void *arg)
+{
+	union blk_descr_unify blk_descr;
+	struct blk_descr_mem *mem_blocks = descr_array;
+
+	blk_descr.mem = &mem_blocks[index];
+
+	blk_descr_mem_init(blk_descr.mem, (void *)arg);
+
+	return blk_descr;
+}
+
+int blk_descr_mem_pool_add(struct blk_descr_pool *pool, void *buffer)
+{
+	union blk_descr_unify blk_descr;
+
+	blk_descr = blk_descr_pool_alloc(pool, sizeof(struct blk_descr_mem),
+					 blk_descr_mem_alloc, buffer);
+	if (blk_descr.ptr == NULL) {
+		pr_err("Failed to allocate block descriptor\n");
+		return -ENOMEM;
+	}
+
+	return SUCCESS;
+}
+
+union blk_descr_unify blk_descr_mem_pool_take(struct blk_descr_pool *pool)
+{
+	return blk_descr_pool_take(pool, sizeof(struct blk_descr_mem));
+}
diff --git a/drivers/block/blk-snap/blk_descr_mem.h b/drivers/block/blk-snap/blk_descr_mem.h
new file mode 100644
index 000000000000..43e8de76c07c
--- /dev/null
+++ b/drivers/block/blk-snap/blk_descr_mem.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#include "blk_descr_pool.h"
+
+struct blk_descr_mem {
+	void *buff; //pointer to snapstore block in memory
+};
+
+void blk_descr_mem_pool_init(struct blk_descr_pool *pool, size_t available_blocks);
+void blk_descr_mem_pool_done(struct blk_descr_pool *pool);
+
+int blk_descr_mem_pool_add(struct blk_descr_pool *pool, void *buffer);
+union blk_descr_unify blk_descr_mem_pool_take(struct blk_descr_pool *pool);
diff --git a/drivers/block/blk-snap/blk_descr_multidev.c b/drivers/block/blk-snap/blk_descr_multidev.c
new file mode 100644
index 000000000000..cf5e0ed6f781
--- /dev/null
+++ b/drivers/block/blk-snap/blk_descr_multidev.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-blk_descr"
+#include "common.h"
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+#include "blk_descr_multidev.h"
+
+static inline void list_assign(struct list_head *dst, struct list_head *src)
+{
+	dst->next = src->next;
+	dst->prev = src->prev;
+
+	src->next->prev = dst;
+	src->prev->next = dst;
+}
+
+static inline void blk_descr_multidev_init(struct blk_descr_multidev *blk_descr,
+					   struct list_head *rangelist)
+{
+	list_assign(&blk_descr->rangelist, rangelist);
+}
+
+static inline void blk_descr_multidev_done(struct blk_descr_multidev *blk_descr)
+{
+	struct blk_range_link_ex *rangelist;
+
+	while (!list_empty(&blk_descr->rangelist)) {
+		rangelist = list_entry(blk_descr->rangelist.next,
+				       struct blk_range_link_ex, link);
+
+		list_del(&rangelist->link);
+		kfree(rangelist);
+	}
+}
+
+void blk_descr_multidev_pool_init(struct blk_descr_pool *pool)
+{
+	blk_descr_pool_init(pool, 0);
+}
+
+static void blk_descr_multidev_cleanup(void *descr_array, size_t count)
+{
+	size_t inx;
+	struct blk_descr_multidev *descr_multidev = descr_array;
+
+	for (inx = 0; inx < count; ++inx)
+		blk_descr_multidev_done(descr_multidev + inx);
+}
+
+void blk_descr_multidev_pool_done(struct blk_descr_pool *pool)
+{
+	blk_descr_pool_done(pool, blk_descr_multidev_cleanup);
+}
+
+static union blk_descr_unify blk_descr_multidev_allocate(void *descr_array, size_t index, void *arg)
+{
+	union blk_descr_unify blk_descr;
+	struct blk_descr_multidev *multidev_blocks = descr_array;
+
+	blk_descr.multidev = &multidev_blocks[index];
+
+	blk_descr_multidev_init(blk_descr.multidev, (struct list_head *)arg);
+
+	return blk_descr;
+}
+
+int blk_descr_multidev_pool_add(struct blk_descr_pool *pool, struct list_head *rangelist)
+{
+	union blk_descr_unify blk_descr;
+
+	blk_descr = blk_descr_pool_alloc(pool, sizeof(struct blk_descr_multidev),
+					 blk_descr_multidev_allocate, (void *)rangelist);
+	if (blk_descr.ptr == NULL) {
+		pr_err("Failed to allocate block descriptor\n");
+		return -ENOMEM;
+	}
+
+	return SUCCESS;
+}
+
+union blk_descr_unify blk_descr_multidev_pool_take(struct blk_descr_pool *pool)
+{
+	return blk_descr_pool_take(pool, sizeof(struct blk_descr_multidev));
+}
+
+#endif //CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
diff --git a/drivers/block/blk-snap/blk_descr_multidev.h b/drivers/block/blk-snap/blk_descr_multidev.h
new file mode 100644
index 000000000000..0145b0d78b10
--- /dev/null
+++ b/drivers/block/blk-snap/blk_descr_multidev.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+
+#include "blk_descr_pool.h"
+
+struct blk_descr_multidev {
+	struct list_head rangelist;
+};
+
+struct blk_range_link_ex {
+	struct list_head link;
+	struct blk_range rg;
+	struct block_device *blk_dev;
+};
+
+void blk_descr_multidev_pool_init(struct blk_descr_pool *pool);
+void blk_descr_multidev_pool_done(struct blk_descr_pool *pool);
+
+int blk_descr_multidev_pool_add(struct blk_descr_pool *pool,
+				struct list_head *rangelist); //allocate new empty block
+union blk_descr_unify blk_descr_multidev_pool_take(struct blk_descr_pool *pool); //take empty
+
+#endif //CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
diff --git a/drivers/block/blk-snap/blk_descr_pool.c b/drivers/block/blk-snap/blk_descr_pool.c
new file mode 100644
index 000000000000..b1fe2ba9c2d0
--- /dev/null
+++ b/drivers/block/blk-snap/blk_descr_pool.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-blk_descr"
+#include "common.h"
+#include "blk_descr_pool.h"
+#include "params.h"
+
+struct pool_el {
+	struct list_head link;
+
+	size_t used_cnt; // used blocks
+	size_t capacity; // blocks array capacity
+
+	u8 descr_array[0];
+};
+
+static void *kmalloc_huge(size_t max_size, size_t min_size, gfp_t flags, size_t *p_allocated_size)
+{
+	void *ptr = NULL;
+
+	do {
+		ptr = kmalloc(max_size, flags | __GFP_NOWARN | __GFP_RETRY_MAYFAIL);
+
+		if (ptr != NULL) {
+			*p_allocated_size = max_size;
+			return ptr;
+		}
+		pr_err("Failed to allocate buffer size=%zu\n", max_size);
+		max_size = max_size >> 1;
+	} while (max_size >= min_size);
+
+	pr_err("Failed to allocate buffer.");
+	return NULL;
+}
+
+static struct pool_el *pool_el_alloc(size_t blk_descr_size)
+{
+	size_t el_size;
+	struct pool_el *el;
+
+	el = kmalloc_huge(8 * PAGE_SIZE, PAGE_SIZE, GFP_NOIO, &el_size);
+	if (el == NULL)
+		return NULL;
+
+	el->capacity = (el_size - sizeof(struct pool_el)) / blk_descr_size;
+	el->used_cnt = 0;
+
+	INIT_LIST_HEAD(&el->link);
+
+	return el;
+}
+
+static void _pool_el_free(struct pool_el *el)
+{
+	if (el != NULL)
+		kfree(el);
+}
+
+void blk_descr_pool_init(struct blk_descr_pool *pool, size_t available_blocks)
+{
+	mutex_init(&pool->lock);
+
+	INIT_LIST_HEAD(&pool->head);
+
+	pool->blocks_cnt = 0;
+
+	pool->total_cnt = available_blocks;
+	pool->take_cnt = 0;
+}
+
+void blk_descr_pool_done(struct blk_descr_pool *pool,
+			 void (*blocks_cleanup_cb)(void *descr_array, size_t count))
+{
+	mutex_lock(&pool->lock);
+	while (!list_empty(&pool->head)) {
+		struct pool_el *el;
+
+		el = list_entry(pool->head.next, struct pool_el, link);
+		if (el == NULL)
+			break;
+
+		list_del(&el->link);
+		--pool->blocks_cnt;
+
+		pool->total_cnt -= el->used_cnt;
+
+		blocks_cleanup_cb(el->descr_array, el->used_cnt);
+
+		_pool_el_free(el);
+	}
+	mutex_unlock(&pool->lock);
+}
+
+union blk_descr_unify blk_descr_pool_alloc(
+	struct blk_descr_pool *pool, size_t blk_descr_size,
+	union blk_descr_unify (*block_alloc_cb)(void *descr_array, size_t index, void *arg),
+	void *arg)
+{
+	union blk_descr_unify blk_descr = { NULL };
+
+	mutex_lock(&pool->lock);
+	do {
+		struct pool_el *el = NULL;
+
+		if (!list_empty(&pool->head)) {
+			el = list_entry(pool->head.prev, struct pool_el, link);
+			if (el->used_cnt == el->capacity)
+				el = NULL;
+		}
+
+		if (el == NULL) {
+			el = pool_el_alloc(blk_descr_size);
+			if (el == NULL)
+				break;
+
+			list_add_tail(&el->link, &pool->head);
+
+			++pool->blocks_cnt;
+		}
+
+		blk_descr = block_alloc_cb(el->descr_array, el->used_cnt, arg);
+
+		++el->used_cnt;
+		++pool->total_cnt;
+
+	} while (false);
+	mutex_unlock(&pool->lock);
+
+	return blk_descr;
+}
+
+static union blk_descr_unify __blk_descr_pool_at(struct blk_descr_pool *pool, size_t blk_descr_size,
+						 size_t index)
+{
+	union blk_descr_unify bkl_descr = { NULL };
+	size_t curr_inx = 0;
+	struct pool_el *el;
+	struct list_head *_list_head;
+
+	if (list_empty(&(pool)->head))
+		return bkl_descr;
+
+	list_for_each(_list_head, &(pool)->head) {
+		el = list_entry(_list_head, struct pool_el, link);
+
+		if ((index >= curr_inx) && (index < (curr_inx + el->used_cnt))) {
+			bkl_descr.ptr = el->descr_array + (index - curr_inx) * blk_descr_size;
+			break;
+		}
+		curr_inx += el->used_cnt;
+	}
+
+	return bkl_descr;
+}
+
+union blk_descr_unify blk_descr_pool_take(struct blk_descr_pool *pool, size_t blk_descr_size)
+{
+	union blk_descr_unify result = { NULL };
+
+	mutex_lock(&pool->lock);
+	do {
+		if (pool->take_cnt >= pool->total_cnt) {
+			pr_err("Unable to get block descriptor: ");
+			pr_err("not enough descriptors, already took %zu, total %zu\n",
+			       pool->take_cnt, pool->total_cnt);
+			break;
+		}
+
+		result = __blk_descr_pool_at(pool, blk_descr_size, pool->take_cnt);
+		if (result.ptr == NULL) {
+			pr_err("Unable to get block descriptor: ");
+			pr_err("not enough descriptors, already took %zu, total %zu\n",
+			       pool->take_cnt, pool->total_cnt);
+			break;
+		}
+
+		++pool->take_cnt;
+	} while (false);
+	mutex_unlock(&pool->lock);
+	return result;
+}
+
+bool blk_descr_pool_check_halffill(struct blk_descr_pool *pool, sector_t empty_limit,
+				   sector_t *fill_status)
+{
+	size_t empty_blocks = (pool->total_cnt - pool->take_cnt);
+
+	*fill_status = (sector_t)(pool->take_cnt) << snapstore_block_shift();
+
+	return (empty_blocks < (size_t)(empty_limit >> snapstore_block_shift()));
+}
diff --git a/drivers/block/blk-snap/blk_descr_pool.h b/drivers/block/blk-snap/blk_descr_pool.h
new file mode 100644
index 000000000000..32f8b8c4103e
--- /dev/null
+++ b/drivers/block/blk-snap/blk_descr_pool.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+struct blk_descr_mem;
+struct blk_descr_file;
+struct blk_descr_multidev;
+
+union blk_descr_unify {
+	void *ptr;
+	struct blk_descr_mem *mem;
+	struct blk_descr_file *file;
+	struct blk_descr_multidev *multidev;
+};
+
+struct blk_descr_pool {
+	struct list_head head;
+	struct mutex lock;
+
+	size_t blocks_cnt; // count of struct pool_el
+
+	size_t total_cnt;  // total count of block descriptors
+	size_t take_cnt;   // take count of block descriptors
+};
+
+void blk_descr_pool_init(struct blk_descr_pool *pool, size_t available_blocks);
+
+void blk_descr_pool_done(struct blk_descr_pool *pool,
+			 void (*blocks_cleanup_cb)(void *descr_array, size_t count));
+
+union blk_descr_unify blk_descr_pool_alloc(
+	struct blk_descr_pool *pool, size_t blk_descr_size,
+	union blk_descr_unify (*block_alloc_cb)(void *descr_array, size_t index, void *arg),
+	void *arg);
+
+union blk_descr_unify blk_descr_pool_take(struct blk_descr_pool *pool, size_t blk_descr_size);
+
+bool blk_descr_pool_check_halffill(struct blk_descr_pool *pool, sector_t empty_limit,
+				   sector_t *fill_status);
diff --git a/drivers/block/blk-snap/blk_redirect.c b/drivers/block/blk-snap/blk_redirect.c
new file mode 100644
index 000000000000..4c28a8cb4275
--- /dev/null
+++ b/drivers/block/blk-snap/blk_redirect.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-redirect"
+#include "common.h"
+#include "blk_util.h"
+#include "blk_redirect.h"
+
+#define bio_vec_sectors(bv) (bv.bv_len >> SECTOR_SHIFT)
+
+struct bio_set blk_redirect_bioset = { 0 };
+
+int blk_redirect_bioset_create(void)
+{
+	return bioset_init(&blk_redirect_bioset, 64, 0, BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
+}
+
+void blk_redirect_bioset_free(void)
+{
+	bioset_exit(&blk_redirect_bioset);
+}
+
+void blk_redirect_bio_endio(struct bio *bb)
+{
+	struct blk_redirect_bio *rq_redir = (struct blk_redirect_bio *)bb->bi_private;
+
+	if (rq_redir != NULL) {
+		int err = SUCCESS;
+
+		if (bb->bi_status != BLK_STS_OK)
+			err = -EIO;
+
+		if (err != SUCCESS) {
+			pr_err("Failed to process redirect IO request. errno=%d\n", 0 - err);
+
+			if (rq_redir->err == SUCCESS)
+				rq_redir->err = err;
+		}
+
+		if (atomic64_dec_and_test(&rq_redir->bio_count))
+			blk_redirect_complete(rq_redir, rq_redir->err);
+	}
+	bio_put(bb);
+}
+
+struct bio *_blk_dev_redirect_bio_alloc(int nr_iovecs, void *bi_private)
+{
+	struct bio *new_bio;
+
+	new_bio = bio_alloc_bioset(GFP_NOIO, nr_iovecs, &blk_redirect_bioset);
+	if (new_bio == NULL)
+		return NULL;
+
+	new_bio->bi_end_io = blk_redirect_bio_endio;
+	new_bio->bi_private = bi_private;
+
+	return new_bio;
+}
+
+struct blk_redirect_bio_list *_redirect_bio_allocate_list(struct bio *new_bio)
+{
+	struct blk_redirect_bio_list *next;
+
+	next = kzalloc(sizeof(struct blk_redirect_bio_list), GFP_NOIO);
+	if (next == NULL)
+		return NULL;
+
+	next->next = NULL;
+	next->this = new_bio;
+
+	return next;
+}
+
+int bio_endio_list_push(struct blk_redirect_bio *rq_redir, struct bio *new_bio)
+{
+	struct blk_redirect_bio_list *head;
+
+	if (rq_redir->bio_list_head == NULL) {
+		//list is empty, add first bio
+		rq_redir->bio_list_head = _redirect_bio_allocate_list(new_bio);
+		if (rq_redir->bio_list_head == NULL)
+			return -ENOMEM;
+		return SUCCESS;
+	}
+
+	// seek end of list
+	head = rq_redir->bio_list_head;
+	while (head->next != NULL)
+		head = head->next;
+
+	//append new bio to the end of list
+	head->next = _redirect_bio_allocate_list(new_bio);
+	if (head->next == NULL)
+		return -ENOMEM;
+
+	return SUCCESS;
+}
+
+void bio_endio_list_cleanup(struct blk_redirect_bio_list *curr)
+{
+	while (curr != NULL) {
+		struct blk_redirect_bio_list *next;
+
+		next = curr->next;
+		kfree(curr);
+		curr = next;
+	}
+}
+
+static unsigned int get_max_sect(struct block_device *blk_dev)
+{
+	struct request_queue *q = bdev_get_queue(blk_dev);
+
+	return min((unsigned int)(BIO_MAX_PAGES << (PAGE_SHIFT - SECTOR_SHIFT)),
+		   q->limits.max_sectors);
+}
+
+static int _blk_dev_redirect_part_fast(struct blk_redirect_bio *rq_redir, int direction,
+				       struct block_device *blk_dev, sector_t target_pos,
+				       sector_t rq_ofs, sector_t rq_count)
+{
+	__label__ _fail_out;
+	__label__ _reprocess_bv;
+
+	int res = SUCCESS;
+
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+
+	struct bio *new_bio = NULL;
+
+	sector_t sect_ofs = 0;
+	sector_t processed_sectors = 0;
+	int nr_iovecs;
+	struct blk_redirect_bio_list *bio_endio_rec;
+
+	nr_iovecs = get_max_sect(blk_dev) >> (PAGE_SHIFT - SECTOR_SHIFT);
+
+	bio_for_each_segment(bvec, rq_redir->bio, iter) {
+		sector_t bvec_ofs;
+		sector_t bvec_sectors;
+
+		unsigned int len;
+		unsigned int offset;
+
+		if ((sect_ofs + bio_vec_sectors(bvec)) <= rq_ofs) {
+			sect_ofs += bio_vec_sectors(bvec);
+			continue;
+		}
+		if (sect_ofs >= (rq_ofs + rq_count))
+			break;
+
+		bvec_ofs = 0;
+		if (sect_ofs < rq_ofs)
+			bvec_ofs = rq_ofs - sect_ofs;
+
+		bvec_sectors = bio_vec_sectors(bvec) - bvec_ofs;
+		if (bvec_sectors > (rq_count - processed_sectors))
+			bvec_sectors = rq_count - processed_sectors;
+
+		if (bvec_sectors == 0) {
+			res = -EIO;
+			goto _fail_out;
+		}
+
+_reprocess_bv:
+		if (new_bio == NULL) {
+			new_bio = _blk_dev_redirect_bio_alloc(nr_iovecs, rq_redir);
+			while (new_bio == NULL) {
+				pr_err("Unable to allocate new bio for redirect IO.\n");
+				res = -ENOMEM;
+				goto _fail_out;
+			}
+
+			bio_set_dev(new_bio, blk_dev);
+
+			if (direction == READ)
+				bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
+
+			if (direction == WRITE)
+				bio_set_op_attrs(new_bio, REQ_OP_WRITE, 0);
+
+			new_bio->bi_iter.bi_sector = target_pos + processed_sectors;
+		}
+
+		len = (unsigned int)from_sectors(bvec_sectors);
+		offset = bvec.bv_offset + (unsigned int)from_sectors(bvec_ofs);
+		if (unlikely(bio_add_page(new_bio, bvec.bv_page, len, offset) != len)) {
+			if (bio_sectors(new_bio) == 0) {
+				res = -EIO;
+				goto _fail_out;
+			}
+
+			res = bio_endio_list_push(rq_redir, new_bio);
+			if (res != SUCCESS) {
+				pr_err("Failed to add bio into bio_endio_list\n");
+				goto _fail_out;
+			}
+
+			atomic64_inc(&rq_redir->bio_count);
+			new_bio = NULL;
+
+			goto _reprocess_bv;
+		}
+		processed_sectors += bvec_sectors;
+
+		sect_ofs += bio_vec_sectors(bvec);
+	}
+
+	if (new_bio != NULL) {
+		res = bio_endio_list_push(rq_redir, new_bio);
+		if (res != SUCCESS) {
+			pr_err("Failed to add bio into bio_endio_list\n");
+			goto _fail_out;
+		}
+
+		atomic64_inc(&rq_redir->bio_count);
+		new_bio = NULL;
+	}
+
+	return SUCCESS;
+
+_fail_out:
+	bio_endio_rec = rq_redir->bio_list_head;
+	while (bio_endio_rec != NULL) {
+		if (bio_endio_rec->this != NULL)
+			bio_put(bio_endio_rec->this);
+
+		bio_endio_rec = bio_endio_rec->next;
+	}
+
+	bio_endio_list_cleanup(bio_endio_rec);
+
+	pr_err("Failed to process part of redirect IO request. rq_ofs=%lld, rq_count=%lld\n",
+	       rq_ofs, rq_count);
+	return res;
+}
+
+int blk_dev_redirect_part(struct blk_redirect_bio *rq_redir, int direction,
+			  struct block_device *blk_dev, sector_t target_pos, sector_t rq_ofs,
+			  sector_t rq_count)
+{
+	struct request_queue *q = bdev_get_queue(blk_dev);
+	sector_t logical_block_size_mask =
+		(sector_t)((q->limits.logical_block_size >> SECTOR_SHIFT) - 1);
+
+	if (likely(logical_block_size_mask == 0))
+		return _blk_dev_redirect_part_fast(rq_redir, direction, blk_dev, target_pos, rq_ofs,
+						   rq_count);
+
+	if (likely((0 == (target_pos & logical_block_size_mask)) &&
+		   (0 == (rq_count & logical_block_size_mask))))
+		return _blk_dev_redirect_part_fast(rq_redir, direction, blk_dev, target_pos, rq_ofs,
+						   rq_count);
+
+	return -EFAULT;
+}
+
+void blk_dev_redirect_submit(struct blk_redirect_bio *rq_redir)
+{
+	struct blk_redirect_bio_list *head;
+	struct blk_redirect_bio_list *curr;
+
+	head = curr = rq_redir->bio_list_head;
+	rq_redir->bio_list_head = NULL;
+
+	while (curr != NULL) {
+		submit_bio_direct(curr->this);
+
+		curr = curr->next;
+	}
+
+	bio_endio_list_cleanup(head);
+}
+
+int blk_dev_redirect_memcpy_part(struct blk_redirect_bio *rq_redir, int direction, void *buff,
+				 sector_t rq_ofs, sector_t rq_count)
+{
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+
+	sector_t sect_ofs = 0;
+	sector_t processed_sectors = 0;
+
+	bio_for_each_segment(bvec, rq_redir->bio, iter) {
+		void *mem;
+		sector_t bvec_ofs;
+		sector_t bvec_sectors;
+
+		if ((sect_ofs + bio_vec_sectors(bvec)) <= rq_ofs) {
+			sect_ofs += bio_vec_sectors(bvec);
+			continue;
+		}
+
+		if (sect_ofs >= (rq_ofs + rq_count))
+			break;
+
+		bvec_ofs = 0;
+		if (sect_ofs < rq_ofs)
+			bvec_ofs = rq_ofs - sect_ofs;
+
+		bvec_sectors = bio_vec_sectors(bvec) - bvec_ofs;
+		if (bvec_sectors > (rq_count - processed_sectors))
+			bvec_sectors = rq_count - processed_sectors;
+
+		mem = kmap_atomic(bvec.bv_page);
+		if (direction == READ) {
+			memcpy(mem + bvec.bv_offset + (unsigned int)from_sectors(bvec_ofs),
+			       buff + (unsigned int)from_sectors(processed_sectors),
+			       (unsigned int)from_sectors(bvec_sectors));
+		} else {
+			memcpy(buff + (unsigned int)from_sectors(processed_sectors),
+			       mem + bvec.bv_offset + (unsigned int)from_sectors(bvec_ofs),
+			       (unsigned int)from_sectors(bvec_sectors));
+		}
+		kunmap_atomic(mem);
+
+		processed_sectors += bvec_sectors;
+
+		sect_ofs += bio_vec_sectors(bvec);
+	}
+
+	return SUCCESS;
+}
+
+int blk_dev_redirect_zeroed_part(struct blk_redirect_bio *rq_redir, sector_t rq_ofs,
+				 sector_t rq_count)
+{
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+
+	sector_t sect_ofs = 0;
+	sector_t processed_sectors = 0;
+
+	bio_for_each_segment(bvec, rq_redir->bio, iter) {
+		void *mem;
+		sector_t bvec_ofs;
+		sector_t bvec_sectors;
+
+		if ((sect_ofs + bio_vec_sectors(bvec)) <= rq_ofs) {
+			sect_ofs += bio_vec_sectors(bvec);
+			continue;
+		}
+
+		if (sect_ofs >= (rq_ofs + rq_count))
+			break;
+
+		bvec_ofs = 0;
+		if (sect_ofs < rq_ofs)
+			bvec_ofs = rq_ofs - sect_ofs;
+
+		bvec_sectors = bio_vec_sectors(bvec) - bvec_ofs;
+		if (bvec_sectors > (rq_count - processed_sectors))
+			bvec_sectors = rq_count - processed_sectors;
+
+		mem = kmap_atomic(bvec.bv_page);
+		memset(mem + bvec.bv_offset + (unsigned int)from_sectors(bvec_ofs), 0,
+		       (unsigned int)from_sectors(bvec_sectors));
+		kunmap_atomic(mem);
+
+		processed_sectors += bvec_sectors;
+
+		sect_ofs += bio_vec_sectors(bvec);
+	}
+
+	return SUCCESS;
+}
+
+int blk_dev_redirect_read_zeroed(struct blk_redirect_bio *rq_redir, struct block_device *blk_dev,
+				 sector_t rq_pos, sector_t blk_ofs_start, sector_t blk_ofs_count,
+				 struct rangevector *zero_sectors)
+{
+	int res = SUCCESS;
+	struct blk_range_tree_node *range_node;
+
+	sector_t ofs = 0;
+
+	sector_t from = rq_pos + blk_ofs_start;
+	sector_t to = rq_pos + blk_ofs_start + blk_ofs_count - 1;
+
+	down_read(&zero_sectors->lock);
+	range_node = blk_range_rb_iter_first(&zero_sectors->root, from, to);
+	while (range_node) {
+		struct blk_range *zero_range = &range_node->range;
+		sector_t current_portion;
+
+		if (zero_range->ofs > rq_pos + blk_ofs_start + ofs) {
+			sector_t pre_zero_cnt = zero_range->ofs - (rq_pos + blk_ofs_start + ofs);
+
+			res = blk_dev_redirect_part(rq_redir, READ, blk_dev,
+						    rq_pos + blk_ofs_start + ofs,
+						    blk_ofs_start + ofs, pre_zero_cnt);
+			if (res != SUCCESS)
+				break;
+
+			ofs += pre_zero_cnt;
+		}
+
+		current_portion = min_t(sector_t, zero_range->cnt, blk_ofs_count - ofs);
+
+		res = blk_dev_redirect_zeroed_part(rq_redir, blk_ofs_start + ofs, current_portion);
+		if (res != SUCCESS)
+			break;
+
+		ofs += current_portion;
+
+		range_node = blk_range_rb_iter_next(range_node, from, to);
+	}
+	up_read(&zero_sectors->lock);
+
+	if (res == SUCCESS)
+		if ((blk_ofs_count - ofs) > 0)
+			res = blk_dev_redirect_part(rq_redir, READ, blk_dev,
+						    rq_pos + blk_ofs_start + ofs,
+						    blk_ofs_start + ofs, blk_ofs_count - ofs);
+
+	return res;
+}
+void blk_redirect_complete(struct blk_redirect_bio *rq_redir, int res)
+{
+	rq_redir->complete_cb(rq_redir->complete_param, rq_redir->bio, res);
+	redirect_bio_queue_free(rq_redir);
+}
+
+void redirect_bio_queue_init(struct redirect_bio_queue *queue)
+{
+	INIT_LIST_HEAD(&queue->list);
+
+	spin_lock_init(&queue->lock);
+
+	atomic_set(&queue->in_queue_cnt, 0);
+	atomic_set(&queue->alloc_cnt, 0);
+
+	atomic_set(&queue->active_state, true);
+}
+
+struct blk_redirect_bio *redirect_bio_queue_new(struct redirect_bio_queue *queue)
+{
+	struct blk_redirect_bio *rq_redir = kzalloc(sizeof(struct blk_redirect_bio), GFP_NOIO);
+
+	if (rq_redir == NULL)
+		return NULL;
+
+	atomic_inc(&queue->alloc_cnt);
+
+	INIT_LIST_HEAD(&rq_redir->link);
+	rq_redir->queue = queue;
+
+	return rq_redir;
+}
+
+void redirect_bio_queue_free(struct blk_redirect_bio *rq_redir)
+{
+	if (rq_redir) {
+		if (rq_redir->queue)
+			atomic_dec(&rq_redir->queue->alloc_cnt);
+
+		kfree(rq_redir);
+	}
+}
+
+int redirect_bio_queue_push_back(struct redirect_bio_queue *queue,
+				 struct blk_redirect_bio *rq_redir)
+{
+	int res = SUCCESS;
+
+	spin_lock(&queue->lock);
+
+	if (atomic_read(&queue->active_state)) {
+		INIT_LIST_HEAD(&rq_redir->link);
+		list_add_tail(&rq_redir->link, &queue->list);
+		atomic_inc(&queue->in_queue_cnt);
+	} else
+		res = -EACCES;
+
+	spin_unlock(&queue->lock);
+	return res;
+}
+
+struct blk_redirect_bio *redirect_bio_queue_get_first(struct redirect_bio_queue *queue)
+{
+	struct blk_redirect_bio *rq_redir = NULL;
+
+	spin_lock(&queue->lock);
+
+	if (!list_empty(&queue->list)) {
+		rq_redir = list_entry(queue->list.next, struct blk_redirect_bio, link);
+		list_del(&rq_redir->link);
+		atomic_dec(&queue->in_queue_cnt);
+	}
+
+	spin_unlock(&queue->lock);
+
+	return rq_redir;
+}
+
+bool redirect_bio_queue_active(struct redirect_bio_queue *queue, bool state)
+{
+	bool prev_state;
+
+	spin_lock(&queue->lock);
+
+	prev_state = atomic_read(&queue->active_state);
+	atomic_set(&queue->active_state, state);
+
+	spin_unlock(&queue->lock);
+
+	return prev_state;
+}
diff --git a/drivers/block/blk-snap/blk_redirect.h b/drivers/block/blk-snap/blk_redirect.h
new file mode 100644
index 000000000000..aae23e78ebe2
--- /dev/null
+++ b/drivers/block/blk-snap/blk_redirect.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#include "rangevector.h"
+
+int blk_redirect_bioset_create(void);
+void blk_redirect_bioset_free(void);
+
+void blk_redirect_bio_endio(struct bio *bb);
+
+struct blk_redirect_bio_list {
+	struct blk_redirect_bio_list *next;
+	struct bio *this;
+};
+
+struct redirect_bio_queue {
+	struct list_head list;
+	spinlock_t lock;
+
+	atomic_t active_state;
+	atomic_t in_queue_cnt;
+	atomic_t alloc_cnt;
+};
+
+struct blk_redirect_bio {
+	struct list_head link;
+	struct redirect_bio_queue *queue;
+
+	struct bio *bio;
+	int err;
+	struct blk_redirect_bio_list *bio_list_head; //list of created bios
+	atomic64_t bio_count;
+
+	void *complete_param;
+	void (*complete_cb)(void *complete_param, struct bio *rq, int err);
+};
+
+int blk_dev_redirect_part(struct blk_redirect_bio *rq_redir, int direction,
+			  struct block_device *blk_dev, sector_t target_pos, sector_t rq_ofs,
+			  sector_t rq_count);
+
+void blk_dev_redirect_submit(struct blk_redirect_bio *rq_redir);
+
+int blk_dev_redirect_memcpy_part(struct blk_redirect_bio *rq_redir, int direction, void *src_buff,
+				 sector_t rq_ofs, sector_t rq_count);
+
+int blk_dev_redirect_zeroed_part(struct blk_redirect_bio *rq_redir, sector_t rq_ofs,
+				 sector_t rq_count);
+
+int blk_dev_redirect_read_zeroed(struct blk_redirect_bio *rq_redir, struct block_device *blk_dev,
+				 sector_t rq_pos, sector_t blk_ofs_start, sector_t blk_ofs_count,
+				 struct rangevector *zero_sectors);
+
+void blk_redirect_complete(struct blk_redirect_bio *rq_redir, int res);
+
+void redirect_bio_queue_init(struct redirect_bio_queue *queue);
+
+struct blk_redirect_bio *redirect_bio_queue_new(struct redirect_bio_queue *queue);
+
+void redirect_bio_queue_free(struct blk_redirect_bio *rq_redir);
+
+int redirect_bio_queue_push_back(struct redirect_bio_queue *queue,
+				 struct blk_redirect_bio *rq_redir);
+
+struct blk_redirect_bio *redirect_bio_queue_get_first(struct redirect_bio_queue *queue);
+
+bool redirect_bio_queue_active(struct redirect_bio_queue *queue, bool state);
+
+#define redirect_bio_queue_empty(queue) (atomic_read(&(queue).in_queue_cnt) == 0)
+
+#define redirect_bio_queue_unactive(queue)                                                         \
+	((atomic_read(&((queue).active_state)) == false) &&                                        \
+	 (atomic_read(&((queue).alloc_cnt)) == 0))
diff --git a/drivers/block/blk-snap/blk_util.c b/drivers/block/blk-snap/blk_util.c
new file mode 100644
index 000000000000..57db70b86516
--- /dev/null
+++ b/drivers/block/blk-snap/blk_util.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+#include "blk_util.h"
+
+int blk_dev_open(dev_t dev_id, struct block_device **p_blk_dev)
+{
+	int result = SUCCESS;
+	struct block_device *blk_dev;
+	int refCount;
+
+	blk_dev = bdget(dev_id);
+	if (blk_dev == NULL) {
+		pr_err("Unable to open device [%d:%d]: bdget return NULL\n", MAJOR(dev_id),
+		       MINOR(dev_id));
+		return -ENODEV;
+	}
+
+	refCount = blkdev_get(blk_dev, FMODE_READ | FMODE_WRITE, NULL);
+	if (refCount < 0) {
+		pr_err("Unable to open device [%d:%d]: blkdev_get return error code %d\n",
+		       MAJOR(dev_id), MINOR(dev_id), 0 - refCount);
+		result = refCount;
+	}
+
+	if (result == SUCCESS)
+		*p_blk_dev = blk_dev;
+	return result;
+}
+
+void blk_dev_close(struct block_device *blk_dev)
+{
+	blkdev_put(blk_dev, FMODE_READ);
+}
diff --git a/drivers/block/blk-snap/blk_util.h b/drivers/block/blk-snap/blk_util.h
new file mode 100644
index 000000000000..0776f2faa668
--- /dev/null
+++ b/drivers/block/blk-snap/blk_util.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+int blk_dev_open(dev_t dev_id, struct block_device **p_blk_dev);
+void blk_dev_close(struct block_device *blk_dev);
+
+/*
+ * this function was copied from block/blk.h
+ */
+static inline sector_t part_nr_sects_read(struct hd_struct *part)
+{
+#if (BITS_PER_LONG == 32) && defined(CONFIG_SMP)
+	sector_t nr_sects;
+	unsigned int seq;
+
+	do {
+		seq = read_seqcount_begin(&part->nr_sects_seq);
+		nr_sects = part->nr_sects;
+	} while (read_seqcount_retry(&part->nr_sects_seq, seq));
+
+	return nr_sects;
+#elif (BITS_PER_LONG == 32) && defined(CONFIG_PREEMPTION)
+	sector_t nr_sects;
+
+	preempt_disable();
+	nr_sects = part->nr_sects;
+	preempt_enable();
+
+	return nr_sects;
+#else
+	return part->nr_sects;
+#endif
+}
diff --git a/drivers/block/blk-snap/cbt_map.c b/drivers/block/blk-snap/cbt_map.c
new file mode 100644
index 000000000000..e913069d1a57
--- /dev/null
+++ b/drivers/block/blk-snap/cbt_map.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-cbt_map"
+#include "common.h"
+#include "cbt_map.h"
+
+int cbt_map_allocate(struct cbt_map *cbt_map, unsigned int cbt_sect_in_block_degree,
+		     sector_t device_capacity)
+{
+	sector_t size_mod;
+
+	cbt_map->sect_in_block_degree = cbt_sect_in_block_degree;
+	cbt_map->device_capacity = device_capacity;
+	cbt_map->map_size = (device_capacity >> (sector_t)cbt_sect_in_block_degree);
+
+	pr_info("Allocate CBT map of %zu\n", cbt_map->map_size);
+
+	size_mod = (device_capacity & ((sector_t)(1 << cbt_sect_in_block_degree) - 1));
+	if (size_mod)
+		cbt_map->map_size++;
+
+	cbt_map->read_map = big_buffer_alloc(cbt_map->map_size, GFP_KERNEL);
+	if (cbt_map->read_map != NULL)
+		big_buffer_memset(cbt_map->read_map, 0);
+
+	cbt_map->write_map = big_buffer_alloc(cbt_map->map_size, GFP_KERNEL);
+	if (cbt_map->write_map != NULL)
+		big_buffer_memset(cbt_map->write_map, 0);
+
+	if ((cbt_map->read_map == NULL) || (cbt_map->write_map == NULL)) {
+		pr_err("Cannot allocate CBT map. map_size=%zu\n", cbt_map->map_size);
+		return -ENOMEM;
+	}
+
+	cbt_map->snap_number_previous = 0;
+	cbt_map->snap_number_active = 1;
+	generate_random_uuid(cbt_map->generationId.b);
+	cbt_map->active = true;
+
+	cbt_map->state_changed_sectors = 0;
+	cbt_map->state_dirty_sectors = 0;
+
+	return SUCCESS;
+}
+
+void cbt_map_deallocate(struct cbt_map *cbt_map)
+{
+	if (cbt_map->read_map != NULL) {
+		big_buffer_free(cbt_map->read_map);
+		cbt_map->read_map = NULL;
+	}
+
+	if (cbt_map->write_map != NULL) {
+		big_buffer_free(cbt_map->write_map);
+		cbt_map->write_map = NULL;
+	}
+
+	cbt_map->active = false;
+}
+
+static void cbt_map_destroy(struct cbt_map *cbt_map)
+{
+	pr_info("CBT map destroy\n");
+	if (cbt_map != NULL) {
+		cbt_map_deallocate(cbt_map);
+
+		kfree(cbt_map);
+	}
+}
+
+struct cbt_map *cbt_map_create(unsigned int cbt_sect_in_block_degree, sector_t device_capacity)
+{
+	struct cbt_map *cbt_map = NULL;
+
+	pr_info("CBT map create\n");
+
+	cbt_map = kzalloc(sizeof(struct cbt_map), GFP_KERNEL);
+	if (cbt_map == NULL)
+		return NULL;
+
+	if (cbt_map_allocate(cbt_map, cbt_sect_in_block_degree, device_capacity) != SUCCESS) {
+		cbt_map_destroy(cbt_map);
+		return NULL;
+	}
+
+	spin_lock_init(&cbt_map->locker);
+	init_rwsem(&cbt_map->rw_lock);
+	kref_init(&cbt_map->refcount);
+
+	return cbt_map;
+}
+
+void cbt_map_destroy_cb(struct kref *kref)
+{
+	cbt_map_destroy(container_of(kref, struct cbt_map, refcount));
+}
+
+struct cbt_map *cbt_map_get_resource(struct cbt_map *cbt_map)
+{
+	if (cbt_map)
+		kref_get(&cbt_map->refcount);
+
+	return cbt_map;
+}
+
+void cbt_map_put_resource(struct cbt_map *cbt_map)
+{
+	if (cbt_map)
+		kref_put(&cbt_map->refcount, cbt_map_destroy_cb);
+}
+
+void cbt_map_switch(struct cbt_map *cbt_map)
+{
+	pr_info("CBT map switch\n");
+	spin_lock(&cbt_map->locker);
+
+	big_buffer_memcpy(cbt_map->read_map, cbt_map->write_map);
+
+	cbt_map->snap_number_previous = cbt_map->snap_number_active;
+	++cbt_map->snap_number_active;
+	if (cbt_map->snap_number_active == 256) {
+		cbt_map->snap_number_active = 1;
+
+		big_buffer_memset(cbt_map->write_map, 0);
+
+		generate_random_uuid(cbt_map->generationId.b);
+
+		pr_info("CBT reset\n");
+	}
+	spin_unlock(&cbt_map->locker);
+}
+
+int _cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start, sector_t sector_cnt,
+		 u8 snap_number, struct big_buffer *map)
+{
+	int res = SUCCESS;
+	size_t cbt_block;
+	size_t cbt_block_first = (size_t)(sector_start >> cbt_map->sect_in_block_degree);
+	size_t cbt_block_last = (size_t)((sector_start + sector_cnt - 1) >>
+					 cbt_map->sect_in_block_degree); //inclusive
+
+	for (cbt_block = cbt_block_first; cbt_block <= cbt_block_last; ++cbt_block) {
+		if (cbt_block < cbt_map->map_size) {
+			u8 num;
+
+			res = big_buffer_byte_get(map, cbt_block, &num);
+			if (res == SUCCESS)
+				if (num < snap_number)
+					res = big_buffer_byte_set(map, cbt_block, snap_number);
+		} else
+			res = -EINVAL;
+
+		if (res != SUCCESS) {
+			pr_err("Block index is too large. #%zu was demanded, map size %zu\n",
+			       cbt_block, cbt_map->map_size);
+			break;
+		}
+	}
+	return res;
+}
+
+int cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start, sector_t sector_cnt)
+{
+	int res = SUCCESS;
+
+	spin_lock(&cbt_map->locker);
+
+	res = _cbt_map_set(cbt_map, sector_start, sector_cnt, (u8)cbt_map->snap_number_active,
+			   cbt_map->write_map);
+	cbt_map->state_changed_sectors += sector_cnt;
+
+	spin_unlock(&cbt_map->locker);
+	return res;
+}
+
+int cbt_map_set_both(struct cbt_map *cbt_map, sector_t sector_start, sector_t sector_cnt)
+{
+	int res = SUCCESS;
+
+	spin_lock(&cbt_map->locker);
+
+	res = _cbt_map_set(cbt_map, sector_start, sector_cnt,
+			   (u8)cbt_map->snap_number_active, cbt_map->write_map);
+	if (res == SUCCESS)
+		res = _cbt_map_set(cbt_map, sector_start, sector_cnt,
+				   (u8)cbt_map->snap_number_previous, cbt_map->read_map);
+	cbt_map->state_dirty_sectors += sector_cnt;
+
+	spin_unlock(&cbt_map->locker);
+	return res;
+}
+
+size_t cbt_map_read_to_user(struct cbt_map *cbt_map, void __user *user_buff, size_t offset,
+			    size_t size)
+{
+	size_t readed = 0;
+	size_t left_size;
+	size_t real_size = min((cbt_map->map_size - offset), size);
+
+	left_size = real_size -
+		    big_buffer_copy_to_user(user_buff, offset, cbt_map->read_map, real_size);
+
+	if (left_size == 0)
+		readed = real_size;
+	else {
+		pr_err("Not all CBT data was read. Left [%zu] bytes\n", left_size);
+		readed = real_size - left_size;
+	}
+
+	return readed;
+}
diff --git a/drivers/block/blk-snap/cbt_map.h b/drivers/block/blk-snap/cbt_map.h
new file mode 100644
index 000000000000..cb52b09531fe
--- /dev/null
+++ b/drivers/block/blk-snap/cbt_map.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#include "big_buffer.h"
+#include <linux/kref.h>
+#include <linux/uuid.h>
+
+struct cbt_map {
+	struct kref refcount;
+
+	spinlock_t locker;
+
+	size_t sect_in_block_degree;
+	sector_t device_capacity;
+	size_t map_size;
+
+	struct big_buffer *read_map;
+	struct big_buffer *write_map;
+
+	unsigned long snap_number_active;
+	unsigned long snap_number_previous;
+	uuid_t generationId;
+
+	bool active;
+
+	struct rw_semaphore rw_lock;
+
+	sector_t state_changed_sectors;
+	sector_t state_dirty_sectors;
+};
+
+struct cbt_map *cbt_map_create(unsigned int cbt_sect_in_block_degree, sector_t device_capacity);
+
+struct cbt_map *cbt_map_get_resource(struct cbt_map *cbt_map);
+void cbt_map_put_resource(struct cbt_map *cbt_map);
+
+void cbt_map_switch(struct cbt_map *cbt_map);
+int cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start, sector_t sector_cnt);
+int cbt_map_set_both(struct cbt_map *cbt_map, sector_t sector_start, sector_t sector_cnt);
+
+size_t cbt_map_read_to_user(struct cbt_map *cbt_map, void __user *user_buffer, size_t offset,
+			    size_t size);
+
+static inline void cbt_map_read_lock(struct cbt_map *cbt_map)
+{
+	down_read(&cbt_map->rw_lock);
+};
+
+static inline void cbt_map_read_unlock(struct cbt_map *cbt_map)
+{
+	up_read(&cbt_map->rw_lock);
+};
+
+static inline void cbt_map_write_lock(struct cbt_map *cbt_map)
+{
+	down_write(&cbt_map->rw_lock);
+};
+
+static inline void cbt_map_write_unlock(struct cbt_map *cbt_map)
+{
+	up_write(&cbt_map->rw_lock);
+};
diff --git a/drivers/block/blk-snap/common.h b/drivers/block/blk-snap/common.h
new file mode 100644
index 000000000000..bbd5e98ab2a6
--- /dev/null
+++ b/drivers/block/blk-snap/common.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#ifndef BLK_SNAP_SECTION
+#define BLK_SNAP_SECTION ""
+#endif
+#define pr_fmt(fmt) KBUILD_MODNAME BLK_SNAP_SECTION ": " fmt
+
+#include <linux/version.h> /*rudiment - needed for using KERNEL_VERSION */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/atomic.h>
+#include <linux/blkdev.h>
+
+#define from_sectors(_sectors) (_sectors << SECTOR_SHIFT)
+#define to_sectors(_byte_size) (_byte_size >> SECTOR_SHIFT)
+
+struct blk_range {
+	sector_t ofs;
+	blkcnt_t cnt;
+};
+
+#ifndef SUCCESS
+#define SUCCESS 0
+#endif
diff --git a/drivers/block/blk-snap/ctrl_fops.c b/drivers/block/blk-snap/ctrl_fops.c
new file mode 100644
index 000000000000..b7b18539ee96
--- /dev/null
+++ b/drivers/block/blk-snap/ctrl_fops.c
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-ctrl"
+#include "common.h"
+#include "blk-snap-ctl.h"
+#include "ctrl_fops.h"
+#include "version.h"
+#include "tracking.h"
+#include "snapshot.h"
+#include "snapstore.h"
+#include "snapimage.h"
+#include "tracker.h"
+#include "blk_deferred.h"
+#include "big_buffer.h"
+#include "params.h"
+
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/uaccess.h>
+
+int blk_snap_major; //zero by default
+
+const struct file_operations ctrl_fops = { .owner = THIS_MODULE,
+					   .read = ctrl_read,
+					   .write = ctrl_write,
+					   .open = ctrl_open,
+					   .release = ctrl_release,
+					   .poll = ctrl_poll,
+					   .unlocked_ioctl = ctrl_unlocked_ioctl };
+
+atomic_t dev_open_cnt = ATOMIC_INIT(0);
+
+const struct ioctl_getversion_s version = { .major = FILEVER_MAJOR,
+					    .minor = FILEVER_MINOR,
+					    .revision = FILEVER_REVISION,
+					    .build = 0 };
+
+int get_blk_snap_major(void)
+{
+	return blk_snap_major;
+}
+
+int ctrl_init(void)
+{
+	int ret;
+
+	ret = register_chrdev(0, MODULE_NAME, &ctrl_fops);
+	if (ret < 0) {
+		pr_err("Failed to register a character device. errno=%d\n", blk_snap_major);
+		return ret;
+	}
+
+	blk_snap_major = ret;
+	pr_info("Module major [%d]\n", blk_snap_major);
+	return SUCCESS;
+}
+
+void ctrl_done(void)
+{
+	unregister_chrdev(blk_snap_major, MODULE_NAME);
+	ctrl_pipe_done();
+}
+
+ssize_t ctrl_read(struct file *fl, char __user *buffer, size_t length, loff_t *offset)
+{
+	ssize_t bytes_read = 0;
+	struct ctrl_pipe *pipe = (struct ctrl_pipe *)fl->private_data;
+
+	if (pipe == NULL) {
+		pr_err("Unable to read from pipe: invalid pipe pointer\n");
+		return -EINVAL;
+	}
+
+	bytes_read = ctrl_pipe_read(pipe, buffer, length);
+	if (bytes_read == 0)
+		if (fl->f_flags & O_NONBLOCK)
+			bytes_read = -EAGAIN;
+
+	return bytes_read;
+}
+
+ssize_t ctrl_write(struct file *fl, const char __user *buffer, size_t length, loff_t *offset)
+{
+	struct ctrl_pipe *pipe = (struct ctrl_pipe *)fl->private_data;
+
+	if (pipe == NULL) {
+		pr_err("Unable to write into pipe: invalid pipe pointer\n");
+		return -EINVAL;
+	}
+
+	return ctrl_pipe_write(pipe, buffer, length);
+}
+
+unsigned int ctrl_poll(struct file *fl, struct poll_table_struct *wait)
+{
+	struct ctrl_pipe *pipe = (struct ctrl_pipe *)fl->private_data;
+
+	if (pipe == NULL) {
+		pr_err("Unable to poll pipe: invalid pipe pointer\n");
+		return -EINVAL;
+	}
+
+	return ctrl_pipe_poll(pipe);
+}
+
+int ctrl_open(struct inode *inode, struct file *fl)
+{
+	fl->f_pos = 0;
+
+	if (false == try_module_get(THIS_MODULE))
+		return -EINVAL;
+
+	fl->private_data = (void *)ctrl_pipe_new();
+	if (fl->private_data == NULL) {
+		pr_err("Failed to open ctrl file\n");
+		return -ENOMEM;
+	}
+
+	atomic_inc(&dev_open_cnt);
+
+	return SUCCESS;
+}
+
+int ctrl_release(struct inode *inode, struct file *fl)
+{
+	int result = SUCCESS;
+
+	if (atomic_read(&dev_open_cnt) > 0) {
+		module_put(THIS_MODULE);
+		ctrl_pipe_put_resource((struct ctrl_pipe *)fl->private_data);
+
+		atomic_dec(&dev_open_cnt);
+	} else {
+		pr_err("Unable to close ctrl file: the file is already closed\n");
+		result = -EALREADY;
+	}
+
+	return result;
+}
+
+int ioctl_compatibility_flags(unsigned long arg)
+{
+	unsigned long len;
+	struct ioctl_compatibility_flags_s param;
+
+	param.flags = 0;
+	param.flags |= BLK_SNAP_COMPATIBILITY_SNAPSTORE;
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	param.flags |= BLK_SNAP_COMPATIBILITY_MULTIDEV;
+#endif
+	len = copy_to_user((void *)arg, &param, sizeof(struct ioctl_compatibility_flags_s));
+	if (len != 0) {
+		pr_err("Unable to get compatibility flags: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	return SUCCESS;
+}
+
+int ioctl_get_version(unsigned long arg)
+{
+	unsigned long len;
+
+	pr_info("Get version\n");
+
+	len = copy_to_user((void *)arg, &version, sizeof(struct ioctl_getversion_s));
+	if (len != 0) {
+		pr_err("Unable to get version: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return SUCCESS;
+}
+
+int ioctl_tracking_add(unsigned long arg)
+{
+	unsigned long len;
+	struct ioctl_dev_id_s dev;
+
+	len = copy_from_user(&dev, (void *)arg, sizeof(struct ioctl_dev_id_s));
+	if (len != 0) {
+		pr_err("Unable to add device under tracking: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return tracking_add(MKDEV(dev.major, dev.minor), 0ull);
+}
+
+int ioctl_tracking_remove(unsigned long arg)
+{
+	struct ioctl_dev_id_s dev;
+
+	if (copy_from_user(&dev, (void *)arg, sizeof(struct ioctl_dev_id_s)) != 0) {
+		pr_err("Unable to remove device from tracking: invalid user buffer\n");
+		return -ENODATA;
+	}
+	return tracking_remove(MKDEV(dev.major, dev.minor));
+	;
+}
+
+int ioctl_tracking_collect(unsigned long arg)
+{
+	unsigned long len;
+	int res;
+	struct ioctl_tracking_collect_s get;
+
+	pr_info("Collecting tracking devices:\n");
+
+	len = copy_from_user(&get, (void *)arg, sizeof(struct ioctl_tracking_collect_s));
+	if (len  != 0) {
+		pr_err("Unable to collect tracking devices: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	if (get.p_cbt_info == NULL) {
+		res = tracking_collect(0x7FFFffff, NULL, &get.count);
+		if (res == SUCCESS) {
+			len = copy_to_user((void *)arg, (void *)&get,
+					   sizeof(struct ioctl_tracking_collect_s));
+			if (len != 0) {
+				pr_err("Unable to collect tracking devices: invalid user buffer for arguments\n");
+				res = -ENODATA;
+			}
+		} else {
+			pr_err("Failed to execute tracking_collect. errno=%d\n", res);
+		}
+	} else {
+		struct cbt_info_s *p_cbt_info = NULL;
+
+		p_cbt_info = kcalloc(get.count, sizeof(struct cbt_info_s), GFP_KERNEL);
+		if (p_cbt_info == NULL)
+			return -ENOMEM;
+
+		do {
+			res = tracking_collect(get.count, p_cbt_info, &get.count);
+			if (res != SUCCESS) {
+				pr_err("Failed to execute tracking_collect. errno=%d\n", res);
+				break;
+			}
+			len = copy_to_user(get.p_cbt_info, p_cbt_info,
+					      get.count * sizeof(struct cbt_info_s));
+			if (len != 0) {
+				pr_err("Unable to collect tracking devices: invalid user buffer for CBT info\n");
+				res = -ENODATA;
+				break;
+			}
+
+			len = copy_to_user((void *)arg, (void *)&get,
+					   sizeof(struct ioctl_tracking_collect_s));
+			if (len != 0) {
+				pr_err("Unable to collect tracking devices: invalid user buffer for arguments\n");
+				res = -ENODATA;
+				break;
+			}
+
+		} while (false);
+
+		kfree(p_cbt_info);
+		p_cbt_info = NULL;
+	}
+	return res;
+}
+
+int ioctl_tracking_block_size(unsigned long arg)
+{
+	unsigned long len;
+	unsigned int blk_sz = change_tracking_block_size();
+
+	len = copy_to_user((void *)arg, &blk_sz, sizeof(unsigned int));
+	if (len != 0) {
+		pr_err("Unable to get tracking block size: invalid user buffer for arguments\n");
+		return -ENODATA;
+	}
+	return SUCCESS;
+}
+
+int ioctl_tracking_read_cbt_map(unsigned long arg)
+{
+	dev_t dev_id;
+	unsigned long len;
+	struct ioctl_tracking_read_cbt_bitmap_s readbitmap;
+
+	len = copy_from_user(&readbitmap, (void *)arg,
+				sizeof(struct ioctl_tracking_read_cbt_bitmap_s));
+	if (len != 0) {
+		pr_err("Unable to read CBT map: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	dev_id = MKDEV(readbitmap.dev_id.major, readbitmap.dev_id.minor);
+	return tracking_read_cbt_bitmap(dev_id, readbitmap.offset, readbitmap.length,
+					(void *)readbitmap.buff);
+}
+
+int ioctl_tracking_mark_dirty_blocks(unsigned long arg)
+{
+	unsigned long len;
+	struct ioctl_tracking_mark_dirty_blocks_s param;
+	struct block_range_s *p_dirty_blocks;
+	size_t buffer_size;
+	int result = SUCCESS;
+
+	len = copy_from_user(&param, (void *)arg,
+			     sizeof(struct ioctl_tracking_mark_dirty_blocks_s));
+	if (len != 0) {
+		pr_err("Unable to mark dirty blocks: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	buffer_size = param.count * sizeof(struct block_range_s);
+	p_dirty_blocks = kzalloc(buffer_size, GFP_KERNEL);
+	if (p_dirty_blocks == NULL) {
+		pr_err("Unable to mark dirty blocks: cannot allocate [%zu] bytes\n", buffer_size);
+		return -ENOMEM;
+	}
+
+	do {
+		dev_t image_dev_id;
+
+		len = copy_from_user(p_dirty_blocks, (void *)param.p_dirty_blocks, buffer_size);
+		if (len != 0) {
+			pr_err("Unable to mark dirty blocks: invalid user buffer\n");
+			result = -ENODATA;
+			break;
+		}
+
+		image_dev_id = MKDEV(param.image_dev_id.major, param.image_dev_id.minor);
+		result = snapimage_mark_dirty_blocks(image_dev_id, p_dirty_blocks, param.count);
+	} while (false);
+	kfree(p_dirty_blocks);
+
+	return result;
+}
+
+int ioctl_snapshot_create(unsigned long arg)
+{
+	unsigned long len;
+	size_t dev_id_buffer_size;
+	int status;
+	struct ioctl_snapshot_create_s param;
+	struct ioctl_dev_id_s *pk_dev_id = NULL;
+
+	len = copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapshot_create_s));
+	if (len != 0) {
+		pr_err("Unable to create snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	dev_id_buffer_size = sizeof(struct ioctl_dev_id_s) * param.count;
+	pk_dev_id = kzalloc(dev_id_buffer_size, GFP_KERNEL);
+	if (pk_dev_id == NULL) {
+		pr_err("Unable to create snapshot: cannot allocate [%zu] bytes\n",
+		       dev_id_buffer_size);
+		return -ENOMEM;
+	}
+
+	do {
+		size_t dev_buffer_size;
+		dev_t *p_dev = NULL;
+		int inx = 0;
+
+		len = copy_from_user(pk_dev_id, (void *)param.p_dev_id,
+				     param.count * sizeof(struct ioctl_dev_id_s));
+		if (len != 0) {
+			pr_err("Unable to create snapshot: invalid user buffer for parameters\n");
+			status = -ENODATA;
+			break;
+		}
+
+		dev_buffer_size = sizeof(dev_t) * param.count;
+		p_dev = kzalloc(dev_buffer_size, GFP_KERNEL);
+		if (p_dev == NULL) {
+			pr_err("Unable to create snapshot: cannot allocate [%zu] bytes\n",
+			       dev_buffer_size);
+			status = -ENOMEM;
+			break;
+		}
+
+		for (inx = 0; inx < param.count; ++inx)
+			p_dev[inx] = MKDEV(pk_dev_id[inx].major, pk_dev_id[inx].minor);
+
+		status = snapshot_create(p_dev, param.count, &param.snapshot_id);
+
+		kfree(p_dev);
+		p_dev = NULL;
+
+	} while (false);
+	kfree(pk_dev_id);
+	pk_dev_id = NULL;
+
+	if (status == SUCCESS) {
+		len = copy_to_user((void *)arg, &param, sizeof(struct ioctl_snapshot_create_s));
+		if (len != 0) {
+			pr_err("Unable to create snapshot: invalid user buffer\n");
+			status = -ENODATA;
+		}
+	}
+
+	return status;
+}
+
+int ioctl_snapshot_destroy(unsigned long arg)
+{
+	unsigned long len;
+	unsigned long long param;
+
+	len = copy_from_user(&param, (void *)arg, sizeof(unsigned long long));
+	if (len != 0) {
+		pr_err("Unable to destroy snapshot: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return snapshot_destroy(param);
+}
+
+static inline dev_t _snapstore_dev(struct ioctl_dev_id_s *dev_id)
+{
+	if ((dev_id->major == 0) && (dev_id->minor == 0))
+		return 0; //memory snapstore
+
+	if ((dev_id->major == -1) && (dev_id->minor == -1))
+		return 0xFFFFffff; //multidevice snapstore
+
+	return MKDEV(dev_id->major, dev_id->minor);
+}
+
+int ioctl_snapstore_create(unsigned long arg)
+{
+	unsigned long len;
+	int res = SUCCESS;
+	struct ioctl_snapstore_create_s param;
+	size_t inx = 0;
+	dev_t *dev_id_set = NULL;
+
+	len = copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapstore_create_s));
+	if (len != 0) {
+		pr_err("Unable to create snapstore: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	dev_id_set = kcalloc(param.count, sizeof(dev_t), GFP_KERNEL);
+	if (dev_id_set == NULL)
+		return -ENOMEM;
+
+	for (inx = 0; inx < param.count; ++inx) {
+		struct ioctl_dev_id_s dev_id;
+
+		len = copy_from_user(&dev_id, param.p_dev_id + inx, sizeof(struct ioctl_dev_id_s));
+		if (len != 0) {
+			pr_err("Unable to create snapstore: ");
+			pr_err("invalid user buffer for parameters\n");
+
+			res = -ENODATA;
+			break;
+		}
+
+		dev_id_set[inx] = MKDEV(dev_id.major, dev_id.minor);
+	}
+
+	if (res == SUCCESS)
+		res = snapstore_create((uuid_t *)param.id, _snapstore_dev(&param.snapstore_dev_id),
+				       dev_id_set, (size_t)param.count);
+
+	kfree(dev_id_set);
+
+	return res;
+}
+
+int ioctl_snapstore_file(unsigned long arg)
+{
+	unsigned long len;
+	int res = SUCCESS;
+	struct ioctl_snapstore_file_add_s param;
+	struct big_buffer *ranges = NULL;
+	size_t ranges_buffer_size;
+
+	len = copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapstore_file_add_s));
+	if (len != 0) {
+		pr_err("Unable to add file to snapstore: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	ranges_buffer_size = sizeof(struct ioctl_range_s) * param.range_count;
+
+	ranges = big_buffer_alloc(ranges_buffer_size, GFP_KERNEL);
+	if (ranges == NULL) {
+		pr_err("Unable to add file to snapstore: cannot allocate [%zu] bytes\n",
+		       ranges_buffer_size);
+		return -ENOMEM;
+	}
+
+	if (big_buffer_copy_from_user((void *)param.ranges, 0, ranges, ranges_buffer_size)
+		!= ranges_buffer_size) {
+
+		pr_err("Unable to add file to snapstore: invalid user buffer for parameters\n");
+		res = -ENODATA;
+	} else
+		res = snapstore_add_file((uuid_t *)(param.id), ranges, (size_t)param.range_count);
+
+	big_buffer_free(ranges);
+
+	return res;
+}
+
+int ioctl_snapstore_memory(unsigned long arg)
+{
+	unsigned long len;
+	int res = SUCCESS;
+	struct ioctl_snapstore_memory_limit_s param;
+
+	len = copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapstore_memory_limit_s));
+	if (len != 0) {
+		pr_err("Unable to add memory block to snapstore: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	res = snapstore_add_memory((uuid_t *)param.id, param.size);
+
+	return res;
+}
+int ioctl_snapstore_cleanup(unsigned long arg)
+{
+	unsigned long len;
+	int res = SUCCESS;
+	struct ioctl_snapstore_cleanup_s param;
+
+	len = copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapstore_cleanup_s));
+	if (len != 0) {
+		pr_err("Unable to perform snapstore cleanup: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	pr_info("Cleanup snapstore %pUB\n", (uuid_t *)param.id);
+	res = snapstore_cleanup((uuid_t *)param.id, &param.filled_bytes);
+
+	if (res == SUCCESS) {
+		if (0 !=
+		    copy_to_user((void *)arg, &param, sizeof(struct ioctl_snapstore_cleanup_s))) {
+			pr_err("Unable to perform snapstore cleanup: invalid user buffer\n");
+			res = -ENODATA;
+		}
+	}
+
+	return res;
+}
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+int ioctl_snapstore_file_multidev(unsigned long arg)
+{
+	unsigned long len;
+	int res = SUCCESS;
+	struct ioctl_snapstore_file_add_multidev_s param;
+	struct big_buffer *ranges = NULL; //struct ioctl_range_s* ranges = NULL;
+	size_t ranges_buffer_size;
+
+	len = copy_from_user(&param, (void *)arg,
+				sizeof(struct ioctl_snapstore_file_add_multidev_s));
+	if (len != 0) {
+		pr_err("Unable to add file to multidev snapstore: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	ranges_buffer_size = sizeof(struct ioctl_range_s) * param.range_count;
+
+	ranges = big_buffer_alloc(ranges_buffer_size, GFP_KERNEL);
+	if (ranges == NULL) {
+		pr_err("Unable to add file to multidev snapstore: cannot allocate [%zu] bytes\n",
+		       ranges_buffer_size);
+		return -ENOMEM;
+	}
+
+	do {
+		uuid_t *id = (uuid_t *)(param.id);
+		dev_t snapstore_device = MKDEV(param.dev_id.major, param.dev_id.minor);
+		size_t ranges_cnt = (size_t)param.range_count;
+
+		if (ranges_buffer_size != big_buffer_copy_from_user((void *)param.ranges, 0, ranges,
+								    ranges_buffer_size)) {
+			pr_err("Unable to add file to snapstore: invalid user buffer for parameters\n");
+			res = -ENODATA;
+			break;
+		}
+
+		res = snapstore_add_multidev(id, snapstore_device, ranges, ranges_cnt);
+	} while (false);
+	big_buffer_free(ranges);
+
+	return res;
+}
+
+#endif
+//////////////////////////////////////////////////////////////////////////
+
+/*
+ * Snapshot get errno for device
+ */
+int ioctl_snapshot_errno(unsigned long arg)
+{
+	unsigned long len;
+	int res;
+	struct ioctl_snapshot_errno_s param;
+
+	len = copy_from_user(&param, (void *)arg, sizeof(struct ioctl_dev_id_s));
+	if (len != 0) {
+		pr_err("Unable failed to get snapstore error code: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	res = snapstore_device_errno(MKDEV(param.dev_id.major, param.dev_id.minor),
+				     &param.err_code);
+
+	if (res != SUCCESS)
+		return res;
+
+	len = copy_to_user((void *)arg, &param, sizeof(struct ioctl_snapshot_errno_s));
+	if (len != 0) {
+		pr_err("Unable to get snapstore error code: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	return SUCCESS;
+}
+
+int ioctl_collect_snapimages(unsigned long arg)
+{
+	unsigned long len;
+	int status = SUCCESS;
+	struct ioctl_collect_snapshot_images_s param;
+
+	len = copy_from_user(&param, (void *)arg, sizeof(struct ioctl_collect_snapshot_images_s));
+	if (len != 0) {
+		pr_err("Unable to collect snapshot images: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	status = snapimage_collect_images(param.count, param.p_image_info, &param.count);
+
+	len = copy_to_user((void *)arg, &param, sizeof(struct ioctl_collect_snapshot_images_s));
+	if (len != 0) {
+		pr_err("Unable to collect snapshot images: invalid user buffer\n");
+		return -ENODATA;
+	}
+
+	return status;
+}
+
+struct blk_snap_ioctl_table {
+	unsigned int cmd;
+	int (*fn)(unsigned long arg);
+};
+
+static struct blk_snap_ioctl_table blk_snap_ioctl_table[] = {
+	{ (IOCTL_COMPATIBILITY_FLAGS), ioctl_compatibility_flags },
+	{ (IOCTL_GETVERSION), ioctl_get_version },
+
+	{ (IOCTL_TRACKING_ADD), ioctl_tracking_add },
+	{ (IOCTL_TRACKING_REMOVE), ioctl_tracking_remove },
+	{ (IOCTL_TRACKING_COLLECT), ioctl_tracking_collect },
+	{ (IOCTL_TRACKING_BLOCK_SIZE), ioctl_tracking_block_size },
+	{ (IOCTL_TRACKING_READ_CBT_BITMAP), ioctl_tracking_read_cbt_map },
+	{ (IOCTL_TRACKING_MARK_DIRTY_BLOCKS), ioctl_tracking_mark_dirty_blocks },
+
+	{ (IOCTL_SNAPSHOT_CREATE), ioctl_snapshot_create },
+	{ (IOCTL_SNAPSHOT_DESTROY), ioctl_snapshot_destroy },
+	{ (IOCTL_SNAPSHOT_ERRNO), ioctl_snapshot_errno },
+
+	{ (IOCTL_SNAPSTORE_CREATE), ioctl_snapstore_create },
+	{ (IOCTL_SNAPSTORE_FILE), ioctl_snapstore_file },
+	{ (IOCTL_SNAPSTORE_MEMORY), ioctl_snapstore_memory },
+	{ (IOCTL_SNAPSTORE_CLEANUP), ioctl_snapstore_cleanup },
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	{ (IOCTL_SNAPSTORE_FILE_MULTIDEV), ioctl_snapstore_file_multidev },
+#endif
+	{ (IOCTL_COLLECT_SNAPSHOT_IMAGES), ioctl_collect_snapimages },
+	{ 0, NULL }
+};
+
+long ctrl_unlocked_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	long status = -ENOTTY;
+	size_t inx = 0;
+
+	while (blk_snap_ioctl_table[inx].cmd != 0) {
+		if (blk_snap_ioctl_table[inx].cmd == cmd) {
+			status = blk_snap_ioctl_table[inx].fn(arg);
+			break;
+		}
+		++inx;
+	}
+
+	return status;
+}
diff --git a/drivers/block/blk-snap/ctrl_fops.h b/drivers/block/blk-snap/ctrl_fops.h
new file mode 100644
index 000000000000..98072b61aa96
--- /dev/null
+++ b/drivers/block/blk-snap/ctrl_fops.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#include <linux/fs.h>
+
+int get_blk_snap_major(void);
+
+int ctrl_init(void);
+void ctrl_done(void);
+
+int ctrl_open(struct inode *inode, struct file *file);
+int ctrl_release(struct inode *inode, struct file *file);
+
+ssize_t ctrl_read(struct file *filp, char __user *buffer, size_t length, loff_t *offset);
+ssize_t ctrl_write(struct file *filp, const char __user *buffer, size_t length, loff_t *offset);
+
+unsigned int ctrl_poll(struct file *filp, struct poll_table_struct *wait);
+
+long ctrl_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/drivers/block/blk-snap/ctrl_pipe.c b/drivers/block/blk-snap/ctrl_pipe.c
new file mode 100644
index 000000000000..73cfbca93487
--- /dev/null
+++ b/drivers/block/blk-snap/ctrl_pipe.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-ctrl"
+#include "common.h"
+#include "ctrl_pipe.h"
+#include "version.h"
+#include "blk-snap-ctl.h"
+#include "snapstore.h"
+#include "big_buffer.h"
+
+#include <linux/poll.h>
+#include <linux/uuid.h>
+
+#define CMD_TO_USER_FIFO_SIZE 1024
+
+LIST_HEAD(ctl_pipes);
+DECLARE_RWSEM(ctl_pipes_lock);
+
+
+static void ctrl_pipe_push_request(struct ctrl_pipe *pipe, unsigned int *cmd, size_t cmd_len)
+{
+	kfifo_in_spinlocked(&pipe->cmd_to_user, cmd, (cmd_len * sizeof(unsigned int)),
+			    &pipe->cmd_to_user_lock);
+
+	wake_up(&pipe->readq);
+}
+
+static void ctrl_pipe_request_acknowledge(struct ctrl_pipe *pipe, unsigned int result)
+{
+	unsigned int cmd[2];
+
+	cmd[0] = BLK_SNAP_CHARCMD_ACKNOWLEDGE;
+	cmd[1] = result;
+
+	ctrl_pipe_push_request(pipe, cmd, 2);
+}
+
+static inline dev_t _snapstore_dev(struct ioctl_dev_id_s *dev_id)
+{
+	if ((dev_id->major == 0) && (dev_id->minor == 0))
+		return 0; //memory snapstore
+
+	if ((dev_id->major == -1) && (dev_id->minor == -1))
+		return 0xFFFFffff; //multidevice snapstore
+
+	return MKDEV(dev_id->major, dev_id->minor);
+}
+
+static ssize_t ctrl_pipe_command_initiate(struct ctrl_pipe *pipe, const char __user *buffer,
+					  size_t length)
+{
+	unsigned long len;
+	int result = SUCCESS;
+	ssize_t processed = 0;
+	char *kernel_buffer;
+
+	kernel_buffer = kmalloc(length, GFP_KERNEL);
+	if (kernel_buffer == NULL)
+		return -ENOMEM;
+
+	len = copy_from_user(kernel_buffer, buffer, length);
+	if (len != 0) {
+		kfree(kernel_buffer);
+		pr_err("Unable to write to pipe: invalid user buffer\n");
+		return -EINVAL;
+	}
+
+	do {
+		u64 stretch_empty_limit;
+		unsigned int dev_id_list_length;
+		uuid_t *unique_id;
+		struct ioctl_dev_id_s *snapstore_dev_id;
+		struct ioctl_dev_id_s *dev_id_list;
+
+		//get snapstore uuid
+		if ((length - processed) < 16) {
+			pr_err("Unable to get snapstore uuid: invalid ctrl pipe initiate command. length=%zu\n",
+			       length);
+			break;
+		}
+		unique_id = (uuid_t *)(kernel_buffer + processed);
+		processed += 16;
+
+		//get snapstore empty limit
+		if ((length - processed) < sizeof(u64)) {
+			pr_err("Unable to get stretch snapstore limit: invalid ctrl pipe initiate command. length=%zu\n",
+			       length);
+			break;
+		}
+		stretch_empty_limit = *(u64 *)(kernel_buffer + processed);
+		processed += sizeof(u64);
+
+		//get snapstore device id
+		if ((length - processed) < sizeof(struct ioctl_dev_id_s)) {
+			pr_err("Unable to get snapstore device id: invalid ctrl pipe initiate command. length=%zu\n",
+			       length);
+			break;
+		}
+		snapstore_dev_id = (struct ioctl_dev_id_s *)(kernel_buffer + processed);
+		processed += sizeof(struct ioctl_dev_id_s);
+
+		//get device id list length
+		if ((length - processed) < 4) {
+			pr_err("Unable to get device id list length: ivalid ctrl pipe initiate command. length=%zu\n",
+			       length);
+			break;
+		}
+		dev_id_list_length = *(unsigned int *)(kernel_buffer + processed);
+		processed += sizeof(unsigned int);
+
+		//get devices id list
+		if ((length - processed) < (dev_id_list_length * sizeof(struct ioctl_dev_id_s))) {
+			pr_err("Unable to get all devices from device id list: invalid ctrl pipe initiate command. length=%zu\n",
+			       length);
+			break;
+		}
+		dev_id_list = (struct ioctl_dev_id_s *)(kernel_buffer + processed);
+		processed += (dev_id_list_length * sizeof(struct ioctl_dev_id_s));
+
+		{
+			size_t inx;
+			dev_t *dev_set;
+			size_t dev_id_set_length = (size_t)dev_id_list_length;
+
+			dev_set = kcalloc(dev_id_set_length, sizeof(dev_t), GFP_KERNEL);
+			if (dev_set == NULL) {
+				result = -ENOMEM;
+				break;
+			}
+
+			for (inx = 0; inx < dev_id_set_length; ++inx)
+				dev_set[inx] =
+					MKDEV(dev_id_list[inx].major, dev_id_list[inx].minor);
+
+			result = snapstore_create(unique_id, _snapstore_dev(snapstore_dev_id),
+						  dev_set, dev_id_set_length);
+			kfree(dev_set);
+			if (result != SUCCESS) {
+				pr_err("Failed to create snapstore\n");
+				break;
+			}
+
+			result = snapstore_stretch_initiate(
+				unique_id, pipe, (sector_t)to_sectors(stretch_empty_limit));
+			if (result != SUCCESS) {
+				pr_err("Failed to initiate stretch snapstore %pUB\n", unique_id);
+				break;
+			}
+		}
+	} while (false);
+	kfree(kernel_buffer);
+	ctrl_pipe_request_acknowledge(pipe, result);
+
+	if (result == SUCCESS)
+		return processed;
+	return result;
+}
+
+static ssize_t ctrl_pipe_command_next_portion(struct ctrl_pipe *pipe, const char __user *buffer,
+					      size_t length)
+{
+	unsigned long len;
+	int result = SUCCESS;
+	ssize_t processed = 0;
+	struct big_buffer *ranges = NULL;
+
+	do {
+		uuid_t unique_id;
+		unsigned int ranges_length;
+		size_t ranges_buffer_size;
+
+		//get snapstore id
+		if ((length - processed) < 16) {
+			pr_err("Unable to get snapstore id: ");
+			pr_err("invalid ctrl pipe next portion command. length=%zu\n",
+			       length);
+			break;
+		}
+		len = copy_from_user(&unique_id, buffer + processed, sizeof(uuid_t));
+		if (len != 0) {
+			pr_err("Unable to write to pipe: invalid user buffer\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += 16;
+
+		//get ranges length
+		if ((length - processed) < 4) {
+			pr_err("Unable to get device id list length: ");
+			pr_err("invalid ctrl pipe next portion command. length=%zu\n",
+			       length);
+			break;
+		}
+		len = copy_from_user(&ranges_length, buffer + processed, sizeof(unsigned int));
+		if (len != 0) {
+			pr_err("Unable to write to pipe: invalid user buffer\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += sizeof(unsigned int);
+
+		ranges_buffer_size = ranges_length * sizeof(struct ioctl_range_s);
+
+		// ranges
+		if ((length - processed) < (ranges_buffer_size)) {
+			pr_err("Unable to get all ranges: ");
+			pr_err("invalid ctrl pipe next portion command. length=%zu\n",
+			       length);
+			break;
+		}
+		ranges = big_buffer_alloc(ranges_buffer_size, GFP_KERNEL);
+		if (ranges == NULL) {
+			pr_err("Unable to allocate page array buffer: ");
+			pr_err("failed to process next portion command\n");
+			processed = -ENOMEM;
+			break;
+		}
+		if (ranges_buffer_size !=
+		    big_buffer_copy_from_user(buffer + processed, 0, ranges, ranges_buffer_size)) {
+			pr_err("Unable to process next portion command: ");
+			pr_err("invalid user buffer for parameters\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += ranges_buffer_size;
+
+		{
+			result = snapstore_add_file(&unique_id, ranges, ranges_length);
+
+			if (result != SUCCESS) {
+				pr_err("Failed to add file to snapstore\n");
+				result = -ENODEV;
+				break;
+			}
+		}
+	} while (false);
+	if (ranges)
+		big_buffer_free(ranges);
+
+	if (result == SUCCESS)
+		return processed;
+	return result;
+}
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+static ssize_t ctrl_pipe_command_next_portion_multidev(struct ctrl_pipe *pipe,
+						       const char __user *buffer, size_t length)
+{
+	unsigned long len;
+	int result = SUCCESS;
+	ssize_t processed = 0;
+	struct big_buffer *ranges = NULL;
+
+	do {
+		uuid_t unique_id;
+		int snapstore_major;
+		int snapstore_minor;
+		unsigned int ranges_length;
+		size_t ranges_buffer_size;
+
+		//get snapstore id
+		if ((length - processed) < 16) {
+			pr_err("Unable to get snapstore id: ");
+			pr_err("invalid ctrl pipe next portion command. length=%zu\n",
+			       length);
+			break;
+		}
+		len = copy_from_user(&unique_id, buffer + processed, sizeof(uuid_t));
+		if (len != 0) {
+			pr_err("Unable to write to pipe: invalid user buffer\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += 16;
+
+		//get device id
+		if ((length - processed) < 8) {
+			pr_err("Unable to get device id list length: ");
+			pr_err("invalid ctrl pipe next portion command. length=%zu\n", length);
+			break;
+		}
+		len = copy_from_user(&snapstore_major, buffer + processed, sizeof(unsigned int));
+		if (len != 0) {
+			pr_err("Unable to write to pipe: invalid user buffer\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += sizeof(unsigned int);
+
+		len = copy_from_user(&snapstore_minor, buffer + processed, sizeof(unsigned int));
+		if (len != 0) {
+			pr_err("Unable to write to pipe: invalid user buffer\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += sizeof(unsigned int);
+
+		//get ranges length
+		if ((length - processed) < 4) {
+			pr_err("Unable to get device id list length: ");
+			pr_err("invalid ctrl pipe next portion command. length=%zu\n",
+			       length);
+			break;
+		}
+		len = copy_from_user(&ranges_length, buffer + processed, sizeof(unsigned int));
+		if (len != 0) {
+			pr_err("Unable to write to pipe: invalid user buffer\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += sizeof(unsigned int);
+
+		ranges_buffer_size = ranges_length * sizeof(struct ioctl_range_s);
+
+		// ranges
+		if ((length - processed) < (ranges_buffer_size)) {
+			pr_err("Unable to get all ranges: ");
+			pr_err("invalid ctrl pipe next portion command.  length=%zu\n",
+			       length);
+			break;
+		}
+		ranges = big_buffer_alloc(ranges_buffer_size, GFP_KERNEL);
+		if (ranges == NULL) {
+			pr_err("Unable to process next portion command: ");
+			pr_err("failed to allocate page array buffer\n");
+			processed = -ENOMEM;
+			break;
+		}
+		if (ranges_buffer_size !=
+		    big_buffer_copy_from_user(buffer + processed, 0, ranges, ranges_buffer_size)) {
+			pr_err("Unable to process next portion command: ");
+			pr_err("invalid user buffer from parameters\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += ranges_buffer_size;
+
+		{
+			result = snapstore_add_multidev(&unique_id,
+							MKDEV(snapstore_major, snapstore_minor),
+							ranges, ranges_length);
+
+			if (result != SUCCESS) {
+				pr_err("Failed to add file to snapstore\n");
+				result = -ENODEV;
+				break;
+			}
+		}
+	} while (false);
+	if (ranges)
+		big_buffer_free(ranges);
+
+	if (result == SUCCESS)
+		return processed;
+
+	return result;
+}
+#endif
+
+static void ctrl_pipe_release_cb(struct kref *kref)
+{
+	struct ctrl_pipe *pipe = container_of(kref, struct ctrl_pipe, refcount);
+
+	down_write(&ctl_pipes_lock);
+	list_del(&pipe->link);
+	up_write(&ctl_pipes_lock);
+
+	kfifo_free(&pipe->cmd_to_user);
+
+	kfree(pipe);
+}
+
+struct ctrl_pipe *ctrl_pipe_get_resource(struct ctrl_pipe *pipe)
+{
+	if (pipe)
+		kref_get(&pipe->refcount);
+
+	return pipe;
+}
+
+void ctrl_pipe_put_resource(struct ctrl_pipe *pipe)
+{
+	if (pipe)
+		kref_put(&pipe->refcount, ctrl_pipe_release_cb);
+}
+
+void ctrl_pipe_done(void)
+{
+	bool is_empty;
+
+	pr_info("Ctrl pipes - done\n");
+
+	down_write(&ctl_pipes_lock);
+	is_empty = list_empty(&ctl_pipes);
+	up_write(&ctl_pipes_lock);
+
+	if (!is_empty)
+		pr_err("Unable to perform ctrl pipes cleanup: container is not empty\n");
+}
+
+struct ctrl_pipe *ctrl_pipe_new(void)
+{
+	int ret;
+	struct ctrl_pipe *pipe;
+
+	pipe = kzalloc(sizeof(struct ctrl_pipe), GFP_KERNEL);
+	if (pipe == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&pipe->link);
+
+	ret = kfifo_alloc(&pipe->cmd_to_user, CMD_TO_USER_FIFO_SIZE, GFP_KERNEL);
+	if (ret) {
+		pr_err("Failed to allocate fifo. errno=%d.\n", ret);
+		kfree(pipe);
+		return NULL;
+	}
+	spin_lock_init(&pipe->cmd_to_user_lock);
+
+	kref_init(&pipe->refcount);
+
+	init_waitqueue_head(&pipe->readq);
+
+	down_write(&ctl_pipes_lock);
+	list_add_tail(&pipe->link, &ctl_pipes);
+	up_write(&ctl_pipes_lock);
+
+	return pipe;
+}
+
+ssize_t ctrl_pipe_read(struct ctrl_pipe *pipe, char __user *buffer, size_t length)
+{
+	int ret;
+	unsigned int processed = 0;
+
+	if (kfifo_is_empty_spinlocked(&pipe->cmd_to_user, &pipe->cmd_to_user_lock)) {
+		//nothing to read
+		ret = wait_event_interruptible(pipe->readq,
+					       !kfifo_is_empty_spinlocked(&pipe->cmd_to_user,
+									&pipe->cmd_to_user_lock));
+		if (ret) {
+			pr_err("Unable to wait for pipe read queue: interrupt signal was received\n");
+			return -ERESTARTSYS;
+		}
+	}
+
+	ret = kfifo_to_user(&pipe->cmd_to_user, buffer, length, &processed);
+	if (ret) {
+		pr_err("Failed to read command from ctrl pipe\n");
+		return ret;
+	}
+
+	return (ssize_t)processed;
+}
+
+ssize_t ctrl_pipe_write(struct ctrl_pipe *pipe, const char __user *buffer, size_t length)
+{
+	ssize_t processed = 0;
+
+	do {
+		unsigned long len;
+		unsigned int command;
+
+		if ((length - processed) < 4) {
+			pr_err("Unable to write command to ctrl pipe: invalid command length=%zu\n",
+			       length);
+			break;
+		}
+		len = copy_from_user(&command, buffer + processed, sizeof(unsigned int));
+		if (len != 0) {
+			pr_err("Unable to write to pipe: invalid user buffer\n");
+			processed = -EINVAL;
+			break;
+		}
+		processed += sizeof(unsigned int);
+		//+4
+		switch (command) {
+		case BLK_SNAP_CHARCMD_INITIATE: {
+			ssize_t res = ctrl_pipe_command_initiate(pipe, buffer + processed,
+								 length - processed);
+			if (res >= 0)
+				processed += res;
+			else
+				processed = res;
+		} break;
+		case BLK_SNAP_CHARCMD_NEXT_PORTION: {
+			ssize_t res = ctrl_pipe_command_next_portion(pipe, buffer + processed,
+								     length - processed);
+			if (res >= 0)
+				processed += res;
+			else
+				processed = res;
+		} break;
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+		case BLK_SNAP_CHARCMD_NEXT_PORTION_MULTIDEV: {
+			ssize_t res = ctrl_pipe_command_next_portion_multidev(
+				pipe, buffer + processed, length - processed);
+			if (res >= 0)
+				processed += res;
+			else
+				processed = res;
+		} break;
+#endif
+		default:
+			pr_err("Ctrl pipe write error: invalid command [0x%x] received\n", command);
+			break;
+		}
+	} while (false);
+	return processed;
+}
+
+unsigned int ctrl_pipe_poll(struct ctrl_pipe *pipe)
+{
+	unsigned int mask = 0;
+
+	if (!kfifo_is_empty_spinlocked(&pipe->cmd_to_user, &pipe->cmd_to_user_lock))
+		mask |= (POLLIN | POLLRDNORM); /* readable */
+
+	mask |= (POLLOUT | POLLWRNORM); /* writable */
+
+	return mask;
+}
+
+void ctrl_pipe_request_halffill(struct ctrl_pipe *pipe, unsigned long long filled_status)
+{
+	unsigned int cmd[3];
+
+	pr_info("Snapstore is half-full\n");
+
+	cmd[0] = (unsigned int)BLK_SNAP_CHARCMD_HALFFILL;
+	cmd[1] = (unsigned int)(filled_status & 0xFFFFffff); //lo
+	cmd[2] = (unsigned int)(filled_status >> 32);
+
+	ctrl_pipe_push_request(pipe, cmd, 3);
+}
+
+void ctrl_pipe_request_overflow(struct ctrl_pipe *pipe, unsigned int error_code,
+				unsigned long long filled_status)
+{
+	unsigned int cmd[4];
+
+	pr_info("Snapstore overflow\n");
+
+	cmd[0] = (unsigned int)BLK_SNAP_CHARCMD_OVERFLOW;
+	cmd[1] = error_code;
+	cmd[2] = (unsigned int)(filled_status & 0xFFFFffff); //lo
+	cmd[3] = (unsigned int)(filled_status >> 32);
+
+	ctrl_pipe_push_request(pipe, cmd, 4);
+}
+
+void ctrl_pipe_request_terminate(struct ctrl_pipe *pipe, unsigned long long filled_status)
+{
+	unsigned int cmd[3];
+
+	pr_info("Snapstore termination\n");
+
+	cmd[0] = (unsigned int)BLK_SNAP_CHARCMD_TERMINATE;
+	cmd[1] = (unsigned int)(filled_status & 0xFFFFffff); //lo
+	cmd[2] = (unsigned int)(filled_status >> 32);
+
+	ctrl_pipe_push_request(pipe, cmd, 3);
+}
diff --git a/drivers/block/blk-snap/ctrl_pipe.h b/drivers/block/blk-snap/ctrl_pipe.h
new file mode 100644
index 000000000000..1aa1099eec25
--- /dev/null
+++ b/drivers/block/blk-snap/ctrl_pipe.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#include <linux/kref.h>
+#include <linux/wait.h>
+#include <linux/kfifo.h>
+
+struct ctrl_pipe {
+	struct list_head link;
+
+	struct kref refcount;
+
+	wait_queue_head_t readq;
+
+	struct kfifo cmd_to_user;
+	spinlock_t cmd_to_user_lock;
+};
+
+struct ctrl_pipe *ctrl_pipe_get_resource(struct ctrl_pipe *pipe);
+void ctrl_pipe_put_resource(struct ctrl_pipe *pipe);
+
+void ctrl_pipe_done(void);
+
+struct ctrl_pipe *ctrl_pipe_new(void);
+
+ssize_t ctrl_pipe_read(struct ctrl_pipe *pipe, char __user *buffer, size_t length);
+ssize_t ctrl_pipe_write(struct ctrl_pipe *pipe, const char __user *buffer, size_t length);
+
+unsigned int ctrl_pipe_poll(struct ctrl_pipe *pipe);
+
+void ctrl_pipe_request_halffill(struct ctrl_pipe *pipe, unsigned long long filled_status);
+void ctrl_pipe_request_overflow(struct ctrl_pipe *pipe, unsigned int error_code,
+				unsigned long long filled_status);
+void ctrl_pipe_request_terminate(struct ctrl_pipe *pipe, unsigned long long filled_status);
diff --git a/drivers/block/blk-snap/ctrl_sysfs.c b/drivers/block/blk-snap/ctrl_sysfs.c
new file mode 100644
index 000000000000..4ec78e85b510
--- /dev/null
+++ b/drivers/block/blk-snap/ctrl_sysfs.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-ctrl"
+#include "common.h"
+#include "ctrl_sysfs.h"
+#include "ctrl_fops.h"
+#include "blk-snap-ctl.h"
+
+#include <linux/blkdev.h>
+#include <linux/sysfs.h>
+
+static ssize_t major_show(struct class *class, struct class_attribute *attr, char *buf)
+{
+	sprintf(buf, "%d", get_blk_snap_major());
+	return strlen(buf);
+}
+
+CLASS_ATTR_RO(major); // declare class_attr_major
+static struct class *blk_snap_class;
+
+static struct device *blk_snap_device;
+
+int ctrl_sysfs_init(void)
+{
+	struct device *dev;
+	int res;
+
+	blk_snap_class = class_create(THIS_MODULE, MODULE_NAME);
+	if (IS_ERR(blk_snap_class)) {
+		res = PTR_ERR(blk_snap_class);
+
+		pr_err("Bad class create. errno=%d\n", 0 - res);
+		return res;
+	}
+
+	pr_info("Create 'major' sysfs attribute\n");
+	res = class_create_file(blk_snap_class, &class_attr_major);
+	if (res != SUCCESS) {
+		pr_err("Failed to create 'major' sysfs file\n");
+
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+		return res;
+	}
+
+	dev = device_create(blk_snap_class, NULL, MKDEV(get_blk_snap_major(), 0), NULL,
+			    MODULE_NAME);
+	if (IS_ERR(dev)) {
+		res = PTR_ERR(dev);
+		pr_err("Failed to create device, errno=%d\n", res);
+
+		class_remove_file(blk_snap_class, &class_attr_major);
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+		return res;
+	}
+
+	blk_snap_device = dev;
+	return res;
+}
+
+void ctrl_sysfs_done(void)
+{
+	if (blk_snap_device) {
+		device_unregister(blk_snap_device);
+		blk_snap_device = NULL;
+	}
+
+	if (blk_snap_class != NULL) {
+		class_remove_file(blk_snap_class, &class_attr_major);
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+	}
+}
diff --git a/drivers/block/blk-snap/ctrl_sysfs.h b/drivers/block/blk-snap/ctrl_sysfs.h
new file mode 100644
index 000000000000..27a2a4d3da4c
--- /dev/null
+++ b/drivers/block/blk-snap/ctrl_sysfs.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+int ctrl_sysfs_init(void);
+void ctrl_sysfs_done(void);
diff --git a/drivers/block/blk-snap/defer_io.c b/drivers/block/blk-snap/defer_io.c
new file mode 100644
index 000000000000..309216fe7319
--- /dev/null
+++ b/drivers/block/blk-snap/defer_io.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-defer_io"
+#include "common.h"
+#include "defer_io.h"
+#include "blk_deferred.h"
+#include "tracker.h"
+#include "blk_util.h"
+
+#include <linux/kthread.h>
+
+#define BLK_IMAGE_THROTTLE_TIMEOUT (1 * HZ) //delay 1 sec
+//#define BLK_IMAGE_THROTTLE_TIMEOUT ( HZ/1000 * 10 )	//delay 10 ms
+
+
+
+struct defer_io_orig_rq {
+	struct list_head link;
+	struct defer_io_queue *queue;
+
+	struct bio *bio;
+	struct tracker *tracker;
+};
+
+static inline void defer_io_queue_init(struct defer_io_queue *queue)
+{
+	INIT_LIST_HEAD(&queue->list);
+
+	spin_lock_init(&queue->lock);
+
+	atomic_set(&queue->in_queue_cnt, 0);
+	atomic_set(&queue->active_state, true);
+}
+
+static inline struct defer_io_orig_rq *defer_io_queue_new(struct defer_io_queue *queue, struct bio *bio)
+{
+	struct defer_io_orig_rq *dio_rq;
+
+	dio_rq = kzalloc(sizeof(struct defer_io_orig_rq), GFP_NOIO);
+	if (dio_rq == NULL)
+		return NULL;
+
+	dio_rq->bio = bio;
+	bio_get(dio_rq->bio);
+
+	INIT_LIST_HEAD(&dio_rq->link);
+	dio_rq->queue = queue;
+
+	return dio_rq;
+}
+
+static inline void defer_io_queue_free(struct defer_io_orig_rq *dio_rq)
+{
+	if (likely(dio_rq)) {
+		if (likely(dio_rq->bio)) {
+			bio_put(dio_rq->bio);
+			dio_rq->bio = NULL;
+		}
+		kfree(dio_rq);
+	}
+}
+
+static int defer_io_queue_push_back(struct defer_io_queue *queue, struct defer_io_orig_rq *dio_rq)
+{
+	int res = SUCCESS;
+
+	spin_lock(&queue->lock);
+
+	if (atomic_read(&queue->active_state)) {
+		list_add_tail(&dio_rq->link, &queue->list);
+		atomic_inc(&queue->in_queue_cnt);
+	} else
+		res = -EACCES;
+
+	spin_unlock(&queue->lock);
+	return res;
+}
+
+static struct defer_io_orig_rq *defer_io_queue_get_first(struct defer_io_queue *queue)
+{
+	struct defer_io_orig_rq *dio_rq = NULL;
+
+	spin_lock(&queue->lock);
+
+	if (!list_empty(&queue->list)) {
+		dio_rq = list_entry(queue->list.next, struct defer_io_orig_rq, link);
+		list_del(&dio_rq->link);
+		atomic_dec(&queue->in_queue_cnt);
+	}
+
+	spin_unlock(&queue->lock);
+
+	return dio_rq;
+}
+
+static bool defer_io_queue_active(struct defer_io_queue *queue, bool state)
+{
+	bool prev_state;
+
+	spin_lock(&queue->lock);
+
+	prev_state = atomic_read(&queue->active_state);
+	atomic_set(&queue->active_state, state);
+
+	spin_unlock(&queue->lock);
+
+	return prev_state;
+}
+
+#define defer_io_queue_empty(queue) (atomic_read(&(queue).in_queue_cnt) == 0)
+
+static void _defer_io_finish(struct defer_io *defer_io, struct defer_io_queue *queue_in_progress)
+{
+	while (!defer_io_queue_empty(*queue_in_progress)) {
+		struct tracker *tracker = NULL;
+		bool cbt_locked = false;
+		bool is_write_bio;
+		sector_t sectCount = 0;
+
+		struct defer_io_orig_rq *orig_req = defer_io_queue_get_first(queue_in_progress);
+
+		is_write_bio = bio_data_dir(orig_req->bio) && bio_has_data(orig_req->bio);
+
+		if (orig_req->tracker && is_write_bio) {
+			tracker = orig_req->tracker;
+			cbt_locked = tracker_cbt_bitmap_lock(tracker);
+			if (cbt_locked) {
+				sectCount = bio_sectors(orig_req->bio);
+				tracker_cbt_bitmap_set(tracker, orig_req->bio->bi_iter.bi_sector,
+						       sectCount);
+			}
+		}
+
+		submit_bio_direct(orig_req->bio);
+
+		if (cbt_locked)
+			tracker_cbt_bitmap_unlock(tracker);
+
+		defer_io_queue_free(orig_req);
+	}
+}
+
+static int _defer_io_copy_prepare(struct defer_io *defer_io,
+				  struct defer_io_queue *queue_in_process,
+				  struct blk_deferred_request **dio_copy_req)
+{
+	int res = SUCCESS;
+	int dios_count = 0;
+	sector_t dios_sectors_count = 0;
+
+	//fill copy_request set
+	while (!defer_io_queue_empty(defer_io->dio_queue) &&
+	       (dios_count < DEFER_IO_DIO_REQUEST_LENGTH) &&
+	       (dios_sectors_count < DEFER_IO_DIO_REQUEST_SECTORS_COUNT)) {
+		struct defer_io_orig_rq *dio_orig_req =
+			(struct defer_io_orig_rq *)defer_io_queue_get_first(&defer_io->dio_queue);
+		atomic_dec(&defer_io->queue_filling_count);
+
+		defer_io_queue_push_back(queue_in_process, dio_orig_req);
+
+		if (!kthread_should_stop() &&
+		    !snapstore_device_is_corrupted(defer_io->snapstore_device)) {
+			if (bio_data_dir(dio_orig_req->bio) && bio_has_data(dio_orig_req->bio)) {
+				struct blk_range copy_range;
+
+				copy_range.ofs = dio_orig_req->bio->bi_iter.bi_sector;
+				copy_range.cnt = bio_sectors(dio_orig_req->bio);
+				res = snapstore_device_prepare_requests(defer_io->snapstore_device,
+									&copy_range, dio_copy_req);
+				if (res != SUCCESS) {
+					pr_err("Unable to execute Copy On Write algorithm: failed to add ranges to copy to snapstore request. errno=%d\n",
+					       res);
+					break;
+				}
+
+				dios_sectors_count += copy_range.cnt;
+			}
+		}
+		++dios_count;
+	}
+	return res;
+}
+
+static int defer_io_work_thread(void *p)
+{
+	struct defer_io_queue queue_in_process = { 0 };
+	struct defer_io *defer_io = NULL;
+
+	//set_user_nice( current, -20 ); //MIN_NICE
+	defer_io_queue_init(&queue_in_process);
+
+	defer_io = defer_io_get_resource((struct defer_io *)p);
+	pr_info("Defer IO thread for original device [%d:%d] started\n",
+		MAJOR(defer_io->original_dev_id), MINOR(defer_io->original_dev_id));
+
+	while (!kthread_should_stop() || !defer_io_queue_empty(defer_io->dio_queue)) {
+		if (defer_io_queue_empty(defer_io->dio_queue)) {
+			int res = wait_event_interruptible_timeout(
+				defer_io->queue_add_event,
+				(!defer_io_queue_empty(defer_io->dio_queue)),
+				BLK_IMAGE_THROTTLE_TIMEOUT);
+			if (-ERESTARTSYS == res)
+				pr_err("Signal received in defer IO thread. Waiting for completion with code ERESTARTSYS\n");
+		}
+
+		if (!defer_io_queue_empty(defer_io->dio_queue)) {
+			int dio_copy_result = SUCCESS;
+			struct blk_deferred_request *dio_copy_req = NULL;
+
+			mutex_lock(&defer_io->snapstore_device->store_block_map_locker);
+			do {
+				dio_copy_result = _defer_io_copy_prepare(
+					defer_io, &queue_in_process, &dio_copy_req);
+				if (dio_copy_result != SUCCESS) {
+					pr_err("Unable to process defer IO request: failed to prepare copy request. erro=%d\n",
+					       dio_copy_result);
+					break;
+				}
+				if (dio_copy_req == NULL)
+					break; //nothing to copy
+
+				dio_copy_result = blk_deferred_request_read_original(
+					defer_io->original_blk_dev, dio_copy_req);
+				if (dio_copy_result != SUCCESS) {
+					pr_err("Unable to process defer IO request: failed to read data to copy request. errno=%d\n",
+					       dio_copy_result);
+					break;
+				}
+				dio_copy_result = snapstore_device_store(defer_io->snapstore_device,
+									 dio_copy_req);
+				if (dio_copy_result != SUCCESS) {
+					pr_err("Unable to process defer IO request: failed to write data from copy request. errno=%d\n",
+					       dio_copy_result);
+					break;
+				}
+
+			} while (false);
+			_defer_io_finish(defer_io, &queue_in_process);
+			mutex_unlock(&defer_io->snapstore_device->store_block_map_locker);
+
+			if (dio_copy_req) {
+				if (dio_copy_result == -EDEADLK)
+					blk_deferred_request_deadlocked(dio_copy_req);
+				else
+					blk_deferred_request_free(dio_copy_req);
+			}
+		}
+
+		//wake up snapimage if defer io queue empty
+		if (defer_io_queue_empty(defer_io->dio_queue))
+			wake_up_interruptible(&defer_io->queue_throttle_waiter);
+	}
+	defer_io_queue_active(&defer_io->dio_queue, false);
+
+	//waiting for all sent request complete
+	_defer_io_finish(defer_io, &defer_io->dio_queue);
+
+	pr_info("Defer IO thread for original device [%d:%d] completed\n",
+		MAJOR(defer_io->original_dev_id), MINOR(defer_io->original_dev_id));
+	defer_io_put_resource(defer_io);
+	return SUCCESS;
+}
+
+static void _defer_io_destroy(struct defer_io *defer_io)
+{
+	if (defer_io == NULL)
+		return;
+
+	if (defer_io->dio_thread)
+		defer_io_stop(defer_io);
+
+	if (defer_io->snapstore_device)
+		snapstore_device_put_resource(defer_io->snapstore_device);
+
+	kfree(defer_io);
+	pr_info("Defer IO processor was destroyed\n");
+}
+
+static void defer_io_destroy_cb(struct kref *kref)
+{
+	_defer_io_destroy(container_of(kref, struct defer_io, refcount));
+}
+
+struct defer_io *defer_io_get_resource(struct defer_io *defer_io)
+{
+	if (defer_io)
+		kref_get(&defer_io->refcount);
+
+	return defer_io;
+}
+
+void defer_io_put_resource(struct defer_io *defer_io)
+{
+	if (defer_io)
+		kref_put(&defer_io->refcount, defer_io_destroy_cb);
+}
+
+int defer_io_create(dev_t dev_id, struct block_device *blk_dev, struct defer_io **pp_defer_io)
+{
+	int res = SUCCESS;
+	struct defer_io *defer_io = NULL;
+	struct snapstore_device *snapstore_device;
+
+	pr_info("Defer IO processor was created for device [%d:%d]\n", MAJOR(dev_id),
+		MINOR(dev_id));
+
+	defer_io = kzalloc(sizeof(struct defer_io), GFP_KERNEL);
+	if (defer_io == NULL)
+		return -ENOMEM;
+
+	snapstore_device = snapstore_device_find_by_dev_id(dev_id);
+	if (snapstore_device == NULL) {
+		pr_err("Unable to create defer IO processor: failed to initialize snapshot data for device [%d:%d]\n",
+		       MAJOR(dev_id), MINOR(dev_id));
+
+		kfree(defer_io);
+		return -ENODATA;
+	}
+
+	defer_io->snapstore_device = snapstore_device_get_resource(snapstore_device);
+	defer_io->original_dev_id = dev_id;
+	defer_io->original_blk_dev = blk_dev;
+
+	kref_init(&defer_io->refcount);
+
+	defer_io_queue_init(&defer_io->dio_queue);
+
+	init_waitqueue_head(&defer_io->queue_add_event);
+
+	atomic_set(&defer_io->queue_filling_count, 0);
+
+	init_waitqueue_head(&defer_io->queue_throttle_waiter);
+
+	defer_io->dio_thread = kthread_create(defer_io_work_thread, (void *)defer_io,
+					      "blksnapdeferio%d:%d", MAJOR(dev_id), MINOR(dev_id));
+	if (IS_ERR(defer_io->dio_thread)) {
+		res = PTR_ERR(defer_io->dio_thread);
+		pr_err("Unable to create defer IO processor: failed to create thread. errno=%d\n",
+		       res);
+
+		_defer_io_destroy(defer_io);
+		defer_io = NULL;
+		*pp_defer_io = NULL;
+
+		return res;
+	}
+
+	wake_up_process(defer_io->dio_thread);
+
+	*pp_defer_io = defer_io;
+	pr_info("Defer IO processor was created\n");
+
+	return SUCCESS;
+}
+
+int defer_io_stop(struct defer_io *defer_io)
+{
+	int res = SUCCESS;
+
+	pr_info("Defer IO thread for the device stopped [%d:%d]\n",
+		MAJOR(defer_io->original_dev_id), MINOR(defer_io->original_dev_id));
+
+	if (defer_io->dio_thread != NULL) {
+		struct task_struct *dio_thread = defer_io->dio_thread;
+
+		defer_io->dio_thread = NULL;
+		res = kthread_stop(dio_thread); //stopping and waiting.
+		if (res != SUCCESS)
+			pr_err("Failed to stop defer IO thread. errno=%d\n", res);
+	}
+
+	return res;
+}
+
+int defer_io_redirect_bio(struct defer_io *defer_io, struct bio *bio, void *tracker)
+{
+	struct defer_io_orig_rq *dio_orig_req;
+
+	if (snapstore_device_is_corrupted(defer_io->snapstore_device))
+		return -ENODATA;
+
+	dio_orig_req = defer_io_queue_new(&defer_io->dio_queue, bio);
+	if (dio_orig_req == NULL)
+		return -ENOMEM;
+
+	dio_orig_req->tracker = (struct tracker *)tracker;
+
+	if (defer_io_queue_push_back(&defer_io->dio_queue, dio_orig_req) != SUCCESS) {
+		defer_io_queue_free(dio_orig_req);
+		return -EFAULT;
+	}
+
+	atomic_inc(&defer_io->queue_filling_count);
+
+	wake_up_interruptible(&defer_io->queue_add_event);
+
+	return SUCCESS;
+}
diff --git a/drivers/block/blk-snap/defer_io.h b/drivers/block/blk-snap/defer_io.h
new file mode 100644
index 000000000000..27c3bb03241f
--- /dev/null
+++ b/drivers/block/blk-snap/defer_io.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+#include <linux/kref.h>
+#include "snapstore_device.h"
+
+struct defer_io_queue {
+	struct list_head list;
+	spinlock_t lock;
+
+	atomic_t active_state;
+	atomic_t in_queue_cnt;
+};
+
+struct defer_io {
+	struct kref refcount;
+
+	wait_queue_head_t queue_add_event;
+
+	atomic_t queue_filling_count;
+	wait_queue_head_t queue_throttle_waiter;
+
+	dev_t original_dev_id;
+	struct block_device *original_blk_dev;
+
+	struct snapstore_device *snapstore_device;
+
+	struct task_struct *dio_thread;
+
+	struct defer_io_queue dio_queue;
+};
+
+int defer_io_create(dev_t dev_id, struct block_device *blk_dev, struct defer_io **pp_defer_io);
+int defer_io_stop(struct defer_io *defer_io);
+
+struct defer_io *defer_io_get_resource(struct defer_io *defer_io);
+void defer_io_put_resource(struct defer_io *defer_io);
+
+int defer_io_redirect_bio(struct defer_io *defer_io, struct bio *bio, void *tracker);
diff --git a/drivers/block/blk-snap/main.c b/drivers/block/blk-snap/main.c
new file mode 100644
index 000000000000..d1d4e08a4890
--- /dev/null
+++ b/drivers/block/blk-snap/main.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+#include "version.h"
+#include "blk-snap-ctl.h"
+#include "params.h"
+#include "ctrl_fops.h"
+#include "ctrl_pipe.h"
+#include "ctrl_sysfs.h"
+#include "snapimage.h"
+#include "snapstore.h"
+#include "snapstore_device.h"
+#include "snapshot.h"
+#include "tracker.h"
+#include "tracking.h"
+#include <linux/module.h>
+
+int __init blk_snap_init(void)
+{
+	int result = SUCCESS;
+
+	pr_info("Loading\n");
+
+	params_check();
+
+	result = ctrl_init();
+	if (result != SUCCESS)
+		return result;
+
+	result = blk_redirect_bioset_create();
+	if (result != SUCCESS)
+		return result;
+
+	result = blk_deferred_bioset_create();
+	if (result != SUCCESS)
+		return result;
+
+	result = snapimage_init();
+	if (result != SUCCESS)
+		return result;
+
+	result = ctrl_sysfs_init();
+	if (result != SUCCESS)
+		return result;
+
+	result = tracking_init();
+	if (result != SUCCESS)
+		return result;
+
+	return result;
+}
+
+void __exit blk_snap_exit(void)
+{
+	pr_info("Unloading module\n");
+
+	ctrl_sysfs_done();
+
+	snapshot_done();
+
+	snapstore_device_done();
+	snapstore_done();
+
+	tracker_done();
+	tracking_done();
+
+	snapimage_done();
+
+	blk_deferred_bioset_free();
+	blk_deferred_done();
+
+	blk_redirect_bioset_free();
+
+	ctrl_done();
+}
+
+module_init(blk_snap_init);
+module_exit(blk_snap_exit);
+
+MODULE_DESCRIPTION("Block Layer Snapshot Kernel Module");
+MODULE_VERSION(FILEVER_STR);
+MODULE_AUTHOR("Veeam Software Group GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/block/blk-snap/params.c b/drivers/block/blk-snap/params.c
new file mode 100644
index 000000000000..7eba3c8bf395
--- /dev/null
+++ b/drivers/block/blk-snap/params.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+#include "params.h"
+#include <linux/module.h>
+
+int snapstore_block_size_pow = 14;
+int change_tracking_block_size_pow = 18;
+
+int get_snapstore_block_size_pow(void)
+{
+	return snapstore_block_size_pow;
+}
+
+int inc_snapstore_block_size_pow(void)
+{
+	if (snapstore_block_size_pow > 30)
+		return -EFAULT;
+
+	++snapstore_block_size_pow;
+	return SUCCESS;
+}
+
+int get_change_tracking_block_size_pow(void)
+{
+	return change_tracking_block_size_pow;
+}
+
+void params_check(void)
+{
+	pr_info("snapstore_block_size_pow: %d\n", snapstore_block_size_pow);
+	pr_info("change_tracking_block_size_pow: %d\n", change_tracking_block_size_pow);
+
+	if (snapstore_block_size_pow > 23) {
+		snapstore_block_size_pow = 23;
+		pr_info("Limited snapstore_block_size_pow: %d\n", snapstore_block_size_pow);
+	} else if (snapstore_block_size_pow < 12) {
+		snapstore_block_size_pow = 12;
+		pr_info("Limited snapstore_block_size_pow: %d\n", snapstore_block_size_pow);
+	}
+
+	if (change_tracking_block_size_pow > 23) {
+		change_tracking_block_size_pow = 23;
+		pr_info("Limited change_tracking_block_size_pow: %d\n",
+			change_tracking_block_size_pow);
+	} else if (change_tracking_block_size_pow < 12) {
+		change_tracking_block_size_pow = 12;
+		pr_info("Limited change_tracking_block_size_pow: %d\n",
+			change_tracking_block_size_pow);
+	}
+}
+
+module_param_named(snapstore_block_size_pow, snapstore_block_size_pow, int, 0644);
+MODULE_PARM_DESC(snapstore_block_size_pow,
+		 "Snapstore block size binary pow. 20 for 1MiB block size");
+
+module_param_named(change_tracking_block_size_pow, change_tracking_block_size_pow, int, 0644);
+MODULE_PARM_DESC(change_tracking_block_size_pow,
+		 "Change-tracking block size binary pow. 18 for 256 KiB block size");
diff --git a/drivers/block/blk-snap/params.h b/drivers/block/blk-snap/params.h
new file mode 100644
index 000000000000..c1b853a1363b
--- /dev/null
+++ b/drivers/block/blk-snap/params.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#pragma once
+
+int get_snapstore_block_size_pow(void);
+int inc_snapstore_block_size_pow(void);
+
+static inline sector_t snapstore_block_shift(void)
+{
+	return get_snapstore_block_size_pow() - SECTOR_SHIFT;
+};
+
+static inline sector_t snapstore_block_size(void)
+{
+	return 1ull << snapstore_block_shift();
+};
+
+static inline sector_t snapstore_block_mask(void)
+{
+	return snapstore_block_size() - 1ull;
+};
+
+int get_change_tracking_block_size_pow(void);
+
+static inline unsigned int change_tracking_block_size(void)
+{
+	return 1 << get_change_tracking_block_size_pow();
+};
+
+void params_check(void);
diff --git a/drivers/block/blk-snap/rangevector.c b/drivers/block/blk-snap/rangevector.c
new file mode 100644
index 000000000000..49fe4589b6f7
--- /dev/null
+++ b/drivers/block/blk-snap/rangevector.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+#include "rangevector.h"
+
+#define SECTION "ranges	"
+
+static inline sector_t range_node_start(struct blk_range_tree_node *range_node)
+{
+	return range_node->range.ofs;
+}
+
+static inline sector_t range_node_last(struct blk_range_tree_node *range_node)
+{
+	return range_node->range.ofs + range_node->range.cnt - 1;
+}
+
+#ifndef INTERVAL_TREE_DEFINE
+#pragma message("INTERVAL_TREE_DEFINE is undefined")
+#endif
+INTERVAL_TREE_DEFINE(struct blk_range_tree_node, _node, sector_t, _subtree_last,
+		     range_node_start, range_node_last, static inline, _blk_range_rb)
+
+void blk_range_rb_insert(struct blk_range_tree_node *node, struct rb_root_cached *root)
+{
+	_blk_range_rb_insert(node, root);
+}
+
+void blk_range_rb_remove(struct blk_range_tree_node *node, struct rb_root_cached *root)
+{
+	_blk_range_rb_remove(node, root);
+}
+
+struct blk_range_tree_node *blk_range_rb_iter_first(struct rb_root_cached *root, sector_t start,
+						    sector_t last)
+{
+	return _blk_range_rb_iter_first(root, start, last);
+}
+
+struct blk_range_tree_node *blk_range_rb_iter_next(struct blk_range_tree_node *node, sector_t start,
+						   sector_t last)
+{
+	return _blk_range_rb_iter_next(node, start, last);
+}
+
+void rangevector_init(struct rangevector *rangevector)
+{
+	init_rwsem(&rangevector->lock);
+
+	rangevector->root = RB_ROOT_CACHED;
+}
+
+void rangevector_done(struct rangevector *rangevector)
+{
+	struct rb_node *rb_node = NULL;
+
+	down_write(&rangevector->lock);
+	rb_node = rb_first_cached(&rangevector->root);
+	while (rb_node) {
+		struct blk_range_tree_node *range_node = (struct blk_range_tree_node *)
+			rb_node; //container_of(rb_node, struct blk_range_tree_node, node);
+
+		blk_range_rb_remove(range_node, &rangevector->root);
+		kfree(range_node);
+
+		rb_node = rb_first_cached(&rangevector->root);
+	}
+	up_write(&rangevector->lock);
+}
+
+int rangevector_add(struct rangevector *rangevector, struct blk_range *rg)
+{
+	struct blk_range_tree_node *range_node;
+
+	range_node = kzalloc(sizeof(struct blk_range_tree_node), GFP_KERNEL);
+	if (range_node)
+		return -ENOMEM;
+
+	range_node->range = *rg;
+
+	down_write(&rangevector->lock);
+	blk_range_rb_insert(range_node, &rangevector->root);
+	up_write(&rangevector->lock);
+
+	return SUCCESS;
+}
diff --git a/drivers/block/blk-snap/rangevector.h b/drivers/block/blk-snap/rangevector.h
new file mode 100644
index 000000000000..5ff439423178
--- /dev/null
+++ b/drivers/block/blk-snap/rangevector.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include <linux/interval_tree_generic.h>
+
+struct blk_range_tree_node {
+	struct rb_node _node;
+	struct blk_range range;
+	sector_t _subtree_last;
+};
+
+void blk_range_rb_insert(struct blk_range_tree_node *node, struct rb_root_cached *root);
+
+void blk_range_rb_remove(struct blk_range_tree_node *node, struct rb_root_cached *root);
+
+struct blk_range_tree_node *blk_range_rb_iter_first(struct rb_root_cached *root, sector_t start,
+						    sector_t last);
+
+struct blk_range_tree_node *blk_range_rb_iter_next(struct blk_range_tree_node *node, sector_t start,
+						   sector_t last);
+
+struct rangevector {
+	struct rb_root_cached root;
+	struct rw_semaphore lock;
+};
+
+void rangevector_init(struct rangevector *rangevector);
+
+void rangevector_done(struct rangevector *rangevector);
+
+int rangevector_add(struct rangevector *rangevector, struct blk_range *rg);
diff --git a/drivers/block/blk-snap/snapimage.c b/drivers/block/blk-snap/snapimage.c
new file mode 100644
index 000000000000..da971486cbef
--- /dev/null
+++ b/drivers/block/blk-snap/snapimage.c
@@ -0,0 +1,982 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-snapimage"
+#include "common.h"
+#include "snapimage.h"
+#include "blk_util.h"
+#include "defer_io.h"
+#include "cbt_map.h"
+#include "tracker.h"
+
+#include <asm/div64.h>
+#include <linux/cdrom.h>
+#include <linux/blk-mq.h>
+#include <linux/hdreg.h>
+#include <linux/kthread.h>
+
+#define SNAPIMAGE_MAX_DEVICES 2048
+
+int snapimage_major;
+unsigned long *snapimage_minors;
+DEFINE_SPINLOCK(snapimage_minors_lock);
+
+LIST_HEAD(snap_images);
+DECLARE_RWSEM(snap_images_lock);
+
+DECLARE_RWSEM(snap_image_destroy_lock);
+
+struct snapimage {
+	struct list_head link;
+
+	sector_t capacity;
+	dev_t original_dev;
+
+	struct defer_io *defer_io;
+	struct cbt_map *cbt_map;
+
+	dev_t image_dev;
+
+	struct request_queue *queue;
+	struct gendisk *disk;
+
+	atomic_t own_cnt;
+
+	struct redirect_bio_queue image_queue;
+
+	struct task_struct *rq_processor;
+
+	wait_queue_head_t rq_proc_event;
+	wait_queue_head_t rq_complete_event;
+
+	struct mutex open_locker;
+	struct block_device *open_bdev;
+
+	size_t open_cnt;
+};
+
+int _snapimage_open(struct block_device *bdev, fmode_t mode)
+{
+	int res = SUCCESS;
+
+	if (bdev->bd_disk == NULL) {
+		pr_err("Unable to open snapshot image: bd_disk is NULL. Device [%d:%d]\n",
+		       MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+		pr_err("Block device object %p\n", bdev);
+		return -ENODEV;
+	}
+
+	down_read(&snap_image_destroy_lock);
+	do {
+		struct snapimage *image = bdev->bd_disk->private_data;
+
+		if (image == NULL) {
+			pr_err("Unable to open snapshot image: private data is not initialized. Block device object %p\n",
+			       bdev);
+			res = -ENODEV;
+			break;
+		}
+
+		mutex_lock(&image->open_locker);
+		{
+			if (image->open_cnt == 0)
+				image->open_bdev = bdev;
+
+			image->open_cnt++;
+		}
+		mutex_unlock(&image->open_locker);
+	} while (false);
+	up_read(&snap_image_destroy_lock);
+	return res;
+}
+
+static inline uint64_t do_div_inline(uint64_t division, uint32_t divisor)
+{
+	do_div(division, divisor);
+	return division;
+}
+
+int _snapimage_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	int res = SUCCESS;
+	sector_t quotient;
+
+	down_read(&snap_image_destroy_lock);
+	do {
+		struct snapimage *image = bdev->bd_disk->private_data;
+
+		if (image == NULL) {
+			pr_err("Unable to open snapshot image: private data is not initialized. Block device object %p\n",
+			       bdev);
+			res = -ENODEV;
+			break;
+		}
+
+		pr_info("Getting geo for snapshot image device [%d:%d]\n", MAJOR(image->image_dev),
+			MINOR(image->image_dev));
+
+		geo->start = 0;
+		if (image->capacity > 63) {
+			geo->sectors = 63;
+			quotient = do_div_inline(image->capacity + (63 - 1), 63);
+
+			if (quotient > 255ULL) {
+				geo->heads = 255;
+				geo->cylinders =
+					(unsigned short)do_div_inline(quotient + (255 - 1), 255);
+			} else {
+				geo->heads = (unsigned char)quotient;
+				geo->cylinders = 1;
+			}
+		} else {
+			geo->sectors = (unsigned char)image->capacity;
+			geo->cylinders = 1;
+			geo->heads = 1;
+		}
+
+		pr_info("Image device geo: capacity=%lld, heads=%d, cylinders=%d, sectors=%d\n",
+			image->capacity, geo->heads, geo->cylinders, geo->sectors);
+	} while (false);
+	up_read(&snap_image_destroy_lock);
+
+	return res;
+}
+
+void _snapimage_close(struct gendisk *disk, fmode_t mode)
+{
+	if (disk->private_data != NULL) {
+		down_read(&snap_image_destroy_lock);
+		do {
+			struct snapimage *image = disk->private_data;
+
+			mutex_lock(&image->open_locker);
+			{
+				if (image->open_cnt > 0)
+					image->open_cnt--;
+
+				if (image->open_cnt == 0)
+					image->open_bdev = NULL;
+			}
+			mutex_unlock(&image->open_locker);
+		} while (false);
+		up_read(&snap_image_destroy_lock);
+	} else
+		pr_err("Unable to close snapshot image: private data is not initialized\n");
+}
+
+int _snapimage_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg)
+{
+	int res = -ENOTTY;
+
+	down_read(&snap_image_destroy_lock);
+	{
+		struct snapimage *image = bdev->bd_disk->private_data;
+
+		switch (cmd) {
+			/*
+			 * The only command we need to interpret is HDIO_GETGEO, since
+			 * we can't partition the drive otherwise.  We have no real
+			 * geometry, of course, so make something up.
+			 */
+		case HDIO_GETGEO: {
+			unsigned long len;
+			struct hd_geometry geo;
+
+			res = _snapimage_getgeo(bdev, &geo);
+
+			len = copy_to_user((void *)arg, &geo, sizeof(geo));
+			if (len != 0)
+				res = -EFAULT;
+			else
+				res = SUCCESS;
+		} break;
+		case CDROM_GET_CAPABILITY: //0x5331  / * get capabilities * /
+		{
+			struct gendisk *disk = bdev->bd_disk;
+
+			if (bdev->bd_disk && (disk->flags & GENHD_FL_CD))
+				res = SUCCESS;
+			else
+				res = -EINVAL;
+		} break;
+
+		default:
+			pr_info("Snapshot image ioctl receive unsupported command\n");
+			pr_info("Device [%d:%d], command 0x%x, arg 0x%lx\n",
+				MAJOR(image->image_dev), MINOR(image->image_dev), cmd, arg);
+
+			res = -ENOTTY; /* unknown command */
+		}
+	}
+	up_read(&snap_image_destroy_lock);
+	return res;
+}
+
+blk_qc_t _snapimage_submit_bio(struct bio *bio);
+
+const struct block_device_operations snapimage_ops = {
+	.owner = THIS_MODULE,
+	.submit_bio = _snapimage_submit_bio,
+	.open = _snapimage_open,
+	.ioctl = _snapimage_ioctl,
+	.release = _snapimage_close,
+};
+
+static inline int _snapimage_request_read(struct snapimage *image,
+					  struct blk_redirect_bio *rq_redir)
+{
+	struct snapstore_device *snapstore_device = image->defer_io->snapstore_device;
+
+	return snapstore_device_read(snapstore_device, rq_redir);
+}
+
+int _snapimage_request_write(struct snapimage *image, struct blk_redirect_bio *rq_redir)
+{
+	struct snapstore_device *snapstore_device;
+	struct cbt_map *cbt_map;
+	int res = SUCCESS;
+
+	if (unlikely((image->defer_io == NULL) || (image->cbt_map == NULL))) {
+		pr_err("Invalid snapshot image structure");
+		return -EINVAL;
+	}
+
+
+	snapstore_device = image->defer_io->snapstore_device;
+	cbt_map = image->cbt_map;
+
+	if (snapstore_device_is_corrupted(snapstore_device))
+		return -ENODATA;
+
+	if (!bio_has_data(rq_redir->bio)) {
+		pr_warn("Snapshot image receive empty block IO. flags=%u\n",
+			rq_redir->bio->bi_flags);
+
+		blk_redirect_complete(rq_redir, SUCCESS);
+		return SUCCESS;
+	}
+
+	if (cbt_map != NULL) {
+		sector_t ofs = rq_redir->bio->bi_iter.bi_sector;
+		sector_t cnt = bio_sectors(rq_redir->bio);
+
+		res = cbt_map_set_both(cbt_map, ofs, cnt);
+		if (res != SUCCESS)
+			pr_err("Unable to write data to snapshot image: failed to set CBT map. errno=%d\n",
+			       res);
+	}
+
+	res = snapstore_device_write(snapstore_device, rq_redir);
+
+	if (res != SUCCESS) {
+		pr_err("Failed to write data to snapshot image\n");
+		return res;
+	}
+
+	return res;
+}
+
+void _snapimage_processing(struct snapimage *image)
+{
+	int res = SUCCESS;
+	struct blk_redirect_bio *rq_redir;
+
+	rq_redir = redirect_bio_queue_get_first(&image->image_queue);
+
+	if (bio_data_dir(rq_redir->bio) == READ) {
+		res = _snapimage_request_read(image, rq_redir);
+		if (res != SUCCESS)
+			pr_err("Failed to read data from snapshot image. errno=%d\n", res);
+
+	} else {
+		res = _snapimage_request_write(image, rq_redir);
+		if (res != SUCCESS)
+			pr_err("Failed to write data to snapshot image. errno=%d\n", res);
+	}
+
+	if (res != SUCCESS)
+		blk_redirect_complete(rq_redir, res);
+}
+
+int snapimage_processor_waiting(struct snapimage *image)
+{
+	int res = SUCCESS;
+
+	if (redirect_bio_queue_empty(image->image_queue)) {
+		res = wait_event_interruptible_timeout(
+			image->rq_proc_event,
+			(!redirect_bio_queue_empty(image->image_queue) || kthread_should_stop()),
+			5 * HZ);
+		if (res > 0)
+			res = SUCCESS;
+		else if (res == 0)
+			res = -ETIME;
+	}
+	return res;
+}
+
+int snapimage_processor_thread(void *data)
+{
+	struct snapimage *image = data;
+
+	pr_info("Snapshot image thread for device [%d:%d] start\n", MAJOR(image->image_dev),
+		MINOR(image->image_dev));
+
+	add_disk(image->disk);
+
+	//priority
+	set_user_nice(current, -20); //MIN_NICE
+
+	while (!kthread_should_stop()) {
+		int res = snapimage_processor_waiting(image);
+
+		if (res == SUCCESS) {
+			if (!redirect_bio_queue_empty(image->image_queue))
+				_snapimage_processing(image);
+		} else if (res != -ETIME) {
+			pr_err("Failed to wait snapshot image thread queue. errno=%d\n", res);
+			return res;
+		}
+		schedule();
+	}
+	pr_info("Snapshot image disk delete\n");
+	del_gendisk(image->disk);
+
+	while (!redirect_bio_queue_empty(image->image_queue))
+		_snapimage_processing(image);
+
+	pr_info("Snapshot image thread for device [%d:%d] complete", MAJOR(image->image_dev),
+		MINOR(image->image_dev));
+	return 0;
+}
+
+static inline void _snapimage_bio_complete(struct bio *bio, int err)
+{
+	if (err == SUCCESS)
+		bio->bi_status = BLK_STS_OK;
+	else
+		bio->bi_status = BLK_STS_IOERR;
+
+	bio_endio(bio);
+}
+
+void _snapimage_bio_complete_cb(void *complete_param, struct bio *bio, int err)
+{
+	struct snapimage *image = (struct snapimage *)complete_param;
+
+	_snapimage_bio_complete(bio, err);
+
+	if (redirect_bio_queue_unactive(image->image_queue))
+		wake_up_interruptible(&image->rq_complete_event);
+
+	atomic_dec(&image->own_cnt);
+}
+
+int _snapimage_throttling(struct defer_io *defer_io)
+{
+	return wait_event_interruptible(defer_io->queue_throttle_waiter,
+					redirect_bio_queue_empty(defer_io->dio_queue));
+}
+
+blk_qc_t _snapimage_submit_bio(struct bio *bio)
+{
+	blk_qc_t result = SUCCESS;
+	struct request_queue *q = bio->bi_disk->queue;
+	struct snapimage *image = q->queuedata;
+
+	if (unlikely(blk_mq_queue_stopped(q))) {
+		pr_info("Failed to make snapshot image request. Queue already is not active.");
+		pr_info("Queue flags=%lx\n", q->queue_flags);
+
+		_snapimage_bio_complete(bio, -ENODEV);
+
+		return result;
+	}
+
+	atomic_inc(&image->own_cnt);
+	do {
+		int res;
+		struct blk_redirect_bio *rq_redir;
+
+		if (false == atomic_read(&(image->image_queue.active_state))) {
+			_snapimage_bio_complete(bio, -ENODEV);
+			break;
+		}
+
+		if (snapstore_device_is_corrupted(image->defer_io->snapstore_device)) {
+			_snapimage_bio_complete(bio, -ENODATA);
+			break;
+		}
+
+		res = _snapimage_throttling(image->defer_io);
+		if (res != SUCCESS) {
+			pr_err("Failed to throttle snapshot image device. errno=%d\n", res);
+			_snapimage_bio_complete(bio, res);
+			break;
+		}
+
+		rq_redir = redirect_bio_queue_new(&image->image_queue);
+		if (rq_redir == NULL) {
+			pr_err("Unable to make snapshot image request: failed to allocate redirect bio structure\n");
+			_snapimage_bio_complete(bio, -ENOMEM);
+			break;
+		}
+		rq_redir->bio = bio;
+		rq_redir->complete_cb = _snapimage_bio_complete_cb;
+		rq_redir->complete_param = (void *)image;
+		atomic_inc(&image->own_cnt);
+
+		res = redirect_bio_queue_push_back(&image->image_queue, rq_redir);
+		if (res == SUCCESS)
+			wake_up(&image->rq_proc_event);
+		else {
+			redirect_bio_queue_free(rq_redir);
+			_snapimage_bio_complete(bio, -EIO);
+
+			if (redirect_bio_queue_unactive(image->image_queue))
+				wake_up_interruptible(&image->rq_complete_event);
+		}
+
+	} while (false);
+	atomic_dec(&image->own_cnt);
+
+	return result;
+}
+
+struct blk_dev_info {
+	size_t blk_size;
+	sector_t start_sect;
+	sector_t count_sect;
+
+	unsigned int io_min;
+	unsigned int physical_block_size;
+	unsigned short logical_block_size;
+};
+
+static int _blk_dev_get_info(struct block_device *blk_dev, struct blk_dev_info *pdev_info)
+{
+	sector_t SectorStart;
+	sector_t SectorsCapacity;
+
+	if (blk_dev->bd_part)
+		SectorsCapacity = blk_dev->bd_part->nr_sects;
+	else if (blk_dev->bd_disk)
+		SectorsCapacity = get_capacity(blk_dev->bd_disk);
+	else
+		return -EINVAL;
+
+	SectorStart = get_start_sect(blk_dev);
+
+	pdev_info->physical_block_size = blk_dev->bd_disk->queue->limits.physical_block_size;
+	pdev_info->logical_block_size = blk_dev->bd_disk->queue->limits.logical_block_size;
+	pdev_info->io_min = blk_dev->bd_disk->queue->limits.io_min;
+
+	pdev_info->blk_size = block_size(blk_dev);
+	pdev_info->start_sect = SectorStart;
+	pdev_info->count_sect = SectorsCapacity;
+	return SUCCESS;
+}
+
+static int blk_dev_get_info(dev_t dev_id, struct blk_dev_info *pdev_info)
+{
+	int result = SUCCESS;
+	struct block_device *blk_dev;
+
+	result = blk_dev_open(dev_id, &blk_dev);
+	if (result != SUCCESS) {
+		pr_err("Failed to open device [%d:%d]\n", MAJOR(dev_id), MINOR(dev_id));
+		return result;
+	}
+
+	result = _blk_dev_get_info(blk_dev, pdev_info);
+	if (result != SUCCESS)
+		pr_err("Failed to identify block device [%d:%d]\n", MAJOR(dev_id), MINOR(dev_id));
+
+	blk_dev_close(blk_dev);
+
+	return result;
+}
+
+static inline void _snapimage_free(struct snapimage *image)
+{
+	defer_io_put_resource(image->defer_io);
+	cbt_map_put_resource(image->cbt_map);
+	image->defer_io = NULL;
+}
+
+static void _snapimage_stop(struct snapimage *image)
+{
+	if (image->rq_processor != NULL) {
+		if (redirect_bio_queue_active(&image->image_queue, false)) {
+			struct request_queue *q = image->queue;
+
+			pr_info("Snapshot image request processing stop\n");
+
+			if (!blk_queue_stopped(q)) {
+				blk_sync_queue(q);
+				blk_mq_stop_hw_queues(q);
+			}
+		}
+
+		pr_info("Snapshot image thread stop\n");
+		kthread_stop(image->rq_processor);
+		image->rq_processor = NULL;
+
+		while (!redirect_bio_queue_unactive(image->image_queue))
+			wait_event_interruptible(image->rq_complete_event,
+						 redirect_bio_queue_unactive(image->image_queue));
+	}
+}
+
+static void _snapimage_destroy(struct snapimage *image)
+{
+	if (image->rq_processor != NULL)
+		_snapimage_stop(image);
+
+	if (image->queue) {
+		pr_info("Snapshot image queue cleanup\n");
+		blk_cleanup_queue(image->queue);
+		image->queue = NULL;
+	}
+
+	if (image->disk != NULL) {
+		struct gendisk *disk;
+
+		disk = image->disk;
+		image->disk = NULL;
+
+		pr_info("Snapshot image disk structure release\n");
+
+		disk->private_data = NULL;
+		put_disk(disk);
+	}
+
+	spin_lock(&snapimage_minors_lock);
+	bitmap_clear(snapimage_minors, MINOR(image->image_dev), 1u);
+	spin_unlock(&snapimage_minors_lock);
+}
+
+int snapimage_create(dev_t original_dev)
+{
+	int res = SUCCESS;
+	struct tracker *tracker = NULL;
+	struct snapimage *image = NULL;
+	struct gendisk *disk = NULL;
+	int minor;
+	struct blk_dev_info original_dev_info;
+
+	pr_info("Create snapshot image for device [%d:%d]\n", MAJOR(original_dev),
+		MINOR(original_dev));
+
+	res = blk_dev_get_info(original_dev, &original_dev_info);
+	if (res != SUCCESS) {
+		pr_err("Failed to obtain original device info\n");
+		return res;
+	}
+
+	res = tracker_find_by_dev_id(original_dev, &tracker);
+	if (res != SUCCESS) {
+		pr_err("Unable to create snapshot image: cannot find tracker for device [%d:%d]\n",
+		       MAJOR(original_dev), MINOR(original_dev));
+		return res;
+	}
+
+	image = kzalloc(sizeof(struct snapimage), GFP_KERNEL);
+	if (image == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&image->link);
+
+	do {
+		spin_lock(&snapimage_minors_lock);
+		minor = bitmap_find_free_region(snapimage_minors, SNAPIMAGE_MAX_DEVICES, 0);
+		spin_unlock(&snapimage_minors_lock);
+
+		if (minor < SUCCESS) {
+			pr_err("Failed to allocate minor for snapshot image device. errno=%d\n",
+			       0 - minor);
+			break;
+		}
+
+		image->rq_processor = NULL;
+
+		image->capacity = original_dev_info.count_sect;
+
+		image->defer_io = defer_io_get_resource(tracker->defer_io);
+		image->cbt_map = cbt_map_get_resource(tracker->cbt_map);
+		image->original_dev = original_dev;
+
+		image->image_dev = MKDEV(snapimage_major, minor);
+		pr_info("Snapshot image device id [%d:%d]\n", MAJOR(image->image_dev),
+			MINOR(image->image_dev));
+
+		atomic_set(&image->own_cnt, 0);
+
+		mutex_init(&image->open_locker);
+		image->open_bdev = NULL;
+		image->open_cnt = 0;
+
+		image->queue = blk_alloc_queue(NUMA_NO_NODE);
+		if (image->queue == NULL) {
+			res = -ENOMEM;
+			break;
+		}
+		image->queue->queuedata = image;
+
+		blk_queue_max_segment_size(image->queue, 1024 * PAGE_SIZE);
+
+		{
+			unsigned int physical_block_size = original_dev_info.physical_block_size;
+			unsigned short logical_block_size = original_dev_info.logical_block_size;
+
+			pr_info("Snapshot image physical block size %d\n", physical_block_size);
+			pr_info("Snapshot image logical block size %d\n", logical_block_size);
+
+			blk_queue_physical_block_size(image->queue, physical_block_size);
+			blk_queue_logical_block_size(image->queue, logical_block_size);
+		}
+		disk = alloc_disk(1); //only one partition on disk
+		if (disk == NULL) {
+			pr_err("Failed to allocate disk for snapshot image device\n");
+			res = -ENOMEM;
+			break;
+		}
+		image->disk = disk;
+
+		if (snprintf(disk->disk_name, DISK_NAME_LEN, "%s%d", SNAP_IMAGE_NAME, minor) < 0) {
+			pr_err("Unable to set disk name for snapshot image device: invalid minor %d\n",
+			       minor);
+			res = -EINVAL;
+			break;
+		}
+
+		pr_info("Snapshot image disk name [%s]", disk->disk_name);
+
+		disk->flags |= GENHD_FL_NO_PART_SCAN;
+		disk->flags |= GENHD_FL_REMOVABLE;
+
+		disk->major = snapimage_major;
+		disk->minors = 1; // one disk have only one partition.
+		disk->first_minor = minor;
+
+		disk->private_data = image;
+
+		disk->fops = &snapimage_ops;
+		disk->queue = image->queue;
+
+		set_capacity(disk, image->capacity);
+		pr_info("Snapshot image device capacity %lld bytes",
+			(u64)from_sectors(image->capacity));
+
+		//res = -ENOMEM;
+		redirect_bio_queue_init(&image->image_queue);
+
+		{
+			struct task_struct *task =
+				kthread_create(snapimage_processor_thread, image, disk->disk_name);
+			if (IS_ERR(task)) {
+				res = PTR_ERR(task);
+				pr_err("Failed to create request processing thread for snapshot image device. errno=%d\n",
+				       res);
+				break;
+			}
+			image->rq_processor = task;
+		}
+		init_waitqueue_head(&image->rq_complete_event);
+
+		init_waitqueue_head(&image->rq_proc_event);
+		wake_up_process(image->rq_processor);
+	} while (false);
+
+	if (res == SUCCESS) {
+		down_write(&snap_images_lock);
+		list_add_tail(&image->link, &snap_images);
+		up_write(&snap_images_lock);
+	} else {
+		_snapimage_destroy(image);
+		_snapimage_free(image);
+
+		kfree(image);
+		image = NULL;
+	}
+	return res;
+}
+
+static struct snapimage *snapimage_find(dev_t original_dev)
+{
+	struct snapimage *image = NULL;
+
+	down_read(&snap_images_lock);
+	if (!list_empty(&snap_images)) {
+		struct list_head *_list_head;
+
+		list_for_each(_list_head, &snap_images) {
+			struct snapimage *_image = list_entry(_list_head, struct snapimage, link);
+
+			if (_image->original_dev == original_dev) {
+				image = _image;
+				break;
+			}
+		}
+	}
+	up_read(&snap_images_lock);
+
+	return image;
+}
+
+void snapimage_stop(dev_t original_dev)
+{
+	struct snapimage *image;
+
+	pr_info("Snapshot image processing stop for original device [%d:%d]\n", MAJOR(original_dev),
+		MINOR(original_dev));
+
+	down_read(&snap_image_destroy_lock);
+
+	image = snapimage_find(original_dev);
+	if (image != NULL)
+		_snapimage_stop(image);
+	else
+		pr_err("Snapshot image [%d:%d] not found\n", MAJOR(original_dev),
+		       MINOR(original_dev));
+
+	up_read(&snap_image_destroy_lock);
+}
+
+void snapimage_destroy(dev_t original_dev)
+{
+	struct snapimage *image = NULL;
+
+	pr_info("Destroy snapshot image for device [%d:%d]\n", MAJOR(original_dev),
+		MINOR(original_dev));
+
+	down_write(&snap_images_lock);
+	if (!list_empty(&snap_images)) {
+		struct list_head *_list_head;
+
+		list_for_each(_list_head, &snap_images) {
+			struct snapimage *_image = list_entry(_list_head, struct snapimage, link);
+
+			if (_image->original_dev == original_dev) {
+				image = _image;
+				list_del(&image->link);
+				break;
+			}
+		}
+	}
+	up_write(&snap_images_lock);
+
+	if (image != NULL) {
+		down_write(&snap_image_destroy_lock);
+
+		_snapimage_destroy(image);
+		_snapimage_free(image);
+
+		kfree(image);
+		image = NULL;
+
+		up_write(&snap_image_destroy_lock);
+	} else
+		pr_err("Snapshot image [%d:%d] not found\n", MAJOR(original_dev),
+		       MINOR(original_dev));
+}
+
+void snapimage_destroy_for(dev_t *p_dev, int count)
+{
+	int inx = 0;
+
+	for (; inx < count; ++inx)
+		snapimage_destroy(p_dev[inx]);
+}
+
+int snapimage_create_for(dev_t *p_dev, int count)
+{
+	int res = SUCCESS;
+	int inx = 0;
+
+	for (; inx < count; ++inx) {
+		res = snapimage_create(p_dev[inx]);
+		if (res != SUCCESS) {
+			pr_err("Failed to create snapshot image for original device [%d:%d]\n",
+			       MAJOR(p_dev[inx]), MINOR(p_dev[inx]));
+			break;
+		}
+	}
+	if (res != SUCCESS)
+		if (inx > 0)
+			snapimage_destroy_for(p_dev, inx - 1);
+	return res;
+}
+
+int snapimage_init(void)
+{
+	int res = SUCCESS;
+
+	res = register_blkdev(snapimage_major, SNAP_IMAGE_NAME);
+	if (res >= SUCCESS) {
+		snapimage_major = res;
+		pr_info("Snapshot image block device major %d was registered\n", snapimage_major);
+		res = SUCCESS;
+
+		spin_lock(&snapimage_minors_lock);
+		snapimage_minors = bitmap_zalloc(SNAPIMAGE_MAX_DEVICES, GFP_KERNEL);
+		spin_unlock(&snapimage_minors_lock);
+
+		if (snapimage_minors == NULL)
+			pr_err("Failed to initialize bitmap of minors\n");
+	} else
+		pr_err("Failed to register snapshot image block device. errno=%d\n", res);
+
+	return res;
+}
+
+void snapimage_done(void)
+{
+	down_write(&snap_image_destroy_lock);
+	while (true) {
+		struct snapimage *image = NULL;
+
+		down_write(&snap_images_lock);
+		if (!list_empty(&snap_images)) {
+			image = list_entry(snap_images.next, struct snapimage, link);
+
+			list_del(&image->link);
+		}
+		up_write(&snap_images_lock);
+
+		if (image == NULL)
+			break;
+
+		pr_err("Snapshot image for device was unexpectedly removed [%d:%d]\n",
+		       MAJOR(image->original_dev), MINOR(image->original_dev));
+
+		_snapimage_destroy(image);
+		_snapimage_free(image);
+
+		kfree(image);
+		image = NULL;
+	}
+
+	spin_lock(&snapimage_minors_lock);
+	bitmap_free(snapimage_minors);
+	snapimage_minors = NULL;
+	spin_unlock(&snapimage_minors_lock);
+
+	if (!list_empty(&snap_images))
+		pr_err("Failed to release snapshot images container\n");
+
+	unregister_blkdev(snapimage_major, SNAP_IMAGE_NAME);
+	pr_info("Snapshot image block device [%d] was unregistered\n", snapimage_major);
+
+	up_write(&snap_image_destroy_lock);
+}
+
+int snapimage_collect_images(int count, struct image_info_s *p_user_image_info, int *p_real_count)
+{
+	int res = SUCCESS;
+	int real_count = 0;
+
+	down_read(&snap_images_lock);
+	if (!list_empty(&snap_images)) {
+		struct list_head *_list_head;
+
+		list_for_each(_list_head, &snap_images)
+			real_count++;
+	}
+	up_read(&snap_images_lock);
+	*p_real_count = real_count;
+
+	if (count < real_count)
+		res = -ENODATA;
+
+	real_count = min(count, real_count);
+	if (real_count > 0) {
+		unsigned long len;
+		struct image_info_s *p_kernel_image_info = NULL;
+		size_t buff_size;
+
+		buff_size = sizeof(struct image_info_s) * real_count;
+		p_kernel_image_info = kzalloc(buff_size, GFP_KERNEL);
+		if (p_kernel_image_info == NULL) {
+			pr_err("Unable to collect snapshot images: not enough memory. size=%zu\n",
+			       buff_size);
+			return res = -ENOMEM;
+		}
+
+		down_read(&snap_image_destroy_lock);
+		down_read(&snap_images_lock);
+
+		if (!list_empty(&snap_images)) {
+			size_t inx = 0;
+			struct list_head *_list_head;
+
+			list_for_each(_list_head, &snap_images) {
+				struct snapimage *img =
+					list_entry(_list_head, struct snapimage, link);
+
+				real_count++;
+
+				p_kernel_image_info[inx].original_dev_id.major =
+					MAJOR(img->original_dev);
+				p_kernel_image_info[inx].original_dev_id.minor =
+					MINOR(img->original_dev);
+
+				p_kernel_image_info[inx].snapshot_dev_id.major =
+					MAJOR(img->image_dev);
+				p_kernel_image_info[inx].snapshot_dev_id.minor =
+					MINOR(img->image_dev);
+
+				++inx;
+				if (inx > real_count)
+					break;
+			}
+		}
+
+		up_read(&snap_images_lock);
+		up_read(&snap_image_destroy_lock);
+
+		len = copy_to_user(p_user_image_info, p_kernel_image_info, buff_size);
+		if (len != 0) {
+			pr_err("Unable to collect snapshot images: failed to copy data to user buffer\n");
+			res = -ENODATA;
+		}
+
+		kfree(p_kernel_image_info);
+	}
+
+	return res;
+}
+
+int snapimage_mark_dirty_blocks(dev_t image_dev_id, struct block_range_s *block_ranges,
+				unsigned int count)
+{
+	size_t inx = 0;
+	int res = SUCCESS;
+
+	pr_info("Marking [%d] dirty blocks for image device [%d:%d]\n", count, MAJOR(image_dev_id),
+		MINOR(image_dev_id));
+
+	down_read(&snap_image_destroy_lock);
+	do {
+		struct snapimage *image = snapimage_find(image_dev_id);
+
+		if (image == NULL) {
+			pr_err("Cannot find device [%d:%d]\n", MAJOR(image_dev_id),
+			       MINOR(image_dev_id));
+			res = -ENODEV;
+			break;
+		}
+
+		for (inx = 0; inx < count; ++inx) {
+			sector_t ofs = (sector_t)block_ranges[inx].ofs;
+			sector_t cnt = (sector_t)block_ranges[inx].cnt;
+
+			res = cbt_map_set_both(image->cbt_map, ofs, cnt);
+			if (res != SUCCESS) {
+				pr_err("Failed to set CBT table. errno=%d\n", res);
+				break;
+			}
+		}
+	} while (false);
+	up_read(&snap_image_destroy_lock);
+
+	return res;
+}
diff --git a/drivers/block/blk-snap/snapimage.h b/drivers/block/blk-snap/snapimage.h
new file mode 100644
index 000000000000..67995c321496
--- /dev/null
+++ b/drivers/block/blk-snap/snapimage.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include "blk-snap-ctl.h"
+
+int snapimage_init(void);
+void snapimage_done(void);
+int snapimage_create_for(dev_t *p_dev, int count);
+
+void snapimage_stop(dev_t original_dev);
+void snapimage_destroy(dev_t original_dev);
+
+int snapimage_collect_images(int count, struct image_info_s *p_user_image_info, int *p_real_count);
+
+int snapimage_mark_dirty_blocks(dev_t image_dev_id, struct block_range_s *block_ranges,
+				unsigned int count);
diff --git a/drivers/block/blk-snap/snapshot.c b/drivers/block/blk-snap/snapshot.c
new file mode 100644
index 000000000000..fdef713103d2
--- /dev/null
+++ b/drivers/block/blk-snap/snapshot.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-snapshot"
+#include "common.h"
+#include "snapshot.h"
+#include "tracker.h"
+#include "snapimage.h"
+#include "tracking.h"
+
+LIST_HEAD(snapshots);
+DECLARE_RWSEM(snapshots_lock);
+
+
+static int _snapshot_remove_device(dev_t dev_id)
+{
+	int result;
+	struct tracker *tracker = NULL;
+
+	result = tracker_find_by_dev_id(dev_id, &tracker);
+	if (result != SUCCESS) {
+		if (result == -ENODEV)
+			pr_err("Cannot find device by device id=[%d:%d]\n", MAJOR(dev_id),
+			       MINOR(dev_id));
+		else
+			pr_err("Failed to find device by device id=[%d:%d]\n", MAJOR(dev_id),
+			       MINOR(dev_id));
+		return SUCCESS;
+	}
+
+	if (result != SUCCESS)
+		return result;
+
+	tracker->snapshot_id = 0ull;
+
+	pr_info("Device [%d:%d] successfully removed from snapshot\n", MAJOR(dev_id),
+		MINOR(dev_id));
+	return SUCCESS;
+}
+
+static void _snapshot_cleanup(struct snapshot *snapshot)
+{
+	int inx;
+
+	for (inx = 0; inx < snapshot->dev_id_set_size; ++inx) {
+
+		if (_snapshot_remove_device(snapshot->dev_id_set[inx]) != SUCCESS)
+			pr_err("Failed to remove device [%d:%d] from snapshot\n",
+			       MAJOR(snapshot->dev_id_set[inx]), MINOR(snapshot->dev_id_set[inx]));
+	}
+
+	if (snapshot->dev_id_set != NULL)
+		kfree(snapshot->dev_id_set);
+	kfree(snapshot);
+}
+
+static void _snapshot_destroy(struct snapshot *snapshot)
+{
+	size_t inx;
+
+	for (inx = 0; inx < snapshot->dev_id_set_size; ++inx)
+		snapimage_stop(snapshot->dev_id_set[inx]);
+
+	pr_info("Release snapshot [0x%llx]\n", snapshot->id);
+
+	tracker_release_snapshot(snapshot->dev_id_set, snapshot->dev_id_set_size);
+
+	for (inx = 0; inx < snapshot->dev_id_set_size; ++inx)
+		snapimage_destroy(snapshot->dev_id_set[inx]);
+
+	_snapshot_cleanup(snapshot);
+}
+
+
+static int _snapshot_new(dev_t *p_dev, int count, struct snapshot **pp_snapshot)
+{
+	struct snapshot *p_snapshot = NULL;
+	dev_t *snap_set = NULL;
+
+	p_snapshot = kzalloc(sizeof(struct snapshot), GFP_KERNEL);
+	if (p_snapshot == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&p_snapshot->link);
+
+	p_snapshot->id = (unsigned long)(p_snapshot);
+
+	snap_set = kcalloc(count, sizeof(dev_t), GFP_KERNEL);
+	if (snap_set == NULL) {
+		kfree(p_snapshot);
+
+		pr_err("Unable to create snapshot: faile to allocate memory for snapshot map\n");
+		return -ENOMEM;
+	}
+	memcpy(snap_set, p_dev, sizeof(dev_t) * count);
+
+	p_snapshot->dev_id_set_size = count;
+	p_snapshot->dev_id_set = snap_set;
+
+	down_write(&snapshots_lock);
+	list_add_tail(&snapshots, &p_snapshot->link);
+	up_write(&snapshots_lock);
+
+	*pp_snapshot = p_snapshot;
+
+	return SUCCESS;
+}
+
+void snapshot_done(void)
+{
+	struct snapshot *snap;
+
+	pr_info("Removing all snapshots\n");
+	do {
+		snap = NULL;
+		down_write(&snapshots_lock);
+		if (!list_empty(&snapshots)) {
+			struct snapshot *snap = list_entry(snapshots.next, struct snapshot, link);
+
+			list_del(&snap->link);
+		}
+		up_write(&snapshots_lock);
+
+		if (snap)
+			_snapshot_destroy(snap);
+
+	} while (snap);
+}
+
+int snapshot_create(dev_t *dev_id_set, unsigned int dev_id_set_size,
+		    unsigned long long *p_snapshot_id)
+{
+	struct snapshot *snapshot = NULL;
+	int result = SUCCESS;
+	unsigned int inx;
+
+	pr_info("Create snapshot for devices:\n");
+	for (inx = 0; inx < dev_id_set_size; ++inx)
+		pr_info("\t%d:%d\n", MAJOR(dev_id_set[inx]), MINOR(dev_id_set[inx]));
+
+	result = _snapshot_new(dev_id_set, dev_id_set_size, &snapshot);
+	if (result != SUCCESS) {
+		pr_err("Unable to create snapshot: failed to allocate snapshot structure\n");
+		return result;
+	}
+
+	do {
+		result = -ENODEV;
+		for (inx = 0; inx < snapshot->dev_id_set_size; ++inx) {
+			dev_t dev_id = snapshot->dev_id_set[inx];
+
+			result = tracking_add(dev_id, snapshot->id);
+			if (result == -EALREADY)
+				result = SUCCESS;
+			else if (result != SUCCESS) {
+				pr_err("Unable to create snapshot\n");
+				pr_err("Failed to add device [%d:%d] to snapshot tracking\n",
+				       MAJOR(dev_id), MINOR(dev_id));
+				break;
+			}
+		}
+		if (result != SUCCESS)
+			break;
+
+		result = tracker_capture_snapshot(snapshot->dev_id_set, snapshot->dev_id_set_size);
+		if (result != SUCCESS) {
+			pr_err("Unable to create snapshot: failed to capture snapshot [0x%llx]\n",
+			       snapshot->id);
+			break;
+		}
+
+		result = snapimage_create_for(snapshot->dev_id_set, snapshot->dev_id_set_size);
+		if (result != SUCCESS) {
+			pr_err("Unable to create snapshot\n");
+			pr_err("Failed to create snapshot image devices\n");
+
+			tracker_release_snapshot(snapshot->dev_id_set, snapshot->dev_id_set_size);
+			break;
+		}
+
+		*p_snapshot_id = snapshot->id;
+		pr_info("Snapshot [0x%llx] was created\n", snapshot->id);
+	} while (false);
+
+	if (result != SUCCESS) {
+		pr_info("Snapshot [0x%llx] cleanup\n", snapshot->id);
+
+		down_write(&snapshots_lock);
+		list_del(&snapshot->link);
+		up_write(&snapshots_lock);
+
+		_snapshot_cleanup(snapshot);
+	}
+	return result;
+}
+
+int snapshot_destroy(unsigned long long snapshot_id)
+{
+	struct snapshot *snapshot = NULL;
+
+	pr_info("Destroy snapshot [0x%llx]\n", snapshot_id);
+
+	down_read(&snapshots_lock);
+	if (!list_empty(&snapshots)) {
+		struct list_head *_head;
+
+		list_for_each(_head, &snapshots) {
+			struct snapshot *_snap = list_entry(_head, struct snapshot, link);
+
+			if (_snap->id == snapshot_id) {
+				snapshot = _snap;
+				list_del(&snapshot->link);
+				break;
+			}
+		}
+	}
+	up_read(&snapshots_lock);
+
+	if (snapshot == NULL) {
+		pr_err("Unable to destroy snapshot [0x%llx]: cannot find snapshot by id\n",
+		       snapshot_id);
+		return -ENODEV;
+	}
+
+	_snapshot_destroy(snapshot);
+	return SUCCESS;
+}
diff --git a/drivers/block/blk-snap/snapshot.h b/drivers/block/blk-snap/snapshot.h
new file mode 100644
index 000000000000..59fb4dba0241
--- /dev/null
+++ b/drivers/block/blk-snap/snapshot.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+struct snapshot {
+	struct list_head link;
+	unsigned long long id;
+
+	dev_t *dev_id_set; //array of assigned devices
+	int dev_id_set_size;
+};
+
+void snapshot_done(void);
+
+int snapshot_create(dev_t *dev_id_set, unsigned int dev_id_set_size,
+		    unsigned long long *p_snapshot_id);
+
+int snapshot_destroy(unsigned long long snapshot_id);
diff --git a/drivers/block/blk-snap/snapstore.c b/drivers/block/blk-snap/snapstore.c
new file mode 100644
index 000000000000..0bedeaeec021
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore.c
@@ -0,0 +1,929 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-snapstore"
+#include "common.h"
+#include "snapstore.h"
+#include "snapstore_device.h"
+#include "big_buffer.h"
+#include "params.h"
+
+LIST_HEAD(snapstores);
+DECLARE_RWSEM(snapstores_lock);
+
+bool _snapstore_check_halffill(struct snapstore *snapstore, sector_t *fill_status)
+{
+	struct blk_descr_pool *pool = NULL;
+
+	if (snapstore->file)
+		pool = &snapstore->file->pool;
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	else if (snapstore->multidev)
+		pool = &snapstore->multidev->pool;
+#endif
+	else if (snapstore->mem)
+		pool = &snapstore->mem->pool;
+
+	if (pool)
+		return blk_descr_pool_check_halffill(pool, snapstore->empty_limit, fill_status);
+
+	return false;
+}
+
+void _snapstore_destroy(struct snapstore *snapstore)
+{
+	sector_t fill_status;
+
+	pr_info("Destroy snapstore with id %pUB\n", &snapstore->id);
+
+	_snapstore_check_halffill(snapstore, &fill_status);
+
+	down_write(&snapstores_lock);
+	list_del(&snapstore->link);
+	up_write(&snapstores_lock);
+
+	if (snapstore->mem != NULL)
+		snapstore_mem_destroy(snapstore->mem);
+	if (snapstore->multidev != NULL)
+		snapstore_multidev_destroy(snapstore->multidev);
+	if (snapstore->file != NULL)
+		snapstore_file_destroy(snapstore->file);
+
+	if (snapstore->ctrl_pipe) {
+		struct ctrl_pipe *pipe;
+
+		pipe = snapstore->ctrl_pipe;
+		snapstore->ctrl_pipe = NULL;
+
+		ctrl_pipe_request_terminate(pipe, fill_status);
+
+		ctrl_pipe_put_resource(pipe);
+	}
+
+	kfree(snapstore);
+}
+
+static void _snapstore_destroy_cb(struct kref *kref)
+{
+	struct snapstore *snapstore = container_of(kref, struct snapstore, refcount);
+
+	_snapstore_destroy(snapstore);
+}
+
+struct snapstore *snapstore_get(struct snapstore *snapstore)
+{
+	if (snapstore)
+		kref_get(&snapstore->refcount);
+
+	return snapstore;
+}
+
+void snapstore_put(struct snapstore *snapstore)
+{
+	if (snapstore)
+		kref_put(&snapstore->refcount, _snapstore_destroy_cb);
+}
+
+void snapstore_done(void)
+{
+	bool is_empty;
+
+	down_read(&snapstores_lock);
+	is_empty = list_empty(&snapstores);
+	up_read(&snapstores_lock);
+
+	if (!is_empty)
+		pr_err("Unable to perform snapstore cleanup: container is not empty\n");
+}
+
+int snapstore_create(uuid_t *id, dev_t snapstore_dev_id, dev_t *dev_id_set,
+		     size_t dev_id_set_length)
+{
+	int res = SUCCESS;
+	size_t dev_id_inx;
+	struct snapstore *snapstore = NULL;
+
+	if (dev_id_set_length == 0)
+		return -EINVAL;
+
+	snapstore = kzalloc(sizeof(struct snapstore), GFP_KERNEL);
+	if (snapstore == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&snapstore->link);
+	uuid_copy(&snapstore->id, id);
+
+	pr_info("Create snapstore with id %pUB\n", &snapstore->id);
+
+	snapstore->mem = NULL;
+	snapstore->multidev = NULL;
+	snapstore->file = NULL;
+
+	snapstore->ctrl_pipe = NULL;
+	snapstore->empty_limit = (sector_t)(64 * (1024 * 1024 / SECTOR_SIZE)); //by default value
+	snapstore->halffilled = false;
+	snapstore->overflowed = false;
+
+	if (snapstore_dev_id == 0)
+		pr_info("Memory snapstore create\n");
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	else if (snapstore_dev_id == 0xFFFFffff) {
+		struct snapstore_multidev *multidev = NULL;
+
+		res = snapstore_multidev_create(&multidev);
+		if (res != SUCCESS) {
+			kfree(snapstore);
+
+			pr_err("Failed to create multidevice snapstore %pUB\n", id);
+			return res;
+		}
+		snapstore->multidev = multidev;
+	}
+#endif
+	else {
+		struct snapstore_file *file = NULL;
+
+		res = snapstore_file_create(snapstore_dev_id, &file);
+		if (res != SUCCESS) {
+			kfree(snapstore);
+
+			pr_err("Failed to create snapstore file for snapstore %pUB\n", id);
+			return res;
+		}
+		snapstore->file = file;
+	}
+
+	down_write(&snapstores_lock);
+	list_add_tail(&snapstores, &snapstore->link);
+	up_write(&snapstores_lock);
+
+	kref_init(&snapstore->refcount);
+
+	for (dev_id_inx = 0; dev_id_inx < dev_id_set_length; ++dev_id_inx) {
+		res = snapstore_device_create(dev_id_set[dev_id_inx], snapstore);
+		if (res != SUCCESS)
+			break;
+	}
+
+	if (res != SUCCESS)
+		snapstore_device_cleanup(id);
+
+	snapstore_put(snapstore);
+	return res;
+}
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+int snapstore_create_multidev(uuid_t *id, dev_t *dev_id_set, size_t dev_id_set_length)
+{
+	int res = SUCCESS;
+	size_t dev_id_inx;
+	struct snapstore *snapstore = NULL;
+	struct snapstore_multidev *multidev = NULL;
+
+	if (dev_id_set_length == 0)
+		return -EINVAL;
+
+	snapstore = kzalloc(sizeof(struct snapstore), GFP_KERNEL);
+	if (snapstore == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&snapstore->link);
+
+	uuid_copy(&snapstore->id, id);
+
+	pr_info("Create snapstore with id %pUB\n", &snapstore->id);
+
+	snapstore->mem = NULL;
+	snapstore->file = NULL;
+	snapstore->multidev = NULL;
+
+	snapstore->ctrl_pipe = NULL;
+	snapstore->empty_limit = (sector_t)(64 * (1024 * 1024 / SECTOR_SIZE)); //by default value
+	snapstore->halffilled = false;
+	snapstore->overflowed = false;
+
+	res = snapstore_multidev_create(&multidev);
+	if (res != SUCCESS) {
+		kfree(snapstore);
+
+		pr_err("Failed to create snapstore file for snapstore %pUB\n", id);
+		return res;
+	}
+	snapstore->multidev = multidev;
+
+	down_write(&snapstores_lock);
+	list_add_tail(&snapstore->link, &snapstores);
+	up_write(&snapstores_lock);
+
+	kref_init(&snapstore->refcount);
+
+	for (dev_id_inx = 0; dev_id_inx < dev_id_set_length; ++dev_id_inx) {
+		res = snapstore_device_create(dev_id_set[dev_id_inx], snapstore);
+		if (res != SUCCESS)
+			break;
+	}
+
+	if (res != SUCCESS)
+		snapstore_device_cleanup(id);
+
+	snapstore_put(snapstore);
+	return res;
+}
+#endif
+
+int snapstore_cleanup(uuid_t *id, u64 *filled_bytes)
+{
+	int res;
+	sector_t filled;
+
+	res = snapstore_check_halffill(id, &filled);
+	if (res == SUCCESS) {
+		*filled_bytes = (u64)from_sectors(filled);
+
+		pr_info("Snapstore fill size: %lld MiB\n", (*filled_bytes >> 20));
+	} else {
+		*filled_bytes = -1;
+		pr_err("Failed to obtain snapstore data filled size\n");
+	}
+
+	return snapstore_device_cleanup(id);
+}
+
+struct snapstore *_snapstore_find(uuid_t *id)
+{
+	struct snapstore *result = NULL;
+
+	down_read(&snapstores_lock);
+	if (!list_empty(&snapstores)) {
+		struct list_head *_head;
+
+		list_for_each(_head, &snapstores) {
+			struct snapstore *snapstore = list_entry(_head, struct snapstore, link);
+
+			if (uuid_equal(&snapstore->id, id)) {
+				result = snapstore;
+				break;
+			}
+		}
+	}
+	up_read(&snapstores_lock);
+
+	return result;
+}
+
+int snapstore_stretch_initiate(uuid_t *unique_id, struct ctrl_pipe *ctrl_pipe, sector_t empty_limit)
+{
+	struct snapstore *snapstore;
+
+	snapstore = _snapstore_find(unique_id);
+	if (snapstore == NULL) {
+		pr_err("Unable to initiate stretch snapstore: ");
+		pr_err("cannot find snapstore by uuid %pUB\n", unique_id);
+		return -ENODATA;
+	}
+
+	snapstore->ctrl_pipe = ctrl_pipe_get_resource(ctrl_pipe);
+	snapstore->empty_limit = empty_limit;
+
+	return SUCCESS;
+}
+
+int snapstore_add_memory(uuid_t *id, unsigned long long sz)
+{
+	int res = SUCCESS;
+	struct snapstore *snapstore = NULL;
+	size_t available_blocks = (size_t)(sz >> (snapstore_block_shift() + SECTOR_SHIFT));
+	size_t current_block = 0;
+
+	pr_info("Adding %lld bytes to the snapstore\n", sz);
+
+	snapstore = _snapstore_find(id);
+	if (snapstore == NULL) {
+		pr_err("Unable to add memory block to the snapstore: ");
+		pr_err("cannot found snapstore by id %pUB\n", id);
+		return -ENODATA;
+	}
+
+	if (snapstore->file != NULL) {
+		pr_err("Unable to add memory block to the snapstore: ");
+		pr_err("snapstore file is already created\n");
+		return -EINVAL;
+	}
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	if (snapstore->multidev != NULL) {
+		pr_err("Unable to add memory block to the snapstore: ");
+		pr_err("snapstore multidevice is already created\n");
+		return -EINVAL;
+	}
+#endif
+	if (snapstore->mem != NULL) {
+		pr_err("Unable to add memory block to the snapstore: ");
+		pr_err("snapstore memory buffer is already created\n");
+		return -EINVAL;
+	}
+
+	snapstore->mem = snapstore_mem_create(available_blocks);
+	for (current_block = 0; current_block < available_blocks; ++current_block) {
+		void *buffer = snapstore_mem_get_block(snapstore->mem);
+
+		if (buffer == NULL) {
+			pr_err("Unable to add memory block to the snapstore: ");
+			pr_err("not enough memory\n");
+			res = -ENOMEM;
+			break;
+		}
+
+		res = blk_descr_mem_pool_add(&snapstore->mem->pool, buffer);
+		if (res != SUCCESS) {
+			pr_err("Unable to add memory block to the snapstore: ");
+			pr_err("failed to initialize new block\n");
+			break;
+		}
+	}
+	if (res != SUCCESS) {
+		snapstore_mem_destroy(snapstore->mem);
+		snapstore->mem = NULL;
+	}
+
+	return res;
+}
+
+int rangelist_add(struct list_head *rglist, struct blk_range *rg)
+{
+	struct blk_range_link *range_link;
+
+	range_link = kzalloc(sizeof(struct blk_range_link), GFP_KERNEL);
+	if (range_link == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&range_link->link);
+
+	range_link->rg.ofs = rg->ofs;
+	range_link->rg.cnt = rg->cnt;
+
+	list_add_tail(&range_link->link, rglist);
+
+	return SUCCESS;
+}
+
+int snapstore_add_file(uuid_t *id, struct big_buffer *ranges, size_t ranges_cnt)
+{
+	int res = SUCCESS;
+	struct snapstore *snapstore = NULL;
+	struct snapstore_device *snapstore_device = NULL;
+	sector_t current_blk_size = 0;
+	LIST_HEAD(blk_rangelist);
+	size_t inx;
+
+	pr_info("Snapstore add %zu ranges\n", ranges_cnt);
+
+	if ((ranges_cnt == 0) || (ranges == NULL))
+		return -EINVAL;
+
+	snapstore = _snapstore_find(id);
+	if (snapstore == NULL) {
+		pr_err("Unable to add file to snapstore: ");
+		pr_err("cannot find snapstore by id %pUB\n", id);
+		return -ENODATA;
+	}
+
+	if (snapstore->file == NULL) {
+		pr_err("Unable to add file to snapstore: ");
+		pr_err("snapstore file was not initialized\n");
+		return -EFAULT;
+	}
+
+	snapstore_device =
+		snapstore_device_find_by_dev_id(snapstore->file->blk_dev_id); //for zeroed
+
+	for (inx = 0; inx < ranges_cnt; ++inx) {
+		size_t blocks_count = 0;
+		sector_t range_offset = 0;
+
+		struct blk_range range;
+		struct ioctl_range_s *ioctl_range;
+
+		ioctl_range = big_buffer_get_element(ranges, inx, sizeof(struct ioctl_range_s));
+		if (ioctl_range == NULL) {
+			pr_err("Invalid count of ranges\n");
+			res = -ENODATA;
+			break;
+		}
+
+		range.ofs = (sector_t)to_sectors(ioctl_range->left);
+		range.cnt = (blkcnt_t)to_sectors(ioctl_range->right) - range.ofs;
+
+		while (range_offset < range.cnt) {
+			struct blk_range rg;
+
+			rg.ofs = range.ofs + range_offset;
+			rg.cnt = min_t(sector_t, (range.cnt - range_offset),
+				       (snapstore_block_size() - current_blk_size));
+
+			range_offset += rg.cnt;
+
+			res = rangelist_add(&blk_rangelist, &rg);
+			if (res != SUCCESS) {
+				pr_err("Unable to add file to snapstore: ");
+				pr_err("cannot add range to rangelist\n");
+				break;
+			}
+
+			//zero sectors logic
+			if (snapstore_device != NULL) {
+				res = rangevector_add(&snapstore_device->zero_sectors, &rg);
+				if (res != SUCCESS) {
+					pr_err("Unable to add file to snapstore: ");
+					pr_err("cannot add range to zero_sectors tree\n");
+					break;
+				}
+			}
+
+			current_blk_size += rg.cnt;
+
+			if (current_blk_size == snapstore_block_size()) { //allocate  block
+				res = blk_descr_file_pool_add(&snapstore->file->pool,
+							      &blk_rangelist);
+				if (res != SUCCESS) {
+					pr_err("Unable to add file to snapstore: ");
+					pr_err("cannot initialize new block\n");
+					break;
+				}
+
+				snapstore->halffilled = false;
+
+				current_blk_size = 0;
+				INIT_LIST_HEAD(&blk_rangelist); //renew list
+				++blocks_count;
+			}
+		}
+		if (res != SUCCESS)
+			break;
+	}
+
+	if ((res == SUCCESS) && (current_blk_size != 0))
+		pr_warn("Snapstore portion was not ordered by Copy-on-Write block size\n");
+
+	return res;
+}
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+static int rangelist_ex_add(struct list_head *list, struct blk_range *rg,
+			    struct block_device *blk_dev)
+{
+	struct blk_range_link_ex *range_link =
+		kzalloc(sizeof(struct blk_range_link_ex), GFP_KERNEL);
+	if (range_link == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&range_link->link);
+
+	range_link->rg.ofs = rg->ofs;
+	range_link->rg.cnt = rg->cnt;
+	range_link->blk_dev = blk_dev;
+
+	list_add_tail(&range_link->link, list);
+
+	return SUCCESS;
+}
+
+int snapstore_add_multidev(uuid_t *id, dev_t dev_id, struct big_buffer *ranges, size_t ranges_cnt)
+{
+	int res = SUCCESS;
+	struct snapstore *snapstore = NULL;
+	sector_t current_blk_size = 0;
+	size_t inx;
+	LIST_HEAD(blk_rangelist);
+
+	pr_info("Snapstore add %zu ranges for device [%d:%d]\n", ranges_cnt, MAJOR(dev_id),
+		MINOR(dev_id));
+
+	if ((ranges_cnt == 0) || (ranges == NULL))
+		return -EINVAL;
+
+	snapstore = _snapstore_find(id);
+	if (snapstore == NULL) {
+		pr_err("Unable to add file to multidevice snapstore: ");
+		pr_err("cannot find snapstore by id %pUB\n", id);
+		return -ENODATA;
+	}
+
+	if (snapstore->multidev == NULL) {
+		pr_err("Unable to add file to multidevice snapstore: ");
+		pr_err("it was not initialized\n");
+		return -EFAULT;
+	}
+
+	for (inx = 0; inx < ranges_cnt; ++inx) {
+		size_t blocks_count = 0;
+		sector_t range_offset = 0;
+		struct blk_range range;
+		struct ioctl_range_s *data;
+
+		data = big_buffer_get_element(ranges, inx, sizeof(struct ioctl_range_s));
+		if (data == NULL) {
+			pr_err("Invalid count of ranges\n");
+			res = -ENODATA;
+			break;
+		}
+
+		range.ofs = (sector_t)to_sectors(data->left);
+		range.cnt = (blkcnt_t)to_sectors(data->right) - range.ofs;
+
+		while (range_offset < range.cnt) {
+			struct blk_range rg;
+			struct block_device *blk_dev = NULL;
+
+			rg.ofs = range.ofs + range_offset;
+			rg.cnt = min_t(sector_t,
+				       range.cnt - range_offset,
+				       snapstore_block_size() - current_blk_size);
+
+			range_offset += rg.cnt;
+
+			blk_dev = snapstore_multidev_get_device(snapstore->multidev, dev_id);
+			if (blk_dev == NULL) {
+				pr_err("Cannot find or open device [%d:%d] for multidevice snapstore\n",
+				       MAJOR(dev_id), MINOR(dev_id));
+				res = -ENODEV;
+				break;
+			}
+
+			res = rangelist_ex_add(&blk_rangelist, &rg, blk_dev);
+			if (res != SUCCESS) {
+				pr_err("Unable to add file to multidevice snapstore: ");
+				pr_err("failed to add range to rangelist\n");
+				break;
+			}
+
+			/*
+			 * zero sectors logic is not implemented for multidevice snapstore
+			 */
+
+			current_blk_size += rg.cnt;
+
+			if (current_blk_size == snapstore_block_size()) { //allocate  block
+				res = blk_descr_multidev_pool_add(&snapstore->multidev->pool,
+								  &blk_rangelist);
+				if (res != SUCCESS) {
+					pr_err("Unable to add file to multidevice snapstore: ");
+					pr_err("failed to initialize new block\n");
+					break;
+				}
+
+				snapstore->halffilled = false;
+
+				current_blk_size = 0;
+				INIT_LIST_HEAD(&blk_rangelist);
+				++blocks_count;
+			}
+		}
+		if (res != SUCCESS)
+			break;
+	}
+
+	if ((res == SUCCESS) && (current_blk_size != 0))
+		pr_warn("Snapstore portion was not ordered by Copy-on-Write block size\n");
+
+	return res;
+}
+#endif
+
+void snapstore_order_border(struct blk_range *in, struct blk_range *out)
+{
+	struct blk_range unorder;
+
+	unorder.ofs = in->ofs & snapstore_block_mask();
+	out->ofs = in->ofs & ~snapstore_block_mask();
+	out->cnt = in->cnt + unorder.ofs;
+
+	unorder.cnt = out->cnt & snapstore_block_mask();
+	if (unorder.cnt != 0)
+		out->cnt += (snapstore_block_size() - unorder.cnt);
+}
+
+union blk_descr_unify snapstore_get_empty_block(struct snapstore *snapstore)
+{
+	union blk_descr_unify result = { NULL };
+
+	if (snapstore->overflowed)
+		return result;
+
+	if (snapstore->file != NULL)
+		result = blk_descr_file_pool_take(&snapstore->file->pool);
+	else if (snapstore->multidev != NULL)
+		result = blk_descr_multidev_pool_take(&snapstore->multidev->pool);
+	else if (snapstore->mem != NULL)
+		result = blk_descr_mem_pool_take(&snapstore->mem->pool);
+
+	if (result.ptr == NULL) {
+		if (snapstore->ctrl_pipe) {
+			sector_t fill_status;
+
+			_snapstore_check_halffill(snapstore, &fill_status);
+			ctrl_pipe_request_overflow(snapstore->ctrl_pipe, -EINVAL,
+						   (u64)from_sectors(fill_status));
+		}
+		snapstore->overflowed = true;
+	}
+
+	return result;
+}
+
+int snapstore_check_halffill(uuid_t *unique_id, sector_t *fill_status)
+{
+	struct snapstore *snapstore;
+
+	snapstore = _snapstore_find(unique_id);
+	if (snapstore == NULL) {
+		pr_err("Cannot find snapstore by uuid %pUB\n", unique_id);
+		return -ENODATA;
+	}
+
+	_snapstore_check_halffill(snapstore, fill_status);
+
+	return SUCCESS;
+}
+
+int snapstore_request_store(struct snapstore *snapstore, struct blk_deferred_request *dio_copy_req)
+{
+	int res = SUCCESS;
+
+	if (snapstore->ctrl_pipe) {
+		if (!snapstore->halffilled) {
+			sector_t fill_status = 0;
+
+			if (_snapstore_check_halffill(snapstore, &fill_status)) {
+				snapstore->halffilled = true;
+				ctrl_pipe_request_halffill(snapstore->ctrl_pipe,
+							   (u64)from_sectors(fill_status));
+			}
+		}
+	}
+
+	if (snapstore->file)
+		res = blk_deferred_request_store_file(snapstore->file->blk_dev, dio_copy_req);
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	else if (snapstore->multidev)
+		res = blk_deferred_request_store_multidev(dio_copy_req);
+#endif
+	else if (snapstore->mem)
+		res = blk_deferred_request_store_mem(dio_copy_req);
+	else
+		res = -EINVAL;
+
+	return res;
+}
+
+static int _snapstore_redirect_read_file(struct blk_redirect_bio *rq_redir,
+					 struct block_device *snapstore_blk_dev,
+					 struct blk_descr_file *file,
+					 sector_t block_ofs,
+					 sector_t rq_ofs, sector_t rq_count)
+{
+	int res = SUCCESS;
+	sector_t current_ofs = 0;
+	struct list_head *_list_head;
+
+	if (unlikely(list_empty(&file->rangelist))) {
+		pr_err("Invalid file block descriptor");
+		return -EINVAL;
+	}
+
+	list_for_each(_list_head, &file->rangelist) {
+		struct blk_range_link *range_link;
+
+		range_link = list_entry(_list_head, struct blk_range_link, link);
+		if (current_ofs >= rq_count)
+			break;
+
+		if (range_link->rg.cnt > block_ofs) {
+			sector_t pos = range_link->rg.ofs + block_ofs;
+			sector_t len = min_t(sector_t,
+					     range_link->rg.cnt - block_ofs,
+					     rq_count - current_ofs);
+
+			res = blk_dev_redirect_part(rq_redir, READ, snapstore_blk_dev, pos,
+						    rq_ofs + current_ofs, len);
+			if (res != SUCCESS) {
+				pr_err("Failed to read from snapstore file. Sector #%lld\n",
+				       pos);
+				break;
+			}
+
+			current_ofs += len;
+			block_ofs = 0;
+		} else
+			block_ofs -= range_link->rg.cnt;
+	}
+
+	if (res != SUCCESS)
+		pr_err("Failed to read from file snapstore\n");
+	return res;
+}
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+static int _snapstore_redirect_read_multidev(struct blk_redirect_bio *rq_redir,
+					      struct blk_descr_multidev *multidev,
+					      sector_t block_ofs,
+					      sector_t rq_ofs, sector_t rq_count)
+{
+	int res = SUCCESS;
+	sector_t current_ofs = 0;
+	struct list_head *_list_head;
+
+	if (unlikely(list_empty(&multidev->rangelist))) {
+		pr_err("Invalid multidev block descriptor");
+		return -EINVAL;
+	}
+
+	list_for_each(_list_head, &multidev->rangelist) {
+		struct blk_range_link_ex *range_link =
+			list_entry(_list_head, struct blk_range_link_ex, link);
+
+		if (current_ofs >= rq_count)
+			break;
+
+		if (range_link->rg.cnt > block_ofs) {
+			sector_t pos = range_link->rg.ofs + block_ofs;
+			sector_t len = min_t(sector_t,
+					     range_link->rg.cnt - block_ofs,
+					     rq_count - current_ofs);
+
+			res = blk_dev_redirect_part(rq_redir, READ, range_link->blk_dev, pos,
+						    rq_ofs + current_ofs, len);
+
+			if (res != SUCCESS) {
+				pr_err("Failed to read from snapstore file. Sector #%lld\n", pos);
+				break;
+			}
+
+			current_ofs += len;
+			block_ofs = 0;
+		} else
+			block_ofs -= range_link->rg.cnt;
+	}
+
+	if (res != SUCCESS)
+		pr_err("Failed to read from multidev snapstore\n");
+	return res;
+}
+#endif
+
+int snapstore_redirect_read(struct blk_redirect_bio *rq_redir, struct snapstore *snapstore,
+			    union blk_descr_unify blk_descr, sector_t target_pos, sector_t rq_ofs,
+			    sector_t rq_count)
+{
+	int res = SUCCESS;
+	sector_t block_ofs = target_pos & snapstore_block_mask();
+
+	if (snapstore->file)
+		res = _snapstore_redirect_read_file(rq_redir, snapstore->file->blk_dev,
+						    blk_descr.file, block_ofs, rq_ofs, rq_count);
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	else if (snapstore->multidev)
+		res = _snapstore_redirect_read_multidev(rq_redir, blk_descr.multidev, block_ofs,
+							rq_ofs, rq_count);
+#endif
+	else if (snapstore->mem) {
+		res = blk_dev_redirect_memcpy_part(
+			rq_redir, READ, blk_descr.mem->buff + (size_t)from_sectors(block_ofs),
+			rq_ofs, rq_count);
+
+		if (res != SUCCESS)
+			pr_err("Failed to read from snapstore memory\n");
+	} else
+		res = -EINVAL;
+
+	if (res != SUCCESS)
+		pr_err("Failed to read from snapstore. Offset %lld sector\n", target_pos);
+	return res;
+}
+
+static int _snapstore_redirect_write_file(struct blk_redirect_bio *rq_redir,
+					  struct block_device *snapstore_blk_dev,
+					  struct blk_descr_file *file,
+					  sector_t block_ofs,
+					  sector_t rq_ofs, sector_t rq_count)
+{
+	int res = SUCCESS;
+	sector_t current_ofs = 0;
+	struct list_head *_list_head;
+
+	if (unlikely(list_empty(&file->rangelist))) {
+		pr_err("Invalid file block descriptor");
+		return -EINVAL;
+	}
+
+	list_for_each(_list_head, &file->rangelist) {
+		struct blk_range_link *range_link;
+
+		range_link = list_entry(_list_head, struct blk_range_link, link);
+		if (current_ofs >= rq_count)
+			break;
+
+		if (range_link->rg.cnt > block_ofs) {
+			sector_t pos = range_link->rg.ofs + block_ofs;
+			sector_t len = min_t(sector_t,
+					     range_link->rg.cnt - block_ofs,
+					     rq_count - current_ofs);
+
+			res = blk_dev_redirect_part(rq_redir, WRITE, snapstore_blk_dev, pos,
+						    rq_ofs + current_ofs, len);
+
+			if (res != SUCCESS) {
+				pr_err("Failed to write to snapstore file. Sector #%lld\n",
+				       pos);
+				break;
+			}
+
+			current_ofs += len;
+			block_ofs = 0;
+		} else
+			block_ofs -= range_link->rg.cnt;
+	}
+	if (res != SUCCESS)
+		pr_err("Failed to write to file snapstore\n");
+	return res;
+}
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+static int _snapstore_redirect_write_multidev(struct blk_redirect_bio *rq_redir,
+					      struct blk_descr_multidev *multidev,
+					      sector_t block_ofs,
+					      sector_t rq_ofs, sector_t rq_count)
+{
+	int res = SUCCESS;
+	sector_t current_ofs = 0;
+	struct list_head *_list_head;
+
+	if (unlikely(list_empty(&multidev->rangelist))) {
+		pr_err("Invalid multidev block descriptor");
+		return -EINVAL;
+	}
+
+	list_for_each(_list_head, &multidev->rangelist) {
+		struct blk_range_link_ex *range_link;
+
+		range_link = list_entry(_list_head, struct blk_range_link_ex, link);
+		if (current_ofs >= rq_count)
+			break;
+
+		if (range_link->rg.cnt > block_ofs) {
+			sector_t pos = range_link->rg.ofs + block_ofs;
+			sector_t len = min_t(sector_t,
+					     range_link->rg.cnt - block_ofs,
+					     rq_count - current_ofs);
+
+			res = blk_dev_redirect_part(rq_redir, WRITE, range_link->blk_dev, pos,
+						    rq_ofs + current_ofs, len);
+
+			if (res != SUCCESS) {
+				pr_err("Failed to write to snapstore file. Sector #%lld\n",
+				       pos);
+				break;
+			}
+
+			current_ofs += len;
+			block_ofs = 0;
+		} else
+			block_ofs -= range_link->rg.cnt;
+	}
+
+	if (res != SUCCESS)
+		pr_err("Failed to write to multidevice snapstore\n");
+	return res;
+}
+#endif
+
+int snapstore_redirect_write(struct blk_redirect_bio *rq_redir, struct snapstore *snapstore,
+			     union blk_descr_unify blk_descr, sector_t target_pos, sector_t rq_ofs,
+			     sector_t rq_count)
+{
+	int res = SUCCESS;
+	sector_t block_ofs = target_pos & snapstore_block_mask();
+
+	if (snapstore->file)
+		res = _snapstore_redirect_write_file(rq_redir, snapstore->file->blk_dev,
+						     blk_descr.file, block_ofs, rq_ofs, rq_count);
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	else if (snapstore->multidev)
+		res = _snapstore_redirect_write_multidev(rq_redir, blk_descr.multidev,
+							 block_ofs, rq_ofs, rq_count);
+#endif
+	else if (snapstore->mem) {
+		res = blk_dev_redirect_memcpy_part(
+			rq_redir, WRITE, blk_descr.mem->buff + (size_t)from_sectors(block_ofs),
+			rq_ofs, rq_count);
+
+		if (res != SUCCESS)
+			pr_err("Failed to write to memory snapstore\n");
+	} else {
+		pr_err("Unable to write to snapstore: invalid type of snapstore device\n");
+		res = -EINVAL;
+	}
+
+	if (res != SUCCESS)
+		pr_err("Failed to write to snapstore. Offset %lld sector\n", target_pos);
+	return res;
+}
diff --git a/drivers/block/blk-snap/snapstore.h b/drivers/block/blk-snap/snapstore.h
new file mode 100644
index 000000000000..db34ad2e2c58
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include <linux/uuid.h>
+#include <linux/kref.h>
+#include "blk-snap-ctl.h"
+#include "rangevector.h"
+#include "snapstore_mem.h"
+#include "snapstore_file.h"
+#include "snapstore_multidev.h"
+#include "blk_redirect.h"
+#include "ctrl_pipe.h"
+#include "big_buffer.h"
+
+struct snapstore {
+	struct list_head link;
+	struct kref refcount;
+
+	uuid_t id;
+
+	struct snapstore_mem *mem;
+	struct snapstore_file *file;
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+	struct snapstore_multidev *multidev;
+#endif
+
+	struct ctrl_pipe *ctrl_pipe;
+	sector_t empty_limit;
+
+	bool halffilled;
+	bool overflowed;
+};
+
+void snapstore_done(void);
+
+int snapstore_create(uuid_t *id, dev_t snapstore_dev_id, dev_t *dev_id_set,
+		     size_t dev_id_set_length);
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+int snapstore_create_multidev(uuid_t *id, dev_t *dev_id_set, size_t dev_id_set_length);
+#endif
+int snapstore_cleanup(uuid_t *id, u64 *filled_bytes);
+
+struct snapstore *snapstore_get(struct snapstore *snapstore);
+void snapstore_put(struct snapstore *snapstore);
+
+int snapstore_stretch_initiate(uuid_t *unique_id, struct ctrl_pipe *ctrl_pipe,
+			       sector_t empty_limit);
+
+int snapstore_add_memory(uuid_t *id, unsigned long long sz);
+int snapstore_add_file(uuid_t *id, struct big_buffer *ranges, size_t ranges_cnt);
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+int snapstore_add_multidev(uuid_t *id, dev_t dev_id, struct big_buffer *ranges, size_t ranges_cnt);
+#endif
+
+void snapstore_order_border(struct blk_range *in, struct blk_range *out);
+
+union blk_descr_unify snapstore_get_empty_block(struct snapstore *snapstore);
+
+int snapstore_request_store(struct snapstore *snapstore, struct blk_deferred_request *dio_copy_req);
+
+int snapstore_redirect_read(struct blk_redirect_bio *rq_redir, struct snapstore *snapstore,
+			    union blk_descr_unify blk_descr, sector_t target_pos, sector_t rq_ofs,
+			    sector_t rq_count);
+int snapstore_redirect_write(struct blk_redirect_bio *rq_redir, struct snapstore *snapstore,
+			     union blk_descr_unify blk_descr, sector_t target_pos, sector_t rq_ofs,
+			     sector_t rq_count);
+
+int snapstore_check_halffill(uuid_t *unique_id, sector_t *fill_status);
diff --git a/drivers/block/blk-snap/snapstore_device.c b/drivers/block/blk-snap/snapstore_device.c
new file mode 100644
index 000000000000..6fdeebacce22
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore_device.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-snapstore"
+#include "common.h"
+#include "snapstore_device.h"
+#include "snapstore.h"
+#include "params.h"
+#include "blk_util.h"
+
+LIST_HEAD(snapstore_devices);
+DECLARE_RWSEM(snapstore_devices_lock);
+
+static inline void _snapstore_device_descr_write_lock(struct snapstore_device *snapstore_device)
+{
+	mutex_lock(&snapstore_device->store_block_map_locker);
+}
+static inline void _snapstore_device_descr_write_unlock(struct snapstore_device *snapstore_device)
+{
+	mutex_unlock(&snapstore_device->store_block_map_locker);
+}
+
+void snapstore_device_done(void)
+{
+	struct snapstore_device *snapstore_device = NULL;
+
+	do {
+		down_write(&snapstore_devices_lock);
+		if (!list_empty(&snapstore_devices)) {
+			snapstore_device =
+				list_entry(snapstore_devices.next, struct snapstore_device, link);
+			list_del(&snapstore_device->link);
+		}
+		up_write(&snapstore_devices_lock);
+
+		if (snapstore_device)
+			snapstore_device_put_resource(snapstore_device);
+	} while (snapstore_device);
+}
+
+struct snapstore_device *snapstore_device_find_by_dev_id(dev_t dev_id)
+{
+	struct snapstore_device *result = NULL;
+
+	down_read(&snapstore_devices_lock);
+	if (!list_empty(&snapstore_devices)) {
+		struct list_head *_head;
+
+		list_for_each(_head, &snapstore_devices) {
+			struct snapstore_device *snapstore_device =
+				list_entry(_head, struct snapstore_device, link);
+
+			if (dev_id == snapstore_device->dev_id) {
+				result = snapstore_device;
+				break;
+			}
+		}
+	}
+	up_read(&snapstore_devices_lock);
+
+	return result;
+}
+
+struct snapstore_device *_snapstore_device_get_by_snapstore_id(uuid_t *id)
+{
+	struct snapstore_device *result = NULL;
+
+	down_write(&snapstore_devices_lock);
+	if (!list_empty(&snapstore_devices)) {
+		struct list_head *_head;
+
+		list_for_each(_head, &snapstore_devices) {
+			struct snapstore_device *snapstore_device =
+				list_entry(_head, struct snapstore_device, link);
+
+			if (uuid_equal(id, &snapstore_device->snapstore->id)) {
+				result = snapstore_device;
+				list_del(&snapstore_device->link);
+				break;
+			}
+		}
+	}
+	up_write(&snapstore_devices_lock);
+
+	return result;
+}
+
+static void _snapstore_device_destroy(struct snapstore_device *snapstore_device)
+{
+	pr_info("Destroy snapstore device\n");
+
+	xa_destroy(&snapstore_device->store_block_map);
+
+	if (snapstore_device->orig_blk_dev != NULL)
+		blk_dev_close(snapstore_device->orig_blk_dev);
+
+	rangevector_done(&snapstore_device->zero_sectors);
+
+	if (snapstore_device->snapstore) {
+		pr_info("Snapstore uuid %pUB\n", &snapstore_device->snapstore->id);
+
+		snapstore_put(snapstore_device->snapstore);
+		snapstore_device->snapstore = NULL;
+	}
+
+	kfree(snapstore_device);
+}
+
+static void snapstore_device_free_cb(struct kref *kref)
+{
+	struct snapstore_device *snapstore_device =
+		container_of(kref, struct snapstore_device, refcount);
+
+	_snapstore_device_destroy(snapstore_device);
+}
+
+struct snapstore_device *snapstore_device_get_resource(struct snapstore_device *snapstore_device)
+{
+	if (snapstore_device)
+		kref_get(&snapstore_device->refcount);
+
+	return snapstore_device;
+};
+
+void snapstore_device_put_resource(struct snapstore_device *snapstore_device)
+{
+	if (snapstore_device)
+		kref_put(&snapstore_device->refcount, snapstore_device_free_cb);
+};
+
+int snapstore_device_cleanup(uuid_t *id)
+{
+	int result = SUCCESS;
+	struct snapstore_device *snapstore_device = NULL;
+
+	while (NULL != (snapstore_device = _snapstore_device_get_by_snapstore_id(id))) {
+		pr_info("Cleanup snapstore device for device [%d:%d]\n",
+			MAJOR(snapstore_device->dev_id), MINOR(snapstore_device->dev_id));
+
+		snapstore_device_put_resource(snapstore_device);
+	}
+	return result;
+}
+
+int snapstore_device_create(dev_t dev_id, struct snapstore *snapstore)
+{
+	int res = SUCCESS;
+	struct snapstore_device *snapstore_device =
+		kzalloc(sizeof(struct snapstore_device), GFP_KERNEL);
+
+	if (snapstore_device == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&snapstore_device->link);
+	snapstore_device->dev_id = dev_id;
+
+	res = blk_dev_open(dev_id, &snapstore_device->orig_blk_dev);
+	if (res != SUCCESS) {
+		kfree(snapstore_device);
+
+		pr_err("Unable to create snapstore device: failed to open original device [%d:%d]\n",
+		       MAJOR(dev_id), MINOR(dev_id));
+		return res;
+	}
+
+	kref_init(&snapstore_device->refcount);
+
+	snapstore_device->snapstore = NULL;
+	snapstore_device->err_code = SUCCESS;
+	snapstore_device->corrupted = false;
+	atomic_set(&snapstore_device->req_failed_cnt, 0);
+
+	mutex_init(&snapstore_device->store_block_map_locker);
+
+	rangevector_init(&snapstore_device->zero_sectors);
+
+	xa_init(&snapstore_device->store_block_map);
+
+	snapstore_device->snapstore = snapstore_get(snapstore);
+
+	down_write(&snapstore_devices_lock);
+	list_add_tail(&snapstore_device->link, &snapstore_devices);
+	up_write(&snapstore_devices_lock);
+
+	return SUCCESS;
+}
+
+int snapstore_device_add_request(struct snapstore_device *snapstore_device,
+				 unsigned long block_index,
+				 struct blk_deferred_request **dio_copy_req)
+{
+	int res = SUCCESS;
+	union blk_descr_unify blk_descr = { NULL };
+	struct blk_deferred_io *dio = NULL;
+	bool req_new = false;
+
+	blk_descr = snapstore_get_empty_block(snapstore_device->snapstore);
+	if (blk_descr.ptr == NULL) {
+		pr_err("Unable to add block to defer IO request: failed to allocate next block\n");
+		return -ENODATA;
+	}
+
+	res = xa_err(
+		xa_store(&snapstore_device->store_block_map, block_index, blk_descr.ptr, GFP_NOIO));
+	if (res != SUCCESS) {
+		pr_err("Unable to add block to defer IO request: failed to set block descriptor to descriptors array. errno=%d\n",
+		       res);
+		return res;
+	}
+
+	if (*dio_copy_req == NULL) {
+		*dio_copy_req = blk_deferred_request_new();
+		if (*dio_copy_req == NULL) {
+			pr_err("Unable to add block to defer IO request: failed to allocate defer IO request\n");
+			return -ENOMEM;
+		}
+		req_new = true;
+	}
+
+	do {
+		dio = blk_deferred_alloc(block_index, blk_descr);
+		if (dio == NULL) {
+			pr_err("Unabled to add block to defer IO request: failed to allocate defer IO\n");
+			res = -ENOMEM;
+			break;
+		}
+
+		res = blk_deferred_request_add(*dio_copy_req, dio);
+		if (res != SUCCESS)
+			pr_err("Unable to add block to defer IO request: failed to add defer IO to request\n");
+	} while (false);
+
+	if (res != SUCCESS) {
+		if (dio != NULL) {
+			blk_deferred_free(dio);
+			dio = NULL;
+		}
+		if (req_new) {
+			blk_deferred_request_free(*dio_copy_req);
+			*dio_copy_req = NULL;
+		}
+	}
+
+	return res;
+}
+
+int snapstore_device_prepare_requests(struct snapstore_device *snapstore_device,
+				      struct blk_range *copy_range,
+				      struct blk_deferred_request **dio_copy_req)
+{
+	int res = SUCCESS;
+	unsigned long inx = 0;
+	unsigned long first = (unsigned long)(copy_range->ofs >> snapstore_block_shift());
+	unsigned long last =
+		(unsigned long)((copy_range->ofs + copy_range->cnt - 1) >> snapstore_block_shift());
+
+	for (inx = first; inx <= last; inx++) {
+		if (xa_load(&snapstore_device->store_block_map, inx) == NULL) {
+			res = snapstore_device_add_request(snapstore_device, inx, dio_copy_req);
+			if (res != SUCCESS) {
+				pr_err("Failed to create copy defer IO request. errno=%d\n", res);
+				break;
+			}
+		}
+		/*
+		 * If xa_load() return not NULL, then block already stored.
+		 */
+	}
+	if (res != SUCCESS)
+		snapstore_device_set_corrupted(snapstore_device, res);
+
+	return res;
+}
+
+int snapstore_device_store(struct snapstore_device *snapstore_device,
+			   struct blk_deferred_request *dio_copy_req)
+{
+	int res;
+
+	res = snapstore_request_store(snapstore_device->snapstore, dio_copy_req);
+	if (res != SUCCESS)
+		snapstore_device_set_corrupted(snapstore_device, res);
+
+	return res;
+}
+
+int snapstore_device_read(struct snapstore_device *snapstore_device,
+			  struct blk_redirect_bio *rq_redir)
+{
+	int res = SUCCESS;
+
+	unsigned long block_index;
+	unsigned long block_index_last;
+	unsigned long block_index_first;
+
+	sector_t blk_ofs_start = 0; //device range start
+	sector_t blk_ofs_count = 0; //device range length
+
+	struct blk_range rq_range;
+	struct rangevector *zero_sectors = &snapstore_device->zero_sectors;
+
+	if (snapstore_device_is_corrupted(snapstore_device))
+		return -ENODATA;
+
+	rq_range.cnt = bio_sectors(rq_redir->bio);
+	rq_range.ofs = rq_redir->bio->bi_iter.bi_sector;
+
+	if (!bio_has_data(rq_redir->bio)) {
+		pr_warn("Empty bio was found during reading from snapstore device. flags=%u\n",
+			rq_redir->bio->bi_flags);
+
+		blk_redirect_complete(rq_redir, SUCCESS);
+		return SUCCESS;
+	}
+
+	block_index_first = (unsigned long)(rq_range.ofs >> snapstore_block_shift());
+	block_index_last =
+		(unsigned long)((rq_range.ofs + rq_range.cnt - 1) >> snapstore_block_shift());
+
+	_snapstore_device_descr_write_lock(snapstore_device);
+	for (block_index = block_index_first; block_index <= block_index_last; ++block_index) {
+		union blk_descr_unify blk_descr;
+
+		blk_ofs_count = min_t(sector_t,
+				      (((sector_t)(block_index + 1)) << snapstore_block_shift()) -
+					      (rq_range.ofs + blk_ofs_start),
+				      rq_range.cnt - blk_ofs_start);
+
+		blk_descr = (union blk_descr_unify)xa_load(&snapstore_device->store_block_map,
+							   block_index);
+		if (blk_descr.ptr) {
+			//push snapstore read
+			res = snapstore_redirect_read(rq_redir, snapstore_device->snapstore,
+						      blk_descr, rq_range.ofs + blk_ofs_start,
+						      blk_ofs_start, blk_ofs_count);
+			if (res != SUCCESS) {
+				pr_err("Failed to read from snapstore device\n");
+				break;
+			}
+		} else {
+			//device read with zeroing
+			if (zero_sectors)
+				res = blk_dev_redirect_read_zeroed(rq_redir,
+								   snapstore_device->orig_blk_dev,
+								   rq_range.ofs, blk_ofs_start,
+								   blk_ofs_count, zero_sectors);
+			else
+				res = blk_dev_redirect_part(rq_redir, READ,
+							    snapstore_device->orig_blk_dev,
+							    rq_range.ofs + blk_ofs_start,
+							    blk_ofs_start, blk_ofs_count);
+
+			if (res != SUCCESS) {
+				pr_err("Failed to redirect read request to the original device [%d:%d]\n",
+				       MAJOR(snapstore_device->dev_id),
+				       MINOR(snapstore_device->dev_id));
+				break;
+			}
+		}
+
+		blk_ofs_start += blk_ofs_count;
+	}
+
+	if (res == SUCCESS) {
+		if (atomic64_read(&rq_redir->bio_count) > 0ll) //async direct access needed
+			blk_dev_redirect_submit(rq_redir);
+		else
+			blk_redirect_complete(rq_redir, res);
+	} else {
+		pr_err("Failed to read from snapstore device. errno=%d\n", res);
+		pr_err("Position %lld sector, length %lld sectors\n", rq_range.ofs, rq_range.cnt);
+	}
+	_snapstore_device_descr_write_unlock(snapstore_device);
+
+	return res;
+}
+
+int _snapstore_device_copy_on_write(struct snapstore_device *snapstore_device,
+				    struct blk_range *rq_range)
+{
+	int res = SUCCESS;
+	struct blk_deferred_request *dio_copy_req = NULL;
+
+	mutex_lock(&snapstore_device->store_block_map_locker);
+	do {
+		res = snapstore_device_prepare_requests(snapstore_device, rq_range, &dio_copy_req);
+		if (res != SUCCESS) {
+			pr_err("Failed to create defer IO request for range. errno=%d\n", res);
+			break;
+		}
+
+		if (dio_copy_req == NULL)
+			break; //nothing to copy
+
+		res = blk_deferred_request_read_original(snapstore_device->orig_blk_dev,
+							 dio_copy_req);
+		if (res != SUCCESS) {
+			pr_err("Failed to read data from the original device. errno=%d\n", res);
+			break;
+		}
+
+		res = snapstore_device_store(snapstore_device, dio_copy_req);
+		if (res != SUCCESS) {
+			pr_err("Failed to write data to snapstore. errno=%d\n", res);
+			break;
+		}
+	} while (false);
+	mutex_unlock(&snapstore_device->store_block_map_locker);
+
+	if (dio_copy_req) {
+		if (res == -EDEADLK)
+			blk_deferred_request_deadlocked(dio_copy_req);
+		else
+			blk_deferred_request_free(dio_copy_req);
+	}
+
+	return res;
+}
+
+int snapstore_device_write(struct snapstore_device *snapstore_device,
+			   struct blk_redirect_bio *rq_redir)
+{
+	int res = SUCCESS;
+	unsigned long block_index;
+	unsigned long block_index_last;
+	unsigned long block_index_first;
+	sector_t blk_ofs_start = 0; //device range start
+	sector_t blk_ofs_count = 0; //device range length
+	struct blk_range rq_range;
+
+	if (snapstore_device_is_corrupted(snapstore_device))
+		return -ENODATA;
+
+	rq_range.cnt = bio_sectors(rq_redir->bio);
+	rq_range.ofs = rq_redir->bio->bi_iter.bi_sector;
+
+	if (!bio_has_data(rq_redir->bio)) {
+		pr_warn("Empty bio was found during reading from snapstore device. flags=%u\n",
+			rq_redir->bio->bi_flags);
+
+		blk_redirect_complete(rq_redir, SUCCESS);
+		return SUCCESS;
+	}
+
+	// do copy to snapstore previously
+	res = _snapstore_device_copy_on_write(snapstore_device, &rq_range);
+
+	block_index_first = (unsigned long)(rq_range.ofs >> snapstore_block_shift());
+	block_index_last =
+		(unsigned long)((rq_range.ofs + rq_range.cnt - 1) >> snapstore_block_shift());
+
+	_snapstore_device_descr_write_lock(snapstore_device);
+	for (block_index = block_index_first; block_index <= block_index_last; ++block_index) {
+		union blk_descr_unify blk_descr;
+
+		blk_ofs_count = min_t(sector_t,
+				      (((sector_t)(block_index + 1)) << snapstore_block_shift()) -
+					      (rq_range.ofs + blk_ofs_start),
+				      rq_range.cnt - blk_ofs_start);
+
+		blk_descr = (union blk_descr_unify)xa_load(&snapstore_device->store_block_map,
+							   block_index);
+		if (blk_descr.ptr == NULL) {
+			pr_err("Unable to write from snapstore device: invalid snapstore block descriptor\n");
+			res = -EIO;
+			break;
+		}
+
+		res = snapstore_redirect_write(rq_redir, snapstore_device->snapstore, blk_descr,
+					       rq_range.ofs + blk_ofs_start, blk_ofs_start,
+					       blk_ofs_count);
+		if (res != SUCCESS) {
+			pr_err("Unable to write from snapstore device: failed to redirect write request to snapstore\n");
+			break;
+		}
+
+		blk_ofs_start += blk_ofs_count;
+	}
+	if (res == SUCCESS) {
+		if (atomic64_read(&rq_redir->bio_count) > 0) { //async direct access needed
+			blk_dev_redirect_submit(rq_redir);
+		} else {
+			blk_redirect_complete(rq_redir, res);
+		}
+	} else {
+		pr_err("Failed to write from snapstore device. errno=%d\n", res);
+		pr_err("Position %lld sector, length %lld sectors\n", rq_range.ofs, rq_range.cnt);
+
+		snapstore_device_set_corrupted(snapstore_device, res);
+	}
+	_snapstore_device_descr_write_unlock(snapstore_device);
+	return res;
+}
+
+bool snapstore_device_is_corrupted(struct snapstore_device *snapstore_device)
+{
+	if (snapstore_device == NULL)
+		return true;
+
+	if (snapstore_device->corrupted) {
+		if (atomic_read(&snapstore_device->req_failed_cnt) == 0)
+			pr_err("Snapshot device is corrupted for [%d:%d]\n",
+			       MAJOR(snapstore_device->dev_id), MINOR(snapstore_device->dev_id));
+
+		atomic_inc(&snapstore_device->req_failed_cnt);
+		return true;
+	}
+
+	return false;
+}
+
+void snapstore_device_set_corrupted(struct snapstore_device *snapstore_device, int err_code)
+{
+	if (!snapstore_device->corrupted) {
+		atomic_set(&snapstore_device->req_failed_cnt, 0);
+		snapstore_device->corrupted = true;
+		snapstore_device->err_code = abs(err_code);
+
+		pr_err("Set snapshot device is corrupted for [%d:%d]\n",
+		       MAJOR(snapstore_device->dev_id), MINOR(snapstore_device->dev_id));
+	}
+}
+
+int snapstore_device_errno(dev_t dev_id, int *p_err_code)
+{
+	struct snapstore_device *snapstore_device;
+
+	snapstore_device = snapstore_device_find_by_dev_id(dev_id);
+	if (snapstore_device == NULL)
+		return -ENODATA;
+
+	*p_err_code = snapstore_device->err_code;
+	return SUCCESS;
+}
diff --git a/drivers/block/blk-snap/snapstore_device.h b/drivers/block/blk-snap/snapstore_device.h
new file mode 100644
index 000000000000..729b3c05ef70
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore_device.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include "rangevector.h"
+#include "blk_deferred.h"
+#include "blk_redirect.h"
+#include "snapstore.h"
+#include <linux/xarray.h>
+#include <linux/kref.h>
+
+struct snapstore_device {
+	struct list_head link;
+	struct kref refcount;
+
+	dev_t dev_id;
+	struct snapstore *snapstore;
+
+	struct block_device *orig_blk_dev;
+
+	struct xarray store_block_map; // map block index to read block offset
+	struct mutex store_block_map_locker;
+
+	struct rangevector zero_sectors;
+
+	atomic_t req_failed_cnt;
+	int err_code;
+	bool corrupted;
+};
+
+void snapstore_device_done(void);
+
+struct snapstore_device *snapstore_device_get_resource(struct snapstore_device *snapstore_device);
+void snapstore_device_put_resource(struct snapstore_device *snapstore_device);
+
+struct snapstore_device *snapstore_device_find_by_dev_id(dev_t dev_id);
+
+int snapstore_device_create(dev_t dev_id, struct snapstore *snapstore);
+
+int snapstore_device_cleanup(uuid_t *id);
+
+int snapstore_device_prepare_requests(struct snapstore_device *snapstore_device,
+				      struct blk_range *copy_range,
+				      struct blk_deferred_request **dio_copy_req);
+int snapstore_device_store(struct snapstore_device *snapstore_device,
+			   struct blk_deferred_request *dio_copy_req);
+
+int snapstore_device_read(struct snapstore_device *snapstore_device,
+			  struct blk_redirect_bio *rq_redir); //request from image
+int snapstore_device_write(struct snapstore_device *snapstore_device,
+			   struct blk_redirect_bio *rq_redir); //request from image
+
+bool snapstore_device_is_corrupted(struct snapstore_device *snapstore_device);
+void snapstore_device_set_corrupted(struct snapstore_device *snapstore_device, int err_code);
+int snapstore_device_errno(dev_t dev_id, int *p_err_code);
+
+static inline void _snapstore_device_descr_read_lock(struct snapstore_device *snapstore_device)
+{
+	mutex_lock(&snapstore_device->store_block_map_locker);
+}
+static inline void _snapstore_device_descr_read_unlock(struct snapstore_device *snapstore_device)
+{
+	mutex_unlock(&snapstore_device->store_block_map_locker);
+}
diff --git a/drivers/block/blk-snap/snapstore_file.c b/drivers/block/blk-snap/snapstore_file.c
new file mode 100644
index 000000000000..a5c959a8070c
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore_file.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-snapstore"
+#include "common.h"
+#include "snapstore_file.h"
+#include "blk_util.h"
+
+int snapstore_file_create(dev_t dev_id, struct snapstore_file **pfile)
+{
+	int res = SUCCESS;
+	struct snapstore_file *file;
+
+	pr_info("Single device file snapstore was created on device [%d:%d]\n", MAJOR(dev_id),
+	       MINOR(dev_id));
+
+	file = kzalloc(sizeof(struct snapstore_file), GFP_KERNEL);
+	if (file == NULL)
+		return -ENOMEM;
+
+	res = blk_dev_open(dev_id, &file->blk_dev);
+	if (res != SUCCESS) {
+		kfree(file);
+		pr_err("Unable to create snapstore file: failed to open device [%d:%d]. errno=%d",
+		       MAJOR(dev_id), MINOR(dev_id), res);
+		return res;
+	}
+	{
+		struct request_queue *q = bdev_get_queue(file->blk_dev);
+
+		pr_info("snapstore device logical block size %d\n", q->limits.logical_block_size);
+		pr_info("snapstore device physical block size %d\n", q->limits.physical_block_size);
+	}
+
+	file->blk_dev_id = dev_id;
+	blk_descr_file_pool_init(&file->pool);
+
+	*pfile = file;
+	return res;
+}
+
+void snapstore_file_destroy(struct snapstore_file *file)
+{
+	if (file) {
+		blk_descr_file_pool_done(&file->pool);
+
+		if (file->blk_dev != NULL) {
+			blk_dev_close(file->blk_dev);
+			file->blk_dev = NULL;
+		}
+
+		kfree(file);
+	}
+}
diff --git a/drivers/block/blk-snap/snapstore_file.h b/drivers/block/blk-snap/snapstore_file.h
new file mode 100644
index 000000000000..effd9d888781
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore_file.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include "blk_deferred.h"
+
+struct snapstore_file {
+	dev_t blk_dev_id;
+	struct block_device *blk_dev;
+
+	struct blk_descr_pool pool;
+};
+
+int snapstore_file_create(dev_t dev_id, struct snapstore_file **pfile);
+
+void snapstore_file_destroy(struct snapstore_file *file);
diff --git a/drivers/block/blk-snap/snapstore_mem.c b/drivers/block/blk-snap/snapstore_mem.c
new file mode 100644
index 000000000000..29a607617d99
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore_mem.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-snapstore"
+#include "common.h"
+#include "snapstore_mem.h"
+#include "params.h"
+
+#include <linux/vmalloc.h>
+
+struct buffer_el {
+	struct list_head link;
+	void *buff;
+};
+
+struct snapstore_mem *snapstore_mem_create(size_t available_blocks)
+{
+	struct snapstore_mem *mem = kzalloc(sizeof(struct snapstore_mem), GFP_KERNEL);
+
+	if (mem == NULL)
+		return NULL;
+
+	blk_descr_mem_pool_init(&mem->pool, available_blocks);
+
+	mem->blocks_limit = available_blocks;
+
+	INIT_LIST_HEAD(&mem->blocks);
+	mutex_init(&mem->blocks_lock);
+
+	return mem;
+}
+
+void snapstore_mem_destroy(struct snapstore_mem *mem)
+{
+	struct buffer_el *buffer_el;
+
+	if (mem == NULL)
+		return;
+
+	do {
+		buffer_el = NULL;
+
+		mutex_lock(&mem->blocks_lock);
+		if (!list_empty(&mem->blocks)) {
+			buffer_el = list_entry(mem->blocks.next, struct buffer_el, link);
+
+			list_del(&buffer_el->link);
+		}
+		mutex_unlock(&mem->blocks_lock);
+
+		if (buffer_el) {
+			vfree(buffer_el->buff);
+			kfree(buffer_el);
+		}
+	} while (buffer_el);
+
+	blk_descr_mem_pool_done(&mem->pool);
+
+	kfree(mem);
+}
+
+void *snapstore_mem_get_block(struct snapstore_mem *mem)
+{
+	struct buffer_el *buffer_el;
+
+	if (mem->blocks_allocated >= mem->blocks_limit) {
+		pr_err("Unable to get block from snapstore in memory\n");
+		pr_err("Block limit is reached, allocated %zu, limit %zu\n", mem->blocks_allocated,
+		       mem->blocks_limit);
+		return NULL;
+	}
+
+	buffer_el = kzalloc(sizeof(struct buffer_el), GFP_KERNEL);
+	if (buffer_el == NULL)
+		return NULL;
+	INIT_LIST_HEAD(&buffer_el->link);
+
+	buffer_el->buff = vmalloc(snapstore_block_size() * SECTOR_SIZE);
+	if (buffer_el->buff == NULL) {
+		kfree(buffer_el);
+		return NULL;
+	}
+
+	++mem->blocks_allocated;
+	if (0 == (mem->blocks_allocated & 0x7F))
+		pr_info("%zu MiB was allocated\n", mem->blocks_allocated);
+
+	mutex_lock(&mem->blocks_lock);
+	list_add_tail(&buffer_el->link, &mem->blocks);
+	mutex_unlock(&mem->blocks_lock);
+
+	return buffer_el->buff;
+}
diff --git a/drivers/block/blk-snap/snapstore_mem.h b/drivers/block/blk-snap/snapstore_mem.h
new file mode 100644
index 000000000000..9044a6525966
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore_mem.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include "blk_descr_mem.h"
+
+struct snapstore_mem {
+	struct list_head blocks;
+	struct mutex blocks_lock;
+
+	size_t blocks_limit;
+	size_t blocks_allocated;
+
+	struct blk_descr_pool pool;
+};
+
+struct snapstore_mem *snapstore_mem_create(size_t available_blocks);
+
+void snapstore_mem_destroy(struct snapstore_mem *mem);
+
+void *snapstore_mem_get_block(struct snapstore_mem *mem);
diff --git a/drivers/block/blk-snap/snapstore_multidev.c b/drivers/block/blk-snap/snapstore_multidev.c
new file mode 100644
index 000000000000..bb6bfefa68d7
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore_multidev.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-snapstore"
+#include "common.h"
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+
+#include "snapstore_multidev.h"
+#include "blk_util.h"
+
+struct multidev_el {
+	struct list_head link;
+
+	dev_t dev_id;
+	struct block_device *blk_dev;
+};
+
+int snapstore_multidev_create(struct snapstore_multidev **p_multidev)
+{
+	int res = SUCCESS;
+	struct snapstore_multidev *multidev;
+
+	pr_info("Multidevice file snapstore create\n");
+
+	multidev = kzalloc(sizeof(struct snapstore_multidev), GFP_KERNEL);
+	if (multidev == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&multidev->devicelist);
+	spin_lock_init(&multidev->devicelist_lock);
+
+	blk_descr_multidev_pool_init(&multidev->pool);
+
+	*p_multidev = multidev;
+	return res;
+}
+
+void snapstore_multidev_destroy(struct snapstore_multidev *multidev)
+{
+	struct multidev_el *el;
+
+	blk_descr_multidev_pool_done(&multidev->pool);
+
+	do {
+		el = NULL;
+		spin_lock(&multidev->devicelist_lock);
+		if (!list_empty(&multidev->devicelist)) {
+			el = list_entry(multidev->devicelist.next, struct multidev_el, link);
+
+			list_del(&el->link);
+		}
+		spin_unlock(&multidev->devicelist_lock);
+
+		if (el) {
+			blk_dev_close(el->blk_dev);
+
+			pr_info("Close device for multidevice snapstore [%d:%d]\n",
+				MAJOR(el->dev_id), MINOR(el->dev_id));
+
+			kfree(el);
+		}
+	} while (el);
+
+	kfree(multidev);
+}
+
+struct multidev_el *snapstore_multidev_find(struct snapstore_multidev *multidev, dev_t dev_id)
+{
+	struct multidev_el *el = NULL;
+
+	spin_lock(&multidev->devicelist_lock);
+	if (!list_empty(&multidev->devicelist)) {
+		struct list_head *_head;
+
+		list_for_each(_head, &multidev->devicelist) {
+			struct multidev_el *_el = list_entry(_head, struct multidev_el, link);
+
+			if (_el->dev_id == dev_id) {
+				el = _el;
+				break;
+			}
+		}
+	}
+	spin_unlock(&multidev->devicelist_lock);
+
+	return el;
+}
+
+struct block_device *snapstore_multidev_get_device(struct snapstore_multidev *multidev,
+						   dev_t dev_id)
+{
+	int res;
+	struct block_device *blk_dev = NULL;
+	struct multidev_el *el = snapstore_multidev_find(multidev, dev_id);
+
+	if (el)
+		return el->blk_dev;
+
+	res = blk_dev_open(dev_id, &blk_dev);
+	if (res != SUCCESS) {
+		pr_err("Unable to add device to snapstore multidevice file\n");
+		pr_err("Failed to open [%d:%d]. errno=%d", MAJOR(dev_id), MINOR(dev_id), res);
+		return NULL;
+	}
+
+	el = kzalloc(sizeof(struct multidev_el), GFP_KERNEL);
+	INIT_LIST_HEAD(&el->link);
+
+	el->blk_dev = blk_dev;
+	el->dev_id = dev_id;
+
+	spin_lock(&multidev->devicelist_lock);
+	list_add_tail(&el->link, &multidev->devicelist);
+	spin_unlock(&multidev->devicelist_lock);
+
+	return el->blk_dev;
+}
+
+#endif
diff --git a/drivers/block/blk-snap/snapstore_multidev.h b/drivers/block/blk-snap/snapstore_multidev.h
new file mode 100644
index 000000000000..40c1c3a41b08
--- /dev/null
+++ b/drivers/block/blk-snap/snapstore_multidev.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV
+
+#include "blk_deferred.h"
+#include "blk_descr_multidev.h"
+
+struct snapstore_multidev {
+	struct list_head devicelist; //for mapping device id to opened device struct pointer
+	spinlock_t devicelist_lock;
+
+	struct blk_descr_pool pool;
+};
+
+int snapstore_multidev_create(struct snapstore_multidev **p_file);
+
+void snapstore_multidev_destroy(struct snapstore_multidev *file);
+
+struct block_device *snapstore_multidev_get_device(struct snapstore_multidev *multidev,
+						   dev_t dev_id);
+#endif
diff --git a/drivers/block/blk-snap/tracker.c b/drivers/block/blk-snap/tracker.c
new file mode 100644
index 000000000000..3cda996d3f0a
--- /dev/null
+++ b/drivers/block/blk-snap/tracker.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-tracker"
+#include "common.h"
+#include "tracker.h"
+#include "blk_util.h"
+#include "params.h"
+
+LIST_HEAD(trackers);
+DEFINE_RWLOCK(trackers_lock);
+
+void tracker_done(void)
+{
+	tracker_remove_all();
+}
+
+int tracker_find_by_bio(struct bio *bio, struct tracker **ptracker)
+{
+	int result = -ENODATA;
+
+	read_lock(&trackers_lock);
+	if (!list_empty(&trackers)) {
+		struct list_head *_head;
+
+		list_for_each(_head, &trackers) {
+			struct tracker *_tracker = list_entry(_head, struct tracker, link);
+
+			if ((bio->bi_disk == _tracker->target_dev->bd_disk) &&
+			    (bio->bi_partno == _tracker->target_dev->bd_partno)) {
+				if (ptracker != NULL)
+					*ptracker = _tracker;
+
+				result = SUCCESS;
+				break;
+			}
+		}
+	}
+	read_unlock(&trackers_lock);
+
+	return result;
+}
+
+int tracker_find_by_dev_id(dev_t dev_id, struct tracker **ptracker)
+{
+	int result = -ENODATA;
+
+	read_lock(&trackers_lock);
+	if (!list_empty(&trackers)) {
+		struct list_head *_head;
+
+		list_for_each(_head, &trackers) {
+			struct tracker *_tracker = list_entry(_head, struct tracker, link);
+
+			if (_tracker->original_dev_id == dev_id) {
+				if (ptracker != NULL)
+					*ptracker = _tracker;
+
+				result = SUCCESS;
+				break;
+			}
+		}
+	}
+	read_unlock(&trackers_lock);
+
+	return result;
+}
+
+int tracker_enum_cbt_info(int max_count, struct cbt_info_s *p_cbt_info, int *p_count)
+{
+	int result = SUCCESS;
+	int count = 0;
+
+	read_lock(&trackers_lock);
+	if (!list_empty(&trackers)) {
+		struct list_head *_head;
+
+		list_for_each(_head, &trackers) {
+			struct tracker *tracker = list_entry(_head, struct tracker, link);
+
+			if (count >= max_count) {
+				result = -ENOBUFS;
+				break; //don`t continue
+			}
+
+			if (p_cbt_info != NULL) {
+				p_cbt_info[count].dev_id.major = MAJOR(tracker->original_dev_id);
+				p_cbt_info[count].dev_id.minor = MINOR(tracker->original_dev_id);
+
+				if (tracker->cbt_map) {
+					p_cbt_info[count].cbt_map_size = tracker->cbt_map->map_size;
+					p_cbt_info[count].snap_number =
+						(unsigned char)
+							tracker->cbt_map->snap_number_previous;
+					uuid_copy((uuid_t *)(p_cbt_info[count].generationId),
+						  &tracker->cbt_map->generationId);
+				} else {
+					p_cbt_info[count].cbt_map_size = 0;
+					p_cbt_info[count].snap_number = 0;
+				}
+
+				p_cbt_info[count].dev_capacity = (u64)from_sectors(
+					part_nr_sects_read(tracker->target_dev->bd_part));
+			}
+
+			++count;
+		}
+	}
+	read_unlock(&trackers_lock);
+
+	if (result == SUCCESS)
+		if (count == 0)
+			result = -ENODATA;
+
+	*p_count = count;
+	return result;
+}
+
+static void blk_thaw_bdev(dev_t dev_id, struct block_device *device,
+					 struct super_block *superblock)
+{
+	if (superblock == NULL)
+		return;
+
+	if (thaw_bdev(device, superblock) == SUCCESS)
+		pr_info("Device [%d:%d] was unfrozen\n", MAJOR(dev_id), MINOR(dev_id));
+	else
+		pr_err("Failed to unfreeze device [%d:%d]\n", MAJOR(dev_id), MINOR(dev_id));
+}
+
+static int blk_freeze_bdev(dev_t dev_id, struct block_device *device,
+			   struct super_block **psuperblock)
+{
+	struct super_block *superblock;
+
+	if (device->bd_super == NULL) {
+		pr_warn("Unable to freeze device [%d:%d]: no superblock was found\n",
+			MAJOR(dev_id), MINOR(dev_id));
+		return SUCCESS;
+	}
+
+	superblock = freeze_bdev(device);
+	if (IS_ERR_OR_NULL(superblock)) {
+		int result;
+
+		pr_err("Failed to freeze device [%d:%d]\n", MAJOR(dev_id), MINOR(dev_id));
+
+		if (superblock == NULL)
+			result = -ENODEV;
+		else {
+			result = PTR_ERR(superblock);
+			pr_err("Error code: %d\n", result);
+		}
+		return result;
+	}
+
+	pr_info("Device [%d:%d] was frozen\n", MAJOR(dev_id), MINOR(dev_id));
+	*psuperblock = superblock;
+
+	return SUCCESS;
+}
+
+int _tracker_create(struct tracker *tracker, void *filter, bool attach_filter)
+{
+	int result = SUCCESS;
+	unsigned int sect_in_block_degree;
+	sector_t capacity;
+	struct super_block *superblock = NULL;
+
+	result = blk_dev_open(tracker->original_dev_id, &tracker->target_dev);
+	if (result != SUCCESS)
+		return ENODEV;
+
+	pr_info("Create tracker for device [%d:%d]. Capacity 0x%llx sectors\n",
+		MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id),
+		(unsigned long long)part_nr_sects_read(tracker->target_dev->bd_part));
+
+	sect_in_block_degree = get_change_tracking_block_size_pow() - SECTOR_SHIFT;
+	capacity = part_nr_sects_read(tracker->target_dev->bd_part);
+
+	tracker->cbt_map = cbt_map_create(sect_in_block_degree, capacity);
+	if (tracker->cbt_map == NULL) {
+		pr_err("Failed to create tracker for device [%d:%d]\n",
+		       MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id));
+		tracker_remove(tracker);
+		return -ENOMEM;
+	}
+
+	tracker->snapshot_id = 0ull;
+
+	if (attach_filter) {
+		blk_freeze_bdev(tracker->original_dev_id, tracker->target_dev, &superblock);
+
+		blk_filter_attach(tracker->original_dev_id, filter, tracker);
+
+		blk_thaw_bdev(tracker->original_dev_id, tracker->target_dev, superblock);
+	}
+
+	return SUCCESS;
+}
+
+int tracker_create(dev_t dev_id, void *filter, struct tracker **ptracker)
+{
+	int ret;
+	struct tracker *tracker = NULL;
+
+	*ptracker = NULL;
+
+	tracker = kzalloc(sizeof(struct tracker), GFP_KERNEL);
+	if (tracker == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&tracker->link);
+	atomic_set(&tracker->is_captured, false);
+	tracker->original_dev_id = dev_id;
+
+	write_lock(&trackers_lock);
+	list_add_tail(&tracker->link, &trackers);
+	write_unlock(&trackers_lock);
+
+	ret = _tracker_create(tracker, filter, true);
+	if (ret < 0) {
+		tracker_remove(tracker);
+		return ret;
+	}
+
+	*ptracker = tracker;
+	if (ret == ENODEV)
+		pr_info("Cannot attach to unknown device [%d:%d]",
+		       MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id));
+
+	return ret;
+}
+
+void _tracker_remove(struct tracker *tracker, bool detach_filter)
+{
+	struct super_block *superblock = NULL;
+
+	if (tracker->target_dev != NULL) {
+		if (detach_filter) {
+			blk_freeze_bdev(tracker->original_dev_id, tracker->target_dev, &superblock);
+
+			blk_filter_detach(tracker->original_dev_id);
+
+			blk_thaw_bdev(tracker->original_dev_id, tracker->target_dev, superblock);
+		}
+
+		blk_dev_close(tracker->target_dev);
+		tracker->target_dev = NULL;
+	}
+
+	if (tracker->cbt_map != NULL) {
+		cbt_map_put_resource(tracker->cbt_map);
+		tracker->cbt_map = NULL;
+	}
+}
+
+void tracker_remove(struct tracker *tracker)
+{
+	_tracker_remove(tracker, true);
+
+	write_lock(&trackers_lock);
+	list_del(&tracker->link);
+	write_unlock(&trackers_lock);
+
+	kfree(tracker);
+}
+
+void tracker_remove_all(void)
+{
+	struct tracker *tracker;
+
+	pr_info("Removing all devices from tracking\n");
+
+	do {
+		tracker = NULL;
+
+		write_lock(&trackers_lock);
+		if (!list_empty(&trackers)) {
+			tracker = list_entry(trackers.next, struct tracker, link);
+
+			list_del(&tracker->link);
+		}
+		write_unlock(&trackers_lock);
+
+		if (tracker) {
+			_tracker_remove(tracker, true);
+			kfree(tracker);
+		}
+	} while (tracker);
+}
+
+void tracker_cbt_bitmap_set(struct tracker *tracker, sector_t sector, sector_t sector_cnt)
+{
+	if (tracker->cbt_map == NULL)
+		return;
+
+	if (tracker->cbt_map->device_capacity != part_nr_sects_read(tracker->target_dev->bd_part)) {
+		pr_warn("Device resize detected\n");
+		tracker->cbt_map->active = false;
+		return;
+	}
+
+	if (cbt_map_set(tracker->cbt_map, sector, sector_cnt) != SUCCESS) { //cbt corrupt
+		pr_warn("CBT fault detected\n");
+		tracker->cbt_map->active = false;
+		return;
+	}
+}
+
+bool tracker_cbt_bitmap_lock(struct tracker *tracker)
+{
+	if (tracker->cbt_map == NULL)
+		return false;
+
+	cbt_map_read_lock(tracker->cbt_map);
+	if (!tracker->cbt_map->active) {
+		cbt_map_read_unlock(tracker->cbt_map);
+		return false;
+	}
+
+	return true;
+}
+
+void tracker_cbt_bitmap_unlock(struct tracker *tracker)
+{
+	if (tracker->cbt_map)
+		cbt_map_read_unlock(tracker->cbt_map);
+}
+
+int _tracker_capture_snapshot(struct tracker *tracker)
+{
+	int result = SUCCESS;
+
+	result = defer_io_create(tracker->original_dev_id, tracker->target_dev, &tracker->defer_io);
+	if (result != SUCCESS) {
+		pr_err("Failed to create defer IO processor\n");
+		return result;
+	}
+
+	atomic_set(&tracker->is_captured, true);
+
+	if (tracker->cbt_map != NULL) {
+		cbt_map_write_lock(tracker->cbt_map);
+		cbt_map_switch(tracker->cbt_map);
+		cbt_map_write_unlock(tracker->cbt_map);
+
+		pr_info("Snapshot captured for device [%d:%d]. New snap number %ld\n",
+			MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id),
+			tracker->cbt_map->snap_number_active);
+	}
+
+	return result;
+}
+
+int tracker_capture_snapshot(dev_t *dev_id_set, int dev_id_set_size)
+{
+	int result = SUCCESS;
+	int inx = 0;
+
+	for (inx = 0; inx < dev_id_set_size; ++inx) {
+		struct super_block *superblock = NULL;
+		struct tracker *tracker = NULL;
+		dev_t dev_id = dev_id_set[inx];
+
+		result = tracker_find_by_dev_id(dev_id, &tracker);
+		if (result != SUCCESS) {
+			pr_err("Unable to capture snapshot: cannot find device [%d:%d]\n",
+			       MAJOR(dev_id), MINOR(dev_id));
+			break;
+		}
+
+
+		blk_freeze_bdev(tracker->original_dev_id, tracker->target_dev, &superblock);
+		blk_filter_freeze(tracker->target_dev);
+
+		result = _tracker_capture_snapshot(tracker);
+		if (result != SUCCESS)
+			pr_err("Failed to capture snapshot for device [%d:%d]\n",
+			       MAJOR(dev_id), MINOR(dev_id));
+
+		blk_filter_thaw(tracker->target_dev);
+		blk_thaw_bdev(tracker->original_dev_id, tracker->target_dev, superblock);
+	}
+	if (result != SUCCESS)
+		return result;
+
+	for (inx = 0; inx < dev_id_set_size; ++inx) {
+		struct tracker *tracker = NULL;
+		dev_t dev_id = dev_id_set[inx];
+
+		result = tracker_find_by_dev_id(dev_id, &tracker);
+		if (result != SUCCESS) {
+			pr_err("Unable to capture snapshot: cannot find device [%d:%d]\n",
+			       MAJOR(dev_id), MINOR(dev_id));
+			continue;
+		}
+
+		if (snapstore_device_is_corrupted(tracker->defer_io->snapstore_device)) {
+			pr_err("Unable to freeze devices [%d:%d]: snapshot data is corrupted\n",
+			       MAJOR(dev_id), MINOR(dev_id));
+			result = -EDEADLK;
+			break;
+		}
+	}
+
+	if (result != SUCCESS) {
+		pr_err("Failed to capture snapshot. errno=%d\n", result);
+
+		tracker_release_snapshot(dev_id_set, dev_id_set_size);
+	}
+	return result;
+}
+
+void _tracker_release_snapshot(struct tracker *tracker)
+{
+	struct super_block *superblock = NULL;
+	struct defer_io *defer_io = tracker->defer_io;
+
+	blk_freeze_bdev(tracker->original_dev_id, tracker->target_dev, &superblock);
+	blk_filter_freeze(tracker->target_dev);
+	{ //locked region
+		atomic_set(&tracker->is_captured, false); //clear freeze flag
+
+		tracker->defer_io = NULL;
+	}
+	blk_filter_thaw(tracker->target_dev);
+
+	blk_thaw_bdev(tracker->original_dev_id, tracker->target_dev, superblock);
+
+	defer_io_stop(defer_io);
+	defer_io_put_resource(defer_io);
+}
+
+void tracker_release_snapshot(dev_t *dev_id_set, int dev_id_set_size)
+{
+	int inx = 0;
+
+	for (; inx < dev_id_set_size; ++inx) {
+		int status;
+		struct tracker *p_tracker = NULL;
+		dev_t dev = dev_id_set[inx];
+
+		status = tracker_find_by_dev_id(dev, &p_tracker);
+		if (status == SUCCESS)
+			_tracker_release_snapshot(p_tracker);
+		else
+			pr_err("Unable to release snapshot: cannot find tracker for device [%d:%d]\n",
+			       MAJOR(dev), MINOR(dev));
+	}
+}
diff --git a/drivers/block/blk-snap/tracker.h b/drivers/block/blk-snap/tracker.h
new file mode 100644
index 000000000000..9fff7c0942c3
--- /dev/null
+++ b/drivers/block/blk-snap/tracker.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include "cbt_map.h"
+#include "defer_io.h"
+#include "blk-snap-ctl.h"
+#include "snapshot.h"
+
+struct tracker {
+	struct list_head link;
+	dev_t original_dev_id;
+	struct block_device *target_dev;
+	struct cbt_map *cbt_map;
+	atomic_t is_captured;
+	struct defer_io *defer_io;
+	unsigned long long snapshot_id; // current snapshot for this device
+};
+
+void tracker_done(void);
+
+int tracker_find_by_bio(struct bio *bio, struct tracker **ptracker);
+int tracker_find_by_dev_id(dev_t dev_id, struct tracker **ptracker);
+
+int tracker_enum_cbt_info(int max_count, struct cbt_info_s *p_cbt_info, int *p_count);
+
+int tracker_capture_snapshot(dev_t *dev_id_set, int dev_id_set_size);
+void tracker_release_snapshot(dev_t *dev_id_set, int dev_id_set_size);
+
+int _tracker_create(struct tracker *tracker, void *filter, bool attach_filter);
+int tracker_create(dev_t dev_id, void *filter, struct tracker **ptracker);
+
+void _tracker_remove(struct tracker *tracker, bool detach_filter);
+void tracker_remove(struct tracker *tracker);
+void tracker_remove_all(void);
+
+void tracker_cbt_bitmap_set(struct tracker *tracker, sector_t sector, sector_t sector_cnt);
+
+bool tracker_cbt_bitmap_lock(struct tracker *tracker);
+void tracker_cbt_bitmap_unlock(struct tracker *tracker);
diff --git a/drivers/block/blk-snap/tracking.c b/drivers/block/blk-snap/tracking.c
new file mode 100644
index 000000000000..55e18891bb96
--- /dev/null
+++ b/drivers/block/blk-snap/tracking.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BLK_SNAP_SECTION "-tracking"
+#include "common.h"
+#include "tracking.h"
+#include "tracker.h"
+#include "blk_util.h"
+#include "defer_io.h"
+#include "params.h"
+
+#include <linux/blk-filter.h>
+
+/* pointer to block layer filter */
+void *filter;
+
+/*
+ * _tracking_submit_bio() - Intercept bio by block io layer filter
+ */
+static bool _tracking_submit_bio(struct bio *bio, void *filter_data)
+{
+	int res;
+	bool cbt_locked = false;
+	struct tracker *tracker = filter_data;
+
+	if (!tracker)
+		return false;
+
+	//intercepting
+	if (atomic_read(&tracker->is_captured)) {
+		//snapshot is captured, call bio redirect algorithm
+
+		res = defer_io_redirect_bio(tracker->defer_io, bio, tracker);
+		if (res == SUCCESS)
+			return true;
+	}
+
+	cbt_locked = false;
+	if (tracker && bio_data_dir(bio) && bio_has_data(bio)) {
+		//call CBT algorithm
+		cbt_locked = tracker_cbt_bitmap_lock(tracker);
+		if (cbt_locked) {
+			sector_t sectStart = bio->bi_iter.bi_sector;
+			sector_t sectCount = bio_sectors(bio);
+
+			tracker_cbt_bitmap_set(tracker, sectStart, sectCount);
+		}
+	}
+	if (cbt_locked)
+		tracker_cbt_bitmap_unlock(tracker);
+
+	return false;
+}
+
+static bool _tracking_part_add(dev_t devt, void **p_filter_data)
+{
+	int result;
+	struct tracker *tracker = NULL;
+
+	pr_info("new block device [%d:%d] in system\n", MAJOR(devt), MINOR(devt));
+
+	result = tracker_find_by_dev_id(devt, &tracker);
+	if (result != SUCCESS)
+		return false; /*do not track this device*/
+
+	if (_tracker_create(tracker, filter, false)) {
+		pr_err("Failed to attach new device to tracker. errno=%d\n", result);
+		return false; /*failed to attach new device to tracker*/
+	}
+
+	*p_filter_data = tracker;
+	return true;
+}
+
+static void _tracking_part_del(void *private_data)
+{
+	struct tracker *tracker = private_data;
+
+	if (!tracker)
+		return;
+
+	pr_info("delete block device [%d:%d] from system\n",
+		MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id));
+
+	_tracker_remove(tracker, false);
+}
+
+struct blk_filter_ops filter_ops = {
+	.filter_bio = _tracking_submit_bio,
+	.part_add = _tracking_part_add,
+	.part_del = _tracking_part_del };
+
+
+
+int tracking_init(void)
+{
+	filter = blk_filter_register(&filter_ops);
+	if (!filter)
+		return -ENOMEM;
+	return SUCCESS;
+}
+
+void tracking_done(void)
+{
+	if (filter) {
+		blk_filter_unregister(filter);
+		filter = NULL;
+	}
+}
+
+static int _add_already_tracked(dev_t dev_id, unsigned long long snapshot_id,
+				struct tracker *tracker)
+{
+	int result = SUCCESS;
+	bool cbt_reset_needed = false;
+
+	if ((snapshot_id != 0ull) && (tracker->snapshot_id == 0ull))
+		tracker->snapshot_id = snapshot_id; // set new snapshot id
+
+	if (tracker->cbt_map == NULL) {
+		unsigned int sect_in_block_degree =
+			get_change_tracking_block_size_pow() - SECTOR_SHIFT;
+		tracker->cbt_map = cbt_map_create(sect_in_block_degree - SECTOR_SHIFT,
+						  part_nr_sects_read(tracker->target_dev->bd_part));
+		if (tracker->cbt_map == NULL)
+			return -ENOMEM;
+
+		// skip snapshot id
+		tracker->snapshot_id = snapshot_id;
+		return SUCCESS;
+	}
+
+	if (!tracker->cbt_map->active) {
+		cbt_reset_needed = true;
+		pr_warn("Nonactive CBT table detected. CBT fault\n");
+	}
+
+	if (tracker->cbt_map->device_capacity != part_nr_sects_read(tracker->target_dev->bd_part)) {
+		cbt_reset_needed = true;
+		pr_warn("Device resize detected. CBT fault\n");
+	}
+
+	if (!cbt_reset_needed)
+		return SUCCESS;
+
+	_tracker_remove(tracker, true);
+
+	result = _tracker_create(tracker, filter, true);
+	if (result != SUCCESS) {
+		pr_err("Failed to create tracker. errno=%d\n", result);
+		return result;
+	}
+
+	tracker->snapshot_id = snapshot_id;
+
+	return SUCCESS;
+}
+
+static int _create_new_tracker(dev_t dev_id, unsigned long long snapshot_id)
+{
+	int result;
+	struct tracker *tracker = NULL;
+
+	result = tracker_create(dev_id, filter, &tracker);
+	if (result != SUCCESS) {
+		pr_err("Failed to create tracker. errno=%d\n", result);
+		return result;
+	}
+
+	tracker->snapshot_id = snapshot_id;
+
+	return SUCCESS;
+}
+
+
+int tracking_add(dev_t dev_id, unsigned long long snapshot_id)
+{
+	int result;
+	struct tracker *tracker = NULL;
+
+	pr_info("Adding device [%d:%d] under tracking\n", MAJOR(dev_id), MINOR(dev_id));
+
+	result = tracker_find_by_dev_id(dev_id, &tracker);
+	if (result == SUCCESS) {
+		//pr_info("Device [%d:%d] is already tracked\n", MAJOR(dev_id), MINOR(dev_id));
+		result = _add_already_tracked(dev_id, snapshot_id, tracker);
+		if (result == SUCCESS)
+			result = -EALREADY;
+	} else if (-ENODATA == result)
+		result = _create_new_tracker(dev_id, snapshot_id);
+	else {
+		pr_err("Unable to add device [%d:%d] under tracking\n", MAJOR(dev_id),
+			MINOR(dev_id));
+		pr_err("Invalid trackers container. errno=%d\n", result);
+	}
+
+	return result;
+}
+
+int tracking_remove(dev_t dev_id)
+{
+	int result;
+	struct tracker *tracker = NULL;
+
+	pr_info("Removing device [%d:%d] from tracking\n", MAJOR(dev_id), MINOR(dev_id));
+
+	result = tracker_find_by_dev_id(dev_id, &tracker);
+	if (result != SUCCESS) {
+		pr_err("Unable to remove device [%d:%d] from tracking: ",
+		       MAJOR(dev_id), MINOR(dev_id));
+
+		if (-ENODATA == result)
+			pr_err("tracker not found\n");
+		else
+			pr_err("tracker container failed. errno=%d\n", result);
+
+		return result;
+	}
+
+	if (tracker->snapshot_id != 0ull) {
+		pr_err("Unable to remove device [%d:%d] from tracking: ",
+		       MAJOR(dev_id), MINOR(dev_id));
+		pr_err("snapshot [0x%llx] already exist\n", tracker->snapshot_id);
+		return -EBUSY;
+	}
+
+	tracker_remove(tracker);
+
+	return SUCCESS;
+}
+
+int tracking_collect(int max_count, struct cbt_info_s *p_cbt_info, int *p_count)
+{
+	int res = tracker_enum_cbt_info(max_count, p_cbt_info, p_count);
+
+	if (res == SUCCESS)
+		pr_info("%d devices found under tracking\n", *p_count);
+	else if (res == -ENODATA) {
+		pr_info("There are no devices under tracking\n");
+		*p_count = 0;
+		res = SUCCESS;
+	} else
+		pr_err("Failed to collect devices under tracking. errno=%d", res);
+
+	return res;
+}
+
+int tracking_read_cbt_bitmap(dev_t dev_id, unsigned int offset, size_t length,
+			     void __user *user_buff)
+{
+	int result = SUCCESS;
+	struct tracker *tracker = NULL;
+
+	result = tracker_find_by_dev_id(dev_id, &tracker);
+	if (result == SUCCESS) {
+		if (atomic_read(&tracker->is_captured))
+			result = cbt_map_read_to_user(tracker->cbt_map, user_buff, offset, length);
+		else {
+			pr_err("Unable to read CBT bitmap for device [%d:%d]: ", MAJOR(dev_id),
+			       MINOR(dev_id));
+			pr_err("device is not captured by snapshot\n");
+			result = -EPERM;
+		}
+	} else if (-ENODATA == result) {
+		pr_err("Unable to read CBT bitmap for device [%d:%d]: ", MAJOR(dev_id),
+		       MINOR(dev_id));
+		pr_err("device not found\n");
+	} else
+		pr_err("Failed to find devices under tracking. errno=%d", result);
+
+	return result;
+}
diff --git a/drivers/block/blk-snap/tracking.h b/drivers/block/blk-snap/tracking.h
new file mode 100644
index 000000000000..22bd5ba54963
--- /dev/null
+++ b/drivers/block/blk-snap/tracking.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include "blk-snap-ctl.h"
+#include <linux/bio.h>
+
+int  tracking_init(void);
+void tracking_done(void);
+
+int tracking_add(dev_t dev_id, unsigned long long snapshot_id);
+int tracking_remove(dev_t dev_id);
+int tracking_collect(int max_count, struct cbt_info_s *p_cbt_info, int *p_count);
+int tracking_read_cbt_bitmap(dev_t dev_id, unsigned int offset, size_t length,
+			     void __user *user_buff);
diff --git a/drivers/block/blk-snap/version.h b/drivers/block/blk-snap/version.h
new file mode 100644
index 000000000000..a4431da73611
--- /dev/null
+++ b/drivers/block/blk-snap/version.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#define FILEVER_MAJOR 5
+#define FILEVER_MINOR 0
+#define FILEVER_REVISION 0
+#define FILEVER_STR "5.0.0"
-- 
2.20.1

