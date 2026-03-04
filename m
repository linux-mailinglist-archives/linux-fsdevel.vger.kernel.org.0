Return-Path: <linux-fsdevel+bounces-79406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMOGBeVPqGmvsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:29:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B40AF202AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE489304436B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CC3264DF;
	Wed,  4 Mar 2026 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VazhBZ4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4687317155;
	Wed,  4 Mar 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636464; cv=none; b=dMAkXw69xSNeR0ffQCtO/grZratOCp+pHo6pRd7caIJo7ZKQO/dlmnYJM5eGbgig5HgAXUFFK0vEazmnOO8fAlHgoB/heldML86uPfs5ZZRRut4i+KoDE8xVRkCuG4P/pwhfMpQWQyvum8G8xe01ssEscbzYTxhg3qb2dJd6Bvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636464; c=relaxed/simple;
	bh=a0hKyFzpMyV4B1Z6xhCoLSmBYJJiblwLWn9ccWEH9SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA0pu3pgwRsqqlCuzVDS7I3mFdgtadl7qe5M/XfAr03gj0ldTFQAnFXJyYDeJkckN/4HvBC92wUq7AEjl4cBgWNUfdXpqXwDrMhvBol/BKGyhHK1K1Viu/HvMj5cPQrChNv8A9lqFHwc0sazbyk2nN33rBk97FuANJ88EKWwhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VazhBZ4m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eStHBSpXComR1v+Pn4vYQL8W4WELIg4jEWCgCC8kPlc=; b=VazhBZ4m2jILtWbdW1O5M1p41h
	Kp0GV2O1QfVtEdCnI7vNX99buD+e8hEng1kplc/VPAWRRx68Kf67BPu/cStqT8YSOZ8qKkOTtLPJq
	vAX1rXxMx1sF6sh97s+nklSAdYWAk93nUtIB57zSy1KAlG5LZF13vgVipDcO6BQHl/22LY/oWHl5k
	nSy/qqBP/D5EGrbER/d+Y9hJjXUxdxKZHkU4jTcmLO23mxi2Nar5UBAc7cbdUwxmuOOPgOlsOV/3v
	opgREfz2fzpNvDme0f5N7yZGBUwWMMJeQV32W250gp0c/qrPs7Gdj0yQQbTRxtUveC32hrJ4fSvhL
	ENCPzGPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnie-0000000HVGE-263V;
	Wed, 04 Mar 2026 15:01:00 +0000
Date: Wed, 4 Mar 2026 07:01:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab
 the buffers on request
Message-ID: <aahJLBBQuqWNDk6p@infradead.org>
References: <aahEJ7hY-tXRRjJk@infradead.org>
 <20260304140328.112636-1-dhowells@redhat.com>
 <20260304140328.112636-18-dhowells@redhat.com>
 <181470.1772635861@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181470.1772635861@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: B40AF202AF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79406-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:51:01PM +0000, David Howells wrote:
> > > +static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
> > > +				      struct fscache_occupancy *occ)
> > > +{
> > 
> > Independent of fiemap or not, how is this supposed to work?  File
> > systems can create speculative preallocations any time they want,
> > so simply querying for holes vs data will corrupt your cache trivially.
> 
> SEEK_DATA and SEEK_HOLE avoid preallocations, I presume?

No, they can't.  The file system doesn't even know what range is
a persistent preallocation or not.  You need to track your cached
ranges yourself.

