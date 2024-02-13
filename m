Return-Path: <linux-fsdevel+bounces-11436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB3853D26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D4F1F28D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51F61677;
	Tue, 13 Feb 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw2vRvgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B902612DF;
	Tue, 13 Feb 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859757; cv=none; b=RttSJUzCbFAjxmVTbTCU6bgZWSa39n5lNh0SDVJENWYMQGUAHPqymHblpoKeMes4QBYPrkFesO/vr0CVjaN/9hpWTjmhxzkq2KcGd02N8HA6qEJOmW22BNAcbzMWCK/ukRBhzkkuMVdVdBJ1vQ756DnRL0a4mO7h/Edycn4UIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859757; c=relaxed/simple;
	bh=QClImjY1lYcfORamVxbILEkRAbA7o0MUEXBX6cK6mdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQsXjNqaaZUzpj7twwKtnWTIWNjp4vW43wEnmq45drMFTIusEt/mXUnxvqDAdiyd5DTCb25ehbmKErBJfyEM4qtcK2AihmRIqeldoD6ishEhHqGdcz0nhyO7iNKBJ1QfR4KHNwPK92RfP3Cs5NLiAHasGgh7us4W2zB7llq2rSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw2vRvgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDE0C433F1;
	Tue, 13 Feb 2024 21:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707859756;
	bh=QClImjY1lYcfORamVxbILEkRAbA7o0MUEXBX6cK6mdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tw2vRvgvBGoL0Ybzyb89j9Y1Lm4agG8oAyI/KLsbv3TRTZOvVBQCjGbNELkZdSC19
	 gpRw2yOJELK7gbM82zJ28/vuizg6p0Zt9gme8w7eEhoH7nYgW/dakZeWvM8k7VT6Ka
	 QXLqI2SttC5f+otkU1PkmVz4crUdpqcBV7kDsO08/S2/g2bl7Nlqi0hwW5N9KvDJXR
	 3neoJi0i0g2NpSg+CqOuCk3yP+mCS7T4u/skbEPqkj86JzM1y9POHMvvzgp7/gzkjm
	 pYxrrB1WQDGmyO6My01WjdOh2FATKOWemRL0m/T4587jN1wLfe9HXOcRtS0GFiW2EO
	 Mr2rUD9JKmtMw==
Date: Tue, 13 Feb 2024 13:29:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 01/14] fs: Allow fine-grained control of folio sizes
Message-ID: <20240213212914.GW616564@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-2-kernel@pankajraghav.com>
 <20240213163431.GS6184@frogsfrogsfrogs>
 <xy45wh2y55oinrvkhea36yxtnqmsoikp7eawaa2b5ejivfv4ku@ob72fvbkj4uh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xy45wh2y55oinrvkhea36yxtnqmsoikp7eawaa2b5ejivfv4ku@ob72fvbkj4uh>

On Tue, Feb 13, 2024 at 10:05:54PM +0100, Pankaj Raghav (Samsung) wrote:
> On Tue, Feb 13, 2024 at 08:34:31AM -0800, Darrick J. Wong wrote:
> > On Tue, Feb 13, 2024 at 10:37:00AM +0100, Pankaj Raghav (Samsung) wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Some filesystems want to be able to limit the maximum size of folios,
> > > and some want to be able to ensure that folios are at least a certain
> > > size.  Add mapping_set_folio_orders() to allow this level of control.
> > > The max folio order parameter is ignored and it is always set to
> > > MAX_PAGECACHE_ORDER.
> > 
> > Why?  If MAX_PAGECACHE_ORDER is 8 and I instead pass in max==3, I'm
> > going to be surprised by my constraint being ignored.  Maybe I said that
> > because I'm not prepared to handle an order-7 folio; or some customer
> > will have some weird desire to twist this knob to make their workflow
> > faster.
> > 
> > --D
> Maybe I should have been explicit. We are planning to add support
> for min order in the first round, and we want to add support for max order
> once the min order support is upstreamed. It was done mainly to reduce
> the scope and testing of this series.
> 
> I definitely agree there are usecases for setting the max order. It is
> also the feedback we got from LPC.
> 
> So one idea would be not to expose max option until we add the support
> for max order? So filesystems can only set the min_order with the
> initial support?

Yeah, there's really no point in having an argument that's deliberately
ignored.

--D

> > > +static inline void mapping_set_folio_orders(struct address_space *mapping,
> > > +					    unsigned int min, unsigned int max)
> > > +{
> > > +	if (min == 1)
> > > +		min = 2;
> > > +	if (max < min)
> > > +		max = min;
> > > +	if (max > MAX_PAGECACHE_ORDER)
> > > +		max = MAX_PAGECACHE_ORDER;
> > > +
> > > +	/*
> > > +	 * XXX: max is ignored as only minimum folio order is supported
> > > +	 * currently.
> > > +	 */
> > > +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> > > +			 (min << AS_FOLIO_ORDER_MIN) |
> > > +			 (MAX_PAGECACHE_ORDER << AS_FOLIO_ORDER_MAX);
> > > +}
> > > +
> 

