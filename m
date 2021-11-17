Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3094544E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 11:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhKQK2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 05:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236257AbhKQK2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637144710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeLytMpeobAX/Mbka1azxJ5y2EI4oXxreVBxQFm+D34=;
        b=eZ1ww7aDADXc2ZXT2Zzgoph/YvjI8H2NaEEjT6RGNzAQ5AAg4wYzkQHVc9E+Ic1xnEdryq
        6LsfRo8eTeZl081QVc5otlei78RSZXcrLM2XpXa9TwOX9rDLh9YXubb7DH7xFDnN8Fl1Jk
        3sZR9NWnQalGX/QZOByq0bOjmGDucfM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-1JBcZch7M1izpwEcNYNTfw-1; Wed, 17 Nov 2021 05:25:09 -0500
X-MC-Unique: 1JBcZch7M1izpwEcNYNTfw-1
Received: by mail-wm1-f70.google.com with SMTP id y9-20020a1c7d09000000b003316e18949bso871162wmc.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 02:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeLytMpeobAX/Mbka1azxJ5y2EI4oXxreVBxQFm+D34=;
        b=DqoxbO0n3cJ14xCAAq/zgxMGWERk1NgKVsvTLfFIPSUuA+GBOkBQ76EJo4sbkpLXsv
         1/d1HOTb+hVRO1Nnxk/iJvHWJM5l32XYI69o5uO4KfLw3wS9g1ITAIE34wMPmU3d/eqX
         XClRSn/4c+lqAi45jfOeh/fSEuQIULorzzOTJwSF/B7EiU/XJ40X9f3T3qvC3WZaZv39
         n2y0Z2xAW9QANU+GbefJfjrNwZludO8giSuDDR3Z40Pk0tgMg32GZRDJvKg7hJH4fqXL
         5/GHCyndxWNsg50inwdUhOQkFRKpD1XdKPsW1wvEd2ia6g+hu3a/BrLZl9zEq92tp7YA
         NpmA==
X-Gm-Message-State: AOAM531Ah0P0R9Q7niyDIpGFd3ok5394uxBdR7zjuUlqyY8E78VjR8VF
        3/VTZLhLwXgxnE2FzUr0RXSoQjq15alBuxftX8dPKnZJ7q6T4iafehR8wQaOMMegWMsjS+r5dJt
        ZI3ilpJJBixnRqJkw/57HT6ojsgAX1Ubln+EO/zsUBw==
X-Received: by 2002:a5d:43c5:: with SMTP id v5mr19042043wrr.11.1637144708010;
        Wed, 17 Nov 2021 02:25:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxV/yzimt/rDgfIdS6R4Pe333apTi73Ff+k6sK61bEAJtugKa8lazitGgtGHk5ESX82WxjntResUX5IKf1Fx4o=
X-Received: by 2002:a5d:43c5:: with SMTP id v5mr19042003wrr.11.1637144707799;
 Wed, 17 Nov 2021 02:25:07 -0800 (PST)
MIME-Version: 1.0
References: <20211111161714.584718-1-agruenba@redhat.com> <20211117053330.GU24307@magnolia>
In-Reply-To: <20211117053330.GU24307@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 17 Nov 2021 11:24:56 +0100
Message-ID: <CAHc6FU4rY=G-pdKzYPVXyQ5SEhtfgh_9CK9wNKbBQRONuP=BFA@mail.gmail.com>
Subject: Re: [5.15 REGRESSION v2] iomap: Fix inline extent handling in iomap_readpage
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 6:33 AM Darrick J. Wong <djwong@kernel.org> wrote:
> On Thu, Nov 11, 2021 at 05:17:14PM +0100, Andreas Gruenbacher wrote:
> > Before commit 740499c78408 ("iomap: fix the iomap_readpage_actor return
> > value for inline data"), when hitting an IOMAP_INLINE extent,
> > iomap_readpage_actor would report having read the entire page.  Since
> > then, it only reports having read the inline data (iomap->length).
> >
> > This will force iomap_readpage into another iteration, and the
> > filesystem will report an unaligned hole after the IOMAP_INLINE extent.
> > But iomap_readpage_actor (now iomap_readpage_iter) isn't prepared to
> > deal with unaligned extents, it will get things wrong on filesystems
> > with a block size smaller than the page size, and we'll eventually run
> > into the following warning in iomap_iter_advance:
> >
> >   WARN_ON_ONCE(iter->processed > iomap_length(iter));
> >
> > Fix that by changing iomap_readpage_iter to return 0 when hitting an
> > inline extent; this will cause iomap_iter to stop immediately.
>
> I guess this means that we also only support having inline data that
> ends at EOF?  IIRC this is true for the three(?) filesystems that have
> expressed any interest in inline data: yours, ext4, and erofs?

Yes.

> > To fix readahead as well, change iomap_readahead_iter to pass on
> > iomap_readpage_iter return values less than or equal to zero.
> >
> > Fixes: 740499c78408 ("iomap: fix the iomap_readpage_actor return value for inline data")
> > Cc: stable@vger.kernel.org # v5.15+
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 1753c26c8e76..fe10d8a30f6b 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -256,8 +256,13 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> >       unsigned poff, plen;
> >       sector_t sector;
> >
> > -     if (iomap->type == IOMAP_INLINE)
> > -             return min(iomap_read_inline_data(iter, page), length);
> > +     if (iomap->type == IOMAP_INLINE) {
> > +             loff_t ret = iomap_read_inline_data(iter, page);
>
> Ew, iomap_read_inline_data returns loff_t.  I think I'll slip in a
> change of return type to ssize_t, if you don't mind?

Really?

> > +
> > +             if (ret < 0)
> > +                     return ret;
>
> ...and a comment here explaining that we only support inline data that
> ends at EOF?

I'll send a separate patch that adds a description for
iomap_read_inline_data and cleans up its return value.

Thanks,
Andreas

> If the answers to all /four/ questions are 'yes', then consider this:
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> --D
>
> > +             return 0;
> > +     }
> >
> >       /* zero post-eof blocks as the page may be mapped */
> >       iop = iomap_page_create(iter->inode, page);
> > @@ -370,6 +375,8 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> >                       ctx->cur_page_in_bio = false;
> >               }
> >               ret = iomap_readpage_iter(iter, ctx, done);
> > +             if (ret <= 0)
> > +                     return ret;
> >       }
> >
> >       return done;
> > --
> > 2.31.1
> >
>

