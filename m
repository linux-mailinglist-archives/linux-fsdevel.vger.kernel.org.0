Return-Path: <linux-fsdevel+bounces-79520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDoXO9TYqWlXGQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 20:26:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA55E2177F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 20:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90D423021442
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 19:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321983148D0;
	Thu,  5 Mar 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wm66T+DE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9C30F808;
	Thu,  5 Mar 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738684; cv=none; b=IvH2cklhz9/C03CTtbpVFHVGsNOlC10MyjgRA1CCJxoAOGdpc0Z51Z9g1MmMnfaXw682PEkSpslhOfgCozDQadQhfav4OX58vYA1GOHYeYVdz8zj8ghjEVz1yBfRLEXpDGgHL7hVMdqlXA4LBxxNL4SQALCNUY/VwBJc8r/VhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738684; c=relaxed/simple;
	bh=VQZCTw8npSsEXBQeBIgiwRrQ3Me1vZlu4H8Ji9uUvLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU9E1FNU2xF8j8afL4TbjT4KtasRCiY3l/l0NuhDp5LLQkI532cfK1pfj1brmYNilug1nurYR/YOvkwau37kETgzxDTpAB/VWptx9OZkpRrWqVgr2K9o0QIxOg4IRAqHzAiRICW0vDwYKX0XXW/fGi2vJCJ9deVluU2dpCDPMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wm66T+DE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ukeKHsAJYN16f/Xu0LO5gqLwIT6xwI1wOVLPLX/DdPw=; b=Wm66T+DEZS/jmgLAh1khMDshCD
	LTVFgMXFWTkJiQ8dy2V2YcnuU/pnomtNDnR9dvE6npT4TD0E3c2b2dhey0GkfpNIS/qgxprSXQwK2
	I0LjaOuzgAn0cuhs8m/fUyNsgulq/roXtzjCLmql+dvViBi9q9HaCFhi/e0BvvrtzvlVVRs5bhWR/
	PfzUvNM0X1nTTkox7poo6hboIpQkUxCZ3Or8P49NpeWxZo+hQgxEhV75pTAsPcDlFoF1S8v0KCphY
	/ag1Dz21FJ3HV2gUJNcSpLAEJFexPp8MTTTwcMmsw+6iyp2jJr1BRBBjVm1xLORVhfTxGESfO/uEn
	WvBqSbBA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyEJK-0000000FW3u-1Z5T;
	Thu, 05 Mar 2026 19:24:38 +0000
Date: Thu, 5 Mar 2026 19:24:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chris J Arges <carges@cloudflare.com>
Cc: akpm@linux-foundation.org, william.kucharski@oracle.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aanYdvdJVG6f5WL2@casper.infradead.org>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305183438.1062312-2-carges@cloudflare.com>
X-Rspamd-Queue-Id: EA55E2177F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79520-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:34:33PM -0600, Chris J Arges wrote:
> We have been hitting VM_BUG_ON_FOLIO(!folio_contains(folio, index)) in
> production environments. These machines are using XFS with large folio
> support enabled and are under high memory pressure.
> 
> >From reading the code it seems plausible that folio splits due to memory
> reclaim are racing with filemap_fault() serving mmap page faults.
> 
> The existing code checks for truncation (folio->mapping != mapping) and
> retries, but there does not appear to be equivalent handling for the
> split case. The result is:
> 
>   kernel BUG at mm/filemap.c:3519!
>   VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio)

This didn't occur to me as a possibility because filemap_get_entry()
is _supposed_ to take care of it.  But if this patch fixes it, then
we need to understand why it works.

folio_split() needs to be sure that it's the only one holding a reference
to the folio.  To that end, it calculates the expected refcount of the
folio, and freezes it (sets the refcount to 0 if the refcount is the
expected value).  Once filemap_get_entry() has incremented the refcount,
freezing will fail.

But of course, we can race.  filemap_get_entry() can load a folio first,
the entire folio_split can happen, then it calls folio_try_get() and
succeeds, but it no longer covers the index we were looking for.  That's
what the xas_reload() is trying to prevent -- if the index is for a
folio which has changed, then the xas_reload() should come back with a
different folio and we goto repeat.

So how did we get through this with a reference to the wrong folio?

