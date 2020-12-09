Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF52D3867
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 02:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgLIBs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 20:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIBs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:48:56 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B59C0613CF;
        Tue,  8 Dec 2020 17:48:15 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id i9so12486ioo.2;
        Tue, 08 Dec 2020 17:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIdrxZcmnEf8fT9FhjlZhkJALNm4RIibbyZ6dc4FDbg=;
        b=e1L1JVngHOvaDbCV0nHAHrMxjUhYlkQpMZqeQV34DtvC+NZtHvKSs/lkxhlRs+B9et
         DeX9gxvYl+Hya5ndlTv9ApD5pKlX+Tq6o8VKHy0fruvV5rc+n4qHS+j2eOIx1NVenU45
         mcHlkFUtLUkCUMsiB7yINOtQYw92GfymWq9EO5mSFPZ5TgOFDa18vLamHEB472ayPKNr
         60sIPaZGRpG4s0tzE7P2HohKg/okLi83Zhhd2Hvp0Pg6A496b2WpQATbfnwUt325M6Gb
         vCsYXc3oLnQ60G+mEVkbox+28E0yUdQzQZ0lhUoB2DXZoyNx19MzDES8cC3+kgiCXtXS
         DU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIdrxZcmnEf8fT9FhjlZhkJALNm4RIibbyZ6dc4FDbg=;
        b=IxuUuWdjJ2Zz8hCi2VOSwWKx1BHwVv6iGkSmGDEW/Bsa6tCNGgvrb3y+/WoXQYkKsH
         c9ot+Sfi/dNMv1lGcIUzodGd84M7B/GQIo4SmzSG4ia5cbL/EVsJLmJu0QZEk+UP3uyB
         c0BPfNPWi4/CIMSkxUCdW/75Pu+HkGQuTDaQxkcp6bI5p0dGNX12YWvBa8hOUtSnb4Hu
         YjnwI4ACAFofVURbi6z+JS2hIlVfHxC+1uNIiikmJPvHIVQ4daR6qKiyf2CCdxxMlUBE
         YgsuRUXF0yunKQbQ2CJ/y2+KLlQEBqrUGzbL9yjt6j1ns0SocMoUxV1zU6o1td23lUgr
         ZrWw==
X-Gm-Message-State: AOAM530OrTVOSdDppiEPRftyecIjaB7qLpE7lghghDw3PIl5wRDhRyml
        J54n4RR1JjwO/aqj0Ul0tLJPR1RO0KUTl3mJfhw=
X-Google-Smtp-Source: ABdhPJx4KGBCCqGmbInWVkmZVA0USU7cZFjsIYCbQIzJoPiEIGZnpg7Z5nrRQjx9tYLEkONtbdu6BgmwEgbCmTI3qYw=
X-Received: by 2002:a05:6602:2c8f:: with SMTP id i15mr180914iow.66.1607478495159;
 Tue, 08 Dec 2020 17:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20201208122824.16118-1-laoar.shao@gmail.com> <20201208122824.16118-4-laoar.shao@gmail.com>
 <20201208185946.GC1943235@magnolia>
In-Reply-To: <20201208185946.GC1943235@magnolia>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 9 Dec 2020 09:47:38 +0800
Message-ID: <CALOAHbB1uKmQ7ns08KW4zH1ikqD0GAY_Y7VySzmTY0=LTEPURA@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 2:59 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Dec 08, 2020 at 08:28:23PM +0800, Yafang Shao wrote:
> > The xfs_trans context should be active after it is allocated, and
> > deactive when it is freed.
> >
> > So these two helpers are refactored as,
> > - xfs_trans_context_set()
> >   Used in xfs_trans_alloc()
> > - xfs_trans_context_clear()
> >   Used in xfs_trans_free()
> >
> > This patch is based on Darrick's work to fix the issue in xfs/141 in the
> > earlier version. [1]
> >
> > 1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia
> >
> > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  fs/xfs/xfs_trans.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > index 11d390f0d3f2..fe20398a214e 100644
> > --- a/fs/xfs/xfs_trans.c
> > +++ b/fs/xfs/xfs_trans.c
> > @@ -67,6 +67,9 @@ xfs_trans_free(
> >       xfs_extent_busy_sort(&tp->t_busy);
> >       xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
> >
> > +     /* Detach the transaction from this thread. */
> > +     xfs_trans_context_clear(tp);
>
> Don't you need to check if tp is still the current transaction before
> you clear PF_MEMALLOC_NOFS, now that the NOFS is bound to the lifespan
> of the transaction itself instead of the reservation?
>

The current->journal_info is always the same with tp here in my verification.
I don't know in which case they are different. It would be better if
you could explain in detail.
Anyway I can add the check with your comment in the next version.


>
> > +
> >       trace_xfs_trans_free(tp, _RET_IP_);
> >       if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
> >               sb_end_intwrite(tp->t_mountp->m_super);
> > @@ -153,9 +156,6 @@ xfs_trans_reserve(
> >       int                     error = 0;
> >       bool                    rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
> >
> > -     /* Mark this thread as being in a transaction */
> > -     xfs_trans_context_set(tp);
> > -
> >       /*
> >        * Attempt to reserve the needed disk blocks by decrementing
> >        * the number needed from the number available.  This will
> > @@ -163,10 +163,9 @@ xfs_trans_reserve(
> >        */
> >       if (blocks > 0) {
> >               error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> > -             if (error != 0) {
> > -                     xfs_trans_context_clear(tp);
> > +             if (error != 0)
> >                       return -ENOSPC;
> > -             }
> > +
> >               tp->t_blk_res += blocks;
> >       }
> >
> > @@ -241,8 +240,6 @@ xfs_trans_reserve(
> >               tp->t_blk_res = 0;
> >       }
> >
> > -     xfs_trans_context_clear(tp);
> > -
> >       return error;
> >  }
> >
> > @@ -284,6 +281,8 @@ xfs_trans_alloc(
> >       INIT_LIST_HEAD(&tp->t_dfops);
> >       tp->t_firstblock = NULLFSBLOCK;
> >
> > +     /* Mark this thread as being in a transaction */
> > +     xfs_trans_context_set(tp);
> >       error = xfs_trans_reserve(tp, resp, blocks, rtextents);
> >       if (error) {
> >               xfs_trans_cancel(tp);
> > @@ -878,7 +877,6 @@ __xfs_trans_commit(
> >
> >       xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
> >
> > -     xfs_trans_context_clear(tp);
> >       xfs_trans_free(tp);
> >
> >       /*
> > @@ -911,7 +909,6 @@ __xfs_trans_commit(
> >               tp->t_ticket = NULL;
> >       }
> >
> > -     xfs_trans_context_clear(tp);
> >       xfs_trans_free_items(tp, !!error);
> >       xfs_trans_free(tp);
> >
> > @@ -971,9 +968,6 @@ xfs_trans_cancel(
> >               tp->t_ticket = NULL;
> >       }
> >
> > -     /* mark this thread as no longer being in a transaction */
> > -     xfs_trans_context_clear(tp);
> > -
> >       xfs_trans_free_items(tp, dirty);
> >       xfs_trans_free(tp);
> >  }
> > --
> > 2.18.4
> >



-- 
Thanks
Yafang
