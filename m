Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E82F1BC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 18:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbhAKRGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 12:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbhAKRGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:06:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0E1C061786;
        Mon, 11 Jan 2021 09:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=e7fweghrMdW9P9YoMI3ZjNeaiqSpkM0BVdJYrB6BTac=; b=X+jDS2nwzR2weLZo7IFlxuNR91
        QHHW/U53h8AErXfEuzYdaHZF9MPzxkZisv3tTBHSqErco6fwcEf4l9a6yhGxFmLWxsbaa9FbnOyNo
        czRj6Qiz9oowwZlTBgR3+LLvk7mAST5tPaGKkEJmX0Lmmx3+Itb3ibk7ZdCvUi1yLObX0MMcYdvVu
        7yv40gMtLexFfa9tiYgWFje8Cp5MPKchmAhvb3fGb1FcUpgPyj5bkxz2j/MNx+cVETfd3FJ4vydLH
        oMvx0SfSmOe8K754TM+DzKwNiL4IJBBDGbXt/yAA2Fet2vNVB0FCG+H1eyykMQsyQ8fVLyU6wy45E
        u0fo9uGg==;
Received: from [2001:4bb8:19b:e528:814e:4181:3d37:5818] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kz0d0-003X7c-HT; Mon, 11 Jan 2021 17:05:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] char_dev: replace cdev_map with an xarray
Date:   Mon, 11 Jan 2021 18:05:13 +0100
Message-Id: <20210111170513.1526780-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

None of the complicated overlapping regions bits of the kobj_map are
required for the character device lookup, so just a trivial xarray
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/Makefile    |   5 +-
 drivers/base/map.c       | 154 ---------------------------------------
 fs/char_dev.c            |  93 ++++++++++++-----------
 fs/dcache.c              |   1 -
 fs/internal.h            |   5 --
 include/linux/kobj_map.h |  20 -----
 6 files changed, 48 insertions(+), 230 deletions(-)
 delete mode 100644 drivers/base/map.c
 delete mode 100644 include/linux/kobj_map.h

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 5e7bf9669a81f8..ff0be4d875cfaf 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for the Linux device tree
 
-obj-y			:= component.o core.o bus.o dd.o syscore.o \
-			   driver.o class.o platform.o \
-			   cpu.o firmware.o init.o map.o devres.o \
+obj-y			:= component.o core.o bus.o dd.o syscore.o driver.o \
+			   class.o platform.o cpu.o firmware.o init.o devres.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   swnode.o
diff --git a/drivers/base/map.c b/drivers/base/map.c
deleted file mode 100644
index 5650ab2b247ada..00000000000000
--- a/drivers/base/map.c
+++ /dev/null
@@ -1,154 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  linux/drivers/base/map.c
- *
- * (C) Copyright Al Viro 2002,2003
- *
- * NOTE: data structure needs to be changed.  It works, but for large dev_t
- * it will be too slow.  It is isolated, though, so these changes will be
- * local to that file.
- */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/mutex.h>
-#include <linux/kdev_t.h>
-#include <linux/kobject.h>
-#include <linux/kobj_map.h>
-
-struct kobj_map {
-	struct probe {
-		struct probe *next;
-		dev_t dev;
-		unsigned long range;
-		struct module *owner;
-		kobj_probe_t *get;
-		int (*lock)(dev_t, void *);
-		void *data;
-	} *probes[255];
-	struct mutex *lock;
-};
-
-int kobj_map(struct kobj_map *domain, dev_t dev, unsigned long range,
-	     struct module *module, kobj_probe_t *probe,
-	     int (*lock)(dev_t, void *), void *data)
-{
-	unsigned n = MAJOR(dev + range - 1) - MAJOR(dev) + 1;
-	unsigned index = MAJOR(dev);
-	unsigned i;
-	struct probe *p;
-
-	if (n > 255)
-		n = 255;
-
-	p = kmalloc_array(n, sizeof(struct probe), GFP_KERNEL);
-	if (p == NULL)
-		return -ENOMEM;
-
-	for (i = 0; i < n; i++, p++) {
-		p->owner = module;
-		p->get = probe;
-		p->lock = lock;
-		p->dev = dev;
-		p->range = range;
-		p->data = data;
-	}
-	mutex_lock(domain->lock);
-	for (i = 0, p -= n; i < n; i++, p++, index++) {
-		struct probe **s = &domain->probes[index % 255];
-		while (*s && (*s)->range < range)
-			s = &(*s)->next;
-		p->next = *s;
-		*s = p;
-	}
-	mutex_unlock(domain->lock);
-	return 0;
-}
-
-void kobj_unmap(struct kobj_map *domain, dev_t dev, unsigned long range)
-{
-	unsigned n = MAJOR(dev + range - 1) - MAJOR(dev) + 1;
-	unsigned index = MAJOR(dev);
-	unsigned i;
-	struct probe *found = NULL;
-
-	if (n > 255)
-		n = 255;
-
-	mutex_lock(domain->lock);
-	for (i = 0; i < n; i++, index++) {
-		struct probe **s;
-		for (s = &domain->probes[index % 255]; *s; s = &(*s)->next) {
-			struct probe *p = *s;
-			if (p->dev == dev && p->range == range) {
-				*s = p->next;
-				if (!found)
-					found = p;
-				break;
-			}
-		}
-	}
-	mutex_unlock(domain->lock);
-	kfree(found);
-}
-
-struct kobject *kobj_lookup(struct kobj_map *domain, dev_t dev, int *index)
-{
-	struct kobject *kobj;
-	struct probe *p;
-	unsigned long best = ~0UL;
-
-retry:
-	mutex_lock(domain->lock);
-	for (p = domain->probes[MAJOR(dev) % 255]; p; p = p->next) {
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
-		probe = p->get;
-		best = p->range - 1;
-		*index = dev - p->dev;
-		if (p->lock && p->lock(dev, data) < 0) {
-			module_put(owner);
-			continue;
-		}
-		mutex_unlock(domain->lock);
-		kobj = probe(dev, index, data);
-		/* Currently ->owner protects _only_ ->probe() itself. */
-		module_put(owner);
-		if (kobj)
-			return kobj;
-		goto retry;
-	}
-	mutex_unlock(domain->lock);
-	return NULL;
-}
-
-struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct mutex *lock)
-{
-	struct kobj_map *p = kmalloc(sizeof(struct kobj_map), GFP_KERNEL);
-	struct probe *base = kzalloc(sizeof(*base), GFP_KERNEL);
-	int i;
-
-	if ((p == NULL) || (base == NULL)) {
-		kfree(p);
-		kfree(base);
-		return NULL;
-	}
-
-	base->dev = 1;
-	base->range = ~0;
-	base->get = base_probe;
-	for (i = 0; i < 255; i++)
-		p->probes[i] = base;
-	p->lock = lock;
-	return p;
-}
diff --git a/fs/char_dev.c b/fs/char_dev.c
index ba0ded7842a779..82c26ed407ff65 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -17,7 +17,6 @@
 #include <linux/seq_file.h>
 
 #include <linux/kobject.h>
-#include <linux/kobj_map.h>
 #include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/backing-dev.h>
@@ -25,8 +24,7 @@
 
 #include "internal.h"
 
-static struct kobj_map *cdev_map;
-
+static DEFINE_XARRAY(cdev_map);
 static DEFINE_MUTEX(chrdevs_lock);
 
 #define CHRDEV_MAJOR_HASH_SIZE 255
@@ -367,6 +365,28 @@ void cdev_put(struct cdev *p)
 	}
 }
 
+static struct cdev *cdev_lookup(dev_t dev)
+{
+	struct cdev *cdev;
+
+	mutex_lock(&chrdevs_lock);
+	cdev = xa_load(&cdev_map, dev);
+	if (!cdev) {
+		mutex_unlock(&chrdevs_lock);
+		if (request_module("char-major-%d-%d",
+				   MAJOR(dev), MINOR(dev)) > 0)
+			/* Make old-style 2.4 aliases work */
+			request_module("char-major-%d", MAJOR(dev));
+		mutex_lock(&chrdevs_lock);
+
+		cdev = xa_load(&cdev_map, dev);
+	}
+	if (cdev && !cdev_get(cdev))
+		cdev = NULL;
+	mutex_unlock(&chrdevs_lock);
+	return cdev;
+}
+
 /*
  * Called every time a character special file is opened
  */
@@ -380,13 +400,10 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 	spin_lock(&cdev_lock);
 	p = inode->i_cdev;
 	if (!p) {
-		struct kobject *kobj;
-		int idx;
 		spin_unlock(&cdev_lock);
-		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
-		if (!kobj)
+		new = cdev_lookup(inode->i_rdev);
+		if (!new)
 			return -ENXIO;
-		new = container_of(kobj, struct cdev, kobj);
 		spin_lock(&cdev_lock);
 		/* Check i_cdev again in case somebody beat us to it while
 		   we dropped the lock. */
@@ -454,18 +471,6 @@ const struct file_operations def_chr_fops = {
 	.llseek = noop_llseek,
 };
 
-static struct kobject *exact_match(dev_t dev, int *part, void *data)
-{
-	struct cdev *p = data;
-	return &p->kobj;
-}
-
-static int exact_lock(dev_t dev, void *data)
-{
-	struct cdev *p = data;
-	return cdev_get(p) ? 0 : -1;
-}
-
 /**
  * cdev_add() - add a char device to the system
  * @p: the cdev structure for the device
@@ -478,7 +483,7 @@ static int exact_lock(dev_t dev, void *data)
  */
 int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 {
-	int error;
+	int error, i;
 
 	p->dev = dev;
 	p->count = count;
@@ -486,14 +491,22 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 	if (WARN_ON(dev == WHITEOUT_DEV))
 		return -EBUSY;
 
-	error = kobj_map(cdev_map, dev, count, NULL,
-			 exact_match, exact_lock, p);
-	if (error)
-		return error;
+	mutex_lock(&chrdevs_lock);
+	for (i = 0; i < count; i++) {
+		error = xa_insert(&cdev_map, dev + i, p, GFP_KERNEL);
+		if (error)
+			goto out_unwind;
+	}
+	mutex_unlock(&chrdevs_lock);
 
 	kobject_get(p->kobj.parent);
-
 	return 0;
+
+out_unwind:
+	while (--i >= 0)
+		xa_erase(&cdev_map, dev + i);
+	mutex_unlock(&chrdevs_lock);
+	return error;
 }
 
 /**
@@ -575,11 +588,6 @@ void cdev_device_del(struct cdev *cdev, struct device *dev)
 		cdev_del(cdev);
 }
 
-static void cdev_unmap(dev_t dev, unsigned count)
-{
-	kobj_unmap(cdev_map, dev, count);
-}
-
 /**
  * cdev_del() - remove a cdev from the system
  * @p: the cdev structure to be removed
@@ -593,11 +601,16 @@ static void cdev_unmap(dev_t dev, unsigned count)
  */
 void cdev_del(struct cdev *p)
 {
-	cdev_unmap(p->dev, p->count);
+	int i;
+
+	mutex_lock(&chrdevs_lock);
+	for (i = 0; i < p->count; i++)
+		xa_erase(&cdev_map, p->dev + i);
+	mutex_unlock(&chrdevs_lock);
+
 	kobject_put(&p->kobj);
 }
 
-
 static void cdev_default_release(struct kobject *kobj)
 {
 	struct cdev *p = container_of(kobj, struct cdev, kobj);
@@ -656,20 +669,6 @@ void cdev_init(struct cdev *cdev, const struct file_operations *fops)
 	cdev->ops = fops;
 }
 
-static struct kobject *base_probe(dev_t dev, int *part, void *data)
-{
-	if (request_module("char-major-%d-%d", MAJOR(dev), MINOR(dev)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("char-major-%d", MAJOR(dev));
-	return NULL;
-}
-
-void __init chrdev_init(void)
-{
-	cdev_map = kobj_map_init(base_probe, &chrdevs_lock);
-}
-
-
 /* Let modules do char dev stuff */
 EXPORT_SYMBOL(register_chrdev_region);
 EXPORT_SYMBOL(unregister_chrdev_region);
diff --git a/fs/dcache.c b/fs/dcache.c
index 97e81a844a966c..3e0329b3de0a2d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3240,5 +3240,4 @@ void __init vfs_caches_init(void)
 	files_maxfiles_init();
 	mnt_init();
 	bdev_cache_init();
-	chrdev_init();
 }
diff --git a/fs/internal.h b/fs/internal.h
index 77c50befbfbe96..a2985ee25c3b15 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -50,11 +50,6 @@ static inline int emergency_thaw_bdev(struct super_block *sb)
 extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 		get_block_t *get_block, struct iomap *iomap);
 
-/*
- * char_dev.c
- */
-extern void __init chrdev_init(void);
-
 /*
  * fs_context.c
  */
diff --git a/include/linux/kobj_map.h b/include/linux/kobj_map.h
deleted file mode 100644
index c9919f8b22932c..00000000000000
--- a/include/linux/kobj_map.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * kobj_map.h
- */
-
-#ifndef _KOBJ_MAP_H_
-#define _KOBJ_MAP_H_
-
-#include <linux/mutex.h>
-
-typedef struct kobject *kobj_probe_t(dev_t, int *, void *);
-struct kobj_map;
-
-int kobj_map(struct kobj_map *, dev_t, unsigned long, struct module *,
-	     kobj_probe_t *, int (*)(dev_t, void *), void *);
-void kobj_unmap(struct kobj_map *, dev_t, unsigned long);
-struct kobject *kobj_lookup(struct kobj_map *, dev_t, int *);
-struct kobj_map *kobj_map_init(kobj_probe_t *, struct mutex *);
-
-#endif /* _KOBJ_MAP_H_ */
-- 
2.29.2

