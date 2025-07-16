Return-Path: <linux-fsdevel+bounces-55153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D1B075E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C0E58103E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745D2F5464;
	Wed, 16 Jul 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ajr6j1qq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E02F49F2;
	Wed, 16 Jul 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669598; cv=none; b=BEqnjj+FuFRXAzP48A53IlUE9NPOaRZxSQz+O3fLdBDGvwp1NxkHl//rdKrw1HUWpeWpYid8+hSAfqODzrnEtWPUYJdo9aNrI4d3v7qWO0NdYWz0h0iY+7wOjmsV+rlnf9LgoOemw1YT+xsEpGo3qo8ybpieovTmWUmv3NZfa6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669598; c=relaxed/simple;
	bh=q6NbmV5Vkm0GWMQ5LrGY2F46f2nbE24gIOrs7R/wTTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWa22mEoFb6qHPUL7GwtscoL7r8REB6AdAb+k7TDSTrqsQK1gUInCwnErdr1ChoIAyGX1ax2uhiYqNeNeP8tj/w1rCObQzAnQzuWqRVE6ksgeaS8HtPNNMLyTR2NoRvQo6wYtvADth66r/BhgeL4vAnBI+pe/CbsvSQ/2FSEEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ajr6j1qq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7545PxSU3H8wsmqj1aWHbhRHAR8cl6QGaO7WkNQ7B9w=; b=Ajr6j1qqs0S/ebhxkZLQQJ016a
	SnCHRX8mdHXCJSuPsWYWO8xbXqk/RHKsVOQ7ryhtl43V8kvB+mtoQvawQlabLWcjGC1QKgGoSeqye
	5E6CnXqoLv+rarhANSYe48QDglFW4/BgiAFKwG0JoIcfIGM4wTcRHrxBlp1DQzGkA3EGa39wFqll3
	AHVKV7EpzacuRA8Zd1+hwCYHjuHgZVaaiXx+3KsUWj/HzRlO+M0r35lgpQPLRJWevw0TGei0uU34a
	XsA2GCU4OZ8I6MBBNND6n/2OIK1JgqiZthWdqQyIte9Ed+jhn/bN9ODbHY+r6zyCpdTzhzxrWJbmt
	yaByql+Q==;
Received: from [223.233.66.171] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uc1QO-00HJWV-46; Wed, 16 Jul 2025 14:39:52 +0200
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
Subject: [PATCH v5 2/3] treewide: Switch memcpy() users of 'task->comm' to a more safer implementation
Date: Wed, 16 Jul 2025 18:09:15 +0530
Message-Id: <20250716123916.511889-3-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250716123916.511889-1-bhupesh@igalia.com>
References: <20250716123916.511889-1-bhupesh@igalia.com>
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
in a more modular way (follow-up patch does the same):

 ...
 char comm[TASK_COMM_LEN];
 memcpy(comm, current->comm, TASK_COMM_LEN);
 comm[TASK_COMM_LEN - 1] = '\0';
 ...

The relevant 'memcpy()' users were identified using the following search
pattern:
 $ git grep 'memcpy.*->comm\>'

[1]. https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 include/linux/coredump.h       | 3 ++-
 include/trace/events/block.h   | 5 +++++
 include/trace/events/oom.h     | 1 +
 include/trace/events/osnoise.h | 1 +
 include/trace/events/signal.h  | 1 +
 include/trace/events/task.h    | 2 ++
 6 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 68861da4cf7c..988b233dcc09 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -54,7 +54,8 @@ extern void vfs_coredump(const kernel_siginfo_t *siginfo);
 	do {	\
 		char comm[TASK_COMM_LEN];	\
 		/* This will always be NUL terminated. */ \
-		memcpy(comm, current->comm, sizeof(comm)); \
+		memcpy(comm, current->comm, TASK_COMM_LEN); \
+		comm[TASK_COMM_LEN - 1] = '\0'; \
 		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
 			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
 	} while (0)	\
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 3e582d5e3a57..af40096a7114 100644
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
@@ -435,6 +437,7 @@ TRACE_EVENT(block_plug,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("[%s]", __entry->comm)
@@ -454,6 +457,7 @@ DECLARE_EVENT_CLASS(block_unplug,
 	TP_fast_assign(
 		__entry->nr_rq = depth;
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
@@ -505,6 +509,7 @@ TRACE_EVENT(block_split,
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


