Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26B07B3EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfG3UCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:02:51 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UCv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:02:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M26j1-1hv2My1VVJ-002bV9; Tue, 30 Jul 2019 22:02:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 23/29] compat_ioctl: remove IGNORE_IOCTL()
Date:   Tue, 30 Jul 2019 22:01:28 +0200
Message-Id: <20190730200145.1081541-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730200145.1081541-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730200145.1081541-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ek1iGVz3z8rp0kwmTInwOrlxtyDELGcxvn7MnUHf2GpwA+Tcv27
 81WjuZnzfJAamGZOR10JbBpBocLtRFeXA/abGHufm3IQpdMqAvM1JYiwQIhKQrCN7kBp1WK
 ep/uslTZF/sihlfaZw3tTQGAKnstpVMJdcHnyaWVnTi1rdykvbhMqgenBjfxo0w//+qzk+3
 ZFvkPJdmHpCxrFw1zlkuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UmkzJ/W4nIU=:HLHpVhSqhr1vzrLA7vdU7r
 w60DltwgBt6R6ydZWyRzpQg/Fade+ac8bmRlXFnLwnSeS64HxrixyRs1Jq2N/IH7ZC8wNyiqL
 +oU3p8/fSPDULShz+7/mfXVZuUVreXAVpepOgYbqyAc0ty35hT/+PHzHYJ4aJyWl2j8RCHhXv
 a1WGzmbBlqRysnbl2Kg4yI5/GPpAOMLDE8dOq3kO0ewJiKN/X2QPXiN3uFlu3dUPC/nSClF7Q
 nYI3MvJUlwu6y3c0Q7KkCV1xR+Ut1WxG3kfzC4MqX6Gi8BxHvSkOunaBiKazkSq2VQtBLV7hO
 SQ19m6qBuznHxQDexVCpO/Gbk0CiflwsBfyyJETD6G4cALYkIXc6jVBOEj65dE/uGCRUgO7Pd
 9u6SzCSmoVFUPTcUxU/AhMlOztHGTybo/Ox4EHP4ZZqzRDtjRXiopLolJTOVFJJFZon6exE9i
 6peIRPf4nIm5Sy6yJtV163q+ipvmywcO48ozy4g2+EnbT1t+7EnUQ88yJ8Gc3oqU3kjrf9xbC
 WofKsy402JIx32VqTJARhFLxugnC/sbdvW5ZVvBSHHfazVmIwh7Ioo9B1bfW3eHTONrZcvJlv
 jfM5ppob2b3Nd1k4R+XWgg6GYLr4O99hVP3yzPk1/nQa+Ds4mIzFu557RtlR56K5nAO4I9Xv8
 CaLlb62YMewgnEMb9FD8lVhgNkRfYldLfjuY8dEUp15u7l1Sl69DAmFSpNrPepJ32Vt6s5qAh
 vXoff6cMi0IxzQjYobnzwlzQAIAupfvizZeq6A==
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

