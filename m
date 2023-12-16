Return-Path: <linux-fsdevel+bounces-6280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9898156F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6141F25BA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA4381A7;
	Sat, 16 Dec 2023 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wmpSPZvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725937D01
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxw2KqDvlMnMD4Kapv1bIsL/tByrZwT85T/LljRE2HE=;
	b=wmpSPZvk0q6PpcFET+M+jpSJuPO1rvRf4yekiYZQcySO04+MNinlp+POwwTts/ZKSMA+vd
	G1nJLMt5WnAM8ceV7UR9qMkJRjc/TkrFKG3Rhg+S893Mr7vpUsk+D8ltIU+aPtti5HYLQ2
	HGLpevlfQAM+3lPkaQ5vzJJDZLqfwks=
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
Subject: [PATCH 36/50] syscall_user_dispatch.h: split out *_types.h
Date: Fri, 15 Dec 2023 22:32:42 -0500
Message-ID: <20231216033300.3553457-4-kent.overstreet@linux.dev>
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

thread_info.h pulls in a lot of junk that sched.h that we don't need; in
particular, this helps to kill the printk.h dependency.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/sched.h                       |  2 +-
 include/linux/syscall_user_dispatch.h       |  9 +--------
 include/linux/syscall_user_dispatch_types.h | 22 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/syscall_user_dispatch_types.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d799427f6d1b..fea6d913e004 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -28,7 +28,7 @@
 #include <linux/sched/prio.h>
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
-#include <linux/syscall_user_dispatch.h>
+#include <linux/syscall_user_dispatch_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index 641ca8880995..3858a6ffdd5c 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -6,16 +6,10 @@
 #define _SYSCALL_USER_DISPATCH_H
 
 #include <linux/thread_info.h>
+#include <linux/syscall_user_dispatch_types.h>
 
 #ifdef CONFIG_GENERIC_ENTRY
 
-struct syscall_user_dispatch {
-	char __user	*selector;
-	unsigned long	offset;
-	unsigned long	len;
-	bool		on_dispatch;
-};
-
 int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 			      unsigned long len, char __user *selector);
 
@@ -29,7 +23,6 @@ int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long siz
 				     void __user *data);
 
 #else
-struct syscall_user_dispatch {};
 
 static inline int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 					    unsigned long len, char __user *selector)
diff --git a/include/linux/syscall_user_dispatch_types.h b/include/linux/syscall_user_dispatch_types.h
new file mode 100644
index 000000000000..3be36b06c7d7
--- /dev/null
+++ b/include/linux/syscall_user_dispatch_types.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SYSCALL_USER_DISPATCH_TYPES_H
+#define _SYSCALL_USER_DISPATCH_TYPES_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_GENERIC_ENTRY
+
+struct syscall_user_dispatch {
+	char __user	*selector;
+	unsigned long	offset;
+	unsigned long	len;
+	bool		on_dispatch;
+};
+
+#else
+
+struct syscall_user_dispatch {};
+
+#endif
+
+#endif /* _SYSCALL_USER_DISPATCH_TYPES_H */
-- 
2.43.0


