Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606AC2A7F6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgKENFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 08:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgKENFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:05:00 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73451C0613CF;
        Thu,  5 Nov 2020 05:04:59 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y17so1304921ilg.4;
        Thu, 05 Nov 2020 05:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZXQ3BAddNN3gYrfwjUK8hjD6WjwUEDBLj1eNYEOzUo=;
        b=pO6y9W7YRw3qCKIWJKv7KZ5gPH5HAp3M0yP7f3VXh/iCV2RltcdOM+NZMmK+Lr6WAG
         bJAR8Py8WsSCI0QAyk+8oFNjw/b8qmB44FFdIACEWpcu2gvFaflNUqgOmr1dAYQ5WzUL
         JKhlX0+EzqmRcvtWgitpsmPUMsatZVa+9VJiF22i786f4JmuJM0zkGNME1HKOzSK/aRu
         BQnPNvMGhSGbSPtpMYXm1M1u2Cw9YF2pKiVAPxZxDbbf91KXXtLR13ClcVPE0zPWSByk
         f10H23ydhFYmul63BdYVywg3N1sGTA7+tsmqNguEutZ9RsJsBRw701fvMoeJOwJx0lC+
         wMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZXQ3BAddNN3gYrfwjUK8hjD6WjwUEDBLj1eNYEOzUo=;
        b=TJNCnIUYMo7I3IAYbaN3OeebjG0neukjAW+q61WmZ5LugmKNffWshztCcTT9mWSTHD
         kM7ylbnJdH3t2oM5t8mP//pIk2ST0G1Sc/z1y7J0pf4OqcB2wuEdE/Tidoz0dUXpyrSW
         epReaAQl5hekmC+cbI3KtDL3ctM7C9oFMqToeGgiMFul3rxCuNhdXo4kjT1rRt3DcBq8
         dFG/4CzPA1/XJEMfW+fsnyy+4Hp9j2ZsG2Nz+8e3L+I/dxEk5kX1ohmz+vv/RhnUSZaQ
         8x+EOWiyExWG4UpA/OJ/Epc/o3t3EKH08ImpLhuAwE/cuvWS1U4Mlge7nLpmDEl52tAv
         vvag==
X-Gm-Message-State: AOAM533pXas4P36JugDaodvU2cP17fDnBhh9PcBygN3zOmZTSDI/MjDo
        m/wZw14CLjJvh23km5VoD+ESRcHoV9wUtKcp9MQ=
X-Google-Smtp-Source: ABdhPJxDmC0wfjLJrqd5m/AlPqEkfeGyCmP9jd4qeKTe5TycmK1XIO774yC4d5EC1LAMCmHsJzoFb5yFBg6q19YBHMo=
X-Received: by 2002:a92:3003:: with SMTP id x3mr1690953ile.93.1604581498765;
 Thu, 05 Nov 2020 05:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20201103131754.94949-1-laoar.shao@gmail.com> <20201103131754.94949-2-laoar.shao@gmail.com>
 <20201103194819.GM7123@magnolia> <CALOAHbBbMdmq0UFy9gWikXufzSdZmSjdUa8Pbkwr31ZdvnodQQ@mail.gmail.com>
 <20201104162640.GD7115@magnolia>
In-Reply-To: <20201104162640.GD7115@magnolia>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 5 Nov 2020 21:04:22 +0800
Message-ID: <CALOAHbAy8WeNgrk3RDF41N2KbEj-2FUOOPbwBrBMDotjRimdRw@mail.gmail.com>
Subject: Re: [PATCH v8 resend 1/2] mm: Add become_kswapd and restore_kswapd
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

On Thu, Nov 5, 2020 at 12:26 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Nov 04, 2020 at 10:17:16PM +0800, Yafang Shao wrote:
> > On Wed, Nov 4, 2020 at 3:48 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Tue, Nov 03, 2020 at 09:17:53PM +0800, Yafang Shao wrote:
> > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > >
> > > > Since XFS needs to pretend to be kswapd in some of its worker threads,
> > > > create methods to save & restore kswapd state.  Don't bother restoring
> > > > kswapd state in kswapd -- the only time we reach this code is when we're
> > > > exiting and the task_struct is about to be destroyed anyway.
> > > >
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
> > > >  include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
> > > >  mm/vmscan.c               | 16 +---------------
> > > >  3 files changed, 32 insertions(+), 21 deletions(-)
> > > >
> > > > diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> > > > index 2d25bab..a04a442 100644
> > > > --- a/fs/xfs/libxfs/xfs_btree.c
> > > > +++ b/fs/xfs/libxfs/xfs_btree.c
> > > > @@ -2813,8 +2813,9 @@ struct xfs_btree_split_args {
> > > >  {
> > > >       struct xfs_btree_split_args     *args = container_of(work,
> > > >                                               struct xfs_btree_split_args, work);
> > > > +     bool                    is_kswapd = args->kswapd;
> > > >       unsigned long           pflags;
> > > > -     unsigned long           new_pflags = PF_MEMALLOC_NOFS;
> > > > +     int                     memalloc_nofs;
> > > >
> > > >       /*
> > > >        * we are in a transaction context here, but may also be doing work
> > > > @@ -2822,16 +2823,17 @@ struct xfs_btree_split_args {
> > > >        * temporarily to ensure that we don't block waiting for memory reclaim
> > > >        * in any way.
> > > >        */
> > > > -     if (args->kswapd)
> > > > -             new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> > > > -
> > > > -     current_set_flags_nested(&pflags, new_pflags);
> > > > +     if (is_kswapd)
> > > > +             pflags = become_kswapd();
> > > > +     memalloc_nofs = memalloc_nofs_save();
> > > >
> > > >       args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
> > > >                                        args->key, args->curp, args->stat);
> > > >       complete(args->done);
> > > >
> > > > -     current_restore_flags_nested(&pflags, new_pflags);
> > > > +     memalloc_nofs_restore(memalloc_nofs);
> > > > +     if (is_kswapd)
> > > > +             restore_kswapd(pflags);
> > >
> > > Note that there's a trivial merge conflict with the mrlock_t removal
> > > series.  I'll carry the fix in the tree, assuming that everything
> > > passes.
> > >
> >
> > This patchset is based on Andrew's tree currently.
> > Seems I should rebase this patchset on your tree instead of Andrew's tree ?
>
> That depends on whether or not you want me to push these two patches
> through the xfs tree or if they're going through Andrew (Morton?)'s
> quiltset.
>
> Frankly I'd rather take them via xfs since most of the diff is xfs...
>

Sure, I will rebase in on the xfs tree.

> > >
> > > >  }
> > > >
> > > >  /*
> > > > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > > > index d5ece7a..2faf03e 100644
> > > > --- a/include/linux/sched/mm.h
> > > > +++ b/include/linux/sched/mm.h
> > > > @@ -278,6 +278,29 @@ static inline void memalloc_nocma_restore(unsigned int flags)
> > > >  }
> > > >  #endif
> > > >
> > > > +/*
> > > > + * Tell the memory management code that this thread is working on behalf
> > > > + * of background memory reclaim (like kswapd).  That means that it will
> > > > + * get access to memory reserves should it need to allocate memory in
> > > > + * order to make forward progress.  With this great power comes great
> > > > + * responsibility to not exhaust those reserves.
> > > > + */
> > > > +#define KSWAPD_PF_FLAGS              (PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD)
> > > > +
> > > > +static inline unsigned long become_kswapd(void)
> > > > +{
> > > > +     unsigned long flags = current->flags & KSWAPD_PF_FLAGS;
> > > > +
> > > > +     current->flags |= KSWAPD_PF_FLAGS;
> > > > +
> > > > +     return flags;
> > > > +}
> > > > +
> > > > +static inline void restore_kswapd(unsigned long flags)
> > > > +{
> > > > +     current->flags &= ~(flags ^ KSWAPD_PF_FLAGS);
> > > > +}
> > > > +
> > > >  #ifdef CONFIG_MEMCG
> > > >  DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> > > >  /**
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index 1b8f0e0..77bc1dd 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -3869,19 +3869,7 @@ static int kswapd(void *p)
> > > >       if (!cpumask_empty(cpumask))
> > > >               set_cpus_allowed_ptr(tsk, cpumask);
> > > >
> > > > -     /*
> > > > -      * Tell the memory management that we're a "memory allocator",
> > > > -      * and that if we need more memory we should get access to it
> > > > -      * regardless (see "__alloc_pages()"). "kswapd" should
> > > > -      * never get caught in the normal page freeing logic.
> > > > -      *
> > > > -      * (Kswapd normally doesn't need memory anyway, but sometimes
> > > > -      * you need a small amount of memory in order to be able to
> > > > -      * page out something else, and this flag essentially protects
> > > > -      * us from recursively trying to free more memory as we're
> > > > -      * trying to free the first piece of memory in the first place).
> > > > -      */
> > > > -     tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> > > > +     become_kswapd();
> > > >       set_freezable();
> > > >
> > > >       WRITE_ONCE(pgdat->kswapd_order, 0);
> > > > @@ -3931,8 +3919,6 @@ static int kswapd(void *p)
> > > >                       goto kswapd_try_sleep;
> > > >       }
> > > >
> > > > -     tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
> > > > -
> > > >       return 0;
> > > >  }
> > > >
> > > > --
> > > > 1.8.3.1
> > > >
> >
> >
> >
> > --
> > Thanks
> > Yafang



-- 
Thanks
Yafang
