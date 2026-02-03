Return-Path: <linux-fsdevel+bounces-76211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFFLN/wjgmnPPgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:36:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABEDC0FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72B3E30517D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3503D300B;
	Tue,  3 Feb 2026 16:32:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AB3168EA;
	Tue,  3 Feb 2026 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136363; cv=none; b=X5cY8OUSI2EiGYIER7uG2Vp99eMguId6gXB9e4pM2Huzbch+O7RuIGD117M9GbPoAXTJYkrcGSI8FSM4+m/YQlthXOgUeQsGHcuDZgoMAETKfWVcQAoYfqQD9Mfgz5DxvM0I8kd8sgiKpBbmwcH0OKciU2ty4cXu1KV6vOq+7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136363; c=relaxed/simple;
	bh=7pZ++R7tg+0e49E+XZr/gIWurUNmxA2u9LbQhL0oOa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmBIs5D7d0BMlXVysq3kHDs67e4Zx9nf2bPs8B5TgtfehwUIasf9CtvzKsxH/V/2Bxc+j+max8CoAABowq+2flvLtjqtNxWuliMufMtW/4KmfcwzdW3/bMUh61uLrRI1iC0pEIVgWdI2biAGprhd6nMZyDie1N3/79KGAjKd6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19FCF68BFE; Tue,  3 Feb 2026 17:32:37 +0100 (CET)
Date: Tue, 3 Feb 2026 17:32:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Askar Safin <safinaskar@gmail.com>
Cc: dhowells@redhat.com, axboe@kernel.dk, brauner@kernel.org,
	cem@kernel.org, djwong@kernel.org, hch@lst.de,
	kundan.kumar@samsung.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, willy@infradead.org, wqu@suse.com
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs
 helper from bio code
Message-ID: <20260203163236.GA28989@lst.de>
References: <1763225.1769180226@warthog.procyon.org.uk> <20260203102821.3017412-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203102821.3017412-1-safinaskar@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76211-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4ABEDC0FE
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 01:28:21PM +0300, Askar Safin wrote:
> David Howells <dhowells@redhat.com>:
> > Can we make vmsplice() just copy data?
> 
> vmsplice already caused at least one security issue in the past:
> CVE-2020-29374 (see https://lwn.net/Articles/849638/ ). There may be other
> CVEs, try to search CVE database.
> 
> Also, I think vmsplice is rarely used.
> 
> So, if you author a patch, which makes vmsplice equivalent to readv/writev,
> and mention these CVEs, then, I think, such patch has high chance to
> succeed.

I'd be all for killing it, especially as getting it to properly pin
the user buffers is still unsolved so far.


