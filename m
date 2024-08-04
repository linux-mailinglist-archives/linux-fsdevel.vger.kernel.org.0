Return-Path: <linux-fsdevel+bounces-24951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DC4946F96
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89F91C20B88
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549A47A15B;
	Sun,  4 Aug 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml8fIGP1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F9757E5
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722785027; cv=none; b=Coo7b4zRTgYXonh9ui/dkk1FiP+4ZaLuoAHRabVm8MA+nbWcaipG+mkb03p5V+nC7QzTKsAQWkPmxTQiNaPrFN0ckdGlvlNbWoCR+2AsPaULXQz1zaH9H3xHv/xURVbBn3KSMihILrLXssJ9hJvTGUI7c2ABDEPbwAjhg73dWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722785027; c=relaxed/simple;
	bh=M/HvJXNppM08outXt+xcpWtPDWshnBemU5T+LJtgsdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8mAo4mYgnb5KjqOw4QpTbdukE5u+3tnVqBRGgtQubjm6iNtWnVv/jNo2aPEkAuvLyPZtNhz5W17Ey8zbtQu+Q8L/jII2JiMuFzGJhQaIwsJMRq1eB2kpuZzCmnR18tFK+QcCgoRC8fmFDGSp4+vwrN7fUqVY5ziyoLmOfDtyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ml8fIGP1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722785024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UscUOq8lFaSoakKdoY4BSP1iK/2oufX+q/kPRNFqhks=;
	b=Ml8fIGP1VVfeECk33gfg+BDTNO8yR9OT/oepsxo4bscyALSBQDo4FQ9AY1I/TVvFLVWaz7
	jPa5d4Tg8gw7+a5LJE40DV9FZmrO+xqgrf0lTE43VffZoBBOHAQbBitunMIEzmSrzpHvYp
	Fgc1iCXw6cJr+U28Qma7tDwLQzPSQXU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-gZqzruUtPhO3S_HyzHd0ZA-1; Sun,
 04 Aug 2024 11:23:39 -0400
X-MC-Unique: gZqzruUtPhO3S_HyzHd0ZA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1EEA1955BF2;
	Sun,  4 Aug 2024 15:23:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.47])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C54731955D42;
	Sun,  4 Aug 2024 15:23:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  4 Aug 2024 17:23:33 +0200 (CEST)
Date: Sun, 4 Aug 2024 17:23:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Brian Mak <makb@juniper.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first in
 ELF cores)
Message-ID: <20240804152327.GA27866@redhat.com>
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/02, Brian Mak wrote:
>
> Large cores may be truncated in some scenarios, such as with daemons
> with stop timeouts that are not large enough or lack of disk space. This
> impacts debuggability with large core dumps since critical information
> necessary to form a usable backtrace, such as stacks and shared library
> information, are omitted.
>
> Attempting to find all the VMAs necessary to form a proper backtrace and
> then prioritizing those VMAs specifically while core dumping is complex.
> So instead, we can mitigate the impact of core dump truncation by
> dumping smaller VMAs first, which may be more likely to contain memory
> necessary to form a usable backtrace.

I thought of a another approach... See the simple patch below,

	- Incomplete, obviously not for inclusion. I think a new
	  PTRACE_EVENT_COREDUMP makes sense, this will simplify
	  the code even more.

	- Needs some preparations. In particular, I still think we
	  should reintroduce SIGNAL_GROUP_COREDUMP regardless of
	  this feature, but lets not discuss this right now.

This patch adds the new %T specifier to core_pattern, so that

	$ echo '|/path/to/dumper %T' /proc/sys/kernel/core_pattern

means that the coredumping thread will run as a traced child of the
"dumper" process, and it will stop in TASK_TRACED before it calls
binfmt->core_dump().

So the dumper process can extract/save the backtrace/registers/whatever
first, then do PTRACE_CONT or kill the tracee if it doesn't need the
"full" coredump.

Of course this won't work if the dumping thread is already ptraced,
but in this case the debugger has all the necessary info.

What do you think?

Oleg.
---

diff --git a/fs/coredump.c b/fs/coredump.c
index 7f12ff6ad1d3..fbe8e5ae7c00 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -337,6 +337,10 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 			case 'C':
 				err = cn_printf(cn, "%d", cprm->cpu);
 				break;
+			case 'T':
+				// XXX explain that we don't need get_task_struct()
+				cprm->traceme = current;
+				break;
 			default:
 				break;
 			}
@@ -516,9 +520,30 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	/* and disallow core files too */
 	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
 
+	if (cp->traceme) {
+		if (ptrace_attach(cp->traceme, PTRACE_SEIZE, 0,0))
+			cp->traceme = NULL;
+	}
+
 	return err;
 }
 
+static void umh_pipe_cleanup(struct subprocess_info *info)
+{
+	struct coredump_params *cp = (struct coredump_params *)info->data;
+	// XXX: we can't rely on this check, for example
+	// CONFIG_STATIC_USERMODEHELPER_PATH == ""
+	if (cp->traceme) {
+		// XXX: meaningful exit_code/message, maybe new PTRACE_EVENT_
+		ptrace_notify(SIGTRAP, 0);
+
+		spin_lock_irq(&current->sighand->siglock);
+		if (!__fatal_signal_pending(current))
+			clear_thread_flag(TIF_SIGPENDING);
+		spin_unlock_irq(&current->sighand->siglock);
+	}
+}
+
 void do_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
@@ -637,7 +662,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
-						umh_pipe_setup, NULL, &cprm);
+						umh_pipe_setup, umh_pipe_cleanup,
+						&cprm);
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 0904ba010341..490b6c5e05d8 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -28,6 +28,7 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
+	struct task_struct *traceme;
 };
 
 extern unsigned int core_file_note_size_limit;
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 90507d4afcd6..13aed4c358b6 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -46,6 +46,9 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
 
+extern int ptrace_attach(struct task_struct *task, long request,
+			 unsigned long addr, unsigned long flags);
+
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d5f89f9ef29f..47f1e09f8fc9 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -406,9 +406,8 @@ static inline void ptrace_set_stopped(struct task_struct *task, bool seize)
 	}
 }
 
-static int ptrace_attach(struct task_struct *task, long request,
-			 unsigned long addr,
-			 unsigned long flags)
+int ptrace_attach(struct task_struct *task, long request,
+		  unsigned long addr, unsigned long flags)
 {
 	bool seize = (request == PTRACE_SEIZE);
 	int retval;


