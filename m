Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D43127C3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLTOEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 09:04:33 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:53080 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLTOEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:04:33 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 47fVqL21bfzKmVq;
        Fri, 20 Dec 2019 15:04:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id hyuFQlMQTZ0P; Fri, 20 Dec 2019 15:04:26 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        dev@opencontainers.org, containers@lists.linux-foundation.org,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] uapi: split openat2(2) definitions from fcntl.h
Date:   Sat, 21 Dec 2019 01:03:28 +1100
Message-Id: <20191220140328.20907-3-cyphar@cyphar.com>
In-Reply-To: <20191220140328.20907-1-cyphar@cyphar.com>
References: <20191220140328.20907-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Florian mentioned that glibc doesn't use fcntl.h because it has some
issues with namespace cleanliness, and that we should have a separate
header for openat2(2) if possible. In addition, userspace has no real
use for the OPEN_HOW_SIZE_* constants so move them to the in-kernel
headers.

Suggested-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 MAINTAINERS                  |  1 +
 include/linux/fcntl.h        |  4 ++++
 include/uapi/linux/fcntl.h   | 36 +--------------------------------
 include/uapi/linux/openat2.h | 39 ++++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 35 deletions(-)
 create mode 100644 include/uapi/linux/openat2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..737ada377ac3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6397,6 +6397,7 @@ F:	fs/*
 F:	include/linux/fs.h
 F:	include/linux/fs_types.h
 F:	include/uapi/linux/fs.h
+F:	include/uapi/linux/openat2.h
 
 FINTEK F75375S HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	Riku Voipio <riku.voipio@iki.fi>
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index f2eb05bd3af3..7bcdcf4f6ab2 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -21,6 +21,10 @@
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
 	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
 
+/* List of all open_how "versions". */
+#define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
+#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
+
 #ifndef force_o_largefile
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 5aaadfd79dd5..ca88b7bce553 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_FCNTL_H
 
 #include <asm/fcntl.h>
+#include <linux/openat2.h>
 
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
 #define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
@@ -100,39 +101,4 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
-/*
- * Arguments for how openat2(2) should open the target path. If only @flags and
- * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
- *
- * However, unlike openat(2), unknown or invalid bits in @flags result in
- * -EINVAL rather than being silently ignored. @mode must be zero unless one of
- *  {O_CREAT, O_TMPFILE} are set.
- *
- * @flags: O_* flags.
- * @mode: O_CREAT/O_TMPFILE file mode.
- * @resolve: RESOLVE_* flags.
- */
-struct open_how {
-	__u64 flags;
-	__u64 mode;
-	__u64 resolve;
-};
-
-#define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
-#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
-
-/* how->resolve flags for openat2(2). */
-#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
-					(includes bind-mounts). */
-#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
-					"magic-links". */
-#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
-					(implies OEXT_NO_MAGICLINKS) */
-#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
-					"..", symlinks, and absolute
-					paths which escape the dirfd. */
-#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
-					be scoped inside the dirfd
-					(similar to chroot(2)). */
-
 #endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
new file mode 100644
index 000000000000..58b1eb711360
--- /dev/null
+++ b/include/uapi/linux/openat2.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_OPENAT2_H
+#define _UAPI_LINUX_OPENAT2_H
+
+#include <linux/types.h>
+
+/*
+ * Arguments for how openat2(2) should open the target path. If only @flags and
+ * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
+ *
+ * However, unlike openat(2), unknown or invalid bits in @flags result in
+ * -EINVAL rather than being silently ignored. @mode must be zero unless one of
+ * {O_CREAT, O_TMPFILE} are set.
+ *
+ * @flags: O_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
+ * @resolve: RESOLVE_* flags.
+ */
+struct open_how {
+	__u64 flags;
+	__u64 mode;
+	__u64 resolve;
+};
+
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+
+#endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.24.0

