Return-Path: <linux-fsdevel+bounces-4870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23198054E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CC4280989
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83C61FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLTebRxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF00B69780;
	Tue,  5 Dec 2023 11:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F30C433C8;
	Tue,  5 Dec 2023 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701775546;
	bh=CQUl6r/F98hCTeMx55KAWTeoJgu07gUHwR1xWmX6yNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLTebRxv/4gpihnvL89VfqlKXgGVT9mpg728cZCElhYBOWfXoHzvqAWGR8qHsA8SB
	 GiS9izQ36sJktd/h0Y+gxlXMzScaBSAwYZc1fxyjNlzyJHhz8VOrz2tvWFaD0z25bP
	 XfKQnOR2AEBm0kTW6Kx8RermVgftIxkekpMK24yTi49GcqcoRPnhGoftXfwmRaXgT7
	 HG14m4vIIuG0Toql56xk1XWi3qEy9WxQFumRceDrBrDepdoXuLKpt2HgTjdtQkJOUt
	 HtS9WEtsIiNe2LDRE6+6xI8k9DllWdIRajQbwfmJMp6tPp2cHT3usI+vpX9E0wm/hY
	 0nz86682GBIdw==
Date: Tue, 5 Dec 2023 12:25:40 +0100
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
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <20231205-simpel-anfragen-71ac550a80fe@brauner>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231204014042.6754-2-neilb@suse.de>

On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> User-space processes always call task_work_run() as needed when
> returning from a system call.  Kernel-threads generally do not.
> Because of this some work that is best run in the task_works context
> (guaranteed that no locks are held) cannot be queued to task_works from
> kernel threads and so are queued to a (single) work_time to be managed
> on a work queue.
> 
> This means that any cost for doing the work is not imposed on the kernel
> thread, and importantly excessive amounts of work cannot apply
> back-pressure to reduce the amount of new work queued.
> 
> I have evidence from a customer site when nfsd (which runs as kernel
> threads) is being asked to modify many millions of files which causes
> sufficient memory pressure that some cache (in XFS I think) gets cleaned
> earlier than would be ideal.  When __dput (from the workqueue) calls
> __dentry_kill, xfs_fs_destroy_inode() needs to synchronously read back
> previously cached info from storage.  This slows down the single thread
> that is making all the final __dput() calls for all the nfsd threads
> with the net result that files are added to the delayed_fput_list faster
> than they are removed, and the system eventually runs out of memory.
> 
> This happens because there is no back-pressure: the nfsd isn't forced to
> slow down when __dput() is slow for any reason.  To fix this we can
> change the nfsd threads to call task_work_run() regularly (much like
> user-space processes do) and allow it to declare this so that work does
> get queued to task_works rather than to a work queue.
> 
> This patch adds a new process flag PF_RUNS_TASK_WORK which is now used
> instead of PF_KTHREAD to determine whether it is sensible to queue
> something to task_works.  This flag is always set for non-kernel threads.
> 
> task_work_run() is also exported so that it can be called from a module
> such as nfsd.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---

The thing that bugs me the most about this is that we expose task work
infrastructure to modules which I think is a really bad idea. File
handling code brings so many driver to their knees and now we're handing
them another footgun.

I'm not per se opposed to all of this but is this really what the other
NFS maintainers want to switch to as well? And is this really that badly
needed and that common that we want to go down that road? I wouldn't
mind not having to do all this if we can get by via other means.

>  fs/file_table.c       | 3 ++-
>  fs/namespace.c        | 2 +-
>  include/linux/sched.h | 2 +-
>  kernel/fork.c         | 2 ++
>  kernel/task_work.c    | 1 +
>  5 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index ee21b3da9d08..d36cade6e366 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -435,7 +435,8 @@ void fput(struct file *file)
>  	if (atomic_long_dec_and_test(&file->f_count)) {
>  		struct task_struct *task = current;
>  
> -		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> +		if (likely(!in_interrupt() &&
> +			   (task->flags & PF_RUNS_TASK_WORK))) {
>  			init_task_work(&file->f_rcuhead, ____fput);
>  			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
>  				return;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e157efc54023..46d640b70ca9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
>  
>  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
>  		struct task_struct *task = current;
> -		if (likely(!(task->flags & PF_KTHREAD))) {
> +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {
>  			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
>  			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
>  				return;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 77f01ac385f7..e4eebac708e7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1747,7 +1747,7 @@ extern struct pid *cad_pid;
>  						 * I am cleaning dirty pages from some other bdi. */
>  #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> -#define PF__HOLE__00800000	0x00800000
> +#define PF_RUNS_TASK_WORK	0x00800000	/* Will call task_work_run() periodically */

The flag seems better to me than just relying on exit_work as itt's
easier to reason about.

>  #define PF__HOLE__01000000	0x01000000
>  #define PF__HOLE__02000000	0x02000000
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3b6d20dfb9a8..d612d8f14861 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2330,6 +2330,8 @@ __latent_entropy struct task_struct *copy_process(
>  	p->flags &= ~PF_KTHREAD;
>  	if (args->kthread)
>  		p->flags |= PF_KTHREAD;
> +	else
> +		p->flags |= PF_RUNS_TASK_WORK;
>  	if (args->user_worker) {
>  		/*
>  		 * Mark us a user worker, and block any signal that isn't
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 95a7e1b7f1da..aec19876e121 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -183,3 +183,4 @@ void task_work_run(void)
>  		} while (work);
>  	}
>  }
> +EXPORT_SYMBOL(task_work_run);
> -- 
> 2.43.0
> 

