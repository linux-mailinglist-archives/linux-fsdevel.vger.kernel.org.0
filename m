Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D92DCBC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 05:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgLQEsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 23:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgLQEsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 23:48:05 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A81C061794;
        Wed, 16 Dec 2020 20:47:24 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id o6so13151027iob.10;
        Wed, 16 Dec 2020 20:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRUMLTk7szvcs7E9rP3JJrNFOeJ7mkueV5pL+SzEkSM=;
        b=QRlJcth1nNqZpZH57ZV7mSS0URPgxM4TleMaXtrVW/Wg6sSJuMdzAQ2MVJbIfHK9QL
         TOjdktPjwgqXEoHWHBuG0Kpl5+maKdYmNU23/jI1DNrB7ADfnRzpSVzf5oooxKCXqVWq
         LJp3q2T9S3J8Fi9w+CzM9u8yRXMkm79eE0iOva5jDp3J6nJS24PCJ1Hh6p+wh7NyRmIR
         uBJxBaLZ2Q7CnqnG56ombBFJ5qYfZsS8mYqJ4D3qCOlBEOM8qGFfxhi9WaUKcr3kl9Y8
         7WcXPNc0OTcuLR0XZm0DqojDVwC9wEupU2c+tXHL3XNjFgEMwxClj5IeqMz46oiH8mpr
         d27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRUMLTk7szvcs7E9rP3JJrNFOeJ7mkueV5pL+SzEkSM=;
        b=FNZ3ymNP96cqtyCGzt+mS9VPaHUBEZxKtLZRT0U7ciHB8zlEjk73wRVNPPZIFjvEjV
         gKRyGOQcTZUQarKrmm9Ut2XZW9Vkb2rGW70qTd88D2qquRNTNhLwOBSEzhCFbrO2Bp/D
         qUEIoWWnEpqV1LycgpEUrKxvFPPcGNdOZIBcuxLeElc2Zx82K3WsI3Kl2c6sGJKULMQX
         cqNwUZFaVfB1sEXE/jYMh+WEdwB2C3UGKQEFKY0LYpbM5fiz3AMakJsnoyRoYDc1orMt
         zm40liNcEamVkzlvFDkZbQjfdM1HqcpMEWFNIKEO/seZBAriieNXokntyjGhOL5QCnsd
         8udQ==
X-Gm-Message-State: AOAM5306sKNKiJaK0guldyi92Phwgq6Hr/Pjf3x5gi1dv4gcSysF6gl5
        SwUpN+vUXyCHK4hUW7IRpYgMPWKd+JZRhX7NFtbFlKKO6KKZ3DRN
X-Google-Smtp-Source: ABdhPJxBoUYfBARhqKQXlH0TMk7AC8ra43Si0SEHE3kCbFav1S1El7VPg2rN//ZysJPcc8ybj8p4DXerd58/pSgl2f0=
X-Received: by 2002:a05:6602:2157:: with SMTP id y23mr45264126ioy.202.1608180443614;
 Wed, 16 Dec 2020 20:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20201217011157.92549-1-laoar.shao@gmail.com> <20201217011157.92549-2-laoar.shao@gmail.com>
 <20201217030609.GP632069@dread.disaster.area>
In-Reply-To: <20201217030609.GP632069@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 17 Dec 2020 12:46:47 +0800
Message-ID: <CALOAHbBNbJ9z6YR20wff1Ei=SR6E-uNFRO8OHpRqg_emsD7few@mail.gmail.com>
Subject: Re: [PATCH v13 1/4] mm: Add become_kswapd and restore_kswapd
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:06 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Dec 17, 2020 at 09:11:54AM +0800, Yafang Shao wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >
> > Since XFS needs to pretend to be kswapd in some of its worker threads,
> > create methods to save & restore kswapd state.  Don't bother restoring
> > kswapd state in kswapd -- the only time we reach this code is when we're
> > exiting and the task_struct is about to be destroyed anyway.
> >
> > Cc: Dave Chinner <david@fromorbit.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
> >  include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
> >  mm/vmscan.c               | 16 +---------------
> >  3 files changed, 32 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> > index 51dbff9b0908..0f35b7a38e76 100644
> > --- a/fs/xfs/libxfs/xfs_btree.c
> > +++ b/fs/xfs/libxfs/xfs_btree.c
> > @@ -2813,8 +2813,9 @@ xfs_btree_split_worker(
> >  {
> >       struct xfs_btree_split_args     *args = container_of(work,
> >                                               struct xfs_btree_split_args, work);
> > +     bool                    is_kswapd = args->kswapd;
> >       unsigned long           pflags;
> > -     unsigned long           new_pflags = PF_MEMALLOC_NOFS;
> > +     int                     memalloc_nofs;
> >
> >       /*
> >        * we are in a transaction context here, but may also be doing work
> > @@ -2822,16 +2823,17 @@ xfs_btree_split_worker(
> >        * temporarily to ensure that we don't block waiting for memory reclaim
> >        * in any way.
> >        */
> > -     if (args->kswapd)
> > -             new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> > -
> > -     current_set_flags_nested(&pflags, new_pflags);
> > +     if (is_kswapd)
> > +             pflags = become_kswapd();
> > +     memalloc_nofs = memalloc_nofs_save();
> >
> >       args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
> >                                        args->key, args->curp, args->stat);
> >       complete(args->done);
> >
> > -     current_restore_flags_nested(&pflags, new_pflags);
> > +     memalloc_nofs_restore(memalloc_nofs);
> > +     if (is_kswapd)
> > +             restore_kswapd(pflags);
> >  }
> >
> >  /*
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index d5ece7a9a403..2faf03e79a1e 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -278,6 +278,29 @@ static inline void memalloc_nocma_restore(unsigned int flags)
> >  }
> >  #endif
> >
> > +/*
> > + * Tell the memory management code that this thread is working on behalf
> > + * of background memory reclaim (like kswapd).  That means that it will
> > + * get access to memory reserves should it need to allocate memory in
> > + * order to make forward progress.  With this great power comes great
> > + * responsibility to not exhaust those reserves.
> > + */
> > +#define KSWAPD_PF_FLAGS              (PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD)
> > +
> > +static inline unsigned long become_kswapd(void)
> > +{
> > +     unsigned long flags = current->flags & KSWAPD_PF_FLAGS;
> > +
> > +     current->flags |= KSWAPD_PF_FLAGS;
> > +
> > +     return flags;
> > +}
>
> You can get rid of the empty lines out of this function.
>
> > +static inline void restore_kswapd(unsigned long flags)
> > +{
> > +     current->flags &= ~(flags ^ KSWAPD_PF_FLAGS);
> > +}
>
> Urk, that requires thinking about to determine whether it is
> correct. And it is 3 runtime logic operations (^, ~ and &) too. The
> way all the memalloc_*_restore() functions restore the previous
> flags is obviously correct and only requires 2 runtime logic
> operations because the compiler calculates the ~ operation on the
> constant. So why do it differently here? i.e.:
>
>         current->flags = (current->flags & ~KSWAPD_PF_FLAGS) | flags;
>

I will change it as you suggested if Matthew doesn't have a different
opinion, Matthew ?


> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3870,19 +3870,7 @@ static int kswapd(void *p)
> >       if (!cpumask_empty(cpumask))
> >               set_cpus_allowed_ptr(tsk, cpumask);
> >
> > -     /*
> > -      * Tell the memory management that we're a "memory allocator",
> > -      * and that if we need more memory we should get access to it
> > -      * regardless (see "__alloc_pages()"). "kswapd" should
> > -      * never get caught in the normal page freeing logic.
> > -      *
> > -      * (Kswapd normally doesn't need memory anyway, but sometimes
> > -      * you need a small amount of memory in order to be able to
> > -      * page out something else, and this flag essentially protects
> > -      * us from recursively trying to free more memory as we're
> > -      * trying to free the first piece of memory in the first place).
> > -      */
> > -     tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> > +     become_kswapd();
> >       set_freezable();
> >
> >       WRITE_ONCE(pgdat->kswapd_order, 0);
> > @@ -3932,8 +3920,6 @@ static int kswapd(void *p)
> >                       goto kswapd_try_sleep;
> >       }
> >
> > -     tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
> > -
>
> Missing a restore_kswapd()?
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com



-- 
Thanks
Yafang
