Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256588DF62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfHNUyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:54:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfHNUyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:54:15 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MnWx3-1ifH7b3rC1-00jcFW; Wed, 14 Aug 2019 22:53:43 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v5 07/18] compat_ioctl: reimplement SG_IO handling
Date:   Wed, 14 Aug 2019 22:49:19 +0200
Message-Id: <20190814205245.121691-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/JQAz9jbmNi46KdiXkmQBzuzdZGvU7yA4i2fYTIxsCWcn54Byn+
 cZSLNL4wecRpJeB91mHzyKN9NNSJ3ULDskRlMVxYXOTO+ptqPBOWuE58W/Zey9cnvoZ/ovy
 UtgaVm4/NG8hfni+6Js5WJEi9KApQ25Y7TnAG3cmdBsqsQ8OO8jvecnRbTxzrYgpjHl8s0+
 1ND4U/lB+ZPB8uDowQj2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8FuODb/6KPU=:gOdtUHMZdpbvut9olHBgd6
 DkWH+wqXU9cvMxiHCdC7DpM+xeDBjcinYvg6WNWYeaj+wYQbEzD5y2kIWP3/YI+QE8X4JlbWa
 HHzWST7F5eSSyDYa6Lyqw52NH+kE7eiZrsE9XK6u7RgELNEYIsUPJaNgBLRcHEVaxMmUIsYrF
 B/0PGqDsjudRd9blhA+aVRqYyOD34HrfPcw9NvRuao434oNgDHXaz3mH0gceEbaDf1NTP4M5w
 rrAJqJd6Ph/Dq2cOqKVMA1Cj93HScfjd6FKChJzpSKo1uf2Qc+TbstnF17fkRyzaMcERJqafW
 LKAzVdDVRG+H1nD+8BIIxwzJFBetCVeSsXvXzq4VNE/8R1UxjnePVJCsm53Hfj+qNmlq98xAY
 zaHRxnP0YfP0JZcv5U53SGBr2kb6jRaFdBSczcpsofU1h94f8BuVhWEMlGCIFMpkiP53xNL0A
 mYO44gp5h+PsmbqExAuPH0Ib88cJpIpjxWN13J5h4biRGxb/CN7uVR/OfmFv2pkiVGGBXeQ8w
 YJ+GWIeoiP0tUNkgQDI2bWuYc/avQYRsR3iwOcfnL0re5lBCGK0IQ/oeP/PSkScluXXYukOnJ
 6Yy6wC1JZfnd+oJ/YqNobNEOdq4AvN6HOOqP7tkIgJ9oELugIb4ZWxPVtfDypetursZmtMZJa
 WsmPAITMwAtWde59K0qUUhAcAuQB1IOgNkSeqCCzJA7cvi/Ac7gFPsNaLizPQegTo0twTblmG
 DnjtAd4YwQ+B78088p9b4g9buz+WkDP4iR238A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two code locations that implement the SG_IO ioctl: the old
sg.c driver, and the generic scsi_ioctl helper that is in turn used by
multiple drivers.

To eradicate the old compat_ioctl conversion handler for the SG_IO
command, I implement a readable pair of put_sg_io_hdr() /get_sg_io_hdr()
helper functions that can be used for both compat and native mode,
and then I call this from both drivers.

For the iovec handling, there is already a compat_import_iovec() function
that can simply be called in place of import_iovec().

To avoid having to pass the compat/native state through multiple
indirections, I mark the SG_IO command itself as compatible in
fs/compat_ioctl.c and use in_compat_syscall() to figure out where
we are called from.

As a side-effect of this, the sg.c driver now also accepts the 32-bit
sg_io_hdr format in compat mode using the read/write interface, not
just ioctl. This should improve compatiblity with old 32-bit binaries,
but it would break if any application intentionally passes the 64-bit
data structure in compat mode here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/scsi_ioctl.c     | 132 ++++++++++++++++++++++++++++++++++--
 drivers/scsi/sg.c      |  19 +++---
 fs/compat_ioctl.c      | 148 +----------------------------------------
 include/linux/blkdev.h |   2 +
 lib/iov_iter.c         |   1 +
 5 files changed, 143 insertions(+), 159 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index f5e0ad65e86a..cbeb629ee917 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
  */
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -327,7 +328,14 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 		struct iov_iter i;
 		struct iovec *iov = NULL;
 
-		ret = import_iovec(rq_data_dir(rq),
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret = compat_import_iovec(rq_data_dir(rq),
+				   hdr->dxferp, hdr->iovec_count,
+				   0, &iov, &i);
+		else
+#endif
+			ret = import_iovec(rq_data_dir(rq),
 				   hdr->dxferp, hdr->iovec_count,
 				   0, &iov, &i);
 		if (ret < 0)
@@ -542,6 +550,122 @@ static inline int blk_send_start_stop(struct request_queue *q,
 	return __blk_send_generic(q, bd_disk, GPCMD_START_STOP_UNIT, data);
 }
 
+#ifdef CONFIG_COMPAT
+struct compat_sg_io_hdr {
+	compat_int_t interface_id;	/* [i] 'S' for SCSI generic (required) */
+	compat_int_t dxfer_direction;	/* [i] data transfer direction  */
+	unsigned char cmd_len;		/* [i] SCSI command length ( <= 16 bytes) */
+	unsigned char mx_sb_len;	/* [i] max length to write to sbp */
+	unsigned short iovec_count;	/* [i] 0 implies no scatter gather */
+	compat_uint_t dxfer_len;	/* [i] byte count of data transfer */
+	compat_uint_t dxferp;		/* [i], [*io] points to data transfer memory
+						or scatter gather list */
+	compat_uptr_t cmdp;		/* [i], [*i] points to command to perform */
+	compat_uptr_t sbp;		/* [i], [*o] points to sense_buffer memory */
+	compat_uint_t timeout;		/* [i] MAX_UINT->no timeout (unit: millisec) */
+	compat_uint_t flags;		/* [i] 0 -> default, see SG_FLAG... */
+	compat_int_t pack_id;		/* [i->o] unused internally (normally) */
+	compat_uptr_t usr_ptr;		/* [i->o] unused internally */
+	unsigned char status;		/* [o] scsi status */
+	unsigned char masked_status;	/* [o] shifted, masked scsi status */
+	unsigned char msg_status;	/* [o] messaging level data (optional) */
+	unsigned char sb_len_wr;	/* [o] byte count actually written to sbp */
+	unsigned short host_status;	/* [o] errors from host adapter */
+	unsigned short driver_status;	/* [o] errors from software driver */
+	compat_int_t resid;		/* [o] dxfer_len - actual_transferred */
+	compat_uint_t duration;		/* [o] time taken by cmd (unit: millisec) */
+	compat_uint_t info;		/* [o] auxiliary information */
+};
+#endif
+
+int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_sg_io_hdr hdr32 =  {
+			.interface_id	 = hdr->interface_id,
+			.dxfer_direction = hdr->dxfer_direction,
+			.cmd_len	 = hdr->cmd_len,
+			.mx_sb_len	 = hdr->mx_sb_len,
+			.iovec_count	 = hdr->iovec_count,
+			.dxfer_len	 = hdr->dxfer_len,
+			.dxferp		 = (uintptr_t)hdr->dxferp,
+			.cmdp		 = (uintptr_t)hdr->cmdp,
+			.sbp		 = (uintptr_t)hdr->sbp,
+			.timeout	 = hdr->timeout,
+			.flags		 = hdr->flags,
+			.pack_id	 = hdr->pack_id,
+			.usr_ptr	 = (uintptr_t)hdr->usr_ptr,
+			.status		 = hdr->status,
+			.masked_status	 = hdr->masked_status,
+			.msg_status	 = hdr->msg_status,
+			.sb_len_wr	 = hdr->sb_len_wr,
+			.host_status	 = hdr->host_status,
+			.driver_status	 = hdr->driver_status,
+			.resid		 = hdr->resid,
+			.duration	 = hdr->duration,
+			.info		 = hdr->info,
+		};
+
+		if (copy_to_user(argp, &hdr32, sizeof(hdr)))
+			return -EFAULT;
+
+		return 0;
+	}
+#endif
+
+	if (copy_to_user(argp, &hdr, sizeof(hdr)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(put_sg_io_hdr);
+
+int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp)
+{
+#ifdef CONFIG_COMPAT
+	struct compat_sg_io_hdr hdr32;
+
+	if (in_compat_syscall()) {
+		if (copy_from_user(&hdr32, argp, sizeof(hdr32)))
+			return -EFAULT;
+
+		*hdr = (struct sg_io_hdr) {
+			.interface_id	 = hdr32.interface_id,
+			.dxfer_direction = hdr32.dxfer_direction,
+			.cmd_len	 = hdr32.cmd_len,
+			.mx_sb_len	 = hdr32.mx_sb_len,
+			.iovec_count	 = hdr32.iovec_count,
+			.dxfer_len	 = hdr32.dxfer_len,
+			.dxferp		 = compat_ptr(hdr32.dxferp),
+			.cmdp		 = compat_ptr(hdr32.cmdp),
+			.sbp		 = compat_ptr(hdr32.sbp),
+			.timeout	 = hdr32.timeout,
+			.flags		 = hdr32.flags,
+			.pack_id	 = hdr32.pack_id,
+			.usr_ptr	 = compat_ptr(hdr32.usr_ptr),
+			.status		 = hdr32.status,
+			.masked_status	 = hdr32.masked_status,
+			.msg_status	 = hdr32.msg_status,
+			.sb_len_wr	 = hdr32.sb_len_wr,
+			.host_status	 = hdr32.host_status,
+			.driver_status	 = hdr32.driver_status,
+			.resid		 = hdr32.resid,
+			.duration	 = hdr32.duration,
+			.info		 = hdr32.info,
+		};
+
+		return 0;
+	}
+#endif
+
+	if (copy_from_user(&hdr, argp, sizeof(hdr)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(get_sg_io_hdr);
+
 int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mode,
 		   unsigned int cmd, void __user *arg)
 {
@@ -581,14 +705,14 @@ int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mod
 		case SG_IO: {
 			struct sg_io_hdr hdr;
 
-			err = -EFAULT;
-			if (copy_from_user(&hdr, arg, sizeof(hdr)))
+			err = get_sg_io_hdr(&hdr, arg);
+			if (err)
 				break;
 			err = sg_io(q, bd_disk, &hdr, mode);
 			if (err == -EFAULT)
 				break;
 
-			if (copy_to_user(arg, &hdr, sizeof(hdr)))
+			if (put_sg_io_hdr(&hdr, arg))
 				err = -EFAULT;
 			break;
 		}
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index cce757506383..8ae096af2667 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -447,8 +447,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 					retval = -ENOMEM;
 					goto free_old_hdr;
 				}
-				retval =__copy_from_user
-				    (new_hdr, buf, SZ_SG_IO_HDR);
+				retval = get_sg_io_hdr(new_hdr, buf);
 				req_pack_id = new_hdr->pack_id;
 				kfree(new_hdr);
 				if (retval) {
@@ -589,10 +588,7 @@ sg_new_read(Sg_fd * sfp, char __user *buf, size_t count, Sg_request * srp)
 	}
 	if (hp->masked_status || hp->host_status || hp->driver_status)
 		hp->info |= SG_INFO_CHECK;
-	if (copy_to_user(buf, hp, SZ_SG_IO_HDR)) {
-		err = -EFAULT;
-		goto err_out;
-	}
+	err = put_sg_io_hdr(hp, buf);
 err_out:
 	err2 = sg_finish_rem_req(srp);
 	sg_remove_request(sfp, srp);
@@ -735,7 +731,7 @@ sg_new_write(Sg_fd *sfp, struct file *file, const char __user *buf,
 	}
 	srp->sg_io_owned = sg_io_owned;
 	hp = &srp->header;
-	if (__copy_from_user(hp, buf, SZ_SG_IO_HDR)) {
+	if (get_sg_io_hdr(hp, buf)) {
 		sg_remove_request(sfp, srp);
 		return -EFAULT;
 	}
@@ -1797,7 +1793,14 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 		struct iovec *iov = NULL;
 		struct iov_iter i;
 
-		res = import_iovec(rw, hp->dxferp, iov_count, 0, &iov, &i);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			res = compat_import_iovec(rw, hp->dxferp, iov_count,
+						  0, &iov, &i);
+		else
+#endif
+			res = import_iovec(rw, hp->dxferp, iov_count,
+					   0, &iov, &i);
 		if (res < 0)
 			return res;
 
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 10ba2d9e20bc..f279e77df256 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -64,151 +64,6 @@ static int do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 #ifdef CONFIG_BLOCK
-typedef struct sg_io_hdr32 {
-	compat_int_t interface_id;	/* [i] 'S' for SCSI generic (required) */
-	compat_int_t dxfer_direction;	/* [i] data transfer direction  */
-	unsigned char cmd_len;		/* [i] SCSI command length ( <= 16 bytes) */
-	unsigned char mx_sb_len;		/* [i] max length to write to sbp */
-	unsigned short iovec_count;	/* [i] 0 implies no scatter gather */
-	compat_uint_t dxfer_len;		/* [i] byte count of data transfer */
-	compat_uint_t dxferp;		/* [i], [*io] points to data transfer memory
-					      or scatter gather list */
-	compat_uptr_t cmdp;		/* [i], [*i] points to command to perform */
-	compat_uptr_t sbp;		/* [i], [*o] points to sense_buffer memory */
-	compat_uint_t timeout;		/* [i] MAX_UINT->no timeout (unit: millisec) */
-	compat_uint_t flags;		/* [i] 0 -> default, see SG_FLAG... */
-	compat_int_t pack_id;		/* [i->o] unused internally (normally) */
-	compat_uptr_t usr_ptr;		/* [i->o] unused internally */
-	unsigned char status;		/* [o] scsi status */
-	unsigned char masked_status;	/* [o] shifted, masked scsi status */
-	unsigned char msg_status;		/* [o] messaging level data (optional) */
-	unsigned char sb_len_wr;		/* [o] byte count actually written to sbp */
-	unsigned short host_status;	/* [o] errors from host adapter */
-	unsigned short driver_status;	/* [o] errors from software driver */
-	compat_int_t resid;		/* [o] dxfer_len - actual_transferred */
-	compat_uint_t duration;		/* [o] time taken by cmd (unit: millisec) */
-	compat_uint_t info;		/* [o] auxiliary information */
-} sg_io_hdr32_t;  /* 64 bytes long (on sparc32) */
-
-typedef struct sg_iovec32 {
-	compat_uint_t iov_base;
-	compat_uint_t iov_len;
-} sg_iovec32_t;
-
-static int sg_build_iovec(sg_io_hdr_t __user *sgio, void __user *dxferp, u16 iovec_count)
-{
-	sg_iovec_t __user *iov = (sg_iovec_t __user *) (sgio + 1);
-	sg_iovec32_t __user *iov32 = dxferp;
-	int i;
-
-	for (i = 0; i < iovec_count; i++) {
-		u32 base, len;
-
-		if (get_user(base, &iov32[i].iov_base) ||
-		    get_user(len, &iov32[i].iov_len) ||
-		    put_user(compat_ptr(base), &iov[i].iov_base) ||
-		    put_user(len, &iov[i].iov_len))
-			return -EFAULT;
-	}
-
-	if (put_user(iov, &sgio->dxferp))
-		return -EFAULT;
-	return 0;
-}
-
-static int sg_ioctl_trans(struct file *file, unsigned int cmd,
-			sg_io_hdr32_t __user *sgio32)
-{
-	sg_io_hdr_t __user *sgio;
-	u16 iovec_count;
-	u32 data;
-	void __user *dxferp;
-	int err;
-	int interface_id;
-
-	if (get_user(interface_id, &sgio32->interface_id))
-		return -EFAULT;
-	if (interface_id != 'S')
-		return do_ioctl(file, cmd, (unsigned long)sgio32);
-
-	if (get_user(iovec_count, &sgio32->iovec_count))
-		return -EFAULT;
-
-	{
-		void __user *top = compat_alloc_user_space(0);
-		void __user *new = compat_alloc_user_space(sizeof(sg_io_hdr_t) +
-				       (iovec_count * sizeof(sg_iovec_t)));
-		if (new > top)
-			return -EINVAL;
-
-		sgio = new;
-	}
-
-	/* Ok, now construct.  */
-	if (copy_in_user(&sgio->interface_id, &sgio32->interface_id,
-			 (2 * sizeof(int)) +
-			 (2 * sizeof(unsigned char)) +
-			 (1 * sizeof(unsigned short)) +
-			 (1 * sizeof(unsigned int))))
-		return -EFAULT;
-
-	if (get_user(data, &sgio32->dxferp))
-		return -EFAULT;
-	dxferp = compat_ptr(data);
-	if (iovec_count) {
-		if (sg_build_iovec(sgio, dxferp, iovec_count))
-			return -EFAULT;
-	} else {
-		if (put_user(dxferp, &sgio->dxferp))
-			return -EFAULT;
-	}
-
-	{
-		unsigned char __user *cmdp;
-		unsigned char __user *sbp;
-
-		if (get_user(data, &sgio32->cmdp))
-			return -EFAULT;
-		cmdp = compat_ptr(data);
-
-		if (get_user(data, &sgio32->sbp))
-			return -EFAULT;
-		sbp = compat_ptr(data);
-
-		if (put_user(cmdp, &sgio->cmdp) ||
-		    put_user(sbp, &sgio->sbp))
-			return -EFAULT;
-	}
-
-	if (copy_in_user(&sgio->timeout, &sgio32->timeout,
-			 3 * sizeof(int)))
-		return -EFAULT;
-
-	if (get_user(data, &sgio32->usr_ptr))
-		return -EFAULT;
-	if (put_user(compat_ptr(data), &sgio->usr_ptr))
-		return -EFAULT;
-
-	err = do_ioctl(file, cmd, (unsigned long) sgio);
-
-	if (err >= 0) {
-		void __user *datap;
-
-		if (copy_in_user(&sgio32->pack_id, &sgio->pack_id,
-				 sizeof(int)) ||
-		    get_user(datap, &sgio->usr_ptr) ||
-		    put_user((u32)(unsigned long)datap,
-			     &sgio32->usr_ptr) ||
-		    copy_in_user(&sgio32->status, &sgio->status,
-				 (4 * sizeof(unsigned char)) +
-				 (2 * sizeof(unsigned short)) +
-				 (3 * sizeof(int))))
-			err = -EFAULT;
-	}
-
-	return err;
-}
-
 struct compat_sg_req_info { /* used by SG_GET_REQUEST_TABLE ioctl() */
 	char req_state;
 	char orphan;
@@ -358,6 +213,7 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
 #endif
 #ifdef CONFIG_BLOCK
 /* SG stuff */
+COMPATIBLE_IOCTL(SG_IO)
 COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_GET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_EMULATED_HOST)
@@ -435,8 +291,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	case PPPIOCSACTIVE32:
 		return ppp_sock_fprog_ioctl_trans(file, cmd, argp);
 #ifdef CONFIG_BLOCK
-	case SG_IO:
-		return sg_ioctl_trans(file, cmd, argp);
 	case SG_GET_REQUEST_TABLE:
 		return sg_grt_trans(file, cmd, argp);
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ef375dafb1c..a1050710d846 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -853,6 +853,8 @@ extern int scsi_cmd_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 			  unsigned int, void __user *);
 extern int sg_scsi_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 			 struct scsi_ioctl_command __user *);
+extern int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp);
+extern int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp);
 
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f1e0569b4539..7baaa989404b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1678,6 +1678,7 @@ ssize_t compat_import_iovec(int type,
 	*iov = p == *iov ? NULL : p;
 	return n;
 }
+EXPORT_SYMBOL(compat_import_iovec);
 #endif
 
 int import_single_range(int rw, void __user *buf, size_t len,
-- 
2.20.0

