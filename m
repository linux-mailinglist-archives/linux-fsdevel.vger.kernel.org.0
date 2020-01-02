Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF6612E7C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgABPCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 10:02:25 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgABPCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:02:24 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MfHQp-1jOJja3KQN-00gnxw; Thu, 02 Jan 2020 16:01:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.com>,
        David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Gao Xiang <xiang@kernel.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 14/22] compat_ioctl: move sys_compat_ioctl() to ioctl.c
Date:   Thu,  2 Jan 2020 15:55:32 +0100
Message-Id: <20200102145552.1853992-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QHW26qoZu7BFOLY294SQCDAdYS+0LermWcmWpuZcCs1uu3ygnuv
 o7yXMPGUgodpJydzENgx8LxWBx25o6BxiYCvPny319dmjTgRx3wYYT08P3JX6GkwJPdF9Fv
 uTGqxsO8Oi2yjHAK0GmswsnVYNnaJTVnLlycdPQvfZBCOsHny1TQi6zBU/4Nm/gN4adJEcM
 QfsIzZQzDJpkVSQ8QcANA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o4Y9FEc7lmM=:FQzkxK5zPiq0iQsTxqM13f
 Zbrvxtvh6EyBo2ubdbPy+9B0cTbLhK4uRVtQaXlx0OSds661k1ptv1bN4I/FttEvINcwSqVmC
 U4RtO1HnQUnMdYaPoO5emXKtb329TqemuRcKxqr2X6Sq9gHsaVgxycAcr8+bvqeDC+OPnaOvw
 AWT5t08j27I1pahKYrts7dafLHbA2MlalQmUW/EgQnoccEs5lN4DFbgpAh/bjTwiQOrYgl4dz
 e37F0L1cmLiUXWkxzmplJUX9pLfuE279NlzQoaAs3JD1MCnk1I/mVc5X1isLVU4ZT3bv4i8AG
 T3xwBpDaexQCASS43vdn+GRqhtGaAOuR5EqmAoaCNsBz5J4xj8SC9smxVp/PwPRYcItIRV7LB
 vIqQsyCRT7EUky08cPguYbYajeKnLoTBgc/QwZlZUPuQsj9+8OuOS7Lp7UcRSVImgAGi+h9j2
 /dKWFJRjPBjRWAc+uaX8Ftjq4fC8fOd+He6LIe8L9/aPCCviqTAuuZjf8Udm7RUV0pU2byQtF
 5rS9pvbxf67gbNWnIsnxUdQRjut/dfDcOl06yWIO45vwu0aZwV9Lgew0CjwuXGdPBMlXjqSEc
 L94ufpzZ4op6UvW3e3fyzyJFE9ExIzyu6LTUMxIMh2oHMxfTCmp2RI4VOdRVjv736etSXyctU
 fORl2tWlEytlTlW7xDPBSGF/FQxCE8tti0cRPQviQXkk9l1J6d359h/jgDkXWjTLk5i0vG5c9
 I2lRlUatZW8fRkrKPe/Gxb+uPtSm3k43mICXElFl1t68SC6Z3tJzP/nYcoIbRgPy23f60/g+E
 a4E7wOx7+hTyEqg/fnkZs8nhC08/GNEILnz4SPSleIXlOEbUJ+3KJepIDkANsNqFPRODSP6jG
 p06GILZr5NMNAyTKHejQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The rest of the fs/compat_ioctl.c file is no longer useful now,
so move the actual syscall as planned.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/sr.c |   2 +-
 fs/Makefile       |   2 +-
 fs/compat_ioctl.c | 133 ----------------------------------------------
 fs/ioctl.c        |  90 +++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 135 deletions(-)
 delete mode 100644 fs/compat_ioctl.c

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 6033a886c42c..f1e7aab00ce3 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -634,7 +634,7 @@ static int sr_block_compat_ioctl(struct block_device *bdev, fmode_t mode, unsign
 	 */
 	ret = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
 	if (ret != -ENOTTY)
-		return ret;
+		goto put;
 
 	ret = scsi_compat_ioctl(sdev, cmd, argp);
 
diff --git a/fs/Makefile b/fs/Makefile
index 1148c555c4d3..98be354fdb61 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
-obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
+obj-$(CONFIG_COMPAT)		+= compat.o
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
 obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
deleted file mode 100644
index ab4471f469e6..000000000000
--- a/fs/compat_ioctl.c
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
- *
- * Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
- * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
- * Copyright (C) 2001,2002  Andi Kleen, SuSE Labs 
- * Copyright (C) 2003       Pavel Machek (pavel@ucw.cz)
- *
- * These routines maintain argument size conversion between 32bit and 64bit
- * ioctls.
- */
-
-#include <linux/types.h>
-#include <linux/compat.h>
-#include <linux/kernel.h>
-#include <linux/capability.h>
-#include <linux/compiler.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/ioctl.h>
-#include <linux/if.h>
-#include <linux/raid/md_u.h>
-#include <linux/falloc.h>
-#include <linux/file.h>
-#include <linux/ppp-ioctl.h>
-#include <linux/if_pppox.h>
-#include <linux/tty.h>
-#include <linux/vt_kern.h>
-#include <linux/blkdev.h>
-#include <linux/serial.h>
-#include <linux/ctype.h>
-#include <linux/syscalls.h>
-#include <linux/gfp.h>
-#include <linux/cec.h>
-
-#include "internal.h"
-
-#include <linux/uaccess.h>
-#include <linux/watchdog.h>
-
-#include <linux/hiddev.h>
-
-COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
-		       compat_ulong_t, arg32)
-{
-	unsigned long arg = arg32;
-	struct fd f = fdget(fd);
-	int error = -EBADF;
-	if (!f.file)
-		goto out;
-
-	/* RED-PEN how should LSM module know it's handling 32bit? */
-	error = security_file_ioctl(f.file, cmd, arg);
-	if (error)
-		goto out_fput;
-
-	switch (cmd) {
-	/* these are never seen by ->ioctl(), no argument or int argument */
-	case FIOCLEX:
-	case FIONCLEX:
-	case FIFREEZE:
-	case FITHAW:
-	case FICLONE:
-		goto do_ioctl;
-	/* these are never seen by ->ioctl(), pointer argument */
-	case FIONBIO:
-	case FIOASYNC:
-	case FIOQSIZE:
-	case FS_IOC_FIEMAP:
-	case FIGETBSZ:
-	case FICLONERANGE:
-	case FIDEDUPERANGE:
-		goto found_handler;
-	/*
-	 * The next group is the stuff handled inside file_ioctl().
-	 * For regular files these never reach ->ioctl(); for
-	 * devices, sockets, etc. they do and one (FIONREAD) is
-	 * even accepted in some cases.  In all those cases
-	 * argument has the same type, so we can handle these
-	 * here, shunting them towards do_vfs_ioctl().
-	 * ->compat_ioctl() will never see any of those.
-	 */
-	/* pointer argument, never actually handled by ->ioctl() */
-	case FIBMAP:
-		goto found_handler;
-	/* handled by some ->ioctl(); always a pointer to int */
-	case FIONREAD:
-		goto found_handler;
-	/* these get messy on amd64 due to alignment differences */
-#if defined(CONFIG_X86_64)
-	case FS_IOC_RESVSP_32:
-	case FS_IOC_RESVSP64_32:
-		error = compat_ioctl_preallocate(f.file, 0, compat_ptr(arg));
-		goto out_fput;
-	case FS_IOC_UNRESVSP_32:
-	case FS_IOC_UNRESVSP64_32:
-		error = compat_ioctl_preallocate(f.file, FALLOC_FL_PUNCH_HOLE,
-				compat_ptr(arg));
-		goto out_fput;
-	case FS_IOC_ZERO_RANGE_32:
-		error = compat_ioctl_preallocate(f.file, FALLOC_FL_ZERO_RANGE,
-				compat_ptr(arg));
-		goto out_fput;
-#else
-	case FS_IOC_RESVSP:
-	case FS_IOC_RESVSP64:
-	case FS_IOC_UNRESVSP:
-	case FS_IOC_UNRESVSP64:
-	case FS_IOC_ZERO_RANGE:
-		goto found_handler;
-#endif
-
-	default:
-		if (f.file->f_op->compat_ioctl) {
-			error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
-			if (error != -ENOIOCTLCMD)
-				goto out_fput;
-		}
-
-		error = -ENOTTY;
-		goto out_fput;
-	}
-
- found_handler:
-	arg = (unsigned long)compat_ptr(arg);
- do_ioctl:
-	error = do_vfs_ioctl(f.file, fd, cmd, arg);
- out_fput:
-	fdput(f);
- out:
-	return error;
-}
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 2f5e4e5b97e1..8f22f7817edb 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -788,4 +788,94 @@ long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return file->f_op->unlocked_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 }
 EXPORT_SYMBOL(compat_ptr_ioctl);
+
+COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
+		       compat_ulong_t, arg32)
+{
+	unsigned long arg = arg32;
+	struct fd f = fdget(fd);
+	int error = -EBADF;
+	if (!f.file)
+		goto out;
+
+	/* RED-PEN how should LSM module know it's handling 32bit? */
+	error = security_file_ioctl(f.file, cmd, arg);
+	if (error)
+		goto out_fput;
+
+	switch (cmd) {
+	/* these are never seen by ->ioctl(), no argument or int argument */
+	case FIOCLEX:
+	case FIONCLEX:
+	case FIFREEZE:
+	case FITHAW:
+	case FICLONE:
+		goto do_ioctl;
+	/* these are never seen by ->ioctl(), pointer argument */
+	case FIONBIO:
+	case FIOASYNC:
+	case FIOQSIZE:
+	case FS_IOC_FIEMAP:
+	case FIGETBSZ:
+	case FICLONERANGE:
+	case FIDEDUPERANGE:
+		goto found_handler;
+	/*
+	 * The next group is the stuff handled inside file_ioctl().
+	 * For regular files these never reach ->ioctl(); for
+	 * devices, sockets, etc. they do and one (FIONREAD) is
+	 * even accepted in some cases.  In all those cases
+	 * argument has the same type, so we can handle these
+	 * here, shunting them towards do_vfs_ioctl().
+	 * ->compat_ioctl() will never see any of those.
+	 */
+	/* pointer argument, never actually handled by ->ioctl() */
+	case FIBMAP:
+		goto found_handler;
+	/* handled by some ->ioctl(); always a pointer to int */
+	case FIONREAD:
+		goto found_handler;
+	/* these get messy on amd64 due to alignment differences */
+#if defined(CONFIG_X86_64)
+	case FS_IOC_RESVSP_32:
+	case FS_IOC_RESVSP64_32:
+		error = compat_ioctl_preallocate(f.file, 0, compat_ptr(arg));
+		goto out_fput;
+	case FS_IOC_UNRESVSP_32:
+	case FS_IOC_UNRESVSP64_32:
+		error = compat_ioctl_preallocate(f.file, FALLOC_FL_PUNCH_HOLE,
+				compat_ptr(arg));
+		goto out_fput;
+	case FS_IOC_ZERO_RANGE_32:
+		error = compat_ioctl_preallocate(f.file, FALLOC_FL_ZERO_RANGE,
+				compat_ptr(arg));
+		goto out_fput;
+#else
+	case FS_IOC_RESVSP:
+	case FS_IOC_RESVSP64:
+	case FS_IOC_UNRESVSP:
+	case FS_IOC_UNRESVSP64:
+	case FS_IOC_ZERO_RANGE:
+		goto found_handler;
+#endif
+
+	default:
+		if (f.file->f_op->compat_ioctl) {
+			error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
+			if (error != -ENOIOCTLCMD)
+				goto out_fput;
+		}
+		error = -ENOTTY;
+		goto out_fput;
+	}
+
+ found_handler:
+	arg = (unsigned long)compat_ptr(arg);
+ do_ioctl:
+	error = do_vfs_ioctl(f.file, fd, cmd, arg);
+ out_fput:
+	fdput(f);
+ out:
+	return error;
+}
 #endif
-- 
2.20.0

