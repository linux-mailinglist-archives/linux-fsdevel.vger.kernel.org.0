Return-Path: <linux-fsdevel+bounces-75959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kORwEFX3fGllPgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 19:24:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82364BDAF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 19:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68553028343
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157037D12F;
	Fri, 30 Jan 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nSn+abVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCF3033C7;
	Fri, 30 Jan 2026 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769797409; cv=none; b=HXZ3Ttm5n4IC0zVECjvjA0RBCOfg9iiQPNPB4/2XDzIkWpdrpBe7lcsTUAr9UzTcOaTmnIgciBmOwzvq3MufLv5WCAGYBuMQ8Q2sE+XYGRsZftyEDSxURdio6lXqiQkQc9J7zoqooPkCZ7J/gVBYgGm0vrWCioWGinGIgKEAFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769797409; c=relaxed/simple;
	bh=hDFGfBUQTNcGRF5QSFDC+wtG0a7h2rY4suY/Ty+5ces=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDB+/GCMYdirww1fw8gmVdW2B8fWEQ6qlvba+Mh+Q3dxXFtWBT73EGepKnkgH/msDpqMP1OH+ggkKA3AEB9p1Z6kVNDx17pqpIQ2CJEFYtBkNtz3Lw0RkzlwueTRaxjuP2lgqvMl/gnCLwEv84SRF/ZtH+hr2TzaUooWkcNL95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nSn+abVy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rDEW4OUvtwNYIvb0JxJqDDmN2rNNIpXu6A6JRhft770=; b=nSn+abVyFfUEhyQS4qe1wpigsc
	+6t4hZE7DAmqBOow+unRIQNspaZWpESvlCgRhGqSYX/5Nf7FsQygUwS4lcRkjs0XG/2389lkckJ3R
	WSm/feQ4QCkIafrfJzP/11+HG8vYS7Yjeg8K2/1kI6xbje0hvfVLmBkAM28VqiqquCEMOt9nQ2do8
	vCMfG3sD10ABUHbOXc2FaxC/OhAlpPDPsAjrZG17ekcPG/mE7ZRz0F822eoH9mfFPKVKjp7MCGFQm
	BC+aF8+Os+fhfiyQpTSQ5GsQPfAf4Ln5GrCrfowYCu8f46ThqsrKRdvG3Y8iGC9JPRV7IyitRmiNW
	20e5XiXw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt9O-0000000CZDw-47Om;
	Fri, 30 Jan 2026 18:23:23 +0000
Date: Fri, 30 Jan 2026 18:23:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, boris@bur.io, clm@fb.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
Message-ID: <aXz3GhxJU15d_ebV@casper.infradead.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
 <aXw-MiQWyYtZ3brh@casper.infradead.org>
 <00d098da-0d01-43f9-9efb-c18b6e8a771e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d098da-0d01-43f9-9efb-c18b6e8a771e@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75959-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmx.com,bur.io,fb.com,suse.com,vger.kernel.org,meta.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82364BDAF9
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 09:10:11AM -0800, JP Kobryn wrote:
> On 1/29/26 9:14 PM, Matthew Wilcox wrote:
> > On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
> > > Another question is, why only two fses (nfs for dir inode, and orangefs) are
> > > utilizing the free_folio() callback.
> > 
> > Alas, secretmem and guest_memfd are also using it.  Nevertheless, I'm
> > not a fan of this interface existing, and would prefer to not introduce
> > new users.  Like launder_folio, which btrfs has also mistakenly used.
> 
> The part that felt concerning is how the private state is lost. If
> release_folio() frees this state but the folio persists in the cache,
> users of the folio afterward have to recreate the state. Is that the
> expectation on how filesystems should handle this situation?

Yes; that's how iomap and buffer_head both handle it.  If an operation
happens that needs sub-folio tracking, allocate the per-folio state
then continue as before.

> In the case of the existing btrfs code, when the state is recreated (in
> subpage mode), the bitmap data and lock states are all zeroed.

If the folio is uptodate, iomap will initialise the uptodate bitmap to
all-set rather than all-clear.  The dirty bitmap will similarly reflect
whetheer the folio dirty bit is set or clear.  Obviously we lose some
precision there (the folio may have been only partially dirty, or some of
the blocks in it may already have been uptodate), but that's not likely
to cause any performance problems.  When ->release_folio is called, we're
expecting to evict the folio from the page cache ...  we just failed to
do so, so it's reasonable to treat it as a freshly allocated folio.

