Return-Path: <linux-fsdevel+bounces-6274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B6E8156E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC4E1C24948
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56C5315BF;
	Sat, 16 Dec 2023 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DIBy7Flv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB601E4BA
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3tHutfa1QYCHwlZxSH9tW2HuBfPypl6d7654MXKb2g=;
	b=DIBy7FlvM36CDQz6G9CvyRS/y6yB/RIfDL9XUiKR3uJjZeJyzz0po37EicZLkGQZfyOCk/
	RZy/4d9+FjbJjPZlHN6cLBuDNbK6LrXNJiOSa7D9LnxUMWDGdIexD4mbwZS63uAzP1Z+7V
	/MlED5Q/UU9DEmdTz8RuXczptTDFTdU=
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
Subject: [PATCH 30/50] workqueue: Split out workqueue_types.h
Date: Fri, 15 Dec 2023 22:29:36 -0500
Message-ID: <20231216032957.3553313-9-kent.overstreet@linux.dev>
In-Reply-To: <20231216032957.3553313-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

More sched.h dependency culling - this lets us kill a rhashtable-types.h
dependency on workqueue.h.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/dma-fence.h        |  1 +
 include/linux/rhashtable-types.h |  2 +-
 include/linux/timekeeping.h      |  1 +
 include/linux/workqueue.h        | 16 +---------------
 include/linux/workqueue_types.h  | 25 +++++++++++++++++++++++++
 5 files changed, 29 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/workqueue_types.h

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index b3772edca2e6..e06bad467f55 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/printk.h>
 #include <linux/rcupdate.h>
+#include <linux/timekeeping.h>
 
 struct dma_fence;
 struct dma_fence_ops;
diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 57467cbf4c5b..b6f3797277ff 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -12,7 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/compiler.h>
 #include <linux/mutex.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 struct rhash_head {
 	struct rhash_head __rcu		*next;
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fe1e467ba046..7c43e98cf211 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -4,6 +4,7 @@
 
 #include <linux/errno.h>
 #include <linux/clocksource_ids.h>
+#include <linux/ktime.h>
 
 /* Included from linux/ktime.h */
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 24b1e5070f4d..f1bb2e35301f 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -14,12 +14,7 @@
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
-
-struct workqueue_struct;
-
-struct work_struct;
-typedef void (*work_func_t)(struct work_struct *work);
-void delayed_work_timer_fn(struct timer_list *t);
+#include <linux/workqueue_types.h>
 
 /*
  * The first word is the work queue pointer and the flags rolled into
@@ -95,15 +90,6 @@ enum {
 #define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
 #define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
 
-struct work_struct {
-	atomic_long_t data;
-	struct list_head entry;
-	work_func_t func;
-#ifdef CONFIG_LOCKDEP
-	struct lockdep_map lockdep_map;
-#endif
-};
-
 #define WORK_DATA_INIT()	ATOMIC_LONG_INIT((unsigned long)WORK_STRUCT_NO_POOL)
 #define WORK_DATA_STATIC_INIT()	\
 	ATOMIC_LONG_INIT((unsigned long)(WORK_STRUCT_NO_POOL | WORK_STRUCT_STATIC))
diff --git a/include/linux/workqueue_types.h b/include/linux/workqueue_types.h
new file mode 100644
index 000000000000..4c38824f3ab4
--- /dev/null
+++ b/include/linux/workqueue_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_WORKQUEUE_TYPES_H
+#define _LINUX_WORKQUEUE_TYPES_H
+
+#include <linux/atomic.h>
+#include <linux/lockdep_types.h>
+#include <linux/timer_types.h>
+#include <linux/types.h>
+
+struct workqueue_struct;
+
+struct work_struct;
+typedef void (*work_func_t)(struct work_struct *work);
+void delayed_work_timer_fn(struct timer_list *t);
+
+struct work_struct {
+	atomic_long_t data;
+	struct list_head entry;
+	work_func_t func;
+#ifdef CONFIG_LOCKDEP
+	struct lockdep_map lockdep_map;
+#endif
+};
+
+#endif /* _LINUX_WORKQUEUE_TYPES_H */
-- 
2.43.0


