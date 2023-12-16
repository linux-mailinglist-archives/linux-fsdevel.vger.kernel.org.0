Return-Path: <linux-fsdevel+bounces-6277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C58156EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967CC1F25B86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F035276;
	Sat, 16 Dec 2023 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZfbmtUM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B43526E
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTwDaJYHWx55QkXgTra2ib4UbsEOMeDcjHLbHkSEmrE=;
	b=IZfbmtUM8O5g5gu/VsP7tzGv6JlW4156s5qkNkOjD1RGbov6viUG9M9wrr/JDfWSrQ+lSq
	JiTvNyF/ll2BgTUM76067uiCK62SyFD01NwqJLq2vzu5bbKSvoZrfICrxraiEZaBSoiAz3
	eSsc1nOr8ojexcfYgaf53pjr2Mh3ALk=
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
Subject: [PATCH 33/50] Split out irqflags_types.h
Date: Fri, 15 Dec 2023 22:32:39 -0500
Message-ID: <20231216033300.3553457-1-kent.overstreet@linux.dev>
In-Reply-To: <20231216024834.3510073-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We're working on only pulling in type definitions to sched.h whenever
possible.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/irqflags.h       | 14 +-------------
 include/linux/irqflags_types.h | 22 ++++++++++++++++++++++
 include/linux/sched.h          |  2 +-
 3 files changed, 24 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/irqflags_types.h

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 2b665c32f5fe..147feebd508c 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_TRACE_IRQFLAGS_H
 #define _LINUX_TRACE_IRQFLAGS_H
 
+#include <linux/irqflags_types.h>
 #include <linux/typecheck.h>
 #include <linux/cleanup.h>
 #include <asm/irqflags.h>
@@ -34,19 +35,6 @@
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
-/* Per-task IRQ trace events information. */
-struct irqtrace_events {
-	unsigned int	irq_events;
-	unsigned long	hardirq_enable_ip;
-	unsigned long	hardirq_disable_ip;
-	unsigned int	hardirq_enable_event;
-	unsigned int	hardirq_disable_event;
-	unsigned long	softirq_disable_ip;
-	unsigned long	softirq_enable_ip;
-	unsigned int	softirq_disable_event;
-	unsigned int	softirq_enable_event;
-};
-
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
diff --git a/include/linux/irqflags_types.h b/include/linux/irqflags_types.h
new file mode 100644
index 000000000000..c13f0d915097
--- /dev/null
+++ b/include/linux/irqflags_types.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IRQFLAGS_TYPES_H
+#define _LINUX_IRQFLAGS_TYPES_H
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+
+/* Per-task IRQ trace events information. */
+struct irqtrace_events {
+	unsigned int	irq_events;
+	unsigned long	hardirq_enable_ip;
+	unsigned long	hardirq_disable_ip;
+	unsigned int	hardirq_enable_event;
+	unsigned int	hardirq_disable_event;
+	unsigned long	softirq_disable_ip;
+	unsigned long	softirq_enable_ip;
+	unsigned int	softirq_disable_event;
+	unsigned int	softirq_enable_event;
+};
+
+#endif
+
+#endif /* _LINUX_IRQFLAGS_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3a58d3d7d264..d799427f6d1b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -11,6 +11,7 @@
 
 #include <asm/current.h>
 
+#include <linux/irqflags_types.h>
 #include <linux/pid_types.h>
 #include <linux/sem.h>
 #include <linux/shm.h>
@@ -18,7 +19,6 @@
 #include <linux/mutex_types.h>
 #include <linux/plist_types.h>
 #include <linux/hrtimer_types.h>
-#include <linux/irqflags.h>
 #include <linux/seccomp.h>
 #include <linux/nodemask_types.h>
 #include <linux/rcupdate.h>
-- 
2.43.0


