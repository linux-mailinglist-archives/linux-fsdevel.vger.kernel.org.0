Return-Path: <linux-fsdevel+bounces-59396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC62B38657
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567E7983654
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB4E27FD6D;
	Wed, 27 Aug 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvU6MkEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7727CCE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307786; cv=none; b=GBIkxxVvlUHbprsyQ6J3ioVqQO6R6yM/WhX91yk4ZsL7/sVMhOdzlvJGegqO32S1CToGuks5WeXuZckd/XovEJH9ZBoiD9KjY3my7uaVVdcnPcIKqCEjs12O7IK+F5I5jwCMgHp+RApHU03CF3Crw3wuNao3phnLITgRN6Yfd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307786; c=relaxed/simple;
	bh=eylZ4RzvMaTL+YpZUU1X3j043tZPNpzbr0txKhRaw08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8Hq3916HLxz5iW4yuq4AmDxFhY+NDOlRvsjDHFpLp19T/PnuhUyeTP5usF1s/WWJyMkbqBW4nAJKktsAhWJzH85l8mMNFLrOJFnrLItTUF8A+cEb9LC61BkgecNhxslGhfCzVETs6sUXFEnrPSV8L0XoVrbo+SGfbc7YC7NleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvU6MkEf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfbYVz7fz/uFwR+BnUwt3uyI6bbjKJwT7ACbSas7CX4=;
	b=NvU6MkEfN5Wke9xk9ufAXTWjtdxZFIRc7iUUHLTzAIkhJUtn3+TrEgqtnzsq4fshwJgWnm
	IedI30X5XJLj3zKr9OtS4K0Tn1LRZjv0EagdRsTXecGkORvetTolRljV8Rnxil7yoHs5Fj
	fW5oJr7CHDQSdio5SN5U+II5itEbKsQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-tVALaQVMM7-GKYEkb5iFBA-1; Wed, 27 Aug 2025 11:16:21 -0400
X-MC-Unique: tVALaQVMM7-GKYEkb5iFBA-1
X-Mimecast-MFC-AGG-ID: tVALaQVMM7-GKYEkb5iFBA_1756307780
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0060bfso46689855e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307780; x=1756912580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfbYVz7fz/uFwR+BnUwt3uyI6bbjKJwT7ACbSas7CX4=;
        b=TwJkC/B+GXVSI0S/F9IXMJ+Lz3UTAkjNvYQhIwfLMe4/5uGNsXnO0aUpgGnKOh3sZJ
         7XpN9YRRhqytBAJogUq6NoyJBipztDUaSgUhtFWQ1U9WZpLlkELlicU/Nh3/ilOs/Pl8
         J0fZAkouvDZqoFbQxiKM4LATvgh7038yy5iH7K4PY0rXxSL0eKQ3NGw1KBSk2BX3+FT0
         6SWDwG26Wn/0vnsB3F+0gPA2QHaNPgysicKvakKN0vOkfAxCjBJDeIaRTVHJbnNZX9eq
         rN4/RX1xGp9n9aSZJS5n9utCftoyvPzR6BQnRyOACCwDlkQBuNAoIKOjYMYYzDDwc5kS
         2mrw==
X-Forwarded-Encrypted: i=1; AJvYcCXQMKH9nds3ida/b9yjnmojCSSDBI/Ns4QDieEffQsrMw1y6i2HPWifslDDzTuJbolLB2m0IFtuWucGdqUG@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcz8fX0yuWcsosaLpxZ7D3HOGfHInkGWIERpLiQJgwmjZUsfb
	Oytv+IR28cfHFQpdYGUvaMwwKAoHQrsxdb2YC5mPX6u9goXTxkxPdOc5VtO9G50xYfhOfj65fG0
	xf9vB7Hkicuf+b3xEFSj44DjU382o9AN7T8MKDNtYOwIKMlQecPnVHQAij3Yed99M4g==
X-Gm-Gg: ASbGncuyK3E5FZmcJMC5mQhhpcnuyD1qswkoZI17dTbGzOLgBGdZGuem/rdRSXk4/s+
	IU/JXIyNprpMh2AdXCZhnOOAjqiX6ugJElS1vXjjkIbBbD7xR98JaKRr3athOkLpuYw+QaDHBej
	w3mcHvNmIVR1oziAuLzdbdRoo8AMkUWdeP4RmVf9ajM86mFhw1PMpZ/dLCGZI8uE9+pVHQe7+mh
	nNgRnvvlp7TGJvaFdHxg0VhVE7nGsA9Stze0WUPsuxGaxOs51euH7AxoMD8YhaIDaS7M00k99pI
	vLx1UGsUGBA9zlBJMQ==
X-Received: by 2002:a05:600c:4512:b0:45b:67e9:121e with SMTP id 5b1f17b1804b1-45b74e88d87mr9563125e9.14.1756307780164;
        Wed, 27 Aug 2025 08:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYQ5okULGOkY4L91XEmJV1fq5N2QWiXUnjAyTcd0hKOUVNKspYTLBGBRNx86dBqTanYNdhwA==
X-Received: by 2002:a05:600c:4512:b0:45b:67e9:121e with SMTP id 5b1f17b1804b1-45b74e88d87mr9562885e9.14.1756307779656;
        Wed, 27 Aug 2025 08:16:19 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm35019145e9.1.2025.08.27.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:16:19 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 27 Aug 2025 17:16:15 +0200
Subject: [PATCH v2 1/3] file_attr: introduce program to set/get fsxattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-xattrat-syscall-v2-1-ba489b5bc17a@kernel.org>
References: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
In-Reply-To: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9830; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=eylZ4RzvMaTL+YpZUU1X3j043tZPNpzbr0txKhRaw08=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtYrOj26aXlFVuxgkW3fpuANBak63nMfyBdWLBaZd
 WiRsv1ZZc+OUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE5njz8hwqUOZWeCMz6yz
 +R52H+IsX5ZznejvKpwqEbYyYtbjzieLGRlm8On4p6uypa6301ip5X9x56J9H9TaV5qvczvSedX
 seRkfABLiREY=
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
 src/file_attr.c       | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 292 insertions(+)

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
index 7080e34896c3..db4223156fc2 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -62,6 +62,11 @@ ifeq ($(HAVE_FALLOCATE), true)
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
index 000000000000..9baf0e9a12ee
--- /dev/null
+++ b/src/file_attr.c
@@ -0,0 +1,268 @@
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
+	printf("\t--invalid-at, -i\t\tUse invalida AT_* flag\n");
+	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
+	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
+	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
+
+	return 1;
+}

-- 
2.49.0


