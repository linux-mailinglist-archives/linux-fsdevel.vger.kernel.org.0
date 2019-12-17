Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC041239A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLQWTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:19:33 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:58457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLQWTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:19:33 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHX7f-1iTskR0T7B-00DVzz; Tue, 17 Dec 2019 23:17:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 24/27] compat_ioctl: block: move blkdev_compat_ioctl() into ioctl.c
Date:   Tue, 17 Dec 2019 23:17:05 +0100
Message-Id: <20191217221708.3730997-25-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PSAD9bl0CFKl/aF5LKUPzusxXoxLYNJ5KzrK6e2MQW/9n3CWnjv
 YS4eBKkXR1HztidqHI91DDyXR/AQfN87JIhMu94SIu4GxAELbMeRJVmpCa6nOBSmtEasanl
 AZE7bG2pC1HRVU9ryXnwF5XG5ymueLsxU/kTFX+LrhBBYUcVVHLF2nZI3tqzs9q4fJz9dmN
 zRS+YuAuqB0r/0v+rTEpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gbhqN5RdKj0=:BWK8lhBEG/MD40PIuhTUnG
 YyDSCscLh9YKImGCbbZipadpWoCh10HeOaNyzo1PaxTLF4rN9pzZYFp2t5ntmeiTZbHfoaCe0
 3cotpxM/Eb1shhdcImLbF6GRrJqKUhruGnep5BCSyf/MuVThSQ/DxzWt3EUmiC6cvZ8YBSQJy
 ZnHHZtrS70kowS/WIyRQCz5g5ypBBZmXHSGE+8V49MJQrGY5kbb1bqG2yXzBrLwovSWJ7M2vy
 dKtq4nrrHcA7Htra+aDTXJqavU1ul99amdZ81t9xuwOLlTdGKGGgoLtX7dNYOuJ7KVJ5ph2Ko
 IGFwCNKZH50bZi+DbHiIv6INtG3I8jNzZ0wBwBsvexAcg5kbjDi65qJuTe3dH7jK9gUrwn0cX
 kumKT2I94RYeeO6mhl+lBdau2ppo8YOslhuObl62S7i861y4voirlm9eDKPMAPPtdTJ7XAjdv
 fTdeoH+aDVL3CbwAeipSQYE3gUixsRGuKHk425h4PZaJkwF+oCitrM0pdzBl37vnOB1YuVJxc
 XkEk6OgqxwypuyZCSmMUr3ujKwTRYAo6MbFj7oJEwCT9nezvq+Psdjwngb2/L1/3286e3Hwol
 3DBrkgZZHpDeoGEZmkr/KEUKaGF+FTytTvUB3JPeerPi5484jRWVYGD+UYWzfBKsgzZvG4IjE
 maAvR5WrNc2Vc49PSNk0aTOAj8D4j5F1m8cPzHI69Do/3WHA6hivRG41ihl1/YJmdDT42kkLO
 FEG24mrkj42RCIc0k7ZJpc6oVx06fi5a8KDd+Oorx655Y5+EeN3NGq2OX0imStKFInD0flEqo
 WpoBJAHn0Pu3+DST8DW+Ow28tRRW5Q/l6gfIoqa42qGwDHFyprv4yld/kyZop0h+oPHh9pO4c
 XaD08gxbDhYNk5xezrZg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Having both in the same file allows a number of simplifications
to the compat path, and makes it more likely that changes to
the native path get applied to the compat version as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/Makefile       |   1 -
 block/compat_ioctl.c | 225 -------------------------------------------
 block/ioctl.c        | 219 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+), 226 deletions(-)
 delete mode 100644 block/compat_ioctl.c

diff --git a/block/Makefile b/block/Makefile
index 205a5f2fef17..1f70c73ea83d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
-obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
deleted file mode 100644
index 765aa5357655..000000000000
--- a/block/compat_ioctl.c
+++ /dev/null
@@ -1,225 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/blkdev.h>
-#include <linux/blkpg.h>
-#include <linux/blktrace_api.h>
-#include <linux/cdrom.h>
-#include <linux/compat.h>
-#include <linux/elevator.h>
-#include <linux/hdreg.h>
-#include <linux/slab.h>
-#include <linux/syscalls.h>
-#include <linux/types.h>
-#include <linux/uaccess.h>
-
-static int compat_put_ushort(unsigned long arg, unsigned short val)
-{
-	return put_user(val, (unsigned short __user *)compat_ptr(arg));
-}
-
-static int compat_put_int(unsigned long arg, int val)
-{
-	return put_user(val, (compat_int_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_uint(unsigned long arg, unsigned int val)
-{
-	return put_user(val, (compat_uint_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_long(unsigned long arg, long val)
-{
-	return put_user(val, (compat_long_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_ulong(unsigned long arg, compat_ulong_t val)
-{
-	return put_user(val, (compat_ulong_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_u64(unsigned long arg, u64 val)
-{
-	return put_user(val, (compat_u64 __user *)compat_ptr(arg));
-}
-
-struct compat_hd_geometry {
-	unsigned char heads;
-	unsigned char sectors;
-	unsigned short cylinders;
-	u32 start;
-};
-
-static int compat_hdio_getgeo(struct gendisk *disk, struct block_device *bdev,
-			struct compat_hd_geometry __user *ugeo)
-{
-	struct hd_geometry geo;
-	int ret;
-
-	if (!ugeo)
-		return -EINVAL;
-	if (!disk->fops->getgeo)
-		return -ENOTTY;
-
-	memset(&geo, 0, sizeof(geo));
-	/*
-	 * We need to set the startsect first, the driver may
-	 * want to override it.
-	 */
-	geo.start = get_start_sect(bdev);
-	ret = disk->fops->getgeo(bdev, &geo);
-	if (ret)
-		return ret;
-
-	ret = copy_to_user(ugeo, &geo, 4);
-	ret |= put_user(geo.start, &ugeo->start);
-	if (ret)
-		ret = -EFAULT;
-
-	return ret;
-}
-
-struct compat_blkpg_ioctl_arg {
-	compat_int_t op;
-	compat_int_t flags;
-	compat_int_t datalen;
-	compat_caddr_t data;
-};
-
-static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, struct compat_blkpg_ioctl_arg __user *ua32)
-{
-	struct blkpg_ioctl_arg __user *a = compat_alloc_user_space(sizeof(*a));
-	compat_caddr_t udata;
-	compat_int_t n;
-	int err;
-
-	err = get_user(n, &ua32->op);
-	err |= put_user(n, &a->op);
-	err |= get_user(n, &ua32->flags);
-	err |= put_user(n, &a->flags);
-	err |= get_user(n, &ua32->datalen);
-	err |= put_user(n, &a->datalen);
-	err |= get_user(udata, &ua32->data);
-	err |= put_user(compat_ptr(udata), &a->data);
-	if (err)
-		return err;
-
-	return blkdev_ioctl(bdev, mode, cmd, (unsigned long)a);
-}
-
-#define BLKBSZGET_32		_IOR(0x12, 112, int)
-#define BLKBSZSET_32		_IOW(0x12, 113, int)
-#define BLKGETSIZE64_32		_IOR(0x12, 114, int)
-
-/* Most of the generic ioctls are handled in the normal fallback path.
-   This assumes the blkdev's low level compat_ioctl always returns
-   ENOIOCTLCMD for unknown ioctls. */
-long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
-{
-	int ret = -ENOIOCTLCMD;
-	struct inode *inode = file->f_mapping->host;
-	struct block_device *bdev = inode->i_bdev;
-	struct gendisk *disk = bdev->bd_disk;
-	fmode_t mode = file->f_mode;
-	loff_t size;
-	unsigned int max_sectors;
-
-	/*
-	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
-	 * to updated it before every ioctl.
-	 */
-	if (file->f_flags & O_NDELAY)
-		mode |= FMODE_NDELAY;
-	else
-		mode &= ~FMODE_NDELAY;
-
-	switch (cmd) {
-	case HDIO_GETGEO:
-		return compat_hdio_getgeo(disk, bdev, compat_ptr(arg));
-	case BLKPBSZGET:
-		return compat_put_uint(arg, bdev_physical_block_size(bdev));
-	case BLKIOMIN:
-		return compat_put_uint(arg, bdev_io_min(bdev));
-	case BLKIOOPT:
-		return compat_put_uint(arg, bdev_io_opt(bdev));
-	case BLKALIGNOFF:
-		return compat_put_int(arg, bdev_alignment_offset(bdev));
-	case BLKDISCARDZEROES:
-		return compat_put_uint(arg, 0);
-	case BLKFLSBUF:
-	case BLKROSET:
-	case BLKDISCARD:
-	case BLKSECDISCARD:
-	case BLKZEROOUT:
-	/*
-	 * the ones below are implemented in blkdev_locked_ioctl,
-	 * but we call blkdev_ioctl, which gets the lock for us
-	 */
-	case BLKRRPART:
-	case BLKREPORTZONE:
-	case BLKRESETZONE:
-	case BLKOPENZONE:
-	case BLKCLOSEZONE:
-	case BLKFINISHZONE:
-	case BLKGETZONESZ:
-	case BLKGETNRZONES:
-		return blkdev_ioctl(bdev, mode, cmd,
-				(unsigned long)compat_ptr(arg));
-	case BLKBSZSET_32:
-		return blkdev_ioctl(bdev, mode, BLKBSZSET,
-				(unsigned long)compat_ptr(arg));
-	case BLKPG:
-		return compat_blkpg_ioctl(bdev, mode, cmd, compat_ptr(arg));
-	case BLKRAGET:
-	case BLKFRAGET:
-		if (!arg)
-			return -EINVAL;
-		return compat_put_long(arg,
-			       (bdev->bd_bdi->ra_pages * PAGE_SIZE) / 512);
-	case BLKROGET: /* compatible */
-		return compat_put_int(arg, bdev_read_only(bdev) != 0);
-	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
-		return compat_put_int(arg, block_size(bdev));
-	case BLKSSZGET: /* get block device hardware sector size */
-		return compat_put_int(arg, bdev_logical_block_size(bdev));
-	case BLKSECTGET:
-		max_sectors = min_t(unsigned int, USHRT_MAX,
-				    queue_max_sectors(bdev_get_queue(bdev)));
-		return compat_put_ushort(arg, max_sectors);
-	case BLKROTATIONAL:
-		return compat_put_ushort(arg,
-					 !blk_queue_nonrot(bdev_get_queue(bdev)));
-	case BLKRASET: /* compatible, but no compat_ptr (!) */
-	case BLKFRASET:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
-		return 0;
-	case BLKGETSIZE:
-		size = i_size_read(bdev->bd_inode);
-		if ((size >> 9) > ~0UL)
-			return -EFBIG;
-		return compat_put_ulong(arg, size >> 9);
-
-	case BLKGETSIZE64_32:
-		return compat_put_u64(arg, i_size_read(bdev->bd_inode));
-
-	case BLKTRACESETUP32:
-	case BLKTRACESTART: /* compatible */
-	case BLKTRACESTOP:  /* compatible */
-	case BLKTRACETEARDOWN: /* compatible */
-		ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
-		return ret;
-	case IOC_PR_REGISTER:
-	case IOC_PR_RESERVE:
-	case IOC_PR_RELEASE:
-	case IOC_PR_PREEMPT:
-	case IOC_PR_PREEMPT_ABORT:
-	case IOC_PR_CLEAR:
-		return blkdev_ioctl(bdev, mode, cmd,
-				(unsigned long)compat_ptr(arg));
-	default:
-		if (disk->fops->compat_ioctl)
-			ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
-		return ret;
-	}
-}
diff --git a/block/ioctl.c b/block/ioctl.c
index e728331d1a5b..f8c4e2649335 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -269,6 +269,38 @@ static int put_u64(unsigned long arg, u64 val)
 	return put_user(val, (u64 __user *)arg);
 }
 
+#ifdef CONFIG_COMPAT
+static int compat_put_ushort(unsigned long arg, unsigned short val)
+{
+	return put_user(val, (unsigned short __user *)compat_ptr(arg));
+}
+
+static int compat_put_int(unsigned long arg, int val)
+{
+	return put_user(val, (compat_int_t __user *)compat_ptr(arg));
+}
+
+static int compat_put_uint(unsigned long arg, unsigned int val)
+{
+	return put_user(val, (compat_uint_t __user *)compat_ptr(arg));
+}
+
+static int compat_put_long(unsigned long arg, long val)
+{
+	return put_user(val, (compat_long_t __user *)compat_ptr(arg));
+}
+
+static int compat_put_ulong(unsigned long arg, compat_ulong_t val)
+{
+	return put_user(val, (compat_ulong_t __user *)compat_ptr(arg));
+}
+
+static int compat_put_u64(unsigned long arg, u64 val)
+{
+	return put_user(val, (compat_u64 __user *)compat_ptr(arg));
+}
+#endif
+
 int __blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 			unsigned cmd, unsigned long arg)
 {
@@ -476,6 +508,44 @@ static int blkdev_getgeo(struct block_device *bdev,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+struct compat_hd_geometry {
+	unsigned char heads;
+	unsigned char sectors;
+	unsigned short cylinders;
+	u32 start;
+};
+
+static int compat_hdio_getgeo(struct gendisk *disk, struct block_device *bdev,
+			struct compat_hd_geometry __user *ugeo)
+{
+	struct hd_geometry geo;
+	int ret;
+
+	if (!ugeo)
+		return -EINVAL;
+	if (!disk->fops->getgeo)
+		return -ENOTTY;
+
+	memset(&geo, 0, sizeof(geo));
+	/*
+	 * We need to set the startsect first, the driver may
+	 * want to override it.
+	 */
+	geo.start = get_start_sect(bdev);
+	ret = disk->fops->getgeo(bdev, &geo);
+	if (ret)
+		return ret;
+
+	ret = copy_to_user(ugeo, &geo, 4);
+	ret |= put_user(geo.start, &ugeo->start);
+	if (ret)
+		ret = -EFAULT;
+
+	return ret;
+}
+#endif
+
 /* set the logical block size */
 static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 		int __user *argp)
@@ -604,3 +674,152 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	}
 }
 EXPORT_SYMBOL_GPL(blkdev_ioctl);
+
+#ifdef CONFIG_COMPAT
+struct compat_blkpg_ioctl_arg {
+	compat_int_t op;
+	compat_int_t flags;
+	compat_int_t datalen;
+	compat_caddr_t data;
+};
+
+static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, struct compat_blkpg_ioctl_arg __user *ua32)
+{
+	struct blkpg_ioctl_arg __user *a = compat_alloc_user_space(sizeof(*a));
+	compat_caddr_t udata;
+	compat_int_t n;
+	int err;
+
+	err = get_user(n, &ua32->op);
+	err |= put_user(n, &a->op);
+	err |= get_user(n, &ua32->flags);
+	err |= put_user(n, &a->flags);
+	err |= get_user(n, &ua32->datalen);
+	err |= put_user(n, &a->datalen);
+	err |= get_user(udata, &ua32->data);
+	err |= put_user(compat_ptr(udata), &a->data);
+	if (err)
+		return err;
+
+	return blkdev_ioctl(bdev, mode, cmd, (unsigned long)a);
+}
+
+#define BLKBSZGET_32		_IOR(0x12, 112, int)
+#define BLKBSZSET_32		_IOW(0x12, 113, int)
+#define BLKGETSIZE64_32		_IOR(0x12, 114, int)
+
+/* Most of the generic ioctls are handled in the normal fallback path.
+   This assumes the blkdev's low level compat_ioctl always returns
+   ENOIOCTLCMD for unknown ioctls. */
+long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+	struct inode *inode = file->f_mapping->host;
+	struct block_device *bdev = inode->i_bdev;
+	struct gendisk *disk = bdev->bd_disk;
+	fmode_t mode = file->f_mode;
+	loff_t size;
+	unsigned int max_sectors;
+
+	/*
+	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
+	 * to updated it before every ioctl.
+	 */
+	if (file->f_flags & O_NDELAY)
+		mode |= FMODE_NDELAY;
+	else
+		mode &= ~FMODE_NDELAY;
+
+	switch (cmd) {
+	case HDIO_GETGEO:
+		return compat_hdio_getgeo(disk, bdev, compat_ptr(arg));
+	case BLKPBSZGET:
+		return compat_put_uint(arg, bdev_physical_block_size(bdev));
+	case BLKIOMIN:
+		return compat_put_uint(arg, bdev_io_min(bdev));
+	case BLKIOOPT:
+		return compat_put_uint(arg, bdev_io_opt(bdev));
+	case BLKALIGNOFF:
+		return compat_put_int(arg, bdev_alignment_offset(bdev));
+	case BLKDISCARDZEROES:
+		return compat_put_uint(arg, 0);
+	case BLKFLSBUF:
+	case BLKROSET:
+	case BLKDISCARD:
+	case BLKSECDISCARD:
+	case BLKZEROOUT:
+	/*
+	 * the ones below are implemented in blkdev_locked_ioctl,
+	 * but we call blkdev_ioctl, which gets the lock for us
+	 */
+	case BLKRRPART:
+	case BLKREPORTZONE:
+	case BLKRESETZONE:
+	case BLKOPENZONE:
+	case BLKCLOSEZONE:
+	case BLKFINISHZONE:
+	case BLKGETZONESZ:
+	case BLKGETNRZONES:
+		return blkdev_ioctl(bdev, mode, cmd,
+				(unsigned long)compat_ptr(arg));
+	case BLKBSZSET_32:
+		return blkdev_ioctl(bdev, mode, BLKBSZSET,
+				(unsigned long)compat_ptr(arg));
+	case BLKPG:
+		return compat_blkpg_ioctl(bdev, mode, cmd, compat_ptr(arg));
+	case BLKRAGET:
+	case BLKFRAGET:
+		if (!arg)
+			return -EINVAL;
+		return compat_put_long(arg,
+			       (bdev->bd_bdi->ra_pages * PAGE_SIZE) / 512);
+	case BLKROGET: /* compatible */
+		return compat_put_int(arg, bdev_read_only(bdev) != 0);
+	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
+		return compat_put_int(arg, block_size(bdev));
+	case BLKSSZGET: /* get block device hardware sector size */
+		return compat_put_int(arg, bdev_logical_block_size(bdev));
+	case BLKSECTGET:
+		max_sectors = min_t(unsigned int, USHRT_MAX,
+				    queue_max_sectors(bdev_get_queue(bdev)));
+		return compat_put_ushort(arg, max_sectors);
+	case BLKROTATIONAL:
+		return compat_put_ushort(arg,
+					 !blk_queue_nonrot(bdev_get_queue(bdev)));
+	case BLKRASET: /* compatible, but no compat_ptr (!) */
+	case BLKFRASET:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
+		return 0;
+	case BLKGETSIZE:
+		size = i_size_read(bdev->bd_inode);
+		if ((size >> 9) > ~0UL)
+			return -EFBIG;
+		return compat_put_ulong(arg, size >> 9);
+
+	case BLKGETSIZE64_32:
+		return compat_put_u64(arg, i_size_read(bdev->bd_inode));
+
+	case BLKTRACESETUP32:
+	case BLKTRACESTART: /* compatible */
+	case BLKTRACESTOP:  /* compatible */
+	case BLKTRACETEARDOWN: /* compatible */
+		ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
+		return ret;
+	case IOC_PR_REGISTER:
+	case IOC_PR_RESERVE:
+	case IOC_PR_RELEASE:
+	case IOC_PR_PREEMPT:
+	case IOC_PR_PREEMPT_ABORT:
+	case IOC_PR_CLEAR:
+		return blkdev_ioctl(bdev, mode, cmd,
+				(unsigned long)compat_ptr(arg));
+	default:
+		if (disk->fops->compat_ioctl)
+			ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
+		return ret;
+	}
+}
+#endif
-- 
2.20.0

