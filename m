Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35412DEC69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 01:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLSA3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 19:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgLSA3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 19:29:19 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1534C06138C;
        Fri, 18 Dec 2020 16:28:38 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id n9so3841964ili.0;
        Fri, 18 Dec 2020 16:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPVM+h1yU+rYtYYm/wlc4NEIQ0PzwsacEydpO06K9XE=;
        b=kTZ3m3xvfqnp9olK7BWcZoiF8s6BlP1qTGMLUdT+kfIF5NEFTompVw3BrK8ewB1xVj
         Rj1ys2nHKp8Z3ndWgBi1pOysfG1C1ny8hl8Xoo1JWfTA55QaerWD6Ctfyds6uFkaobmU
         +92DpR8JuhGgWaloC7F7qIddTvnw21bXBllcSYHt/vWsFQFPNdlQHDTmGe+klTnxM8KB
         QmpfZkODK6Q1kB+SQY4z/xXojN3STKg73hDhBuVBH2LLR9MEodWFI1ezaN8wPBmYTs4v
         xQKJ+/sYHW3dajEAB3SA74PRpuFZlnPMliNoQVow/0GG91tmsBy/yP8c2EgSRjPIy8V/
         tI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPVM+h1yU+rYtYYm/wlc4NEIQ0PzwsacEydpO06K9XE=;
        b=aJCIFUPDc9TmIFXnOFuSYdyz3NHSB5HtS3ezt0Zff36KzqLso25YOIfsqfHFWMAvXf
         /So6XcKzm1sgM+NZQuinJSdhmEur9hKNsfad7wG0xRXqzksPWS0sMIjfreEPqV6YVpVw
         6XMXQwtkB40hnN3xf0pOx2+O/zAZ0GWgKqSMZX4guEwpSOBNN9HEnVvkUia2Sj+AnD31
         VcBMgc+ZbKZ9hJzIUhKr/6+Ytt4oS7w2/PKkTLYnCjpBbE/G0nzq3Ap0p60Xh4dOB9Kx
         nBcCtbf0wjydBT2m+3uiRhVvzGmU6L2AstPB2s+KzhNxzloRI8IUb+ZXlAOFpVXYJ6zP
         6Nsg==
X-Gm-Message-State: AOAM532Ux59NGP1vwIyN1iFdBBacDP885ENgh5ZE905AzHtDFxZXx5cX
        leXpA5Oir8QCuRnD90D8O09z1EUPfR9Xr/HFqbQ=
X-Google-Smtp-Source: ABdhPJz+KJh7dGrxqQVVQCtCBTrQGXNchHDSEESjWTprd7z6kNilqN06QJJfnHMx9qKQkDTMmhKgdvbax3MdOwj737w=
X-Received: by 2002:a92:489b:: with SMTP id j27mr6630232ilg.168.1608337718154;
 Fri, 18 Dec 2020 16:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20201217011157.92549-1-laoar.shao@gmail.com> <20201217011157.92549-4-laoar.shao@gmail.com>
 <20201217221509.GQ632069@dread.disaster.area>
In-Reply-To: <20201217221509.GQ632069@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 19 Dec 2020 08:28:02 +0800
Message-ID: <CALOAHbAWLVGFO8QGQK05HHzokji+=XsCE3tt3E5eCx87smrDtg@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
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

On Fri, Dec 18, 2020 at 6:15 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Dec 17, 2020 at 09:11:56AM +0800, Yafang Shao wrote:
> > The xfs_trans context should be active after it is allocated, and
> > deactive when it is freed.
> > The rolling transaction should be specially considered, because in the
> > case when we clear the old transaction the thread's NOFS state shouldn't
> > be changed, as a result we have to set NOFS in the old transaction's
> > t_pflags in xfs_trans_context_swap().
> >
> > So these helpers are refactored as,
> > - xfs_trans_context_set()
> >   Used in xfs_trans_alloc()
> > - xfs_trans_context_clear()
> >   Used in xfs_trans_free()
> >
> > And a new helper is instroduced to handle the rolling transaction,
> > - xfs_trans_context_swap()
> >   Used in rolling transaction
> >
> > This patch is based on Darrick's work to fix the issue in xfs/141 in the
> > earlier version. [1]
> >
> > 1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia
>
> As I said in my last comments, this change of logic is not
> necessary.  All we need to do is transfer the NOFS state to the new
> transactions and *remove it from the old one*.
>

Thanks for the explanation, I will change it.

> IOWs, all this patch should do is:
>
> > @@ -119,7 +123,9 @@ xfs_trans_dup(
> >
> >       ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
> >       tp->t_rtx_res = tp->t_rtx_res_used;
> > -     ntp->t_pflags = tp->t_pflags;
> > +
> > +     /* Associate the new transaction with this thread. */
> > +     xfs_trans_context_swap(tp, ntp);
> >
> >       /* move deferred ops over to the new tp */
> >       xfs_defer_move(ntp, tp);
>
> This, and
>
> > diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> > index 44b11c64a15e..12380eaaf7ce 100644
> > --- a/fs/xfs/xfs_trans.h
> > +++ b/fs/xfs/xfs_trans.h
> > @@ -280,4 +280,17 @@ xfs_trans_context_clear(struct xfs_trans *tp)
> >       memalloc_nofs_restore(tp->t_pflags);
> >  }
> >
> > +static inline void
> > +xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> > +{
>
> introduce this wrapper.
>
> > +     ntp->t_pflags = tp->t_pflags;
> > +     /*
> > +      * For the rolling transaction, we have to set NOFS in the old
> > +      * transaction's t_pflags so that when we clear the context on
> > +      * the old transaction we don't actually change the thread's NOFS
> > +      * state.
> > +      */
> > +     tp->t_pflags = current->flags | PF_MEMALLOC_NOFS;
> > +}
>
> But not with this implementation.
>
> Think for a minute, please. All we want to do is avoid clearing
> the nofs state when we call xfs_trans_context_clear(tp) if the state
> has been handed to another transaction.
>
> Your current implementation hands the state to ntp, but *then leaves
> it on tp* as well. So then you hack a PF_MEMALLOC_NOFS flag into
> tp->t_pflags so that it doesn't clear that flag (abusing the masking
> done during clearing). That's just nasty because it relies on
> internal memalloc_nofs_restore() details for correct functionality.
>
> The obvious solution: we've moved the saved process state to a
> different context, so it is no longer needed for the current
> transaction we are about to commit. So How about just clearing the
> saved state from the original transaction when swappingi like so:
>
> static inline void
> xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> {
>         ntp->t_pflags = tp->t_pflags;
>         tp->t_flags = 0;
> }
>
> And now, when we go to clear the transaction context, we can simply
> do this:
>
> static inline void
> xfs_trans_context_clear(struct xfs_trans *tp)
> {
>         if (tp->t_pflags)
>                 memalloc_nofs_restore(tp->t_pflags);
> }
>
> and the problem is solved. The NOFS state will follow the active
> transaction and not be reset until the entire transaction chain is
> completed.
>
> In the next patch you can go and introduce current->journal_info
> into just the wrapper functions, maintaining the same overall
> logic.
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com



-- 
Thanks
Yafang
