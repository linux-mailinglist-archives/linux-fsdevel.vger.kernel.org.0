Return-Path: <linux-fsdevel+bounces-75288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMXzGCl/c2mQwwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:01:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9087690A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5975F302DF60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A33148B4;
	Fri, 23 Jan 2026 13:59:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A630E0E0;
	Fri, 23 Jan 2026 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176746; cv=none; b=JyLUdKUW29W2mm1nMBH634B+QVqpziZGc5m1gMUjXkslKQslENBtWF2e6HW94BKL6woOmUasfjJS5cbsI+92r/0dcMP2Qy4kUZLzJ2z3OEZPpMI1WmGPFcJKjUqeaykNJ4kt1nqVnO3x7vEOAVbJmc7xKzXZLPstQDwdXeyKYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176746; c=relaxed/simple;
	bh=KsDWJy9IIzRYwrCXF2vcDTPb6iqadM+bu8+EwSQNB3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9agmW+WSG+NYl0h8monX0azhT356rSScaSafuse+XEaORUzAi8fGdLxVm+HXpNqsYlAvX/E31rNLG4LFzCkg3H/7o0Zjo3+FpRYgmFdDo9KsKqeBgFB5Zg5ohrWKXUerqE0UHU9v9Ohv52OYDh79Pn41UXPH8yXwnqz79/Tcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7930E227AAE; Fri, 23 Jan 2026 14:58:58 +0100 (CET)
Date: Fri, 23 Jan 2026 14:58:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kundan Kumar <kundan.kumar@samsung.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs
 helper from bio code
Message-ID: <20260123135858.GA24386@lst.de>
References: <20260119074425.4005867-4-hch@lst.de> <20260119074425.4005867-1-hch@lst.de> <1754475.1769168237@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1754475.1769168237@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75288-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 9A9087690A
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:37:17AM +0000, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > +static unsigned int get_contig_folio_len(struct page **pages,
> > +		unsigned int *num_pages, size_t left, size_t offset)
> > +{
> > +	struct folio *folio = page_folio(pages[0]);
> 
> You can't do this.  You cannot assume that pages[0] is of folio type.
> vmsplice() is unfortunately a thing and the page could be a network read
> buffer.

Hmm, this just moves around existing code added in commit ed9832bc08db
("block: introduce folio awareness and add a bigger size from folio").

How do we get these network read buffers into either a user address
space or a (non-bvec) iter passed to O_DIRECT reads/writes?

Can we come up with testcase for xfstests or blktests for this?

How do we find out if a given page is a folio and that we can do this?

