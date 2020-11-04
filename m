Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC12A6C36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 18:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgKDRvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 12:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDRvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:51:00 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61BC0613D3;
        Wed,  4 Nov 2020 09:51:00 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id u127so23022224oib.6;
        Wed, 04 Nov 2020 09:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmmRKfUI57+ASIBQcePaOUav20StSxB9VBqKRyvBS+I=;
        b=IXl11llEDPCGFmMnByQchu6QJ/G9RuygDTJ6zdfz3YLJoJgTpZyNPA7NScfBUeZZL0
         ioCcO3qLRkFrHG7VBPjFMMrUk6cicIe/3mvk8GLiEVmDc+JIT2Aud55PXRClDb4dZLmU
         uWYo0GqDTPZzm552NXOE4BgMZSkxJbYw9x6MQP3NmNhCQHbmdzqO3psEDAbfH2sV92z3
         eTDX9+CcRVp4iSTo/bjB/oTshfVx0IZVWqKQOijXiPNyrsHzqXnu0EvgxRMtx0cQdXX7
         eolrYdzb6Tu/THwdaLi48bHHoTS+daz0MmnIjKvVZpJphjH4lM7A00dfo45sHa6zXokM
         OfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmmRKfUI57+ASIBQcePaOUav20StSxB9VBqKRyvBS+I=;
        b=hwTi9B8Q5UEMFAYU7VQ+oZcC6wgz/NJbSMoochXmuVPgXQwiC0mdpotWX6MC1jEK6P
         IPZqgH9SmeuI2hN/B2OjroEAKPv3GIn65L1qI6MgYpG2pW7UjxJSt2PBW4jZH465Dkpl
         VxZH2gyyRKvIN59GJrwzkcoIgvWXiCzErDKH6c3LV+kNuZ8Kl0qu6xnDWDWs4Edxu6gu
         dZO3qIxIvFmqCmmeISLxJBsgfgU76MQDtwqjvwF5VWcUqM8dI2l7ittWt1ZvLat28uxh
         D3rZWANSWRI2YEVZLbu//c6IZyYM8AbtDNDCq2aV610Y/n84AYYYgos6P068/6RGkE+k
         0G2A==
X-Gm-Message-State: AOAM531D6kicIanZaNhjckTZa9I35cULsIHeGaOPz05oHLN4clk7r4ha
        KgIhnjTfjNeodUZlc3DY30LBGj9FviGbPAYm4L0=
X-Google-Smtp-Source: ABdhPJyp/bySwbgpnfVqpcVm6qeBLsAtShC3BCzZbdsFWLYVFWvZo/RdZBU9xKZonDTjq644fJI7pAow4vVcNkGdmUQ=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr3079382oid.114.1604512259492;
 Wed, 04 Nov 2020 09:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20201103131754.94949-1-laoar.shao@gmail.com> <20201103131754.94949-2-laoar.shao@gmail.com>
 <20201103194819.GM7123@magnolia> <CALOAHbBbMdmq0UFy9gWikXufzSdZmSjdUa8Pbkwr31ZdvnodQQ@mail.gmail.com>
 <20201104162640.GD7115@magnolia>
In-Reply-To: <20201104162640.GD7115@magnolia>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 09:50:47 -0800
Message-ID: <CAE1WUT6Po1HhK9cgUs6=rrR6O+7Q-NKtnWp4GTnK_eYMXpj_9A@mail.gmail.com>
Subject: Re: [PATCH v8 resend 1/2] mm: Add become_kswapd and restore_kswapd
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Nov 4, 2020 at 8:30 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
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

I think they could go through either, but the XFS tree might be ever-so-slightly
better.

>
> Frankly I'd rather take them via xfs since most of the diff is xfs...

Yeah, it's an XFS patch so let's throw it through the XFS tree.

>
> --D
>
> > > --D
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

Best regards,
Amy Parker
(they/them)
