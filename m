Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F582D403E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgLIKpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 05:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgLIKpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:45:06 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE94C0613CF;
        Wed,  9 Dec 2020 02:44:26 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z5so1137005iob.11;
        Wed, 09 Dec 2020 02:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htf7oQLbUIT12CkPdqZFjdgF/YoqVY5s3W8UZCtazfU=;
        b=BDH0ED5DZ98HJqDCraITjaG60bDgQ6/mLGoFquywWqKEZtc0/RtlAKAgXDFxxgKmWH
         2rbxoaPIMnSi2xtSm+EY4P4w8YojftKrWDsbyDV9XJdRDrVhOZJlFD9iGMbteHoWDMnX
         lhJ8jVRDYpnKQFB0KVhhwy+dzkiQXDm+sW/7OKQoq/fCD95lBZSEsfrlkR4N9FcL7K9B
         GRC7u4nSezTf4LTZyLuAYx3Uf7195hJNZCLUPSjFOO6Jp3j/sRCcDAW+Xnur6cC/h8hC
         qfKqvjmKOaA4YxSND+srbTreUbHETuLhGYNCog0hI1sFjOuaci2JdYx4j8Q2F7pT/6M1
         MvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htf7oQLbUIT12CkPdqZFjdgF/YoqVY5s3W8UZCtazfU=;
        b=iMB8QYBNZ3L51vBGlXWfgpQeJUYDdu7beB7WAUz4SA4/91Qbie7DYLXq899dWR0ZxY
         Eoq67kGAtIXvq2Bv/h2BpupoVPBiJI+qbVe0V412uuVf/5zA0bbGOShSwF6xr7lf84u5
         JXYKo2OJQ+qEhnT37U0F9Es1Z3D6e+6KTnvtM2E2CU1by0Z3SI6pqVWKx19e2ZeSqPNT
         eLSyIUcloX6OItiE6E47QVqySdrrFI5yt7dgA2bBgyxHJp3ASyXjgzEyjXMOO+vygUhO
         Sap4Uaoe35yUApsPFohhwT/7ybAqFGNj1R6YZKO2UAA5OtOQ3KWX5KRfZBzAQFVBIRUc
         DR0A==
X-Gm-Message-State: AOAM532DxnBnrJ3gTJuW1Vr9Cwi+TaXaDCCayZkNHFVTwyR3JkVWSv6U
        d2ypRfAN/aQ6IJJXvOzOlxhUG2jseN88hjRz8u0=
X-Google-Smtp-Source: ABdhPJwoZCydcQ/F/M7hMYjYvOS8z4MbQe8D7XdvViM/KC8+z4gAYHKEAqye/nrRvgEL+J/XKDTJuBkLppZidNDdXdY=
X-Received: by 2002:a5e:9612:: with SMTP id a18mr1987644ioq.13.1607510665449;
 Wed, 09 Dec 2020 02:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20201208122824.16118-1-laoar.shao@gmail.com> <20201208122824.16118-4-laoar.shao@gmail.com>
 <20201208185946.GC1943235@magnolia> <CALOAHbB1uKmQ7ns08KW4zH1ikqD0GAY_Y7VySzmTY0=LTEPURA@mail.gmail.com>
 <20201209035320.GI1943235@magnolia>
In-Reply-To: <20201209035320.GI1943235@magnolia>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 9 Dec 2020 18:43:49 +0800
Message-ID: <CALOAHbAqF8AjjFi3oboDq=oEsKOqRiNn7U=UbguE2jDXwG6fCQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
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

On Wed, Dec 9, 2020 at 11:53 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Dec 09, 2020 at 09:47:38AM +0800, Yafang Shao wrote:
> > On Wed, Dec 9, 2020 at 2:59 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Tue, Dec 08, 2020 at 08:28:23PM +0800, Yafang Shao wrote:
> > > > The xfs_trans context should be active after it is allocated, and
> > > > deactive when it is freed.
> > > >
> > > > So these two helpers are refactored as,
> > > > - xfs_trans_context_set()
> > > >   Used in xfs_trans_alloc()
> > > > - xfs_trans_context_clear()
> > > >   Used in xfs_trans_free()
> > > >
> > > > This patch is based on Darrick's work to fix the issue in xfs/141 in the
> > > > earlier version. [1]
> > > >
> > > > 1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia
> > > >
> > > > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  fs/xfs/xfs_trans.c | 20 +++++++-------------
> > > >  1 file changed, 7 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > > > index 11d390f0d3f2..fe20398a214e 100644
> > > > --- a/fs/xfs/xfs_trans.c
> > > > +++ b/fs/xfs/xfs_trans.c
> > > > @@ -67,6 +67,9 @@ xfs_trans_free(
> > > >       xfs_extent_busy_sort(&tp->t_busy);
> > > >       xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
> > > >
> > > > +     /* Detach the transaction from this thread. */
> > > > +     xfs_trans_context_clear(tp);
> > >
> > > Don't you need to check if tp is still the current transaction before
> > > you clear PF_MEMALLOC_NOFS, now that the NOFS is bound to the lifespan
> > > of the transaction itself instead of the reservation?
> > >
> >
> > The current->journal_info is always the same with tp here in my verification.
> > I don't know in which case they are different.
>
> I don't know why you changed it from the previous version.
>

I should explain it in the change log. Sorry about that.

> > It would be better if you could explain in detail.  Anyway I can add
> > the check with your comment in the next version.
>
> xfs_trans_alloc is called to allocate a transaction.  We set _NOFS and
> save the old flags (which don't contain _NOFS) to this transaction.
>
> thread logs some changes and calls xfs_trans_roll.
>
> xfs_trans_roll calls xfs_trans_dup to duplicate the old transaction.
>
> xfs_trans_dup allocates a new transaction, which sets PF_MEMALLOC_NOFS
> and saves the current context flags (in which _NOFS is set) in the new
> transaction.
>
> xfs_trans_roll then commits the old transaction
>
> xfs_trans_commit frees the old transaction
>
> xfs_trans_free restores the old context (which didn't have _NOFS) and
> now we've dropped NOFS incorrectly
>
> now we move on with the new transaction, but in the wrong NOFS mode.
>
> note that this becomes a lot more obvious once you start fiddling with
> current->journal_info in the last patch.
>

Many thanks for the detailed explanation. I missed the rolling transaction.
I will add this check in the next version.

> --D
>
> >
> > >
> > > > +
> > > >       trace_xfs_trans_free(tp, _RET_IP_);
> > > >       if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
> > > >               sb_end_intwrite(tp->t_mountp->m_super);
> > > > @@ -153,9 +156,6 @@ xfs_trans_reserve(
> > > >       int                     error = 0;
> > > >       bool                    rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
> > > >
> > > > -     /* Mark this thread as being in a transaction */
> > > > -     xfs_trans_context_set(tp);
> > > > -
> > > >       /*
> > > >        * Attempt to reserve the needed disk blocks by decrementing
> > > >        * the number needed from the number available.  This will
> > > > @@ -163,10 +163,9 @@ xfs_trans_reserve(
> > > >        */
> > > >       if (blocks > 0) {
> > > >               error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> > > > -             if (error != 0) {
> > > > -                     xfs_trans_context_clear(tp);
> > > > +             if (error != 0)
> > > >                       return -ENOSPC;
> > > > -             }
> > > > +
> > > >               tp->t_blk_res += blocks;
> > > >       }
> > > >
> > > > @@ -241,8 +240,6 @@ xfs_trans_reserve(
> > > >               tp->t_blk_res = 0;
> > > >       }
> > > >
> > > > -     xfs_trans_context_clear(tp);
> > > > -
> > > >       return error;
> > > >  }
> > > >
> > > > @@ -284,6 +281,8 @@ xfs_trans_alloc(
> > > >       INIT_LIST_HEAD(&tp->t_dfops);
> > > >       tp->t_firstblock = NULLFSBLOCK;
> > > >
> > > > +     /* Mark this thread as being in a transaction */
> > > > +     xfs_trans_context_set(tp);
> > > >       error = xfs_trans_reserve(tp, resp, blocks, rtextents);
> > > >       if (error) {
> > > >               xfs_trans_cancel(tp);
> > > > @@ -878,7 +877,6 @@ __xfs_trans_commit(
> > > >
> > > >       xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
> > > >
> > > > -     xfs_trans_context_clear(tp);
> > > >       xfs_trans_free(tp);
> > > >
> > > >       /*
> > > > @@ -911,7 +909,6 @@ __xfs_trans_commit(
> > > >               tp->t_ticket = NULL;
> > > >       }
> > > >
> > > > -     xfs_trans_context_clear(tp);
> > > >       xfs_trans_free_items(tp, !!error);
> > > >       xfs_trans_free(tp);
> > > >
> > > > @@ -971,9 +968,6 @@ xfs_trans_cancel(
> > > >               tp->t_ticket = NULL;
> > > >       }
> > > >
> > > > -     /* mark this thread as no longer being in a transaction */
> > > > -     xfs_trans_context_clear(tp);
> > > > -
> > > >       xfs_trans_free_items(tp, dirty);
> > > >       xfs_trans_free(tp);
> > > >  }
> > > > --
> > > > 2.18.4
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
