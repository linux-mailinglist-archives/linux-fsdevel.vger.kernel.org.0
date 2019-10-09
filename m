Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5710ED1897
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfJITPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:15:23 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJITLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MWAjC-1ibYVn29tK-00XaSj; Wed, 09 Oct 2019 21:11:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 06/43] compat_sys_ioctl(): make parallel to do_vfs_ioctl()
Date:   Wed,  9 Oct 2019 21:10:06 +0200
Message-Id: <20191009191044.308087-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WOVEDt2np91eiK1oiQBp5uo+5rR4In1UdGh9NlEpbg6vm0omKcr
 a3KGO6PgQtVlWhhfEl3CfgF6SJvcwClHasJeqzVP/gVaagwqhhjYTkWjOqYlvKplGTAjeIr
 wFQiWC2yxSaJ2bCZVl5yuOyGcpGCfAgdTngpr2EvOsUDi5t/bcVP8fZZwsjCJewwfKra4ta
 K9yHvmpA5S+jX6ob/2ZTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qq913+1lsiY=:S/eqYoa/lf0TVLC4kpg5Zb
 s8aubOCVqEVZyXHXPU3kIvoCcP9M0y1Sbyt/n2DvzqCH+A+1Btt1GK4CbLDvLzYimMAJv7WL/
 1U4bGlXj9vhNF39rf5+fk2eaZC1DN3qZe9vuFDepDNlfiwBxE9kJa6ftnk2ciQaKFx5+F1RFz
 Gc9ktAF+NtQ7pV5RjNsImxOBVKP+f4rNebsNh9L0hdpsuJ+OBuE15p+1SNGkbByFoJj3oK1x0
 r6t2SrRHmketKaPMCE2BduIjjMkF550H9Y0hygM1P8klPcq2qJocm1M584sJJUqiYtPNVxW/r
 u3OAiCEm3QJRzFfGjKbPbU6TkWHBYaRjcj+dfnAcMgNzNBBmHzjbOwhK4XVQkQ4YrbiN43MKU
 9o/HMIuMRosfD9ZhZu0QDrbhzrNIDz4deIovRsPUPBsYVpctUMP/hrTOc4Zm8CoUlS5br7gRN
 Rlzm3A36hyLn9BZOsD6FBeYe4HslxJAPflRfd4+S0/fv1n6qctW17IspBfEcoYyFvMJVB7NC/
 hryFw3mqP4ki5tqexOj1G8q9ePsPj75mpvBnEbzMNyNnORMuFGLAX08G6AY6MKu3FELKmq9qF
 9ob3QrLX9WyorQ+pAmwxlMGvSPF/gvGOO1amVLm/4eeykY9ey0seTI/PORE1tNzQvVFNW8/++
 xuhB3W5z6xfUqz3wVUD0DeH1bHK+aVmt3fOR1vs+kd6ZBnMlPWQplLq/4AfS4JV6Xu3U5fi8c
 rS4jJHGAmFOAmEtSNw7mra9EcDM0hyRy1aXmmyewFrGWUoxmXytB3EpmNSzTBaJUmrvVl2jaJ
 lmKzKVf7kOns6C8kIXlBXPCgy4zu72SJuhplCEZ6AIQDVPIFVHPLQHsuzevxWExlmpBIP0A/b
 rvNVT6WH8mNzOMTpTDOQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Handle ioctls that might be handled without reaching ->ioctl() in
native case on the top level there.  The counterpart of vfs_ioctl()
(i.e. calling ->unlock_ioctl(), etc.) left as-is; eventually
that would turn simply into the call of ->compat_ioctl(), but
that'll take more work.  Once that is done, we can move the
remains of compat_sys_ioctl() into fs/ioctl.c and finally bury
fs/compat_ioctl.c.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 63 +++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index ce995d4fa1f4..ecbd5254b547 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -487,19 +487,7 @@ static unsigned int ioctl_pointer[] = {
 /* compatible ioctls first */
 /* Little t */
 COMPATIBLE_IOCTL(TIOCOUTQ)
-/* Little f */
-COMPATIBLE_IOCTL(FIOCLEX)
-COMPATIBLE_IOCTL(FIONCLEX)
-COMPATIBLE_IOCTL(FIOASYNC)
-COMPATIBLE_IOCTL(FIONBIO)
-COMPATIBLE_IOCTL(FIONREAD)  /* This is also TIOCINQ */
-COMPATIBLE_IOCTL(FS_IOC_FIEMAP)
-/* 0x00 */
-COMPATIBLE_IOCTL(FIBMAP)
-COMPATIBLE_IOCTL(FIGETBSZ)
 /* 'X' - originally XFS but some now in the VFS */
-COMPATIBLE_IOCTL(FIFREEZE)
-COMPATIBLE_IOCTL(FITHAW)
 COMPATIBLE_IOCTL(FITRIM)
 #ifdef CONFIG_BLOCK
 /* Big S */
@@ -971,19 +959,39 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	if (error)
 		goto out_fput;
 
-	/*
-	 * To allow the compat_ioctl handlers to be self contained
-	 * we need to check the common ioctls here first.
-	 * Just handle them with the standard handlers below.
-	 */
 	switch (cmd) {
+	/* these are never seen by ->ioctl(), no argument or int argument */
 	case FIOCLEX:
 	case FIONCLEX:
+	case FIFREEZE:
+	case FITHAW:
+	case FICLONE:
+		goto do_ioctl;
+	/* these are never seen by ->ioctl(), pointer argument */
 	case FIONBIO:
 	case FIOASYNC:
 	case FIOQSIZE:
-		break;
-
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
+	/* these two get messy on amd64 due to alignment differences */
 #if defined(CONFIG_X86_64)
 	case FS_IOC_RESVSP_32:
 	case FS_IOC_RESVSP64_32:
@@ -992,23 +1000,8 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 #else
 	case FS_IOC_RESVSP:
 	case FS_IOC_RESVSP64:
-		error = ioctl_preallocate(f.file, compat_ptr(arg));
-		goto out_fput;
-#endif
-
-	case FICLONE:
-		goto do_ioctl;
-	case FICLONERANGE:
-	case FIDEDUPERANGE:
-	case FS_IOC_FIEMAP:
-	case FIGETBSZ:
 		goto found_handler;
-
-	case FIBMAP:
-	case FIONREAD:
-		if (S_ISREG(file_inode(f.file)->i_mode))
-			break;
-		/*FALL THROUGH*/
+#endif
 
 	default:
 		if (f.file->f_op->compat_ioctl) {
-- 
2.20.0

