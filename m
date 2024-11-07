Return-Path: <linux-fsdevel+bounces-33961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266769C0F90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580F21C229BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60180217F3F;
	Thu,  7 Nov 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fbMq8Mip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87C1EC015;
	Thu,  7 Nov 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010441; cv=none; b=vGjly6aKvz5ExNH4Z7VWjoQUMOMHCiDdYcjINXemi8X6C9r9p3LByy+YRupQbHYweUbh/UpuLLN6XOkL2yOBekxXJXcHunS0qNPtyUXII1rZrnsFqS2tKXnIfX8DUPmYQ1vLkU9OCeMfd/+pLyYKUHnHjePEIw6PTSxS/hSE940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010441; c=relaxed/simple;
	bh=/CH9QSA5NaFSKWHqx2Ka4Z/JWhz9RwhVsy7pSq/bS7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcsMPrRbOrYmubMwPNROywNltxj4LgpPQXrNQd4H8CJ3z92boQS5KTqS4MRkJrxGAxGCPPD6ev7sSFb+l6GxDGRCQyGVfENF96uq8V/aX9e86bQ9yp/nVDWz76osmqNXsqZu6UKgzjzZ6O2Y8V0a5ziswS1wMdevVwcfiGLqbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fbMq8Mip; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HBvcWM0gK7/kTdXAO4nzwP9CRBKS7Dzym5COEsSvMQ0=; b=fbMq8MipzULggm8bQ5DxzOoeTd
	DZtHoCCFK5Yk9UGSWSFAsUgtBbpmaUKR59ya+JtpWzrpWa1+j3kRyd8bhqnZ21tadbfrm6sfELV5d
	wj7Cnfwzyc09EcRSTmNW670JWoGeTx74+2P63voAIFKJQQDnFvCFABr9M4zF1ELDK4Zdg/mJccs+O
	j2mqH8E9r0oSrVa3bwHAdyg7cK6PiZl4oVioJaLQF51Op6gmtnX2wr+MYlAHBx3pANkc4pVYZVfc/
	Xo6D/2zgBpbk6KwSPi0+bxvxhZuY/unEAeztjELz2QI/RhJq/S5jtk/kBgWzfOwQlD0z/ekJFF4Ap
	1Hh0Rt3A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t98t9-00000007KEO-2Ip2;
	Thu, 07 Nov 2024 20:13:55 +0000
Date: Thu, 7 Nov 2024 20:13:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: intel-xe@lists.freedesktop.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] iov_iter: Provide copy_iomem_to|from_iter()
Message-ID: <Zy0fg6E7Fbmi6lsP@casper.infradead.org>
References: <20241107163448.2123-1-michal.wajdeczko@intel.com>
 <20241107163448.2123-2-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107163448.2123-2-michal.wajdeczko@intel.com>

On Thu, Nov 07, 2024 at 05:34:45PM +0100, Michal Wajdeczko wrote:
> +size_t copy_iomem_to_iter(const void __iomem *from, size_t offset,
> +			  size_t bytes, struct iov_iter *i)
> +{
> +	unsigned char buf[SMP_CACHE_BYTES];
> +	size_t progress = 0, copied, len;
> +
> +	from += offset;
> +	while (bytes) {
> +		len = min(bytes, sizeof(buf));
> +		memcpy_fromio(buf, from + progress, len);
> +		copied = _copy_to_iter(buf, len, i);
> +		if (!copied)
> +			break;
> +		bytes -= copied;
> +		progress += copied;
> +	}

This seems like a rather sad implementation.  Why not:

	if (WARN_ON_ONCE(i->data_source))
		return 0;
	if (user_backed_iter(i))
		might_fault();
	return iterate_and_advance(i, bytes, (void *)addr,
			copy_iomem_to_iter, memcpy_iomem_to_iter);

along with

size_t memcpy_iomem_to_iter()
{
	memcpy_fromio(iter_to, from + progress, len);
	return 0;
}`

