Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E863B9FFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 13:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhGBLrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 07:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232006AbhGBLrV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:47:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ED5F61402;
        Fri,  2 Jul 2021 11:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625226290;
        bh=6BZPEDKAj+7kvkj991rbBYP4cz+T/5lQA2vpcgGtwcU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cPyRTlp20NdcAXAR+EjKnqf7Mh9jzhMAESmqRd6Ukuwh92MIeciNqVVHB3zsLbALQ
         ayKVqghJxGvQFtseUyJNu4iA5qE0EtoiBBjtBbRBnjDkXA5QGyMFpVvuYelneeRu3r
         tub4AdXgAktQRlodmqWOErWQlMi1mUUE8V3oIUYNDgNDh+Yz9mXyDn44WcsTm8dgPO
         DghL1e5W7E2SyCKa0O1SFeb5DIs2qturxcyWNEA+yXA7kVpEK5+6NyBumcUoQJkdTp
         304WLhGsKQFnaNNIEYwtO6ySYRt7dnmuQkB3WTLZNLfjnSs0LWzu9PFqCvfy8zAuHG
         JpLmk2p4XMdiA==
Message-ID: <43b5f2c7e7e5e5ed35c8e3de2eafeb960f267836.camel@kernel.org>
Subject: Re: [PATCH 1/2] fcntl: fix potential deadlocks for &fown_struct.lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Date:   Fri, 02 Jul 2021 07:44:48 -0400
In-Reply-To: <20210702091831.615042-2-desmondcheongzx@gmail.com>
References: <20210702091831.615042-1-desmondcheongzx@gmail.com>
         <20210702091831.615042-2-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-07-02 at 17:18 +0800, Desmond Cheong Zhi Xi wrote:
> Syzbot reports a potential deadlock in do_fcntl:
> 
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 5.12.0-syzkaller #0 Not tainted
> --------------------------------------------------------
> syz-executor132/8391 just changed the state of lock:
> ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: f_getown_ex fs/fcntl.c:211 [inline]
> ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: do_fcntl+0x8b4/0x1200 fs/fcntl.c:395
> but this lock was taken by another, HARDIRQ-safe lock in the past:
>  (&dev->event_lock){-...}-{2:2}
> 
> and interrupts could create inverse lock ordering between them.
> 
> other info that might help us debug this:
> Chain exists of:
>   &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
> 
>  Possible interrupt unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&f->f_owner.lock);
>                                local_irq_disable();
>                                lock(&dev->event_lock);
>                                lock(&new->fa_lock);
>   <Interrupt>
>     lock(&dev->event_lock);
> 
>  *** DEADLOCK ***
> 
> This happens because there is a lock hierarchy of
> &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
> from the following call chain:
> 
>   input_inject_event():
>     spin_lock_irqsave(&dev->event_lock,...);
>     input_handle_event():
>       input_pass_values():
>         input_to_handler():
>           evdev_events():
>             evdev_pass_values():
>               spin_lock(&client->buffer_lock);
>               __pass_event():
>                 kill_fasync():
>                   kill_fasync_rcu():
>                     read_lock(&fa->fa_lock);
>                     send_sigio():
>                       read_lock_irqsave(&fown->lock,...);
> 
> However, since &dev->event_lock is HARDIRQ-safe, interrupts have to be
> disabled while grabbing &f->f_owner.lock, otherwise we invert the lock
> hierarchy.
> 
> Hence, we replace calls to read_lock/read_unlock on &f->f_owner.lock,
> with read_lock_irq/read_unlock_irq.
> 

Patches look reasonable overall, but why does this one use read_lock_irq
and the other one use read_lock_irqsave? Don't we need to *_irqsasve in
both patches?


> Reported-and-tested-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
>  fs/fcntl.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index dfc72f15be7f..cf9e81dfa615 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -150,7 +150,8 @@ void f_delown(struct file *filp)
>  pid_t f_getown(struct file *filp)
>  {
>  	pid_t pid = 0;
> -	read_lock(&filp->f_owner.lock);
> +
> +	read_lock_irq(&filp->f_owner.lock);
>  	rcu_read_lock();
>  	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type)) {
>  		pid = pid_vnr(filp->f_owner.pid);
> @@ -158,7 +159,7 @@ pid_t f_getown(struct file *filp)
>  			pid = -pid;
>  	}
>  	rcu_read_unlock();
> -	read_unlock(&filp->f_owner.lock);
> +	read_unlock_irq(&filp->f_owner.lock);
>  	return pid;
>  }
>  
> @@ -208,7 +209,7 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
>  	struct f_owner_ex owner = {};
>  	int ret = 0;
>  
> -	read_lock(&filp->f_owner.lock);
> +	read_lock_irq(&filp->f_owner.lock);
>  	rcu_read_lock();
>  	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type))
>  		owner.pid = pid_vnr(filp->f_owner.pid);
> @@ -231,7 +232,7 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
>  		ret = -EINVAL;
>  		break;
>  	}
> -	read_unlock(&filp->f_owner.lock);
> +	read_unlock_irq(&filp->f_owner.lock);
>  
>  	if (!ret) {
>  		ret = copy_to_user(owner_p, &owner, sizeof(owner));
> @@ -249,10 +250,10 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
>  	uid_t src[2];
>  	int err;
>  
> -	read_lock(&filp->f_owner.lock);
> +	read_lock_irq(&filp->f_owner.lock);
>  	src[0] = from_kuid(user_ns, filp->f_owner.uid);
>  	src[1] = from_kuid(user_ns, filp->f_owner.euid);
> -	read_unlock(&filp->f_owner.lock);
> +	read_unlock_irq(&filp->f_owner.lock);
>  
>  	err  = put_user(src[0], &dst[0]);
>  	err |= put_user(src[1], &dst[1]);

-- 
Jeff Layton <jlayton@kernel.org>

