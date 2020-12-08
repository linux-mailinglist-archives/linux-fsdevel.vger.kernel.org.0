Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCDC2D22DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 06:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgLHFC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 00:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLHFC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 00:02:57 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5DC061749;
        Mon,  7 Dec 2020 21:02:16 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z5so15711517iob.11;
        Mon, 07 Dec 2020 21:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjOIiNIARLKGbCL4WsNHg/y/9CkG9Qa/Drt1maYW5Iw=;
        b=NTglJp1LM2oBXvkzbMWPg0jN+h9rypyRkm22H+yok0+uzCEmlGhclVVu8tEJFgv88a
         VKrFaFyfuYe5l2pcMQwwhGXJ/01B+V1hkOKvpzkGFr3hRv1O0i7s7tlZMKOmZRjJj9Oo
         4kpSItYK0bJjjbtPW7mYiPGq2DIKz+wFTo+Q0iCTzBRzDhScgEJMvJesfmk+ZDiGnKNl
         BYsxrWg2hkwx6KQd+YnCrO9C4Nzn2UgtPy6GOzZU8riMnsDOoORkibPOVm1vOglUsRYm
         N3qBBlA8x5RxSrvEiwO6gwD6LI2iWc13K5QOA1o1hjPZ2xrPgRe5AQ/X5FjW4oIamWuV
         yKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjOIiNIARLKGbCL4WsNHg/y/9CkG9Qa/Drt1maYW5Iw=;
        b=nmVeHIMC93wDLEQe3Au+Xj/9URNCIMGU+1+EOsqXCWY6KQnpDT7nE4u0xSsYUn5dHJ
         tuf0/M9N99UvLkY79I6HYijfxwWAgkH14uNPV0rE2/Px0bynk/PXtCy6t0gfDynUbzsI
         fDRwoA3SZ12NySTp7kwjymDcI6744jyCrd8ti/KfFBmmKecKpmqoHqDtbkn1RL/LEQTC
         3Xhlf7CgJj0Hoot5BGjBcNV3smE+zZheFLKCB8haxFF+nKlcDs6Sd6hoQ1ApvMhGaVZd
         0FVh8AsREC3CZrTpU0O+H9ELkQOIyq586stLluWzL0QkPJYcO9D8kazsBw1df3b4OZdW
         9L2A==
X-Gm-Message-State: AOAM530FNr8CcqCnh0uIK9KVmsQQUqxDaZ1PTg9PvkegXdB++IsGkMQ2
        IC10ZNEaaOMMxHqKQEPVUizkCC33p1cjrt+CJFg=
X-Google-Smtp-Source: ABdhPJwPNOB4pambcCqF8NeCShr9QVSscoPYVupfFDxLMbWV7TrxXDU8JlSbny5pUwIt8GLXX7rbcfbn+tbfJaRJcCM=
X-Received: by 2002:a02:a152:: with SMTP id m18mr24542685jah.64.1607403736011;
 Mon, 07 Dec 2020 21:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20201208021543.76501-1-laoar.shao@gmail.com> <20201208021543.76501-5-laoar.shao@gmail.com>
 <20201208042026.GW3913616@dread.disaster.area>
In-Reply-To: <20201208042026.GW3913616@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 8 Dec 2020 13:01:40 +0800
Message-ID: <CALOAHbA8QtaxKx85U7UraU4D4MzjU=pR7rs0duVfPRvyarymSQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] xfs: use current->journal_info to avoid
 transaction reservation recursion
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

On Tue, Dec 8, 2020 at 12:20 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Dec 08, 2020 at 10:15:43AM +0800, Yafang Shao wrote:
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
> >  fs/xfs/xfs_trans.h     | 25 +++++++++++++++++++++++++
> >  4 files changed, 45 insertions(+), 7 deletions(-)
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
> > index 2371187b7615..28db93d0da97 100644
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
> > +     if (xfs_trans_context_active()) {
> > +             redirty_page_for_writepage(wbc, page);
> > +             unlock_page(page);
> > +             return 0;
> > +     }
>
> hmmm. Missing warning....
>
> > diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> > index 44b11c64a15e..82c6735e40fc 100644
> > --- a/fs/xfs/xfs_trans.h
> > +++ b/fs/xfs/xfs_trans.h
> > @@ -268,16 +268,41 @@ xfs_trans_item_relog(
> >       return lip->li_ops->iop_relog(lip, tp);
> >  }
> >
> > +static inline bool
> > +xfs_trans_context_active(void)
> > +{
> > +     /* Use journal_info to indicate current is in a transaction */
> > +     if (WARN_ON_ONCE(current->journal_info != NULL))
> > +             return true;
> > +
> > +     return false;
> > +}
>
> Ah, this is wrong. The call sites should be:
>
>         if (WARN_ON_ONCE(xfs_trans_context_active())) {
>                 /* do error handling */
>                 return error_value;
>         }
>
> because we might want to use xfs_trans_context_active() to check if
> we are in a transaction context or not and that should not generate
> a warning. Also, placing the warning at the call site gives a more
> accurate indication of which IO path generated the warning....
>

Thanks for the explanation. I will update it in the next version.


-- 
Thanks
Yafang
