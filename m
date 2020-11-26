Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E42C549D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbgKZNHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389900AbgKZNHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05286C0613D4;
        Thu, 26 Nov 2020 05:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TyzqnxJJ0lPyhYWk7Q6Y2rXryMj44xbGM+SIZQYkZvc=; b=kTeBBPXTZGDQlqvWXi1ub7lmvK
        cpnK08gWLXcWbBPPdmkRvLMxHdqyIGOqpWCQb5BjlbvAcY6waRjucuwF4EbPBG7PVYT8grRUIiy1I
        fRAKYhasJriE+kayDsRRwhhmS9JHgMY4jzN3q2QtYJh7eowAxjzyt6GZ+uqeAJoSrPo/M4Y/2G0Rq
        2AeJ6qfmzuWSmewSR31lCCoXK3I4tQvHKtPnxfZPwYX2hoOoyg85yVBAu4gJlqBjdkuYiZkCjfykT
        5S+Pyh1/6J6gTrQdbfu2ByGBPLfUPRdCc3a/D5X6Ubl7OXvbluV+9MZBFCnaPBnqGtNXp5j+aW9pi
        +okagJjg==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGz3-0003zN-SH; Thu, 26 Nov 2020 13:06:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 12/44] block: add a bdev_kobj helper
Date:   Thu, 26 Nov 2020 14:03:50 +0100
Message-Id: <20201126130422.92945-13-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a little helper to find the kobject for a struct block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Coly Li <colyli@suse.de>		[bcache]
---
 drivers/md/bcache/super.c |  7 ++-----
 drivers/md/md.c           |  4 +---
 fs/block_dev.c            |  6 +++---
 fs/btrfs/sysfs.c          | 15 +++------------
 include/linux/blk_types.h |  3 +++
 5 files changed, 12 insertions(+), 23 deletions(-)

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
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 33c29106c98907..c5755150c6be62 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1242,7 +1242,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	holder->disk = disk;
 	holder->refcnt = 1;
 
-	ret = add_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
+	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
 	if (ret)
 		goto out_free;
 
@@ -1259,7 +1259,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	goto out_unlock;
 
 out_del:
-	del_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
+	del_symlink(disk->slave_dir, bdev_kobj(bdev));
 out_free:
 	kfree(holder);
 out_unlock:
@@ -1287,7 +1287,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	holder = bd_find_holder_disk(bdev, disk);
 
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
-		del_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
+		del_symlink(disk->slave_dir, bdev_kobj(bdev));
 		del_symlink(bdev->bd_part->holder_dir,
 			    &disk_to_dev(disk)->kobj);
 		kobject_put(bdev->bd_part->holder_dir);
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
index ebfb4e7c1fd125..9698f459cc65c9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -49,6 +49,9 @@ struct block_device {
 	struct super_block	*bd_fsfreeze_sb;
 } __randomize_layout;
 
+#define bdev_kobj(_bdev) \
+	(&part_to_dev((_bdev)->bd_part)->kobj)
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
-- 
2.29.2

