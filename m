Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA2F12DB47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 20:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfLaTtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 14:49:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38951 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727145AbfLaTts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577821787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:in-reply-to:
         references:references:references;
        bh=fau7ZEoOCDFNNBwFs+C0zLL4owpwvdNE22T2hdEGJ2I=;
        b=TX9eSVaFTDcKo/tnasLsaIcDs1SDpWJt/94b4GLvF6Wx4fBmQUAFhHVqlBtvQXaQVCF8eS
        1rm5wHUzL9Iu+Givr4kj9TG564iYAe0DfyRTdJq6ni3sgEuiJN2S7M4YB9TXHfHH42RmIm
        zrBqobnlJgkjaYLPzb7Ujce9POJYbVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-dWtca370PvGB1sL2fqXRcQ-1; Tue, 31 Dec 2019 14:49:45 -0500
X-MC-Unique: dWtca370PvGB1sL2fqXRcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72418477;
        Tue, 31 Dec 2019 19:49:43 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAA1682086;
        Tue, 31 Dec 2019 19:49:38 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        nhorman@tuxdriver.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 V8 01/16] audit: collect audit task parameters
Date:   Tue, 31 Dec 2019 14:48:14 -0500
Message-Id: <53b9f42c05477cbde0f70377248015b78e587050.1577736799.git.rgb@redhat.com>
In-Reply-To: <cover.1577736799.git.rgb@redhat.com>
References: <cover.1577736799.git.rgb@redhat.com>
In-Reply-To: <cover.1577736799.git.rgb@redhat.com>
References: <cover.1577736799.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The audit-related parameters in struct task_struct should ideally be
collected together and accessed through a standard audit API.

Collect the existing loginuid, sessionid and audit_context together in a
new struct audit_task_info called "audit" in struct task_struct.

Use kmem_cache to manage this pool of memory.
Un-inline audit_free() to be able to always recover that memory.

Please see the upstream github issue
https://github.com/linux-audit/audit-kernel/issues/81

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h | 49 +++++++++++++++++++++++------------
 include/linux/sched.h |  7 +----
 init/init_task.c      |  3 +--
 init/main.c           |  2 ++
 kernel/audit.c        | 71 +++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/audit.h        |  5 ++++
 kernel/auditsc.c      | 26 ++++++++++---------
 kernel/fork.c         |  1 -
 8 files changed, 124 insertions(+), 40 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index f9ceae57ca8d..96deb28942e3 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -94,6 +94,16 @@ struct audit_ntp_data {
 struct audit_ntp_data {};
 #endif
 
+struct audit_task_info {
+	kuid_t			loginuid;
+	unsigned int		sessionid;
+#ifdef CONFIG_AUDITSYSCALL
+	struct audit_context	*ctx;
+#endif
+};
+
+extern struct audit_task_info init_struct_audit;
+
 extern int is_audit_feature_set(int which);
 
 extern int __init audit_register_class(int class, unsigned *list);
@@ -130,6 +140,9 @@ struct audit_ntp_data {
 #ifdef CONFIG_AUDIT
 /* These are defined in audit.c */
 				/* Public API */
+extern int  audit_alloc(struct task_struct *task);
+extern void audit_free(struct task_struct *task);
+extern void __init audit_task_init(void);
 extern __printf(4, 5)
 void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
 	       const char *fmt, ...);
@@ -173,12 +186,16 @@ extern void		    audit_log_path_denied(int type,
 
 static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
 {
-	return tsk->loginuid;
+	if (!tsk->audit)
+		return INVALID_UID;
+	return tsk->audit->loginuid;
 }
 
 static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
 {
-	return tsk->sessionid;
+	if (!tsk->audit)
+		return AUDIT_SID_UNSET;
+	return tsk->audit->sessionid;
 }
 
 extern u32 audit_enabled;
@@ -186,6 +203,14 @@ static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
 extern int audit_signal_info(int sig, struct task_struct *t);
 
 #else /* CONFIG_AUDIT */
+static inline int audit_alloc(struct task_struct *task)
+{
+	return 0;
+}
+static inline void audit_free(struct task_struct *task)
+{ }
+static inline void __init audit_task_init(void)
+{ }
 static inline __printf(4, 5)
 void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
 	       const char *fmt, ...)
@@ -261,8 +286,6 @@ static inline int audit_signal_info(int sig, struct task_struct *t)
 
 /* These are defined in auditsc.c */
 				/* Public API */
-extern int  audit_alloc(struct task_struct *task);
-extern void __audit_free(struct task_struct *task);
 extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 				  unsigned long a2, unsigned long a3);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
@@ -282,12 +305,14 @@ extern void audit_seccomp_actions_logged(const char *names,
 
 static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
 {
-	task->audit_context = ctx;
+	task->audit->ctx = ctx;
 }
 
 static inline struct audit_context *audit_context(void)
 {
-	return current->audit_context;
+	if (!current->audit)
+		return NULL;
+	return current->audit->ctx;
 }
 
 static inline bool audit_dummy_context(void)
@@ -295,11 +320,7 @@ static inline bool audit_dummy_context(void)
 	void *p = audit_context();
 	return !p || *(int *)p;
 }
-static inline void audit_free(struct task_struct *task)
-{
-	if (unlikely(task->audit_context))
-		__audit_free(task);
-}
+
 static inline void audit_syscall_entry(int major, unsigned long a0,
 				       unsigned long a1, unsigned long a2,
 				       unsigned long a3)
@@ -517,12 +538,6 @@ static inline void audit_ntp_log(const struct audit_ntp_data *ad)
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
-static inline int audit_alloc(struct task_struct *task)
-{
-	return 0;
-}
-static inline void audit_free(struct task_struct *task)
-{ }
 static inline void audit_syscall_entry(int major, unsigned long a0,
 				       unsigned long a1, unsigned long a2,
 				       unsigned long a3)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 467d26046416..aebe24192b23 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -33,7 +33,6 @@
 #include <linux/rseq.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
-struct audit_context;
 struct backing_dev_info;
 struct bio_list;
 struct blk_plug;
@@ -930,11 +929,7 @@ struct task_struct {
 	struct callback_head		*task_works;
 
 #ifdef CONFIG_AUDIT
-#ifdef CONFIG_AUDITSYSCALL
-	struct audit_context		*audit_context;
-#endif
-	kuid_t				loginuid;
-	unsigned int			sessionid;
+	struct audit_task_info		*audit;
 #endif
 	struct seccomp			seccomp;
 
diff --git a/init/init_task.c b/init/init_task.c
index 9e5cbe5eab7b..5204578d6e7e 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -122,8 +122,7 @@ struct task_struct init_task
 	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
 #ifdef CONFIG_AUDIT
-	.loginuid	= INVALID_UID,
-	.sessionid	= AUDIT_SID_UNSET,
+	.audit		= &init_struct_audit,
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	.perf_event_mutex = __MUTEX_INITIALIZER(init_task.perf_event_mutex),
diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef0..f6687f40ba90 100644
--- a/init/main.c
+++ b/init/main.c
@@ -93,6 +93,7 @@
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
+#include <linux/audit.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -770,6 +771,7 @@ asmlinkage __visible void __init start_kernel(void)
 	nsfs_init();
 	cpuset_init();
 	cgroup_init();
+	audit_task_init();
 	taskstats_init_early();
 	delayacct_init();
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 17b0d523afb3..397f8fb4836a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -203,6 +203,73 @@ struct audit_reply {
 	struct sk_buff *skb;
 };
 
+static struct kmem_cache *audit_task_cache;
+
+void __init audit_task_init(void)
+{
+	audit_task_cache = kmem_cache_create("audit_task",
+					     sizeof(struct audit_task_info),
+					     0, SLAB_PANIC, NULL);
+}
+
+/**
+ * audit_alloc - allocate an audit info block for a task
+ * @tsk: task
+ *
+ * Call audit_alloc_syscall to filter on the task information and
+ * allocate a per-task audit context if necessary.  This is called from
+ * copy_process, so no lock is needed.
+ */
+int audit_alloc(struct task_struct *tsk)
+{
+	int ret = 0;
+	struct audit_task_info *info;
+
+	info = kmem_cache_alloc(audit_task_cache, GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	info->loginuid = audit_get_loginuid(current);
+	info->sessionid = audit_get_sessionid(current);
+	tsk->audit = info;
+
+	ret = audit_alloc_syscall(tsk);
+	if (ret) {
+		tsk->audit = NULL;
+		kmem_cache_free(audit_task_cache, info);
+	}
+out:
+	return ret;
+}
+
+struct audit_task_info init_struct_audit = {
+	.loginuid = INVALID_UID,
+	.sessionid = AUDIT_SID_UNSET,
+#ifdef CONFIG_AUDITSYSCALL
+	.ctx = NULL,
+#endif
+};
+
+/**
+ * audit_free - free per-task audit info
+ * @tsk: task whose audit info block to free
+ *
+ * Called from copy_process and do_exit
+ */
+void audit_free(struct task_struct *tsk)
+{
+	struct audit_task_info *info = tsk->audit;
+
+	audit_free_syscall(tsk);
+	/* Freeing the audit_task_info struct must be performed after
+	 * audit_log_exit() due to need for loginuid and sessionid.
+	 */
+	info = tsk->audit;
+	tsk->audit = NULL;
+	kmem_cache_free(audit_task_cache, info);
+}
+
 /**
  * auditd_test_task - Check to see if a given task is an audit daemon
  * @task: the task to check
@@ -2255,8 +2322,8 @@ int audit_set_loginuid(kuid_t loginuid)
 			sessionid = (unsigned int)atomic_inc_return(&session_id);
 	}
 
-	current->sessionid = sessionid;
-	current->loginuid = loginuid;
+	current->audit->sessionid = sessionid;
+	current->audit->loginuid = loginuid;
 out:
 	audit_log_set_loginuid(oldloginuid, loginuid, oldsessionid, sessionid, rc);
 	return rc;
diff --git a/kernel/audit.h b/kernel/audit.h
index 6fb7160412d4..7f623ef216e6 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -251,6 +251,8 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
 			      struct timespec64 *t, unsigned int *serial);
+extern int audit_alloc_syscall(struct task_struct *tsk);
+extern void audit_free_syscall(struct task_struct *tsk);
 
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
@@ -292,6 +294,9 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
 #define auditsc_get_stamp(c, t, s) 0
+#define audit_alloc_syscall(t) 0
+#define audit_free_syscall(t) {}
+
 #define audit_put_watch(w) {}
 #define audit_get_watch(w) {}
 #define audit_to_watch(k, p, l, o) (-EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2..10679da36bb6 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -903,23 +903,25 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
 	return context;
 }
 
-/**
- * audit_alloc - allocate an audit context block for a task
+/*
+ * audit_alloc_syscall - allocate an audit context block for a task
  * @tsk: task
  *
  * Filter on the task information and allocate a per-task audit context
  * if necessary.  Doing so turns on system call auditing for the
- * specified task.  This is called from copy_process, so no lock is
- * needed.
+ * specified task.  This is called from copy_process via audit_alloc, so
+ * no lock is needed.
  */
-int audit_alloc(struct task_struct *tsk)
+int audit_alloc_syscall(struct task_struct *tsk)
 {
 	struct audit_context *context;
 	enum audit_state     state;
 	char *key = NULL;
 
-	if (likely(!audit_ever_enabled))
+	if (likely(!audit_ever_enabled)) {
+		audit_set_context(tsk, NULL);
 		return 0; /* Return if not auditing. */
+	}
 
 	state = audit_filter_task(tsk, &key);
 	if (state == AUDIT_DISABLED) {
@@ -929,7 +931,7 @@ int audit_alloc(struct task_struct *tsk)
 
 	if (!(context = audit_alloc_context(state))) {
 		kfree(key);
-		audit_log_lost("out of memory in audit_alloc");
+		audit_log_lost("out of memory in audit_alloc_syscall");
 		return -ENOMEM;
 	}
 	context->filterkey = key;
@@ -1574,14 +1576,15 @@ static void audit_log_exit(void)
 }
 
 /**
- * __audit_free - free a per-task audit context
+ * audit_free_syscall - free per-task audit context info
  * @tsk: task whose audit context block to free
  *
- * Called from copy_process and do_exit
+ * Called from audit_free
  */
-void __audit_free(struct task_struct *tsk)
+void audit_free_syscall(struct task_struct *tsk)
 {
-	struct audit_context *context = tsk->audit_context;
+	struct audit_task_info *info = tsk->audit;
+	struct audit_context *context = info->ctx;
 
 	if (!context)
 		return;
@@ -1604,7 +1607,6 @@ void __audit_free(struct task_struct *tsk)
 		if (context->current_state == AUDIT_RECORD_CONTEXT)
 			audit_log_exit();
 	}
-
 	audit_set_context(tsk, NULL);
 	audit_free_context(context);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..edf034e5cbb4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1993,7 +1993,6 @@ static __latent_entropy struct task_struct *copy_process(
 	posix_cputimers_init(&p->posix_cputimers);
 
 	p->io_context = NULL;
-	audit_set_context(p, NULL);
 	cgroup_fork(p);
 #ifdef CONFIG_NUMA
 	p->mempolicy = mpol_dup(p->mempolicy);
-- 
1.8.3.1

