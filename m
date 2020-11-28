Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF22C751B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbgK1Vt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbgK1SuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:50:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B305C025493;
        Sat, 28 Nov 2020 08:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=l2OUXXZyRNebs+SSxWBE5t0zKHICM2g7PbDPWNpAFtE=; b=Kwe5UbohXPkCahCIjKmAAenrf6
        RG2ZopE74cobOKoOyzEsV6/PrTnMoQjclx2bq4XwZOIUGbBRdIY5N5thT6r6VA5VHy232bqvbGNk4
        hyN/cn1eW9YZnIXFGPBTPzflf8AyqyjIXbMVGTZ4skmftKlnzxuDX6Fn+ALukylFAqDTkzgPzFCio
        5mIu3vqcVABpPBBjYwrfAU/tRHzkz45sxkQo3er23PhpWgdNkXhqxlos34LNK1d/m6+4KDCavhfDK
        gtzU55Qi7t/CtryyMsaJXOJqtRYN9xqFAL1mE30TyTmuUxAgDVWCXSdh40EqZKu05luxeTdLclJzw
        NSn9YCqQ==;
Received: from 089144198196.atnat0007.highway.a1.net ([89.144.198.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj2vW-0000YZ-0l; Sat, 28 Nov 2020 16:18:23 +0000
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
Subject: [PATCH 34/45] block: move holder_dir to struct block_device
Date:   Sat, 28 Nov 2020 17:14:59 +0100
Message-Id: <20201128161510.347752-35-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128161510.347752-1-hch@lst.de>
References: <20201128161510.347752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the holder_dir field to struct block_device in preparation for
kill struct hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c             |  5 +++--
 block/partitions/core.c   |  8 ++++----
 fs/block_dev.c            | 11 +++++------
 include/linux/blk_types.h |  1 +
 include/linux/genhd.h     |  1 -
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index fe202a12eec096..a964e7532fedd5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -673,7 +673,8 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
-	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
+	disk->part0.bdev->bd_holder_dir =
+			kobject_create_and_add("holders", &ddev->kobj);
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 
 	if (disk->flags & GENHD_FL_HIDDEN) {
@@ -879,7 +880,7 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_unregister_queue(disk);
 
-	kobject_put(disk->part0.holder_dir);
+	kobject_put(disk->part0.bdev->bd_holder_dir);
 	kobject_put(disk->slave_dir);
 
 	part_stat_set_all(&disk->part0, 0);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 07df9ff554627f..c068471fa654f5 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -344,7 +344,7 @@ void delete_partition(struct hd_struct *part)
 	 */
 	get_device(disk_to_dev(disk));
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
-	kobject_put(part->holder_dir);
+	kobject_put(part->bdev->bd_holder_dir);
 	device_del(part_to_dev(part));
 
 	/*
@@ -452,8 +452,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		goto out_put;
 
 	err = -ENOMEM;
-	p->holder_dir = kobject_create_and_add("holders", &pdev->kobj);
-	if (!p->holder_dir)
+	bdev->bd_holder_dir = kobject_create_and_add("holders", &pdev->kobj);
+	if (!bdev->bd_holder_dir)
 		goto out_del;
 
 	dev_set_uevent_suppress(pdev, 0);
@@ -487,7 +487,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 out_remove_file:
 	device_remove_file(pdev, &dev_attr_whole_disk);
 out_del:
-	kobject_put(p->holder_dir);
+	kobject_put(bdev->bd_holder_dir);
 	device_del(pdev);
 out_put:
 	put_device(pdev);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0770f654b09cdf..381c22426f435b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1142,7 +1142,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	WARN_ON_ONCE(!bdev->bd_holder);
 
 	/* FIXME: remove the following once add_disk() handles errors */
-	if (WARN_ON(!disk->slave_dir || !bdev->bd_part->holder_dir))
+	if (WARN_ON(!disk->slave_dir || !bdev->bd_holder_dir))
 		goto out_unlock;
 
 	holder = bd_find_holder_disk(bdev, disk);
@@ -1165,14 +1165,14 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (ret)
 		goto out_free;
 
-	ret = add_symlink(bdev->bd_part->holder_dir, &disk_to_dev(disk)->kobj);
+	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
 	if (ret)
 		goto out_del;
 	/*
 	 * bdev could be deleted beneath us which would implicitly destroy
 	 * the holder directory.  Hold on to it.
 	 */
-	kobject_get(bdev->bd_part->holder_dir);
+	kobject_get(bdev->bd_holder_dir);
 
 	list_add(&holder->list, &bdev->bd_holder_disks);
 	goto out_unlock;
@@ -1207,9 +1207,8 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		del_symlink(disk->slave_dir, bdev_kobj(bdev));
-		del_symlink(bdev->bd_part->holder_dir,
-			    &disk_to_dev(disk)->kobj);
-		kobject_put(bdev->bd_part->holder_dir);
+		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+		kobject_put(bdev->bd_holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 2f8ede04e5a94c..c0591e52d7d7ce 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -35,6 +35,7 @@ struct block_device {
 #ifdef CONFIG_SYSFS
 	struct list_head	bd_holder_disks;
 #endif
+	struct kobject		*bd_holder_dir;
 	u8			bd_partno;
 	struct hd_struct *	bd_part;
 	/* number of times partitions within this device have been opened. */
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 30d7076155b4d2..b4a5c05593b99c 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -55,7 +55,6 @@ struct hd_struct {
 
 	struct block_device *bdev;
 	struct device __dev;
-	struct kobject *holder_dir;
 	int policy, partno;
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	int make_it_fail;
-- 
2.29.2

