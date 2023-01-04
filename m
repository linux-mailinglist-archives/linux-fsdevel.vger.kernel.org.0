Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBB65DC5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 19:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbjADSv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 13:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjADSvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:51:25 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB43313;
        Wed,  4 Jan 2023 10:51:24 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id e6so16743285qkl.4;
        Wed, 04 Jan 2023 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bQHtx1jV1iYY+5vmOG5eBZD9J3BMwuA/6luLhUEcbrA=;
        b=TDExYjJjMUDUUy6AzN61xsH0jeF30hZHwoIFonbaB9tW4bZD2u9VZTOvIU3egt6YkV
         qjDFO9cClpkhEfxStQv7QAnARC1cUz1J6J46oDCu5WAAxl3NEPfawETfMcz59E23VTph
         FjIAVcr2JFYxDVEw20eno2RmkotjgTlpY0Z3M2EMWLaxQofHzDRgsLJzuZ75xAh0lgd8
         oNt/BucLDPgLKXdMZBbLGP+UotKhlC2GuKsNbj8ybFi7MHAogWPubGcOXp8M+cCMmO24
         +fBnHAJtnMeKbwXnWo51NiKRVZfwQf8uByj5XM78o3P46p+HcG2lznbYQnBaMfTpJXXa
         hEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQHtx1jV1iYY+5vmOG5eBZD9J3BMwuA/6luLhUEcbrA=;
        b=uujAh2ylC9rKIe2+l+u2CKgdk8TDkQmfloYRAYfTpVDkLNJQC8a+jaCBYZ0sQuBCUB
         p3861MILePF8H+R/TIdlisbxtNex8yeXUllf16hSg8gZj5qVqXRz43sumsJyBtiLGyol
         uLhIJ8/5w9RVGYMzQSz3EA2oa8IVmwHmXsvIcOjoZu59A/MiZuBmlM5T23UalxeIK0wJ
         7QNiIXJiHH3acqh+Isp/r4rHtdxcyMZaQaXz8ZyqZPIhNQWBh/t7YjQaNaioyjcA3vg6
         tK7zGxGF3Lb/ujMkP0f/jE8WmvL+TTDip7BAbUxMw9p52S0PSkWmguCxjibHzImJL/13
         6r+Q==
X-Gm-Message-State: AFqh2kr4YRSimJkilGsbMIqt7aVTbTRTYQwdbgSTXi6PrWcnzzVMaJXs
        astCmnbdDiT0EbfoSO6fzSjKEAtXNfQ6iqXMWdg=
X-Google-Smtp-Source: AMrXdXtBsLz6jVERQ2FgRgHifewHsGn5S/jauQZ041epROuzVCvMzwihHIjCh5xjhWaDvOR5Z42UK1HfWetvk4obWeM=
X-Received: by 2002:a05:620a:8305:b0:6fe:e149:de1c with SMTP id
 pa5-20020a05620a830500b006fee149de1cmr2415370qkn.572.1672858283805; Wed, 04
 Jan 2023 10:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20221231150919.659533-1-agruenba@redhat.com> <20221231150919.659533-4-agruenba@redhat.com>
 <Y7W5RGsOgOThtlg3@magnolia>
In-Reply-To: <Y7W5RGsOgOThtlg3@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 4 Jan 2023 19:51:12 +0100
Message-ID: <CAHpGcMK_=KxrhBRxv2msUHSAJ=X=vJM0yG1rnVtJwiZbhhvxTw@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] iomap: Rename page_done handler to put_folio
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

Am Mi., 4. Jan. 2023 um 18:47 Uhr schrieb Darrick J. Wong <djwong@kernel.org>:
>
> On Sat, Dec 31, 2022 at 04:09:13PM +0100, Andreas Gruenbacher wrote:
> > The ->page_done() handler in struct iomap_page_ops is now somewhat
> > misnamed in that it mainly deals with unlocking and putting a folio, so
> > rename it to ->put_folio().
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/gfs2/bmap.c         |  4 ++--
> >  fs/iomap/buffered-io.c |  4 ++--
> >  include/linux/iomap.h  | 10 +++++-----
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> > index 46206286ad42..0c041459677b 100644
> > --- a/fs/gfs2/bmap.c
> > +++ b/fs/gfs2/bmap.c
> > @@ -967,7 +967,7 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
> >       return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
> >  }
> >
> > -static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
> > +static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
> >                                unsigned copied, struct folio *folio)
> >  {
> >       struct gfs2_trans *tr = current->journal_info;
> > @@ -994,7 +994,7 @@ static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
> >
> >  static const struct iomap_page_ops gfs2_iomap_page_ops = {
> >       .page_prepare = gfs2_iomap_page_prepare,
> > -     .page_done = gfs2_iomap_page_done,
> > +     .put_folio = gfs2_iomap_put_folio,
> >  };
> >
> >  static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index e13d5694e299..2a9bab4f3c79 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -580,8 +580,8 @@ static void iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
> >  {
> >       const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> >
> > -     if (page_ops && page_ops->page_done) {
> > -             page_ops->page_done(iter->inode, pos, ret, folio);
> > +     if (page_ops && page_ops->put_folio) {
> > +             page_ops->put_folio(iter->inode, pos, ret, folio);
> >       } else if (folio) {
> >               folio_unlock(folio);
> >               folio_put(folio);
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 743e2a909162..10ec36f373f4 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -126,18 +126,18 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
> >
> >  /*
> >   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
> > - * and page_done will be called for each page written to.  This only applies to
> > + * and put_folio will be called for each page written to.  This only applies to
>
> "...for each folio written to."

Ah, yes.

> With that fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> --D
>
>
> >   * buffered writes as unbuffered writes will not typically have pages

And here, it should be "folios" as well I'd say.

Thanks,
Andreas

> >   * associated with them.
> >   *
> > - * When page_prepare succeeds, page_done will always be called to do any
> > - * cleanup work necessary.  In that page_done call, @folio will be NULL if the
> > - * associated folio could not be obtained.  When folio is not NULL, page_done
> > + * When page_prepare succeeds, put_folio will always be called to do any
> > + * cleanup work necessary.  In that put_folio call, @folio will be NULL if the
> > + * associated folio could not be obtained.  When folio is not NULL, put_folio
> >   * is responsible for unlocking and putting the folio.
> >   */
> >  struct iomap_page_ops {
> >       int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
> > -     void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
> > +     void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
> >                       struct folio *folio);
> >
> >       /*
> > --
> > 2.38.1
> >
