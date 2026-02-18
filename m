Return-Path: <linux-fsdevel+bounces-77528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLA5Jr1dlWkHPwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:35:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E36153758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C51323011112
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66C309EE8;
	Wed, 18 Feb 2026 06:35:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE3308F34;
	Wed, 18 Feb 2026 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771396525; cv=none; b=A+gmykkZcQ+gvjHuJE0hyba51pPxVFNFx/WKpmWtyuRANsGntDS8iIENELg9n1lE/zOL9QEkNiGgI+79evfnR0QoF9sNUOClfhdR/93psRzuuQWm+YCe3FZD6Gt79gNkr4XhBYZ0Yc8NK0N0uCAfq52BpdpMDXVML7pq39l9/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771396525; c=relaxed/simple;
	bh=M5Qog5hFYAZAY0vKnsCQGFRZoOyjAe9K/dBLlP1I3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8huZ/mdQjsvQHmeiZ7NcZM7njndY6m60I8zWN4ovOVwgZ09AQyTlLXqmvHtFbVGwzxDorqs2KF/jm5MFzUOzgseX2H6DjM4kUld9kxR/eKm/CfJPtyOTJhoxULYia6B2p+nJwvELLbNX1eV65hs3GbGBqx2x2+tDCxxJGtihWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9706B68B05; Wed, 18 Feb 2026 07:35:21 +0100 (CET)
Date: Wed, 18 Feb 2026 07:35:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	djwong@kernel.org
Subject: Re: [PATCH v3 22/35] xfs: add iomap write/writeback and reading of
 Merkle tree pages
Message-ID: <20260218063521.GC8600@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-23-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-23-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77528-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 09E36153758
X-Rspamd-Action: no action

> -	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
> +	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, iomap_flags, XFS_WPC(wpc)->data_seq);

Overly long line.

> +		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
> +			wbc->range_start = fsverity_metadata_offset(VFS_I(ip));
> +			wbc->range_end = LLONG_MAX;
> +			wbc->nr_to_write = LONG_MAX;

Shouldn't this be taken care of by the caller?

> +			/*
> +			 * Set IOMAP_F_FSVERITY to skip initial EOF check
> +			 * The following iomap->flags would be set in
> +			 * xfs_map_blocks()
> +			 */
> +			wpc.ctx.iomap.flags |= IOMAP_F_FSVERITY;

I'm usually a fan of more comments rather than less, but I don't think
this adds any value.


