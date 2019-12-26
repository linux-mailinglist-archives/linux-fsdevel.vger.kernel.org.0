Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16C12ACD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfLZOGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:06:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfLZOGJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:06:09 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC7D2053B;
        Thu, 26 Dec 2019 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369168;
        bh=TW+/7vNc36SSnwKKSLCacvAF6RIp14hMj4jNvVxbGiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9fFE8WQWKCctgehXzAMbT7b6VzKw8jnuKfYouQB1Mwrh9p2+wPL3MXJd2DugIBdx
         UMSQvrO3wRp6SpNQcDHT0HBFFkkkzG773S+E1T1TK7A081059I/6guVcStKTvICybX
         0BxcvRtaN90YzD1ZCK4WG829DM/g8av/ECuYTd+I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
Subject: [PATCH v5 11/22] tracing: kprobes: Output kprobe event to printk buffer
Date:   Thu, 26 Dec 2019 23:06:01 +0900
Message-Id: <157736916148.11126.2981069208289310860.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157736902773.11126.2531161235817081873.stgit@devnote2>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
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
 0 files changed

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4c6e15605766..5c94b8bacc88 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -216,6 +216,7 @@ struct trace_event_buffer {
 	void				*entry;
 	unsigned long			flags;
 	int				pc;
+	struct pt_regs			*regs;
 };
 
 void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 43f0f255ad66..970bac1299b5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2680,9 +2680,9 @@ void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
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
index a5b614cc3887..13446a3a7f1e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -272,6 +272,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	if (!fbuffer->event)
 		return NULL;
 
+	fbuffer->regs = NULL;
 	fbuffer->entry = ring_buffer_event_data(fbuffer->event);
 	return fbuffer->entry;
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7f890262c8a3..5899911a5720 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1175,10 +1175,8 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
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
@@ -1186,24 +1184,26 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
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
@@ -1223,10 +1223,8 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
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
@@ -1234,25 +1232,26 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
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

