Return-Path: <linux-fsdevel+bounces-34084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44C9C24E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367141F2393C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310BD1A9B3C;
	Fri,  8 Nov 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q0i+zgV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD52233D6E;
	Fri,  8 Nov 2024 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090803; cv=none; b=pKXB1yrbHqpt1UZjDAyG4QtUcREsgia5azP6pHinLys2Id0yhaT9A881/JVToFBXvc0jYKwAJHxRudgZPWVF6ZK7NHUj4VbJNnsJ3/zWMU/JF78Dy9U8I/53XbRv6s2PEh/2ux/kDLCANlM88mH1dUq0DnqObpXeIbarhZCL9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090803; c=relaxed/simple;
	bh=BUrUKcrOBLuOYRhDXsyK+/CBvZBzVAsJ75G04lAWNeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AckDVjoLEwV8sNMx7CGaL8+ajkyyRhUkXIhgH5vgirk6W46qu9zYsc3sV5RWXViznmHidlIH3EZELfWeASwikenqyTrhMo594+uJWXNFiKOAt9qyavfv1KkqHXdqcMhAskjsdqHuJEXV549LV39mf+s7HAA3owfd8GmynMWtito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q0i+zgV5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BPleluZ0wE/8aNLphmAdE2uJITOE+HSyY7uzrnMww8M=; b=q0i+zgV5EGWxt2QNrgNCzIHcaw
	SP8QoN+i7fs2yOVbyuIGhhu7MGRJb7qJzH5jQVhklWOIVEYwMCjsw6vUaIVuCPjDmn4SKaJTKbNUP
	IO83P4bZEVBMFtVe1dxqeNjq3YOFSaOS3mMyAXTzryMcNm6ZFJB2nCG37IcILnkzGzu1IQgfQeRe7
	BjrkRdB9fCBNfVpcEr/2dCmHoG7bj4o8Elug+NGxDI9FO/BlVs+RBZuEgqG3XIGra0Rtov6H5A0ZF
	GngwTb/al4rIUSZ6MBbCQ6vvevelvnwQw+LhzHtLf82iNyknEfvDW0Z0Sg/O+hdcEB/TkHg5G5k3w
	9q3BFAXA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t9TnL-00000009B9r-1HO5;
	Fri, 08 Nov 2024 18:33:19 +0000
Date: Fri, 8 Nov 2024 18:33:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] fs: add read support for RWF_UNCACHED
Message-ID: <Zy5Zb8Twe7QBkHMh@casper.infradead.org>
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-9-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108174505.1214230-9-axboe@kernel.dk>

On Fri, Nov 08, 2024 at 10:43:31AM -0700, Jens Axboe wrote:
> +++ b/mm/swap.c
> @@ -472,6 +472,8 @@ static void folio_inc_refs(struct folio *folio)
>   */
>  void folio_mark_accessed(struct folio *folio)
>  {
> +	if (folio_test_uncached(folio))
> +		return;
>  	if (lru_gen_enabled()) {

This feels like it might be a problem.  If, eg, process A is doing
uncached IO and process B comes along and, say, mmap()s it, I think
we'll need to clear the uncached flag in order to have things work
correctly.  It's a performance problem, not a correctness problem.

