Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994AED1882
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfJITOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:14:43 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731804AbfJITLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:15 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MacjC-1hgTm41Y0A-00cAyD; Wed, 09 Oct 2019 21:11:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 22/43] compat_ioctl: remove IGNORE_IOCTL()
Date:   Wed,  9 Oct 2019 21:10:22 +0200
Message-Id: <20191009191044.308087-22-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4ibtuu83t8J3I3nx9gtJjn6IFOwAlacfixwPLywJPqpQL/tXpS1
 FygjVs+7RNbo33Hl3Ps7NIL+XmxrAfbBfr+6JPmj1fbg2SfZnhDI6em5cdEoaCCHzg8C4Kb
 d7bNfYn5lk4T7ZnfkBPkWIGQMefp3eoztuKlhWglncgAtQr3gGD3qoILQFO1sZN9Q05kd1b
 ih6cVAqbzYsltwW0OpZ3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AcH8bIy42IU=:Mdqu1BVs/UAgPHhPWIU1fg
 xfeL1NPaBTP8tG0CaCM/etZWHcZFyqZ/JcvGFiXZQFXAqbuVKR3JuwMi2FKFfMSehbIQBshL5
 KeMkOFWYNR//Kb1gxf3/CoMzWtkQ7lxoT2FMiqiDRKOjGdW6Efh6IIXN9HOr7vOdGChqpWj2e
 fB/4+tj51O15u5zdmWSLY1id+RBNWkH3+rWtQt/UeOj7yFWxycB/HCACK0/Xej90uH6cNCdXb
 zmXhXwDLgZ0LZVH8GHO5siybAXh5SGZJ1wuCSBfnjxmALzOJAd1d7wBilIHT6MpoU4u0Ly8kz
 iHHSKluTiEbv0j+DBC8jvr2fxY99oCPzH1PEoqP/ci/5IyyLSBuQH3HftjVDxsD2XBeDPtEh0
 LHrhYaykEhpmZMklBDd/x8e4kcW1/0ZWQmRHrIVpA8q2r4BxeBL2egnOqJ8Hrh+Id7q3/+oHu
 Z9VGaAA3BqBoLT06xEjqjkREQaTtjVdd+isHMTbjCG8kl2P2Gox7Oo2w4gIBWZcZRPt4iJD3o
 /4FaxRBnOKYhkP5pCfJQbukqRZ1A3c095UeMe5/rk9s/uHNlbAW0AhSeXaTXVL8DdVLQ0l4eb
 jKXcwEPK+RsGPlj8Uj4nLmUJAxxzO7YuqHiF6KZ3DSjycA2xVM3/b/aL60224KS+VySLka3m8
 ScCgugnwewPeLD4n+S9sbU3gBQJGcw6fK7oIbNoqAiQ1q1hJAPU7BX0taqkpvBCtPxUwoOaCM
 ZiszSJxrqe1Rk60LNiScbulAusAlnKaXXTg2gjYcWm8ubKESDgZW60+tWUbS0otMtf+ujF4Pe
 xklC2Cjmlz0iE+D03CPf0s014ailuTfCTMuvbrArcH7d//4ao6BM0qmv5eiqc6tnasN4JaXsq
 meTGtpVPr9ivOZDUjojg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 07d106d0a33d ("vfs: fix up ENOIOCTLCMD error handling"),
we don't warn about unhandled compat-ioctl command code any more, but
just return the same error that a native file descriptor returns when
there is no handler.

This means the IGNORE_IOCTL() annotations are completely useless and
can all be removed. TIOCSTART/TIOCSTOP and KDGHWCLK/KDSHWCLK fall into
the same category, but for some reason were listed as COMPATIBLE_IOCTL().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 56 -----------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 33f732979f45..10dfe4d80bbd 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -56,11 +56,6 @@
 
 #include <linux/sort.h>
 
-#ifdef CONFIG_SPARC
-#include <linux/fb.h>
-#include <asm/fbio.h>
-#endif
-
 #define convert_in_user(srcptr, dstptr)			\
 ({							\
 	typeof(*srcptr) val;				\
@@ -358,17 +353,7 @@ static int ppp_scompress(struct file *file, unsigned int cmd,
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
 
 #define COMPATIBLE_IOCTL(cmd) XFORM((u32)cmd),
-/* ioctl should not be warned about even if it's not implemented.
-   Valid reasons to use this:
-   - It is implemented with ->compat_ioctl on some device, but programs
-   call it on others too.
-   - The ioctl is not implemented in the native kernel, but programs
-   call it commonly anyways.
-   Most other reasons are not valid. */
-#define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
-
 static unsigned int ioctl_pointer[] = {
-/* compatible ioctls first */
 /* Little t */
 COMPATIBLE_IOCTL(TIOCOUTQ)
 /* 'X' - originally XFS but some now in the VFS */
@@ -384,23 +369,7 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_SEND_COMMAND)
 COMPATIBLE_IOCTL(SCSI_IOCTL_PROBE_HOST)
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
 #endif
-/* Big V (don't complain on serial console) */
-IGNORE_IOCTL(VT_OPENQRY)
-IGNORE_IOCTL(VT_GETMODE)
-/*
- * These two are only for the sbus rtc driver, but
- * hwclock tries them on every rtc device first when
- * running on sparc.  On other architectures the entries
- * are useless but harmless.
- */
-COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
-COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
 #ifdef CONFIG_BLOCK
-/* md calls this on random blockdevs */
-IGNORE_IOCTL(RAID_VERSION)
-/* qemu/qemu-img might call these two on plain files for probing */
-IGNORE_IOCTL(CDROM_DRIVE_STATUS)
-IGNORE_IOCTL(FDGETPRM32)
 /* SG stuff */
 COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_GET_TIMEOUT)
@@ -487,31 +456,6 @@ COMPATIBLE_IOCTL(JSIOCGVERSION)
 COMPATIBLE_IOCTL(JSIOCGAXES)
 COMPATIBLE_IOCTL(JSIOCGBUTTONS)
 COMPATIBLE_IOCTL(JSIOCGNAME(0))
-
-/* fat 'r' ioctls. These are handled by fat with ->compat_ioctl,
-   but we don't want warnings on other file systems. So declare
-   them as compatible here. */
-#define VFAT_IOCTL_READDIR_BOTH32       _IOR('r', 1, struct compat_dirent[2])
-#define VFAT_IOCTL_READDIR_SHORT32      _IOR('r', 2, struct compat_dirent[2])
-
-IGNORE_IOCTL(VFAT_IOCTL_READDIR_BOTH32)
-IGNORE_IOCTL(VFAT_IOCTL_READDIR_SHORT32)
-
-#ifdef CONFIG_SPARC
-/* Sparc framebuffers, handled in sbusfb_compat_ioctl() */
-IGNORE_IOCTL(FBIOGTYPE)
-IGNORE_IOCTL(FBIOSATTR)
-IGNORE_IOCTL(FBIOGATTR)
-IGNORE_IOCTL(FBIOSVIDEO)
-IGNORE_IOCTL(FBIOGVIDEO)
-IGNORE_IOCTL(FBIOSCURPOS)
-IGNORE_IOCTL(FBIOGCURPOS)
-IGNORE_IOCTL(FBIOGCURMAX)
-IGNORE_IOCTL(FBIOPUTCMAP32)
-IGNORE_IOCTL(FBIOGETCMAP32)
-IGNORE_IOCTL(FBIOSCURSOR32)
-IGNORE_IOCTL(FBIOGCURSOR32)
-#endif
 };
 
 /*
-- 
2.20.0

