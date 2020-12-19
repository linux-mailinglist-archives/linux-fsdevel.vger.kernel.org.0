Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263632DEC50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 01:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgLSARh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 19:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgLSARg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 19:17:36 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F5C0617B0;
        Fri, 18 Dec 2020 16:16:56 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q1so3789953ilt.6;
        Fri, 18 Dec 2020 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+srfVk5LFUit/NQt+S2ivZ9seQ6hbpnwEWB584IB1M=;
        b=SaMiyBIWjpP1z8VlNM9VPbdbeQpZuMO+Ymt7hFKE3OVQV3PVyQYZaTe41AuayQ4r7u
         D+0JyaOGlcCJXwD0QJ0BL594q7v/7PJIhIfXbD/iOduoUfb1AR/PPG6R3AbmcVSYpbAm
         ovQ1Z0Y7b+pCrlyU+CgG4sY+lARHw6/0xHltrMSJ5PJh5+cFypQsXtrLXce9Y/dH1Rpp
         MwrS/DOBr5q00zFGlcpV5qvSu+Mpr2EdZwA1tU41g7kRErAGjXT4OGZ4WVp1vWoD2yjo
         bVJeGjhEzZ0pmAySe4X4Tu5S75zZlgcgfpuqM0IboeBybQTIh4uGfeN1e3irR1Lcb1qY
         eRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+srfVk5LFUit/NQt+S2ivZ9seQ6hbpnwEWB584IB1M=;
        b=jaZTNIQjDUTUptZRIpVIFWJgKGuUY4XJudFnhEz11qxcCmjsitsN532lS2KXysJKzi
         Cja4L6YZspoeZCmEuNG5gmv8kZGFFkEcewZZu0EdE09BCv51TsGmbgwODES0pU5E1p9A
         PcrIqURE93PvVtHzj+hiaad0WpKmxNu6dfas45yaGMvPzFhnsiJXT1ylSt9pr5h5tApU
         4lcJZftZHQASa0vD3I3ZMWJF6xL5m64GPHncyVzh3SmCwtJRRi4qcz7Smm4QGvTAOtkz
         jXjGMfb2o079DxzL0Hz5GZSh0V9BjeE9jn/w5hH3/Swg+f5G5H1im5j5aADyaCsOYJVH
         GefQ==
X-Gm-Message-State: AOAM531TvVi/rsqWTuDkbPd/VkCAxhE6fCmEy5U51D33n2RdOGGXpWJA
        kGhAQFbxVGkOGkX52hT2B9s3jVTuHCUn8eT3nBw=
X-Google-Smtp-Source: ABdhPJzSxqkvV+NbAPCJQWZJzXNqRmylB8moClwA0C9kvg1T5xDU8dIs76SfXzjOTqJ1BXo3tRJj9ii5YSitobTpRSU=
X-Received: by 2002:a05:6e02:c32:: with SMTP id q18mr6667563ilg.203.1608337015728;
 Fri, 18 Dec 2020 16:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20201217011157.92549-1-laoar.shao@gmail.com> <20201217011157.92549-5-laoar.shao@gmail.com>
 <20201218001442.GS632069@dread.disaster.area>
In-Reply-To: <20201218001442.GS632069@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 19 Dec 2020 08:16:19 +0800
Message-ID: <CALOAHbAKJ3G5VrsMhHeCy44rp2rhVUk2rWb1qdEF0BvRDuYYAA@mail.gmail.com>
Subject: Re: [PATCH v13 4/4] xfs: use current->journal_info to avoid
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

On Fri, Dec 18, 2020 at 8:14 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Dec 17, 2020 at 09:11:57AM +0800, Yafang Shao wrote:
> > PF_FSTRANS which is used to avoid transaction reservation recursion, is
> > dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> > PF_MEMALLOC_NOFS") and replaced by PF_MEMALLOC_NOFS which means to avoid
> > filesystem reclaim recursion.
> >
> > As these two flags have different meanings, we'd better reintroduce
> > PF_FSTRANS back. To avoid wasting the space of PF_* flags in task_struct,
> > we can reuse the current->journal_info to do that, per Willy. As the
> > check of transaction reservation recursion is used by XFS only, we can
> > move the check into xfs_vm_writepage(s), per Dave.
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
> >  fs/xfs/xfs_trans.h     | 26 +++++++++++++++++++-------
> >  3 files changed, 36 insertions(+), 14 deletions(-)
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
>
> Comment is wrong. This is not protecting against direct reclaim
> recursion, this is protecting against writeback from within a
> transaction context.
>

Ah, I forgot to change this comment after copy and paste. Thanks for
pointing it out.

> Best to remove the comment altogether, because it is largely
> redundant.
>

Sure, I will remove these comments.

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
>
> same here.
>
> > +     if (WARN_ON_ONCE(xfs_trans_context_active()))
> > +             return 0;
> > +
> >       return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> >  }
> >
> > diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> > index 12380eaaf7ce..0c8140147b9b 100644
> > --- a/fs/xfs/xfs_trans.h
> > +++ b/fs/xfs/xfs_trans.h
> > @@ -268,29 +268,41 @@ xfs_trans_item_relog(
> >       return lip->li_ops->iop_relog(lip, tp);
> >  }
> >
> > +static inline bool
> > +xfs_trans_context_active(void)
> > +{
> > +     /* Use journal_info to indicate current is in a transaction */
> > +     return current->journal_info != NULL;
> > +}
>
> Comment is not necessary.
>
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
> > +     /*
> > +      * If xfs_trans_context_swap() handed the NOFS context to a
> > +      * new transaction we do not clear the context here.
> > +      */
>
> It's a transaction context, not a "NOFS context". Setting NOFS is
> just something we implement inside the transaction context. More
> correct would be:
>
>         /*
>          * If we handed over the context via xfs_trans_context_swap() then
>          * the context is no longer ours to clear.
>          */
>

Sure, I will change it.


-- 
Thanks
Yafang
