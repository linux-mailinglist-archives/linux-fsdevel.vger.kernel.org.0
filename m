Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF17C2A6606
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 15:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKDOLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 09:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKDOLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:11:44 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A965C0613D3;
        Wed,  4 Nov 2020 06:11:44 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id k21so22293223ioa.9;
        Wed, 04 Nov 2020 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcaSFKbqGOU4PLbSCaH2MHC7wub+NBzcw+dl0wjN4Fk=;
        b=UZ57raZCjB4yNnYG3mFlVwfOQ1c+QZWIZU2YrD5sWA3r3lG3I+3BwGWJzFdLgUYx4R
         vCBovJqGUyt+OOpwnuwEBh4NxpQfzob1dgzibxCR2QwTM9HeVByS7oRReDZeqEzbbNHa
         GAvPYKIsVCL4DIlHZBoivyCF8GeJKKHkB3oBlMmioXOGCuLsPxSNHJugtKp1Eh7PqA+0
         p3QfIVxZ97D1VbbTaNwBABnfGozO+SalwMAPOOAyxtb9849dmgSn7bJ0eN3xeMAJVKZ/
         6vTRtBrC0U1d1VzsL14M2faXYCixtTCLaaPghNitoVX19KV1z5uo50ZF9domZ7efHIvg
         i3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcaSFKbqGOU4PLbSCaH2MHC7wub+NBzcw+dl0wjN4Fk=;
        b=Jh1tz81kEENAdNQFjIBq7vRsZ+kLbJFGphh6cPhqJ9cqZg3OaAv68cfmIguN19xAkX
         Fppqq8/MNrmVVTVMQyNVjLXcztFPo5gnrjeTV6+fMwkqa7/YJ6bQADs3vOoEwmI2JH3J
         VHPCyfZ8EISI73XIRMf/K9KIEgdhFff+bf73/kkQ8hhBnCStRI+C7PPhKeBNezMLFNrE
         B/10zuKGSWOqC2oMgjQtTGHdy3x8ge3SDWcPPmwbXiw6a0phaLLEgdcYJ1iWsw5drb7O
         6kqBEYzFERsaSXu4LQ1MW+po50MtGFBvVx5MsPtMjYIL3uAAl15Qsn946z62SFYThW7z
         7nIQ==
X-Gm-Message-State: AOAM5334NeJEh7zLPV+bnfB8LdbOht7fylaqBE1468unDmPS5ZUHDVVU
        FQod4YDHaDt/I9HaG5RnRlWzk3iqXvaGQ3toK0w=
X-Google-Smtp-Source: ABdhPJxZuzV9UoMHwj/CvTEHOj1cGrNTdFNhFuQiEo/BFYsxZp36DnEflp1wC939F/vkGng1txW1q3odq5GD3tUozy0=
X-Received: by 2002:a5d:9850:: with SMTP id p16mr4060362ios.81.1604499103813;
 Wed, 04 Nov 2020 06:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20201103131754.94949-1-laoar.shao@gmail.com> <20201103131754.94949-3-laoar.shao@gmail.com>
 <20201104001649.GN7123@magnolia>
In-Reply-To: <20201104001649.GN7123@magnolia>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 4 Nov 2020 22:11:07 +0800
Message-ID: <CALOAHbB6Zace5BrBcv2XoB2xBNL-0XKS480YLVx2X11iv0JeZQ@mail.gmail.com>
Subject: Re: [PATCH v8 resend 2/2] xfs: avoid transaction reservation recursion
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 4, 2020 at 8:18 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Nov 03, 2020 at 09:17:54PM +0800, Yafang Shao wrote:
> > PF_FSTRANS which is used to avoid transaction reservation recursion, is
> > dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> > PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> > memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> > means to avoid filesystem reclaim recursion. That change is subtle.
> > Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> > PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> > PF_MEMALLOC_NOFS is not proper.
> > Below comment is quoted from Dave,
> > > It wasn't for memory allocation recursion protection in XFS - it was for
> > > transaction reservation recursion protection by something trying to flush
> > > data pages while holding a transaction reservation. Doing
> > > this could deadlock the journal because the existing reservation
> > > could prevent the nested reservation for being able to reserve space
> > > in the journal and that is a self-deadlock vector.
> > > IOWs, this check is not protecting against memory reclaim recursion
> > > bugs at all (that's the previous check [1]). This check is
> > > protecting against the filesystem calling writepages directly from a
> > > context where it can self-deadlock.
> > > So what we are seeing here is that the PF_FSTRANS ->
> > > PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> > > about what type of error this check was protecting against.
> >
> > As a result, we should reintroduce PF_FSTRANS. As current->journal_info
> > isn't used in XFS, we can reuse it to indicate whehter the task is in
> > fstrans or not, Per Willy. To achieve that, four new helpers are introduce
> > in this patch, per Dave:
> > - xfs_trans_context_set()
> >   Used in xfs_trans_alloc()
> > - xfs_trans_context_clear()
> >   Used in xfs_trans_commit() and xfs_trans_cancel()
> > - xfs_trans_context_update()
> >   Used in xfs_trans_roll()
> > - xfs_trans_context_active()
> >   To check whehter current is in fs transcation or not
> > [1]. Below check is to avoid memory reclaim recursion.
> > if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> >         PF_MEMALLOC))
> >         goto redirty;
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
>
> Urrrrk, I found some problems with this patch while testing.  xfs/141
> blows up with:
>
> XFS: Assertion failed: current->journal_info == tp, file:
> fs/xfs/xfs_trans.h, line: 289
>
> The call trace is very garbled, but I think it is:
>
> +[ 1815.870749]  __xfs_trans_commit+0x4df/0x680 [xfs]
> +[ 1815.871342]  xfs_symlink+0x5ec/0xac0 [xfs]
> +[ 1815.871834]  ? lock_release+0x20d/0x450
> +[ 1815.872280]  ? get_cached_acl+0x32/0x250
> +[ 1815.872847]  xfs_vn_symlink+0x8d/0x1b0 [xfs]
> +[ 1815.873742]  vfs_symlink+0xc7/0x150
> +[ 1815.874356]  do_symlinkat+0x83/0x110
> +[ 1815.874788]  do_syscall_64+0x31/0x40
> +[ 1815.875204]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> +[ 1815.875781] RIP: 0033:0x7f2317fc6d7b
>
>
> > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > index c94e71f..b272d07 100644
> > --- a/fs/xfs/xfs_trans.c
> > +++ b/fs/xfs/xfs_trans.c
> > @@ -153,8 +153,6 @@
> >       int                     error = 0;
> >       bool                    rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
> >
> > -     /* Mark this thread as being in a transaction */
> > -     current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> >
> >       /*
> >        * Attempt to reserve the needed disk blocks by decrementing
> > @@ -163,10 +161,8 @@
> >        */
> >       if (blocks > 0) {
> >               error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> > -             if (error != 0) {
> > -                     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +             if (error != 0)
> >                       return -ENOSPC;
> > -             }
> >               tp->t_blk_res += blocks;
> >       }
> >
> > @@ -241,8 +237,6 @@
> >               tp->t_blk_res = 0;
> >       }
> >
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > -
> >       return error;
> >  }
> >
> > @@ -284,6 +278,8 @@
> >       INIT_LIST_HEAD(&tp->t_dfops);
> >       tp->t_firstblock = NULLFSBLOCK;
> >
> > +     /* Mark this thread as being in a transaction */
> > +     xfs_trans_context_set(tp);
> >       error = xfs_trans_reserve(tp, resp, blocks, rtextents);
> >       if (error) {
> >               xfs_trans_cancel(tp);
>
> You're missing a xfs_trans_context_clear() call here.
>
> > @@ -878,7 +874,8 @@
> >
> >       xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
> >
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     if (!regrant)
> > +             xfs_trans_context_clear(tp);
> >       xfs_trans_free(tp);
> >
> >       /*
> > @@ -910,7 +907,8 @@
> >                       xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
> >               tp->t_ticket = NULL;
> >       }
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +
> > +     xfs_trans_context_clear(tp);
> >       xfs_trans_free_items(tp, !!error);
> >       xfs_trans_free(tp);
> >
> > @@ -971,7 +969,7 @@
> >       }
> >
> >       /* mark this thread as no longer being in a transaction */
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     xfs_trans_context_clear(tp);
> >
> >       xfs_trans_free_items(tp, dirty);
> >       xfs_trans_free(tp);
> > @@ -1013,6 +1011,7 @@
> >       if (error)
> >               return error;
> >
> > +     xfs_trans_context_update(trans, *tpp);
>
> Two bugs here: First, xfs_trans_commit freed @trans, which means that
> the assertion commits a UAF error.  Second, if the transaction is
> synchronous and the xfs_log_force_lsn at the bottom of
> __xfs_trans_commit fails, we'll abort everything without clearing
> current->journal_info or restoring the memalloc flags.
>
> Personally I think you should just clear the context from xfs_trans_free
> if current->journal_info points to the transaction being freed.  I
> /think/ you could fix this with the attached patch; what do you think?
>

Thanks for catching this issue and the fix for it.
I will run xfstests with your fix.

> --D
>
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index b272d0767c87..09ae5c181299 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -67,6 +67,11 @@ xfs_trans_free(
>         xfs_extent_busy_sort(&tp->t_busy);
>         xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
>
> +       /* Detach the transaction from this thread. */
> +       ASSERT(current->journal_info != NULL);
> +       if (current->journal_info == tp)
> +               xfs_trans_context_clear(tp);
> +
>         trace_xfs_trans_free(tp, _RET_IP_);
>         if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
>                 sb_end_intwrite(tp->t_mountp->m_super);
> @@ -119,7 +124,11 @@ xfs_trans_dup(
>
>         ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
>         tp->t_rtx_res = tp->t_rtx_res_used;
> +
> +       /* Associate the new transaction with this thread. */
> +       ASSERT(current->journal_info == tp);
>         ntp->t_pflags = tp->t_pflags;
> +       current->journal_info = ntp;
>
>         /* move deferred ops over to the new tp */
>         xfs_defer_move(ntp, tp);
> @@ -874,8 +883,6 @@ __xfs_trans_commit(
>
>         xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
>
> -       if (!regrant)
> -               xfs_trans_context_clear(tp);
>         xfs_trans_free(tp);
>
>         /*
> @@ -908,7 +915,6 @@ __xfs_trans_commit(
>                 tp->t_ticket = NULL;
>         }
>
> -       xfs_trans_context_clear(tp);
>         xfs_trans_free_items(tp, !!error);
>         xfs_trans_free(tp);
>
> @@ -968,9 +974,6 @@ xfs_trans_cancel(
>                 tp->t_ticket = NULL;
>         }
>
> -       /* mark this thread as no longer being in a transaction */
> -       xfs_trans_context_clear(tp);
> -
>         xfs_trans_free_items(tp, dirty);
>         xfs_trans_free(tp);
>  }
> @@ -1011,7 +1014,6 @@ xfs_trans_roll(
>         if (error)
>                 return error;
>
> -       xfs_trans_context_update(trans, *tpp);
>         /*
>          * Reserve space in the log for the next transaction.
>          * This also pushes items in the "AIL", the list of logged items,
> diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> index c4877afcb8b9..ceb530bf5c4b 100644
> --- a/fs/xfs/xfs_trans.h
> +++ b/fs/xfs/xfs_trans.h
> @@ -276,13 +276,6 @@ xfs_trans_context_set(struct xfs_trans *tp)
>         tp->t_pflags = memalloc_nofs_save();
>  }
>
> -static inline void
> -xfs_trans_context_update(struct xfs_trans *old, struct xfs_trans *new)
> -{
> -       ASSERT(current->journal_info == old);
> -       current->journal_info = new;
> -}
> -
>  static inline void
>  xfs_trans_context_clear(struct xfs_trans *tp)
>  {



-- 
Thanks
Yafang
