Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502ED1ECE6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgFCLc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 07:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCLc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:32:27 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FB6C08C5C0;
        Wed,  3 Jun 2020 04:32:26 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v25so725711uau.4;
        Wed, 03 Jun 2020 04:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PI1rnt1hDqTjvBE8Gu3X6DiYZAINHe9ky3fEiJXjP3o=;
        b=Y5pGVwKaLqMd941pWTk4HUbLJ+9jFnYJii5c7cMAqnrU7TLk56w5rroWiHm3sgAOJi
         BocqD9R21RA18b9DnYiKYYNY6tuj3uV1iOFU/QF//4JNuRHN6Zr+l+A2XRqXIYuJBMkF
         VtsM/KoooL8AyHiDYj8NDfKRmmhxul+XLDpu1NuDGDqEd43IWbsC1wcBpg95tnWh9ucb
         eHqmaCH2r34rnDyRn3kare7oshChtowjSbR7GFjJiL5sCue1agtSGmR8dSsQQ3XgW8dD
         TCJCLmvzCEz3weWzsZYBPhxu+zREyo5F3KPq6pQ8rBMZINel2PogO5G3HAJxmO3ali1F
         gF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PI1rnt1hDqTjvBE8Gu3X6DiYZAINHe9ky3fEiJXjP3o=;
        b=ODwYAjKFDpassPQrZUKe28cyVTRN9FFzmyqGlwaFCL/kHEWVTLghv/HnAiQgpAQBQ6
         jTZahw3QK7JRbn5lUXb7nDPs84qD1jJvrsgFjyLtrB4N9hEoQorGMvcYKUIyJmOoeBvH
         kX4+VcoIigY/ckLin/MoZx2U9KKCYsB5ULYGsx4SqPbW8/uWgp/NHoRHHNtErZG/9N9h
         gjuRf4GcQ3RqNmHt1HEvq/Gp+xCNq9jfTrARPgMblUJnqyKdMJ5du4VyHedNTlWxQMiV
         zIBHGBedQbtI191p33tjTklBsvMxkT4AJ6PWdAJUMqa0Wj9a3CzygcR7I6xdY7g5WEZ1
         PWxA==
X-Gm-Message-State: AOAM532BAba4IBU4eZb1xulfOIBChFW712qy8ra78C0J2uyzKEJQAINX
        aPSoPsYDXzLSN8DVkeLUnEvfIKWpC9NLro4DcVU=
X-Google-Smtp-Source: ABdhPJxspY1/Nm5NTobJIX9UN7DynDdyX82bJg7w/I2unETZkrCI7+Oak9obEEYiJeB+fT3OS+0TffGtuODZDB1CkCQ=
X-Received: by 2002:ab0:5498:: with SMTP id p24mr5733513uaa.123.1591183946056;
 Wed, 03 Jun 2020 04:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200528192103.xm45qoxqmkw7i5yl@fiona> <20200529002319.GQ252930@magnolia>
 <20200601151614.pxy7in4jrvuuy7nx@fiona> <CAL3q7H60xa0qW4XdneDdeQyNcJZx7DxtwDiYkuWB5NoUVPYdwQ@mail.gmail.com>
In-Reply-To: <CAL3q7H60xa0qW4XdneDdeQyNcJZx7DxtwDiYkuWB5NoUVPYdwQ@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 3 Jun 2020 12:32:15 +0100
Message-ID: <CAL3q7H4=N2pfnBSiJ+TApy9kwvcPE5sB92sxcVZN10bxZqQpaA@mail.gmail.com>
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

On Wed, Jun 3, 2020 at 12:23 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Mon, Jun 1, 2020 at 4:16 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote=
:
> >
> > On 17:23 28/05, Darrick J. Wong wrote:
> > > On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> > > >
> > > > Filesystems such as btrfs are unable to guarantee page invalidation
> > > > because pages could be locked as a part of the extent. Return zero
> > >
> > > Locked for what?  filemap_write_and_wait_range should have just clean=
ed
> > > them off.
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
> > > >      */
> > > >     ret =3D invalidate_inode_pages2_range(mapping,
> > > >                     pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > -   if (ret)
> > > > -           dio_warn_stale_pagecache(iocb->ki_filp);
> > > > -   ret =3D 0;
> > > > +   /*
> > > > +    * If a page can not be invalidated, return 0 to fall back
> > > > +    * to buffered write.
> > > > +    */
> > > > +   if (ret) {
> > > > +           if (ret =3D=3D -EBUSY)
> > > > +                   ret =3D 0;
> > > > +           goto out_free_dio;
> > >
> > > XFS doesn't fall back to buffered io when directio fails, which means
> > > this will cause a regression there.
> > >
> > > Granted mixing write types is bogus...
> > >
> >
> > I have not seen page invalidation failure errors on XFS, but what shoul=
d
> > happen hypothetically if they do occur? Carry on with the direct I/O?
> > Would an error return like -ENOTBLK be better?
>
> It doesn't make much to me to emit the warning and then proceed to the
> direct IO write path anyway, as if nothing happened.
> If we are concerned about possible corruption, we should either return
> an error or fallback to buffered IO just like
> generic_file_direct_write() did, and not allow the possibility for
> corruptions.
>
> Btw, this is causing a regression in Btrfs now. The problem is that
> dio_warn_stale_pagecache() sets an EIO error in the inode's mapping:
>
> errseq_set(&inode->i_mapping->wb_err, -EIO);
>
> So the next fsync on the file will return that error, despite the
> fsync having completed successfully with any errors.
>
> Since patchset to make btrfs direct IO use iomap is already in Linus'
> tree, we need to fix this somehow.
> This makes generic/547 fail often for example - buffered write against
> file + direct IO write + fsync - the later returns -EIO.

Just to make it clear, despite the -EIO error, there was actually no
data loss or corruption (generic/547 checks that),
since the direct IO write path in btrfs figures out there's a buffered
write still ongoing and waits for it to complete before proceeding
with the dio write.

Nevertheless, it's still a regression, -EIO shouldn't be returned as
everything went fine.

>
> Thanks.
>
> >
> > --
> > Goldwyn
>
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
