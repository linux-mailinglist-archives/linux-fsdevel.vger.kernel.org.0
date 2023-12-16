Return-Path: <linux-fsdevel+bounces-6273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28E8156E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472691F25ACF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236828E04;
	Sat, 16 Dec 2023 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LIleEnZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9051DA34
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGwDe7U0LIiQOaGhDE/WHEXnlMSjy21mOvWClH81kqk=;
	b=LIleEnZFItXHaaCrcMZrYWUko8U1aO3M5XoZxWS6ixnogw7QINK4bm//irG/js1dyhubo0
	Vov1IDygO6SNz1ZusBKJlhy3t11N/2JerYK2h6CJIsocr8vT4MNihRRudwFvLRmv7utth2
	9r8TMBCnfVU2qcZPdNrWfHDLgyT/z0E=
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
Subject: [PATCH 29/50] timers: Split out timer_types.h
Date: Fri, 15 Dec 2023 22:29:35 -0500
Message-ID: <20231216032957.3553313-8-kent.overstreet@linux.dev>
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

Cutting down on sched.h dependencies: this is going to be used in
workqueue_types.h in the next patch, so we can kill the sched.h
dependency on workqueue.h.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/timer.h       | 16 +---------------
 include/linux/timer_types.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/timer_types.h

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 26a545bb0153..f18a2f1eb79e 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -7,21 +7,7 @@
 #include <linux/stddef.h>
 #include <linux/debugobjects.h>
 #include <linux/stringify.h>
-
-struct timer_list {
-	/*
-	 * All fields that change during normal runtime grouped to the
-	 * same cacheline
-	 */
-	struct hlist_node	entry;
-	unsigned long		expires;
-	void			(*function)(struct timer_list *);
-	u32			flags;
-
-#ifdef CONFIG_LOCKDEP
-	struct lockdep_map	lockdep_map;
-#endif
-};
+#include <linux/timer_types.h>
 
 #ifdef CONFIG_LOCKDEP
 /*
diff --git a/include/linux/timer_types.h b/include/linux/timer_types.h
new file mode 100644
index 000000000000..fae5a388f914
--- /dev/null
+++ b/include/linux/timer_types.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIMER_TYPES_H
+#define _LINUX_TIMER_TYPES_H
+
+#include <linux/lockdep_types.h>
+#include <linux/types.h>
+
+struct timer_list {
+	/*
+	 * All fields that change during normal runtime grouped to the
+	 * same cacheline
+	 */
+	struct hlist_node	entry;
+	unsigned long		expires;
+	void			(*function)(struct timer_list *);
+	u32			flags;
+
+#ifdef CONFIG_LOCKDEP
+	struct lockdep_map	lockdep_map;
+#endif
+};
+
+#endif /* _LINUX_TIMER_TYPES_H */
-- 
2.43.0


