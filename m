Return-Path: <linux-fsdevel+bounces-51106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C54FAD2CB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C929F3B0529
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575921FF32;
	Tue, 10 Jun 2025 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jfv8ECEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADF78F4A;
	Tue, 10 Jun 2025 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749530020; cv=none; b=bC2RqLBsZNHiuDpIsLpNqZRVSE2nOOQFIHFuo8cMO9a/XrRZkEP12nWgPRFHVuVLuOlyraP3hR2IRWunGSZgthTvHE8K2mQIrpcG8tX5TEpr9Daj/f9B6GhWAfPMy+78yS0VQFXPDSyrAY2K0TBNXeSZQYeJxABQ7Ed4cymxhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749530020; c=relaxed/simple;
	bh=TyHr5bkkSEUv3+xwVmGVBjlaNLL3/ck1ieIVP3pu2Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RypCjFvsDt1ygvqVRXG3ixxGfZd5PwvOf5UEsOsM02jiYYJOsU5V9caxGBoi08ERTI1PcqD17uKpFLSJswLDVd6S7IUqztCFcASg7muNv+dU0xYw8l39Y7tCCs8FNiY8iWguaZ29rtHEP7Vs6BH1xwLwf2hej3LH/fVcG6VdbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jfv8ECEl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bhq2uAvmwXciN4wckjAT0jx5pVXgwcgkUjPtu3OFJH0=; b=Jfv8ECElD21wKUw+n70c8bi9PW
	wWVZeWS62A7tVJjPKimwOrFmP/C+3XOFUPEssjLqow/KxdTbOvi9tMic0n8aF9a6NWB241oMqriZJ
	kNxOdTZv1Lt8FW8yaECJNAfq97E3uUzbPRze3JQ2S7fLmLL9FesmVCwPB00g64r5zZIOwRgkBRC0n
	q+slHldJS+D/D0dsjwSLbneXPqeHc5fp7RYj5XKcg3BqhgzFfiKM6hrslildSK8ofcz53OJnDQlhl
	sFNVJyt8BXS1PITYU1HMQk5Np9ZmRZheLpVYwcc26DMiyceC/mvbPjZ+Q4p+SNKLTm/znB8GYC5dr
	xjB6E+KQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqg5-00000005l3x-3zGi;
	Tue, 10 Jun 2025 04:33:37 +0000
Date: Mon, 9 Jun 2025 21:33:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <aEe1oR3qRXz-QB67@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-8-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605173357.579720-8-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 05, 2025 at 01:33:57PM -0400, Brian Foster wrote:
> iomap_zero_range() has to cover various corner cases that are
> difficult to test on production kernels because it is used in fairly
> limited use cases. For example, it is currently only used by XFS and
> mostly only in partial block zeroing cases.
> 
> While it's possible to test most of these functional cases, we can
> provide more robust test coverage by co-opting fallocate zero range
> to invoke zeroing of the entire range instead of the more efficient
> block punch/allocate sequence. Add an errortag to occasionally
> invoke forced zeroing.

I like this, having an easy way to improve code coverage using the
existing fallocate and errtag interfaces is always a good thing.

Can I assume you plan to add a testcase using the errtag to xfstests?


