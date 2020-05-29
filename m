Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4F1E7C4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgE2LuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 07:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgE2LuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 07:50:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC74C03E969;
        Fri, 29 May 2020 04:50:13 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id t4so1321781vsq.0;
        Fri, 29 May 2020 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7W1O2HXAIbyQ+otP3BbkCzr3HZK9gd+LWW8WRJTmcZo=;
        b=YMgzh8dme7JNlQFNNWoOaODk8CUN4nP77yF270bhT+l9zVoRo3yoqLOBqoj0RnVu2j
         QiKlrLoQd0FLoy54lBdx7uN/Ur0uw3dAwuuSDgsMsx/oF+gHMQ30dK7b1n/j0fZ07IY2
         C0fRFZJ4gm6aC9W3e68MtnfHdZ7UXpLwpT0I8BHtz/jpcQJl/Kc7EiGLVZwINdnTLPyf
         eU3UvHXI04YkjzHQfdRUVtWsWkehcaPFetsA4EQmNDxoUqe72REUodv+IKWL/c7p/fQg
         aivafL1sCw6KJJ2kZntOr55cxIxrNpLZVdEEAlyaPLMfeH0AFxggz4gRhiNMyKBViBDN
         IGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7W1O2HXAIbyQ+otP3BbkCzr3HZK9gd+LWW8WRJTmcZo=;
        b=RDwWQT78eMeDsTluPgsZ5Q1+zq4NmkjHtFRT/c/l2WBgQ+hTTQBJ3Tgq3gUo1jBU4B
         5OBnogQtW91cVlBOorgBGCTKG5Ieb8RkGj/fUBWfhAS7rguzjVW4wYUiGxK1TN+5hp8F
         P+hjsSzGWsxo5vvVz8xqmyBpEqR6x5yoG/Vg/fS3DjJ8d6POO9YprGZ/XUe4Z7GISigm
         gqY+SkuhnZ2zGI3EXrXrmlSorf4yBdlIaEXpFwUtUzQFQbz8NbO6X6LvXMHc5BH1nMRT
         PDgwRSUf75C2mB8viGE45yNBeyIcDygJyHkLvaysKsrAylPn6NnUeQBMbXw7WdRmcdeB
         VJAA==
X-Gm-Message-State: AOAM533OnHDBPzlFM3i6mCUPIO+x7qFhvdQCHRK66yiRieQ+wsynKT2j
        Tm0AmvrFpwAgHbukhruQtpwhI/pWpi+HExqzffU=
X-Google-Smtp-Source: ABdhPJy66B1TfOo6HFPClQhFiuex5EouoquqLGPqhgQDSCvY6RYVY2ovl7m/pbFPikdhHq95thEmKiUEhHtyKPxWIG4=
X-Received: by 2002:a05:6102:242b:: with SMTP id l11mr4923345vsi.14.1590753012594;
 Fri, 29 May 2020 04:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200528192103.xm45qoxqmkw7i5yl@fiona> <20200529002319.GQ252930@magnolia>
 <CAL3q7H4Mit=P9yHsZXKsVxMN0=7m7gS2ZqiGTbyFz5Aid9t3hQ@mail.gmail.com> <20200529113116.GU17206@bombadil.infradead.org>
In-Reply-To: <20200529113116.GU17206@bombadil.infradead.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 29 May 2020 12:50:01 +0100
Message-ID: <CAL3q7H5cp8joqHnS8rtPBBEQyYw9L0KbRNCQwFfKz1pD-tZvwQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 12:31 PM Matthew Wilcox <willy@infradead.org> wrote=
:
>
> On Fri, May 29, 2020 at 11:55:33AM +0100, Filipe Manana wrote:
> > On Fri, May 29, 2020 at 1:23 AM Darrick J. Wong <darrick.wong@oracle.co=
m> wrote:
> > >
> > > On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> > > >
> > > > Filesystems such as btrfs are unable to guarantee page invalidation
> > > > because pages could be locked as a part of the extent. Return zero
> > >
> > > Locked for what?  filemap_write_and_wait_range should have just clean=
ed
> > > them off.
> >
> > Yes, it will be confusing even for someone more familiar with btrfs.
> > The changelog could be more detailed to make it clear what's happening =
and why.
> >
> > So what happens:
> >
> > 1) iomap_dio_rw() calls filemap_write_and_wait_range().
> >     That starts delalloc for all dirty pages in the range and then
> > waits for writeback to complete.
> >     This is enough for most filesystems at least (if not all except btr=
fs).
> >
> > 2) However, in btrfs once writeback finishes, a job is queued to run
> > on a dedicated workqueue, to execute the function
> > btrfs_finish_ordered_io().
> >     So that job will be run after filemap_write_and_wait_range() return=
s.
> >     That function locks the file range (using a btrfs specific data
> > structure), does a bunch of things (updating several btrees), and then
> > unlocks the file range.
> >
> > 3) While iomap calls invalidate_inode_pages2_range(), which ends up
> > calling the btrfs callback btfs_releasepage(),
> >     btrfs_finish_ordered_io() is running and has the file range locked
> > (this is what Goldwyn means by "pages could be locked", which is
> > confusing because it's not about any locked struct page).
> >
> > 4) Because the file range is locked, btrfs_releasepage() returns 0
> > (page can't be released), this happens in the helper function
> > try_release_extent_state().
> >     Any page in that range is not dirty nor under writeback anymore
> > and, in fact, btrfs_finished_ordered_io() doesn't do anything with the
> > pages, it's only updating metadata.
> >
> >     btrfs_releasepage() in this case could release the pages, but
> > there are other contextes where the file range is locked, the pages
> > are still not dirty and not under writeback, where this would not be
> > safe to do.
>
> Isn't this the bug, though?  Rather than returning "page can't be
> released", shouldn't ->releasepage sleep on the extent state, at least
> if the GFP mask indicates you can sleep?

Goldwyn mentioned in another thread that he had tried that with the
following patch:

https://patchwork.kernel.org/patch/11275063/

But he mentioned it didn't work though, caused some locking problems.
I don't know the details and I haven't tried the patchset yet.
Goldwyn?

>
> > 5) So because of that invalidate_inode_pages2_range() returns
> > non-zero, the iomap code prints that warning message and then proceeds
> > with doing a direct IO write anyway.
> >
> > What happens currently in btrfs, before Goldwyn's patchset:
> >
> > 1) generic_file_direct_write() also calls filemap_write_and_wait_range(=
).
> > 2) After that it calls invalidate_inode_pages2_range() too, but if
> > that returns non-zero, it doesn't print any warning and falls back to
> > a buffered write.
> >
> > So Goldwyn here is effectively adding that behaviour from
> > generic_file_direct_write() to iomap.
> >
> > Thanks.
> >
> > >
> > > > in case a page cache invalidation is unsuccessful so filesystems ca=
n
> > > > fallback to buffered I/O. This is similar to
> > > > generic_file_direct_write().
> > > >
> > > > This takes care of the following invalidation warning during btrfs
> > > > mixed buffered and direct I/O using iomap_dio_rw():
> > > >
> > > > Page cache invalidation failure on direct I/O.  Possible data
> > > > corruption due to collision with buffered I/O!
> > > >
> > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > >
> > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > index e4addfc58107..215315be6233 100644
> > > > --- a/fs/iomap/direct-io.c
> > > > +++ b/fs/iomap/direct-io.c
> > > > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_it=
er *iter,
> > > >        */
> > > >       ret =3D invalidate_inode_pages2_range(mapping,
> > > >                       pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > -     if (ret)
> > > > -             dio_warn_stale_pagecache(iocb->ki_filp);
> > > > -     ret =3D 0;
> > > > +     /*
> > > > +      * If a page can not be invalidated, return 0 to fall back
> > > > +      * to buffered write.
> > > > +      */
> > > > +     if (ret) {
> > > > +             if (ret =3D=3D -EBUSY)
> > > > +                     ret =3D 0;
> > > > +             goto out_free_dio;
> > >
> > > XFS doesn't fall back to buffered io when directio fails, which means
> > > this will cause a regression there.
> > >
> > > Granted mixing write types is bogus...
> > >
> > > --D
> > >
> > > > +     }
> > > >
> > > >       if (iov_iter_rw(iter) =3D=3D WRITE && !wait_for_completion &&
> > > >           !inode->i_sb->s_dio_done_wq) {
> > > >
> > > > --
> > > > Goldwyn
> >
> >
> >
> > --
> > Filipe David Manana,
> >
> > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
