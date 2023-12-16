Return-Path: <linux-fsdevel+bounces-6267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CA8156D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BE11F2485A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665D11705;
	Sat, 16 Dec 2023 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ub89eKfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5210792
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J6ZTRPGT7PpELf8O6mfGNQjPQNgqo1t5goRsr9dKXE=;
	b=Ub89eKfF4KwlYPY3oicjXOZKpYuat1K555e6TGwRfSnQoXCnNUJbKIdPAyjk1b9XDbIPy7
	x8yEi4bfsWn2Qg+9JNwwsx9W1iU7KF6BOD9GMX7AslVE9aBBEX+bF5/694hrP1Omg/IxTk
	WLfmh+zSwPDwMMjCqp42ArexI14ZMqM=
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
Subject: [PATCH 23/50] sched.h: move pid helpers to pid.h
Date: Fri, 15 Dec 2023 22:29:29 -0500
Message-ID: <20231216032957.3553313-2-kent.overstreet@linux.dev>
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

This is needed for killing the sched.h dependency on rcupdate.h, and
pid.h is a better place for this code anyways.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/pid.h          | 125 +++++++++++++++++++++++++++++++++++
 include/linux/sched.h        | 122 ----------------------------------
 include/linux/sched/signal.h |   1 +
 3 files changed, 126 insertions(+), 122 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index f254c3a45b9b..395cacce1179 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -4,7 +4,9 @@
 
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
 #include <linux/wait.h>
 
 /*
@@ -204,4 +206,127 @@ pid_t pid_vnr(struct pid *pid);
 		}							\
 		task = tg___;						\
 	} while_each_pid_task(pid, type, task)
+
+static inline struct pid *task_pid(struct task_struct *task)
+{
+	return task->thread_pid;
+}
+
+/*
+ * the helpers to get the task's different pids as they are seen
+ * from various namespaces
+ *
+ * task_xid_nr()     : global id, i.e. the id seen from the init namespace;
+ * task_xid_vnr()    : virtual id, i.e. the id seen from the pid namespace of
+ *                     current.
+ * task_xid_nr_ns()  : id seen from the ns specified;
+ *
+ * see also pid_nr() etc in include/linux/pid.h
+ */
+pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type, struct pid_namespace *ns);
+
+static inline pid_t task_pid_nr(struct task_struct *tsk)
+{
+	return tsk->pid;
+}
+
+static inline pid_t task_pid_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns);
+}
+
+static inline pid_t task_pid_vnr(struct task_struct *tsk)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_PID, NULL);
+}
+
+
+static inline pid_t task_tgid_nr(struct task_struct *tsk)
+{
+	return tsk->tgid;
+}
+
+/**
+ * pid_alive - check that a task structure is not stale
+ * @p: Task structure to be checked.
+ *
+ * Test if a process is not yet dead (at most zombie state)
+ * If pid_alive fails, then pointers within the task structure
+ * can be stale and must not be dereferenced.
+ *
+ * Return: 1 if the process is alive. 0 otherwise.
+ */
+static inline int pid_alive(const struct task_struct *p)
+{
+	return p->thread_pid != NULL;
+}
+
+static inline pid_t task_pgrp_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_PGID, ns);
+}
+
+static inline pid_t task_pgrp_vnr(struct task_struct *tsk)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_PGID, NULL);
+}
+
+
+static inline pid_t task_session_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_SID, ns);
+}
+
+static inline pid_t task_session_vnr(struct task_struct *tsk)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_SID, NULL);
+}
+
+static inline pid_t task_tgid_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_TGID, ns);
+}
+
+static inline pid_t task_tgid_vnr(struct task_struct *tsk)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_TGID, NULL);
+}
+
+static inline pid_t task_ppid_nr_ns(const struct task_struct *tsk, struct pid_namespace *ns)
+{
+	pid_t pid = 0;
+
+	rcu_read_lock();
+	if (pid_alive(tsk))
+		pid = task_tgid_nr_ns(rcu_dereference(tsk->real_parent), ns);
+	rcu_read_unlock();
+
+	return pid;
+}
+
+static inline pid_t task_ppid_nr(const struct task_struct *tsk)
+{
+	return task_ppid_nr_ns(tsk, &init_pid_ns);
+}
+
+/* Obsolete, do not use: */
+static inline pid_t task_pgrp_nr(struct task_struct *tsk)
+{
+	return task_pgrp_nr_ns(tsk, &init_pid_ns);
+}
+
+/**
+ * is_global_init - check if a task structure is init. Since init
+ * is free to have sub-threads we need to check tgid.
+ * @tsk: Task structure to be checked.
+ *
+ * Check if a task structure is the first user space task the kernel created.
+ *
+ * Return: 1 if the task structure is init. 0 otherwise.
+ */
+static inline int is_global_init(struct task_struct *tsk)
+{
+	return task_tgid_nr(tsk) == 1;
+}
+
 #endif /* _LINUX_PID_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 37cc9d257073..9e2708c2cfa6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1561,114 +1561,6 @@ struct task_struct {
 	 */
 };
 
-static inline struct pid *task_pid(struct task_struct *task)
-{
-	return task->thread_pid;
-}
-
-/*
- * the helpers to get the task's different pids as they are seen
- * from various namespaces
- *
- * task_xid_nr()     : global id, i.e. the id seen from the init namespace;
- * task_xid_vnr()    : virtual id, i.e. the id seen from the pid namespace of
- *                     current.
- * task_xid_nr_ns()  : id seen from the ns specified;
- *
- * see also pid_nr() etc in include/linux/pid.h
- */
-pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type, struct pid_namespace *ns);
-
-static inline pid_t task_pid_nr(struct task_struct *tsk)
-{
-	return tsk->pid;
-}
-
-static inline pid_t task_pid_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
-{
-	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns);
-}
-
-static inline pid_t task_pid_vnr(struct task_struct *tsk)
-{
-	return __task_pid_nr_ns(tsk, PIDTYPE_PID, NULL);
-}
-
-
-static inline pid_t task_tgid_nr(struct task_struct *tsk)
-{
-	return tsk->tgid;
-}
-
-/**
- * pid_alive - check that a task structure is not stale
- * @p: Task structure to be checked.
- *
- * Test if a process is not yet dead (at most zombie state)
- * If pid_alive fails, then pointers within the task structure
- * can be stale and must not be dereferenced.
- *
- * Return: 1 if the process is alive. 0 otherwise.
- */
-static inline int pid_alive(const struct task_struct *p)
-{
-	return p->thread_pid != NULL;
-}
-
-static inline pid_t task_pgrp_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
-{
-	return __task_pid_nr_ns(tsk, PIDTYPE_PGID, ns);
-}
-
-static inline pid_t task_pgrp_vnr(struct task_struct *tsk)
-{
-	return __task_pid_nr_ns(tsk, PIDTYPE_PGID, NULL);
-}
-
-
-static inline pid_t task_session_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
-{
-	return __task_pid_nr_ns(tsk, PIDTYPE_SID, ns);
-}
-
-static inline pid_t task_session_vnr(struct task_struct *tsk)
-{
-	return __task_pid_nr_ns(tsk, PIDTYPE_SID, NULL);
-}
-
-static inline pid_t task_tgid_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
-{
-	return __task_pid_nr_ns(tsk, PIDTYPE_TGID, ns);
-}
-
-static inline pid_t task_tgid_vnr(struct task_struct *tsk)
-{
-	return __task_pid_nr_ns(tsk, PIDTYPE_TGID, NULL);
-}
-
-static inline pid_t task_ppid_nr_ns(const struct task_struct *tsk, struct pid_namespace *ns)
-{
-	pid_t pid = 0;
-
-	rcu_read_lock();
-	if (pid_alive(tsk))
-		pid = task_tgid_nr_ns(rcu_dereference(tsk->real_parent), ns);
-	rcu_read_unlock();
-
-	return pid;
-}
-
-static inline pid_t task_ppid_nr(const struct task_struct *tsk)
-{
-	return task_ppid_nr_ns(tsk, &init_pid_ns);
-}
-
-/* Obsolete, do not use: */
-static inline pid_t task_pgrp_nr(struct task_struct *tsk)
-{
-	return task_pgrp_nr_ns(tsk, &init_pid_ns);
-}
-
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)
 
@@ -1712,20 +1604,6 @@ static inline char task_state_to_char(struct task_struct *tsk)
 	return task_index_to_char(task_state_index(tsk));
 }
 
-/**
- * is_global_init - check if a task structure is init. Since init
- * is free to have sub-threads we need to check tgid.
- * @tsk: Task structure to be checked.
- *
- * Check if a task structure is the first user space task the kernel created.
- *
- * Return: 1 if the task structure is init. 0 otherwise.
- */
-static inline int is_global_init(struct task_struct *tsk)
-{
-	return task_tgid_nr(tsk) == 1;
-}
-
 extern struct pid *cad_pid;
 
 /*
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3499c1a8b929..b847d8fa75a9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 #include <linux/cred.h>
 #include <linux/refcount.h>
+#include <linux/pid.h>
 #include <linux/posix-timers.h>
 #include <linux/mm_types.h>
 #include <asm/ptrace.h>
-- 
2.43.0


