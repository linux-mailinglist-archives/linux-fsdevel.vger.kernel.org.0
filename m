Return-Path: <linux-fsdevel+bounces-79355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNCcAJcwqGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:16:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699552003F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F9CA311877F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06465286D5D;
	Wed,  4 Mar 2026 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jveHQ7jC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE12853E9;
	Wed,  4 Mar 2026 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629698; cv=none; b=m4fsOVS7GA5fi/96c5x1lwbSc9ifDjdX85f73O13dOhtIq+Vw1bpzWSWZb5oKTJ/ZOtCelZjyZ7cQE+EaB4bRzeEvh6AVHeUwoaN2AM4dXOirC0dNNfQZSqzX4iC3GeYPxRzddNIU+dUgLzG43OUz8CfzDZmgCmKDcwLjrS4f0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629698; c=relaxed/simple;
	bh=gkCY8IKyJI+ioqbkX97w9tQzV7M4DsoDbt1/L05Mklo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obvyxfI2mxnaKbly/3TRLl0fIBKanxluNd3TdBu8y3W61TBp0MYtzV5T7bLkA4B1KpozN95AV5PKZ4fBkF5jGhSQ+1yYh90tiGnLRIK6Rk317XY5sKzoAfTfPRsdestMW41Y4p78YUgTC6HHmoj5Z3GzOjMyIm/XcB47PP+B43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jveHQ7jC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ggUu6CR1IYs5DAQWNlxIdgKdqfXGxAJNgDDTXOMfNT8=; b=jveHQ7jCDM2mtMGYV4jS22ZV/N
	FLicibigvnlpkroEdeoWslkYKHHBRDIk/EV1Z5p/pUv8Cbf/ZdPJZpUZgo4eKfswWtiQlCPlia2aS
	d3PBTsHbRyyds98+tIitk8qhAseMGDhrTM61H642b4lG6NjDU7VF5D+dKbYLd2qRQZEL5f7SIRckL
	m1/aP1o+GkCbGgf2IWI8n+ifr9Uf6/dEgDyC8pcLNZasxZf5AhEl46Bpp4mKDTinOtAIZ8Ud3KQRC
	gSMyKTWonpDtP2YnAtKP1vYsBOjXp8rSZeXDAnRmHsZjdmDO386sOJDNDun5u0uV5Otgsf8qa7Q85
	Nje0vHPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxlxX-0000000HDuS-2Pcp;
	Wed, 04 Mar 2026 13:08:15 +0000
Date: Wed, 4 Mar 2026 05:08:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, cheol.lee@lge.com
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
Message-ID: <aaguv09zaPCgdzWO@infradead.org>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303082807.750679-1-hyc.lee@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 699552003F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79355-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:28:07PM +0900, Hyunchul Lee wrote:
> s_maxbytes currently is set to MAX_LFS_FILESIZE,
> which allows writes beyond the partition size.

The "partition size" does not matter here.  s_maxbytes is the maximum
size supported by the format and has nothing to do with the actual space
allocated to the file system (which in Linux terminology would be the
block device and not the partition anyway).

>
> As a result,
> large-offset writes on small partitions can fail late
> with ENOSPC.

That sounds like some other check is missing in hfsplus, but it
should be about the available free space, not the device size.


