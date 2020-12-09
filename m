Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3F2D385D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 02:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgLIBmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 20:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIBmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:42:03 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB82C0613D6;
        Tue,  8 Dec 2020 17:41:16 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id b8so60439ila.13;
        Tue, 08 Dec 2020 17:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAGWTxNYiR5ootYJRUnUUI04QhdswVTJD/R6XwstuWM=;
        b=HB/rAKzJr5CG+rq2DeWaPCAmqtQN1wgBJx6FeZmzTHWzYSyhwWT6zlgTr7NxOc+CBn
         1d52HA3170acxH6axHMsipNoDhhHBrZYXL7gLCMl0yWpgijY4omt0IcDaDj/NEG5gF5H
         q1EafboB2/cpJuRinDHJ0lgR/M0goLFmG2o7Wmijj9zhGHPIkeiTMu9Qlv2NQdaZaDt5
         CM40N0DOVcuN5ugpTuESqvMDuEdkvVZPy4y2p1TV1W4eJtF+w3aaWXT3T4P4QUqoWziZ
         XByaOhvEsPitAECL4YMtMYHGeRxxqQHouGqgJ8+i7JKxE8QVee+q/A9cLG348f65gvQ0
         1rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAGWTxNYiR5ootYJRUnUUI04QhdswVTJD/R6XwstuWM=;
        b=Rkhg+rUOKaWjwwzjI40hN0BBT59UAFck+hudNGj3AuI9ZMTs6za0ORFd5inBazLOUf
         p301qa4tSrpeQQvGHcU1L08KLv6AkqNIizlTk1zEXXYrNtgboA5x9KuuW4vH3JTd/Y5T
         o3eAp9DKN6i6/jbGX6ECx8iu5qANytLxS/5TAC6vICHTJS5qkvAg1k1ctiC3cV8rl1Dy
         K+l2+nwKKA/RHqLgruAagk6NyxQx9XT4SPyO2DTQxZ3V0O7tGpYyB9VLOr4Li+s/oHkh
         lYgu7hjbkR9RqdgRLk5LnoCuXb32MNk+dXX3h1MPWEGNmgsWIZnqIgZrsFlqy2PmPlD2
         TSRw==
X-Gm-Message-State: AOAM532oRvYvov2jhecMXP8qdkRAegKcK6QWlr3AjmDGItMMQegTwYpI
        xE+ZuDtJCX+K0muooKuJklAR0HHCN2RSlGapra4=
X-Google-Smtp-Source: ABdhPJwYEbLB3evwd4abSi2gz55NeZ/XnLzHrSL8vccVrF859VvYv+M/ufOp7NWH+xP5cHBIkbG+AhvacQbYO4UR5S4=
X-Received: by 2002:a05:6e02:c32:: with SMTP id q18mr58174ilg.203.1607478076247;
 Tue, 08 Dec 2020 17:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20201208122824.16118-1-laoar.shao@gmail.com> <20201208122824.16118-5-laoar.shao@gmail.com>
 <20201208185959.GD1943235@magnolia>
In-Reply-To: <20201208185959.GD1943235@magnolia>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 9 Dec 2020 09:40:40 +0800
Message-ID: <CALOAHbCgfAJOn60_2Gw++uHPqutU0UO8pXi6Bg0_huRqepxpaA@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] xfs: use current->journal_info to avoid
 transaction reservation recursion
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 3:00 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Dec 08, 2020 at 08:28:24PM +0800, Yafang Shao wrote:
> > PF_FSTRANS which is used to avoid transaction reservation recursion, is
> > dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> > PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> > memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> > means to avoid filesystem reclaim recursion.
> >
> > As these two flags have different meanings, we'd better reintroduce
> > PF_FSTRANS back. To avoid wasting the space of PF_* flags in task_struct,
> > we can reuse the current->journal_info to do that, per Willy. As the
> > check of transaction reservation recursion is used by XFS only, we can
> > move the check into xfs_vm_writepage(s), per Dave.
> >
> > To better abstract that behavoir, two new helpers are introduced, as
> > follows,
> > - xfs_trans_context_active
> >   To check whehter current is in fs transcation or not
> > - xfs_trans_context_swap
> >   Transfer the transaction context when rolling a permanent transaction
> >
> > These two new helpers are instroduced in xfs_trans.h.
> >
> > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jeff Layton <jlayton@redhat.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c |  7 -------
> >  fs/xfs/xfs_aops.c      | 17 +++++++++++++++++
> >  fs/xfs/xfs_trans.c     |  3 +++
> >  fs/xfs/xfs_trans.h     | 22 ++++++++++++++++++++++
> >  4 files changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 10cc7979ce38..3c53fa6ce64d 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1458,13 +1458,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
> >                       PF_MEMALLOC))
> >               goto redirty;
> >
> > -     /*
> > -      * Given that we do not allow direct reclaim to call us, we should
> > -      * never be called in a recursive filesystem reclaim context.
> > -      */
> > -     if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > -             goto redirty;
> > -
> >       /*
> >        * Is this page beyond the end of the file?
> >        *
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index 2371187b7615..0da0242d42c3 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -568,6 +568,16 @@ xfs_vm_writepage(
> >  {
> >       struct xfs_writepage_ctx wpc = { };
> >
> > +     /*
> > +      * Given that we do not allow direct reclaim to call us, we should
> > +      * never be called while in a filesystem transaction.
> > +      */
> > +     if (WARN_ON_ONCE(xfs_trans_context_active())) {
> > +             redirty_page_for_writepage(wbc, page);
> > +             unlock_page(page);
> > +             return 0;
> > +     }
> > +
> >       return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
> >  }
> >
> > @@ -579,6 +589,13 @@ xfs_vm_writepages(
> >       struct xfs_writepage_ctx wpc = { };
> >
> >       xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > +     /*
> > +      * Given that we do not allow direct reclaim to call us, we should
> > +      * never be called while in a filesystem transaction.
> > +      */
> > +     if (WARN_ON_ONCE(xfs_trans_context_active()))
> > +             return 0;
> > +
> >       return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> >  }
> >
> > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > index fe20398a214e..08d4916ffb13 100644
> > --- a/fs/xfs/xfs_trans.c
> > +++ b/fs/xfs/xfs_trans.c
> > @@ -124,6 +124,9 @@ xfs_trans_dup(
> >       tp->t_rtx_res = tp->t_rtx_res_used;
> >       ntp->t_pflags = tp->t_pflags;
>
> This one line (ntp->t_pflags = tp->t_pflags) should move to
> xfs_trans_context_swap.
>

Make sense to me.
Will update it.


> --D
>
> >
> > +     /* Associate the new transaction with this thread. */
> > +     xfs_trans_context_swap(tp, ntp);
> > +
> >       /* move deferred ops over to the new tp */
> >       xfs_defer_move(ntp, tp);
> >
> > diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> > index 44b11c64a15e..d596a375e3bf 100644
> > --- a/fs/xfs/xfs_trans.h
> > +++ b/fs/xfs/xfs_trans.h
> > @@ -268,16 +268,38 @@ xfs_trans_item_relog(
> >       return lip->li_ops->iop_relog(lip, tp);
> >  }
> >
> > +static inline bool
> > +xfs_trans_context_active(void)
> > +{
> > +     /* Use journal_info to indicate current is in a transaction */
> > +     return current->journal_info != NULL;
> > +}
> > +
> >  static inline void
> >  xfs_trans_context_set(struct xfs_trans *tp)
> >  {
> > +     ASSERT(!current->journal_info);
> > +     current->journal_info = tp;
> >       tp->t_pflags = memalloc_nofs_save();
> >  }
> >
> >  static inline void
> >  xfs_trans_context_clear(struct xfs_trans *tp)
> >  {
> > +     ASSERT(current->journal_info == tp);
> > +     current->journal_info = NULL;
> >       memalloc_nofs_restore(tp->t_pflags);
> >  }
> >
> > +/*
> > + * Transfer the transaction context when rolling a permanent
> > + * transaction.
> > + */
> > +static inline void
> > +xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> > +{
> > +     ASSERT(current->journal_info == tp);
> > +     current->journal_info = ntp;
> > +}
> > +
> >  #endif       /* __XFS_TRANS_H__ */
> > --
> > 2.18.4
> >



--
Thanks
Yafang
