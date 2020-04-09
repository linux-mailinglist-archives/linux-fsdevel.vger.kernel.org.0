Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC41A310B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDIIgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 04:36:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40827 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIIge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:36:34 -0400
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jMSea-0007to-72; Thu, 09 Apr 2020 08:35:16 +0000
Date:   Thu, 9 Apr 2020 10:35:14 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bfields@fieldses.org, christian@brauner.io,
        cyphar@cyphar.com, gregkh@linuxfoundation.org, guro@fb.com,
        jlayton@kernel.org, joel@joelfernandes.org, keescook@chromium.org,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        sargun@sargun.me, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] proc: Use a dedicated lock in struct pid
Message-ID: <20200409083514.owpl4sbrqsif2ljq@wittgenstein>
References: <00000000000011d66805a25cd73f@google.com>
 <20200403091135.GA3645@redhat.com>
 <87pnchwwlj.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnchwwlj.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:28:40PM -0500, Eric W. Biederman wrote:
> 
> syzbot wrote:
> > ========================================================
> > WARNING: possible irq lock inversion dependency detected
> > 5.6.0-syzkaller #0 Not tainted
> > --------------------------------------------------------
> > swapper/1/0 just changed the state of lock:
> > ffffffff898090d8 (tasklist_lock){.+.?}-{2:2}, at: send_sigurg+0x9f/0x320 fs/fcntl.c:840
> > but this lock took another, SOFTIRQ-unsafe lock in the past:
> >  (&pid->wait_pidfd){+.+.}-{2:2}
> >
> >
> > and interrupts could create inverse lock ordering between them.
> >
> >
> > other info that might help us debug this:
> >  Possible interrupt unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&pid->wait_pidfd);
> >                                local_irq_disable();
> >                                lock(tasklist_lock);
> >                                lock(&pid->wait_pidfd);
> >   <Interrupt>
> >     lock(tasklist_lock);
> >
> >  *** DEADLOCK ***
> >
> > 4 locks held by swapper/1/0:
> 
> The problem is that because wait_pidfd.lock is taken under the tasklist
> lock.  It must always be taken with irqs disabled as tasklist_lock can be
> taken from interrupt context and if wait_pidfd.lock was already taken this
> would create a lock order inversion.
> 
> Oleg suggested just disabling irqs where I have added extra calls to
> wait_pidfd.lock.  That should be safe and I think the code will eventually
> do that.  It was rightly pointed out by Christian that sharing the
> wait_pidfd.lock was a premature optimization.
> 
> It is also true that my pre-merge window testing was insufficient.  So
> remove the premature optimization and give struct pid a dedicated lock of
> it's own for struct pid things.  I have verified that lockdep sees all 3
> paths where we take the new pid->lock and lockdep does not complain.
> 
> It is my current day dream that one day pid->lock can be used to guard the
> task lists as well and then the tasklist_lock won't need to be held to
> deliver signals.  That will require taking pid->lock with irqs disabled.
> 
> Link: https://lore.kernel.org/lkml/00000000000011d66805a25cd73f@google.com/
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Reported-by: syzbot+343f75cdeea091340956@syzkaller.appspotmail.com
> Reported-by: syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com
> Reported-by: syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com
> Reported-by: syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com
> Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks, Eric.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Christian

> ---
> 
> If anyone sees an issue please holer otherwise I plan on sending
> this fix to Linus.
> 
>  fs/proc/base.c      | 10 +++++-----
>  include/linux/pid.h |  1 +
>  kernel/pid.c        |  1 +
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 74f948a6b621..6042b646ab27 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1839,9 +1839,9 @@ void proc_pid_evict_inode(struct proc_inode *ei)
>  	struct pid *pid = ei->pid;
>  
>  	if (S_ISDIR(ei->vfs_inode.i_mode)) {
> -		spin_lock(&pid->wait_pidfd.lock);
> +		spin_lock(&pid->lock);
>  		hlist_del_init_rcu(&ei->sibling_inodes);
> -		spin_unlock(&pid->wait_pidfd.lock);
> +		spin_unlock(&pid->lock);
>  	}
>  
>  	put_pid(pid);
> @@ -1877,9 +1877,9 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>  	/* Let the pid remember us for quick removal */
>  	ei->pid = pid;
>  	if (S_ISDIR(mode)) {
> -		spin_lock(&pid->wait_pidfd.lock);
> +		spin_lock(&pid->lock);
>  		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
> -		spin_unlock(&pid->wait_pidfd.lock);
> +		spin_unlock(&pid->lock);
>  	}
>  
>  	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> @@ -3273,7 +3273,7 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
>  
>  void proc_flush_pid(struct pid *pid)
>  {
> -	proc_invalidate_siblings_dcache(&pid->inodes, &pid->wait_pidfd.lock);
> +	proc_invalidate_siblings_dcache(&pid->inodes, &pid->lock);
>  	put_pid(pid);
>  }
>  
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 01a0d4e28506..cc896f0fc4e3 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -60,6 +60,7 @@ struct pid
>  {
>  	refcount_t count;
>  	unsigned int level;
> +	spinlock_t lock;
>  	/* lists of tasks that use this pid */
>  	struct hlist_head tasks[PIDTYPE_MAX];
>  	struct hlist_head inodes;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index efd34874b3d1..517d0855d4cf 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -246,6 +246,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  
>  	get_pid_ns(ns);
>  	refcount_set(&pid->count, 1);
> +	spin_lock_init(&pid->lock);
>  	for (type = 0; type < PIDTYPE_MAX; ++type)
>  		INIT_HLIST_HEAD(&pid->tasks[type]);
>  
> -- 
> 2.20.1
> 
> Eric
