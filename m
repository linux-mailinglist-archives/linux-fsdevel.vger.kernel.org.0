Return-Path: <linux-fsdevel+bounces-16353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC60989BB21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441561F20EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550E3BBF9;
	Mon,  8 Apr 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTzLQuKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E063BBDB
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566970; cv=none; b=iPUMDMWWC2ZWDUD8bFa0ZHX3JtD4f7wVe5gLZUct3StRC5e50n2ZY5fnSD3hniNqCi8AJTYwm+1lY6xoLzCLd+zLzpeVu2fWQugCqZVjHjZ19nKa0dxxXS85z0/5kdL7fO6NtuNz4P4fNgswfdEMwHcgAwlaTYEbovs5VZNrRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566970; c=relaxed/simple;
	bh=aVuKcbnpYY4FjU+CNW2JrarqfTioWso04jtw3oU+lTI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qVqgmymIk4dxMnNhTPJEWhe1zJUvWRFJhD7Hkbj4oRiIkMWM0fT0GJ1RAwkgx3n4huBqZivFIJsH0UtfdVLz7IZHABbn5uQT/1n9EfzIE+fUotxKf0YPUvx1x7TiTxgzh/VJ8lVM9aPFWuqWad6xs3CGMW4/Cx3KxBT6b+RE/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTzLQuKB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so6550461276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712566967; x=1713171767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dRUfOG22gFtzSxXckMYpwWSYVbuVuH++MvjmfSoLS8Y=;
        b=LTzLQuKBm8g7OHxnQdc0+7vk/JxEO9pIvGEIpIY9Qv3Pp4ikHBvaIYm6Cy7ggG0/92
         kzxeF7ctzHX+UrhFvnfBx0ik7SAEvAFpNyR6JiJGArUqqx6WvHytqCRKvJuGFxbvA9Cv
         NcOmnj3cWGsroecHaTyDmKfk8c9OXiwR0bOeW9n1nkf16P6qJ0y4B5+yZMzUtHoeyvsZ
         uZ0/FQQw3URmaL3m4LsZgzl+WhkOCcix74EGIlvZeTBClEeBqyfKg7PJVksc229yhln5
         el3atGe0wU2ZuH2FlKwnJC7EJ8cl0hMGgobLV81DCEBR+F0W2EIslSTcBBjewRMJy7xh
         IMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566967; x=1713171767;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRUfOG22gFtzSxXckMYpwWSYVbuVuH++MvjmfSoLS8Y=;
        b=EEuVhpK/O+Ac6pR+4igpegWo32ZajsqvkN57Ov+zTKtcqa552Vj3oFRRboPyjo1MOz
         9zyzcA33TLNacffDt1X0HubJlx2d4flGa8HQup5YuZA+HNpJeN62F6OwsjmZROsXEC4Q
         0teQOO4w9gHSZYZPTLo7eeJUuHBCTJ9x9v3HEbkc1fYMjByb7N3rbeu4me0EElzjjHvX
         7AtQr3LN4sDG00QDMxi42nJ1lL6i11mArtGdJyReLnbw99rWj1hW5uIqSy9A88yrg/e0
         Uo6lrvcyqWRNQsZBujuKcfTlxU2C/aRSi7qQLLK20tMqDgc6vpR71fDMX7q6gWTcEFyQ
         CDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1A0Hi6mQLrSlC7GYpzUzVZEmKxEsI5Gz3QpongwV5K8D2ECpI3K4Hvuu+gnnyudlJgKZsLIgkmqWdxAeplscT2l0F9HEUR2Jh0lNsJw==
X-Gm-Message-State: AOJu0Yx0e05ppwBux9J7MiCRwj75eB7+PIz9izT5jfYUqECjVQ5nJ8Md
	HSgOoItqliCroTvxJsrHncpSdBiJQjHLsG5IaIJZlmR0GLxI2B0pBrFJDZ5R4nWa8VJp/up/yA=
	=
X-Google-Smtp-Source: AGHT+IF7fNc9CfA3rN0FPE5cCB/FJRCFpa71D/Uyw6NdHdjHjjwDmKUZCoP0gpqMqi3bqfDBxO1+PAF/cA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:ea4d:dc81:62c5:eeb9])
 (user=elver job=sendgmr) by 2002:a05:6902:c09:b0:dcd:b431:7f5b with SMTP id
 fs9-20020a0569020c0900b00dcdb4317f5bmr2823872ybb.0.1712566967683; Mon, 08 Apr
 2024 02:02:47 -0700 (PDT)
Date: Mon,  8 Apr 2024 11:01:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408090205.3714934-1-elver@google.com>
Subject: [PATCH] tracing: Add new_exec tracepoint
From: Marco Elver <elver@google.com>
To: elver@google.com, Steven Rostedt <rostedt@goodmis.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Add "new_exec" tracepoint, which is run right after the point of no
return but before the current task assumes its new exec identity.

Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
runs before flushing the old exec, i.e. while the task still has the
original state (such as original MM), but when the new exec either
succeeds or crashes (but never returns to the original exec).

Being able to trace this event can be helpful in a number of use cases:

  * allowing tracing eBPF programs access to the original MM on exec,
    before current->mm is replaced;
  * counting exec in the original task (via perf event);
  * profiling flush time ("new_exec" to "sched_process_exec").

Example of tracing output ("new_exec" and "sched_process_exec"):

  $ cat /sys/kernel/debug/tracing/trace_pipe
      <...>-379     [003] .....   179.626921: new_exec: filename=/usr/bin/sshd pid=379 comm=sshd
      <...>-379     [003] .....   179.629131: sched_process_exec: filename=/usr/bin/sshd pid=379 old_pid=379
      <...>-381     [002] .....   180.048580: new_exec: filename=/bin/bash pid=381 comm=sshd
      <...>-381     [002] .....   180.053122: sched_process_exec: filename=/bin/bash pid=381 old_pid=381
      <...>-385     [001] .....   180.068277: new_exec: filename=/usr/bin/tty pid=385 comm=bash
      <...>-385     [001] .....   180.069485: sched_process_exec: filename=/usr/bin/tty pid=385 old_pid=385
      <...>-389     [006] .....   192.020147: new_exec: filename=/usr/bin/dmesg pid=389 comm=bash
       bash-389     [006] .....   192.021377: sched_process_exec: filename=/usr/bin/dmesg pid=389 old_pid=389

Signed-off-by: Marco Elver <elver@google.com>
---
 fs/exec.c                   |  2 ++
 include/trace/events/task.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 38bf71cbdf5e..ab778ae1fc06 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1268,6 +1268,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		return retval;
 
+	trace_new_exec(current, bprm);
+
 	/*
 	 * Ensure all future errors are fatal.
 	 */
diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 47b527464d1a..8853dc44783d 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -56,6 +56,36 @@ TRACE_EVENT(task_rename,
 		__entry->newcomm, __entry->oom_score_adj)
 );
 
+/**
+ * new_exec - called before setting up new exec
+ * @task:	pointer to the current task
+ * @bprm:	pointer to linux_binprm used for new exec
+ *
+ * Called before flushing the old exec, but at the point of no return during
+ * switching to the new exec.
+ */
+TRACE_EVENT(new_exec,
+
+	TP_PROTO(struct task_struct *task, struct linux_binprm *bprm),
+
+	TP_ARGS(task, bprm),
+
+	TP_STRUCT__entry(
+		__string(	filename,	bprm->filename	)
+		__field(	pid_t,		pid		)
+		__string(	comm,		task->comm	)
+	),
+
+	TP_fast_assign(
+		__assign_str(filename, bprm->filename);
+		__entry->pid = task->pid;
+		__assign_str(comm, task->comm);
+	),
+
+	TP_printk("filename=%s pid=%d comm=%s",
+		  __get_str(filename), __entry->pid, __get_str(comm))
+);
+
 #endif
 
 /* This part must be outside protection */
-- 
2.44.0.478.gd926399ef9-goog


