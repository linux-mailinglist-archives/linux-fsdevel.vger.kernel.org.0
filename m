Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC863DB55A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhG3IxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:53:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34380 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238189AbhG3IxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:53:11 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ahx651qFTb6ttFbSwpLqEDMeALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc3Jom6uj5qaTdZUgpGbJYVkqOE3I9ertBEDEewK4yXcX2/h3AV7BZniEhI?=
 =?us-ascii?q?LAFugLhuGO/9SjIVybygc378ZdmsZFZ+EYdWIK7/oS/jPIbuoI8Z2W9ryyn+fC?=
 =?us-ascii?q?wzNIRQFuUatp6AB0EW+gYzZLbTgDFZwkD4Cd+8YCgzKhfE4cZsO9CmJAcPPEo7?=
 =?us-ascii?q?Tw5ejbSC9DFxg68xOPkD/tzLb7FiKT1hAYXygK4ZpKyxm8rzDE?=
X-IronPort-AV: E=Sophos;i="5.84,281,1620662400"; 
   d="scan'208";a="112070581"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jul 2021 16:53:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 43B434D0D4A3;
        Fri, 30 Jul 2021 16:53:01 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 30 Jul 2021 16:52:52 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 30 Jul 2021 16:52:49 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <djwong@kernel.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>
Subject: [PATCH v6 2/9] dax: Introduce holder for dax_device
Date:   Fri, 30 Jul 2021 16:52:38 +0800
Message-ID: <20210730085245.3069812-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730085245.3069812-1-ruansy.fnst@fujitsu.com>
References: <20210730085245.3069812-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 43B434D0D4A3.A0FA0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To easily track filesystem from a pmem device, we introduce a holder for
dax_device structure, and also its operation.  This holder is used to
remember who is using this dax_device:
 - When it is the backend of a filesystem, the holder will be the
   superblock of this filesystem.
 - When this pmem device is one of the targets in a mapped device, the
   holder will be this mapped device.  In this case, the mapped device
   has its own dax_device and it will follow the first rule.  So that we
   can finally track to the filesystem we needed.

The holder and holder_ops will be set when filesystem is being mounted,
or an target device is being activated.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h | 17 +++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5fa6ae9dbc8b..00c32dfa5665 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -214,6 +214,8 @@ enum dax_device_flags {
  * @cdev: optional character interface for "device dax"
  * @host: optional name for lookups where the device path is not available
  * @private: dax driver private data
+ * @holder_rwsem: prevent unregistration while holder_ops is in progress
+ * @holder_data: holder of a dax_device: could be filesystem or mapped device
  * @flags: state and boolean properties
  */
 struct dax_device {
@@ -222,8 +224,11 @@ struct dax_device {
 	struct cdev cdev;
 	const char *host;
 	void *private;
+	struct rw_semaphore holder_rwsem;
+	void *holder_data;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	const struct dax_holder_operations *holder_ops;
 };
 
 static ssize_t write_cache_show(struct device *dev,
@@ -373,6 +378,25 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+int dax_holder_notify_failure(struct dax_device *dax_dev, loff_t offset,
+			      size_t size, void *data)
+{
+	int rc;
+
+	if (!dax_dev)
+		return -ENXIO;
+
+	if (!dax_dev->holder_data)
+		return -EOPNOTSUPP;
+
+	down_read(&dax_dev->holder_rwsem);
+	rc = dax_dev->holder_ops->notify_failure(dax_dev, offset,
+							 size, data);
+	up_read(&dax_dev->holder_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
@@ -603,6 +627,7 @@ struct dax_device *alloc_dax(void *private, const char *__host,
 	dax_add_host(dax_dev, host);
 	dax_dev->ops = ops;
 	dax_dev->private = private;
+	init_rwsem(&dax_dev->holder_rwsem);
 	if (flags & DAXDEV_F_SYNC)
 		set_dax_synchronous(dax_dev);
 
@@ -624,6 +649,27 @@ void put_dax(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(put_dax);
 
+void dax_set_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	if (!dax_dev)
+		return;
+	down_write(&dax_dev->holder_rwsem);
+	dax_dev->holder_data = holder;
+	dax_dev->holder_ops = ops;
+	up_write(&dax_dev->holder_rwsem);
+}
+EXPORT_SYMBOL_GPL(dax_set_holder);
+
+void *dax_get_holder(struct dax_device *dax_dev)
+{
+	if (!dax_dev)
+		return NULL;
+
+	return dax_dev->holder_data;
+}
+EXPORT_SYMBOL_GPL(dax_get_holder);
+
 /**
  * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
  * @host: alternate name for the device registered by a dax driver
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..6f4b5c97ceb0 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -38,10 +38,17 @@ struct dax_operations {
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
 
+struct dax_holder_operations {
+	int (*notify_failure)(struct dax_device *, loff_t, size_t, void *);
+};
+
 extern struct attribute_group dax_attribute_group;
 
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *dax_get_by_host(const char *host);
+void dax_set_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops);
+void *dax_get_holder(struct dax_device *dax_dev);
 struct dax_device *alloc_dax(void *private, const char *host,
 		const struct dax_operations *ops, unsigned long flags);
 void put_dax(struct dax_device *dax_dev);
@@ -77,6 +84,14 @@ static inline struct dax_device *dax_get_by_host(const char *host)
 {
 	return NULL;
 }
+static inline void dax_set_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+}
+static inline void *dax_get_holder(struct dax_device *dax_dev)
+{
+	return NULL;
+}
 static inline struct dax_device *alloc_dax(void *private, const char *host,
 		const struct dax_operations *ops, unsigned long flags)
 {
@@ -226,6 +241,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_holder_notify_failure(struct dax_device *dax_dev, loff_t offset,
+		size_t size, void *data);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.32.0



