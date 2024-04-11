Return-Path: <linux-fsdevel+bounces-16662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B388A0F39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602EB1F2666E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC94146586;
	Thu, 11 Apr 2024 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJtvKh72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FE14601B
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830926; cv=none; b=VRYYJ1UP6RHBRHIc6D5ViQuKX6cK1aZZiFFv8HJ3rTHXRBc5qwzU4N96AaaKr7Zv+MWyIhEhGvXXqTF3swWglEfo++KdSUhoRXpRO/R1kovU385NEiT+8qg0jMpZ72DjwdclXdkX/T0zJ5x12C700jrP46W8NQDZ6zfUNzo5zbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830926; c=relaxed/simple;
	bh=kwjGtNvLpK325ZnrzYNhpHBo59AhLmuaGY0i7QoIDKs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HFj8ezUafP3jPxzlyw3ITRA2xdvhQvrPL+aPLWRlhDJULJevqpa0kzdDESfq+8HovRjHJ8/FLl5ldO/yIgbLnAI5Gamc19TNygCUyBxaYLbNb8TF5Jz3ukAFWBHRuNWzr9v5TGE9xqbeQ1hqIGp2Umm6Usa5EnqJ36iuMChGPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJtvKh72; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a51a2113040so343164366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 03:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712830923; x=1713435723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+rR9HIwFgg/0oSpb0w3lX+KECeC+/l7rF3yPb/nkNJ0=;
        b=UJtvKh72FY0JKCgLC7XKqPpkHTMXqKfhlej8TUr/dhEtFPjcok9sFMi9wKlnSjq22R
         ln/b+k57z8Bu3tY0f+fPiD1lL0dZy7xC9X4ZGR1/wzB0NJ85KsOFkF7cSMnzscYKYk4F
         G5ODG9kH3ZWjiMQUaQ0ZE1UO5Lqds5ayLc/ZRw+pIJGJREiO5/4pfVkZM0Ycg2M2oD+w
         IvAhTVZj5B5TxBUEZz56oarrEvmF0+VQo4uIi331EFsJA2E0D/2VWVjv85Cy2SMQi7R7
         qLY1xMDZpb0sN3VS+jICF/jcw8tDXMRdFjKRnoHf9ETOyMAEP/m6XCKaVFJ6aYg9v0xk
         i2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712830923; x=1713435723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rR9HIwFgg/0oSpb0w3lX+KECeC+/l7rF3yPb/nkNJ0=;
        b=wtINbeX/xg/ZiQDJjhnm9f4BRjHR9f8/brh95un3SJzlMlSslMUEGdtvMxeGSkwqFY
         d0FraI/mDCGJGN8ugC2ARVdfk4VqiWHbJvpyt3R5PAHKT38vSETVoc6vkdw3jC3jiSxa
         nDkXaw9a7Hlia6qASmT0L6nFtd057jHqs7O1DGo8W/YRIUEpzXI9xyLAeRAiagOek0W3
         IdGOPklmopagqJH5RJBpcTLB3vFOA3B4LhetccRHDcW4RY/I3rhgeF4XsH+8/DK+/urF
         J4sq+MrpF8tr/x/XQJ1A/aJO+hWsDX1ozs/Q4yd1mNkkgMS3jXFjx2kAY05iQx6u2BfS
         v7uA==
X-Forwarded-Encrypted: i=1; AJvYcCWpTZtu3e1nDc9ZVq8Iq7xxiOLsjmXw3RlLxPBmEscLLvM8XXQhsbVq0KklXwGruggiYvfED9g0m6dukOhWaPNMkgnfqG4P5sPiQJQRNA==
X-Gm-Message-State: AOJu0YzvOz5hHe5xlT88E2mL91fFoem06UyWsWpsL2l/3XvMQZEprT0t
	Qeg0uCwzo8zqSkUjKr4cWg/vBhmMwRcxlUz1qfUBbMWIMxo8ghDBShJuFRfuW3gj3Xfg1wfcMQ=
	=
X-Google-Smtp-Source: AGHT+IFXG6iOFjgVBIzBx0eWBP5cDueeQuL6me8jmVrtbOPiz1Cb0gwJMrq43P1HgLFWtX3oaOdfw2/1NQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:5b29:b86f:ece8:1df5])
 (user=elver job=sendgmr) by 2002:a17:906:857:b0:a51:abd7:85a5 with SMTP id
 f23-20020a170906085700b00a51abd785a5mr4613ejd.15.1712830922433; Thu, 11 Apr
 2024 03:22:02 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:20:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240411102158.1272267-1-elver@google.com>
Subject: [PATCH v2] tracing: Add sched_prepare_exec tracepoint
From: Marco Elver <elver@google.com>
To: elver@google.com, Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Add "sched_prepare_exec" tracepoint, which is run right after the point
of no return but before the current task assumes its new exec identity.

Unlike the tracepoint "sched_process_exec", the "sched_prepare_exec"
tracepoint runs before flushing the old exec, i.e. while the task still
has the original state (such as original MM), but when the new exec
either succeeds or crashes (but never returns to the original exec).

Being able to trace this event can be helpful in a number of use cases:

  * allowing tracing eBPF programs access to the original MM on exec,
    before current->mm is replaced;
  * counting exec in the original task (via perf event);
  * profiling flush time ("sched_prepare_exec" to "sched_process_exec").

Example of tracing output:

 $ cat /sys/kernel/debug/tracing/trace_pipe
    <...>-379  [003] .....  179.626921: sched_prepare_exec: interp=/usr/bin/sshd filename=/usr/bin/sshd pid=379 comm=sshd
    <...>-381  [002] .....  180.048580: sched_prepare_exec: interp=/bin/bash filename=/bin/bash pid=381 comm=sshd
    <...>-385  [001] .....  180.068277: sched_prepare_exec: interp=/usr/bin/tty filename=/usr/bin/tty pid=385 comm=bash
    <...>-389  [006] .....  192.020147: sched_prepare_exec: interp=/usr/bin/dmesg filename=/usr/bin/dmesg pid=389 comm=bash

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Add more documentation.
* Also show bprm->interp in trace.
* Rename to sched_prepare_exec.
---
 fs/exec.c                    |  8 ++++++++
 include/trace/events/sched.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 38bf71cbdf5e..57fee729dd92 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1268,6 +1268,14 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		return retval;
 
+	/*
+	 * This tracepoint marks the point before flushing the old exec where
+	 * the current task is still unchanged, but errors are fatal (point of
+	 * no return). The later "sched_process_exec" tracepoint is called after
+	 * the current task has successfully switched to the new exec.
+	 */
+	trace_sched_prepare_exec(current, bprm);
+
 	/*
 	 * Ensure all future errors are fatal.
 	 */
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..226f47c6939c 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -420,6 +420,41 @@ TRACE_EVENT(sched_process_exec,
 		  __entry->pid, __entry->old_pid)
 );
 
+/**
+ * sched_prepare_exec - called before setting up new exec
+ * @task:	pointer to the current task
+ * @bprm:	pointer to linux_binprm used for new exec
+ *
+ * Called before flushing the old exec, where @task is still unchanged, but at
+ * the point of no return during switching to the new exec. At the point it is
+ * called the exec will either succeed, or on failure terminate the task. Also
+ * see the "sched_process_exec" tracepoint, which is called right after @task
+ * has successfully switched to the new exec.
+ */
+TRACE_EVENT(sched_prepare_exec,
+
+	TP_PROTO(struct task_struct *task, struct linux_binprm *bprm),
+
+	TP_ARGS(task, bprm),
+
+	TP_STRUCT__entry(
+		__string(	interp,		bprm->interp	)
+		__string(	filename,	bprm->filename	)
+		__field(	pid_t,		pid		)
+		__string(	comm,		task->comm	)
+	),
+
+	TP_fast_assign(
+		__assign_str(interp, bprm->interp);
+		__assign_str(filename, bprm->filename);
+		__entry->pid = task->pid;
+		__assign_str(comm, task->comm);
+	),
+
+	TP_printk("interp=%s filename=%s pid=%d comm=%s",
+		  __get_str(interp), __get_str(filename),
+		  __entry->pid, __get_str(comm))
+);
 
 #ifdef CONFIG_SCHEDSTATS
 #define DEFINE_EVENT_SCHEDSTAT DEFINE_EVENT
-- 
2.44.0.478.gd926399ef9-goog


