Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06243681F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhJUQla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhJUQl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:41:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55958C061764;
        Thu, 21 Oct 2021 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+b/lrsIDFJhqrjd+tWsnOZ+oYDQEr0WPrNW7mTh7MZo=; b=No8x6av4qzP/egn5c0VTK9TDf8
        VPRKWFy/ipwPrcZixJJ3ATWLb1E/KnHvJeqNKaOHnpOWz50I3dykhIkp6UdTPW3M41yl2XWQ8Fd4l
        jSukRGum5dhv5HIXMLGt8QOdcqIjcTaawzvVHKkSaiv6ZAaDJ4hF0lPVUdFFwsbo1hsns3rE63z6N
        c6dt8MH2e8GQif/8qWgbs5eBWb8awwlOdHtsNuGTMxmX9Udq6yBLB2XVBFMDwcr5lAHOHrF96Ue4v
        iFVfo3UrNtWCqsWWCasFDWuRFGnEg5km89tAShalSStaQGW9QmmIbTGh3rWVWcDaPx4XhDL9PrBHO
        lno9GyHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdb5m-008OYy-0T; Thu, 21 Oct 2021 16:38:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hch@lst.de, penguin-kernel@i-love.sakura.ne.jp,
        schmitzmic@gmail.com, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 2/3] block: make __register_blkdev() return an error
Date:   Thu, 21 Oct 2021 09:38:55 -0700
Message-Id: <20211021163856.2000993-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021163856.2000993-1-mcgrof@kernel.org>
References: <20211021163856.2000993-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This makes __register_blkdev() return an error, and also changes the
probe() call to return an error as well.

We expand documentation for the probe call to ensure that if the block
device already exists we don't return on error on that condition. We do
this as otherwise we loose ability to handle concurrent requests if the
block device already existed.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c            |  5 ++++-
 block/genhd.c           | 21 +++++++++++++++------
 drivers/block/ataflop.c | 19 ++++++++++++++-----
 drivers/block/brd.c     |  7 +++++--
 drivers/block/floppy.c  | 17 +++++++++++++----
 drivers/block/loop.c    | 11 ++++++++---
 drivers/md/md.c         | 12 +++++++++---
 drivers/scsi/sd.c       |  3 ++-
 include/linux/genhd.h   |  4 ++--
 9 files changed, 72 insertions(+), 27 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cff0bb3a4578..ec6982f7c4a6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -735,10 +735,13 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
+	int ret;
 
 	inode = ilookup(blockdev_superblock, dev);
 	if (!inode) {
-		blk_request_module(dev);
+		ret = blk_request_module(dev);
+		if (ret)
+			return NULL;
 		inode = ilookup(blockdev_superblock, dev);
 		if (!inode)
 			return NULL;
diff --git a/block/genhd.c b/block/genhd.c
index 000e344265ca..404429e6f06c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -183,7 +183,7 @@ static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
 	char name[16];
-	void (*probe)(dev_t devt);
+	int (*probe)(dev_t devt);
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 static DEFINE_MUTEX(major_names_lock);
 static DEFINE_SPINLOCK(major_names_spinlock);
@@ -213,7 +213,13 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
  *         @major = 0, try to allocate any unused major number.
  * @name: the name of the new block device as a zero terminated string
- * @probe: allback that is called on access to any minor number of @major
+ * @probe: callback that is called on access to any minor number of @major.
+ * 	This will return 0 if the block device is already present or was
+ * 	not present and it succcessfully added a new one. If the block device
+ * 	was not already present but it was a valid request an error reflecting
+ * 	the reason why adding the block device is returned. An error should not
+ * 	be returned if the block device already exists as otherwise concurrent
+ * 	requests to open an existing block device would fail.
  *
  * The @name must be unique within the system.
  *
@@ -231,7 +237,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * Use register_blkdev instead for any new code.
  */
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt))
+		int (*probe)(dev_t devt))
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
@@ -650,17 +656,18 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
-void blk_request_module(dev_t devt)
+int blk_request_module(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
+	int err;
 
 	mutex_lock(&major_names_lock);
 	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
 		if ((*n)->major == major && (*n)->probe) {
-			(*n)->probe(devt);
+			err = (*n)->probe(devt);
 			mutex_unlock(&major_names_lock);
-			return;
+			return err;
 		}
 	}
 	mutex_unlock(&major_names_lock);
@@ -668,6 +675,8 @@ void blk_request_module(dev_t devt)
 	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
 		/* Make old-style 2.4 aliases work */
 		request_module("block-major-%d", MAJOR(devt));
+
+	return 0;
 }
 
 /*
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 9aecd37ea8a5..c58750dcc685 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1976,22 +1976,31 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
 	return 0;
 }
 
-static void ataflop_probe(dev_t dev)
+static int ataflop_probe(dev_t dev)
 {
 	int drive = MINOR(dev) & 3;
 	int type  = MINOR(dev) >> 2;
+	int err = 0;
 
 	if (type)
 		type--;
 
 	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
-		return;
+		return -EINVAL;
+
 	if (!unit[drive].disk[type]) {
-		if (ataflop_alloc_disk(drive, type) == 0) {
-			add_disk(unit[drive].disk[type]);
-			unit[drive].registered[type] = true;
+		err = ataflop_alloc_disk(drive, type);
+		if (err == 0) {
+			err = add_disk(unit[drive].disk[type]);
+			if (err) {
+				blk_cleanup_disk(unit[drive].disk[type]);
+				unit[drive].disk[type] = NULL;
+			} else
+				unit[drive].registered[type] = true;
 		}
 	}
+
+	return err;
 }
 
 static void atari_floppy_cleanup(void)
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index a896ee175d86..fa6f532035fc 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -437,9 +437,12 @@ static int brd_alloc(int i)
 	return err;
 }
 
-static void brd_probe(dev_t dev)
+static int brd_probe(dev_t dev)
 {
-	brd_alloc(MINOR(dev) / max_part);
+	int ret =  brd_alloc(MINOR(dev) / max_part);
+	if (ret == -EEXIST)
+		return 0;
+	return ret;
 }
 
 static void brd_del_one(struct brd_device *brd)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3873e789478e..ff3422f517a6 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4518,21 +4518,30 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
 
 static DEFINE_MUTEX(floppy_probe_lock);
 
-static void floppy_probe(dev_t dev)
+static int floppy_probe(dev_t dev)
 {
 	unsigned int drive = (MINOR(dev) & 3) | ((MINOR(dev) & 0x80) >> 5);
 	unsigned int type = (MINOR(dev) >> 2) & 0x1f;
+	int err = 0;
 
 	if (drive >= N_DRIVE || !floppy_available(drive) ||
 	    type >= ARRAY_SIZE(floppy_type))
-		return;
+		return -EINVAL;
 
 	mutex_lock(&floppy_probe_lock);
 	if (!disks[drive][type]) {
-		if (floppy_alloc_disk(drive, type) == 0)
-			add_disk(disks[drive][type]);
+		err = floppy_alloc_disk(drive, type);
+		if (err == 0) {
+			err = add_disk(disks[drive][type]);
+			if (err) {
+				blk_cleanup_disk(disks[drive][type]);
+				disks[drive][type] = NULL;
+			}
+		}
 	}
 	mutex_unlock(&floppy_probe_lock);
+
+	return err;
 }
 
 static int __init do_floppy_init(void)
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 00ee365ed5e0..5ffb1900baa9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2433,13 +2433,18 @@ static void loop_remove(struct loop_device *lo)
 	kfree(lo);
 }
 
-static void loop_probe(dev_t dev)
+static int loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
+	int ret;
 
 	if (max_loop && idx >= max_loop)
-		return;
-	loop_add(idx);
+		return -EINVAL;
+	ret = loop_add(idx);
+	if (ret == -EEXIST)
+		return 0;
+
+	return ret;
 }
 
 static int loop_control_remove(int idx)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5111ed966947..cdfabb90acb5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5737,12 +5737,18 @@ static int md_alloc(dev_t dev, char *name)
 	return error;
 }
 
-static void md_probe(dev_t dev)
+static int md_probe(dev_t dev)
 {
+	int error = 0;
+
 	if (MAJOR(dev) == MD_MAJOR && MINOR(dev) >= 512)
-		return;
+		return -EINVAL;
 	if (create_on_open)
-		md_alloc(dev, NULL);
+		error = md_alloc(dev, NULL);
+	if (error == -EEXIST)
+		return 0;
+
+	return error;
 }
 
 static int add_named_array(const char *val, const struct kernel_param *kp)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 665e79d3f06c..5f5e4a4cbe28 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -632,8 +632,9 @@ static struct scsi_driver sd_template = {
  * Don't request a new module, as that could deadlock in multipath
  * environment.
  */
-static void sd_default_probe(dev_t devt)
+static int sd_default_probe(dev_t devt)
 {
+	return 0;
 }
 
 /*
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8d98ff613aae..f805173de312 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -288,7 +288,7 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
 void blk_cleanup_disk(struct gendisk *disk);
 
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt));
+		int (*probe)(dev_t devt));
 #define register_blkdev(major, name) \
 	__register_blkdev(major, name, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
@@ -320,7 +320,7 @@ static inline int bd_register_pending_holders(struct gendisk *disk)
 dev_t part_devt(struct gendisk *disk, u8 partno);
 void inc_diskseq(struct gendisk *disk);
 dev_t blk_lookup_devt(const char *name, int partno);
-void blk_request_module(dev_t devt);
+int blk_request_module(dev_t devt);
 #ifdef CONFIG_BLOCK
 void printk_all_partitions(void);
 #else /* CONFIG_BLOCK */
-- 
2.30.2

