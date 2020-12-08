Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6082A2D2144
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 04:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgLHDGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 22:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgLHDGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:06:22 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE83C061793;
        Mon,  7 Dec 2020 19:05:42 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i9so15596310ioo.2;
        Mon, 07 Dec 2020 19:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozr90VGBYbWlh1y66ehF1CrNRHOaukDgzG0FfD0U5rQ=;
        b=fgGD2P02OBd5bUMH1Ot63IAOGjmfSe2xNPQo9CHe4UeOaM0KzF0cjqYmBGL6xhC8nO
         uppNorEvPWQyy8aGzJsP/dn2Gn8OxZfRV/a0NnNgxHLH38Jbb9MqvDpnluDCEQEozt+5
         /7c+domZWrNyFW+by+tHuB9cmD1ryAmzfBlIXBv3EPyl0ZE1lbTIpFoayXtxrw8r9F3o
         pN5HPRFGgb0Qq5uMIU0uwvcbj50RVKHq2ntrTs0asnBbec7P1/8qdwFQPwPH/f+60cEJ
         OlxFBfvtRt9UNuzZA6EZ/M/PDi6VQFPsCFT9JYLryQHDljXeu3B8IbI+4uycienjfzRX
         MVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozr90VGBYbWlh1y66ehF1CrNRHOaukDgzG0FfD0U5rQ=;
        b=gUs0Ta8U0NI+QvTzVVfozIqX/G5XJy/+PuzWs/3wnKEqG3atXNrFn0Cs5Dh6FefWVZ
         SIGQnQEyAdQU8IQdEPbuHF6CoGLsLIn5DieFQNZLsQdB5HKA2EGJVRgrxFzbDAs+dCGV
         Z4MAXyfUAxVV96Ev07fLTdsekkvF/QI06cHVOmLPJ0EhQJDXzWuk43qd0zsSDSS34UWY
         071w2wRlysen4ixycAlb1YuB6qX/7aU91E70l6uiN2nURl1GtfRpLRGhNLT9PirJb7dN
         mthxxZRiezaICGrRnkP5lykVxQZU/RiayY0X/PvXNTdtDROcvNZvLiu987YkLtIkgXQw
         xtaA==
X-Gm-Message-State: AOAM533FZj8v1M2eFQPBV6c7Ju8rRTNl/2+m3Dgiz3CYMBoGAOQF/lok
        fKzPyzMbhQJw5SdyruhiRcFgo0A/RKjF37YYHsM=
X-Google-Smtp-Source: ABdhPJzO/Z1mQm5Wubaj1F0ITFfQTsPZoRC8wJ4I1X7pE/zdNjTZ/nTVVkMwEIoI9Vte3qzs3jUEjltiHBxhWPy6YQE=
X-Received: by 2002:a02:a304:: with SMTP id q4mr24109925jai.97.1607396742053;
 Mon, 07 Dec 2020 19:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20201208021543.76501-1-laoar.shao@gmail.com> <20201208021543.76501-3-laoar.shao@gmail.com>
 <20201208024637.GG7338@casper.infradead.org>
In-Reply-To: <20201208024637.GG7338@casper.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 8 Dec 2020 11:05:06 +0800
Message-ID: <CALOAHbAe_BQzNEJNZCa-ixt4FUEoxHvxkj=jNCGiMF4LnzSwtw@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] xfs: use memalloc_nofs_{save,restore} in xfs transaction
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
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

On Tue, Dec 8, 2020 at 10:46 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 08, 2020 at 10:15:41AM +0800, Yafang Shao wrote:
> > memalloc_nofs_{save,restore} API is introduced in
> > commit 7dea19f9ee63 ("mm: introduce memalloc_nofs_{save,restore} API"),
> > which gives a better abstraction of the usage around PF_MEMALLOC_NOFS. We'd
> > better use this API in XFS instead of using PF_MEMALLOC_NOFS directly as
> > well.
> >
> > To prepare for the followup patch, two new helpers are introduced in XFS
> > to wrap the memalloc_nofs_{save,restore} API, as follows,
> >
> > static inline void
> > xfs_trans_context_set(struct xfs_trans *tp)
> > {
> >       tp->t_pflags = memalloc_nofs_save();
> > }
> >
> > static inline void
> > xfs_trans_context_clear(struct xfs_trans *tp)
> > {
> >       memalloc_nofs_restore(tp->t_pflags);
> > }
>
> Don't repeat the contents of the patch in the changelog.
>

Sure.

> Also, this ordering of patches doesn't make sense.  If I saw this
> patch by itself instead of part of the series, there's no good reason
> to replace one xfs-specific wrapper (current_set_flags_nested) with
> another (xfs_trans_context_set).
>
> If the changelog here said something like ...
>
> Introduce a new API to mark the start and end of XFS transactions.
> For now, just save and restore the memalloc_nofs flags.
>
> ... then it might make more sense to do things in this order.
>

Thanks. I will update it in the next version.

> > These two new helpers are added into xfs_tans.h as they are used in xfs
> > transaction only.
> >
> > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  fs/xfs/xfs_aops.c  |  4 ++--
> >  fs/xfs/xfs_linux.h |  4 ----
> >  fs/xfs/xfs_trans.c | 13 +++++++------
> >  fs/xfs/xfs_trans.h | 12 ++++++++++++
> >  4 files changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index 4304c6416fbb..2371187b7615 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -62,7 +62,7 @@ xfs_setfilesize_trans_alloc(
> >        * We hand off the transaction to the completion thread now, so
> >        * clear the flag here.
> >        */
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     xfs_trans_context_clear(tp);
> >       return 0;
> >  }
> >
> > @@ -125,7 +125,7 @@ xfs_setfilesize_ioend(
> >        * thus we need to mark ourselves as being in a transaction manually.
> >        * Similarly for freeze protection.
> >        */
> > -     current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     xfs_trans_context_set(tp);
> >       __sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
> >
> >       /* we abort the update if there was an IO error */
> > diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> > index 5b7a1e201559..6ab0f8043c73 100644
> > --- a/fs/xfs/xfs_linux.h
> > +++ b/fs/xfs/xfs_linux.h
> > @@ -102,10 +102,6 @@ typedef __u32                    xfs_nlink_t;
> >  #define xfs_cowb_secs                xfs_params.cowb_timer.val
> >
> >  #define current_cpu()                (raw_smp_processor_id())
> > -#define current_set_flags_nested(sp, f)              \
> > -             (*(sp) = current->flags, current->flags |= (f))
> > -#define current_restore_flags_nested(sp, f)  \
> > -             (current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
> >
> >  #define NBBY         8               /* number of bits per byte */
> >
> > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > index c94e71f741b6..11d390f0d3f2 100644
> > --- a/fs/xfs/xfs_trans.c
> > +++ b/fs/xfs/xfs_trans.c
> > @@ -154,7 +154,7 @@ xfs_trans_reserve(
> >       bool                    rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
> >
> >       /* Mark this thread as being in a transaction */
> > -     current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     xfs_trans_context_set(tp);
> >
> >       /*
> >        * Attempt to reserve the needed disk blocks by decrementing
> > @@ -164,7 +164,7 @@ xfs_trans_reserve(
> >       if (blocks > 0) {
> >               error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> >               if (error != 0) {
> > -                     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +                     xfs_trans_context_clear(tp);
> >                       return -ENOSPC;
> >               }
> >               tp->t_blk_res += blocks;
> > @@ -241,7 +241,7 @@ xfs_trans_reserve(
> >               tp->t_blk_res = 0;
> >       }
> >
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     xfs_trans_context_clear(tp);
> >
> >       return error;
> >  }
> > @@ -878,7 +878,7 @@ __xfs_trans_commit(
> >
> >       xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
> >
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     xfs_trans_context_clear(tp);
> >       xfs_trans_free(tp);
> >
> >       /*
> > @@ -910,7 +910,8 @@ __xfs_trans_commit(
> >                       xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
> >               tp->t_ticket = NULL;
> >       }
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +
> > +     xfs_trans_context_clear(tp);
> >       xfs_trans_free_items(tp, !!error);
> >       xfs_trans_free(tp);
> >
> > @@ -971,7 +972,7 @@ xfs_trans_cancel(
> >       }
> >
> >       /* mark this thread as no longer being in a transaction */
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     xfs_trans_context_clear(tp);
> >
> >       xfs_trans_free_items(tp, dirty);
> >       xfs_trans_free(tp);
> > diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> > index 084658946cc8..44b11c64a15e 100644
> > --- a/fs/xfs/xfs_trans.h
> > +++ b/fs/xfs/xfs_trans.h
> > @@ -268,4 +268,16 @@ xfs_trans_item_relog(
> >       return lip->li_ops->iop_relog(lip, tp);
> >  }
> >
> > +static inline void
> > +xfs_trans_context_set(struct xfs_trans *tp)
> > +{
> > +     tp->t_pflags = memalloc_nofs_save();
> > +}
> > +
> > +static inline void
> > +xfs_trans_context_clear(struct xfs_trans *tp)
> > +{
> > +     memalloc_nofs_restore(tp->t_pflags);
> > +}
> > +
> >  #endif       /* __XFS_TRANS_H__ */
> > --
> > 2.18.4
> >
> >



-- 
Thanks
Yafang
