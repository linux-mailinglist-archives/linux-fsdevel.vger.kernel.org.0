Return-Path: <linux-fsdevel+bounces-67317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88291C3B8B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D39A1A422C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2114033A02B;
	Thu,  6 Nov 2025 14:01:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165A339710;
	Thu,  6 Nov 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437714; cv=none; b=SsDbeqTkOYqgzl3RpJIlBoUa4N3s5Fgw12Dg0zaMkzYUIrUV7tAeUEBWzoyEkwBmZAOLV2uCAzpuOuk5O9dFOXKu9811G3/hPOshYUT4PeypLOXmkmzXXXB8ABASB5wBG1NLtO/xwW3RM2Udb4uo6PucEWIA3gmGmXxNqFF2hIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437714; c=relaxed/simple;
	bh=eiISBvjco5QPWD2jTvDlbk2vV4mbJeXzLH2KFd+DU1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzzp/GVelk1xwAao0u5rZLZ+ZplTwXRpbUgRIchdclESuyl67aVCIRBA+jo+3FRBnkFwfVjsL+gaVtozmumIuUEJhbGCUr6Ucz8oeUbZH6km9GYs5J1cKbd9GrsNixYWgnitB9kg5VgwO/6k5s7BFoi2A2WkhGWJpFaRM0RzfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDBAC227A87; Thu,  6 Nov 2025 15:01:43 +0100 (CET)
Date: Thu, 6 Nov 2025 15:01:42 +0100
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
Subject: Re: [PATCH 9/9] blk-crypto: use mempool_alloc_bulk for encrypted
 bio page allocation
Message-ID: <20251106140142.GA11440@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-10-hch@lst.de> <39f2d0d3-de79-4e13-a577-83a3aeb5cf1b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f2d0d3-de79-4e13-a577-83a3aeb5cf1b@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 04:12:29PM +0100, Vlastimil Babka wrote:
> > +	memset(pages, 0, sizeof(struct page *) * nr_segs);
> > +	if (alloc_pages_bulk(GFP_NOFS, nr_segs, pages) < nr_segs) {
> > +		mempool_alloc_bulk(blk_crypto_bounce_page_pool, (void **)pages,
> > +				nr_segs, GFP_NOIO);
> 
> Why do the GFP flags differ?

Me messing up.  So fsr all blk-crypto stuff was GFP_NOIO.  I think it
generally should be GFP_NOFS now, but f2fs is doing some weird things
with GFP_NOIO.  (Could everyone please document their restrictions,
preferable using the task flags, thanks..).

I'll restore GFP_NOIO for the next version.


