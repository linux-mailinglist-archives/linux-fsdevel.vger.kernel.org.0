Return-Path: <linux-fsdevel+bounces-11600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2C08552DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 20:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14037289943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3351513B7A8;
	Wed, 14 Feb 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnKVOBoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC24139575;
	Wed, 14 Feb 2024 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937211; cv=none; b=CYiBU537oKKNymC46DEFuTPXMcS2fEjIdrA9zMaNvB5v3Bnp1j61jBm/zLeB9QvwYwnlAQ+aqS8TgpPQvPWRfPUAQZcDuirOL1kc7RZdZj/cX4w1m8hiih0UtD+rcEZiLiNp3yq0dn1Ew3tEeDHkrLgqF8GYRTpOu5HvqWOvlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937211; c=relaxed/simple;
	bh=4jc6g0LFud0Mvqgrbo+tGEeVyeNTU4cJbrkHNFnIVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjF5gxH6Nh2oOEUJwBKIgmonwBuCXGBDM2IrU8k4JQt8ntYvdbaGflBasjr2xXKHi/378hnbmwPWpgvlUVIVADRQVu2tS1cZqc1cv0e4HEhYqHT2py+R9yin6RljzvlElQNjw/7wOMYjmJDBU7EoIZcshYdblMpb7S1zgE2MyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rnKVOBoV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=foFpJZ54BtuTBxARzlxsAzGeWzKOUcYpxd8wVsdim80=; b=rnKVOBoVsKHPVo9eorBDHNjwb1
	EcBJGnPvXMtjFIbHfea3Ga6ZHoG5SkT5KlUzJVQUFepY4phy/SvafFD35XeDH6Ctq9MHWar+cKcVa
	EQMlXBgs8QO1ORaGVw9ShO8ydsuceXqkAs57A2+b+YBnIiUFiMJ3/ga7+2sZ3lOlD8H8DNibwnzB5
	mQZApnvIkELdtV2Rx+ZPi8ZxNhhUNVQt/pl+DbAmAh1XiKa0Ox7JNgORj77D1q35Kk/7femrVqfg7
	PjE9sSzYHtRqZr8LA+dmMu9o/WGPpiLCXszW0TGV56lDa5nQs9XYFc68RmdhsdPH9jNcM82eHZJCA
	wUGm2WHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raKUH-0000000HLkn-3GS2;
	Wed, 14 Feb 2024 19:00:06 +0000
Date: Wed, 14 Feb 2024 19:00:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, linux-mm@kvack.org,
	david@fromorbit.com
Subject: Re: [RFC v2 01/14] fs: Allow fine-grained control of folio sizes
Message-ID: <Zc0NtZrnHIXrZy53@casper.infradead.org>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-2-kernel@pankajraghav.com>
 <20240213163431.GS6184@frogsfrogsfrogs>
 <xy45wh2y55oinrvkhea36yxtnqmsoikp7eawaa2b5ejivfv4ku@ob72fvbkj4uh>
 <20240213212914.GW616564@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213212914.GW616564@frogsfrogsfrogs>

On Tue, Feb 13, 2024 at 01:29:14PM -0800, Darrick J. Wong wrote:
> On Tue, Feb 13, 2024 at 10:05:54PM +0100, Pankaj Raghav (Samsung) wrote:
> > On Tue, Feb 13, 2024 at 08:34:31AM -0800, Darrick J. Wong wrote:
> > > On Tue, Feb 13, 2024 at 10:37:00AM +0100, Pankaj Raghav (Samsung) wrote:
> > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > 
> > > > Some filesystems want to be able to limit the maximum size of folios,
> > > > and some want to be able to ensure that folios are at least a certain
> > > > size.  Add mapping_set_folio_orders() to allow this level of control.
> > > > The max folio order parameter is ignored and it is always set to
> > > > MAX_PAGECACHE_ORDER.
> > > 
> > > Why?  If MAX_PAGECACHE_ORDER is 8 and I instead pass in max==3, I'm
> > > going to be surprised by my constraint being ignored.  Maybe I said that
> > > because I'm not prepared to handle an order-7 folio; or some customer
> > > will have some weird desire to twist this knob to make their workflow
> > > faster.
> > > 
> > > --D
> > Maybe I should have been explicit. We are planning to add support
> > for min order in the first round, and we want to add support for max order
> > once the min order support is upstreamed. It was done mainly to reduce
> > the scope and testing of this series.
> > 
> > I definitely agree there are usecases for setting the max order. It is
> > also the feedback we got from LPC.
> > 
> > So one idea would be not to expose max option until we add the support
> > for max order? So filesystems can only set the min_order with the
> > initial support?
> 
> Yeah, there's really no point in having an argument that's deliberately
> ignored.

I favour introducing the right APIs even if they're not fully implemented.
We have no filesystems today that need this, so it doesn't need to
be implemented, but if we have to go back and add it, it's more churn
for every filesystem.  I'm open to better ideas about the API; I think
for a lot of filesystems they only want to set the minimum, so maybe
introducing that API now would be a good thing.

