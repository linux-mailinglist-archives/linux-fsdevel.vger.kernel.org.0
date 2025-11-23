Return-Path: <linux-fsdevel+bounces-69523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1EC7E39C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 716CE4E1B2B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DA221FBA;
	Sun, 23 Nov 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzYHEBrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D822B5A5
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915616; cv=none; b=S8bSSMpR2QvDw7NVWumQd1u9wht0TuqPV3nxFOwmJl+mnyLLVjsPp11X0bWoEAsYel90i0ewnenfnrrOMSGmLgIQvL/z2pMhWh8tXhruDDs+YRQQUHh8n4/FZDHsVKNV81ID1bnrAr0fKKq32We9NEdKbW6UQowEOlxDiLjHseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915616; c=relaxed/simple;
	bh=eVf6m4OXw6XcUK5nObR+xw5g+qi7tad2aiN/2ZONolc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXmxyK4f1jVtnpwTi9GmjTvfvsjP9P+q+L7e2jpda3cN0HH0Jdh40oZ8saZvEMkvFNeOux9mbMMR1FAUgVbtjllQsfSiAapyC8ym24FMlP30LxMJ55oo2D5qwqiIlt+BxlwjHqbhAxSAzUYeDiaHOSzQGVIzgqfdXXSH98e64RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzYHEBrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975D3C19421;
	Sun, 23 Nov 2025 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915616;
	bh=eVf6m4OXw6XcUK5nObR+xw5g+qi7tad2aiN/2ZONolc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KzYHEBrO+ClKV9cERpuYPCMP8f7LWX5csy391yz36fIGYpuXDZhu+6nPr/9C6cle2
	 TZDK0dItdOkvEGXOeXeM5NdsWy647hFjFmzVGBtHzrUkip7du8fNwuVpvNDxJnlX5/
	 YfpVp4xKp0dsGEp3DEDpgNS7MhZeIWF+htCzBSq7c60aRlid3rLouvzedFzckuE2nk
	 vOKEjyr6PPsLumz1TsOpKfc+ju4pNYrJ1RMGZOCkS1cKUiSXszSJC28HJagMdwpIZL
	 oWk5Cfhuc5jL7ULXpT65MLz8MbjvRwvRPBzimlBxDYWutzZ3mTCpDiJKPQlyUTdQgj
	 ngZeCl+LIXXWA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:19 +0100
Subject: [PATCH v4 01/47] file: add FD_{ADD,PREPARE}()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-1-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7319; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eVf6m4OXw6XcUK5nObR+xw5g+qi7tad2aiN/2ZONolc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0f4Ce7Vll2vOJtnNkv35baDdddVDmxdH8x9ICU3Y
 oUZh2RNRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESUvjEytDJdO2beffLKXstP
 M76peSxbnhZ8Zem+3zPu5iY8/7vjQTEjw7S0gGsO9z5EOyQv2b/9jTi7jUeBTM26iRvk01dlyOh
 PZAUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I've been playing with this to allow for moderately flexible usage of
the get_unused_fd_flags() + create file + fd_install() pattern that's
used quite extensively.

How callers allocate files is really heterogenous so it's not really
convenient to fold them into a single class. It's possibe to split them
into subclasses like for anon inodes. I think that's not necessarily
nice as well.

My take is to add two primites:
(1) FD_ADD() the simple cases a file is installed:

    fd = FD_ADD(O_CLOEXEC, open_file(some, args)));
    if (fd >= 0)
            kvm_get_kvm(vcpu->kvm);
    return fd;

(2) FD_PREPARE() that captures all the cases where access to fd or file
    or additional work before publishing the fd is needed:

    FD_PREPARE(fdf, open_flag, file_open_handle(&path, open_flag));
    if (fdf.err)
            return fdf.err;

    if (copy_to_user(/* something something */))
            return -EFAULT;

    return fd_publish(fdf);

I've converted all of the easy cases over to it and it gets rid of an
aweful lot of convoluted cleanup logic.

It's centered around struct fd_prepare. FD_PREPARE() encapsulates all of
allocation and cleanup logic and must be followed by a call to
fd_publish() which associates the fd with the file and installs it into
the callers fdtable. If fd_publish() isn't called both are deallocated.

It mandates a specific order namely that first we allocate the fd and
then instantiate the file. But that shouldn't be a problem nearly
everyone I've converted uses this exact pattern anyway.

There's a bunch of additional cases where it would be easy to convert
them to this pattern. For example, the whole sync file stuff in dma
currently retains the containing structure of the file instead of the
file itself even though it's only used to allocate files. Changing that
would make it fall into the FD_PREPARE() pattern easily. I've not done
that work yet.

There's room for extending this in a way that wed'd have subclasses for
some particularly often use patterns but as I said I'm not even sure
that's worth it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cleanup.h |  7 ++++
 include/linux/file.h    | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 19c7e475d3a4..b8bd2f15f91f 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -261,6 +261,10 @@ const volatile void * __must_check_fn(const volatile void *val)
  * CLASS(name, var)(args...):
  *	declare the variable @var as an instance of the named class
  *
+ * CLASS_INIT(name, var, init_expr):
+ *	declare the variable @var as an instance of the named class with
+ *	custom initialization expression.
+ *
  * Ex.
  *
  * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
@@ -290,6 +294,9 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
 		class_##_name##_constructor
 
+#define CLASS_INIT(_name, _var, _init_expr)                             \
+        class_##_name##_t _var __cleanup(class_##_name##_destructor) = (_init_expr)
+
 #define __scoped_class(_name, var, _label, args...)        \
 	for (CLASS(_name, var)(args); ; ({ goto _label; })) \
 		if (0) {                                   \
diff --git a/include/linux/file.h b/include/linux/file.h
index af1768d934a0..2f1853612b56 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -127,4 +127,95 @@ extern void __fput_sync(struct file *);
 
 extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 
+/*
+ * class_fd_prepare_t: Combined fd + file allocation cleanup class.
+ *
+ * Allocates an fd and a file together. On error paths, automatically cleans
+ * up whichever resource was successfully allocated. Allows flexible file
+ * allocation with different functions per usage.
+ */
+typedef struct {
+	s32 err;
+	s32 __fd;
+	struct file *__file;
+} class_fd_prepare_t;
+
+#define fd_prepare_fd(_T) ((_T).__fd)
+#define fd_prepare_file(_T) ((_T).__file)
+
+static inline void class_fd_prepare_destructor(class_fd_prepare_t *_T)
+{
+	if (unlikely(_T->err)) {
+		if (likely(_T->__fd >= 0))
+			put_unused_fd(_T->__fd);
+		if (unlikely(!IS_ERR_OR_NULL(_T->__file)))
+			fput(_T->__file);
+	}
+}
+
+static inline int class_fd_prepare_lock_err(class_fd_prepare_t *_T)
+{
+	if (unlikely(_T->__fd < 0))
+		return _T->__fd;
+	if (unlikely(IS_ERR(_T->__file)))
+		return PTR_ERR(_T->__file);
+	if (unlikely(!_T->__file))
+		return -ENOMEM;
+	return 0;
+}
+
+/*
+ * __FD_PREPARE_INIT(fd_flags, file_init_expr):
+ *     Helper to initialize fd_prepare class.
+ * @fd_flags: flags for get_unused_fd_flags()
+ * @file_init_expr: expression that returns struct file *
+ *
+ * Returns a struct fd_prepare with fd, file, and err set.
+ * If fd allocation fails, fd will be negative and err will be set.
+ * If fd succeeds but file_init_expr fails, file will be ERR_PTR and err will be set.
+ * The err field is the single source of truth for error checking.
+ */
+#define __FD_PREPARE_INIT(_fd_flags, _file_init_owned)                   \
+	({                                                               \
+		class_fd_prepare_t _fd_prepare = {                       \
+			.__fd = get_unused_fd_flags((_fd_flags)),        \
+		};                                                       \
+		if (likely(_fd_prepare.__fd >= 0))                       \
+			_fd_prepare.__file = (_file_init_owned);         \
+		_fd_prepare.err = ACQUIRE_ERR(fd_prepare, &_fd_prepare); \
+		_fd_prepare;                                             \
+	})
+
+/*
+ * FD_PREPARE(var, fd_flags, file_init_owned):
+ *     Declares and initializes an fd_prepare variable with automatic cleanup.
+ *     No separate scope required - cleanup happens when variable goes out of scope.
+ *
+ * @_var: name of struct fd_prepare variable to define
+ * @_fd_flags: flags for get_unused_fd_flags()
+ * @_file_init_owned: struct file to take ownership of (can be expression)
+ */
+#define FD_PREPARE(_var, _fd_flags, _file_init_owned) \
+	CLASS_INIT(fd_prepare, _var, __FD_PREPARE_INIT(_fd_flags, _file_init_owned))
+
+#define fd_publish(_fd_prepare)                                \
+	({                                                     \
+		class_fd_prepare_t *__p = &(_fd_prepare);      \
+		VFS_WARN_ON_ONCE(__p->err);                    \
+		VFS_WARN_ON_ONCE(__p->__fd < 0);               \
+		VFS_WARN_ON_ONCE(IS_ERR_OR_NULL(__p->__file)); \
+		fd_install(__p->__fd, __p->__file);            \
+		retain_and_null_ptr(__p->__file);              \
+		take_fd(__p->__fd);                            \
+	})
+
+#define FD_ADD(_fd_flags, _file_init_owned)                    \
+	({                                                     \
+		FD_PREPARE(_var, _fd_flags, _file_init_owned); \
+		s32 ret = _var.err;                            \
+		if (likely(!ret))                              \
+			ret = fd_publish(_var);                \
+		ret;                                           \
+	})
+
 #endif /* __LINUX_FILE_H */

-- 
2.47.3


