Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1EC2DA504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 01:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgLOAoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 19:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgLOAoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:44:08 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E82C061793;
        Mon, 14 Dec 2020 16:42:46 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id p5so17610936ilm.12;
        Mon, 14 Dec 2020 16:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQ8sWYcc6++GKAUXS48FF0Tzgm+rRka2SqEuWOPEWKY=;
        b=a7EUEJTmS4Z2hWBbqkFKAJPVhs2fShTmmSbgtLqEecX4a3vy8EeaAVhvFPoScC2NKe
         OYH2bnMpZzgIRmGE0qVgxB8KYIMPkzt5hGwkIxzWhFNMERhKWKeprMFZ1zOMNS5ADeQY
         CS1Pd6dxpY4oytDY83HyWgrxuqxOzRVvUEkXzonznn5iPVkes6axrw6BjY43rEqx4gQ1
         BMm1v7htdRt9LtLA21zhpaQrZ669TslYlPs73BIhT0miccmfHyEJrLzPrplzg4eOYNu5
         RVR72C3nxnNiGpX6Rd8gY+Z+7az3ULXWYtUI6TPNm95yOM2HcadsTB6fhVXHf218VmKW
         PwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQ8sWYcc6++GKAUXS48FF0Tzgm+rRka2SqEuWOPEWKY=;
        b=DaxBAw3SeegVDqgOXGPtX/jjwzL9xT9Q9EH3waOWyoyrDqH2gzAdNLNwu4+SmSrtWL
         NCpC2vVL/skNnv8Uf87+qSFL9WgVcQhkxwxwEjDo+473k5EO3apjWQM9MrGMfHphmc53
         AmvTbtrJhurUQMGDqazCgbMPz8OBSgsTm8KTB99X6sSvq+llus2sBu4v6z885SAdirKB
         l4uAekDKKDt6NISnJMwMHHa5xJwN4LS84ujmLvj0UyD/hkqkox/k30D5iFQYAsDrOCk1
         KntvCnFdtCJbqlEPg8RQYfJf/JnEZzdmYL1ufloDSwve93OXF+LKSp46aSypEg+05aUN
         h1EQ==
X-Gm-Message-State: AOAM531Lm/GHBautp+ZTDqiSm6XxV/VE8Urkk5xqGF4wh83JQ4rIVEyF
        MEt3pBIkOcFCKUYfrQ3RBbSWacIb4a0e/Vnz1WA=
X-Google-Smtp-Source: ABdhPJzEyU9JNu0fnNhUilOe+9j6k4b6rE292AN0DfQ1OORKBk0RqCWZOtCSN7nTK5XdJ0tiHr7sd+RqSKkpVM+935M=
X-Received: by 2002:a05:6e02:68f:: with SMTP id o15mr39228993ils.93.1607992965458;
 Mon, 14 Dec 2020 16:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20201209131146.67289-1-laoar.shao@gmail.com> <20201209131146.67289-4-laoar.shao@gmail.com>
 <20201209195235.GN1943235@magnolia> <CALOAHbD_DK9w=s9RDsVBNaYwgeRi4UUEGDHFb3zEsqh_V8gLMA@mail.gmail.com>
 <20201214210833.GE632069@dread.disaster.area>
In-Reply-To: <20201214210833.GE632069@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 15 Dec 2020 08:42:08 +0800
Message-ID: <CALOAHbAK=OB1NQKwNYHttBuM=QZjc04cjU=YRw5MoTWT34HXvg@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
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

On Tue, Dec 15, 2020 at 5:08 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sun, Dec 13, 2020 at 05:09:02PM +0800, Yafang Shao wrote:
> > On Thu, Dec 10, 2020 at 3:52 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Wed, Dec 09, 2020 at 09:11:45PM +0800, Yafang Shao wrote:
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
> > > >  fs/xfs/xfs_trans.c | 28 +++++++++++++++-------------
> > > >  1 file changed, 15 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> > > > index 11d390f0d3f2..4f4645329bb2 100644
> > > > --- a/fs/xfs/xfs_trans.c
> > > > +++ b/fs/xfs/xfs_trans.c
> > > > @@ -67,6 +67,17 @@ xfs_trans_free(
> > > >       xfs_extent_busy_sort(&tp->t_busy);
> > > >       xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
> > > >
> > > > +
> > > > +     /* Detach the transaction from this thread. */
> > > > +     ASSERT(current->journal_info != NULL);
> > > > +     /*
> > > > +      * The PF_MEMALLOC_NOFS is bound to the transaction itself instead
> > > > +      * of the reservation, so we need to check if tp is still the
> > > > +      * current transaction before clearing the flag.
> > > > +      */
> > > > +     if (current->journal_info == tp)
> > >
> > > Um, you don't start setting journal_info until the next patch, so this
> > > means that someone who lands on this commit with git bisect will have a
> > > xfs with broken logic.
> > >
> > > Because this is the patch that changes where we set and restore NOFS
> > > context, I think you have to introduce xfs_trans_context_swap here,
> > > and not in the next patch.
> > >
> >
> > Thanks for the review. I will change it in the next version.
> >
> > > I also think the _swap routine has to move the old NOFS state to the
> > > new transaction's t_pflags,
> >
> > Sure
> >
> > > and then set NOFS in the old transaction's
> > > t_pflags so that when we clear the context on the old transaction we
> > > don't actually change the thread's NOFS state.
> > >
> >
> > Both thread's NOFS state and thead's journal_info state can't be
> > changed in that case, right ?
> > So should it better be,
> >
> >     __xfs_trans_commit(tp, regrant)
> >         xfs_trans_free(tp, regrant)
> >             if (!regrant). // don't clear the xfs_trans_context if
> > regrant is true.
> >                 xfs_trans_context_clear()
>
> No. You are trying to make this way more complex than it needs to be.
> The logic in the core XFS code is *already correct* and all we need
> to do is move that logic to wrapper functions, then slightly modify
> the implementation inside the wrapper functions.
>

Thanks for the explanation.

>
> That is, xfs_trans_context_clear() should end up like this:
>

Agreed.

> static inline void
> xfs_trans_context_clear(struct xfs_trans *tp)
> {
>         /*
>          * If xfs_trans_context_swap() handed the NOFS context to a
>          * new transaction we do not clear the context here.
>          */
>         if (current->journal_info != tp)

current->journal_info hasn't been used in patch #3, that will make
patch #3 a little more complex.
We have to do some workaround in patch #3. I will think about it.

>                 return;
>         current->journal_info = NULL;
>         memalloc_nofs_restore(tp->t_pflags);
> }
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com



-- 
Thanks
Yafang
