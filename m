Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C31430F2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 06:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhJREnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 00:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhJREng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:43:36 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E69EC06161C;
        Sun, 17 Oct 2021 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OefCJeKZRwNOQJyWwjpa25k0EXB7cz0zeM7/yCP728c=; b=lF2B+B0FkeVgvyZq3xHAoj6+vI
        0+7zSn1861uqGFT8qjvOUw/zTRd/ZnTY8ISTCGleY1f2+RIjpCOb2Ds3xY4G9ZAC8vaTYHA8zu5lm
        dYOspE9haamzAEsdGJhQwCkzxf/jdCackn+hNrH8pF/T1hAOZW/4B7cwo14sJl7IhDOQmIPxWKvwu
        54kSk2Q/yJEWX2coBvpTdAYjlAuX7qnsMOli2l4YuSQodL/FbJuVY5HFPL1tX6ogRyOyL/V7Z691h
        sQ1yKc+EoUjoaATdVlSnlsWH/+6zCCvxif8doSGMEGV+wrohv1Poem2ttMtNqVNuA9vPwmyDnstiC
        cih9O2nQ==;
Received: from 089144211028.atnat0020.highway.a1.net ([89.144.211.28] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcKSc-00E3MD-Pj; Mon, 18 Oct 2021 04:41:19 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 07/11] dax: remove dax_capable
Date:   Mon, 18 Oct 2021 06:40:50 +0200
Message-Id: <20211018044054.1779424-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
References: <20211018044054.1779424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just open code the block size and dax_dev == NULL checks in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c          | 36 ------------------------------------
 drivers/md/dm-table.c        | 22 +++++++++++-----------
 drivers/md/dm.c              | 21 ---------------------
 drivers/md/dm.h              |  4 ----
 drivers/nvdimm/pmem.c        |  1 -
 drivers/s390/block/dcssblk.c |  1 -
 fs/erofs/super.c             | 11 +++++++----
 fs/ext2/super.c              |  6 ++++--
 fs/ext4/super.c              |  9 ++++++---
 fs/xfs/xfs_super.c           | 21 ++++++++-------------
 include/linux/dax.h          | 14 --------------
 11 files changed, 36 insertions(+), 110 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 482fe775324a4..803942586d1b6 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -108,42 +108,6 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 	return dax_dev;
 }
 EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
-
-bool generic_fsdax_supported(struct dax_device *dax_dev,
-		struct block_device *bdev, int blocksize, sector_t start,
-		sector_t sectors)
-{
-	if (blocksize != PAGE_SIZE) {
-		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
-		return false;
-	}
-
-	if (!dax_dev) {
-		pr_debug("%pg: error: dax unsupported by block device\n", bdev);
-		return false;
-	}
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(generic_fsdax_supported);
-
-bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len)
-{
-	bool ret = false;
-	int id;
-
-	if (!dax_dev)
-		return false;
-
-	id = dax_read_lock();
-	if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
-		ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
-						  start, len);
-	dax_read_unlock(id);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dax_supported);
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
 enum dax_device_flags {
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 1fa4d5582dca5..4ae671c2168ea 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -807,12 +807,14 @@ void dm_table_set_type(struct dm_table *t, enum dm_queue_mode type)
 EXPORT_SYMBOL_GPL(dm_table_set_type);
 
 /* validate the dax capability of the target device span */
-int device_not_dax_capable(struct dm_target *ti, struct dm_dev *dev,
+static int device_not_dax_capable(struct dm_target *ti, struct dm_dev *dev,
 			sector_t start, sector_t len, void *data)
 {
-	int blocksize = *(int *) data;
+	if (dev->dax_dev)
+		return false;
 
-	return !dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
+	pr_debug("%pg: error: dax unsupported by block device\n", dev->bdev);
+	return true;
 }
 
 /* Check devices support synchronous DAX */
@@ -822,8 +824,8 @@ static int device_not_dax_synchronous_capable(struct dm_target *ti, struct dm_de
 	return !dev->dax_dev || !dax_synchronous(dev->dax_dev);
 }
 
-bool dm_table_supports_dax(struct dm_table *t,
-			   iterate_devices_callout_fn iterate_fn, int *blocksize)
+static bool dm_table_supports_dax(struct dm_table *t,
+			   iterate_devices_callout_fn iterate_fn)
 {
 	struct dm_target *ti;
 	unsigned i;
@@ -836,7 +838,7 @@ bool dm_table_supports_dax(struct dm_table *t,
 			return false;
 
 		if (!ti->type->iterate_devices ||
-		    ti->type->iterate_devices(ti, iterate_fn, blocksize))
+		    ti->type->iterate_devices(ti, iterate_fn, NULL))
 			return false;
 	}
 
@@ -863,7 +865,6 @@ static int dm_table_determine_type(struct dm_table *t)
 	struct dm_target *tgt;
 	struct list_head *devices = dm_table_get_devices(t);
 	enum dm_queue_mode live_md_type = dm_get_md_type(t->md);
-	int page_size = PAGE_SIZE;
 
 	if (t->type != DM_TYPE_NONE) {
 		/* target already set the table's type */
@@ -907,7 +908,7 @@ static int dm_table_determine_type(struct dm_table *t)
 verify_bio_based:
 		/* We must use this table as bio-based */
 		t->type = DM_TYPE_BIO_BASED;
-		if (dm_table_supports_dax(t, device_not_dax_capable, &page_size) ||
+		if (dm_table_supports_dax(t, device_not_dax_capable) ||
 		    (list_empty(devices) && live_md_type == DM_TYPE_DAX_BIO_BASED)) {
 			t->type = DM_TYPE_DAX_BIO_BASED;
 		}
@@ -1981,7 +1982,6 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			      struct queue_limits *limits)
 {
 	bool wc = false, fua = false;
-	int page_size = PAGE_SIZE;
 	int r;
 
 	/*
@@ -2015,9 +2015,9 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	}
 	blk_queue_write_cache(q, wc, fua);
 
-	if (dm_table_supports_dax(t, device_not_dax_capable, &page_size)) {
+	if (dm_table_supports_dax(t, device_not_dax_capable)) {
 		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
-		if (dm_table_supports_dax(t, device_not_dax_synchronous_capable, NULL))
+		if (dm_table_supports_dax(t, device_not_dax_synchronous_capable))
 			set_dax_synchronous(t->md->dax_dev);
 	}
 	else
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a0a4703620650..f896ad29a67a7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1027,26 +1027,6 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	return ret;
 }
 
-static bool dm_dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len)
-{
-	struct mapped_device *md = dax_get_private(dax_dev);
-	struct dm_table *map;
-	bool ret = false;
-	int srcu_idx;
-
-	map = dm_get_live_table(md, &srcu_idx);
-	if (!map)
-		goto out;
-
-	ret = dm_table_supports_dax(map, device_not_dax_capable, &blocksize);
-
-out:
-	dm_put_live_table(md, srcu_idx);
-
-	return ret;
-}
-
 static size_t dm_dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 				    void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -3050,7 +3030,6 @@ static const struct block_device_operations dm_rq_blk_dops = {
 
 static const struct dax_operations dm_dax_ops = {
 	.direct_access = dm_dax_direct_access,
-	.dax_supported = dm_dax_supported,
 	.copy_from_iter = dm_dax_copy_from_iter,
 	.copy_to_iter = dm_dax_copy_to_iter,
 	.zero_page_range = dm_dax_zero_page_range,
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 742d9c80efe19..9013dc1a7b002 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -73,10 +73,6 @@ bool dm_table_bio_based(struct dm_table *t);
 bool dm_table_request_based(struct dm_table *t);
 void dm_table_free_md_mempools(struct dm_table *t);
 struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t);
-bool dm_table_supports_dax(struct dm_table *t, iterate_devices_callout_fn fn,
-			   int *blocksize);
-int device_not_dax_capable(struct dm_target *ti, struct dm_dev *dev,
-			   sector_t start, sector_t len, void *data);
 
 void dm_lock_md_type(struct mapped_device *md);
 void dm_unlock_md_type(struct mapped_device *md);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 5628afb808f41..428a485800058 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -321,7 +321,6 @@ static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 
 static const struct dax_operations pmem_dax_ops = {
 	.direct_access = pmem_dax_direct_access,
-	.dax_supported = generic_fsdax_supported,
 	.copy_from_iter = pmem_copy_from_iter,
 	.copy_to_iter = pmem_copy_to_iter,
 	.zero_page_range = pmem_dax_zero_page_range,
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 657e492f2bc26..e65e83764d1ce 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -72,7 +72,6 @@ static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
 
 static const struct dax_operations dcssblk_dax_ops = {
 	.direct_access = dcssblk_dax_direct_access,
-	.dax_supported = generic_fsdax_supported,
 	.copy_from_iter = dcssblk_dax_copy_from_iter,
 	.copy_to_iter = dcssblk_dax_copy_to_iter,
 	.zero_page_range = dcssblk_dax_zero_page_range,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b8f042c3e7e67..530d7b1e0f138 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -649,10 +649,13 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	if (test_opt(&sbi->opt, DAX_ALWAYS) &&
-	    !dax_supported(sbi->dax_dev, sb->s_bdev, EROFS_BLKSIZ, 0, bdev_nr_sectors(sb->s_bdev))) {
-		errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
-		clear_opt(&sbi->opt, DAX_ALWAYS);
+	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
+		BUILD_BUG_ON(EROFS_BLKSIZ != PAGE_SIZE);
+
+		if (!sbi->dax_dev) {
+			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
+			clear_opt(&sbi->opt, DAX_ALWAYS);
+		}
 	}
 	sb->s_flags |= SB_RDONLY | SB_NOATIME;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index d8d580b609baa..a964066a80aa7 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -946,11 +946,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (test_opt(sb, DAX)) {
-		if (!dax_supported(dax_dev, sb->s_bdev, blocksize, 0,
-				bdev_nr_sectors(sb->s_bdev))) {
+		if (!dax_dev) {
 			ext2_msg(sb, KERN_ERR,
 				"DAX unsupported by block device. Turning off DAX.");
 			clear_opt(sbi->s_mount_opt, DAX);
+		} else if (blocksize != PAGE_SIZE) {
+			ext2_msg(sb, KERN_ERR, "unsupported blocksize for DAX\n");
+			clear_opt(sbi->s_mount_opt, DAX);
 		}
 	}
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6361ea1f97bc5..f571be3a6252b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4291,9 +4291,12 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
-	if (dax_supported(dax_dev, sb->s_bdev, blocksize, 0,
-			bdev_nr_sectors(sb->s_bdev)))
-		set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
+	if (dax_dev) {
+		if (blocksize == PAGE_SIZE)
+			set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
+		else
+			ext4_msg(sb, KERN_ERR, "unsupported blocksize for DAX\n");
+	}
 
 	if (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) {
 		if (ext4_has_feature_inline_data(sb)) {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d07020a8eb9e3..163ceafbd8fd2 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -330,28 +330,23 @@ xfs_set_inode_alloc(
 	return xfs_is_inode32(mp) ? maxagi : agcount;
 }
 
-static bool
-xfs_buftarg_is_dax(
-	struct super_block	*sb,
-	struct xfs_buftarg	*bt)
-{
-	return dax_supported(bt->bt_daxdev, bt->bt_bdev, sb->s_blocksize, 0,
-			bdev_nr_sectors(bt->bt_bdev));
-}
-
 static int
 xfs_setup_dax(
 	struct xfs_mount	*mp)
 {
-	struct super_block	*sb = mp->m_super;
-
-	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
-	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
+	if (!mp->m_ddev_targp->bt_daxdev &&
+	   (!mp->m_rtdev_targp || !mp->m_rtdev_targp->bt_daxdev)) {
 		xfs_alert(mp,
 			"DAX unsupported by block device. Turning off DAX.");
 		goto disable_dax;
 	}
 
+	if (mp->m_super->s_blocksize != PAGE_SIZE) {
+		xfs_alert(mp,
+			"DAX not supported for blocksize. Turning off DAX.\n");
+		goto disable_dax;
+	}
+
 	if (xfs_has_reflink(mp)) {
 		xfs_alert(mp, "DAX and reflink cannot be used together!");
 		return -EINVAL;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index e2e9a67004cbd..439c3c70e347b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -111,12 +111,6 @@ int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
 int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
 void dax_remove_host(struct gendisk *disk);
-bool generic_fsdax_supported(struct dax_device *dax_dev,
-		struct block_device *bdev, int blocksize, sector_t start,
-		sector_t sectors);
-
-bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len);
 
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
@@ -139,14 +133,6 @@ static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 static inline void dax_remove_host(struct gendisk *disk)
 {
 }
-#define generic_fsdax_supported		NULL
-
-static inline bool dax_supported(struct dax_device *dax_dev,
-		struct block_device *bdev, int blocksize, sector_t start,
-		sector_t len)
-{
-	return false;
-}
 
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
-- 
2.30.2

