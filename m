Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D83AA19B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFPQnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFPQm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:42:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9E1C0617AF
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x10so1407938plg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7QUDwC2EPEuD6DlH3pxmHwtJHgqhkfKbQUcKenskMw=;
        b=ZCdfrphV3dB5zlbDHKiuVpwdDt4sMlvzJGQQgBMXUFaiHwTCmZmt4J3GpvydjFySW3
         w2jlhZ5/mPyplNuRD6XksvWXobmt51zj5N4jefTeXM6zui8q9W+4Q80tV+MCb//CH7PP
         I92j114VJ2U9Bo/YnE3m3AXq7DhUqJqL7NBC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7QUDwC2EPEuD6DlH3pxmHwtJHgqhkfKbQUcKenskMw=;
        b=oGU77n6U3hgSKUa3AXUh3swtsG2NQEBg/TZYxhAO9NJnkvjWIq2HthAyhc3Gf6zkVs
         gyR2pPB8xG4xtk+B9Lgb6UQUWn4iH+wP01YtVozqGordDnW+Qh1//ZWB8yePFgGAl6rj
         vlCGLoBWKMlqZMLUEyeXwO+8to9fu0Zz5OWQkvJT6WaoAI7lF5GkmywtFsOFaCZNFYfc
         7Q3GtWH7ZX+brp7v0r3mpvstlZoqncz4AkRnXxjm5CQ/2ENuxUH1ICtYpgRGA4+GYwEF
         s9bJYnuoatWw2YVDF1z4He6yWzfqJpzFWwfYDDomZaS3to6DtYDRujgeTzkn49I/NN3/
         FhJg==
X-Gm-Message-State: AOAM5331MnOjKsRmomwUodxGWAdBp/UoEKdLH2rdwhl0XWqZtaELOoqM
        Yfc12J9LqrjlD7vge4tzlhG9vw==
X-Google-Smtp-Source: ABdhPJxEdmwP8K6Xh2thladeJiDTTJl9AykTfJtSWOWgDzFWoDz5+ZlvIOjmVNrUtl5sto5e2q1FNw==
X-Received: by 2002:a17:902:b288:b029:f8:fb4f:f8d3 with SMTP id u8-20020a170902b288b02900f8fb4ff8d3mr340757plr.25.1623861649012;
        Wed, 16 Jun 2021 09:40:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g204sm2655813pfb.107.2021.06.16.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:40:46 -0700 (PDT)
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
Subject: [PATCH v3 3/5] pstore/blk: Use the normal block device I/O path
Date:   Wed, 16 Jun 2021 09:40:41 -0700
Message-Id: <20210616164043.1221861-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616164043.1221861-1-keescook@chromium.org>
References: <20210616164043.1221861-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=d7a0d1871c46c87d312fa072b281fc2f84918c5c; i=SsOtgEq5qb4nZxhHBpq4SPkuFKirt6TdeGDEanJT//k=; m=oAlwYgOPy6cUOJBMN2N65cQmVA0MlO3aACbBT/7A9mM=; p=3go9GHfcbfGGvGSkn9vIl/DGa7s9OrV3LPAmJf69dw4=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKKYoACgkQiXL039xtwCb8SQ//Xf+ HUDAQKsgP4bL0ObAPGjY+vBfBxjRE9P2d8uUVBb3nSr5/g7hPjDPR/LjxCOaNZ9lIvzApH+Q/rb3h cIGjbX6H9H68GfGJ03QY97NISnoHDUK1wa9SHcgm2pBMeuy3j971itguPkjDjNsCI7023WMxnOyIM cIQxfpgwCD/E2reQZujVgJLMjk2iVM1KS+UI0ynJxIw9q8CzHaAeA+XV27jn6QQUwRRa4tcUUGTln 0AVb3gwRaTIKZOp00Y/CnuUNDoAuIJVoIhvzGZYHz7gBRiZkWFjhVFGPQiKX0KlE/MPL0ovk5xBTV vBWcUNmhnjNOyLZOX1Kn4e06pTMxKPkOgAlIHahPkBFw1Y/lzk8S706rmjiFYqyoeh/vkpYf+sKXV 7aIyy1JW5WfSU3d5bmN6Y2bEod9NLcQe53Mr20A9M7XstziS+PP6BypaplpDbDikVEBve/ZwxqagO O+l9jBf/wqEm1irOBX1gEjHGe+crc92fJuHYpkVVjhS37lUae+YnP+ODd2tLlf8J3zFrbGej/w8Py Yu+uOGMHZwZ2L99cW9uCpy4rISaaa4RPmGkNHM3BckbKDThV9w2gIe7678VH7foP6vYA/Axv8SLbx iYlUb00oXYvUddm8kWd9mdJTw1BJLaVSAYCYeLCJv7vBU8rziN/eBa6UrxgBvveo=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stop poking into block layer internals and just open the block device
file an use kernel_read and kernel_write on it. Note that this means
the transformation from name_to_dev_t can't be used anymore when
pstore_blk is loaded as a module: a full filesystem device path name
must be used instead. Additionally removes ":internal:" kerndoc link,
since no such documentation remains.

Co-developed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/pstore-blk.rst |   3 -
 fs/pstore/blk.c                          | 264 +++++++----------------
 2 files changed, 83 insertions(+), 184 deletions(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index 49d8149f8d32..79f6d23e8cda 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -227,8 +227,5 @@ For developer reference, here are all the important structures and APIs:
 .. kernel-doc:: include/linux/pstore_zone.h
    :internal:
 
-.. kernel-doc:: fs/pstore/blk.c
-   :internal:
-
 .. kernel-doc:: include/linux/pstore_blk.h
    :internal:
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 7d8e5a1ddd5b..dc5ff763d414 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -8,15 +8,16 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include "../../block/blk.h"
 #include <linux/blkdev.h>
 #include <linux/string.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pstore_blk.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init_syscalls.h>
 #include <linux/mount.h>
-#include <linux/uio.h>
 
 static long kmsg_size = CONFIG_PSTORE_BLK_KMSG_SIZE;
 module_param(kmsg_size, long, 0400);
@@ -60,23 +61,25 @@ MODULE_PARM_DESC(best_effort, "use best effort to write (i.e. do not require sto
  *
  * Usually, this will be a partition of a block device.
  *
- * blkdev accepts the following variants:
- * 1) <hex_major><hex_minor> device number in hexadecimal representation,
- *    with no leading 0x, for example b302.
- * 2) /dev/<disk_name> represents the device number of disk
- * 3) /dev/<disk_name><decimal> represents the device number
+ * blkdev accepts the following variants, when built as a module:
+ * 1) /dev/<disk_name> represents the device number of disk
+ * 2) /dev/<disk_name><decimal> represents the device number
  *    of partition - device number of disk plus the partition number
- * 4) /dev/<disk_name>p<decimal> - same as the above, that form is
+ * 3) /dev/<disk_name>p<decimal> - same as the above, that form is
  *    used when disk name of partitioned disk ends on a digit.
- * 5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
+ *
+ * blkdev accepts the following variants when built into the kernel:
+ * 1) <hex_major><hex_minor> device number in hexadecimal representation,
+ *    with no leading 0x, for example b302.
+ * 2) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
  *    unique id of a partition if the partition table provides it.
  *    The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
  *    partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
  *    filled hex representation of the 32-bit "NT disk signature", and PP
  *    is a zero-filled hex representation of the 1-based partition number.
- * 6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
+ * 3) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
  *    a partition with a known unique id.
- * 7) <major>:<minor> major and minor number of the device separated by
+ * 4) <major>:<minor> major and minor number of the device separated by
  *    a colon.
  */
 static char blkdev[80] = CONFIG_PSTORE_BLK_BLKDEV;
@@ -88,15 +91,9 @@ MODULE_PARM_DESC(blkdev, "block device for pstore storage");
  * during the register/unregister functions.
  */
 static DEFINE_MUTEX(pstore_blk_lock);
-static struct block_device *psblk_bdev;
+static struct file *psblk_file;
 static struct pstore_zone_info *pstore_zone_info;
 
-struct bdev_info {
-	dev_t devt;
-	sector_t nr_sects;
-	sector_t start_sect;
-};
-
 #define check_size(name, alignsize) ({				\
 	long _##name_ = (name);					\
 	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
@@ -219,203 +216,73 @@ void unregister_pstore_device(struct pstore_device_info *dev)
 }
 EXPORT_SYMBOL_GPL(unregister_pstore_device);
 
-/**
- * psblk_get_bdev() - open block device
- *
- * @holder:	Exclusive holder identifier
- * @info:	Information about bdev to fill in
- *
- * Return: pointer to block device on success and others on error.
- *
- * On success, the returned block_device has reference count of one.
- */
-static struct block_device *psblk_get_bdev(void *holder,
-					   struct bdev_info *info)
-{
-	struct block_device *bdev = ERR_PTR(-ENODEV);
-	fmode_t mode = FMODE_READ | FMODE_WRITE;
-	sector_t nr_sects;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	if (pstore_zone_info)
-		return ERR_PTR(-EBUSY);
-
-	if (!blkdev[0])
-		return ERR_PTR(-ENODEV);
-
-	if (holder)
-		mode |= FMODE_EXCL;
-	bdev = blkdev_get_by_path(blkdev, mode, holder);
-	if (IS_ERR(bdev)) {
-		dev_t devt;
-
-		devt = name_to_dev_t(blkdev);
-		if (devt == 0)
-			return ERR_PTR(-ENODEV);
-		bdev = blkdev_get_by_dev(devt, mode, holder);
-		if (IS_ERR(bdev))
-			return bdev;
-	}
-
-	nr_sects = bdev_nr_sectors(bdev);
-	if (!nr_sects) {
-		pr_err("not enough space for '%s'\n", blkdev);
-		blkdev_put(bdev, mode);
-		return ERR_PTR(-ENOSPC);
-	}
-
-	if (info) {
-		info->devt = bdev->bd_dev;
-		info->nr_sects = nr_sects;
-		info->start_sect = get_start_sect(bdev);
-	}
-
-	return bdev;
-}
-
-static void psblk_put_bdev(struct block_device *bdev, void *holder)
-{
-	fmode_t mode = FMODE_READ | FMODE_WRITE;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	if (!bdev)
-		return;
-
-	if (holder)
-		mode |= FMODE_EXCL;
-	blkdev_put(bdev, mode);
-}
-
 static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
 {
-	struct block_device *bdev = psblk_bdev;
-	struct file file;
-	struct kiocb kiocb;
-	struct iov_iter iter;
-	struct kvec iov = {.iov_base = buf, .iov_len = bytes};
-
-	if (!bdev)
-		return -ENODEV;
-
-	memset(&file, 0, sizeof(struct file));
-	file.f_mapping = bdev->bd_inode->i_mapping;
-	file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
-	file.f_inode = bdev->bd_inode;
-	file_ra_state_init(&file.f_ra, file.f_mapping);
-
-	init_sync_kiocb(&kiocb, &file);
-	kiocb.ki_pos = pos;
-	iov_iter_kvec(&iter, READ, &iov, 1, bytes);
-
-	return generic_file_read_iter(&kiocb, &iter);
+	return kernel_read(psblk_file, buf, bytes, &pos);
 }
 
 static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
 		loff_t pos)
 {
-	struct block_device *bdev = psblk_bdev;
-	struct iov_iter iter;
-	struct kiocb kiocb;
-	struct file file;
-	ssize_t ret;
-	struct kvec iov = {.iov_base = (void *)buf, .iov_len = bytes};
-
-	if (!bdev)
-		return -ENODEV;
-
 	/* Console/Ftrace backend may handle buffer until flush dirty zones */
 	if (in_interrupt() || irqs_disabled())
 		return -EBUSY;
-
-	memset(&file, 0, sizeof(struct file));
-	file.f_mapping = bdev->bd_inode->i_mapping;
-	file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
-	file.f_inode = bdev->bd_inode;
-
-	init_sync_kiocb(&kiocb, &file);
-	kiocb.ki_pos = pos;
-	iov_iter_kvec(&iter, WRITE, &iov, 1, bytes);
-
-	inode_lock(bdev->bd_inode);
-	ret = generic_write_checks(&kiocb, &iter);
-	if (ret > 0)
-		ret = generic_perform_write(&file, &iter, pos);
-	inode_unlock(bdev->bd_inode);
-
-	if (likely(ret > 0)) {
-		const struct file_operations f_op = {.fsync = blkdev_fsync};
-
-		file.f_op = &f_op;
-		kiocb.ki_pos += ret;
-		ret = generic_write_sync(&kiocb, ret);
-	}
-	return ret;
+	return kernel_write(psblk_file, buf, bytes, &pos);
 }
 
 /*
  * This takes its configuration only from the module parameters now.
- * See psblk_get_bdev() and blkdev.
  */
-static int __register_pstore_blk(void)
+static int __register_pstore_blk(const char *devpath)
 {
-	char bdev_name[BDEVNAME_SIZE];
-	struct block_device *bdev;
-	struct pstore_device_info dev;
-	struct bdev_info binfo;
-	void *holder = blkdev;
+	struct pstore_device_info dev = {
+		.read = psblk_generic_blk_read,
+		.write = psblk_generic_blk_write,
+	};
+	struct inode *inode;
 	int ret = -ENODEV;
 
 	lockdep_assert_held(&pstore_blk_lock);
 
-	/* hold bdev exclusively */
-	memset(&binfo, 0, sizeof(binfo));
-	bdev = psblk_get_bdev(holder, &binfo);
-	if (IS_ERR(bdev)) {
-		pr_err("failed to open '%s'!\n", blkdev);
-		return PTR_ERR(bdev);
+	psblk_file = filp_open(devpath, O_RDWR | O_DSYNC | O_NOATIME | O_EXCL, 0);
+	if (IS_ERR(psblk_file)) {
+		ret = PTR_ERR(psblk_file);
+		pr_err("failed to open '%s': %d!\n", devpath, ret);
+		goto err;
 	}
 
-	/* only allow driver matching the @blkdev */
-	if (!binfo.devt) {
-		pr_debug("no major\n");
-		ret = -ENODEV;
-		goto err_put_bdev;
+	inode = file_inode(psblk_file);
+	if (!S_ISBLK(inode->i_mode)) {
+		pr_err("'%s' is not block device!\n", devpath);
+		goto err_fput;
 	}
 
-	/* psblk_bdev must be assigned before register to pstore/blk */
-	psblk_bdev = bdev;
-
-	memset(&dev, 0, sizeof(dev));
-	dev.total_size = binfo.nr_sects << SECTOR_SHIFT;
-	dev.read = psblk_generic_blk_read;
-	dev.write = psblk_generic_blk_write;
+	inode = I_BDEV(psblk_file->f_mapping->host)->bd_inode;
+	dev.total_size = i_size_read(inode);
 
 	ret = __register_pstore_device(&dev);
 	if (ret)
-		goto err_put_bdev;
+		goto err_fput;
 
-	bdevname(bdev, bdev_name);
-	pr_info("attached %s (no dedicated panic_write!)\n", bdev_name);
 	return 0;
 
-err_put_bdev:
-	psblk_bdev = NULL;
-	psblk_put_bdev(bdev, holder);
+err_fput:
+	fput(psblk_file);
+err:
+	psblk_file = NULL;
+
 	return ret;
 }
 
-static void __unregister_pstore_blk(unsigned int major)
+static void __unregister_pstore_blk(struct file *device)
 {
 	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
-	void *holder = blkdev;
 
 	lockdep_assert_held(&pstore_blk_lock);
-	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
+	if (psblk_file && psblk_file == device) {
 		__unregister_pstore_device(&dev);
-		psblk_put_bdev(psblk_bdev, holder);
-		psblk_bdev = NULL;
+		fput(psblk_file);
+		psblk_file = NULL;
 	}
 }
 
@@ -433,13 +300,48 @@ int pstore_blk_get_config(struct pstore_blk_config *info)
 }
 EXPORT_SYMBOL_GPL(pstore_blk_get_config);
 
+
+#ifndef MODULE
+static const char devname[] = "/dev/pstore-blk";
+static __init const char *early_boot_devpath(const char *initial_devname)
+{
+	/*
+	 * During early boot the real root file system hasn't been
+	 * mounted yet, and no device nodes are present yet. Use the
+	 * same scheme to find the device that we use for mounting
+	 * the root file system.
+	 */
+	dev_t dev = name_to_dev_t(initial_devname);
+
+	if (!dev) {
+		pr_err("failed to resolve '%s'!\n", initial_devname);
+		return initial_devname;
+	}
+
+	init_unlink(devname);
+	init_mknod(devname, S_IFBLK | 0600, new_encode_dev(dev));
+
+	return devname;
+}
+#else
+static inline const char *early_boot_devpath(const char *initial_devname)
+{
+	return initial_devname;
+}
+#endif
+
 static int __init pstore_blk_init(void)
 {
 	int ret = 0;
 
 	mutex_lock(&pstore_blk_lock);
-	if (!pstore_zone_info && best_effort && blkdev[0])
-		ret = __register_pstore_blk();
+	if (!pstore_zone_info && best_effort && blkdev[0]) {
+		ret = __register_pstore_blk(early_boot_devpath(blkdev));
+		if (ret == 0 && pstore_zone_info)
+			pr_info("attached %s:%s (%zu) (no dedicated panic_write!)\n",
+				pstore_zone_info->name, blkdev,
+				pstore_zone_info->total_size);
+	}
 	mutex_unlock(&pstore_blk_lock);
 
 	return ret;
@@ -449,8 +351,8 @@ late_initcall(pstore_blk_init);
 static void __exit pstore_blk_exit(void)
 {
 	mutex_lock(&pstore_blk_lock);
-	if (psblk_bdev)
-		__unregister_pstore_blk(MAJOR(psblk_bdev->bd_dev));
+	if (psblk_file)
+		__unregister_pstore_blk(psblk_file);
 	else {
 		struct pstore_device_info dev = { };
 
-- 
2.25.1

