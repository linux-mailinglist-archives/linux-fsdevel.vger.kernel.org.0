Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FB202237
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgFTHRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgFTHRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:17:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676AC06174E;
        Sat, 20 Jun 2020 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=q4EALRxcaActKV9HCTOro94tk2q9YtvXD2QaQ1ECFhU=; b=J3HzNqMsJMZq9/DJl3R1iGLAlu
        Qvx9hc/oS08eVmeUQ9v6MbQ3QpeZwyIET+O/hNmLf1v52PvDDVarHSh2DWGje0D8zKmfv/gDwUyKB
        mczvE41dkd46CZZpucyRovPyj4Nz4f0wdsr/zb7ry6F36Pithq6gGJ/KmlGuyE5wLEt6DYlLuCqoz
        MzdCrtl/xx5gOQbrLEPjRzzctXHLZXvlUoFLfVIgsh2H+TFY0sCNz1o+++iQqCFWvzP3JJIw6rC7r
        h+YI0ij4PQy2gpwT3iOvd1o2THm3joyRjGwQsj3zaMubCPO5hZ0t5B1M0pt3Oc/yGcgMsnadtyrr1
        KnDL70JQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkZ-0003um-TD; Sat, 20 Jun 2020 07:17:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] block: move struct block_device to blk_types.h
Date:   Sat, 20 Jun 2020 09:16:44 +0200
Message-Id: <20200620071644.463185-11-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
References: <20200620071644.463185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the struct block_device definition together with most of the
block layer definitions, as it has nothing to do with the rest of fs.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/adfs/super.c           |  1 +
 fs/befs/linuxvfs.c        |  1 +
 fs/efs/super.c            |  1 +
 fs/jfs/jfs_mount.c        |  1 +
 fs/jfs/resize.c           |  1 +
 include/linux/blk_types.h | 39 ++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h    |  1 +
 include/linux/dasd_mod.h  |  2 ++
 include/linux/fs.h        | 41 ---------------------------------------
 9 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index a3cc8ecb50da1a..d553bb5bc17abd 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/statfs.h>
 #include <linux/user_namespace.h>
+#include <linux/blkdev.h>
 #include "adfs.h"
 #include "dir_f.h"
 #include "dir_fplus.h"
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 64cdf4d8e42451..2482032021cac7 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -22,6 +22,7 @@
 #include <linux/cred.h>
 #include <linux/exportfs.h>
 #include <linux/seq_file.h>
+#include <linux/blkdev.h>
 
 #include "befs.h"
 #include "btree.h"
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 4a6ebff2af76f3..a4a945d0ac6a42 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
+#include <linux/blkdev.h>
 
 #include "efs.h"
 #include <linux/efs_vh.h>
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index eb8b9e233d73db..2935d4c776ec75 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -36,6 +36,7 @@
 
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
+#include <linux/blkdev.h>
 
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
diff --git a/fs/jfs/resize.c b/fs/jfs/resize.c
index 66acea9d878b97..bde787c354fcc1 100644
--- a/fs/jfs/resize.c
+++ b/fs/jfs/resize.c
@@ -6,6 +6,7 @@
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
 #include <linux/quotaops.h>
+#include <linux/blkdev.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b185..a602132cbe32c2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -14,12 +14,49 @@ struct bio_set;
 struct bio;
 struct bio_integrity_payload;
 struct page;
-struct block_device;
 struct io_context;
 struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
+struct block_device {
+	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
+	int			bd_openers;
+	struct inode *		bd_inode;	/* will die */
+	struct super_block *	bd_super;
+	struct mutex		bd_mutex;	/* open/close mutex */
+	void *			bd_claiming;
+	void *			bd_holder;
+	int			bd_holders;
+	bool			bd_write_holder;
+#ifdef CONFIG_SYSFS
+	struct list_head	bd_holder_disks;
+#endif
+	struct block_device *	bd_contains;
+	unsigned		bd_block_size;
+	u8			bd_partno;
+	struct hd_struct *	bd_part;
+	/* number of times partitions within this device have been opened. */
+	unsigned		bd_part_count;
+	int			bd_invalidated;
+	struct gendisk *	bd_disk;
+	struct request_queue *  bd_queue;
+	struct backing_dev_info *bd_bdi;
+	struct list_head	bd_list;
+	/*
+	 * Private data.  You must have bd_claim'ed the block_device
+	 * to use this.  NOTE:  bd_claim allows an owner to claim
+	 * the same device multiple times, the owner must take special
+	 * care to not mess up bd_private for that case.
+	 */
+	unsigned long		bd_private;
+
+	/* The counter of freeze processes */
+	int			bd_fsfreeze_count;
+	/* Mutex for freeze */
+	struct mutex		bd_fsfreeze_mutex;
+} __randomize_layout;
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0f021ee2ce1c3b..60d07e89582bfa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1932,6 +1932,7 @@ void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
 		void *holder);
 void blkdev_put(struct block_device *bdev, fmode_t mode);
 
+struct block_device *I_BDEV(struct inode *inode);
 struct block_device *bdget(dev_t);
 struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
diff --git a/include/linux/dasd_mod.h b/include/linux/dasd_mod.h
index d39abad2ff6e4c..14e6cf8c62677f 100644
--- a/include/linux/dasd_mod.h
+++ b/include/linux/dasd_mod.h
@@ -4,6 +4,8 @@
 
 #include <asm/dasd.h>
 
+struct gendisk;
+
 extern int dasd_biodasdinfo(struct gendisk *disk, dasd_information2_t *info);
 
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index add30c3bdf9a28..1d7c4f7465d24c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -470,45 +470,6 @@ struct address_space {
 	 * must be enforced here for CRIS, to let the least significant bit
 	 * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
 	 */
-struct request_queue;
-
-struct block_device {
-	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
-	int			bd_openers;
-	struct inode *		bd_inode;	/* will die */
-	struct super_block *	bd_super;
-	struct mutex		bd_mutex;	/* open/close mutex */
-	void *			bd_claiming;
-	void *			bd_holder;
-	int			bd_holders;
-	bool			bd_write_holder;
-#ifdef CONFIG_SYSFS
-	struct list_head	bd_holder_disks;
-#endif
-	struct block_device *	bd_contains;
-	unsigned		bd_block_size;
-	u8			bd_partno;
-	struct hd_struct *	bd_part;
-	/* number of times partitions within this device have been opened. */
-	unsigned		bd_part_count;
-	int			bd_invalidated;
-	struct gendisk *	bd_disk;
-	struct request_queue *  bd_queue;
-	struct backing_dev_info *bd_bdi;
-	struct list_head	bd_list;
-	/*
-	 * Private data.  You must have bd_claim'ed the block_device
-	 * to use this.  NOTE:  bd_claim allows an owner to claim
-	 * the same device multiple times, the owner must take special
-	 * care to not mess up bd_private for that case.
-	 */
-	unsigned long		bd_private;
-
-	/* The counter of freeze processes */
-	int			bd_fsfreeze_count;
-	/* Mutex for freeze */
-	struct mutex		bd_fsfreeze_mutex;
-} __randomize_layout;
 
 /* XArray tags, for tagging dirty and writeback pages in the pagecache. */
 #define PAGECACHE_TAG_DIRTY	XA_MARK_0
@@ -907,8 +868,6 @@ static inline unsigned imajor(const struct inode *inode)
 	return MAJOR(inode->i_rdev);
 }
 
-extern struct block_device *I_BDEV(struct inode *inode);
-
 struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
-- 
2.26.2

