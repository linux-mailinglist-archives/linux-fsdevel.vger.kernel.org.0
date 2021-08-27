Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530193FA12E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 23:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhH0Vd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 17:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhH0Vd3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:33:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EB3C60F58;
        Fri, 27 Aug 2021 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630099959;
        bh=y8z3/XKnVDeuNQf8gfmjbfX5mTKkn+C8iBSvzVZM7ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0ROG2Qxfk6FDAULnV2nqG0z4YjYqtmPLua7ojGOhzOpGEvrFMAoaVFiTQP9JxIzg
         X32cPWsEcX5B2U+B3FLmFhRGm4i6rG9HQEpWMqzYrnFDa5F2e6JgQwoJymd7/YhnxY
         m4ozVulQNnO9yTGtpNIRCzoZj+hOKxNByj9uHLvDtcMLDRsBCfyUbGDXqeEPOu6zeZ
         TSqhw2O3D3z/utWVBfrfvMjlgnIVKx/RrZERq85kUbXk810zWOI+QrqxI77c2OhiDC
         6SR/NcBGpCVSpZlMegl6hhAk6W4228xkDqqj5EbjWdpcf5H6FQKLNCuMlEKwTMaoTw
         z7CZbFUMrNemw==
Date:   Fri, 27 Aug 2021 14:32:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
Message-ID: <20210827213239.GH12597@magnolia>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-17-agruenba@redhat.com>
 <20210827183018.GJ12664@magnolia>
 <CAHc6FU44mGza=G4prXh08=RJZ0Wu7i6rBf53BjURj8oyX5Q8iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU44mGza=G4prXh08=RJZ0Wu7i6rBf53BjURj8oyX5Q8iA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:15:11PM +0200, Andreas Gruenbacher wrote:
> On Fri, Aug 27, 2021 at 8:30 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > On Fri, Aug 27, 2021 at 06:49:23PM +0200, Andreas Gruenbacher wrote:
> > > Add a done_before argument to iomap_dio_rw that indicates how much of
> > > the request has already been transferred.  When the request succeeds, we
> > > report that done_before additional bytes were tranferred.  This is
> > > useful for finishing a request asynchronously when part of the request
> > > has already been completed synchronously.
> > >
> > > We'll use that to allow iomap_dio_rw to be used with page faults
> > > disabled: when a page fault occurs while submitting a request, we
> > > synchronously complete the part of the request that has already been
> > > submitted.  The caller can then take care of the page fault and call
> > > iomap_dio_rw again for the rest of the request, passing in the number of
> > > bytes already tranferred.
> > >
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > ---
> > >  fs/btrfs/file.c       |  5 +++--
> > >  fs/ext4/file.c        |  5 +++--
> > >  fs/gfs2/file.c        |  4 ++--
> > >  fs/iomap/direct-io.c  | 11 ++++++++---
> > >  fs/xfs/xfs_file.c     |  6 +++---
> > >  fs/zonefs/super.c     |  4 ++--
> > >  include/linux/iomap.h |  4 ++--
> > >  7 files changed, 23 insertions(+), 16 deletions(-)
> > >
> >
> > <snip to the interesting parts>
> >
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index ba88fe51b77a..dcf9a2b4381f 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -31,6 +31,7 @@ struct iomap_dio {
> > >       atomic_t                ref;
> > >       unsigned                flags;
> > >       int                     error;
> > > +     size_t                  done_before;
> > >       bool                    wait_for_completion;
> > >
> > >       union {
> > > @@ -126,6 +127,9 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> > >       if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
> > >               ret = generic_write_sync(iocb, ret);
> > >
> > > +     if (ret > 0)
> > > +             ret += dio->done_before;
> >
> > Pardon my ignorance since this is the first time I've had a crack at
> > this patchset, but why is it necessary to carry the "bytes copied"
> > count from the /previous/ iomap_dio_rw call all the way through to dio
> > completion of the current call?
> 
> Consider the following situation:
> 
>  * A user submits an asynchronous read request.
> 
>  * The first page of the buffer is in memory, but the following
>    pages are not. This isn't uncommon for consecutive reads
>    into freshly allocated memory.
> 
>  * iomap_dio_rw writes into the first page. Then it
>    hits the next page which is missing, so it returns a partial
>    result, synchronously.
> 
>  * We then fault in the remaining pages and call iomap_dio_rw
>    for the rest of the request.
> 
>  * The rest of the request completes asynchronously.
> 
> Does that answer your question?

No, because you totally ignored the second question:

If the directio operation succeeds even partially and the PARTIAL flag
is set, won't that push the iov iter ahead by however many bytes
completed?

We already finished the IO for the first page, so the second attempt
should pick up where it left off, i.e. the second page.

--D

> Thanks,
> Andreas
> 
