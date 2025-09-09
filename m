Return-Path: <linux-fsdevel+bounces-60685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C75B50100
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016F37B07A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2EB352FD0;
	Tue,  9 Sep 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShPgalVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1C2BB17
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431490; cv=none; b=JTww9j3ImfCkPRCz+MVCDnnbuYT6b0bpIbVyFzS3a5cIfgw2J6RfcYXGytlex2nEwX9z+jXS/mNHKeIdXV7M2dg3/c4w+66FwcOGZ2KBDMP2zJTldn5UUxR7zUXn/kw7pCqFmTt/2+KoH/IHDLEN8gioUn3n8NB6ygN9GbsTHrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431490; c=relaxed/simple;
	bh=UYvWnN1XqUZ+zERBsQzWg+UXv5RLTMQ4dK1NL2LWvs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=OvUqo+gaR9wwVWue9CR7ZoVNmsP8AisNzKOAUfJQBcG7cZU1VgZpxWPUC2wtJ6JQzM7yi+CHEQUCWiT2pYBPSMVYFSy2wYJ/41U22njpc/c5Ly28jLsQlVJJ4bG/FL6mr+PM2t04DLhz4kRPoSnbv4Kn1FLK8ztKRFV53MTovN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShPgalVy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZmpQpX6deUvZ+x3RMDS571a5+S8+u+b6eXTKAxOtFA=;
	b=ShPgalVyrT23P2HnkWCVVD7BFl9UbRFwtDhjkjKfZGmuUinrwfvRUQI6jScAsgqcTLfQKa
	08T93NUmKFJ3xOZsNQgzcwdnVHcfFENKusiGk1d7JHMBDZuV2SV7LVSP/PyM2960q3ZdoE
	6w4iw0LYDCVZV832Ai0LYBiLDzQ9sOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-7hLZ2G-LOeSvrtWlMVM1uw-1; Tue, 09 Sep 2025 11:24:45 -0400
X-MC-Unique: 7hLZ2G-LOeSvrtWlMVM1uw-1
X-Mimecast-MFC-AGG-ID: 7hLZ2G-LOeSvrtWlMVM1uw_1757431485
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb604427fso31638685e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 08:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431484; x=1758036284;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZmpQpX6deUvZ+x3RMDS571a5+S8+u+b6eXTKAxOtFA=;
        b=B47dTqynWRqu2Nphezh+pbB7pZnP9VwDH/BUhQi6B78RDbT0Lmpimf7MEHYvQo8v48
         mdyiRvA1mbAItbzrIAtuciXsvS1DlM1ikC6By4hHEf85OusX/uUABOtNtsGCjHGLZzEs
         RA5RkzuLMcYwtFM7seQQz0FIaBWi1diu75dEcRwcIx4qrIwCfNPVCE5x7CTrFYfXuVL7
         hbYARYMxYGinWBTZb+FXWmdLiRuj/92iLp8/9z7uBqtQKSj1B6PajhDd6CRIXEqAln8o
         9SsN3mHgbeNwZZ9+ZgVx73JfrelnnO9HSfsLWMNDosOVn2aC2Uo/mv5CpSZ+tbS+42xq
         d9mA==
X-Forwarded-Encrypted: i=1; AJvYcCUdfdSUnt4pDiKBI9/LCVfUeh+umgA9ODrg3SkSWnRgwee3XICOmOUzcnm6fJuDT/yg7vM+pgAS/PXFKDxA@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZ9XJA33aEG02ydzR+ZC70Dt3f7BFruxhG70lIrHvtkbmo8i3
	kYyvvKvcFOFc+hBP+01puDqf00jUDeE/LoVzzShMBcrbNta6y7jabce0Nz89WKSHUB6kJVXfJ0P
	DXBzaA8t0pbrS8MjiqRIctU3+kRmbOMaBhCxok/2g8XtfZleCUfo3wsIDTcAImYYb/Q==
X-Gm-Gg: ASbGncvqrFOXMl1WpJ+XT+X7MI8VcU057b0qyJxICVquBstRSI5VEYQFFIq6Kw0xmEc
	QK6U0BQ1SYffuBawjyg3q4vHWNcdvODyGBSeoceI2PxZNGJdJ2dQ71r71drBkPPpSaDfbBDc3yz
	GRf1e3+PwYR6N/F/lQTGf8Qpye3ccSkGaV/HpHedzBai6/VYVYXdk8xnhU24vkujze8k1yb9HhR
	isseNWBag0qo0aATZ9IkOCExxZiZWvSaOzfLGIlNOa3EoPo9TxGBMKoB1y/n762KDZggwo10E93
	Cro+L2DlWiWykWoWhrNa9n9bELJy/FeVVGEW1HQ=
X-Received: by 2002:a05:600c:19c8:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-45ddde866c8mr116414455e9.5.1757431484336;
        Tue, 09 Sep 2025 08:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSfjFSN/TbL5I2VNTcqu4pE3Qp4KpnkvMit4ZMKacniUANv8m19ZZHVaWYedED6W94Ia1sTA==
X-Received: by 2002:a05:600c:19c8:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-45ddde866c8mr116414185e9.5.1757431483789;
        Tue, 09 Sep 2025 08:24:43 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df17d9774sm11432015e9.9.2025.09.09.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:24:43 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 09 Sep 2025 17:24:36 +0200
Subject: [PATCH v3 v3 1/4] libfrog: add wrappers for
 file_getattr/file_setattr syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-xattrat-syscall-v3-1-4407a714817e@kernel.org>
References: <20250909-xattrat-syscall-v3-0-4407a714817e@kernel.org>
In-Reply-To: <20250909-xattrat-syscall-v3-0-4407a714817e@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7435; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=UYvWnN1XqUZ+zERBsQzWg+UXv5RLTMQ4dK1NL2LWvs0=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMg647erIefGxvVx0DmuazEGuD8fVH/dEL+Dgy/bU7
 MwzNJkRvb6jlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARLwDGf4ZHZh3ZGLHu/nS
 2pU/U1YnHnQWW/rY/enWQnk12wkmx5nUGBmeskko8Dxbd6j75evQ6gUJ22aevFnG+njp/B1pqTs
 fa0UzAQDK+Ud7
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
 libfrog/file_attr.c   | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++
 libfrog/file_attr.h   |  35 +++++++++++++++
 m4/package_libcdev.m4 |  19 ++++++++
 7 files changed, 203 insertions(+)

diff --git a/configure.ac b/configure.ac
index 195ee6dddf61..0ba371c33147 100644
--- a/configure.ac
+++ b/configure.ac
@@ -156,6 +156,7 @@ AC_PACKAGE_NEED_RCU_INIT
 AC_HAVE_PWRITEV2
 AC_HAVE_COPY_FILE_RANGE
 AC_HAVE_CACHESTAT
+AC_HAVE_FILE_GETATTR
 AC_NEED_INTERNAL_FSXATTR
 AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
 AC_NEED_INTERNAL_FSCRYPT_POLICY_V2
diff --git a/include/builddefs.in b/include/builddefs.in
index 04b4e0880a84..b5aa1640711b 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -97,6 +97,7 @@ HAVE_ZIPPED_MANPAGES = @have_zipped_manpages@
 HAVE_PWRITEV2 = @have_pwritev2@
 HAVE_COPY_FILE_RANGE = @have_copy_file_range@
 HAVE_CACHESTAT = @have_cachestat@
+HAVE_FILE_GETATTR = @have_file_getattr@
 NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
 NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
 NEED_INTERNAL_FSCRYPT_POLICY_V2 = @need_internal_fscrypt_policy_v2@
@@ -169,6 +170,10 @@ ifeq ($(ENABLE_GETTEXT),yes)
 GCFLAGS += -DENABLE_GETTEXT
 endif
 
+ifeq ($(HAVE_FILE_GETATTR),yes)
+LCFLAGS += -DHAVE_FILE_GETATTR
+endif
+
 # Override these if C++ needs other options
 SANITIZER_CXXFLAGS = $(SANITIZER_CFLAGS)
 GCXXFLAGS = $(GCFLAGS)
diff --git a/include/linux.h b/include/linux.h
index 6e83e073aa2e..cea468d2b9d8 100644
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
+ * Use FILE_ATTR_SIZE_VER0 (linux/fs.h) instead of build system
+ * HAVE_FILE_GETATTR as this header could be included in other places where
+ * HAVE_FILE_GETATTR is not defined (e.g. xfstests's conftest.c in ./configure)
+ */
+#ifndef FILE_ATTR_SIZE_VER0
+/*
+ * We need to define file_attr if it's missing to know how to convert it to
+ * fsxattr
+ */
+struct file_attr {
+	__u32	fa_xflags;
+	__u32	fa_extsize;
+	__u32	fa_nextents;
+	__u32	fa_projid;
+	__u32	fa_cowextsize;
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
index 000000000000..bb51ac6eb2ef
--- /dev/null
+++ b/libfrog/file_attr.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Red Hat, Inc.
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
+	memset(fsxa, 0, sizeof(struct fsxattr));
+
+	fsxa->fsx_xflags = fa->fa_xflags;
+	fsxa->fsx_extsize = fa->fa_extsize;
+	fsxa->fsx_nextents = fa->fa_nextents;
+	fsxa->fsx_projid = fa->fa_projid;
+	fsxa->fsx_cowextsize = fa->fa_cowextsize;
+}
+
+static void
+fsxattr_to_file_attr(
+	const struct fsxattr	*fsxa,
+	struct file_attr	*fa)
+{
+	memset(fa, 0, sizeof(struct file_attr));
+
+	fa->fa_xflags = fsxa->fsx_xflags;
+	fa->fa_extsize = fsxa->fsx_extsize;
+	fa->fa_nextents = fsxa->fsx_nextents;
+	fa->fa_projid = fsxa->fsx_projid;
+	fa->fa_cowextsize = fsxa->fsx_cowextsize;
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
+#ifdef HAVE_FILE_GETATTR
+	error = syscall(__NR_file_getattr, dfd, path, fa,
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
+#ifdef HAVE_FILE_GETATTR /* file_get/setattr goes together */
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
index 000000000000..df9b6181d52c
--- /dev/null
+++ b/libfrog/file_attr.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Red Hat, Inc.
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
index b77ac1a7580a..28998e48ccdf 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -274,3 +274,22 @@ AC_DEFUN([AC_PACKAGE_CHECK_LTO],
     AC_SUBST(lto_cflags)
     AC_SUBST(lto_ldflags)
   ])
+
+#
+# Check if we have a file_getattr system call (Linux)
+#
+AC_DEFUN([AC_HAVE_FILE_GETATTR],
+  [AC_MSG_CHECKING([for file_getattr syscall])
+    AC_LINK_IFELSE(
+    [AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#include <sys/syscall.h>
+#include <unistd.h>
+  ]], [[
+syscall(__NR_file_getattr, 0, 0, 0, 0, 0);
+  ]])
+    ], have_file_getattr=yes
+       AC_MSG_RESULT(yes),
+       AC_MSG_RESULT(no))
+    AC_SUBST(have_file_getattr)
+  ])

-- 
2.50.1


