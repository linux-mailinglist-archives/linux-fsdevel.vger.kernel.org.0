Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D883F3BE74E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 13:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhGGLna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 07:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhGGLn3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:43:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB75661C9A;
        Wed,  7 Jul 2021 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625658049;
        bh=5hdxt/c5mX2gplQZWN++ETvu6S9jK9V5XKZCIG1SJTQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sY0eFYsNZ1kuQxTd+qivqnxq1NK+P8u3XGQmE903J1wJ2+NMN9LTTTnq3TyNg/MYu
         uZ0LYNf/njNfbPzYb7jij6AqXOJ4gp4P1M+6sJHmr5KmeTBt0un/wwVAxIIETXqM9y
         JM+Mfg+BvTmnosDtoeyu093fDbvtYgZFguBlpk3ah599RlZbwHFXi6bt3ru+l+qLLY
         JXo0oRchnIWISyO0O1jJR8x5bxly7z43uKn8owVJ5Cj0vX4wQbDkWwSpsY3OGXdUun
         qVqfSicRWuXpEy/ppnhFK7hR5TtCIfbvPptnKgzEVuSdyyuUP7Xyt61x0nUN7oUwVX
         tKdu415KPGYyA==
Message-ID: <4dda1cad6348fced5fcfcb6140186795ed07d948.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] fcntl: fix potential deadlocks for
 &fown_struct.lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Date:   Wed, 07 Jul 2021 07:40:47 -0400
In-Reply-To: <YOWHKk6Nq8bazYjB@kroah.com>
References: <20210707023548.15872-1-desmondcheongzx@gmail.com>
         <20210707023548.15872-2-desmondcheongzx@gmail.com>
         <YOVENb3X/m/pNrYt@kroah.com>
         <14633c3be87286d811263892375f2dfa9a8ed40a.camel@kernel.org>
         <YOWHKk6Nq8bazYjB@kroah.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 12:51 +0200, Greg KH wrote:
> On Wed, Jul 07, 2021 at 06:44:42AM -0400, Jeff Layton wrote:
> > On Wed, 2021-07-07 at 08:05 +0200, Greg KH wrote:
> > > On Wed, Jul 07, 2021 at 10:35:47AM +0800, Desmond Cheong Zhi Xi wrote:
> > > > Syzbot reports a potential deadlock in do_fcntl:
> > > > 
> > > > ========================================================
> > > > WARNING: possible irq lock inversion dependency detected
> > > > 5.12.0-syzkaller #0 Not tainted
> > > > --------------------------------------------------------
> > > > syz-executor132/8391 just changed the state of lock:
> > > > ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: f_getown_ex fs/fcntl.c:211 [inline]
> > > > ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: do_fcntl+0x8b4/0x1200 fs/fcntl.c:395
> > > > but this lock was taken by another, HARDIRQ-safe lock in the past:
> > > >  (&dev->event_lock){-...}-{2:2}
> > > > 
> > > > and interrupts could create inverse lock ordering between them.
> > > > 
> > > > other info that might help us debug this:
> > > > Chain exists of:
> > > >   &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
> > > > 
> > > >  Possible interrupt unsafe locking scenario:
> > > > 
> > > >        CPU0                    CPU1
> > > >        ----                    ----
> > > >   lock(&f->f_owner.lock);
> > > >                                local_irq_disable();
> > > >                                lock(&dev->event_lock);
> > > >                                lock(&new->fa_lock);
> > > >   <Interrupt>
> > > >     lock(&dev->event_lock);
> > > > 
> > > >  *** DEADLOCK ***
> > > > 
> > > > This happens because there is a lock hierarchy of
> > > > &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
> > > > from the following call chain:
> > > > 
> > > >   input_inject_event():
> > > >     spin_lock_irqsave(&dev->event_lock,...);
> > > >     input_handle_event():
> > > >       input_pass_values():
> > > >         input_to_handler():
> > > >           evdev_events():
> > > >             evdev_pass_values():
> > > >               spin_lock(&client->buffer_lock);
> > > >               __pass_event():
> > > >                 kill_fasync():
> > > >                   kill_fasync_rcu():
> > > >                     read_lock(&fa->fa_lock);
> > > >                     send_sigio():
> > > >                       read_lock_irqsave(&fown->lock,...);
> > > > 
> > > > However, since &dev->event_lock is HARDIRQ-safe, interrupts have to be
> > > > disabled while grabbing &f->f_owner.lock, otherwise we invert the lock
> > > > hierarchy.
> > > > 
> > > > Hence, we replace calls to read_lock/read_unlock on &f->f_owner.lock,
> > > > with read_lock_irq/read_unlock_irq.
> > > > 
> > > > Here read_lock_irq/read_unlock_irq should be safe to use because the
> > > > functions f_getown_ex and f_getowner_uids are only called from
> > > > do_fcntl, and f_getown is only called from do_fnctl and
> > > > sock_ioctl. do_fnctl itself is only called from syscalls.
> > > > 
> > > > For sock_ioctl, the chain is
> > > >   compat_sock_ioctl():
> > > >     compat_sock_ioctl_trans():
> > > >       sock_ioctl()
> > > > 
> > > > And interrupts are not disabled on either path. We assert this
> > > > assumption with WARN_ON_ONCE(irqs_disabled()). This check is also
> > > > inserted into another use of write_lock_irq in f_modown.
> > > > 
> > > > Reported-and-tested-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
> > > > Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> > > > ---
> > > >  fs/fcntl.c | 17 +++++++++++------
> > > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > index dfc72f15be7f..262235e02c4b 100644
> > > > --- a/fs/fcntl.c
> > > > +++ b/fs/fcntl.c
> > > > @@ -88,6 +88,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
> > > >  static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
> > > >                       int force)
> > > >  {
> > > > +	WARN_ON_ONCE(irqs_disabled());
> > > 
> > > If this triggers, you just rebooted the box :(
> > > 
> > > Please never do this, either properly handle the problem and return an
> > > error, or do not check for this.  It is not any type of "fix" at all,
> > > and at most, a debugging aid while you work on the root problem.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Wait, what? Why would testing for irqs being disabled and throwing a
> > WARN_ON in that case crash the box?
> 
> If panic-on-warn is enabled, which is a common setting for systems these
> days.

Ok, that makes some sense.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

