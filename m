Return-Path: <linux-fsdevel+bounces-76951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN0oNzqjjGlhrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:41:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F863125C65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E12301ABB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FDC30E84E;
	Wed, 11 Feb 2026 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCtjGMAl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3030F7F7;
	Wed, 11 Feb 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824472; cv=none; b=K4bc5mMdC8XHPXz+oAvoxZxgPZEiqoA4tj7xQjqtAO1j0rJXlvRLlytFhZSInIVNpUfX5hdNT1r7F9BjAbBnBWkeNih7UB8iqvXqilux7Ukgdly2YU2F7K0KwzhveINQjM87bAflQg+qhcZI6gXnrePiqNbEQfDG2cwAj3+i12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824472; c=relaxed/simple;
	bh=aJs/39Fr6BRe5aRAMCC8Tr/FF4UOhPyHeDCxJAFsgig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFkyOUjH34nZFH0hlPMfhz3Hy2cVxKw9aMUGFQC7ORuzYRrYoaqLn7qGaD2hqIzRm9FjIalFHuucByw9f4LmvGtlo/xrua8D9LcKEpRz5NxQk+wQcR3ICCFoCcHnlNU2wOj+X7xwbN76r1rKZuXeeS60QxolmwqF9J5DcAEMo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sCtjGMAl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iSTOlxV9SVNibpOeEzoKnxMTSS3Rhumc84h05lz/i6w=; b=sCtjGMAlJYgcEsQYK4V3Dt/DqC
	kApRcB+Fp2ps9WIvwozId0ftXdSAZaPa0Z9C5p55hdZ7Q9sCj7XAhwCBQWNBbR2A3SgbbhTl3DwrL
	vdD90BAa0iu2pNU3Iob93Zo2ztd589dt/5KRY2vz+IAh9I5yUhQ0L1bZyGlzfXakKJdGKEVs9ODAB
	nZ2W44MoevZrGDoUWX1RTy1Vhm/GyhDdYieAP4AUO1mrKwXOmGXoCijGnUrW4PodgGDkT1kidOi3W
	EQjzn56lb0tPuOrNEz2rvjS3Ma8jNzF5zsJdkljKt7RbkHCOBg/ipME/TB+pFHXxCjCMkQIGQ0tOj
	FVT395ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqCKz-00000000nng-0ctU;
	Wed, 11 Feb 2026 15:41:09 +0000
Date: Wed, 11 Feb 2026 07:41:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] xfs: replace zero range flush with folio batch
Message-ID: <aYyjFbZaWKRVD-ib@infradead.org>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-6-bfoster@redhat.com>
 <aYta8A6dBpjZyb8c@infradead.org>
 <aYuE2a0DdXZAPwXC@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYuE2a0DdXZAPwXC@bfoster>
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
	TAGGED_FROM(0.00)[bounces-76951-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F863125C65
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 02:19:53PM -0500, Brian Foster wrote:
> This adds a bit more code in the same area as this series. It doesn't
> seem terrible so far, but it was one reason I was wondering if this
> perhaps warranted splitting off its own callback. The behavior for zero
> range here is unique enough from standard read/write ops such that might
> be a readability improvement. Since I'm not the only person with that
> thought, I'll take a proper look and see if it's worth a prototype to go
> along with the mapping behavior change..

Yeah, a separate handler might be cleaner.  Note that in
xfs_buffered_write_iomap_begin, the zeroing special case is also
a fairly large part of the function.

One thing that might help here is my old idea of splitting looking up the
existing mapping, and creating a new mapping for dirtied data into
separate nested iomap iterations, preferably with a way to pass along the
mapping for in-place updates.  That way all this zeroing special casing
would go away, as we'd only perform an action if the read side lookup
returned an extent.  But so far this is just a crazy idea in my mind,
and I'm not really sure how well it would work in practice.


