Return-Path: <linux-fsdevel+bounces-4024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422337FB95D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 12:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AF41C21472
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F764F60C;
	Tue, 28 Nov 2023 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWwDFxYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111784652D;
	Tue, 28 Nov 2023 11:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79166C433C7;
	Tue, 28 Nov 2023 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701170664;
	bh=sAPmFm7cnWhTJeY7ueW6GOIoW7e7zZ9rt09iElgE6oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWwDFxYQAAoifWIczDFp1o9BUBA1RFxx19MI9z3tQ9EmKDmxuTkxTcSKuTT3GlS1V
	 gVkZupihx/7ozj1uuN9wLU5TX31QkgPUJOAsFEywBfPbNbb0vb+f/KR8QmCWAsZYgr
	 XzMCeW+3wXYb8hFKEMQj5zrcp0o1VO/J1dqcuFxxJEimvB3NsYdZMFgsxwSHY/YNGo
	 jaa4WsjiQ/ZVscPrCt6DN9d0PMjBGxci24iF2LCwuKsO08kNiRaY/IB9oVcMcaD8ey
	 PlIjmbumgdt8Cu549p22WPQmZ3M0fgvJmpgGhfKFLHYLtB8umUEnIIUg51V1AcHlI3
	 Q5N8QdDFsXQgg==
Date: Tue, 28 Nov 2023 12:24:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231128-arsch-halbieren-b2a95645de53@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170112272125.7109.6245462722883333440@noble.neil.brown.name>

On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> 
> I have evidence from a customer site of 256 nfsd threads adding files to
> delayed_fput_lists nearly twice as fast they are retired by a single
> work-queue thread running delayed_fput().  As you might imagine this
> does not end well (20 million files in the queue at the time a snapshot
> was taken for analysis).
> 
> While this might point to a problem with the filesystem not handling the
> final close efficiently, such problems should only hurt throughput, not
> lead to memory exhaustion.
> 
> For normal threads, the thread that closes the file also calls the
> final fput so there is natural rate limiting preventing excessive growth
> in the list of delayed fputs.  For kernel threads, and particularly for
> nfsd, delayed in the final fput do not impose any throttling to prevent
> the thread from closing more files.
> 
> A simple way to fix this is to treat nfsd threads like normal processes
> for task_work.  Thus the pending files are queued for the thread, and
> the same thread finishes the work.
> 
> Currently KTHREADs are assumed never to call task_work_run().  With this
> patch that it still the default but it is implemented by storing the
> magic value TASK_WORKS_DISABLED in ->task_works.  If a kthread, such as
> nfsd, will call task_work_run() periodically, it sets ->task_works
> to NULL to indicate this.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
> I wonder which tree this should go through assuming everyone likes it.
> VFS maybe??

Sure.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 292c31697248..c63c2bedbf71 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1117,6 +1117,7 @@ struct task_struct {
>  	unsigned int			sas_ss_flags;
>  
>  	struct callback_head		*task_works;
> +#define	TASK_WORKS_DISABLED	((void*)1)

Should be simpler if you invert the logic?

COMPLETELY UNTESTED

---
 fs/file_table.c           |  2 +-
 fs/nfsd/nfssvc.c          |  4 ++++
 include/linux/task_work.h |  3 +++
 kernel/fork.c             |  3 +++
 kernel/task_work.c        | 12 ++++++++++++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index de4a2915bfd4..e79351df22be 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -445,7 +445,7 @@ void fput(struct file *file)
 	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task = current;
 
-		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+		if (likely(!in_interrupt())) {
 			init_task_work(&file->f_rcuhead, ____fput);
 			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
 				return;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d6122bb2d167..cea76bad3a95 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -13,6 +13,7 @@
 #include <linux/fs_struct.h>
 #include <linux/swap.h>
 #include <linux/siphash.h>
+#include <linux/task_work.h>
 
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/svcsock.h>
@@ -943,6 +944,7 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
+	task_work_manage(current); /* Declare that I will call task_work_run() */
 	atomic_inc(&nfsdstats.th_cnt);
 
 	set_freezable();
@@ -956,6 +958,8 @@ nfsd(void *vrqstp)
 
 		svc_recv(rqstp);
 		validate_process_creds();
+		if (task_work_pending(current))
+			task_work_run();
 	}
 
 	atomic_dec(&nfsdstats.th_cnt);
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 795ef5a68429..645fb94e47e0 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -20,6 +20,9 @@ enum task_work_notify_mode {
 	TWA_SIGNAL_NO_IPI,
 };
 
+void task_work_off(struct task_struct *task);
+void task_work_manage(struct task_struct *task);
+
 static inline bool task_work_pending(struct task_struct *task)
 {
 	return READ_ONCE(task->task_works);
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..348ed8fa9333 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2346,6 +2346,9 @@ __latent_entropy struct task_struct *copy_process(
 	if (args->io_thread)
 		p->flags |= PF_IO_WORKER;
 
+	if (args->kthread)
+		task_work_off(p);
+
 	if (args->name)
 		strscpy_pad(p->comm, args->name, sizeof(p->comm));
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b7f1da..2ae948d0d124 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -5,6 +5,18 @@
 
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
+void task_work_off(struct task_struct *task)
+{
+	task->task_works = &work_exited;
+}
+EXPORT_SYMBOL(task_work_off);
+
+void task_work_manage(struct task_struct *task)
+{
+	task->task_works = NULL;
+}
+EXPORT_SYMBOL(task_work_manage);
+
 /**
  * task_work_add - ask the @task to execute @work->func()
  * @task: the task which should run the callback
-- 
2.42.0

