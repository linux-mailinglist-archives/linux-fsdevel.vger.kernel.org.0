Return-Path: <linux-fsdevel+bounces-6284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D98156FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0734287C0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B2940BF3;
	Sat, 16 Dec 2023 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1Je6O36"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628513FB08
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H50Z0kSGEyOHKjuvYlMoEObUuyeC38rfMHKwdLte1so=;
	b=M1Je6O36HQ5QIRvQAOQK7U/+LJOUwJxBcAvzS6QVZPFcMei3FP6V+VPGxf8RwjVwCutDXX
	LVnGA70HtCaiYKQUqI/J0w8za7YRSUh+eDptL1nlrCSTYkqJsJtd06zS/La04hgbvk79VN
	xmFlGBLX1P/18IRHlt+tjLYoG7a6y7M=
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
Subject: [PATCH 40/50] seccomp: Split out seccomp_types.h
Date: Fri, 15 Dec 2023 22:32:46 -0500
Message-ID: <20231216033300.3553457-8-kent.overstreet@linux.dev>
In-Reply-To: <20231216033300.3553457-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

More pruning of sched.h dependencies.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/sched.h         |  2 +-
 include/linux/seccomp.h       | 20 +-------------------
 include/linux/seccomp_types.h | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/seccomp_types.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f52977af1511..9bfa61ab2750 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -19,7 +19,7 @@
 #include <linux/mutex_types.h>
 #include <linux/plist_types.h>
 #include <linux/hrtimer_types.h>
-#include <linux/seccomp.h>
+#include <linux/seccomp_types.h>
 #include <linux/nodemask_types.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount_types.h>
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 1ec0d8dc4b69..26a53cea5761 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -19,27 +19,9 @@
 
 #include <linux/thread_info.h>
 #include <linux/atomic.h>
+#include <linux/seccomp_types.h>
 #include <asm/seccomp.h>
 
-struct seccomp_filter;
-/**
- * struct seccomp - the state of a seccomp'ed process
- *
- * @mode:  indicates one of the valid values above for controlled
- *         system calls available to a process.
- * @filter_count: number of seccomp filters
- * @filter: must always point to a valid seccomp-filter or NULL as it is
- *          accessed without locking during system call entry.
- *
- *          @filter must only be accessed from the context of current as there
- *          is no read locking.
- */
-struct seccomp {
-	int mode;
-	atomic_t filter_count;
-	struct seccomp_filter *filter;
-};
-
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 extern int __secure_computing(const struct seccomp_data *sd);
 static inline int secure_computing(void)
diff --git a/include/linux/seccomp_types.h b/include/linux/seccomp_types.h
new file mode 100644
index 000000000000..c6184582a0a0
--- /dev/null
+++ b/include/linux/seccomp_types.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SECCOMP_TYPES_H
+#define _LINUX_SECCOMP_TYPES_H
+
+#include <linux/types.h>
+
+struct seccomp_filter;
+/**
+ * struct seccomp - the state of a seccomp'ed process
+ *
+ * @mode:  indicates one of the valid values above for controlled
+ *         system calls available to a process.
+ * @filter_count: number of seccomp filters
+ * @filter: must always point to a valid seccomp-filter or NULL as it is
+ *          accessed without locking during system call entry.
+ *
+ *          @filter must only be accessed from the context of current as there
+ *          is no read locking.
+ */
+struct seccomp {
+	int mode;
+	atomic_t filter_count;
+	struct seccomp_filter *filter;
+};
+
+#endif /* _LINUX_SECCOMP_TYPES_H */
-- 
2.43.0


