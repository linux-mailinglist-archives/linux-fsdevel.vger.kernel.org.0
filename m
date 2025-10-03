Return-Path: <linux-fsdevel+bounces-63350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA19BB661C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 11:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB38C19E68FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48344287268;
	Fri,  3 Oct 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEbhdqwh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BE2989B4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484121; cv=none; b=lPRz7ecbv12XnctyHD4fTidF2MD2I61zVYadb7aNgEviq4jwXmkRDSTJDdvdyJI8c1mTGc4CvQU0EI4v2yK57Hy0XPRtQKR1D/f/Z5i41wTZadgKyShIkvGGCCp6eEx/P+L9mGXjPSX5Mt3bQJj5XgT9MgTYboSV7vScDbXq3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484121; c=relaxed/simple;
	bh=1g0F8G0ZJ3aQR1QOcer4WbbNZ4zedOeqU7qRg83YmYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YsJuAr9mWh/Ms6781bDBAtDKhVcJdpLIxks71Y6GRnC41flUaItyzf8nd+FwkAdj3HP40Q/dVxdA3j51fi3GxUtaJO0F6+2ZQpuP+22kA7MILHugMKok7kAszuAJF6oVOaUCBelYG8krF7nSaUPySZtX1e8zlAW9bvw4tHiCkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEbhdqwh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759484118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOc2kyXwkfyHFjkUB0VqkLUggJ+gZJQWX3oPeW8H3Q4=;
	b=YEbhdqwhQaWqxNn+NKnbGZKK8YDadKuiBdemOJvB7rJFoztPAWZ7zKrJRXNuQHO36N7IZw
	fjyYjcY0BhCDgfE9kp+zFB1IZgJVWg4Z17/zMNiaKqBnDc2D1bJ3Vo1y79jD2MdXJn1d/l
	dvp/yz8IvOPJu565SH2qfW/0175quPw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-X784rouFN8q4uU-mwFQsjw-1; Fri, 03 Oct 2025 05:35:17 -0400
X-MC-Unique: X784rouFN8q4uU-mwFQsjw-1
X-Mimecast-MFC-AGG-ID: X784rouFN8q4uU-mwFQsjw_1759484116
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee10a24246so1182119f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 02:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484116; x=1760088916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOc2kyXwkfyHFjkUB0VqkLUggJ+gZJQWX3oPeW8H3Q4=;
        b=BMzMb/AARNqB0Rxgp/IzXzpX4cUIo+x43mMa9hVl11UCAXJr2UXcQYLrsL/Td8Zhk1
         jAeQtzwuw+Tw6p7Hdd+NlRo+Gsd9hrkIvtfGMStaZu/n3dKHUIk4wbN7zbhuBaPPYOke
         ZM3kDk43obh2HcB9YysWzUlUERS17T/I6tcmALacXISGJCYuYLIwel6n/4aAWy4jGrAE
         iEupkeDqiskvEt2+K5RHEOhOnKZmBIqywSP13Fw4rDNe19SHaRmXp+7q60EUztMEE1un
         fnA4U2t3jDgxD93uU3jZDxgBCp/HKtvzvjM8ZHBH+2wPUJQja5y5BZxxmgu8GYLKhXVx
         SkyA==
X-Forwarded-Encrypted: i=1; AJvYcCWQKWnVsUNg0mvZt69Kjn8t+IpeibrOx3xpGoRxZrFiyAT4s02fT3g6zjgyYElwxEejQ2Qs5WY5cLOginrj@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwP3Ftntl504j30SSNzKlb0u21ucI6AdP+q1Me40VQ9d8jiw1
	03UGJpFU9Pp0alPbu1qT/9R51svD1K4NtOP3jngn/vz5uurvVZWRCPXV/BUIHVwsY0Zelqzb2Wn
	L1UsuUyyqaVCPSkG6NVWO3T/8b7fbyKYfRRSi8WJa7+GE3V4rVo0lgj+nkx0SEBicsg==
X-Gm-Gg: ASbGncs5xfz9t/NyCLWWD5CYZ8IybFrBRo4us0FSZpn1O5I8beEiBeGP/yoFYL4JVLE
	ZVh5h/xXsRjEWepSunVSp+dtAmwyNucl43OsuhVi/74iBMp6dKMOFObQ3M2Ledw9DqjDhJxa3WF
	adwSQBZE59TH65cyrmtsRAIryGEFCKwwg1cHZTqhiiZTaDKtRi7cKq058yPFqO7I/VmKvKXWvRj
	Bo0tN68PWhrHP8mTBSsumh2v5b+Upb42mQaeTNbZnKhfftd+YtFNQL4KEqHeFxYrBEbYvjNp/U+
	HuF+CqJkaMHVOve7WhUFnLiCL1deLqTfTAT9ksdlofR9MusV2pKdFKrk4QUNippaWb2RFZk1
X-Received: by 2002:a05:6000:186f:b0:405:3028:1be4 with SMTP id ffacd0b85a97d-42567137c45mr1224018f8f.8.1759484115928;
        Fri, 03 Oct 2025 02:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMaTE01e/q99DbFJ42R9UEeit7urvP487lT806X0Mcy4v5aEZn0ijayMhPp/VypTI+LTBUfw==
X-Received: by 2002:a05:6000:186f:b0:405:3028:1be4 with SMTP id ffacd0b85a97d-42567137c45mr1223986f8f.8.1759484115222;
        Fri, 03 Oct 2025 02:35:15 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm121695005e9.10.2025.10.03.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:35:14 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 03 Oct 2025 11:32:44 +0200
Subject: [PATCH v4 1/3] file_attr: introduce program to set/get fsxattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
In-Reply-To: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9766; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=1g0F8G0ZJ3aQR1QOcer4WbbNZ4zedOeqU7qRg83YmYs=;
 b=kA0DAAoWRqfqGKwz4QgByyZiAGjfmNGglTwF+pprIDFjZ/x9jv8H27qD9FBGuIXM2CF9sZato
 oh1BAAWCgAdFiEErhsqlWJyGm/EMHwfRqfqGKwz4QgFAmjfmNEACgkQRqfqGKwz4QidogEA7jAu
 TrCyZMJvjbJs23OW7VgHMOGl9ie2ozc4bvNSVrwA/0bVSFoVR2hD4h35Q2X62tITm4dwLvxQcFw
 1fGZavyoK
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

This programs uses newly introduced file_getattr and file_setattr
syscalls. This program is partially a test of invalid options. This will
be used further in the test.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 .gitignore            |   1 +
 configure.ac          |   1 +
 include/builddefs.in  |   1 +
 m4/package_libcdev.m4 |  16 +++
 src/Makefile          |   5 +
 src/file_attr.c       | 274 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 298 insertions(+)

diff --git a/.gitignore b/.gitignore
index 6948fd602f95..82c57f415301 100644
--- a/.gitignore
+++ b/.gitignore
@@ -211,6 +211,7 @@ tags
 /src/min_dio_alignment
 /src/dio-writeback-race
 /src/unlink-fsync
+/src/file_attr
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/configure.ac b/configure.ac
index f3c8c643f0eb..f7519fa97654 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,6 +73,7 @@ AC_HAVE_RLIMIT_NOFILE
 AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
 AC_HAVE_FICLONE
 AC_HAVE_TRIVIAL_AUTO_VAR_INIT
+AC_HAVE_FILE_GETATTR
 
 AC_CHECK_FUNCS([renameat2])
 AC_CHECK_FUNCS([reallocarray])
diff --git a/include/builddefs.in b/include/builddefs.in
index 96d5ed25b3e2..708d75b24d76 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -74,6 +74,7 @@ HAVE_BMV_OF_SHARED = @have_bmv_of_shared@
 HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
 NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
 HAVE_FICLONE = @have_ficlone@
+HAVE_FILE_GETATTR = @have_file_getattr@
 
 GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
 SANITIZER_CFLAGS += @autovar_init_cflags@
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index ed8fe6e32ae0..17f57f427410 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -86,3 +86,19 @@ AC_DEFUN([AC_HAVE_TRIVIAL_AUTO_VAR_INIT],
     CFLAGS="${OLD_CFLAGS}"
     AC_SUBST(autovar_init_cflags)
   ])
+
+#
+# Check if we have a file_getattr system call (Linux)
+#
+AC_DEFUN([AC_HAVE_FILE_GETATTR],
+  [ AC_MSG_CHECKING([for file_getattr syscall])
+    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#include <sys/syscall.h>
+#include <unistd.h>
+    ]], [[
+         syscall(__NR_file_getattr, 0, 0, 0, 0, 0, 0);
+    ]])],[have_file_getattr=yes
+       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
+    AC_SUBST(have_file_getattr)
+  ])
diff --git a/src/Makefile b/src/Makefile
index 7080e34896c3..711dbb917b3a 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -62,6 +62,11 @@ ifeq ($(HAVE_FALLOCATE), true)
 LCFLAGS += -DHAVE_FALLOCATE
 endif
 
+ifeq ($(HAVE_FILE_GETATTR), yes)
+LINUX_TARGETS += file_attr
+LCFLAGS += -DHAVE_FILE_GETATTR
+endif
+
 ifeq ($(PKG_PLATFORM),linux)
 TARGETS += $(LINUX_TARGETS)
 endif
diff --git a/src/file_attr.c b/src/file_attr.c
new file mode 100644
index 000000000000..29bb6c903403
--- /dev/null
+++ b/src/file_attr.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
+ */
+
+#include "global.h"
+#include <sys/syscall.h>
+#include <getopt.h>
+#include <errno.h>
+#include <linux/fs.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#ifndef HAVE_FILE_GETATTR
+#define __NR_file_getattr 468
+#define __NR_file_setattr 469
+
+struct file_attr {
+	__u32	fa_xflags;	/* xflags field value (get/set) */
+	__u32	fa_extsize;	/* extsize field value (get/set)*/
+	__u32	fa_nextents;	/* nextents field value (get)   */
+	__u32	fa_projid;	/* project identifier (get/set) */
+	__u32	fa_cowextsize;	/* CoW extsize field value (get/set) */
+};
+
+#endif
+
+#define SPECIAL_FILE(x) \
+	   (S_ISCHR((x)) \
+	|| S_ISBLK((x)) \
+	|| S_ISFIFO((x)) \
+	|| S_ISLNK((x)) \
+	|| S_ISSOCK((x)))
+
+static struct option long_options[] = {
+	{"set",			no_argument,	0,	's' },
+	{"get",			no_argument,	0,	'g' },
+	{"no-follow",		no_argument,	0,	'n' },
+	{"at-cwd",		no_argument,	0,	'a' },
+	{"set-nodump",		no_argument,	0,	'd' },
+	{"invalid-at",		no_argument,	0,	'i' },
+	{"too-big-arg",		no_argument,	0,	'b' },
+	{"too-small-arg",	no_argument,	0,	'm' },
+	{"new-fsx-flag",	no_argument,	0,	'x' },
+	{0,			0,		0,	0 }
+};
+
+static struct xflags {
+	uint	flag;
+	char	*shortname;
+	char	*longname;
+} xflags[] = {
+	{ FS_XFLAG_REALTIME,		"r", "realtime"		},
+	{ FS_XFLAG_PREALLOC,		"p", "prealloc"		},
+	{ FS_XFLAG_IMMUTABLE,		"i", "immutable"	},
+	{ FS_XFLAG_APPEND,		"a", "append-only"	},
+	{ FS_XFLAG_SYNC,		"s", "sync"		},
+	{ FS_XFLAG_NOATIME,		"A", "no-atime"		},
+	{ FS_XFLAG_NODUMP,		"d", "no-dump"		},
+	{ FS_XFLAG_RTINHERIT,		"t", "rt-inherit"	},
+	{ FS_XFLAG_PROJINHERIT,		"P", "proj-inherit"	},
+	{ FS_XFLAG_NOSYMLINKS,		"n", "nosymlinks"	},
+	{ FS_XFLAG_EXTSIZE,		"e", "extsize"		},
+	{ FS_XFLAG_EXTSZINHERIT,	"E", "extsz-inherit"	},
+	{ FS_XFLAG_NODEFRAG,		"f", "no-defrag"	},
+	{ FS_XFLAG_FILESTREAM,		"S", "filestream"	},
+	{ FS_XFLAG_DAX,			"x", "dax"		},
+	{ FS_XFLAG_COWEXTSIZE,		"C", "cowextsize"	},
+	{ FS_XFLAG_HASATTR,		"X", "has-xattr"	},
+	{ 0, NULL, NULL }
+};
+
+static int
+file_getattr(
+		int			dfd,
+		const char		*filename,
+		struct file_attr	*fsx,
+		size_t			usize,
+		unsigned int		at_flags)
+{
+	return syscall(__NR_file_getattr, dfd, filename, fsx, usize, at_flags);
+}
+
+static int
+file_setattr(
+		int			dfd,
+		const char		*filename,
+		struct file_attr	*fsx,
+		size_t			usize,
+		unsigned int		at_flags)
+{
+	return syscall(__NR_file_setattr, dfd, filename, fsx, usize, at_flags);
+}
+
+static void
+print_xflags(
+	uint		flags,
+	int		verbose,
+	int		dofname,
+	const char	*fname,
+	int		dobraces,
+	int		doeol)
+{
+	struct xflags	*p;
+	int		first = 1;
+
+	if (dobraces)
+		fputs("[", stdout);
+	for (p = xflags; p->flag; p++) {
+		if (flags & p->flag) {
+			if (verbose) {
+				if (first)
+					first = 0;
+				else
+					fputs(", ", stdout);
+				fputs(p->longname, stdout);
+			} else {
+				fputs(p->shortname, stdout);
+			}
+		} else if (!verbose) {
+			fputs("-", stdout);
+		}
+	}
+	if (dobraces)
+		fputs("]", stdout);
+	if (dofname)
+		printf(" %s ", fname);
+	if (doeol)
+		fputs("\n", stdout);
+}
+
+int main(int argc, char *argv[])
+{
+	int error;
+	int c;
+	const char *path = NULL;
+	const char *path1 = NULL;
+	const char *path2 = NULL;
+	unsigned int at_flags = 0;
+	unsigned int fa_xflags = 0;
+	int action = 0; /* 0 get; 1 set */
+	struct file_attr fsx = { };
+	int fa_size = sizeof(struct file_attr);
+	struct stat status;
+	int fd;
+	int at_fdcwd = 0;
+	int unknwon_fa_flag = 0;
+
+	while (1) {
+		int option_index = 0;
+
+		c = getopt_long_only(argc, argv, "", long_options,
+				&option_index);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 's':
+			action = 1;
+			break;
+		case 'g':
+			action = 0;
+			break;
+		case 'n':
+			at_flags |= AT_SYMLINK_NOFOLLOW;
+			break;
+		case 'a':
+			at_fdcwd = 1;
+			break;
+		case 'd':
+			fa_xflags |= FS_XFLAG_NODUMP;
+			break;
+		case 'i':
+			at_flags |= (1 << 25);
+			break;
+		case 'b':
+			fa_size = getpagesize() + 1; /* max size if page size */
+			break;
+		case 'm':
+			fa_size = 19; /* VER0 size of fsxattr is 20 */
+			break;
+		case 'x':
+			unknwon_fa_flag = (1 << 27);
+			break;
+		default:
+			goto usage;
+		}
+	}
+
+	if (!path1 && optind < argc)
+		path1 = argv[optind++];
+	if (!path2 && optind < argc)
+		path2 = argv[optind++];
+
+	if (at_fdcwd) {
+		fd = AT_FDCWD;
+		path = path1;
+	} else if (!path2) {
+		error = stat(path1, &status);
+		if (error) {
+			fprintf(stderr,
+"Can not get file status of %s: %s\n", path1, strerror(errno));
+			return error;
+		}
+
+		if (SPECIAL_FILE(status.st_mode)) {
+			fprintf(stderr,
+"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
+			return errno;
+		}
+
+		fd = open(path1, O_RDONLY);
+		if (fd == -1) {
+			fprintf(stderr, "Can not open %s: %s\n", path1,
+					strerror(errno));
+			return errno;
+		}
+	} else {
+		fd = open(path1, O_RDONLY);
+		if (fd == -1) {
+			fprintf(stderr, "Can not open %s: %s\n", path1,
+					strerror(errno));
+			return errno;
+		}
+		path = path2;
+	}
+
+	if (!path)
+		at_flags |= AT_EMPTY_PATH;
+
+	error = file_getattr(fd, path, &fsx, fa_size,
+			at_flags);
+	if (error) {
+		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
+				strerror(errno));
+		return error;
+	}
+	if (action) {
+		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
+
+		error = file_setattr(fd, path, &fsx, fa_size,
+				at_flags);
+		if (error) {
+			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
+					strerror(errno));
+			return error;
+		}
+	} else {
+		if (path2)
+			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
+		else
+			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
+	}
+
+	return error;
+
+usage:
+	printf("Usage: %s [options]\n", argv[0]);
+	printf("Options:\n");
+	printf("\t--get, -g\t\tget filesystem inode attributes\n");
+	printf("\t--set, -s\t\tset filesystem inode attributes\n");
+	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
+	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
+	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
+	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
+	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
+	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
+	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
+
+	return 1;
+}

-- 
2.50.1


