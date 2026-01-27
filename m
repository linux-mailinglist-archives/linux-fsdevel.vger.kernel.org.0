Return-Path: <linux-fsdevel+bounces-75596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCluC6S0eGlzsQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 13:50:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38E9480A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C52F304138A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E63355030;
	Tue, 27 Jan 2026 12:50:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DD185E4A;
	Tue, 27 Jan 2026 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518211; cv=none; b=PeMDbyakpmghVUjGQIykYeLZMgobsguWO25LC/19F1il3eZBBa1EoZTqsAmtI3vgj3WOSNLX01WH8GV182urKQOsxuVw91R/uTht5g9bCrPYsrHr9TeDW9yuTXF7YPwDo8UOkDmwxKpht1I/GysjhmBGcMI6BVIlfEoIRNgzBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518211; c=relaxed/simple;
	bh=JnAMdZTCe2rK/26Mbxf5u2LvTqM54GiNjOm7P5fX8Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J577jO/nTH9RnuQZDS9GVE6+P4LqmkDeZTlLOepzV4HSVJV1dlWwIvEPW17qITvlqSJjGy6quQX50n29gpUyZSw4EhqoA8XsakngVNIZFcsOwF1wBwT1jhCqyZZM9PoQbGhWT2xF9vFlWBITpnet0cagkwF6potkgIlZwSumw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCD99227A88; Tue, 27 Jan 2026 13:50:06 +0100 (CET)
Date: Tue, 27 Jan 2026 13:50:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: block or iomap tree, was: Re: bounce buffer direct I/O when
 stable pages are required v2
Message-ID: <20260127125006.GA21793@lst.de>
References: <20260119074425.4005867-1-hch@lst.de> <20260123-zuerst-viadukt-b61b8db7f1c5@brauner> <20260123141032.GA24964@lst.de> <20260127-dezent-ungunsten-0cc7a56917ba@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-dezent-ungunsten-0cc7a56917ba@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75596-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7B38E9480A
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:31:30AM +0100, Christian Brauner wrote:
> > What do you and Jens think of waiting for another quick respin and
> > merging it through the block tree or a shared branch in the block
> > tree?  There really is nothing in the iomap branch that conflicts,
> 
> I don't mind per se. I haven't pushed this into -next yet. We can also
> just wait for the next merge window given how close we're cutting it.

I'd really like to see this merge window at least for this series,
so that we can finally use qemu out of the box on PI devices.

I was hoping to also get the file system PI series in, but I think
we're getting too close for it, and with that the tree might not
matter any more for this one.  It would just be nice to get the
repost, and maintainer ACKs for both block and iomap.  With you
ready to take it and Darrick's review I think that's a yes for
iomap, but I'd really like to hear from Jens.

