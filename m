Return-Path: <linux-fsdevel+bounces-77711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBctBEUTl2n7uAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:42:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB9D15F2ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4002F3045228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EFD33A711;
	Thu, 19 Feb 2026 13:41:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6F3191BB;
	Thu, 19 Feb 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508466; cv=none; b=mIapGbEPVI1NkIS7h/qkjLmUd4JM2ay5X7eB05EhMygnSZzkzTW7IXJ8+1mdv+DClcv1gm6kBLZ+vvz65sr5fS4JXb33jtk+5005iIhIR4pC4R57yQUxiLXoMRSOPvyIt/1AzjPSrODt0dvMKt27U5RLtRsLzpIIf8Lj/GYeP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508466; c=relaxed/simple;
	bh=Wb9Q0hoQOXXMO297DJsBiXshfgGgR+MvEB0pfl3uBcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTD7nyUV4i6+6NHRkBxGTErhn6qUwscV0pNIGExYRccJBJL0wzXvlaVVPcAEuzz50+dOH/QhT55/+G6pdpHoYWSZwrhoRKpg+xhzC63z3MOTQ/DJzFuhVqSHKZ/N3pBABrNwvr9EnaMUirlqzGMgV/GBq59Pq6+qs60IlR6UebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E6B568BFE; Thu, 19 Feb 2026 14:41:02 +0100 (CET)
Date: Thu, 19 Feb 2026 14:41:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org, djwong@kernel.org
Subject: Re: [PATCH v3 28/35] xfs: add fs-verity support
Message-ID: <20260219134101.GA12139@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-29-aalbersh@kernel.org> <20260218064429.GC8768@lst.de> <mtnj4ahovgefkl4pexgwkxrreq6fm7hwpk5lgeaihxg7z5zdlz@tpzevymml5qx> <20260219061122.GA4091@lst.de> <4cmnh4lgygm4fj3fixsgy3b7xp2ayo3jirvspoma6qxusdgluu@nyamffhaurej>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cmnh4lgygm4fj3fixsgy3b7xp2ayo3jirvspoma6qxusdgluu@nyamffhaurej>
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
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77711-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 5BB9D15F2ED
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:51:14AM +0100, Andrey Albershteyn wrote:
> > > fs block size < PAGE_SIZE when these tree holes are in one folio
> > > with descriptor. Iomap can not fill them without getting descriptor
> > > first.
> > 
> > Should we just simply not create tree holes for that case?  Anything
> > involving page cache validation is a pain, so if we have an easy
> > enough way to avoid it I'd rather do that.
> 
> I don't think we can. Any hole at the tree tail which gets into the
> same folio with descriptor need to be skipped. If we write out
> hashes instead of the holes for the 4k page then other holes at
> lower offsets of the tree still can have holes on bigger page
> system.

Ok.

> Adding a bit of space between tree tail and descriptor would
> probably work but that's also dependent on the page size.

Well, I guess then the only thing we can do is writes very detailed
comments explaining all this.

