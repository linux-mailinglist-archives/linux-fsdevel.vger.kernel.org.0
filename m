Return-Path: <linux-fsdevel+bounces-77338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uhoyBakKlGkb/QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 07:28:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9F148F7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 07:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 047683019821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2982765C5;
	Tue, 17 Feb 2026 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0+F3pw4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B91F0E34;
	Tue, 17 Feb 2026 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771309730; cv=none; b=sOcKWyKCo/URwVu0vTxuAYQwyMkpjNQfJHEefvCaDVaMKcjagBGIheHEnHAxTGdOQIQ8E4ZvASAMxpZg0njk6nWrG1U98aTwDcNEJw+6aVr3aqfh+m6wtZWQt/AborBWFzuripElIQO5zOnSThMRJCqDSuldAcbLKG/Rjk+6svo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771309730; c=relaxed/simple;
	bh=r0yGeDQV7l+yDkOyUI3jXK/Hrs6RmGr9LwFczLdSKUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieNkTrld0SeNZy1Tlz0s6bCePonSgh0aXqwtgJQbVr7S2Fr8H98mH3bBm5QSscwtHTQbHP2w7VSDUo1RnMs0cNJOkpk5mT5OIVaeS3pICNqYnkpPrHHObShamne1M9RRKLbvApMD7rEk6TuGoJfI/77wJ17VhiIajXPr8WWfpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0+F3pw4M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LQEB5qH6sGqn4N5t877calL/A3UF9/CGACxt3V+Y1E8=; b=0+F3pw4MxvXt2rCIDBraA++VZd
	ORMPnoIPZWkL+haiLnvZw7FGjGsFKm4CnAJ3gQlRPNpp6ht7zV7qxTzPlGrMayTPi/sW8bsk13X+Y
	n0dREQP1oEevOCNFRjKONBFZUtrgAupOei6wwSsulBKQ36AxTBQNmOWGiKjpI6sCd3OJCNzDEdtme
	9RlCWxby5PZzzGMrtfl9zGRRZqg7OPIyH0hwah2AuGzI7g3dxKRiRtIcKmNepmrkxc7rbfvtev+HK
	Pq0NbrcVJJGVKyhD2kCjd1TbD0CV/+fggmtPxMur45DtK1BGQ37UZhFh14FW5S8/C3js6JeVV94B3
	Je3ankVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsEZj-00000007hu1-43Mb;
	Tue, 17 Feb 2026 06:28:47 +0000
Date: Mon, 16 Feb 2026 22:28:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/2] f2fs: make f2fs_verify_cluster() partially
 large-folio-aware
Message-ID: <aZQKn2-L2Tro4OUT@infradead.org>
References: <20260215042806.13348-1-ebiggers@kernel.org>
 <20260215042806.13348-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215042806.13348-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77338-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FD9F148F7A
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 08:28:05PM -0800, Eric Biggers wrote:
> In addition, remove the unnecessary clearing of the up-to-date flag.

I'd split that into a prep patch, as it is not really related to
the folio conversion.

Otherwise this looks good.  I actually had patchs to kill
fsverity_verify_page in my local queue, but decied to postpone
it.  Guess I should have included them..


