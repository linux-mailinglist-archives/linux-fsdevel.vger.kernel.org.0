Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ABE440F01
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhJaPXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 11:23:32 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24365 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230080AbhJaPXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:23:31 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AE7mGwahOrdyqyVfhNPUf8IxlX161CxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVUzmAfWG2CM6mCZzPxfNB1bo+2/B5QvJHSxtRkQVA6pXw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi+xZVA/fvQHOOlULW?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHm75LMkByZKRMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTSuJsrsUlItPiMI4Wtjdn1z6xJfovR9bBBbrL4dtZ1?=
 =?us-ascii?q?TIrrsFIAfvaIcEebFJHYBbfZBtAElQaEpQzmKGvnHaXWzlZrk+F4K8yy2vNxQd?=
 =?us-ascii?q?ylr/3P7L9fMKGRMBQtkKZvX7duWD4BAwKctCS11Kt8Huqi6nEnT7TX5gbH7m1s?=
 =?us-ascii?q?PVthTW7wm0VFQ1TW0C3rOe0jmagVN9FbU8Z4Cwjqe417kPDZt38WQCo5X2JpBg?=
 =?us-ascii?q?RX/JOHOAgrgKA0KzZ50CeHGdsZjpAbsE28d84XhQ02VKT2dDkHzpitPuSU331y?=
 =?us-ascii?q?1s+hVteIgBMdSlbO3BCFlBDvrHeTEgIpkqnZr5e/GSd1bUZwQ3N/g0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACbxiBqi/Dr4z+v7x+tiPNg5CfHBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.87,197,1631548800"; 
   d="scan'208";a="116677972"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Oct 2021 23:20:53 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A23484D0F90E;
        Sun, 31 Oct 2021 23:20:47 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:20:43 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 31 Oct 2021 23:20:40 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 2/8] dax: Introduce holder for dax_device
Date:   Sun, 31 Oct 2021 23:20:22 +0800
Message-ID: <20211031152028.3724121-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
References: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A23484D0F90E.A1C55
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
 drivers/dax/super.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h | 25 ++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index f7701e943019..ed1b27198382 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -23,7 +23,10 @@
  * @cdev: optional character interface for "device dax"
  * @host: optional name for lookups where the device path is not available
  * @private: dax driver private data
+ * @holder_data: holder of a dax_device: could be filesystem or mapped device
  * @flags: state and boolean properties
+ * @ops: operations for dax_device
+ * @holder_ops: operations for the inner holder
  */
 struct dax_device {
 	struct hlist_node list;
@@ -32,8 +35,10 @@ struct dax_device {
 	const char *host;
 	void *private;
 	struct percpu_rw_semaphore rwsem;
+	void *holder_data;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	const struct dax_holder_operations *holder_ops;
 };
 
 static dev_t dax_devt;
@@ -376,6 +381,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
+			      u64 len, int mf_flags)
+{
+	int rc;
+
+	dax_read_lock(dax_dev);
+	if (!dax_alive(dax_dev)) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (!dax_dev->holder_ops) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
+out:
+	dax_read_unlock(dax_dev);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
@@ -438,6 +466,10 @@ void kill_dax(struct dax_device *dax_dev)
 		return;
 	dax_write_lock(dax_dev);
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
+
+	/* clear holder data */
+	dax_dev->holder_ops = NULL;
+	dax_dev->holder_data = NULL;
 	dax_write_unlock(dax_dev);
 
 	spin_lock(&dax_host_lock);
@@ -622,6 +654,37 @@ void put_dax(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(put_dax);
 
+void dax_set_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	dax_write_lock(dax_dev);
+	if (!dax_alive(dax_dev)) {
+		dax_write_unlock(dax_dev);
+		return;
+	}
+
+	dax_dev->holder_data = holder;
+	dax_dev->holder_ops = ops;
+	dax_write_unlock(dax_dev);
+}
+EXPORT_SYMBOL_GPL(dax_set_holder);
+
+void *dax_get_holder(struct dax_device *dax_dev)
+{
+	void *holder;
+
+	dax_read_lock(dax_dev);
+	if (!dax_alive(dax_dev)) {
+		dax_read_unlock(dax_dev);
+		return NULL;
+	}
+
+	holder = dax_dev->holder_data;
+	dax_read_unlock(dax_dev);
+	return holder;
+}
+EXPORT_SYMBOL_GPL(dax_get_holder);
+
 /**
  * inode_dax: convert a public inode into its dax_dev
  * @inode: An inode with i_cdev pointing to a dax_dev
diff --git a/include/linux/dax.h b/include/linux/dax.h
index e38711d6c519..891c3e8a40e6 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -38,9 +38,24 @@ struct dax_operations {
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
 
+struct dax_holder_operations {
+	/*
+	 * notify_failure - notify memory failure into inner holder device
+	 * @dax_dev: the dax device which contains the holder
+	 * @offset: offset on this dax device where memory failure occurs
+	 * @len: length of this memory failure event
+	 * @flags: action flags for memory failure handler
+	 */
+	int (*notify_failure)(struct dax_device *dax_dev, u64 offset,
+			u64 len, int mf_flags);
+};
+
 extern struct attribute_group dax_attribute_group;
 
 #if IS_ENABLED(CONFIG_DAX)
+void dax_set_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops);
+void *dax_get_holder(struct dax_device *dax_dev);
 struct dax_device *alloc_dax(void *private, const char *host,
 		const struct dax_operations *ops, unsigned long flags);
 void put_dax(struct dax_device *dax_dev);
@@ -70,6 +85,14 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 	return dax_synchronous(dax_dev);
 }
 #else
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
@@ -198,6 +221,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off, u64 len,
+		int mf_flags);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.33.0



