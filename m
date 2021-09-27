Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1211D41A2AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 00:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbhI0WJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 18:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbhI0WJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:09:56 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F23C08E876;
        Mon, 27 Sep 2021 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FEbfg3Ip2SxtKmcwLtx8iPGrMzlfqJBHD5on3T7ArDI=; b=0RaOKoCEDb+T5+lML154q4tQoM
        iGf+xX6th/pyDKIj81wYzs+4eRSjZAisuq3KsOKCtkm/aoEBLgtV98vSVfpg9IpfcpPdO46NzadUt
        r6pTgBRuesptsgKR/Nwi+S0olapnlSBqfy7kDwqw9ggAxPG5+PG8vse9bj73jeJK9pqMdthIsQ2ic
        uvzNicCKcEZNQTx2c6+6pYmkbQpva0hixxT7a0XStsh80TQBImV0YfFPuoMePrs193InFshIcAj0Z
        Ohf6wcrM3YLBAZBWhnqkCHFFIB9Vcmiom0Tpbx28YmJAwYSr8/JoFvLCAkUzCnrxVBHspfoq2syuj
        ptU07Bhg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyij-004VaU-5A; Mon, 27 Sep 2021 22:03:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hch@lst.de, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH v2 1/2] block: make __register_blkdev() return an error
Date:   Mon, 27 Sep 2021 15:03:31 -0700
Message-Id: <20210927220332.1074647-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220332.1074647-1-mcgrof@kernel.org>
References: <20210927220332.1074647-1-mcgrof@kernel.org>
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
 drivers/block/ataflop.c | 20 +++++++++++++++-----
 drivers/block/brd.c     |  7 +++++--
 drivers/block/floppy.c  | 14 ++++++++++----
 drivers/block/loop.c    | 11 ++++++++---
 drivers/md/md.c         | 12 +++++++++---
 drivers/scsi/sd.c       |  3 ++-
 include/linux/genhd.h   |  4 ++--
 9 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cf2780cb44a7..a9b39c3d13d7 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -733,10 +733,13 @@ struct block_device *blkdev_get_no_open(dev_t dev)
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
index 7b6e5e1cf956..a5a41628aa59 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -180,7 +180,7 @@ static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
 	char name[16];
-	void (*probe)(dev_t devt);
+	int (*probe)(dev_t devt);
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 static DEFINE_MUTEX(major_names_lock);
 static DEFINE_SPINLOCK(major_names_spinlock);
@@ -210,7 +210,13 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
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
@@ -228,7 +234,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * Use register_blkdev instead for any new code.
  */
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt))
+		int (*probe)(dev_t devt))
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
@@ -626,17 +632,18 @@ static ssize_t disk_badblocks_store(struct device *dev,
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
@@ -644,6 +651,8 @@ void blk_request_module(dev_t devt)
 	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
 		/* Make old-style 2.4 aliases work */
 		request_module("block-major-%d", MAJOR(devt));
+
+	return 0;
 }
 
 /*
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 5dc9b3d32415..be0627345b21 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1989,24 +1989,34 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
 
 static DEFINE_MUTEX(ataflop_probe_lock);
 
-static void ataflop_probe(dev_t dev)
+static int ataflop_probe(dev_t dev)
 {
 	int drive = MINOR(dev) & 3;
 	int type  = MINOR(dev) >> 2;
+	int err = 0;
 
 	if (type)
 		type--;
 
-	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
-		return;
+	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	mutex_lock(&ataflop_probe_lock);
 	if (!unit[drive].disk[type]) {
-		if (ataflop_alloc_disk(drive, type) == 0) {
-			add_disk(unit[drive].disk[type]);
+		err = ataflop_alloc_disk(drive, type);
+		if (err == 0) {
+			err = add_disk(unit[drive].disk[type]);
+			if (err)
+				blk_cleanup_disk(unit[drive].disk[type]);
 			unit[drive].registered[type] = true;
 		}
 	}
 	mutex_unlock(&ataflop_probe_lock);
+
+out:
+	return err;
 }
 
 static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c2bf4946f4e3..82a93044de95 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -426,10 +426,11 @@ static int brd_alloc(int i)
 	return err;
 }
 
-static void brd_probe(dev_t dev)
+static int brd_probe(dev_t dev)
 {
 	int i = MINOR(dev) / max_part;
 	struct brd_device *brd;
+	int err = 0;
 
 	mutex_lock(&brd_devices_mutex);
 	list_for_each_entry(brd, &brd_devices, brd_list) {
@@ -437,9 +438,11 @@ static void brd_probe(dev_t dev)
 			goto out_unlock;
 	}
 
-	brd_alloc(i);
+	err = brd_alloc(i);
 out_unlock:
 	mutex_unlock(&brd_devices_mutex);
+
+	return err;
 }
 
 static void brd_del_one(struct brd_device *brd)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 0434f28742e7..95a1c8ef62f7 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4517,21 +4517,27 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
 
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
+		if (floppy_alloc_disk(drive, type) == 0) {
+			err = add_disk(disks[drive][type]);
+			if (err)
+				blk_cleanup_disk(disks[drive][type]);
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
index 6bd5ad3c30b4..a68b47462ad7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5729,12 +5729,18 @@ static int md_alloc(dev_t dev, char *name)
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
index 3a101ad4d16e..691dae32f02b 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -631,8 +631,9 @@ static struct scsi_driver sd_template = {
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
index c68d83c87f83..5828ecda5c49 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -281,7 +281,7 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
 void blk_cleanup_disk(struct gendisk *disk);
 
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt));
+		int (*probe)(dev_t devt));
 #define register_blkdev(major, name) \
 	__register_blkdev(major, name, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
@@ -317,7 +317,7 @@ static inline int bd_register_pending_holders(struct gendisk *disk)
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

