Return-Path: <linux-fsdevel+bounces-34097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05C9C263D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 21:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8CBB232A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E16A1C1F3C;
	Fri,  8 Nov 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="stc3xRhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3C1C1F3A;
	Fri,  8 Nov 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096464; cv=none; b=iciRJfpaLuR1ycedJCjGJSqKH95hpWRooRFwlPLNtG+01Qhl/WRL6MPqyTj/4G8qD+BclUQj2SogvlBNdh5rY5fWQ6UoL+asScbUMFhemPicOqQ1f7ywxdKcKVWkWvGwR6uHxhX9jJuLczq3W/HMFTq/Px4XC+sTVNjv4eg+q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096464; c=relaxed/simple;
	bh=1g76rPSHhw49jhg8w9vWpOWVtMb+UwWrzottr4RHgMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4mWtvPrk5b2LUQgLPIgV0+z6CbdYutOdwpjZtlkAVN7To+g7TkVP1C8HOoJ7rJa/RfFKUyb54Gm/AMloWHrQW/Eu+iIaz5qTJ6dzPGaU30O49OunFZkLq8VybHTrhQKhjiyVFN7JAqImIN8PeLoLKYFp3OaanCHR1KiuVECTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=stc3xRhy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8EOlj3DHLk9ACbQvSOs+ZQpxrIbjKWEhntEJ6z86Fj0=; b=stc3xRhyQhi1TpmnLA+jqBh38V
	pDyrpuFXoPhaJdggDuwE+XqldhFLq9Tic2JHw2PcaJUcPTieRLPCEPS0i4Is2Pib6OrmA3JIze3Nr
	s/ONYx+Z2NgZA9upkXhJf7fElxf8+QGR/PILe9oiK+s9nxU49UHlDfchxvV0iC8d4dUT5MSZwHKr8
	iI3mGYrAypWHvzIoGcgTs2q2oD/CXXEEkD9+Wcjj1KYXRCI+sJEbHPczCHJqZ2bI1doU0J61F28jq
	Is4gzfb1Roh52LnxsTEnVFz5ncmwcyalRXZP+Yo9R4P7O8/zwFuymynhSs+DqanvqbuYsvTkJJcWu
	FKxp232g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VGe-00000009GQk-02b6;
	Fri, 08 Nov 2024 20:07:40 +0000
Date: Fri, 8 Nov 2024 20:07:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] iomap: make buffered writes work with RWF_UNCACHED
Message-ID: <Zy5vi-L6Vsn-seRZ@casper.infradead.org>
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-12-axboe@kernel.dk>
 <Zy5cmQyCE8AgjPbQ@casper.infradead.org>
 <45ac1a3c-7198-4f5b-b6e3-c980c425f944@kernel.dk>
 <30f5066a-0d3a-425f-a336-16a2af330473@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f5066a-0d3a-425f-a336-16a2af330473@kernel.dk>

On Fri, Nov 08, 2024 at 12:49:58PM -0700, Jens Axboe wrote:
> On 11/8/24 12:26 PM, Jens Axboe wrote:
> > On 11/8/24 11:46 AM, Matthew Wilcox wrote:
> >> On Fri, Nov 08, 2024 at 10:43:34AM -0700, Jens Axboe wrote:
> >>> +++ b/fs/iomap/buffered-io.c
> >>> @@ -959,6 +959,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >>>  		}
> >>>  		if (iter->iomap.flags & IOMAP_F_STALE)
> >>>  			break;
> >>> +		if (iter->flags & IOMAP_UNCACHED)
> >>> +			folio_set_uncached(folio);
> >>
> >> This seems like it'd convert an existing page cache folio into being
> >> uncached?  Is this just leftover from a previous version or is that a
> >> design decision you made?
> > 
> > I'll see if we can improve that. Currently both the read and write side
> > do drop whatever it touches. We could feasibly just have it drop
> > newly instantiated pages - iow, uncached just won't create new persistent
> > folios, but it'll happily use the ones that are there already.
> 
> Well that was nonsense on the read side, it deliberately only prunes
> entries that has uncached set. For the write side, this is a bit
> trickier. We'd essentially need to know if the folio populated by
> write_begin was found in the page cache, or create from new. Any way we
> can do that? One way is to change ->write_begin() so it takes a kiocb
> rather than a file, but that's an amount of churn I'd rather avoid!
> Maybe there's a way I'm just not seeing?

Umm.  We can solve it for iomap with a new FGP_UNCACHED flag and
checking IOMAP_UNCACHED in iomap_get_folio().  Not sure how we solve it
for other filesystems though.  Any filesystem which uses FGP_NOWAIT has
_a_ solution, but eg btrfs will need to plumb through a third boolean
flag (or, more efficiently, just start passing FGP flags to
prepare_one_folio()).

