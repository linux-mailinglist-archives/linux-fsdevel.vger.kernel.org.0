Return-Path: <linux-fsdevel+bounces-42322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF045A402EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7192F3B8973
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DBA205ABC;
	Fri, 21 Feb 2025 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSASlA+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F551202F87;
	Fri, 21 Feb 2025 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177716; cv=none; b=KHeP/xXljhIscULzUKQORreoMas3UChYFD9GkaPMIBX2gYCrOAFvJyURrl/oE7gIiSRUXlM5R1amEZ0tXaRBXLgPj3GYLFG4qOuyZHKCNaj8mYFddI/98e3+3aaVaFkAnbQH5O1oyB4QV5+vUbEt8ZaIvtl+Xl/A2ABy1S7Id/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177716; c=relaxed/simple;
	bh=KCTcOEy7m7DtImxnNfyb914bSpZJiCOKd+nlU77fLRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeAZmvM74SuZWiaUEiqWBN1YcFBQtuaRuCLuHrL6MGk4k7Pi4yShkAToh0r6s5P0P0Ec+JEq8HeExVTMmwaBF/IZMScfvXhvXSx5gy/YY09MYfU8HpiDDuVo747ErPocwCT3SwsBnekBS1pdjxufBx8m62UwyuxjbY+XsQUUow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSASlA+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7340DC4CED6;
	Fri, 21 Feb 2025 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740177715;
	bh=KCTcOEy7m7DtImxnNfyb914bSpZJiCOKd+nlU77fLRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSASlA+rgnHeUCFrNJ62Qtu2Xa5M37QjAqMdXfh5yyAL/THN/swr05FEAnN0JyOsJ
	 z7dXifTlx/gDWuyLuU+TjL1e+5eyyrbewDaJAbJrIkKjQCquG+2XrBI9R4tyxwBVkV
	 lPc1Zm3r06MWghFIs9UINwp7nJ06F5UiplFysvUAwqm0ZGQZiatkwR0wyWohPS1pcW
	 olurebQ2OMIjwuo2jPr70rsoE2UVskiAA6qk4j6AMRvPozETPQm3JpnQGkYgZh9Jtb
	 KrKszdYujRMhmDfBOpB5iDaaainl6Vpl+1baKkl+sZ6cuG6I48+KVR7yAP21kRThm2
	 f2iI7/nB4fGyg==
Date: Fri, 21 Feb 2025 14:41:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to
 take a folio
Message-ID: <20250221224153.GA41579@quark.localdomain>
References: <20250221051004.2951759-1-willy@infradead.org>
 <20250221051607.GA1259@sol.localdomain>
 <Z7gQjS34D_Xg_uVo@casper.infradead.org>
 <20250221210938.GB3790599@google.com>
 <Z7j8vuxjI9E64iw4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7j8vuxjI9E64iw4@casper.infradead.org>

On Fri, Feb 21, 2025 at 10:22:54PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 21, 2025 at 09:09:38PM +0000, Eric Biggers wrote:
> > > Yup, I haven't figured out how to do large folio support, so any
> > > filesystem using fscrypt can't support large folios for now.  I'm
> > > working on "separate folio and page" at the moment rather than "enable
> > > large folios everywhere".  
> > 
> > It might be a good idea to make the limitation to small folios clear in the
> > function's kerneldoc and/or in a WARN_ON_ONCE().
> 
> I can add a VM_BUG_ON like the other
> this-is-not-yet-ready-for-large-folios tests.
> 
> > > Maybe someone else will figure out how to
> > > support large folios in fscrypt and I won't have to ;-)
> > 
> > Decryption is easy and already done, but encryption is harder.  We have to
> > encrypt into bounce pages, since we can't overwrite the plaintext in the page
> > cache.  And when encrypting a large folio, I don't think we can rely on being
> > able to allocate a large bounce folio of the same size; it may just not be
> > available at the time.  So we'd still need bounce pages, and the filesystem
> > would have to keep track of potentially multiple bounce pages per folio.
> > 
> > However, this is all specific to the original fs-layer file contents encryption
> > path.  The newer inline crypto one should just work, even without hardware
> > support since block/blk-crypto-fallback.c would be used.  (blk-crypto-fallback
> > operates at the bio level, handles en/decryption, and manages bounce pages
> > itself.)  It actually might be time to remove the fs-layer file contents
> > encryption path and just support the inline crypto one.
> 
> That should be fine for f2fs and ext4, but ceph might be unhappy since
> it doesn't use bios.  Would we need an analagous function for network
> filesystems?

Oof, I forgot about ceph again.  Something similar applies to ubifs (it's not
block based), but ubifs uses its own bounce buffers, so it never calls
fscrypt_encrypt_pagecache_blocks().  ceph does call it, though.  So yes, while
moving to "block based filesystems will always use inline crypto" would simplify
some of fs/crypto/ and allow block-based filesystems to use large folios on
encrypted files, ceph would need a different solution.  I think it still has to
involve encrypting the folio's data into a list of bounce pages, keeping track
of them during the write, and freeing them at the end of the write.  So we'd
have to look at what is the easiest way to do that in the ceph case.

- Eric

