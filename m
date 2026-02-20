Return-Path: <linux-fsdevel+bounces-77803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP7mI3ePmGnjJgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 17:44:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B35169620
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5253D302EEB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF534F259;
	Fri, 20 Feb 2026 16:44:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0C34E751;
	Fri, 20 Feb 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605871; cv=none; b=Hle/HJYU5XkcZQo/09I2P9C3vUPORvaqaBH97Pn13P4C5nhaQMlYtcQV9XzZAsvsIgLTmu8LEZyE2HSJWjrB0vN8igG9Pq536Uti2vRvx3NZ3RY/G3gK/ksV2XQcCYEpydhHfjRVZ0AsZVIiAC3zSDBfQrExh1y/HQFXJWYaGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605871; c=relaxed/simple;
	bh=LFEeMA5NCk4oYtquDig/+RWfmXvw9puQ0xqNjM0rpkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPVNt7xYDLexiMQ2YgfpDtp3dRZANJI/3nKIyosNc7cWTbhFb2IzYsPuAO0wsIV/ZWGRfoFioUT6GReU2ZNJFjWUPykxPeItsg26T25EtvTrVaXpMxYLxNjCgLG0f5UhkF17RHGna29aNshpfFkVwbzTgvRY4lSf3x73msE7dMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E264B68BFE; Fri, 20 Feb 2026 17:44:27 +0100 (CET)
Date: Fri, 20 Feb 2026 17:44:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org, hch@lst.de, djwong@kernel.org
Subject: Re: [PATCH v3 08/35] iomap: don't limit fsverity metadata by EOF
 in writeback
Message-ID: <20260220164427.GA15907@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-9-aalbersh@kernel.org> <aZiPDWBn9-1AIQAi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZiPDWBn9-1AIQAi@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
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
	TAGGED_FROM(0.00)[bounces-77803-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 16B35169620
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:42:53PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 18, 2026 at 12:19:08AM +0100, Andrey Albershteyn wrote:
> > fsverity metadata is stored at the next folio after largest folio
> > containing EOF.
> 
> I don't get it.
> 
> Here's how I understand how all this works:
> 
> Userspace writes data to the file.
> Userspace calculates the fsverity metadata.
> The entire file is fsync'ed to storage
> The fsverity flag is set and i_size is reduced to before the metadata
> starts
> 
> At no point during this process do we need to do writeback past EOF.
> 
> What am I missing?

Userspace only writes the file data directly.  The metadata is written
kernel-internal by an ioctl, and should stay beyond i_size.

