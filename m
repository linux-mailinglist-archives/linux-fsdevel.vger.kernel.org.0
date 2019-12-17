Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D271239C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLQWUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:20:03 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:38169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfLQWRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:39 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6bo8-1hctFg38KU-0185vc; Tue, 17 Dec 2019 23:17:26 +0100
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
Subject: [PATCH v2 08/27] compat: scsi: sg: fix v3 compat read/write interface
Date:   Tue, 17 Dec 2019 23:16:49 +0100
Message-Id: <20191217221708.3730997-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EPgVRxHLVmXq6xV18Ht+/wrImzU2wxByo1tUXVa0LaSS0Tun9rb
 Uc1alnCqaf3enDvyoANS+9o6zakLERXmmuEXztsCTp13GfgiBuXeR8jX0IlKpanAmMPOqWA
 IgIBFsbJcd5fe1lM8c2OaGrhNBdk0tKSomd1i3EWYQkZkp1hy5WEi8N1II4JLvGhrBcdAW0
 oDgUhAOGBaSxVKe/RbJEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:P6dApjCTFbs=:9MBkCDnDPmp4VM9Ikqp3lq
 SU2sCvfOWxk0wq0gm6yls1Me6krnN0BpciuDY9QhkKQRUqOFO8sFGAjGN34N/hIoB9Q+PiSq6
 oQxP7C++7OJnoydQ7H/JA3ksD3jV10zJciEn5IZWdyscG86GNIkxC+Zz2TIHIH11WcmwBGeht
 Y2vkJaROZnUwSgvqOZWp2Ak3pqIrf5nDWxf/kmx2DJVp/WS0wBRRcFP/oNwe65SN6RzAkBIuv
 XgDTmWi45gcHKI9+gb8Zza9Wec6hcLPcDZy56hLusJP8Cq+h184rs1L/28mje0jUSeRu5DsJX
 olK1cTlhScBiKVU9yJSXob1XZaBFPm3yVK92NVDpg63ry7oYWGzPZjzXlay2L0HrsKc9oK5j6
 Yy0+pBDLdH+jziICwteGxGWSOpQ7wIIfaw1rceeiFeeP6Wr+iJrr1sJXaTBOtSlSYZQL5YPO2
 CQnltBuEmfTR3ZybaZE0n2RsNQ4Ni50oJNHSxTa62y3msPziKqonM0MXIwh1ig/4qS+FxT6iz
 0bmD9++FKEn81LFze5UUonsQGYF0t6fYlu4IVg+pMtpg12DEmGgIWfTcKaAnCl0i/pDv/X1ex
 Snx0EEx9jfVwD3PlWwfKkiK7wSZg2a1esBKEz9SPKM+I85vvFp0D0WNmWw+1lb/4VKETmxGuG
 YdbwI6EGjhVCMgw75nw5K+WjfsOyWcE7RSywgFPdyyrh0kjlCOhMcASpVI6UbFZVtjiLm9pSN
 rd/gRUkKhufS/zSOYtUzavKTnToYwbyvMFsqD4flfKIbFEUdh/ICpp62xxKaHZvcik6wkMW8G
 3hec+15yIC/58C2OGDdPz+T/jedwh2d29hYQYmm77nzp+bzNJLkcdWxrr9Ty2QeXcV+O5Eyc/
 YaqwT/oBqIOqkTgYBnMQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the v5.4 merge window, a cleanup patch from Al Viro conflicted
with my rework of the compat handling for sg.c read(). Linus Torvalds
did a correct merge but pointed out that the resulting code is still
unsatisfactory.

I later noticed that the sg_new_read() function still gets the compat
mode wrong, when the 'count' argument is large enough to pass a
compat_sg_io_hdr object, but not a nativ sg_io_hdr.

To address both of these, move the definition of compat_sg_io_hdr
into a scsi/sg.h to make it visible to sg.c and rewrite the logic
for reading req_pack_id as well as the size check to a simpler
version that gets the expected results.

Fixes: c35a5cfb4150 ("scsi: sg: sg_read(): simplify reading ->pack_id of userland sg_io_hdr_t")
Fixes: 98aaaec4a150 ("compat_ioctl: reimplement SG_IO handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/scsi_ioctl.c |  29 +----------
 drivers/scsi/sg.c  | 126 +++++++++++++++++++++------------------------
 include/scsi/sg.h  |  30 +++++++++++
 3 files changed, 90 insertions(+), 95 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 650bade5ea5a..b61dbf4d8443 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -20,6 +20,7 @@
 #include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/sg.h>
 
 struct blk_cmd_filter {
 	unsigned long read_ok[BLK_SCSI_CMD_PER_LONG];
@@ -550,34 +551,6 @@ static inline int blk_send_start_stop(struct request_queue *q,
 	return __blk_send_generic(q, bd_disk, GPCMD_START_STOP_UNIT, data);
 }
 
-#ifdef CONFIG_COMPAT
-struct compat_sg_io_hdr {
-	compat_int_t interface_id;	/* [i] 'S' for SCSI generic (required) */
-	compat_int_t dxfer_direction;	/* [i] data transfer direction  */
-	unsigned char cmd_len;		/* [i] SCSI command length ( <= 16 bytes) */
-	unsigned char mx_sb_len;	/* [i] max length to write to sbp */
-	unsigned short iovec_count;	/* [i] 0 implies no scatter gather */
-	compat_uint_t dxfer_len;	/* [i] byte count of data transfer */
-	compat_uint_t dxferp;		/* [i], [*io] points to data transfer memory
-						or scatter gather list */
-	compat_uptr_t cmdp;		/* [i], [*i] points to command to perform */
-	compat_uptr_t sbp;		/* [i], [*o] points to sense_buffer memory */
-	compat_uint_t timeout;		/* [i] MAX_UINT->no timeout (unit: millisec) */
-	compat_uint_t flags;		/* [i] 0 -> default, see SG_FLAG... */
-	compat_int_t pack_id;		/* [i->o] unused internally (normally) */
-	compat_uptr_t usr_ptr;		/* [i->o] unused internally */
-	unsigned char status;		/* [o] scsi status */
-	unsigned char masked_status;	/* [o] shifted, masked scsi status */
-	unsigned char msg_status;	/* [o] messaging level data (optional) */
-	unsigned char sb_len_wr;	/* [o] byte count actually written to sbp */
-	unsigned short host_status;	/* [o] errors from host adapter */
-	unsigned short driver_status;	/* [o] errors from software driver */
-	compat_int_t resid;		/* [o] dxfer_len - actual_transferred */
-	compat_uint_t duration;		/* [o] time taken by cmd (unit: millisec) */
-	compat_uint_t info;		/* [o] auxiliary information */
-};
-#endif
-
 int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp)
 {
 #ifdef CONFIG_COMPAT
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 160748ad9c0f..eace8886d95a 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -405,6 +405,38 @@ sg_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int get_sg_io_pack_id(int *pack_id, void __user *buf, size_t count)
+{
+	struct sg_header __user *old_hdr = buf;
+	int reply_len;
+
+	if (count >= SZ_SG_HEADER) {
+		/* negative reply_len means v3 format, otherwise v1/v2 */
+		if (get_user(reply_len, &old_hdr->reply_len))
+			return -EFAULT;
+
+		if (reply_len >= 0)
+			return get_user(*pack_id, &old_hdr->pack_id);
+
+		if (in_compat_syscall() &&
+		    count >= sizeof(struct compat_sg_io_hdr)) {
+			struct compat_sg_io_hdr __user *hp = buf;
+
+			return get_user(*pack_id, &hp->pack_id);
+		}
+
+		if (count >= sizeof(struct sg_io_hdr)) {
+			struct sg_io_hdr __user *hp = buf;
+
+			return get_user(*pack_id, &hp->pack_id);
+		}
+	}
+
+	/* no valid header was passed, so ignore the pack_id */
+	*pack_id = -1;
+	return 0;
+}
+
 static ssize_t
 sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 {
@@ -413,8 +445,8 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 	Sg_request *srp;
 	int req_pack_id = -1;
 	sg_io_hdr_t *hp;
-	struct sg_header *old_hdr = NULL;
-	int retval = 0;
+	struct sg_header *old_hdr;
+	int retval;
 
 	/*
 	 * This could cause a response to be stranded. Close the associated
@@ -429,79 +461,34 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
 				      "sg_read: count=%d\n", (int) count));
 
-	if (sfp->force_packid && (count >= SZ_SG_HEADER)) {
-		old_hdr = memdup_user(buf, SZ_SG_HEADER);
-		if (IS_ERR(old_hdr))
-			return PTR_ERR(old_hdr);
-		if (old_hdr->reply_len < 0) {
-			if (count >= SZ_SG_IO_HDR) {
-				/*
-				 * This is stupid.
-				 *
-				 * We're copying the whole sg_io_hdr_t from user
-				 * space just to get the 'pack_id' field. But the
-				 * field is at different offsets for the compat
-				 * case, so we'll use "get_sg_io_hdr()" to copy
-				 * the whole thing and convert it.
-				 *
-				 * We could do something like just calculating the
-				 * offset based of 'in_compat_syscall()', but the
-				 * 'compat_sg_io_hdr' definition is in the wrong
-				 * place for that.
-				 */
-				sg_io_hdr_t *new_hdr;
-				new_hdr = kmalloc(SZ_SG_IO_HDR, GFP_KERNEL);
-				if (!new_hdr) {
-					retval = -ENOMEM;
-					goto free_old_hdr;
-				}
-				retval = get_sg_io_hdr(new_hdr, buf);
-				req_pack_id = new_hdr->pack_id;
-				kfree(new_hdr);
-				if (retval) {
-					retval = -EFAULT;
-					goto free_old_hdr;
-				}
-			}
-		} else
-			req_pack_id = old_hdr->pack_id;
-	}
+	if (sfp->force_packid)
+		retval = get_sg_io_pack_id(&req_pack_id, buf, count);
+	if (retval)
+		return retval;
+
 	srp = sg_get_rq_mark(sfp, req_pack_id);
 	if (!srp) {		/* now wait on packet to arrive */
-		if (atomic_read(&sdp->detaching)) {
-			retval = -ENODEV;
-			goto free_old_hdr;
-		}
-		if (filp->f_flags & O_NONBLOCK) {
-			retval = -EAGAIN;
-			goto free_old_hdr;
-		}
+		if (atomic_read(&sdp->detaching))
+			return -ENODEV;
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
 		retval = wait_event_interruptible(sfp->read_wait,
 			(atomic_read(&sdp->detaching) ||
 			(srp = sg_get_rq_mark(sfp, req_pack_id))));
-		if (atomic_read(&sdp->detaching)) {
-			retval = -ENODEV;
-			goto free_old_hdr;
-		}
-		if (retval) {
+		if (atomic_read(&sdp->detaching))
+			return -ENODEV;
+		if (retval)
 			/* -ERESTARTSYS as signal hit process */
-			goto free_old_hdr;
-		}
-	}
-	if (srp->header.interface_id != '\0') {
-		retval = sg_new_read(sfp, buf, count, srp);
-		goto free_old_hdr;
+			return retval;
 	}
+	if (srp->header.interface_id != '\0')
+		return sg_new_read(sfp, buf, count, srp);
 
 	hp = &srp->header;
-	if (old_hdr == NULL) {
-		old_hdr = kmalloc(SZ_SG_HEADER, GFP_KERNEL);
-		if (! old_hdr) {
-			retval = -ENOMEM;
-			goto free_old_hdr;
-		}
-	}
-	memset(old_hdr, 0, SZ_SG_HEADER);
+	old_hdr = kzalloc(SZ_SG_HEADER, GFP_KERNEL);
+	if (!old_hdr)
+		return -ENOMEM;
+
 	old_hdr->reply_len = (int) hp->timeout;
 	old_hdr->pack_len = old_hdr->reply_len; /* old, strange behaviour */
 	old_hdr->pack_id = hp->pack_id;
@@ -575,7 +562,12 @@ sg_new_read(Sg_fd * sfp, char __user *buf, size_t count, Sg_request * srp)
 	int err = 0, err2;
 	int len;
 
-	if (count < SZ_SG_IO_HDR) {
+	if (in_compat_syscall()) {
+		if (count < sizeof(struct compat_sg_io_hdr)) {
+			err = -EINVAL;
+			goto err_out;
+		}
+	} else if (count < SZ_SG_IO_HDR) {
 		err = -EINVAL;
 		goto err_out;
 	}
diff --git a/include/scsi/sg.h b/include/scsi/sg.h
index f91bcca604e4..29c7ad04d2e2 100644
--- a/include/scsi/sg.h
+++ b/include/scsi/sg.h
@@ -68,6 +68,36 @@ typedef struct sg_io_hdr
     unsigned int info;          /* [o] auxiliary information */
 } sg_io_hdr_t;  /* 64 bytes long (on i386) */
 
+#if defined(__KERNEL__)
+#include <linux/compat.h>
+
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
 #define SG_INTERFACE_ID_ORIG 'S'
 
 /* Use negative values to flag difference from original sg_header structure */
-- 
2.20.0

