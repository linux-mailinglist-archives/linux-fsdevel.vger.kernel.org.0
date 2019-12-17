Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2012394F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLQWSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:18:07 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfLQWSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:18:06 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6KQZ-1haxi02lkf-016j9T; Tue, 17 Dec 2019 23:17:33 +0100
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
Subject: [PATCH v2 23/27] compat_ioctl: move HDIO ioctl handling into drivers/ide
Date:   Tue, 17 Dec 2019 23:17:04 +0100
Message-Id: <20191217221708.3730997-24-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/D1NP1hHpImcePmuJVorHaYd+oDnC0KYUns7AoRctoy/PRF56ag
 9CgmMYuITFsdIlxRzHhQw8J1VfVcH6qQTsSkVNSAlsbyOfutTv/edqbEYMOgCnp0U2Iivk5
 RQMhbBYtKLGmtbrm/n2NmsF6GdzfsRJe2Abcs0dmzn44BXZxnoMvi/3wH+hJDPM0jt6Kk2B
 Yc0JDsAWtxde8ZW02TWyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mSJF4exvfz4=:IusaUtG2jlMz6UDm/jSETr
 jkTYpg/QbJX4045dxbyAekcKRxji0NTwSyXV3k2jEd0N+iLvSLGbydTPfU7n+6APT7yGbwL+q
 Z+NMWhyp6cVzcv774FSjhYztehuFbu8mXbf8+URht4tTFtQk12D/SDb5Ysqrgbn8IUqnyoamL
 VpEVog+mtaT5tEr4k+AVwVjdc4d66QNblgdEGqsVqi8yMMYOoEbt+S0fOda3/ivT+M7vdlggI
 CWgbM40EGeunX6VOZ9MRReJBIU4asG98vjlgzegPQ1BjfrJFlBk8GNBbTU0Rwx+v5tzJriAcD
 5UAykD51fauLiZMHIVibtrY+iifPIPSXK+KnaaeIzJc8m8QjMQd4h58IlX5YPWfrPHolJpnNa
 kTuOfF9PP8tUD4WkWP443G/EZGrcm/aTUd3471GLc6lJgSSKgjs4ATaDCmM4hrZbhxUz0J/VV
 oUz2DX0hXb2OfBCoy1aeFyxZx9QoYNnTMDStrQFS+rv7O0PQtwwOv8HdfbknFF3kxXR7rOAAw
 uTnd8+r/g0BfajCRelRjhBr503Xmwwo+ksDxn3aIkRVjhlFPsTxSutl3fVFLVGcVWLHtJEVLE
 dBH39ye5Ku2ygusz1U4maVq1Ct6Magh1iW8FdyoinP9bAhkxmaUk4QY8T3TUO8Eh1C7YFWSmT
 SmGVqc+bBjukHhVQhA7ZVXM09KJ2+FlbFWGk39XISFdIrJwAUsfNwdmRXTCZmSF9hLnXBVSuW
 auquuH2DQWeU7A7gssPRpz78B/qUIFnGRITAIH+ghbZsGGzfzOXTw9EkbILQfQoX2o8fOuWWv
 SMGfy7BT4zkosYRSgm7PcmVcixITBdfq2o09So9KrVKf+uqYOOcTech+yDS7wCtYc7bu3Gt46
 OIAarc6M/aawxtr2aWJw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of the HDIO ioctls are only used by the obsolete drivers/ide
subsystem, these can be handled by changing ide_cmd_ioctl() to be aware
of compat mode and doing the correct transformations in place and using
it as both native and compat handlers for all drivers.

The SCSI drivers implementing the same commands are already doing
this in the drivers, so the compat_blkdev_driver_ioctl() function
is no longer needed now.

The BLKSECTSET and HDIO_GETGEO_BIG ioctls are not implemented
in any driver any more and no longer need any conversion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c           | 75 ----------------------------------
 drivers/ide/ide-cd.c           | 15 +++----
 drivers/ide/ide-disk.c         |  1 +
 drivers/ide/ide-floppy_ioctl.c |  7 ++--
 drivers/ide/ide-ioctls.c       | 44 ++++++++++++--------
 drivers/ide/ide-tape.c         | 11 +++++
 6 files changed, 51 insertions(+), 102 deletions(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 7cb534d6e767..765aa5357655 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -77,24 +77,6 @@ static int compat_hdio_getgeo(struct gendisk *disk, struct block_device *bdev,
 	return ret;
 }
 
-static int compat_hdio_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	unsigned long __user *p;
-	int error;
-
-	p = compat_alloc_user_space(sizeof(unsigned long));
-	error = __blkdev_driver_ioctl(bdev, mode,
-				cmd, (unsigned long)p);
-	if (error == 0) {
-		unsigned int __user *uvp = compat_ptr(arg);
-		unsigned long v;
-		if (get_user(v, p) || put_user(v, uvp))
-			error = -EFAULT;
-	}
-	return error;
-}
-
 struct compat_blkpg_ioctl_arg {
 	compat_int_t op;
 	compat_int_t flags;
@@ -128,61 +110,6 @@ static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
 #define BLKBSZSET_32		_IOW(0x12, 113, int)
 #define BLKGETSIZE64_32		_IOR(0x12, 114, int)
 
-static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
-			unsigned cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case HDIO_GET_UNMASKINTR:
-	case HDIO_GET_MULTCOUNT:
-	case HDIO_GET_KEEPSETTINGS:
-	case HDIO_GET_32BIT:
-	case HDIO_GET_NOWERR:
-	case HDIO_GET_DMA:
-	case HDIO_GET_NICE:
-	case HDIO_GET_WCACHE:
-	case HDIO_GET_ACOUSTIC:
-	case HDIO_GET_ADDRESS:
-	case HDIO_GET_BUSSTATE:
-		return compat_hdio_ioctl(bdev, mode, cmd, arg);
-
-	/*
-	 * No handler required for the ones below, we just need to
-	 * convert arg to a 64 bit pointer.
-	 */
-	case BLKSECTSET:
-	/*
-	 * 0x03 -- HD/IDE ioctl's used by hdparm and friends.
-	 *         Some need translations, these do not.
-	 */
-	case HDIO_GET_IDENTITY:
-	case HDIO_DRIVE_TASK:
-	case HDIO_DRIVE_CMD:
-	/* 0x330 is reserved -- it used to be HDIO_GETGEO_BIG */
-	case 0x330:
-		arg = (unsigned long)compat_ptr(arg);
-	/* These intepret arg as an unsigned long, not as a pointer,
-	 * so we must not do compat_ptr() conversion. */
-	case HDIO_SET_MULTCOUNT:
-	case HDIO_SET_UNMASKINTR:
-	case HDIO_SET_KEEPSETTINGS:
-	case HDIO_SET_32BIT:
-	case HDIO_SET_NOWERR:
-	case HDIO_SET_DMA:
-	case HDIO_SET_PIO_MODE:
-	case HDIO_SET_NICE:
-	case HDIO_SET_WCACHE:
-	case HDIO_SET_ACOUSTIC:
-	case HDIO_SET_BUSSTATE:
-	case HDIO_SET_ADDRESS:
-		break;
-	default:
-		/* unknown ioctl number */
-		return -ENOIOCTLCMD;
-	}
-
-	return __blkdev_driver_ioctl(bdev, mode, cmd, arg);
-}
-
 /* Most of the generic ioctls are handled in the normal fallback path.
    This assumes the blkdev's low level compat_ioctl always returns
    ENOIOCTLCMD for unknown ioctls. */
@@ -293,8 +220,6 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	default:
 		if (disk->fops->compat_ioctl)
 			ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
-		if (ret == -ENOIOCTLCMD)
-			ret = compat_blkdev_driver_ioctl(bdev, mode, cmd, arg);
 		return ret;
 	}
 }
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 2de6e8ace957..284a7a5bad54 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1711,7 +1711,6 @@ static int idecd_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
 static int idecd_locked_compat_ioctl(struct block_device *bdev, fmode_t mode,
 			unsigned int cmd, unsigned long arg)
 {
@@ -1727,8 +1726,12 @@ static int idecd_locked_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	}
 
-	return cdrom_ioctl(&info->devinfo, bdev, mode, cmd,
-			   (unsigned long)compat_ptr(arg));
+	err = generic_ide_ioctl(info->drive, bdev, cmd, arg);
+	if (err == -EINVAL)
+		err = cdrom_ioctl(&info->devinfo, bdev, mode, cmd,
+				  (unsigned long)compat_ptr(arg));
+
+	return err;
 }
 
 static int idecd_compat_ioctl(struct block_device *bdev, fmode_t mode,
@@ -1742,7 +1745,6 @@ static int idecd_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 	return ret;
 }
-#endif
 
 static unsigned int idecd_check_events(struct gendisk *disk,
 				       unsigned int clearing)
@@ -1765,9 +1767,8 @@ static const struct block_device_operations idecd_ops = {
 	.open			= idecd_open,
 	.release		= idecd_release,
 	.ioctl			= idecd_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= idecd_compat_ioctl,
-#endif
+	.compat_ioctl		= IS_ENABLED(CONFIG_COMPAT) ?
+				  idecd_compat_ioctl : NULL,
 	.check_events		= idecd_check_events,
 	.revalidate_disk	= idecd_revalidate_disk
 };
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 197912af5c2f..1d3407d7e095 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -794,4 +794,5 @@ const struct ide_disk_ops ide_ata_disk_ops = {
 	.set_doorlock		= ide_disk_set_doorlock,
 	.do_request		= ide_do_rw_disk,
 	.ioctl			= ide_disk_ioctl,
+	.compat_ioctl		= ide_disk_ioctl,
 };
diff --git a/drivers/ide/ide-floppy_ioctl.c b/drivers/ide/ide-floppy_ioctl.c
index 4fd70f804d6f..39a790ac6cc3 100644
--- a/drivers/ide/ide-floppy_ioctl.c
+++ b/drivers/ide/ide-floppy_ioctl.c
@@ -329,10 +329,9 @@ int ide_floppy_compat_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	if (cmd != CDROM_SEND_PACKET && cmd != SCSI_IOCTL_SEND_COMMAND)
 		err = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
 
-	/*
-	 * there is no generic_ide_compat_ioctl(), that is handled
-	 * through compat_blkdev_ioctl().
-	 */
+	if (err == -ENOTTY)
+		err = generic_ide_ioctl(drive, bdev, cmd, arg);
+
 out:
 	mutex_unlock(&ide_floppy_ioctl_mutex);
 	return err;
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index d48c17003874..f6497c817493 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -3,11 +3,20 @@
  * IDE ioctls handling.
  */
 
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/slab.h>
 
+static int put_user_long(long val, unsigned long arg)
+{
+	if (in_compat_syscall())
+		return put_user(val, (compat_long_t __user *)compat_ptr(arg));
+
+	return put_user(val, (long __user *)arg);
+}
+
 static const struct ide_ioctl_devset ide_ioctl_settings[] = {
 { HDIO_GET_32BIT,	 HDIO_SET_32BIT,	&ide_devset_io_32bit  },
 { HDIO_GET_KEEPSETTINGS, HDIO_SET_KEEPSETTINGS,	&ide_devset_keepsettings },
@@ -37,7 +46,7 @@ int ide_setting_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	mutex_lock(&ide_setting_mtx);
 	err = ds->get(drive);
 	mutex_unlock(&ide_setting_mtx);
-	return err >= 0 ? put_user(err, (long __user *)arg) : err;
+	return err >= 0 ? put_user_long(err, arg) : err;
 
 set_val:
 	if (bdev != bdev->bd_contains)
@@ -56,7 +65,7 @@ int ide_setting_ioctl(ide_drive_t *drive, struct block_device *bdev,
 EXPORT_SYMBOL_GPL(ide_setting_ioctl);
 
 static int ide_get_identity_ioctl(ide_drive_t *drive, unsigned int cmd,
-				  unsigned long arg)
+				  void __user *argp)
 {
 	u16 *id = NULL;
 	int size = (cmd == HDIO_GET_IDENTITY) ? (ATA_ID_WORDS * 2) : 142;
@@ -77,7 +86,7 @@ static int ide_get_identity_ioctl(ide_drive_t *drive, unsigned int cmd,
 	memcpy(id, drive->id, size);
 	ata_id_to_hd_driveid(id);
 
-	if (copy_to_user((void __user *)arg, id, size))
+	if (copy_to_user(argp, id, size))
 		rc = -EFAULT;
 
 	kfree(id);
@@ -87,10 +96,10 @@ static int ide_get_identity_ioctl(ide_drive_t *drive, unsigned int cmd,
 
 static int ide_get_nice_ioctl(ide_drive_t *drive, unsigned long arg)
 {
-	return put_user((!!(drive->dev_flags & IDE_DFLAG_DSC_OVERLAP)
+	return put_user_long((!!(drive->dev_flags & IDE_DFLAG_DSC_OVERLAP)
 			 << IDE_NICE_DSC_OVERLAP) |
 			(!!(drive->dev_flags & IDE_DFLAG_NICE1)
-			 << IDE_NICE_1), (long __user *)arg);
+			 << IDE_NICE_1), arg);
 }
 
 static int ide_set_nice_ioctl(ide_drive_t *drive, unsigned long arg)
@@ -115,7 +124,7 @@ static int ide_set_nice_ioctl(ide_drive_t *drive, unsigned long arg)
 	return 0;
 }
 
-static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
+static int ide_cmd_ioctl(ide_drive_t *drive, void __user *argp)
 {
 	u8 *buf = NULL;
 	int bufsize = 0, err = 0;
@@ -123,7 +132,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 	struct ide_cmd cmd;
 	struct ide_taskfile *tf = &cmd.tf;
 
-	if (NULL == (void *) arg) {
+	if (NULL == argp) {
 		struct request *rq;
 
 		rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
@@ -135,7 +144,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 		return err;
 	}
 
-	if (copy_from_user(args, (void __user *)arg, 4))
+	if (copy_from_user(args, argp, 4))
 		return -EFAULT;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -181,19 +190,18 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 	args[1] = tf->error;
 	args[2] = tf->nsect;
 abort:
-	if (copy_to_user((void __user *)arg, &args, 4))
+	if (copy_to_user(argp, &args, 4))
 		err = -EFAULT;
 	if (buf) {
-		if (copy_to_user((void __user *)(arg + 4), buf, bufsize))
+		if (copy_to_user((argp + 4), buf, bufsize))
 			err = -EFAULT;
 		kfree(buf);
 	}
 	return err;
 }
 
-static int ide_task_ioctl(ide_drive_t *drive, unsigned long arg)
+static int ide_task_ioctl(ide_drive_t *drive, void __user *p)
 {
-	void __user *p = (void __user *)arg;
 	int err = 0;
 	u8 args[7];
 	struct ide_cmd cmd;
@@ -237,6 +245,10 @@ int generic_ide_ioctl(ide_drive_t *drive, struct block_device *bdev,
 		      unsigned int cmd, unsigned long arg)
 {
 	int err;
+	void __user *argp = (void __user *)arg;
+
+	if (in_compat_syscall())
+		argp = compat_ptr(arg);
 
 	err = ide_setting_ioctl(drive, bdev, cmd, arg, ide_ioctl_settings);
 	if (err != -EOPNOTSUPP)
@@ -247,7 +259,7 @@ int generic_ide_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	case HDIO_GET_IDENTITY:
 		if (bdev != bdev->bd_contains)
 			return -EINVAL;
-		return ide_get_identity_ioctl(drive, cmd, arg);
+		return ide_get_identity_ioctl(drive, cmd, argp);
 	case HDIO_GET_NICE:
 		return ide_get_nice_ioctl(drive, arg);
 	case HDIO_SET_NICE:
@@ -265,11 +277,11 @@ int generic_ide_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	case HDIO_DRIVE_CMD:
 		if (!capable(CAP_SYS_RAWIO))
 			return -EACCES;
-		return ide_cmd_ioctl(drive, arg);
+		return ide_cmd_ioctl(drive, argp);
 	case HDIO_DRIVE_TASK:
 		if (!capable(CAP_SYS_RAWIO))
 			return -EACCES;
-		return ide_task_ioctl(drive, arg);
+		return ide_task_ioctl(drive, argp);
 	case HDIO_DRIVE_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
@@ -277,7 +289,7 @@ int generic_ide_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	case HDIO_GET_BUSSTATE:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		if (put_user(BUSSTATE_ON, (long __user *)arg))
+		if (put_user_long(BUSSTATE_ON, arg))
 			return -EFAULT;
 		return 0;
 	case HDIO_SET_BUSSTATE:
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 3e7482695f77..6f26634b22bb 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1945,11 +1945,22 @@ static int idetape_ioctl(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 
+static int idetape_compat_ioctl(struct block_device *bdev, fmode_t mode,
+				unsigned int cmd, unsigned long arg)
+{
+        if (cmd == 0x0340 || cmd == 0x350)
+		arg = (unsigned long)compat_ptr(arg);
+
+	return idetape_ioctl(bdev, mode, cmd, arg);
+}
+
 static const struct block_device_operations idetape_block_ops = {
 	.owner		= THIS_MODULE,
 	.open		= idetape_open,
 	.release	= idetape_release,
 	.ioctl		= idetape_ioctl,
+	.compat_ioctl	= IS_ENABLED(CONFIG_COMPAT) ?
+				idetape_compat_ioctl : NULL,
 };
 
 static int ide_tape_probe(ide_drive_t *drive)
-- 
2.20.0

