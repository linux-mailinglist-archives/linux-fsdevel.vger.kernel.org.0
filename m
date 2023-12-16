Return-Path: <linux-fsdevel+bounces-6271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710E8156E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5DF1F25AB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CEB1CFB4;
	Sat, 16 Dec 2023 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9xGdVnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327E182D2
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOn/Y15NsNzqgslo/DGUA4vnnDcPK/hObV7tmn0+yB0=;
	b=t9xGdVnfoMSLTM9Td4x0n7yOYowwiWYquuWGItTI09FEmyYaq1F5zDGKbE6Z68kquCcZ4v
	QzWKPsB1k1p716MbbYUSL3g+gxUets/iissMmxK50hFXtT7+43ywuaUk/ZRITZoXnE5n/A
	qzJSrRGwWvwDYzhsS7l0YJyP71QnUks=
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
Subject: [PATCH 27/50] timerqueue: Split out timerqueue_types.h
Date: Fri, 15 Dec 2023 22:29:33 -0500
Message-ID: <20231216032957.3553313-6-kent.overstreet@linux.dev>
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

Trimming down sched.h dependencies: timerqueue_types can include just
rbtree_types.h instead of pulling in rbtree.h.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/hrtimer_types.h      |  2 +-
 include/linux/posix-timers_types.h |  2 +-
 include/linux/timerqueue.h         | 13 +------------
 include/linux/timerqueue_types.h   | 17 +++++++++++++++++
 4 files changed, 20 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/timerqueue_types.h

diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index f4ef391b96a7..ad66a3081735 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -3,7 +3,7 @@
 #define _LINUX_HRTIMER_TYPES_H
 
 #include <linux/types.h>
-#include <linux/timerqueue.h>
+#include <linux/timerqueue_types.h>
 
 struct hrtimer_clock_base;
 
diff --git a/include/linux/posix-timers_types.h b/include/linux/posix-timers_types.h
index 57fec639a9bb..2b1f30ee2db0 100644
--- a/include/linux/posix-timers_types.h
+++ b/include/linux/posix-timers_types.h
@@ -3,7 +3,7 @@
 #define _linux_POSIX_TIMERS_TYPES_H
 
 #include <linux/mutex_types.h>
-#include <linux/timerqueue.h>
+#include <linux/timerqueue_types.h>
 #include <linux/types.h>
 
 /*
diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index adc80e29168e..62973f7d4610 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -3,18 +3,7 @@
 #define _LINUX_TIMERQUEUE_H
 
 #include <linux/rbtree.h>
-#include <linux/ktime.h>
-
-
-struct timerqueue_node {
-	struct rb_node node;
-	ktime_t expires;
-};
-
-struct timerqueue_head {
-	struct rb_root_cached rb_root;
-};
-
+#include <linux/timerqueue_types.h>
 
 extern bool timerqueue_add(struct timerqueue_head *head,
 			   struct timerqueue_node *node);
diff --git a/include/linux/timerqueue_types.h b/include/linux/timerqueue_types.h
new file mode 100644
index 000000000000..dc298d0923e3
--- /dev/null
+++ b/include/linux/timerqueue_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIMERQUEUE_TYPES_H
+#define _LINUX_TIMERQUEUE_TYPES_H
+
+#include <linux/rbtree_types.h>
+#include <linux/types.h>
+
+struct timerqueue_node {
+	struct rb_node node;
+	ktime_t expires;
+};
+
+struct timerqueue_head {
+	struct rb_root_cached rb_root;
+};
+
+#endif /* _LINUX_TIMERQUEUE_TYPES_H */
-- 
2.43.0


