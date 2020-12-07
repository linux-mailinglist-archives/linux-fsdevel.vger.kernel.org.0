Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03442D1077
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLGMUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgLGMUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:20:44 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0ABC0613D1;
        Mon,  7 Dec 2020 04:19:58 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id k8so11963369ilr.4;
        Mon, 07 Dec 2020 04:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmX04Xm8s9mKxY/1lGTzg12tjKncEApAlN819pLIyqc=;
        b=mpFTV6oTfhWaX56ayuVKmKbSEaCmWJ5iWUCha5tRi/nx2gU7B4QdZlmHNiKQXM8OqT
         cqzoB5yJy7x1lGgk4+Yp8Vahayq34pMrR0WPYrHJK332oNhLyLI67oVMb7s4OKpR9hi3
         Uu4UokzCVvKMn+JNTdHbFrseYhjYMQnQyWVSPxG1zpctBq1beGxMzGN3xHG/HM+uYnUq
         pi+JqyG8LHCwesfLFnwvgWdjf7dtie0Yx+jo/K6VnhBmj8U5xJFK+fsdoXUl9V3kaEzf
         f4IsS/vNFr6VBmR4Y+bbc5PXvfhNnfm/PDd8IDk6/qgkUDd7nAxxwWCufFqShYpDjUiG
         HnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmX04Xm8s9mKxY/1lGTzg12tjKncEApAlN819pLIyqc=;
        b=CkU5En2FvyP1lHIUQ187VA+/srvjCq0SIuPiAMnBTphGMw3OKF3mkkZlpMdbHWQIP+
         hERpZEqfvnVrKcmcggqtE29oquKe1Z6F6MunHNhY71I6nJYkd6YO/NbqnIKNWCYU/yiK
         aDhbjhwIAJI7mGeubsQ54eOUKGMlNOG2mVKILQVYytpnAX/PbbCNHwib/LXJW3+LjMDc
         dIxL3c02I64mSjpLYMB85kczMBno/AD5UNwgChuv8hc0pZ1ILO6Njliy6ab/ru7auBov
         YegTwBQRx/H0hLtqoBSHBnZ1L5+N4uRkFZUDTZUhzNNasyd1LLpUD5Vp6Yu1ioH4RE4N
         B7pw==
X-Gm-Message-State: AOAM532z8u5lUwtCcP0zoWGZIURXYh7FRCqwZI0ZJ3Hd0b2tI58I+DsU
        eyt51YuT9DNXnqtgELMpyAY1pJHVEz6IxrN3rYU=
X-Google-Smtp-Source: ABdhPJzwQYZXwRO4yIvDupWtkb1G23sJm52E2tsA9DwtaYDAM01x0Kvacx+v7jdHH+RvqakZ7sDVVXJATr5cUbl4T4o=
X-Received: by 2002:a05:6e02:68f:: with SMTP id o15mr21142088ils.93.1607343597522;
 Mon, 07 Dec 2020 04:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20201206064046.2921-1-laoar.shao@gmail.com> <20201206064046.2921-3-laoar.shao@gmail.com>
 <20201206210445.GI3913616@dread.disaster.area>
In-Reply-To: <20201206210445.GI3913616@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 7 Dec 2020 20:19:21 +0800
Message-ID: <CALOAHbCQ5wCL1J1SF=ThLyrV1AONCZqdOM+quuyYWuVr8io1mw@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] xfs: avoid transaction reservation recursion
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 7, 2020 at 5:04 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sun, Dec 06, 2020 at 02:40:46PM +0800, Yafang Shao wrote:
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
> > fstrans or not, Per Willy. To achieve that, some new helpers are introduce
> > in this patch, per Dave:
> > - xfs_trans_context_set()
> >   Used in xfs_trans_alloc()
> > - xfs_trans_context_clear()
> >   Used in xfs_trans_commit() and xfs_trans_cancel()
> > - xfs_trans_context_active()
> >   To check whehter current is in fs transcation or not
> >
> > Darrick helped fix the error occurred in xfs/141.[2]
> >
> > No obvious error occurred when I run xfstests in my test machine.
> >
> > [1]. Below check is to avoid memory reclaim recursion.
> > if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> >         PF_MEMALLOC))
> >         goto redirty;
> >
> > [2]. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia/
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
> >  fs/xfs/xfs_aops.c      | 23 +++++++++++++++++++++--
> >  fs/xfs/xfs_linux.h     |  4 ----
> >  fs/xfs/xfs_trans.c     | 25 +++++++++++++------------
> >  fs/xfs/xfs_trans.h     | 23 +++++++++++++++++++++++
> >  5 files changed, 57 insertions(+), 25 deletions(-)
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
>
> So this would have given us a warning if something went wrong...
>
> > @@ -568,6 +569,16 @@ xfs_vm_writepage(
> >  {
> >       struct xfs_writepage_ctx wpc = { };
> >
> > +     /*
> > +      * Given that we do not allow direct reclaim to call us, we should
> > +      * never be called while in a filesystem transaction.
> > +      */
> > +     if (xfs_trans_context_active()) {
> > +             redirty_page_for_writepage(wbc, page);
> > +             unlock_page(page);
> > +             return 0;
> > +     }
> > +
> >       return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
> >  }
> >
> > @@ -579,6 +590,14 @@ xfs_vm_writepages(
> >       struct xfs_writepage_ctx wpc = { };
> >
> >       xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > +
> > +     /*
> > +      * Given that we do not allow direct reclaim to call us, we should
> > +      * never be called while in a filesystem transaction.
> > +      */
> > +     if (xfs_trans_context_active())
> > +             return 0;
> > +
> >       return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> >  }
>
> But neither of these will trigger a warning at all, so we won't know
> that there's a bug in the code at all. Given this is primarily a "we
> have a bug in the code" deadlock avoidance check, we really need the
> noisy warnings if these fire...
>

I will add the warning back in the next version.

> > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > index c94e71f741b6..09ae5c181299 100644
> > --- a/fs/xfs/xfs_trans.c
> > +++ b/fs/xfs/xfs_trans.c
> > @@ -67,6 +67,11 @@ xfs_trans_free(
> >       xfs_extent_busy_sort(&tp->t_busy);
> >       xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
> >
> > +     /* Detach the transaction from this thread. */
> > +     ASSERT(current->journal_info != NULL);
> > +     if (current->journal_info == tp)
> > +             xfs_trans_context_clear(tp);
>
> From the context of this patch and the code it is replacing, I have
> no idea why this condition could occur, so this needs a comment
> explaining when current->journal_info is not equal to the
> transaction we are freeing.
>

Right. I think we can remove this check.

> > +
> >       trace_xfs_trans_free(tp, _RET_IP_);
> >       if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
> >               sb_end_intwrite(tp->t_mountp->m_super);
> > @@ -119,7 +124,11 @@ xfs_trans_dup(
> >
> >       ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
> >       tp->t_rtx_res = tp->t_rtx_res_used;
> > +
> > +     /* Associate the new transaction with this thread. */
> > +     ASSERT(current->journal_info == tp);
> >       ntp->t_pflags = tp->t_pflags;
> > +     current->journal_info = ntp;
>
> Why is this open coded and not in a helper like all the
> current->journal_info manipulations? Something like
> xfs_trans_context_swap(tp, ntp) with a comment explaining that it is
> used to transfer the transaction context when rolling a permanent
> transaction?
>

Sure, I will use a wrapper.

> >
> >       /* move deferred ops over to the new tp */
> >       xfs_defer_move(ntp, tp);
> > @@ -153,8 +162,6 @@ xfs_trans_reserve(
> >       int                     error = 0;
> >       bool                    rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
> >
> > -     /* Mark this thread as being in a transaction */
> > -     current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> >
> >       /*
> >        * Attempt to reserve the needed disk blocks by decrementing
> > @@ -163,10 +170,8 @@ xfs_trans_reserve(
> >        */
> >       if (blocks > 0) {
> >               error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> > -             if (error != 0) {
> > -                     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +             if (error != 0)
> >                       return -ENOSPC;
> > -             }
> >               tp->t_blk_res += blocks;
> >       }
> >
> > @@ -241,8 +246,6 @@ xfs_trans_reserve(
> >               tp->t_blk_res = 0;
> >       }
> >
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > -
> >       return error;
> >  }
> >
> > @@ -284,6 +287,8 @@ xfs_trans_alloc(
> >       INIT_LIST_HEAD(&tp->t_dfops);
> >       tp->t_firstblock = NULLFSBLOCK;
> >
> > +     /* Mark this thread as being in a transaction */
> > +     xfs_trans_context_set(tp);
> >       error = xfs_trans_reserve(tp, resp, blocks, rtextents);
> >       if (error) {
> >               xfs_trans_cancel(tp);
>
> This refactoring should probably be a separate patch, done first.
>

Sure.

> > @@ -878,7 +883,6 @@ __xfs_trans_commit(
> >
> >       xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
> >
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> >       xfs_trans_free(tp);
> >
> >       /*
> > @@ -910,7 +914,7 @@ __xfs_trans_commit(
> >                       xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
> >               tp->t_ticket = NULL;
> >       }
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > +
> >       xfs_trans_free_items(tp, !!error);
> >       xfs_trans_free(tp);
> >
> > @@ -970,9 +974,6 @@ xfs_trans_cancel(
> >               tp->t_ticket = NULL;
> >       }
> >
> > -     /* mark this thread as no longer being in a transaction */
> > -     current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> > -
> >       xfs_trans_free_items(tp, dirty);
> >       xfs_trans_free(tp);
> >  }
>
> And moving current_restore_flags_nested() into xfs_trans_free()
> should also probably be a separate patch.
>

Sure.

> That way this patch is simply changing all the flags manipulations
> to use the new wrappers, and not a mix of refactoring and API
> rework...
>

Good suggestion. Thanks.


-- 
Thanks
Yafang
