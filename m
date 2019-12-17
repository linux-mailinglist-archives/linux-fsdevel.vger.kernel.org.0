Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43429123980
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLQWSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:18:47 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLQWRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:44 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MZl1l-1iDrlU3PPT-00WpIf; Tue, 17 Dec 2019 23:17:31 +0100
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
Subject: [PATCH v2 19/27] compat_ioctl: move sys_compat_ioctl() to ioctl.c
Date:   Tue, 17 Dec 2019 23:17:00 +0100
Message-Id: <20191217221708.3730997-20-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uitpeVFCvHeOqyYvOf9VceF0TkY7WDr+aoxiayii8Nsle7oX7c4
 tRK0a94PCUH6uhLlvKz+JTH2P5Hn4tAZo7O8EVVZifhaA1VGs0ay1Ld7k3PT6fbHr21oFY3
 XfDJX0zycHaRJPsvt1s+0y9gkgyzTrVrCG/aFgHi2jXROje4THWKk8Don6y+d7EWfgZmw+k
 4HLFri5/9xxQsbf0VHy4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sVRCpX+XGZA=:ZBzw1UJJqSCs3zp91ameci
 KXBlh9Xa40oyraHgp1AAkgibcSSuAMYnnxdPm59s3JCuj3hQicsBkGRdsYttbK4dpo3xkmhW1
 y6wHfgiZVkGHXtPmuWR81JZHd2fXlRbVkVBmX8pSdEEEj5KsOW4mFk0G0yl4Kd7ILhhhniH8C
 UTQaJl3PdMxI77+Rb3MwaGcTTtuuoTubL18bpBSKIUKj7jtr40dt35GtOpOHuZsm2RQz5AIxi
 mQInCCSWJIErLmQc3NlhGLp1lyIDMcqLVRUA446pERNbNcp81qvFJjGQ+y/PUpG3zKLsAm26f
 iKpOiP7sFI4irglSea7jCZzcC1X60oiu5c3IuIAi3N6FcrpHwakYrt8YXVMyV1aW+Zbjw7Tce
 ounnfsyexFV4e2glN8SsS78BYQRS7IGM78S68cEkPnZJ3C3q9TEahk9DEDYYcf1S7dhR598s+
 AoENyPuZROXbicx4qWfLwMdawxzEDJaLYkeusfQEyDJxy99Qz8O8eHBlEWc7Ohji+l9xec88c
 GaioANanR4VIcTK4vfzhlgRkundMpFpXEN9hyrHPf2PbSCeyhn+34GR/qfnIr1LAqLaOz9nvG
 9gRjPimEYwiV+q9DAp68c8njXwRXtR9C7P2b+pJJBNvZ1NxQWOvt4PZqeUEbWDYb2t+K4Pn7N
 MvPWC2bxrM6OQmCfVkaN22zqQowq1p3T8mtHyTUL+TvX728JEhy6LoTqrpDwrSoqZZ8vaKibu
 8c7G/HAnzIsgYRm6qh+aA5rDPmWeDyhSJP8iXJZHKot5g6tkvRwli/79wGGfJ32+PdFJwzxal
 rVxt1jWN/T2Wa8lAF4xW8xSoNFDs7fdOPINGuBcHz0bJrG4PM8A3RtIbNFDoYnqDw2pxToSVy
 roQ65vYHMw3pGLUc6BZQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The rest of the fs/compat_ioctl.c file is no longer useful now,
so move the actual syscall as planned.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/Makefile       |   2 +-
 fs/compat_ioctl.c | 133 ----------------------------------------------
 fs/ioctl.c        |  90 +++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 134 deletions(-)
 delete mode 100644 fs/compat_ioctl.c

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

