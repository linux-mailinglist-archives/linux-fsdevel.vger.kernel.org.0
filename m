Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E050C2B84C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgKRTTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgKRTTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:33 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B995CC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:31 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id y22so1534250plr.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdTEku7J/1wmWyPZ7NOZDpBLdc5B/RHj8uVOrA+In/8=;
        b=roqYDntKPONpvGO4yrNgAnMiIvzffHjw1ItJjihDO0zAXyTqw7LaWVag9fQpotYUKd
         YfVB6eFRNdZ5s6MEsHcrcqaJFcYKJyMEfNku/pCinewZLtzbI4FIGXBqhiZkvNOg3A3B
         AAsgrrl7tDKgSZpiOIhXcoZ7ZDrPSrVaiXe02Q6CEiyYITVaT7I+IgwHFFaIsDnePx1e
         WhG4EGML51kiebsnX5Z3iIDjhfpdcS/8oh1i0RFjCOfvE90xXoiHIWBp+6lBvrBiS0fQ
         16Y7ZDhSWkcCR2EJ/g4EwNQ7a/o4RLSksiEaCh4pS2UuBOyhD8vOYbv7lmLaJGGSgA1B
         RgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdTEku7J/1wmWyPZ7NOZDpBLdc5B/RHj8uVOrA+In/8=;
        b=Hqg56KByA7u7d4pqBy1JRUc8vYeIj2QSOTlPzKB3GvTGzsJE4yA7qA0gB6Z8g2eE0X
         OABrlPYPrbbzVsCR4/RP1zYe3aYWAYBnt2zYnZrAWOZnipvj+MoTs36HpfMXReKadvQW
         t4mQoM3u8x0tPN8jAlspNpundUG1w3Yc9DlSPg5z+x3/djbrgZT8DwO/8IRY6JmXvhkA
         Tda+/XewgUhkca+WqAXp/BlUPGbjBOeaxP4mREpc7nm9CMktyHaXfbzqIqdZvVQ/S+M8
         Solip/yBx8/kdcVCYRBYHAwXlJeYVFNVk1ISlpnE1M0WgTeUf4DKNNBQxBc4jW8r822/
         vlJg==
X-Gm-Message-State: AOAM533QDV3suf5blamhSWaRdDOogkmJjyi+QqkwCdfAHk+iPvmqPHkM
        gZLjq/HBGMVaOtPNqxdRcxwlHw==
X-Google-Smtp-Source: ABdhPJzLbh0+BDId9iRc2IZ73xfiwWhzpQU1qk3S1DKX/X95Jnkcr7rywmRMtBQwOSeUicRjgXvtWg==
X-Received: by 2002:a17:902:6a83:b029:d5:e98f:2437 with SMTP id n3-20020a1709026a83b02900d5e98f2437mr5625373plk.38.1605727171319;
        Wed, 18 Nov 2020 11:19:31 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:29 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/13] btrfs-progs: receive: add stub implementation for pwritev2
Date:   Wed, 18 Nov 2020 11:18:53 -0800
Message-Id: <fbfec817eede33f202464cb240547993e4a0170a.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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
index 381b630d..505e39d7 100644
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
index dd4adedf..eaf353cc 100644
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
2.29.2

