Return-Path: <linux-fsdevel+bounces-12984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4411869C86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1BC1F26D81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE454F8D;
	Tue, 27 Feb 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4qGhESs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68F4D9EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052043; cv=none; b=Oacdgk+l9xZXGxk0QEPjRvcbITF6f3d/kknIOVB4rYM2Grpf+x8TeH4ob9f9xQTvF/ARM8ShMm7kdwMd4iUVVxfs73v/hX9UxLR21Jda9+BKkzD+H8M548+P/uODVgNGn0n5F26JdwzlsnNVh12dMGZU98gCegWeYmkG1Qu6C+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052043; c=relaxed/simple;
	bh=LtrvC/N0rfcL2CqzKBp3j0kchpUkmXiOTnFS6av9DPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1IuGqM6Jqr78wQO2/IqDLlLols4n8P/FCBqYyFNlHVUGWX7TAmbFQs8JDbBlr/kpzVsz1PprDjVHpKBFIPWJx1nl9Ektkm5M9yAq+wr3lat0wgK7Sw/8GEn2Pz2FtCmyF8D0driFckcfe1JV2eudNWn3/bJvOp7zJftctTDTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4qGhESs; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 11:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709052039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqGMBKnYn/QrgVfOj0WWSs+uvU9TA5U1Pary0hbDu00=;
	b=a4qGhESssTTzkGy2+Uv8q68Vlj6IlrykUhxoBIAvTJM1VVVGTJgMVAIvAgMGDyCrD17PZ3
	SnDSmItEjgCBn17FFW6zlPCGYFYiqFXkHtZHwRIqHObSXHImtjWI+9KJfk65F0kG9GsO9m
	40Ndv+7sDZ+0dc14Pp0geccOEWac0cQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, david@fromorbit.com, 
	chandan.babu@oracle.com, akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, 
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 03/13] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <vsy43j4pwgh4thcqbhmotap7rgzg5dnet42gd5z6x4yt3zwnu4@5w4ousyue36m>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-4-kernel@pankajraghav.com>
 <Zdyi6lFDAHXi8GPz@casper.infradead.org>
 <37kubwweih4zwvxzvjbhnhxunrafawdqaqggzcw6xayd6vtrfl@dllnk6n53akf>
 <hjrsbb34ghop4qbb6owmg3wqkxu4l42yrekshwfleeqattscqp@z2epeibc67lt>
 <aajarho6xwi4sphqirwvukofvqy3cl6llpe5fetomj5sz7rgzp@xo2iqdwingtf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aajarho6xwi4sphqirwvukofvqy3cl6llpe5fetomj5sz7rgzp@xo2iqdwingtf>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 05:36:09PM +0100, Pankaj Raghav (Samsung) wrote:
> On Tue, Feb 27, 2024 at 11:22:24AM -0500, Kent Overstreet wrote:
> > On Tue, Feb 27, 2024 at 11:06:37AM +0100, Pankaj Raghav (Samsung) wrote:
> > > On Mon, Feb 26, 2024 at 02:40:42PM +0000, Matthew Wilcox wrote:
> > > > On Mon, Feb 26, 2024 at 10:49:26AM +0100, Pankaj Raghav (Samsung) wrote:
> > > > > From: Luis Chamberlain <mcgrof@kernel.org>
> > > > > 
> > > > > Supporting mapping_min_order implies that we guarantee each folio in the
> > > > > page cache has at least an order of mapping_min_order. So when adding new
> > > > > folios to the page cache we must ensure the index used is aligned to the
> > > > > mapping_min_order as the page cache requires the index to be aligned to
> > > > > the order of the folio.
> > > > 
> > > > This seems like a remarkably complicated way of achieving:
> > > > 
> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index 5603ced05fb7..36105dad4440 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -2427,9 +2427,11 @@ static int filemap_update_page(struct kiocb *iocb,
> > > >  }
> > > >  
> > > >  static int filemap_create_folio(struct file *file,
> > > > -		struct address_space *mapping, pgoff_t index,
> > > > +		struct address_space *mapping, loff_t pos,
> > > >  		struct folio_batch *fbatch)
> > > >  {
> > > > +	pgoff_t index;
> > > > +	unsigned int min_order;
> > > >  	struct folio *folio;
> > > >  	int error;
> > > >  
> > > > @@ -2451,6 +2453,8 @@ static int filemap_create_folio(struct file *file,
> > > >  	 * well to keep locking rules simple.
> > > >  	 */
> > > >  	filemap_invalidate_lock_shared(mapping);
> > > > +	min_order = mapping_min_folio_order(mapping);
> > > > +	index = (pos >> (min_order + PAGE_SHIFT)) << min_order;
> > > 
> > > That is some cool mathfu. I will add a comment here as it might not be
> > > that obvious to some people (i.e me).
> > 
> > you guys are both wrong, just use rounddown()
> 
> Umm, what do you mean just use rounddown? rounddown to ...?
> 
> We need to get index that are in PAGE units but aligned to min_order
> pages.
> 
> The original patch did this:
> 
> index = mapping_align_start_index(mapping, iocb->ki_pos >> PAGE_SHIFT);
> 
> Which is essentially a rounddown operation (probably this is what you
> are suggesting?).
> 
> So what willy is proposing will do the same. To me, what I proposed is
> less complicated but to willy it is the other way around.

Ok, I just found the code for mapping_align_start_index() - it is just a
round_down().

Never mind; patch looks fine (aside from perhaps some quibbling over
whether the round_down()) should be done before calling readahead or
within readahead; I think that might have been more what willy was
keying in on)

