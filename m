Return-Path: <linux-fsdevel+bounces-13011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42A86A257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A641A2895B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080CA14F971;
	Tue, 27 Feb 2024 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gnD5MWcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148A4CE17
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072490; cv=none; b=uH66ZELOcpDTrytQWwmTYFR0Fl7m3UPguDs12HEY54dWOlfqkRUs5kOxJVYQY9pkFoX/R1hym10jk369KVPL123A9/y2QedX6zlIXt8LA7claedKPOq9tYvGoASkPJLKwJiIivGahHkTcCnhOPvTJGJ5tHzRWYXlvLD08RgjOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072490; c=relaxed/simple;
	bh=TvczKApdVhsEju+BckGg14/Ix/Q3Nb2EKzxKlikXK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igx2Q52dNS54oGdFbkpfxAus3u0trI+/zssLnDHHyiHdwe4PcB34lgUErZ1f2nnLoC+7bye/DBicTxKZbyVmyWyp6AFYqP/r6yeTgdU/S378vJX0Bz9Nxiwb3lZFpRVZV6B7oD1AicLDm3N/fLvQt8a3A6El0LcnJxARtXhFbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gnD5MWcU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 17:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709072485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwgQo6FDRri5QEfNjCzxF2Jb9a4VN388sKPexvzlY+s=;
	b=gnD5MWcUFUZGk46B7cTR9rWkXEzxnfif0bRYTG3B0YZ4kIWu0e3/gzI6tPhivFQ9Z0RNn/
	CN4mOcGHbaTPl4u/jnuOZnpwtcJe8dxxgXqOUQpcuiGsrQyAJbeWwv91Kn4drOxfN2H1fT
	p+05sqFjkpJFO7VKXHFjgjEfIN8eCPU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd5ecZbF5NACZpGs@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 09:13:05AM +1100, Dave Chinner wrote:
> On Tue, Feb 27, 2024 at 05:07:30AM -0500, Kent Overstreet wrote:
> > AFAIK every filesystem allows concurrent direct writes, not just xfs,
> > it's _buffered_ writes that we care about here.
> 
> We could do concurrent buffered writes in XFS - we would just use
> the same locking strategy as direct IO and fall back on folio locks
> for copy-in exclusion like ext4 does.

ext4 code doesn't do that. it takes the inode lock in exclusive mode,
just like everyone else.

> The real question is how much of userspace will that break, because
> of implicit assumptions that the kernel has always serialised
> buffered writes?

What would break?

> > If we do a short write because of a page fault (despite previously
> > faulting in the userspace buffer), there is no way to completely prevent
> > torn writes an atomicity breakage; we could at least try a trylock on
> > the inode lock, I didn't do that here.
> 
> As soon as we go for concurrent writes, we give up on any concept of
> atomicity of buffered writes (esp. w.r.t reads), so this really
> doesn't matter at all.

We've already given up buffered write vs. read atomicity, have for a
long time - buffered read path takes no locks.

