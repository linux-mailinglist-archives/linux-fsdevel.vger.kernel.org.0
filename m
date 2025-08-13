Return-Path: <linux-fsdevel+bounces-57611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A9B23D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 03:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0C71AA7E25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81317A318;
	Wed, 13 Aug 2025 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K89fM2Ar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2254C2D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755047430; cv=none; b=NICc/H59pbth6NvvWCnP882WoG0ISXNniqZGFSnn7uxUoOzl4P2X1iwWJ2F3f46H9NjUMf1ialtwSVbhDGGyvFZiS65KuuHirXlGi4OfXILTOv+9WQ1l0gN5NbrlydqtbSIkCC3q6wJEK613ubd2KXlMniOnGJD5b0yHxSdI+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755047430; c=relaxed/simple;
	bh=2Gcm9XguGHC5/KT75cZd8Hc/dn8RHFyExWbQidCaADM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osZruyLzAMEtFGLlLWpQDSPy7RKbXe49C7Zr+Fn9D2srfGoq4+rL/CnZ3GVJTO2CWDng48N04KYMGhW99GBCTbMZKjFbV2Swbl5CH+lVFqtdSJ2omqXaNsIV/wgm0ly95fMX2UijT8eouPk1TGldW/Jb2XWTYV133JswmXEsXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K89fM2Ar; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0c5d57713so47163221cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755047428; x=1755652228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW+62l2Rgy8wolVJ0jri6hTl1M6VmlbjpXer86yqLTI=;
        b=K89fM2Arp6vQofWJ66lj2dWiNV4LtfKNT5I4hxHp9eopQVMBZTU8bx58oWhA4ZmMZQ
         OWXe69bhy/O1rrVYygCpvbMYz7Tkx/oLsZhY/cyRiVOw2TMhq94a8NCTR9ADi5/IXKjq
         y2hw/r88wim1Fj6vTfMVM7jlxpa6z2o7f6W6QZ2oyUbIm+eaoDSzBE7D1d5GVVOXMhHs
         huCjPeMS7TcZGg/x/DYXaUxM/ShSvPXSCiCDGxNMBwVRNhZuadLb8TwDgoFbwP9NTNJm
         1rmAknit55NG0ma4/s7YohybA8bH5vi6deDDmsB/KQrHPOh9OfTp6gR75LhaTmFMKc4g
         tyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755047428; x=1755652228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW+62l2Rgy8wolVJ0jri6hTl1M6VmlbjpXer86yqLTI=;
        b=Dk3iPU5bKOcCuFr43crvoba+rko+uhhtldENJ/6EmW0ijwZXHVmSgLRYYKRvF6bhXw
         Olcx5eziSQssaLozfw8n4oYTfxwZLsiNkWmgOVYXu3Jyt8Bj7GcV8tc42qxqYMD9afe7
         lYBbCYqtKc+fLIWk2BVC9Vovghy+23+yiStRujjx66ViDGplQ/6OcI7aCZA9ifdAVlVX
         PQOEcQgYqn0iX+bT4ij66Hn2VHH67kXTFtMYdtA6uF2UK5P1hCqMvMftUunbhc/dBz82
         xrzVEFyevpmLzD02zibYY47+hH2nMVx8T0sGZpUWlvNKOaQGNEwjuutg/eggEcYTSoDM
         dlRA==
X-Forwarded-Encrypted: i=1; AJvYcCU47G2nT46NPAYH1kPMpJ2L6wI+ldo7fF8cBQ7gMS4TrUJ4iMA2kqIiAcZqaSVXh/LNSyvGH9hn6Sq56ngD@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6ybpGcCbJw2Rwzmsy7veJvZ7pjsMb9lFG0akWZw6QiM0bsY5
	RKnSSJeFXMJ/r2sjShqvcPXycmqAP+XZzqGvdfllR4hQhThWKjZOUdiDT21ujSGSys/Sgut2u2D
	cAYIfhSzmrlowQY+isrovYG0FVWthA/w=
X-Gm-Gg: ASbGncvX1VoIDJ07K8KV3iuNmfS8tG4UCVt4mfBPOTSqPGG9wJ1gdcSKNJ9IJcYFwZ8
	G0vJ5PrwkH74P3W0mcziAqpabjuxGTxGsWZp3w6DGILaayjq2VZYGc13Bs6QYScgSxl8PPdZU3L
	uNSmD8uII4lb2b1f4yko4itvvedQoiABNTvACCXVEmurqReNoafv0nGpzUcr6h+cFpBM6XBlC+q
	+t3pPob
X-Google-Smtp-Source: AGHT+IFsdqfj/tAhAllAZAhX+cwUB7Y+BgDDNMcuWhkHOqKdtmIjYTjo0ovZF5HAGl2+tPycP4YoTLIGOYSPd5AVXg0=
X-Received: by 2002:ac8:7e96:0:b0:4b0:89c2:68d9 with SMTP id
 d75a77b69052e-4b0fc87a0ddmr12489431cf.36.1755047427575; Tue, 12 Aug 2025
 18:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-11-joannelkoong@gmail.com> <aJr4D9ec7XG92G--@infradead.org>
In-Reply-To: <aJr4D9ec7XG92G--@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 Aug 2025 18:10:15 -0700
X-Gm-Features: Ac12FXzjpx1VHBeMLwDllX4JQ9W149cx9RY1gnKEqe31VXNLal5My-OjbEmgX9M
Message-ID: <CAJnrk1aLAPqpZZJ9TLBhceVQ2-ZzDGY8qv5_bX2rt5XA5T9QTA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/10] iomap: add granular dirty and writeback accounting
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, jack@suse.cz, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 1:15=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
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
>
> This adds more sizse to the folio state.  Shouldn't this be the same
> as
>
>     DIV_ROUND_UP(write_bytes_pending, PAGE_SIZE)
>
> anyway?

I don't think we can use write_bytes_pending because writeback for a
folio may be split into multiple requests (eg for fuse, if the ranges
are not contiguous) and each request when it finishes will call
iomap_finish_folio_write() which will decrement write_bytes_pending,
but when the last folio writeback request has finished and we call
folio_end_writeback_pages(), we would need the original value of
write_bytes_pending before any of the decrements. write_bytes_pending
gets decremented since it gets used as a refcount.

I need to look more into whether readahead/read_folio and writeback
run concurrently or not but if not, maybe read_bytes_pending and
write_bytes_pending could be consolidated together.

>
> > +     unsigned end_blk =3D min((unsigned)(i_size_read(inode) >> inode->=
i_blkbits),
> > +                             i_blocks_per_folio(inode, folio));
>
> Overly long line.  Also not sure why the cast is needed to start with?

The cast is needed to avoid the compiler error of comparing a loff_t
with an unsigned int. I see there's a min_t helper, I'll use that
instead then.

>
> > +     unsigned nblks =3D 0;
> > +
> > +     while (start_blk < end_blk) {
> > +             if (ifs_block_is_dirty(folio, ifs, start_blk))
> > +                     nblks++;
> > +             start_blk++;
> > +     }
>
> We have this pattern open coded in a few places.  Maybe factor it into a
> helper first?  And then maybe someone smart can actually make it use
> find_first_bit/find_next_bit.
>
> > +static bool iomap_granular_dirty_pages(struct folio *folio)
> > +{
> > +     struct iomap_folio_state *ifs =3D folio->private;
> > +     struct inode *inode;
> > +     unsigned block_size;
> > +
> > +     if (!ifs)
> > +             return false;
> > +
> > +     inode =3D folio->mapping->host;
> > +     block_size =3D 1 << inode->i_blkbits;
> > +
> > +     if (block_size >=3D PAGE_SIZE) {
> > +             WARN_ON(block_size & (PAGE_SIZE - 1));
> > +             return true;
> > +     }
> > +     return false;
>
> Do we need the WARN_ON?  Both the block and page size must be powers
> of two, so I can't see how it would trigger.  Also this can use the
> i_blocksize helper.

I'll get rid of the WARN_ON and will incorporate your i_blocksize
helper suggestion.

>
> I.e. just turn this into:
>
>         return i_blocksize(folio->mapping->host) >=3D PAGE_SIZE;
>
>
> > +static bool iomap_dirty_folio_range(struct address_space *mapping, str=
uct folio *folio,
>
> Overly long line.

I'll fix up the long lines in the patchset, sorry.

>
> > +     wpc->wbc->no_stats_accounting =3D true;
>
> Who does the writeback accounting now?  Maybe throw in a comment if
> iomap is now doing something different than all the other writeback
> code.

iomap does the writeback accounting now, which happens in
iomap_update_dirty_stats(). I'll add a comment about that.


Thanks,
Joanne
>

