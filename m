Return-Path: <linux-fsdevel+bounces-51235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12759AD4C38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9224D1899B69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1A22D4C7;
	Wed, 11 Jun 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O9YzAY5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8623026B;
	Wed, 11 Jun 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625204; cv=none; b=pSBUSkP8Vq6X1uEMDhWet1mphHcBTlFyYlMnlNDzq6jzdkC17w/k/raQcXMXLzQqB07QhiKvMCwrbjfZ95ouumfnOEqFda4rBkXaJqJLf0OLmY9EWNRBS0gRjo/ziZUK3e7g0TCJTQTVVTDq1paP1YoW1rPx5rgJf8/kVFnKOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625204; c=relaxed/simple;
	bh=oK46InMCGqOyrCMeTdvA39/S1GaETKO3zLEwchOaGDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/J4uxFJlM3o+Xaf2XFGApd5QyI/7f9s0Lp8UriT9YCRT2y5qfLtdw6+Hn8s76uy5CBO6z+z4rv7kj1YIyoheb76hfe0iZ3Er6eY4GOGCcJ5qg1dWAeSre0slnYOvQM5lXVMXiUG8LIKHtPYwKkuFoeD8qDokHIs0saqLDPYf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O9YzAY5F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7t6fBI3g7MVf8MoodTMxtcgo/gTd3Z2a2WB7VbT0fYU=; b=O9YzAY5Fx6mbOAJ37ZHD2+ptgj
	QYYgnUOtSUmhxb+fnckY5gWFMLtvR/JkKTaUTFVmA9D+HdjzwTszQSirZQj0FWbO5bnoLKGBI4JF8
	AG7BK+T45fu2VvFX/C3zb2rJ+wM2iPtMPnrBJB3bZimMW51B5nIQSlytVKixL6EoylYo7oJ6FKLjv
	nbGQlHH71RGJi+6rJo0ozxpIKSYVRJSDODcuLyUcpTzBsi1pp5pFxUm1oeHtYg40nDMBS2Rjt0/pV
	8uxusPu9z78O3zdQ7pZHJEUPV2u4dzrvgNcAaM4v18FGxrosjnUGVQdG6UjKpTlgXwM4Tsmnx3dwy
	YFoeXUtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPFRK-000000093kY-0zDi;
	Wed, 11 Jun 2025 07:00:02 +0000
Date: Wed, 11 Jun 2025 00:00:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
Message-ID: <aEkpcmZG4rtAZk-3@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610205737.63343-6-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 04:57:36PM -0400, Mike Snitzer wrote:
> IO must be aligned, otherwise it falls back to using buffered IO.
> 
> RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
> nfsd/enable-dontcache=1) because it works against us (due to RMW
> needing to read without benefit of cache), whereas buffered IO enables
> misaligned IO to be more performant.

This seems to "randomly" mix direct I/O and buffered I/O on a file.
That's basically asking for data corruption due to invalidation races.

But maybe also explain what this is trying to address to start with?

