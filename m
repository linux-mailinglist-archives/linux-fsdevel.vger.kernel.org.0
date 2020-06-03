Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7FD1ECE38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFCLXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 07:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFCLXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:23:47 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E9BC08C5C0;
        Wed,  3 Jun 2020 04:23:47 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id g129so1165221vsc.4;
        Wed, 03 Jun 2020 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=y7FWwoobcsPP40OyH4Tz598jhyv/yE2NYqyLFTHYbPU=;
        b=l32gLM5O/VFeAbmyOdI+3AcrKyJ2IhpsExXh+PPZWmbWr9D8sdKab8u2DQ4FCwvcg4
         rToDfKviksIE6fn09zE+1q7Ue+FejLqwW7RqzZ4/nY25o66fzZI3fgVTOJ/TiPdV8ywf
         HIUZwdcgIQE/ZUIogkcjMIm/BLg1wV3Fly7smRDT1xU86LoLe1wPWLll+Fr4VzAO59aY
         jY16CgjDm8gU1yqDmp78UuBMzdZHHR+ObZC7nlaV5g7C0Xln5wmKPKtwv+z8O5y+gm8y
         swVKlkmsJMAk3evW9ExqBdbjAJXdhMANZiGm9FqgGyriVSd8ZGp6A1QX1fCoKxb060is
         a46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=y7FWwoobcsPP40OyH4Tz598jhyv/yE2NYqyLFTHYbPU=;
        b=B1uS+/LsVlOK4h6E292mnMilDx1jXkQbrxOcjLaoDUPggdI+VR1dN/RMt2k1T9vY6L
         c89UShnslM+oLt1y8ExsJUz537ODQBgzuCeMFAU4AOlqtkasNGmL87SAQVB7tobENiDk
         293LXsR+a+tHrR7fsV12HTx3cLrh/3XgMctYNNeImYToQ0mygn13+XHQoxiloblkJ1qP
         WTshmsGeLxa7vn/ZjP1Mq/4zKyKekj3JwfGPS0v2GHy12qhhtD3whSCmaprCBWiux9wX
         2OsG0hac3/mlhUCxjI9cNYU3m977Z2J51VH6hJA+q7Q7yC8nOgtq7jCUn2Gfo0c4im3y
         9kiQ==
X-Gm-Message-State: AOAM533nzqBsPzqaQ7OHCJ/BYKVLx0iJeNOBD2pxJOX692to7PtWLuuw
        yD3S9RDDECaaZRJjotZBf/eqDsx8OX45gC8FG07qRN5+
X-Google-Smtp-Source: ABdhPJwrNnJZ94w+B5cDRzvjU3lCmTBgfzEKsESn6bNw9P5dGOznjkl/I5LuXuoRkLCwpj2+tLFsxJbcqh1Lkz16QXA=
X-Received: by 2002:a67:f9d6:: with SMTP id c22mr12179521vsq.14.1591183426522;
 Wed, 03 Jun 2020 04:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200528192103.xm45qoxqmkw7i5yl@fiona> <20200529002319.GQ252930@magnolia>
 <20200601151614.pxy7in4jrvuuy7nx@fiona>
In-Reply-To: <20200601151614.pxy7in4jrvuuy7nx@fiona>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 3 Jun 2020 12:23:35 +0100
Message-ID: <CAL3q7H60xa0qW4XdneDdeQyNcJZx7DxtwDiYkuWB5NoUVPYdwQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
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

On Mon, Jun 1, 2020 at 4:16 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> On 17:23 28/05, Darrick J. Wong wrote:
> > On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> > >
> > > Filesystems such as btrfs are unable to guarantee page invalidation
> > > because pages could be locked as a part of the extent. Return zero
> >
> > Locked for what?  filemap_write_and_wait_range should have just cleaned
> > them off.
> >
> > > in case a page cache invalidation is unsuccessful so filesystems can
> > > fallback to buffered I/O. This is similar to
> > > generic_file_direct_write().
> > >
> > > This takes care of the following invalidation warning during btrfs
> > > mixed buffered and direct I/O using iomap_dio_rw():
> > >
> > > Page cache invalidation failure on direct I/O.  Possible data
> > > corruption due to collision with buffered I/O!
> > >
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > >
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index e4addfc58107..215315be6233 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter=
 *iter,
> > >      */
> > >     ret =3D invalidate_inode_pages2_range(mapping,
> > >                     pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > -   if (ret)
> > > -           dio_warn_stale_pagecache(iocb->ki_filp);
> > > -   ret =3D 0;
> > > +   /*
> > > +    * If a page can not be invalidated, return 0 to fall back
> > > +    * to buffered write.
> > > +    */
> > > +   if (ret) {
> > > +           if (ret =3D=3D -EBUSY)
> > > +                   ret =3D 0;
> > > +           goto out_free_dio;
> >
> > XFS doesn't fall back to buffered io when directio fails, which means
> > this will cause a regression there.
> >
> > Granted mixing write types is bogus...
> >
>
> I have not seen page invalidation failure errors on XFS, but what should
> happen hypothetically if they do occur? Carry on with the direct I/O?
> Would an error return like -ENOTBLK be better?

It doesn't make much to me to emit the warning and then proceed to the
direct IO write path anyway, as if nothing happened.
If we are concerned about possible corruption, we should either return
an error or fallback to buffered IO just like
generic_file_direct_write() did, and not allow the possibility for
corruptions.

Btw, this is causing a regression in Btrfs now. The problem is that
dio_warn_stale_pagecache() sets an EIO error in the inode's mapping:

errseq_set(&inode->i_mapping->wb_err, -EIO);

So the next fsync on the file will return that error, despite the
fsync having completed successfully with any errors.

Since patchset to make btrfs direct IO use iomap is already in Linus'
tree, we need to fix this somehow.
This makes generic/547 fail often for example - buffered write against
file + direct IO write + fsync - the later returns -EIO.

Thanks.

>
> --
> Goldwyn



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
