Return-Path: <linux-fsdevel+bounces-75501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO5ZMB2md2lrjwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 18:36:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 861498B8E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 18:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C8A83018C00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF334D4DF;
	Mon, 26 Jan 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZdGEOhbh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB1168BD;
	Mon, 26 Jan 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448985; cv=none; b=H6bPzc0L/s2vQO7gsWbVgS1MGH22pwkDzJeUbpscIvzJWEAzUHci1mZsyCJJinRAGGVb6m3Fmm58b/q6YaSaagOd81PoXZCg9ICXYmd6vJ6IaKM2czpL0DhYS6l95XoHvbR15059ek+lkGf2tUc6pwJCbdeW95k/x7U8z9qBF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448985; c=relaxed/simple;
	bh=IR0RiDtRQxTU5cFZWnSpngyOZ5KIXKQAiOq7J1bRe1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkYT+hXUxO6WLDo2aAGyW8IgmWm7oCB6zyMox9he/EGLljvhUOgOpQfYyCpBjoS/4ewWf0zkf6xZlikMNuzbt66RA+wSYIBFAFBsv3IWTKjDsmN3GxFrkv5WNE8J2vcJu/qdQv/QeXUBVW7ESmaz63l/nR9Jit3xgPE/a1xj/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZdGEOhbh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aOwxYhMrFGZ9qZqMNlKYd/PzK3JSyijS2/c7mOvz79I=; b=ZdGEOhbhsQBDNoujaXcJJsynRG
	7m90rQePpb8HU1v0zFrD/R+zUJXABXymJvWhL9jMOtocsqPxkxAzMQSC35g27D9d9QUlHf2V7PM5a
	e4Vnr9gi/yetTTTfrsJRamH1iXRzeoZfcAgxc146JADzgurDi2s0b5x8ZmhXMEmozh2QTt+dWwDwL
	uRjQPCg2SCiLkMmGFmAozYkXpHm/78fqR+tjClhgj3yxvXjYuBYGvOO2AOHxbFxf0Dee3S7T/LSh6
	F+r+qt42haSXx4NpOeVF6JGyvf5AR4Tr1wzraAahfIRVB7TXB+6zLDqHhCVl7blncMP2VTv5Fdvg7
	sgQQpDaw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkQVY-00000006EY8-46mD;
	Mon, 26 Jan 2026 17:36:13 +0000
Date: Mon, 26 Jan 2026 17:36:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kundan Kumar <kundan.kumar@samsung.com>
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper
 from bio code
Message-ID: <aXemDMAfgC6vCU9K@casper.infradead.org>
References: <20260123135858.GA24386@lst.de>
 <20260119074425.4005867-4-hch@lst.de>
 <20260119074425.4005867-1-hch@lst.de>
 <1754475.1769168237@warthog.procyon.org.uk>
 <1763225.1769180226@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763225.1769180226@warthog.procyon.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75501-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 861498B8E4
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:57:06PM +0000, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Fri, Jan 23, 2026 at 11:37:17AM +0000, David Howells wrote:
> > > Christoph Hellwig <hch@lst.de> wrote:
> > > 
> > > > +static unsigned int get_contig_folio_len(struct page **pages,
> > > > +		unsigned int *num_pages, size_t left, size_t offset)
> > > > +{
> > > > +	struct folio *folio = page_folio(pages[0]);
> > > 
> > > You can't do this.  You cannot assume that pages[0] is of folio type.
> > > vmsplice() is unfortunately a thing and the page could be a network read
> > > buffer.
> > 
> > Hmm, this just moves around existing code added in commit ed9832bc08db
> > ("block: introduce folio awareness and add a bigger size from folio").
> > 
> > How do we get these network read buffers into either a user address
> > space or a (non-bvec) iter passed to O_DIRECT reads/writes?
> 
> Splice from TCP socket to pipe, vmsplice from there into process address
> space; DIO write() from there I think should do it.

Some other ways to get something that isn't a folio mapped into a user
address space:

 - mmap() a vmalloc-allocated buffer.  We don't have a good story here
   yet; we could declare every driver that does this to be buggy and
   force them to allocate folios and vmap them.  Seems a bit
   unreasonable and likely to end up with a lot of duplicate code with
   bugs.  I've prototyped another approach, but it's not reeady to share
   yet.
 - mmap() the perf ring buffer.  We could decide to refuse to do DIO to
   this buffer.

> > How do we find out if a given page is a folio and that we can do this?
> 
> That's a question for Willy.

Today there's no way.  Although you could test for page_has_type()?

The eventual solution is that page_folio() will return NULL for pages
which do not belong to folios.  That's independent of whether we decide
to make user-mappable-vmalloc contain folios, or whether we have some
other way to map/track pages-that-belong-to-vmalloc.

