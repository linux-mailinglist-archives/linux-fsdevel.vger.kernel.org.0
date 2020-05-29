Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC91E7B02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE2Kzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE2Kzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:55:45 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B660C03E969;
        Fri, 29 May 2020 03:55:45 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id t4so1246388vsq.0;
        Fri, 29 May 2020 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1QIrHboYpvTgFpYZIQzYJ/WjTtt+j6wK2PtEXIJTrUg=;
        b=OyqfQtKp2v6T3zrMHuufhS5CDVC7Qgl1i2ab9QM2T5ghSYfVloizeVEEiS5JYXWAKl
         ynpE2/Jb2Uu2cbRnoS6WxHuV7B3bZ9pf5xHzVYkkV/JcMhy8HjJFtJJuKNCIVa0p48AA
         Jw+cpEcZSUNqvXMRQVWxQvrfX6HtBkK3naFI/WsnKVUk+mWdyuPWSECAF3dVAnFs1SIl
         5aRI7s0Odf0VbSFsNIGFFMmWZE8MzwTSwbmaavdnHzrM7mSHWE9AorevKdYjrHGnL++s
         KGDFbJvg/m0+8ra8ZJXySfwZvJ/K8CqrSY733zJeCgqUUeSu0O/PxMp37d3Z/5ofykpF
         8fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1QIrHboYpvTgFpYZIQzYJ/WjTtt+j6wK2PtEXIJTrUg=;
        b=iT9IqBhUm7/qWg7DEGM+6fY1jkytMjt7oX95WxQgPtxCyRXGpClkWPAeTUuJjT7LH2
         r5LKBtwfNoLL9fgveuho15ygltYRis+q6vwY9qaIQ9ReezJL2BeslvrJ9Afja4iV0Y3U
         AvfiJNUcWXwixyElRIXAXDAJZECoMDaAQAEoF+AEA/WCAXEZpbCDPWQF6BR6W85Zpd5x
         +kAYik51rAE4AITEWYhnfISK/CnWp9AQiR49qSbNKbQPqJxb8/V5ZXih9h6kafxWS29z
         ysIgiHwvXMVJS1qylLwOhzAKcsRLEzEnlUdbWet+wT1K1euWsyOwGRmCGDdXNa3VUAqY
         IeAA==
X-Gm-Message-State: AOAM533H2gzJHXigLJPrMQqDSwyohl7pEtwqmHGpTOuYwPR/76Yig+k2
        ZNA98QTcOs6emsnpTSYk5M8T45sIVbx6dCIqR2M=
X-Google-Smtp-Source: ABdhPJxgZrgfRTiBtCGnFfsRDcEdRTPnV9EiEbJKNo9+TOWnbvwfaIQqvCEdXWRPUIhzu3gBvQKgKs65gW9OyIBWVi8=
X-Received: by 2002:a67:cf4d:: with SMTP id f13mr4946101vsm.90.1590749744534;
 Fri, 29 May 2020 03:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200528192103.xm45qoxqmkw7i5yl@fiona> <20200529002319.GQ252930@magnolia>
In-Reply-To: <20200529002319.GQ252930@magnolia>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 29 May 2020 11:55:33 +0100
Message-ID: <CAL3q7H4Mit=P9yHsZXKsVxMN0=7m7gS2ZqiGTbyFz5Aid9t3hQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
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

On Fri, May 29, 2020 at 1:23 AM Darrick J. Wong <darrick.wong@oracle.com> w=
rote:
>
> On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> >
> > Filesystems such as btrfs are unable to guarantee page invalidation
> > because pages could be locked as a part of the extent. Return zero
>
> Locked for what?  filemap_write_and_wait_range should have just cleaned
> them off.

Yes, it will be confusing even for someone more familiar with btrfs.
The changelog could be more detailed to make it clear what's happening and =
why.

So what happens:

1) iomap_dio_rw() calls filemap_write_and_wait_range().
    That starts delalloc for all dirty pages in the range and then
waits for writeback to complete.
    This is enough for most filesystems at least (if not all except btrfs).

2) However, in btrfs once writeback finishes, a job is queued to run
on a dedicated workqueue, to execute the function
btrfs_finish_ordered_io().
    So that job will be run after filemap_write_and_wait_range() returns.
    That function locks the file range (using a btrfs specific data
structure), does a bunch of things (updating several btrees), and then
unlocks the file range.

3) While iomap calls invalidate_inode_pages2_range(), which ends up
calling the btrfs callback btfs_releasepage(),
    btrfs_finish_ordered_io() is running and has the file range locked
(this is what Goldwyn means by "pages could be locked", which is
confusing because it's not about any locked struct page).

4) Because the file range is locked, btrfs_releasepage() returns 0
(page can't be released), this happens in the helper function
try_release_extent_state().
    Any page in that range is not dirty nor under writeback anymore
and, in fact, btrfs_finished_ordered_io() doesn't do anything with the
pages, it's only updating metadata.

    btrfs_releasepage() in this case could release the pages, but
there are other contextes where the file range is locked, the pages
are still not dirty and not under writeback, where this would not be
safe to do.

5) So because of that invalidate_inode_pages2_range() returns
non-zero, the iomap code prints that warning message and then proceeds
with doing a direct IO write anyway.

What happens currently in btrfs, before Goldwyn's patchset:

1) generic_file_direct_write() also calls filemap_write_and_wait_range().
2) After that it calls invalidate_inode_pages2_range() too, but if
that returns non-zero, it doesn't print any warning and falls back to
a buffered write.

So Goldwyn here is effectively adding that behaviour from
generic_file_direct_write() to iomap.

Thanks.

>
> > in case a page cache invalidation is unsuccessful so filesystems can
> > fallback to buffered I/O. This is similar to
> > generic_file_direct_write().
> >
> > This takes care of the following invalidation warning during btrfs
> > mixed buffered and direct I/O using iomap_dio_rw():
> >
> > Page cache invalidation failure on direct I/O.  Possible data
> > corruption due to collision with buffered I/O!
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index e4addfc58107..215315be6233 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *=
iter,
> >        */
> >       ret =3D invalidate_inode_pages2_range(mapping,
> >                       pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > -     if (ret)
> > -             dio_warn_stale_pagecache(iocb->ki_filp);
> > -     ret =3D 0;
> > +     /*
> > +      * If a page can not be invalidated, return 0 to fall back
> > +      * to buffered write.
> > +      */
> > +     if (ret) {
> > +             if (ret =3D=3D -EBUSY)
> > +                     ret =3D 0;
> > +             goto out_free_dio;
>
> XFS doesn't fall back to buffered io when directio fails, which means
> this will cause a regression there.
>
> Granted mixing write types is bogus...
>
> --D
>
> > +     }
> >
> >       if (iov_iter_rw(iter) =3D=3D WRITE && !wait_for_completion &&
> >           !inode->i_sb->s_dio_done_wq) {
> >
> > --
> > Goldwyn



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
