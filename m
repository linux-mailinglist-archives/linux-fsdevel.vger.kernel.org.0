Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40753290554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407670AbgJPMiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407674AbgJPMiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:38:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBF4C0613DB
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:38:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n9so1365057pgt.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqaYZUMkPSpLLEjOUbnHI46g98PupVda3GBY5xIdI7Y=;
        b=fLa8iRJm3pZRFs3LJk+qvkdZNLt8PKHk1DZ1czE6YVY+NyqomcV0WvQeqMm27MzkYu
         GwHr9Yx7aKxkI9KBqCEb0KK0gvKxVyLQRImBDRADJRXbhZCp0QZA8THonT0ckHS8r8Hr
         MD8XGgWjCGZjTRE12R7TPeev+20YhPQD/UcaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqaYZUMkPSpLLEjOUbnHI46g98PupVda3GBY5xIdI7Y=;
        b=ULa5Lwm7bn8Ufc5vCM4PBRVgpjVh/O+tMiQZx2k0KvcUqk6+RH0rANYP7cXte9Fl1B
         D6AveQqZCqvatMBuYtZLjpe8/KloHoRTCOatuT1xfrWrUTapcGrxkP2cCu0GmMM3WqM5
         4pboDOHLs4IJjvmLU6/HrrZD1XezKBC8avXAm/Z1o/QeP3j2M5NQxIpzySxLIkzuJCWX
         Lb8riMk2YklgW2d2noiKfTn2C0BdVhCLCldvWixogyAOvlzg/O1sxFkwZ879R6pyz57o
         X0tf1FWqrQqflWitfcRvbL3e3pBBpf4nj6bV06+MdZnZ/vwlsx7NlUH1FkCJBo4cSp9H
         tY3g==
X-Gm-Message-State: AOAM5316k45QnUhwKd9+N1aWNr/q9Ph9ehxJPIv0dNDfjgS8Lqxpp6k0
        wwzvwLJeOhBPrubvcb6PzKV6hA==
X-Google-Smtp-Source: ABdhPJxmrT2hmJIi2JVagSZ831T8sA2/y8kiYJuLUzDNhvARz+k4ExUL23VS3oEALSZOngdaE0FZLg==
X-Received: by 2002:a63:4102:: with SMTP id o2mr2932789pga.354.1602851879506;
        Fri, 16 Oct 2020 05:37:59 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id q8sm2857216pfg.118.2020.10.16.05.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:37:58 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kyle Anderson <kylea@netflix.com>
Subject: [PATCH v2 2/3] samples/vfs: Split out common code for new syscall APIs
Date:   Fri, 16 Oct 2020 05:37:44 -0700
Message-Id: <20201016123745.9510-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016123745.9510-1-sargun@sargun.me>
References: <20201016123745.9510-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are a bunch of helper functions which make using the new
mount APIs much easier. As we add examples of leveraging the
new APIs, it probably makes sense to promote code reuse.

Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kyle Anderson <kylea@netflix.com>
---
 samples/vfs/Makefile       |  2 +
 samples/vfs/test-fsmount.c | 86 +-------------------------------------
 samples/vfs/vfs-helper.c   | 43 +++++++++++++++++++
 samples/vfs/vfs-helper.h   | 55 ++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 85 deletions(-)
 create mode 100644 samples/vfs/vfs-helper.c
 create mode 100644 samples/vfs/vfs-helper.h

diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 00b6824f9237..7f76875eaa70 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+test-fsmount-objs := test-fsmount.o vfs-helper.o
 userprogs := test-fsmount test-statx
+
 always-y := $(userprogs)
 
 userccflags += -I usr/include
diff --git a/samples/vfs/test-fsmount.c b/samples/vfs/test-fsmount.c
index 50f47b72e85f..36a4fa886200 100644
--- a/samples/vfs/test-fsmount.c
+++ b/samples/vfs/test-fsmount.c
@@ -14,91 +14,7 @@
 #include <sys/wait.h>
 #include <linux/mount.h>
 #include <linux/unistd.h>
-
-#define E(x) do { if ((x) == -1) { perror(#x); exit(1); } } while(0)
-
-static void check_messages(int fd)
-{
-	char buf[4096];
-	int err, n;
-
-	err = errno;
-
-	for (;;) {
-		n = read(fd, buf, sizeof(buf));
-		if (n < 0)
-			break;
-		n -= 2;
-
-		switch (buf[0]) {
-		case 'e':
-			fprintf(stderr, "Error: %*.*s\n", n, n, buf + 2);
-			break;
-		case 'w':
-			fprintf(stderr, "Warning: %*.*s\n", n, n, buf + 2);
-			break;
-		case 'i':
-			fprintf(stderr, "Info: %*.*s\n", n, n, buf + 2);
-			break;
-		}
-	}
-
-	errno = err;
-}
-
-static __attribute__((noreturn))
-void mount_error(int fd, const char *s)
-{
-	check_messages(fd);
-	fprintf(stderr, "%s: %m\n", s);
-	exit(1);
-}
-
-/* Hope -1 isn't a syscall */
-#ifndef __NR_fsopen
-#define __NR_fsopen -1
-#endif
-#ifndef __NR_fsmount
-#define __NR_fsmount -1
-#endif
-#ifndef __NR_fsconfig
-#define __NR_fsconfig -1
-#endif
-#ifndef __NR_move_mount
-#define __NR_move_mount -1
-#endif
-
-
-static inline int fsopen(const char *fs_name, unsigned int flags)
-{
-	return syscall(__NR_fsopen, fs_name, flags);
-}
-
-static inline int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags)
-{
-	return syscall(__NR_fsmount, fsfd, flags, ms_flags);
-}
-
-static inline int fsconfig(int fsfd, unsigned int cmd,
-			   const char *key, const void *val, int aux)
-{
-	return syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
-}
-
-static inline int move_mount(int from_dfd, const char *from_pathname,
-			     int to_dfd, const char *to_pathname,
-			     unsigned int flags)
-{
-	return syscall(__NR_move_mount,
-		       from_dfd, from_pathname,
-		       to_dfd, to_pathname, flags);
-}
-
-#define E_fsconfig(fd, cmd, key, val, aux)				\
-	do {								\
-		if (fsconfig(fd, cmd, key, val, aux) == -1)		\
-			mount_error(fd, key ?: "create");		\
-	} while (0)
+#include "vfs-helper.h"
 
 int main(int argc, char *argv[])
 {
diff --git a/samples/vfs/vfs-helper.c b/samples/vfs/vfs-helper.c
new file mode 100644
index 000000000000..bae2bc03c923
--- /dev/null
+++ b/samples/vfs/vfs-helper.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include "vfs-helper.h"
+
+void check_messages(int fd)
+{
+	char buf[4096];
+	int err, n;
+
+	err = errno;
+
+	for (;;) {
+		n = read(fd, buf, sizeof(buf));
+		if (n < 0)
+			break;
+		n -= 2;
+
+		switch (buf[0]) {
+		case 'e':
+			fprintf(stderr, "Error: %*.*s\n", n, n, buf + 2);
+			break;
+		case 'w':
+			fprintf(stderr, "Warning: %*.*s\n", n, n, buf + 2);
+			break;
+		case 'i':
+			fprintf(stderr, "Info: %*.*s\n", n, n, buf + 2);
+			break;
+		}
+	}
+
+	errno = err;
+}
+
+__attribute__((noreturn))
+void mount_error(int fd, const char *s)
+{
+	check_messages(fd);
+	fprintf(stderr, "%s: %m\n", s);
+	exit(1);
+}
\ No newline at end of file
diff --git a/samples/vfs/vfs-helper.h b/samples/vfs/vfs-helper.h
new file mode 100644
index 000000000000..be460ab48247
--- /dev/null
+++ b/samples/vfs/vfs-helper.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/unistd.h>
+#include <linux/mount.h>
+#include <sys/syscall.h>
+
+#define E(x) do { if ((x) == -1) { perror(#x); exit(1); } } while(0)
+
+/* Hope -1 isn't a syscall */
+#ifndef __NR_fsopen
+#define __NR_fsopen -1
+#endif
+#ifndef __NR_fsmount
+#define __NR_fsmount -1
+#endif
+#ifndef __NR_fsconfig
+#define __NR_fsconfig -1
+#endif
+#ifndef __NR_move_mount
+#define __NR_move_mount -1
+#endif
+
+#define E_fsconfig(fd, cmd, key, val, aux)				\
+	do {								\
+		if (fsconfig(fd, cmd, key, val, aux) == -1)		\
+			mount_error(fd, key ?: "create");		\
+	} while (0)
+
+static inline int fsopen(const char *fs_name, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fs_name, flags);
+}
+
+static inline int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags)
+{
+	return syscall(__NR_fsmount, fsfd, flags, ms_flags);
+}
+
+static inline int fsconfig(int fsfd, unsigned int cmd,
+			   const char *key, const void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
+}
+
+static inline int move_mount(int from_dfd, const char *from_pathname,
+			     int to_dfd, const char *to_pathname,
+			     unsigned int flags)
+{
+	return syscall(__NR_move_mount,
+		       from_dfd, from_pathname,
+		       to_dfd, to_pathname, flags);
+}
+
+__attribute__((noreturn))
+void mount_error(int fd, const char *s);
+void check_messages(int fd);
-- 
2.25.1

