Return-Path: <linux-fsdevel+bounces-76051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AKyKdvBgGl3AgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 16:25:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0160CE2C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C580305D153
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8737882C;
	Mon,  2 Feb 2026 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDtlxC7H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DAA3783C1;
	Mon,  2 Feb 2026 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045112; cv=none; b=qsTZbO3pGujIS/q1vTnsTNkBoF3s/NbV5ufGHBD3oAlxQ9pNwexDQShkcGMWYxc37uwo7LtMkj01/odcFB6YxEJqF6CxJOTdlfCJzkv7rTylaF/aiAUvEu049DdIIFK+JZdtOUqsQqChx2iA4z2FCSkQqUBsJcmydUAZAM2N/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045112; c=relaxed/simple;
	bh=XD1mJNWkOcI6dGgHAOJhJcnbwykWRo8a4yuMq6e9Z1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGQ6Tv691PiT9goi5MuWdx/vxN63s1SZgwaZUXMfzBextpMQMtUczaS8tddg2YKrJcV/mBMdkjzTNjDMK5ACNM3sU2x/N0wdy1wqRsls1F1Vj2+Zq6PWV0hdKIaBa4SMuA/lBzHzJRTA3uEC88mRR84lsvKEL87vdgHe5fVQLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BDtlxC7H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=29jy1DWONXoy2B6xjNCVE28WgCP/0GEBN/PkS8AOnVg=; b=BDtlxC7H+13PZmg79XlT4cSMua
	xCmWldl386DVv7YKhloM8ay70jGq0ky18Petto6satpvMsOL7fevIgvAqiZ+m+T6dTk9OSYyjC9B1
	dgk5DWbW5WtnJ5dXJqJtbG8v1U3xFLHjpHoDe9S11x2Hx3rNbI7g0hkbr2HHCIxDzAbUzzAv6dbgP
	6rP862nQMv4gnxs7ZGhGVAFYzSMXeOynEkfnl+8Ge3pLQoZw9MEPAuPqTtnZ33oYU7uTa/WHu11eu
	NkI4dVGUFndZcaqlAzsnvzeNwkeanApgqsDci6lZ3Cx+VX0m0V0A/2I/YzUijvV5CJd1qIVP+qJOm
	VWpZWm+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmvab-0000000Gf51-3qX6;
	Mon, 02 Feb 2026 15:11:45 +0000
Date: Mon, 2 Feb 2026 15:11:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 02/11] readahead: push invalidate_lock out of
 page_cache_ra_unbounded
Message-ID: <aYC-set6OAK9F9GE@casper.infradead.org>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202060754.270269-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202060754.270269-3-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76051-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: C0160CE2C2
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:06:31AM +0100, Christoph Hellwig wrote:
> +++ b/fs/f2fs/file.c
> @@ -4418,7 +4418,9 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>  	pgoff_t redirty_idx = page_idx;
>  	int page_len = 0, ret = 0;
>  
> +	filemap_invalidate_lock_shared(mapping);
>  	page_cache_ra_unbounded(&ractl, len, 0);
> +	filemap_invalidate_unlock_shared(mapping);

Why is f2fs calling page_cache_ra_unbounded() here?  The documentation
literally says not to call it:

 * This function is for filesystems to call when they want to start
 * readahead beyond a file's stated i_size.  This is almost certainly
 * not the function you want to call.  Use page_cache_async_readahead()
 * or page_cache_sync_readahead() instead.

(in this case, f2fs doesn't have a folio, so page_cache_async_ra() is
probably the right function to call).  But what's the point in writing
documentation when people don't read it?

> @@ -228,9 +229,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 */
>  	unsigned int nofs = memalloc_nofs_save();
>  
> +	lockdep_assert_held_read(&mapping->invalidate_lock);

Hm, why are we asserting that it's not write-locked?  For the
purposes of this function, I'd think we want to just
lockdep_assert_held()?

In the tree I'm looking at, there are also calls to
page_cache_ra_unbounded() in fs/ext4/verity.c and fs/f2fs/verity.c
which probably need the lock taken too?

