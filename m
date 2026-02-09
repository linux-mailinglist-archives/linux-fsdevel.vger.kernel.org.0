Return-Path: <linux-fsdevel+bounces-76750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5EvkFOA9imn7IgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:04:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF6114547
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8938E300BB91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F54329C70;
	Mon,  9 Feb 2026 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZMITLXbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206E328638
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667482; cv=none; b=rzBqOyLmHpPdLLAX/2m77qxy7huuTR5PTq8hWr2oGxcerGnAvOJtE+ZLWRL2TS8AJ1++WVJ3/1cYwVxMt0psCAgsfPllM87zHivQvaeZr+V6kENmMQT4LNCi10bTAl2Gtv6xnEFoomNJl4VaXSW98cgy6ncd19rDnAsqBOWQhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667482; c=relaxed/simple;
	bh=FKcpq47ihM6dU17ipJg966Goby+OB3X7sF+1HRCBXo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH2Ga22KcMCeOIFJP5WjDKF0i9eN+t/K6UsBvYvxijXUbEvZNEAoybg4z7D7I2YudOucHDnNV9fMC3ELA+g49vFynj4rw4+kP1xARn8kLjlYtth9WTEMgAzWnVe5M5lOwB8P4x2r0crYPKrH3Qq5fVVV1cYK4Wcn36l/4wKlyIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZMITLXbG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=epmRFCFxvZNEpcmqqEDNPoTwBlQhQNNTs//USnqXsXM=; b=ZMITLXbG55vw/IZ4lBvE8cLgt0
	Z7hBWFOfLVacwsc8xgwnOByXNeWXMBAq657G7D13f6q91em36/jU+3pRbzAU6LaF6bxozISga/ghd
	J+fe7d2wc05T5qEm9CS0LjvSHgl1kMXG9vdwL+CUbtwgziq2p/aJJEa+ObE5174LmJ3jJCdBlrFXD
	ftB2am8Qacj+EDH3SQbYlSxFFRsSN826XvjG0HZXEEFGU0yrRn3pyYel/sfpDC076DXvb6PgTy6Es
	oMKjkbbuLHKXjYGLjZh1dA7HoekmsVo1s0LrZTmNYiU63pPKawYP3VqEiG5Fze/FrmkrKfks2HLjd
	mdDmhj8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpXUs-00000009z5P-3UxH;
	Mon, 09 Feb 2026 20:04:39 +0000
Date: Mon, 9 Feb 2026 20:04:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] smaps: Report correct page sizes with THP
Message-ID: <aYo91kREDEIsM60V@casper.infradead.org>
References: <20260209193223.230797-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209193223.230797-1-ak@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76750-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim]
X-Rspamd-Queue-Id: 7CBF6114547
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:32:23AM -0800, Andi Kleen wrote:
> +	} else {
> +		unsigned ps = vma_mmu_pagesize(vma);
> +		/* Will need adjustments when more THP page sizes are added. */
> +		SEQ_PUT_DEC(" kB\nMMUPageSize:    ", ps);
> +		if (mss.shmem_thp + mss.file_thp + mss.anonymous_thp > 0 &&
> +		    ps != HPAGE_PMD_SIZE)
> +			SEQ_PUT_DEC(" kB\nMMUPageSize2:   ", HPAGE_PMD_SIZE);
> +	}

I'm not a fan of adding support for just two page sizes when we already
know that we need to support many.  Particularly not with such an
uninformative name as "MMUPageSize2".

Something like MMUOtherPageSizes: 64Kib,256KiB,2MiB would work for me.
But maybe other people have better ideas.

