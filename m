Return-Path: <linux-fsdevel+bounces-79632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pg5COgBq2msZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:33:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F16224F74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A393036ECF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F533F0749;
	Fri,  6 Mar 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CFJJubN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586F3EDABC;
	Fri,  6 Mar 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814510; cv=none; b=mgm/GYov/NYwWliDTxwgzsUQTfZd3yFujZQZwTsz4daKMILuWOBxdd5lpzRezo67e9x+i1TMLECwO7dnoqaWqHA/PfjhsMbiFV7a2NzbkRaYuE/DS/lTexJAUZcSIA19xijH4LmEiSxlxtZMYj76nqkBO0zG/DVhknOcrcCEhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814510; c=relaxed/simple;
	bh=AYMWoThi0NnfjPGX1UGO0PLN/rhWl59XCxXvQqb7xrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ8mVu1FCOeArnpVOlvAtrQyWPPQZYBolcYFqij3GqRL47ou4YMdTB1HuXoPvn0zQPLI22Jp71mClEwbKKfVJJMHqWVmorw5UX4pT0Zz1S8q6/dpZYfc1dXMXbWEfmSg2RldWjIt2z89rwkuLtdjtc/Z2PMhDkXPcZPMMjE/kSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CFJJubN2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IcWzAUhUQsNspCv6GqG4MtP9jZ6m38H8CKI6GAuV6PQ=; b=CFJJubN2q+3CnInjWYPhV8zU28
	mPjm1wr/eqieb7/M3uozkIsZRuMXZJ9JNU78GCm5o6ssr/BFYYP1TW9LWNIO4wOiWbxQlEXwZ2n2t
	WA6wGJ7RDsGhz8A36cS8svTVNiWOGMetYU/ZbSSOXMbr6b4AaaPp4phkxxn5PeHG4F61wI2znjgGU
	r+l1fjV3WuBSfKJ/PexXiufIYHLJDXQjvs1j/yl1K3hugCpX5Kx2CZKONDqlUkKlXzwAHqJ4iM8EZ
	H59qpDHTn2g46K5bxD9n/mbH/DvhOvsG7RHpNJhbrVfgRiZuaoqAfqY1S1CxIDvdqcx+LYNizGAlU
	yDjezxzg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyY2F-0000000GzX5-2dMe;
	Fri, 06 Mar 2026 16:28:19 +0000
Date: Fri, 6 Mar 2026 16:28:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Chris J Arges <carges@cloudflare.com>, akpm@linux-foundation.org,
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aasAo8qRCV9XSuax@casper.infradead.org>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aarVMrFptdXhHsX1@thinkstation>
X-Rspamd-Queue-Id: 73F16224F74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79632-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 02:13:26PM +0000, Kiryl Shutsemau wrote:
> On Thu, Mar 05, 2026 at 07:24:38PM +0000, Matthew Wilcox wrote:
> > folio_split() needs to be sure that it's the only one holding a reference
> > to the folio.  To that end, it calculates the expected refcount of the
> > folio, and freezes it (sets the refcount to 0 if the refcount is the
> > expected value).  Once filemap_get_entry() has incremented the refcount,
> > freezing will fail.
> > 
> > But of course, we can race.  filemap_get_entry() can load a folio first,
> > the entire folio_split can happen, then it calls folio_try_get() and
> > succeeds, but it no longer covers the index we were looking for.  That's
> > what the xas_reload() is trying to prevent -- if the index is for a
> > folio which has changed, then the xas_reload() should come back with a
> > different folio and we goto repeat.
> > 
> > So how did we get through this with a reference to the wrong folio?
> 
> What would xas_reload() return if we raced with split and index pointed
> to a tail page before the split?
> 
> Wouldn't it return the folio that was a head and check will pass?

It's not supposed to return the head in this case.  But, check the code:

        if (!node)
                return xa_head(xas->xa);
        if (IS_ENABLED(CONFIG_XARRAY_MULTI)) {
                offset = (xas->xa_index >> node->shift) & XA_CHUNK_MASK;
                entry = xa_entry(xas->xa, node, offset);
                if (!xa_is_sibling(entry))
                        return entry;
                offset = xa_to_sibling(entry);
        }
        return xa_entry(xas->xa, node, offset);

(obviously CONFIG_XARRAY_MULTI is enabled)

!node is almost certainly not true -- that's only the case if there's a
single entry at offset 0, and we're talking about a situation where we
have a large folio.

I think we have two cases to consider; one where we've allocated a new
node because we split an entry from order >=6 to order <6, and one where
we just split an entry that stays at the same level in the tree.

So let's say we're looking up an entry at index 1499 and first we got
a folio that is at index 1024 order 9.  So first, let's look at what
happens if it's split into two order-8 folios.  We get a reference on the
first one, then we calculate offset as ((1499 >> 6) & 63) which is 23.
Unless folio splitting is buggy, the original folio is in slot 16 and
has sibling entries in 17,18,19 and the new folio is in slot 20 and has
sibling entries in 21,22,23.  So we should find a sibling entry in slot
23 that points to 20, then return the new folio in slot 20 which would
mismatch the old folio that we got a refcount on.

Then let's consider what happens if we split the index at 1499 into an
order-0 folio.  folio split allocated a new node and put it at offset 23
(and populated the new node, but we don't need to be concerned with that
here).  This time the lookup finds the new node and actually returns the
node instead of a folio.  But that's OK, because we'ree just checking
for pointer equality, and there's no way this node compares equal to
any folio we found (not least because it has a low bit set to indicate
this is a node and not a pointer).  So again the pointer equality check
fails and we drop the speculative refcount we obtained and retry the loop.

Have I missed something?  Maybe a memory ordering problem?

