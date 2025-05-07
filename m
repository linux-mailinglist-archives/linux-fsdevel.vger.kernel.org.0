Return-Path: <linux-fsdevel+bounces-48350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB305AADCEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DC2985A4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B5235BFB;
	Wed,  7 May 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YiiUP5eQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AD220F4D;
	Wed,  7 May 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615918; cv=none; b=IDzXo8yCdbYUTjPjlvbopl+mT3HmyFdmSfnlW1/0i2ONEXC/r2B38GyJCA/e2wQUF4M7hSEqhF7Z7wx88aasegI9Z0KX2V9lW2tbTpAexXW6CshbWZTCiYlEn4cg9RWv9vebS/YKHLnVCmlYJVNLXPCPNlihwrWw/moc48qBeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615918; c=relaxed/simple;
	bh=e3aGZP70jxUNb+/lCFUVUQ4+81xhoV5u73X0xieaeFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NltG/ftFJsn0Yx/v30cFc6AAomc7oTF1wRsp5d+NQ2DGEcZJn1ESxau4/nFS3gwAxBa+/2QNeRWh5J+ry33dVtLQ2q9Vzm3UWbxneLBSF+owz/G2+hze8TMw4avIXJ3B5RHdl+Q35Vr0Iai4Kb+d6CslexcrSIyKX4xL3ZkzqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YiiUP5eQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WDkvWa3TSuFgagk4tHSvnu3aN8dyFDkVfMiKuLfeTvc=; b=YiiUP5eQmiRvA58V2urS/zA0/i
	lrhuXgQKnAoXV0QlYLqB7dnloSUu6KsWBSpQUJIi9WtRqfYxnD5y/aDxXUEqtRElGBt1wjkRtxJfz
	4II61sik1sB7z2u7cdwEnaESgdtdEHVAGIeHtU/qfe8myoWRXVzk+kd7TtRGWYvtj8Xjuqlx4/ivV
	/K1NyD/RZWnBduY0dymnxEkuJNIHplFhxhux5hWKuxI4i1BCejDjZysj26YBDmrk63IOi3tS85tN7
	ltg9pe4l7aAxEL4752bP3qMgD8j3VlyZEljXAFj0uDAf2PK+URJm4n7TujpbZpNZYU6uG2Ov9/vfd
	pc3yyTdg==;
Received: from [223.233.66.62] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uCcWa-004fhg-HR; Wed, 07 May 2025 13:05:11 +0200
From: Bhupesh <bhupesh@igalia.com>
To: akpm@linux-foundation.org
Cc: bhupesh@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	oliver.sang@intel.com,
	lkp@intel.com,
	laoar.shao@gmail.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl,
	peterz@infradead.org,
	willy@infradead.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	keescook@chromium.org,
	ebiederm@xmission.com,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Subject: [PATCH v3 2/3] treewide: Switch memcpy() users of 'task->comm' to a more safer implementation
Date: Wed,  7 May 2025 16:34:43 +0530
Message-Id: <20250507110444.963779-3-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250507110444.963779-1-bhupesh@igalia.com>
References: <20250507110444.963779-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Linus mentioned in [1], currently we have several memcpy() use-cases
which use 'current->comm' to copy the task name over to local copies.
For an example:

 ...
 char comm[TASK_COMM_LEN];
 memcpy(comm, current->comm, TASK_COMM_LEN);
 ...

These should be modified so that we can later implement approaches
to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
is a more modular way (follow-up patches do the same):

 ...
 char comm[TASK_COMM_LEN];
 memcpy(comm, current->comm, TASK_COMM_LEN);
 comm[TASK_COMM_LEN - 1] = 0;
 ...

The relevant 'memcpy()' users were identified using the following search
pattern:
 $ git grep 'memcpy.*->comm\>'

[1]. https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 include/linux/coredump.h       |  3 ++-
 include/trace/events/block.h   |  5 +++++
 include/trace/events/oom.h     |  1 +
 include/trace/events/osnoise.h |  1 +
 include/trace/events/sched.h   | 13 +++++++++++++
 include/trace/events/signal.h  |  1 +
 include/trace/events/task.h    |  2 ++
 7 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 77e6e195d1d6..058ae3f2bec8 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -53,7 +53,8 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
 	do {	\
 		char comm[TASK_COMM_LEN];	\
 		/* This will always be NUL terminated. */ \
-		memcpy(comm, current->comm, sizeof(comm)); \
+		memcpy(comm, current->comm, TASK_COMM_LEN); \
+		comm[TASK_COMM_LEN] = '\0'; \
 		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
 			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
 	} while (0)	\
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index bd0ea07338eb..94a941ac2034 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -214,6 +214,7 @@ DECLARE_EVENT_CLASS(block_rq,
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u [%s]",
@@ -352,6 +353,7 @@ DECLARE_EVENT_CLASS(block_bio,
 		__entry->nr_sector	= bio_sectors(bio);
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%s]",
@@ -439,6 +441,7 @@ TRACE_EVENT(block_plug,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("[%s]", __entry->comm)
@@ -458,6 +461,7 @@ DECLARE_EVENT_CLASS(block_unplug,
 	TP_fast_assign(
 		__entry->nr_rq = depth;
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
@@ -509,6 +513,7 @@ TRACE_EVENT(block_split,
 		__entry->new_sector	= new_sector;
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("%d,%d %s %llu / %llu [%s]",
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 9f0a5d1482c4..a5641ed4285f 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -24,6 +24,7 @@ TRACE_EVENT(oom_score_adj_update,
 	TP_fast_assign(
 		__entry->pid = task->pid;
 		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 3f4273623801..0321b3f8d532 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -117,6 +117,7 @@ TRACE_EVENT(thread_noise,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid = t->pid;
 		__entry->start = start;
 		__entry->duration = duration;
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97d86c1..3126d44c43ee 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -26,6 +26,7 @@ TRACE_EVENT(sched_kthread_stop,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid	= t->pid;
 	),
 
@@ -153,6 +154,7 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->target_cpu	= task_cpu(p);
@@ -238,10 +240,12 @@ TRACE_EVENT(sched_switch,
 
 	TP_fast_assign(
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
 		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		__entry->next_comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
@@ -285,6 +289,7 @@ TRACE_EVENT(sched_migrate_task,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->orig_cpu	= task_cpu(p);
@@ -310,6 +315,7 @@ DECLARE_EVENT_CLASS(sched_process_template,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 	),
@@ -356,6 +362,7 @@ TRACE_EVENT(sched_process_wait,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid		= pid_nr(pid);
 		__entry->prio		= current->prio; /* XXX SCHED_DEADLINE */
 	),
@@ -382,8 +389,10 @@ TRACE_EVENT(sched_process_fork,
 
 	TP_fast_assign(
 		memcpy(__entry->parent_comm, parent->comm, TASK_COMM_LEN);
+		__entry->parent_comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->parent_pid	= parent->pid;
 		memcpy(__entry->child_comm, child->comm, TASK_COMM_LEN);
+		__entry->child_comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->child_pid	= child->pid;
 	),
 
@@ -480,6 +489,7 @@ DECLARE_EVENT_CLASS_SCHEDSTAT(sched_stat_template,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid	= tsk->pid;
 		__entry->delay	= delay;
 	),
@@ -538,6 +548,7 @@ DECLARE_EVENT_CLASS(sched_stat_runtime,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid		= tsk->pid;
 		__entry->runtime	= runtime;
 	),
@@ -570,6 +581,7 @@ TRACE_EVENT(sched_pi_setprio,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
 		__entry->newprio	= pi_task ?
@@ -595,6 +607,7 @@ TRACE_EVENT(sched_process_hang,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid = tsk->pid;
 	),
 
diff --git a/include/trace/events/signal.h b/include/trace/events/signal.h
index 1db7e4b07c01..7f490e553db5 100644
--- a/include/trace/events/signal.h
+++ b/include/trace/events/signal.h
@@ -68,6 +68,7 @@ TRACE_EVENT(signal_generate,
 		__entry->sig	= sig;
 		TP_STORE_SIGINFO(__entry, info);
 		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->pid	= task->pid;
 		__entry->group	= group;
 		__entry->result	= result;
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index af535b053033..4ddf21b69372 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -22,6 +22,7 @@ TRACE_EVENT(task_newtask,
 	TP_fast_assign(
 		__entry->pid = task->pid;
 		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 		__entry->clone_flags = clone_flags;
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
@@ -45,6 +46,7 @@ TRACE_EVENT(task_rename,
 
 	TP_fast_assign(
 		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
+		entry->oldcomm[TASK_COMM_LEN - 1] = '\0';
 		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
-- 
2.38.1


