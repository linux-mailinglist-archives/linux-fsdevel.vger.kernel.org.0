Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E6A9C7AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfHZDQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDQz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:16:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A010621744;
        Mon, 26 Aug 2019 03:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789415;
        bh=i1sp1BbzKL5yrHW27AdY2EkJgx+nFs+u0ymGWoaZnoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfxJLv8Ehend5oNP3Te5VYWfudAIv9P86IvvQCbVWXJUuoVse9WUQjHqCSQEE6xzN
         R8SL19VsIfHDWKWuWHAwlX/S57Lkw1P14H+xtKfw46+3zg9ULb8XQAfiTvazb2/Y3w
         8mysXYFo6ObK/LoLbbiAAmI/7F3tfjWxqsWLP6Oo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 06/19] tracing: kprobes: Output kprobe event to printk buffer
Date:   Mon, 26 Aug 2019 12:16:49 +0900
Message-Id: <156678940919.21459.18266384720385228733.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156678933823.21459.4100380582025186209.stgit@devnote2>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since kprobe-events use event_trigger_unlock_commit_regs() directly,
that events doesn't show up in printk buffer if "tp_printk" is set.

Use trace_event_buffer_commit() in kprobe events so that it can
invoke output_printk() as same as other trace events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/trace_events.h |    1 +
 kernel/trace/trace.c         |    4 +--
 kernel/trace/trace_events.c  |    1 +
 kernel/trace/trace_kprobe.c  |   57 +++++++++++++++++++++---------------------
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5150436783e8..8912ccdb3d4b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -211,6 +211,7 @@ struct trace_event_buffer {
 	void				*entry;
 	unsigned long			flags;
 	int				pc;
+	struct pt_regs			*regs;
 };
 
 void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ead3a9faa584..605faf584164 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2572,9 +2572,9 @@ void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
 
-	event_trigger_unlock_commit(fbuffer->trace_file, fbuffer->buffer,
+	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
 				    fbuffer->event, fbuffer->entry,
-				    fbuffer->flags, fbuffer->pc);
+				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
 }
 EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c7506bc81b75..22cf08bd2317 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -271,6 +271,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	if (!fbuffer->event)
 		return NULL;
 
+	fbuffer->regs = NULL;
 	fbuffer->entry = ring_buffer_event_data(fbuffer->event);
 	return fbuffer->entry;
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d483ad9bb6c..6c5145525f90 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -988,10 +988,8 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 		    struct trace_event_file *trace_file)
 {
 	struct kprobe_trace_entry_head *entry;
-	struct ring_buffer_event *event;
-	struct ring_buffer *buffer;
-	int size, dsize, pc;
-	unsigned long irq_flags;
+	struct trace_event_buffer fbuffer;
+	int dsize;
 	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
 
 	WARN_ON(call != trace_file->event_call);
@@ -999,24 +997,26 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	local_save_flags(irq_flags);
-	pc = preempt_count();
+	local_save_flags(fbuffer.flags);
+	fbuffer.pc = preempt_count();
+	fbuffer.trace_file = trace_file;
 
 	dsize = __get_data_size(&tk->tp, regs);
-	size = sizeof(*entry) + tk->tp.size + dsize;
 
-	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
-						call->event.type,
-						size, irq_flags, pc);
-	if (!event)
+	fbuffer.event =
+		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
+					call->event.type,
+					sizeof(*entry) + tk->tp.size + dsize,
+					fbuffer.flags, fbuffer.pc);
+	if (!fbuffer.event)
 		return;
 
-	entry = ring_buffer_event_data(event);
+	fbuffer.regs = regs;
+	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
-	event_trigger_unlock_commit_regs(trace_file, buffer, event,
-					 entry, irq_flags, pc, regs);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
@@ -1036,10 +1036,8 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 		       struct trace_event_file *trace_file)
 {
 	struct kretprobe_trace_entry_head *entry;
-	struct ring_buffer_event *event;
-	struct ring_buffer *buffer;
-	int size, pc, dsize;
-	unsigned long irq_flags;
+	struct trace_event_buffer fbuffer;
+	int dsize;
 	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
 
 	WARN_ON(call != trace_file->event_call);
@@ -1047,25 +1045,26 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	local_save_flags(irq_flags);
-	pc = preempt_count();
+	local_save_flags(fbuffer.flags);
+	fbuffer.pc = preempt_count();
+	fbuffer.trace_file = trace_file;
 
 	dsize = __get_data_size(&tk->tp, regs);
-	size = sizeof(*entry) + tk->tp.size + dsize;
-
-	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
-						call->event.type,
-						size, irq_flags, pc);
-	if (!event)
+	fbuffer.event =
+		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
+					call->event.type,
+					sizeof(*entry) + tk->tp.size + dsize,
+					fbuffer.flags, fbuffer.pc);
+	if (!fbuffer.event)
 		return;
 
-	entry = ring_buffer_event_data(event);
+	fbuffer.regs = regs;
+	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
-	event_trigger_unlock_commit_regs(trace_file, buffer, event,
-					 entry, irq_flags, pc, regs);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 static void

