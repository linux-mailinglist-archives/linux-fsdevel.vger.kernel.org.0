Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA42A663B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgKDORx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 09:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKDORx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:17:53 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458F1C0613D3;
        Wed,  4 Nov 2020 06:17:53 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id g15so4730407ilc.9;
        Wed, 04 Nov 2020 06:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xebe9mZ8DB5irhboCX8vCKD1a9LqZ8XcyxjHuCXnZxw=;
        b=hcLhPdVRSs44m978omUttG/O0Ao4AXMdsw7AxyjOhEMMufKcz8qdX+HtsVjCSiTrlB
         zZHnIZ5anDIlHNS1oLJaLa22xjbYhh1Cp4MLw7qguONX9ZeyGIFWeJGI/XiqzQInQuFQ
         2CqfkYLZKDbs9R1eJLCp4uw0ur+TpAl+VKQWsD8p0qmWsR59AdhG900FHnHBoCGI9mej
         taGs9US0AfQn+cHsri+cfgFuY2ODwzJkqge8jEWm0Iu/NGvs4iqihRXOlsbacukzV4JC
         4Qh26zfA8mECEzpLkCnXMy+Cx1vRerEdG914kZVYZbBe7QfZl/Er002DIkJbEIjXLSOl
         BEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xebe9mZ8DB5irhboCX8vCKD1a9LqZ8XcyxjHuCXnZxw=;
        b=b0Lfzo8C65+jzkMxz5uptYkc9WGFscVUD7/IA1x980yMW81ggXnYqYDZSp+QZrnRpa
         5ixhys4xmeODA6iJHqLbBQyssepozaJkFd8q49zzGmF3HlLSs3c7h5vvCAzJJoU0+IOY
         s5KvqriKiRD+YFF7WYTkKVCJQTT3BqiQnaQIRhVzZr29G4TVwK5lLtv0FHLcYubPdRIo
         Xx4J0PKAKc/mCscFtH7d5FUYzEGiCuZPA60SbWOZZeU3qr6M68MR6VYczV4m/00rpdMc
         PXM9NBcfXRDYKpPfS2jdHc76WnA14aJ4KmDiK2+RbhpjMFaFVX3T80xEp7t9Mbkl4og5
         8aFg==
X-Gm-Message-State: AOAM533ljBVyy7nlsPJ++eEboEdy8b05FVgIAUUqIxSaVykaSWcMEFG3
        YEql5vtFm1LhmCY7PURjdE9FQHJXH/Ybpb+Rrpc=
X-Google-Smtp-Source: ABdhPJwU1Nu1VvYjapXwx/rqdQ4611QoTnLt4nyVafc9SCay46WwUSgmwQZgj0FZBBBMaQHORBlnThoHzpR+7bq1vqM=
X-Received: by 2002:a92:1307:: with SMTP id 7mr18654189ilt.142.1604499472652;
 Wed, 04 Nov 2020 06:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20201103131754.94949-1-laoar.shao@gmail.com> <20201103131754.94949-2-laoar.shao@gmail.com>
 <20201103194819.GM7123@magnolia>
In-Reply-To: <20201103194819.GM7123@magnolia>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 4 Nov 2020 22:17:16 +0800
Message-ID: <CALOAHbBbMdmq0UFy9gWikXufzSdZmSjdUa8Pbkwr31ZdvnodQQ@mail.gmail.com>
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

On Wed, Nov 4, 2020 at 3:48 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Nov 03, 2020 at 09:17:53PM +0800, Yafang Shao wrote:
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
> > index 2d25bab..a04a442 100644
> > --- a/fs/xfs/libxfs/xfs_btree.c
> > +++ b/fs/xfs/libxfs/xfs_btree.c
> > @@ -2813,8 +2813,9 @@ struct xfs_btree_split_args {
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
> > @@ -2822,16 +2823,17 @@ struct xfs_btree_split_args {
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
>
> Note that there's a trivial merge conflict with the mrlock_t removal
> series.  I'll carry the fix in the tree, assuming that everything
> passes.
>

This patchset is based on Andrew's tree currently.
Seems I should rebase this patchset on your tree instead of Andrew's tree ?

> --D
>
> >  }
> >
> >  /*
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index d5ece7a..2faf03e 100644
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
> > +
> > +static inline void restore_kswapd(unsigned long flags)
> > +{
> > +     current->flags &= ~(flags ^ KSWAPD_PF_FLAGS);
> > +}
> > +
> >  #ifdef CONFIG_MEMCG
> >  DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> >  /**
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 1b8f0e0..77bc1dd 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3869,19 +3869,7 @@ static int kswapd(void *p)
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
> > @@ -3931,8 +3919,6 @@ static int kswapd(void *p)
> >                       goto kswapd_try_sleep;
> >       }
> >
> > -     tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
> > -
> >       return 0;
> >  }
> >
> > --
> > 1.8.3.1
> >



-- 
Thanks
Yafang
