Return-Path: <linux-fsdevel+bounces-49559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E1FABEBED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 08:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCDD1B67D06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDB4235079;
	Wed, 21 May 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JNO5+HGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3238235049;
	Wed, 21 May 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747808648; cv=none; b=FTL77p91KSdNpMrNNyUOR00hAG3DWJcXUcKyR0G0tjZpPDMCYuFrlkJDysLs9MXQTqp/8yqOXkCJwf9IyfBIMCg9toYnGdB5Nj77VQDtxBnv/3TYnLWwqKUgUb6Wzi2SU1iSUZlH0eyBj7TWoJ1e7pQiXs8G/1vdemK12RfiMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747808648; c=relaxed/simple;
	bh=DtIhSG+eMDrB9z0amxyQUxZAA8kvUIc6nU10K2gv5oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+kxD3OmgWjsFV+VoQuPMliy9m39MngWSdwlUO0TatTl0RL22FjCVTzu7THdnX3Ggr5Cl9ZY0Qi1vmVD9dwYNERXfBqN+TFUdTFJswBGgUfVS8wdPhhQ9Ggfg/f4Ll4TdNts+/jAcJMnKmeDW8Tdy6gSbFz8hI1gE/1kc6BQ4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JNO5+HGL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pU6bSpYB8CPj1DDuT5mIS//XBcxXY2wc6q2aPeo4HGQ=; b=JNO5+HGL1Dc1zYmWHmB1rUUSLj
	piJFD554YV1qAOBwm3wP6JD+5CfsNkMhT+XL82pn9BmIorkyu77UykXUJcZ2bHjnswyiiAqn9FIBV
	84XLl24D6Z0Z13jPHWgTXdEQU4oJoQ5Oo5CjE/RSEmSqaK2pKhZUMWfOgZqPlocycfS0+U0B1OzS7
	ovvNEES1S0qW+oYB10H6pXwyF+4hehZZpsQEupxgUUrKaR/sZ8D9vOGY/YXvYhhLiMl/CRYT/T3K/
	dtRbhaqm+v6wcuH9m6mh1Wj6iqBggjjGMPrbE26GoBA0XXBqqVkoMzvZl/M3uzAoJ6kdaAJJ4NT2/
	KMNoufIw==;
Received: from [223.233.70.209] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uHcry-00B3oN-Ij; Wed, 21 May 2025 08:24:02 +0200
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
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm' to a more safer implementation
Date: Wed, 21 May 2025 11:53:36 +0530
Message-Id: <20250521062337.53262-3-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250521062337.53262-1-bhupesh@igalia.com>
References: <20250521062337.53262-1-bhupesh@igalia.com>
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
index 76e41805b92d..468abc308c24 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -54,7 +54,8 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
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
index ad36e73b8579..11aa0b58176d 100644
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
@@ -424,6 +426,7 @@ TRACE_EVENT(block_plug,
 
 	TP_fast_assign(
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("[%s]", __entry->comm)
@@ -443,6 +446,7 @@ DECLARE_EVENT_CLASS(block_unplug,
 	TP_fast_assign(
 		__entry->nr_rq = depth;
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->comm[TASK_COMM_LEN - 1] = '\0';
 	),
 
 	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
@@ -494,6 +498,7 @@ TRACE_EVENT(block_split,
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


