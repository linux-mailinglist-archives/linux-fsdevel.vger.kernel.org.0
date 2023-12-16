Return-Path: <linux-fsdevel+bounces-6286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789EA815700
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB79D1C2498D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434F41C99;
	Sat, 16 Dec 2023 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TEw8lyxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1B41235
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEcswrm7jwwc7VjG2k3DRMFRtfQsexzn74V1sev2AFE=;
	b=TEw8lyxGiEvcCafUswfHvN5NQkKGTs2243U56VTEeo3e0l3SKtJ7S42DFrZp7hpnCe5CdV
	SeeiJ74HseN+NIKaK/VjxGPdu7FOGxA7A0k/mvQ10aXwOThBSec0e/hUpzAo/iWiqXrFUQ
	Vytn1rIiS7BT4QaXEqkoF3Wg27OQ71M=
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
Subject: [PATCH 42/50] sem: Split out sem_types.h
Date: Fri, 15 Dec 2023 22:32:48 -0500
Message-ID: <20231216033300.3553457-10-kent.overstreet@linux.dev>
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

More sched.h dependency pruning.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/audit.h     |  1 +
 include/linux/sched.h     |  3 ++-
 include/linux/sem.h       | 10 +---------
 include/linux/sem_types.h | 13 +++++++++++++
 4 files changed, 17 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/sem_types.h

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 51b1b7054a23..93d97b56e1e4 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -400,6 +400,7 @@ static inline void audit_ptrace(struct task_struct *t)
 }
 
 				/* Private API (for audit.c only) */
+struct kern_ipc_perm;
 extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
 extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, umode_t mode);
 extern void __audit_bprm(struct linux_binprm *bprm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 157e7af36bb7..98885e3a81e8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -13,12 +13,13 @@
 
 #include <linux/irqflags_types.h>
 #include <linux/pid_types.h>
-#include <linux/sem.h>
+#include <linux/sem_types.h>
 #include <linux/shm.h>
 #include <linux/kmsan_types.h>
 #include <linux/mutex_types.h>
 #include <linux/plist_types.h>
 #include <linux/hrtimer_types.h>
+#include <linux/timer_types.h>
 #include <linux/seccomp_types.h>
 #include <linux/nodemask_types.h>
 #include <linux/rcupdate.h>
diff --git a/include/linux/sem.h b/include/linux/sem.h
index 5608a500c43e..c4deefe42aeb 100644
--- a/include/linux/sem.h
+++ b/include/linux/sem.h
@@ -3,25 +3,17 @@
 #define _LINUX_SEM_H
 
 #include <uapi/linux/sem.h>
+#include <linux/sem_types.h>
 
 struct task_struct;
-struct sem_undo_list;
 
 #ifdef CONFIG_SYSVIPC
 
-struct sysv_sem {
-	struct sem_undo_list *undo_list;
-};
-
 extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
 extern void exit_sem(struct task_struct *tsk);
 
 #else
 
-struct sysv_sem {
-	/* empty */
-};
-
 static inline int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
 {
 	return 0;
diff --git a/include/linux/sem_types.h b/include/linux/sem_types.h
new file mode 100644
index 000000000000..73df1971a7ae
--- /dev/null
+++ b/include/linux/sem_types.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SEM_TYPES_H
+#define _LINUX_SEM_TYPES_H
+
+struct sem_undo_list;
+
+struct sysv_sem {
+#ifdef CONFIG_SYSVIPC
+	struct sem_undo_list *undo_list;
+#endif
+};
+
+#endif /* _LINUX_SEM_TYPES_H */
-- 
2.43.0


