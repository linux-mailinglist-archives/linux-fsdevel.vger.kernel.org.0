Return-Path: <linux-fsdevel+bounces-51548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A89AD828C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E903A0371
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7319239E63;
	Fri, 13 Jun 2025 05:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S8W4S5Jd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AD223DD1;
	Fri, 13 Jun 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792685; cv=none; b=iJQOsIJMt0l6R8mwwILr2crtLLhGZGJZ8ANSL/Sd9e6sRY5c+tCL9+cnT/Ul8VQIBX9U408vMqWhYoa4nsThaQWyGn9JtJ3HIEjWaqrR1BtuYv5nnsrc+mxIMovG6idudu0nRqEGPOSnGSDIPkQGtMS12U1ckXS9E4mnfAdiYe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792685; c=relaxed/simple;
	bh=qV3PIfgDEASr6d/+C3HiHZ9uZ0RXzdMSvc5FK30jhKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFp1MUq/lj0xNuWWkMjrjJRn3IkuywwIWRBpkIF2Aul44QI22KUno9d+9FQpToqlzW5FervHXhpTixaUibzZVniljZx0jQnE+hRfxSUIRHz0SpJKJbKaJYnBEQW8xY+hLMuHM9yZhG3sYlR1qHwrdzATMArjL5xMLlfPa95jI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S8W4S5Jd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IrtORiAaU7lBlnCrqLBSXmhTmBml8+sBucUzbGsbw64=; b=S8W4S5Jdz+4tfYF3qztWNl6c14
	fy0zpwFIEUH4zPX/xbQod/oRluK93ICDBaCnkXQshFZBDe/p3nRRzDvl1RXbLahLLyUaTBlp6LsYL
	NgbnCfjap4VsuzZQ6GOE64CuUatOuXZWNqqNCWK2IPVI5MDwlyS8wniuAHNsqjnhL8xEePUfoob3/
	GFfdK+us2p0LrdRWBkq7iymdD3/0ZTXNR3mrUyhVNBQuBFtWLkHBiwQQAsnLyTNv72g9l1drXP18V
	Cm8sOIn/ISDp77QYbcpQzsydB/bXDBz+EPiNKHU28FdMNzE+w7Gl42AjxtZ4sBaNUPSTuWUgLXQYC
	OPC72TQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPx0V-0000000FNnl-3bSl;
	Fri, 13 Jun 2025 05:31:15 +0000
Date: Thu, 12 Jun 2025 22:31:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
Message-ID: <aEu3o9imaQQF9vyg@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <54acf3548634f5a46fa261fc2ab3fdbf86938c1c.camel@kernel.org>
 <aEqEQLumUp8Y7JR5@infradead.org>
 <aEs6gmTXzhzuDZOI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEs6gmTXzhzuDZOI@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 12, 2025 at 04:37:22PM -0400, Mike Snitzer wrote:
> On Thu, Jun 12, 2025 at 12:39:44AM -0700, Christoph Hellwig wrote:
> > 
> > Another thing is that using the page cache for reads is probably
> > rather pointless.  I've been wondering if we should just change
> > the direct I/O read code to read from the page cache if there are
> > cached pages and otherwise go direct to the device.  That would make
> > a setup using buffered writes (without or without the dontcache
> > flag) and direct I/O reads safe.
> 
> Yes, that sounds like a good idea.  Just an idea at this point or have
> you tried to implement it?

Just an idea.

> FYI, I mentioned this earlier at one point in this thread but I was
> thinking the IOR "hard"

Sorry, but what is IOR?


