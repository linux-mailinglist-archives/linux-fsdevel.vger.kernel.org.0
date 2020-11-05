Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32B82A7EE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgKEMp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 07:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgKEMp5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:45:57 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1D520756;
        Thu,  5 Nov 2020 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604580356;
        bh=1GelF9aRS5tVKsklgGIdwFZL8G7WthPJK6xM7HDfius=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wfjm6yzetyE7/MEg7l1Bp+8URz4uvYNPafBAJo4vL6C9HMYp1Fsjs8PnGCu9yhASy
         SLnPFPXFj06J2Wg8jrE6tveEgqi/H9454LvbeEdfAR9KhU31vF4zgJ/9MevMK0SYyw
         hSOoIFQLO+87HdDHMpd+tI+KQW53JOiT33qhztrg=
Message-ID: <d09ae090e7ec770cf799f1072a59cafe4efb6150.camel@kernel.org>
Subject: Re: possible deadlock in send_sigurg (2)
From:   Jeff Layton <jlayton@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>,
        syzbot <syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com>
Cc:     bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Date:   Thu, 05 Nov 2020 07:45:54 -0500
In-Reply-To: <20201105062351.GA2840779@boqun-archlinux>
References: <0000000000009d056805b252e883@google.com>
         <000000000000e1c72705b346f8e6@google.com>
         <20201105062351.GA2840779@boqun-archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-11-05 at 14:23 +0800, Boqun Feng wrote:
> Hi,
> 
> On Wed, Nov 04, 2020 at 04:18:08AM -0800, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit e918188611f073063415f40fae568fa4d86d9044
> > Author: Boqun Feng <boqun.feng@gmail.com>
> > Date:   Fri Aug 7 07:42:20 2020 +0000
> > 
> >     locking: More accurate annotations for read_lock()
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14142732500000
> > start commit:   4ef8451b Merge tag 'perf-tools-for-v5.10-2020-11-03' of gi..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=16142732500000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12142732500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c5e32344981ad9f33750
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15197862500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c59f6c500000
> > 
> > Reported-by: syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com
> > Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Thanks for reporting this, and this is actually a deadlock potential
> detected by the newly added recursive read deadlock detection as my
> analysis:
> 
> 	https://lore.kernel.org/lkml/20200910071523.GF7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net
> 
> Besides, other reports[1][2] are caused by the same problem. I made a
> fix for this, please have a try and see if it's get fixed.
> 
> Regards,
> Boqun
> 
> [1]: https://lore.kernel.org/lkml/000000000000d7136005aee14bf9@google.com
> [2]: https://lore.kernel.org/lkml/0000000000006e29ed05b3009b04@google.com
> 
> ----------------------------------------------------->8
> From 7fbe730fcff2d7909be034cf6dc8bf0604d0bf14 Mon Sep 17 00:00:00 2001
> From: Boqun Feng <boqun.feng@gmail.com>
> Date: Thu, 5 Nov 2020 14:02:57 +0800
> Subject: [PATCH] fs/fcntl: Fix potential deadlock in send_sig{io, urg}()
> 
> Syzbot reports a potential deadlock found by the newly added recursive
> read deadlock detection in lockdep:
> 
> [...] ========================================================
> [...] WARNING: possible irq lock inversion dependency detected
> [...] 5.9.0-rc2-syzkaller #0 Not tainted
> [...] --------------------------------------------------------
> [...] syz-executor.1/10214 just changed the state of lock:
> [...] ffff88811f506338 (&f->f_owner.lock){.+..}-{2:2}, at: send_sigurg+0x1d/0x200
> [...] but this lock was taken by another, HARDIRQ-safe lock in the past:
> [...]  (&dev->event_lock){-...}-{2:2}
> [...]
> [...]
> [...] and interrupts could create inverse lock ordering between them.
> [...]
> [...]
> [...] other info that might help us debug this:
> [...] Chain exists of:
> [...]   &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
> [...]
> [...]  Possible interrupt unsafe locking scenario:
> [...]
> [...]        CPU0                    CPU1
> [...]        ----                    ----
> [...]   lock(&f->f_owner.lock);
> [...]                                local_irq_disable();
> [...]                                lock(&dev->event_lock);
> [...]                                lock(&new->fa_lock);
> [...]   <Interrupt>
> [...]     lock(&dev->event_lock);
> [...]
> [...]  *** DEADLOCK ***
> 
> The corresponding deadlock case is as followed:
> 
> 	CPU 0		CPU 1		CPU 2
> 	read_lock(&fown->lock);
> 			spin_lock_irqsave(&dev->event_lock, ...)
> 					write_lock_irq(&filp->f_owner.lock); // wait for the lock
> 			read_lock(&fown-lock); // have to wait until the writer release
> 					       // due to the fairness
> 	<interrupted>
> 	spin_lock_irqsave(&dev->event_lock); // wait for the lock
> 
> The lock dependency on CPU 1 happens if there exists a call sequence:
> 
> 	input_inject_event():
> 	  spin_lock_irqsave(&dev->event_lock,...);
> 	  input_handle_event():
> 	    input_pass_values():
> 	      input_to_handler():
> 	        handler->event(): // evdev_event()
> 	          evdev_pass_values():
> 	            spin_lock(&client->buffer_lock);
> 	            __pass_event():
> 	              kill_fasync():
> 	                kill_fasync_rcu():
> 	                  read_lock(&fa->fa_lock);
> 	                  send_sigio():
> 	                    read_lock(&fown->lock);
> 
> To fix this, make the reader in send_sigurg() and send_sigio() use
> read_lock_irqsave() and read_lock_irqrestore().
> 
> Reported-by: syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com
> Reported-by: syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  fs/fcntl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 19ac5baad50f..05b36b28f2e8 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -781,9 +781,10 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
>  {
>  	struct task_struct *p;
>  	enum pid_type type;
> +	unsigned long flags;
>  	struct pid *pid;
>  	
> -	read_lock(&fown->lock);
> +	read_lock_irqsave(&fown->lock, flags);
>  
> 
>  	type = fown->pid_type;
>  	pid = fown->pid;
> @@ -804,7 +805,7 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
>  		read_unlock(&tasklist_lock);
>  	}
>   out_unlock_fown:
> -	read_unlock(&fown->lock);
> +	read_unlock_irqrestore(&fown->lock, flags);
>  }
>  
> 
>  static void send_sigurg_to_task(struct task_struct *p,
> @@ -819,9 +820,10 @@ int send_sigurg(struct fown_struct *fown)
>  	struct task_struct *p;
>  	enum pid_type type;
>  	struct pid *pid;
> +	unsigned long flags;
>  	int ret = 0;
>  	
> -	read_lock(&fown->lock);
> +	read_lock_irqsave(&fown->lock, flags);
>  
> 
>  	type = fown->pid_type;
>  	pid = fown->pid;
> @@ -844,7 +846,7 @@ int send_sigurg(struct fown_struct *fown)
>  		read_unlock(&tasklist_lock);
>  	}
>   out_unlock_fown:
> -	read_unlock(&fown->lock);
> +	read_unlock_irqrestore(&fown->lock, flags);
>  	return ret;
>  }
>  
> 

Thanks Boqun,

This looks sane to me. I'll go ahead and pull it into -next for now, and
it should make v5.11. Let me know if you think it needs to go in sooner.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

