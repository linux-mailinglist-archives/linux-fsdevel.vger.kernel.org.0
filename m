Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBF23AA1A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFPQnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFPQm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:42:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67C2C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mj8-20020a17090b3688b029016ee34fc1b3so2125577pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uK58C0QtDNcahqJUODnJkhg6UnfaTIghgCe8Hvo81CM=;
        b=HLSDT+7wUHY8LpTUjhJI1RoaqvvzJ8CbeGa1mlLDdidW+2R1M1TEhtvYM7yz+eWIrX
         KvQv9652FaY6AXcLIj1bqdc1ooiiyg/Zrd86bydD6vbzdb3xskLp+KBJcF3FR50cQB6n
         qKRguDajdMaWHfageonZo7jsoXdZh7+Dy0rD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uK58C0QtDNcahqJUODnJkhg6UnfaTIghgCe8Hvo81CM=;
        b=HA0sQpfnDUhy5l9JlV7GZ6YCJ6xBiMnStsFeyfv8YvSqx9scZRbevjpyAAlVcA+5p7
         j/gnQSkQHxh6PS98Dc+bbuwNRScLP/Ze5Epcsf5pEGO71DwlutIFgpT+/Nv9e13HvnEg
         k5i2LVoO22S1tO1GVIaQiD7REG1NR3T8h32BqKLgSH7pULXSTxCDjWu1rNUS8aa8Xysb
         gLNzlXI6KACs94mTEWnobQSAi0UVEoHdqGLRyBQRPH7ubvg99YVhYp9bStryjs6AtgUU
         8Vgth1S38sljmoEMoH8J5Nj2OQOa8G3QjlyvFjK3bSZ6QbMfTqDvS/H9Pj+Za62BPPU8
         vw4A==
X-Gm-Message-State: AOAM533Vh69VV75zgvq1SrUO+LyNqH+x5S2XrThrrPHBaRN0ZiWN4CO1
        5rwWkb0f85Bp9cWdld0htMqa/A==
X-Google-Smtp-Source: ABdhPJwlTj2cDO93OlRliFpEUmheK1SgPnMQrH2UNhETk3H6RxkXF0EXk5NDiMLaXRmE082Rijd1Sw==
X-Received: by 2002:a17:90b:190a:: with SMTP id mp10mr11930432pjb.145.1623861650375;
        Wed, 16 Jun 2021 09:40:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x22sm2748199pjp.37.2021.06.16.09.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:40:49 -0700 (PDT)
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
Subject: [PATCH v3 5/5] pstore/blk: Include zone in pstore_device_info
Date:   Wed, 16 Jun 2021 09:40:43 -0700
Message-Id: <20210616164043.1221861-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616164043.1221861-1-keescook@chromium.org>
References: <20210616164043.1221861-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=c97831fb0c8399e525140afebf8001d0f40da49a; i=OzHp+/X5c8B1qT+xdnUXKoWwSY89uY95adXbT6Ztj74=; m=WOqt0d4utZlTaiUKpB0qyaFAJBWPe3VuJCNaOBLEDLw=; p=wbFugwaR98gj5F6ZJcTti2VyGOc7eeRpR29pqb1+kEM=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKKYoACgkQiXL039xtwCYvsA/6ApV 9oqn2tzk1t8uMGJIn3m65c8MwIVr818wTAMFJnW9u82WYoJCWvo32Qh0f3PmX43ZDi40Xi4WgHoU+ DWoUxhSQhUU1j7C7XgrJN41FLiylFLPdPSgFKBl33CeDOOFMsYoB2prcRBpl5mdp+HzsSB+pHH2qZ pnVBhl8YGHq9YdTzQP9WefqTL8DrpbWpOzRQr3YsIpVlkwnbdnk47mnBTOmIrPevoE+HQfJZOsjJh ndvcUnLRCYIUuayQkXi2NuPTS2K61vW4rBMBzoHImcIYMtZbg1uLXTC9D1vJRRWwRh57FvUXXoxak jjaT+0CjnV/Ulq1oMiKmp2PYnrwztj4R0oydjQqtR0jE+Zd4e+GU2kF/YrNTERZCLTOhnM4j/RJjd R+7j5TQtwgppoqNLjWu2Z5+8ouJuKTQW3JSAUHCJGA7+Vrw5xcQSF2/3L4CRwQmS/HyOCrH8Ysan/ jgQMjbFxVXh7o7K83BhbgYIYEtx7zYfshZ5ZRAQU6iccE14L30Gf2rvDf2b68f205OSKQlTS5+S5d WyaDqbN1qIqj98FEQR85QYGg2tdB11VTDSZWOTCXdGAmVOgepD12myNxG/FGm0yboZ/IGx60g2DwC uoGHNT2b4NMHEcO/j2BgYAhKLXy1nAJONBIDpaqy/avuWQlmCio+FEIHEmpJRyb4=
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
 fs/pstore/blk.c            | 143 ++++++++++++++++++++-----------------
 include/linux/pstore_blk.h |  27 +------
 3 files changed, 87 insertions(+), 93 deletions(-)

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
index c373e0d73e6c..ccb82bcde7a8 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -70,7 +70,7 @@ MODULE_PARM_DESC(blkdev, "block device for pstore storage");
  */
 static DEFINE_MUTEX(pstore_blk_lock);
 static struct file *psblk_file;
-static struct pstore_zone_info *pstore_zone_info;
+static struct pstore_device_info *pstore_device_info;
 
 #define check_size(name, alignsize) ({				\
 	long _##name_ = (name);					\
@@ -91,7 +91,7 @@ static struct pstore_zone_info *pstore_zone_info;
 		_##name_ = 0;					\
 	/* Synchronize module parameters with resuls. */	\
 	name = _##name_ / 1024;					\
-	pstore_zone_info->name = _##name_;			\
+	dev->zone.name = _##name_;				\
 }
 
 static int __register_pstore_device(struct pstore_device_info *dev)
@@ -104,50 +104,42 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 		pr_err("NULL device info\n");
 		return -EINVAL;
 	}
-	if (!dev->total_size) {
+	if (!dev->zone.total_size) {
 		pr_err("zero sized device\n");
 		return -EINVAL;
 	}
-	if (!dev->read) {
+	if (!dev->zone.read) {
 		pr_err("no read handler for device\n");
 		return -EINVAL;
 	}
-	if (!dev->write) {
+	if (!dev->zone.write) {
 		pr_err("no write handler for device\n");
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
 
+	/* Copy in module parameters. */
 	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
 	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
 	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
 	verify_size(ftrace_size, 4096, dev->flags & PSTORE_FLAGS_FTRACE);
+	dev->zone.max_reason = max_reason;
+
+	/* Initialize required zone ownership details. */
+	dev->zone.name = KBUILD_MODNAME;
+	dev->zone.owner = THIS_MODULE;
+
+	ret = register_pstore_zone(&dev->zone);
+	if (ret == 0)
+		pstore_device_info = dev;
 
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
 	return ret;
 }
 /**
@@ -174,10 +166,9 @@ EXPORT_SYMBOL_GPL(register_pstore_device);
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
 
@@ -211,12 +202,9 @@ static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
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
 	struct inode *inode;
 	int ret = -ENODEV;
 
@@ -236,9 +224,9 @@ static int __register_pstore_blk(const char *devpath)
 	}
 
 	inode = I_BDEV(psblk_file->f_mapping->host)->bd_inode;
-	dev.total_size = i_size_read(inode);
+	dev->zone.total_size = i_size_read(inode);
 
-	ret = __register_pstore_device(&dev);
+	ret = __register_pstore_device(dev);
 	if (ret)
 		goto err_fput;
 
@@ -252,18 +240,6 @@ static int __register_pstore_blk(const char *devpath)
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
@@ -308,18 +284,63 @@ static inline const char *early_boot_devpath(const char *initial_devname)
 }
 #endif
 
+static int __init __best_effort_init(void)
+{
+	struct pstore_device_info *best_effort_dev;
+	int ret;
+
+	/* No best-effort mode requested. */
+	if (!best_effort)
+		return 0;
+
+	/* Reject an empty blkdev. */
+	if (!blkdev[0]) {
+		pr_err("blkdev empty with best_effort=Y\n");
+		return -EINVAL;
+	}
+
+	best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
+	if (!best_effort)
+		return -ENOMEM;
+
+	best_effort_dev->zone.read = psblk_generic_blk_read;
+	best_effort_dev->zone.write = psblk_generic_blk_write;
+
+	ret = __register_pstore_blk(best_effort_dev,
+				    early_boot_devpath(blkdev));
+	if (ret)
+		kfree(best_effort_dev);
+	else
+		pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
+			blkdev, best_effort_dev->zone.total_size);
+
+	return ret;
+}
+
+static void __exit __best_effort_exit(void)
+{
+	/*
+	 * Currently, the only user of psblk_file is best_effort, so
+	 * we can assume that pstore_device_info is associated with it.
+	 * Once there are "real" blk devices, there will need to be a
+	 * dedicated pstore_blk_info, etc.
+	 */
+	if (psblk_file) {
+		struct pstore_device_info *dev = pstore_device_info;
+
+		__unregister_pstore_device(dev);
+		kfree(dev);
+		fput(psblk_file);
+		psblk_file = NULL;
+	}
+}
+
 static int __init pstore_blk_init(void)
 {
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&pstore_blk_lock);
-	if (!pstore_zone_info && best_effort && blkdev[0]) {
-		ret = __register_pstore_blk(early_boot_devpath(blkdev));
-		if (ret == 0 && pstore_zone_info)
-			pr_info("attached %s:%s (%zu) (no dedicated panic_write!)\n",
-				pstore_zone_info->name, blkdev,
-				pstore_zone_info->total_size);
-	}
+	ret = __best_effort_init();
 	mutex_unlock(&pstore_blk_lock);
 
 	return ret;
@@ -329,15 +350,9 @@ late_initcall(pstore_blk_init);
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
-	}
+	__best_effort_exit();
+	/* If we've been asked to unload, unregister any remaining device. */
+	__unregister_pstore_device(pstore_device_info);
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

