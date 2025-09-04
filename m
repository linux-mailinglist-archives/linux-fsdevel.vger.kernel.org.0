Return-Path: <linux-fsdevel+bounces-60299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE794B447E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A981BC4F44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFE8288CBF;
	Thu,  4 Sep 2025 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRI7MuGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC702874F3;
	Thu,  4 Sep 2025 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019503; cv=none; b=qBOLXmphPSBjDV5dBe0l7Ztx8wcLvwzf3X2973PWQoQrak0cXJjnDnLVZKzQ2ERDXI3oIccKHwclqyR6dU/vytswobJeAxNNxpUA0fM+W2qe++LZHJ1Yi4ahMwOeYOmpq5+yhDRmT/gDT3GHW8HGLRdhhif/H1QztCD8ATXy+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019503; c=relaxed/simple;
	bh=GbPYQt63wKjujfZb/7zodtfPZpf2M98vl7RvUKSaMVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mjc0O1OddCuTdKCMqJKLtAyfyu+h/ow+TCDjZHD5tE0XoVTJe6cwdj3uFSFThSp++R8A/M89pck6cgo9fOoV99nVueoaKkKICfjfR2hiLki3OqW7R7Wx19EOriFesKoSG3JE4k1AHbkq9vqTvZvGcJ1x2ZKdSbf0h9yhwxsAfXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRI7MuGc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b3289ed834so17836051cf.1;
        Thu, 04 Sep 2025 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757019501; x=1757624301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjIWkNshoqX+yPDVvFR9uyzNZLhGoD944zzaK0IVS0s=;
        b=LRI7MuGcmIsNbu6hw+lw/hmXsE8XJy7MQ11VTcTaN+idqZCWtPkvc6miex1/49Mlcl
         C6Na4b7whCz4PNyt/yZJFw7qRzYU4AIh7G6qxsgB7Bu6c+5wt9vzQQQ7DuAdCMBp/lAg
         6SoACj7VwTdrU+MOYv6HkYqQSbX1yfS+/wYfPgFpI5RZbxq2FZTH2zVxHbUTqd67pmEu
         6R2dCdwwZqoHeNzXNqIhOrlXo7LNU8eJ1iZFplSNmSpu2+vFVVTGcAjlUe9XuK4IuItF
         mq5/DCjEYOq8njpvw97ayNna6TPCcImeiX04bv7CiAT/2ffUWuE1Qa1viWVwh4VmUZUF
         mSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757019501; x=1757624301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjIWkNshoqX+yPDVvFR9uyzNZLhGoD944zzaK0IVS0s=;
        b=hBy0aZvpISsYhbbCJOecTNPc1qB1vsHMFLqLSd3+QuAstutJI9RTobVHyTG+HaykQN
         ZakjBqN9C0wT3D1/3sglfExGI+YP//2lPCU/EN7wugaayzAHb0Ipac86+ukj0cvjAx1c
         zKrtGj2PLbMDuxd0q6hv+7VdT8Th3ke8t4jx3dhlEM4htxg5uAVuBaMahG+sLIuewggY
         mxh7XPDJ4ekAno3UnO8g4wJyJwAZbrLGxDfFvEalqNg+Wlj779QPpqWHgbR8OEwsyNV3
         qt2v/TuzvSGW6VJ2N6L2fHrDqPp1Xe1ZWY61iAm2Yo78uk4cPoWpjp8va/GUL1X3vPWA
         xXZg==
X-Forwarded-Encrypted: i=1; AJvYcCU4zF7XxGMcXijvOGuEYE5aCm50kgpsChS2V0EBSpr23D300lVvoi/juIa7FMVxLariECrdWH8aTJew@vger.kernel.org, AJvYcCX9O0Mmn2mzJIm84ow0MbjyFJbCF5QW0caf9EaupWvV6oZAHcguf28G1/dmxTZq0odfuGSa0YGHYyrHy9ICyQ==@vger.kernel.org, AJvYcCXKqWf/KFt20nZsiFSeB/Jj4T8kb1Uq4vO+Ct2K8jdwL8sB67XBeLKlPNZKexyfkB8BHH2gV0Lpleo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCfMc96y3i0b21zhm1rlzHGyEBd93HwZ7FnhTkUzqWzTX/sJe
	S8aZYspWwV9S1v1lbFUKdz6QB8jodzuLp537dd4ksG7QNVIL9bx5dT4vZrsV52jSNNiOiDuS5OD
	oDnLkvTQk7JXuVsEK7tzcZM3bm73MjZg=
X-Gm-Gg: ASbGncuBp1gfVNpEPMwwCB+1VlCYr9sxMbBRittCVhiwY9UPXsskTnupybyWtj31X5n
	fKQYQRM7ZbY+KxWoFOqqE+5r+SttAg/xQNKfApeMuFxRPIxNJQvRr70PqwdIW+772w1dGA75IYQ
	kRQsTjSe74Liz7q7jDwAWL+NZvLQnmqnWHAQntmO8CHrzF80LHgKFEiL5OJFkjkkWW8iQIXgkgA
	qcN30qFsEttVq6grCU=
X-Google-Smtp-Source: AGHT+IGlajoodFNlAUxj3SBBz6KiuvIwKSuixFHDhY4up8xLBB9u6Pqovfv7y9tHlhYH5O4rHymbtI0KM02BdjTLmy8=
X-Received: by 2002:a05:622a:13c6:b0:4b4:2d33:3bed with SMTP id
 d75a77b69052e-4b42d333fedmr108443161cf.30.1757019500534; Thu, 04 Sep 2025
 13:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-13-joannelkoong@gmail.com> <20250903210856.GT1587915@frogsfrogsfrogs>
In-Reply-To: <20250903210856.GT1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 13:58:09 -0700
X-Gm-Features: Ac12FXxLOWvhBdadrOyqQwz4w0JgKKdk3QYJbd8zKKnqjs5Ug4b2WYfQHShwqgs
Message-ID: <CAJnrk1YQkSe10053L7O7dC9igjAHYqc3Mc5W4hGPFf=x377_zQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/16] iomap: add iomap_read_ops for read and readahead
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:08=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, Aug 29, 2025 at 04:56:23PM -0700, Joanne Koong wrote:
> > Add a "struct iomap_read_ops" that contains a read_folio_range()
> > callback that callers can provide as a custom handler for reading in a
> > folio range, if the caller does not wish to issue bio read requests
> > (which otherwise is the default behavior). read_folio_range() may read
> > the request asynchronously or synchronously. The caller is responsible
> > for calling iomap_start_folio_read()/iomap_finish_folio_read() when
> > reading the folio range.
> >
> > This makes it so that non-block based filesystems may use iomap for
> > reads.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  .../filesystems/iomap/operations.rst          | 19 +++++
> >  block/fops.c                                  |  4 +-
> >  fs/erofs/data.c                               |  4 +-
> >  fs/gfs2/aops.c                                |  4 +-
> >  fs/iomap/buffered-io.c                        | 79 +++++++++++++------
> >  fs/xfs/xfs_aops.c                             |  4 +-
> >  fs/zonefs/file.c                              |  4 +-
> >  include/linux/iomap.h                         | 21 ++++-
> >  8 files changed, 105 insertions(+), 34 deletions(-)
> >
> > diff --git a/Documentation/filesystems/iomap/operations.rst b/Documenta=
tion/filesystems/iomap/operations.rst
> > index 067ed8e14ef3..215053f0779d 100644
> > --- a/Documentation/filesystems/iomap/operations.rst
> > +++ b/Documentation/filesystems/iomap/operations.rst
> > @@ -57,6 +57,25 @@ The following address space operations can be wrappe=
d easily:
> >   * ``bmap``
> >   * ``swap_activate``
> >
> > +``struct iomap_read_ops``
> > +--------------------------
> > +
> > +.. code-block:: c
> > +
> > + struct iomap_read_ops {
> > +     int (*read_folio_range)(const struct iomap_iter *iter,
> > +                        struct folio *folio, loff_t pos, size_t len);
> > + };
> > +
> > +iomap calls these functions:
> > +
> > +  - ``read_folio_range``: Called to read in the range (read does not n=
eed to
> > +    be synchronous). The caller is responsible for calling
>
> Er... does this perform the read synchronously or asynchronously?
> Does the implementer need to know?  How does iomap figure out what
> happened?

It is up to the implementer whether they do the read synchronously or
asynchronously. Most filesystems I think will issue readahead
asynchronously but for fuse, readahead needs to be synchronous unless
the server explicitly opts into async read, otherwise the read
requests can be sent in non-sequential order which some servers may
not be able to handle.

I don't think it matters from the iomap side whether the read is
synchronous or asynchronous, or even if the read has completed by the
time iomap_readahead() completes. I think it only needs to make sure
the reads get kicked off.

>
> My guess is that iomap_finish_folio_read unlocks the folio, and anyone
> who cared is by this point already waiting on the folio lock?  So it's
> actually not important if the ->read_folio_range implementation runs
> async or not; the key is that the folio stays locked until we've
> completed the read IO?

This is my understanding too. The unlocking and
waking-any-waiting-threads stuff happens in folio_end_read().

>
> > +    iomap_start_folio_read() and iomap_finish_folio_read() when readin=
g the
> > +    folio range. This should be done even if an error is encountered d=
uring
> > +    the read. If this function is not provided by the caller, then iom=
ap
> > +    will default to issuing asynchronous bio read requests.
>
> What is this function supposed to return?  The usual 0 or negative
> errno?

Good point, I will add that info in.

>
> > +
> >  ``struct iomap_write_ops``
> >  --------------------------
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 5d153c6b16b6..06f2c857de64 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -335,8 +335,8 @@ void iomap_start_folio_read(struct folio *folio, si=
ze_t len)
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_start_folio_read);
> >
> > -void iomap_finish_folio_read(struct folio *folio, size_t off, size_t l=
en,
> > -             int error)
> > +static void __iomap_finish_folio_read(struct folio *folio, size_t off,
> > +             size_t len, int error, bool update_bitmap)
> >  {
> >       struct iomap_folio_state *ifs =3D folio->private;
> >       bool uptodate =3D !error;
> > @@ -346,7 +346,7 @@ void iomap_finish_folio_read(struct folio *folio, s=
ize_t off, size_t len,
> >               unsigned long flags;
> >
> >               spin_lock_irqsave(&ifs->state_lock, flags);
> > -             if (!error)
> > +             if (!error && update_bitmap)
> >                       uptodate =3D ifs_set_range_uptodate(folio, ifs, o=
ff, len);
>
> When do we /not/ want to set uptodate after a successful read?  I guess
> iomap_read_folio_range_async goes through the bio machinery and sets
> uptodate via iomap_finish_folio_read()?  Does the ->read_folio_range
> function need to set the uptodate bits itself?  Possibly by calling
> iomap_finish_folio_read as well?
>

Maybe this is hacky but I'm not sure if there's a better way to do it,
but I essentially need a "bias" for read requests if they are async so
that we don't prematurely end the read on the folio if the first few
async requests are completed before the next ones are issued. For
example if there's a large folio and a readahead request for 16 pages
in that folio, if doing readahead on the 16 pages is split into 4
async requests and the first request is sent off and then completed
before we send off the second request, then the
"iomap_finish_folio_read()" call on the first request will set
ifs->read_bytes_pending to now 0 and call folio_end_read().

For that reason, I added a "__iomap_start_folio_read(folio, ..., 1);"
before any async requests are sent and a
"__iomap_finish_folio_read(folio, ..., 1);" after all the requests
have been sent. (This is the same thing the iomap writeback logic does
for their async requests). Those calls though should not update the
uptodate bitmap, they are used only to prevent the premature
folio_end_read().

Yes, ->read_folio_range() is responsible for calling
iomap_finish_folio_read() (as well as iomap_start_folio_read()); this
call will update the uptodate bitmap.


Thanks,
Joanne

> >               ifs->read_bytes_pending -=3D len;
> >               finished =3D !ifs->read_bytes_pending;
> > @@ -356,6 +356,12 @@ void iomap_finish_folio_read(struct folio *folio, =
size_t off, size_t len,
> >       if (finished)
> >               folio_end_read(folio, uptodate);
> >  }
> > +
> > @@ -471,7 +478,14 @@ static int iomap_readfolio_iter(struct iomap_iter =
*iter,
> >       }
> >
> >       /* zero post-eof blocks as the page may be mapped */
> > -     ifs_alloc(iter->inode, folio, iter->flags);
> > +     ifs =3D ifs_alloc(iter->inode, folio, iter->flags);
> > +
> > +     /*
> > +      * Add a bias to ifs->read_bytes_pending so that a read is ended =
only
> > +      * after all the ranges have been read in.
> > +      */
> > +     if (ifs)
> > +             iomap_start_folio_read(folio, 1);
> >
> >       length =3D min_t(loff_t, length,
> >                       folio_size(folio) - offset_in_folio(folio, pos));
> > @@ -479,35 +493,53 @@ static int iomap_readfolio_iter(struct iomap_iter=
 *iter,
> >               iomap_adjust_read_range(iter->inode, folio, &pos,
> >                               length, &poff, &plen);
> >               count =3D pos - iter->pos + plen;
> > -             if (plen =3D=3D 0)
> > -                     return iomap_iter_advance(iter, &count);
> > +             if (plen =3D=3D 0) {
> > +                     ret =3D iomap_iter_advance(iter, &count);
> > +                     break;
> > +             }
> >
> >               if (iomap_block_needs_zeroing(iter, pos)) {
> >                       folio_zero_range(folio, poff, plen);
> >                       iomap_set_range_uptodate(folio, poff, plen);
> >               } else {
> > -                     iomap_read_folio_range_async(iter, ctx, pos, plen=
);
> > +                     ctx->folio_unlocked =3D true;
> > +                     if (read_ops && read_ops->read_folio_range) {
> > +                             ret =3D read_ops->read_folio_range(iter, =
folio, pos, plen);
> > +                             if (ret)
> > +                                     break;
> > +                     } else {
> > +                             iomap_read_folio_range_async(iter, ctx, p=
os, plen);
> > +                     }
> >               }
> >
> >               length -=3D count;
> >               ret =3D iomap_iter_advance(iter, &count);
> >               if (ret)
> > -                     return ret;
> > +                     break;
> >               pos =3D iter->pos;
> >       }
> > -     return 0;
> > +
> > +     if (ifs) {
> > +             __iomap_finish_folio_read(folio, 0, 1, ret, false);
> > +             ctx->folio_unlocked =3D true;
>
> Er.... so we subtract 1 from read_bytes_pending?  I thought the
> ->read_folio_range ioend was supposed to decrease that?
>
> --D
>

