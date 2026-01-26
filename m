Return-Path: <linux-fsdevel+bounces-75471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBA2IMaAd2m9hgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:57:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40089D0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 753BE302F270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B0155757;
	Mon, 26 Jan 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/ooKLWZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262223EAB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439338; cv=none; b=RfXI2OElfNvKT6I9MwNSFs4+fd3TZoxmNlZwhVzHPzd/4dYbpq4E9A3XO4woGyFkLx0KAA8rm4TjrT5hHKCodCEwID6gnLslVw6v1ddubO6IZIw3tQhn4JEmSb3hBWjSBES3hFZioLAeRCmuKLJaWDru3KBvsRqWTJt/m8QYTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439338; c=relaxed/simple;
	bh=3sAG/VVSwzncyQMX0VHpDmEDoZhBrlVYzDAgLgv7i4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9ZcNsUxbfOQ34QSAeZ7A1juXg5c+RYcevSdkevWtpVJeDl4yh6+NYTDX+8ZIxMo2oAwjJ8WxkCGxixQ78vDLC0RQyHnS51ZYIQ2B7xwUVNXuuw/v2FepdZPVeYQslZ9ykwUO6lgDDu4i1fo16LzSpMCnTcLvGp+wsw5Fzk5ss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b/ooKLWZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WJ7fS9+ojqoWItAofx71Uka9v5Qa3uztN6wqXQuZ26I=; b=b/ooKLWZp1ES8BrZRXQRANi0Tn
	+SMH107JVr/1GYc6Mo5L9iW08z2NiZ+TqhcWQnYpL+EzmFvdnaulIwUFkqFLmqv/cWuEfL72rxDEa
	gN6h5FxrWZMr/ITA4OJ6DLJyAi3RlmqLs1SR3n1b3OQaikNoPHYKcvUUp3IasNrAwkTxb8Dcfzkhe
	3YcvkZRnEOvKfJfCOwXZvDH8i+VHUXVvmtDiBpGrbtKdN4wqYiAGBjX9jnR8yx018djHM9EfgxVns
	9XU2tSFWSA7IL8Ha2+nG7HKdVwRvXWfPjBe9dUfH3Py8x7VdC4JV0PAW2eo5JeaglLiyKuN3LyAWW
	GNCwB62A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkO03-000000063v5-1I3K;
	Mon, 26 Jan 2026 14:55:31 +0000
Date: Mon, 26 Jan 2026 14:55:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	djwong@kernel.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] iomap: fix invalid folio access after
 folio_end_read()
Message-ID: <aXeAY8K12KKf9d4_@casper.infradead.org>
References: <20260123235617.1026939-1-joannelkoong@gmail.com>
 <20260123235617.1026939-2-joannelkoong@gmail.com>
 <aXb_trkyt-uzdIkd@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXb_trkyt-uzdIkd@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75471-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,casper.infradead.org:mid]
X-Rspamd-Queue-Id: CE40089D0E
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 09:46:30PM -0800, Christoph Hellwig wrote:
> > -	if (ctx->ops->submit_read)
> > -		ctx->ops->submit_read(ctx);
> > -
> > -	iomap_read_end(folio, bytes_submitted);
> > +	iomap_read_submit_and_end(ctx, bytes_submitted);
> 
> Can you drop this cleanup for now?  I think it's actually useful,
> but it should be in a separate patch, and creates a conflict with
> my iomap PI series.
> 
> The actual fix looks great and simplified the code nicely!

I don't think it's just a cleanup -- I think it's a bug fix.  But, yes,
it should be a separate patch because it's a separate bug.  That bug
can be hit if the folio passed to iomap_read_folio() covers more than
one extent, the first call to iomap_iter() succeeds, and then the second
one fails.  Now we have a folio with a positive read_pending that will
never become zero, so we'll never unlock the folio.

Not sure how we'd write an fstest that would exercise this ...

