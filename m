Return-Path: <linux-fsdevel+bounces-77669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ9mLO+nlmmTiQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:04:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E815C4A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E58302A6F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490662E6CC0;
	Thu, 19 Feb 2026 06:04:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992F23A9A8;
	Thu, 19 Feb 2026 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481064; cv=none; b=dlyT2eKMizjR0xqponb4zgwEyNp1U+2H6KrIAzVOYZV5NRg8kaR4ykN5d30353jBqWV+ynWF4N7nCexjuFjaUoxW62VtNczYxlwwaBgPlQHJaUOhJfVDuPWgw+pi42ExhviynCXa3aUedjF3xDU3mEeUPfpMfSSVrwVLVK/lZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481064; c=relaxed/simple;
	bh=tghFlCBFVHod7l2FgpgEuuzHopXeIrkIWJQ5bXIaWOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1+tlJicfhD23KQYs4jP2CQDn+S/MMSnwQ3rwERe7f+QmFZFton2K6jFypP9Hq+p+IG4O1jR6kl9OryY4w81uV51uxS08TTU6nwNEyBFk4/Nc4jTYxo988KTVoQWanKiOnM0c7h5KKkILnToyX/h0wMFPOliIv2qjH6YtYaeYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B3F968C7B; Thu, 19 Feb 2026 07:04:20 +0100 (CET)
Date: Thu, 19 Feb 2026 07:04:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org, djwong@kernel.org
Subject: Re: [PATCH v3 11/35] iomap: allow filesystem to read fsverity
 metadata beyound EOF
Message-ID: <20260219060420.GC3739@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-12-aalbersh@kernel.org> <20260218063606.GD8600@lst.de> <hfteu6bonpv7djecbf3d6ekh56ktgcl4c2lvtjtrjfetzaq5dw@scsrvxx5rgig>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hfteu6bonpv7djecbf3d6ekh56ktgcl4c2lvtjtrjfetzaq5dw@scsrvxx5rgig>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77669-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 238E815C4A8
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:41:14AM +0100, Andrey Albershteyn wrote:
> > +		 * Handling of fsverity "holes". We hits this for two case:
> > +		 *   1. No need to go further, the hole after fsverity
> > +		 *	descriptor is the end of the fsverity metadata.
> > +		 *
> > +		 *	No ctx->vi means we are reading a folio with descriptor.
> > +		 *	XXX: what does descriptor mean here?  Also how do we
> > +		 *	even end up with this case?  I can't see how this can
> > +		 *	happe based on the caller?
> 
> fsverity descriptor. This is basically the case as for EOF folio.
> Descriptor is the end of the fsverity metadata region. If we have 1k
> fs blocks (= merkle blocks) we can have [descriptor | hole ] folio.
> As we are not limited by i_size here, iomap_block_needs_zeroing()
> won't fire to zero this hole. So, this case is to mark this tail as
> uptodate.

How do we end up in that without ctx->vi set?

> I think this could be split into two cases by checking if (poff +
> plen) cover everything to the folio end. This means that we didn't
> get the case with tree holes and descriptor in one folio.

That might be more clear.

> > +		    	if (!ctx->vi) {
> > +				iomap_set_range_uptodate(folio, poff, plen);
> > +				/*
> > +				 * XXX: why return to the caller early here?
> > +				 */
> 
> To not hit hole in the tree (which means synthesize the block). The
> fsverity_folio_zero_hash() case.

Well, I mean return early from the function and not just move on
to the next loop iteration (which based on everything else you
wrote would then terminate anyway), і.e., why is this not:

		if (!ctx->vi)
			fsverity_folio_zero_hash(folio, poff, plen, ctx->vi)
		iomap_set_range_uptodate(folio, poff, plen);
	} else if ...

?


