Return-Path: <linux-fsdevel+bounces-78947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFqzFwrLpWnEFgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:38:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C810A1DDEB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2FA53046687
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3A2423A89;
	Mon,  2 Mar 2026 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehTo4NjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD9317143;
	Mon,  2 Mar 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473053; cv=none; b=Qs2H2Fv4NH/Y9/v5SDkd37StWwobsSAbcQ3KOIjA+TmJPLjVGY690uXOBDwXBgTGL3h7Y8BO1gzleTRG8qwF/npYs3Sf96Nd9lAXlkJlaW4VFkK5XBmhCr/gCdKbHaF9MDyaI5QvjmN19s1y18KMD1n3oGDJxyN196rXBQhWKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473053; c=relaxed/simple;
	bh=HBZU7lDrqfiSFQCOqZP8QIuscOzDLO1xfpjrl0wUxfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1OvITxG9UIA7TOQWN7cM1FYMgR1Ks3KiotPvAyPBjoyNq5itecnz5ukuy0uJ5UBwOgbH9BN70sfapc2NkBmAxBhSCoCG8JxUhZRlADWsUEOnXOi6DXGcdyhoWoJawPeptKvFo/z00rSpIiD3gbeb8zXjDWAZAQJrv1hYGlxHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ehTo4NjD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HBZU7lDrqfiSFQCOqZP8QIuscOzDLO1xfpjrl0wUxfI=; b=ehTo4NjDnDbSNIxrlRcltHgLiK
	ZFXRHXew8As8wOR37BRxXGVN6MNhYqSj036P4OQs0tY6JLOKITQJ88+z8sdEsQcWgwNIbN0fZVtwv
	7Ms57LIVncTKXYIGWSVZpxXDRqx//BZsbVounzAl9KGiWVD8c+3+GNEhHQR4jpQ2OJewH48yL2PDS
	581FS0SqPSNntr8+8yPPW8Jnk5q0RX852O3bKuvptQu2PuqyInVMRO8pGBOUx//Rjas5xux+u67UY
	pLqcqTYZlbLIbxuG2Fe5wcgnm/zioxUglEBT+zfUPnQ93XE5/4Vql0lOjI2Rq12DOwfx7kcG60GEe
	v+klc6kg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx7Cu-00000009qOO-0PEU;
	Mon, 02 Mar 2026 17:37:24 +0000
Date: Mon, 2 Mar 2026 17:37:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Tal Zussman <tz2294@columbia.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/2] filemap: defer dropbehind invalidation from
 IRQ context
Message-ID: <aaXK0_HqEnU5SK61@casper.infradead.org>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
 <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu>
 <wen63cjbk3k54mjzgw7zftsuze6bzxmdk5u5wdjabzdiqg645k@67666k5lrevh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wen63cjbk3k54mjzgw7zftsuze6bzxmdk5u5wdjabzdiqg645k@67666k5lrevh>
X-Rspamd-Queue-Id: C810A1DDEB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78947-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:11:19AM +0100, Jan Kara wrote:
> Folio batches are relatively small (31 folios). With 4k folios it is very
> easy to overflow the batch with a single IO completion. Large folios will
> obviously make this less likely but I'm not sure reasonable working of
> dropbehind should be dependent on large folios... Not sure how to best
> address this though. We could use larger batches but that would mean using
> our own array of folios instead of folio_batch.

That's why I think we should allow the bio to be tagged as
"finish the bio in workqueue context",
https://lore.kernel.org/linux-fsdevel/aaC3LUFa1Jz2ahk3@casper.infradead.org/

Why remove the folios from one data structure, to put them into a
different data structure that they don't necessarily fit in, rather than
just postpone processing to workqueue context?

