Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33747F727
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Dec 2021 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhLZOfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 09:35:06 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18852 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233729AbhLZOfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:35:06 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AaNRbs6sZkxdxgYOHX7GCiz7+dufnVD1fMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3yWBLXWqOP/3cNDbye49zaNyz9ENQscDWndZhTlNvqntgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuClUbS?=
 =?us-ascii?q?eZHgoLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6J3OkRaWLSWEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYulnhuwiKsfxNY8Ss30myivWZd4qSJaFQePV5Ntc3?=
 =?us-ascii?q?T41nehPG+rTY4wSbj8HRBjCfBpJNX8UBYg4kePugWPwGxVcqVSIte8y5kDQ0gV?=
 =?us-ascii?q?60/7qKtW9UtqUScRQm26cp3na5CL9AxcHJJqTxCTt2nClgOKJliPmcIUIHba8+?=
 =?us-ascii?q?7hhh1j77mgSDgAGEFWgrfSnh0qWRd1SMQoX9zAooKx081akJvH5XhulsDuHswQ?=
 =?us-ascii?q?aVt54DeI38keOx7DS7gLfAXILJhZFado7pIomSycCyFCEhZXqCCZpvbnTTmiSn?=
 =?us-ascii?q?op4Bxva1TM9dDdEPHFbC1BepYSLnW36tTqXJv4LLUJ/poSd9enM/g23?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Anjpok6/PmNzmvIgRnXpuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,237,1635177600"; 
   d="scan'208";a="119563866"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Dec 2021 22:35:04 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 4AB594D146EE;
        Sun, 26 Dec 2021 22:35:03 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Dec 2021 22:35:05 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 26 Dec 2021 22:35:01 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v9 02/10] dax: Introduce holder for dax_device
Date:   Sun, 26 Dec 2021 22:34:31 +0800
Message-ID: <20211226143439.3985960-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4AB594D146EE.A03D7
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
   instance of this filesystem.
 - When this pmem device is one of the targets in a mapped device, the
   holder will be this mapped device.  In this case, the mapped device
   has its own dax_device and it will follow the first rule.  So that we
   can finally track to the filesystem we needed.

The holder and holder_ops will be set when filesystem is being mounted,
or an target device is being activated.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h | 29 +++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c46f56e33d40..94c51f2ee133 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -20,15 +20,20 @@
  * @inode: core vfs
  * @cdev: optional character interface for "device dax"
  * @private: dax driver private data
+ * @holder_data: holder of a dax_device: could be filesystem or mapped device
  * @flags: state and boolean properties
+ * @ops: operations for dax_device
+ * @holder_ops: operations for the inner holder
  */
 struct dax_device {
 	struct inode inode;
 	struct cdev cdev;
 	void *private;
 	struct percpu_rw_semaphore rwsem;
+	void *holder_data;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	const struct dax_holder_operations *holder_ops;
 };
 
 static dev_t dax_devt;
@@ -192,6 +197,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
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
@@ -254,6 +282,10 @@ void kill_dax(struct dax_device *dax_dev)
 		return;
 	dax_write_lock(dax_dev);
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
+
+	/* clear holder data */
+	dax_dev->holder_ops = NULL;
+	dax_dev->holder_data = NULL;
 	dax_write_unlock(dax_dev);
 }
 EXPORT_SYMBOL_GPL(kill_dax);
@@ -401,6 +433,36 @@ void put_dax(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(put_dax);
 
+void dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	if (!dax_alive(dax_dev))
+		return;
+
+	dax_dev->holder_data = holder;
+	dax_dev->holder_ops = ops;
+}
+EXPORT_SYMBOL_GPL(dax_register_holder);
+
+void dax_unregister_holder(struct dax_device *dax_dev)
+{
+	if (!dax_alive(dax_dev))
+		return;
+
+	dax_dev->holder_data = NULL;
+	dax_dev->holder_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(dax_unregister_holder);
+
+void *dax_get_holder(struct dax_device *dax_dev)
+{
+	if (!dax_alive(dax_dev))
+		return NULL;
+
+	return dax_dev->holder_data;
+}
+EXPORT_SYMBOL_GPL(dax_get_holder);
+
 /**
  * inode_dax: convert a public inode into its dax_dev
  * @inode: An inode with i_cdev pointing to a dax_dev
diff --git a/include/linux/dax.h b/include/linux/dax.h
index a146bfb80804..e16a9e0ee857 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -44,6 +44,22 @@ struct dax_operations {
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops,
 		unsigned long flags);
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
+void dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops);
+void dax_unregister_holder(struct dax_device *dax_dev);
+void *dax_get_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
@@ -71,6 +87,17 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 	return dax_synchronous(dax_dev);
 }
 #else
+static inline void dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+}
+static inline void dax_unregister_holder(struct dax_device *dax_dev)
+{
+}
+static inline void *dax_get_holder(struct dax_device *dax_dev)
+{
+	return NULL;
+}
 static inline struct dax_device *alloc_dax(void *private,
 		const struct dax_operations *ops, unsigned long flags)
 {
@@ -209,6 +236,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off, u64 len,
+		int mf_flags);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.34.1



