Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FF3F4B0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhHWMq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhHWMq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:46:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A4C061575;
        Mon, 23 Aug 2021 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p0aGUTvrWMOHMkR7q1SOGl+THfPkpdyyLBdkyQ0BPhI=; b=XNR7jGC6IJ9/L4PSnanVT0CJUU
        Qs33/Fgy481IHMeWsRjiPBhdCdEEhdAGLA5v3EEb+EkKtSnnvB//JId+WXVl6v5jMZLyPGDp6Q5d2
        NBGmwcET+1itXGZ3emXhDRy5aOE8XYTeQnekc8zTEOaF/q0wJUI/YZb+ST2X43KYklLDfnqxXuoYB
        R61mxurNHiEj4qaFcBd1H83XzBpFUsmUdMel2+ax/R9eFubaAF36KeMqOjKeTqFcPQTd6PBCz9orC
        T1XVxGityguQ46rE0Drq7sz6ffA3jOZ5jgTv3ZXlHwc035cQSj3EKP5xJ1LBCEiTQg43vm7/g4wBl
        zeTgyhuA==;
Received: from [2001:4bb8:193:fd10:c6e8:3c08:6f8b:cbf0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI9If-009jXt-OA; Mon, 23 Aug 2021 12:44:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 9/9] dax: remove bdev_dax_supported
Date:   Mon, 23 Aug 2021 14:35:16 +0200
Message-Id: <20210823123516.969486-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210823123516.969486-1-hch@lst.de>
References: <20210823123516.969486-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers already have a dax_device obtained from fs_dax_get_by_bdev
at hand, so just pass that to dax_supported() insted of doing another
lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c | 42 +-----------------------------------------
 fs/ext2/super.c     |  3 ++-
 fs/ext4/super.c     |  3 ++-
 fs/xfs/xfs_super.c  |  3 ++-
 include/linux/dax.h | 12 ------------
 5 files changed, 7 insertions(+), 56 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index eed02729add3..fc89e91beea7 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -220,47 +220,7 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
 }
 EXPORT_SYMBOL_GPL(dax_supported);
 #endif /* CONFIG_FS_DAX */
-
-/**
- * __bdev_dax_supported() - Check if the device supports dax for filesystem
- * @bdev: block device to check
- * @blocksize: The block size of the device
- *
- * This is a library function for filesystems to check if the block device
- * can be mounted with dax option.
- *
- * Return: true if supported, false if unsupported
- */
-bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
-{
-	struct dax_device *dax_dev;
-	struct request_queue *q;
-	char buf[BDEVNAME_SIZE];
-	bool ret;
-
-	q = bdev_get_queue(bdev);
-	if (!q || !blk_queue_dax(q)) {
-		pr_debug("%s: error: request queue doesn't support dax\n",
-				bdevname(bdev, buf));
-		return false;
-	}
-
-	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
-	if (!dax_dev) {
-		pr_debug("%s: error: device does not support dax\n",
-				bdevname(bdev, buf));
-		return false;
-	}
-
-	ret = dax_supported(dax_dev, bdev, blocksize, 0,
-			i_size_read(bdev->bd_inode) / 512);
-
-	put_dax(dax_dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(__bdev_dax_supported);
-#endif
+#endif /* CONFIG_BLOCK */
 
 enum dax_device_flags {
 	/* !alive + rcu grace period == no new operations / mappings */
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 21e09fbaa46f..26e69e48d7e0 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -949,7 +949,8 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (test_opt(sb, DAX)) {
-		if (!bdev_dax_supported(sb->s_bdev, blocksize)) {
+		if (!dax_supported(dax_dev, sb->s_bdev, blocksize, 0,
+				bdev_nr_sectors(sb->s_bdev))) {
 			ext2_msg(sb, KERN_ERR,
 				"DAX unsupported by block device. Turning off DAX.");
 			clear_opt(sbi->s_mount_opt, DAX);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..a1726a8debce 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4435,7 +4435,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
-	if (bdev_dax_supported(sb->s_bdev, blocksize))
+	if (dax_supported(dax_dev, sb->s_bdev, blocksize, 0,
+			bdev_nr_sectors(sb->s_bdev)))
 		set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
 
 	if (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5a89bf601d97..f4384974e52a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -319,7 +319,8 @@ xfs_buftarg_is_dax(
 	struct super_block	*sb,
 	struct xfs_buftarg	*bt)
 {
-	return bdev_dax_supported(bt->bt_bdev, sb->s_blocksize);
+	return dax_supported(bt->bt_daxdev, bt->bt_bdev, sb->s_blocksize, 0,
+			bdev_nr_sectors(bt->bt_bdev));
 }
 
 STATIC int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 32dce5763f2c..2619d94c308d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -109,12 +109,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 struct writeback_control;
 int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
-bool __bdev_dax_supported(struct block_device *bdev, int blocksize);
-static inline bool bdev_dax_supported(struct block_device *bdev, int blocksize)
-{
-	return __bdev_dax_supported(bdev, blocksize);
-}
-
 bool generic_fsdax_supported(struct dax_device *dax_dev,
 		struct block_device *bdev, int blocksize, sector_t start,
 		sector_t sectors);
@@ -136,12 +130,6 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t st
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
-static inline bool bdev_dax_supported(struct block_device *bdev,
-		int blocksize)
-{
-	return false;
-}
-
 #define generic_fsdax_supported		NULL
 
 static inline bool dax_supported(struct dax_device *dax_dev,
-- 
2.30.2

