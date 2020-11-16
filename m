Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B92B482A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgKPPCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbgKPO7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEDFC0617A6;
        Mon, 16 Nov 2020 06:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B9SmRAKqCfACKKyGENFkBsseQWLE7CqM6G32RVvIzu4=; b=YQQqHRpSkrytYfsEPQgYxForVD
        ablAk/WRbGXtgxrxwNPGmkrzt1O8iJfhT5R2bc9kw1ILZs2JspT6CnDAtWi6H1YUByvbdA5f9WyhN
        uCO93gIlHgtuIV9TH2X+F3LmXC0K4QQezeb3WfKxjzE/QxnV9BXZKeQZppJYBgbbWJVaY6WHdV6Wz
        o3+F4X3jMir+rU9NgAMuiknEYgx5X5aTQ7lEP6wvCebgL1xLVb4qQYSvAXNIGsZclY1CJa85yva1t
        3ZOV/mD9/yBkT9Ag7uKj999ThoEG+ydI187GuglZeRckSc1dxAQ1vI9VhLWGyx3iMOWxNRPx1e+V1
        8b8xJE+w==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyW-00043h-2j; Mon, 16 Nov 2020 14:59:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 52/78] block: switch gendisk lookup to a simple xarray
Date:   Mon, 16 Nov 2020 15:57:43 +0100
Message-Id: <20201116145809.410558-53-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that bdev_map is only used for finding gendisks, we can use
a simple xarray instead of the regions tracking structure for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/genhd.c         | 208 ++++++++----------------------------------
 include/linux/genhd.h |   7 --
 2 files changed, 37 insertions(+), 178 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index dc8690bc281c16..4a224a3c8e1071 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -27,15 +27,7 @@
 
 static struct kobject *block_depr;
 
-struct bdev_map {
-	struct bdev_map *next;
-	dev_t dev;
-	unsigned long range;
-	struct module *owner;
-	struct kobject *(*probe)(dev_t, int *, void *);
-	int (*lock)(dev_t, void *);
-	void *data;
-} *bdev_map[255];
+static DEFINE_XARRAY(bdev_map);
 static DEFINE_MUTEX(bdev_map_lock);
 
 /* for extended dynamic devt allocation, currently only one major is used */
@@ -646,85 +638,26 @@ static char *bdevt_str(dev_t devt, char *buf)
 	return buf;
 }
 
-/*
- * Register device numbers dev..(dev+range-1)
- * range must be nonzero
- * The hash chain is sorted on range, so that subranges can override.
- */
-void blk_register_region(dev_t devt, unsigned long range, struct module *module,
-			 struct kobject *(*probe)(dev_t, int *, void *),
-			 int (*lock)(dev_t, void *), void *data)
-{
-	unsigned n = MAJOR(devt + range - 1) - MAJOR(devt) + 1;
-	unsigned index = MAJOR(devt);
-	unsigned i;
-	struct bdev_map *p;
-
-	n = min(n, 255u);
-	p = kmalloc_array(n, sizeof(struct bdev_map), GFP_KERNEL);
-	if (p == NULL)
-		return;
-
-	for (i = 0; i < n; i++, p++) {
-		p->owner = module;
-		p->probe = probe;
-		p->lock = lock;
-		p->dev = devt;
-		p->range = range;
-		p->data = data;
-	}
+static void blk_register_region(struct gendisk *disk)
+{
+	int i;
 
 	mutex_lock(&bdev_map_lock);
-	for (i = 0, p -= n; i < n; i++, p++, index++) {
-		struct bdev_map **s = &bdev_map[index % 255];
-		while (*s && (*s)->range < range)
-			s = &(*s)->next;
-		p->next = *s;
-		*s = p;
+	for (i = 0; i < disk->minors; i++) {
+		if (xa_insert(&bdev_map, disk_devt(disk) + i, disk, GFP_KERNEL))
+			WARN_ON_ONCE(1);
 	}
 	mutex_unlock(&bdev_map_lock);
 }
-EXPORT_SYMBOL(blk_register_region);
 
-void blk_unregister_region(dev_t devt, unsigned long range)
+static void blk_unregister_region(struct gendisk *disk)
 {
-	unsigned n = MAJOR(devt + range - 1) - MAJOR(devt) + 1;
-	unsigned index = MAJOR(devt);
-	unsigned i;
-	struct bdev_map *found = NULL;
+	int i;
 
 	mutex_lock(&bdev_map_lock);
-	for (i = 0; i < min(n, 255u); i++, index++) {
-		struct bdev_map **s;
-		for (s = &bdev_map[index % 255]; *s; s = &(*s)->next) {
-			struct bdev_map *p = *s;
-			if (p->dev == devt && p->range == range) {
-				*s = p->next;
-				if (!found)
-					found = p;
-				break;
-			}
-		}
-	}
+	for (i = 0; i < disk->minors; i++)
+		xa_erase(&bdev_map, disk_devt(disk) + i);
 	mutex_unlock(&bdev_map_lock);
-	kfree(found);
-}
-EXPORT_SYMBOL(blk_unregister_region);
-
-static struct kobject *exact_match(dev_t devt, int *partno, void *data)
-{
-	struct gendisk *p = data;
-
-	return &disk_to_dev(p)->kobj;
-}
-
-static int exact_lock(dev_t devt, void *data)
-{
-	struct gendisk *p = data;
-
-	if (!get_disk_and_module(p))
-		return -1;
-	return 0;
 }
 
 static void disk_scan_partitions(struct gendisk *disk)
@@ -870,8 +803,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
 		bdi_set_owner(bdi, dev);
-		blk_register_region(disk_devt(disk), disk->minors, NULL,
-				    exact_match, exact_lock, disk);
+		blk_register_region(disk);
 	}
 	register_disk(parent, disk, groups);
 	if (register_queue)
@@ -984,7 +916,7 @@ void del_gendisk(struct gendisk *disk)
 	blk_unregister_queue(disk);
 	
 	if (!(disk->flags & GENHD_FL_HIDDEN))
-		blk_unregister_region(disk_devt(disk), disk->minors);
+		blk_unregister_region(disk);
 	/*
 	 * Remove gendisk pointer from idr so that it cannot be looked up
 	 * while RCU period before freeing gendisk is running to prevent
@@ -1050,54 +982,22 @@ static void request_gendisk_module(dev_t devt)
 		request_module("block-major-%d", MAJOR(devt));
 }
 
-static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
+static bool get_disk_and_module(struct gendisk *disk)
 {
-	struct kobject *kobj;
-	struct bdev_map *p;
-	unsigned long best = ~0UL;
-
-retry:
-	mutex_lock(&bdev_map_lock);
-	for (p = bdev_map[MAJOR(dev) % 255]; p; p = p->next) {
-		struct kobject *(*probe)(dev_t, int *, void *);
-		struct module *owner;
-		void *data;
-
-		if (p->dev > dev || p->dev + p->range - 1 < dev)
-			continue;
-		if (p->range - 1 >= best)
-			break;
-		if (!try_module_get(p->owner))
-			continue;
-		owner = p->owner;
-		data = p->data;
-		probe = p->probe;
-		best = p->range - 1;
-		*partno = dev - p->dev;
-
-		if (!probe) {
-			mutex_unlock(&bdev_map_lock);
-			module_put(owner);
-			request_gendisk_module(dev);
-			goto retry;
-		}
+	struct module *owner;
 
-		if (p->lock && p->lock(dev, data) < 0) {
-			module_put(owner);
-			continue;
-		}
-		mutex_unlock(&bdev_map_lock);
-		kobj = probe(dev, partno, data);
-		/* Currently ->owner protects _only_ ->probe() itself. */
+	if (!disk->fops)
+		return false;
+	owner = disk->fops->owner;
+	if (owner && !try_module_get(owner))
+		return false;
+	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj)) {
 		module_put(owner);
-		if (kobj)
-			return dev_to_disk(kobj_to_dev(kobj));
-		goto retry;
+		return false;
 	}
-	mutex_unlock(&bdev_map_lock);
-	return NULL;
-}
+	return true;
 
+}
 
 /**
  * get_gendisk - get partitioning information for a given device
@@ -1116,7 +1016,19 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	might_sleep();
 
 	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
-		disk = lookup_gendisk(devt, partno);
+		mutex_lock(&bdev_map_lock);
+		disk = xa_load(&bdev_map, devt);
+		if (!disk) {
+			mutex_unlock(&bdev_map_lock);
+			request_gendisk_module(devt);
+			mutex_lock(&bdev_map_lock);
+			disk = xa_load(&bdev_map, devt);
+		}
+		if (disk && !get_disk_and_module(disk))
+			disk = NULL;
+		if (disk)
+			*partno = devt - disk_devt(disk);
+		mutex_unlock(&bdev_map_lock);
 	} else {
 		struct hd_struct *part;
 
@@ -1320,21 +1232,6 @@ static const struct seq_operations partitions_op = {
 };
 #endif
 
-static void bdev_map_init(void)
-{
-	struct bdev_map *base;
-	int i;
-
-	base = kzalloc(sizeof(*base), GFP_KERNEL);
-	if (!base)
-		panic("cannot allocate bdev_map");
-
-	base->dev = 1;
-	base->range = ~0 ;
-	for (i = 0; i < 255; i++)
-		bdev_map[i] = base;
-}
-
 static int __init genhd_device_init(void)
 {
 	int error;
@@ -1343,7 +1240,6 @@ static int __init genhd_device_init(void)
 	error = class_register(&block_class);
 	if (unlikely(error))
 		return error;
-	bdev_map_init();
 	blk_dev_init();
 
 	register_blkdev(BLOCK_EXT_MAJOR, "blkext");
@@ -1892,35 +1788,6 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
-/**
- * get_disk_and_module - increments the gendisk and gendisk fops module refcount
- * @disk: the struct gendisk to increment the refcount for
- *
- * This increments the refcount for the struct gendisk, and the gendisk's
- * fops module owner.
- *
- * Context: Any context.
- */
-struct kobject *get_disk_and_module(struct gendisk *disk)
-{
-	struct module *owner;
-	struct kobject *kobj;
-
-	if (!disk->fops)
-		return NULL;
-	owner = disk->fops->owner;
-	if (owner && !try_module_get(owner))
-		return NULL;
-	kobj = kobject_get_unless_zero(&disk_to_dev(disk)->kobj);
-	if (kobj == NULL) {
-		module_put(owner);
-		return NULL;
-	}
-	return kobj;
-
-}
-EXPORT_SYMBOL(get_disk_and_module);
-
 /**
  * put_disk - decrements the gendisk refcount
  * @disk: the struct gendisk to decrement the refcount for
@@ -1957,7 +1824,6 @@ void put_disk_and_module(struct gendisk *disk)
 		module_put(owner);
 	}
 }
-EXPORT_SYMBOL(put_disk_and_module);
 
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 04f6a6bf577a90..46553d6d602563 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -338,15 +338,8 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct block_device *bdev);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
-extern struct kobject *get_disk_and_module(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
 extern void put_disk_and_module(struct gendisk *disk);
-extern void blk_register_region(dev_t devt, unsigned long range,
-			struct module *module,
-			struct kobject *(*probe)(dev_t, int *, void *),
-			int (*lock)(dev_t, void *),
-			void *data);
-extern void blk_unregister_region(dev_t devt, unsigned long range);
 
 #define alloc_disk_node(minors, node_id)				\
 ({									\
-- 
2.29.2

