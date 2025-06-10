Return-Path: <linux-fsdevel+bounces-51091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE2AD2C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 05:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE3D16FB2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 03:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F325D1ED;
	Tue, 10 Jun 2025 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EBqqahfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D62AF1B;
	Tue, 10 Jun 2025 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527047; cv=none; b=oFk6FRNYcfcjCyWnbQuLaSKaPeyr2HO5GcwQrxL9U6yTFYM8Qce+3XD6Ci5HX/kNBNaHsRmhi6X+s5h5u0UzZMyeuai8MWe5ZAaqJlNKwVre6MzTlirez+0MDz2XuBPEzP37CJNYShwY0J7Ani6jI7J4BRQuiv3bAlnqxX7zPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527047; c=relaxed/simple;
	bh=MVRvMTKY4Zq/mrv91guSyToqjb2dnWHHIE3Ya68xfRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGnDQyQ/75GN8Le68z9f5Igv0F1ofgbIDjFQto4LTqZUT90ypBComVZw5KCEKNYA3GJKdhVmhNC9Yuo9scb2bWpZVSb3OIkRnC0UvazMAcx5f7bBVXKAUJQw+ienggXLEbTpDOD2nAMHccj5iLhynWzk9/Y8BaMfqwmSdj6E1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EBqqahfv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dHed1Rc21KJ45DuuCfGvy/Ksm4Y7rEPnq66tToCk/8Y=; b=EBqqahfvnN7SrXfF3X1eg6zELV
	wHq3h8/NUAzuLXXKqga/D5ko7oLh4SMz3gjVA73HzC2IxY3Er0UONNIxicBvASMsYcCyFPntJ/P7W
	MfKbiMAICfEnixEUbYd3/P7N/IIJRCT831h64WvByiPKzDT9PUCdw7l1MLh+G1EdOQMFulqUV3LaV
	rfVbPJo+UiNF2XJMX0/6PxrDRwGYH4/hhUaZZRbqsyOjQDt3WyG4NaFZXnzZuKEz6vSur7jEZYQXQ
	7nByZW0Fc5dviH4DP5JPMQNWrI8d7nDhAF09M66407Yja8c+at+GmuVsBCggazBkaU5057Jm8l1Je
	Ob+Hv9vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOpu9-00000005hHs-0j4n;
	Tue, 10 Jun 2025 03:44:05 +0000
Date: Mon, 9 Jun 2025 20:44:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 3/8] iomap: add buffered write support for
 IOMAP_IN_MEM iomaps
Message-ID: <aEeqBWOkB-QXLQ_2@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-4-joannelkoong@gmail.com>
 <aEZpcWGYssJ2OpqL@infradead.org>
 <CAJnrk1asVKKakBOmXghU22fWiZu4D+PDKVM6z5fMbbFNCzP5dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1asVKKakBOmXghU22fWiZu4D+PDKVM6z5fMbbFNCzP5dQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 03:45:05PM -0700, Joanne Koong wrote:
> > I just ran into this for another project and I hated my plumbing for
> > this.  I hate yours very slightly less but I still don't like it.
> >
> > This is really more of a VM level concept, so I  wonder if we should
> > instead:
> >
> >  - add a new read_folio_sync method to the address space operations that
> >    reads a folio without unlocking it.
> 
> imo I hate this more. AFAIU, basically fuse will be the only one
> actually needing/using this?

No, not at all.  We have a few projects that needs a submit_io hook
for iomap buffered reads - on is the btrfs conversion for their checksum
and raid, the other is my series to support T10 PI (and maybe checksums
in non-PI metadata as a follow on).  For ->read_folio and ->readahead
we just has patches from Goldwyn and me to pass a new ops vector for
that.  But I found it really ugly to do this for the write path, even
if it works (my current version).  Also this path is the only reason
why the srcmap in the iomap_iter exists - so that file systems that
do out of place writes can read partial folios from one place, but
return a different mapping to write it back to.  If we split it into
a separate aops we could kill all that, something I've been wanting
to do for a long time.

> Though it's a more intensive change, what about just expanding the
> existing address space operations ->read_folio() callback to take in
> an offset, length, and a boolean for whether the folio should be
> unlocked after the read?

The boolean for locking behavior is not a pattern liked much in
the kernel, for good reason - it makes verification really hard.
Now maybe always unlocking the folio in the caller might make sense,
but I'll need to consult at least willy on that before looking into
that.


