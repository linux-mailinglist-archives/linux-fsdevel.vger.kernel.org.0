Return-Path: <linux-fsdevel+bounces-77675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD4DC5eplmlViwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:11:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE015C53F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99D3C302A2D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950702E7162;
	Thu, 19 Feb 2026 06:11:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996E2E541E;
	Thu, 19 Feb 2026 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481486; cv=none; b=fogEpidiCfG/7GPJqFCHRYa/GAV2i5z5u8eNfMHI9SfFaKaaRX195fj85sjMblk+IaDixT1iOEr/dd7hrBTKzVYCrAGRxhdNzLCG2JfTJEc1ux8rmReWzf54BndCF7O386YbFJQw9nhwW2uIG/RXaEJkP7AcxYOT+CiV5AfIllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481486; c=relaxed/simple;
	bh=e3t3WjjBQq0ZzdFNYZhOQWXe5BFqqRITUn2G5ny4C94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVJDCy55BP5U27yXoOXqdg9tVPtixXvkkvGO8GHcOhWeuklpNcDn+E1UPUndbG2S4bssAJeOQbm55g1NE84iE7eQABHSzZLOGyQjH472ZHSWV+cFwz824ZHeQtXbpagp/MZ8Id9MfKwCqGj3B45fg/ZPC4BHwNgFmGO3ZR45v/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8CA568C7B; Thu, 19 Feb 2026 07:11:22 +0100 (CET)
Date: Thu, 19 Feb 2026 07:11:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org, djwong@kernel.org
Subject: Re: [PATCH v3 28/35] xfs: add fs-verity support
Message-ID: <20260219061122.GA4091@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-29-aalbersh@kernel.org> <20260218064429.GC8768@lst.de> <mtnj4ahovgefkl4pexgwkxrreq6fm7hwpk5lgeaihxg7z5zdlz@tpzevymml5qx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mtnj4ahovgefkl4pexgwkxrreq6fm7hwpk5lgeaihxg7z5zdlz@tpzevymml5qx>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77675-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A5FE015C53F
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:57:35AM +0100, Andrey Albershteyn wrote:
> > > +static int
> > > +xfs_fsverity_drop_descriptor_page(
> > > +	struct inode	*inode,
> > > +	u64		offset)
> > > +{
> > > +	pgoff_t index = offset >> PAGE_SHIFT;
> > > +
> > > +	return invalidate_inode_pages2_range(inode->i_mapping, index, index);
> > > +}
> > 
> > What is the rationale for this?  Why do ext4 and f2fs get away without
> > it?
> 
> They don't skip blocks full of zero hashes and then synthesize them.
> XFS has holes in the tree and this is handling for the case
> fs block size < PAGE_SIZE when these tree holes are in one folio
> with descriptor. Iomap can not fill them without getting descriptor
> first.

Should we just simply not create tree holes for that case?  Anything
involving page cache validation is a pain, so if we have an easy
enough way to avoid it I'd rather do that.


