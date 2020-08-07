Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3097B23E696
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 06:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgHGEM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 00:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgHGEMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:12:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6569C061574;
        Thu,  6 Aug 2020 21:12:24 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g14so656493iom.0;
        Thu, 06 Aug 2020 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tR46+jH5HAE5RBYT73wIlj3eTY5WLMg+m88DMWq/IdQ=;
        b=t5oLN1mBhXv0gHC6lx0fidZIOb7WEf4YcNP2+rKWfNA0NznbT8k/QFWao3Gnk3aUHp
         KqYQbJSzuUY2SVeBgT9QBeSaK/PjcyyIibRkILH5P2I1Hf/pzA5O6G5xmjgSYHlC9l4G
         REVHH1baJYlrFX0BwXX2oiE5Dae5zxIE2GJ2Wvrl2oy/dBQYvzVTpVDPGtZ+syhOohvm
         U60oiQiLr5tD93JQmf+BBdyP3jxGEqE2mMXaGAFnxIRsIe2ZUZpwu+9WoKDSgCs4jHPh
         g5SsfNNkzOA1IsevHd7UNrqeadGBDiYITPsEr1AQ01BcA2KCjLKBT+EkdLu0usaokWOK
         pV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tR46+jH5HAE5RBYT73wIlj3eTY5WLMg+m88DMWq/IdQ=;
        b=nx5Vrw/lsWJLHYU45R+xUy//KZ2yBYUy+DmDo3UGYOQLKrw/0O/4614pEw+dQxauPC
         8D+4VsJz1pd1c5574XBKy0/bSlToGoe0PnVjr0PAqEhk60wGt2h0gAIWIX8xnt5Q6WSu
         blkQiKgp0deyc263P86Jeej22zwpiPwG5P9Wz34r+Hp/cWwnVJAovEj52D1c2jt7GVCx
         f5HAbnSsIXFdNUUHDGHKrUMZYH0EdnSIVMBn6s6oMjQlHFfbL061BSG1hOKNvSlYCTZO
         BjTNEyvG81Ek+VFU4WN3UomXhj/UZQFVlRJ+AJR4TtoCQaHeG81LbhSuFOpuPV4MAaP3
         mrEg==
X-Gm-Message-State: AOAM532IB163vb43ct9whYW2yIayABNLf5dFPalrbvW2N3r2d2niAvCO
        pRuLlbUu14Fk9epsr9IBRLGxq5UWFsYaqvJItZU=
X-Google-Smtp-Source: ABdhPJzdDcMpFQJ83WorZ3S8PJ+sGu+ca3vrkSQnrfd38VFioTPUGK3RJQ9ZSZYPqkq3SPJFwn0xRQXqjCugePJlQZ0=
X-Received: by 2002:a02:a905:: with SMTP id n5mr2836770jam.64.1596773544199;
 Thu, 06 Aug 2020 21:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200801154632.866356-1-laoar.shao@gmail.com> <20200801154632.866356-3-laoar.shao@gmail.com>
 <20200804233541.GE2114@dread.disaster.area>
In-Reply-To: <20200804233541.GE2114@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 7 Aug 2020 12:11:48 +0800
Message-ID: <CALOAHbCbyx8HSG2vRcK7dtDCk_abUiHwmXBgvNPRkrvnUsOZyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] xfs: avoid transaction reservation recursion
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Yafang Shao <shaoyafang@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 5, 2020 at 7:35 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Aug 01, 2020 at 11:46:32AM -0400, Yafang Shao wrote:
> > From: Yafang Shao <shaoyafang@didiglobal.com>
> >
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
> > fstrans or not.
>
> IF we are just going to use ->journal_info, do it the simple way.
>
> > index 2d25bab68764..0795511f9e6a 100644
> > --- a/fs/xfs/libxfs/xfs_btree.c
> > +++ b/fs/xfs/libxfs/xfs_btree.c
> > @@ -2825,6 +2825,7 @@ xfs_btree_split_worker(
> >       if (args->kswapd)
> >               new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> >
> > +     xfs_trans_context_start();
>
> Not really. We are transferring a transaction context here, not
> starting one. Hence this reads somewhat strangely.
>
> This implies that the helper function should be something like:
>
>         xfs_trans_context_set(tp);
>
>
> >       current_set_flags_nested(&pflags, new_pflags);
> >
> >       args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
> > @@ -2832,6 +2833,7 @@ xfs_btree_split_worker(
> >       complete(args->done);
> >
> >       current_restore_flags_nested(&pflags, new_pflags);
> > +     xfs_trans_context_end();
>
> And this is more likely xfs_trans_context_clear(tp)
>
> Reasons for this will become clear soon...
>
> >  }
> >
> >  /*
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index b35611882ff9..39ef95acdd8e 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -63,6 +63,8 @@ xfs_setfilesize_trans_alloc(
> >        * clear the flag here.
> >        */
> >       current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +     xfs_trans_context_end();
>
> Note the repeated pairing of functions in this patch?
>
> > +
> >       return 0;
> >  }
> >
> > @@ -125,6 +127,7 @@ xfs_setfilesize_ioend(
> >        * thus we need to mark ourselves as being in a transaction manually.
> >        * Similarly for freeze protection.
> >        */
> > +     xfs_trans_context_start();
> >       current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> >       __sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
> >
> > diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> > index 9f70d2f68e05..1192b660a968 100644
> > --- a/fs/xfs/xfs_linux.h
> > +++ b/fs/xfs/xfs_linux.h
> > @@ -111,6 +111,25 @@ typedef __u32                    xfs_nlink_t;
> >  #define current_restore_flags_nested(sp, f)  \
> >               (current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
> >
> > +static inline void xfs_trans_context_start(void)
> > +{
> > +     long flags = (long)current->journal_info;
> > +
> > +     /*
> > +      * Reuse journal_info to indicate whehter the current is in fstrans
> > +      * or not.
> > +      */
> > +     current->journal_info = (void *)(flags + 1);
> > +}
> > +
> > +static inline void xfs_trans_context_end(void)
> > +{
> > +     long flags = (long)current->journal_info;
> > +
> > +     WARN_ON_ONCE(flags <= 0);
> > +     current->journal_info = ((void *)(flags - 1));
> > +}
>
> This is overly complex, and cannot be used for validation that we
> are clearing the transaction context we expect to be clearing. These
> are really "set" and "clear" operations, and for rolling
> transactions we are going to need an "update" operation, too.
>
> As per my comments about the previous patch, _set() would be done
> in xfs_trans_alloc(), _clear() would be done on the final
> xfs_trans_commit() or _cancel() and _update() would be done when the
> transaction rolls.
>
> Then we can roll in the NOFS updates, and we get these three helper
> functions that keep all the per-transaction thread state coherent:
>
> static inline void
> xfs_trans_context_set(struct xfs_trans *tp)
> {
>         ASSERT(!current->journal_info);
>         current->journal_info = tp;
>         tp->t_flags = memalloc_nofs_save();
> }
>
> static inline void
> xfs_trans_context_update(struct xfs_trans *old, struct xfs_trans *new)
> {
>         ASSERT(current->journal_info == old);
>         current->journal_info = new;
>         new->t_flags = old->t_flags;
> }
>
> static inline void
> xfs_trans_context_clear(struct xfs_trans *tp)
> {
>         ASSERT(current->journal_info == tp);
>         current->journal_info = NULL;
>         memalloc_nofs_restore(tp->t_flags);
> }
>

Below helper will be used in fs/iomap/buffered-io.c, so I think we'd
better name it with fstrans_context_active() and put it in
include/linux/iomap.h, while regarding the other three helpers I think
we'd better put them in fs/xfs/xfs_trans.h.
> static bool
> xfs_trans_context_active(void)
> {
>         return current->journal_info != NULL;
> }
>

Many thanks for the detailed explanation, I will update with your
suggestion in the next version.

-- 
Thanks
Yafang
