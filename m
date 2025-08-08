Return-Path: <linux-fsdevel+bounces-57132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1880B1EEE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FB6581EE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA052882AA;
	Fri,  8 Aug 2025 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Es20vdD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE721F63CD
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681541; cv=none; b=ol4Uyus750VZCRa3iPgLZ7K5XuYWNiQF95JhkHZaPgQMfYOfY/83D3r9F75S1rJZJmnMzrCQT9PLCtzIe0r0EyVmEbSdl4+m9ysZJYrx4TgqjXUPdTYJT6tkRM3Fj4NiFAJloFeK6IOM/JA7V++2LP8l5jFdt7MWwU7qFoE/W0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681541; c=relaxed/simple;
	bh=WujlhYTQ8jAqRvrGPxQt0D+9SgdBdzmBALP2G4lkanw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1ne2z5U24XICWmDg/AOB39Dq8d1shWz0ci2mmuTTlCNl2HZTQZtcIG+cAeTs/kbl7QdgRv1VcdnX+EOKuGop06ZEKsuwHxzR4nkUSP8DZCv6PVHv6wqhGDrRd0lDYAdfblen15fmCRcV2S2Yjcd6IxyC6PXJXNeF+LQ7FBRS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Es20vdD3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnH5AGkNC1YLmaeblWM34txAvQiRi2XNQckzj6PJBcA=;
	b=Es20vdD3M2Pzroo9DXbSibRHAskFM+Me2OACyQPXCX6pvQXZSm3lCQ7p4vj9Lil5tiwuMa
	ax40ygj+kOWLMPY7e3G8xvBhjmzrYNqlcl91Tq3gjbUu75CDbwXny07Xo1Y+inMo868VLx
	CuayLpAfR8ATCcnytQCvcZ7x1uuMpe0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-ztoZR-AFP5CUQ_PRbHo0Cw-1; Fri, 08 Aug 2025 15:32:16 -0400
X-MC-Unique: ztoZR-AFP5CUQ_PRbHo0Cw-1
X-Mimecast-MFC-AGG-ID: ztoZR-AFP5CUQ_PRbHo0Cw_1754681536
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d30992bcso20733085e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681535; x=1755286335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnH5AGkNC1YLmaeblWM34txAvQiRi2XNQckzj6PJBcA=;
        b=OCNu6oFgDyA12aLAUta+lqsPWYMfPRixKIFx6jSDDXMRro3lQtorJIcUBF9nlOoLun
         kRegUtVWp0AnGqxmvIbB8HDDjFZ6exmRDgSBv1qX5jdh7XnG1MLz1ZR+nSkjiH0YQ1R2
         sxtpUfHJL7GjWBtf9pEGD+oicrmHzC11Xb/LlPvG+O86MyZxmQ4aIXD23vltMcYEJ+/q
         rOQkCTPZbFVk5sh2l6xk8lV6hwYBg72aAX6hEb0ZQzmIZkYXBX5IvV2uLscE4ehU9hK7
         MYWN98/AwdA7DXEBiO5eyB8lyhfvE6JreR5LSh6AqmbrP5LSjkAFKwixmYqIfb54eZLI
         MqAA==
X-Forwarded-Encrypted: i=1; AJvYcCUNtzjTC1JUsyybgA1NC9HFBPq42gIuyeQYgdROtaLlzF8KEjEfAUlSSUUBAk0soVKUEnnL5DtICueTg4I4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+T6NMWtlJdrMy47caxQ3zK+dRD5PN4t1/rD9Oa8XfSSKCwd1A
	WTl5QvGUis6KnK4oxCA1QIlrSZRI1gj5tgVKVSq247Op5kTnEZbJv6otSx4mpBf2aTs2geOLeJs
	aS2U4DVzKhkXnHb4ltFyjqk/ZqXjHKgGfCGDvPJyRZJpLbjFqgQbBkW72yzmHj6lNG3qqBS7xRA
	==
X-Gm-Gg: ASbGncuCBvUKWjQyn6ITM9KaISwjTD3K0n6nrpKaFOeBJV7Tjil3m9+rk5+cDI1tRGZ
	cGRZDdd4v6oYThSrKAWy7ZhwUj+qARXGTSJhx0bLnWGUdbWv40Np5oNoF0J5P1OMrrAQbjDhXv5
	Mk01/7X0cZGczEOYKcKSwD3F92gThIWAc8aYMYBvGBHamZNwVlcO3PhfPk2xaWXTOWbW4jBV3Lw
	6JGVoaaUqMX7yHBJgHJni0CSBOXO8W0zFzPFiT+otFG2jGVhiUAKbyque8B6WJl3gocKq51ZTId
	vt5w/VjrE0RoE6Lg6cuOGxm04YIsgoCsWEF2ns5Lx34okw==
X-Received: by 2002:a05:600c:45c6:b0:459:dc35:dc05 with SMTP id 5b1f17b1804b1-459f4f51a76mr27243715e9.9.1754681534881;
        Fri, 08 Aug 2025 12:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrPOIgoIfUoRuaLapmkogo3cWYmwTtKM6hGTwdverZUZstxhBYBJBqSm8qPdAlBIqQU610UA==
X-Received: by 2002:a05:600c:45c6:b0:459:dc35:dc05 with SMTP id 5b1f17b1804b1-459f4f51a76mr27243525e9.9.1754681534308;
        Fri, 08 Aug 2025 12:32:14 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5869cccsm164906135e9.17.2025.08.08.12.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:32:14 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 08 Aug 2025 21:31:56 +0200
Subject: [PATCH 1/3] file_attr: introduce program to set/get fsxattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-xattrat-syscall-v1-1-6a09c4f37f10@kernel.org>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
In-Reply-To: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9990; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=WujlhYTQ8jAqRvrGPxQt0D+9SgdBdzmBALP2G4lkanw=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYF7I346Km3+9z6gs0Xw64mugg0ZKa7Gm+5ERlhK
 TkrKOxq1sSOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAEzE/xvC/MnK1UdD6He/N
 bQ6dOu2Y/efZj9fn/Z2zLHl7J61IiONcysiwI8j4cfYlxvQTYlM2bp2qsqmLL3Helvh11vb6kpO
 ly46wAwCI3EeA
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
 src/file_attr.c       | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 301 insertions(+)

diff --git a/.gitignore b/.gitignore
index 4fd817243dca..1a578eab1ea0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -210,6 +210,7 @@ tags
 /src/fiemap-fault
 /src/min_dio_alignment
 /src/dio-writeback-race
+/src/file_attr
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/configure.ac b/configure.ac
index f3c8c643f0eb..6fe54e8e1d54 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,6 +73,7 @@ AC_HAVE_RLIMIT_NOFILE
 AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
 AC_HAVE_FICLONE
 AC_HAVE_TRIVIAL_AUTO_VAR_INIT
+AC_HAVE_FILE_ATTR
 
 AC_CHECK_FUNCS([renameat2])
 AC_CHECK_FUNCS([reallocarray])
diff --git a/include/builddefs.in b/include/builddefs.in
index 96d5ed25b3e2..821237339cc7 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -74,6 +74,7 @@ HAVE_BMV_OF_SHARED = @have_bmv_of_shared@
 HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
 NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
 HAVE_FICLONE = @have_ficlone@
+HAVE_FILE_ATTR = @have_file_attr@
 
 GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
 SANITIZER_CFLAGS += @autovar_init_cflags@
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index ed8fe6e32ae0..e68a70f7d87e 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -86,3 +86,19 @@ AC_DEFUN([AC_HAVE_TRIVIAL_AUTO_VAR_INIT],
     CFLAGS="${OLD_CFLAGS}"
     AC_SUBST(autovar_init_cflags)
   ])
+
+#
+# Check if we have a file_getattr/file_setattr system call (Linux)
+#
+AC_DEFUN([AC_HAVE_FILE_ATTR],
+  [ AC_MSG_CHECKING([for file_getattr/file_setattr syscalls])
+    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#include <sys/syscall.h>
+#include <unistd.h>
+    ]], [[
+         syscall(__NR_file_getattr, 0, 0, 0, 0, 0, 0);
+    ]])],[have_file_attr=yes
+       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
+    AC_SUBST(have_file_attr)
+  ])
diff --git a/src/Makefile b/src/Makefile
index 6ac72b366257..f3137acf687f 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -61,6 +61,11 @@ ifeq ($(HAVE_FALLOCATE), true)
 LCFLAGS += -DHAVE_FALLOCATE
 endif
 
+ifeq ($(HAVE_FILE_ATTR), yes)
+LINUX_TARGETS += file_attr
+LCFLAGS += -DHAVE_FILE_ATTR
+endif
+
 ifeq ($(PKG_PLATFORM),linux)
 TARGETS += $(LINUX_TARGETS)
 endif
diff --git a/src/file_attr.c b/src/file_attr.c
new file mode 100644
index 000000000000..9756ab265a57
--- /dev/null
+++ b/src/file_attr.c
@@ -0,0 +1,277 @@
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
+#ifndef HAVE_FILE_ATTR
+#define __NR_file_getattr 468
+#define __NR_file_setattr 469
+
+struct file_attr {
+       __u32           fa_xflags;     /* xflags field value (get/set) */
+       __u32           fa_extsize;    /* extsize field value (get/set)*/
+       __u32           fa_nextents;   /* nextents field value (get)   */
+       __u32           fa_projid;     /* project identifier (get/set) */
+       __u32           fa_cowextsize; /* CoW extsize field value (get/set) */
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
+void
+printxattr(
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
+        while (1) {
+            int option_index = 0;
+
+            c = getopt_long_only(argc, argv, "", long_options, &option_index);
+            if (c == -1)
+                break;
+
+            switch (c) {
+	    case 's':
+		action = 1;
+		break;
+	    case 'g':
+		action = 0;
+		break;
+	    case 'n':
+		at_flags |= AT_SYMLINK_NOFOLLOW;
+		break;
+	    case 'a':
+		at_fdcwd = 1;
+		break;
+	    case 'd':
+		fa_xflags |= FS_XFLAG_NODUMP;
+		break;
+	    case 'i':
+		at_flags |= (1 << 25);
+		break;
+	    case 'b':
+		fa_size = getpagesize() + 1; /* max size if page size */
+		break;
+	    case 'm':
+		fa_size = 19; /* VER0 size of fsxattr is 20 */
+		break;
+	    case 'x':
+		unknwon_fa_flag = (1 << 27);
+		break;
+	    default:
+		goto usage;
+            }
+        }
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
+	if (action) {
+		error = file_getattr(fd, path, &fsx, fa_size,
+				at_flags);
+		if (error) {
+			fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
+					strerror(errno));
+			return error;
+		}
+
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
+		error = file_getattr(fd, path, &fsx, fa_size,
+				at_flags);
+		if (error) {
+			fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
+					strerror(errno));
+			return error;
+		}
+
+		if (path2)
+			printxattr(fsx.fa_xflags, 0, 1, path, 0, 1);
+		else
+			printxattr(fsx.fa_xflags, 0, 1, path1, 0, 1);
+	}
+
+	return error;
+
+usage:
+	printf("Usage: %s [options]\n", argv[0]);
+	printf("Options:\n");
+	printf("\t--get\t\tget filesystem inode attributes\n");
+	printf("\t--set\t\tset filesystem inode attributes\n");
+	printf("\t--at-cwd\t\topen file at current working directory\n");
+	printf("\t--no-follow\t\tdon't follow symlinks\n");
+	printf("\t--set-nodump\t\tset FS_XFLAG_NODUMP on an inode\n");
+	printf("\t--invalid-at\t\tUse invalida AT_* flag\n");
+	printf("\t--too-big-arg\t\tSet fsxattr size bigger than PAGE_SIZE\n");
+	printf("\t--too-small-arg\t\tSet fsxattr size to 27 bytes\n");
+	printf("\t--new-fsx-flag\t\tUse unknown fa_flags flag\n");
+
+	return 1;
+}

-- 
2.49.0


