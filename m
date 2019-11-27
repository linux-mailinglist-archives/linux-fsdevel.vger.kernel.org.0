Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9514710C09E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 00:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfK0X1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 18:27:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39750 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfK0X1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:27:30 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so2901376oib.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 15:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o17+8CbvEVhOy52GU617H5c27TW8wRMeItKugWda1E8=;
        b=gEfFygk6zlq4YjlSAWZP+mBposTPLDRB0XxbdPfaSa+M9iiNgVGB8mYWVDeb9AVTsk
         YrA3GXh9ZLq4Z+xsJQhqojijbIxtEdSI1+fWzY+kmoYOLvqpkzqR6rXb56Y09ug897bC
         eWBu9yWelTnScG+tv6mjz4fDwDi9w38OTIl6SHxAWgCSIC6PMa4eWYVdx2GMzV9dcLcQ
         Se5pJt/Ybo+2hmCxGnMZDi2tDNMQExJNlLyEYnebNDH34CYmhwqbBfPpOu5pjURX3AuE
         MUaRGQUqSsCf162tumHS06Y/2RmW7YNUzvfGIddWVqJq/34EW44h1+ePcEqcxOEhJKYU
         4YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o17+8CbvEVhOy52GU617H5c27TW8wRMeItKugWda1E8=;
        b=Tm89jmAz7pzGAT2mjhXruTr5rcyuxh0A9O4EXMWzuydPt0lZh5wCMoXoUN/RJ4CUe9
         qM+DHKdgB95D+88Al2QvEsUKc8I4q8XVJZnKx6qYbr2SVXpqO30wlfRpoaZnTjCV218z
         JzhGxSBHgBzkBU9BihyANjYvnj5KgqTVX7kK4Ws/uIAVTExTKriPZ3mME1NGqNCknshc
         56oIi6HxJuRoFPe7EAyrSYF09oi4afw5XwtkhwUPBaWiIYX/kMaaaclxeKfZvVBeRufR
         25Ksf7GVWZNNZR7YzaS8azSm/Jyz20j/yTl1FkdVq3NRqiP4qK6LTSo85xRdT08pgc9n
         nD8w==
X-Gm-Message-State: APjAAAWwUVSMDJz4rs7UMADY9uq6oYDmjkHMvd4q/tb92UVTZlth8Lkc
        nVk6ir/+oA2UdK6JhV2C7HBZ+fRVyIuikPTYgoa3gTANzqY=
X-Google-Smtp-Source: APXvYqz/AUEd3lH0kPPmUTqXkVmSb9WSAhqCK7EciEEtyrVLgZRj53oKw15Kf7wNjADfJLYnoAQVfAgL4uUDIqrpQDY=
X-Received: by 2002:a05:6808:9a1:: with SMTP id e1mr6352651oig.175.1574897248917;
 Wed, 27 Nov 2019 15:27:28 -0800 (PST)
MIME-Version: 1.0
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com> <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk>
In-Reply-To: <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Nov 2019 00:27:02 +0100
Message-ID: <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 9:48 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 11/27/19 12:23 PM, Jann Horn wrote:
> > On Wed, Nov 27, 2019 at 6:11 AM Jens Axboe <axboe@kernel.dk> wrote:
> >> I posted this a few weeks back, took another look at it and refined it a
> >> bit. I'd like some input on the viability of this approach.
> >>
> >> A new signalfd setup flag is added, SFD_TASK. This is only valid if used
> >> with SFD_CLOEXEC. If set, the task setting up the signalfd descriptor is
> >> remembered in the signalfd context, and will be the one we use for
> >> checking signals in the poll/read handlers in signalfd.
> >>
> >> This is needed to make signalfd useful with io_uring and aio, of which
> >> the former in particular has my interest.
> >>
> >> I _think_ this is sane. To prevent the case of a task clearing O_CLOEXEC
> >> on the signalfd descriptor, forking, and then exiting, we grab a
> >> reference to the task when we assign it. If that original task exits, we
> >> catch it in signalfd_flush() and ensure waiters are woken up.
> >
> > Mh... that's not really reliable, because you only get ->flush() from
> > the last exiting thread (or more precisely, the last exiting task that
> > shares the files_struct).
> >
> > What is your goal here? To have a reference to a task without keeping
> > the entire task_struct around in memory if someone leaks the signalfd
> > to another process - basically like a weak pointer? If so, you could
> > store a refcounted reference to "struct pid" instead of a refcounted
> > reference to the task_struct, and then do the lookup of the
> > task_struct on ->poll and ->read (similar to what procfs does).
>
> Yeah, I think that works out much better (and cleaner). How about this,
> then? Follows your advice and turns it into a struct pid instead. I
> don't particularly like the -ESRCH in dequeue and setup, what do you
> think? For poll, POLLERR seems like a prudent choice.

-ESRCH may be kinda weird, but I also can't think of anything
better... and it does describe the problem pretty accurately: The task
whose signal state you're trying to inspect is gone. I went through
the list of errnos, and everything else sounded more weird...


One more thing, though: We'll have to figure out some way to
invalidate the fd when the target goes through execve(), in particular
if it's a setuid execution. Otherwise we'll be able to just steal
signals that were intended for the other task, that's probably not
good.

So we should:
 a) prevent using ->wait() on an old signalfd once the task has gone
through execve()
 b) kick off all existing waiters
 c) most importantly, prevent ->read() on an old signalfd once the
task has gone through execve()

We probably want to avoid using the cred_guard_mutex here, since it is
quite broad and has some deadlocking issues; it might make sense to
put the update of ->self_exec_id in fs/exec.c under something like the
siglock, and then for a) and c) we can check whether the
->self_exec_id changed while holding the siglock, and for b) we can
add a call to signalfd_cleanup() after the ->self_exec_id change.

> +static void signalfd_put_task(struct signalfd_ctx *ctx, struct task_struct *tsk)
> +{
> +       if (ctx->task_pid)
> +               put_task_struct(tsk);
> +}
> +
> +static struct task_struct *signalfd_get_task(struct signalfd_ctx *ctx)
> +{
> +       if (ctx->task_pid)
> +               return get_pid_task(ctx->task_pid, PIDTYPE_PID);
> +
> +       return current;
> +}

This works, and I guess it's a question of coding style... but I'd
kinda prefer to do the refcount operation in both cases, so that the
semantics of the returned reference are simply "holds a reference"
instead of "either holds a reference or borrows from current depending
on ctx->task_pid". But if you feel strongly about it, feel free to
keep it as-is.

[...]
> -       add_wait_queue(&current->sighand->signalfd_wqh, &wait);
> +       add_wait_queue(&tsk->sighand->signalfd_wqh, &wait);
>         for (;;) {
>                 set_current_state(TASK_INTERRUPTIBLE);
> -               ret = dequeue_signal(current, &ctx->sigmask, info);
> +               ret = dequeue_signal(tsk, &ctx->sigmask, info);
>                 if (ret != 0)
>                         break;
>                 if (signal_pending(current)) {
>                         ret = -ERESTARTSYS;
>                         break;
>                 }
> -               spin_unlock_irq(&current->sighand->siglock);
> +               spin_unlock_irq(&tsk->sighand->siglock);
>                 schedule();

Should we be dropping the reference to the task before schedule() and
re-acquiring it afterwards so that if we're blocked on a signalfd read
and then the corresponding task dies, the refcount can drop to zero
and we can get woken up? Probably doesn't matter, but seems a bit
cleaner to me.

> -               spin_lock_irq(&current->sighand->siglock);
> +               spin_lock_irq(&tsk->sighand->siglock);
>         }
> -       spin_unlock_irq(&current->sighand->siglock);
> +       spin_unlock_irq(&tsk->sighand->siglock);
>
> -       remove_wait_queue(&current->sighand->signalfd_wqh, &wait);
> +       remove_wait_queue(&tsk->sighand->signalfd_wqh, &wait);
>         __set_current_state(TASK_RUNNING);
>
> +       signalfd_put_task(ctx, tsk);
>         return ret;
>   }
>
> @@ -267,19 +296,24 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
>         /* Check the SFD_* constants for consistency.  */
>         BUILD_BUG_ON(SFD_CLOEXEC != O_CLOEXEC);
>         BUILD_BUG_ON(SFD_NONBLOCK != O_NONBLOCK);
> +       BUILD_BUG_ON(SFD_TASK & (SFD_CLOEXEC | SFD_NONBLOCK));
>
> -       if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK))
> +       if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK | SFD_TASK))
> +               return -EINVAL;
> +       if ((flags & (SFD_CLOEXEC | SFD_TASK)) == SFD_TASK)
>                 return -EINVAL;

(non-actionable comment: It seems kinda weird that you can specify
these parameters with no effect for the `uffd != -1` case... but since
the existing parameters already work that way, I guess it's
consistent.)
