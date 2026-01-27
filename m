Return-Path: <linux-fsdevel+bounces-75571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BThHK1JeGn2pAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:14:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E14BD8FFAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5BB030209DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 05:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5C328B6D;
	Tue, 27 Jan 2026 05:14:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A930AD1C;
	Tue, 27 Jan 2026 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769490846; cv=none; b=lQA/0eKXUscSOsvYTnYYu9UiZHLsg8vZaClM0Zbqf5+mzF4gYZLYT3vP8th25MFT2Awal9a+tonZmevoS7qFkghd3vU0ga7LhGvB1ufP/5iNG7N3XJB5jfKgm32An9Ljsj+6GuhGj20q/Kzi8FpsKnLMdWeJa78c7RqodTZ6CEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769490846; c=relaxed/simple;
	bh=qAAidTqt62wLQtqzAicedo/B6O7vF3ti36gyT7k/BSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAe49iwisGy0jCx/H5/PhZbSKbH/y5wfPsfK3UKSW7xHMPsG12ZRP9wU7B/gYaUjPFgXaR9c4znoucBfs2FJPfHggWF9umPH6YqLuS/J9tNREd0BuLmAKbTMRtDAi2XrpNKYn93yymnxSTnvsAjbwYHqSI7JsPyx/s4dnjUttqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A94D227AAE; Tue, 27 Jan 2026 06:13:53 +0100 (CET)
Date: Tue, 27 Jan 2026 06:13:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kundan Kumar <kundan.kumar@samsung.com>
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs
 helper from bio code
Message-ID: <20260127051352.GA24293@lst.de>
References: <20260123135858.GA24386@lst.de> <20260119074425.4005867-4-hch@lst.de> <20260119074425.4005867-1-hch@lst.de> <1754475.1769168237@warthog.procyon.org.uk> <1763225.1769180226@warthog.procyon.org.uk> <aXemDMAfgC6vCU9K@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXemDMAfgC6vCU9K@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75571-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E14BD8FFAA
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:36:12PM +0000, Matthew Wilcox wrote:
> > > Hmm, this just moves around existing code added in commit ed9832bc08db
> > > ("block: introduce folio awareness and add a bigger size from folio").
> > > 
> > > How do we get these network read buffers into either a user address
> > > space or a (non-bvec) iter passed to O_DIRECT reads/writes?
> > 
> > Splice from TCP socket to pipe, vmsplice from there into process address
> > space; DIO write() from there I think should do it.
> 
> Some other ways to get something that isn't a folio mapped into a user
> address space:
> 
>  - mmap() a vmalloc-allocated buffer.  We don't have a good story here
>    yet; we could declare every driver that does this to be buggy and
>    force them to allocate folios and vmap them.  Seems a bit
>    unreasonable and likely to end up with a lot of duplicate code with
>    bugs.  I've prototyped another approach, but it's not reeady to share
>    yet.
>  - mmap() the perf ring buffer.  We could decide to refuse to do DIO to
>    this buffer.

I'm confused.  Your example are all about something that would happen if
we actually split up what is currently struct page in some way.  But I
read Dave's mail as something is broken right now already.  Which of
those is the case?

> The eventual solution is that page_folio() will return NULL for pages
> which do not belong to folios.  That's independent of whether we decide
> to make user-mappable-vmalloc contain folios, or whether we have some
> other way to map/track pages-that-belong-to-vmalloc.

vmalloc is a tiny wrapper around alloc_page* + vmap/vm_map_area, and a
lot of code all over the kernel relies on that.  Trying to have a
separate "memory type" for vmalloc is going to break things left right
and center for not much obvious gain.  I'm not going to say you can't
do it, but I doubt that is actually ends up easy and particularly
useful.

