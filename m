Return-Path: <linux-fsdevel+bounces-70420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF79C99E18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 03:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B8724E2484
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E0726E14C;
	Tue,  2 Dec 2025 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H6zUj0Rc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980BB22FDEA;
	Tue,  2 Dec 2025 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642698; cv=none; b=iqopogyBR5URPb52AsfBAeb3l5wfUzeFIijk3K+NJqEYyyS9HARxSasx17OFtbPE3Bzw3XceEfPhPS6ksWAa/HSdWeq2bMSOZiEk8dgeMSLd/LajKogq0ewBbVp7NlSb/sQAyCS8aBtm+B7PAibpaFGVG4RzM+KrNlE9/CXhHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642698; c=relaxed/simple;
	bh=OEFTQuybwSLNdOugGmTjw3APCi8uxkJFjGkqxa3iLd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iesrn+f+aa1Y7QO1l+kRzllsRzfQvCUZLl9kIZS/rYGTND2LoZcNdYzVwE4K+WMCoqQo8P/Bv7a8NgPNHCVNz0DJGCMJMTLGpHIKGxM9QlJ2UyuKeDaGpfTbUSfJ0SYrAOuDSrUJ6sKYx1kZLdkFADsHP+WAya4e4dMqDA5Odhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=H6zUj0Rc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tW1tgRvc4m15Ay6Mwri5wyNnNufCcevV2cFRhMvqU4o=; b=H6zUj0RcVeyBxIx4/yAIAvSrVI
	OKqSQyMJIWnDBbV4g5ec6fwgS5rkHKIIKO2vBVRPrM9waoDSfnF/zzQNZMYedHmD7D3DpwFthNd1g
	mzDj6ieUHjgcLF8/XiI3pONQGPoYUCKw7o33elolIbN3TDfBxN2vOKLOijDNcLNa5VjQfSxdfF6H1
	SNAuA3e/YdOkm3QwDFLOMyUBRW4wrX9TYQFO8qWQbgsSZhhMpTxobyeetgWJyB8Sn+BAbQhDkgqit
	vruZhwL81fzxMu5bbSNesnLJ1EneiYuuKH0HrFfOtriPSJCTKKLV4Rj7V59sfyWjIqWpiecagr7Mx
	CVDdK71Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQGB9-0000000FvgF-1ozh;
	Tue, 02 Dec 2025 02:31:47 +0000
Date: Tue, 2 Dec 2025 02:31:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: hide names_cache behind runtime const machinery
Message-ID: <20251202023147.GA1712166@ZenIV>
References: <20251201083226.268846-1-mjguzik@gmail.com>
 <20251201085117.GB3538@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201085117.GB3538@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 01, 2025 at 08:51:17AM +0000, Al Viro wrote:
> On Mon, Dec 01, 2025 at 09:32:26AM +0100, Mateusz Guzik wrote:
> > s/names_cachep/names_cache/ for consistency with dentry cache.
> > 
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> > 
> > v2:
> > - rebased on top of work.filename-refcnt
> > 
> > ACHTUNG: there is a change queued for 6.19 merge window which treats
> > dentry cache the same way:
> > commit 21b561dab1406e63740ebe240c7b69f19e1bcf58
> > Author: Mateusz Guzik <mjguzik@gmail.com>
> > Date:   Wed Nov 5 16:36:22 2025 +0100
> > 
> >     fs: hide dentry_cache behind runtime const machinery
> > 
> > which would result in a merge conflict in vmlinux.lds.h. thus I
> > cherry-picked before generating the diff to avoid the issue for later.
> 
> *shrug*
> For now I'm working on top of v6.18; rebase to -rc1 will happen at the
> end of window...
> 
> Anyway, not a problem; applied with obvious massage.  Will push tomorrow
> once I sort the linearization out.

	FWIW, I wonder if we would be better off with the following trick:
add
	struct kmem_cache *preallocated;
to struct kmem_cache_args.  Semantics: if the value is non-NULL, it must
point to an unitialized object of type struct kmem_cache; in that case
__kmem_cache_create_args() will use that object (and return its address
on success) instead of allocating one from kmem_cache.  kmem_cache_destroy()
should not be called for it.

It's very easy to do, AFAICS:
	1) non-NULL => have __kmem_cache_create_args() skip the __kmem_cache_alias()
path.
	2) non-NULL => have create_cache() zero what it points to and use that pointer
instead of calling kmem_cache_zalloc()
	3) non-NULL => skip kmem_cache_free() at create_cache() out_free_cache:

"Don't do kmem_cache_destroy() to those" might or might not be worth relaxing -
I hadn't looked into the lifetime issues for kmem_cache instances, no idea
how painful would that be; for core kernel caches it's not an issue, obviously.
For modules it is, but then runtime_constant machinery is not an option there
either.

