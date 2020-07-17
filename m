Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07E22425D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGQRoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgGQRnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38387C0619DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so7016021pge.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdmbKVHrJifDyFKGRiPxQr6xGtyiyZhgnulqrb7cTi4=;
        b=KxsZTRcrmbjX9gRipSlc+nOn40x8bHka/KHPfn/aku/qUYWIs18vckaGAM0Opy3Tiy
         VqFTSRkK049oSCpFn9D/UQ0eXZ0WTO9YQXXmnhuSwDB/Rd+3QsgF6PvEMm3EjhVg49OZ
         p02I1Fb6XxnJKrdZVTGL5Xef3ANDJbCrFZGag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdmbKVHrJifDyFKGRiPxQr6xGtyiyZhgnulqrb7cTi4=;
        b=aLYr2EmleA0gd+fsKsAg9wvUlm9nxnIVivuSf+wfbXAp+VjfuaNu+b11MzxxokbI9J
         0bWppGiuuEKYFLBkRrtcWd6t9ezU/d9OfDITYiPosRM/O0x348TxkMqySQak9QomiLia
         tBVR48C2IJzBGKaxbFLXSnQxHAPyx/C/w506ICBvIYj4lVExhsgGcdcemf6sejlXfdFJ
         CQuXwu5Zm8lSmGb1opELxpe1/sMcfrADA7/NMlEvpuLhgRUvc2dioxcwGyUp9Kl8TFxw
         i+CjbrVIgwj02RKWKn4vc28sAXynz5RuFsfoUI74l9BAprN3zaMFZXb4GUINSrXAi97S
         VzdA==
X-Gm-Message-State: AOAM532Clh5my7PNW2Rw/D3iwg4VuuhSA8TV01B8BdP4PpJwAKhQ8qWO
        pffAalEq2JnsPbwz+Y3HaPU75Q==
X-Google-Smtp-Source: ABdhPJw80/ZJ0hMaNae5lO7bD+JI3n2e4F5wLXXQbKccAXCN9l9mug5+L6cCzWdA5XIP9OI5YQ+ZDA==
X-Received: by 2002:a62:e202:: with SMTP id a2mr9281383pfi.8.1595007797710;
        Fri, 17 Jul 2020 10:43:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm8261382pfy.193.2020.07.17.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] fs/kernel_read_file: Split into separate include file
Date:   Fri, 17 Jul 2020 10:42:59 -0700
Message-Id: <20200717174309.1164575-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>

Move kernel_read_file* out of linux/fs.h to its own linux/kernel_read_file.h
include file. That header gets pulled in just about everywhere
and doesn't really need functions not related to the general fs interface.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20200706232309.12010-2-scott.branden@broadcom.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/main.c |  1 +
 fs/exec.c                           |  1 +
 include/linux/fs.h                  | 38 ---------------------
 include/linux/ima.h                 |  1 +
 include/linux/kernel_read_file.h    | 51 +++++++++++++++++++++++++++++
 include/linux/security.h            |  1 +
 kernel/kexec_file.c                 |  1 +
 kernel/module.c                     |  1 +
 security/integrity/digsig.c         |  1 +
 security/integrity/ima/ima_fs.c     |  1 +
 security/integrity/ima/ima_main.c   |  1 +
 security/integrity/ima/ima_policy.c |  1 +
 security/loadpin/loadpin.c          |  1 +
 security/security.c                 |  1 +
 security/selinux/hooks.c            |  1 +
 15 files changed, 64 insertions(+), 38 deletions(-)
 create mode 100644 include/linux/kernel_read_file.h

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index c2f57cedcd6f..d4a413ea48ce 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -12,6 +12,7 @@
 
 #include <linux/capability.h>
 #include <linux/device.h>
+#include <linux/kernel_read_file.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/timer.h>
diff --git a/fs/exec.c b/fs/exec.c
index 2bf549757ce7..07a7fe9ac5be 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -23,6 +23,7 @@
  * formats.
  */
 
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f50a35d54a61..11dd6cc7de58 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2993,44 +2993,6 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
-/* This is a list of *what* is being read, not *how* nor *where*. */
-#define __kernel_read_file_id(id) \
-	id(UNKNOWN, unknown)		\
-	id(FIRMWARE, firmware)		\
-	id(MODULE, kernel-module)		\
-	id(KEXEC_IMAGE, kexec-image)		\
-	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-	id(POLICY, security-policy)		\
-	id(X509_CERTIFICATE, x509-certificate)	\
-	id(MAX_ID, )
-
-#define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
-#define __fid_stringify(dummy, str) #str,
-
-enum kernel_read_file_id {
-	__kernel_read_file_id(__fid_enumify)
-};
-
-static const char * const kernel_read_file_str[] = {
-	__kernel_read_file_id(__fid_stringify)
-};
-
-static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
-{
-	if ((unsigned)id >= READING_MAX_ID)
-		return kernel_read_file_str[READING_UNKNOWN];
-
-	return kernel_read_file_str[id];
-}
-
-extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
-			    enum kernel_read_file_id);
-extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
-				      enum kernel_read_file_id);
-extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
-					     enum kernel_read_file_id);
-extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
-				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 9164e1534ec9..148636bfcc8f 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_IMA_H
 #define _LINUX_IMA_H
 
+#include <linux/kernel_read_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
new file mode 100644
index 000000000000..78cf3d7dc835
--- /dev/null
+++ b/include/linux/kernel_read_file.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KERNEL_READ_FILE_H
+#define _LINUX_KERNEL_READ_FILE_H
+
+#include <linux/file.h>
+#include <linux/types.h>
+
+/* This is a list of *what* is being read, not *how* nor *where*. */
+#define __kernel_read_file_id(id) \
+	id(UNKNOWN, unknown)		\
+	id(FIRMWARE, firmware)		\
+	id(MODULE, kernel-module)		\
+	id(KEXEC_IMAGE, kexec-image)		\
+	id(KEXEC_INITRAMFS, kexec-initramfs)	\
+	id(POLICY, security-policy)		\
+	id(X509_CERTIFICATE, x509-certificate)	\
+	id(MAX_ID, )
+
+#define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
+#define __fid_stringify(dummy, str) #str,
+
+enum kernel_read_file_id {
+	__kernel_read_file_id(__fid_enumify)
+};
+
+static const char * const kernel_read_file_str[] = {
+	__kernel_read_file_id(__fid_stringify)
+};
+
+static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
+{
+	if ((unsigned int)id >= READING_MAX_ID)
+		return kernel_read_file_str[READING_UNKNOWN];
+
+	return kernel_read_file_str[id];
+}
+
+int kernel_read_file(struct file *file,
+		     void **buf, loff_t *size, loff_t max_size,
+		     enum kernel_read_file_id id);
+int kernel_read_file_from_path(const char *path,
+			       void **buf, loff_t *size, loff_t max_size,
+			       enum kernel_read_file_id id);
+int kernel_read_file_from_path_initns(const char *path,
+				      void **buf, loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id);
+int kernel_read_file_from_fd(int fd,
+			     void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id);
+
+#endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 0a0a03b36a3b..42df0d9b4c37 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -23,6 +23,7 @@
 #ifndef __LINUX_SECURITY_H
 #define __LINUX_SECURITY_H
 
+#include <linux/kernel_read_file.h>
 #include <linux/key.h>
 #include <linux/capability.h>
 #include <linux/fs.h>
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 09cc78df53c6..1358069ce9e9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
diff --git a/kernel/module.c b/kernel/module.c
index 26105148f4d2..e9765803601b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/sysfs.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index ac02b7632353..f8869be45d8f 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
+#include <linux/kernel_read_file.h>
 #include <linux/key-type.h>
 #include <linux/digsig.h>
 #include <linux/vmalloc.h>
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 15a44c5022f7..e13ffece3726 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/fcntl.h>
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f80ee4ce4669..dab4a13221cf 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
+#include <linux/kernel_read_file.h>
 #include <linux/mount.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e493063a3c34..f8390f6081f0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -9,6 +9,7 @@
 
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/kernel_read_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/magic.h>
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ee5cb944f4ad..81bc95127f92 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
 #include <linux/path.h>
diff --git a/security/security.c b/security/security.c
index 0ce3e73edd42..f5920115a325 100644
--- a/security/security.c
+++ b/security/security.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/integrity.h>
 #include <linux/ima.h>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index efa6108b1ce9..5de45010fb1a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/kd.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/tracehook.h>
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
-- 
2.25.1

