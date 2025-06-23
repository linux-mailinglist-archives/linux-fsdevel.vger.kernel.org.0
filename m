Return-Path: <linux-fsdevel+bounces-52572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5BFAE459E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF2817CAC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393E253F08;
	Mon, 23 Jun 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0g9CUqnB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178E1957FF;
	Mon, 23 Jun 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686785; cv=none; b=fK7KiwMUhqIrrnOp6dUbxzja3zBV8CZvUTmm4GZArO6lQURxj8wEs90nMd0MvMWJglCI7XGQp8+AXyXxZ8SrzXRfCb10GDAhDAa1uVYFVMCdzjrSpynXewJoGPGNV4zaBFAAPSsjCSsNGNr/FpjdZ72OHFg1GOb5Z+1VsXAOB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686785; c=relaxed/simple;
	bh=qehOKHW0DXOUEoQt7yoJi/kRC/gnYrNDCeKceRmhrsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZO7w1j82gWEZJ98ZZTfGeKFxfjEqfWttuTwI2w9Begw7fF5MjLsDZugfxeFnp8L6n4swoyr2u+8g/0qcFrfCpZCKfWagEkdSp8+lCkXxsgsqt9ujkZ2PsH1PkwWoYefw6wH3ZK+7+RV7TDHA1Fv2Tp7Adzp1gh8Wq+4BbvI0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0g9CUqnB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YVHSJAiRhj7qf6Q+0VoJztFQx2dBI/eUpzohiN1zMCc=; b=0g9CUqnB1CfKDqlHsdyDKWKIJR
	AbYW4CnHUKJerou9qQ1LyzJhKkI2On3ZQyoBz1p3EKk/ybJyUzUaIQPSGxRosBwBsfyRAB1tm4m3T
	qlDA5bF99eMEprEbvv9J5UvRfUoejni6zhLUmN5M8gaZ+6+1NxAqWMH+rrSb+wzOYmBu5oR95udXJ
	lPrS0doZWtcg1PEbYrSArNVAMJCMYZ0W4B8sWRLKHWn8eefz/HUuhVRhLWO40J4ELRCv8hxQVteU5
	e6UiPIU9BVb70rl/h9KAz55Z2rvMQuZJjRB/Pu7HemRvxEwekrSST5U5sOzDxUdoVc9mtKLYLQGVW
	XCFluUZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThbY-00000002wC1-1uG3;
	Mon, 23 Jun 2025 13:53:00 +0000
Date: Mon, 23 Jun 2025 06:53:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <mszeredi@redhat.com>, torvalds@linux-foundation.org,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: AF_UNIX/zerocopy/pipe/vmsplice/splice vs FOLL_PIN
Message-ID: <aFlcPOpajICfVlFE@infradead.org>
References: <1069540.1746202908@warthog.procyon.org.uk>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <2135907.1747061490@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2135907.1747061490@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 12, 2025 at 03:51:30PM +0100, David Howells wrote:
> I'm looking at how to make sendmsg() handle page pinning - and also working
> towards supporting the page refcount eventually being removed and only being
> available with certain memory types.

Yes, that would be great.

> The question is what should happen here to a memory span for which the network
> layer or pipe driver is not allowed to take reference, but rather must call a
> destructor?  Particularly if, say, it's just a small part of a larger span.

What is a "span" in this context?  In general splice unlike direct I/O
relies on page reference counts inside the splice machinery.  But that is
configurable through the pipe_buf_operations.  So if you want something
to be handled by splice that does not use simple page refcounts you need
special pipe_buf_operations for it.  And you'd better have a really good
use case for this to be worthwhile.

> And then there's vmsplice().  The same goes for vmsplice() to AF_UNIX or to a
> pipe.  That should also pin memory.  It may also be possible to vmsplice a
> pinned page into the target process's VM or a page from a memory span with
> some other type of destruction.  I don't suppose we can deprecate vmsplice()?

You'll need a longterm pin for vmsplice.  I'd love to deprecate it,
but I doubt it's going to go away any time soon if ever.


