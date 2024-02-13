Return-Path: <linux-fsdevel+bounces-11432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626C853CE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11934286BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D384A43;
	Tue, 13 Feb 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZG4QS4o8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFD839ED;
	Tue, 13 Feb 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858365; cv=none; b=XlUYMtpRJOd+/6HgZ+WbNankB8F0lbNbe80B0f7GUgNuCfaXsD7Tm+6mSsLYrsVul/YtSIB4lCNdcz3qIZTOWuKMpjg5deCHqVKZP7oR8X9qrOGRVHO566MC2l1hbW/9cJ5OekbZTRi7eb+pb8dM0FFlYBzHIj8LMGcDcjCMwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858365; c=relaxed/simple;
	bh=xgl7lHB5nFNYdQ9gjvd365a6aa0rerNmO4jYedWe+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpTp32o6ttj7XBlYO8yCtjjnIPNHnsSWQ9oil+x1B0zu3Vf9f0IQCPoqSZojd7tPh7BvqkRXst4N1lSLgCX8HX0Aw+jpkRqBkD3XqEAG9ENTgcjRm02a1P9P7Novz1OVmrHw+gkaxsGgzw5x4c3Yd6hLEooA2TsIgy8sZ5kjAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZG4QS4o8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TZDPy5hp7z9smr;
	Tue, 13 Feb 2024 22:05:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707858358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlGuEk+lrsb7TKIHP84bbBdxjJkSQOe0GzEds4VJ6uo=;
	b=ZG4QS4o883VynvBzMh26WK5TOHr+yNiz10QE3/MYTdpyJpXlNQqm8MlMY0oqBHmrcxR/U2
	gfSusG0OqEUHDp90Y/iktmMcvIgx+9GuKg3P8OnIkbBbRqYxmqNVWUGmQPBpBRo7pEPsbc
	Sb5QjfDMhZl9fIaTZ+Hzjf+/pfS1LjAo1I5rwJoG+hiMoXlZ6pSsNWnTA9aPQSObgodAZc
	9W+bG8TtxtZ7w7jkMVvPfgCf/ESTLeAZeTcG9cKXaFMzmCdY8V1XBUK7bXjvvz/SZt8KyJ
	wFB462Hdk6dO/xWQLnJgY8R/EtL3P+irS0UR8Nyp/iBAViXjWL92ymaGxC5zzQ==
Date: Tue, 13 Feb 2024 22:05:54 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org, 
	david@fromorbit.com
Subject: Re: [RFC v2 01/14] fs: Allow fine-grained control of folio sizes
Message-ID: <xy45wh2y55oinrvkhea36yxtnqmsoikp7eawaa2b5ejivfv4ku@ob72fvbkj4uh>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-2-kernel@pankajraghav.com>
 <20240213163431.GS6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213163431.GS6184@frogsfrogsfrogs>

On Tue, Feb 13, 2024 at 08:34:31AM -0800, Darrick J. Wong wrote:
> On Tue, Feb 13, 2024 at 10:37:00AM +0100, Pankaj Raghav (Samsung) wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Some filesystems want to be able to limit the maximum size of folios,
> > and some want to be able to ensure that folios are at least a certain
> > size.  Add mapping_set_folio_orders() to allow this level of control.
> > The max folio order parameter is ignored and it is always set to
> > MAX_PAGECACHE_ORDER.
> 
> Why?  If MAX_PAGECACHE_ORDER is 8 and I instead pass in max==3, I'm
> going to be surprised by my constraint being ignored.  Maybe I said that
> because I'm not prepared to handle an order-7 folio; or some customer
> will have some weird desire to twist this knob to make their workflow
> faster.
> 
> --D
Maybe I should have been explicit. We are planning to add support
for min order in the first round, and we want to add support for max order
once the min order support is upstreamed. It was done mainly to reduce
the scope and testing of this series.

I definitely agree there are usecases for setting the max order. It is
also the feedback we got from LPC.

So one idea would be not to expose max option until we add the support
for max order? So filesystems can only set the min_order with the
initial support?

> > +static inline void mapping_set_folio_orders(struct address_space *mapping,
> > +					    unsigned int min, unsigned int max)
> > +{
> > +	if (min == 1)
> > +		min = 2;
> > +	if (max < min)
> > +		max = min;
> > +	if (max > MAX_PAGECACHE_ORDER)
> > +		max = MAX_PAGECACHE_ORDER;
> > +
> > +	/*
> > +	 * XXX: max is ignored as only minimum folio order is supported
> > +	 * currently.
> > +	 */
> > +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> > +			 (min << AS_FOLIO_ORDER_MIN) |
> > +			 (MAX_PAGECACHE_ORDER << AS_FOLIO_ORDER_MAX);
> > +}
> > +

