Return-Path: <linux-fsdevel+bounces-75932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDxnBv9HfGkSLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:56:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A03AB7849
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5102C302D09C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 05:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054F3382CA;
	Fri, 30 Jan 2026 05:55:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B06369212;
	Fri, 30 Jan 2026 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752546; cv=none; b=b2QD3tdqJufpw0B7z4auEbvJpbhAiMxNIiNZn4QKBzkv+U02xv8l3+bABHrXLKCDhK/mhp9WGPwqjWf1YGlAW4quIuMFwxSI0JNwLkeQcst250dkKjKApCQlgaOJIEj+1TchIQMaY+kKiLvwUoCYEkSAn3SZqFMLDSUI6JyCn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752546; c=relaxed/simple;
	bh=6JRsmjSgzYP+N5fv6QtNtCSVn+ysuKU7wLgj1IALRSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsSjhv+Nzdj9qCDDkk7pH/Br4MAb0/1enHNNnW93YD6+Dh1uDhmMqWH3IQawqub50uClyBMqX2onTXrTwdraT5XVbAYukx67ztxrdClQaQUVh3gxsvou7kwPH7qA4qWGwmAIFOESE+tWrEvIaRCdzJNTt30PWDpesIAddFDGmyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D5F568AFE; Fri, 30 Jan 2026 06:55:41 +0100 (CET)
Date: Fri, 30 Jan 2026 06:55:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 08/15] fsverity: kick off hash readahead at data I/O
 submission time
Message-ID: <20260130055541.GC622@lst.de>
References: <20260128152630.627409-1-hch@lst.de> <20260128152630.627409-9-hch@lst.de> <20260128225602.GB2024@quark> <20260128232213.GJ5900@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128232213.GJ5900@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75932-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 8A03AB7849
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 03:22:13PM -0800, Darrick J. Wong wrote:
> > Unfortunately, this patch causes recursive down_read() of
> > address_space::invalidate_lock.  How was this meant to work?
> 
> Usually the filesystem calls filemap_invalidate_lock{,_shared} if it
> needs to coordinate truncate vs. page removal (i.e. fallocate hole
> punch).  That said, there are a few places where the pagecache itself
> will take that lock too...

> [...]

> ...except that pagecache_ra_unbounded is being called recursively from
> an actual file data read.  My guess is that we'd need a flag or
> something to ask for "unlocked" readahead if we still want readahead to
> spur more readahead.

Basically just move it out of page_cache_ra_unbounded.  With the
consolidation in the earlier patches there are just two callers
of page_cache_ra_unbounded left, this and the redirty_blocks() in f2fs.

I'd kinda wish to kill the latter, as the past-EOF reading is something
that should be restricted to core code, but I can't really think of
an easy way to do that.


