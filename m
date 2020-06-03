Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0BD1ED68B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFCTLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 15:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:11:02 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E81C08C5C0;
        Wed,  3 Jun 2020 12:11:02 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id c1so2041806vsc.11;
        Wed, 03 Jun 2020 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vp7h4Q+Zj2Lt3Qp0tQ+xDIfVwbTZuPSlGZKzkYXD3Po=;
        b=pNFXxlJwqMuPtFcMgIXNTgG5hGGJilVwg6Zq6zQtOjR0tayCKoTo0/BQ/2NkKpM99a
         Gsj8z8VY7zY6jxoPJA2VOaalPSS3gE4NQuBbzB+2lQPbVMycaSrLn5AZZo18agsuiQa2
         xad4UTmP1lWEnNlhV3+IkK8QJ/5OV1NYy+iQr33GOQbGEjT4WMrSFDLRGIGoWVxgxLzK
         lHBrrIAQ5sr9INkXGUyROYZWOerP0h0icZsj1TyEu1sUNYjJPmwiygBvkhyXFAA1Wivw
         afDRqs/ig779TfQLiAG7RqW81z3hcQlw3WEy+nHU/G1WlQYOLbVMUCTxx6QWpQ5C1bNq
         jncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vp7h4Q+Zj2Lt3Qp0tQ+xDIfVwbTZuPSlGZKzkYXD3Po=;
        b=QXP/D+pNIkClPwWD+31OhnGYRX/PaLBZ50EioeMZKl65yUmTEvTN8h/lpC9fKlrsWY
         9wJGyOW9LED3oen/7qEUlPxPFtsNSX7hTQ3FrAht57jTAck59eEKPXTyRm7qsRRqqKLk
         3/Fzf9jMZCtId1ppYFTNzUbnIdW4qmk65wfMeMo5aJ4jbO5AQzxMn7bdUUlBP2RSz9dR
         gxbiArN2gabwikb9BekDMrFBgeFTDXK2ZXBuWNpMsjL67ok/Ji0zpTFEJ3WhKqiU84rk
         S+U2QI3UyNKXGV/WRkBQjQfzRln2X5oQdLTvMq3UbTDqn0ztOWE6Eyf+ocwxgaVKhuwT
         Y/lQ==
X-Gm-Message-State: AOAM533daxKcoFSlBVY5Drymso2aYDyrVaUujPsT+OL4Ye6FNwuusuQ3
        rtaSsO+fMNGgHMZSeCT1X+TGwgArgdA1GstOMtg=
X-Google-Smtp-Source: ABdhPJzwkcpbUS0V9vZJclGHaANKFsVt4CX1AT923hlH6cwbPHHm173ZBrnzUf1xjLSstWWXFuVIFN4W/4VfoesThBA=
X-Received: by 2002:a67:f9d6:: with SMTP id c22mr759834vsq.14.1591211461671;
 Wed, 03 Jun 2020 12:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200528192103.xm45qoxqmkw7i5yl@fiona> <20200529002319.GQ252930@magnolia>
 <20200601151614.pxy7in4jrvuuy7nx@fiona> <CAL3q7H60xa0qW4XdneDdeQyNcJZx7DxtwDiYkuWB5NoUVPYdwQ@mail.gmail.com>
 <CAL3q7H4=N2pfnBSiJ+TApy9kwvcPE5sB92sxcVZN10bxZqQpaA@mail.gmail.com> <20200603190252.GG8204@magnolia>
In-Reply-To: <20200603190252.GG8204@magnolia>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 3 Jun 2020 20:10:50 +0100
Message-ID: <CAL3q7H4gHHHKMNifbTthvT3y3KaTZDSX+L0z7f1uXz7rzDe8BA@mail.gmail.com>
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

On Wed, Jun 3, 2020 at 8:02 PM Darrick J. Wong <darrick.wong@oracle.com> wr=
ote:
>
> On Wed, Jun 03, 2020 at 12:32:15PM +0100, Filipe Manana wrote:
> > On Wed, Jun 3, 2020 at 12:23 PM Filipe Manana <fdmanana@gmail.com> wrot=
e:
> > >
> > > On Mon, Jun 1, 2020 at 4:16 PM Goldwyn Rodrigues <rgoldwyn@suse.de> w=
rote:
> > > >
> > > > On 17:23 28/05, Darrick J. Wong wrote:
> > > > > On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote=
:
> > > > > >
> > > > > > Filesystems such as btrfs are unable to guarantee page invalida=
tion
> > > > > > because pages could be locked as a part of the extent. Return z=
ero
> > > > >
> > > > > Locked for what?  filemap_write_and_wait_range should have just c=
leaned
> > > > > them off.
> > > > >
> > > > > > in case a page cache invalidation is unsuccessful so filesystem=
s can
> > > > > > fallback to buffered I/O. This is similar to
> > > > > > generic_file_direct_write().
> > > > > >
> > > > > > This takes care of the following invalidation warning during bt=
rfs
> > > > > > mixed buffered and direct I/O using iomap_dio_rw():
> > > > > >
> > > > > > Page cache invalidation failure on direct I/O.  Possible data
> > > > > > corruption due to collision with buffered I/O!
> > > > > >
> > > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > > >
> > > > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > > > index e4addfc58107..215315be6233 100644
> > > > > > --- a/fs/iomap/direct-io.c
> > > > > > +++ b/fs/iomap/direct-io.c
> > > > > > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct io=
v_iter *iter,
> > > > > >      */
> > > > > >     ret =3D invalidate_inode_pages2_range(mapping,
> > > > > >                     pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > > > -   if (ret)
> > > > > > -           dio_warn_stale_pagecache(iocb->ki_filp);
> > > > > > -   ret =3D 0;
> > > > > > +   /*
> > > > > > +    * If a page can not be invalidated, return 0 to fall back
> > > > > > +    * to buffered write.
> > > > > > +    */
> > > > > > +   if (ret) {
> > > > > > +           if (ret =3D=3D -EBUSY)
> > > > > > +                   ret =3D 0;
> > > > > > +           goto out_free_dio;
> > > > >
> > > > > XFS doesn't fall back to buffered io when directio fails, which m=
eans
> > > > > this will cause a regression there.
> > > > >
> > > > > Granted mixing write types is bogus...
> > > > >
> > > >
> > > > I have not seen page invalidation failure errors on XFS, but what s=
hould
>
> What happens if you try to dirty an mmap page at the same time as
> issuing a directio?
>
> > > > happen hypothetically if they do occur? Carry on with the direct I/=
O?
> > > > Would an error return like -ENOTBLK be better?
>
> In the old days, we would only WARN when we encountered collisions like
> this.  How about only setting EIO in the mapping if we fail the
> pagecache invalidation in directio completion?  If a buffered write
> dirties the page after the direct write thread flushes the dirty pages
> but before invalidation, we can argue that we didn't lose anything; the
> direct write simply happened after the buffered write.
>
> XFS doesn't implement buffered write fallback, and it never has.  Either
> the entire directio succeeds, or it returns a negative error code.  Some
> of the iomap_dio_rw callers (ext4, jfs2) will notice a short direct
> write and try to finish the rest with buffered io, but xfs and zonefs do
> not.
>
> The net effect of this (on xfs anyway) is that when buffered and direct
> writes collide, before we'd make the buffered writer lose, now we make
> the direct writer lose.
>
> You also /could/ propose teaching xfs how to fall back to an
> invalidating synchronous buffered write like ext4 does, but that's not
> part of this patch set, and that's not a behavior I want to introduce
> suddenly during the merge window.
>
> > > It doesn't make much to me to emit the warning and then proceed to th=
e
> > > direct IO write path anyway, as if nothing happened.
> > > If we are concerned about possible corruption, we should either retur=
n
> > > an error or fallback to buffered IO just like
> > > generic_file_direct_write() did, and not allow the possibility for
> > > corruptions.
> > >
> > > Btw, this is causing a regression in Btrfs now. The problem is that
> > > dio_warn_stale_pagecache() sets an EIO error in the inode's mapping:
> > >
> > > errseq_set(&inode->i_mapping->wb_err, -EIO);
> > >
> > > So the next fsync on the file will return that error, despite the
> > > fsync having completed successfully with any errors.
> > >
> > > Since patchset to make btrfs direct IO use iomap is already in Linus'
> > > tree, we need to fix this somehow.
>
> Y'all /just/ sent the pull request containing that conversion 2 days
> ago.  Why did you move forward with that when you knew there were
> unresolved fstests failures?
>
> > > This makes generic/547 fail often for example - buffered write agains=
t
> > > file + direct IO write + fsync - the later returns -EIO.
> >
> > Just to make it clear, despite the -EIO error, there was actually no
> > data loss or corruption (generic/547 checks that),
> > since the direct IO write path in btrfs figures out there's a buffered
> > write still ongoing and waits for it to complete before proceeding
> > with the dio write.
> >
> > Nevertheless, it's still a regression, -EIO shouldn't be returned as
> > everything went fine.
>
> Now I'm annoyed because I feel like you're trying to strong-arm me into
> making last minute changes to iomap when you could have held off for
> another cycle.

If you are talking to me, I'm not trying to strong-arm anyone nor
point a fingers.
I'm just reporting a problem that I found earlier today while testing
some work I was doing.

Thanks.

>
> While I'm pretty sure your analysis is correct that we could /probably/
> get away with only setting EIO if we can't invalidate the cache after
> we've already written the disk blocks directly (because then we really
> did lose something), I /really/ want these kinds of behavioral changes
> to shared code to soak in for-next for long enough that we can work out
> the kinks without exposing the upstream kernel to unnecessary risk.
>
> This conversation would be /much/ different had you not just merged the
> btrfs directio iomap conversion yesterday.
>
> --D
>
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > --
> > > > Goldwyn
> > >
> > >
> > >
> > > --
> > > Filipe David Manana,
> > >
> > > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 =
you're right.=E2=80=9D
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
