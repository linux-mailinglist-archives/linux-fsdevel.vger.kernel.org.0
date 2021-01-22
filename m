Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB54300E99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbhAVVLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbhAVUxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:53:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D07C0698D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id md11so4597782pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4U7hox/ox8NJiCD09kdKyflNUgetq9XNrvX185hJfE=;
        b=iW4TXb5oPqGQcV/qhoRMlEInT5Sa9xhW4WR/LNznUpCaUXsDodccPB5wG/jlEeKJks
         +MR2AsCl1N2lI+LOiT64sVYzRs4DUDtJ4WDFSXfj6Zc8VQy47j0WXqKbDJc5nYNdCCcI
         AcUrC7ViZ5AreRLR/c2Cgj9cRMpXg0rgHmux4/9X10ct144cy4LE6PDcgIS4MRiEfcDP
         wWj7Jl1uzz/J/VWsDLTvizsdY9Pv1xjTUHfH9SsBHSbqxR5bEPUfQz9yIYQYq3oZdDNE
         8SVgJBBg/D+8hRKLmJKrFnJjzc7qSdLo7CfYJDoaQgVwGfENFV7CpvZoBlDZ58AKC1p/
         hDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4U7hox/ox8NJiCD09kdKyflNUgetq9XNrvX185hJfE=;
        b=sk0x1+AsPF+Uzqop7nuasLeQqHH+pvoQmN2t7HPaP1lAO6chdlThgIQdxp2sx1XDMD
         ADqpmKHaoORJmN+rpqHpkmgb5pJpiOdRstTwjsQ8t1hnJEql+L68c2EPyMfC/0L7o0gc
         bVQ7l25apqelXriPdE+JHj7WbPgEY6yNm9dYp9ZH+xJHsKtH0KUN0V71oSTDE1OEfItd
         f4Rwkmmqqx7W/tDOzT2H/fM3ScqcDdw2YksNgEWBn1uyNr5O7ZH8zaVXhdCDdN3TBbyQ
         6Sx9LBFwERgY9d/8IIp6peKGHHx9sPWEcueqAyeeNXzBVPXG7fURigbWzh2VU+CgzG/l
         rrnw==
X-Gm-Message-State: AOAM5328mbrURNHzqGls7moi2gMQehw3k3xz9uSTIVnB6PIvRpWzXBFi
        bWvIXvpN6fP6S4UONWUWkof4yMBftcH5Hw==
X-Google-Smtp-Source: ABdhPJwcshFHSUnx4T8H9XICsfSpJItoAwj2IFubcr8mhUD8QdwvPO0JW2ZkFSmUBW3+8wGSQGbKhA==
X-Received: by 2002:a17:902:694c:b029:da:afba:beab with SMTP id k12-20020a170902694cb02900daafbabeabmr6810541plt.32.1611348516992;
        Fri, 22 Jan 2021 12:48:36 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:35 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 05/11] btrfs-progs: receive: add stub implementation for pwritev2
Date:   Fri, 22 Jan 2021 12:47:51 -0800
Message-Id: <e0d2c6c86a5b76db21620443ed6f66a4c2a7c30e.1611347859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index e288a336..7c0971f7 100644
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
index 39f93040..d43eb91f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,6 +57,7 @@ AC_CHECK_FUNCS([openat], [],
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
2.30.0

