Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441853B5611
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 02:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhF1AFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 20:05:32 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54538 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231876AbhF1AFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 20:05:31 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AWJU4YKyumXfXlyQA26UeKrPwyr1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SK2lfqeV7Y0mPH7P+U4ssR4b6LO90cW7Lk80sKQFhbX5Xo3SOjUO2l?=
 =?us-ascii?q?HYTr2KhLGKq1aLdkHDH6xmpMBdmsNFaOEYY2IVsS+D2njcLz8/+qj6zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2f6YRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2eiIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl96ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.83,304,1616428800"; 
   d="scan'208";a="110256332"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Jun 2021 08:03:03 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3E44C4D0BA6A;
        Mon, 28 Jun 2021 08:03:01 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 28 Jun 2021 08:02:57 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 28 Jun 2021 08:02:56 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 28 Jun 2021 08:02:56 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>
Subject: [PATCH v5 2/9] dax: Introduce holder for dax_device
Date:   Mon, 28 Jun 2021 08:02:11 +0800
Message-ID: <20210628000218.387833-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
References: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3E44C4D0BA6A.A2802
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
 drivers/dax/super.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h | 17 ++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5fa6ae9dbc8b..22f0aa3f2e13 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -222,8 +222,11 @@ struct dax_device {
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
@@ -373,6 +376,24 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);

+int dax_holder_notify_failure(struct dax_device *dax_dev, loff_t offset,
+			      size_t size, void *data)
+{
+	int rc = -ENXIO;
+	if (!dax_dev)
+		return rc;
+
+	if (dax_dev->holder_data) {
+		rc = dax_dev->holder_ops->notify_failure(dax_dev, offset,
+							 size, data);
+		if (rc == -ENODEV)
+			rc = -ENXIO;
+	} else
+		rc = -EOPNOTSUPP;
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
@@ -603,6 +624,7 @@ struct dax_device *alloc_dax(void *private, const char *__host,
 	dax_add_host(dax_dev, host);
 	dax_dev->ops = ops;
 	dax_dev->private = private;
+	init_rwsem(&dax_dev->holder_rwsem);
 	if (flags & DAXDEV_F_SYNC)
 		set_dax_synchronous(dax_dev);

@@ -624,6 +646,33 @@ void put_dax(struct dax_device *dax_dev)
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
+	void *holder_data;
+
+	if (!dax_dev)
+		return NULL;
+
+	down_read(&dax_dev->holder_rwsem);
+	holder_data = dax_dev->holder_data;
+	up_read(&dax_dev->holder_rwsem);
+
+	return holder_data;
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



