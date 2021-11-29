Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1283C46133D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376985AbhK2LLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377071AbhK2LJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:09:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F87C08E997;
        Mon, 29 Nov 2021 02:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ewhivocMaLSSfGhJIKXpP/saMql6MGncMo3j4U26KRM=; b=mzYkSW2CK5kKdEXeMQ3i7+RJHz
        t/MH4bCndPV2PniR9U6P93nzYpAZ6tzClXkw1GGlK55j/HZMIf8+Cr5++7s+aKZdEZwF6EJ8mkoGw
        QGprCqLRGCB8Rket9jXnMi7eyI9RcUj79k6IgDLH3KvoFii1H3JVg5Hw6hHnWBv0PP/WXztRI+Xax
        a7Vj1m02ap047/9mzpIdupEVJYQl/b0z38MmcFWP6qzHH4MbD11w0ZazlF/1Vl8BjK4IKNqD6PdWg
        bJ/s5g0HVvfEJoGffpk/IZSbQi/L44pdwg1PYrCXK0wNtv9d2jwuRgF7uy6VhKkj8sceQZMD4gTE/
        RkJrnWVQ==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdna-0073Lj-Pg; Mon, 29 Nov 2021 10:22:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 08/29] dax: remove dax_capable
Date:   Mon, 29 Nov 2021 11:21:42 +0100
Message-Id: <20211129102203.2243509-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just open code the block size and dax_dev == NULL checks in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com> [erofs]
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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
index f2cef47bdeafd..90b5733f5a709 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -107,42 +107,6 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
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
index aa173f5bdc3dd..e43096cfe9e22 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -806,12 +806,14 @@ void dm_table_set_type(struct dm_table *t, enum dm_queue_mode type)
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
+	DMDEBUG("%pg: error: dax unsupported by block device", dev->bdev);
+	return true;
 }
 
 /* Check devices support synchronous DAX */
@@ -821,8 +823,8 @@ static int device_not_dax_synchronous_capable(struct dm_target *ti, struct dm_de
 	return !dev->dax_dev || !dax_synchronous(dev->dax_dev);
 }
 
-bool dm_table_supports_dax(struct dm_table *t,
-			   iterate_devices_callout_fn iterate_fn, int *blocksize)
+static bool dm_table_supports_dax(struct dm_table *t,
+			   iterate_devices_callout_fn iterate_fn)
 {
 	struct dm_target *ti;
 	unsigned i;
@@ -835,7 +837,7 @@ bool dm_table_supports_dax(struct dm_table *t,
 			return false;
 
 		if (!ti->type->iterate_devices ||
-		    ti->type->iterate_devices(ti, iterate_fn, blocksize))
+		    ti->type->iterate_devices(ti, iterate_fn, NULL))
 			return false;
 	}
 
@@ -862,7 +864,6 @@ static int dm_table_determine_type(struct dm_table *t)
 	struct dm_target *tgt;
 	struct list_head *devices = dm_table_get_devices(t);
 	enum dm_queue_mode live_md_type = dm_get_md_type(t->md);
-	int page_size = PAGE_SIZE;
 
 	if (t->type != DM_TYPE_NONE) {
 		/* target already set the table's type */
@@ -906,7 +907,7 @@ static int dm_table_determine_type(struct dm_table *t)
 verify_bio_based:
 		/* We must use this table as bio-based */
 		t->type = DM_TYPE_BIO_BASED;
-		if (dm_table_supports_dax(t, device_not_dax_capable, &page_size) ||
+		if (dm_table_supports_dax(t, device_not_dax_capable) ||
 		    (list_empty(devices) && live_md_type == DM_TYPE_DAX_BIO_BASED)) {
 			t->type = DM_TYPE_DAX_BIO_BASED;
 		}
@@ -1976,7 +1977,6 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			      struct queue_limits *limits)
 {
 	bool wc = false, fua = false;
-	int page_size = PAGE_SIZE;
 	int r;
 
 	/*
@@ -2010,9 +2010,9 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
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
index a8c650276b321..4eba27e75c230 100644
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
@@ -3044,7 +3024,6 @@ static const struct block_device_operations dm_rq_blk_dops = {
 
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
index 1018f0d44acb8..4190c8c46ca88 100644
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
index 6a969b1e0ee6b..0aed886473c8d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -652,10 +652,13 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
index 4e33b5eca694d..fd3d68f10ee55 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4299,9 +4299,12 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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
index 875fd3151d6c9..c4297206f4834 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -331,28 +331,23 @@ xfs_set_inode_alloc(
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
 xfs_setup_dax_always(
 	struct xfs_mount	*mp)
 {
-	struct super_block	*sb = mp->m_super;
-
-	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
-	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
+	if (!mp->m_ddev_targp->bt_daxdev &&
+	    (!mp->m_rtdev_targp || !mp->m_rtdev_targp->bt_daxdev)) {
 		xfs_alert(mp,
 			"DAX unsupported by block device. Turning off DAX.");
 		goto disable_dax;
 	}
 
+	if (mp->m_super->s_blocksize != PAGE_SIZE) {
+		xfs_alert(mp,
+			"DAX not supported for blocksize. Turning off DAX.");
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

