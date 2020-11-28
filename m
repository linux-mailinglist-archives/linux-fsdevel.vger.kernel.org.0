Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4137E2C7590
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbgK1VtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbgK1Spj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:45:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF424C025492;
        Sat, 28 Nov 2020 08:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UgVkmALFIWqry4eWbGmtJ4BhyI76zNGGn8dFufuva+w=; b=moX275hEfmihvK/a0gTQdhR7z4
        gJzZ+ci4w16CBgiGtMT63fBnbgOW11p29112pT3MPhnLylSmzfD4jIdMPMMM/30t8stpKk3mp9OeU
        vcWPwPLlOW2z4VkZAMkJfTaZsEE+QkNcHy4xJfWNROasa4ELKV88z5lG0D9Ss0hLxKv+w4UmhzffG
        +wtv0OLHxOA9nVaonaPNNXhm1b04McORQ1WvR3A5W0rPy1J52qUAk9TYCSTkbalcFxNKgqPk3m64F
        6V+HxIERI5U5m/VrkjkF0splOFLMG94gLVSra7IfU3sEsMHdfMiLto3pLZ1M1g6oIPVg/TuK1OGXH
        jW8w56rw==;
Received: from [2001:4bb8:18c:1dd6:48f3:741a:602e:7fdd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj2tN-0000Ok-Vg; Sat, 28 Nov 2020 16:16:10 +0000
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
Subject: [PATCH 33/45] block: move the partition_meta_info to struct block_device
Date:   Sat, 28 Nov 2020 17:14:58 +0100
Message-Id: <20201128161510.347752-34-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128161510.347752-1-hch@lst.de>
References: <20201128161510.347752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the partition_meta_info to struct block_device in preparation for
killing struct hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
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
index 7bb45382658385..fe202a12eec096 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1002,7 +1002,8 @@ void __init printk_all_partitions(void)
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
index 460a745812c6d4..07df9ff554627f 100644
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
index 0832c7830f3a10..0770f654b09cdf 100644
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
index 50d27f5d38e2af..30d7076155b4d2 100644
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

