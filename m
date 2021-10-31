Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A041B440EFE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 16:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJaPXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 11:23:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24352 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230061AbhJaPXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:23:22 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AGtAvgapJYL1SBsc7s+JmD2wHDyZeBmJzZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmEYX2qPM/+LZjH9edF/b4ri9UtV7ZfVn4UxSVNrrCsyQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?cYXkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXNkRKZIiWzqxlpJARsVWECwc57CH9?=
 =?us-ascii?q?P+dQWMjcIaQqJhv7wy7W+IsFsjcQLLc/lJooTt3hsizbDAp4OTZnFBaeM+t5c2?=
 =?us-ascii?q?DY5g9tmHPDCas5fYj1qBDzMYQJIPFg/C58kmuqswH7lfFVwrFOTuLpy5m37zxJ?=
 =?us-ascii?q?427urN8DaEvSMW8lUm0OwomPd43+/BhAcKczZxTebmlquj+nC2yj7RaoVDrSz8?=
 =?us-ascii?q?vMsi1qWrkQXCRsLRR61uvW0lEO6c8xQJlZS+Sc0q6U2skuxQbHVWxy+vW7BvRM?=
 =?us-ascii?q?GXddUO/M15RvLyafO5QudQG8eQVZpbN0gqd9zVTIx/kGGksmvBjF1trCRD3WH+?=
 =?us-ascii?q?d+pQZmaUcQOBTZaI3ZaEk1euJ++yLzfRynnFr5LeJNZRPWucd0o/w23kQ=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AFayfKq0ggKKafmIM/jJqjgqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.87,197,1631548800"; 
   d="scan'208";a="116677967"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Oct 2021 23:20:47 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 61DD94D0DC6D;
        Sun, 31 Oct 2021 23:20:41 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:20:34 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 31 Oct 2021 23:20:34 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 1/8] dax: Use percpu rwsem for dax_{read,write}_lock()
Date:   Sun, 31 Oct 2021 23:20:21 +0800
Message-ID: <20211031152028.3724121-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
References: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 61DD94D0DC6D.A2E07
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to introduce dax holder registration, we need a write lock for
dax.  Change the current lock to percpu_rw_semaphore and introduce a
dax write lock for registration.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/device.c       | 11 ++++----
 drivers/dax/super.c        | 51 +++++++++++++++++++++++---------------
 drivers/md/dm-writecache.c |  7 +++---
 fs/dax.c                   | 26 +++++++++----------
 include/linux/dax.h        |  9 +++----
 5 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index dd8222a42808..041345f9956d 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -198,7 +198,6 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 	struct file *filp = vmf->vma->vm_file;
 	unsigned long fault_size;
 	vm_fault_t rc = VM_FAULT_SIGBUS;
-	int id;
 	pfn_t pfn;
 	struct dev_dax *dev_dax = filp->private_data;
 
@@ -206,7 +205,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 			(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
 			vmf->vma->vm_start, vmf->vma->vm_end, pe_size);
 
-	id = dax_read_lock();
+	dax_read_lock(dev_dax->dax_dev);
 	switch (pe_size) {
 	case PE_SIZE_PTE:
 		fault_size = PAGE_SIZE;
@@ -246,7 +245,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 			page->index = pgoff + i;
 		}
 	}
-	dax_read_unlock(id);
+	dax_read_unlock(dev_dax->dax_dev);
 
 	return rc;
 }
@@ -284,7 +283,7 @@ static const struct vm_operations_struct dax_vm_ops = {
 static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct dev_dax *dev_dax = filp->private_data;
-	int rc, id;
+	int rc;
 
 	dev_dbg(&dev_dax->dev, "trace\n");
 
@@ -292,9 +291,9 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * We lock to check dax_dev liveness and will re-check at
 	 * fault time.
 	 */
-	id = dax_read_lock();
+	dax_read_lock(dev_dax->dax_dev);
 	rc = check_vma(dev_dax, vma, __func__);
-	dax_read_unlock(id);
+	dax_read_unlock(dev_dax->dax_dev);
 	if (rc)
 		return rc;
 
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index fc89e91beea7..f7701e943019 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -31,12 +31,12 @@ struct dax_device {
 	struct cdev cdev;
 	const char *host;
 	void *private;
+	struct percpu_rw_semaphore rwsem;
 	unsigned long flags;
 	const struct dax_operations *ops;
 };
 
 static dev_t dax_devt;
-DEFINE_STATIC_SRCU(dax_srcu);
 static struct vfsmount *dax_mnt;
 static DEFINE_IDA(dax_minor_ida);
 static struct kmem_cache *dax_cache __read_mostly;
@@ -46,18 +46,28 @@ static struct super_block *dax_superblock __read_mostly;
 static struct hlist_head dax_host_list[DAX_HASH_SIZE];
 static DEFINE_SPINLOCK(dax_host_lock);
 
-int dax_read_lock(void)
+void dax_read_lock(struct dax_device *dax_dev)
 {
-	return srcu_read_lock(&dax_srcu);
+	percpu_down_read(&dax_dev->rwsem);
 }
 EXPORT_SYMBOL_GPL(dax_read_lock);
 
-void dax_read_unlock(int id)
+void dax_read_unlock(struct dax_device *dax_dev)
 {
-	srcu_read_unlock(&dax_srcu, id);
+	percpu_up_read(&dax_dev->rwsem);
 }
 EXPORT_SYMBOL_GPL(dax_read_unlock);
 
+void dax_write_lock(struct dax_device *dax_dev)
+{
+	percpu_down_write(&dax_dev->rwsem);
+}
+
+void dax_write_unlock(struct dax_device *dax_dev)
+{
+	percpu_up_write(&dax_dev->rwsem);
+}
+
 static int dax_host_hash(const char *host)
 {
 	return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
@@ -70,26 +80,28 @@ static int dax_host_hash(const char *host)
 static struct dax_device *dax_get_by_host(const char *host)
 {
 	struct dax_device *dax_dev, *found = NULL;
-	int hash, id;
+	int hash;
 
 	if (!host)
 		return NULL;
 
 	hash = dax_host_hash(host);
 
-	id = dax_read_lock();
 	spin_lock(&dax_host_lock);
 	hlist_for_each_entry(dax_dev, &dax_host_list[hash], list) {
+		dax_read_lock(dax_dev);
 		if (!dax_alive(dax_dev)
-				|| strcmp(host, dax_dev->host) != 0)
+				|| strcmp(host, dax_dev->host) != 0) {
+			dax_read_unlock(dax_dev);
 			continue;
+		}
 
 		if (igrab(&dax_dev->inode))
 			found = dax_dev;
+		dax_read_unlock(dax_dev);
 		break;
 	}
 	spin_unlock(&dax_host_lock);
-	dax_read_unlock(id);
 
 	return found;
 }
@@ -130,7 +142,7 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
 	pfn_t pfn, end_pfn;
 	sector_t last_page;
 	long len, len2;
-	int err, id;
+	int err;
 
 	if (blocksize != PAGE_SIZE) {
 		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
@@ -155,14 +167,14 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
 		return false;
 	}
 
-	id = dax_read_lock();
+	dax_read_lock(dax_dev);
 	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
 	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
 
 	if (len < 1 || len2 < 1) {
 		pr_info("%pg: error: dax access failed (%ld)\n",
 				bdev, len < 1 ? len : len2);
-		dax_read_unlock(id);
+		dax_read_unlock(dax_dev);
 		return false;
 	}
 
@@ -192,7 +204,7 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
 		put_dev_pagemap(end_pgmap);
 
 	}
-	dax_read_unlock(id);
+	dax_read_unlock(dax_dev);
 
 	if (!dax_enabled) {
 		pr_info("%pg: error: dax support not enabled\n", bdev);
@@ -206,16 +218,15 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
 		int blocksize, sector_t start, sector_t len)
 {
 	bool ret = false;
-	int id;
 
 	if (!dax_dev)
 		return false;
 
-	id = dax_read_lock();
+	dax_read_lock(dax_dev);
 	if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
 		ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
 						  start, len);
-	dax_read_unlock(id);
+	dax_read_unlock(dax_dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dax_supported);
@@ -410,7 +421,7 @@ EXPORT_SYMBOL_GPL(__set_dax_synchronous);
 
 bool dax_alive(struct dax_device *dax_dev)
 {
-	lockdep_assert_held(&dax_srcu);
+	lockdep_assert_held(&dax_dev->rwsem);
 	return test_bit(DAXDEV_ALIVE, &dax_dev->flags);
 }
 EXPORT_SYMBOL_GPL(dax_alive);
@@ -425,10 +436,9 @@ void kill_dax(struct dax_device *dax_dev)
 {
 	if (!dax_dev)
 		return;
-
+	dax_write_lock(dax_dev);
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
-
-	synchronize_srcu(&dax_srcu);
+	dax_write_unlock(dax_dev);
 
 	spin_lock(&dax_host_lock);
 	hlist_del_init(&dax_dev->list);
@@ -590,6 +600,7 @@ struct dax_device *alloc_dax(void *private, const char *__host,
 	dax_add_host(dax_dev, host);
 	dax_dev->ops = ops;
 	dax_dev->private = private;
+	percpu_init_rwsem(&dax_dev->rwsem);
 	if (flags & DAXDEV_F_SYNC)
 		set_dax_synchronous(dax_dev);
 
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 18320444fb0a..abce88bf1b24 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -260,7 +260,6 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 	loff_t s;
 	long p, da;
 	pfn_t pfn;
-	int id;
 	struct page **pages;
 	sector_t offset;
 
@@ -284,7 +283,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 	}
 	offset >>= PAGE_SHIFT - 9;
 
-	id = dax_read_lock();
+	dax_read_lock(wc->ssd_dev->dax_dev);
 
 	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
 	if (da < 0) {
@@ -334,7 +333,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		wc->memory_vmapped = true;
 	}
 
-	dax_read_unlock(id);
+	dax_read_unlock(wc->ssd_dev->dax_dev);
 
 	wc->memory_map += (size_t)wc->start_sector << SECTOR_SHIFT;
 	wc->memory_map_size -= (size_t)wc->start_sector << SECTOR_SHIFT;
@@ -343,7 +342,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 err3:
 	kvfree(pages);
 err2:
-	dax_read_unlock(id);
+	dax_read_unlock(wc->ssd_dev->dax_dev);
 err1:
 	return r;
 }
diff --git a/fs/dax.c b/fs/dax.c
index 4e3e5a283a91..a06cbb950950 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -715,22 +715,21 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
 	void *vto, *kaddr;
 	pgoff_t pgoff;
 	long rc;
-	int id;
 
 	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
 	if (rc)
 		return rc;
 
-	id = dax_read_lock();
+	dax_read_lock(dax_dev);
 	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
-		dax_read_unlock(id);
+		dax_read_unlock(dax_dev);
 		return rc;
 	}
 	vto = kmap_atomic(to);
 	copy_user_page(vto, (void __force *)kaddr, vaddr, to);
 	kunmap_atomic(vto);
-	dax_read_unlock(id);
+	dax_read_unlock(dax_dev);
 	return 0;
 }
 
@@ -1015,13 +1014,13 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
-	int id, rc;
+	int rc;
 	long length;
 
 	rc = bdev_dax_pgoff(iomap->bdev, sector, size, &pgoff);
 	if (rc)
 		return rc;
-	id = dax_read_lock();
+	dax_read_lock(iomap->dax_dev);
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
 				   NULL, pfnp);
 	if (length < 0) {
@@ -1038,7 +1037,7 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 		goto out;
 	rc = 0;
 out:
-	dax_read_unlock(id);
+	dax_read_unlock(iomap->dax_dev);
 	return rc;
 }
 
@@ -1130,7 +1129,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
-	long rc, id;
+	long rc;
 	void *kaddr;
 	bool page_aligned = false;
 	unsigned offset = offset_in_page(pos);
@@ -1144,14 +1143,14 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 	if (rc)
 		return rc;
 
-	id = dax_read_lock();
+	dax_read_lock(iomap->dax_dev);
 
 	if (page_aligned)
 		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 	else
 		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
-		dax_read_unlock(id);
+		dax_read_unlock(iomap->dax_dev);
 		return rc;
 	}
 
@@ -1159,7 +1158,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 		memset(kaddr + offset, 0, size);
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	}
-	dax_read_unlock(id);
+	dax_read_unlock(iomap->dax_dev);
 	return size;
 }
 
@@ -1174,7 +1173,6 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	loff_t end = pos + length, done = 0;
 	ssize_t ret = 0;
 	size_t xfer;
-	int id;
 
 	if (iov_iter_rw(iter) == READ) {
 		end = min(end, i_size_read(iomi->inode));
@@ -1199,7 +1197,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 					      (end - 1) >> PAGE_SHIFT);
 	}
 
-	id = dax_read_lock();
+	dax_read_lock(dax_dev);
 	while (pos < end) {
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
@@ -1251,7 +1249,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (xfer < map_len)
 			break;
 	}
-	dax_read_unlock(id);
+	dax_read_unlock(dax_dev);
 
 	return done ? done : ret;
 }
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2619d94c308d..e38711d6c519 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -177,15 +177,14 @@ static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
 #endif
 
 #if IS_ENABLED(CONFIG_DAX)
-int dax_read_lock(void);
-void dax_read_unlock(int id);
+void dax_read_lock(struct dax_device *dax_dev);
+void dax_read_unlock(struct dax_device *dax_dev);
 #else
-static inline int dax_read_lock(void)
+static inline void dax_read_lock(struct dax_device *dax_dev)
 {
-	return 0;
 }
 
-static inline void dax_read_unlock(int id)
+static inline void dax_read_unlock(struct dax_device *dax_dev)
 {
 }
 #endif /* CONFIG_DAX */
-- 
2.33.0



