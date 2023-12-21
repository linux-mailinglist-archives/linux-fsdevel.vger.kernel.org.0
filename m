Return-Path: <linux-fsdevel+bounces-6656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A881B2F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5F2B229BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11F44D10A;
	Thu, 21 Dec 2023 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQFlcgzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3B4CB36;
	Thu, 21 Dec 2023 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so5998125e9.1;
        Thu, 21 Dec 2023 01:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703152456; x=1703757256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2ZdmV6mFZSXgUlUGvSfZl6UXJ+WcSkP8ofHyoJDlUo=;
        b=QQFlcgzYNeRmf807AeTAPoZH7Z6DaZhIskLkbnC9dVQ8PdX8YFBOAB08R61e3txr8y
         8NOwkXCpZbzDHrkbOIeZ5KqBC2v/1OREW2hwbOlgt0WaiT/ukI4qKBDfmDpPba5TOvjP
         iIPMgGVl/tksWW1sfV+7iWDVpQQtnNlPXie503R1e6cpsJgKU1E5rN5XF61VTKX346nl
         QDFmPZ3ekYtoza8eKC4vBvy3qkSSKaM48SsLVvatGIxXTdZTJLxg2CmgsrHF3tH/rGq+
         HCKJf7NB6MfIo13xqdrtOBTAdIHNb749nXC5uufKwBNc/O+Oe8F4u7zYAQIvqUuGMgi4
         gzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152456; x=1703757256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2ZdmV6mFZSXgUlUGvSfZl6UXJ+WcSkP8ofHyoJDlUo=;
        b=RmobWePbsm8wQVQhPv3zFIC1peYkdPuyKqS8izsEEarSD6yAshM2gxZ+TYD7HgbvKP
         kEvRgJ+FeLjjdfVYI297ASz1t5XfqfU+JyvITw6u1MoTU6Ryo9cWwCVkzMb7SIfwP4yV
         pYT+xFKnbHBHwk3MuT9hQOhOXmDTDYxX99foCzhpQpF1LWXvNzBiiPXof7aRFAMuVUgO
         lWe5/ideXb8xRwVtnnUwYrwzO7Hi7RyV4SpJGc8Fy/G3Ocdt+KAdZawVJ3Ds0UfTY7dx
         GW/jO7nVkcB/x36x1I5UsMtJzVWqfHtLk6S0xCbSX/Jdhr47jgS+QI8mfOgtNW3UjKXj
         xNRQ==
X-Gm-Message-State: AOJu0Yz+M0ym72rIvmalMiC2HH4olNghUoDML/Ah2p9j0LMwqQ20aLRm
	UYGHFQMxma3pEyFaRx/lQn0=
X-Google-Smtp-Source: AGHT+IFLmD2Ht8k20JOg16jZtHulpwgQ5lurg6Fuxg5jhT9zRPAFnoz5TmHlKEhFPi2R56vqyqnjGA==
X-Received: by 2002:a05:600c:46c6:b0:40d:3758:3251 with SMTP id q6-20020a05600c46c600b0040d37583251mr288655wmo.262.1703152455603;
        Thu, 21 Dec 2023 01:54:15 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f5-20020adff8c5000000b003367dad4a58sm1628082wrq.70.2023.12.21.01.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:54:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [RFC][PATCH 1/4] fs: prepare for stackable filesystems backing file helpers
Date: Thu, 21 Dec 2023 11:54:07 +0200
Message-Id: <20231221095410.801061-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221095410.801061-1-amir73il@gmail.com>
References: <20231221095410.801061-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for factoring out some backing file io helpers from
overlayfs, move backing_file_open() into a new file fs/backing-file.c
and header.

Add a MAINTAINERS entry for stackable filesystems and add a Kconfig
FS_STACK which stackable filesystems need to select.

For now, the backing_file struct, the backing_file alloc/free functions
and the backing_file_real_path() accessor remain internal to file_table.c.
We may change that in the future.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 MAINTAINERS                  |  9 +++++++
 fs/Kconfig                   |  4 +++
 fs/Makefile                  |  1 +
 fs/backing-file.c            | 48 ++++++++++++++++++++++++++++++++++++
 fs/open.c                    | 38 ----------------------------
 fs/overlayfs/Kconfig         |  1 +
 fs/overlayfs/file.c          |  1 +
 include/linux/backing-file.h | 17 +++++++++++++
 include/linux/fs.h           |  3 ---
 9 files changed, 81 insertions(+), 41 deletions(-)
 create mode 100644 fs/backing-file.c
 create mode 100644 include/linux/backing-file.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 788be9ab5b73..9115a4f0dec7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8186,6 +8186,15 @@ S:	Supported
 F:	fs/iomap/
 F:	include/linux/iomap.h
 
+FILESYSTEMS [STACKABLE]
+M:	Miklos Szeredi <miklos@szeredi.hu>
+M:	Amir Goldstein <amir73il@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+L:	linux-unionfs@vger.kernel.org
+S:	Maintained
+F:	fs/backing-file.c
+F:	include/linux/backing-file.h
+
 FINTEK F75375S HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	Riku Voipio <riku.voipio@iki.fi>
 L:	linux-hwmon@vger.kernel.org
diff --git a/fs/Kconfig b/fs/Kconfig
index fd1f655b4f1f..c47fa4eb9282 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -18,6 +18,10 @@ config VALIDATE_FS_PARSER
 config FS_IOMAP
 	bool
 
+# Stackable filesystems
+config FS_STACK
+	bool
+
 config BUFFER_HEAD
 	bool
 
diff --git a/fs/Makefile b/fs/Makefile
index 75522f88e763..a6962c588962 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
 obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat.o
 
+obj-$(CONFIG_FS_STACK)		+= backing-file.o
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
diff --git a/fs/backing-file.c b/fs/backing-file.c
new file mode 100644
index 000000000000..04b33036f709
--- /dev/null
+++ b/fs/backing-file.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common helpers for stackable filesystems and backing files.
+ *
+ * Copyright (C) 2023 CTERA Networks.
+ */
+
+#include <linux/fs.h>
+#include <linux/backing-file.h>
+
+#include "internal.h"
+
+/**
+ * backing_file_open - open a backing file for kernel internal use
+ * @user_path:	path that the user reuqested to open
+ * @flags:	open flags
+ * @real_path:	path of the backing file
+ * @cred:	credentials for open
+ *
+ * Open a backing file for a stackable filesystem (e.g., overlayfs).
+ * @user_path may be on the stackable filesystem and @real_path on the
+ * underlying filesystem.  In this case, we want to be able to return the
+ * @user_path of the stackable filesystem. This is done by embedding the
+ * returned file into a container structure that also stores the stacked
+ * file's path, which can be retrieved using backing_file_user_path().
+ */
+struct file *backing_file_open(const struct path *user_path, int flags,
+			       const struct path *real_path,
+			       const struct cred *cred)
+{
+	struct file *f;
+	int error;
+
+	f = alloc_empty_backing_file(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	path_get(user_path);
+	*backing_file_user_path(f) = *user_path;
+	error = vfs_open(real_path, f);
+	if (error) {
+		fput(f);
+		f = ERR_PTR(error);
+	}
+
+	return f;
+}
+EXPORT_SYMBOL_GPL(backing_file_open);
diff --git a/fs/open.c b/fs/open.c
index d877228d5939..a75054237437 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1184,44 +1184,6 @@ struct file *kernel_file_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
-/**
- * backing_file_open - open a backing file for kernel internal use
- * @user_path:	path that the user reuqested to open
- * @flags:	open flags
- * @real_path:	path of the backing file
- * @cred:	credentials for open
- *
- * Open a backing file for a stackable filesystem (e.g., overlayfs).
- * @user_path may be on the stackable filesystem and @real_path on the
- * underlying filesystem.  In this case, we want to be able to return the
- * @user_path of the stackable filesystem. This is done by embedding the
- * returned file into a container structure that also stores the stacked
- * file's path, which can be retrieved using backing_file_user_path().
- */
-struct file *backing_file_open(const struct path *user_path, int flags,
-			       const struct path *real_path,
-			       const struct cred *cred)
-{
-	struct file *f;
-	int error;
-
-	f = alloc_empty_backing_file(flags, cred);
-	if (IS_ERR(f))
-		return f;
-
-	path_get(user_path);
-	*backing_file_user_path(f) = *user_path;
-	f->f_path = *real_path;
-	error = do_dentry_open(f, d_inode(real_path->dentry), NULL);
-	if (error) {
-		fput(f);
-		f = ERR_PTR(error);
-	}
-
-	return f;
-}
-EXPORT_SYMBOL_GPL(backing_file_open);
-
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
 #define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
 
diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
index fec5020c3495..2ac67e04a6fb 100644
--- a/fs/overlayfs/Kconfig
+++ b/fs/overlayfs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config OVERLAY_FS
 	tristate "Overlay filesystem support"
+	select FS_STACK
 	select EXPORTFS
 	help
 	  An overlay filesystem combines two filesystems - an 'upper' filesystem
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4e46420c8fdd..a6da3eaf6d4f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/backing-file.h>
 #include "overlayfs.h"
 
 #include "../internal.h"	/* for sb_init_dio_done_wq */
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
new file mode 100644
index 000000000000..55c9e804f780
--- /dev/null
+++ b/include/linux/backing-file.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common helpers for stackable filesystems and backing files.
+ *
+ * Copyright (C) 2023 CTERA Networks.
+ */
+
+#ifndef _LINUX_BACKING_FILE_H
+#define _LINUX_BACKING_FILE_H
+
+#include <linux/file.h>
+
+struct file *backing_file_open(const struct path *user_path, int flags,
+			       const struct path *real_path,
+			       const struct cred *cred);
+
+#endif /* _LINUX_BACKING_FILE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 900d0cd55b50..db5d07e6e02e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2575,9 +2575,6 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct file *backing_file_open(const struct path *user_path, int flags,
-			       const struct path *real_path,
-			       const struct cred *cred);
 struct path *backing_file_user_path(struct file *f);
 
 /*
-- 
2.34.1


