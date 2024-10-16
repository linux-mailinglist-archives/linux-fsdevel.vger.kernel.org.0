Return-Path: <linux-fsdevel+bounces-32101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDF9A08E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D511C2457A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7663C207A14;
	Wed, 16 Oct 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KLjmEU1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFB206971
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079869; cv=none; b=VvaH8v2WGB/gG21E2Kg71x9p6HzuEREI14oq+5A5D2iDHR7xyIrZXrRSwXglBLqNaFWg1j9wjlj2i7GQZU4NarKUy8pfEuwbi2+XOWq8z4/dP3C+UsRh5GKYzvyMrVuRYiODBm7Xlh5D3UAKjdZLgGpd30c9gsP3+ISG6whbZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079869; c=relaxed/simple;
	bh=jK9jKlVD7IYfG/47A8Hw0YOg0rbsGMt9h1ddBOIju38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDg0ocsmjAyOnx86+psVhe4bZ3J9Ey2Bd9Sre4EsLcsEa66KUBwB57dlR8t9mQIXjH7uDexkHbh5ZzD4s7Hi6pSiunl/oppED6SsZZ5irlNPBddIVjv7RNeugBD2A4GlRPqPbHBl/v4m3GKKA8++Xume8yjCZxHJDAcAKJaaX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KLjmEU1L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mbl/u6ht4xnA85g84TEKGQpV8CYMroGPrfeh03GQbFs=; b=KLjmEU1LZHa3oKp05sgxPZBHBq
	/jK+biCr/+fXjo7wfccH1jGK/Foq7RF8XUXQlfB9+ze3FyaruLXwyQwgYnNZqNTQmNt/9Lwp72yvb
	Sskuz2LMBP1JQBknhxbSzF2+qRcRdlA6CQpX66iOO+mtYEswaarXFmXZamtqVJfD0lGe9V0/Dna9j
	bm2jsWQgFO2LdQk8khPqI99eT3ccY9XI9q0O5t3ud/j31Wf60Zu93Z9uClMDaSaH0RmgCZdqilLqH
	TcWI4z2xu6euQgDo9vBcI4g12L5z5xMjQ2knrxBIkChnsxxS0py8JdZJE2W8MGX1gAaUngPmRAazQ
	L1O1gMfA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t12ev-00000007ptf-0xVU;
	Wed, 16 Oct 2024 11:57:45 +0000
Date: Wed, 16 Oct 2024 12:57:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: Re: [PATCH v14] mm: don't set readahead flag on a folio when
 lookahead_size > nr_to_read
Message-ID: <Zw-qOAOM2je3EHb1@casper.infradead.org>
References: <20241015164106.465253-1-kernel@pankajraghav.com>
 <Zw6nVz-Y6l-4bDbt@casper.infradead.org>
 <cwugg63urgcknylwum4lfcxyemx3epcejfchrpfwcii5pvsp3k@2f5d5kjw7tlq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cwugg63urgcknylwum4lfcxyemx3epcejfchrpfwcii5pvsp3k@2f5d5kjw7tlq>

On Wed, Oct 16, 2024 at 03:35:27PM +0530, Pankaj Raghav (Samsung) wrote:
> > > - The current calculation for `mark` with mapping_min_order > 0 gives
> > >   incorrect results when lookahead_size > nr_to_read due to rounding
> > >   up operation.
> > > 
> > > Explicitly initialize `mark` to be ULONG_MAX and only calculate it
> > > when lookahead_size is within the readahead window.
> > 
> > You haven't really spelled out the consequences of this properly.
> > Perhaps a worked example would help.
> 
> Got it. I saw this while running generic/476 on XFS with 64k block size.
> 
> Let's assume the following values:
> index = 128
> nr_to_read = 16
> lookahead_size = 28
> mapping_min_order = 4 (16 pages)
> 
> The lookahead_size is actually lying outside the current readahead
> window. The calculation without this patch will result in incorrect mark
> as follows:
> 
> ra_folio_index = round_up(128 + 16 - 28, 16) = 128;
> mark = 128 - 128 = 0;
> 
> So we will be marking the folio on 0th index with RA flag, even though
> we shouldn't have. Does that make sense?

But we don't go back and find the folio for index 0.  We only consider
the folios we're actually reading for marking.  So if 'mark' lies
outside the readahead window, we simply won't mark any of them.  So I
don't think your patch changes anything.  Or did I miss something?


