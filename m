Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32A3E99EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 22:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhHKUtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 16:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHKUtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:49:07 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B656CC0617A4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:48:38 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l24so3226077qtj.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=DtMiabXVe2t/Zp2eRgjYPiHEYc/TygDlwFzgOsvocec=;
        b=mHB4Mq/ymO89PaC6GERZsJRMU2RZQzRN80hB6TZ4vTuahsZHQBmqn99UHdEP8pe9Mb
         BEZOhSaBAYBD/YTghe3J21RBSIFnv/UHY56gNQdXnHWdjFzn+nVc+Vdsek/3vrfYiP4m
         qLbTIW0s9LGcjoh8mQkcxOwAAL6Q6PPILx4+2upDSOkZT/YK7EXSkr6D4yTj2F/hB4Ka
         uxj9NzFE8kCOoRzub52RHK9IXRP31WUd1jCjBnQ+vbLVsUNVb09tSfXx7+j1BSF8WxZ3
         u7oaIXD+3H7FbCM75ydcFU/gqtH5rc2Zjfhv1pAAogL6tUDNo5KWrCvWczVap90qCrbQ
         A4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DtMiabXVe2t/Zp2eRgjYPiHEYc/TygDlwFzgOsvocec=;
        b=j3q0Bdcuk4xKoVj6TlqVzgPfT/YOeYd6LbtMgFoBGeIbl5zrEHKYamat7KD1XSshK9
         Ae5vnLhlM9shxBIrHhYGZa7dNDSA/CEQszObHuvfJ2eojaRabB6PtCvODT3uptLcH8mv
         E0F4vHYqDsU9caVejz+GuwJGgeCdjH5WXVFTuEqQ8WQ573Z7lzizwUjh4V6QPAOJLIHD
         VzrWhP9D+EnIdO0YMX41VtRukusPfE1+wE0mEnaprrVshQpRsQALU+PGtbOkaGLVZZkW
         bgDG7h5wFzmOsWoKZwfbrjrlk//W09T141+Eh+D55yVSJ2wtnnZrsl6mCWlMabLfFyNo
         7lRA==
X-Gm-Message-State: AOAM533a/2gUfq8VcrxF46/hde78kpOtPxKLfiyKlj2pqvw/yPNvIxxj
        VoR1gnDfrK7hra8aVP12eG06
X-Google-Smtp-Source: ABdhPJy9Mr3jPE5RRqWi1zMGvFe0GdY1f67fZWlXvlp2FSzHM5K2j8qGh27zkuz0EAvq3NKzCfyEOA==
X-Received: by 2002:ac8:b82:: with SMTP id h2mr608579qti.214.1628714917719;
        Wed, 11 Aug 2021 13:48:37 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id 12sm164548qkk.67.2021.08.11.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:48:37 -0700 (PDT)
Subject: [RFC PATCH v2 4/9] audit: add filtering for io_uring records
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed, 11 Aug 2021 16:48:36 -0400
Message-ID: <162871491639.63873.699905170296128086.stgit@olly>
In-Reply-To: <162871480969.63873.9434591871437326374.stgit@olly>
References: <162871480969.63873.9434591871437326374.stgit@olly>
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

This patch adds basic audit io_uring filtering, using as much of the
existing audit filtering infrastructure as possible.  In order to do
this we reuse the audit filter rule's syscall mask for the io_uring
operation and we create a new filter for io_uring operations as
AUDIT_FILTER_URING_EXIT/audit_filter_list[7].

<TODO - provide some additional guidance for the userspace tools>

Thanks to Richard Guy Briggs for his review and feedback.

Signed-off-by: Paul Moore <paul@paul-moore.com>

---
v2:
- incorporate feedback from Richard
v1:
- initial draft
---
 include/uapi/linux/audit.h |    3 +-
 kernel/audit_tree.c        |    3 +-
 kernel/audit_watch.c       |    3 +-
 kernel/auditfilter.c       |   15 ++++++++--
 kernel/auditsc.c           |   65 ++++++++++++++++++++++++++++++++++----------
 5 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index a1997697c8b1..ecf1edd2affa 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -167,8 +167,9 @@
 #define AUDIT_FILTER_EXCLUDE	0x05	/* Apply rule before record creation */
 #define AUDIT_FILTER_TYPE	AUDIT_FILTER_EXCLUDE /* obsolete misleading naming */
 #define AUDIT_FILTER_FS		0x06	/* Apply rule at __audit_inode_child */
+#define AUDIT_FILTER_URING_EXIT	0x07	/* Apply rule at io_uring op exit */
 
-#define AUDIT_NR_FILTERS	7
+#define AUDIT_NR_FILTERS	8
 
 #define AUDIT_FILTER_PREPEND	0x10	/* Prepend to front of list */
 
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index b2be4e978ba3..31bf34844546 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -726,7 +726,8 @@ int audit_make_tree(struct audit_krule *rule, char *pathname, u32 op)
 {
 
 	if (pathname[0] != '/' ||
-	    rule->listnr != AUDIT_FILTER_EXIT ||
+	    (rule->listnr != AUDIT_FILTER_EXIT &&
+	     rule->listnr != AUDIT_FILTER_URING_EXIT) ||
 	    op != Audit_equal ||
 	    rule->inode_f || rule->watch || rule->tree)
 		return -EINVAL;
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 2acf7ca49154..698b62b4a2ec 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -183,7 +183,8 @@ int audit_to_watch(struct audit_krule *krule, char *path, int len, u32 op)
 		return -EOPNOTSUPP;
 
 	if (path[0] != '/' || path[len-1] == '/' ||
-	    krule->listnr != AUDIT_FILTER_EXIT ||
+	    (krule->listnr != AUDIT_FILTER_EXIT &&
+	     krule->listnr != AUDIT_FILTER_URING_EXIT) ||
 	    op != Audit_equal ||
 	    krule->inode_f || krule->watch || krule->tree)
 		return -EINVAL;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index db2c6b59dfc3..d75acb014ccd 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -44,7 +44,8 @@ struct list_head audit_filter_list[AUDIT_NR_FILTERS] = {
 	LIST_HEAD_INIT(audit_filter_list[4]),
 	LIST_HEAD_INIT(audit_filter_list[5]),
 	LIST_HEAD_INIT(audit_filter_list[6]),
-#if AUDIT_NR_FILTERS != 7
+	LIST_HEAD_INIT(audit_filter_list[7]),
+#if AUDIT_NR_FILTERS != 8
 #error Fix audit_filter_list initialiser
 #endif
 };
@@ -56,6 +57,7 @@ static struct list_head audit_rules_list[AUDIT_NR_FILTERS] = {
 	LIST_HEAD_INIT(audit_rules_list[4]),
 	LIST_HEAD_INIT(audit_rules_list[5]),
 	LIST_HEAD_INIT(audit_rules_list[6]),
+	LIST_HEAD_INIT(audit_rules_list[7]),
 };
 
 DEFINE_MUTEX(audit_filter_mutex);
@@ -151,7 +153,8 @@ char *audit_unpack_string(void **bufp, size_t *remain, size_t len)
 static inline int audit_to_inode(struct audit_krule *krule,
 				 struct audit_field *f)
 {
-	if (krule->listnr != AUDIT_FILTER_EXIT ||
+	if ((krule->listnr != AUDIT_FILTER_EXIT &&
+	     krule->listnr != AUDIT_FILTER_URING_EXIT) ||
 	    krule->inode_f || krule->watch || krule->tree ||
 	    (f->op != Audit_equal && f->op != Audit_not_equal))
 		return -EINVAL;
@@ -248,6 +251,7 @@ static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *
 		pr_err("AUDIT_FILTER_ENTRY is deprecated\n");
 		goto exit_err;
 	case AUDIT_FILTER_EXIT:
+	case AUDIT_FILTER_URING_EXIT:
 	case AUDIT_FILTER_TASK:
 #endif
 	case AUDIT_FILTER_USER:
@@ -332,6 +336,10 @@ static int audit_field_valid(struct audit_entry *entry, struct audit_field *f)
 		if (entry->rule.listnr != AUDIT_FILTER_FS)
 			return -EINVAL;
 		break;
+	case AUDIT_PERM:
+		if (entry->rule.listnr == AUDIT_FILTER_URING_EXIT)
+			return -EINVAL;
+		break;
 	}
 
 	switch (entry->rule.listnr) {
@@ -980,7 +988,8 @@ static inline int audit_add_rule(struct audit_entry *entry)
 	}
 
 	entry->rule.prio = ~0ULL;
-	if (entry->rule.listnr == AUDIT_FILTER_EXIT) {
+	if (entry->rule.listnr == AUDIT_FILTER_EXIT ||
+	    entry->rule.listnr == AUDIT_FILTER_URING_EXIT) {
 		if (entry->rule.flags & AUDIT_FILTER_PREPEND)
 			entry->rule.prio = ++prio_high;
 		else
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 928f1dd12460..f4a2ca496cac 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -805,6 +805,35 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
 	return rule->mask[word] & bit;
 }
 
+/**
+ * audit_filter_uring - apply filters to an io_uring operation
+ * @tsk: associated task
+ * @ctx: audit context
+ */
+static void audit_filter_uring(struct task_struct *tsk,
+			       struct audit_context *ctx)
+{
+	struct audit_entry *e;
+	enum audit_state state;
+
+	if (auditd_test_task(tsk))
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_URING_EXIT],
+				list) {
+		if (audit_in_mask(&e->rule, ctx->uring_op) &&
+		    audit_filter_rules(tsk, &e->rule, ctx, NULL, &state,
+				       false)) {
+			rcu_read_unlock();
+			ctx->current_state = state;
+			return;
+		}
+	}
+	rcu_read_unlock();
+	return;
+}
+
 /* At syscall exit time, this filter is called if the audit_state is
  * not low enough that auditing cannot take place, but is also not
  * high enough that we already know we have to write an audit record
@@ -1765,7 +1794,7 @@ static void audit_log_exit(void)
  * __audit_free - free a per-task audit context
  * @tsk: task whose audit context block to free
  *
- * Called from copy_process and do_exit
+ * Called from copy_process, do_exit, and the io_uring code
  */
 void __audit_free(struct task_struct *tsk)
 {
@@ -1783,15 +1812,21 @@ void __audit_free(struct task_struct *tsk)
 	 * random task_struct that doesn't doesn't have any meaningful data we
 	 * need to log via audit_log_exit().
 	 */
-	if (tsk == current && !context->dummy &&
-	    context->context == AUDIT_CTX_SYSCALL) {
+	if (tsk == current && !context->dummy) {
 		context->return_valid = AUDITSC_INVALID;
 		context->return_code = 0;
-
-		audit_filter_syscall(tsk, context);
-		audit_filter_inodes(tsk, context);
-		if (context->current_state == AUDIT_STATE_RECORD)
-			audit_log_exit();
+		if (context->context == AUDIT_CTX_SYSCALL) {
+			audit_filter_syscall(tsk, context);
+			audit_filter_inodes(tsk, context);
+			if (context->current_state == AUDIT_STATE_RECORD)
+				audit_log_exit();
+		} else if (context->context == AUDIT_CTX_URING) {
+			/* TODO: verify this case is real and valid */
+			audit_filter_uring(tsk, context);
+			audit_filter_inodes(tsk, context);
+			if (context->current_state == AUDIT_STATE_RECORD)
+				audit_log_uring(context);
+		}
 	}
 
 	audit_set_context(tsk, NULL);
@@ -1875,12 +1910,6 @@ void __audit_uring_exit(int success, long code)
 {
 	struct audit_context *ctx = audit_context();
 
-	/*
-	 * TODO: At some point we will likely want to filter on io_uring ops
-	 *       and other things similar to what we do for syscalls, but that
-	 *       is something for another day; just record what we can here.
-	 */
-
 	if (ctx->context == AUDIT_CTX_SYSCALL) {
 		/*
 		 * NOTE: See the note in __audit_uring_entry() about the case
@@ -1903,6 +1932,8 @@ void __audit_uring_exit(int success, long code)
 		 * the behavior here.
 		 */
 		audit_filter_syscall(current, ctx);
+		if (ctx->current_state != AUDIT_STATE_RECORD)
+			audit_filter_uring(current, ctx);
 		audit_filter_inodes(current, ctx);
 		if (ctx->current_state != AUDIT_STATE_RECORD)
 			return;
@@ -1911,7 +1942,9 @@ void __audit_uring_exit(int success, long code)
 		return;
 	}
 #if 1
-	/* XXX - temporary hack to force record generation */
+	/* XXX - temporary hack to force record generation, we are leaving this
+	 *       enabled, but if you want to actually test the filtering you
+	 *       need to disable this #if/#endif block */
 	ctx->current_state = AUDIT_STATE_RECORD;
 #endif
 
@@ -1919,6 +1952,8 @@ void __audit_uring_exit(int success, long code)
 	if (!list_empty(&ctx->killed_trees))
 		audit_kill_trees(ctx);
 
+	/* run through both filters to ensure we set the filterkey properly */
+	audit_filter_uring(current, ctx);
 	audit_filter_inodes(current, ctx);
 	if (ctx->current_state != AUDIT_STATE_RECORD)
 		goto out;

