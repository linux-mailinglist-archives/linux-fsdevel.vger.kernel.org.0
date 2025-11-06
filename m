Return-Path: <linux-fsdevel+bounces-67332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0DEC3BF29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 16:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B501893D92
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09928345CBC;
	Thu,  6 Nov 2025 15:00:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099641A3179;
	Thu,  6 Nov 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441256; cv=none; b=BH4X1C2uguL/sWvIebwtMFwciGi5xLZ0QQwGH729evLklvIvSiNSCDeD/OXUajF5eQUO5Xj5TMrf2qehwUGwPVSslNi+sTPlFVVjv9BjzQ70mgGtxxRE68SO1TibcH404mw0cqY8nN45lgu9vBmd/HAHY6M5pDodSaCsbRZUx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441256; c=relaxed/simple;
	bh=DHx5Gn/zRq9/QYaOscwbgOy0T1R7dI032wNeOlgn9fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRHqeNVAceUQUtNDAdO9WSGaBT1MtuQMKr4/7mwEanyuMp1v4trwvDHrRtiICNpHyk2VLLBld/C/5+hTCitVIqBzIEkP/zjo+6QBnVU99mfXB9vIq1CwK30N31kraNXKwPmOBkeyDDuJX9l3WJpSzdpsqmf0inr/NIfXWTjuCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E486227AAE; Thu,  6 Nov 2025 16:00:49 +0100 (CET)
Date: Thu, 6 Nov 2025 16:00:49 +0100
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
Message-ID: <20251106150049.GA16252@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-4-hch@lst.de> <1fff522d-1987-4dcc-a6a2-4406a22d3ec2@suse.cz> <20251106141306.GA12043@lst.de> <b950d1a9-3686-4adc-ac2d-795b598ff1a5@suse.cz> <20251106144846.GA15119@lst.de> <f933b80c-0170-4c0c-bf91-7c862127e96d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f933b80c-0170-4c0c-bf91-7c862127e96d@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 03:57:13PM +0100, Vlastimil Babka wrote:
> > I think the only reason mempool_alloc even allows !__GFP_DIRECT_RECLAIM
> > is to avoid special casing that in callers that have a non-constant
> > gfp mask.  So maybe the best thing would be to never actually go to
> > the pool for them and just give up if alloc_fn fails?
> 
> Yeah, but I guess we could keep trying the pool for the single allocation
> case as that's simple enough, just not for the bulk.

Doing that will be quite a bit more complicated I think.  And given
that the !__GFP_DIRECT_RECLAIM handlers must be able to handle failure
I'm also not sure that using the pool is all that useful.


