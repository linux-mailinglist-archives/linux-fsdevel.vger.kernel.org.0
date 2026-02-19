Return-Path: <linux-fsdevel+bounces-77674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id us+kHXuplmlViwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:11:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FDB15C530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D3333021E5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD192E62A2;
	Thu, 19 Feb 2026 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrBQm0tC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD9C238C16
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481462; cv=none; b=FyJw6EyeeGsvgPCQVjOsgwu81hwIU95J3vVEIJ1fCpYMTtgnMhPOzKRBI8VC1xK+sY9RvH2HFHgPDOlODygHYG/5XLv41y62JkiFITFSJ98Hx4A520fE7BMcF1STQf2GpGRGk/iEnwYt2c+qIt2uASHhCfY6fmJW95IAx3dhQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481462; c=relaxed/simple;
	bh=37sSeJD6ADv1EuNIdngYO3hXk5k5J2f0eOcPG2Qb7CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH4lVNZCCY6w8NK4JZWEg1OcBlpI0uuNXIOyi3lpWA4zD9fxuMFJ6+VgYdcl+iyOcN38uW5EHXfmOb7FKswuObSFkhuGGFKsGEybP+vh9psFSPkXsF7menjUBOwaZ8cc8G7va9v5Sshrpc2pCQdYKtxmh+kF2ROaHnBW7yD8B0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrBQm0tC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C3C4CEF7;
	Thu, 19 Feb 2026 06:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771481462;
	bh=37sSeJD6ADv1EuNIdngYO3hXk5k5J2f0eOcPG2Qb7CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrBQm0tCchO2r7hg0ZoSqZ27h6GQOqAE02C1qDwh5HlCkSlb58S07V8/3O+lV7TPf
	 aPLouyxXbkWBmg2Qt6GlE9lQSS+bHtye9fvt+SWdQgxBuQYXzytRg0wUHYjJKmK4+e
	 PXTxVDNGDYo8ZU+A0C+7SOsZ28oOhif3TDy2vnmFOkhFbpfg6ZVU/F5PBGDThyojEu
	 bzOgJEAcrcmjdPZWbpZ/PeqWf6Aop+D6J/yDh3g8YbPZDovBH50Dyb5fQW4NRcL8R3
	 pRrTSIjx1Xttn80m0sX8HMSYMw13pEaCoMaEOTDg5WQ/0m/SATaCeoax2xPlt1/f+u
	 psIUnv+Oe4PXg==
Date: Wed, 18 Feb 2026 22:11:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	wegao@suse.com, sashal@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has
 bytes pending
Message-ID: <20260219061101.GO6467@frogsfrogsfrogs>
References: <20260219003911.344478-1-joannelkoong@gmail.com>
 <20260219003911.344478-2-joannelkoong@gmail.com>
 <20260219024534.GN6467@frogsfrogsfrogs>
 <aZaQO0jQaZXakwOA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZaQO0jQaZXakwOA@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.com,infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77674-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2FDB15C530
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 04:23:23AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 18, 2026 at 06:45:34PM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 18, 2026 at 04:39:11PM -0800, Joanne Koong wrote:
> > > If a folio has ifs metadata attached to it and the folio is partially
> > > read in through an async IO helper with the rest of it then being read
> > > in through post-EOF zeroing or as inline data, and the helper
> > > successfully finishes the read first, then post-EOF zeroing / reading
> > > inline will mark the folio as uptodate in iomap_set_range_uptodate().
> > > 
> > > This is a problem because when the read completion path later calls
> > > iomap_read_end(), it will call folio_end_read(), which sets the uptodate
> > > bit using XOR semantics. Calling folio_end_read() on a folio that was
> > > already marked uptodate clears the uptodate bit.
> > 
> > Aha, I wondered if that xor thing was going to come back to bite us.
> 
> This isn't "the xor thing has come back to bite us".  This is "the iomap
> code is now too complicated and I cannot figure out how to explain to
> Joanne that there's really a simple way to do this".
> 
> I'm going to have to set aside my current projects and redo the iomap
> readahead/read_folio code myself, aren't I?

Well you could try explaining to me what that simpler way is?

/me gets the sense he's missing a discussion somewhere...

--D

