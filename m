Return-Path: <linux-fsdevel+bounces-77293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJsHEH4gk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:49:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C571441AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9287F30329A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FA8223339;
	Mon, 16 Feb 2026 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O81A/DTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497730EF97;
	Mon, 16 Feb 2026 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249748; cv=none; b=Y4t06IU0WmGMTYTVRloRfGvMRWyyQjP3ZbKCHyxMARUk+oQABRPk7Lb0nZJPUpsKKmGBMBOcP1Ly7nDHd6C6S21+PlZOCx/RuSUFNAOeyXDxkEplUuhImr3gmLwGqddZ7jjgSgQ+NeJtgX1omv3WNp4EnTMm1bn6iLTe6t8/xdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249748; c=relaxed/simple;
	bh=XMhMQ4UmOWsjLLe0c2QLCNNjrRibvwH2g1VICYfF4aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZp4B+O3J0+hIemI+0eYMLQtN1wR6DyZEPIXWuaECaTXBCrM90U6a97MDB5h5K7X4eLA3P3PAMHQylOHbE9H7jNS25T6Dj+X/Wza0JjgLpPJ8v6j4JxrwMptM4jJrwfYbejqNUOQKQ3R8j4wcWoCJuTJGyA4gdOBA9R8pZFh+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O81A/DTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BFAC116C6;
	Mon, 16 Feb 2026 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771249747;
	bh=XMhMQ4UmOWsjLLe0c2QLCNNjrRibvwH2g1VICYfF4aI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O81A/DTyHJtbIdHBD1CKjAIisTzxmik3wOrn5KJcm9CTNzkOg82TtTaNcuesDqzfv
	 7ArdJ8Gm9Gz88I1cp86UxvRpy7wn493d58UMVK5Ad30DL3Tf0yjs19Yf4/RKeV1YoP
	 ts+F3G3UF9RmyGrd+XwLv772KeVPmihtCIFqnUBjHNtV7nB1GbC7yXOEpVdQn8ZaP2
	 0nRo6CJdODLUKSGJ2DCrEsS3YLFbq5x+0IF3AB/7WolcrmM4SmI4ojQNiVqbX2fNm8
	 E6fJzKlWiwWbnHJnGSUKUCuqWaVPvcoh22bZ17LfMC2voDce2QyKN4dtWlfTOn1R/x
	 9CLCOHg1zERzg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:48:35 +0100
Subject: [PATCH RFC 1/2] clone: add CLONE_AUTOREAP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-pidfs-autoreap-v1-1-e63f663008f2@kernel.org>
References: <20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org>
In-Reply-To: <20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5641; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XMhMQ4UmOWsjLLe0c2QLCNNjrRibvwH2g1VICYfF4aI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROVvBnOhtyaZPpP0vG7i/Lpqsa3fy84JvIUV8/fbWP1
 1atTb3H1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLkOG/+GRZ35P+Fh55PCC
 Z/ceXF2/6++rwmfvXzsvOs9yci3H5c97Gf57WZpdTV7d9DA5V6i3X+r1+hnfXa69OKFtXaEgJyK
 76QkfAA==
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
	TAGGED_FROM(0.00)[bounces-77293-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91C571441AB
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
When the child exits do_notify_parent() checks this flag and returns
autoreap=true causing exit_notify() to transition the task directly to
EXIT_DEAD. Since the flag lives on the child it survives reparenting: if
the original parent exits and the child is reparented to a subreaper or
init the child still auto-reaps when it eventually exits.

CLONE_AUTOREAP requires CLONE_PIDFD because the process will never be
visible to wait(). The parent must use the pidfd to monitor exit via
poll() and retrieve exit status via PIDFD_GET_INFO. No exit signal is
delivered so exit_signal must be zero.

The flag is not inherited by the autoreap process's own children. Each
child that should be autoreaped must be explicitly created with
CLONE_AUTOREAP.

Link: https://github.com/uapi-group/kernel-features/issues/45
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/sched/signal.h |  1 +
 include/uapi/linux/sched.h   |  1 +
 kernel/fork.c                | 16 +++++++++++++++-
 kernel/ptrace.c              |  3 ++-
 kernel/signal.c              |  4 ++++
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7d6449982822..346ecbad4c2b 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -132,6 +132,7 @@ struct signal_struct {
 	 */
 	unsigned int		is_child_subreaper:1;
 	unsigned int		has_child_subreaper:1;
+	unsigned int		autoreap:1;
 
 #ifdef CONFIG_POSIX_TIMERS
 
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 359a14cc76a4..e6fc5ae621e2 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,7 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_AUTOREAP 0x400000000ULL /* Auto-reap child on exit, requires CLONE_PIDFD. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/kernel/fork.c b/kernel/fork.c
index 9c5effbdbdc1..a803bdad2805 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2028,6 +2028,15 @@ __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
+	if (clone_flags & CLONE_AUTOREAP) {
+		if (!(clone_flags & CLONE_PIDFD))
+			return ERR_PTR(-EINVAL);
+		if (clone_flags & CLONE_THREAD)
+			return ERR_PTR(-EINVAL);
+		if (args->exit_signal)
+			return ERR_PTR(-EINVAL);
+	}
+
 	/*
 	 * Force any signals received before this point to be delivered
 	 * before the fork happens.  Collect up signals sent to multiple
@@ -2374,6 +2383,8 @@ __latent_entropy struct task_struct *copy_process(
 		p->parent_exec_id = current->parent_exec_id;
 		if (clone_flags & CLONE_THREAD)
 			p->exit_signal = -1;
+		else if (clone_flags & CLONE_AUTOREAP)
+			p->exit_signal = 0;
 		else
 			p->exit_signal = current->group_leader->exit_signal;
 	} else {
@@ -2435,6 +2446,8 @@ __latent_entropy struct task_struct *copy_process(
 			 */
 			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
 							 p->real_parent->signal->is_child_subreaper;
+			if (clone_flags & CLONE_AUTOREAP)
+				p->signal->autoreap = 1;
 			list_add_tail(&p->sibling, &p->real_parent->children);
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
@@ -2897,7 +2910,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
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
index e42b8bd6922f..2fb206c84c07 100644
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


