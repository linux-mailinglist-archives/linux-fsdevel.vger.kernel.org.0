Return-Path: <linux-fsdevel+bounces-51354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42233AD5E89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298AD18987BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF04D26B2C5;
	Wed, 11 Jun 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko8UhCBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A222C355;
	Wed, 11 Jun 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667840; cv=none; b=HSnECJH4sDNanDigo2AQt/J9JbjG00LdxymnfLjXSwSvA6Waen9adLGSII9+AL1FlZJSEKV41itw+Hwvfz5wdiroaE1E8jT4tHLmDXuICgLVB3+kWPZ0g5WBZX8n6Wp4y60+doHsycCZmC1QxHJP5AoIs3Of5oJUT/1X/kHn9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667840; c=relaxed/simple;
	bh=K+VqBRIOI16KDT8vzgF0nS+BSfGDTIdxEkzKRZkWcK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs4fzTNsBpNiN5xZE0OKlEMHqNWV3pvi1J1uL+4YlOYkYgyuFsB9gh2pQvCkJxqlNUmJwYcO2guMdmrRnoLIAOS1qK34A3kRQKMBTEbdunFZM/EuDNlQ7jZ2s/S0TcV15fDwSQeEGeHDI/57vgIiYVK3QYZLH2+AhGYHprn4pWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko8UhCBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DFBC4CEF4;
	Wed, 11 Jun 2025 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749667840;
	bh=K+VqBRIOI16KDT8vzgF0nS+BSfGDTIdxEkzKRZkWcK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ko8UhCBdGvb0YAAkBYkL7Y05eXJStJxSF8pECQvKRoxcEEluvYLB41xv8mzNT8/TC
	 UQdoiAgER56JiMp5N9QaK9w7JqgPlGaLwIDcFNJIjHZkmLq7ac/911jbsVSGNPG4g7
	 zgRDgIJdnIXZN9t9++F0yHX9Ouy9BW4j7u95mhJNU6qCpzgGdNnY8XxxFYDWJLBzPC
	 7tBTGj9Kmqc0WSWvoSvK+isewahpAUyYViZyC9WJMCEuylxuNZxi9Lj0KvXrgmB0mn
	 ryGpN+pfV583K3e+DgeNJiEYpxWptSHdPuer9X+na91OZtRI0yoYhkHq4XO+HQ5mEQ
	 1x3U57UBQF0nQ==
Date: Wed, 11 Jun 2025 11:50:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Message-ID: <20250611185039.GI6179@frogsfrogsfrogs>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com>
 <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org>
 <aEgyu86jWSz0Gpia@infradead.org>
 <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com>
 <aEkARG3yyWSYcOu6@infradead.org>
 <CAJnrk1b8edbe8svuZXLtvWBnsNhY14hBCXhoqNXdHM6=df6YAg@mail.gmail.com>
 <CAJnrk1au_grkFx=GT-DmbqFE4FmXhyG1qOr0moXXpg8BuBdp1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1au_grkFx=GT-DmbqFE4FmXhyG1qOr0moXXpg8BuBdp1A@mail.gmail.com>

On Wed, Jun 11, 2025 at 11:33:40AM -0700, Joanne Koong wrote:
> On Tue, Jun 10, 2025 at 11:00 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Tue, Jun 10, 2025 at 9:04 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, Jun 10, 2025 at 01:13:09PM -0700, Joanne Koong wrote:
> > >
> > > > For fuse at least, we definitely want granular reads, since reads may
> > > > be extremely expensive (eg it may be a network fetch) and there's
> > > > non-trivial mempcy overhead incurred with fuse needing to memcpy read
> > > > buffer data from userspace back to the kernel.
> > >
> > > Ok, with that the plain ->read_folio variant is not going to fly.
> > >
> > > > > +               folio_lock(folio);
> > > > > +               if (unlikely(folio->mapping != inode->i_mapping))
> > > > > +                       return 1;
> > > > > +               if (unlikely(!iomap_validate(iter)))
> > > > > +                       return 1;
> > > >
> > > > Does this now basically mean that every caller that uses iomap for
> > > > writes will have to implement ->iomap_valid and up the sequence
> > > > counter anytime there's a write or truncate, in case the folio changes
> > > > during the lock drop? Or were we already supposed to be doing this?
> > >
> > > Not any more than before.  It's is still option, but you still
> > > very much want it to protect against races updating the mapping.
> > >
> > Okay thanks, I think I'll need to add this in for fuse then. I'll look
> > at this some more
> 
> I read some of the thread in [1] and I don't think fuse needs this
> after all. The iomap mapping won't be changing state and concurrent
> writes are already protected by the file lock (if we don't use the
> plain ->read_folio variant).
> 
> [1] https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

<nod> If the mapping types don't change between read/write (which take
i_rwsem in exclusive mode) and writeback (which doesn't take it at all)
then I don't think there's a need to revalidate the mapping after
grabbing a folio.  I think the other ways to avoid those races are (a)
avoid unaligned zeroing if you can guarantee that the folios are always
fully uptodate; and (b) don't do things that change the out-of-place
write status of pagecache (e.g. reflink).

--D

