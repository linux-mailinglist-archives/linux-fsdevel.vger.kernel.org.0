Return-Path: <linux-fsdevel+bounces-6291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6DE81570A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D3C1F22B55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993F8125B7;
	Sat, 16 Dec 2023 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k2LqHjje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B2D525
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vu1t9phxzTSXpH+NH5TjLwnssQckaKv/rd6AdxtJ6QU=;
	b=k2LqHjjeXyWQcZtEDT3qPwqJuVwSn31XJPGOmS7I+9BpmD0M3wsbYtMoHVlHz4TYub/KKS
	DPM8Vz6e/Sk8rDIrenfyToVzwzlhXYIAl5YUo7wyNEGYRA0OZmX/Ixpt2NvbKJDE+mxSRw
	Xhh1YWwCbg1cSQ6BMyxwdiNZZiGXZS4=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 47/50] thread_info, uaccess.h: Move HARDENED_USERCOPY to better location
Date: Fri, 15 Dec 2023 22:35:48 -0500
Message-ID: <20231216033552.3553579-4-kent.overstreet@linux.dev>
In-Reply-To: <20231216033552.3553579-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

thread_info.h is needed by sched.h, and we're trying to slim down
dependencies there - bug.h is a big one.

And the HARDENED_USERCOPY stuff is used in uaccess.h, so it makes more
sense there anyways.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/thread_info.h | 49 -------------------------------------
 include/linux/uaccess.h     | 49 +++++++++++++++++++++++++++++++++++++
 include/linux/uio.h         |  2 +-
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28068f4..85d99c556cb5 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -10,7 +10,6 @@
 
 #include <linux/types.h>
 #include <linux/limits.h>
-#include <linux/bug.h>
 #include <linux/restart_block.h>
 #include <linux/errno.h>
 
@@ -204,54 +203,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 }
 #endif
 
-#ifdef CONFIG_HARDENED_USERCOPY
-extern void __check_object_size(const void *ptr, unsigned long n,
-					bool to_user);
-
-static __always_inline void check_object_size(const void *ptr, unsigned long n,
-					      bool to_user)
-{
-	if (!__builtin_constant_p(n))
-		__check_object_size(ptr, n, to_user);
-}
-#else
-static inline void check_object_size(const void *ptr, unsigned long n,
-				     bool to_user)
-{ }
-#endif /* CONFIG_HARDENED_USERCOPY */
-
-extern void __compiletime_error("copy source size is too small")
-__bad_copy_from(void);
-extern void __compiletime_error("copy destination size is too small")
-__bad_copy_to(void);
-
-void __copy_overflow(int size, unsigned long count);
-
-static inline void copy_overflow(int size, unsigned long count)
-{
-	if (IS_ENABLED(CONFIG_BUG))
-		__copy_overflow(size, count);
-}
-
-static __always_inline __must_check bool
-check_copy_size(const void *addr, size_t bytes, bool is_source)
-{
-	int sz = __builtin_object_size(addr, 0);
-	if (unlikely(sz >= 0 && sz < bytes)) {
-		if (!__builtin_constant_p(bytes))
-			copy_overflow(sz, bytes);
-		else if (is_source)
-			__bad_copy_from();
-		else
-			__bad_copy_to();
-		return false;
-	}
-	if (WARN_ON_ONCE(bytes > INT_MAX))
-		return false;
-	check_object_size(addr, bytes, is_source);
-	return true;
-}
-
 #ifndef arch_setup_new_exec
 static inline void arch_setup_new_exec(void) { }
 #endif
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..3e93ee64d6f8 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/bug.h>
 #include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/minmax.h>
@@ -32,6 +33,54 @@
 })
 #endif
 
+#ifdef CONFIG_HARDENED_USERCOPY
+extern void __check_object_size(const void *ptr, unsigned long n,
+					bool to_user);
+
+static __always_inline void check_object_size(const void *ptr, unsigned long n,
+					      bool to_user)
+{
+	if (!__builtin_constant_p(n))
+		__check_object_size(ptr, n, to_user);
+}
+#else
+static inline void check_object_size(const void *ptr, unsigned long n,
+				     bool to_user)
+{ }
+#endif /* CONFIG_HARDENED_USERCOPY */
+
+extern void __compiletime_error("copy source size is too small")
+__bad_copy_from(void);
+extern void __compiletime_error("copy destination size is too small")
+__bad_copy_to(void);
+
+void __copy_overflow(int size, unsigned long count);
+
+static inline void copy_overflow(int size, unsigned long count)
+{
+	if (IS_ENABLED(CONFIG_BUG))
+		__copy_overflow(size, count);
+}
+
+static __always_inline __must_check bool
+check_copy_size(const void *addr, size_t bytes, bool is_source)
+{
+	int sz = __builtin_object_size(addr, 0);
+	if (unlikely(sz >= 0 && sz < bytes)) {
+		if (!__builtin_constant_p(bytes))
+			copy_overflow(sz, bytes);
+		else if (is_source)
+			__bad_copy_from();
+		else
+			__bad_copy_to();
+		return false;
+	}
+	if (WARN_ON_ONCE(bytes > INT_MAX))
+		return false;
+	check_object_size(addr, bytes, is_source);
+	return true;
+}
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
diff --git a/include/linux/uio.h b/include/linux/uio.h
index b6214cbf2a43..084262b68106 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -6,7 +6,7 @@
 #define __LINUX_UIO_H
 
 #include <linux/kernel.h>
-#include <linux/thread_info.h>
+#include <linux/uaccess.h>
 #include <linux/mm_types.h>
 #include <uapi/linux/uio.h>
 
-- 
2.43.0


