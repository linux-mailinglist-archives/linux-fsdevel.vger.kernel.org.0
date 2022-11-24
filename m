Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E3E63724D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 07:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKXGV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 01:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKXGV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:21:27 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A793CD7;
        Wed, 23 Nov 2022 22:21:24 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id 124so664067vsv.4;
        Wed, 23 Nov 2022 22:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtFcW3+88rS+G9ApXMftzKq9j1YlsQHhTP69bVKC3HI=;
        b=WK889YFJqOaDU8xtSW7IS2l0YM0qP31X2yLaHo9zwMiHihzADV6uZE0QVM8FS55QP/
         d9G2qkZSXPOOIturX1up8t4VooU5u5qF4eM2EX3S2dVG7GLHjV8tDZFBKnoanZCg1//n
         2UMzwcSTQckeVduzhVMtzUPoFEVRlK2+R6RUJLUTUaEUgTjLtsWZBRqQ2hA5cCMuqp4W
         Ts+6NwjeoTjxRUXzhgmqOsyfYwgD8A3Dxb4z4O+VzH/Q2O8tZG91kNL+EIpbjcNGrWp0
         u44ZUsI26jXB27BPRRMAIVQ1udYwoAA5dQVVeOKnbbdpJlP3log4jZw17qpiGT0oUVDP
         H3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtFcW3+88rS+G9ApXMftzKq9j1YlsQHhTP69bVKC3HI=;
        b=1H6H8m7CAErHFN7fEGYs/AVrzQ39YccMmB9H7wFOb86wAVR8Kp0m3/YgFE/akF3aGe
         +RuhZup3a2Hw7xkPf5kUwSPzeu1qJ33rjKZVjLFMQKhz1dg8eYrYMXpzSLsL1jFqy5VF
         sgzELeVms8xYaYziZKsPfIFnIT+lBVCQB63bIWgMqZH7PzKMcj/50ehow4NO1H8nVYf6
         av6zU3NoxC3zKwJk0+3elrxIVGMFViVyC40kJV4Z+wEq3TGY1LsHXR5ARHLXCa5f6tE9
         VlJ3Apu/0PU7UlzIlWvThxYrK3vUg26R3SAFSrsyx9LqAL6ViR1BNrbDo9Z6eMl8VR4C
         zuoQ==
X-Gm-Message-State: ANoB5pmuLjGs8MqAgDKhPhiYkvqJMsHGhlqCGaUfs2KItcrftAfDG0UI
        ZxFTFz5/OzxFaCyv5NCM+k5Nx3lRILT0OyYfve8=
X-Google-Smtp-Source: AA0mqf4VCN00grmzHmrPYRVJC6glnDQrUS9uAenqDukSRJ3eQqxyJ7nb0m2dG8BkiXELmC0zsWWZQp1B1lKyEhs2v4o=
X-Received: by 2002:a67:6dc4:0:b0:3aa:320a:90a7 with SMTP id
 i187-20020a676dc4000000b003aa320a90a7mr9522110vsc.3.1669270884886; Wed, 23
 Nov 2022 22:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20221123114645.3aowv3hw4hxqr2ed@quack3> <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Nov 2022 08:21:13 +0200
Message-ID: <CAOQ4uxge4cF_o80bbXPE2ZAjRwy9zNA6U1oXsdyYsiF-wVRvpA@mail.gmail.com>
Subject: Re: SRCU use from different contexts
To:     paulmck@kernel.org
Cc:     Jan Kara <jack@suse.cz>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+fsdevel]

On Thu, Nov 24, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> > Hello!
> >
> > We were pondering with Amir about some issues with fsnotify subsystem and
> > as a building block we would need a mechanism to make sure write(2) has
> > completed. For simplicity we could imagine it like a sequence
> >
> > write(2)
> >   START
> >   do stuff to perform write
> >   END
> >
> > and we need a mechanism to wait for all processes that already passed START
> > to reach END. Ideally without blocking new writes while we wait for the
> > pending ones. Now this seems like a good task for SRCU. We could do:
> >
> > write(2)
> >   srcu_read_lock(&sb->s_write_rcu);
> >   do stuff to perform write
> >   srcu_read_unlock(&sb->s_write_rcu);
> >
> > and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> >
> > But the trouble with writes is there are things like aio or io_uring where
> > the part with srcu_read_lock() happens from one task (the submitter) while
> > the part with srcu_read_unlock() happens from another context (usually worker
> > thread triggered by IRQ reporting that the HW has finished the IO).
> >
> > Is there any chance to make SRCU work in a situation like this? It seems to
> > me in principle it should be possible to make this work but maybe there are
> > some implementation constraints I'm missing...
>
> The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
> will work for this, though that is not their intended purpose.  Plus you
> might want to trace these functions, which, as their names indicate, is
> not permitted.  I assume that you do not intend to use these functions
> from NMI handlers, though that really could be accommodated.  (But why
> would you need that?)
>
> So how about srcu_down_read() and srcu_up_read(), as shown in the
> (untested) patch below?
>
> Note that you do still need to pass the return value from srcu_down_read()
> into srcu_up_read().  I am guessing that io_uring has a convenient place
> that this value can be placed.  No idea about aio.
>

Sure, aio completion has context.

> Thoughts?

That looks great! Thank you.

Followup question:
Both fs/aio.c:aio_write() and io_uring/rw.c:io_write() do this ugly
thing:

/*
 * Open-code file_start_write here to grab freeze protection,
 * which will be released by another thread in
 * aio_complete_rw().  Fool lockdep by telling it the lock got
 * released so that it doesn't complain about the held lock when
 * we return to userspace.
 */
if (S_ISREG(file_inode(file)->i_mode)) {
    sb_start_write(file_inode(file)->i_sb);
    __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
}

And in write completion:

/*
 * Tell lockdep we inherited freeze protection from submission
 * thread.
 */
if (S_ISREG(inode->i_mode))
    __sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
file_end_write(kiocb->ki_filp);

I suppose we also need to "fool lockdep" w.r.t returning to userspace
with an acquired srcu?

Thanks,
Amir.

>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 0efa1e7b5a862e9c2f1bf8c19db6bd142ad35355
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Nov 23 15:49:55 2022 -0800
>
>     rcu: Add srcu_down_read() and srcu_up_read()
>
>     A pair of matching srcu_read_lock() and srcu_read_unlock() invocations
>     must take place within the same context, for example, within the same
>     task.  Otherwise, lockdep complains, as is the right thing to do for
>     most use cases.
>
>     However, there are use cases involving asynchronous I/O where the
>     SRCU reader needs to begin on one task and end on another.  This commit
>     therefore supplies the semaphore-like srcu_down_read() and srcu_up_read(),
>     which act like srcu_read_lock() and srcu_read_unlock(), but permitting
>     srcu_up_read() to be invoked in a different context than was the matching
>     srcu_down_read().
>
>     Neither srcu_down_read() nor srcu_up_read() may be invoked from an
>     NMI handler.
>
>     Reported-by: Jan Kara <jack@suse.cz>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 9b9d0bbf1d3cf..74796cd7e7a9d 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -214,6 +214,34 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>         return retval;
>  }
>
> +/**
> + * srcu_down_read - register a new reader for an SRCU-protected structure.
> + * @ssp: srcu_struct in which to register the new reader.
> + *
> + * Enter a semaphore-like SRCU read-side critical section.  Note that
> + * SRCU read-side critical sections may be nested.  However, it is
> + * illegal to call anything that waits on an SRCU grace period for the
> + * same srcu_struct, whether directly or indirectly.  Please note that
> + * one way to indirectly wait on an SRCU grace period is to acquire
> + * a mutex that is held elsewhere while calling synchronize_srcu() or
> + * synchronize_srcu_expedited().  But if you want lockdep to help you
> + * keep this stuff straight, you should instead use srcu_read_lock().
> + *
> + * The semaphore-like nature of srcu_down_read() means that the matching
> + * srcu_up_read() can be invoked from some other context, for example,
> + * from some other task or from an irq handler.  However, neither
> + * srcu_down_read() nor srcu_up_read() may be invoked from an NMI handler.
> + *
> + * Calls to srcu_down_read() may be nested, similar to the manner in
> + * which calls to down_read() may be nested.
> + */
> +static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
> +{
> +       WARN_ON_ONCE(in_nmi());
> +       srcu_check_nmi_safety(ssp, false);
> +       return __srcu_read_lock(ssp);
> +}
> +
>  /**
>   * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
>   * @ssp: srcu_struct in which to unregister the old reader.
> @@ -254,6 +282,23 @@ srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
>         __srcu_read_unlock(ssp, idx);
>  }
>
> +/**
> + * srcu_up_read - unregister a old reader from an SRCU-protected structure.
> + * @ssp: srcu_struct in which to unregister the old reader.
> + * @idx: return value from corresponding srcu_read_lock().
> + *
> + * Exit an SRCU read-side critical section, but not necessarily from
> + * the same context as the maching srcu_down_read().
> + */
> +static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
> +       __releases(ssp)
> +{
> +       WARN_ON_ONCE(idx & ~0x1);
> +       WARN_ON_ONCE(in_nmi());
> +       srcu_check_nmi_safety(ssp, false);
> +       __srcu_read_unlock(ssp, idx);
> +}
> +
>  /**
>   * smp_mb__after_srcu_read_unlock - ensure full ordering after srcu_read_unlock
>   *
