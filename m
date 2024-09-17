Return-Path: <linux-fsdevel+bounces-29588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97697B0BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 15:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0A283058
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F929166F25;
	Tue, 17 Sep 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O9A2Vlt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370F1EB35;
	Tue, 17 Sep 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579532; cv=none; b=bd1nnybf7b6rcrM9IQ4rYpGQj9VQ+aS9AC7QCNITNmYI8Iy1LBlryPEqGvTyq51hIgDH/nzuM8R/irCi/uKzIUjLRI54p/mLAiX9AnRAHsl5Sb0eFeKX5L5w7hzSjGZJI7d+jbSSXada0ExbdQyKuwj+DAx+akA5jrbWpr4c/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579532; c=relaxed/simple;
	bh=o+PCxyRMBkZiHib/jeVuc79sTseqzlW+C033Xq3Wiw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBMXm2PSkpR9+FHiqHIg5xrFrSSEyGuO4+yZ/3yY1uXYELJxfq1+rosMvgZQNoBk2rzgKnR8qRc6aL5KRnNU+z//3ede4mkXo3+P2fO9PF3+rHyz9DAL+6hIqfM8AQrIacTt7fgJ8QNLBoPQg6GI3owTxKjcYubtkJ6J8tzPSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O9A2Vlt+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XE0pVbqxqTT4RLjiHozh6t2ZvtCH+KY8eY1nRde4TzA=; b=O9A2Vlt+1scJZ+pflALJYFbHl/
	dp0Uh4+oq+gr+SyYodCTAMa36SXpSp7ReoykEhRITC3I6iPFo5xy8fKT+zP2mxElqMTNfDWnDm5V3
	gR7oip56eas6RY6jJjYOZUKA20KTz+YPcUwmczCzM4uhlupTPJra88z4537Dcj04W3YmqI6sVJ2SE
	HHggiINgtYlZHU2LN9rXaPMbP2dOlH8wh1riM81VZzeB48BZ+dNbQzb4d62KuzmwAyGglqbok71kz
	WImWbP/s4TOrvIaxlGmNDDB1IuTHgnTS9nxEDiTHO9M7ihRlwh425AcBIV2FIewm+TVNNVrzom0wl
	Us8U9o4A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqYCj-00000003BD1-2icq;
	Tue, 17 Sep 2024 13:25:17 +0000
Date: Tue, 17 Sep 2024 14:25:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZumDPU7RDg5wV0Re@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>

On Tue, Sep 17, 2024 at 01:13:05PM +0200, Chris Mason wrote:
> On 9/17/24 5:32 AM, Matthew Wilcox wrote:
> > On Mon, Sep 16, 2024 at 10:47:10AM +0200, Chris Mason wrote:
> >> I've got a bunch of assertions around incorrect folio->mapping and I'm
> >> trying to bash on the ENOMEM for readahead case.  There's a GFP_NOWARN
> >> on those, and our systems do run pretty short on ram, so it feels right
> >> at least.  We'll see.
> > 
> > I've been running with some variant of this patch the whole way across
> > the Atlantic, and not hit any problems.  But maybe with the right
> > workload ...?
> > 
> > There are two things being tested here.  One is whether we have a
> > cross-linked node (ie a node that's in two trees at the same time).
> > The other is whether the slab allocator is giving us a node that already
> > contains non-NULL entries.
> > 
> > If you could throw this on top of your kernel, we might stand a chance
> > of catching the problem sooner.  If it is one of these problems and not
> > something weirder.
> > 
> 
> This fires in roughly 10 seconds for me on top of v6.11.  Since array seems
> to always be 1, I'm not sure if the assertion is right, but hopefully you
> can trigger yourself.

Whoops.

$ git grep XA_RCU_FREE
lib/xarray.c:#define XA_RCU_FREE        ((struct xarray *)1)
lib/xarray.c:   node->array = XA_RCU_FREE;

so you walked into a node which is currently being freed by RCU.  Which
isn't a problem, of course.  I don't know why I do that; it doesn't seem
like anyone tests it.  The jetlag is seriously kicking in right now,
so I'm going to refrain from saying anything more because it probably
won't be coherent.


