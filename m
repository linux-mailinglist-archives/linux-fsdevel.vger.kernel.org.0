Return-Path: <linux-fsdevel+bounces-54046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7979AFAADF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D55170944
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFD32638B2;
	Mon,  7 Jul 2025 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJbJX81L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECE25525F;
	Mon,  7 Jul 2025 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866041; cv=none; b=sP6A6rTWu+68VI2KwBPp4UxP6hV9bPLUSSr18K6eVUJ2UGyAwTrK5KK37nsewWFh7lzo1zhXkCK46UofDmBPY+m3smblT4wP6bbqMQgs/vsxnYN0bqWG9alR9J4M8xL94WyXF8EQjfxOt4HxbeDjGr28VEkVkyLgiN2i1X9qWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866041; c=relaxed/simple;
	bh=LWXSP11U4v7LhS9NiD0RGxeMQ2ejJp1tXMOxu9EiViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdRN+VsLseQMAgZgFEnyd4uR/2wDqhMIZMVdYihqwrgym8+oH0aoNXmuTFCYUmQhtamuHbwRatRP6Ll7lj1G9dqoI7slNPHdloa2yMdi03Nd2eZPr5yz2JBV5hIk9bBXKy1S5K1R8Etu7qZnipysJ+/Otx0as5Ef3CqJrNevp2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mJbJX81L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yjYpPsb1PlpJ4trdF82+OwKClS+X6SpzN0bYgE8MEi8=; b=mJbJX81LkHLWenjyVpDOEV6th/
	0RXfvxzyDfXyzQ8ca97WJZaSBp6QXvcMxkje3u9wyL519KCvFaNGie7tG+MMdv61u5rMtVk1g7RUT
	qKmGSYAluEIaCApNI/pUdpBZdoFPjeSZXpwM/jxfVf+4CeDVBpisv1p8VuSvgZjod0WrWry/D/pms
	fCfCIuOW7tLKdVEAjnWyab0OruZA5cEBzvlWm0FEZI29mwl/7jtKshwJHzIIbTP4kNScBGkwDtoiZ
	4J9eGct4fcMVrsYgIJ6MDtv1Lh9lvLtlGP0fjin0VJSvDTsILqnkesaH05sCeEPxpU+VIACEY/Cem
	iHAZuwLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYeNp-00000001QwP-15D7;
	Mon, 07 Jul 2025 05:27:17 +0000
Date: Sun, 6 Jul 2025 22:27:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Yuwen Chen <ywen.chen@foxmail.com>, hch@infradead.org,
	brauner@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] libfs: reduce the number of memory allocations in
 generic_ci_match
Message-ID: <aGtatW8g2fV6bFkm@infradead.org>
References: <aGZFtmIxHDLKL6mc@infradead.org>
 <tencent_82716EB4F15F579C738C3CC3AFE62E822207@qq.com>
 <20250704060259.GB4199@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704060259.GB4199@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 03, 2025 at 11:02:59PM -0700, Eric Biggers wrote:

[Can you trim your replies to the usual 73 characters?  The long lines
make them quite hard to read without first reflowing them]

> The real problem is, once again, the legacy crypto_skcipher API, which requires
> that the source/destination buffers be provided as scatterlists.  In Linux, the
> kernel stack can be in the vmalloc area.  Thus, the buffers passed to
> crypto_skcipher cannot be stack buffers unless the caller actually is aware of
> how to turn a vmalloc'ed buffer into a scatterlist, which is hard to do.  (See
> verity_ahash_update() in drivers/md/dm-verity-target.c for an example.)

I don't think setting up a scatterlist for vmalloc data is hard.  But it is
extra boilerplate code that is rather annoying and adds overhead.

> code in the kernel uses is something that would be worth adopting for
> now in fname_decrypt().  As I mentioned above, it's hard to do (you
> have to go page by page), but it's possible.  That would allow
> immediately moving generic_ci_match() to use a stack allocation, which
> would avoid adding all the complexity of the preallocation that you
> have in this patchset.

I suspect that all the overhead required for that get close to that of a
memory allocation.

But I wonder why generic_ci_match is even called that often.  Both ext4
and f2fs support hashed lookups, so you should usually only see it called
for the main match, plus the occasional hash false positive, which should
be rate if the hash works.

Yuwen, are you using f2fs in the mode where it does a linear scan on a
hash lookup miss?  That was added as a workaround for the utf8 code point
changes, but is a completely broken idea the defeats hashed lookups and
IIRC only was default for a very short time.

Note that even with this fixed, using an on-stack allocation would be
nice eventually when moving the crypto library API, as it would still
avoid the allocation entirely.  But caching shouldn't be worth it if the
number of generic_ci_match per lookup is just slightly above 1.

