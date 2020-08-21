Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB8024CFA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgHUHlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgHUHkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB8C061342
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so460526pjx.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URR7tMlgOUKOzcjK5E8NicBnj1Rg4iRoSDJkh2liR1o=;
        b=zKarahD+70otuDEW4gm8J5J9PDMsQPCnJbs0kGPG8OxJ92n+9S+gkTd2+5al7gS4lQ
         itIoIFqAMcDZtg10sQYONqy4EkM7jTBqeEU5fHGcplEoKSlxXGbeE6du7eklFTz7NLWa
         EmpfFZm7OzP1zGQrV1IID53Vgs+i80uW8Zmxh6iMNU+Sx65gWzlGs5Jq2z40tJCOKRTG
         6ufp9VZbG/UDrhcbo69ENy8xnb/pepTfkoTbgP6wmxVZk5uQKjCJlkyuasPziKE+WTYM
         pV363RwWl4NhY+xluWqjlZY9nnFCj4cRliRIPPsGlfNRLP6K8vfmNrAnybwQ/JOug8EZ
         AGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URR7tMlgOUKOzcjK5E8NicBnj1Rg4iRoSDJkh2liR1o=;
        b=jWlRj+6RUnG5MTaVnKuSTqkNNISAQ//4LSUrGQuhqupIfmAsPyo/NZyceniwWjkbSy
         4UvUvZtutqwKkk5Vx3TDBczuXEHRbyNvTgcxyke/cerVy1Kmmfh95OnzK7EZ7mkao9wm
         PQNXm7j5SQJQV6YSfDtVzI4DZZ9n+w+v1jzwZiUZi1uV6f2tperzJenzueDpQMv3/vGr
         vqlk8y4l3abAfhlZehEM/p3hiG4zW54ypH/lDCg3GhDt92rybofW9zuiMALWTlIthLAY
         t9Jhk4jatKmOBFKOLEQlw3/b903UkZkfjCjSMoCaZvAsiU5rkFUgxPUveD2muIArS2jQ
         NO7Q==
X-Gm-Message-State: AOAM532moJfJ8kJhTpmEJIf6toCIeZB/qURCMxAjW64e7UwdukcZ97sY
        bRgm6O5QI9UWJI0vAslj469Syw==
X-Google-Smtp-Source: ABdhPJwhV8iqJUiJ0/8V0kKRrmFqPmu9SAzuKRUn2QhB22gVhZBUHwNdn4tx9as4cPlmH2FPQKUsHA==
X-Received: by 2002:a17:90a:498b:: with SMTP id d11mr1397508pjh.179.1597995645241;
        Fri, 21 Aug 2020 00:40:45 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:43 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/11] btrfs-progs: receive: add stub implementation for pwritev2
Date:   Fri, 21 Aug 2020 00:40:04 -0700
Message-Id: <fa0a8010abb91862ffd90a3d19fd63c14b28b98f.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

Encoded writes in receive will use pwritev2. It is possible that the
system libc does not export this function, so we stub it out and detect
whether to build the stub code with autoconf.

This syscall has special semantics in x32 (no hi lo, just takes loff_t)
so we have to detect that case and use the appropriate arguments.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 Makefile     |  4 ++--
 configure.ac |  1 +
 stubs.c      | 24 ++++++++++++++++++++++++
 stubs.h      | 11 +++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 stubs.c
 create mode 100644 stubs.h

diff --git a/Makefile b/Makefile
index c788b91b..11ecfc6c 100644
--- a/Makefile
+++ b/Makefile
@@ -173,12 +173,12 @@ libbtrfs_objects = common/send-stream.o common/send-utils.o kernel-lib/rbtree.o
 		   kernel-lib/raid56.o kernel-lib/tables.o \
 		   common/device-scan.o common/path-utils.o \
 		   common/utils.o libbtrfsutil/subvolume.o libbtrfsutil/stubs.o \
-		   crypto/hash.o crypto/xxhash.o $(CRYPTO_OBJECTS)
+		   crypto/hash.o crypto/xxhash.o $(CRYPTO_OBJECTS) stubs.o
 libbtrfs_headers = common/send-stream.h common/send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
 	       crypto/crc32c.h kernel-lib/list.h kerncompat.h \
 	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
 	       common/extent-cache.h kernel-shared/extent_io.h ioctl.h \
-	       kernel-shared/ctree.h btrfsck.h version.h
+	       kernel-shared/ctree.h btrfsck.h version.h stubs.h
 libbtrfsutil_major := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_MAJOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
 libbtrfsutil_minor := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_MINOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
 libbtrfsutil_patch := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_PATCH ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
diff --git a/configure.ac b/configure.ac
index 7c2c9b8d..cbcfbe6d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -45,6 +45,7 @@ AC_CHECK_FUNCS([openat], [],
 	[AC_MSG_ERROR([cannot find openat() function])])
 
 AC_CHECK_FUNCS([reallocarray])
+AC_CHECK_FUNCS([pwritev2])
 
 m4_ifndef([PKG_PROG_PKG_CONFIG],
   [m4_fatal([Could not locate the pkg-config autoconf
diff --git a/stubs.c b/stubs.c
new file mode 100644
index 00000000..ab68a411
--- /dev/null
+++ b/stubs.c
@@ -0,0 +1,24 @@
+#if HAVE_PWRITEV2 != 1
+
+#include "stubs.h"
+
+#include "kerncompat.h"
+
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+
+ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
+		 int flags)
+{
+/* these conditions indicate an x32 system, which has a different pwritev2 */
+#if defined(__x86_64__) && defined(__ILP32__)
+	return syscall(SYS_pwritev2, fd, iov, iovcnt, offset, flags);
+#else
+	unsigned long hi = offset >> (BITS_PER_LONG / 2) >> (BITS_PER_LONG / 2);
+	unsigned long lo = offset;
+
+	return syscall(SYS_pwritev2, fd, iov, iovcnt, lo, hi, flags);
+#endif // X32
+}
+#endif /* HAVE_PWRIVEV2 */
diff --git a/stubs.h b/stubs.h
new file mode 100644
index 00000000..b39f8a69
--- /dev/null
+++ b/stubs.h
@@ -0,0 +1,11 @@
+#ifndef _BTRFS_STUBS_H
+#define _BTRFS_STUBS_H
+
+#include <sys/types.h>
+
+struct iovec;
+
+ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
+		 int flags);
+
+#endif
-- 
2.28.0

