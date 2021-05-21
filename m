Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FCD38D01C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhEUVvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhEUVvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 17:51:14 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8241EC0613ED
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 14:49:50 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 76so21264565qkn.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=MBgujV95p1ux4Z0lQ9e0ZsZFW8/3ifOLJEoE9gqJeMM=;
        b=U2b3Zd+j5EzMt39NJhIRBTUjL6a/2ULPAOS0G9blnCFUtPHx+N6w/5XYs9Q6R+tY7k
         BSfuTxTuhBah3uqm6NghrCArr6VPdkpAkRWk1KahVd6SLBCEeSWv52Flg8MJoIAu94mb
         mdjXQ169V7BcOfqq3TsKaX1JcRwo5KbGDKUFFKXDMCYMXHXD9CF8mj5etUQPHJInRyFH
         1bIu5++aqEoXm06i1YB3UXfArMrAr82oiKMxaqUtfmRk9I/kLYG22iAOsRTrs5fBHFpY
         UU/U2I0XQq2bniX0JvZa6mLWPcrb9AmcajOCugNn6zBJKvBc59fuDC8fFcq33OCABiHZ
         3luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MBgujV95p1ux4Z0lQ9e0ZsZFW8/3ifOLJEoE9gqJeMM=;
        b=RS78RXyR19y4ReaAzkhc1TCeC5I4uJegAK1Q85u/7ZWdbYIpUDKE8QiSTr2N7dEMsp
         /iN7RHtiJqu92Om9vh6dgQvKndResYxH1wAniM18k3OPl8Pht3WlqeIxqDMTKz+Vn+Jz
         jghji7b0mf3FDnBKByFzAbsaKHAUlLiP0vi716x3jPUWvHxh6508kQyzrwPGD39svwD9
         ymoGfk9SOADkG6uA68ScDzAfgNosHfSLy/k4p/wcJZo3pAviQFeA52uiOCYzTdlC+DaT
         C+bJ/t17DNt0I9jF1v1s43VVmiMPorrfyuGxTUBpd5uwHlpV/qyT3Ipgr9bWxZAXj2LP
         Ss2Q==
X-Gm-Message-State: AOAM5332mRd8EbiUrOZF+PvfOEH+TgBEl4JXDkU6rPAt/0hwB3AMdNdX
        vb/u+QARXcU5wlGV9opMhuwBH/URIJXr
X-Google-Smtp-Source: ABdhPJwn8C4xL0zpucZBFF5ean2xcuT6W4lWFjyGg7ttG5YcnmiHmwRIugTnSIxvJ/VQeKF2EftkhQ==
X-Received: by 2002:a37:2714:: with SMTP id n20mr14357489qkn.434.1621633789468;
        Fri, 21 May 2021 14:49:49 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id b17sm5068340qtb.78.2021.05.21.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:49:49 -0700 (PDT)
Subject: [RFC PATCH 1/9] audit: prepare audit_context for use in calling
 contexts beyond syscalls
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 21 May 2021 17:49:48 -0400
Message-ID: <162163378838.8379.13998476482108256664.stgit@sifl>
In-Reply-To: <162163367115.8379.8459012634106035341.stgit@sifl>
References: <162163367115.8379.8459012634106035341.stgit@sifl>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

WARNING - This is a work in progress and should not be merged
anywhere important.  It is almost surely not complete, and while it
probably compiles it likely hasn't been booted and will do terrible
things.  You have been warned.

This patch cleans up some of our audit_context handling by
abstracting out the reset and return code fixup handling to dedicated
functions.  Not only does this help make things easier to read and
inspect, it allows for easier reuse be future patches.  We also
convert the simple audit_context->in_syscall flag into an enum which
can be used to by future patches to indicate a calling context other
than the syscall context.

Thanks to Richard Guy Briggs for review and feedback.

Acked-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.h   |    5 +
 kernel/auditsc.c |  255 +++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 167 insertions(+), 93 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 1522e100fd17..fba180de5912 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -97,7 +97,10 @@ struct audit_proctitle {
 /* The per-task audit context. */
 struct audit_context {
 	int		    dummy;	/* must be the first element */
-	int		    in_syscall;	/* 1 if task is in a syscall */
+	enum {
+		AUDIT_CTX_UNUSED,	/* audit_context is currently unused */
+		AUDIT_CTX_SYSCALL,	/* in use by syscall */
+	} context;
 	enum audit_state    state, current_state;
 	unsigned int	    serial;     /* serial number for record */
 	int		    major;      /* syscall number */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 175ef6f3ea4e..cc89e9f9a753 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -909,10 +909,80 @@ static inline void audit_free_aux(struct audit_context *context)
 		context->aux = aux->next;
 		kfree(aux);
 	}
+	context->aux = NULL;
 	while ((aux = context->aux_pids)) {
 		context->aux_pids = aux->next;
 		kfree(aux);
 	}
+	context->aux_pids = NULL;
+}
+
+/**
+ * audit_reset_context - reset a audit_context structure
+ * @ctx: the audit_context to reset
+ *
+ * All fields in the audit_context will be reset to an initial state, all
+ * references held by fields will be dropped, and private memory will be
+ * released.  When this function returns the audit_context will be suitable
+ * for reuse, so long as the passed context is not NULL or a dummy context.
+ */
+static void audit_reset_context(struct audit_context *ctx)
+{
+	if (!ctx)
+		return;
+
+	/* if ctx is non-null, reset the "ctx->state" regardless */
+	ctx->context = AUDIT_CTX_UNUSED;
+	if (ctx->dummy)
+		return;
+
+	/*
+	 * NOTE: It shouldn't matter in what order we release the fields, so
+	 *       release them in the order in which they appear in the struct;
+	 *       this gives us some hope of quickly making sure we are
+	 *       resetting the audit_context properly.
+	 *
+	 *       Other things worth mentioning:
+	 *       - we don't reset "dummy"
+	 *       - we don't reset "state", we do reset "current_state"
+	 *       - we preserver "filterkey" if "state" is AUDIT_RECORD_CONTEXT
+	 *       - much of this is likely overkill, but play it safe for now
+	 *       - we really need to work on improving the audit_context struct
+	 */
+
+	ctx->current_state = ctx->state;
+	ctx->serial = 0;
+	ctx->major = 0;
+	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
+	memset(ctx->argv, 0, sizeof(ctx->argv));
+	ctx->return_code = 0;
+	ctx->prio = (ctx->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0);
+	ctx->return_valid = AUDITSC_INVALID;
+	audit_free_names(ctx);
+	if (ctx->state != AUDIT_RECORD_CONTEXT) {
+		kfree(ctx->filterkey);
+		ctx->filterkey = NULL;
+	}
+	audit_free_aux(ctx);
+	kfree(ctx->sockaddr);
+	ctx->sockaddr = NULL;
+	ctx->sockaddr_len = 0;
+	ctx->pid = ctx->ppid = 0;
+	ctx->uid = ctx->euid = ctx->suid = ctx->fsuid = KUIDT_INIT(0);
+	ctx->gid = ctx->egid = ctx->sgid = ctx->fsgid = KGIDT_INIT(0);
+	ctx->personality = 0;
+	ctx->arch = 0;
+	ctx->target_pid = 0;
+	ctx->target_auid = ctx->target_uid = KUIDT_INIT(0);
+	ctx->target_sessionid = 0;
+	ctx->target_sid = 0;
+	ctx->target_comm[0] = '\0';
+	unroll_tree_refs(ctx, NULL, 0);
+	WARN_ON(!list_empty(&ctx->killed_trees));
+	ctx->type = 0;
+	audit_free_module(ctx);
+	ctx->fds[0] = -1;
+	audit_proctitle_free(ctx);
 }
 
 static inline struct audit_context *audit_alloc_context(enum audit_state state)
@@ -922,6 +992,7 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
 	context = kzalloc(sizeof(*context), GFP_KERNEL);
 	if (!context)
 		return NULL;
+	context->context = AUDIT_CTX_UNUSED;
 	context->state = state;
 	context->prio = state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
 	INIT_LIST_HEAD(&context->killed_trees);
@@ -947,7 +1018,7 @@ int audit_alloc(struct task_struct *tsk)
 	char *key = NULL;
 
 	if (likely(!audit_ever_enabled))
-		return 0; /* Return if not auditing. */
+		return 0;
 
 	state = audit_filter_task(tsk, &key);
 	if (state == AUDIT_DISABLED) {
@@ -969,14 +1040,10 @@ int audit_alloc(struct task_struct *tsk)
 
 static inline void audit_free_context(struct audit_context *context)
 {
-	audit_free_module(context);
-	audit_free_names(context);
-	unroll_tree_refs(context, NULL, 0);
+	/* resetting is extra work, but it is likely just noise */
+	audit_reset_context(context);
 	free_tree_refs(context);
-	audit_free_aux(context);
 	kfree(context->filterkey);
-	kfree(context->sockaddr);
-	audit_proctitle_free(context);
 	kfree(context);
 }
 
@@ -1479,29 +1546,35 @@ static void audit_log_exit(void)
 
 	context->personality = current->personality;
 
-	ab = audit_log_start(context, GFP_KERNEL, AUDIT_SYSCALL);
-	if (!ab)
-		return;		/* audit_panic has been called */
-	audit_log_format(ab, "arch=%x syscall=%d",
-			 context->arch, context->major);
-	if (context->personality != PER_LINUX)
-		audit_log_format(ab, " per=%lx", context->personality);
-	if (context->return_valid != AUDITSC_INVALID)
-		audit_log_format(ab, " success=%s exit=%ld",
-				 (context->return_valid==AUDITSC_SUCCESS)?"yes":"no",
-				 context->return_code);
-
-	audit_log_format(ab,
-			 " a0=%lx a1=%lx a2=%lx a3=%lx items=%d",
-			 context->argv[0],
-			 context->argv[1],
-			 context->argv[2],
-			 context->argv[3],
-			 context->name_count);
-
-	audit_log_task_info(ab);
-	audit_log_key(ab, context->filterkey);
-	audit_log_end(ab);
+	switch (context->context) {
+	case AUDIT_CTX_SYSCALL:
+		ab = audit_log_start(context, GFP_KERNEL, AUDIT_SYSCALL);
+		if (!ab)
+			return;
+		audit_log_format(ab, "arch=%x syscall=%d",
+				 context->arch, context->major);
+		if (context->personality != PER_LINUX)
+			audit_log_format(ab, " per=%lx", context->personality);
+		if (context->return_valid != AUDITSC_INVALID)
+			audit_log_format(ab, " success=%s exit=%ld",
+					 (context->return_valid == AUDITSC_SUCCESS ?
+					  "yes" : "no"),
+					 context->return_code);
+		audit_log_format(ab,
+				 " a0=%lx a1=%lx a2=%lx a3=%lx items=%d",
+				 context->argv[0],
+				 context->argv[1],
+				 context->argv[2],
+				 context->argv[3],
+				 context->name_count);
+		audit_log_task_info(ab);
+		audit_log_key(ab, context->filterkey);
+		audit_log_end(ab);
+		break;
+	default:
+		BUG();
+		break;
+	}
 
 	for (aux = context->aux; aux; aux = aux->next) {
 
@@ -1591,14 +1664,15 @@ static void audit_log_exit(void)
 		audit_log_name(context, n, NULL, i++, &call_panic);
 	}
 
-	audit_log_proctitle();
+	if (context->context == AUDIT_CTX_SYSCALL)
+		audit_log_proctitle();
 
 	/* Send end of event record to help user space know we are finished */
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
 	if (ab)
 		audit_log_end(ab);
 	if (call_panic)
-		audit_panic("error converting sid to string");
+		audit_panic("error in audit_log_exit()");
 }
 
 /**
@@ -1614,6 +1688,7 @@ void __audit_free(struct task_struct *tsk)
 	if (!context)
 		return;
 
+	/* this may generate CONFIG_CHANGE records */
 	if (!list_empty(&context->killed_trees))
 		audit_kill_trees(context);
 
@@ -1622,7 +1697,8 @@ void __audit_free(struct task_struct *tsk)
 	 * random task_struct that doesn't doesn't have any meaningful data we
 	 * need to log via audit_log_exit().
 	 */
-	if (tsk == current && !context->dummy && context->in_syscall) {
+	if (tsk == current && !context->dummy &&
+	    context->context == AUDIT_CTX_SYSCALL) {
 		context->return_valid = AUDITSC_INVALID;
 		context->return_code = 0;
 
@@ -1636,6 +1712,34 @@ void __audit_free(struct task_struct *tsk)
 	audit_free_context(context);
 }
 
+/**
+ * audit_return_fixup - fixup the return codes in the audit_context
+ * @ctx: the audit_context
+ * @success: true/false value to indicate if the operation succeeded or not
+ * @code: operation return code
+ *
+ * We need to fixup the return code in the audit logs if the actual return
+ * codes are later going to be fixed by the arch specific signal handlers.
+ */
+static void audit_return_fixup(struct audit_context *ctx,
+			       int success, long code)
+{
+	/*
+	 * This is actually a test for:
+	 * (rc == ERESTARTSYS ) || (rc == ERESTARTNOINTR) ||
+	 * (rc == ERESTARTNOHAND) || (rc == ERESTART_RESTARTBLOCK)
+	 *
+	 * but is faster than a bunch of ||
+	 */
+	if (unlikely(code <= -ERESTARTSYS) &&
+	    (code >= -ERESTART_RESTARTBLOCK) &&
+	    (code != -ENOIOCTLCMD))
+		ctx->return_code = -EINTR;
+	else
+		ctx->return_code  = code;
+	ctx->return_valid = (success ? AUDITSC_SUCCESS : AUDITSC_FAILURE);
+}
+
 /**
  * __audit_syscall_entry - fill in an audit record at syscall entry
  * @major: major syscall type (function)
@@ -1661,7 +1765,12 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	if (!audit_enabled || !context)
 		return;
 
-	BUG_ON(context->in_syscall || context->name_count);
+	WARN_ON(context->context != AUDIT_CTX_UNUSED);
+	WARN_ON(context->name_count);
+	if (context->context != AUDIT_CTX_UNUSED || context->name_count) {
+		audit_panic("unrecoverable error in audit_syscall_entry()");
+		return;
+	}
 
 	state = context->state;
 	if (state == AUDIT_DISABLED)
@@ -1680,10 +1789,8 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->argv[1]    = a2;
 	context->argv[2]    = a3;
 	context->argv[3]    = a4;
-	context->serial     = 0;
-	context->in_syscall = 1;
+	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
-	context->ppid       = 0;
 	ktime_get_coarse_real_ts64(&context->ctime);
 }
 
@@ -1700,63 +1807,27 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
  */
 void __audit_syscall_exit(int success, long return_code)
 {
-	struct audit_context *context;
+	struct audit_context *context = audit_context();
 
-	context = audit_context();
-	if (!context)
-		return;
+	if (!context || context->dummy ||
+	    context->context != AUDIT_CTX_SYSCALL)
+		goto out;
 
+	/* this may generate CONFIG_CHANGE records */
 	if (!list_empty(&context->killed_trees))
 		audit_kill_trees(context);
 
-	if (!context->dummy && context->in_syscall) {
-		if (success)
-			context->return_valid = AUDITSC_SUCCESS;
-		else
-			context->return_valid = AUDITSC_FAILURE;
-
-		/*
-		 * we need to fix up the return code in the audit logs if the
-		 * actual return codes are later going to be fixed up by the
-		 * arch specific signal handlers
-		 *
-		 * This is actually a test for:
-		 * (rc == ERESTARTSYS ) || (rc == ERESTARTNOINTR) ||
-		 * (rc == ERESTARTNOHAND) || (rc == ERESTART_RESTARTBLOCK)
-		 *
-		 * but is faster than a bunch of ||
-		 */
-		if (unlikely(return_code <= -ERESTARTSYS) &&
-		    (return_code >= -ERESTART_RESTARTBLOCK) &&
-		    (return_code != -ENOIOCTLCMD))
-			context->return_code = -EINTR;
-		else
-			context->return_code  = return_code;
-
-		audit_filter_syscall(current, context);
-		audit_filter_inodes(current, context);
-		if (context->current_state == AUDIT_RECORD_CONTEXT)
-			audit_log_exit();
-	}
+	/* run through both filters to ensure we set the filterkey properly */
+	audit_filter_syscall(current, context);
+	audit_filter_inodes(current, context);
+	if (context->current_state < AUDIT_RECORD_CONTEXT)
+		goto out;
 
-	context->in_syscall = 0;
-	context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
+	audit_return_fixup(context, success, return_code);
+	audit_log_exit();
 
-	audit_free_module(context);
-	audit_free_names(context);
-	unroll_tree_refs(context, NULL, 0);
-	audit_free_aux(context);
-	context->aux = NULL;
-	context->aux_pids = NULL;
-	context->target_pid = 0;
-	context->target_sid = 0;
-	context->sockaddr_len = 0;
-	context->type = 0;
-	context->fds[0] = -1;
-	if (context->state != AUDIT_RECORD_CONTEXT) {
-		kfree(context->filterkey);
-		context->filterkey = NULL;
-	}
+out:
+	audit_reset_context(context);
 }
 
 static inline void handle_one(const struct inode *inode)
@@ -1905,7 +1976,7 @@ void __audit_getname(struct filename *name)
 	struct audit_context *context = audit_context();
 	struct audit_names *n;
 
-	if (!context->in_syscall)
+	if (context->context == AUDIT_CTX_UNUSED)
 		return;
 
 	n = audit_alloc_name(context, AUDIT_TYPE_UNKNOWN);
@@ -1977,7 +2048,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
 	int i;
 
-	if (!context->in_syscall)
+	if (context->context == AUDIT_CTX_UNUSED)
 		return;
 
 	rcu_read_lock();
@@ -2095,7 +2166,7 @@ void __audit_inode_child(struct inode *parent,
 	struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
 	int i;
 
-	if (!context->in_syscall)
+	if (context->context == AUDIT_CTX_UNUSED)
 		return;
 
 	rcu_read_lock();
@@ -2194,7 +2265,7 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
 int auditsc_get_stamp(struct audit_context *ctx,
 		       struct timespec64 *t, unsigned int *serial)
 {
-	if (!ctx->in_syscall)
+	if (ctx->context == AUDIT_CTX_UNUSED)
 		return 0;
 	if (!ctx->serial)
 		ctx->serial = audit_serial();
@@ -2686,7 +2757,7 @@ void audit_seccomp_actions_logged(const char *names, const char *old_names,
 struct list_head *audit_killed_trees(void)
 {
 	struct audit_context *ctx = audit_context();
-	if (likely(!ctx || !ctx->in_syscall))
+	if (likely(!ctx || ctx->context == AUDIT_CTX_UNUSED))
 		return NULL;
 	return &ctx->killed_trees;
 }

