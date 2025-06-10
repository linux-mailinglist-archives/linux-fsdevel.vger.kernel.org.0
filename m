Return-Path: <linux-fsdevel+bounces-51190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C59AD4392
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FCA77AA724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06786265CD0;
	Tue, 10 Jun 2025 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdT7eYp5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7B264A86;
	Tue, 10 Jun 2025 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586403; cv=none; b=iLkJN+DU2cyOaFOCO0+IP/+h712SQ2FKIM7UQWbtHf3UlWWyV5Lxtml0RA/c2ljqF0pgOpCLuzqe6B/mwh/C+pMZhsBORHQGf/q/QRZJufhQON7HGwYwcbi39RAPChUdMoQPAcH/t/etBKd0DsDpQXnJbH8qlajT07W2xgiPtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586403; c=relaxed/simple;
	bh=ug4o0OQD3U8aYTZtojZkULRawLsX9EcF3pSxkfdpWJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTRFGtDZkYJv3YWZdrrOvrJ2hPSUUcM++WWC7iWRiUhXPIDyRwfOe7mgQ5u7Wpa6reWdSHNbqTibn9DL5Rf877giAYkNVHWyNtIYaxh28YKr4cwFP/BDzSDBb09B0Pu1wYNrhPjbuB34tO5RN+cMODlqw0qKLe+iQu1eF5WXTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdT7eYp5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a58f79d6e9so64423831cf.2;
        Tue, 10 Jun 2025 13:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749586400; x=1750191200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv1K8V0qXemtRgHGyIxXsEyWV3R8o02H0eJFKiYINSo=;
        b=SdT7eYp5glsUulbH05NuMdA9IDOpqkIBB+zfINbioqwq3JkN2ZBG1UjuibFNOXDZIq
         wvUpdUp1VKQ6uIuW3fX3fBLu2jmMN1SxviFV4AWuDf3sRd/GnLiSB16fys9h6EHrJ4Mc
         egUAQRdLlHJxV8t2PUZb4c6jSzeLWUaojDB09hZa+nvjPICCqocG6kwSccMc3X70D0sp
         mLUdgjqECpU7LBw+Z/0ET0oYmX1sZ+rogENHxNmY4VKGbs5/x39b45e0AzZ1riw87EeI
         P6wnkouceyI4nD/7VstpIe9rHynkTIfoy9QzKbJ6zWk2TLNkOnO/iNt4Ls4lwuFIUiFx
         9Usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749586400; x=1750191200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rv1K8V0qXemtRgHGyIxXsEyWV3R8o02H0eJFKiYINSo=;
        b=Os//RbUX0Pxt/M8aknaRClDbQ/iYV8+VGoBPBlTTLWkrhWyecrO1ke09IAE3e42ATr
         VkAaBS6h/J5z2mLsqEeQX6Lw7jvbWYrD+yDm8L53rHwNp0Bon2x8W6B3u2sHyjchjgcm
         8YGGY7ISQUPCGZ0oZAOWVJYW9ZqMYXNWY+KghsDZNmNfdbWQ7R1otgxNtbnA4Lx0h2ob
         UoZ8z2INd0BeJCpu8gYd+ccR0h/yyNWfLnBFVu4OSfJ/Km/0en86XP6V7frNYJD/Ci6+
         TSW108knDa6TSimL2CBjemh1KFBDX7w3u9CnAcZTn9SRP8Kph0bjwVJ5gN7sdhQTq5d4
         6uPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6KOLzXqGBVa29QSiA72+jvec20sUHITR+4isE1eH0mBV1+tlWb8VC1Cd0SwBUM/N3nFJYt+K+omxM@vger.kernel.org, AJvYcCUgpYkHP4WUk+25x9OBEXjnxCZ7+gzjlTD2DW5GtoYug7kickuBZ96n3GCstytXjS10LtoweZfZZ6vi1prB@vger.kernel.org
X-Gm-Message-State: AOJu0YyjKriPtpEjM0AtDxnJ5nN/gYm4cXgBuVJg/rAaCIKV/SWcsWs9
	JsxnMpdGenbbnU3AZaPJVFoadYLCKw9m8CRDXil2i2A3Xd285q2q+GLgOoB2nFhB9ZELM9skF+j
	L1Jhd8u1+pfXhCTI1hqzth2ra3KlbXGA=
X-Gm-Gg: ASbGncsEi5FV/ZIavXdovSEr3p/dlU42CCdKQ5jaqdxB0f+n2KCuc7o/aHbbfsJpJyi
	Vt+B+wL0RjoaY147wkb/5vQqJ3WuvTNLHREYs1mUJkclfdZdBZewtZjKD3/b2DQeBg+ShHrw3FR
	rXv7aHliegZjwdQVRUob3bhRP/UXicLwPIlVlssDLewCg=
X-Google-Smtp-Source: AGHT+IEzvgszwqvoTEsN0eiIdRCJWuEdonPydD25CbluGxxroYxfnuqdZHI8ZkMdvUJ1fOY9b2Ye/spxDj0moFpa/bM=
X-Received: by 2002:a05:622a:4cc6:b0:4a4:30cf:c213 with SMTP id
 d75a77b69052e-4a713c65d3bmr10984481cf.48.1749586400340; Tue, 10 Jun 2025
 13:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com> <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org> <aEgyu86jWSz0Gpia@infradead.org>
In-Reply-To: <aEgyu86jWSz0Gpia@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Jun 2025 13:13:09 -0700
X-Gm-Features: AX0GCFvWdPTKIpdfMQoECUZje2TuIYo3X8nX0skN8nFeh8vzio8DJt9NBJBgcT0
Message-ID: <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 6:27=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> So I looked into something else, what if we just use ->read_folio
> despite it not seeming ideal initially?  After going through with
> it I think it's actually less bad than I thought.  This passes
> -g auto on xfs with 4k blocks, and has three regression with 1k
> blocks, 2 look are the seek hole testers upset that we can't
> easily create detectable sub-block holes now, and one because
> generic/563 thinks the cgroup accounting is off, probably because
> we read more data now or something like that.
>
> ---
> From c5d3cf651c815d3327199c74eac43149fc958098 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 10 Jun 2025 09:39:57 +0200
> Subject: iomap: use ->read_folio instead of iomap_read_folio_sync
>
> iomap_file_buffered_write has it's own private read path for reading
> in folios that are only partially overwritten, which not only adds
> extra code, but also extra problem when e.g. we want reads to go
> through a file system method to support checksums or RAID, or even
> support non-block based file systems.
>
> Switch to using ->read_folio instead, which has a few up- and downsides.
>
> ->read_folio always reads the entire folios and not just the start and
> the tail that is not being overwritten.  Historically this was seen as a
> downside as it reads more data than needed.  But with modern file systems
> and modern storage devices this is probably a benefit.  If the folio is
> stored contiguously on disk, the single read will be more efficient than
> two small reads on almost all current hardware. If the folio is backed by
> two blocks, at least we pipeline the two reads instead of doing two
> synchronous ones.  And if the file system fragmented the folio so badly
> that we'll now need to do more than two reads we're still at least
> pipelining it, although that should basically never happen with modern
> file systems.

If the filesystem wants granular folio reads, it can also just do that
itself by calling an iomap helper (eg what iomap_adjust_read_range()
is doing right now) in its ->read_folio() implementation, correct?

For fuse at least, we definitely want granular reads, since reads may
be extremely expensive (eg it may be a network fetch) and there's
non-trivial mempcy overhead incurred with fuse needing to memcpy read
buffer data from userspace back to the kernel.

>
> ->read_folio unlocks the folio on completion.  This adds extract atomics
> to the write fast path, but the actual signaling by doing a lock_page
> after ->read_folio is not any slower than the completion wakeup.  We
> just have to recheck the mapping in this case do lock out truncates
> and other mapping manipulations.
>
> ->read_folio starts another, nested, iomap iteration, with an extra
> lookup of the extent at the current file position.  For in-place update
> file systems this is extra work, although if they use a good data
> structure like the xfs iext btree there is very little overhead in
> another lookup.  For file system that write out of place this actually
> implements the desired semantics as they don't care about the existing
> data for the write iteration at all, although untangling this and
> removing the srcmap member in the iomap_iter will require additional
> work to turn the block zeroing and unshare helpers upside down.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 116 ++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 71 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..52b4040208dd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -667,30 +667,34 @@ iomap_write_failed(struct inode *inode, loff_t pos,=
 unsigned len)
>                                          pos + len - 1);
>  }
>
> -static int iomap_read_folio_sync(loff_t block_start, struct folio *folio=
,
> -               size_t poff, size_t plen, const struct iomap *iomap)
> +/*
> + * Now that we have a locked folio, check that the iomap we have cached =
is not
> + * stale before we do anything.
> + *
> + * The extent mapping can change due to concurrent IO in flight, e.g. th=
e
> + * IOMAP_UNWRITTEN state can change and memory reclaim could have reclai=
med a
> + * previously partially written page at this index after IO completion b=
efore
> + * this write reaches this file offset, and hence we could do the wrong =
thing
> + * here (zero a page range incorrectly or fail to zero) and corrupt data=
.
> + */
> +static bool iomap_validate(struct iomap_iter *iter)
>  {
> -       struct bio_vec bvec;
> -       struct bio bio;
> +       const struct iomap_folio_ops *folio_ops =3D iter->iomap.folio_ops=
;
>
> -       bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
> -       bio.bi_iter.bi_sector =3D iomap_sector(iomap, block_start);
> -       bio_add_folio_nofail(&bio, folio, plen, poff);
> -       return submit_bio_wait(&bio);
> +       if (folio_ops && folio_ops->iomap_valid &&
> +           !folio_ops->iomap_valid(iter->inode, &iter->iomap)) {
> +               iter->iomap.flags |=3D IOMAP_F_STALE;
> +               return false;
> +       }
> +
> +       return true;
>  }
>
> -static int __iomap_write_begin(const struct iomap_iter *iter, size_t len=
,
> +static int __iomap_write_begin(struct iomap_iter *iter, size_t len,
>                 struct folio *folio)
>  {
> -       const struct iomap *srcmap =3D iomap_iter_srcmap(iter);
> +       struct inode *inode =3D iter->inode;
>         struct iomap_folio_state *ifs;
> -       loff_t pos =3D iter->pos;
> -       loff_t block_size =3D i_blocksize(iter->inode);
> -       loff_t block_start =3D round_down(pos, block_size);
> -       loff_t block_end =3D round_up(pos + len, block_size);
> -       unsigned int nr_blocks =3D i_blocks_per_folio(iter->inode, folio)=
;
> -       size_t from =3D offset_in_folio(folio, pos), to =3D from + len;
> -       size_t poff, plen;
>
>         /*
>          * If the write or zeroing completely overlaps the current folio,=
 then
> @@ -699,45 +703,29 @@ static int __iomap_write_begin(const struct iomap_i=
ter *iter, size_t len,
>          * For the unshare case, we must read in the ondisk contents beca=
use we
>          * are not changing pagecache contents.
>          */
> -       if (!(iter->flags & IOMAP_UNSHARE) && pos <=3D folio_pos(folio) &=
&
> -           pos + len >=3D folio_pos(folio) + folio_size(folio))
> +       if (!(iter->flags & IOMAP_UNSHARE) &&
> +           iter->pos <=3D folio_pos(folio) &&
> +           iter->pos + len >=3D folio_pos(folio) + folio_size(folio))
>                 return 0;
>
> -       ifs =3D ifs_alloc(iter->inode, folio, iter->flags);
> -       if ((iter->flags & IOMAP_NOWAIT) && !ifs && nr_blocks > 1)
> +       ifs =3D ifs_alloc(inode, folio, iter->flags);
> +       if ((iter->flags & IOMAP_NOWAIT) && !ifs &&
> +           i_blocks_per_folio(inode, folio) > 1)
>                 return -EAGAIN;
>
> -       if (folio_test_uptodate(folio))
> -               return 0;
> -
> -       do {
> -               iomap_adjust_read_range(iter->inode, folio, &block_start,
> -                               block_end - block_start, &poff, &plen);
> -               if (plen =3D=3D 0)
> -                       break;
> +       if (!folio_test_uptodate(folio)) {
> +               inode->i_mapping->a_ops->read_folio(NULL, folio);
>
> -               if (!(iter->flags & IOMAP_UNSHARE) &&
> -                   (from <=3D poff || from >=3D poff + plen) &&
> -                   (to <=3D poff || to >=3D poff + plen))
> -                       continue;
> -
> -               if (iomap_block_needs_zeroing(iter, block_start)) {
> -                       if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
> -                               return -EIO;
> -                       folio_zero_segments(folio, poff, from, to, poff +=
 plen);
> -               } else {
> -                       int status;
> -
> -                       if (iter->flags & IOMAP_NOWAIT)
> -                               return -EAGAIN;
> -
> -                       status =3D iomap_read_folio_sync(block_start, fol=
io,
> -                                       poff, plen, srcmap);
> -                       if (status)
> -                               return status;
> -               }
> -               iomap_set_range_uptodate(folio, poff, plen);
> -       } while ((block_start +=3D plen) < block_end);
> +               /*
> +                * ->read_folio unlocks the folio.  Relock and revalidate=
 the
> +                * folio.
> +                */
> +               folio_lock(folio);
> +               if (unlikely(folio->mapping !=3D inode->i_mapping))
> +                       return 1;
> +               if (unlikely(!iomap_validate(iter)))
> +                       return 1;

Does this now basically mean that every caller that uses iomap for
writes will have to implement ->iomap_valid and up the sequence
counter anytime there's a write or truncate, in case the folio changes
during the lock drop? Or were we already supposed to be doing this?

> +       }
>
>         return 0;
>  }
> @@ -803,7 +791,6 @@ static int iomap_write_begin_inline(const struct ioma=
p_iter *iter,
>  static int iomap_write_begin(struct iomap_iter *iter, struct folio **fol=
iop,
>                 size_t *poffset, u64 *plen)
>  {
> -       const struct iomap_folio_ops *folio_ops =3D iter->iomap.folio_ops=
;
>         const struct iomap *srcmap =3D iomap_iter_srcmap(iter);
>         loff_t pos =3D iter->pos;
>         u64 len =3D min_t(u64, SIZE_MAX, iomap_length(iter));
> @@ -818,28 +805,14 @@ static int iomap_write_begin(struct iomap_iter *ite=
r, struct folio **foliop,
>         if (fatal_signal_pending(current))
>                 return -EINTR;
>
> +lookup_again:
>         folio =3D __iomap_get_folio(iter, len);
>         if (IS_ERR(folio))
>                 return PTR_ERR(folio);
>
> -       /*
> -        * Now we have a locked folio, before we do anything with it we n=
eed to
> -        * check that the iomap we have cached is not stale. The inode ex=
tent
> -        * mapping can change due to concurrent IO in flight (e.g.
> -        * IOMAP_UNWRITTEN state can change and memory reclaim could have
> -        * reclaimed a previously partially written page at this index af=
ter IO
> -        * completion before this write reaches this file offset) and hen=
ce we
> -        * could do the wrong thing here (zero a page range incorrectly o=
r fail
> -        * to zero) and corrupt data.
> -        */
> -       if (folio_ops && folio_ops->iomap_valid) {
> -               bool iomap_valid =3D folio_ops->iomap_valid(iter->inode,
> -                                                        &iter->iomap);
> -               if (!iomap_valid) {
> -                       iter->iomap.flags |=3D IOMAP_F_STALE;
> -                       status =3D 0;
> -                       goto out_unlock;
> -               }
> +       if (unlikely(!iomap_validate(iter))) {
> +               status =3D 0;
> +               goto out_unlock;
>         }
>
>         pos =3D iomap_trim_folio_range(iter, folio, poffset, &len);
> @@ -860,7 +833,8 @@ static int iomap_write_begin(struct iomap_iter *iter,=
 struct folio **foliop,
>
>  out_unlock:
>         __iomap_put_folio(iter, 0, folio);
> -
> +       if (status =3D=3D 1)
> +               goto lookup_again;
>         return status;
>  }
>
> --
> 2.47.2
>

