Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D894D188D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfJITLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfJITLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:10 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLzSD-1iaDr11Rab-00HuC6; Wed, 09 Oct 2019 21:11:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 09/43] compat_ioctl: add compat_ptr_ioctl()
Date:   Wed,  9 Oct 2019 21:10:09 +0200
Message-Id: <20191009191044.308087-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CIXoOECmE4Ydk1Z/lGazuni0y3AvvhSKErUXxmDj6hoc/lGA6n1
 n1JlKtouYc5tmlB+Q0qfvmbnzsEuxX7hKdQa2JHuL5CbZvzjIiuTQGKRq74WhfL6aTIaqQu
 ugfbzDyybpOxAhTqrHD7Xo3Y+Tnhg9Yme/2A73obzZ+qbRLV76a0k5db+nae2Zl1AsN45CK
 gtCOqiLMNHBYx/+WpJMug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L2RMaJB5fME=:MXyBXS3UeBoG8NcHVgoKuK
 MhLtWnuMnfitDST7C/KybKwwmxC8yLd9aolr0idFbtXPC6CbseSRmKmAFb1Wt3gctoigO09TG
 h0vo3IYCesuUmnVs8SRrAYReBXQ8P15VP6JxgXwhYB/neR6VADupowpTtFKsGUUup6KnROs6+
 p+w06FOM7EkxXLz1+aX2BYY8yZ2ObSjaeJMNXYIcjeGRjnfpVNx7vkS+Vc+CkTSFI42dWt8/N
 f4TNoPEwHoDNUo0Z7ojIFDBgb2QVyD+770070FNgYrip6T0PeQKY2k0Ej2+NzByIfyFeIHclT
 GFgbbQM5TwJr0p+zOBEhR1+Ehzym4HvGYV8fv0UGrsUKhUGIv3UdLLskYKL0/q35fBVKWHgW1
 KvD477V5wvPX+Z7YcSsvwCSJ5OXdr9XNn5yjvDLYwqixkUuJYFEHaHM+zgTkfF4xvM6xVDQ1e
 fgm3jqHglitHN/q0GWd4Ji7EKRQhA+6p4ZGc1lGKG/8oCUDAQe+x/GRL5uH2BbyHkq65RnCOZ
 LOB0bFrfbVEbEML7Q+hKl1fkz08eZXcWVGgj02M/aV2c0hGRh184tYG0HSa8oqY3LPWCY0hcr
 /H730wsVLn9EycoOWqgo09mXJd0YHb5ks/eJcTHJWWwDuy+qlZuS12fvv0A7H3E4Ks5K5xbW3
 1cxSb2Nk9D23xcqeC4QV/mw9VLArrFmZTkMoPr8Uh3RGaEMrvleEOUzu2RaFC1qgrqoDQP/yQ
 jDm5nwfmDFYxuYrJ41njHCzr1VQAU0yCWAhF6ZB8z9r3oftMA77eUqD3xHW1ow52dlByyaMpw
 yQEZs3SjRLApN8tx+F8n2kc0hrXCP/2EYILdsSZ48BoEOqlucRA1rIYz+ZQy5rC8uxzvXklrj
 w1dVDe9K83tZ//NSsSKg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many drivers have ioctl() handlers that are completely compatible between
32-bit and 64-bit architectures, except for the argument that is passed
down from user space and may have to be passed through compat_ptr()
in order to become a valid 64-bit pointer.

Using ".compat_ptr = compat_ptr_ioctl" in file operations should let
us simplify a lot of those drivers to avoid #ifdef checks, and convert
additional drivers that don't have proper compat handling yet.

On most architectures, the compat_ptr_ioctl() just passes all arguments
to the corresponding ->ioctl handler. The exception is arch/s390, where
compat_ptr() clears the top bit of a 32-bit pointer value, so user space
pointers to the second 2GB alias the first 2GB, as is the case for native
32-bit s390 user space.

The compat_ptr_ioctl() function must therefore be used only with
ioctl functions that either ignore the argument or pass a pointer to a
compatible data type.

If any ioctl command handled by fops->unlocked_ioctl passes a plain
integer instead of a pointer, or any of the passed data types is
incompatible between 32-bit and 64-bit architectures, a proper handler
is required instead of compat_ptr_ioctl.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: add a better description
v2: use compat_ptr_ioctl instead of generic_compat_ioctl_ptrarg,
as suggested by Al Viro
---
 fs/ioctl.c         | 35 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 9d26251f34a9..812061ba667a 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -8,6 +8,7 @@
 #include <linux/syscalls.h>
 #include <linux/mm.h>
 #include <linux/capability.h>
+#include <linux/compat.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
@@ -748,3 +749,37 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 {
 	return ksys_ioctl(fd, cmd, arg);
 }
+
+#ifdef CONFIG_COMPAT
+/**
+ * compat_ptr_ioctl - generic implementation of .compat_ioctl file operation
+ *
+ * This is not normally called as a function, but instead set in struct
+ * file_operations as
+ *
+ *     .compat_ioctl = compat_ptr_ioctl,
+ *
+ * On most architectures, the compat_ptr_ioctl() just passes all arguments
+ * to the corresponding ->ioctl handler. The exception is arch/s390, where
+ * compat_ptr() clears the top bit of a 32-bit pointer value, so user space
+ * pointers to the second 2GB alias the first 2GB, as is the case for
+ * native 32-bit s390 user space.
+ *
+ * The compat_ptr_ioctl() function must therefore be used only with ioctl
+ * functions that either ignore the argument or pass a pointer to a
+ * compatible data type.
+ *
+ * If any ioctl command handled by fops->unlocked_ioctl passes a plain
+ * integer instead of a pointer, or any of the passed data types
+ * is incompatible between 32-bit and 64-bit architectures, a proper
+ * handler is required instead of compat_ptr_ioctl.
+ */
+long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	if (!file->f_op->unlocked_ioctl)
+		return -ENOIOCTLCMD;
+
+	return file->f_op->unlocked_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+EXPORT_SYMBOL(compat_ptr_ioctl);
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..0b4d8fc79e0f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1727,6 +1727,13 @@ int vfs_mkobj(struct dentry *, umode_t,
 
 extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
+#ifdef CONFIG_COMPAT
+extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
+					unsigned long arg);
+#else
+#define compat_ptr_ioctl NULL
+#endif
+
 /*
  * VFS file helper functions.
  */
-- 
2.20.0

