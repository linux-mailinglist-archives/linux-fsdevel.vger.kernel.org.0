Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1815E2C27A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbgKXN3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbgKXN3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:29:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C98C0613D6;
        Tue, 24 Nov 2020 05:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=poZBwhuOLPH4nVpuZeBAMid+BIvjZtpwd5xAAK8WqlA=; b=GShL211CdoWfaon8Asg+Yyt/uD
        O4KY/ru6xFzxXugAsi4gNVsfLdWSHBDbaQHEileb61HyjAxsCkG17xh05JMkhBNHpjZ7bdbqhUV6j
        ZJDO8oPwblwrDMI4PFP8XiSn2cGysXNlJXRl2ZwnsCcm8WrZrLGTBvkklhzFB20Tl5AgqzPshm0EO
        hrL4cwDDEc2HuFczFp/++Sod4QAfiJnnwIIlrtvLuBLWttgsr1YhsQ96QA7pgqWpGdQTY/qbb10u/
        HgkloUSyqKxJ18ixGgzZUIzKPRUgVuftoC7ZzTmsFglKlIbNU502KOzP0sFhzL4RsM0nISeUSHKnc
        NZz4Fvfw==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNF-0006fK-UM; Tue, 24 Nov 2020 13:28:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 33/45] block: move the partition_meta_info to struct block_device
Date:   Tue, 24 Nov 2020 14:27:39 +0100
Message-Id: <20201124132751.3747337-34-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the partition_meta_info to struct block_device in preparation for
killing struct hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h               |  1 -
 block/genhd.c             |  3 ++-
 block/partitions/core.c   | 18 +++++++-----------
 fs/block_dev.c            |  1 +
 include/linux/blk_types.h |  2 ++
 include/linux/genhd.h     |  1 -
 init/do_mounts.c          |  7 ++++---
 7 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 3f801f6e86f8a1..0bd4b58bcbaf77 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -381,7 +381,6 @@ static inline void hd_struct_put(struct hd_struct *part)
 
 static inline void hd_free_part(struct hd_struct *part)
 {
-	kfree(part->info);
 	bdput(part->bdev);
 	percpu_ref_exit(&part->ref);
 }
diff --git a/block/genhd.c b/block/genhd.c
index 8212a2dd10ec4e..20c7bf6d091e94 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -994,7 +994,8 @@ void __init printk_all_partitions(void)
 			       bdevt_str(part_devt(part), devt_buf),
 			       bdev_nr_sectors(part->bdev) >> 1,
 			       disk_name(disk, part->partno, name_buf),
-			       part->info ? part->info->uuid : "");
+			       part->bdev->bd_meta_info ?
+					part->bdev->bd_meta_info->uuid : "");
 			if (is_part0) {
 				if (dev->parent && dev->parent->driver)
 					printk(" driver: %s\n",
diff --git a/block/partitions/core.c b/block/partitions/core.c
index aa4b836374b037..e24673b4cba61f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -275,8 +275,9 @@ static int part_uevent(struct device *dev, struct kobj_uevent_env *env)
 	struct hd_struct *part = dev_to_part(dev);
 
 	add_uevent_var(env, "PARTN=%u", part->partno);
-	if (part->info && part->info->volname[0])
-		add_uevent_var(env, "PARTNAME=%s", part->info->volname);
+	if (part->bdev->bd_meta_info && part->bdev->bd_meta_info->volname[0])
+		add_uevent_var(env, "PARTNAME=%s",
+			       part->bdev->bd_meta_info->volname);
 	return 0;
 }
 
@@ -422,13 +423,10 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	p->policy = get_disk_ro(disk);
 
 	if (info) {
-		struct partition_meta_info *pinfo;
-
-		pinfo = kzalloc_node(sizeof(*pinfo), GFP_KERNEL, disk->node_id);
-		if (!pinfo)
+		err = -ENOMEM;
+		bdev->bd_meta_info = kmemdup(info, sizeof(*info), GFP_KERNEL);
+		if (!bdev->bd_meta_info)
 			goto out_bdput;
-		memcpy(pinfo, info, sizeof(*info));
-		p->info = pinfo;
 	}
 
 	dname = dev_name(ddev);
@@ -444,7 +442,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 
 	err = blk_alloc_devt(p, &devt);
 	if (err)
-		goto out_free_info;
+		goto out_bdput;
 	pdev->devt = devt;
 
 	/* delay uevent until 'holders' subdir is created */
@@ -481,8 +479,6 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
 	return p;
 
-out_free_info:
-	kfree(p->info);
 out_bdput:
 	bdput(bdev);
 out_free:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0427e6fa59556f..2393395201aa6c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -785,6 +785,7 @@ static void bdev_free_inode(struct inode *inode)
 	struct block_device *bdev = I_BDEV(inode);
 
 	free_percpu(bdev->bd_stats);
+	kfree(bdev->bd_meta_info);
 
 	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a690008f60cd92..2f8ede04e5a94c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -49,6 +49,8 @@ struct block_device {
 	/* Mutex for freeze */
 	struct mutex		bd_fsfreeze_mutex;
 	struct super_block	*bd_fsfreeze_sb;
+
+	struct partition_meta_info *bd_meta_info;
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a9d64da474233f..1e52f38b719db3 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -57,7 +57,6 @@ struct hd_struct {
 	struct device __dev;
 	struct kobject *holder_dir;
 	int policy, partno;
-	struct partition_meta_info *info;
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	int make_it_fail;
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5879edf083b318..368ccb71850126 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -79,8 +79,8 @@ static int match_dev_by_uuid(struct device *dev, const void *data)
 	const struct uuidcmp *cmp = data;
 	struct hd_struct *part = dev_to_part(dev);
 
-	if (!part->info ||
-	    strncasecmp(cmp->uuid, part->info->uuid, cmp->len))
+	if (!part->bdev->bd_meta_info ||
+	    strncasecmp(cmp->uuid, part->bdev->bd_meta_info->uuid, cmp->len))
 		return 0;
 	return 1;
 }
@@ -169,7 +169,8 @@ static int match_dev_by_label(struct device *dev, const void *data)
 	const char *label = data;
 	struct hd_struct *part = dev_to_part(dev);
 
-	if (!part->info || strcmp(label, part->info->volname))
+	if (!part->bdev->bd_meta_info ||
+	    strcmp(label, part->bdev->bd_meta_info->volname))
 		return 0;
 	return 1;
 }
-- 
2.29.2

