Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A312E7CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgABPEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 10:04:12 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:47589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgABPEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:04:11 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MnJUy-1jU5yG242e-00jFzj; Thu, 02 Jan 2020 16:01:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Martin Wilck <mwilck@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ira Weiny <ira.weiny@intel.com>, Iustin Pop <iustin@k1024.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/22] compat_ioctl: scsi: move ioctl handling into drivers
Date:   Thu,  2 Jan 2020 15:55:31 +0100
Message-Id: <20200102145552.1853992-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/e80zwdT+wTicn0NMZuh6AZ7aAB/UfmFnLijkeDZsj8gxRxFW5k
 N//+5PnYmCiu9NnLxiRRE0mJZsNb5V80V0Ex9rjoeqi05jIqFZUh7ziOTX1gQPinUT7BRpl
 jeZoob0rgUjez9ZHLn85pzbYf/4sEvUOCPWPa7vZZizKKCEb9w9+sVRqZzLRRJXjzvWZ0R9
 cMqCviOyZOxSKDQ9baMYQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x/Q6tmSDxu8=:OjjUVNa82AbH3RiNJYC9Xv
 mVO9b74kQFTgrYlXKNbSlG6Vs6Vo86LTUPlv7WUijUK9dAJWI30NUAICkIZeWWQDt4J8/G9/I
 rBiyU5BTmVPe9ZTaxtUKgYpGXr1BnqCVSpj7sb85DTv5pERnqhIthEtb8SjBT2U5W7k61RrOa
 ldAV9tfo8NkGWJnxXUe0hGwQJJwcjW/eRNwO6rXGiTGuu6RfJsdfw+p1HkjxjQjNJe+mhRrrA
 qQpNP4iMPELMR3BoMoZVSWDJrD4ltCbNQOHfR85DpIvWIsQW7EwwCeC/xk6fm4uXj8DX4q9U7
 FMf0y/fMe7VWuVdULYRQ7qIHqiAqHxvSm0RvN/tziqyJLnu80Z/qK6/DIRDh7TwdeB3n2zpkN
 hQN4Tq8t/HP6CAmpo5DuqHZu+hADe0ktznB3OK/tc5TJwtET7m1UGsCiUqX3PKAj3wLv569uh
 o6XQjGR4upeSYjmR5idXvJ/L6/cShVxi7MsCE8AHbRiECso0UO6vgwgupC2uIajcZShqUQxQT
 oaTXT8hBNfNxUoqB9EgBgsFkcIcPR80Lqx73PsG/EkkDaJpyKx/6nQi6Ba5QToJIuOKfREgA8
 aYWUSUEVWXR2d3EB8Soc1y8AQycGifnC+HDL3KfEHC8hq5rHSxtesh5QFjpA4GOREGY/GT/Sq
 nZk66EO/rPHdkPHpitzqWFE00YZE8ft9h8rGiDBM7xp+mP5g8sRWY9WUOexnpzUeEYJPx9LA5
 GkFt3CagmES56AkxBD2bG69vytWcWvhj4XvwxUZ3siOohsKkXrTe5/Lf0EZjjbTDyDZytu5nr
 VdBBmsD+8jFaNJDY97oPQgDUR3ixrIB8ow5brQo2wbKZMST9Y76+MXU5pnKiAheYhoWYc809T
 ujWAXClkzLx9abc/N5Yg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Each driver calling scsi_ioctl() gets an equivalent compat_ioctl()
handler that implements the same commands by calling scsi_compat_ioctl().

The scsi_cmd_ioctl() and scsi_cmd_blk_ioctl() functions are compatible
at this point, so any driver that calls those can do so for both native
and compat mode, with the argument passed through compat_ptr().

With this, we can remove the entries from fs/compat_ioctl.c.  The new
code is larger, but should be easier to maintain and keep updated with
newly added commands.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/virtio_blk.c |   3 +
 drivers/scsi/ch.c          |   9 ++-
 drivers/scsi/sd.c          |  50 ++++++--------
 drivers/scsi/sg.c          |  44 ++++++++-----
 drivers/scsi/sr.c          |  57 ++++++++++++++--
 drivers/scsi/st.c          |  51 ++++++++------
 fs/compat_ioctl.c          | 132 +------------------------------------
 7 files changed, 142 insertions(+), 204 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7ffd719d89de..fbbf18ac1d5d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 
 static const struct block_device_operations virtblk_fops = {
 	.ioctl  = virtblk_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = blkdev_compat_ptr_ioctl,
+#endif
 	.owner  = THIS_MODULE,
 	.getgeo = virtblk_getgeo,
 };
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 76751d6c7f0d..ed5f4a6ae270 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -872,6 +872,10 @@ static long ch_ioctl_compat(struct file * file,
 			    unsigned int cmd, unsigned long arg)
 {
 	scsi_changer *ch = file->private_data;
+	int retval = scsi_ioctl_block_when_processing_errors(ch->device, cmd,
+							file->f_flags & O_NDELAY);
+	if (retval)
+		return retval;
 
 	switch (cmd) {
 	case CHIOGPARAMS:
@@ -883,7 +887,7 @@ static long ch_ioctl_compat(struct file * file,
 	case CHIOINITELEM:
 	case CHIOSVOLTAG:
 		/* compatible */
-		return ch_ioctl(file, cmd, arg);
+		return ch_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 	case CHIOGSTATUS32:
 	{
 		struct changer_element_status32 ces32;
@@ -898,8 +902,7 @@ static long ch_ioctl_compat(struct file * file,
 		return ch_gstatus(ch, ces32.ces_type, data);
 	}
 	default:
-		// return scsi_ioctl_compat(ch->device, cmd, (void*)arg);
-		return -ENOIOCTLCMD;
+		return scsi_compat_ioctl(ch->device, cmd, compat_ptr(arg));
 
 	}
 }
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cea625906440..5afb0046b12a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1465,13 +1465,12 @@ static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
  *	Note: most ioctls are forward onto the block subsystem or further
  *	down in the scsi subsystem.
  **/
-static int sd_ioctl(struct block_device *bdev, fmode_t mode,
-		    unsigned int cmd, unsigned long arg)
+static int sd_ioctl_common(struct block_device *bdev, fmode_t mode,
+			   unsigned int cmd, void __user *p)
 {
 	struct gendisk *disk = bdev->bd_disk;
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdp = sdkp->device;
-	void __user *p = (void __user *)arg;
 	int error;
     
 	SCSI_LOG_IOCTL(1, sd_printk(KERN_INFO, sdkp, "sd_ioctl: disk=%s, "
@@ -1507,9 +1506,6 @@ static int sd_ioctl(struct block_device *bdev, fmode_t mode,
 			break;
 		default:
 			error = scsi_cmd_blk_ioctl(bdev, mode, cmd, p);
-			if (error != -ENOTTY)
-				break;
-			error = scsi_ioctl(sdp, cmd, p);
 			break;
 	}
 out:
@@ -1691,39 +1687,31 @@ static void sd_rescan(struct device *dev)
 	revalidate_disk(sdkp->disk);
 }
 
+static int sd_ioctl(struct block_device *bdev, fmode_t mode,
+		    unsigned int cmd, unsigned long arg)
+{
+	void __user *p = (void __user *)arg;
+	int ret;
+
+	ret = sd_ioctl_common(bdev, mode, cmd, p);
+	if (ret != -ENOTTY)
+		return ret;
+
+	return scsi_ioctl(scsi_disk(bdev->bd_disk)->device, cmd, p);
+}
 
 #ifdef CONFIG_COMPAT
-/* 
- * This gets directly called from VFS. When the ioctl 
- * is not recognized we go back to the other translation paths. 
- */
 static int sd_compat_ioctl(struct block_device *bdev, fmode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
-	struct gendisk *disk = bdev->bd_disk;
-	struct scsi_disk *sdkp = scsi_disk(disk);
-	struct scsi_device *sdev = sdkp->device;
 	void __user *p = compat_ptr(arg);
-	int error;
-
-	error = scsi_verify_blk_ioctl(bdev, cmd);
-	if (error < 0)
-		return error;
+	int ret;
 
-	error = scsi_ioctl_block_when_processing_errors(sdev, cmd,
-			(mode & FMODE_NDELAY) != 0);
-	if (error)
-		return error;
+	ret = sd_ioctl_common(bdev, mode, cmd, p);
+	if (ret != -ENOTTY)
+		return ret;
 
-	if (is_sed_ioctl(cmd))
-		return sed_ioctl(sdkp->opal_dev, cmd, p);
-	       
-	/* 
-	 * Let the static ioctl translation table take care of it.
-	 */
-	if (!sdev->host->hostt->compat_ioctl)
-		return -ENOIOCTLCMD; 
-	return sdev->host->hostt->compat_ioctl(sdev, cmd, p);
+	return scsi_compat_ioctl(scsi_disk(bdev->bd_disk)->device, cmd, p);
 }
 #endif
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index eace8886d95a..bafeaf7b9ad8 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -911,19 +911,14 @@ static int put_compat_request_table(struct compat_sg_req_info __user *o,
 #endif
 
 static long
-sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
+sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
+		unsigned int cmd_in, void __user *p)
 {
-	void __user *p = (void __user *)arg;
 	int __user *ip = p;
 	int result, val, read_only;
-	Sg_device *sdp;
-	Sg_fd *sfp;
 	Sg_request *srp;
 	unsigned long iflags;
 
-	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
-		return -ENXIO;
-
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
 				   "sg_ioctl: cmd=0x%x\n", (int) cmd_in));
 	read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
@@ -1146,29 +1141,44 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 			cmd_in, filp->f_flags & O_NDELAY);
 	if (result)
 		return result;
+
+	return -ENOIOCTLCMD;
+}
+
+static long
+sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
+{
+	void __user *p = (void __user *)arg;
+	Sg_device *sdp;
+	Sg_fd *sfp;
+	int ret;
+
+	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
+		return -ENXIO;
+
+	ret = sg_ioctl_common(filp, sdp, sfp, cmd_in, p);
+	if (ret != -ENOIOCTLCMD)
+		return ret;
+
 	return scsi_ioctl(sdp->device, cmd_in, p);
 }
 
 #ifdef CONFIG_COMPAT
 static long sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 {
+	void __user *p = compat_ptr(arg);
 	Sg_device *sdp;
 	Sg_fd *sfp;
-	struct scsi_device *sdev;
+	int ret;
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 
-	sdev = sdp->device;
-	if (sdev->host->hostt->compat_ioctl) { 
-		int ret;
-
-		ret = sdev->host->hostt->compat_ioctl(sdev, cmd_in, (void __user *)arg);
-
+	ret = sg_ioctl_common(filp, sdp, sfp, cmd_in, p);
+	if (ret != -ENOIOCTLCMD)
 		return ret;
-	}
-	
-	return -ENOIOCTLCMD;
+
+	return scsi_compat_ioctl(sdp->device, cmd_in, p);
 }
 #endif
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 4664fdf75c0f..6033a886c42c 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -38,6 +38,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/bio.h>
+#include <linux/compat.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/cdrom.h>
@@ -598,6 +599,55 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+static int sr_block_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
+			  unsigned long arg)
+{
+	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
+	struct scsi_device *sdev = cd->device;
+	void __user *argp = compat_ptr(arg);
+	int ret;
+
+	mutex_lock(&sr_mutex);
+
+	ret = scsi_ioctl_block_when_processing_errors(sdev, cmd,
+			(mode & FMODE_NDELAY) != 0);
+	if (ret)
+		goto out;
+
+	scsi_autopm_get_device(sdev);
+
+	/*
+	 * Send SCSI addressing ioctls directly to mid level, send other
+	 * ioctls to cdrom/block level.
+	 */
+	switch (cmd) {
+	case SCSI_IOCTL_GET_IDLUN:
+	case SCSI_IOCTL_GET_BUS_NUMBER:
+		ret = scsi_compat_ioctl(sdev, cmd, argp);
+		goto put;
+	}
+
+	/*
+	 * CDROM ioctls are handled in the block layer, but
+	 * do the scsi blk ioctls here.
+	 */
+	ret = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
+	if (ret != -ENOTTY)
+		return ret;
+
+	ret = scsi_compat_ioctl(sdev, cmd, argp);
+
+put:
+	scsi_autopm_put_device(sdev);
+
+out:
+	mutex_unlock(&sr_mutex);
+	return ret;
+
+}
+#endif
+
 static unsigned int sr_block_check_events(struct gendisk *disk,
 					  unsigned int clearing)
 {
@@ -641,12 +691,11 @@ static const struct block_device_operations sr_bdops =
 	.open		= sr_block_open,
 	.release	= sr_block_release,
 	.ioctl		= sr_block_ioctl,
+#ifdef CONFIG_COMPAT
+	.ioctl		= sr_block_compat_ioctl,
+#endif
 	.check_events	= sr_block_check_events,
 	.revalidate_disk = sr_block_revalidate_disk,
-	/* 
-	 * No compat_ioctl for now because sr_block_ioctl never
-	 * seems to pass arbitrary ioctls down to host drivers.
-	 */
 };
 
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 9e3fff2de83e..393f3019ccac 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3501,7 +3501,7 @@ static int partition_tape(struct scsi_tape *STp, int size)
 
 
 /* The ioctl command */
-static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
+static long st_ioctl_common(struct file *file, unsigned int cmd_in, void __user *p)
 {
 	int i, cmd_nr, cmd_type, bt;
 	int retval = 0;
@@ -3509,7 +3509,6 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 	struct scsi_tape *STp = file->private_data;
 	struct st_modedef *STm;
 	struct st_partstat *STps;
-	void __user *p = (void __user *)arg;
 
 	if (mutex_lock_interruptible(&STp->lock))
 		return -ERESTARTSYS;
@@ -3824,9 +3823,19 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 	}
 	mutex_unlock(&STp->lock);
 	switch (cmd_in) {
+		case SCSI_IOCTL_STOP_UNIT:
+			/* unload */
+			retval = scsi_ioctl(STp->device, cmd_in, p);
+			if (!retval) {
+				STp->rew_at_close = 0;
+				STp->ready = ST_NO_TAPE;
+			}
+			return retval;
+
 		case SCSI_IOCTL_GET_IDLUN:
 		case SCSI_IOCTL_GET_BUS_NUMBER:
 			break;
+
 		default:
 			if ((cmd_in == SG_IO ||
 			     cmd_in == SCSI_IOCTL_SEND_COMMAND ||
@@ -3840,42 +3849,46 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 				return i;
 			break;
 	}
-	retval = scsi_ioctl(STp->device, cmd_in, p);
-	if (!retval && cmd_in == SCSI_IOCTL_STOP_UNIT) { /* unload */
-		STp->rew_at_close = 0;
-		STp->ready = ST_NO_TAPE;
-	}
-	return retval;
+	return -ENOTTY;
 
  out:
 	mutex_unlock(&STp->lock);
 	return retval;
 }
 
+static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
+{
+	void __user *p = (void __user *)arg;
+	struct scsi_tape *STp = file->private_data;
+	int ret;
+
+	ret = st_ioctl_common(file, cmd_in, p);
+	if (ret != -ENOTTY)
+		return ret;
+
+	return scsi_ioctl(STp->device, cmd_in, p);
+}
+
 #ifdef CONFIG_COMPAT
 static long st_compat_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 {
 	void __user *p = compat_ptr(arg);
 	struct scsi_tape *STp = file->private_data;
-	struct scsi_device *sdev = STp->device;
-	int ret = -ENOIOCTLCMD;
+	int ret;
 
 	/* argument conversion is handled using put_user_mtpos/put_user_mtget */
 	switch (cmd_in) {
-	case MTIOCTOP:
-		return st_ioctl(file, MTIOCTOP, (unsigned long)p);
 	case MTIOCPOS32:
-		return st_ioctl(file, MTIOCPOS, (unsigned long)p);
+		return st_ioctl_common(file, MTIOCPOS, p);
 	case MTIOCGET32:
-		return st_ioctl(file, MTIOCGET, (unsigned long)p);
+		return st_ioctl_common(file, MTIOCGET, p);
 	}
 
-	if (sdev->host->hostt->compat_ioctl) { 
+	ret = st_ioctl_common(file, cmd_in, p);
+	if (ret != -ENOTTY)
+		return ret;
 
-		ret = sdev->host->hostt->compat_ioctl(sdev, cmd_in, (void __user *)arg);
-
-	}
-	return ret;
+	return scsi_compat_ioctl(STp->device, cmd_in, p);
 }
 #endif
 
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 358ea2ecf36b..ab4471f469e6 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -36,109 +36,11 @@
 
 #include "internal.h"
 
-#ifdef CONFIG_BLOCK
-#include <linux/cdrom.h>
-#include <linux/fd.h>
-#include <scsi/scsi.h>
-#include <scsi/scsi_ioctl.h>
-#include <scsi/sg.h>
-#endif
-
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 
 #include <linux/hiddev.h>
 
-
-#include <linux/sort.h>
-
-/*
- * simple reversible transform to make our table more evenly
- * distributed after sorting.
- */
-#define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
-
-#define COMPATIBLE_IOCTL(cmd) XFORM((u32)cmd),
-static unsigned int ioctl_pointer[] = {
-#ifdef CONFIG_BLOCK
-/* Big S */
-COMPATIBLE_IOCTL(SCSI_IOCTL_GET_IDLUN)
-COMPATIBLE_IOCTL(SCSI_IOCTL_DOORLOCK)
-COMPATIBLE_IOCTL(SCSI_IOCTL_DOORUNLOCK)
-COMPATIBLE_IOCTL(SCSI_IOCTL_TEST_UNIT_READY)
-COMPATIBLE_IOCTL(SCSI_IOCTL_GET_BUS_NUMBER)
-COMPATIBLE_IOCTL(SCSI_IOCTL_SEND_COMMAND)
-COMPATIBLE_IOCTL(SCSI_IOCTL_PROBE_HOST)
-COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
-#endif
-#ifdef CONFIG_BLOCK
-/* SG stuff */
-COMPATIBLE_IOCTL(SG_IO)
-COMPATIBLE_IOCTL(SG_GET_REQUEST_TABLE)
-COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
-COMPATIBLE_IOCTL(SG_GET_TIMEOUT)
-COMPATIBLE_IOCTL(SG_EMULATED_HOST)
-COMPATIBLE_IOCTL(SG_GET_TRANSFORM)
-COMPATIBLE_IOCTL(SG_SET_RESERVED_SIZE)
-COMPATIBLE_IOCTL(SG_GET_RESERVED_SIZE)
-COMPATIBLE_IOCTL(SG_GET_SCSI_ID)
-COMPATIBLE_IOCTL(SG_SET_FORCE_LOW_DMA)
-COMPATIBLE_IOCTL(SG_GET_LOW_DMA)
-COMPATIBLE_IOCTL(SG_SET_FORCE_PACK_ID)
-COMPATIBLE_IOCTL(SG_GET_PACK_ID)
-COMPATIBLE_IOCTL(SG_GET_NUM_WAITING)
-COMPATIBLE_IOCTL(SG_SET_DEBUG)
-COMPATIBLE_IOCTL(SG_GET_SG_TABLESIZE)
-COMPATIBLE_IOCTL(SG_GET_COMMAND_Q)
-COMPATIBLE_IOCTL(SG_SET_COMMAND_Q)
-COMPATIBLE_IOCTL(SG_GET_VERSION_NUM)
-COMPATIBLE_IOCTL(SG_NEXT_CMD_LEN)
-COMPATIBLE_IOCTL(SG_SCSI_RESET)
-COMPATIBLE_IOCTL(SG_GET_REQUEST_TABLE)
-COMPATIBLE_IOCTL(SG_SET_KEEP_ORPHAN)
-COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
-#endif
-};
-
-/*
- * Convert common ioctl arguments based on their command number
- *
- * Please do not add any code in here. Instead, implement
- * a compat_ioctl operation in the place that handleѕ the
- * ioctl for the native case.
- */
-static long do_ioctl_trans(unsigned int cmd,
-		 unsigned long arg, struct file *file)
-{
-	return -ENOIOCTLCMD;
-}
-
-static int compat_ioctl_check_table(unsigned int xcmd)
-{
-#ifdef CONFIG_BLOCK
-	int i;
-	const int max = ARRAY_SIZE(ioctl_pointer) - 1;
-
-	BUILD_BUG_ON(max >= (1 << 16));
-
-	/* guess initial offset into table, assuming a
-	   normalized distribution */
-	i = ((xcmd >> 16) * max) >> 16;
-
-	/* do linear search up first, until greater or equal */
-	while (ioctl_pointer[i] < xcmd && i < max)
-		i++;
-
-	/* then do linear search down */
-	while (ioctl_pointer[i] > xcmd && i > 0)
-		i--;
-
-	return ioctl_pointer[i] == xcmd;
-#else
-	return 0;
-#endif
-}
-
 COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 		       compat_ulong_t, arg32)
 {
@@ -216,19 +118,9 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 				goto out_fput;
 		}
 
-		if (!f.file->f_op->unlocked_ioctl)
-			goto do_ioctl;
-		break;
-	}
-
-	if (compat_ioctl_check_table(XFORM(cmd)))
-		goto found_handler;
-
-	error = do_ioctl_trans(cmd, arg, f.file);
-	if (error == -ENOIOCTLCMD)
 		error = -ENOTTY;
-
-	goto out_fput;
+		goto out_fput;
+	}
 
  found_handler:
 	arg = (unsigned long)compat_ptr(arg);
@@ -239,23 +131,3 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
  out:
 	return error;
 }
-
-static int __init init_sys32_ioctl_cmp(const void *p, const void *q)
-{
-	unsigned int a, b;
-	a = *(unsigned int *)p;
-	b = *(unsigned int *)q;
-	if (a > b)
-		return 1;
-	if (a < b)
-		return -1;
-	return 0;
-}
-
-static int __init init_sys32_ioctl(void)
-{
-	sort(ioctl_pointer, ARRAY_SIZE(ioctl_pointer), sizeof(*ioctl_pointer),
-		init_sys32_ioctl_cmp, NULL);
-	return 0;
-}
-__initcall(init_sys32_ioctl);
-- 
2.20.0

