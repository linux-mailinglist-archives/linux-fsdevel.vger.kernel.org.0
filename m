Return-Path: <linux-fsdevel+bounces-57253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B6FB1FF92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 08:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88590189AC47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57E2D97A0;
	Mon, 11 Aug 2025 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r1W/3gWT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2822D77F1;
	Mon, 11 Aug 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894817; cv=none; b=J7JPoO/vAgLcJaO2AmkOKQc0dj8LgdGynwAUortArmcqW3o7dSW88CnF1x9f7wu1gfHQ0zlCWq7ticSKRy/PsZlmkDfOCu2JIyObo6jGeNmRwE5PJFZv/Z6B3srYkNyw2Kn+6ejYSxciazADkTREVbi6bHJn+bI46XLDrG01c08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894817; c=relaxed/simple;
	bh=rc1bITCVNlHfS8AG5qXT+5Kgla+zoPabCKwl8khR1yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxG9yKMsmVpqjbwdyCddfp0VqGfbKw6SobR3XnVfGN1qoIOypMSrYsY+bKUTIt2VEoDUclAFU2SGiCBrc1dEyAJrIYj+egl0hMXESvt/Wf2OJTccMmWP4/SQdJSHeXw/h2+egZ2cjCPIjOmVF1yPyA5aufEwkRjYYrdhoPX3sek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r1W/3gWT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YI8nSK3pDhA4y88O+/crLV9isyigf3E4ksFRw5WalPw=; b=r1W/3gWTqyRMMsqIbXnpvu1YTY
	mNvmj0N2p3h4VAZzTA+RZ19LCE03vksvNVDVp5zcLVVn+H4oB4BZiVliZg/XFrvWv3a+iPSamfQDd
	RX8xUNIrQeyl4Dwm2A8QLn37dej56rc9LlXJdRuKsafh4EoZOIhuspusfQc8DCHKBLd8KrmTrbUON
	Ja9kjwDxGbcRpOxvYBYnyuz/yfzfNQn/Y8BomNw7/nekO1khxzIWn+1CZJ+3bHc0F4oDbKQGCPoZT
	ihzvyiyvGsYPRcgpzrj7nyGrUBXcEzAim0ahM8F8xDEgyr59H0ZloFDe9p3QgbHeNqopYh+RF1uNP
	3q/3e8qg==;
Received: from [223.233.69.163] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulMJ1-00Cdun-TF; Mon, 11 Aug 2025 08:46:52 +0200
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
	vschneid@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	kees@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v7 4/4] treewide: Switch memcpy() users of 'task->comm' to a more safer implementation
Date: Mon, 11 Aug 2025 12:16:09 +0530
Message-Id: <20250811064609.918593-5-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250811064609.918593-1-bhupesh@igalia.com>
References: <20250811064609.918593-1-bhupesh@igalia.com>
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

These should be rather calling a wrappper like "get_task_array()",
which is implemented as:

   static __always_inline void
       __cstr_array_copy(char *dst,
            const char *src, __kernel_size_t size)
   {
        memcpy(dst, src, size);
        dst[size] = 0;
   }

   #define get_task_array(dst,src) \
      __cstr_array_copy(dst, src, __must_be_array(dst))

The relevant 'memcpy()' users were identified using the following search
pattern:
 $ git grep 'memcpy.*->comm\>'

[1]. https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 include/linux/coredump.h                      |  2 +-
 include/linux/sched.h                         | 32 +++++++++++++++++++
 include/linux/tracepoint.h                    |  4 +--
 include/trace/events/block.h                  | 10 +++---
 include/trace/events/oom.h                    |  2 +-
 include/trace/events/osnoise.h                |  2 +-
 include/trace/events/sched.h                  | 13 ++++----
 include/trace/events/signal.h                 |  2 +-
 include/trace/events/task.h                   |  4 +--
 tools/bpf/bpftool/pids.c                      |  6 ++--
 .../bpf/test_kmods/bpf_testmod-events.h       |  2 +-
 11 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 68861da4cf7c..bcee0afc5eaf 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -54,7 +54,7 @@ extern void vfs_coredump(const kernel_siginfo_t *siginfo);
 	do {	\
 		char comm[TASK_COMM_LEN];	\
 		/* This will always be NUL terminated. */ \
-		memcpy(comm, current->comm, sizeof(comm)); \
+		get_task_array(comm, current->comm); \
 		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
 			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
 	} while (0)	\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 97ea2ac2a97a..6602ec132297 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1960,12 +1960,44 @@ extern void wake_up_new_task(struct task_struct *tsk);
 
 extern void kick_process(struct task_struct *tsk);
 
+/*
+ * - Why not use task_lock()?
+ *   User space can randomly change their names anyway, so locking for readers
+ *   doesn't make sense. For writers, locking is probably necessary, as a race
+ *   condition could lead to long-term mixed results.
+ *   The logic inside __set_task_comm() should ensure that the task comm is
+ *   always NUL-terminated and zero-padded. Therefore the race condition between
+ *   reader and writer is not an issue.
+ */
+
 extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
 #define set_task_comm(tsk, from) ({			\
 	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
 	__set_task_comm(tsk, from, false);		\
 })
 
+/*
+ * 'get_task_array' can be 'data-racy' in the destination and
+ * should not be used for cases where a 'stable NUL at the end'
+ * is needed. Its better to use strscpy and friends for such
+ * use-cases.
+ *
+ * It is suited mainly for a 'just copy comm to a constant-sized
+ * array' case - especially in performance sensitive use-cases,
+ * like tracing.
+ */
+
+static __always_inline void
+	__cstr_array_copy(char *dst, const char *src,
+			  __kernel_size_t size)
+{
+	memcpy(dst, src, size);
+	dst[size] = 0;
+}
+
+#define get_task_array(dst, src) \
+	__cstr_array_copy(dst, src, __must_be_array(dst))
+
 static __always_inline void scheduler_ipi(void)
 {
 	/*
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f8..40e04cb660ce 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -570,10 +570,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *	*
  *
  *	TP_fast_assign(
- *		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+ *		get_task_array(__entry->next_comm, next->comm);
  *		__entry->prev_pid	= prev->pid;
  *		__entry->prev_prio	= prev->prio;
- *		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+ *		get_task_array(__entry->prev_comm, prev->comm);
  *		__entry->next_pid	= next->pid;
  *		__entry->next_prio	= next->prio;
  *	),
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 6aa79e2d799c..de1fe35333fc 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -213,7 +213,7 @@ DECLARE_EVENT_CLASS(block_rq,
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, current->comm);
 	),
 
 	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u [%s]",
@@ -351,7 +351,7 @@ DECLARE_EVENT_CLASS(block_bio,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, current->comm);
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%s]",
@@ -434,7 +434,7 @@ TRACE_EVENT(block_plug,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, current->comm);
 	),
 
 	TP_printk("[%s]", __entry->comm)
@@ -453,7 +453,7 @@ DECLARE_EVENT_CLASS(block_unplug,
 
 	TP_fast_assign(
 		__entry->nr_rq = depth;
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, current->comm);
 	),
 
 	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
@@ -504,7 +504,7 @@ TRACE_EVENT(block_split,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->new_sector	= new_sector;
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, current->comm);
 	),
 
 	TP_printk("%d,%d %s %llu / %llu [%s]",
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 9f0a5d1482c4..31e5b7295188 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -23,7 +23,7 @@ TRACE_EVENT(oom_score_adj_update,
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, task->comm);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 3f4273623801..f67f8b5eca75 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -116,7 +116,7 @@ TRACE_EVENT(thread_noise,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, t->comm);
 		__entry->pid = t->pid;
 		__entry->start = start;
 		__entry->duration = duration;
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..66fe808f2654 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -152,7 +152,7 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, p->comm);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->target_cpu	= task_cpu(p);
@@ -237,11 +237,11 @@ TRACE_EVENT(sched_switch,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		get_task_array(__entry->prev_comm, prev->comm);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		get_task_array(__entry->next_comm, next->comm);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
@@ -346,7 +346,7 @@ TRACE_EVENT(sched_process_exit,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, p->comm);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->group_dead	= group_dead;
@@ -787,14 +787,13 @@ TRACE_EVENT(sched_skip_cpuset_numa,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, tsk->comm);
 		__entry->pid		 = task_pid_nr(tsk);
 		__entry->tgid		 = task_tgid_nr(tsk);
 		__entry->ngid		 = task_numa_group_id(tsk);
 		BUILD_BUG_ON(sizeof(nodemask_t) != \
 			     BITS_TO_LONGS(MAX_NUMNODES) * sizeof(long));
-		memcpy(__entry->mem_allowed, mem_allowed_ptr->bits,
-		       sizeof(__entry->mem_allowed));
+		get_task_array(__entry->mem_allowed, mem_allowed_ptr->bits);
 	),
 
 	TP_printk("comm=%s pid=%d tgid=%d ngid=%d mem_nodes_allowed=%*pbl",
diff --git a/include/trace/events/signal.h b/include/trace/events/signal.h
index 1db7e4b07c01..0681dc5ab1de 100644
--- a/include/trace/events/signal.h
+++ b/include/trace/events/signal.h
@@ -67,7 +67,7 @@ TRACE_EVENT(signal_generate,
 	TP_fast_assign(
 		__entry->sig	= sig;
 		TP_STORE_SIGINFO(__entry, info);
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, task->comm);
 		__entry->pid	= task->pid;
 		__entry->group	= group;
 		__entry->result	= result;
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index af535b053033..9553946943a6 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -21,7 +21,7 @@ TRACE_EVENT(task_newtask,
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, task->comm);
 		__entry->clone_flags = clone_flags;
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
@@ -44,7 +44,7 @@ TRACE_EVENT(task_rename,
 	),
 
 	TP_fast_assign(
-		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
+		get_task_array(entry->oldcomm, task->comm);
 		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 23f488cf1740..a5d339cb8ca3 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -53,8 +53,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		refs->refs = tmp;
 		ref = &refs->refs[refs->ref_cnt];
 		ref->pid = e->pid;
-		memcpy(ref->comm, e->comm, sizeof(ref->comm));
-		ref->comm[sizeof(ref->comm) - 1] = '\0';
+		get_task_array(ref->comm, e->comm);
 		refs->ref_cnt++;
 
 		return;
@@ -77,8 +76,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	}
 	ref = &refs->refs[0];
 	ref->pid = e->pid;
-	memcpy(ref->comm, e->comm, sizeof(ref->comm));
-	ref->comm[sizeof(ref->comm) - 1] = '\0';
+	get_task_array(ref->comm, e->comm);
 	refs->ref_cnt = 1;
 	refs->has_bpf_cookie = e->has_bpf_cookie;
 	refs->bpf_cookie = e->bpf_cookie;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
index aeef86b3da74..81880748550f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
@@ -20,7 +20,7 @@ TRACE_EVENT(bpf_testmod_test_read,
 	),
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		get_task_array(__entry->comm, task->comm);
 		__entry->off = ctx->off;
 		__entry->len = ctx->len;
 	),
-- 
2.38.1


