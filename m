Return-Path: <linux-fsdevel+bounces-28091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7563966CA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 00:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28328B213FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 22:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC66A1C2307;
	Fri, 30 Aug 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDZ4f1rf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17414E2E1;
	Fri, 30 Aug 2024 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057749; cv=none; b=K621zopeW3KqI9xkZkvr+YAzNhsui7oG0aWhPT0fKEjvzbRVD6t9XKH96x3ytV/SOzJkfFyX4F7c6fhtTgqkkBlQEPoVJOQ++Iqgq45+R/TS5bjWY3WIKQH4SfP4Y3a/GZMaouSbh5HIkUPTVduzfTlV2PT4g05CxXP0nkMd/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057749; c=relaxed/simple;
	bh=vdiME2Hn+nceXHKlGGuy8E8NsiATQrqZAVsIIadpM48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G//nCwaBWsDOMhCqpz8+y4cpBNTSZkuuUjsJNwk0aaD6SfDGffuALPlWtiKH//9a8MLs6NWgbNa727CG/O+QxRZdmHNaxlPj9vjyG3eKUvYZgwBGDK4GIh5KqfaCdevJXl7gFLnZmFUhf6f9D3B2U18d6UmTATB1UDKLcHUwMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BDZ4f1rf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=prD1VbZIGGQBOBhoPQZxAl0J7UvFLgR9rwzDdD+A1yk=; b=BDZ4f1rfbUU0cNa3RjQjHVEIPD
	2atkufySHAnFtxNOrM9lrvBqHeRCTMey4djRkrxXjjBRVIdqAiJrTFRNKcv+TVm4r/JF68KrbA8GB
	Knbkeqbi7nJ7u78S1s4KyoTL1t/N1ivAIn1ASz8yrMQ/AGnRow5JKxrVBMTPQgIbN4F5GgJjWlWTL
	71gV6qs3ruMVT6juiEhemhzKZygpcH4Sh5Rk5h1h4WV/oTR2fG5r40tdHlCajRNVj+NkfMPTW9wq7
	Hz0G/SD+5k1B/6TI30ujQEslSYgH6MrrAU/1/ykAYkbRP8clSHTgJaHlruizNJT0eyNwe5NGL6x4F
	Ze/IG8TA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1skAJi-00000003jZo-3U82;
	Fri, 30 Aug 2024 22:42:06 +0000
Date: Fri, 30 Aug 2024 23:42:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Sven Schnelle <svens@linux.ibm.com>, brauner@kernel.org,
	akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	john.g.garry@oracle.com, cl@os.amperecomputing.com,
	p.raghav@samsung.com, ryan.roberts@arm.com,
	David Howells <dhowells@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <ZtJKvuF8086rj1dq@casper.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com>
 <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
 <ZtDSJuI2hYniMAzv@casper.infradead.org>
 <221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
 <ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
 <2477a817-b482-43ed-9fd3-a7f8f948495f@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2477a817-b482-43ed-9fd3-a7f8f948495f@pankajraghav.com>

On Fri, Aug 30, 2024 at 04:59:57PM +0200, Pankaj Raghav wrote:
> It feels a bit weird to pass both folio and the page in `split_page_folio_to_list()`.

We do that in the rmap code.

But this is not a performance path.  We should keep this as simple as
possible.

