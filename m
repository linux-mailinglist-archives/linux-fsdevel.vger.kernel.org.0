Return-Path: <linux-fsdevel+bounces-76853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNbqHw5bi2ljUAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:21:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CACE011D131
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AED630490D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D59388868;
	Tue, 10 Feb 2026 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x+rjC7dW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AC2E7BCC;
	Tue, 10 Feb 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740465; cv=none; b=l92+OjS2WGQibgvAl7XY0mSprCJWdjvkZX7QGyjiMlD3x091mTZ0PUblbtKDvt7Ml+aEK6nZKcwbytf9XsyJHEt9MFeKqNYjRfFmOlPZw9dmj6TBrGrKsEM2Jq3I7TvglEHEHBEopWqDfR7PMiv5lStrPh9RFMZSusAQ3PekZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740465; c=relaxed/simple;
	bh=6m9ywh+7CtQXO9LDljzJqaiRP0wFg9sht4dJlcqYQek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZzUlnRqFrTdk8LWkCdq4gQwxgcKb72H9Y4kFHPBosZSmJL6alWeZTq2tlVqx79Bb0OddMgK1zAS1c1Z1bNsYIzezVFgYLDR4B1+2vI6Oa3rrtZi2s9m988Fgry7+c69+fcOxR+4DqFIACAWsK/MXdgNp0CDXJn6JvfKHiI3Z5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x+rjC7dW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y5zcvM3DB/X1SwvyJUyqRbQJv0rWF2nynRpSDGvWd4M=; b=x+rjC7dW5iF8EioZJe0rG9Kf5C
	IZuDHhWZXyfropzEmoDj30i8qkSHETD2zOAaeuywi2GKqFvNB1cjPa57LSl1GXzvptX5sGHOwcb9J
	AnwuT9dWYBy26H4w9wkC1j4R/QklqSzaNx4saBu3Ukfq2pwI9u1JRwD5JrWamJ1DIZYIEGjNvEVum
	aSA4naoyvxDQoq5/goSTjgAbqTtqI7YkxoXxZivkl6ukHNFcWI4g9/E9iycFVQC7WQi1NoHe7PFKZ
	gvIbzlEhAtvjzfxJ8LAWa5TIIOLjY27dtS1aQvc9hHkJMPLEQfaQdPDbM0xTV+cLMjf+3C0Tf4ReK
	SyTfZk9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpqU4-0000000HDdx-0zvi;
	Tue, 10 Feb 2026 16:21:04 +0000
Date: Tue, 10 Feb 2026 08:21:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] xfs: replace zero range flush with folio batch
Message-ID: <aYta8A6dBpjZyb8c@infradead.org>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129155028.141110-6-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76853-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,lst.de:email]
X-Rspamd-Queue-Id: CACE011D131
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:50:28AM -0500, Brian Foster wrote:
> Now that the zero range pagecache flush is purely isolated to
> providing zeroing correctness in this case, we can remove it and
> replace it with the folio batch mechanism that is used for handling
> unwritten extents.
> 
> This is still slightly odd in that XFS reports a hole vs. a mapping
> that reflects the COW fork extents, but that has always been the
> case in this situation and so a separate issue

I wish we could fix it eventually.  One thing that came to my mind
a few times would be to do all writes through the COW fork, and
instead renaming it a 'staging' or similar fork, because it then
contains all data not recorded into the inode yet.  But that would
be a huge lift..

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

