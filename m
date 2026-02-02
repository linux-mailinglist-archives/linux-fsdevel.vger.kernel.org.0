Return-Path: <linux-fsdevel+bounces-76091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FvLA1QRgWnmDwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:04:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767FD16DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 22:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA8EB300B9FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 21:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377D73101C8;
	Mon,  2 Feb 2026 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akopJkb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A5222565;
	Mon,  2 Feb 2026 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066256; cv=none; b=u7Ug1ZNna40K1ejcbVUX+ZTUOAsBq/uLuPYv0PaR/nFqdl/0pxVwlj4+vFLRuD5VgBNJPrs+uuvx5xYjzV/TvEaaB+t+D7qRDbkXffnYTTVAbxuvwzPJ3Uysc+Ui4hw0gWwjlnUzPaXy7FiMxi4pCBbxZjj6ZHXrHDxRW89TV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066256; c=relaxed/simple;
	bh=XRzlzAwIzrWwQQCJu0yYDI/QY/MD+z952CyEosMvgJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3muMsSWLpDMePuwB40GShf+gGYPaIOzW2ZMO8OxS40iKVW+nOuYVaT5+zFQTGykyH1a6/318ZUQuNbGnQ4rxOtZz6yvEjoUqrr7DiBGYKo87/opdhAzTQDKcTd9Ebmvic4HUqrcn2lypj9czSgvrJcPZJSS74ICTIHOi7YQMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akopJkb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01EFC116C6;
	Mon,  2 Feb 2026 21:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770066256;
	bh=XRzlzAwIzrWwQQCJu0yYDI/QY/MD+z952CyEosMvgJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akopJkb3IJUb0UY+zPkONhlRaYXvL+MBanv8EvQ06eGrkuDIIuCdgXqTMQwBLD923
	 rovYpMsNDFP0Hy2s/XpuQC0hETgCjQM8VsLjBGubzj9cmy3x7SAavwwSswydbABffE
	 nQgDK2NgJceLQRNmpX/wCLHbRRbnQMpKSd0k+xQOsDXFGBRvwxepCTL98xtrMKKtmD
	 xRObm8348BVZvMzN/0zXNq712b9oUL2DK9aAFWEg1IGYpqY3dcYQ1ESkgRqJKW/r+f
	 WEN9bmXfY4GVeFGziTXeBgEov43XNehyJMtQXXHS8H231V4Iha289/VQoJHffUNblu
	 KFkHwgDfhwarQ==
Date: Mon, 2 Feb 2026 13:04:13 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 02/11] readahead: push invalidate_lock out of
 page_cache_ra_unbounded
Message-ID: <20260202210413.GA4838@quark>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202060754.270269-3-hch@lst.de>
 <aYC-set6OAK9F9GE@casper.infradead.org>
 <20260202151755.GA22756@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202151755.GA22756@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76091-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9767FD16DD
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 04:17:55PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 03:11:45PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 02, 2026 at 07:06:31AM +0100, Christoph Hellwig wrote:
> > > +++ b/fs/f2fs/file.c
> > > @@ -4418,7 +4418,9 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
> > >  	pgoff_t redirty_idx = page_idx;
> > >  	int page_len = 0, ret = 0;
> > >  
> > > +	filemap_invalidate_lock_shared(mapping);
> > >  	page_cache_ra_unbounded(&ractl, len, 0);
> > > +	filemap_invalidate_unlock_shared(mapping);
> > 
> > Why is f2fs calling page_cache_ra_unbounded() here?
> 
> From tracing the callers is seems to be able to be called from the
> garbage collector, which might have to move fsverity files.  Not sure if
> that was the reason or is incidental.
> 
> (using the pagecache for GC is generally a very bad idea, and there is
> at least one academic paper showing it is a huge performance problem in
> f2fs, and my initial attempts at using the pagecache for GC in zoned XFS
> also showed horrible results)
> 
> > >  	unsigned int nofs = memalloc_nofs_save();
> > >  
> > > +	lockdep_assert_held_read(&mapping->invalidate_lock);
> > 
> > Hm, why are we asserting that it's not write-locked?  For the
> > purposes of this function, I'd think we want to just
> > lockdep_assert_held()?
> 
> Fine with me.
> 
> > In the tree I'm looking at, there are also calls to
> > page_cache_ra_unbounded() in fs/ext4/verity.c and fs/f2fs/verity.c
> > which probably need the lock taken too?
> 
> I consolidated those into the single call in fs/verity/pagecache.c
> in the previous iteration of this series, and Eric merged the
> first few patches including that one into the fsverity tree.

I changed both instances of lockdep_assert_held_read() to
lockdep_assert_held() when applying.

- Eric

