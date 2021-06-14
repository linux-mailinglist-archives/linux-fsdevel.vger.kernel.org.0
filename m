Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE33A6FC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhFNUGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhFNUGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:06:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DFFC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 13:04:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z26so11407575pfj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DeFbcc5UoyRBkZKlbWQgafPlksRPTewxcDrzpOeBUs8=;
        b=FZrLjyV3eCGvZa91krPQmv9byIFKuqcqLbpFBABm8GJgNLnrXA4bIBGDp4/SE4o1M0
         f2IFkeV+0Bzrzl7HJmPxq2E09jLhs+XLUYi5P0i+HxXb6IB1rcuakEaxJMjHTw+4SQsD
         zP1GNVNfj1SZn9Jtz2pdVRNZLI0Q1IxqGiD+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DeFbcc5UoyRBkZKlbWQgafPlksRPTewxcDrzpOeBUs8=;
        b=hRQBuzpoAjsOcHqEdEm1BhKRbNyQ+2K0JWbqUZtWUrpXdGeBuBGnZNJKvoTNREDoJB
         jReUF3WYtZZoDS88UIDVBqwfnJ17MxhW3eFQgAi/vTGqEmqLYZhWOVCjmIYM5Dz5v+3W
         4y3oyea1urT7L8+IjuxSYk+MygY/FCWHczmsf0Z1/LafV6aDkZJh1O38NnbWsTJMkWON
         9sF43fnoaklS1TzEe+wxaHk/St/euMQU7uyo3X1OY6EGPJVSZVUeA6eiqstENhuEDxXf
         yTnDRX/IoNMxqNKYuH8SjBXyW8wIqxs3WT7xIl2FWPaKzTONuuXATvx8mrfkaFJI4eg0
         Aogg==
X-Gm-Message-State: AOAM532Noe1NE0sOZNNowSELub25ut71RIzMidIXs7so0gxHQKb3ihCP
        A4oPeHsAr+leCrQGbWFNht2eyA==
X-Google-Smtp-Source: ABdhPJzrBXlOpgj2H/rKYQUAmvgNau/HMClGIivIrFe0uzmZW+d/J+GXkYooHtmP/jc4ciNwhMprxQ==
X-Received: by 2002:aa7:9885:0:b029:2ea:25ce:3ad2 with SMTP id r5-20020aa798850000b02902ea25ce3ad2mr749069pfl.76.1623701064539;
        Mon, 14 Jun 2021 13:04:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q4sm13866481pfh.18.2021.06.14.13.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 13:04:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>, axboe@kernel.dk,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] pstore/blk: Use the normal block device I/O path
Date:   Mon, 14 Jun 2021 13:04:21 -0700
Message-Id: <20210614200421.2702002-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=071182d1a03cc0a742799c4b403abd38a59867ea; i=SsOtgEq5qb4nZxhHBpq4SPkuFKirt6TdeGDEanJT//k=; m=AX20vtCwKnCA9lIRJQ6C3o1nYyFB2hBR6BVOnkiJdKA=; p=roVjiiqqUV983gyLRn5ZPfVlwUIii5SlAMgvt0PIUmc=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDHtkQACgkQiXL039xtwCZgjxAAhaW cuCqkh6q1lWjAOtaaQPKqD7cP3ogLwzoRY4dB6Kq0cu3VkmJjwxrorbbfVSXFPkPoJIn6pFrRCM1k YUZCncyHzz8Pl8GJ3tz6gpUaS0rNTFcjehNvRc0Np0iLe0hCexNhp/U6TW6Np8NzNen8Rq/oi9PDg Gn/GfvzJg1i1KdCZYjlT0wL8oTiNU2zCnIIxeK65aiTZkAGiaKgL8g0DNzpcyHp+xoH3xC8N31H4N Fdfk4P1uaO9tkD1yf3jDw81Gm+VXzQD6kU8pFSCl+0T8lYD/6wVzdfhmhYJ3bTorqQokoVr/38DJE bPM2pk7MGPEK9v4y3cYdtnwS5E0PkmdVdI8wQavpc9mmIMmLvvmIQCWXlRHL1ucJDHUuiS/0wxaMi Ahdqbu7zYR+F1vwnAiXaiS86hiHLH6NrrCXCaq49GcsD/swsfEw5TS63QgL6+Z6ui2oRGwkVDlff4 Z48vx8MSDVM8oTTTvZNCDWwqBy9d/tX0GdGAY/UGfy55mpZQ9+GbVajoimV3ULwLHomjFNAyQ4hpb Xc4KFvbwiGCmNR5V8TPKww8C0gaeHF5h9aCi9zQCOGhZV6RYmL9ZsQkIi0TpjCZZ+6semz4A3VkSl MixXZ01FPIQ0ugZGz3cDj+cyYa2LAvDJVHOYTZE5D5/HfHagw6s/gfAy49txj0Eg=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stop poking into block layer internals and just open the block device
file an use kernel_read and kernel_write on it. Note that this means
the transformation from name_to_dev_t can't be used anymore when
pstore_blk is loaded as a module: a full filesystem device path name
must be used instead.

Co-developed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This reworks hch's proposal from
https://lore.kernel.org/lkml/20201016132047.3068029-9-hch@lst.de/
---
 fs/pstore/blk.c | 262 ++++++++++++++++--------------------------------
 1 file changed, 84 insertions(+), 178 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 4bb8a344957a..35458445cbd4 100644
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
@@ -114,8 +111,19 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 
 	lockdep_assert_held(&pstore_blk_lock);
 
-	if (!dev || !dev->total_size || !dev->read || !dev->write)
+	if (!dev || !dev->total_size || !dev->read || !dev->write) {
+		if (!dev)
+			pr_err("NULL device info\n");
+		else {
+			if (!dev->total_size)
+				pr_err("zero sized device\n");
+			if (!dev->read)
+				pr_err("no read handler for device\n");
+			if (!dev->write)
+				pr_err("no write handler for device\n");
+		}
 		return -EINVAL;
+	}
 
 	/* someone already registered before */
 	if (pstore_zone_info)
@@ -205,203 +213,101 @@ void unregister_pstore_device(struct pstore_device_info *dev)
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
 static int __register_pstore_blk(void)
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
 	int ret = -ENODEV;
 
 	lockdep_assert_held(&pstore_blk_lock);
 
-	/* hold bdev exclusively */
-	memset(&binfo, 0, sizeof(binfo));
-	bdev = psblk_get_bdev(holder, &binfo);
-	if (IS_ERR(bdev)) {
-		pr_err("failed to open '%s'!\n", blkdev);
-		return PTR_ERR(bdev);
+	if (!__is_defined(MODULE)) {
+		/*
+		 * During early boot the real root file system hasn't been
+		 * mounted yet, and no device nodes are present yet. Use the
+		 * same scheme to find the device that we use for mounting
+		 * the root file system.
+		 */
+		static const char devname[] = "/dev/pstore-blk";
+		dev_t dev = name_to_dev_t(blkdev);
+
+		if (!dev) {
+			pr_err("failed to resolve '%s'!\n", blkdev);
+			goto err;
+		}
+
+		init_unlink(devname);
+		init_mknod(devname, S_IFBLK | 0600, new_encode_dev(dev));
+		strscpy(blkdev, devname, sizeof(blkdev));
 	}
 
-	/* only allow driver matching the @blkdev */
-	if (!binfo.devt) {
-		pr_debug("no major\n");
-		ret = -ENODEV;
-		goto err_put_bdev;
+	psblk_file = filp_open(blkdev, O_RDWR | O_DSYNC | O_NOATIME | O_EXCL, 0);
+	if (IS_ERR(psblk_file)) {
+		ret = PTR_ERR(psblk_file);
+		pr_err("failed to open '%s': %d!\n", blkdev, ret);
+		goto err;
 	}
 
-	/* psblk_bdev must be assigned before register to pstore/blk */
-	psblk_bdev = bdev;
+	if (!S_ISBLK(file_inode(psblk_file)->i_mode)) {
+		pr_err("'%s' is not block device!\n", blkdev);
+		goto err_fput;
+	}
 
-	memset(&dev, 0, sizeof(dev));
-	dev.total_size = binfo.nr_sects << SECTOR_SHIFT;
-	dev.read = psblk_generic_blk_read;
-	dev.write = psblk_generic_blk_write;
+	if (!psblk_file->f_mapping)
+		pr_err("missing f_mapping\n");
+	else if (!psblk_file->f_mapping->host)
+		pr_err("missing host\n");
+	else if (!I_BDEV(psblk_file->f_mapping->host))
+		pr_err("missing I_BDEV\n");
+	else if (!I_BDEV(psblk_file->f_mapping->host)->bd_inode)
+		pr_err("missing bd_inode\n");
+	else
+		dev.total_size = i_size_read(I_BDEV(psblk_file->f_mapping->host)->bd_inode);
 
 	ret = __register_pstore_device(&dev);
 	if (ret)
-		goto err_put_bdev;
+		goto err_fput;
 
-	bdevname(bdev, bdev_name);
-	pr_info("attached %s (no dedicated panic_write!)\n", bdev_name);
+	pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
+		blkdev, dev.total_size);
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
 
@@ -435,8 +341,8 @@ late_initcall(pstore_blk_init);
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

