Return-Path: <linux-fsdevel+bounces-6283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F8D8156FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7782C1F25DD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C8C3FB1D;
	Sat, 16 Dec 2023 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u7h8j6yR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9573D0BD
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdKy4c2nBK8OI3SHb8BxNCiiiUgr6tnoyAXaAjNUd7o=;
	b=u7h8j6yRy4W3KIP0uUc0t9IivyFOUHLizykuz/OutUHsq99rFa/O5tgPuwzqjJ0+TOXqYm
	dQl0x6e3yNEReAm6QbwM8WlNoe7FRV9uF4cu1Y3Pm4w1i7cWnQklA1javWWAGXQ2qehTNx
	EoDMjTpIhLYMCnn98EkX9mPxW7DV4Cs=
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
Subject: [PATCH 39/50] refcount: Split out refcount_types.h
Date: Fri, 15 Dec 2023 22:32:45 -0500
Message-ID: <20231216033300.3553457-7-kent.overstreet@linux.dev>
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

More trimming of sched.h dependencies.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/refcount.h       | 13 +------------
 include/linux/refcount_types.h | 19 +++++++++++++++++++
 include/linux/sched.h          |  2 +-
 3 files changed, 21 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/refcount_types.h

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index a62fcca97486..85c6df0d1bef 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -96,22 +96,11 @@
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/limits.h>
+#include <linux/refcount_types.h>
 #include <linux/spinlock_types.h>
 
 struct mutex;
 
-/**
- * typedef refcount_t - variant of atomic_t specialized for reference counts
- * @refs: atomic_t counter field
- *
- * The counter saturates at REFCOUNT_SATURATED and will not move once
- * there. This avoids wrapping the counter and causing 'spurious'
- * use-after-free bugs.
- */
-typedef struct refcount_struct {
-	atomic_t refs;
-} refcount_t;
-
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
 #define REFCOUNT_MAX		INT_MAX
 #define REFCOUNT_SATURATED	(INT_MIN / 2)
diff --git a/include/linux/refcount_types.h b/include/linux/refcount_types.h
new file mode 100644
index 000000000000..162004f06edf
--- /dev/null
+++ b/include/linux/refcount_types.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_REFCOUNT_TYPES_H
+#define _LINUX_REFCOUNT_TYPES_H
+
+#include <linux/types.h>
+
+/**
+ * typedef refcount_t - variant of atomic_t specialized for reference counts
+ * @refs: atomic_t counter field
+ *
+ * The counter saturates at REFCOUNT_SATURATED and will not move once
+ * there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free bugs.
+ */
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+#endif /* _LINUX_REFCOUNT_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index fea6d913e004..f52977af1511 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -22,7 +22,7 @@
 #include <linux/seccomp.h>
 #include <linux/nodemask_types.h>
 #include <linux/rcupdate.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/resource.h>
 #include <linux/latencytop.h>
 #include <linux/sched/prio.h>
-- 
2.43.0


