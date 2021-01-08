Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAAC2EF5B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 17:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbhAHQ1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 11:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbhAHQ1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:27:23 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5518C061381
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 08:26:42 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p187so10300453iod.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=zq4ynxe5zNFBD/WCjhKDxTtiI6y5h8yiSnOliompjAs=;
        b=JBNOJWdZn6xETPTvjelUwCoZ1hzSnfZsxnVNz2BDLTqGcqTG7+ETfuyEcAwIt6aCk5
         cBS0SsoNDdZoZOoRCK4AvV4FIacqqinRIof7/gpEQ+yiX8I+NcLlOi5CfLsSIt83Lc6Z
         8A6lLaDURxCE3TcdbDtAjzSSaoN0Pi7+rqeoSYSP/lnLmQ93tdjuflDvlCM4ScXPjNJx
         AjE9P0/4ebrnaFSKnXPxZZAYxqCLN6q+b7YepoyzGXyZcdtqAoYzdDh3UJNqZAEh/u+a
         W5uB/WrgeHAmZs/r/1qiyjoff7MoKOlWF00luhwZIDeq8J7wF/sQYeD3V6FMhxPGv6I+
         /Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=zq4ynxe5zNFBD/WCjhKDxTtiI6y5h8yiSnOliompjAs=;
        b=RTPApW+KFWjvQTShESai6/fTRhmljoljwgKpOafLJ9e+XJxqITToG4txrnSF5poHs6
         A2I4ld/Geb3DMn9MFrN2GcgtOP+jwpAPIBkDWpnMQgglXiLMbPe2OSizYCUotqz6Z4JN
         oY1ZXx/qB4V/V3nBLUTQ8RKgHCUC4MGhZfOU8iMbK8VExpg/7l/kCfLHN0Rj7rTzutfM
         6JbVCdkhpvVyf/JO9ONrX+irLK0GGHaW++41gTbGIPDYbiMFIXswRT+gfCU0l4HqkH1K
         vveodOm06MgGddEo1bV2u2Z5DvxvrMlSODGTSO+gWYiO11tH8e3ttWmTOpgHArSsjVqN
         +fRw==
X-Gm-Message-State: AOAM531OgWdCra902e9CIEcjY7B9UDznvooYdBQ/stwoG2LpA90ypcbr
        /8brUADh9873DjX2HjdnaKJA1w==
X-Google-Smtp-Source: ABdhPJxkbNmjeng3aQtqO/glCSb2wA796QWzDpW6ogcZrV25WqhDI0sNq9gYwQxuW9keQFfz29G6kQ==
X-Received: by 2002:a02:7428:: with SMTP id o40mr4119502jac.130.1610123201944;
        Fri, 08 Jan 2021 08:26:41 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm7478872iln.0.2021.01.08.08.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 08:26:40 -0800 (PST)
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <20210108052651.GM3579531@ZenIV.linux.org.uk>
 <20210108064639.GN3579531@ZenIV.linux.org.uk>
 <245fba32-76cc-c4e1-6007-0b1f8a22a86b@kernel.dk>
 <20210108155807.GQ3579531@ZenIV.linux.org.uk>
 <41e33492-7b01-6801-cbb1-78ecef0c9fc0@kernel.dk>
Message-ID: <2cdd6d47-7eb1-3ab1-7aa8-80c54819009b@kernel.dk>
Date:   Fri, 8 Jan 2021 09:26:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <41e33492-7b01-6801-cbb1-78ecef0c9fc0@kernel.dk>
Content-Type: multipart/mixed;
 boundary="------------DB179B50B84C45A6F2CE09AA"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DB179B50B84C45A6F2CE09AA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 1/8/21 9:10 AM, Jens Axboe wrote:
> On 1/8/21 8:58 AM, Al Viro wrote:
>> On Fri, Jan 08, 2021 at 08:13:25AM -0700, Jens Axboe wrote:
>>>> Anyway, bedtime for me; right now it looks like at least for task ==
>>>> current we always want TWA_SIGNAL.  I'll look into that more tomorrow
>>>> when I get up, but so far it smells like switching everything to
>>>> TWA_SIGNAL would be the right thing to do, if not going back to bool
>>>> notify for task_work_add()...
>>>
>>> Before the change, the fact that we ran task_work off get_signal() and
>>> thus processed even non-notify work in that path was a bit of a mess,
>>> imho. If you have work that needs processing now, in the same manner as
>>> signals, then you really should be using TWA_SIGNAL. For this pipe case,
>>> and I'd need to setup and reproduce it again, the task must have a
>>> signal pending and that would have previously caused the task_work to
>>> run, and now it does not. TWA_RESUME technically didn't change its
>>> behavior, it's still the same notification type, we just don't run
>>> task_work unconditionally (regardless of notification type) from
>>> get_signal().
>>
>> It sure as hell did change behaviour.  Think of the effect of getting
>> hit with SIGSTOP.  That's what that "bit of a mess" had been about.
>> Work done now vs. possibly several days later when SIGCONT finally
>> gets sent.
>>
>>> I think the main question here is if we want to re-instate the behavior
>>> of running task_work off get_signal(). I'm leaning towards not doing
>>> that and ensuring that callers that DO need that are using TWA_SIGNAL.
>>
>> Can you show the callers that DO NOT need it?
> 
> OK, so here's my suggestion:
> 
> 1) For 5.11, we just re-instate the task_work run in get_signal(). This
>    will make TWA_RESUME have the exact same behavior as before.
> 
> 2) For 5.12, I'll prepare a patch that collapses TWA_RESUME and TWA_SIGNAL,
>    turning it into a bool again (notify or no notify).
> 
> How does that sound?

Attached the patches - #1 is proposed for 5.11 to fix the current issue,
and then 2-4 can get queued for 5.12 to totally remove the difference
between TWA_RESUME and TWA_SIGNAL.

Totally untested, but pretty straight forward.

-- 
Jens Axboe


--------------DB179B50B84C45A6F2CE09AA
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-task_work-use-true-false-for-task_work_add-notificat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-task_work-use-true-false-for-task_work_add-notificat.pa";
 filename*1="tch"

From 069af1e44d70b6d3dd746e41a5f9d65505fb5490 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 8 Jan 2021 09:22:04 -0700
Subject: [PATCH 3/4] task_work: use true/false for task_work_add notification
 type

There's no difference between TWA_SIGNAL and TWA_RESUME anymore, change
all callers to simply specify whether they need notification or not.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/kernel/cpu/mce/core.c         |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 drivers/acpi/apei/ghes.c               |  2 +-
 drivers/android/binder.c               |  2 +-
 fs/file_table.c                        |  2 +-
 fs/io_uring.c                          | 19 +++++++++----------
 fs/namespace.c                         |  2 +-
 kernel/events/uprobes.c                |  2 +-
 kernel/irq/manage.c                    |  2 +-
 kernel/sched/fair.c                    |  2 +-
 kernel/time/posix-cpu-timers.c         |  2 +-
 security/keys/keyctl.c                 |  2 +-
 security/yama/yama_lsm.c               |  2 +-
 13 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1cbda17..9f315b4c022d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1278,7 +1278,7 @@ static void queue_task_work(struct mce *m, int kill_current_task)
 	else
 		current->mce_kill_me.func = kill_me_maybe;
 
-	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
+	task_work_add(current, &current->mce_kill_me, true);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 29ffb95b25ff..109dd4fe72da 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -579,7 +579,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * callback has been invoked.
 	 */
 	atomic_inc(&rdtgrp->waitcount);
-	ret = task_work_add(tsk, &callback->work, TWA_RESUME);
+	ret = task_work_add(tsk, &callback->work, true);
 	if (ret) {
 		/*
 		 * Task is exiting. Drop the refcount and free the callback.
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..99df00f64306 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -942,7 +942,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 			estatus_node->task_work.func = ghes_kick_task_work;
 			estatus_node->task_work_cpu = smp_processor_id();
 			ret = task_work_add(current, &estatus_node->task_work,
-					    TWA_RESUME);
+					    true);
 			if (ret)
 				estatus_node->task_work.func = NULL;
 		}
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c119736ca56a..5b1b2ed7c020 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1839,7 +1839,7 @@ static void binder_deferred_fd_close(int fd)
 	close_fd_get_file(fd, &twcb->file);
 	if (twcb->file) {
 		filp_close(twcb->file, current->files);
-		task_work_add(current, &twcb->twork, TWA_RESUME);
+		task_work_add(current, &twcb->twork, true);
 	} else {
 		kfree(twcb);
 	}
diff --git a/fs/file_table.c b/fs/file_table.c
index 45437f8e1003..f2bb37fd0905 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -338,7 +338,7 @@ void fput_many(struct file *file, unsigned int refs)
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
 			init_task_work(&file->f_u.fu_rcuhead, ____fput);
-			if (!task_work_add(task, &file->f_u.fu_rcuhead, TWA_RESUME))
+			if (!task_work_add(task, &file->f_u.fu_rcuhead, true))
 				return;
 			/*
 			 * After this task has run exit_task_work(),
diff --git a/fs/io_uring.c b/fs/io_uring.c
index ca46f314640b..70a555b17bac 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2077,7 +2077,7 @@ static int io_req_task_work_add(struct io_kiocb *req)
 {
 	struct task_struct *tsk = req->task;
 	struct io_ring_ctx *ctx = req->ctx;
-	enum task_work_notify_mode notify;
+	bool notify;
 	int ret;
 
 	if (tsk->flags & PF_EXITING)
@@ -2085,13 +2085,12 @@ static int io_req_task_work_add(struct io_kiocb *req)
 
 	/*
 	 * SQPOLL kernel thread doesn't need notification, just a wakeup. For
-	 * all other cases, use TWA_SIGNAL unconditionally to ensure we're
-	 * processing task_work. There's no reliable way to tell if TWA_RESUME
-	 * will do the job.
+	 * all other cases, use notification unconditionally to ensure we're
+	 * processing task_work.
 	 */
-	notify = TWA_NONE;
+	notify = false;
 	if (!(ctx->flags & IORING_SETUP_SQPOLL))
-		notify = TWA_SIGNAL;
+		notify = true;
 
 	ret = task_work_add(tsk, &req->task_work, notify);
 	if (!ret)
@@ -2159,7 +2158,7 @@ static void io_req_task_queue(struct io_kiocb *req)
 
 		init_task_work(&req->task_work, io_req_task_cancel);
 		tsk = io_wq_get_task(req->ctx->io_wq);
-		task_work_add(tsk, &req->task_work, TWA_NONE);
+		task_work_add(tsk, &req->task_work, false);
 		wake_up_process(tsk);
 	}
 }
@@ -2279,7 +2278,7 @@ static void io_free_req_deferred(struct io_kiocb *req)
 		struct task_struct *tsk;
 
 		tsk = io_wq_get_task(req->ctx->io_wq);
-		task_work_add(tsk, &req->task_work, TWA_NONE);
+		task_work_add(tsk, &req->task_work, false);
 		wake_up_process(tsk);
 	}
 }
@@ -3375,7 +3374,7 @@ static int io_async_buf_func(struct wait_queue_entry *wait, unsigned mode,
 		/* queue just for cancelation */
 		init_task_work(&req->task_work, io_req_task_cancel);
 		tsk = io_wq_get_task(req->ctx->io_wq);
-		task_work_add(tsk, &req->task_work, TWA_NONE);
+		task_work_add(tsk, &req->task_work, false);
 		wake_up_process(tsk);
 	}
 	return 1;
@@ -5092,7 +5091,7 @@ static int __io_async_wake(struct io_kiocb *req, struct io_poll_iocb *poll,
 
 		WRITE_ONCE(poll->canceled, true);
 		tsk = io_wq_get_task(req->ctx->io_wq);
-		task_work_add(tsk, &req->task_work, TWA_NONE);
+		task_work_add(tsk, &req->task_work, false);
 		wake_up_process(tsk);
 	}
 	return 1;
diff --git a/fs/namespace.c b/fs/namespace.c
index d2db7dfe232b..f6b661ad8bbd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1194,7 +1194,7 @@ static void mntput_no_expire(struct mount *mnt)
 		struct task_struct *task = current;
 		if (likely(!(task->flags & PF_KTHREAD))) {
 			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
-			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
+			if (!task_work_add(task, &mnt->mnt_rcu, true))
 				return;
 		}
 		if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bf9edd8d75be..8bb26a338e06 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1823,7 +1823,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
 
 	t->utask->dup_xol_addr = area->vaddr;
 	init_task_work(&t->utask->dup_xol_work, dup_xol_work);
-	task_work_add(t, &t->utask->dup_xol_work, TWA_RESUME);
+	task_work_add(t, &t->utask->dup_xol_work, true);
 }
 
 /*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ab8567f32501..d4e2f484e4af 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1232,7 +1232,7 @@ static int irq_thread(void *data)
 		handler_fn = irq_thread_fn;
 
 	init_task_work(&on_exit_work, irq_thread_dtor);
-	task_work_add(current, &on_exit_work, TWA_NONE);
+	task_work_add(current, &on_exit_work, false);
 
 	irq_thread_check_affinity(desc, action);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..476c564f0f8a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2939,7 +2939,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 		curr->node_stamp += period;
 
 		if (!time_before(jiffies, curr->mm->numa_next_scan))
-			task_work_add(curr, work, TWA_RESUME);
+			task_work_add(curr, work, true);
 	}
 }
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a71758e34e45..51080a1ed11f 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1128,7 +1128,7 @@ static inline void __run_posix_cpu_timers(struct task_struct *tsk)
 
 	/* Schedule task work to actually expire the timers */
 	tsk->posix_cputimers_work.scheduled = true;
-	task_work_add(tsk, &tsk->posix_cputimers_work.work, TWA_RESUME);
+	task_work_add(tsk, &tsk->posix_cputimers_work.work, true);
 }
 
 static inline bool posix_cpu_timers_enable_work(struct task_struct *tsk,
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 61a614c21b9b..e26bbccda7cc 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1693,7 +1693,7 @@ long keyctl_session_to_parent(void)
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
-	ret = task_work_add(parent, newwork, TWA_RESUME);
+	ret = task_work_add(parent, newwork, true);
 	if (!ret)
 		newwork = NULL;
 unlock:
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..536c99646f6a 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -99,7 +99,7 @@ static void report_access(const char *access, struct task_struct *target,
 	info->access = access;
 	info->target = target;
 	info->agent = agent;
-	if (task_work_add(current, &info->work, TWA_RESUME) == 0)
+	if (task_work_add(current, &info->work, true) == 0)
 		return; /* success */
 
 	WARN(1, "report_access called from exiting task");
-- 
2.30.0


--------------DB179B50B84C45A6F2CE09AA
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-task_work-always-use-signal-work-if-notification-is-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-task_work-always-use-signal-work-if-notification-is-.pa";
 filename*1="tch"

From 232a5d9bf181b05d199ff3c3be7ab7c2b0b1898c Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 8 Jan 2021 09:17:45 -0700
Subject: [PATCH 2/4] task_work: always use signal work if notification is
 selected

Since we run any task_work from get_signal(), there's no real distinction
between TWA_RESUME and TWA_SIGNAL. Turn the notification method for
task_work_add() into a boolean, in preparation for getting rid of the
difference between the two.

With TWA_SIGNAL always being used, we no longer need to check and run
task_work in get_signal() unconditionally. Get rid of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/task_work.h |  2 +-
 kernel/signal.c           |  3 ---
 kernel/task_work.c        | 29 ++++++++---------------------
 3 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 0d848a1e9e62..8df8d539fad8 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -20,7 +20,7 @@ enum task_work_notify_mode {
 };
 
 int task_work_add(struct task_struct *task, struct callback_head *twork,
-			enum task_work_notify_mode mode);
+			bool notify);
 
 struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
 void task_work_run(void);
diff --git a/kernel/signal.c b/kernel/signal.c
index 6b9c431da08f..5736c55aaa1a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2550,9 +2550,6 @@ bool get_signal(struct ksignal *ksig)
 	struct signal_struct *signal = current->signal;
 	int signr;
 
-	if (unlikely(current->task_works))
-		task_work_run();
-
 	/*
 	 * For non-generic architectures, check for TIF_NOTIFY_SIGNAL so
 	 * that the arch handlers don't all have to do it. If we get here
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 9cde961875c0..7a4850669033 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -9,15 +9,13 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * task_work_add - ask the @task to execute @work->func()
  * @task: the task which should run the callback
  * @work: the callback to run
- * @notify: how to notify the targeted task
+ * @notify: whether to notify the targeted task or not
  *
- * Queue @work for task_work_run() below and notify the @task if @notify
- * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL works like signals, in that the
- * it will interrupt the targeted task and run the task_work. @TWA_RESUME
- * work is run only when the task exits the kernel and returns to user mode,
- * or before entering guest mode. Fails if the @task is exiting/exited and thus
- * it can't process this @work. Otherwise @work->func() will be called when the
- * @task goes through one of the aforementioned transitions, or exits.
+ * Queue @work for task_work_run() below and notify the @task if @notify is
+ * true. If notification is selected, the targeted task is interrupted so it
+ * can process the work. Fails if the @task is exiting/exited and thus it can't
+ * process this @work. Otherwise @work->func() will be called when the @task
+ * goes through one of the aforementioned transitions, or exits.
  *
  * If the targeted task is exiting, then an error is returned and the work item
  * is not queued. It's up to the caller to arrange for an alternative mechanism
@@ -30,7 +28,7 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * 0 if succeeds or -ESRCH.
  */
 int task_work_add(struct task_struct *task, struct callback_head *work,
-		  enum task_work_notify_mode notify)
+		  bool notify)
 {
 	struct callback_head *head;
 
@@ -41,19 +39,8 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		work->next = head;
 	} while (cmpxchg(&task->task_works, head, work) != head);
 
-	switch (notify) {
-	case TWA_NONE:
-		break;
-	case TWA_RESUME:
-		set_notify_resume(task);
-		break;
-	case TWA_SIGNAL:
+	if (notify)
 		set_notify_signal(task);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
 
 	return 0;
 }
-- 
2.30.0


--------------DB179B50B84C45A6F2CE09AA
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-task_work-unconditionally-run-task_work-from-get_sig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-task_work-unconditionally-run-task_work-from-get_sig.pa";
 filename*1="tch"

From 35d0b389f3b23439ad15b610d6e43fc72fc75779 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 5 Jan 2021 11:32:43 -0700
Subject: [PATCH 1/4] task_work: unconditionally run task_work from
 get_signal()

Song reported a boot regression in a kvm image with 5.11-rc, and bisected
it down to the below patch. Debugging this issue, turns out that the boot
stalled when a task is waiting on a pipe being released. As we no longer
run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
task goes idle without running the task_work. This prevents ->release()
from being called on the pipe, which another boot task is waiting on.

For now, re-instate the unconditional task_work run from get_signal().
For 5.12, we'll collapse TWA_RESUME and TWA_SIGNAL, as it no longer
makes sense to have a distinction between the two. This will turn
task_work notification into a simple boolean, whether to notify or not.

Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
Reported-by: Song Liu <songliubraving@fb.com>
Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang version 11.0.1
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 5736c55aaa1a..6b9c431da08f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2550,6 +2550,9 @@ bool get_signal(struct ksignal *ksig)
 	struct signal_struct *signal = current->signal;
 	int signr;
 
+	if (unlikely(current->task_works))
+		task_work_run();
+
 	/*
 	 * For non-generic architectures, check for TIF_NOTIFY_SIGNAL so
 	 * that the arch handlers don't all have to do it. If we get here
-- 
2.30.0


--------------DB179B50B84C45A6F2CE09AA
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-task_work-kill-enum-task_work_notify_mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0004-task_work-kill-enum-task_work_notify_mode.patch"

From 4906058b2573b7de9c220dd8566c20d0e78a7c4b Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 8 Jan 2021 09:23:16 -0700
Subject: [PATCH 4/4] task_work: kill enum task_work_notify_mode

It's now unused, get rid of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/task_work.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 8df8d539fad8..7b987260f4d7 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -13,12 +13,6 @@ init_task_work(struct callback_head *twork, task_work_func_t func)
 	twork->func = func;
 }
 
-enum task_work_notify_mode {
-	TWA_NONE,
-	TWA_RESUME,
-	TWA_SIGNAL,
-};
-
 int task_work_add(struct task_struct *task, struct callback_head *twork,
 			bool notify);
 
-- 
2.30.0


--------------DB179B50B84C45A6F2CE09AA--
