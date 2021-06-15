Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5595B3A8B05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 23:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFOVXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 17:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhFOVXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:23:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B68C0613A3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 14:21:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l184so140862pgd.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQuWk5oOmzR3+MBzf1Y5kFtlcef8MqT/01wlIDqw2YU=;
        b=jfbWOCBe3bM+wLUiepl7fnkaZ7873RB/BpyhovaXZ2WAZQb3+OGqRyDYmeF37wFdHU
         NiC9boMyt6rH6Rb86kZvnRgNf09xNKUphZp7AkEj2AQqxLUOl/dmINLIyGWxzj8YnMSl
         Lqppveg+hKw6RjZjHiqVDh1ubHorR9blT/v+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQuWk5oOmzR3+MBzf1Y5kFtlcef8MqT/01wlIDqw2YU=;
        b=f6c4T/exCOulE4HpL59iCGvYyuvOtocBkyqS6DyQvqrsKjdIlDTd9kT4fPutmp2GIi
         mCKRVP/fMxKiVlGJXI0InU8pYjv8ViVL5n5bug/A02xEnlI71gErU8f75Ie992ixDL1I
         eVXwQRo5hE2b4ATwISsxGY1YeCxa3yzM9u9Mo3Q/JBaMpKzcN7kVyH/pHMoOeAh0oLfp
         uscULyLFG/Dcjgs+rJ/b8nDfZj52NxBMycNmoTRLvP7JGHY9G2j94pb7Uwnn+KlGhv80
         yLC0pqy8fL3Xhxxj4/I75lJVR0+aMnxKcGeksmQ3Wswb9kVviGmP1mmmjOgotBwGIGmv
         n8sw==
X-Gm-Message-State: AOAM532Hq8FbZ07pVYMOxCuoG6LKNEhc8eHn3OH9gkNmsx/cO7R5PrO2
        uTaKzMCfRWF+0wDv0+KUK5MZCA==
X-Google-Smtp-Source: ABdhPJxv08gD1iooT16I/J+jl8d/hEyuNoj/rHWFbvF7fv81s1D9NiTfgIfzuGLGnJM5scYGinwOZQ==
X-Received: by 2002:a62:34c7:0:b029:28e:addf:f17a with SMTP id b190-20020a6234c70000b029028eaddff17amr6603010pfa.62.1623792086251;
        Tue, 15 Jun 2021 14:21:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n72sm97432pfd.8.2021.06.15.14.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:21:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/4] pstore/blk: Include zone in pstore_device_info
Date:   Tue, 15 Jun 2021 14:21:20 -0700
Message-Id: <20210615212121.1200820-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615212121.1200820-1-keescook@chromium.org>
References: <20210615212121.1200820-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=efcf5526fe13766bd98acae29e0115d24b07d210; i=OzHp+/X5c8B1qT+xdnUXKoWwSY89uY95adXbT6Ztj74=; m=WOqt0d4utZlTaiUKpB0qyaFAJBWPe3VuJCNaOBLEDLw=; p=GZLcj+Pw6pTB7TcSUO0TjvUzZzwmL6Y5LQQOOEKli3E=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDJGdAACgkQiXL039xtwCYcLQ/9Fvd Nj3Ll/zeOLGt4PGGxze7JbJepy6cH2wDJQu1BGatCL+4bWg4QpvEe+csymzkSrAQMNFJ0AQdds7V4 T03C0ur2CxGfQHjbXlsbY3fy+kXqQrpPhsy9lacKCIgVqyhHsneOQy5xinFCW8zAetopb+NA+1Z7E P3nl32yC7gccP3/r1ssROCOI2WECYoalwccWeJrVgPgqmf35b0DrGeLWQEQo5t4SwS4B70WW4vcRM E/Po3vNo9kJuV97hOWqHZD+XTyZY9/CQ0uODLRHOJbKUoLHAa3FJhLuLJm+uymdKNBhJsC8pQhltX fMK5pC1nt7djnQSf/HgiqoOYrv5xGyu10iNJodPdzqZ23txGygAOzNQlrguzMD3g7p1YZSBgtJSSL vl6D1uJiwOk4eaoAmciNSJRJc5K6zuLkpYj8zVoz5iOtLixKuI+EZtWC9GF2Zeru4MmoGSNNx6qow Qxeu2bjjjP5W9oWn6Nh0zUmf+foxqIeO9adkx2Eyzr83Uo6hgDyABe99QNrsIaOXg+T6nY7AWIC1V ysKqB+ppSsmq2R5RNUMk/neYiE5hDXOatnAVEqcDpBsqVQis/TYgYa0BB9kNEoLMuQ8gng+8q2M8g 1b2AifpUOmoQQsNqq8F71g3E7qFwMgIRNhi+csIJIkMJB42qKu6bwaxYjG5CWsBM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Information was redundant between struct pstore_zone_info and struct
pstore_device_info. Use struct pstore_zone_info, with member name "zone".

Additionally untangle the logic for the "best effort" block device
instance.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/mtdpstore.c    |  10 +--
 fs/pstore/blk.c            | 141 ++++++++++++++++++-------------------
 include/linux/pstore_blk.h |  27 +------
 3 files changed, 75 insertions(+), 103 deletions(-)

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index a3ae8778f6a9..e13d42c0acb0 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -423,13 +423,13 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
 	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
 
-	cxt->dev.total_size = mtd->size;
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
-	cxt->dev.read = mtdpstore_read;
-	cxt->dev.write = mtdpstore_write;
-	cxt->dev.erase = mtdpstore_erase;
-	cxt->dev.panic_write = mtdpstore_panic_write;
+	cxt->dev.zone.read = mtdpstore_read;
+	cxt->dev.zone.write = mtdpstore_write;
+	cxt->dev.zone.erase = mtdpstore_erase;
+	cxt->dev.zone.panic_write = mtdpstore_panic_write;
+	cxt->dev.zone.total_size = mtd->size;
 
 	ret = register_pstore_device(&cxt->dev);
 	if (ret) {
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 8f5bd656cc2d..e5ed118683b1 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -92,7 +92,7 @@ MODULE_PARM_DESC(blkdev, "block device for pstore storage");
  */
 static DEFINE_MUTEX(pstore_blk_lock);
 static struct file *psblk_file;
-static struct pstore_zone_info *pstore_zone_info;
+static struct pstore_device_info *pstore_device_info;
 
 #define check_size(name, alignsize) ({				\
 	long _##name_ = (name);					\
@@ -105,68 +105,60 @@ static struct pstore_zone_info *pstore_zone_info;
 	_##name_;						\
 })
 
+#define verify_size(name, alignsize, enabled) {				\
+		long _##name_;						\
+		if (enabled)						\
+			_##name_ = check_size(name, alignsize);		\
+		else							\
+			_##name_ = 0;					\
+		/* synchronize visible module parameters to result. */	\
+		name = _##name_ / 1024;					\
+		dev->zone.name = _##name_;				\
+	}
+
 static int __register_pstore_device(struct pstore_device_info *dev)
 {
 	int ret;
 
 	lockdep_assert_held(&pstore_blk_lock);
 
-	if (!dev || !dev->total_size || !dev->read || !dev->write) {
+	if (!dev || !dev->zone.total_size || !dev->zone.read || !dev->zone.write) {
 		if (!dev)
-			pr_err("NULL device info\n");
+			pr_err("NULL pstore_device_info\n");
 		else {
-			if (!dev->total_size)
+			if (!dev->zone.total_size)
 				pr_err("zero sized device\n");
-			if (!dev->read)
+			if (!dev->zone.read)
 				pr_err("no read handler for device\n");
-			if (!dev->write)
+			if (!dev->zone.write)
 				pr_err("no write handler for device\n");
 		}
 		return -EINVAL;
 	}
 
 	/* someone already registered before */
-	if (pstore_zone_info)
+	if (pstore_device_info)
 		return -EBUSY;
 
-	pstore_zone_info = kzalloc(sizeof(struct pstore_zone_info), GFP_KERNEL);
-	if (!pstore_zone_info)
-		return -ENOMEM;
-
 	/* zero means not limit on which backends to attempt to store. */
 	if (!dev->flags)
 		dev->flags = UINT_MAX;
 
-#define verify_size(name, alignsize, enabled) {				\
-		long _##name_;						\
-		if (enabled)						\
-			_##name_ = check_size(name, alignsize);		\
-		else							\
-			_##name_ = 0;					\
-		name = _##name_ / 1024;					\
-		pstore_zone_info->name = _##name_;			\
-	}
-
+	/* Copy in module parameters. */
 	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
 	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
 	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
 	verify_size(ftrace_size, 4096, dev->flags & PSTORE_FLAGS_FTRACE);
-#undef verify_size
-
-	pstore_zone_info->total_size = dev->total_size;
-	pstore_zone_info->max_reason = max_reason;
-	pstore_zone_info->read = dev->read;
-	pstore_zone_info->write = dev->write;
-	pstore_zone_info->erase = dev->erase;
-	pstore_zone_info->panic_write = dev->panic_write;
-	pstore_zone_info->name = KBUILD_MODNAME;
-	pstore_zone_info->owner = THIS_MODULE;
-
-	ret = register_pstore_zone(pstore_zone_info);
-	if (ret) {
-		kfree(pstore_zone_info);
-		pstore_zone_info = NULL;
-	}
+	dev->zone.max_reason = max_reason;
+
+	/* Initialize required zone ownership details. */
+	dev->zone.name = KBUILD_MODNAME;
+	dev->zone.owner = THIS_MODULE;
+
+	ret = register_pstore_zone(&dev->zone);
+	if (ret == 0)
+		pstore_device_info = dev;
+
 	return ret;
 }
 /**
@@ -193,10 +185,9 @@ EXPORT_SYMBOL_GPL(register_pstore_device);
 static void __unregister_pstore_device(struct pstore_device_info *dev)
 {
 	lockdep_assert_held(&pstore_blk_lock);
-	if (pstore_zone_info && pstore_zone_info->read == dev->read) {
-		unregister_pstore_zone(pstore_zone_info);
-		kfree(pstore_zone_info);
-		pstore_zone_info = NULL;
+	if (pstore_device_info && pstore_device_info == dev) {
+		unregister_pstore_zone(&dev->zone);
+		pstore_device_info = NULL;
 	}
 }
 
@@ -230,12 +221,9 @@ static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
 /*
  * This takes its configuration only from the module parameters now.
  */
-static int __register_pstore_blk(const char *devpath)
+static int __register_pstore_blk(struct pstore_device_info *dev,
+				 const char *devpath)
 {
-	struct pstore_device_info dev = {
-		.read = psblk_generic_blk_read,
-		.write = psblk_generic_blk_write,
-	};
 	int ret = -ENODEV;
 
 	lockdep_assert_held(&pstore_blk_lock);
@@ -252,9 +240,9 @@ static int __register_pstore_blk(const char *devpath)
 		goto err_fput;
 	}
 
-	dev.total_size = i_size_read(I_BDEV(psblk_file->f_mapping->host)->bd_inode);
+	dev->zone.total_size = i_size_read(I_BDEV(psblk_file->f_mapping->host)->bd_inode);
 
-	ret = __register_pstore_device(&dev);
+	ret = __register_pstore_device(dev);
 	if (ret)
 		goto err_fput;
 
@@ -268,18 +256,6 @@ static int __register_pstore_blk(const char *devpath)
 	return ret;
 }
 
-static void __unregister_pstore_blk(struct file *device)
-{
-	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
-
-	lockdep_assert_held(&pstore_blk_lock);
-	if (psblk_file && psblk_file == device) {
-		__unregister_pstore_device(&dev);
-		fput(psblk_file);
-		psblk_file = NULL;
-	}
-}
-
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
 {
@@ -329,13 +305,27 @@ static int __init pstore_blk_init(void)
 	int ret = 0;
 
 	mutex_lock(&pstore_blk_lock);
-	if (!pstore_zone_info && best_effort && blkdev[0]) {
-		ret = __register_pstore_blk(early_boot_devpath(blkdev));
-		if (ret == 0 && pstore_zone_info)
-			pr_info("attached %s:%s (%zu) (no dedicated panic_write!)\n",
-				pstore_zone_info->name, blkdev,
-				pstore_zone_info->total_size);
+	if (!pstore_device_info && best_effort && blkdev[0]) {
+		struct pstore_device_info *best_effort_dev;
+
+		best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
+		if (!best_effort) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		best_effort_dev->zone.read = psblk_generic_blk_read;
+		best_effort_dev->zone.write = psblk_generic_blk_write;
+
+		ret = __register_pstore_blk(best_effort_dev,
+					    early_boot_devpath(blkdev));
+		if (ret)
+			kfree(best_effort_dev);
+		else
+			pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
+				blkdev, best_effort_dev->zone.total_size);
 	}
+
+unlock:
 	mutex_unlock(&pstore_blk_lock);
 
 	return ret;
@@ -345,15 +335,18 @@ late_initcall(pstore_blk_init);
 static void __exit pstore_blk_exit(void)
 {
 	mutex_lock(&pstore_blk_lock);
-	if (psblk_file)
-		__unregister_pstore_blk(psblk_file);
-	else {
-		struct pstore_device_info dev = { };
-
-		if (pstore_zone_info)
-			dev.read = pstore_zone_info->read;
-		__unregister_pstore_device(&dev);
+	/* Unregister and free the best_effort device. */
+	if (psblk_file) {
+		struct pstore_device_info *dev = pstore_device_info;
+
+		__unregister_pstore_device(dev);
+		kfree(dev);
+		fput(psblk_file);
+		psblk_file = NULL;
 	}
+	/* If we've been asked to unload, unregister any registered device. */
+	if (pstore_device_info)
+		__unregister_pstore_device(pstore_device_info);
 	mutex_unlock(&pstore_blk_lock);
 }
 module_exit(pstore_blk_exit);
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 99564f93d774..924ca07aafbd 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -10,36 +10,15 @@
 /**
  * struct pstore_device_info - back-end pstore/blk driver structure.
  *
- * @total_size: The total size in bytes pstore/blk can use. It must be greater
- *		than 4096 and be multiple of 4096.
  * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
  *		linux/pstore.h. It means what front-ends this device support.
  *		Zero means all backends for compatible.
- * @read:	The general read operation. Both of the function parameters
- *		@size and @offset are relative value to bock device (not the
- *		whole disk).
- *		On success, the number of bytes should be returned, others
- *		means error.
- * @write:	The same as @read, but the following error number:
- *		-EBUSY means try to write again later.
- *		-ENOMSG means to try next zone.
- * @erase:	The general erase operation for device with special removing
- *		job. Both of the function parameters @size and @offset are
- *		relative value to storage.
- *		Return 0 on success and others on failure.
- * @panic_write:The write operation only used for panic case. It's optional
- *		if you do not care panic log. The parameters are relative
- *		value to storage.
- *		On success, the number of bytes should be returned, others
- *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
+ * @zone:	The struct pstore_zone_info details.
+ *
  */
 struct pstore_device_info {
-	unsigned long total_size;
 	unsigned int flags;
-	pstore_zone_read_op read;
-	pstore_zone_write_op write;
-	pstore_zone_erase_op erase;
-	pstore_zone_write_op panic_write;
+	struct pstore_zone_info zone;
 };
 
 int  register_pstore_device(struct pstore_device_info *dev);
-- 
2.25.1

