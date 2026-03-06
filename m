Return-Path: <linux-fsdevel+bounces-79655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGAAC0Qgq2mPaAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 19:43:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C6226CE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 19:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81DDA30A8F09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A736F413;
	Fri,  6 Mar 2026 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wg/i8/QW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44553431FD;
	Fri,  6 Mar 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822477; cv=none; b=bm/K0o8rxxgcA7JVvUOasKbcPV+n4dg4ipUNW2qvCsMCnSMcYU9dH3ic4uhZmV5LGKZIvzqtnFO0U1D8+27ss+n4nmRvTvt56SaS5wtVwZDe1FkYUGFRt1IBSVzRMH790MxQnLMh/n5hlleeKXGEDrpcEZ4xWUpTVfb3xGIDHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822477; c=relaxed/simple;
	bh=pVQX8UbFQFuwDfMZUkbjtXBKe6Lw0V+LZTPRaPnqEoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QX+Q0ILwEA3QLYlVgfqMGmscV6c4LWMu7bcpAGSFUIojBPHmXMwI3OtBU+jpEOe6UvpM8cA93Dgs9AJhibFKHwAdOYV70v1KYKOCkBwVSSMl0aykDH3xdzFVaLpk/aYGxtGnDrstfwbJZH8LW8YTQ05gCwTU26IBhdym8qWR304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wg/i8/QW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VM5um0Un0dBqpJi9mEsTrBTXwrxc0DE4YjAakbTEyXQ=; b=Wg/i8/QWd4Ak3VOJCLKU4dOiuQ
	xhhympkoBIIrndvU9oNWzizRvbkRQ3jezMSezju9eBLweSBuzsBZdBVnJOYqnOrHMvr5SmlnVP7Rg
	Ng7hBgG47iGveYVWERXxjBdpvNRmq5AUyqBbP+7Nd6VQdOMNY/jUo+w/KgoQdH47g2HRf2TYFAWfw
	CCM7PTZXAotdCUsSZQMpGSkloS/Q2nDnr0/Aq9/YgBeRNfhWNv8pPcEzDkNj6deFHagI4erqIHgJp
	eteoq5s9zoTi8qpjjo0mqYvWpKAt2FdK+b+ImQ30AyTXD4aDaJV9zgu+yWXF0XFKvpq91UIqEg4U3
	Eoj2sqbg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vya6m-0000000H9Eb-2cL2;
	Fri, 06 Mar 2026 18:41:08 +0000
Date: Fri, 6 Mar 2026 18:41:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Chris J Arges <carges@cloudflare.com>, akpm@linux-foundation.org,
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aasfxLYRWzNodAYO@casper.infradead.org>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
 <aasddOvIfcMYp3sk@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aasddOvIfcMYp3sk@thinkstation>
X-Rspamd-Queue-Id: A95C6226CE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79655-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 06:36:30PM +0000, Kiryl Shutsemau wrote:
> The proposed change doesn't fix anything, but hides the problem.
> It would be better to downgrade the VM_BUG_ON_FOLIO() to a warning +
> retry.

The trouble is that a retry only happens to work in ... whatever scenario
this is.  If there's a persistent corruption of the radix tree, a retry
might be an infinite loop which isn't terribly helpful.

