Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19D65DC80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 20:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbjADTDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 14:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjADTDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:03:10 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F10248;
        Wed,  4 Jan 2023 11:03:08 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d13so24054656qvj.8;
        Wed, 04 Jan 2023 11:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pTjo/9+5dGsDu5LarlQNnwmMiElbczSxkHDB5tXnbzA=;
        b=gLq8HHEWjtwYqXma5ySE06hGKf8zWDivmQkA2njYCMg2HWztXwE6hRMlGtYgeIPj/5
         vB0b2sMF/Jn/xCBO+myLzvgc+kavjuiwd7/IB72Xywu5zRZckHmAaLsXDEMiM86A3gGo
         eRMNgOgy5CPKQD2LQxQ/lEbukVvAq1QP4+XRQb5S0iBizM9e4kMKEIaNBjJSbC58S2Gc
         L9HXUAydyh9Sbbp/V4L8ZPIR6l5lz+AzXLC7naKC6v4wxXC/w9Bp1tc+oLPGHafq+XHD
         t+9vSCh9/qZo9rD+bSwrehDD8NjoWQYRCxwHRyk2Tg2ggwaCmQFF0S1z7Ai6nb1MIpr/
         gLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTjo/9+5dGsDu5LarlQNnwmMiElbczSxkHDB5tXnbzA=;
        b=OyzJ0xnF/l8QBh2RzHP6URj3dfvrTJBq+/Xjv5t3WSB44+tKYmHXHrrF2MQPk3duf8
         /wTRldLkhPSfQrqZ+06cai+3wbORp+zt97qQV4WM3s9flBG9P7gZuonZqRNzvDOLtsEy
         nY+s7wSkj1QmoImvwdLPedsinhgYYrW4mu+FGbDDsqc2fiTci/C3KE+el7TSHxgBQmAq
         gYh/eQuFKOJ+T/QBuGDkEYNc0t8+M9UA5tqBqtRXw4tL/lZj1ySKNJ2oOIoUgpdspK/q
         3d2J68kjVsvlnlZC7F8fCmcuwowokdt/r+inekV2W4dVYHvg+7LZiFsmfTe4BfMc0VYW
         BpYg==
X-Gm-Message-State: AFqh2koOv21c6Jya12SQthMkdZZ5JDEsV4pK3OPPnReB6aC4J1FaGvD+
        7Jpap7+knvASzecYYYm9sOcH14XyjSjWR0dMYGKFUgu0f/s=
X-Google-Smtp-Source: AMrXdXupxbTpmCjTep7UhT36HT0CRXGatphE6RzlJ8cTKiAXQO4hM0H3wVvG89XbeP5wi9jFYQ0+CiINPPGFotp5LiA=
X-Received: by 2002:ad4:5908:0:b0:532:f87:7546 with SMTP id
 ez8-20020ad45908000000b005320f877546mr11568qvb.93.1672858987846; Wed, 04 Jan
 2023 11:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20221231150919.659533-1-agruenba@redhat.com> <20221231150919.659533-8-agruenba@redhat.com>
 <Y7W9Dfub1WeTvG8G@magnolia>
In-Reply-To: <Y7W9Dfub1WeTvG8G@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 4 Jan 2023 20:02:56 +0100
Message-ID: <CAHpGcMJu47qQEFgzSvodbpJtPz71HFrG66wbrXR_6AdbkZsOOw@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] iomap/xfs: Eliminate the iomap_valid handler
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 4. Jan. 2023 um 19:00 Uhr schrieb Darrick J. Wong <djwong@kernel.org>:
> On Sat, Dec 31, 2022 at 04:09:17PM +0100, Andreas Gruenbacher wrote:
> > Eliminate the ->iomap_valid() handler by switching to a ->get_folio()
> > handler and validating the mapping there.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 25 +++++--------------------
> >  fs/xfs/xfs_iomap.c     | 37 ++++++++++++++++++++++++++-----------
> >  include/linux/iomap.h  | 22 +++++-----------------
> >  3 files changed, 36 insertions(+), 48 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 4f363d42dbaf..df6fca11f18c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -630,7 +630,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> >       const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> >       const struct iomap *srcmap = iomap_iter_srcmap(iter);
> >       struct folio *folio;
> > -     int status = 0;
> > +     int status;
> >
> >       BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> >       if (srcmap != &iter->iomap)
> > @@ -646,27 +646,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> >               folio = page_ops->get_folio(iter, pos, len);
> >       else
> >               folio = iomap_get_folio(iter, pos);
> > -     if (IS_ERR(folio))
> > -             return PTR_ERR(folio);
> > -
> > -     /*
> > -      * Now we have a locked folio, before we do anything with it we need to
> > -      * check that the iomap we have cached is not stale. The inode extent
> > -      * mapping can change due to concurrent IO in flight (e.g.
> > -      * IOMAP_UNWRITTEN state can change and memory reclaim could have
> > -      * reclaimed a previously partially written page at this index after IO
> > -      * completion before this write reaches this file offset) and hence we
> > -      * could do the wrong thing here (zero a page range incorrectly or fail
> > -      * to zero) and corrupt data.
> > -      */
> > -     if (page_ops && page_ops->iomap_valid) {
> > -             bool iomap_valid = page_ops->iomap_valid(iter->inode,
> > -                                                     &iter->iomap);
> > -             if (!iomap_valid) {
> > +     if (IS_ERR(folio)) {
> > +             if (folio == ERR_PTR(-ESTALE)) {
> >                       iter->iomap.flags |= IOMAP_F_STALE;
> > -                     status = 0;
> > -                     goto out_unlock;
> > +                     return 0;
> >               }
> > +             return PTR_ERR(folio);
>
> I wonder if this should be reworked a bit to reduce indenting:
>
>         if (PTR_ERR(folio) == -ESTALE) {
>                 iter->iomap.flags |= IOMAP_F_STALE;
>                 return 0;
>         }
>         if (IS_ERR(folio))
>                 return PTR_ERR(folio);
>
> But I don't have any strong opinions about that.

This is a relatively hot path; the compiler would have to convert the
flattened version back to the nested version for the best possible
result to avoid a redundant check. Not sure it would always do that.

> >       }
> >
> >       if (pos + len > folio_pos(folio) + folio_size(folio))
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 669c1bc5c3a7..d0bf99539180 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -62,29 +62,44 @@ xfs_iomap_inode_sequence(
> >       return cookie | READ_ONCE(ip->i_df.if_seq);
> >  }
> >
> > -/*
> > - * Check that the iomap passed to us is still valid for the given offset and
> > - * length.
> > - */
> > -static bool
> > -xfs_iomap_valid(
> > -     struct inode            *inode,
> > -     const struct iomap      *iomap)
> > +static struct folio *
> > +xfs_get_folio(
> > +     struct iomap_iter       *iter,
> > +     loff_t                  pos,
> > +     unsigned                len)
> >  {
> > +     struct inode            *inode = iter->inode;
> > +     struct iomap            *iomap = &iter->iomap;
> >       struct xfs_inode        *ip = XFS_I(inode);
> > +     struct folio            *folio;
> >
> > +     folio = iomap_get_folio(iter, pos);
> > +     if (IS_ERR(folio))
> > +             return folio;
> > +
> > +     /*
> > +      * Now that we have a locked folio, we need to check that the iomap we
> > +      * have cached is not stale.  The inode extent mapping can change due to
> > +      * concurrent IO in flight (e.g., IOMAP_UNWRITTEN state can change and
> > +      * memory reclaim could have reclaimed a previously partially written
> > +      * page at this index after IO completion before this write reaches
> > +      * this file offset) and hence we could do the wrong thing here (zero a
> > +      * page range incorrectly or fail to zero) and corrupt data.
> > +      */
> >       if (iomap->validity_cookie !=
> >                       xfs_iomap_inode_sequence(ip, iomap->flags)) {
> >               trace_xfs_iomap_invalid(ip, iomap);
> > -             return false;
> > +             folio_unlock(folio);
> > +             folio_put(folio);
> > +             return ERR_PTR(-ESTALE);
> >       }
> >
> >       XFS_ERRORTAG_DELAY(ip->i_mount, XFS_ERRTAG_WRITE_DELAY_MS);
> > -     return true;
> > +     return folio;
> >  }
> >
> >  const struct iomap_page_ops xfs_iomap_page_ops = {
> > -     .iomap_valid            = xfs_iomap_valid,
> > +     .get_folio              = xfs_get_folio,
> >  };
> >
> >  int
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index dd3575ada5d1..6f8e3321e475 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -134,29 +134,17 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
> >   * When get_folio succeeds, put_folio will always be called to do any
> >   * cleanup work necessary.  put_folio is responsible for unlocking and putting
> >   * @folio.
> > + *
> > + * When an iomap is created, the filesystem can store internal state (e.g., a
> > + * sequence number) in iomap->validity_cookie.  When it then detects in the
>
> I would reword this to:
>
> "When an iomap is created, the filesystem can store internal state (e.g.
> sequence number) in iomap->validity_cookie.  The get_folio handler can
> use this validity cookie to detect if the iomap is no longer up to date
> and needs to be refreshed.  If this is the case, the function should
> return ERR_PTR(-ESTALE) to retry the operation with a fresh mapping."

Yes, but "e.g." is always followed by a comma and it's "when", not
"if" here. So how about:

 * When an iomap is created, the filesystem can store internal state (e.g., a
 * sequence number) in iomap->validity_cookie.  The get_folio handler can use
 * this validity cookie to detect when the iomap needs to be refreshed because
 * it is no longer up to date.  In that case, the function should return
 * ERR_PTR(-ESTALE) to retry the operation with a fresh mapping.

I've incorporated all your feedback into this branch for now:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=iomap-race

Thank you,
Andreas


> --D
>
> > + * get_folio handler that the iomap is no longer up to date and needs to be
> > + * refreshed, it can return ERR_PTR(-ESTALE) to trigger a retry.
> >   */
> >  struct iomap_page_ops {
> >       struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
> >                       unsigned len);
> >       void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
> >                       struct folio *folio);
> > -
> > -     /*
> > -      * Check that the cached iomap still maps correctly to the filesystem's
> > -      * internal extent map. FS internal extent maps can change while iomap
> > -      * is iterating a cached iomap, so this hook allows iomap to detect that
> > -      * the iomap needs to be refreshed during a long running write
> > -      * operation.
> > -      *
> > -      * The filesystem can store internal state (e.g. a sequence number) in
> > -      * iomap->validity_cookie when the iomap is first mapped to be able to
> > -      * detect changes between mapping time and whenever .iomap_valid() is
> > -      * called.
> > -      *
> > -      * This is called with the folio over the specified file position held
> > -      * locked by the iomap code.
> > -      */
> > -     bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> >  };
> >
> >  /*
> > --
> > 2.38.1
> >
