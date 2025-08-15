Return-Path: <linux-fsdevel+bounces-58051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3155B285E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 20:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2716B03700
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64721ADA3;
	Fri, 15 Aug 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMvw3aAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F146317700
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283141; cv=none; b=Saq1B0We7ZmbGLRL8vtSMJjVU/ekC6QGbY7BaZnfWUqFAkwnW7q/SmEUpGHita00u2AFIrnQ3ozYun29Iim0XmhraI31kZ89Pd0MMnMRo21hlIFi8BoB3xeZ/ayY+bs5rrzazbMGB6OLkJHrYwIMyDCiJhLrt+YJ7U0MEYfL7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283141; c=relaxed/simple;
	bh=It5+QM8kG5DohK+1iWvc26VCUiqDT/BnBIea94o6R68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rbcl+Uo28yFJoP4Dioo9nc5JtCpsmPSD9riBNatyUfjRH75h5mueilup2P7lpBmz7m20l1BNV9kisrjd4xdqvHbE4DoQS6oxh5I5gw5pshCwcbbRjcIHV9WxdLjvSMx4PMQKiwL1YWayEaoOIiAGd6zeDBdhXxKxa4fsC3ljKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMvw3aAI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e87063d4a9so246862385a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 11:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755283138; x=1755887938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwAXxLY8fmeaxd9qf43Lujd9rKXNUCEjbpzfTeqryII=;
        b=lMvw3aAI45o2/93HEU7h2jI56n8s2qiTsWcyD7iZiyPrdbBsB0hI+kmiICjpVP/vV4
         Y4g9Mr///pBBndBHkz76Dradfm1jc8LLSYjA/bksf8iAIxCuBJXc0qxXf4+HjkXjRNTE
         idzsedRSoU5G161N+pkKdBDAH5z9jIySyisynQer9ERVVs49dwDpVUrqkuz/sPExLKdu
         PbLhFoP51pQ9SJ9t1JQJvJq2iqFj6N0iz+LtYrYU/mhzpauK+6/28N/WwyntC5KREgOs
         SXdSSzcBQrsrhQU5AlhgDqyI0UyOCXM6wallxdeNdM9W7RbyvZVppIt6J8w43dB9A34w
         FwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755283138; x=1755887938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwAXxLY8fmeaxd9qf43Lujd9rKXNUCEjbpzfTeqryII=;
        b=q5PrnsObye4ElyyCnH6wrdzhHSNS5EZajHXQG5I0pkM1k9JDcCjGUTj6GPcYckH75L
         QGU29QRjQl0zKEe9m3Kkkf0e5JQMmWvsvanLhIRXn6vqSQN6Q4cAIru+xbQ0D+EvppRu
         6ZSce1ZYQCvewHjvJv5EkqUBLdpvohf/UR34ozqXtYg195eHXSmNh2d9RqInygEfGnx+
         fcs32LInyaDR6KMS/0ZvArzB9GpQlVpDL9vubGlppL+tbh+BcqmOzm7BuI7DWlf51ISY
         HCJX7HVhHVgZX+PeLqMRcHzCuvbuDxVhrBECtcpsxZ3512YSk6rzEpW0dsSMiNCE00Ao
         jmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtT8t3jq8TQlRuASAO8Nx6tnHBIgtJd5gGBV1nGg1msMW1G64F8fI+mgOjwkF4J9L0sMHZdd/4oAlxLEbP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72+XwDkhkMdVZEj+G0cs6tohbldN/10yg3KLvOPjy+4RpTvYu
	hombOafMzgRIoM2qELIsT2OejrYbjx0BiCFpSBYKvyv6MXXjFiFPZVi9UKh5c8wLoEA48VIB1ds
	n2FQ1l211KpwXZbfKNw5azEiQnvasMIiC8Q==
X-Gm-Gg: ASbGnctkvvfE6K6Sj+rBVF6NNWSMyl9WZ67Tb8Nz7VQVts1YVOMjJm4QLH54a0uUEAA
	HhrDJMd70dci92dghT+ihqytBBQusVkAKQ7MTQ+JlcjHeLWeQnQEBYLkWJDO3PQEEucsGoeBzaT
	cwRLZ+GBL7tqFTOTy1xXKyJcFepocSDSvLWeuoyXGID7ZOy3DeI04X61crgPQT9ZL8rND2r554e
	PQdplFP5dJMyF2vN50=
X-Google-Smtp-Source: AGHT+IHAt0ffkvixYLAAK0FiNUs86CcOS9oLiN5NW1g96oBVK+g09pmJiV8fpiJsad3IIH0IGQiC2NqX99u235i4n5Q=
X-Received: by 2002:a05:620a:1a04:b0:7d4:3bcc:85bf with SMTP id
 af79cd13be357-7e87dfd75a9mr459325585a.12.1755283138288; Fri, 15 Aug 2025
 11:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-11-joannelkoong@gmail.com> <20250814163759.GN7942@frogsfrogsfrogs>
In-Reply-To: <20250814163759.GN7942@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 Aug 2025 11:38:47 -0700
X-Gm-Features: Ac12FXwgNSzjLd-7pzv2yGDIlw23znYURkdMbkX30pg1fVeN2kx5bS6G8eV5ecM
Message-ID: <CAJnrk1a0vBqcbwDGnhr2A-H26Jr=0WauX7A2VLU9wvtV3UtpDQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/10] iomap: add granular dirty and writeback accounting
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, jack@suse.cz, 
	hch@infradead.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:38=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Jul 31, 2025 at 05:21:31PM -0700, Joanne Koong wrote:
> > Add granular dirty and writeback accounting for large folios. These
> > stats are used by the mm layer for dirty balancing and throttling.
> > Having granular dirty and writeback accounting helps prevent
> > over-aggressive balancing and throttling.
> >
> > There are 4 places in iomap this commit affects:
> > a) filemap dirtying, which now calls filemap_dirty_folio_pages()
> > b) writeback_iter with setting the wbc->no_stats_accounting bit and
> > calling clear_dirty_for_io_stats()
> > c) starting writeback, which now calls __folio_start_writeback()
> > d) ending writeback, which now calls folio_end_writeback_pages()
> >
> > This relies on using the ifs->state dirty bitmap to track dirty pages i=
n
> > the folio. As such, this can only be utilized on filesystems where the
> > block size >=3D PAGE_SIZE.
>
> Apologies for my slow responses this month. :)

No worries at all, thanks for looking at this.
>
> I wonder, does this cause an observable change in the writeback
> accounting and throttling behavior for non-fuse filesystems like XFS
> that use large folios?  I *think* this does actually reduce throttling
> for XFS, but it might not be so noticeable because the limits are much
> more generous outside of fuse?

I haven't run any benchmarks on non-fuse filesystems yet but that's
what I would expect too. Will run some benchmarks to see!

>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 136 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 128 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index bcc6e0e5334e..626c3c8399cc 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -20,6 +20,8 @@ struct iomap_folio_state {
> >       spinlock_t              state_lock;
> >       unsigned int            read_bytes_pending;
> >       atomic_t                write_bytes_pending;
> > +     /* number of pages being currently written back */
> > +     unsigned                nr_pages_writeback;
> >
> >       /*
> >        * Each block has two bits in this bitmap:
> > @@ -81,6 +83,25 @@ static inline bool ifs_block_is_dirty(struct folio *=
folio,
> >       return test_bit(block + blks_per_folio, ifs->state);
> >  }
> >
> > +static unsigned ifs_count_dirty_pages(struct folio *folio)
> > +{
> > +     struct iomap_folio_state *ifs =3D folio->private;
> > +     struct inode *inode =3D folio->mapping->host;
> > +     unsigned block_size =3D 1 << inode->i_blkbits;
> > +     unsigned start_blk =3D 0;
> > +     unsigned end_blk =3D min((unsigned)(i_size_read(inode) >> inode->=
i_blkbits),
> > +                             i_blocks_per_folio(inode, folio));
> > +     unsigned nblks =3D 0;
> > +
> > +     while (start_blk < end_blk) {
> > +             if (ifs_block_is_dirty(folio, ifs, start_blk))
> > +                     nblks++;
> > +             start_blk++;
> > +     }
>
> Hmm, isn't this bitmap_weight(ifs->state, blks_per_folio) ?
>
> Ohh wait no, the dirty bitmap doesn't start on a byte boundary because
> the format of the bitmap is [uptodate bits][dirty bits].
>
> Maybe those two should be reversed, because I bet the dirty state gets
> changed a lot more over the lifetime of a folio than the uptodate bits.

I think there's the find_next_bit() helper (which Christoph also
pointed out) that could probably be used here instead. Or at least
that's how I see a lot of the driver code doing it for their bitmaps.

