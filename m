Return-Path: <linux-fsdevel+bounces-67428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB1C3FD85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 13:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7C23B5321
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDD63271F4;
	Fri,  7 Nov 2025 12:06:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B094325722;
	Fri,  7 Nov 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517205; cv=none; b=QU5U7p91S9b0mHH2bFdgtIXNqQ6ZNu3u5/ZnYSCYbjA5YUFRRBnmZ9pEALz23C+PHxxqh7u1NLrIyBOoW6f69CeTJcRS+/vNZvqkNvtgChL8MNEbe6fAC/K7CC2FfxuukxI4UraC4pniAXlZQ8c+ZSS8bM4pJctDQUTYHRrOhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517205; c=relaxed/simple;
	bh=rPn2jM9nrfLYzKJ2ZokYRbjAE+SBuL78zpD81yjb3+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9EYXXF6T3RIww9l7tcuj1cdSCYysBy2+iYa7g5bzSwuqJf6uxHDzboPYXbst6CVFhFbjya0nxN+jsNx3J9YSiJJrXR2iDnE2wUKJ9MdFGaZ5lHwmiX5PcBLA3JhyXDSXRVSmuUjwaZrSrPV4AEymyCSCgY9WRJTZaWSh7Xl/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 101D4227AAE; Fri,  7 Nov 2025 13:06:38 +0100 (CET)
Date: Fri, 7 Nov 2025 13:06:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/9] mempool: add mempool_{alloc,free}_bulk
Message-ID: <20251107120637.GC30551@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-4-hch@lst.de> <20251107035207.GA47797@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107035207.GA47797@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 07:52:07PM -0800, Eric Biggers wrote:
> > +int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
> > +		unsigned int count, gfp_t gfp_mask, unsigned long caller_ip)
> 
> What exactly is the behavior on partial failures?  Is the return value 0
> or is it -ENOMEM, and is the array restored to its original state or
> might some elements have been allocated?

Right now it frees everything.  But as per the discussion with Vlastimil
I'll move to not allowing non-blocking allocations for multiple elements,
at which point the failure case just can't happen and that is sorted out.

> > +}
> >  EXPORT_SYMBOL(mempool_alloc_noprof);
> 
> How much overhead does this add to mempool_alloc(), which will continue
> to be the common case?  I wonder if it would be worthwhile to
> force-inline the bulk allocation function into it, so that it will get
> generate about the same code as before.

It's about 10 extra instructions looking at my profiles.  So I don't
think it matters, but if the maintainers prefer force inlining I
can do that.


