Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43E0A9303
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 22:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfIDUUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 16:20:31 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:61250 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfIDUUb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:20:31 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 14B05A1118;
        Wed,  4 Sep 2019 22:20:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 5YgcWSvkz__Z; Wed,  4 Sep 2019 22:20:20 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user helpers
Date:   Thu,  5 Sep 2019 06:19:22 +1000
Message-Id: <20190904201933.10736-2-cyphar@cyphar.com>
In-Reply-To: <20190904201933.10736-1-cyphar@cyphar.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A common pattern for syscall extensions is increasing the size of a
struct passed from userspace, such that the zero-value of the new fields
result in the old kernel behaviour (allowing for a mix of userspace and
kernel vintages to operate on one another in most cases). This is done
in both directions -- hence two helpers -- though it's more common to
have to copy user space structs into kernel space.

Previously there was no common lib/ function that implemented
the necessary extension-checking semantics (and different syscalls
implemented them slightly differently or incompletely[1]). A future
patch replaces all of the common uses of this pattern to use the new
copy_struct_{to,from}_user() helpers.

[1]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
     similar checks to copy_struct_from_user() while rt_sigprocmask(2)
     always rejects differently-sized struct arguments.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/uaccess.h |   5 ++
 lib/Makefile            |   2 +-
 lib/struct_user.c       | 182 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 lib/struct_user.c

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 34a038563d97..0ad9544a1aee 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -230,6 +230,11 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 
 #endif		/* ARCH_HAS_NOCACHE_UACCESS */
 
+extern int copy_struct_to_user(void __user *dst, size_t usize,
+			       const void *src, size_t ksize);
+extern int copy_struct_from_user(void *dst, size_t ksize,
+				 const void __user *src, size_t usize);
+
 /*
  * probe_kernel_read(): safely attempt to read from a location
  * @dst: pointer to the buffer that shall take the data
diff --git a/lib/Makefile b/lib/Makefile
index 29c02a924973..d86c71feaf0a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,7 +28,7 @@ endif
 CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
 endif
 
-lib-y := ctype.o string.o vsprintf.o cmdline.o \
+lib-y := ctype.o string.o struct_user.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o \
 	 sha1.o chacha.o irq_regs.o argv_split.o \
diff --git a/lib/struct_user.c b/lib/struct_user.c
new file mode 100644
index 000000000000..7301ab1bbe98
--- /dev/null
+++ b/lib/struct_user.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 SUSE LLC
+ * Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#define BUFFER_SIZE 64
+
+/*
+ * "memset(p, 0, size)" but for user space buffers. Caller must have already
+ * checked access_ok(p, size).
+ */
+static int __memzero_user(void __user *p, size_t s)
+{
+	const char zeros[BUFFER_SIZE] = {};
+	while (s > 0) {
+		size_t n = min(s, sizeof(zeros));
+
+		if (__copy_to_user(p, zeros, n))
+			return -EFAULT;
+
+		p += n;
+		s -= n;
+	}
+	return 0;
+}
+
+/**
+ * copy_struct_to_user: copy a struct to user space
+ * @dst:   Destination address, in user space.
+ * @usize: Size of @dst struct.
+ * @src:   Source address, in kernel space.
+ * @ksize: Size of @src struct.
+ *
+ * Copies a struct from kernel space to user space, in a way that guarantees
+ * backwards-compatibility for struct syscall arguments (as long as future
+ * struct extensions are made such that all new fields are *appended* to the
+ * old struct, and zeroed-out new fields have the same meaning as the old
+ * struct).
+ *
+ * @ksize is just sizeof(*dst), and @usize should've been passed by user space.
+ * The recommended usage is something like the following:
+ *
+ *   SYSCALL_DEFINE2(foobar, struct foo __user *, uarg, size_t, usize)
+ *   {
+ *      int err;
+ *      struct foo karg = {};
+ *
+ *      // do something with karg
+ *
+ *      err = copy_struct_to_user(uarg, usize, &karg, sizeof(karg));
+ *      if (err)
+ *        return err;
+ *
+ *      // ...
+ *   }
+ *
+ * There are three cases to consider:
+ *  * If @usize == @ksize, then it's copied verbatim.
+ *  * If @usize < @ksize, then kernel space is "returning" a newer struct to an
+ *    older user space. In order to avoid user space getting incomplete
+ *    information (new fields might be important), all trailing bytes in @src
+ *    (@ksize - @usize) must be zerored, otherwise -EFBIG is returned.
+ *  * If @usize > @ksize, then the kernel is "returning" an older struct to a
+ *    newer user space. The trailing bytes in @dst (@usize - @ksize) will be
+ *    zero-filled.
+ *
+ * Returns (in all cases, some data may have been copied):
+ *  * -EFBIG:  (@usize < @ksize) and there are non-zero trailing bytes in @src.
+ *  * -EFAULT: access to user space failed.
+ */
+int copy_struct_to_user(void __user *dst, size_t usize,
+			const void *src, size_t ksize)
+{
+	size_t size = min(ksize, usize);
+	size_t rest = abs(ksize - usize);
+
+	if (unlikely(usize > PAGE_SIZE))
+		return -EFAULT;
+	if (unlikely(!access_ok(dst, usize)))
+		return -EFAULT;
+
+	/* Deal with trailing bytes. */
+	if (usize < ksize) {
+		if (memchr_inv(src + size, 0, rest))
+			return -EFBIG;
+	} else if (usize > ksize) {
+		if (__memzero_user(dst + size, rest))
+			return -EFAULT;
+	}
+	/* Copy the interoperable parts of the struct. */
+	if (__copy_to_user(dst, src, size))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL(copy_struct_to_user);
+
+/**
+ * copy_struct_from_user: copy a struct from user space
+ * @dst:   Destination address, in kernel space. This buffer must be @ksize
+ *         bytes long.
+ * @ksize: Size of @dst struct.
+ * @src:   Source address, in user space.
+ * @usize: (Alleged) size of @src struct.
+ *
+ * Copies a struct from user space to kernel space, in a way that guarantees
+ * backwards-compatibility for struct syscall arguments (as long as future
+ * struct extensions are made such that all new fields are *appended* to the
+ * old struct, and zeroed-out new fields have the same meaning as the old
+ * struct).
+ *
+ * @ksize is just sizeof(*dst), and @usize should've been passed by user space.
+ * The recommended usage is something like the following:
+ *
+ *   SYSCALL_DEFINE2(foobar, const struct foo __user *, uarg, size_t, usize)
+ *   {
+ *      int err;
+ *      struct foo karg = {};
+ *
+ *      err = copy_struct_from_user(&karg, sizeof(karg), uarg, size);
+ *      if (err)
+ *        return err;
+ *
+ *      // ...
+ *   }
+ *
+ * There are three cases to consider:
+ *  * If @usize == @ksize, then it's copied verbatim.
+ *  * If @usize < @ksize, then the user space has passed an old struct to a
+ *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @usize)
+ *    are to be zero-filled.
+ *  * If @usize > @ksize, then the user space has passed a new struct to an
+ *    older kernel. The trailing bytes unknown to the kernel (@usize - @ksize)
+ *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
+ *
+ * Returns (in all cases, some data may have been copied):
+ *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes in @src.
+ *  * -E2BIG:  @usize is "too big" (at time of writing, >PAGE_SIZE).
+ *  * -EFAULT: access to user space failed.
+ */
+int copy_struct_from_user(void *dst, size_t ksize,
+			  const void __user *src, size_t usize)
+{
+	size_t size = min(ksize, usize);
+	size_t rest = abs(ksize - usize);
+
+	if (unlikely(usize > PAGE_SIZE))
+		return -EFAULT;
+	if (unlikely(!access_ok(src, usize)))
+		return -EFAULT;
+
+	/* Deal with trailing bytes. */
+	if (usize < ksize)
+		memset(dst + size, 0, rest);
+	else if (usize > ksize) {
+		const void __user *addr = src + size;
+		char buffer[BUFFER_SIZE] = {};
+
+		while (rest > 0) {
+			size_t bufsize = min(rest, sizeof(buffer));
+
+			if (__copy_from_user(buffer, addr, bufsize))
+				return -EFAULT;
+			if (memchr_inv(buffer, 0, bufsize))
+				return -E2BIG;
+
+			addr += bufsize;
+			rest -= bufsize;
+		}
+	}
+	/* Copy the interoperable parts of the struct. */
+	if (__copy_from_user(dst, src, size))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL(copy_struct_from_user);
-- 
2.23.0

