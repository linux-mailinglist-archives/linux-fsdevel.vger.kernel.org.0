Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C43A4B18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 01:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFKXSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 19:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhFKXSG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 19:18:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C661613C3;
        Fri, 11 Jun 2021 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623453355;
        bh=ldDxd3SAl23LV2xslCIftZCEnnBiXgGRvYqkriYuZPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KHIkxEIKe/fnhKal4xXi+ekzeTiz2WRCnK0eQ0kJdiiOGC5NaASFAv/9vwPfxDK8X
         1A/izIxwGauD8PDuEW6vgeSLYuOWJDxQqHFIgoBziBqCz0XB4qSI5DVCIa7WrmVphl
         6TGDsI9CxxwRvVVt45mvIpliKMi4nvd6ODgsXffw=
Date:   Fri, 11 Jun 2021 16:15:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Charles Haithcock <chaithco@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Helge Deller <deller@gmx.de>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Adrian Reber <areber@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv8] exec: Fix dead-lock in de_thread with ptrace_attach
Message-Id: <20210611161553.7dcfa91e494a18e069539193@linux-foundation.org>
In-Reply-To: <AM8PR10MB4708AFBD838138A84CE89EF8E4359@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
References: <AM8PR10MB4708AFBD838138A84CE89EF8E4359@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Jun 2021 09:31:42 +0200 Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:

> This introduces signal->unsafe_execve_in_progress,
> which is used to fix the case when at least one of the
> sibling threads is traced, and therefore the trace
> process may dead-lock in ptrace_attach, but de_thread
> will need to wait for the tracer to continue execution.
> 
> The solution is to detect this situation and allow
> ptrace_attach to continue, while de_thread() is still
> waiting for traced zombies to be eventually released.
> When the current thread changed the ptrace status from
> non-traced to traced, we can simply abort the whole
> execve and restart it by returning -ERESTARTSYS.
> This needs to be done before changing the thread leader,
> because the PTRACE_EVENT_EXEC needs to know the old
> thread pid.
> 
> Although it is technically after the point of no return,
> we just have to reset bprm->point_of_no_return here,
> since at this time only the other threads have received
> a fatal signal, not the current thread.
> 
> >From the user's point of view the whole execve was
> simply delayed until after the ptrace_attach.
> 
> Other threads die quickly since the cred_guard_mutex
> is released, but a deadly signal is already pending.
> In case the mutex_lock_killable misses the signal,
> ->unsafe_execve_in_progress makes sure they release
> the mutex immediately and return with -ERESTARTNOINTR.
> 
> This means there is no API change, unlike the previous
> version of this patch which was discussed here:
> 
> https://lore.kernel.org/lkml/b6537ae6-31b1-5c50-f32b-8b8332ace882@hotmail.de/
> 
> See tools/testing/selftests/ptrace/vmaccess.c
> for a test case that gets fixed by this change.
> 
> Note that since the test case was originally designed to
> test the ptrace_attach returning an error in this situation,
> the test expectation needed to be adjusted, to allow the
> API to succeed at the first attempt.
> 


Here's the diff from v8.  It's conventional to tell reviewers what
changed when sending out a new version.

What changed in this version?

--- a/fs/exec.c~exec-fix-dead-lock-in-de_thread-with-ptrace_attach-v9
+++ a/fs/exec.c
@@ -1056,29 +1056,31 @@ static int de_thread(struct task_struct
 		return -EAGAIN;
 	}
 
-	while_each_thread(tsk, t) {
-		if (unlikely(t->ptrace) && t != tsk->group_leader)
-			sig->unsafe_execve_in_progress = true;
-	}
-
 	sig->group_exit_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
-	spin_unlock_irq(lock);
 
-	if (unlikely(sig->unsafe_execve_in_progress))
+	while_each_thread(tsk, t) {
+		if (unlikely(t->ptrace) && t != tsk->group_leader)
+			sig->unsafe_execve_in_progress = true;
+	}
+
+	if (unlikely(sig->unsafe_execve_in_progress)) {
+		spin_unlock_irq(lock);
 		mutex_unlock(&sig->cred_guard_mutex);
+		spin_lock_irq(lock);
+	}
 
-	for (;;) {
-		set_current_state(TASK_KILLABLE);
-		if (!sig->notify_count)
-			break;
+	while (sig->notify_count) {
+		__set_current_state(TASK_KILLABLE);
+		spin_unlock_irq(lock);
 		schedule();
 		if (__fatal_signal_pending(tsk))
 			goto killed;
+		spin_lock_irq(lock);
 	}
-	__set_current_state(TASK_RUNNING);
+	spin_unlock_irq(lock);
 
 	if (unlikely(sig->unsafe_execve_in_progress)) {
 		if (mutex_lock_killable(&sig->cred_guard_mutex))
_

