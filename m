Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D953E4773
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhHIOX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbhHIOXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:23:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0505DC0613D3;
        Mon,  9 Aug 2021 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fXjNcv6g4LXpl9OMYkaZ1/31OMLTWrjb+tumAO/Mylw=; b=EMpRx4HDRE3aq5JIirkHqECR7M
        PmCT8BB29vmf/mLA9Hdi+4kXbQ+mrcOC7384rd9njXwsfMQnPVE6GhIJDmSykwt3bc47VuGArTDbN
        DRPazT34U2qlCnzlDIuRgZkih4Yr8qYkaP8zodKrWkiia0mumtwGfs5VVpTuJVdmaEH6gfrnBOLNQ
        p/KpmJRwDYup3/gZ62c+tBo3Uj+Nqj4Ac/3RQjWYUHfrZijJeL9orUOm4lXguTtSQ7wfYLFib41G5
        7TyUQ7ocHznUwqptL65qJaA/9C8qgyJs1qBe2AArz7OBb/PN8GZ7yRuO3PmjU2bzo81ThRlDOfA6R
        R0zTJArA==;
Received: from [2001:4bb8:184:6215:d19a:ace4:57f0:d5ad] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD6A9-00B4Gq-D4; Mon, 09 Aug 2021 14:22:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 5/5] block: remove the bd_bdi in struct block_device
Date:   Mon,  9 Aug 2021 16:17:44 +0200
Message-Id: <20210809141744.1203023-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809141744.1203023-1-hch@lst.de>
References: <20210809141744.1203023-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just retrieve the bdi from the disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c               |  7 ++++---
 fs/block_dev.c              | 13 +------------
 fs/nilfs2/super.c           |  2 +-
 fs/super.c                  |  2 +-
 fs/xfs/xfs_buf.c            |  2 +-
 include/linux/backing-dev.h |  2 +-
 include/linux/blk_types.h   |  1 -
 7 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 0c3a4a53fa11..fff161eaab42 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -506,7 +506,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKFRASET:
 		if(!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
+		bdev->bd_disk->bdi->ra_pages = (arg * 512) / PAGE_SIZE;
 		return 0;
 	case BLKRRPART:
 		return blkdev_reread_part(bdev, mode);
@@ -556,7 +556,8 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKFRAGET:
 		if (!argp)
 			return -EINVAL;
-		return put_long(argp, (bdev->bd_bdi->ra_pages*PAGE_SIZE) / 512);
+		return put_long(argp,
+			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
 	case BLKGETSIZE:
 		size = i_size_read(bdev->bd_inode);
 		if ((size >> 9) > ~0UL)
@@ -628,7 +629,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		if (!argp)
 			return -EINVAL;
 		return compat_put_long(argp,
-			       (bdev->bd_bdi->ra_pages * PAGE_SIZE) / 512);
+			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
 	case BLKGETSIZE:
 		size = i_size_read(bdev->bd_inode);
 		if ((size >> 9) > ~0UL)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index de8c3d9cbdb1..65fc0efca26b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -801,7 +801,6 @@ static struct inode *bdev_alloc_inode(struct super_block *sb)
 	if (!ei)
 		return NULL;
 	memset(&ei->bdev, 0, sizeof(ei->bdev));
-	ei->bdev.bd_bdi = &noop_backing_dev_info;
 	return &ei->vfs_inode;
 }
 
@@ -826,16 +825,11 @@ static void init_once(void *data)
 
 static void bdev_evict_inode(struct inode *inode)
 {
-	struct block_device *bdev = &BDEV_I(inode)->bdev;
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
 	/* Detach inode from wb early as bdi_put() may free bdi->wb */
 	inode_detach_wb(inode);
-	if (bdev->bd_bdi != &noop_backing_dev_info) {
-		bdi_put(bdev->bd_bdi);
-		bdev->bd_bdi = &noop_backing_dev_info;
-	}
 }
 
 static const struct super_operations bdev_sops = {
@@ -1229,11 +1223,8 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 		}
 	}
 
-	if (!bdev->bd_openers) {
+	if (!bdev->bd_openers)
 		set_init_blocksize(bdev);
-		if (bdev->bd_bdi == &noop_backing_dev_info)
-			bdev->bd_bdi = bdi_get(disk->bdi);
-	}
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
 	bdev->bd_openers++;
@@ -1266,8 +1257,6 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 
 	disk->open_partitions++;
 	set_init_blocksize(part);
-	if (part->bd_bdi == &noop_backing_dev_info)
-		part->bd_bdi = bdi_get(disk->bdi);
 done:
 	part->bd_openers++;
 	return 0;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 4abd928b0bc8..f6b2d280aab5 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1053,7 +1053,7 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_time_gran = 1;
 	sb->s_max_links = NILFS_LINK_MAX;
 
-	sb->s_bdi = bdi_get(sb->s_bdev->bd_bdi);
+	sb->s_bdi = bdi_get(sb->s_bdev->bd_disk->bdi);
 
 	err = load_nilfs(nilfs, sb);
 	if (err)
diff --git a/fs/super.c b/fs/super.c
index 91b7f156735b..bcef3a6f4c4b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1203,7 +1203,7 @@ static int set_bdev_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
 	s->s_dev = s->s_bdev->bd_dev;
-	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
+	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
 
 	if (blk_queue_stable_writes(s->s_bdev->bd_disk->queue))
 		s->s_iflags |= SB_I_STABLE_WRITES;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 8ff42b3585e0..3ab73567a0f5 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -844,7 +844,7 @@ xfs_buf_readahead_map(
 {
 	struct xfs_buf		*bp;
 
-	if (bdi_read_congested(target->bt_bdev->bd_bdi))
+	if (bdi_read_congested(target->bt_bdev->bd_disk->bdi))
 		return;
 
 	xfs_buf_read_map(target, map, nmaps,
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 44df4fcef65c..29530859d9ff 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -143,7 +143,7 @@ static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
 	sb = inode->i_sb;
 #ifdef CONFIG_BLOCK
 	if (sb_is_blkdev_sb(sb))
-		return I_BDEV(inode)->bd_bdi;
+		return I_BDEV(inode)->bd_disk->bdi;
 #endif
 	return sb->s_bdi;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 290f9061b29a..a6c015cedaf7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -41,7 +41,6 @@ struct block_device {
 	u8			bd_partno;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
-	struct backing_dev_info *bd_bdi;
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
-- 
2.30.2

