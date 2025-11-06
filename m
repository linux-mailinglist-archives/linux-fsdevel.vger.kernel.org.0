Return-Path: <linux-fsdevel+bounces-67327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE61CC3BE29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9C53BEF24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2618D333452;
	Thu,  6 Nov 2025 14:48:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126852DAFD7;
	Thu,  6 Nov 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440534; cv=none; b=lH2nohaA1r6ZFxvzYD78Ek3BKEL52d9ADdgkVD3RebVA7mrkFgq2m6WvSpV8TnL5Pe+WZylWusqoR3ztZLKPtlgo8pClzeoLyAa8yr7nlDfaLSbezW6+hI9QWJKdeJUroO2VBsV613dwuf6UorUM+p50D2JKcJUuoQzhCJQ+QlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440534; c=relaxed/simple;
	bh=lKugn0J9rMSINhrlRTkYP3boduzz6d+jBDbWL1YlLmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phkXRMElo5wxkicp49ZKUHOs2Fa0CGOyYwFbpk+HkY/FjtC6VEpsV8pAX8v66Vc3eDjUgLsBZjYwl3ZdWMby9s+KdAvQIkLgr0bwizOzsABen6Tf+O82ddGGCKCn1bEKFrkdusXhcgrDXrOnas+f4ISQZkLOhedY3ILsw0IpdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F02EA227AAE; Thu,  6 Nov 2025 15:48:46 +0100 (CET)
Date: Thu, 6 Nov 2025 15:48:46 +0100
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
Message-ID: <20251106144846.GA15119@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-4-hch@lst.de> <1fff522d-1987-4dcc-a6a2-4406a22d3ec2@suse.cz> <20251106141306.GA12043@lst.de> <b950d1a9-3686-4adc-ac2d-795b598ff1a5@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b950d1a9-3686-4adc-ac2d-795b598ff1a5@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 03:27:35PM +0100, Vlastimil Babka wrote:
> >> Would it be enough to do this failure injection attempt once and not in
> >> every iteration?
> > 
> > Well, that would only test failure handling for the first element. Or
> > you mean don't call it again if called once?
> 
> I mean since this is (due to the semantics of mempools) not really causing a
> failure to the caller (unlike the typical failure injection usage), but
> forcing preallocated objecs use, I'm not sure we get much benefit (in terms
> of testing caller's error paths) from the fine grained selection of the
> first element where we inject fail, and failing immediately or never should
> be sufficient.

I guess. OTOH testing multiple failures could be useful?

> > Yes, this looks like broken copy and paste.  The again I'm not even
> > sure who calls into mempool without __GFP_DIRECT_RECLAIM reset, as
> > that's kinda pointless.
> 
> Hm yeah would have to be some special case where something limits how many
> such outstanding allocations can there be, otherwise it's just a cache to
> make success more likely but not guaranteed.

I think the only reason mempool_alloc even allows !__GFP_DIRECT_RECLAIM
is to avoid special casing that in callers that have a non-constant
gfp mask.  So maybe the best thing would be to never actually go to
the pool for them and just give up if alloc_fn fails?

> >> >   * This function only sleeps if the free_fn callback sleeps.
> >> 
> >> This part now only applies to mempool_free() ?
> > 
> > Both mempool_free and mempool_free_bulk.
> 
> But mempool_free_bulk() doesn't use the callback, it's up to the caller to
> free anything the mempool didn't use for its refill.

You're right.  So mempool_free_bulk itself will indeed never sleep and
I'll fix that up.

