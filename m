Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088AF2B7915
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgKRIs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgKRIsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B0C061A4D;
        Wed, 18 Nov 2020 00:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9bzANv+VYgNayi3XqYu3+gJSnycumDxTZtqBmtGYeOA=; b=Zwjf9/vfCdFX/wzjudAegg8I9I
        ne6T0qgttSCBMB4/+qUGaZ0F8oemsXBAjc8MiA01yPrzHlCI+B7NOaQCcgUPiGeeOeRaDRjNOL0TI
        XTvLoy6KGn3T2Sy/YYIyZfKkz8pr91yZcXqExhyNx6T1JicjMldOTa2ud8J4dvUkqfJXsI2ky1h0j
        JzrP7PsQ5U3dJXRRu9nPHXIWufdefaoTP45TCu+rSkQhlllaqIRdDC1SU1aU3sN/0323xx3thLATv
        NBGm1F1GhheaF/vYD/ePxy3W47MdD2OJPtdvqukJRdrxHYP5kAaSKYzKivQrPHlRuOzrRoPRqWhYp
        zSRofNWw==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8J-0007ke-8F; Wed, 18 Nov 2020 08:48:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 03/20] block: add a bdev_kobj helper
Date:   Wed, 18 Nov 2020 09:47:43 +0100
Message-Id: <20201118084800.2339180-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a little helper to find the kobject for a struct block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c |  7 ++-----
 drivers/md/md.c           |  4 +---
 fs/btrfs/sysfs.c          | 15 +++------------
 include/linux/blk_types.h |  3 +++
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 46a00134a36ae1..a6a5e21e4fd136 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1447,8 +1447,7 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		goto err;
 
 	err = "error creating kobject";
-	if (kobject_add(&dc->disk.kobj, &part_to_dev(bdev->bd_part)->kobj,
-			"bcache"))
+	if (kobject_add(&dc->disk.kobj, bdev_kobj(bdev), "bcache"))
 		goto err;
 	if (bch_cache_accounting_add_kobjs(&dc->accounting, &dc->disk.kobj))
 		goto err;
@@ -2342,9 +2341,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		goto err;
 	}
 
-	if (kobject_add(&ca->kobj,
-			&part_to_dev(bdev->bd_part)->kobj,
-			"bcache")) {
+	if (kobject_add(&ca->kobj, bdev_kobj(bdev), "bcache")) {
 		err = "error calling kobject_add";
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b2edf5e0f965b5..7ce6047c856ea2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2414,7 +2414,6 @@ EXPORT_SYMBOL(md_integrity_add_rdev);
 static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 {
 	char b[BDEVNAME_SIZE];
-	struct kobject *ko;
 	int err;
 
 	/* prevent duplicates */
@@ -2477,9 +2476,8 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
 
-	ko = &part_to_dev(rdev->bdev->bd_part)->kobj;
 	/* failure here is OK */
-	err = sysfs_create_link(&rdev->kobj, ko, "block");
+	err = sysfs_create_link(&rdev->kobj, bdev_kobj(rdev->bdev), "block");
 	rdev->sysfs_state = sysfs_get_dirent_safe(rdev->kobj.sd, "state");
 	rdev->sysfs_unack_badblocks =
 		sysfs_get_dirent_safe(rdev->kobj.sd, "unacknowledged_bad_blocks");
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676d4..24b6c6dc69000a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1232,8 +1232,6 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 
 void btrfs_sysfs_remove_device(struct btrfs_device *device)
 {
-	struct hd_struct *disk;
-	struct kobject *disk_kobj;
 	struct kobject *devices_kobj;
 
 	/*
@@ -1243,11 +1241,8 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device)
 	devices_kobj = device->fs_info->fs_devices->devices_kobj;
 	ASSERT(devices_kobj);
 
-	if (device->bdev) {
-		disk = device->bdev->bd_part;
-		disk_kobj = &part_to_dev(disk)->kobj;
-		sysfs_remove_link(devices_kobj, disk_kobj->name);
-	}
+	if (device->bdev)
+		sysfs_remove_link(devices_kobj, bdev_kobj(device->bdev)->name);
 
 	if (device->devid_kobj.state_initialized) {
 		kobject_del(&device->devid_kobj);
@@ -1353,11 +1348,7 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
 	nofs_flag = memalloc_nofs_save();
 
 	if (device->bdev) {
-		struct hd_struct *disk;
-		struct kobject *disk_kobj;
-
-		disk = device->bdev->bd_part;
-		disk_kobj = &part_to_dev(disk)->kobj;
+		struct kobject *disk_kobj = bdev_kobj(device->bdev);
 
 		ret = sysfs_create_link(devices_kobj, disk_kobj, disk_kobj->name);
 		if (ret) {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d9b69bbde5cc54..0069bee992063e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -48,6 +48,9 @@ struct block_device {
 	struct mutex		bd_fsfreeze_mutex;
 } __randomize_layout;
 
+#define bdev_kobj(_bdev) \
+	(&part_to_dev((_bdev)->bd_part)->kobj)
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
-- 
2.29.2

