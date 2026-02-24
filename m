Return-Path: <linux-fsdevel+bounces-78273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP+HDw+5nWnERQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:43:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F2318892B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B4C530A8D19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF4B39E6E8;
	Tue, 24 Feb 2026 14:42:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CD376BE5;
	Tue, 24 Feb 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944173; cv=none; b=O6CyGQUE/etQoeYHRX/s/rKccxm7btezLX0z3njNAzM+5FhgvtuSGyL5vFlPcWNmLEuFhVFzVkMhPVAtA9LDf+e9va1CBbGHNsMjuS0r/nHJruZI72w0GeIn4cZscX7FTDAa/rbwOn9ERORE38hqdJcixnaR2LKAbIq6/b3FsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944173; c=relaxed/simple;
	bh=wC9Y4jz9b+cciDywQ8+900OuS6yQXQOyS1NadcFn5gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAm9b8C0IVMIvM6hjAB8VPoKllaVGOpfGGL6FJNFRrwSYzQ2WgenxwCxPC7INIect4Qq7Tu4mWQZ2q7vAU1J5KyBCEkH7q9PRYKXNvm3q7TLNE7PWSFHpZLxgEQaXIiiN8/QW6+DuDGlUsBZZ2TabUfmhZ1aab2bgcANN4F2hVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CA4368D09; Tue, 24 Feb 2026 15:42:49 +0100 (CET)
Date: Tue, 24 Feb 2026 15:42:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org, djwong@kernel.org
Subject: Re: [PATCH v3 11/35] iomap: allow filesystem to read fsverity
 metadata beyound EOF
Message-ID: <20260224144248.GA12746@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-12-aalbersh@kernel.org> <20260218063606.GD8600@lst.de> <hfteu6bonpv7djecbf3d6ekh56ktgcl4c2lvtjtrjfetzaq5dw@scsrvxx5rgig> <20260219060420.GC3739@lst.de> <qheg77kxcl4ecqdrsnmz4acfvszjlamlb7ilgxxyf3pmt4r7ah@5fzzmcpurdfp> <20260219133829.GA11935@lst.de> <bltgc6uliclhzkuqd4la2tzp6x7vsww73nvjedxh7s624tby3k@jw4ij5irh6ni> <20260220153113.GA14359@lst.de> <ujwgs5xb6rienyskr7qbekmsbyn5qea2ew4untas5drqdufirp@2qea2ndmnchs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ujwgs5xb6rienyskr7qbekmsbyn5qea2ew4untas5drqdufirp@2qea2ndmnchs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-78273-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B3F2318892B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:10:23PM +0100, Andrey Albershteyn wrote:
> 
> > 
> > I'm still not sure what "When iomap is reading fsverity descriptor
> > inode" means.
> 
> "When iomap is reading fsverity descriptor, inode won't have any
> fsverity_info yet."

What code path is this?  __fsverity_file_open -> ensure_verity_info ->
fsverity_get_descriptor?

> > See above, unlike ext4/f2fs we set it for all I/O on fsverity inodes.
> > And afaik we don't actually need it, the only use in the fsverity
> > metadata path is the fill zeroes hash values check (which I'm still
> > totally confused about).
> 
> Yeah, for metadata the only use is to fill zero hash blocks. I will
> try to split it so lookup happens for data and holes in fsverity
> metadata. This way we would have less lookups for metadata.

I think doing one lookup per ->read_folio / ->readahead is fine.
I just really need to understand the differences here.  I think I'm
finally getting it, and it would be greast to capture all this in
comments.  I'll carefully read over the next versions and will suggest
updates to the comments based on the my understanding if needed.


