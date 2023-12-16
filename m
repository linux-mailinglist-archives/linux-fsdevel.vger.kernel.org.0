Return-Path: <linux-fsdevel+bounces-6268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B28156DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3487A281977
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826C13FF3;
	Sat, 16 Dec 2023 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ia9m6uyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CB1119E
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=perIwL4jXB4r21Fv4KTrzGxY/6sHRKJXYGHhpp/B6G0=;
	b=ia9m6uyy5c8z4Ps150HZ3r7QU3i5xp5t9Ok4TTJbZ+ggRwRD8HP7dF+F8VTCxLqCfTsKpY
	iB6B2Xd6p3pxJa5tx18NHaq/cxURtJYyBDh1mnVsGaRDZ9zxBSuE/hBGIyzC0w5eEoaraU
	EHozuvKA9327XaEjZA+DfyBoxkWgHog=
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
Subject: [PATCH 24/50] plist: Split out plist_types.h
Date: Fri, 15 Dec 2023 22:29:30 -0500
Message-ID: <20231216032957.3553313-3-kent.overstreet@linux.dev>
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

Trimming down sched.h dependencies: we don't want to include more than
the base types.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/plist.h       | 12 +-----------
 include/linux/plist_types.h | 17 +++++++++++++++++
 include/linux/sched.h       |  2 +-
 init/init_task.c            |  1 +
 kernel/futex/core.c         |  1 +
 kernel/futex/requeue.c      |  1 +
 kernel/futex/waitwake.c     |  1 +
 mm/swapfile.c               |  1 +
 8 files changed, 24 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/plist_types.h

diff --git a/include/linux/plist.h b/include/linux/plist.h
index 0f352c1d3c80..8c1c8adf7fe9 100644
--- a/include/linux/plist.h
+++ b/include/linux/plist.h
@@ -75,20 +75,10 @@
 
 #include <linux/container_of.h>
 #include <linux/list.h>
-#include <linux/types.h>
+#include <linux/plist_types.h>
 
 #include <asm/bug.h>
 
-struct plist_head {
-	struct list_head node_list;
-};
-
-struct plist_node {
-	int			prio;
-	struct list_head	prio_list;
-	struct list_head	node_list;
-};
-
 /**
  * PLIST_HEAD_INIT - static struct plist_head initializer
  * @head:	struct plist_head variable name
diff --git a/include/linux/plist_types.h b/include/linux/plist_types.h
new file mode 100644
index 000000000000..c37e784330af
--- /dev/null
+++ b/include/linux/plist_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_PLIST_TYPES_H
+#define _LINUX_PLIST_TYPES_H
+
+#include <linux/types.h>
+
+struct plist_head {
+	struct list_head node_list;
+};
+
+struct plist_node {
+	int			prio;
+	struct list_head	prio_list;
+	struct list_head	node_list;
+};
+
+#endif /* _LINUX_PLIST_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9e2708c2cfa6..8c230f24688b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -16,7 +16,7 @@
 #include <linux/shm.h>
 #include <linux/kmsan_types.h>
 #include <linux/mutex_types.h>
-#include <linux/plist.h>
+#include <linux/plist_types.h>
 #include <linux/hrtimer_types.h>
 #include <linux/irqflags.h>
 #include <linux/seccomp.h>
diff --git a/init/init_task.c b/init/init_task.c
index 5727d42149c3..56220898a256 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -12,6 +12,7 @@
 #include <linux/audit.h>
 #include <linux/numa.h>
 #include <linux/scs.h>
+#include <linux/plist.h>
 
 #include <linux/uaccess.h>
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index dad981a865b8..e0e853412c15 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -34,6 +34,7 @@
 #include <linux/compat.h>
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
+#include <linux/plist.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index eb21f065816b..b47bb764b352 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/plist.h>
 #include <linux/sched/signal.h>
 
 #include "futex.h"
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 61b112897a84..3a10375d9521 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/plist.h>
 #include <linux/sched/task.h>
 #include <linux/sched/signal.h>
 #include <linux/freezer.h>
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4bc70f459164..25019af07181 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,6 +42,7 @@
 #include <linux/completion.h>
 #include <linux/suspend.h>
 #include <linux/zswap.h>
+#include <linux/plist.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
-- 
2.43.0


