Return-Path: <linux-fsdevel+bounces-51072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A4AD2924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 00:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05131892C08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB5881E;
	Mon,  9 Jun 2025 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDBq84N7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103119ABB6;
	Mon,  9 Jun 2025 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749506599; cv=none; b=p18NlCWBUBwU4RGIQT0ouySzhIjMFZvhFfxfjZr2dvUYRvXCU+Z1wYUGArNeZAa7f5LEXYRbqU6hyapbz5yccG+FPcGU9J/cWNtZeXGlma2qbVzqzLtWMYH0CDGC53DrUe9TH/qw+QDRJVjIsuPCa7aSJ3wrgImTsgPfhq4Y7AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749506599; c=relaxed/simple;
	bh=kTcWcsUXPZ3DSMWXmiteAytPm7rFqw/8OGkYl0vK46w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEjEeAMriObqBEwu58ZJ0Bl42Bzv04xFFZ/5Cs2LBgEcKkVYHiKW1VXaWWdyUHMHyYM4vmZU0agSFUKbfPe0ckwG8pPquLz9broeinxyeKIgJGsTt4sx6IVVBxNu+hCOKZalCqjXTSSTebtJPkC/W96AfKTGU7UpjO27FhHA8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDBq84N7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a6f6d52af7so21839261cf.1;
        Mon, 09 Jun 2025 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749506596; x=1750111396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImDU677/IDBFdNubvQNS2UqChpmFPmPumpZBCbbmVWI=;
        b=XDBq84N7SbMR6yRn2taWGw6lqmrGx2n+1TafEb/JZy6lmH/clmtz2SaVEun5BYjvtW
         ZgAEqO7wBhWt/tv5Gd6t0SZuXUOpTsWCQC1oiK8OWDvXB3rYwObpD8XZHHIK5kdG1bKY
         S+YpZQSoT5K8r5ZAYiXNjwPXa4N5KBH+PrVThGfSczp3cwKw6Jc7yBpr4h+TJX2Fh6yJ
         zit+jsqaVlozPknhFI5TAb2h1krACwk/kZTVF/PKGPbKsumkp0He5duIVyQaSOlFkyQl
         onMm5EbyMBl5JW6kE5LpwJ3JgQkCcKkJ+fpfQ68+QkjEyzNeLdJ9PhGCrl3LtUZG7Bfj
         EgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749506596; x=1750111396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImDU677/IDBFdNubvQNS2UqChpmFPmPumpZBCbbmVWI=;
        b=KlNW0kCKJ9Kc2Aa7kiO00M5XrOtUln3iXbLkAb/Y8cWWdPua5yiVzmkVEn67jEsjpq
         J7s7BssO7dNATQ2HZTxTfXBWLz3SgU8T/sUALu2URlTtBJljGaOh4fHJB55Owls3wojK
         szeOg2fht16QCa2zLtntv8PRb4hrTpZuYpwpW1LOYS8i5AcaPw9fMpgWkLd7hqegh2Hk
         NAvKZr9KGjZ9m/jSX97s0WoPVC4aRVIo1dxfzeQD+gNUt2zeJ2Tf55bJAxSKb/5XPcRO
         M5XwJa0ajetntSHFms3JnfEMsaNOeLJ3o1zPCN2Vme0yB2ByvdDyPMv9Quhg7KGvr7N0
         dxWA==
X-Forwarded-Encrypted: i=1; AJvYcCW7MHW93mUjS8Yl33Akek2frlUo0HNJvU8ChAzbb9VKgiWdDwT/WUUBRnOuDEie4zfJEiX0lYtKEjL0FaQT@vger.kernel.org, AJvYcCXK2xAq20B6W/bjAsZlBgwnMnRN0nAStB2WEeNwWdrOfaMghAYi0S3/6UyUlN/kZwyfFobjmrXukR/5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Xlm81PNOext/X4rFiMUqjFldSnzBSMQVbH7joqpJjav3rlzi
	dfpRCiM7+xtl2NDIU8H6OpCJ3Qu/rCUySCPaFYA2gQR/VblM/WTbZyK3HcE8ycdo9G3M1h4xGU+
	FwxfR6N5CWS27Z2IEq37ph97bj7ZRsmo=
X-Gm-Gg: ASbGncs+JKMG+pjQ1ApGFu7CpZX01T7OA2pNJ5Zi+h5jma4Z2u+80mECm4+6R/7rOHf
	+IO+zRrjfI0NRIlt1OO2RRJpE8avWKfaH26aruyI2llsc5EMaWuXhHn4alNuUDK8GLti7kq+26+
	RQ+PZK9X1TBSxxQca4URvhp/8B41Rc3n5D6vP9BGzYLUE=
X-Google-Smtp-Source: AGHT+IFO5wiKwK/MpvYjPwsbbBMu0KrqzWyqadX+VRYVfSsVpBJL+gSTdInx+srgNfgyC9snSXYM1FOMAH9Fw/hVoaU=
X-Received: by 2002:a05:622a:5c1a:b0:4a4:327f:1d0d with SMTP id
 d75a77b69052e-4a5b9d4edfamr244584011cf.30.1749506596125; Mon, 09 Jun 2025
 15:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-4-joannelkoong@gmail.com> <20250609163840.GJ6156@frogsfrogsfrogs>
In-Reply-To: <20250609163840.GJ6156@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 15:03:05 -0700
X-Gm-Features: AX0GCFuLHQWkyInOdd3IqZsh67f8pVAbuqgIB29NxrW5V6iJQ_6jH1MO0Ub4xx8
Message-ID: <CAJnrk1ZVBNWjKmxc_pAXdJ1NEiCQm0Mpdy8eSjzkY1c05k+WxQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] iomap: add buffered write support for IOMAP_IN_MEM iomaps
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 9:38=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, Jun 06, 2025 at 04:37:58PM -0700, Joanne Koong wrote:
> > Add buffered write support for IOMAP_IN_MEM iomaps. This lets
> > IOMAP_IN_MEM iomaps use some of the internal features in iomaps
> > such as granular dirty tracking for large folios.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 24 +++++++++++++++++-------
> >  include/linux/iomap.h  | 10 ++++++++++
> >  2 files changed, 27 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 1caeb4921035..fd2ea1306d88 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -300,7 +300,7 @@ static inline bool iomap_block_needs_zeroing(const =
struct iomap_iter *iter,
> >  {
> >       const struct iomap *srcmap =3D iomap_iter_srcmap(iter);
> >
> > -     return srcmap->type !=3D IOMAP_MAPPED ||
> > +     return (srcmap->type !=3D IOMAP_MAPPED && srcmap->type !=3D IOMAP=
_IN_MEM) ||
> >               (srcmap->flags & IOMAP_F_NEW) ||
> >               pos >=3D i_size_read(iter->inode);
> >  }
> > @@ -583,16 +583,26 @@ iomap_write_failed(struct inode *inode, loff_t po=
s, unsigned len)
> >                                        pos + len - 1);
> >  }
> >
> > -static int iomap_read_folio_sync(loff_t block_start, struct folio *fol=
io,
> > -             size_t poff, size_t plen, const struct iomap *iomap)
> > +static int iomap_read_folio_sync(const struct iomap_iter *iter, loff_t=
 block_start,
> > +                              struct folio *folio, size_t poff, size_t=
 plen)
> >  {
> > -     return iomap_bio_read_folio_sync(block_start, folio, poff, plen, =
iomap);
> > +     const struct iomap_folio_ops *folio_ops =3D iter->iomap.folio_ops=
;
> > +     const struct iomap *srcmap =3D iomap_iter_srcmap(iter);
> > +
> > +     if (folio_ops && folio_ops->read_folio_sync)
> > +             return folio_ops->read_folio_sync(block_start, folio,
> > +                                               poff, plen, srcmap,
> > +                                               iter->private);
>
> Hmm, patch 6 hooks this up to fuse_do_readfolio, which means that iomap
> provides the folios and manages their uptodate/dirty state.  You still
> want fuse to handle the folio contents (aka poke the fuse server via
> FUSE_READ/FUSE_WRITE), but this avoids the memcpy that IOMAP_INLINE
> performs.
>
> So I think you're effectively addding another IO path to buffered-io.c,
> which explains why you moved the bio code to a separate file.  I wonder

The bio code needed to be moved to its own separate file because it
depends on CONFIG_BLOCK whereas fuse should still compile/run even if
CONFIG_BLOCK is not set.

Btw, I think you will need this too for your fuse server iomap patchset.

> if you could hook up this new IO path by checking for a non-NULL
> ->read_folio_sync function and calling it regardless of iomap::type?

I think this is already doing that? It will call ->read_folio_sync()
if the callback was provided, regardless of what the iomap type is.

>
> --D
>
> > +
> > +     /* IOMAP_IN_MEM iomaps must always handle ->read_folio_sync() */
> > +     WARN_ON_ONCE(iter->iomap.type =3D=3D IOMAP_IN_MEM);
> > +
> > +     return iomap_bio_read_folio_sync(block_start, folio, poff, plen, =
srcmap);
> >  }
> >
> >  static int __iomap_write_begin(const struct iomap_iter *iter, loff_t p=
os,
> >               size_t len, struct folio *folio)
> >  {
> > -     const struct iomap *srcmap =3D iomap_iter_srcmap(iter);
> >       struct iomap_folio_state *ifs;
> >       loff_t block_size =3D i_blocksize(iter->inode);
> >       loff_t block_start =3D round_down(pos, block_size);
> > @@ -640,8 +650,8 @@ static int __iomap_write_begin(const struct iomap_i=
ter *iter, loff_t pos,
> >                       if (iter->flags & IOMAP_NOWAIT)
> >                               return -EAGAIN;
> >
> > -                     status =3D iomap_read_folio_sync(block_start, fol=
io,
> > -                                     poff, plen, srcmap);
> > +                     status =3D iomap_read_folio_sync(iter, block_star=
t, folio,
> > +                                                    poff, plen);
> >                       if (status)
> >                               return status;
> >               }
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index dbbf217eb03f..e748aeebe1a5 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -175,6 +175,16 @@ struct iomap_folio_ops {
> >        * locked by the iomap code.
> >        */
> >       bool (*iomap_valid)(struct inode *inode, const struct iomap *ioma=
p);
> > +
> > +     /*
> > +      * Required for IOMAP_IN_MEM iomaps. Otherwise optional if the ca=
ller
> > +      * wishes to handle reading in a folio.
> > +      *
> > +      * The read must be done synchronously.
> > +      */
> > +     int (*read_folio_sync)(loff_t block_start, struct folio *folio,
> > +                            size_t off, size_t len, const struct iomap=
 *iomap,
> > +                            void *private);
> >  };
> >
> >  /*
> > --
> > 2.47.1
> >
> >

