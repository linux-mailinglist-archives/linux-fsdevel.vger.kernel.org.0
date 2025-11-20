Return-Path: <linux-fsdevel+bounces-69280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA500C76804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B67034593C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79B2FB09A;
	Thu, 20 Nov 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHvZjj11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063702AF1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677940; cv=none; b=GAxpUez9hUlO4xkTY84RbDqdHxOp87MW4Vgwt8ftVRyTwVDqVwTKSOeieRvZ57shnkB1CeUmITABiOO4RebZkxSEjKCwz8Ax6p+f1E1y2DkqbFYM4x4p0syYXkFkO2jlsKsHBCOobdJEsSDLeQhzBnhhqCWeE52hdYsspvSwDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677940; c=relaxed/simple;
	bh=0DEOAptiw63V5v8PJPs+HScNihC1bR04FaukoalpbGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAuks5MhAhdmPfhmkAJ/2ul85mtluqJe5vBmrl1J3Pyn2zGf2YFexKNaJz/d44Q2anBBh55P1DRXLlKiGfGiexBXiDIHl9L7TThN1+ZFYctmox40e6nOVddEMPJlRZ+QoJxY3Ebj3+YGfVlr4LNrcdRSjsxX9vIEXGCdiNEWeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHvZjj11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4A9C116C6;
	Thu, 20 Nov 2025 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677939;
	bh=0DEOAptiw63V5v8PJPs+HScNihC1bR04FaukoalpbGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SHvZjj11RxaXHb25v9RBsd384GJnGgwBFlM0x/e4SesdHffP8Gc2jyOvTkPNExFF1
	 9L2AZg4Kdn+FIkW96A5ApSEElaNJRnUgNgEQCrVcwHfG7eALKdVYpk5MzQbLhGu+3p
	 cYgfbdStYIiFrM4U0ON5xa1M1IcGGOoV46U9muJsQ/sbXDZW7xiqZdR6gB4cuT6Qxf
	 XJhDJqwt9EmNDD6voPLkPx3OZN40l1pzJWjWH/4CtSkTMJc7Dg0X8gq8O48GT10/Uv
	 azalGnSrr9hFGRog4fklYi5LJx+NO0fpnHCJ65gptNBf2wE6LP4Cg32Wgzs0aik/26
	 ys1n3dv2a1auA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:31:58 +0100
Subject: [PATCH RFC v2 01/48] file: add FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-1-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8547; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0DEOAptiw63V5v8PJPs+HScNihC1bR04FaukoalpbGs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vzv31veEANg5HeSk3Gv53x/f2tImG3XircYvm3c
 usiHv2VHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5dZKRYbFBYk9C9Hx9q3yP
 VUrXAvvry3dEa/edaXDe4PSi9/KPE4wMD+30yypau2w/BGe8+vRydajL1ez4/pYPpss2PtQQLXj
 GAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cleanup.h |  32 +++++++++++
 include/linux/file.h    | 141 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 19c7e475d3a4..4b5b41bafd47 100644
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
 
+#define CLASS_INIT(_name, _var, _init_expr)                             \
+        class_##_name##_t _var __cleanup(class_##_name##_destructor) = (_init_expr)
+
 #define __scoped_class(_name, var, _label, args...)        \
 	for (CLASS(_name, var)(args); ; ({ goto _label; })) \
 		if (0) {                                   \
@@ -297,9 +319,19 @@ _label:                                                    \
 			break;                             \
 		} else
 
+#define __scoped_class_init(_name, var, _init_expr, _label)                \
+	for (CLASS_INIT(_name, var, _init_expr); ; ({ goto _label; })) \
+		if (0) {                                                    \
+_label:                                                                     \
+			break;                                              \
+		} else
+
 #define scoped_class(_name, var, args...) \
 	__scoped_class(_name, var, __UNIQUE_ID(label), args)
 
+#define scoped_class_init(_name, var, _init_expr) \
+	__scoped_class_init(_name, var, _init_expr, __UNIQUE_ID(label))
+
 /*
  * DEFINE_GUARD(name, type, lock, unlock):
  *	trivial wrapper around DEFINE_CLASS() above specifically
diff --git a/include/linux/file.h b/include/linux/file.h
index af1768d934a0..67dbc6b704f7 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/cleanup.h>
 #include <linux/err.h>
+#include <linux/vfsdebug.h>
 
 struct file;
 
@@ -127,4 +128,144 @@ extern void __fput_sync(struct file *);
 
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
+	struct file *file;
+	int fd;
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
+static __always_inline void __fd_prepare_put(struct fd_prepare fdp)
+{
+	if (unlikely(fdp.fd >= 0))
+		put_unused_fd(fdp.fd);
+	if (unlikely(!IS_ERR_OR_NULL(fdp.file)))
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
+#define __FD_PREPARE_INIT(_fd_flags, _file_init_owned)          \
+	({                                                      \
+		struct fd_prepare _fd_prepare = {               \
+			.fd = get_unused_fd_flags((_fd_flags)), \
+		};                                              \
+		if (likely(_fd_prepare.fd >= 0))                \
+			_fd_prepare.file = (_file_init_owned);  \
+		_fd_prepare;                                    \
+	})
+
+/*
+ * FD_PREPARE(var, fd_flags, file_init_owned):
+ *     Convenience wrapper for CLASS_INIT(fd_prepare, ...).
+ *
+ * @_var: name of struct fd_prepare variable to define
+ * @_fd_flags: flags for get_unused_fd_flags()
+ * @_file_init_owned: struct file to take ownership of (can be expression)
+ *
+ * Ex.
+ * FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+ *                  anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep, O_RDWR));
+ * if (fd_prepare_failed(fdf))
+ *     return fd_prepare_error(fdf);
+ *
+ * ep->file = fd_prepare_file(fdf);
+ * return fd_publish(fdf);
+ *
+ * Or with different file init function:
+ *
+ * FD_PREPARE(fdf, flags,
+ *                  anon_inode_getfile_fmode("[eventfd]", &eventfd_fops, ctx, flags, FMODE_NOWAIT));
+ * if (fd_prepare_failed(fdf))
+ *     return fd_prepare_error(fdf);
+ *
+ * return fd_publish(fdf);
+ */
+#define FD_PREPARE(_var, _fd_flags, _file_init_owned) \
+	scoped_class_init(fd_prepare, _var, __FD_PREPARE_INIT(_fd_flags, _file_init_owned))
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


