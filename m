Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD6465FDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 09:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356241AbhLBIwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 03:52:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52057 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346026AbhLBIwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:52:34 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ATBct2q1aU1Lrz/O2GPbD5bhwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ1mh03mdRnWIaCz2HOPbfYGT9c9B/Otzn9UIOvsDczNE2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM+X9BDpC79SMljPvQHOKlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoe+ceCnm6ZL7I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr+K9wJq6TOd2j8guJcWtO5kQ0llsxDefD7A5QJTHQqzP/vdZ2?=
 =?us-ascii?q?is9goZFGvO2T8Ybdj1pYzzDbgdJN1NRD4gx9M+sh3/iY3hdrXqWu6M84C7U1gM?=
 =?us-ascii?q?Z+L7zPNvQf/SORN5JhQCcp2Tb7yL1Dw9yHN6WzzfD+XKxrujVlCj/VcQZE7jQ3?=
 =?us-ascii?q?vprhkCDg2IIBBAIWF+Tv/a0kAi9VshZJkhS/TAhxYA29Uq2Xpz+Uge+rXqsoBE?=
 =?us-ascii?q?RQZxTHvc85QXLzbDbiy6dB24ZXntRZscOqsA7X3op20WPktevAiZg2IB541r1G?=
 =?us-ascii?q?qy89Gv0YHZKazRZI3JscOfM2PG7yKlbs/4FZooL/HaJs+DI?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/AnR1awvMRzw7ij5VFnRKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="118319106"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Dec 2021 16:49:04 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B53974D13A1B;
        Thu,  2 Dec 2021 16:49:01 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Dec 2021 16:49:02 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Dec 2021 16:48:59 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 1/9] dax: Use percpu rwsem for dax_{read,write}_lock()
Date:   Thu, 2 Dec 2021 16:48:48 +0800
Message-ID: <20211202084856.1285285-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B53974D13A1B.A295C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to introduce dax holder registration, we need a write lock for
dax.  Change the current lock to percpu_rw_semaphore and introduce a
write lock for registration.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/device.c       | 11 +++++------
 drivers/dax/super.c        | 40 +++++++++++++++++++++++++-------------
 drivers/md/dm-writecache.c |  7 +++----
 fs/dax.c                   | 31 ++++++++++++++---------------
 fs/fuse/dax.c              |  6 +++---
 include/linux/dax.h        |  9 ++++-----
 6 files changed, 57 insertions(+), 47 deletions(-)

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
index e7152a6c4cc4..719e77b2c2d4 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -26,29 +26,39 @@ struct dax_device {
 	struct inode inode;
 	struct cdev cdev;
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
 static struct super_block *dax_superblock __read_mostly;
 
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
 #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 #include <linux/blkdev.h>
 
@@ -75,7 +85,7 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
 {
 	struct dax_device *dax_dev;
 	u64 part_size;
-	int id;
+	bool not_found;
 
 	if (!blk_queue_dax(bdev->bd_disk->queue))
 		return NULL;
@@ -87,11 +97,14 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
 		return NULL;
 	}
 
-	id = dax_read_lock();
 	dax_dev = xa_load(&dax_hosts, (unsigned long)bdev->bd_disk);
-	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
-		dax_dev = NULL;
-	dax_read_unlock(id);
+	if (dax_dev) {
+		dax_read_lock(dax_dev);
+		not_found = !dax_alive(dax_dev) || !igrab(&dax_dev->inode);
+		dax_read_unlock(dax_dev);
+		if (not_found)
+			dax_dev = NULL;
+	}
 
 	return dax_dev;
 }
@@ -222,7 +235,7 @@ EXPORT_SYMBOL_GPL(__set_dax_synchronous);
 
 bool dax_alive(struct dax_device *dax_dev)
 {
-	lockdep_assert_held(&dax_srcu);
+	lockdep_assert_held(&dax_dev->rwsem);
 	return test_bit(DAXDEV_ALIVE, &dax_dev->flags);
 }
 EXPORT_SYMBOL_GPL(dax_alive);
@@ -237,9 +250,9 @@ void kill_dax(struct dax_device *dax_dev)
 {
 	if (!dax_dev)
 		return;
-
+	dax_write_lock(dax_dev);
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
-	synchronize_srcu(&dax_srcu);
+	dax_write_unlock(dax_dev);
 }
 EXPORT_SYMBOL_GPL(kill_dax);
 
@@ -366,6 +379,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops,
 
 	dax_dev->ops = ops;
 	dax_dev->private = private;
+	percpu_init_rwsem(&dax_dev->rwsem);
 	if (flags & DAXDEV_F_SYNC)
 		set_dax_synchronous(dax_dev);
 
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 4f31591d2d25..ebe1ec345d1d 100644
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
index e0eecd8e3a8f..1f46810d4b68 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -717,20 +717,20 @@ static pgoff_t dax_iomap_pgoff(const struct iomap *iomap, loff_t pos)
 static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(&iter->iomap, iter->pos);
+	struct dax_device *dax_dev = iter->iomap.dax_dev;
 	void *vto, *kaddr;
 	long rc;
-	int id;
 
-	id = dax_read_lock();
-	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
+	dax_read_lock(dax_dev);
+	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
-		dax_read_unlock(id);
+		dax_read_unlock(dax_dev);
 		return rc;
 	}
 	vto = kmap_atomic(vmf->cow_page);
 	copy_user_page(vto, kaddr, vmf->address, vmf->cow_page);
 	kunmap_atomic(vto);
-	dax_read_unlock(id);
+	dax_read_unlock(dax_dev);
 	return 0;
 }
 
@@ -1009,10 +1009,10 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 			 pfn_t *pfnp)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
-	int id, rc;
+	int rc;
 	long length;
 
-	id = dax_read_lock();
+	dax_read_lock(iomap->dax_dev);
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
 				   NULL, pfnp);
 	if (length < 0) {
@@ -1029,7 +1029,7 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 		goto out;
 	rc = 0;
 out:
-	dax_read_unlock(id);
+	dax_read_unlock(iomap->dax_dev);
 	return rc;
 }
 
@@ -1135,6 +1135,7 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
 	const struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	struct dax_device *dax_dev = iomap->dax_dev;
 	loff_t pos = iter->pos;
 	u64 length = iomap_length(iter);
 	s64 written = 0;
@@ -1148,14 +1149,13 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
 		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 		long rc;
-		int id;
 
-		id = dax_read_lock();
+		dax_read_lock(dax_dev);
 		if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
-			rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
+			rc = dax_zero_page_range(dax_dev, pgoff, 1);
 		else
-			rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
-		dax_read_unlock(id);
+			rc = dax_memzero(dax_dev, pgoff, offset, size);
+		dax_read_unlock(dax_dev);
 
 		if (rc < 0)
 			return rc;
@@ -1209,7 +1209,6 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	loff_t end = pos + length, done = 0;
 	ssize_t ret = 0;
 	size_t xfer;
-	int id;
 
 	if (iov_iter_rw(iter) == READ) {
 		end = min(end, i_size_read(iomi->inode));
@@ -1234,7 +1233,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 					      (end - 1) >> PAGE_SHIFT);
 	}
 
-	id = dax_read_lock();
+	dax_read_lock(dax_dev);
 	while (pos < end) {
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
@@ -1281,7 +1280,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (xfer < map_len)
 			break;
 	}
-	dax_read_unlock(id);
+	dax_read_unlock(dax_dev);
 
 	return done ? done : ret;
 }
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 713818d74de6..00a419acab79 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1231,7 +1231,7 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 {
 	long nr_pages, nr_ranges;
 	struct fuse_dax_mapping *range;
-	int ret, id;
+	int ret;
 	size_t dax_size = -1;
 	unsigned long i;
 
@@ -1240,10 +1240,10 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 	INIT_LIST_HEAD(&fcd->busy_ranges);
 	INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
 
-	id = dax_read_lock();
+	dax_read_lock(fcd->dev);
 	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
 				     NULL);
-	dax_read_unlock(id);
+	dax_read_unlock(fcd->dev);
 	if (nr_pages < 0) {
 		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
 		return nr_pages;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 87ae4c9b1d65..8414a08dcbea 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -178,15 +178,14 @@ int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
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
2.34.0



