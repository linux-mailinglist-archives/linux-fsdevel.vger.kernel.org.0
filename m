Return-Path: <linux-fsdevel+bounces-78492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMIyOi9UoGlLiQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:09:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 413971A73DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8FE3183FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34B3A0E9D;
	Thu, 26 Feb 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WErjZFeX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE4127F72C;
	Thu, 26 Feb 2026 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113873; cv=none; b=rv0qbEnzUejv0/aLudmRloplh7I3JwSTrL2l0aNFEnVAwTXFhoRCz/nxxLZ6zjt2LJUDSDVbFcUmq3iE4MIjFLnWUzC1g7NazJsK7xX5lRVq1oi+2jIM8pjTpIZY2arv5+m5zRSAuNQvTB+3VD5xmNqMeSxAF7i0lgjA6TxpDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113873; c=relaxed/simple;
	bh=oHaJZts+QrjYBNUL0bMFZBKLhJ1qXU7/bPzzxp7wO58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gviCAEGBhu54SkCmAUY/L+Hx+GuTe9WdH626ZGc+e4rPmKQLXYhhxR2KY9gM0extG2DwVl6ZZOUUVmAr6GYm1+zkrZA/8w5CNC0QrrpwjE53j/fcdXZQ8D3kkQdjxAtDjhxUBi5LtXcxCoku1O8Da71Za2lOpDerETXGCt6sCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WErjZFeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2E8C116C6;
	Thu, 26 Feb 2026 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113872;
	bh=oHaJZts+QrjYBNUL0bMFZBKLhJ1qXU7/bPzzxp7wO58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WErjZFeXdGKHyXShvVNqpaJVGu5gNaaJobXSBgnwQqxpcg1C3MRXVopPZfJ7lTSFe
	 qBhljkWfo86dxo3Jfo4IioKREgMVpXxId8a1v+SQBCWzmKWL6NyoU2dpdJ5bWWVOd9
	 WfVe7Y2ViK1uW5Rs3/6b1VkfuwIadEfI7JAMm8QxZFtGqX7Jj5u+givLjeqaL+83Nm
	 0NX5876s1om7x88DvR9Z9snQ6P3LbFEdA1lS/vu5CRUmSz1GXgk2Rj9JCs6twO7mAb
	 uz0CV4nlF83mY6bGNqo5hhXOcmICPin79uWOzP2PMOfZ8wWdpntm0dbFQ064jYsA5A
	 pvevy4awFA5lA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:50:59 +0100
Subject: [PATCH v5 1/6] clone: add CLONE_AUTOREAP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-pidfs-autoreap-v5-1-d148b984a989@kernel.org>
References: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
In-Reply-To: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5721; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oHaJZts+QrjYBNUL0bMFZBKLhJ1qXU7/bPzzxp7wO58=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8D/99W9EN6Obt2elWu2Wpoirs7XaDNw3BtzzWfhG4
 qDVlwl5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOp8WJkeDvV64iw8OEic/lr
 uj3K5Rq/1oadWDNV0zgwYJbAjpU3lBn+6X58L5t+kdtcXJ/11z6bU0vYl2z6qn1mrpLC3qM/jv+
 awA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-78492-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 413971A73DA
X-Rspamd-Action: no action

Add a new clone3() flag CLONE_AUTOREAP that makes a child process
auto-reap on exit without ever becoming a zombie. This is a per-process
property in contrast to the existing auto-reap mechanism via
SA_NOCLDWAIT or SIG_IGN for SIGCHLD which applies to all children of a
given parent.

Currently the only way to automatically reap children is to set
SA_NOCLDWAIT or SIG_IGN on SIGCHLD. This is a parent-scoped property
affecting all children which makes it unsuitable for libraries or
applications that need selective auto-reaping of specific children while
still being able to wait() on others.

CLONE_AUTOREAP stores an autoreap flag in the child's signal_struct.
When the child exits do_notify_parent() checks this flag and causes
exit_notify() to transition the task directly to EXIT_DEAD. Since the
flag lives on the child it survives reparenting: if the original parent
exits and the child is reparented to a subreaper or init the child still
auto-reaps when it eventually exits.

CLONE_AUTOREAP can be combined with CLONE_PIDFD to allow the parent to
monitor the child's exit via poll() and retrieve exit status via
PIDFD_GET_INFO. Without CLONE_PIDFD it provides a fire-and-forget
pattern where the parent simply doesn't care about the child's exit
status. No exit signal is delivered so exit_signal must be zero.

CLONE_AUTOREAP is rejected in combination with CLONE_PARENT. If a
CLONE_AUTOREAP child were to clone(CLONE_PARENT) the new grandchild
would inherit exit_signal == 0 from the autoreap parent's group leader
but without signal->autoreap. This grandchild would become a zombie that
never sends a signal and is never autoreaped - confusing and arguably
broken behavior.

The flag is not inherited by the autoreap process's own children. Each
child that should be autoreaped must be explicitly created with
CLONE_AUTOREAP.

Link: https://github.com/uapi-group/kernel-features/issues/45
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/sched/signal.h |  1 +
 include/uapi/linux/sched.h   |  1 +
 kernel/fork.c                | 14 +++++++++++++-
 kernel/ptrace.c              |  3 ++-
 kernel/signal.c              |  4 ++++
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index a22248aebcf9..f842c86b806f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -132,6 +132,7 @@ struct signal_struct {
 	 */
 	unsigned int		is_child_subreaper:1;
 	unsigned int		has_child_subreaper:1;
+	unsigned int		autoreap:1;
 
 #ifdef CONFIG_POSIX_TIMERS
 
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 359a14cc76a4..8a22ea640817 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,7 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_AUTOREAP 0x400000000ULL /* Auto-reap child on exit. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/kernel/fork.c b/kernel/fork.c
index e832da9d15a4..0dedf2999f0c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2028,6 +2028,15 @@ __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
+	if (clone_flags & CLONE_AUTOREAP) {
+		if (clone_flags & CLONE_THREAD)
+			return ERR_PTR(-EINVAL);
+		if (clone_flags & CLONE_PARENT)
+			return ERR_PTR(-EINVAL);
+		if (args->exit_signal)
+			return ERR_PTR(-EINVAL);
+	}
+
 	/*
 	 * Force any signals received before this point to be delivered
 	 * before the fork happens.  Collect up signals sent to multiple
@@ -2435,6 +2444,8 @@ __latent_entropy struct task_struct *copy_process(
 			 */
 			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
 							 p->real_parent->signal->is_child_subreaper;
+			if (clone_flags & CLONE_AUTOREAP)
+				p->signal->autoreap = 1;
 			list_add_tail(&p->sibling, &p->real_parent->children);
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
@@ -2897,7 +2908,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP |
+	      CLONE_AUTOREAP))
 		return false;
 
 	/*
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 392ec2f75f01..68c17daef8d4 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -549,7 +549,8 @@ static bool __ptrace_detach(struct task_struct *tracer, struct task_struct *p)
 	if (!dead && thread_group_empty(p)) {
 		if (!same_thread_group(p->real_parent, tracer))
 			dead = do_notify_parent(p, p->exit_signal);
-		else if (ignoring_children(tracer->sighand)) {
+		else if (ignoring_children(tracer->sighand) ||
+			 p->signal->autoreap) {
 			__wake_up_parent(p, tracer);
 			dead = true;
 		}
diff --git a/kernel/signal.c b/kernel/signal.c
index d65d0fe24bfb..e61f39fa8c8a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2251,6 +2251,10 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
 			sig = 0;
 	}
+	if (!tsk->ptrace && tsk->signal->autoreap) {
+		autoreap = true;
+		sig = 0;
+	}
 	/*
 	 * Send with __send_signal as si_pid and si_uid are in the
 	 * parent's namespaces.

-- 
2.47.3


