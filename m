Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94855DA523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 07:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392392AbfJQF1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 01:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfJQF1p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 01:27:45 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40CF2082C;
        Thu, 17 Oct 2019 05:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571290064;
        bh=cvii7IoLU8oou9av1ctfLhhGghmK/B6OwKzMBcYtoAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfQ9TFNNkpfkvNX1IN9qLrYD7DR6wKfVMhfQq0mTE9WBzviP4UR5pkUW+O0pmyrE0
         gkGa5fwVa/V4KshdDYn9Y2wB7XWLOuXrc1R2BGAxIuWiiQDOQYR1bycmpTQPk4iGI2
         uaV+yC+ZNCcW0mlxXLie3p5kDky24wfGTd6+bARc=
Date:   Wed, 16 Oct 2019 22:27:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING: bad unlock balance in rcu_lock_release
Message-ID: <20191017052742.GI1552@sol.localdomain>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
        syzbot <syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000fdd3f3058bfcf369@google.com>
 <0000000000004ecdb90594d16d77@google.com>
 <20191015075631.GB21550@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015075631.GB21550@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:56:31AM +0200, Jan Kara wrote:
> On Sun 13-10-19 14:28:06, syzbot wrote:
> > syzbot has found a reproducer for the following crash on:
> > 
> > HEAD commit:    da940012 Merge tag 'char-misc-5.4-rc3' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12cfdf4f600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2d2fd92a28d3e50
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f9545ab3e9f85cd43a3a
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148c9fc7600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100d3f8b600000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com
> > 
> > =====================================
> > WARNING: bad unlock balance detected!
> > 5.4.0-rc2+ #0 Not tainted
> > -------------------------------------
> > syz-executor111/7877 is trying to release lock (rcu_callback) at:
> > [<ffffffff81612bd4>] rcu_lock_release+0x4/0x20 include/linux/rcupdate.h:212
> > but there are no more locks to release!
> 
> Hum, this is really weird. Look:
> 
> > other info that might help us debug this:
> > 1 lock held by syz-executor111/7877:
> >  #0: ffff8880a3c600d8 (&type->s_umount_key#42/1){+.+.}, at:
> > alloc_super+0x15f/0x790 fs/super.c:229
> > 
> > stack backtrace:
> > CPU: 1 PID: 7877 Comm: syz-executor111 Not tainted 5.4.0-rc2+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
> >  print_unlock_imbalance_bug+0x20b/0x240 kernel/locking/lockdep.c:4008
> >  __lock_release kernel/locking/lockdep.c:4244 [inline]
> >  lock_release+0x473/0x780 kernel/locking/lockdep.c:4506
> >  rcu_lock_release+0x1c/0x20 include/linux/rcupdate.h:214
> >  __rcu_reclaim kernel/rcu/rcu.h:223 [inline]
> 
> __rcu_reclaim_kernel() has:
> 
>         rcu_lock_acquire(&rcu_callback_map);
>         if (__is_kfree_rcu_offset(offset)) {
>                 trace_rcu_invoke_kfree_callback(rn, head, offset);
>                 kfree((void *)head - offset);
>                 rcu_lock_release(&rcu_callback_map);
>                 return true;
>         } else {
>                 trace_rcu_invoke_callback(rn, head);
>                 f = head->func;
>                 WRITE_ONCE(head->func, (rcu_callback_t)0L);
>                 f(head);
>                 rcu_lock_release(&rcu_callback_map);
>                 return false;
>         }
> 
> So RCU locking is clearly balanced there. The only possibility I can see
> how this can happen is that RCU callback we have called actually released
> rcu_callback_map but grepping the kernel doesn't show any other place where
> that would get released? Confused.
> 
> But apparently there is even a reproducer for this so we could dig
> further...
> 

It's probably the same cause as "WARNING: bad unlock balance in rcu_core", see
the thread: https://lkml.kernel.org/linux-fsdevel/000000000000c0bffa0586795098@google.com/T/#u
Looks related to the lockdep_off() in ntfs_fill_super().

- Eric
