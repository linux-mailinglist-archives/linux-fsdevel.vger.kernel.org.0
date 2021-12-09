Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69246E2A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 07:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhLIGmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 01:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhLIGmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:42:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC100C061746;
        Wed,  8 Dec 2021 22:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nn8GtjdHPWjHvtKLdFW4ACZFrY6mUDVYXTAF0BxnsTs=; b=ThgDj4pp/KlE8rWqzpXowxMZ3V
        3Qm82c+cErNZKwDP9XLj8woOONYTMUv4DfqbSSGYr7f8l0Wpaj/3tLDdf13p/mEdHAzechUvXsplR
        hw8qr54sdQ6QI6fbxGlVA1L67ovn5NSEMVbo84KuOloLDFe9uq6Mp+mpCkMdYxNBlH/lTYxiIzRt6
        kmOwrTNijtOJ9qp9eIhW0YoKiJ8LVxoyd+v3/aZkjiZjelsdfCJ0usIklRULGN+kThxBeC2cMtFHA
        wtXDI/iv6FrbYkpfDPU1wcVIS7KaGQVgjJj7KEeJAInef6XSEb8KV1XJy8asB4l/5wY0eSCjXYuEf
        LuLzfZOg==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvD4b-0096hm-Jx; Thu, 09 Dec 2021 06:38:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter methods
Date:   Thu,  9 Dec 2021 07:38:27 +0100
Message-Id: <20211209063828.18944-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063828.18944-1-hch@lst.de>
References: <20211209063828.18944-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These methods indirect the actual DAX read/write path.  In the end pmem
uses magic flush and mc safe variants and fuse and dcssblk use plain ones
while device mapper picks redirects to the underlying device.

Add set_dax_virtual() and set_dax_nomcsafe() APIs for fuse to skip these
special variants, then use them everywhere as they fall back to the plain
ones on s390 anyway and remove an indirect call from the read/write path
as well as a lot of boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c           | 36 ++++++++++++++--
 drivers/md/dm-linear.c        | 20 ---------
 drivers/md/dm-log-writes.c    | 80 -----------------------------------
 drivers/md/dm-stripe.c        | 20 ---------
 drivers/md/dm.c               | 50 ----------------------
 drivers/nvdimm/pmem.c         | 20 ---------
 drivers/s390/block/dcssblk.c  | 14 ------
 fs/dax.c                      |  5 ---
 fs/fuse/virtio_fs.c           | 19 +--------
 include/linux/dax.h           |  9 ++--
 include/linux/device-mapper.h |  4 --
 11 files changed, 37 insertions(+), 240 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e81d5ee57390f..ff676a07480c8 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -105,6 +105,10 @@ enum dax_device_flags {
 	DAXDEV_WRITE_CACHE,
 	/* flag to check if device supports synchronous flush */
 	DAXDEV_SYNC,
+	/* do not use uncached operations to write data */
+	DAXDEV_CACHED,
+	/* do not use mcsafe operations to read data */
+	DAXDEV_NOMCSAFE,
 };
 
 /**
@@ -146,9 +150,15 @@ size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 	if (!dax_alive(dax_dev))
 		return 0;
 
-	return dax_dev->ops->copy_from_iter(dax_dev, pgoff, addr, bytes, i);
+	/*
+	 * The userspace address for the memory copy has already been validated
+	 * via access_ok() in vfs_write, so use the 'no check' version to bypass
+	 * the HARDENED_USERCOPY overhead.
+	 */
+	if (test_bit(DAXDEV_CACHED, &dax_dev->flags))
+		return _copy_from_iter(addr, bytes, i);
+	return _copy_from_iter_flushcache(addr, bytes, i);
 }
-EXPORT_SYMBOL_GPL(dax_copy_from_iter);
 
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i)
@@ -156,9 +166,15 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 	if (!dax_alive(dax_dev))
 		return 0;
 
-	return dax_dev->ops->copy_to_iter(dax_dev, pgoff, addr, bytes, i);
+	/*
+	 * The userspace address for the memory copy has already been validated
+	 * via access_ok() in vfs_red, so use the 'no check' version to bypass
+	 * the HARDENED_USERCOPY overhead.
+	 */
+	if (test_bit(DAXDEV_NOMCSAFE, &dax_dev->flags))
+		return _copy_to_iter(addr, bytes, i);
+	return _copy_mc_to_iter(addr, bytes, i);
 }
-EXPORT_SYMBOL_GPL(dax_copy_to_iter);
 
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages)
@@ -220,6 +236,18 @@ void set_dax_synchronous(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(set_dax_synchronous);
 
+void set_dax_cached(struct dax_device *dax_dev)
+{
+	set_bit(DAXDEV_CACHED, &dax_dev->flags);
+}
+EXPORT_SYMBOL_GPL(set_dax_cached);
+
+void set_dax_nomcsafe(struct dax_device *dax_dev)
+{
+	set_bit(DAXDEV_NOMCSAFE, &dax_dev->flags);
+}
+EXPORT_SYMBOL_GPL(set_dax_nomcsafe);
+
 bool dax_alive(struct dax_device *dax_dev)
 {
 	lockdep_assert_held(&dax_srcu);
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 90de42f6743ac..1b97a11d71517 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -180,22 +180,6 @@ static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
 }
 
-static size_t linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
-{
-	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
-
-	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
-}
-
-static size_t linear_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
-{
-	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
-
-	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
-}
-
 static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 				      size_t nr_pages)
 {
@@ -206,8 +190,6 @@ static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 
 #else
 #define linear_dax_direct_access NULL
-#define linear_dax_copy_from_iter NULL
-#define linear_dax_copy_to_iter NULL
 #define linear_dax_zero_page_range NULL
 #endif
 
@@ -225,8 +207,6 @@ static struct target_type linear_target = {
 	.prepare_ioctl = linear_prepare_ioctl,
 	.iterate_devices = linear_iterate_devices,
 	.direct_access = linear_dax_direct_access,
-	.dax_copy_from_iter = linear_dax_copy_from_iter,
-	.dax_copy_to_iter = linear_dax_copy_to_iter,
 	.dax_zero_page_range = linear_dax_zero_page_range,
 };
 
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index cdb22e7a1d0da..139b09b06eda9 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -902,51 +902,6 @@ static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limit
 }
 
 #if IS_ENABLED(CONFIG_FS_DAX)
-static int log_dax(struct log_writes_c *lc, sector_t sector, size_t bytes,
-		   struct iov_iter *i)
-{
-	struct pending_block *block;
-
-	if (!bytes)
-		return 0;
-
-	block = kzalloc(sizeof(struct pending_block), GFP_KERNEL);
-	if (!block) {
-		DMERR("Error allocating dax pending block");
-		return -ENOMEM;
-	}
-
-	block->data = kzalloc(bytes, GFP_KERNEL);
-	if (!block->data) {
-		DMERR("Error allocating dax data space");
-		kfree(block);
-		return -ENOMEM;
-	}
-
-	/* write data provided via the iterator */
-	if (!copy_from_iter(block->data, bytes, i)) {
-		DMERR("Error copying dax data");
-		kfree(block->data);
-		kfree(block);
-		return -EIO;
-	}
-
-	/* rewind the iterator so that the block driver can use it */
-	iov_iter_revert(i, bytes);
-
-	block->datalen = bytes;
-	block->sector = bio_to_dev_sectors(lc, sector);
-	block->nr_sectors = ALIGN(bytes, lc->sectorsize) >> lc->sectorshift;
-
-	atomic_inc(&lc->pending_blocks);
-	spin_lock_irq(&lc->blocks_lock);
-	list_add_tail(&block->list, &lc->unflushed_blocks);
-	spin_unlock_irq(&lc->blocks_lock);
-	wake_up_process(lc->log_kthread);
-
-	return 0;
-}
-
 static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 		pgoff_t *pgoff)
 {
@@ -964,37 +919,6 @@ static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
 }
 
-static size_t log_writes_dax_copy_from_iter(struct dm_target *ti,
-					    pgoff_t pgoff, void *addr, size_t bytes,
-					    struct iov_iter *i)
-{
-	struct log_writes_c *lc = ti->private;
-	sector_t sector = pgoff * PAGE_SECTORS;
-	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
-	int err;
-
-	/* Don't bother doing anything if logging has been disabled */
-	if (!lc->logging_enabled)
-		goto dax_copy;
-
-	err = log_dax(lc, sector, bytes, i);
-	if (err) {
-		DMWARN("Error %d logging DAX write", err);
-		return 0;
-	}
-dax_copy:
-	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
-}
-
-static size_t log_writes_dax_copy_to_iter(struct dm_target *ti,
-					  pgoff_t pgoff, void *addr, size_t bytes,
-					  struct iov_iter *i)
-{
-	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
-
-	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
-}
-
 static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 					  size_t nr_pages)
 {
@@ -1005,8 +929,6 @@ static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 
 #else
 #define log_writes_dax_direct_access NULL
-#define log_writes_dax_copy_from_iter NULL
-#define log_writes_dax_copy_to_iter NULL
 #define log_writes_dax_zero_page_range NULL
 #endif
 
@@ -1024,8 +946,6 @@ static struct target_type log_writes_target = {
 	.iterate_devices = log_writes_iterate_devices,
 	.io_hints = log_writes_io_hints,
 	.direct_access = log_writes_dax_direct_access,
-	.dax_copy_from_iter = log_writes_dax_copy_from_iter,
-	.dax_copy_to_iter = log_writes_dax_copy_to_iter,
 	.dax_zero_page_range = log_writes_dax_zero_page_range,
 };
 
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 50dba3f39274c..e566115ec0bb8 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -324,22 +324,6 @@ static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
 }
 
-static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
-{
-	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
-
-	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
-}
-
-static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
-{
-	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
-
-	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
-}
-
 static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 				      size_t nr_pages)
 {
@@ -350,8 +334,6 @@ static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 
 #else
 #define stripe_dax_direct_access NULL
-#define stripe_dax_copy_from_iter NULL
-#define stripe_dax_copy_to_iter NULL
 #define stripe_dax_zero_page_range NULL
 #endif
 
@@ -488,8 +470,6 @@ static struct target_type stripe_target = {
 	.iterate_devices = stripe_iterate_devices,
 	.io_hints = stripe_io_hints,
 	.direct_access = stripe_dax_direct_access,
-	.dax_copy_from_iter = stripe_dax_copy_from_iter,
-	.dax_copy_to_iter = stripe_dax_copy_to_iter,
 	.dax_zero_page_range = stripe_dax_zero_page_range,
 };
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f4b972af10928..1b7e4ec9e2f57 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1027,54 +1027,6 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	return ret;
 }
 
-static size_t dm_dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-				    void *addr, size_t bytes, struct iov_iter *i)
-{
-	struct mapped_device *md = dax_get_private(dax_dev);
-	sector_t sector = pgoff * PAGE_SECTORS;
-	struct dm_target *ti;
-	long ret = 0;
-	int srcu_idx;
-
-	ti = dm_dax_get_live_target(md, sector, &srcu_idx);
-
-	if (!ti)
-		goto out;
-	if (!ti->type->dax_copy_from_iter) {
-		ret = copy_from_iter(addr, bytes, i);
-		goto out;
-	}
-	ret = ti->type->dax_copy_from_iter(ti, pgoff, addr, bytes, i);
- out:
-	dm_put_live_table(md, srcu_idx);
-
-	return ret;
-}
-
-static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
-{
-	struct mapped_device *md = dax_get_private(dax_dev);
-	sector_t sector = pgoff * PAGE_SECTORS;
-	struct dm_target *ti;
-	long ret = 0;
-	int srcu_idx;
-
-	ti = dm_dax_get_live_target(md, sector, &srcu_idx);
-
-	if (!ti)
-		goto out;
-	if (!ti->type->dax_copy_to_iter) {
-		ret = copy_to_iter(addr, bytes, i);
-		goto out;
-	}
-	ret = ti->type->dax_copy_to_iter(ti, pgoff, addr, bytes, i);
- out:
-	dm_put_live_table(md, srcu_idx);
-
-	return ret;
-}
-
 static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 				  size_t nr_pages)
 {
@@ -3024,8 +2976,6 @@ static const struct block_device_operations dm_rq_blk_dops = {
 
 static const struct dax_operations dm_dax_ops = {
 	.direct_access = dm_dax_direct_access,
-	.copy_from_iter = dm_dax_copy_from_iter,
-	.copy_to_iter = dm_dax_copy_to_iter,
 	.zero_page_range = dm_dax_zero_page_range,
 };
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 85b3339286bd8..b08f0642aa257 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -301,28 +301,8 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
 }
 
-/*
- * Use the 'no check' versions of _copy_from_iter_flushcache() and
- * _copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
- * checking, both file offset and device offset, is handled by
- * dax_iomap_actor()
- */
-static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
-{
-	return _copy_from_iter_flushcache(addr, bytes, i);
-}
-
-static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
-{
-	return _copy_mc_to_iter(addr, bytes, i);
-}
-
 static const struct dax_operations pmem_dax_ops = {
 	.direct_access = pmem_dax_direct_access,
-	.copy_from_iter = pmem_copy_from_iter,
-	.copy_to_iter = pmem_copy_to_iter,
 	.zero_page_range = pmem_dax_zero_page_range,
 };
 
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 10823debc09bd..d614843caf6cc 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -44,18 +44,6 @@ static const struct block_device_operations dcssblk_devops = {
 	.release 	= dcssblk_release,
 };
 
-static size_t dcssblk_dax_copy_from_iter(struct dax_device *dax_dev,
-		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
-{
-	return copy_from_iter(addr, bytes, i);
-}
-
-static size_t dcssblk_dax_copy_to_iter(struct dax_device *dax_dev,
-		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
-{
-	return copy_to_iter(addr, bytes, i);
-}
-
 static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
 				       pgoff_t pgoff, size_t nr_pages)
 {
@@ -72,8 +60,6 @@ static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
 
 static const struct dax_operations dcssblk_dax_ops = {
 	.direct_access = dcssblk_dax_direct_access,
-	.copy_from_iter = dcssblk_dax_copy_from_iter,
-	.copy_to_iter = dcssblk_dax_copy_to_iter,
 	.zero_page_range = dcssblk_dax_zero_page_range,
 };
 
diff --git a/fs/dax.c b/fs/dax.c
index e0eecd8e3a8f8..cd03485867a74 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1260,11 +1260,6 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (map_len > end - pos)
 			map_len = end - pos;
 
-		/*
-		 * The userspace address for the memory copy has already been
-		 * validated via access_ok() in either vfs_read() or
-		 * vfs_write(), depending on which operation we are doing.
-		 */
 		if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5c03a0364a9bb..754319ce2a29b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -753,20 +753,6 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
-static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
-				       pgoff_t pgoff, void *addr,
-				       size_t bytes, struct iov_iter *i)
-{
-	return copy_from_iter(addr, bytes, i);
-}
-
-static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
-				       pgoff_t pgoff, void *addr,
-				       size_t bytes, struct iov_iter *i)
-{
-	return copy_to_iter(addr, bytes, i);
-}
-
 static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
 				     pgoff_t pgoff, size_t nr_pages)
 {
@@ -783,8 +769,6 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
 
 static const struct dax_operations virtio_fs_dax_ops = {
 	.direct_access = virtio_fs_direct_access,
-	.copy_from_iter = virtio_fs_copy_from_iter,
-	.copy_to_iter = virtio_fs_copy_to_iter,
 	.zero_page_range = virtio_fs_zero_page_range,
 };
 
@@ -853,7 +837,8 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
 	if (IS_ERR(fs->dax_dev))
 		return PTR_ERR(fs->dax_dev);
-
+	set_dax_cached(fs->dax_dev);
+	set_dax_nomcsafe(fs->dax_dev);
 	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
 					fs->dax_dev);
 }
diff --git a/include/linux/dax.h b/include/linux/dax.h
index c04f46478e3b5..d22cbf03d37d2 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -28,12 +28,6 @@ struct dax_operations {
 	 */
 	bool (*dax_supported)(struct dax_device *, struct block_device *, int,
 			sector_t, sector_t);
-	/* copy_from_iter: required operation for fs-dax direct-i/o */
-	size_t (*copy_from_iter)(struct dax_device *, pgoff_t, void *, size_t,
-			struct iov_iter *);
-	/* copy_to_iter: required operation for fs-dax direct-i/o */
-	size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
-			struct iov_iter *);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
@@ -95,6 +89,9 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 }
 #endif
 
+void set_dax_cached(struct dax_device *dax_dev);
+void set_dax_nomcsafe(struct dax_device *dax_dev);
+
 struct writeback_control;
 #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index a7df155ea49b8..b26fecf6c8e87 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -147,8 +147,6 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn);
-typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
@@ -200,8 +198,6 @@ struct target_type {
 	dm_iterate_devices_fn iterate_devices;
 	dm_io_hints_fn io_hints;
 	dm_dax_direct_access_fn direct_access;
-	dm_dax_copy_iter_fn dax_copy_from_iter;
-	dm_dax_copy_iter_fn dax_copy_to_iter;
 	dm_dax_zero_page_range_fn dax_zero_page_range;
 
 	/* For internal device-mapper use. */
-- 
2.30.2

