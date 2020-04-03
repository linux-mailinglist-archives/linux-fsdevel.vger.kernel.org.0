Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6119D3D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgDCJhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 05:37:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47143 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgDCJhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:37:05 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jKIkI-0000BB-CT; Fri, 03 Apr 2020 09:36:14 +0000
Date:   Fri, 3 Apr 2020 11:36:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bfields@fieldses.org, christian@brauner.io,
        cyphar@cyphar.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, guro@fb.com, jlayton@kernel.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: Re: possible deadlock in send_sigurg
Message-ID: <20200403093612.mtd7edubsng24uuh@wittgenstein>
References: <00000000000011d66805a25cd73f@google.com>
 <20200403091135.GA3645@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403091135.GA3645@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 11:11:35AM +0200, Oleg Nesterov wrote:
> On 04/02, syzbot wrote:
> >
> >                       lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >                       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >                       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >                       spin_lock include/linux/spinlock.h:353 [inline]
> >                       proc_pid_make_inode+0x1f9/0x3c0 fs/proc/base.c:1880
> 
> Yes, spin_lock(wait_pidfd.lock) is not safe...
> 
> Eric, at first glance the fix is simple.
> 
> Oleg.
> 
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c

Um, when did this lock get added to proc/base.c in the first place and
why has it been abused for this?
People just recently complained loudly about this in the
cred_guard_mutex thread that abusing locks for things they weren't
intended for is a bad idea...

> index 74f948a6b621..9ec8c114aa60 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1839,9 +1839,9 @@ void proc_pid_evict_inode(struct proc_inode *ei)
>  	struct pid *pid = ei->pid;
>  
>  	if (S_ISDIR(ei->vfs_inode.i_mode)) {
> -		spin_lock(&pid->wait_pidfd.lock);
> +		spin_lock_irq(&pid->wait_pidfd.lock);
>  		hlist_del_init_rcu(&ei->sibling_inodes);
> -		spin_unlock(&pid->wait_pidfd.lock);
> +		spin_unlock_irq(&pid->wait_pidfd.lock);
>  	}
>  
>  	put_pid(pid);
> @@ -1877,9 +1877,9 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>  	/* Let the pid remember us for quick removal */
>  	ei->pid = pid;
>  	if (S_ISDIR(mode)) {
> -		spin_lock(&pid->wait_pidfd.lock);
> +		spin_lock_irq(&pid->wait_pidfd.lock);
>  		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
> -		spin_unlock(&pid->wait_pidfd.lock);
> +		spin_unlock_irq(&pid->wait_pidfd.lock);
>  	}
>  
>  	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 1e730ea1dcd6..6b7ee76e1b36 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -123,9 +123,9 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
>  		if (!node)
>  			break;
>  		ei = hlist_entry(node, struct proc_inode, sibling_inodes);
> -		spin_lock(lock);
> +		spin_lock_irq(lock);
>  		hlist_del_init_rcu(&ei->sibling_inodes);
> -		spin_unlock(lock);
> +		spin_unlock_irq(lock);
>  
>  		inode = &ei->vfs_inode;
>  		sb = inode->i_sb;
> 
