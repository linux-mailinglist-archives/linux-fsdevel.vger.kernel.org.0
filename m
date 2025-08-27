Return-Path: <linux-fsdevel+bounces-59393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B74B3863E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555917B833C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65FC312819;
	Wed, 27 Aug 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwJuX+M/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149152853E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307767; cv=none; b=cdh07xo8izWDkZZR/9/qWViiMvbpAdYq+figU4GMR8+WyYiPUC5wFotJGcJNvAENlnT4Ch80KtQXgbLkC3XYvdxV66gkCVd1HW68Y9zRFKr2V5GJZrzo5U/sMaPC7yi0c+TKUP04xtWnIIm6AJnOC79Y8SJjt5NyPi9r1O21f/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307767; c=relaxed/simple;
	bh=kZjF0sSqx+5FmDXvAoC983U2XPglvCp39phKC5ZNRKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=NL04SxCP9pSnoSwbr2QkWpAKIyrF/SMjJ7sO8mVWXWLHW3LZqiLsP7TjQbqS42YIYirrc53ga/FlZ+iLWe7sP3gEglha4XIYFsP1O7xoXbZtVVswk1peCBKVow3o88g782Z2FVuW4D0CCAJycRwMOwv5vRIXMOiy+g/7vkEYirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwJuX+M/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mv4tjVeEmkg4u5d++BVU3AE8UvzEzsRk+7y9ta7YFmA=;
	b=CwJuX+M/3Os7gTMlxp8Tw4wg/Abs7qa4ypxIVPYZEZkIy/99SFHXHN0eE/eAGSCnuc8/cv
	zmvPzr6HgVRpmzuFyfMxQr+PHhLQVzukAM8vQ/RLT2LI2TbnM5s6qHDoQeEq5oJfzfAaxR
	Lj7JVNomFq2Ss6xL8eoWkpq/X3WYa38=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-Qj1OGBPWP9WukbyX6WanDA-1; Wed, 27 Aug 2025 11:16:01 -0400
X-MC-Unique: Qj1OGBPWP9WukbyX6WanDA-1
X-Mimecast-MFC-AGG-ID: Qj1OGBPWP9WukbyX6WanDA_1756307759
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b71eef08eso4464045e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307758; x=1756912558;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv4tjVeEmkg4u5d++BVU3AE8UvzEzsRk+7y9ta7YFmA=;
        b=jsL0G/96NJpdWCA6UZ7ZBiNj0f4M2tc1rIL9Tgr34pND0ZQw8MT1kENBOhiKdk5DL7
         dVHwoowFo0YMFy/mFVzAML+x0qNfl9VOtUWGd1TFjSMRFIjAeJAGA+vAL9w69giePOJZ
         l0QYEvTANq5ukdJCuCte0C364lj32w/MIfmLN06o1kWPpkMHj6WWT7NxTEtOHes3QVBd
         O2nx/NWtXbnnvpm+BV2ta5F8PDgcW2pQCGbru1OWcPI6O+y41MywV/ZFyfXtrkf/KErv
         Q18jTrlr21qQdL4W4oHBOGyfTVINQpVxgvk+H4m4Erh8bKsfST6aR/YfeAspd3+CuwqV
         mVEg==
X-Forwarded-Encrypted: i=1; AJvYcCVth/45NfLv3IMd3GdYZYIMiHaQhU1gf8SamgQAw6/Man3emNhHoQWCur3+cVX4pIAjoBrUCsfUzwp5Ye7A@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKt1wMEAuwsCAZvtzieBTpSLPjFwo3fSi1GQLr594PcRKFT4C
	Cw8K1Sx6gzsoOlFvmf7D2Lisy4xbXXT25bCgq3Fv2JMn4Wc1v9Wz8gRWIRATY+uI47LclNyZNkW
	/xmVYgyWYyxZjGhW6bNu4ioSRVAA0t6ebSC8jaL+50ug92g6qpYSYlviI1IcLo72qn/gV1DPpjQ
	==
X-Gm-Gg: ASbGncv4bbLD0J37guDlD9LkEKW/4lMgGB8VDVbxSdP5nlHLHp1b5uv7ZqF6LeEMEgN
	TKQwkG4h++rqA7yMsAN39HsAzXB4lbXPptw7NthZIe6kCjg/qk8jLADO8WVWrQfRgz0r9n2RnFF
	SL73fhtzZ96T7TEWtVBME+bBcd2pJcUDb7OOFO/zd5tjEZ1V/x4ZDGsfsYZ0UihyTTNnH4aEuQW
	q+7f7TUM7NYWwDjZ25HzD6WPN9fmQxHV7lSt7tVcWOWXkvrYO0hyzl2uYGVbPQhIX9J5O7HATEa
	k4XD7Pqmew+zT+5V3A==
X-Received: by 2002:a05:600c:1ca0:b0:458:be44:357b with SMTP id 5b1f17b1804b1-45b517ad7bdmr157463825e9.15.1756307758378;
        Wed, 27 Aug 2025 08:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOnaickknvHXVF+nKbTKRjH9nbHWer2PHunwMtOjVcHCZfO2UhJlk/zAIYWX/D1CW9vZUOcg==
X-Received: by 2002:a05:600c:1ca0:b0:458:be44:357b with SMTP id 5b1f17b1804b1-45b517ad7bdmr157463535e9.15.1756307757882;
        Wed, 27 Aug 2025 08:15:57 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0e27b2sm33896285e9.10.2025.08.27.08.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:15:57 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 27 Aug 2025 17:15:53 +0200
Subject: [PATCH v2 1/4] libfrog: add wrappers for file_getattr/file_setattr
 syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-xattrat-syscall-v2-1-82a2d2d5865b@kernel.org>
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
In-Reply-To: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7473; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=kZjF0sSqx+5FmDXvAoC983U2XPglvCp39phKC5ZNRKw=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtYr6pgwH386y7r2izp76anUk7Y1N4xXenptW7fu2
 /eounbjnyIdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJqK3g5Fh/6TiOKHM8vdx
 bgxm0RZ88ZGpDTG/zq18uNnUWMCwfp8DI8Pbud1njx9xPx5jkt/r/ez2Sl69H7cPnDXJexVx9Va
 b2EYGAMDXRzw=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add wrappers for new file_getattr/file_setattr inode syscalls which will
be used by xfs_quota and xfs_io.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 configure.ac          |   1 +
 include/builddefs.in  |   5 +++
 include/linux.h       |  20 +++++++++
 libfrog/Makefile      |   2 +
 libfrog/file_attr.c   | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++
 libfrog/file_attr.h   |  35 +++++++++++++++
 m4/package_libcdev.m4 |  19 ++++++++
 7 files changed, 204 insertions(+)

diff --git a/configure.ac b/configure.ac
index 195ee6dddf61..a3206d53e7e0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -156,6 +156,7 @@ AC_PACKAGE_NEED_RCU_INIT
 AC_HAVE_PWRITEV2
 AC_HAVE_COPY_FILE_RANGE
 AC_HAVE_CACHESTAT
+AC_HAVE_FILE_ATTR
 AC_NEED_INTERNAL_FSXATTR
 AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
 AC_NEED_INTERNAL_FSCRYPT_POLICY_V2
diff --git a/include/builddefs.in b/include/builddefs.in
index 04b4e0880a84..d727b55b854f 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -97,6 +97,7 @@ HAVE_ZIPPED_MANPAGES = @have_zipped_manpages@
 HAVE_PWRITEV2 = @have_pwritev2@
 HAVE_COPY_FILE_RANGE = @have_copy_file_range@
 HAVE_CACHESTAT = @have_cachestat@
+HAVE_FILE_ATTR = @have_file_attr@
 NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
 NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
 NEED_INTERNAL_FSCRYPT_POLICY_V2 = @need_internal_fscrypt_policy_v2@
@@ -169,6 +170,10 @@ ifeq ($(ENABLE_GETTEXT),yes)
 GCFLAGS += -DENABLE_GETTEXT
 endif
 
+ifeq ($(HAVE_FILE_ATTR),yes)
+LCFLAGS += -DHAVE_FILE_ATTR
+endif
+
 # Override these if C++ needs other options
 SANITIZER_CXXFLAGS = $(SANITIZER_CFLAGS)
 GCXXFLAGS = $(GCFLAGS)
diff --git a/include/linux.h b/include/linux.h
index 6e83e073aa2e..993789f01b3a 100644
--- a/include/linux.h
+++ b/include/linux.h
@@ -16,6 +16,7 @@
 #include <sys/param.h>
 #include <sys/sysmacros.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 #include <inttypes.h>
 #include <malloc.h>
 #include <getopt.h>
@@ -202,6 +203,25 @@ struct fsxattr {
 };
 #endif
 
+/*
+ * Use FILE_ATTR_SIZE_VER0 (linux/fs.h) instead of build system HAVE_FILE_ATTR
+ * as this header could be included in other places where HAVE_FILE_ATTR is not
+ * defined (e.g. xfstests's conftest.c in ./configure)
+ */
+#ifndef FILE_ATTR_SIZE_VER0
+/*
+ * We need to define file_attr if it's missing to know how to convert it to
+ * fsxattr
+ */
+struct file_attr {
+	__u32		fa_xflags;
+	__u32		fa_extsize;
+	__u32		fa_nextents;
+	__u32		fa_projid;
+	__u32		fa_cowextsize;
+};
+#endif
+
 #ifndef FS_IOC_FSGETXATTR
 /*
  * Flags for the fsx_xflags field
diff --git a/libfrog/Makefile b/libfrog/Makefile
index 560bad417ee4..268fa26638d7 100644
--- a/libfrog/Makefile
+++ b/libfrog/Makefile
@@ -24,6 +24,7 @@ fsproperties.c \
 fsprops.c \
 getparents.c \
 histogram.c \
+file_attr.c \
 list_sort.c \
 linux.c \
 logging.c \
@@ -55,6 +56,7 @@ fsprops.h \
 getparents.h \
 handle_priv.h \
 histogram.h \
+file_attr.h \
 logging.h \
 paths.h \
 projects.h \
diff --git a/libfrog/file_attr.c b/libfrog/file_attr.c
new file mode 100644
index 000000000000..1d42895477ae
--- /dev/null
+++ b/libfrog/file_attr.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Red Hat, Inc.
+ * All Rights Reserved.
+ */
+
+#include "file_attr.h"
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <asm/types.h>
+#include <fcntl.h>
+
+static void
+file_attr_to_fsxattr(
+	const struct file_attr	*fa,
+	struct fsxattr		*fsxa)
+{
+     memset(fsxa, 0, sizeof(struct fsxattr));
+
+     fsxa->fsx_xflags = fa->fa_xflags;
+     fsxa->fsx_extsize = fa->fa_extsize;
+     fsxa->fsx_nextents = fa->fa_nextents;
+     fsxa->fsx_projid = fa->fa_projid;
+     fsxa->fsx_cowextsize = fa->fa_cowextsize;
+
+}
+
+static void
+fsxattr_to_file_attr(
+	const struct fsxattr	*fsxa,
+	struct file_attr	*fa)
+{
+     memset(fa, 0, sizeof(struct file_attr));
+
+     fa->fa_xflags = fsxa->fsx_xflags;
+     fa->fa_extsize = fsxa->fsx_extsize;
+     fa->fa_nextents = fsxa->fsx_nextents;
+     fa->fa_projid = fsxa->fsx_projid;
+     fa->fa_cowextsize = fsxa->fsx_cowextsize;
+}
+
+int
+xfrog_file_getattr(
+	const int		dfd,
+	const char		*path,
+	const struct stat	*stat,
+	struct file_attr	*fa,
+	const unsigned int	at_flags)
+{
+	int			error;
+	int			fd;
+	struct fsxattr		fsxa;
+
+#ifdef HAVE_FILE_ATTR
+        error = syscall(__NR_file_getattr, dfd, path, fa,
+                        sizeof(struct file_attr), at_flags);
+	if (error && errno != ENOSYS)
+		return error;
+
+	if (!error)
+		return error;
+#endif
+
+	if (SPECIAL_FILE(stat->st_mode)) {
+		errno = EOPNOTSUPP;
+		return -1;
+	}
+
+	fd = open(path, O_RDONLY|O_NOCTTY);
+	if (fd == -1)
+		return fd;
+
+	error = ioctl(fd, FS_IOC_FSGETXATTR, &fsxa);
+	close(fd);
+	if (error)
+		return error;
+
+	fsxattr_to_file_attr(&fsxa, fa);
+
+	return error;
+}
+
+int
+xfrog_file_setattr(
+	const int		dfd,
+	const char		*path,
+	const struct stat	*stat,
+	struct file_attr	*fa,
+	const unsigned int	at_flags)
+{
+	int			error;
+	int			fd;
+	struct fsxattr		fsxa;
+
+#ifdef HAVE_FILE_ATTR
+	error = syscall(__NR_file_setattr, dfd, path, fa,
+			sizeof(struct file_attr), at_flags);
+	if (error && errno != ENOSYS)
+		return error;
+
+	if (!error)
+		return error;
+#endif
+
+	if (SPECIAL_FILE(stat->st_mode)) {
+		errno = EOPNOTSUPP;
+		return -1;
+	}
+
+	fd = open(path, O_RDONLY|O_NOCTTY);
+	if (fd == -1)
+		return fd;
+
+	file_attr_to_fsxattr(fa, &fsxa);
+
+	error = ioctl(fd, FS_IOC_FSSETXATTR, fa);
+	close(fd);
+
+	return error;
+}
diff --git a/libfrog/file_attr.h b/libfrog/file_attr.h
new file mode 100644
index 000000000000..ad33241bbffa
--- /dev/null
+++ b/libfrog/file_attr.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Red Hat, Inc.
+ * All Rights Reserved.
+ */
+#ifndef __LIBFROG_FILE_ATTR_H__
+#define __LIBFROG_FILE_ATTR_H__
+
+#include "linux.h"
+#include <sys/stat.h>
+
+#define SPECIAL_FILE(x) \
+	   (S_ISCHR((x)) \
+	|| S_ISBLK((x)) \
+	|| S_ISFIFO((x)) \
+	|| S_ISLNK((x)) \
+	|| S_ISSOCK((x)))
+
+int
+xfrog_file_getattr(
+	const int		dfd,
+	const char		*path,
+	const struct stat	*stat,
+	struct file_attr	*fa,
+	const unsigned int	at_flags);
+
+int
+xfrog_file_setattr(
+	const int		dfd,
+	const char		*path,
+	const struct stat	*stat,
+	struct file_attr	*fa,
+	const unsigned int	at_flags);
+
+#endif /* __LIBFROG_FILE_ATTR_H__ */
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index b77ac1a7580a..6a267dab7ab7 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -274,3 +274,22 @@ AC_DEFUN([AC_PACKAGE_CHECK_LTO],
     AC_SUBST(lto_cflags)
     AC_SUBST(lto_ldflags)
   ])
+
+#
+# Check if we have a file_getattr/file_setattr system call (Linux)
+#
+AC_DEFUN([AC_HAVE_FILE_ATTR],
+  [ AC_MSG_CHECKING([for file_getattr/file_setattr syscalls])
+    AC_LINK_IFELSE(
+    [	AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#include <sys/syscall.h>
+#include <unistd.h>
+	]], [[
+syscall(__NR_file_getattr, 0, 0, 0, 0, 0);
+	]])
+    ], have_file_attr=yes
+       AC_MSG_RESULT(yes),
+       AC_MSG_RESULT(no))
+    AC_SUBST(have_file_attr)
+  ])

-- 
2.49.0


