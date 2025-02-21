Return-Path: <linux-fsdevel+bounces-42312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316BBA40294
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25D519C4044
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF802252909;
	Fri, 21 Feb 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rsV8JbKX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267518DB0B;
	Fri, 21 Feb 2025 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176579; cv=none; b=XHrBi152JZ3/avSvoQdWJWb8Wa7wsKG/V5gsXPn2w3yELTkKntjjC1GTxyPr3Bi+qJM4uveo7RQOAeQptzm7uQuMErwrO/N2Z+NiUvCbSsbrRo/ZMVyVckZBIwu5o+a3c1xWfOazNVzieRajmT0BVL0myUImAPXKArESxe6oJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176579; c=relaxed/simple;
	bh=vogGsnv55uPHQgIuM9YQyIS0OwRHfzJwGgMrTYh8490=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGBx8RLf3Iw/gf6ki/ErjoLwtNcIu9oAGKEgXLN6v4KPSjSmGpi472o3DxwSUYX2zlo6u4DYRV0tp1egDFbXZ5X41/dRv622dMgvQHOSaciudvWi9/sxrwhqM+1ifc7Ppt6azB1UkPthRG+qP7hchHSA9kXrOS71EVudQf7BNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rsV8JbKX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cu0ycN1zgsGIJYg8IwODAFYvM5bJa0u25BKaWpdZrnQ=; b=rsV8JbKX3LPPcSem3IAxG+eyov
	XJxV1PedtChSkPNzc1hTQQ8KtAMbW005NVRipAMYC0Hmvs/sqk5DL+UJoVM7WUrJkJett7zApeZkA
	5ToKYvpzpsL9O1KV9eEleYazpxbehiIC8vZTwkt8fdAsMSLYLDXq2tAb2aLBBnHE9G0/iQAvYXHPc
	f2Cg89oTeSpXCaE++rxmRexAFBlTzSam8K9QJaxjMK61Tfa4t5Qn96S4Juhk9pEfN8SqD8HPRkwx4
	0uPrXsTfHL17koZE8le5IDlzc4Xsf94ft0zbzWBpNU7y04YqdZsOjjjP0to1E3Ei+kfHF0gkNWmnD
	gj2675GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbQ6-0000000FIt0-0zq3;
	Fri, 21 Feb 2025 22:22:54 +0000
Date: Fri, 21 Feb 2025 22:22:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to
 take a folio
Message-ID: <Z7j8vuxjI9E64iw4@casper.infradead.org>
References: <20250221051004.2951759-1-willy@infradead.org>
 <20250221051607.GA1259@sol.localdomain>
 <Z7gQjS34D_Xg_uVo@casper.infradead.org>
 <20250221210938.GB3790599@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221210938.GB3790599@google.com>

On Fri, Feb 21, 2025 at 09:09:38PM +0000, Eric Biggers wrote:
> > Yup, I haven't figured out how to do large folio support, so any
> > filesystem using fscrypt can't support large folios for now.  I'm
> > working on "separate folio and page" at the moment rather than "enable
> > large folios everywhere".  
> 
> It might be a good idea to make the limitation to small folios clear in the
> function's kerneldoc and/or in a WARN_ON_ONCE().

I can add a VM_BUG_ON like the other
this-is-not-yet-ready-for-large-folios tests.

> > Maybe someone else will figure out how to
> > support large folios in fscrypt and I won't have to ;-)
> 
> Decryption is easy and already done, but encryption is harder.  We have to
> encrypt into bounce pages, since we can't overwrite the plaintext in the page
> cache.  And when encrypting a large folio, I don't think we can rely on being
> able to allocate a large bounce folio of the same size; it may just not be
> available at the time.  So we'd still need bounce pages, and the filesystem
> would have to keep track of potentially multiple bounce pages per folio.
> 
> However, this is all specific to the original fs-layer file contents encryption
> path.  The newer inline crypto one should just work, even without hardware
> support since block/blk-crypto-fallback.c would be used.  (blk-crypto-fallback
> operates at the bio level, handles en/decryption, and manages bounce pages
> itself.)  It actually might be time to remove the fs-layer file contents
> encryption path and just support the inline crypto one.

That should be fine for f2fs and ext4, but ceph might be unhappy since
it doesn't use bios.  Would we need an analagous function for network
filesystems?

