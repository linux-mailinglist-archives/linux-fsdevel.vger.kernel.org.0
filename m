Return-Path: <linux-fsdevel+bounces-75575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJYcGZJUeGn2pQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:00:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1190367
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04DD5302F424
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34C329E6A;
	Tue, 27 Jan 2026 06:00:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264552EBBA2;
	Tue, 27 Jan 2026 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769493646; cv=none; b=ibJR5QzZg5x0+cY3DTJ9IGN2W4f+EFYeIutUPqRoEWIPwm41LQTqyAVrVWLyVXZIh9AefCmsq7yeJQfFIgp1yqWo1j6ShhnLxVKQtNtaB+Xi70tscfTygkxGjAXs4X4lcVHrNuaqm+Wk/OZIutE+HBhbwB+mWMR26z2djhxOI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769493646; c=relaxed/simple;
	bh=CRjgMQfRtbbPQJI6tjEU9apiUX/m6z3FJpz22aMvx1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al5gfpWlqqnch/CeHqClVDop7PiJ3KeKzRcYtoYi8SgCOUhbfWXYntDBH9MpWoe6f42UDJCc1aoJ6CtS2FzZfxDK6Xwlvl0tK8mbQU9oYtBFizbZ0SheIbd1P3eA+0l1UVFPh1uaZ/TvsPCWKTTiC2AQwOz/iia1fAPpkHWgi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEE5D227AAE; Tue, 27 Jan 2026 07:00:39 +0100 (CET)
Date: Tue, 27 Jan 2026 07:00:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 07/16] fsverity: don't issue readahead for non-ENOENT
 errors from __filemap_get_folio
Message-ID: <20260127060039.GA25321@lst.de>
References: <20260126045212.1381843-1-hch@lst.de> <20260126045212.1381843-8-hch@lst.de> <20260126191102.GO5910@frogsfrogsfrogs> <20260126205301.GD30838@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126205301.GD30838@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75575-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DCF1190367
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:53:01PM -0800, Eric Biggers wrote:
> Then for the final version in generic_readahead_merkle_tree(), one
> option would be:
> 
> 	struct folio *folio;
> 
> 	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> 	if (folio == ERR_PTR(-ENOENT) ||
> 	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
> 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
> 
> 		page_cache_ra_unbounded(&ractl, nr_pages, 0);
> 	}
> 	if (!IS_ERR(folio))
> 		folio_put(folio);
> 
> Or as a diff from this series:

I ended up doing the second version (which is what I intended to do
anyway, but messed up the brace placement) in this patch.  It then
automatically carries over to the readahead split.

> 
> -	if (PTR_ERR(folio) == -ENOENT ||
> -	    !(IS_ERR(folio) && !folio_test_uptodate(folio))) {
> +	if (folio == ERR_PTR(-ENOENT) ||
> +	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
> 
> (Note that PTR_ERR() shouldn't be used before it's known that the
> pointer is an error pointer.)

That's new to me, and I can't find anything in the documentation or
implementation suggesting that.  Your example code above also does
this as does plenty of code in the kernel elsewhere.


