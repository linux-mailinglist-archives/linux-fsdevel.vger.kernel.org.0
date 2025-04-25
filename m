Return-Path: <linux-fsdevel+bounces-47320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69837A9BDB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 06:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2C392412B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 04:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA6F1DFD96;
	Fri, 25 Apr 2025 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BJVri5ot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5817A2EE
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745556746; cv=none; b=WwaTGd+vg2DgRVWPckzT98qRoPPpLJjRj7SnqoykXhlQkjmw7gOuCbU8eP009SkpUICK7ZWhMnREpxVsRZ1NTfFhqEg7Ljl1Qb/IawF1i50vwaffJXCl6rD8mJMxdro0vbMeW2J7rJhcEmX8ikgLDzty1UlPuRz0Id7rMs6qgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745556746; c=relaxed/simple;
	bh=YkvdAd9jfK3zmFwKC9u0mjKivpPvf6/rpbqcfNckOaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSQsxbozmb7I014DRKec1moidH0ampY/S0tnM2M5BC6PTEhLeRm+irMQ63MVtHDv1kj2Vz1J6wzfmUsHl3S2hfsqPfF42yjc5CUVQU9DMIpGkbSHiEy7CXQNpD5fL5p4x7RK95nO0GcBEiPv9rXdSSMoxHSrNekJCwKZ6BMy7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BJVri5ot; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YFB4ZF0Whoj32Yw9FFMV1qTPxhW/oefu8NpvR90pwmo=; b=BJVri5otk1pxjU6hwWWNbwGeal
	i4HaomFTMDjAKOEXyyGZaomJGjvCcMUT+exbtpztdlAYki/4TVu6FOSYKUmFb1M1ahlyu2qR8jsA5
	AN9GcVM15y+bHwmu6lDOmvGbyhRbSTJht9A3S4jUSKYLh9mpU701/8ih0bpLxn8ei19RQ7wECjDQm
	XNx4x61tglPNOs5a3QFd/imh37eSrGmQCD95ehd4BM708sKT7JblkS60i3RIwoEdfeT+AfzB/dJMf
	JHzHO/TWabc7ae/ATlH1JqC/tUBGD5w8iAz4vHJIV6CA0tyySoCEiSwzogiw9/wn13ajLfBa3c9j6
	yvJ2X4/A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8B2y-0000000Dm1m-3s9a;
	Fri, 25 Apr 2025 04:52:20 +0000
Date: Fri, 25 Apr 2025 05:52:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aAsVBIIUvXJ6KQ5d@casper.infradead.org>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <aAqCXfPirHqWMlb4@x1.local>
 <aAqUCK6V1I08cPpj@casper.infradead.org>
 <aAqxAX2PimC2uZds@x1.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAqxAX2PimC2uZds@x1.local>

On Thu, Apr 24, 2025 at 05:45:37PM -0400, Peter Xu wrote:
> On Thu, Apr 24, 2025 at 08:42:00PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 24, 2025 at 02:26:37PM -0400, Peter Xu wrote:
> > > Secondly, userfaultfd is indeed the only consumer of
> > > FAULT_FLAG_INTERRUPTIBLE but not necessary always in the future.  While
> > > this patch resolves it for userfaultfd, it might get caught again later if
> > > something else in the kernel starts to respects the _INTERRUPTIBLE flag
> > > request.  For example, __folio_lock_or_retry() ignores that flag so far,
> > > but logically it should obey too (with a folio_wait_locked_interruptible)..
> > 
> > No.  Hell, no.  We don't want non-fatal signals being able to interrupt
> > that.  There's a reason we introduced killable as a concept in the first
> > place.
> 
> Not really proposing that as I don't have a use caes.  Just curious, could
> you explain a bit why having it interruptible is against the killable
> concept if (IIUC) it is still killable?

Because "interruptible" means it can be interrupted by inane stuff like
SIGWINCH and SIGALRM.  And then we return from a page fault prematurely
and can't actually handle the situation, so we end up going back into the
page fault handler anyway having accomplished nothing other than burn CPU.

At least it's better than interruptible system calls which just gets
you short reads, corrupted data and crashing programs.

