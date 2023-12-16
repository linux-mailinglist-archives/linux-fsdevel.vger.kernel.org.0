Return-Path: <linux-fsdevel+bounces-6262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC858156CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8AF286526
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3E1B27A;
	Sat, 16 Dec 2023 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sCzIMwM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4918EA4
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYpe5VKbI0uY+woOivYCAFG3kwewGieeeX3lG0j4fOU=;
	b=sCzIMwM2LXm7dg4joaoWyKEZ+f7mK4v8IWa0/1tqUO/odZhVKSP3iFUBWcXkcCzggkUcBA
	MgclZ5q0jgBG54q6SkQPGNkYuON4IZiYlXXHtFVEI8uH8v4wBfBNj7/uLqETu4JfhGOAl3
	InhjvBSHWLsOm8Ju67WXZv0nZ3OLl5E=
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
Subject: [PATCH 18/50] hrtimers: Split out hrtimer_types.h
Date: Fri, 15 Dec 2023 22:26:17 -0500
Message-ID: <20231216032651.3553101-8-kent.overstreet@linux.dev>
In-Reply-To: <20231216032651.3553101-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We need to reduce the scope of what's included in sched.h: task_struct
includes a hrtimer, so split out the core types into their own header.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h       | 44 ++----------------------------
 include/linux/hrtimer_types.h | 50 +++++++++++++++++++++++++++++++++++
 include/linux/sched.h         |  2 +-
 3 files changed, 53 insertions(+), 43 deletions(-)
 create mode 100644 include/linux/hrtimer_types.h

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 02d264ca9dce..87e3bedf8eb0 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -13,13 +13,13 @@
 #define _LINUX_HRTIMER_H
 
 #include <linux/hrtimer_defs.h>
-#include <linux/rbtree.h>
+#include <linux/hrtimer_types.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/percpu-defs.h>
+#include <linux/rbtree.h>
 #include <linux/seqlock.h>
 #include <linux/timer.h>
-#include <linux/timerqueue.h>
 
 struct hrtimer_clock_base;
 struct hrtimer_cpu_base;
@@ -59,14 +59,6 @@ enum hrtimer_mode {
 	HRTIMER_MODE_REL_PINNED_HARD = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_HARD,
 };
 
-/*
- * Return values for the callback function
- */
-enum hrtimer_restart {
-	HRTIMER_NORESTART,	/* Timer is not restarted */
-	HRTIMER_RESTART,	/* Timer must be restarted */
-};
-
 /*
  * Values to track state of the timer
  *
@@ -94,38 +86,6 @@ enum hrtimer_restart {
 #define HRTIMER_STATE_INACTIVE	0x00
 #define HRTIMER_STATE_ENQUEUED	0x01
 
-/**
- * struct hrtimer - the basic hrtimer structure
- * @node:	timerqueue node, which also manages node.expires,
- *		the absolute expiry time in the hrtimers internal
- *		representation. The time is related to the clock on
- *		which the timer is based. Is setup by adding
- *		slack to the _softexpires value. For non range timers
- *		identical to _softexpires.
- * @_softexpires: the absolute earliest expiry time of the hrtimer.
- *		The time which was given as expiry time when the timer
- *		was armed.
- * @function:	timer expiry callback function
- * @base:	pointer to the timer base (per cpu and per clock)
- * @state:	state information (See bit values above)
- * @is_rel:	Set if the timer was armed relative
- * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
- * @is_hard:	Set if hrtimer will be expired in hard interrupt context
- *		even on RT.
- *
- * The hrtimer structure must be initialized by hrtimer_init()
- */
-struct hrtimer {
-	struct timerqueue_node		node;
-	ktime_t				_softexpires;
-	enum hrtimer_restart		(*function)(struct hrtimer *);
-	struct hrtimer_clock_base	*base;
-	u8				state;
-	u8				is_rel;
-	u8				is_soft;
-	u8				is_hard;
-};
-
 /**
  * struct hrtimer_sleeper - simple sleeper structure
  * @timer:	embedded timer structure
diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
new file mode 100644
index 000000000000..f4ef391b96a7
--- /dev/null
+++ b/include/linux/hrtimer_types.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HRTIMER_TYPES_H
+#define _LINUX_HRTIMER_TYPES_H
+
+#include <linux/types.h>
+#include <linux/timerqueue.h>
+
+struct hrtimer_clock_base;
+
+/*
+ * Return values for the callback function
+ */
+enum hrtimer_restart {
+	HRTIMER_NORESTART,	/* Timer is not restarted */
+	HRTIMER_RESTART,	/* Timer must be restarted */
+};
+
+/**
+ * struct hrtimer - the basic hrtimer structure
+ * @node:	timerqueue node, which also manages node.expires,
+ *		the absolute expiry time in the hrtimers internal
+ *		representation. The time is related to the clock on
+ *		which the timer is based. Is setup by adding
+ *		slack to the _softexpires value. For non range timers
+ *		identical to _softexpires.
+ * @_softexpires: the absolute earliest expiry time of the hrtimer.
+ *		The time which was given as expiry time when the timer
+ *		was armed.
+ * @function:	timer expiry callback function
+ * @base:	pointer to the timer base (per cpu and per clock)
+ * @state:	state information (See bit values above)
+ * @is_rel:	Set if the timer was armed relative
+ * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
+ * @is_hard:	Set if hrtimer will be expired in hard interrupt context
+ *		even on RT.
+ *
+ * The hrtimer structure must be initialized by hrtimer_init()
+ */
+struct hrtimer {
+	struct timerqueue_node		node;
+	ktime_t				_softexpires;
+	enum hrtimer_restart		(*function)(struct hrtimer *);
+	struct hrtimer_clock_base	*base;
+	u8				state;
+	u8				is_rel;
+	u8				is_soft;
+	u8				is_hard;
+};
+
+#endif /* _LINUX_HRTIMER_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7501a3451a20..3762809652da 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -17,7 +17,7 @@
 #include <linux/kmsan_types.h>
 #include <linux/mutex.h>
 #include <linux/plist.h>
-#include <linux/hrtimer.h>
+#include <linux/hrtimer_types.h>
 #include <linux/irqflags.h>
 #include <linux/seccomp.h>
 #include <linux/nodemask_types.h>
-- 
2.43.0


