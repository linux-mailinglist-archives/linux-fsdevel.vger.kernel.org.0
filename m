Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838BF3B03E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhFVMOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:14:04 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42771 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhFVMOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:14:01 -0400
Received: from orion.localdomain ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MjSwu-1lXv4n04de-00l0Mu; Tue, 22 Jun 2021 14:11:43 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [RFC PATCH 1/6] fs: generic file operation for fstrim
Date:   Tue, 22 Jun 2021 14:11:31 +0200
Message-Id: <20210622121136.4394-2-info@metux.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622121136.4394-1-info@metux.net>
References: <20210622121136.4394-1-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mxnG189gnivpMOPC1iOvIJAilxj0ERkOrGBc0UZYCjdpWI1Ubs0
 T9yoC6NEk+K7+Jpb+a+kR/KCI0/mw2BXxEUPAaAoyUP/I8zhmJnsdD9TiNOMCfQRu+8pOTU
 2MA3ThpwpXuENCLw55zlsvIDwjSMV5cZCMQbNZ9y0bbfD5uVvCHwVoOyrJmSdeUpRXPIalb
 CieF9xMr5/I9R+3X/6vfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0m9wi6GdRnY=:eW/MAhdwj1XV05G2upUjs7
 tbo1j7ZY+NkNajmKR1YOC3INfClsijRQvlbwL7egQsrE1j+yrkekmh0aGtx1yfaEksEhqSgDW
 IM8pC4RfLWZVrhwfkQ6LalQndAnQR7bkRtROr7vhECdN5Kl0SoQGHCiB+/jbYSSZJH9r5k5oK
 paK+NUFGhbjFd1Ht5uIwLhY8QJbYyxug/4N98vmCGebnmAtr70EtwdWR4nQ+CwZC6Tnv5c1TD
 aX74x2s9x+Qut8j6SIGw5hBSs06flZK05X7D7Kz/WSGKsEHHxXs9IVopVVGyS9LlzTaroQOm3
 +SBhoDePFCGj19Xw8ZUMnzzCn81QRlbEMGsm+lfhlBB2qShvoXIL1m7EM4bxtes2QEWAZtRFS
 pU48EnwzrDUOEU6W4dSK39p48bAFGXnmQpK8JIvM2PYJzwQ/vVH8762k4xx/9nHgYNGwZdBxk
 YQ8Axku+FuqjE00ZH4oFfBKVwckz23lBEPv6weOMPqp0ozKQnO0rWa3CyJg3AeY8oaovpBQS0
 ALSieVLaPMus8KluY3RXeo=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to factor out common parts of fstrim ioctl's, introduce a new
file_operation field for the file system specific parts.

The generic ioctl code (do_vfs_ioctl) calls an helper for doing the common
actions (eg. permission checks or buffer copying). If the file system
doesn't supply an fstrim function, the call will be passed down directly
to the file system, as it used to be.

This change also enables an easier way for possible future relaxing of
permissions, eg. allowing unprivileged users to trim their own files
sounds like an apelling idea.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 fs/ioctl.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1e2204fa9963..3a638f1eb0f5 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -961,6 +961,51 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
 	return err;
 }
 
+/*
+ * ioctl_fitrim() generic handling for FITRIM ioctl() via dedicated file
+ * operation. It does't common things like copying the arg from/to userland,
+ * permission check, etc.
+ *
+ * If the handler in file_operation is NULL, just pass the ioctl down to the
+ * generic ioctl() handler, as it used to be.
+ */
+static int ioctl_fitrim(struct file *filp, unsigned int fd, unsigned int cmd,
+			void __user *argp)
+{
+	struct fstrim_range;
+	int ret;
+
+
+		if (S_ISREG(inode->i_mode))
+			return file_ioctl(filp, cmd, argp);
+		break;
+
+	/* if the fs doesn't implement the fitrim operation, just pass it to
+	   the fs's ioctl() operation, so remaining implementations are kept
+	   intact. this can be removed when all fs'es are converted */
+	if (!filp->f_op->fitrim) {
+		if (S_ISREG(inode->i_mode))
+			return file_ioctl(filp, cmd, argp);
+
+		return -ENOIOCTLCMD;
+	}
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&range, (struct fstrim_range __user)*argp,
+			   sizeof(range)))
+		return -EFAULT;
+
+	ret = filp->f_op->fitrim(filp, &range);
+
+	if (copy_to_user((struct fstrim_range __user)*argp, &range,
+			 sizeof(range)))
+		return -EFAULT;
+
+	return ret;
+}
+
 /*
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
@@ -1043,6 +1088,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FS_IOC_FSSETXATTR:
 		return ioctl_fssetxattr(filp, argp);
 
+	case FITRIM:
+		return ioctl_fitrim(filp, cmd, argp);
+
 	default:
 		if (S_ISREG(inode->i_mode))
 			return file_ioctl(filp, cmd, argp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..9e2f0cd5c787 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2059,6 +2059,7 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	long (*fstrim)(struct file *, struct fstrim_range *range);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.20.1

