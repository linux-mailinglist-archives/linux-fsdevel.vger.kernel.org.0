Return-Path: <linux-fsdevel+bounces-67319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA4C3B9E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E7C1AA5879
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED1341AB9;
	Thu,  6 Nov 2025 14:13:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B1340DB2;
	Thu,  6 Nov 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438395; cv=none; b=kcMSmnkZeQN4EID0KOv3SC6oeef9snoOZhtYS/i3DftYRqKdKpI4UntVrCgf7PF265h9fA5Q5bEafgP0AKbOQM0ZkPfkrp9HUzYMQfwjD5ZSST0/MgMSF8CzbY4N0ttbr9D7Pu08nyBFnaEDuVIp8J76/oswd+aZ3EnOzroXucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438395; c=relaxed/simple;
	bh=Qcr6LUVkwYzlTRsfR5r+wjTXyzhkPuLwFUZmgLNhPOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G75kAXV4/JbzmUdpO2xSzQRMeiJkTYFCK2uZSVNGltPzyK6hRb3Oe5UiiTQygf3W+x52gnGA/wEGUQS9FSOxghH7udbD/jXJtX5CPrB1AjaNy4V/0Nbu0lq5+lFitQyz6TlcmkkTZuFvBKgQcCDP8UbqUftlhv7MLw6I3Jb7mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 10E97227AAE; Thu,  6 Nov 2025 15:13:07 +0100 (CET)
Date: Thu, 6 Nov 2025 15:13:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/9] mempool: add mempool_{alloc,free}_bulk
Message-ID: <20251106141306.GA12043@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-4-hch@lst.de> <1fff522d-1987-4dcc-a6a2-4406a22d3ec2@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fff522d-1987-4dcc-a6a2-4406a22d3ec2@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 04:04:53PM +0100, Vlastimil Babka wrote:
> > +	for (; i < count; i++) {
> > +		if (!elem[i]) {
> > +			if (should_fail_ex(&fail_mempool_alloc, 1,
> > +					FAULT_NOWARN)) {
> > +				pr_info("forcing pool usage for pool %pS\n",
> > +					(void *)caller_ip);
> > +				goto use_pool;
> > +			}
> 
> Would it be enough to do this failure injection attempt once and not in
> every iteration?

Well, that would only test failure handling for the first element. Or
you mean don't call it again if called once?

> >  	/*
> > @@ -445,10 +463,12 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
> >  	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
> >  	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
> >  		spin_unlock_irqrestore(&pool->lock, flags);
> > -		return NULL;
> > +		if (i > 0)
> > +			mempool_free_bulk(pool, elem + i, count - i);
> 
> I don't understand why we are trying to free from i to count and not from 0
> to i? Seems buggy, there will likely be NULLs which might go through
> add_element() which assumes they are not NULL.

Yes, this looks like broken copy and paste.  The again I'm not even
sure who calls into mempool without __GFP_DIRECT_RECLAIM reset, as
that's kinda pointless.

> Assuming this is fixed we might still have confusing API. We might be
> freeing away elements that were already in the array when
> mempool_alloc_bulk() was called. OTOH the pool might be missing less than i
> elements and mempool_free_bulk() will not do anything with the rest.
> Anything beyond i is untouched. The caller has no idea what's in the array
> after getting this -ENOMEM. (alloc_pages_bulk() returns the number of pages
> there).
> Maybe it's acceptable (your usecase I think doesn't even add a caller that
> can't block), but needs documenting clearly.

I'm tempted to just disallow !__GFP_DIRECT_RECLAIM bulk allocations.
That feature seems to being a lot of trouble for no real gain, as
we can't use mempool as a guaranteed allocator there, so it's kinda
pointless.

> So in theory callers waiting for many objects might wait indefinitely to
> find enough objects in the pool, while smaller callers succeed their
> allocations and deplete the pool. Mempools never provided some fair ordering
> of waiters, but this might make it worse deterministically instead of
> randomly. Guess it's not such a problem if all callers are comparable in
> number of objects.

Yeah, which is the use case.

> >   * This function only sleeps if the free_fn callback sleeps.
> 
> This part now only applies to mempool_free() ?

Both mempool_free and mempool_free_bulk.


