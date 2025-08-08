Return-Path: <linux-fsdevel+bounces-57125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3173B1EEDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23A31733B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1452882AC;
	Fri,  8 Aug 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFy67Hv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326F192D8A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681427; cv=none; b=o28kObjbw/iU31MSBC0bNHAWFkMRYIGyKPewVIHgMLWA8eeUr//ho5yTwdFjao1wsiTrOrsbkgDUizZrj6JVNdIDQWLR29F2kHRIaq6R+VCY9lY+RObC2tPKsZvnnUs92/ydPlNcpOsS/J9mzH5nflrBmv0Pf7hZILH2JAgRnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681427; c=relaxed/simple;
	bh=eKtnu0iazeEyE9NW3BoOBmMxkE/CTOGKQLJMUyrooXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Wdg6fwdzvx67cM+cz+bbkZNODHSxAyfMEPOCf/N7DHpbkTLPBQiUbR96g2m7dN3WkIZWieDkoMejAmbB8XRgvuWZ666qc/Q+imTT1+EfrQYuQ81IDazUkd6iUwSICJyZv216BdeoOrT+vTijpSAovBAKPJnX3QA8CSoakktdLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFy67Hv7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kM+rg67yvBJDtWjV29sE+ws+WZJB3BtzfXWianxfU84=;
	b=XFy67Hv7GmGWTfkhT9wdv5y1+GShLNHy/yrZ09GYsWfIyex5XmSIAkY5R9t6mrnIPPru68
	7bTSj2M5Z5zkBOVDqFE4jjD/OqC2Uptq6zN22X77dnOCzGQN9tV6hzTACNV1jOrzFjrmeb
	BJLNP8CPfiZxqLU2lQ1LXQjrHIZ2b6g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-l0HjrTsJP4aYebjSBeQAlA-1; Fri, 08 Aug 2025 15:30:22 -0400
X-MC-Unique: l0HjrTsJP4aYebjSBeQAlA-1
X-Mimecast-MFC-AGG-ID: l0HjrTsJP4aYebjSBeQAlA_1754681422
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7807a33faso1023012f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681421; x=1755286221;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM+rg67yvBJDtWjV29sE+ws+WZJB3BtzfXWianxfU84=;
        b=HPvWp8D1nY1IXKnC9OBRk1pCsi3DmCzT7STv8H6ym/eB0BWoJz4qFo+zW5nQCRMNbw
         musgA5zRkvAJ+TIFCgxeUBot9U6qYIUstNL/SPElaBLgMLCugSdoz/af2x+/FkVAWLQ0
         We4qVH52hy7R022xwjIXWTmJlr80Nb+Zx9Mv5gjX3ed4YAIURJOiY++TgVBa4M/jyGqz
         AkoZ7fZJnDAYsLJ4wsWgVIgUXDnWqa09JuGnyo1I/t3A10WC1+lIGP/7oO0vmX3X02WK
         QtuUgdedkbycViE9DfPXlMo0vjDdw70bX06gyi4hlo/E95i2tIxbCY73gaFsmB7n5AlO
         Q5tw==
X-Forwarded-Encrypted: i=1; AJvYcCWTo21ViDrgqk/vsgGPXvqnitZmv9zfslBmcHER2E1QM+/vBbC4drY0bW7qSaz7HxIUUZs4iWUfmBnTCjsb@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBdMG9s+yedioWXt42/vPx567Exoy3NuNzpF2Y6jCRNlls/7X
	IAuTllnCG29wies3AL+CAzXvpp+UzhRM14CaXJtSX4AGGpch7y2wq6gxwmF4TymV5XgcVpkUDC9
	kH3z+SX4gu1cYEYZxUthrX7sR/3RJ4AwcTNNvf9KX0ZUkwAoXk0IFSieZwncQIamUd5+d0QRVpQ
	==
X-Gm-Gg: ASbGncs0X6mvnlnZv5O5snl6OCNk2qZlHnC34gDfjRW/+2U94FZ+JLaZMTLMk5Y2X3Z
	rTT3I0phaJfVznyS+i7U18e9Intefweu7MsMkl94/qIEVNupfzlHFqPoY+v9mp2bCNIcwdHUI0x
	CqzA4Au4Zqjx3MkIKs7S7177SBExFuS8BzMCVpGxPcZVKGFHYDiJMobQXk+P2K5NSaSMkLpbF+C
	djG1I57HieAZftNE7p4s3gqZ7XrWXh7WdjR2fmO/0jc7fHNO4C1taAJHtwHzXNKJrJBV3oRwTv3
	UY8yqVZUbM7UugB/Sz0Dc3tupCN9NSwNHboBZARGoFk5pg==
X-Received: by 2002:a05:6000:4025:b0:3b7:98bc:b856 with SMTP id ffacd0b85a97d-3b900b50524mr3517468f8f.41.1754681421031;
        Fri, 08 Aug 2025 12:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv/UwKaR7OXHFUKv1nF2eh6uaI6nmSfD7l33u4gEKFNCmpP64hML9y9mmBdlqts17VzVqCPA==
X-Received: by 2002:a05:6000:4025:b0:3b7:98bc:b856 with SMTP id ffacd0b85a97d-3b900b50524mr3517452f8f.41.1754681420548;
        Fri, 08 Aug 2025 12:30:20 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm8925162f8f.69.2025.08.08.12.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:30:20 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 08 Aug 2025 21:30:16 +0200
Subject: [PATCH 1/4] libfrog: add wrappers for file_getattr/file_setattr
 syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-xattrat-syscall-v1-1-48567c29e45c@kernel.org>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
In-Reply-To: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7140; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=eKtnu0iazeEyE9NW3BoOBmMxkE/CTOGKQLJMUyrooXY=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYFeO/19FPYsXs/L+9Pj23PtnjdcjaZFf/3Rmv0r
 mtrt/qp+hh1lLIwiHExyIopsqyT1pqaVCSVf8SgRh5mDisTyBAGLk4BmAiPFyPDA7XsnXsu+5n3
 nDm+UrjEfqbkg4Ned53YVjJMlkk9Pz90ASPDQdePzka63P+rF6oKS7spb15xc0mfw+7PHgK/535
 vWm7DCgAONUYm
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add wrappers for new file_getattr/file_setattr inode syscalls which will
be used by xfs_quota and xfs_io.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 configure.ac          |   1 +
 include/builddefs.in  |   5 +++
 include/linux.h       |  20 ++++++++++
 libfrog/Makefile      |   2 +
 libfrog/file_attr.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++
 libfrog/file_attr.h   |  35 +++++++++++++++++
 m4/package_libcdev.m4 |  19 +++++++++
 7 files changed, 187 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9a3309bcdfd1..40a44c571e7b 100644
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
index 6e83e073aa2e..018cc78960e3 100644
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
+ * Use __NR_file_getattr instead of build system HAVE_FILE_ATTR as this header
+ * could be included in other places where HAVE_FILE_ATTR is not defined (e.g.
+ * xfstests's conftest.c in ./configure)
+ */
+#ifndef __NR_file_getattr
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
index b64ca4597f4e..7d49fd0fe6cc 100644
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
index 000000000000..8592d775f554
--- /dev/null
+++ b/libfrog/file_attr.c
@@ -0,0 +1,105 @@
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
+file_getattr(
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
+	return syscall(__NR_file_getattr, dfd, path, fa,
+			sizeof(struct file_attr), at_flags);
+#else
+	if (SPECIAL_FILE(stat->st_mode))
+		return 0;
+#endif
+
+	fd = open(path, O_RDONLY|O_NOCTTY);
+	if (fd == -1)
+		return errno;
+
+	error = ioctl(fd, FS_IOC_FSGETXATTR, &fsxa);
+	close(fd);
+
+	fsxattr_to_file_attr(&fsxa, fa);
+
+	return error;
+}
+
+int
+file_setattr(
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
+	return syscall(__NR_file_setattr, dfd, path, fa,
+			sizeof(struct file_attr), at_flags);
+#else
+	if (SPECIAL_FILE(stat->st_mode))
+		return 0;
+#endif
+
+	fd = open(path, O_RDONLY|O_NOCTTY);
+	if (fd == -1)
+		return errno;
+
+	file_attr_to_fsxattr(fa, &fsxa);
+	error = ioctl(fd, FS_IOC_FSSETXATTR, fa);
+	close(fd);
+
+	return error;
+}
diff --git a/libfrog/file_attr.h b/libfrog/file_attr.h
new file mode 100644
index 000000000000..3e56e80a6f95
--- /dev/null
+++ b/libfrog/file_attr.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Red Hat, Inc.
+ * All Rights Reserved.
+ */
+#ifndef __LIBFROG_IXATTR_H__
+#define __LIBFROG_IXATTR_H__
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
+file_getattr(
+	const int		dfd,
+	const char		*path,
+	const struct stat	*stat,
+	struct file_attr	*fa,
+	const unsigned int	at_flags);
+
+int
+file_setattr(
+	const int		dfd,
+	const char		*path,
+	const struct stat	*stat,
+	struct file_attr	*fa,
+	const unsigned int	at_flags);
+
+#endif /* __LIBFROG_IXATTR_H__ */
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index 61353d0aa9d5..cb8ff1576d01 100644
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


