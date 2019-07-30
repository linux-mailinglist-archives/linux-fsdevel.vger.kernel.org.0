Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1987B3CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfG3UAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:00:22 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfG3UAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:00:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8yU2-1hycp60PiA-0067YS; Tue, 30 Jul 2019 21:59:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v5 15/29] compat_ioctl: move tape handling into drivers
Date:   Tue, 30 Jul 2019 21:55:31 +0200
Message-Id: <20190730195819.901457-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730195819.901457-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730195819.901457-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DjrExkZ5Ld377ZFAs9oLXBHkumN5MdCfTEPVek3qN/4rrIuaXAt
 BnjcZ5NsP0owf4pQBbSs9TJbdzHbypdHesdhu4fMrLY1n4NqqsDCL9PDIN6RHJ5byrGBJ1u
 xP+EhKW2rvyx9h9pGpKTCm9IIzI8J5uMMlF8qSmuzL8b90UbqIOT3MxrqUTLcJiOe1wcytL
 2ieKIGf/kZgvsxEGaKIMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GlW61MzzTkA=:Yq5B7sCgMqvFsp0nnDg/Vv
 dBq3ju5H3Brp13aspISufSCltMAEzFT2CiWkN+D/jJ0FcTwazNSIZbSDeuObYoFjJfjIo4OIA
 QYgei3C3m2gJeiaJIGu0iiszWR6cUDIfvsc13TiGyz113a8bqG4cr+nHqhObZ5D6yMwTDIEaP
 JNNZDtMFMsnT6lEVzoi4TFaOsOnXNIk8W+kMqOsdvD4wAs/kO4IYWl8Uqei7MBAOgmB749FFD
 lJMU6DCf0TJooPH+pOWp42M2xAA1DyjgVgzm6gVgo3xR8BGqBZI6nSHl1UeDl3+ebbdT7KemE
 ObvxVuRFYSPKyfNbxWP37meStqU8j2wX0J8BWYQKMxWkan7fKgqzKJ9SIZFozk9dPIE1Jn2i9
 eJJAM8aCRehUdWeuqTKFjCBdrf8OXy0+KyGUdCaREVIpVNb7oDpfnE8UY5PcA2AP6mweQmoEc
 3Tvoofg+ovfoxeDiu50pWdDAoci77jFK2wSgCTkzaViGLeZx/Vpt4K3m2lmpnfxblGRa7x/PU
 8SjTAJ18d+L0eE8FmwdjT37hXHaJuOJgkVCZ+2RGtVck2/IN52GC3N4li26lvu3TBGYjbHMzs
 jsOaETcUOWC2a1gx/ENbPbVDlNES+NR9AJLMOcqkqV64Dsw10HPdeTbdcJz8odA8seriVHiCm
 9Bk+LxFf16xF5B2oAjQxKQ5MsCycgIw1UmjmotqpPdbmgZr8lyXtG/gZZxoW6aYJbc4u90Hef
 VVn4Zz39Lwx8fGyq560Hut3TeKnctYDbwYzdJw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MTIOCPOS and MTIOCGET are incompatible between 32-bit and 64-bit user
space, and traditionally have been translated in fs/compat_ioctl.c.

To get rid of that translation handler, move a corresponding
implementation into each of the four drivers implementing those commands.

The interesting part of that is now in a new linux/mtio.h header that
wraps the existing uapi/linux/mtio.h header and provides an abstraction
to let drivers handle both cases easily. Using an in_compat_syscall()
check, the caller does not have to keep track of whether this was
called through .unlocked_ioctl() or .compat_ioctl().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ide/ide-tape.c        | 27 ++++++++++---
 drivers/s390/char/tape_char.c | 41 +++++++-------------
 drivers/scsi/st.c             | 28 +++++++++-----
 fs/compat_ioctl.c             | 73 -----------------------------------
 include/linux/mtio.h          | 59 ++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 115 deletions(-)
 create mode 100644 include/linux/mtio.h

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index db1a65f4b490..3e7482695f77 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -19,6 +19,7 @@
 
 #define IDETAPE_VERSION "1.20"
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -1407,14 +1408,10 @@ static long do_idetape_chrdev_ioctl(struct file *file,
 		if (tape->drv_write_prot)
 			mtget.mt_gstat |= GMT_WR_PROT(0xffffffff);
 
-		if (copy_to_user(argp, &mtget, sizeof(struct mtget)))
-			return -EFAULT;
-		return 0;
+		return put_user_mtget(argp, &mtget);
 	case MTIOCPOS:
 		mtpos.mt_blkno = position / tape->user_bs_factor - block_offset;
-		if (copy_to_user(argp, &mtpos, sizeof(struct mtpos)))
-			return -EFAULT;
-		return 0;
+		return put_user_mtpos(argp, &mtpos);
 	default:
 		if (tape->chrdev_dir == IDETAPE_DIR_READ)
 			ide_tape_discard_merge_buffer(drive, 1);
@@ -1432,6 +1429,22 @@ static long idetape_chrdev_ioctl(struct file *file,
 	return ret;
 }
 
+static long idetape_chrdev_compat_ioctl(struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	long ret;
+
+	if (cmd == MTIOCPOS32)
+		cmd = MTIOCPOS;
+	else if (cmd == MTIOCGET32)
+		cmd = MTIOCGET;
+
+	mutex_lock(&ide_tape_mutex);
+	ret = do_idetape_chrdev_ioctl(file, cmd, arg);
+	mutex_unlock(&ide_tape_mutex);
+	return ret;
+}
+
 /*
  * Do a mode sense page 0 with block descriptor and if it succeeds set the tape
  * block size with the reported value.
@@ -1886,6 +1899,8 @@ static const struct file_operations idetape_fops = {
 	.read		= idetape_chrdev_read,
 	.write		= idetape_chrdev_write,
 	.unlocked_ioctl	= idetape_chrdev_ioctl,
+	.compat_ioctl	= IS_ENABLED(CONFIG_COMPAT) ?
+			  idetape_chrdev_compat_ioctl : NULL,
 	.open		= idetape_chrdev_open,
 	.release	= idetape_chrdev_release,
 	.llseek		= noop_llseek,
diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index ea4253939555..8abb42923307 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -341,14 +341,14 @@ tapechar_release(struct inode *inode, struct file *filp)
  */
 static int
 __tapechar_ioctl(struct tape_device *device,
-		 unsigned int no, unsigned long data)
+		 unsigned int no, void __user *data)
 {
 	int rc;
 
 	if (no == MTIOCTOP) {
 		struct mtop op;
 
-		if (copy_from_user(&op, (char __user *) data, sizeof(op)) != 0)
+		if (copy_from_user(&op, data, sizeof(op)) != 0)
 			return -EFAULT;
 		if (op.mt_count < 0)
 			return -EINVAL;
@@ -392,9 +392,7 @@ __tapechar_ioctl(struct tape_device *device,
 		if (rc < 0)
 			return rc;
 		pos.mt_blkno = rc;
-		if (copy_to_user((char __user *) data, &pos, sizeof(pos)) != 0)
-			return -EFAULT;
-		return 0;
+		return put_user_mtpos(data, &pos);
 	}
 	if (no == MTIOCGET) {
 		/* MTIOCGET: query the tape drive status. */
@@ -424,15 +422,12 @@ __tapechar_ioctl(struct tape_device *device,
 			get.mt_blkno = rc;
 		}
 
-		if (copy_to_user((char __user *) data, &get, sizeof(get)) != 0)
-			return -EFAULT;
-
-		return 0;
+		return put_user_mtget(data, &get);
 	}
 	/* Try the discipline ioctl function. */
 	if (device->discipline->ioctl_fn == NULL)
 		return -EINVAL;
-	return device->discipline->ioctl_fn(device, no, data);
+	return device->discipline->ioctl_fn(device, no, (unsigned long)data);
 }
 
 static long
@@ -445,7 +440,7 @@ tapechar_ioctl(struct file *filp, unsigned int no, unsigned long data)
 
 	device = (struct tape_device *) filp->private_data;
 	mutex_lock(&device->mutex);
-	rc = __tapechar_ioctl(device, no, data);
+	rc = __tapechar_ioctl(device, no, (void __user *)data);
 	mutex_unlock(&device->mutex);
 	return rc;
 }
@@ -455,23 +450,17 @@ static long
 tapechar_compat_ioctl(struct file *filp, unsigned int no, unsigned long data)
 {
 	struct tape_device *device = filp->private_data;
-	int rval = -ENOIOCTLCMD;
-	unsigned long argp;
+	long rc;
 
-	/* The 'arg' argument of any ioctl function may only be used for
-	 * pointers because of the compat pointer conversion.
-	 * Consider this when adding new ioctls.
-	 */
-	argp = (unsigned long) compat_ptr(data);
-	if (device->discipline->ioctl_fn) {
-		mutex_lock(&device->mutex);
-		rval = device->discipline->ioctl_fn(device, no, argp);
-		mutex_unlock(&device->mutex);
-		if (rval == -EINVAL)
-			rval = -ENOIOCTLCMD;
-	}
+	if (no == MTIOCPOS32)
+		no = MTIOCPOS;
+	else if (no == MTIOCGET32)
+		no = MTIOCGET;
 
-	return rval;
+	mutex_lock(&device->mutex);
+	rc = __tapechar_ioctl(device, no, compat_ptr(data));
+	mutex_unlock(&device->mutex);
+	return rc;
 }
 #endif /* CONFIG_COMPAT */
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index e3266a64a477..9e3fff2de83e 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -22,6 +22,7 @@ static const char *verstr = "20160209";
 
 #include <linux/module.h>
 
+#include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
@@ -3800,14 +3801,11 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 		if (STp->cleaning_req)
 			mt_status.mt_gstat |= GMT_CLN(0xffffffff);
 
-		i = copy_to_user(p, &mt_status, sizeof(struct mtget));
-		if (i) {
-			retval = (-EFAULT);
+		retval = put_user_mtget(p, &mt_status);
+		if (retval)
 			goto out;
-		}
 
 		STp->recover_reg = 0;		/* Clear after read */
-		retval = 0;
 		goto out;
 	}			/* End of MTIOCGET */
 	if (cmd_type == _IOC_TYPE(MTIOCPOS) && cmd_nr == _IOC_NR(MTIOCPOS)) {
@@ -3821,9 +3819,7 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 			goto out;
 		}
 		mt_pos.mt_blkno = blk;
-		i = copy_to_user(p, &mt_pos, sizeof(struct mtpos));
-		if (i)
-			retval = (-EFAULT);
+		retval = put_user_mtpos(p, &mt_pos);
 		goto out;
 	}
 	mutex_unlock(&STp->lock);
@@ -3857,14 +3853,26 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 }
 
 #ifdef CONFIG_COMPAT
-static long st_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long st_compat_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 {
+	void __user *p = compat_ptr(arg);
 	struct scsi_tape *STp = file->private_data;
 	struct scsi_device *sdev = STp->device;
 	int ret = -ENOIOCTLCMD;
+
+	/* argument conversion is handled using put_user_mtpos/put_user_mtget */
+	switch (cmd_in) {
+	case MTIOCTOP:
+		return st_ioctl(file, MTIOCTOP, (unsigned long)p);
+	case MTIOCPOS32:
+		return st_ioctl(file, MTIOCPOS, (unsigned long)p);
+	case MTIOCGET32:
+		return st_ioctl(file, MTIOCGET, (unsigned long)p);
+	}
+
 	if (sdev->host->hostt->compat_ioctl) { 
 
-		ret = sdev->host->hostt->compat_ioctl(sdev, cmd, (void __user *)arg);
+		ret = sdev->host->hostt->compat_ioctl(sdev, cmd_in, (void __user *)arg);
 
 	}
 	return ret;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 47da220f95b1..b65eef3d4787 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -27,7 +27,6 @@
 #include <linux/file.h>
 #include <linux/ppp-ioctl.h>
 #include <linux/if_pppox.h>
-#include <linux/mtio.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
 #include <linux/raw.h>
@@ -361,73 +360,6 @@ static int ppp_scompress(struct file *file, unsigned int cmd,
 	return do_ioctl(file, PPPIOCSCOMPRESS, (unsigned long) odata);
 }
 
-#ifdef CONFIG_BLOCK
-struct mtget32 {
-	compat_long_t	mt_type;
-	compat_long_t	mt_resid;
-	compat_long_t	mt_dsreg;
-	compat_long_t	mt_gstat;
-	compat_long_t	mt_erreg;
-	compat_daddr_t	mt_fileno;
-	compat_daddr_t	mt_blkno;
-};
-#define MTIOCGET32	_IOR('m', 2, struct mtget32)
-
-struct mtpos32 {
-	compat_long_t	mt_blkno;
-};
-#define MTIOCPOS32	_IOR('m', 3, struct mtpos32)
-
-static int mt_ioctl_trans(struct file *file,
-		unsigned int cmd, void __user *argp)
-{
-	/* NULL initialization to make gcc shut up */
-	struct mtget __user *get = NULL;
-	struct mtget32 __user *umget32;
-	struct mtpos __user *pos = NULL;
-	struct mtpos32 __user *upos32;
-	unsigned long kcmd;
-	void *karg;
-	int err = 0;
-
-	switch(cmd) {
-	case MTIOCPOS32:
-		kcmd = MTIOCPOS;
-		pos = compat_alloc_user_space(sizeof(*pos));
-		karg = pos;
-		break;
-	default:	/* MTIOCGET32 */
-		kcmd = MTIOCGET;
-		get = compat_alloc_user_space(sizeof(*get));
-		karg = get;
-		break;
-	}
-	if (karg == NULL)
-		return -EFAULT;
-	err = do_ioctl(file, kcmd, (unsigned long)karg);
-	if (err)
-		return err;
-	switch (cmd) {
-	case MTIOCPOS32:
-		upos32 = argp;
-		err = convert_in_user(&pos->mt_blkno, &upos32->mt_blkno);
-		break;
-	case MTIOCGET32:
-		umget32 = argp;
-		err = convert_in_user(&get->mt_type, &umget32->mt_type);
-		err |= convert_in_user(&get->mt_resid, &umget32->mt_resid);
-		err |= convert_in_user(&get->mt_dsreg, &umget32->mt_dsreg);
-		err |= convert_in_user(&get->mt_gstat, &umget32->mt_gstat);
-		err |= convert_in_user(&get->mt_erreg, &umget32->mt_erreg);
-		err |= convert_in_user(&get->mt_fileno, &umget32->mt_fileno);
-		err |= convert_in_user(&get->mt_blkno, &umget32->mt_blkno);
-		break;
-	}
-	return err ? -EFAULT: 0;
-}
-
-#endif /* CONFIG_BLOCK */
-
 /* Bluetooth ioctls */
 #define HCIUARTSETPROTO		_IOW('U', 200, int)
 #define HCIUARTGETPROTO		_IOR('U', 201, int)
@@ -479,8 +411,6 @@ IGNORE_IOCTL(VT_GETMODE)
  */
 COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
-/* Little m */
-COMPATIBLE_IOCTL(MTIOCTOP)
 #ifdef CONFIG_BLOCK
 /* md calls this on random blockdevs */
 IGNORE_IOCTL(RAID_VERSION)
@@ -846,9 +776,6 @@ static long do_ioctl_trans(unsigned int cmd,
 		return sg_ioctl_trans(file, cmd, argp);
 	case SG_GET_REQUEST_TABLE:
 		return sg_grt_trans(file, cmd, argp);
-	case MTIOCGET32:
-	case MTIOCPOS32:
-		return mt_ioctl_trans(file, cmd, argp);
 #endif
 	}
 
diff --git a/include/linux/mtio.h b/include/linux/mtio.h
new file mode 100644
index 000000000000..fa2783fd37d1
--- /dev/null
+++ b/include/linux/mtio.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MTIO_COMPAT_H
+#define _LINUX_MTIO_COMPAT_H
+
+#include <linux/compat.h>
+#include <uapi/linux/mtio.h>
+#include <linux/uaccess.h>
+
+/*
+ * helper functions for implementing compat ioctls on the four tape
+ * drivers: we define the 32-bit layout of each incompatible strucucture,
+ * plus a wrapper function to copy it to user space in either format.
+ */
+
+struct	mtget32 {
+	s32	mt_type;
+	s32	mt_resid;
+	s32	mt_dsreg;
+	s32	mt_gstat;
+	s32	mt_erreg;
+	s32	mt_fileno;
+	s32	mt_blkno;
+};
+#define	MTIOCGET32	_IOR('m', 2, struct mtget32)
+
+struct	mtpos32 {
+	s32 	mt_blkno;
+};
+#define	MTIOCPOS32	_IOR('m', 3, struct mtpos32)
+
+static inline int put_user_mtget(void __user *u, struct mtget *k)
+{
+	struct mtget32 k32 = {
+		.mt_type   = k->mt_type,
+		.mt_resid  = k->mt_resid,
+		.mt_dsreg  = k->mt_dsreg,
+		.mt_gstat  = k->mt_gstat,
+		.mt_fileno = k->mt_fileno,
+		.mt_blkno  = k->mt_blkno,
+	};
+	int ret;
+
+	if (in_compat_syscall())
+		ret = copy_to_user(u, &k32, sizeof(k32));
+	else
+		ret = copy_to_user(u, k, sizeof(*k));
+
+	return ret ? -EFAULT : 0;
+}
+
+static inline int put_user_mtpos(void __user *u, struct mtpos *k)
+{
+	if (in_compat_syscall())
+		return put_user(k->mt_blkno, (u32 __user *)u);
+	else
+		return put_user(k->mt_blkno, (long __user *)u);
+}
+
+#endif
-- 
2.20.0

