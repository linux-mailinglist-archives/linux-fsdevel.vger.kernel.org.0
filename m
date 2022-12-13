Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3661164BDD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 21:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiLMUSO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 15:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiLMURv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:17:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C62714E
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670962551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsEdZNGVmnTvoH2VquKqwJ5kQo3gqU2sUkgS6EmDZfQ=;
        b=BxMNPcXO6r9s9l+B6uXdRxnPN+tni06s7FrlJti+1WS+Fw3Xr4Tf565DU9SRg0rHFrXb8I
        unYgLGcXWzQVT8P1zSN/++7SjWni3RFx0T7yqMdxewjyve0qJKErGWn1aL0zfjawGXMe0V
        MDn7cEKPgM+CHxaRtQ/asZiTOI5OpQc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-LRViPMdkM_-kXj-h1xUrCQ-1; Tue, 13 Dec 2022 15:15:49 -0500
X-MC-Unique: LRViPMdkM_-kXj-h1xUrCQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-40306a5a42cso180480087b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 12:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsEdZNGVmnTvoH2VquKqwJ5kQo3gqU2sUkgS6EmDZfQ=;
        b=FBAObWrR1HXIDG8XQL12iVI0gHD7nw2EyWI/g5LIpECxYTSpTXr0soQKZ85Ihrc8YK
         72RX04HHyLQ36pa6sSUQFH3Y0Q5+4VbnrIMsOY9oSHe2hkt69vuJbV27EXSxGpktSPik
         Z6jltPermJMwP06+RbE9DVkdd2oGFvlhabR+axgYT5OETkikvmEsTyIK1QaCoY5pSdaI
         6d878WI5fc15t4bdNqAXwyju+V/TxN+aGCwFDaUV7PTWFmsCDaqRpRFd7zikTvC38zNN
         8eLlvYrL7nAlLqooeujzo6mFLiJr9vXAEDvfmIqzf+5AWzwh3cTmVoJ6S1TVsER+nUT0
         XixA==
X-Gm-Message-State: ANoB5plsflkpMUOWuANBKzkWuxCUR0Fpot8y4t1oO64a459jADXl403+
        AXRZ6uyTiYsKoQ/Sbx3T5bX7bbSVJ3Qu3NmoLoCGXAlJCeUfrA9Mv7yFYRpgsw4k9RaKwAkWHgh
        23c7sqBuW3lmP1VKkT0ESJmIS5jVrMla45IquYyY++g==
X-Received: by 2002:a05:6902:1370:b0:6ff:eb24:45aa with SMTP id bt16-20020a056902137000b006ffeb2445aamr21101678ybb.321.1670962549307;
        Tue, 13 Dec 2022 12:15:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7CM1nfbCNHI0ZHI5MDflEDMT6ZkLZC5c2EhDzPUZV7YYp/sc72g7k5DBblPmLsDSxwy5HcT9sotLQ8mGWxeJk=
X-Received: by 2002:a05:6902:1370:b0:6ff:eb24:45aa with SMTP id
 bt16-20020a056902137000b006ffeb2445aamr21101671ybb.321.1670962549051; Tue, 13
 Dec 2022 12:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20221213194833.1636649-1-agruenba@redhat.com> <Y5janUs2/29XZRbc@magnolia>
In-Reply-To: <Y5janUs2/29XZRbc@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 13 Dec 2022 21:15:38 +0100
Message-ID: <CAHc6FU7CZZb48FZSELYg-29ehTUcAzLZoKNGdLSg1XK7Wx9Cfg@mail.gmail.com>
Subject: Re: [PATCH] iomap: Move page_done callback under the folio lock
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 9:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> On Tue, Dec 13, 2022 at 08:48:33PM +0100, Andreas Gruenbacher wrote:
> > Hi Darrick,
> >
> > I'd like to get the following iomap change into this merge window.  This
> > only affects gfs2, so I can push it as part of the gfs2 updates if you
> > don't mind, provided that I'll get your Reviewed-by confirmation.
> > Otherwise, if you'd prefer to pass this through the xfs tree, could you
> > please take it?
>
> I don't mind you pushing changes to ->page_done through the gfs2 tree,
> but don't you need to move the other callsite at the bottom of
> iomap_write_begin?

No, in the failure case in iomap_write_begin(), the folio isn't
relevant because it's not being written to.

Thanks for paying attention,
Andreas

> --D
>
> > Thanks,
> > Andreas
> >
> > --
> >
> > Move the ->page_done() call in iomap_write_end() under the folio lock.
> > This closes a race between journaled data writes and the shrinker in
> > gfs2.  What's happening is that gfs2_iomap_page_done() is called after
> > the page has been unlocked, so try_to_free_buffers() can come in and
> > free the buffers while gfs2_iomap_page_done() is trying to add them to
> > the current transaction.  The folio lock prevents that from happening.
> >
> > The only user of ->page_done() is gfs2, so other filesystems are not
> > affected.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 91ee0b308e13..476c9ed1b333 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -714,12 +714,12 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> >               i_size_write(iter->inode, pos + ret);
> >               iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> >       }
> > +     if (page_ops && page_ops->page_done)
> > +             page_ops->page_done(iter->inode, pos, ret, &folio->page);
> >       folio_unlock(folio);
> >
> >       if (old_size < pos)
> >               pagecache_isize_extended(iter->inode, old_size, pos);
> > -     if (page_ops && page_ops->page_done)
> > -             page_ops->page_done(iter->inode, pos, ret, &folio->page);
> >       folio_put(folio);
> >
> >       if (ret < len)
> > --
> > 2.38.1
> >
>

