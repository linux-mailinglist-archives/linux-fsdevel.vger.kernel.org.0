Return-Path: <linux-fsdevel+bounces-68960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7FC6A6BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7336A4EE06B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03259364EB2;
	Tue, 18 Nov 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQo3q1uz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256721FF25
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480980; cv=none; b=YpYxk9OXPJ9Rg3lVCypCyRqirRaLYH/DPtpyercr5oTky+JOIQ3iB/1qnaXpSpY9A7xc6u6/9AKiKsVIgSLssu4zf/7dv7gm/ZwCUk972t6qbPyPeKmLqaY/AqKcxVG7bOl2uDLwuEqf51ppQMYfiusmSlV/te+gQI1ilh4E8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480980; c=relaxed/simple;
	bh=6Ww0oKNJC99eL61+w1MZF9Z5cAYvlZxENuGtf6xhVoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1Mt8vct6g6kZt7UNtc6znKpUkQaOW4ad1jfS+3h27PZGPjeVhM5xt9r2Vozd/MgR6SxrJPujuQbvxR+ZfYN1zJMu4uIxP7goCHqqLgaHYvaYylX6QjsReuth3TsG4IvgmGCNCGyDT2Ms4jxAepHs0GmRG8HSgViKfOXRC1EXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQo3q1uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5758FC116D0;
	Tue, 18 Nov 2025 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480979;
	bh=6Ww0oKNJC99eL61+w1MZF9Z5cAYvlZxENuGtf6xhVoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VQo3q1uzXedbr00Q4jzmO7TFJA/2U0N5PXMimLmHBQTBwtXnrqLlqDBxy528sUhRp
	 r2dTKAY1w2OH6OWt2U6+vCelhruSGVcwKx3GRGmrJsHVQrLXBE+uA8GTaJGTVtXfpx
	 RZgncQNjyhFwi3021a4dRS+fUdm9b+8XZTbsXFgHC2rqut3nE92++rHSUPVRBz43um
	 DojWbjmU/G08XVSX11zry0iOXUtf9pqgo5QlKWsfydYv6fNjjXrXVvkcPZYvL7Ib5u
	 rgnAiOsI+p+3ZB2vTFf6O/pmfbEnKL+A3cTCRsYPAfyz2iRE9L9SdRzioC8GBA9D7R
	 nqm9RjQH3Eh7Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:41 +0100
Subject: [PATCH DRAFT RFC UNTESTED 01/18] file: add FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-1-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7427; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6Ww0oKNJC99eL61+w1MZF9Z5cAYvlZxENuGtf6xhVoU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO1reSy0v8qpY2uzyO4PL2WuLp3yIGrt6UlOs0+uO
 z+vOaCHoaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiKQEMfyUu5nB6brDIs5BV
 Zdm5r11vorXZE87VTxSWKa+M2twursnwV/rjrPPXVzeavwzgUH/xuqN175nqhA3cN+Zs2Wq40G5
 jDzsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cleanup.h |  22 ++++++++
 include/linux/file.h    | 137 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585b7f06..b35b9a1da026 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -255,12 +255,20 @@ const volatile void * __must_check_fn(const volatile void *val)
  *	@exit is an expression using '_T' -- similar to FREE above.
  *	@init is an expression in @init_args resulting in @type
  *
+ * DEFINE_CLASS_TYPE(name, type, exit):
+ *	Like DEFINE_CLASS but without a constructor. Use with CLASS_INIT()
+ *	for classes that need custom initialization expressions per usage.
+ *
  * EXTEND_CLASS(name, ext, init, init_args...):
  *	extends class @name to @name@ext with the new constructor
  *
  * CLASS(name, var)(args...):
  *	declare the variable @var as an instance of the named class
  *
+ * CLASS_INIT(name, var, init_expr):
+ *	declare the variable @var as an instance of the named class with
+ *	custom initialization expression. Use with DEFINE_CLASS_TYPE().
+ *
  * Ex.
  *
  * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
@@ -270,6 +278,12 @@ const volatile void * __must_check_fn(const volatile void *val)
  *		return -EBADF;
  *
  *	// use 'f' without concern
+ *
+ * DEFINE_CLASS_TYPE(fd_file, struct { int fd; struct file *file; }, ...)
+ *
+ *	CLASS_INIT(fd_file, ff, custom_init_expression);
+ *	if (ff.fd < 0)
+ *		return ff.fd;
  */
 
 #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
@@ -279,6 +293,11 @@ static inline void class_##_name##_destructor(_type *p)			\
 static inline _type class_##_name##_constructor(_init_args)		\
 { _type t = _init; return t; }
 
+#define DEFINE_CLASS_TYPE(_name, _type, _exit)				\
+typedef _type class_##_name##_t;					\
+static inline void class_##_name##_destructor(_type *p)		\
+{ _type _T = *p; _exit; }
+
 #define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
 typedef class_##_name##_t class_##_name##ext##_t;			\
 static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
@@ -290,6 +309,9 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
 		class_##_name##_constructor
 
+#define CLASS_INIT(_name, _var, _init_expr)				\
+	class_##_name##_t _var __cleanup(class_##_name##_destructor) = (_init_expr)
+
 #define scoped_class(_name, var, args)                          \
 	for (CLASS(_name, var)(args);                           \
 	     __guard_ptr(_name)(&var) || !__is_cond_ptr(_name); \
diff --git a/include/linux/file.h b/include/linux/file.h
index af1768d934a0..331b07f9a6fd 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/cleanup.h>
 #include <linux/err.h>
+#include <linux/vfsdebug.h>
 
 struct file;
 
@@ -127,4 +128,140 @@ extern void __fput_sync(struct file *);
 
 extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 
+/*
+ * fd_prepare class: Combined fd + file allocation with automatic cleanup.
+ *
+ * Allocates an fd and a file together. On error paths, automatically cleans
+ * up whichever resource was successfully allocated. Allows flexible file
+ * allocation with different functions per usage.
+ */
+
+struct fd_prepare {
+	int fd;
+	struct file *file;
+};
+
+/*
+ * fd_prepare_fd() - Get fd from fd_prepare structure
+ * @fd_prepare: struct fd_prepare to extract fd from
+ *
+ * Returns the file descriptor from an fd_prepare structure.
+ *
+ * Return: The file descriptor
+ */
+static inline int fd_prepare_fd(struct fd_prepare fdp)
+{
+	return fdp.fd;
+}
+
+/*
+ * fd_prepare_file() - Get file from fd_prepare structure
+ * @fd_prepare: struct fd_prepare to extract file from
+ *
+ * Returns the file pointer from an fd_prepare structure.
+ *
+ * Return: The file pointer
+ */
+static inline struct file *fd_prepare_file(struct fd_prepare fdp)
+{
+	return fdp.file;
+}
+
+/*
+ * fd_prepare_failed() - Check if fd_prepare allocation failed
+ * @fd_prepare: struct fd_prepare to check
+ *
+ * Checks whether either the fd allocation or file allocation failed.
+ *
+ * Return: true if either allocation failed, false otherwise
+ */
+static inline bool fd_prepare_failed(struct fd_prepare fdp)
+{
+	VFS_WARN_ON_ONCE(fdp.fd < 0 && IS_ERR(fdp.file));
+	return fdp.fd < 0 || IS_ERR(fdp.file);
+}
+
+/*
+ * fd_prepare_error() - Get error from failed fd_prepare
+ * @fd_prepare: struct fd_prepare to extract error from
+ *
+ * Returns the error code from the first allocation that failed.
+ * Should only be called after fd_prepare_failed() returns true.
+ *
+ * Return: Negative error code
+ */
+static inline int fd_prepare_error(struct fd_prepare fdp)
+{
+	if (fdp.fd < 0) {
+		VFS_WARN_ON_ONCE(fdp.file);
+		return fdp.fd;
+	}
+	if (!fdp.file)
+		return -ENOMEM;
+	return PTR_ERR(fdp.file);
+}
+
+static inline void __fd_prepare_put(struct fd_prepare fdp)
+{
+	if (fdp.fd >= 0)
+		put_unused_fd(fdp.fd);
+	if (!IS_ERR_OR_NULL(fdp.file))
+		fput(fdp.file);
+}
+
+DEFINE_CLASS_TYPE(fd_prepare, struct fd_prepare, __fd_prepare_put(_T))
+
+/*
+ * __FD_PREPARE_INIT(fd_flags, file_init_expr):
+ *     Helper to initialize fd_prepare class.
+ *     @fd_flags: flags for get_unused_fd_flags()
+ *     @file_init_expr: expression that returns struct file *
+ *
+ * Returns a struct fd_prepare with fd and file set.
+ * If fd allocation fails, file will be NULL.
+ * If fd succeeds but file_init_expr fails, fd will be cleaned up.
+ */
+#define __FD_PREPARE_INIT(_fd_flags, _file_init)                \
+	({                                                    \
+		struct fd_prepare _fd_prepare = {             \
+			.fd = get_unused_fd_flags(_fd_flags), \
+		};                                            \
+		if (_fd_prepare.fd >= 0)                      \
+			_fd_prepare.file = (_file_init);      \
+		_fd_prepare;                                  \
+	})
+
+/*
+ * FD_PREPARE(var, fd_flags, file_init_expr):
+ *     Convenience wrapper for CLASS_INIT(fd_prepare, ...).
+ *
+ * Ex.
+ * FD_PREPARE(ff, O_RDWR | O_CLOEXEC,
+ *                  anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep, O_RDWR));
+ * if (fd_prepare_failed(ff))
+ *     return fd_prepare_error(ff);
+ *
+ * ep->file = fd_prepare_file(ff);
+ * return fd_publish(ff);
+ *
+ * Or with different file init function:
+ *
+ * FD_PREPARE(ff, flags,
+ *                  anon_inode_getfile_fmode("[eventfd]", &eventfd_fops, ctx, flags, FMODE_NOWAIT));
+ * if (fd_prepare_failed(ff))
+ *     return fd_prepare_error(ff);
+ *
+ * return fd_publish(ff);
+ */
+#define FD_PREPARE(_var, _fd_flags, _file_init) \
+	CLASS_INIT(fd_prepare, _var, __FD_PREPARE_INIT(_fd_flags, _file_init))
+
+#define fd_publish(_fd_prepare)                          \
+	({                                               \
+		struct fd_prepare *__p = &(_fd_prepare); \
+		fd_install(__p->fd, __p->file);          \
+		retain_and_null_ptr(__p->file);          \
+		take_fd(__p->fd);                        \
+	})
+
 #endif /* __LINUX_FILE_H */

-- 
2.47.3


