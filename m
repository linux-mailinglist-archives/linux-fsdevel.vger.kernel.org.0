Return-Path: <linux-fsdevel+bounces-79221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCpoFKDopmnjZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:56:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1831F0D94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15F57303CDA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DC5359A84;
	Tue,  3 Mar 2026 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbp37g3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721F34F259;
	Tue,  3 Mar 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545764; cv=none; b=qun1oeIm3Kdi8KecXnWQPiDJoXd0OKDnQwp8oQCqIpqbm8ohJmP+xmqpcECvBO/WBfgbRCpsYviivtjuaEZXtZ95z3tQC/04ks5feFYbiZ5uCme0+sjgPdsHSWftkbDPxT22pwJcJrYF6hOR/d615gg2t2BZeFmrDnrubgnLnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545764; c=relaxed/simple;
	bh=G9y+dlXKiv7XllPg95+Jn37I6Ds6wUEm0+HL1jfB7Y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6+odSaSdhD33q6LSRBE/HlXG9SGAG6CjexM440IQvU8uFx2DhPgceGmZkiQ6rH6Pk7+78a7iPq+QntG4yt9vb8IOAweLT8FNTA66yr+fOT3M6F2eGN9hhlx/jmouSBaxAMSRgGAJBN0LgvC9BwYmTvE9pBi4DN+7VNkyVppRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbp37g3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93470C116C6;
	Tue,  3 Mar 2026 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545763;
	bh=G9y+dlXKiv7XllPg95+Jn37I6Ds6wUEm0+HL1jfB7Y0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tbp37g3SW/FaxSbw3RmAR8ZKVVeS4XC1SgHv7xLaVVkJshBbd7t4hN5WB51rWX/oG
	 oz7BhvpcbXwI8r9hLNw/izFwijHNyHZmlzv7wUVr7GkvMVJvJ7LuFbvYH0E+zfQg6m
	 /oV+LqAALAi4+eMBsJ6m9SVHo7JR8WLdxb0dt686KlLR/BrA2UFBGCLqB45WCofIXG
	 fTou0DM9Sahlk7fUlTTaDaUxQaOchW+y/Y7NBjNmHQPTcpcYg/X3RwU8J434/JjTq2
	 AIq0FWNM3YvtzYsqevUa9nr1aYvFbAaeG1hU+iyPNw74MJ6iwpQRauv+MY41WgCr/R
	 KLc+8fijkl0qQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:12 +0100
Subject: [PATCH RFC DRAFT POC 01/11] kthread: refactor
 __kthread_create_on_node() to take a struct argument
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-1-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5798; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G9y+dlXKiv7XllPg95+Jn37I6Ds6wUEm0+HL1jfB7Y0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3YvZm1MpOPNStesz2IqB99nT9ZM3sHc+iRfZu7UA
 5NsJJ5IdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk2nWG/+HWz5iWmW2SWp4r
 aHpjSm6/5Zs5/R+f9zSJihfNvbHmojsjw4Z3qyyeel79efd19QQPCZ1FSiaahyN32mR/uc0eqfa
 7jw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 4A1831F0D94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79221-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Refactor __kthread_create_on_node() to take a const struct
kthread_create_info pointer instead of individual parameters. The
caller fills in the relevant fields in a stack-local struct and the
helper heap-copies it, making it trivial to add new kthread creation
options without changing the function signature.

As part of this, collapse __kthread_create_worker_on_node() into
__kthread_create_on_node() by adding a kthread_worker:1 bitfield to
struct kthread_create_info. When set, the unified helper allocates and
initializes the kthread_worker internally, removing the need for a
separate helper.

Also switch create_kthread() from the kernel_thread() wrapper to
constructing struct kernel_clone_args directly and calling
kernel_clone(). This makes the clone flags explicit and prepares for
passing richer per-kthread arguments through kernel_clone_args in
subsequent patches.

No functional change.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/kthread.c | 87 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 791210daf8b4..84d535c7a635 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -45,6 +45,7 @@ struct kthread_create_info
 	int (*threadfn)(void *data);
 	void *data;
 	int node;
+	u32 kthread_worker:1;
 
 	/* Result passed back to kthread_create() from kthreadd. */
 	struct task_struct *result;
@@ -451,13 +452,20 @@ int tsk_fork_get_node(struct task_struct *tsk)
 static void create_kthread(struct kthread_create_info *create)
 {
 	int pid;
+	struct kernel_clone_args args = {
+		.flags		= CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_UNTRACED,
+		.exit_signal	= SIGCHLD,
+		.fn		= kthread,
+		.fn_arg		= create,
+		.name		= create->full_name,
+		.kthread	= 1,
+	};
 
 #ifdef CONFIG_NUMA
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, create->full_name,
-			    CLONE_FS | CLONE_FILES | SIGCHLD);
+	pid = kernel_clone(&args);
 	if (pid < 0) {
 		/* Release the structure when caller killed by a fatal signal. */
 		struct completion *done = xchg(&create->done, NULL);
@@ -472,21 +480,32 @@ static void create_kthread(struct kthread_create_info *create)
 	}
 }
 
-static __printf(4, 0)
-struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
-						    void *data, int node,
+static struct task_struct *__kthread_create_on_node(const struct kthread_create_info *info,
 						    const char namefmt[],
 						    va_list args)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
+	struct kthread_worker *worker = NULL;
 	struct task_struct *task;
-	struct kthread_create_info *create = kmalloc_obj(*create);
+	struct kthread_create_info *create;
 
+	create = kmalloc_obj(*create);
 	if (!create)
 		return ERR_PTR(-ENOMEM);
-	create->threadfn = threadfn;
-	create->data = data;
-	create->node = node;
+
+	*create = *info;
+
+	if (create->kthread_worker) {
+		worker = kzalloc_obj(*worker);
+		if (!worker) {
+			kfree(create);
+			return ERR_PTR(-ENOMEM);
+		}
+		kthread_init_worker(worker);
+		create->threadfn = kthread_worker_fn;
+		create->data = worker;
+	}
+
 	create->done = &done;
 	create->full_name = kvasprintf(GFP_KERNEL, namefmt, args);
 	if (!create->full_name) {
@@ -520,6 +539,8 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	}
 	task = create->result;
 free_create:
+	if (IS_ERR(task))
+		kfree(worker);
 	kfree(create);
 	return task;
 }
@@ -552,11 +573,16 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 					   const char namefmt[],
 					   ...)
 {
+	struct kthread_create_info info = {
+		.threadfn	= threadfn,
+		.data		= data,
+		.node		= node,
+	};
 	struct task_struct *task;
 	va_list args;
 
 	va_start(args, namefmt);
-	task = __kthread_create_on_node(threadfn, data, node, namefmt, args);
+	task = __kthread_create_on_node(&info, namefmt, args);
 	va_end(args);
 
 	return task;
@@ -1045,34 +1071,6 @@ int kthread_worker_fn(void *worker_ptr)
 }
 EXPORT_SYMBOL_GPL(kthread_worker_fn);
 
-static __printf(3, 0) struct kthread_worker *
-__kthread_create_worker_on_node(unsigned int flags, int node,
-				const char namefmt[], va_list args)
-{
-	struct kthread_worker *worker;
-	struct task_struct *task;
-
-	worker = kzalloc_obj(*worker);
-	if (!worker)
-		return ERR_PTR(-ENOMEM);
-
-	kthread_init_worker(worker);
-
-	task = __kthread_create_on_node(kthread_worker_fn, worker,
-					node, namefmt, args);
-	if (IS_ERR(task))
-		goto fail_task;
-
-	worker->flags = flags;
-	worker->task = task;
-
-	return worker;
-
-fail_task:
-	kfree(worker);
-	return ERR_CAST(task);
-}
-
 /**
  * kthread_create_worker_on_node - create a kthread worker
  * @flags: flags modifying the default behavior of the worker
@@ -1086,13 +1084,24 @@ __kthread_create_worker_on_node(unsigned int flags, int node,
 struct kthread_worker *
 kthread_create_worker_on_node(unsigned int flags, int node, const char namefmt[], ...)
 {
+	struct kthread_create_info info = {
+		.node		= node,
+		.kthread_worker	= 1,
+	};
 	struct kthread_worker *worker;
+	struct task_struct *task;
 	va_list args;
 
 	va_start(args, namefmt);
-	worker = __kthread_create_worker_on_node(flags, node, namefmt, args);
+	task = __kthread_create_on_node(&info, namefmt, args);
 	va_end(args);
 
+	if (IS_ERR(task))
+		return ERR_CAST(task);
+
+	worker = kthread_data(task);
+	worker->flags = flags;
+	worker->task = task;
 	return worker;
 }
 EXPORT_SYMBOL(kthread_create_worker_on_node);

-- 
2.47.3


