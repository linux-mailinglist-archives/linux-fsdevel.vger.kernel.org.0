Return-Path: <linux-fsdevel+bounces-42309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5EA401CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C3616A4BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216CB253B7D;
	Fri, 21 Feb 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAJ8LvTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C62505BD;
	Fri, 21 Feb 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172180; cv=none; b=qMvhJg3UYnQU0YuD0H06U84UmgJmmSvyTIVmMXEbFwElzFFRAfOotFFRi/QKLmIGX1x0GYphbGbH1atz1XD79DLSqdrLoQlkNFHrZniwJy/P5AMD8L6al903BnAugwO0zxTPru2FwZ5nnNmSnmB1h7Ku9NfLZ/tWE4DR7tWhkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172180; c=relaxed/simple;
	bh=hlpKDA0z0+EXCXi8dk4vSXmieSEGwL+lw6PBDapawiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brsogKzb96cqalUnz1wH0XN2AwRneiPrqcQ/1da3ubb8712X7kAdfSl/ukE2k55y6+Ocaax4+ctuDapD2qKoQjZheIdzRiAXbLTr68D4n/0B1X9TDcWro18UvwkW4ihQ7Z2BjGLRqJe9Wq8nB6uxYnwIQpFIi/RlmNwOTMxXS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAJ8LvTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB262C4CED6;
	Fri, 21 Feb 2025 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740172179;
	bh=hlpKDA0z0+EXCXi8dk4vSXmieSEGwL+lw6PBDapawiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAJ8LvTx8gxz1cas5VN+djHvXLB9bNWCWtQrp3Fzu52nZlQOPyOn96ylgnHiGv8iY
	 kh45q6E2Mmn80LKgnZBvrjnlv4kDgwJCbjtDWguL7MzO4eATNTrNm2K3NicjIFshdO
	 /XK4OJ2ut4gg2ac4980Hj59yfMbGivwtMQpeFgoQec9sBKByCmibk7yCKGrshagOah
	 JGf/snx7qP5ye9no6yC72ug+ZLVUwEzB4NPJ/5llLCNFgmiU2JvmFQmwHl6BSwE0NE
	 XdjFP4xp4WvDV3vBLZDiBB24wrUuYdULsqmVKnqGcuLcrq33IFTZlLtFcpZXVUMcss
	 JAYktMkEmdnwA==
Date: Fri, 21 Feb 2025 21:09:38 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to
 take a folio
Message-ID: <20250221210938.GB3790599@google.com>
References: <20250221051004.2951759-1-willy@infradead.org>
 <20250221051607.GA1259@sol.localdomain>
 <Z7gQjS34D_Xg_uVo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7gQjS34D_Xg_uVo@casper.infradead.org>

On Fri, Feb 21, 2025 at 05:35:09AM +0000, Matthew Wilcox wrote:
> On Thu, Feb 20, 2025 at 09:16:07PM -0800, Eric Biggers wrote:
> > On Fri, Feb 21, 2025 at 05:10:01AM +0000, Matthew Wilcox (Oracle) wrote:
> > > ext4 and ceph already have a folio to pass; f2fs needs to be properly
> > > converted but this will do for now.  This removes a reference
> > > to page->index and page->mapping as well as removing a call to
> > > compound_head().
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > It's still assumed to be a small folio though, right?  It still just allocates a
> > "bounce page", not a "bounce folio".
> 
> Yup, I haven't figured out how to do large folio support, so any
> filesystem using fscrypt can't support large folios for now.  I'm
> working on "separate folio and page" at the moment rather than "enable
> large folios everywhere".  

It might be a good idea to make the limitation to small folios clear in the
function's kerneldoc and/or in a WARN_ON_ONCE().

> Maybe someone else will figure out how to
> support large folios in fscrypt and I won't have to ;-)

Decryption is easy and already done, but encryption is harder.  We have to
encrypt into bounce pages, since we can't overwrite the plaintext in the page
cache.  And when encrypting a large folio, I don't think we can rely on being
able to allocate a large bounce folio of the same size; it may just not be
available at the time.  So we'd still need bounce pages, and the filesystem
would have to keep track of potentially multiple bounce pages per folio.

However, this is all specific to the original fs-layer file contents encryption
path.  The newer inline crypto one should just work, even without hardware
support since block/blk-crypto-fallback.c would be used.  (blk-crypto-fallback
operates at the bio level, handles en/decryption, and manages bounce pages
itself.)  It actually might be time to remove the fs-layer file contents
encryption path and just support the inline crypto one.

- Eric

