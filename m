Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B211239E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLQWWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:22:40 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50303 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQWWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:22:39 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MJV5K-1iNTt20bmK-00JtoE; Tue, 17 Dec 2019 23:17:28 +0100
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
Subject: [PATCH v2 11/27] compat_ioctl: move CDROM_SEND_PACKET handling into scsi
Date:   Tue, 17 Dec 2019 23:16:52 +0100
Message-Id: <20191217221708.3730997-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Mp6Rj1N7d53mOvmoxMfJiXqVy8L4vX/KvDXHNCZwCkj5FtqvPqF
 LmsoqBqoIPLL7AWulDNY/HeW0lyyWQFtfqHhobt64l7pTViW29nW6M1yeERIiviw+HfvW9Q
 cTGasJcn8hQNeBqcIHZ3tp1szj6SouCBKTs1wZrLmWyroDrgUBg7FdHwEOUDsQvv9ZRTh/V
 HOPorWfYSm2xUQnMzZwig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0YLBBWODoHM=:uDf/SRKlIUIKgACjezHiKS
 5nSxSvF9qoF1iaB0ddvSTisSkno8s9Wk2vTRscWdwMFfHcVcv5uL2dLxFru8slEBa0C3U2AzB
 +qvKfh/fPsmmkm2x/eslA9pOJUnr6wCQU5MLzCM0fwzyVdsAqEXws3ArzSAMGTULxdNwCl4Kw
 jzcRXYpbhpYUmZ2AzexKsdTrmKLOFZblJ0whfwdLfYqHbovYis78zMBp/3+pm+Au8g/q+7fQj
 2Se9G2tsx/xL4Ppv1Dw05sZaBVH4OHfjgNCv1/TjrRGmi6FlCDpcZCHP3tatmDvdwE/nf08EE
 +ZKkdw2y4IzjO8AR9efNnYOe2aVtS/xcvN97fzsVDM11AhDI7EY3hhRwXKK9EIh3fTE4+Jiy+
 DYuSwqJu+Jv4y0in9PHCLvcHUIqeHiKH5xbb8GDpvHfUrRYxxjxWok+wbAf74aoUVLPHq3hrU
 76ULf2FBo4wGrUAX/yrB6gmTUjrQlIyk5xh3BcP5Q4fk/1rTsPVo/6GplaCA2WK1LeAecFioU
 vsxhBfDw1tqC4rPy1DmGUB9QVAUd755Gu6npvnTHp29MURmGGWdFGvRqmVOlD4zfqYDVE3xsb
 q5YtAiSaxqrlBRGzLCH6XQuxjnugDwQoos7XnSvuzZEV1UeepTyGsrRQafzB3SBgAy74Jannt
 aTUkELjMbxJFbK5tZCFiXQNjUT2S8HFPeG8MBbqJYflhP+SrQW3Tdse4n4wv91i8VsBoMFA+2
 z5N1q1j5Ucs3O+vRyHlAfia0CCIFDkU4p9pLC49Vw6ZJxFVYj/2S4XrzteXWLuLf594skFg3w
 xHq1mv+oQ5G0a3hH4R8YBcRABnBxssGrqj5MOVJkubu1LIag86jK0XzsRY4IzUOpJJ6gosCeL
 dLgbzKKx/LBfJPL/h5tQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is only one implementation of this ioctl, so move the handling out
of the common block layer code into the place where it's actually needed.

It also gets called indirectly through pktcdvd, which needs to be aware
of this change.

As I noticed, the old implementation of the compat handler failed to
convert the structure on the way out, so the updated fields never got
written back to user space. This is either not important, or it has
never worked and should be fixed now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c    |  47 +---------
 block/scsi_ioctl.c      | 185 ++++++++++++++++++++++++++++------------
 drivers/block/pktcdvd.c |   6 +-
 3 files changed, 135 insertions(+), 103 deletions(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index f16ae92065d7..578e04f94619 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -102,18 +102,6 @@ struct compat_cdrom_read_audio {
 	compat_caddr_t		buf;
 };
 
-struct compat_cdrom_generic_command {
-	unsigned char	cmd[CDROM_PACKET_SIZE];
-	compat_caddr_t	buffer;
-	compat_uint_t	buflen;
-	compat_int_t	stat;
-	compat_caddr_t	sense;
-	unsigned char	data_direction;
-	compat_int_t	quiet;
-	compat_int_t	timeout;
-	compat_caddr_t	reserved[1];
-};
-
 static int compat_cdrom_read_audio(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -141,38 +129,6 @@ static int compat_cdrom_read_audio(struct block_device *bdev, fmode_t mode,
 			(unsigned long)cdread_audio);
 }
 
-static int compat_cdrom_generic_command(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	struct cdrom_generic_command __user *cgc;
-	struct compat_cdrom_generic_command __user *cgc32;
-	u32 data;
-	unsigned char dir;
-	int itmp;
-
-	cgc = compat_alloc_user_space(sizeof(*cgc));
-	cgc32 = compat_ptr(arg);
-
-	if (copy_in_user(&cgc->cmd, &cgc32->cmd, sizeof(cgc->cmd)) ||
-	    get_user(data, &cgc32->buffer) ||
-	    put_user(compat_ptr(data), &cgc->buffer) ||
-	    copy_in_user(&cgc->buflen, &cgc32->buflen,
-			 (sizeof(unsigned int) + sizeof(int))) ||
-	    get_user(data, &cgc32->sense) ||
-	    put_user(compat_ptr(data), &cgc->sense) ||
-	    get_user(dir, &cgc32->data_direction) ||
-	    put_user(dir, &cgc->data_direction) ||
-	    get_user(itmp, &cgc32->quiet) ||
-	    put_user(itmp, &cgc->quiet) ||
-	    get_user(itmp, &cgc32->timeout) ||
-	    put_user(itmp, &cgc->timeout) ||
-	    get_user(data, &cgc32->reserved[0]) ||
-	    put_user(compat_ptr(data), &cgc->reserved[0]))
-		return -EFAULT;
-
-	return __blkdev_driver_ioctl(bdev, mode, cmd, (unsigned long)cgc);
-}
-
 struct compat_blkpg_ioctl_arg {
 	compat_int_t op;
 	compat_int_t flags;
@@ -224,8 +180,6 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 		return compat_hdio_ioctl(bdev, mode, cmd, arg);
 	case CDROMREADAUDIO:
 		return compat_cdrom_read_audio(bdev, mode, cmd, arg);
-	case CDROM_SEND_PACKET:
-		return compat_cdrom_generic_command(bdev, mode, cmd, arg);
 
 	/*
 	 * No handler required for the ones below, we just need to
@@ -263,6 +217,7 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 	case CDROM_DISC_STATUS:
 	case CDROM_CHANGER_NSLOTS:
 	case CDROM_GET_CAPABILITY:
+	case CDROM_SEND_PACKET:
 	/* Ignore cdrom.h about these next 5 ioctls, they absolutely do
 	 * not take a struct cdrom_read, instead they take a struct cdrom_msf
 	 * which is compatible.
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index b61dbf4d8443..b4e73d5dd5c2 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -639,6 +639,136 @@ int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp)
 }
 EXPORT_SYMBOL(get_sg_io_hdr);
 
+#ifdef CONFIG_COMPAT
+struct compat_cdrom_generic_command {
+	unsigned char	cmd[CDROM_PACKET_SIZE];
+	compat_caddr_t	buffer;
+	compat_uint_t	buflen;
+	compat_int_t	stat;
+	compat_caddr_t	sense;
+	unsigned char	data_direction;
+	compat_int_t	quiet;
+	compat_int_t	timeout;
+	compat_caddr_t	reserved[1];
+};
+#endif
+
+static int scsi_get_cdrom_generic_arg(struct cdrom_generic_command *cgc,
+				      const void __user *arg)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_cdrom_generic_command cgc32;
+
+		if (copy_from_user(&cgc32, arg, sizeof(cgc32)))
+			return -EFAULT;
+
+		*cgc = (struct cdrom_generic_command) {
+			.buffer		= compat_ptr(cgc32.buffer),
+			.buflen		= cgc32.buflen,
+			.stat		= cgc32.stat,
+			.sense		= compat_ptr(cgc32.sense),
+			.data_direction	= cgc32.data_direction,
+			.quiet		= cgc32.quiet,
+			.timeout	= cgc32.timeout,
+			.reserved[0]	= compat_ptr(cgc32.reserved[0]),
+		};
+		memcpy(&cgc->cmd, &cgc32.cmd, CDROM_PACKET_SIZE);
+		return 0;
+	}
+#endif
+	if (copy_from_user(cgc, arg, sizeof(*cgc)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int scsi_put_cdrom_generic_arg(const struct cdrom_generic_command *cgc,
+				      void __user *arg)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_cdrom_generic_command cgc32 = {
+			.buffer		= (uintptr_t)(cgc->buffer),
+			.buflen		= cgc->buflen,
+			.stat		= cgc->stat,
+			.sense		= (uintptr_t)(cgc->sense),
+			.data_direction	= cgc->data_direction,
+			.quiet		= cgc->quiet,
+			.timeout	= cgc->timeout,
+			.reserved[0]	= (uintptr_t)(cgc->reserved[0]),
+		};
+		memcpy(&cgc32.cmd, &cgc->cmd, CDROM_PACKET_SIZE);
+
+		if (copy_to_user(arg, &cgc32, sizeof(cgc32)))
+			return -EFAULT;
+
+		return 0;
+	}
+#endif
+	if (copy_to_user(arg, cgc, sizeof(*cgc)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int scsi_cdrom_send_packet(struct request_queue *q,
+				  struct gendisk *bd_disk,
+				  fmode_t mode, void __user *arg)
+{
+	struct cdrom_generic_command cgc;
+	struct sg_io_hdr hdr;
+	int err;
+
+	err = scsi_get_cdrom_generic_arg(&cgc, arg);
+	if (err)
+		return err;
+
+	cgc.timeout = clock_t_to_jiffies(cgc.timeout);
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.interface_id = 'S';
+	hdr.cmd_len = sizeof(cgc.cmd);
+	hdr.dxfer_len = cgc.buflen;
+	switch (cgc.data_direction) {
+		case CGC_DATA_UNKNOWN:
+			hdr.dxfer_direction = SG_DXFER_UNKNOWN;
+			break;
+		case CGC_DATA_WRITE:
+			hdr.dxfer_direction = SG_DXFER_TO_DEV;
+			break;
+		case CGC_DATA_READ:
+			hdr.dxfer_direction = SG_DXFER_FROM_DEV;
+			break;
+		case CGC_DATA_NONE:
+			hdr.dxfer_direction = SG_DXFER_NONE;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	hdr.dxferp = cgc.buffer;
+	hdr.sbp = cgc.sense;
+	if (hdr.sbp)
+		hdr.mx_sb_len = sizeof(struct request_sense);
+	hdr.timeout = jiffies_to_msecs(cgc.timeout);
+	hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
+	hdr.cmd_len = sizeof(cgc.cmd);
+
+	err = sg_io(q, bd_disk, &hdr, mode);
+	if (err == -EFAULT)
+		return -EFAULT;
+
+	if (hdr.status)
+		return -EIO;
+
+	cgc.stat = err;
+	cgc.buflen = hdr.resid;
+	if (scsi_put_cdrom_generic_arg(&cgc, arg))
+		return -EFAULT;
+
+	return err;
+}
+
 int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mode,
 		   unsigned int cmd, void __user *arg)
 {
@@ -689,60 +819,9 @@ int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mod
 				err = -EFAULT;
 			break;
 		}
-		case CDROM_SEND_PACKET: {
-			struct cdrom_generic_command cgc;
-			struct sg_io_hdr hdr;
-
-			err = -EFAULT;
-			if (copy_from_user(&cgc, arg, sizeof(cgc)))
-				break;
-			cgc.timeout = clock_t_to_jiffies(cgc.timeout);
-			memset(&hdr, 0, sizeof(hdr));
-			hdr.interface_id = 'S';
-			hdr.cmd_len = sizeof(cgc.cmd);
-			hdr.dxfer_len = cgc.buflen;
-			err = 0;
-			switch (cgc.data_direction) {
-				case CGC_DATA_UNKNOWN:
-					hdr.dxfer_direction = SG_DXFER_UNKNOWN;
-					break;
-				case CGC_DATA_WRITE:
-					hdr.dxfer_direction = SG_DXFER_TO_DEV;
-					break;
-				case CGC_DATA_READ:
-					hdr.dxfer_direction = SG_DXFER_FROM_DEV;
-					break;
-				case CGC_DATA_NONE:
-					hdr.dxfer_direction = SG_DXFER_NONE;
-					break;
-				default:
-					err = -EINVAL;
-			}
-			if (err)
-				break;
-
-			hdr.dxferp = cgc.buffer;
-			hdr.sbp = cgc.sense;
-			if (hdr.sbp)
-				hdr.mx_sb_len = sizeof(struct request_sense);
-			hdr.timeout = jiffies_to_msecs(cgc.timeout);
-			hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
-			hdr.cmd_len = sizeof(cgc.cmd);
-
-			err = sg_io(q, bd_disk, &hdr, mode);
-			if (err == -EFAULT)
-				break;
-
-			if (hdr.status)
-				err = -EIO;
-
-			cgc.stat = err;
-			cgc.buflen = hdr.resid;
-			if (copy_to_user(arg, &cgc, sizeof(cgc)))
-				err = -EFAULT;
-
+		case CDROM_SEND_PACKET:
+			err = scsi_cdrom_send_packet(q, bd_disk, mode, arg);
 			break;
-		}
 
 		/*
 		 * old junk scsi send command ioctl
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 861fc65a1b75..ab4d3be4b646 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2671,15 +2671,13 @@ static int pkt_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned in
 	case CDROMEJECT:
 	case CDROMMULTISESSION:
 	case CDROMREADTOCENTRY:
+	case CDROM_SEND_PACKET: /* compat mode handled in scsi_cmd_ioctl */
 	case SCSI_IOCTL_SEND_COMMAND:
 		return pkt_ioctl(bdev, mode, cmd, (unsigned long)compat_ptr(arg));
 
-
 	/* FIXME: no handler so far */
-	case CDROM_LAST_WRITTEN:
-	/* handled in compat_blkdev_driver_ioctl */
-	case CDROM_SEND_PACKET:
 	default:
+	case CDROM_LAST_WRITTEN:
 		return -ENOIOCTLCMD;
 	}
 }
-- 
2.20.0

