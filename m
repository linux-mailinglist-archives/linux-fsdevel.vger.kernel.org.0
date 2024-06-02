Return-Path: <linux-fsdevel+bounces-20720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A78D731B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 04:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C414C1F217F3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 02:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30EA932;
	Sun,  2 Jun 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z97RSFnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC44C81;
	Sun,  2 Jun 2024 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717295910; cv=none; b=ao9kH9JYCe0iNoapbIiQrtEU7ozMHqd8gnKHhmWpQQAlW8j/4KuIDn6hC2++OBYvUSuMUNuhN8ymJiUsInpZTCYkdrGEihCvMhQaDp5OdAVfYNqAiXdsO33wIBu0Zc33s1przFe3StgKAmu7BXTYlckOaKr8qEN2Rj7EN4QrOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717295910; c=relaxed/simple;
	bh=CGWh4S8+r91SSRuLn3E71JJWKgrT+nzupvKqmDjon1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VXiQ6x6WkYiCP7HacmYX/gJRDbAvSQSsPwkOCq7kyfWlqtNhqvjzAHDAaT5KIiF6cgchyNBIc+oDqpbUKUsTKuVf9JXqrvfOamqSl0K23OlM+n8OX+ZKBpEQ7KgQ1hEzQJYLURltT7/XLBphL5BdoUBuFqHZGWIhzqBTi+0lbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z97RSFnx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6818e31e5baso2630174a12.1;
        Sat, 01 Jun 2024 19:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717295908; x=1717900708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4yHgpWtrekLlyiVlHlJ07YnG43AZ2I7wcs9NGubtp0=;
        b=Z97RSFnxcD20zapViDGJfi1H6KOSLbTSKGmBazpGUxpYaSWVDtdog759Rkh7SRgrjR
         zUV/Dwp/7m1787ldPU3JigLzKrCdmiI9i+x9+kwbIIarzjTNkys6zZQLmt1cPvct2Pj/
         NrHeJBRmK3Z10rjMsD2eeKy5MN5nFu+54C3qIi0LekOE/AEHC8wRplC9PkYfcgs4Cu+9
         MX3xOfTI7FaUZcirXDJXDFZMaFAan2Lg8CF+BfNwF4Z+OQ2DbhP0m4+kVuOM2Fz9ssIR
         Y475Z/Hzqq4hNxKMXoVDidjK0d3Y3FQTridHMKa0oadVkzvefbjdZDYGxQ25N5mfxp4I
         Gnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717295908; x=1717900708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4yHgpWtrekLlyiVlHlJ07YnG43AZ2I7wcs9NGubtp0=;
        b=SCgQQL02R2VFlcNCYiv7kuAjBZlb7IDVs2NUuBtuYloKfP2S+pcGOsmCsAuyZv1G+9
         KTGxrhe90/v7FuxEsbSCRnVILVSY4hsdubdFDrD8tRF3Ueue3jBf5lodQNOaswPDPTXL
         j9I1iV3qBA6FSmX6zr0PNiGVxknwNekbjkbWRSGVVMXGRJoSNI/qwv4ktUCNN/ijKI/M
         GqjdyupiYQLI9G4h6dFc/U/I+SmapEkh/eGAUCXLMvHJQ792z7+8usiSVgjpKLt6QTpP
         gnRjXu6k5hN5EW/eT+g4oL10sp30CjkwWXHKBOjIv6mBXVFzdd4jje7QYbb5/zNsATrK
         Kc+A==
X-Forwarded-Encrypted: i=1; AJvYcCXfB/IpMjtpP9lOCemmuwMO0HFlukr0DCJp3bU1ilS1wrdW1yI7jO1UVR6SVUoX2ADBg/RJuQY/v9yh3saQ8UCSJ98mhk52JOY1n+8QHyrJ94FmyftNc6ajoD0P8rnBjlxqHsQ8RT3UGVZNU2IcN8dEMS6b03iIGH04el3AlTC8cBDw6D/f42QkpnC+ciFVrVZ+F+KJ8v43hAwOzfHClE8f2Z7MBpvWNMzmttrwtQhrOzt9RT89RQv9BfVRuqGsXkHEsLyNNteHyMcwWMr9aIoKTXDgvECKgPauYZ89CQ==
X-Gm-Message-State: AOJu0YzUUHxH6yAx6GjILICyFvvS0QTYBapJu427O2Mqh54FxGP/NjYn
	a+3w4Dd6L/63YoRgbU+sA6CSqGESri1ChIpacY7FdyTNpyzyUcxZ
X-Google-Smtp-Source: AGHT+IE+a6Agoj8+Gjr8xAx8NUyto1//finy+7nb6g1z3TiLFFz5Bgij41khKDrpJ1UuLaT9z0xZDA==
X-Received: by 2002:a17:902:d4cc:b0:1f2:f1bf:cf44 with SMTP id d9443c01a7336-1f636fdebcamr71682625ad.6.1717295907785;
        Sat, 01 Jun 2024 19:38:27 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ea21csm39379575ad.202.2024.06.01.19.38.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2024 19:38:27 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
Date: Sun,  2 Jun 2024 10:37:50 +0800
Message-Id: <20240602023754.25443-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240602023754.25443-1-laoar.shao@gmail.com>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/tracepoint.h     |  4 ++--
 include/trace/events/block.h   | 10 +++++-----
 include/trace/events/oom.h     |  2 +-
 include/trace/events/osnoise.h |  2 +-
 include/trace/events/sched.h   | 27 ++++++++++++++-------------
 include/trace/events/signal.h  |  2 +-
 include/trace/events/task.h    |  4 ++--
 7 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 689b6d71590e..6381824d8107 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -519,10 +519,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *	*
  *
  *	TP_fast_assign(
- *		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+ *		__get_task_comm(__entry->next_comm, TASK_COMM_LEN, next);
  *		__entry->prev_pid	= prev->pid;
  *		__entry->prev_prio	= prev->prio;
- *		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+ *		__get_task_comm(__entry->prev_comm, TASK_COMM_LEN, prev);
  *		__entry->next_pid	= next->pid;
  *		__entry->next_prio	= next->prio;
  *	),
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..6f8c5d0014e6 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -193,7 +193,7 @@ DECLARE_EVENT_CLASS(block_rq,
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, current);
 	),
 
 	TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
@@ -328,7 +328,7 @@ DECLARE_EVENT_CLASS(block_bio,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, current);
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%s]",
@@ -415,7 +415,7 @@ TRACE_EVENT(block_plug,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, current);
 	),
 
 	TP_printk("[%s]", __entry->comm)
@@ -434,7 +434,7 @@ DECLARE_EVENT_CLASS(block_unplug,
 
 	TP_fast_assign(
 		__entry->nr_rq = depth;
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, current);
 	),
 
 	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
@@ -485,7 +485,7 @@ TRACE_EVENT(block_split,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->new_sector	= new_sector;
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, current);
 	),
 
 	TP_printk("%d,%d %s %llu / %llu [%s]",
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index b799f3bcba82..f29be9ebcd4d 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -23,7 +23,7 @@ TRACE_EVENT(oom_score_adj_update,
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, task);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 82f741ec0f57..50f480655722 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -20,7 +20,7 @@ TRACE_EVENT(thread_noise,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, t);
 		__entry->pid = t->pid;
 		__entry->start = start;
 		__entry->duration = duration;
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 68973f650c26..2a9d7c62c58a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -9,6 +9,7 @@
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
+#include <linux/sched.h>
 
 /*
  * Tracepoint for calling kthread_stop, performed to end a kthread:
@@ -25,7 +26,7 @@ TRACE_EVENT(sched_kthread_stop,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, t);
 		__entry->pid	= t->pid;
 	),
 
@@ -152,7 +153,7 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, p);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->target_cpu	= task_cpu(p);
@@ -239,11 +240,11 @@ TRACE_EVENT(sched_switch,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->next_comm, TASK_COMM_LEN, next);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
-		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->prev_comm, TASK_COMM_LEN, prev);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
@@ -286,7 +287,7 @@ TRACE_EVENT(sched_migrate_task,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, p);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->orig_cpu	= task_cpu(p);
@@ -311,7 +312,7 @@ DECLARE_EVENT_CLASS(sched_process_template,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, p);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 	),
@@ -357,7 +358,7 @@ TRACE_EVENT(sched_process_wait,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, current);
 		__entry->pid		= pid_nr(pid);
 		__entry->prio		= current->prio; /* XXX SCHED_DEADLINE */
 	),
@@ -383,9 +384,9 @@ TRACE_EVENT(sched_process_fork,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->parent_comm, parent->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->parent_comm, TASK_COMM_LEN, parent);
 		__entry->parent_pid	= parent->pid;
-		memcpy(__entry->child_comm, child->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->child_comm, TASK_COMM_LEN, child);
 		__entry->child_pid	= child->pid;
 	),
 
@@ -481,7 +482,7 @@ DECLARE_EVENT_CLASS_SCHEDSTAT(sched_stat_template,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, tsk);
 		__entry->pid	= tsk->pid;
 		__entry->delay	= delay;
 	),
@@ -539,7 +540,7 @@ DECLARE_EVENT_CLASS(sched_stat_runtime,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, tsk);
 		__entry->pid		= tsk->pid;
 		__entry->runtime	= runtime;
 	),
@@ -571,7 +572,7 @@ TRACE_EVENT(sched_pi_setprio,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, tsk);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
 		__entry->newprio	= pi_task ?
@@ -596,7 +597,7 @@ TRACE_EVENT(sched_process_hang,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, tsk);
 		__entry->pid = tsk->pid;
 	),
 
diff --git a/include/trace/events/signal.h b/include/trace/events/signal.h
index 1db7e4b07c01..8f317a265392 100644
--- a/include/trace/events/signal.h
+++ b/include/trace/events/signal.h
@@ -67,7 +67,7 @@ TRACE_EVENT(signal_generate,
 	TP_fast_assign(
 		__entry->sig	= sig;
 		TP_STORE_SIGINFO(__entry, info);
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, task);
 		__entry->pid	= task->pid;
 		__entry->group	= group;
 		__entry->result	= result;
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 47b527464d1a..77c14707460e 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -21,7 +21,7 @@ TRACE_EVENT(task_newtask,
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__get_task_comm(__entry->comm, TASK_COMM_LEN, task);
 		__entry->clone_flags = clone_flags;
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
@@ -46,7 +46,7 @@ TRACE_EVENT(task_rename,
 
 	TP_fast_assign(
 		__entry->pid = task->pid;
-		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
+		__get_task_comm(entry->oldcomm, TASK_COMM_LEN, task);
 		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
-- 
2.39.1


