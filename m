Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD697B344
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfG3T1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:27:53 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46957 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfG3T1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:27:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MBDSg-1i5DlA14H8-00CikT; Tue, 30 Jul 2019 21:27:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 06/29] compat_sys_ioctl(): make parallel to do_vfs_ioctl()
Date:   Tue, 30 Jul 2019 21:25:17 +0200
Message-Id: <20190730192552.4014288-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eUvt0YwKFhdJg3lXz9kxlv3RXRQRot6byum/SOVWh3BqhBoj/Qc
 n5CZqcDwwKhTWYc1HfnuIFiUr8gnv1TUw0T6/y2KQFQ0GqYgwzhsbaxfkolBUIt5CO4qih8
 DnkkS1PeIfjzlniRUYryGnDLX9dVaYM4JbWRnRxBfrMN5rLpNmyQyDj9NMY8v1uv4YE2PEz
 bl+IkX+jtbo0u4NM30/jQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s3Bn1Da8AC4=:aD9jeEvFDKbXMao1EcVNht
 gWfXtfcsfsUvkOV5fH9VL7WfvhDLEP01Rc+Ux+8H7G/7meXuGe1fqJ03l1mlMTEVOcXMgpbn/
 DaUnN6Ls/LDtZy4Z2fLoFIaletrZJmrD6HkIB14fj7In5Vzh0AqIjuoq7RWDGxzneVNsB2rTh
 kFPmzEB4H5xp7gQZ/8/J920fBHy4u7ZKqx25bU9XLd+yHdgwqstrC3nQGB6hRUyIPON4SvsZs
 8+kN+LuxBLwMem0zDvl0EcDrGzZIFKFlyOMXhodI5TwTOo1CTm7hsYNo8/XLMfPBxISjB+P/H
 v3jN0UMcHHQuunipcIAEMutgnKu7wJN1EIVSHjFxRXRDfQmAZCL72eq8MZalKTK8f37orV9b5
 ovkR3BUD96LMEycqJH/Bx1clGRN5cC7yv/vk+2zu0nquHaeZn4xJ0RZkmz7oGfY9lclgfxAro
 orDtEED/WLtX0HVNU3WJrAB72rUxEG4005j82nE1rzgte0N53qDXh90/qpaXg+Rru+9xYctWq
 zor2KmkXeWprzwK91UazLo1KD4WV0c/xtD6GR/31ke6YZzQqkt6tat9diCMt1Ok1DGGZpcrl0
 OdMpUw20AxETEjLetKzW7zVhLec9qTMBopqts22IJbIQ3kYDq44WezJUBgKnoOzQ2y965t3Ef
 RHnJuqtqmp8cU1lINUG28j5Lf6yoGGoRWeoGxudAVPbe3bGxEUgCZqwLFKNJRw0pn2QQy6sHy
 EotLIhNf3QjY2oXPpHq3Tmai2wkbZZX02lMI+A==
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
index 0a748324f96f..399287b277dd 100644
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
@@ -974,19 +962,39 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
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
@@ -995,23 +1003,8 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
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

