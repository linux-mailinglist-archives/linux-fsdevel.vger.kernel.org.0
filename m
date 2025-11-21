Return-Path: <linux-fsdevel+bounces-69399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B3C7B2F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FFEE3808DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3834D388;
	Fri, 21 Nov 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpK2LHeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79D2E8B76
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748054; cv=none; b=UwuNuSBi7Y0Lw5E4S5jn5hW7o+/kv/7a3W0PKrxWYWRWwSTgJXBN1kinjobxn2MXWUTVHAZ8DBXysl3p1sujnaGFIuZFyMeUvFiK3qRVUC6vfjy4BycscZENRlJ0uPps2o5vT+fhMEEM3qfg01rmgPW14ZiKHlCuwXp1o0Zgoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748054; c=relaxed/simple;
	bh=uo3J5MPdZsDnguieTF4nM5smah+M2RctAN7tIFdnFco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1Us6xzz5l/5HfLVXoNUlLREsxf+T3/Ccj3pKz28AmX+GcT/phqXfq3OFsOXfBguRRnxzxZlQ+BVPNwU0qAUs80NOppMnzF+iwzlalmic1FYl61Spt8wP3T7v1c94V5u5okcX3anHssFlKjROTB3YN0n26tkDkG0C8khaViJmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpK2LHeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58264C116D0;
	Fri, 21 Nov 2025 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748054;
	bh=uo3J5MPdZsDnguieTF4nM5smah+M2RctAN7tIFdnFco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kpK2LHeodlkzMD1m5IeuQrhPTpfg41XrPnh//h9NdIC28w4Voff9pYgHbdRYkUIft
	 LJQjQaYpUaExxxMPXGI2pDcRFk/39vyLNkqb/TA8J6cTeA63XGZzGHzNskO+ixMVJ/
	 HfYuoCfbH/u0gWRPB/dnlQCqV8cLdPp5kfwWiEy8AoPNhk+3i5x9GhcwY42GGOtJvv
	 Hgw/23Ge9BLENfZSWc1MkobsVs1/lEm3kDtiy9UA4CTyv1f/HwiM7cEUxyt+EFptUQ
	 Ep2/IjJ3+s3E0DuVL94fY0yAknlYeWrZ6McHBq8isCRFKBD4/d3BLS2YbK7AJNUbXA
	 PHatAHtwI8Ncw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:40 +0100
Subject: [PATCH RFC v3 01/47] file: add FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-1-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4456; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uo3J5MPdZsDnguieTF4nM5smah+M2RctAN7tIFdnFco=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDhvFtXNuvq1EUeKwEeHR2ukLp7gKUy3LGo/dmlZV
 usfsamXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSIc7IcL/N7WXot4KL8ruU
 z7t5F39nyUmwDBX3UgvNjrq4WFP2NMP/fMXNi8InOvCmb+NqmWJ03VSm5LH4vDsJCzNOmUvpPT7
 MAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cleanup.h |  7 +++++
 include/linux/file.h    | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

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
index af1768d934a0..ec90bbf9eb40 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -127,4 +127,79 @@ extern void __fput_sync(struct file *);
 
 extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 
+/*
+ * class_fd_prepare_t: Combined fd + file allocation cleanup class.
+ *
+ * Allocates an fd and a file together. On error paths, automatically cleans
+ * up whichever resource was successfully allocated. Allows flexible file
+ * allocation with different functions per usage.
+ */
+typedef struct {
+	int fd;
+	struct file *file;
+} class_fd_prepare_t;
+
+#define fd_prepare_fd(_T) ((_T).fd)
+#define fd_prepare_file(_T) ((_T).file)
+
+static inline void class_fd_prepare_destructor(class_fd_prepare_t *_T)
+{
+	if (unlikely(_T->fd >= 0)) {
+		put_unused_fd(_T->fd);
+		if (unlikely(!IS_ERR_OR_NULL(_T->file)))
+			fput(_T->file);
+	}
+}
+
+static inline int class_fd_prepare_lock_err(class_fd_prepare_t *_T)
+{
+	if (IS_ERR(_T->file))
+		return PTR_ERR(_T->file);
+	if (unlikely(!_T->file))
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
+ * Returns a struct fd_prepare with fd and file set.
+ * If fd allocation fails, file will be set to ERR_PTR with the error code.
+ * If fd succeeds but file_init_expr fails, file will contain the ERR_PTR.
+ * The file pointer is the single source of truth for error checking.
+ */
+#define __FD_PREPARE_INIT(_fd_flags, _file_init_owned)              \
+	({                                                          \
+		class_fd_prepare_t _fd_prepare = {                  \
+			.fd = get_unused_fd_flags((_fd_flags)),     \
+		};                                                  \
+		if (likely(_fd_prepare.fd >= 0))                    \
+			_fd_prepare.file = (_file_init_owned);      \
+		else                                                \
+			_fd_prepare.file = ERR_PTR(_fd_prepare.fd); \
+		_fd_prepare;                                        \
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
+#define fd_publish(_fd_prepare)                           \
+	({                                                \
+		class_fd_prepare_t *__p = &(_fd_prepare); \
+		fd_install(__p->fd, __p->file);           \
+		take_fd(__p->fd);                         \
+	})
+
 #endif /* __LINUX_FILE_H */

-- 
2.47.3


