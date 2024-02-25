Return-Path: <linux-fsdevel+bounces-12726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE04862C45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CDAB20FA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BA1862E;
	Sun, 25 Feb 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sYfZStVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179217C7F
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882366; cv=none; b=FuVqLEZ/1Jbcjpd5j/AP6mra6R1xjTFYddQoH30D3gLhHZmnABc+tM/NeiE4N5Ylv2wqhDvxAOzgeTBaNkrhB/nPW95VED03xtpOuKEBvdbrtCqun51AwE0j6XfdRTE9fkOvmsStJZULcqQntRpk4iPPONNVkSRRI1rjAB/z5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882366; c=relaxed/simple;
	bh=Lj1ttRp5N51ASzgMUZRMLAcAAdD/2FW5n4fJl72U7y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkWwb5uHkmj9NvHBCCdx9jp8eNfviMGS0i6iG9CKfwgai8UwCM2pwzBoBMNFoNl+EKJF0Mkuz2wL3aIbExTpbk9/4dz01nVcFAR5ahZvemOBsVyjpiJGlPWx1CS1C91FUeNqtZjX0GM2uo8G1hnSB4XCFXyE5AD5cprwd3Bduzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYfZStVJ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 12:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708882361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48kxm1i6cHsIkepVpM1ROlIBeKHmlm9Uv4gXRmTJ3LM=;
	b=sYfZStVJ55kmFRBLPasdaCrFUnTHQ786jA3sSk4ys8XnRkmo6P3BUnlD4dk+1AoLLbM4cA
	hvRfsndXdCe4ExffmLTmBefPQjNbbzisfhd26yLqPYIkEfOFagi4Siqf6OxgMtoDvAI+Nh
	Nl2fHAIYj1lTlkQUqZvf1Uan2RIqZjw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <2impeknscqi2dg3ik6woohow26wjlfnv4oaevuqa7o2uyc3ppz@pwpnppp54jnh>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zds8T9O4AYAmdS9d@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 01:10:39PM +0000, Matthew Wilcox wrote:
> On Sun, Feb 25, 2024 at 12:18:23AM -0500, Kent Overstreet wrote:
> > Before large folios, we had people very much bottlenecked by 4k page
> > overhead on sequential IO; my customer/sponsor was one of them.
> > 
> > Factor of 2 or 3, IIRC; it was _bad_. And when you looked at the
> > profiles and looked at the filemap.c code it wasn't hard to see why;
> > we'd walk a radix tree, do an atomic op (get the page), then do a 4k
> > usercopy... hence the work I did to break up
> > generic_file_buffered_read() and vectorize it, which was a huge
> > improvement.
> 
> There's also the small random 64 byte read case that we haven't optimised
> for yet.  That also bottlenecks on the page refcount atomic op.
> 
> The proposed solution to that was double-copy; look up the page without
> bumping its refcount, copy to a buffer, look up the page again to be
> sure it's still there, copy from the buffer to userspace.
> 
> Except that can go wrong under really unlikely circumstances.  Look up the
> page, page gets freed, page gets reallocated to slab, we copy sensitive
> data from it, page gets freed again, page gets reallocated to the same
> spot in the file (!), lookup says "yup the same page is there".
> We'd need a seqcount or something to be sure the page hasn't moved.

yes, generation numbers are the standard solution to ABA...

