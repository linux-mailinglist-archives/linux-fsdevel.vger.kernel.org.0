Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89327B35C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfG3TaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:30:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfG3TaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:30:08 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mvs2R-1iC0D41RtH-00su5I; Tue, 30 Jul 2019 21:29:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Phillip Potter <phil@philpotter.co.uk>
Subject: [PATCH v5 10/29] compat_ioctl: add compat_ptr_ioctl()
Date:   Tue, 30 Jul 2019 21:25:21 +0200
Message-Id: <20190730192552.4014288-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oaGT+dgCZ7eW61FvI0TZ9DdaBUodVzKQE6fy+DvsydsjtaA9t5t
 YNnIgO4VmLAEqquIOxEvpgquoRzqJpizCxZLxmHRWNeM82CA74cvT8w4AqLlGT2jwBI2T41
 9zXvcLKmuHlP0UV9NQfQRrVJ7XM9SRVtuvqO8+DHZpMZJB36p/mrh7jnkrETr//v+3RYnxW
 bcsdG1mf3FtsarekW2Dsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3P75hwXu32Y=:yg4yB85JnCIIeA3T5b7w+z
 6edHtMRI89PheXd23dSpuey5gLS/R1d2ABuxzHKIwHjEhrFYDahUTXurS8tMXtubp9Y+EMfDa
 O/WyXfyNDKIqf+1SyfAkVR8qJpOg260mRzQBVSNoPb0pTO5f2rmRltb+tVDR0IRgtD0Hw7OwM
 4THx1WA1mjP9gXRp1yTZ2agisqmmhMYrXZtpewerRiL3kPC75uSBfLxhhTz31JNtVVBsfENQn
 7sO2iYl0U28Uw8YQkGSRw3sL+3YjRlQeE7tHjW+fg0vzVfSnBGWlcXgfGGqL0vn8MzJTd3c+x
 l18NehHDl1xDZE3+eOLtPwyEsFh7cGk/pa/kiK2DzsoasnRo3hT9pEf00MyfVBmXVroK+UHzQ
 phV2wnJdmv+VaCew4+UB3umKmMbcZtVy989/CFjTXeYT+f8aAbQLPA+rRm9YpeXd211906qvS
 rNkFoRMRsZWqMGiT5I4+R8/30DHI+W9683aWBb95oXm0iVkBv0O3NqhMiPUaanDOnKhshNiWj
 LflYrLMjDaVuVCUOOqXd/hRL5g5op6Q/nAUbLYwZix7XTce480XJZlCuhAwTRpR/RIkjtWOee
 TN2PQ1PYgH7mm53aF6Fk+ske/686btFFgeJhPKueLW7L4vse0dey3vesME7UrbK7yy6ArTSjC
 gOj3z4V1pI1J6Pho3O8VSXxSOKI82ota2xMpDjOr4Y4SmEmkZ445sUuQEv/gdQrrvYSxTz9zz
 sNiXQB23GT/IK2Y1LyUUyZHHE1gCwquDBjZFkw==
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
index 56b8e358af5c..07b032e58032 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1702,6 +1702,13 @@ int vfs_mkobj(struct dentry *, umode_t,
 
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

