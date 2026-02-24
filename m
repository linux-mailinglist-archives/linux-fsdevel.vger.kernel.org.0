Return-Path: <linux-fsdevel+bounces-78274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDMyOAS8nWklRgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:56:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0F188B93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8ECD301D04B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5A3A0E8F;
	Tue, 24 Feb 2026 14:52:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429A39E6F9;
	Tue, 24 Feb 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944721; cv=none; b=FuB4+cBw0Ko+jqguKBQRkNLO2GfnAo4z2jPU223ItVzM8h8Z/ftfseJw/GdryrDPtg5VAy1tZvGN3fTb8yHWwfKRCsAWNWBfAKugffaH+PXmRh0IEGUOevF0rH/b2vPKswHfW6O2Wq4iIPxNkf7GZDp1/Imd4lzjnn2BUKnXkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944721; c=relaxed/simple;
	bh=iyIHMDWafRDoQWMxBuWvwQXYG3m2tJZQ5KOhoIR+TDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9Mam3ybSFiLK2agS3xp8F+hsezprqgS+DlTZ8D8Hssjvax6ydoYi30583sEkV2hMPHk1iP/j0IWW8PQk8A142/4q+rywYF5/hPXrKW3Ch5Di+M1p8VynCCNbP/1yJzvUCDDfYYnqkyIUin180en15EHhJtE1mUs2MAewh1RWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2604668BEB; Tue, 24 Feb 2026 15:51:57 +0100 (CET)
Date: Tue, 24 Feb 2026 15:51:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fsverity: add dependency on 64K or smaller pages
Message-ID: <20260224145156.GA13173@lst.de>
References: <20260221204525.30426-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221204525.30426-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-78274-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 79C0F188B93
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:45:25PM -0800, Eric Biggers wrote:
> Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
> cache the Merkle tree in the pagecache at a 64K aligned offset after the
> end of the file data.  This offset needs to be a multiple of the page
> size, which is guaranteed only when the page size is 64K or smaller.
> 
> 64K was chosen to be the "largest reasonable page size".  But it isn't
> the largest *possible* page size: the hexagon and powerpc ports of Linux
> support 256K pages, though that configuration is rarely used.
> 
> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.

Do we want to throw in the towel here for the forseable future and if we
ever need to support fsverity on > 64k page size just do a on-disk
version rev?

Because if so we could just simply the pending xfs fsverity support to
drop all the offset adjustment and simplify it a lot..


