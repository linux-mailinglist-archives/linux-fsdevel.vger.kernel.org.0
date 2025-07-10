Return-Path: <linux-fsdevel+bounces-54442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A698AFFB88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4E0188E745
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797928BA87;
	Thu, 10 Jul 2025 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TXJ+rrsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871228B7CD;
	Thu, 10 Jul 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134439; cv=none; b=ZoGV96xKSG4W84XgG6yiMjl+uIusXy8QC84k4TRxg4FcRfN1/U+So247g4P5RtGx0bnhC+esDDr18sIGXjqXqGsW8yPIWbQkz9kDM4zDxvtKD1hwQk7CMngD7MGnOdmmDzVvKUUWqYlaP0eqibSiW7J3Y/P3fwjfuAMjxFAEEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134439; c=relaxed/simple;
	bh=2dHUB3IC3sdS0hLmMicGLp/gfznTyK+DCrvYFfDZR08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVoSbyuZmS9JrFvvCEeBnWZpvRYzzsp7nlcW0KJsza/wFgvpzEaArdFoaLiDGJW+UpCWkg2A8IMzQU1/AGH3hr9a8w5PS7gLWeN5TZ2/06e2A/YnvqfULF0FJ2yk6BVmQtcz3rZscWah2Ume7LwHwLBO7sly/Khn+bmwy7esEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TXJ+rrsE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RQSU1VKtvPuYnwuvJ92PV+7wJlwWZ71mCrKkW3LvhAU=; b=TXJ+rrsEYXGPJ9bSByOzmW07nc
	cKcy37r3QJf7/aNPaxKi1nDAZRtj4BaYkug2lbprVqsedOxkKbozjXGsE/LAUciexvVE1g/4J3G1B
	3lSfTQxyDQ9usUbC+yDPNmxmWeaI/xC0Z1ofhSVfwEQOu8rJgBQg9awYYNTE1t0YUwONsIGkanWyl
	6paB6og5j/Zn0S/vTTjDJ0Q6leXdrbrxYqHxkM3WofLPKwYVar5AXQMyqtVG4U/WaWnukncPfyqfC
	/OgrkTSaAGrfuTRD/hd4d13Hr1Ul68A4cwlXCw4Mmf20Q6DgzqUYuCKUs4HStirAzOaxMUMKcjMYT
	mR80URUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZmCn-0000000B64a-2px3;
	Thu, 10 Jul 2025 08:00:33 +0000
Date: Thu, 10 Jul 2025 01:00:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk,
	kundanthebest@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] nfsd: issue POSIX_FADV_DONTNEED after
 READ/WRITE/COMMIT
Message-ID: <aG9zIQTuMqmfauVE@infradead.org>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
 <175158460396.565058.1455251307012063937@noble.neil.brown.name>
 <fbe5d61013efe48d0cd89c16a933a9c925a8ea86.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe5d61013efe48d0cd89c16a933a9c925a8ea86.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 05, 2025 at 07:32:58AM -0400, Jeff Layton wrote:
> That is the fundamental question: should we delay writeback or not? It
> seems like delaying it is probably best, even in the modern era with
> SSDs, but we do need more numbers here (ideally across a range of
> workloads).

If you have asynchronous writeback there's probably no good reason to
delay it per-se.  But it does make sense to wait long enough to have
a large I/O size, especially with some form of parity raid you'll want
to fill up the chunk, but also storage devices themselves will perform
much better with a larger size.  e.g. for HDD you'll want to write 1MB
batches, and similar write sizes also help with for SSDs.  While the
write performance itself might not be much worse with smaller I/O
especially for high quality ones, large I/O helps to reduce the
internal fragmentation and thus later reduces garbage collection
overhead and thus increases life time.

> > Ideally DONTCACHE should only affect cache usage and the latency of
> > subsequence READs.  It shouldn't affect WRITE behaviour.
> > 
> 
> It definitely does affect it today. The ideal thing IMO would be to
> just add the dropbehind flag to the folios on writes but not call
> filemap_fdatawrite_range_kick() on every write operation.

Yes, a mode that sets drop behind but leaves writeback to the
writeback threads can be interesting.  Right now it will still be
bottlenecked by the single writeback thread, but work on this is
underway.


