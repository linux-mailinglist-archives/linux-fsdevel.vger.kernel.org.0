Return-Path: <linux-fsdevel+bounces-51395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6BAD664E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2A63AD498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345221DED64;
	Thu, 12 Jun 2025 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebft0rEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C481D8DFB;
	Thu, 12 Jun 2025 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700482; cv=none; b=q7nIkAEL3OESaTK5zVeTZMldSY083ut6CEG160V2b4Af6Rl/UHgqsLzXnwnckac8kkQ6el7jh+tifaY8BCjxzypOQkQ2+DdCmbEi3BpQZinW/ek4isg7w2ErUbqPCapdPauipWeoxqJDgBQWOmSOtBOPeEjVcsxoP4+qyqm/JS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700482; c=relaxed/simple;
	bh=TYK836nLZHmvabsVBnFAo2JgtCjMYEIhusN4X3nfM3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIOanL03r/CLy7X723K52Yk4/FLvhmNsgdJQMT7X4biI7JHSJEkC+oB/v8OFAzDpHOZEDO1Qyi+vXEpYLjgVGcP6tRbpvCwlCV42+Lcalo/TGjj5S21yXn4NSIphENXgJmq6n5M+mlRPaOxY7qQe6wXvhISJ/FUwnMbj238PcxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebft0rEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB2CC4CEEA;
	Thu, 12 Jun 2025 03:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749700481;
	bh=TYK836nLZHmvabsVBnFAo2JgtCjMYEIhusN4X3nfM3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ebft0rEjLkGP5McYHcGqtDF2W9PHmd/W9TdFJExDNiynCzg+YC7Q6NkNueNP7afKE
	 es+W5mvhYKF1aooggF424hy7r+gLbCoZ7xUDKZOGslS1rG4+cgoKg/5WtRPPLBcha1
	 9xOz1IrM87Q/YAxwhXY38chVqhF8PL/DZ6FCkiYwdS1usZiB9/8L5FI8Cwwe4uZU8I
	 KNv+NB3bWoP2bvQZVICTs039XhijYZfjTIRPxeRqwIIb2IG6s1PiOwFNrJz34/qaEf
	 Z4bTB0galhs/GTv/0mU0lLsPM4w2l7d5n1mG1wBawn0hMMfTWPpdCJr8WD5sJ99L4F
	 D/LaSNlC1OqDg==
Date: Wed, 11 Jun 2025 20:54:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 3/8] iomap: add buffered write support for
 IOMAP_IN_MEM iomaps
Message-ID: <20250612035441.GI6138@frogsfrogsfrogs>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-4-joannelkoong@gmail.com>
 <20250609163840.GJ6156@frogsfrogsfrogs>
 <CAJnrk1ZVBNWjKmxc_pAXdJ1NEiCQm0Mpdy8eSjzkY1c05k+WxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZVBNWjKmxc_pAXdJ1NEiCQm0Mpdy8eSjzkY1c05k+WxQ@mail.gmail.com>

On Mon, Jun 09, 2025 at 03:03:05PM -0700, Joanne Koong wrote:
> On Mon, Jun 9, 2025 at 9:38 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Jun 06, 2025 at 04:37:58PM -0700, Joanne Koong wrote:
> > > Add buffered write support for IOMAP_IN_MEM iomaps. This lets
> > > IOMAP_IN_MEM iomaps use some of the internal features in iomaps
> > > such as granular dirty tracking for large folios.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 24 +++++++++++++++++-------
> > >  include/linux/iomap.h  | 10 ++++++++++
> > >  2 files changed, 27 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 1caeb4921035..fd2ea1306d88 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -300,7 +300,7 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
> > >  {
> > >       const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > >
> > > -     return srcmap->type != IOMAP_MAPPED ||
> > > +     return (srcmap->type != IOMAP_MAPPED && srcmap->type != IOMAP_IN_MEM) ||
> > >               (srcmap->flags & IOMAP_F_NEW) ||
> > >               pos >= i_size_read(iter->inode);
> > >  }
> > > @@ -583,16 +583,26 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
> > >                                        pos + len - 1);
> > >  }
> > >
> > > -static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
> > > -             size_t poff, size_t plen, const struct iomap *iomap)
> > > +static int iomap_read_folio_sync(const struct iomap_iter *iter, loff_t block_start,
> > > +                              struct folio *folio, size_t poff, size_t plen)
> > >  {
> > > -     return iomap_bio_read_folio_sync(block_start, folio, poff, plen, iomap);
> > > +     const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
> > > +     const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > > +
> > > +     if (folio_ops && folio_ops->read_folio_sync)
> > > +             return folio_ops->read_folio_sync(block_start, folio,
> > > +                                               poff, plen, srcmap,
> > > +                                               iter->private);
> >
> > Hmm, patch 6 hooks this up to fuse_do_readfolio, which means that iomap
> > provides the folios and manages their uptodate/dirty state.  You still
> > want fuse to handle the folio contents (aka poke the fuse server via
> > FUSE_READ/FUSE_WRITE), but this avoids the memcpy that IOMAP_INLINE
> > performs.
> >
> > So I think you're effectively addding another IO path to buffered-io.c,
> > which explains why you moved the bio code to a separate file.  I wonder
> 
> The bio code needed to be moved to its own separate file because it
> depends on CONFIG_BLOCK whereas fuse should still compile/run even if
> CONFIG_BLOCK is not set.
> 
> Btw, I think you will need this too for your fuse server iomap patchset.

Yeah, I added it, thank you. :)

> > if you could hook up this new IO path by checking for a non-NULL
> > ->read_folio_sync function and calling it regardless of iomap::type?
> 
> I think this is already doing that? It will call ->read_folio_sync()
> if the callback was provided, regardless of what the iomap type is.

Err, yes it does, my bad.

--D

> >
> > --D
> >
> > > +
> > > +     /* IOMAP_IN_MEM iomaps must always handle ->read_folio_sync() */
> > > +     WARN_ON_ONCE(iter->iomap.type == IOMAP_IN_MEM);
> > > +
> > > +     return iomap_bio_read_folio_sync(block_start, folio, poff, plen, srcmap);
> > >  }
> > >
> > >  static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> > >               size_t len, struct folio *folio)
> > >  {
> > > -     const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > >       struct iomap_folio_state *ifs;
> > >       loff_t block_size = i_blocksize(iter->inode);
> > >       loff_t block_start = round_down(pos, block_size);
> > > @@ -640,8 +650,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> > >                       if (iter->flags & IOMAP_NOWAIT)
> > >                               return -EAGAIN;
> > >
> > > -                     status = iomap_read_folio_sync(block_start, folio,
> > > -                                     poff, plen, srcmap);
> > > +                     status = iomap_read_folio_sync(iter, block_start, folio,
> > > +                                                    poff, plen);
> > >                       if (status)
> > >                               return status;
> > >               }
> > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > > index dbbf217eb03f..e748aeebe1a5 100644
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -175,6 +175,16 @@ struct iomap_folio_ops {
> > >        * locked by the iomap code.
> > >        */
> > >       bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> > > +
> > > +     /*
> > > +      * Required for IOMAP_IN_MEM iomaps. Otherwise optional if the caller
> > > +      * wishes to handle reading in a folio.
> > > +      *
> > > +      * The read must be done synchronously.
> > > +      */
> > > +     int (*read_folio_sync)(loff_t block_start, struct folio *folio,
> > > +                            size_t off, size_t len, const struct iomap *iomap,
> > > +                            void *private);
> > >  };
> > >
> > >  /*
> > > --
> > > 2.47.1
> > >
> > >
> 

