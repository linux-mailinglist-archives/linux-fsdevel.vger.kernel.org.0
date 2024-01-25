Return-Path: <linux-fsdevel+bounces-9008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B1D83CDD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62CE1C25426
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACE11386B6;
	Thu, 25 Jan 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CqEVduGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE83135A5E;
	Thu, 25 Jan 2024 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216091; cv=none; b=dTD8B3xpOBTxGfzsEicoAjeYh3oGxPsSEElSU+DmKBRtgt2O1spygKAnmmkqmvO61+jUcE6bP31duWPPKs9tF+oKY5+eNDmy1ri7Qe+oLQaIUDRwRUo4NhoHbU0pdMNanKvqra5MyaOw4Na9ehfSF+9kD0MmB+6dgEvxq7UYO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216091; c=relaxed/simple;
	bh=SpKksvIWM5+cnM216eYx+4zjN5n7LpPmxS2mK+QEfvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oy2kaifC/OXtPRpArFt5bpAnFUWp+3ckBU51AP5wjn1boLO05b+GQ51cUwbsgcWf0qITZzb3Es89Kprin9jc56sya2NRpOMIZGC2hYNSRGNWS/agawV+FuHnt2vh6mcf+oZa3XQQ2KjEWhiyZiPnMO6Ssnlu+ydozFU3E2jLLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CqEVduGL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tz6CP5gYVtr2hsAPEJmAbiZv1JPJpw3XqQureOu159Q=; b=CqEVduGLAuMeeUplttS7hkZf+M
	ARBHuFerXe35IHjO42C6S1B0EDsCMhqjU6pxm+6j+mHod3KOpZWXVJKQQrnmfIy1qVhgYThXZ0q7R
	sj53FQwtZ90BmdDY0DgU+eGjnWcMhvOVQfpgu4mBdtTIQOHmNNC+K3467DnMaOMIzn7GDLHNL9Wuk
	OJYfbEg8TGc1nuFRdsGViSzFuTkPKKzOd1qlLqQnSjwxO2Ej9eIreBV0SbFYApYkqIl11rvL/lUIG
	cTSJWmCB+01gy8HPPW6OJwASeW3W5sYAl4Sb2F/KxV5+0BIKNB3NabjdbWBh/x1VRcoEu5oaC6P5e
	zJM6sq1A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT6kJ-00000001s6s-0kYz;
	Thu, 25 Jan 2024 20:54:47 +0000
Date: Thu, 25 Jan 2024 12:54:47 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, fengnanchang@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	vishal.moola@gmail.com,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH] f2fs: Support enhanced hot/cold data separation for f2fs
Message-ID: <ZbLKl25vxw0eTzGE@bombadil.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
 <Y4d0UReDb+EmUJOz@casper.infradead.org>
 <Y5D8wYGpp/95ShTV@bombadil.infradead.org>
 <ZbLI63UHBErD6_L2@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbLI63UHBErD6_L2@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jan 25, 2024 at 08:47:39PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 07, 2022 at 12:51:13PM -0800, Luis Chamberlain wrote:
> > On Wed, Nov 30, 2022 at 03:18:41PM +0000, Matthew Wilcox wrote:
> > > From a filesystem point of view, you need to ensure that you handle folios
> > > larger than PAGE_SIZE correctly.  The easiest way is to spread the use
> > > of folios throughout the filesystem.  For example, today the first thing
> > > we do in f2fs_read_data_folio() is convert the folio back into a page.
> > > That works because f2fs hasn't told the kernel that it supports large
> > > folios, so the VFS won't create large folios for it.
> > > 
> > > It's a lot of subtle things.  Here's an obvious one:
> > >                         zero_user_segment(page, 0, PAGE_SIZE);
> > > There's a folio equivalent that will zero an entire folio.
> > > 
> > > But then there is code which assumes the number of blocks per page (maybe
> > > not in f2fs?) and so on.  Every filesystem will have its own challenges.
> > > 
> > > One way to approach this is to just enable large folios (see commit
> > > 6795801366da or 8549a26308f9) and see what breaks when you run xfstests
> > > over it.  Probably quite a lot!
> > 
> > Me and Pankaj are very interested in helping on this front. And so we'll
> > start to organize and talk every week about this to see what is missing.
> > First order of business however will be testing so we'll have to
> > establish a public baseline to ensure we don't regress. For this we intend
> > on using kdevops so that'll be done first.
> > 
> > If folks have patches they want to test in consideration for folio /
> > iomap enhancements feel free to Cc us :)
> > 
> > After we establish a baseline we can move forward with taking on tasks
> > which will help with this conversion.
> 
> So ... it's been a year.  How is this project coming along?  There
> weren't a lot of commits to f2fs in 2023 that were folio related.

The review at LSFMM revealed iomap based filesystems were the priority
and so that has been the priority. Once we tackle that and get XFS
support we can revisit which next fs to help out with. Testing has been
a *huge* part of our endeavor, and naturally getting XFS patches up to
what is required has just taken a bit more time. But you can expect
patches for that within a month or so.

  Luis

