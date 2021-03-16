Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008AE33DDF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhCPTpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbhCPTpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF240C0613DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s7so17448081plg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuAw0ppT0ABvcb7CD6nxV0FbeYlL2sIG10J+yY2raCU=;
        b=ztqOvQUthnoojW1c4C5JqRJk0YckO3BPtl5/hMvtBD3/GNsDPIwfazyld3BbiRGdwC
         E0loKHEIiJ6N31sXfk+LxGOxDdgXnRM0l3r0hpklJ6P/d8fMc2Ox9tsb0Z1O11sDKUqn
         juMFavGAu9dONm/5NPSUJW1SBJwIslofq3lLpW2T66UTF+Dx4SkBg0iGQ0en9NfINIDa
         /aiGC54mei1nF/hDK1giqhpfTpXSgtN2I04hkx3hFMI5/FMexuD1gi1QQI7ku7JrlYju
         vI2yKnN+YYqk4WgnUZtTJBqAE1NO0xeIBMRMgJty4ze27g49WLiH5qI/wCw9xwB7EPAq
         aqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuAw0ppT0ABvcb7CD6nxV0FbeYlL2sIG10J+yY2raCU=;
        b=LHBaHUF9R1CkX+UpV1ucZS4VmJHnyzS/QdgWau5RGcWY7XeKc40YmtvSTdrBrHvzoW
         MtOkF03xjYY+mCA/3M0TyDWRy5GAy6ZAthD0vhwkN1LGxpYqZwSJT/0JphcNEv6hw1zO
         BZIDchKyjqnodDvgZDVtyT+7kzA020GcYALnXtAn+IwWocmDkcrSiNBJO117Pbs49/mh
         0Pknhr7Op4Ut7qY4g4FHLEBnU4mCkl0sVjw7aoCf4G/0Vtl8cpDf12s689ciXU5X3QF0
         MtHocCXNy22jHWXfHaA0JwOHiS5CWo5DjrkbT+x7Kzr2MRpeLHLmPV9g0+ue2Q9nQpG2
         BSzw==
X-Gm-Message-State: AOAM532emqm/Ttgc840Yhg97ldYvJUelGUhsF9p7fwGqOhpbkxzjoOs7
        rXeZK+9RyVOFC4UB1PdJwHRW/g==
X-Google-Smtp-Source: ABdhPJzwOvxll0bc3dCRKvFwG94j5cEcrVnjYBlSnyRXrEmITN+aTln6aLaxs/NBjTH1aekjVGqX6g==
X-Received: by 2002:a17:90a:d907:: with SMTP id c7mr611393pjv.45.1615923878427;
        Tue, 16 Mar 2021 12:44:38 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:37 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 05/11] btrfs-progs: receive: add stub implementation for pwritev2
Date:   Tue, 16 Mar 2021 12:43:58 -0700
Message-Id: <e6817cbd8ba926eb5b4e0d19e10ac6a2af6ad05b.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
index 498588cd..b91daeb6 100644
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
index aa3f7824..4e85436f 100644
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
2.30.2

