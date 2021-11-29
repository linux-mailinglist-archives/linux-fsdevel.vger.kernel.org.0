Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA886461391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377306AbhK2LND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhK2LLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:11:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49229C0613B4;
        Mon, 29 Nov 2021 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mfRFhwIhVg2zPZROlsUurf8sjhIS8PFnhvuo/zgvKNc=; b=flj0yeai0nDNXu5WeUXJTEwJgU
        Il/4BTSdXvm2VwvMTB+FDRD1ZCpxX17CRtgL3/YX/0U5yT/hac+mk/GIdT4U/SqlnDqo8GJ/6YhpV
        tqgpqNpo03WPlDirevdh8jsIzKYPh1fDIUU5M5avRn1ATfRzgZ7JOcxcEfVjXzJuPrVZQtW1CI3Fh
        S+bZulnZXwicPa7JM/UstE1SAApWMbIBCpe9VnCH25Kp82B6h8VYSvdo8ETJLFuhpPHrAdAYQDdPY
        jcl1r3gXd0PYvb6qu2ltCrCLSiq+wrV00moHXDAeG11GX8x5LURk6LutZj1he4AS5UCKB56TnH9rl
        vEIw79Ew==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdny-0073Wt-FD; Mon, 29 Nov 2021 10:22:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 25/29] dax: return the partition offset from fs_dax_get_by_bdev
Date:   Mon, 29 Nov 2021 11:21:59 +0100
Message-Id: <20211129102203.2243509-26-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prepare for the removal of the block_device from the DAX I/O path by
returning the partition offset from fs_dax_get_by_bdev so that the file
systems have it at hand for use during I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/super.c | 9 ++++++---
 drivers/md/dm.c     | 4 ++--
 fs/erofs/internal.h | 2 ++
 fs/erofs/super.c    | 4 ++--
 fs/ext2/ext2.h      | 1 +
 fs/ext2/super.c     | 2 +-
 fs/ext4/ext4.h      | 1 +
 fs/ext4/super.c     | 2 +-
 fs/xfs/xfs_buf.c    | 2 +-
 fs/xfs/xfs_buf.h    | 1 +
 include/linux/dax.h | 6 ++++--
 11 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 45d931aefd063..e7152a6c4cc40 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -69,17 +69,20 @@ EXPORT_SYMBOL_GPL(dax_remove_host);
 /**
  * fs_dax_get_by_bdev() - temporary lookup mechanism for filesystem-dax
  * @bdev: block device to find a dax_device for
+ * @start_off: returns the byte offset into the dax_device that @bdev starts
  */
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
 {
 	struct dax_device *dax_dev;
+	u64 part_size;
 	int id;
 
 	if (!blk_queue_dax(bdev->bd_disk->queue))
 		return NULL;
 
-	if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
-	    (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
+	*start_off = get_start_sect(bdev) * SECTOR_SIZE;
+	part_size = bdev_nr_sectors(bdev) * SECTOR_SIZE;
+	if (*start_off % PAGE_SIZE || part_size % PAGE_SIZE) {
 		pr_info("%pg: error: unaligned partition for dax\n", bdev);
 		return NULL;
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4eba27e75c230..4e997c02bb0a0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -637,7 +637,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 			     struct mapped_device *md)
 {
 	struct block_device *bdev;
-
+	u64 part_off;
 	int r;
 
 	BUG_ON(td->dm_dev.bdev);
@@ -653,7 +653,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 	}
 
 	td->dm_dev.bdev = bdev;
-	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
+	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);
 	return 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3265688af7f9f..c1e65346e9f15 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -51,6 +51,7 @@ struct erofs_device_info {
 	char *path;
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
+	u64 dax_part_off;
 
 	u32 blocks;
 	u32 mapped_blkaddr;
@@ -109,6 +110,7 @@ struct erofs_sb_info {
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
+	u64 dax_part_off;
 	u64 total_blocks;
 	u32 primarydevice_blocks;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0aed886473c8d..71efce16024d9 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -312,7 +312,7 @@ static int erofs_init_devices(struct super_block *sb,
 			goto err_out;
 		}
 		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev);
+		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
 		dif->blocks = le32_to_cpu(dis->blocks);
 		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
 		sbi->total_blocks += dif->blocks;
@@ -644,7 +644,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
-	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
+	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 3be9dd6412b78..d4f306aa5aceb 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -118,6 +118,7 @@ struct ext2_sb_info {
 	spinlock_t s_lock;
 	struct mb_cache *s_ea_block_cache;
 	struct dax_device *s_daxdev;
+	u64 s_dax_part_off;
 };
 
 static inline spinlock_t *
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 7e23482862e69..94f1fbd7d3ac2 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -831,7 +831,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	sb->s_fs_info = sbi;
 	sbi->s_sb_block = sb_block;
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
 
 	spin_lock_init(&sbi->s_lock);
 	ret = -EINVAL;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 404dd50856e5d..9cc55bcda6ba4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1697,6 +1697,7 @@ struct ext4_sb_info {
 	 */
 	struct percpu_rw_semaphore s_writepages_rwsem;
 	struct dax_device *s_daxdev;
+	u64 s_dax_part_off;
 #ifdef CONFIG_EXT4_DEBUG
 	unsigned long s_simulate_fail;
 #endif
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8d7e3449c6472..56228e33e52a2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3913,7 +3913,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sbi->s_blockgroup_lock)
 		goto out_free_base;
 
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
 	sb->s_fs_info = sbi;
 	sbi->s_sb = sb;
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 4d4553ffa7050..bbb0fbd34e649 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1945,7 +1945,7 @@ xfs_alloc_buftarg(
 	btp->bt_mount = mp;
 	btp->bt_dev =  bdev->bd_dev;
 	btp->bt_bdev = bdev;
-	btp->bt_daxdev = fs_dax_get_by_bdev(bdev);
+	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index bd7f709f0d232..edcb6254fa6a8 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -89,6 +89,7 @@ typedef struct xfs_buftarg {
 	dev_t			bt_dev;
 	struct block_device	*bt_bdev;
 	struct dax_device	*bt_daxdev;
+	u64			bt_dax_part_off;
 	struct xfs_mount	*bt_mount;
 	unsigned int		bt_meta_sectorsize;
 	size_t			bt_meta_sectormask;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b79036743e7fa..f6f353382cc90 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -117,7 +117,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 	put_dax(dax_dev);
 }
 
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
+		u64 *start_off);
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
@@ -138,7 +139,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 }
 
-static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
+static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
+		u64 *start_off)
 {
 	return NULL;
 }
-- 
2.30.2

