Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C54255A58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgH1Mh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 08:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgH1Mhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:37:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75AEC061264;
        Fri, 28 Aug 2020 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ly13hCO4T70EGDvVQoz2wykiYXpJvBtQbdcq7qWG4Ac=; b=2nnPaR4tAZBk0lbz7c9n8ugOHE
        CUNFzZpnyeoe9/dDOdaaNz1W03M2KVJNEfoQ0poK3GbhsVGI5jB6Pkd7xHG4paiA5CKR+PGVruqHz
        yPcRRorQWoOnLGkpE+2JaE8QHvdtgOnKqIthheY+NwjFjwBlSMA6F4rTpNRnnT6jrqpK35OOtr8BV
        T9tYzSIE9gE334hVLmydz1pzBA5tZO/frGX24fUpnCNe3/fDxl7UkLznRbLPDxplusqLPTTSwvY69
        gzMk9LCfxpnvkJtPfEPE1bPBdGRcom8YcOsck9w6xxmAsvD//NoBAdCPyuX0j0KGRfGImAVI27dv7
        Ddn7TvGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBddE-0004yy-0g; Fri, 28 Aug 2020 12:37:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B26543003E5;
        Fri, 28 Aug 2020 14:37:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C6C02C56DFB1; Fri, 28 Aug 2020 14:37:20 +0200 (CEST)
Date:   Fri, 28 Aug 2020 14:37:20 +0200
From:   peterz@infradead.org
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, gladkov.alexey@gmail.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        walken@google.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, jannh@google.com
Subject: Re: possible deadlock in proc_pid_syscall (2)
Message-ID: <20200828123720.GZ1362448@hirez.programming.kicks-ass.net>
References: <00000000000063640c05ade8e3de@google.com>
 <87mu2fj7xu.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu2fj7xu.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 07:01:17AM -0500, Eric W. Biederman wrote:
> This feels like an issue where perf can just do too much under
> exec_update_mutex.  In particular calling kern_path from
> create_local_trace_uprobe.  Calling into the vfs at the very least
> makes it impossible to know exactly which locks will be taken.
> 
> Thoughts?

> > -> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
> >        down_read+0x96/0x420 kernel/locking/rwsem.c:1492
> >        inode_lock_shared include/linux/fs.h:789 [inline]
> >        lookup_slow fs/namei.c:1560 [inline]
> >        walk_component+0x409/0x6a0 fs/namei.c:1860
> >        lookup_last fs/namei.c:2309 [inline]
> >        path_lookupat+0x1ba/0x830 fs/namei.c:2333
> >        filename_lookup+0x19f/0x560 fs/namei.c:2366
> >        create_local_trace_uprobe+0x87/0x4e0 kernel/trace/trace_uprobe.c:1574
> >        perf_uprobe_init+0x132/0x210 kernel/trace/trace_event_perf.c:323
> >        perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9580
> >        perf_try_init_event+0x12a/0x560 kernel/events/core.c:10899
> >        perf_init_event kernel/events/core.c:10951 [inline]
> >        perf_event_alloc.part.0+0xdee/0x3770 kernel/events/core.c:11229
> >        perf_event_alloc kernel/events/core.c:11608 [inline]
> >        __do_sys_perf_event_open+0x72c/0x2cb0 kernel/events/core.c:11724
> >        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >        entry_SYSCALL_64_after_hwframe+0x44/0xa9

Right, so we hold the mutex fairly long there, supposedly to ensure
privs don't change out from under us.

We do the permission checks early -- no point in doing anything else if
we're not allowed, but we then have to hold this mutex until the event
is actually installed according to that comment.

/me goes look at git history:

  6914303824bb5 - changed cred_guard_mutex into exec_update_mutex
  79c9ce57eb2d5 - introduces cred_guard_mutex

So that latter commit explains the race we're guarding against. Without
this we can install the event after execve() which might have changed
privs on us.

I'm open to suggestions on how to do this differently.

Could we check privs twice instead?

Something like the completely untested below..

---
diff --git a/include/linux/freelist.h b/include/linux/freelist.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5bfe8e3c6e44..14e6c9bbfcda 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11701,21 +11701,9 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (task) {
-		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
-		if (err)
-			goto err_task;
-
-		/*
-		 * Preserve ptrace permission check for backwards compatibility.
-		 *
-		 * We must hold exec_update_mutex across this and any potential
-		 * perf_install_in_context() call for this new event to
-		 * serialize against exec() altering our credentials (and the
-		 * perf_event_exit_task() that could imply).
-		 */
 		err = -EACCES;
 		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
-			goto err_cred;
+			goto err_task;
 	}
 
 	if (flags & PERF_FLAG_PID_CGROUP)
@@ -11844,6 +11832,24 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_context;
 	}
 
+	if (task) {
+		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
+		if (err)
+			goto err_file;
+
+		/*
+		 * Preserve ptrace permission check for backwards compatibility.
+		 *
+		 * We must hold exec_update_mutex across this and any potential
+		 * perf_install_in_context() call for this new event to
+		 * serialize against exec() altering our credentials (and the
+		 * perf_event_exit_task() that could imply).
+		 */
+		err = -EACCES;
+		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+			goto err_cred;
+	}
+
 	if (move_group) {
 		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
 
@@ -12019,7 +12025,10 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (move_group)
 		perf_event_ctx_unlock(group_leader, gctx);
 	mutex_unlock(&ctx->mutex);
-/* err_file: */
+err_cred:
+	if (task)
+		mutex_unlock(&task->signal->exec_update_mutex);
+err_file:
 	fput(event_file);
 err_context:
 	perf_unpin_context(ctx);
@@ -12031,9 +12040,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	 */
 	if (!event_file)
 		free_event(event);
-err_cred:
-	if (task)
-		mutex_unlock(&task->signal->exec_update_mutex);
 err_task:
 	if (task)
 		put_task_struct(task);
