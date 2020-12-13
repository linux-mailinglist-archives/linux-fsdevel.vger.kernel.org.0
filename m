Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF162D8C7B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 10:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405228AbgLMJKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 04:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgLMJKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 04:10:19 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69FC0613CF;
        Sun, 13 Dec 2020 01:09:39 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so13000647ilt.6;
        Sun, 13 Dec 2020 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7GTvYEsVIVwjvV23D7RG5wUssdQLZojxIkxkNlOkWI=;
        b=SPCtjOSGrOXBOb7FXLg34p2igyWU588Jy1ITL3uDxg3KV9j9hqegwxfkW0PMA6cx/V
         EOIY59QB7x7/mp9zDB3fIYNm11dir6pHU/4ExH2vXTUGRd00cXGfTzPxzChX4Qv4yd5v
         xiIf3SCDIEbRRDnyfjhmXzSHdwK73M3q/6Aq28OeqAkDqKi3lGjNUviM7naD4H8dfA5m
         sO9n7Wj6Uwr9uIgS7bzSu2sstoR4o/whHfcY+rwcirUgxtAcdL9JArIIGwmtes1AGVKF
         yJ3o0HMnr4p9QSg2B/iMtWAAE0sHf4p7GDyv+C3lTz4hy+xxfeoj4sNT16ILLJa9PGKh
         YmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7GTvYEsVIVwjvV23D7RG5wUssdQLZojxIkxkNlOkWI=;
        b=ttKx0gJkRMjtWyrqbdkXxwgxS6g+xGrP2Kda/n7hK4bBdagem86WKnwmHgO3Wqfsom
         /1oLAjmr3QZAHaFP3Xz/Q3nxzYhSK+9yZa+CVmGaOQZJCSO7c2z6kin57srLTK0j9TN2
         wT6NG8I2l2oB0yZ++rG368z/U5WytmAGmXTGgYN+u5oZM5oQ7iw7l+N13CeIrZsXR6z5
         tQ0Z3NU58aUP5DfZ0+5oplBeNmLwzobVNFp0uvuUpvkSNRdA9flo5La3Sr0lXTq2HCPu
         wolUFHECzXUDnUXJqfi7OwLoAWOJ5D+SUR9i/WDqI+ObVGU1UUwrw0pAzCfI7V8yp0lX
         ACGw==
X-Gm-Message-State: AOAM531wc54mbmaprGLVJyKbEFGMcEbgp1DyoT/ev9dp2Wq579pIWlyb
        tqcN9thlpenOzWtCFM/NtELn+1NnfEFTLtGrX5M=
X-Google-Smtp-Source: ABdhPJxSjfFeaIvKMeUtKyBFgh0BXATRF6yhOG6j7VgiMcuP7Alm48/FakLeqW9J+sdvHIt3tJBWychg6p4AMtF5CBw=
X-Received: by 2002:a05:6e02:68f:: with SMTP id o15mr27943384ils.93.1607850578855;
 Sun, 13 Dec 2020 01:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20201209131146.67289-1-laoar.shao@gmail.com> <20201209131146.67289-4-laoar.shao@gmail.com>
 <20201209195235.GN1943235@magnolia>
In-Reply-To: <20201209195235.GN1943235@magnolia>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 13 Dec 2020 17:09:02 +0800
Message-ID: <CALOAHbD_DK9w=s9RDsVBNaYwgeRi4UUEGDHFb3zEsqh_V8gLMA@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
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

On Thu, Dec 10, 2020 at 3:52 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Dec 09, 2020 at 09:11:45PM +0800, Yafang Shao wrote:
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
> >  fs/xfs/xfs_trans.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > index 11d390f0d3f2..4f4645329bb2 100644
> > --- a/fs/xfs/xfs_trans.c
> > +++ b/fs/xfs/xfs_trans.c
> > @@ -67,6 +67,17 @@ xfs_trans_free(
> >       xfs_extent_busy_sort(&tp->t_busy);
> >       xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
> >
> > +
> > +     /* Detach the transaction from this thread. */
> > +     ASSERT(current->journal_info != NULL);
> > +     /*
> > +      * The PF_MEMALLOC_NOFS is bound to the transaction itself instead
> > +      * of the reservation, so we need to check if tp is still the
> > +      * current transaction before clearing the flag.
> > +      */
> > +     if (current->journal_info == tp)
>
> Um, you don't start setting journal_info until the next patch, so this
> means that someone who lands on this commit with git bisect will have a
> xfs with broken logic.
>
> Because this is the patch that changes where we set and restore NOFS
> context, I think you have to introduce xfs_trans_context_swap here,
> and not in the next patch.
>

Thanks for the review. I will change it in the next version.

> I also think the _swap routine has to move the old NOFS state to the
> new transaction's t_pflags,

Sure

> and then set NOFS in the old transaction's
> t_pflags so that when we clear the context on the old transaction we
> don't actually change the thread's NOFS state.
>

Both thread's NOFS state and thead's journal_info state can't be
changed in that case, right ?
So should it better be,

    __xfs_trans_commit(tp, regrant)
        xfs_trans_free(tp, regrant)
            if (!regrant). // don't clear the xfs_trans_context if
regrant is true.
                xfs_trans_context_clear()



> --D
>
> > +             xfs_trans_context_clear(tp);
> > +
> >       trace_xfs_trans_free(tp, _RET_IP_);
> >       if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
> >               sb_end_intwrite(tp->t_mountp->m_super);
> > @@ -153,9 +164,6 @@ xfs_trans_reserve(
> >       int                     error = 0;
> >       bool                    rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
> >
> > -     /* Mark this thread as being in a transaction */
> > -     xfs_trans_context_set(tp);
> > -
> >       /*
> >        * Attempt to reserve the needed disk blocks by decrementing
> >        * the number needed from the number available.  This will
> > @@ -163,10 +171,9 @@ xfs_trans_reserve(
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
> > @@ -241,8 +248,6 @@ xfs_trans_reserve(
> >               tp->t_blk_res = 0;
> >       }
> >
> > -     xfs_trans_context_clear(tp);
> > -
> >       return error;
> >  }
> >
> > @@ -284,6 +289,8 @@ xfs_trans_alloc(
> >       INIT_LIST_HEAD(&tp->t_dfops);
> >       tp->t_firstblock = NULLFSBLOCK;
> >
> > +     /* Mark this thread as being in a transaction */
> > +     xfs_trans_context_set(tp);
> >       error = xfs_trans_reserve(tp, resp, blocks, rtextents);
> >       if (error) {
> >               xfs_trans_cancel(tp);
> > @@ -878,7 +885,6 @@ __xfs_trans_commit(
> >
> >       xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
> >
> > -     xfs_trans_context_clear(tp);
> >       xfs_trans_free(tp);
> >
> >       /*
> > @@ -911,7 +917,6 @@ __xfs_trans_commit(
> >               tp->t_ticket = NULL;
> >       }
> >
> > -     xfs_trans_context_clear(tp);
> >       xfs_trans_free_items(tp, !!error);
> >       xfs_trans_free(tp);
> >
> > @@ -971,9 +976,6 @@ xfs_trans_cancel(
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
