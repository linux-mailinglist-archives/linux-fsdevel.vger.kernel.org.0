Return-Path: <linux-fsdevel+bounces-72667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C9CFF52B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B60963453E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CFF352F9D;
	Wed,  7 Jan 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tKwmlW3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833F336ECA;
	Wed,  7 Jan 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802746; cv=none; b=KymuRIYcJTtm8ZF2mO4+/bqJX53lSEm4PKMwff1yTvmnRAn3wR7qSS3iVtAueieLH6dE8Hnb+Cdw8eqlxKJLyrbUPJqen3Bs3K4Jbq/Aj5+JuLdLJMIyLVy+UZY5du6TlRXof14zwNq+eFzhbBx+MBIVTfNaxQ8+kD60N9vSvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802746; c=relaxed/simple;
	bh=9WSsVKcWi1MPhmQZ9YTuKiH9MV++AlT3b0XG/31hze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgxN3PcE4d5bHoSVm9N7wnYSMfcJZTgfWyAY7/TUuuYMMsnZA9HrQkRFJfSnJVk1UQCcpBl8nbwbCuphoZsfg5Im1sTDgC9hRBQ6Pd+gzmQSS6+p8J/6k9W2g8tGiiTOH/YRRI7bETseUMm5rkc47Ih8gb3FSsihQyVDnIHtjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tKwmlW3N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CtqjvYVbsJ9Q52it8W6vomMoBo9AhV4tm5GtSo/oG/g=; b=tKwmlW3NTUHOjME+Z6BZ19xGKT
	bLv0SFyKENflH/d1DeKn9uBrZMldZ6/zb6SzisuRXFhNwIo9uHlmb65V8t9d4kYh7Z898y0/An0Va
	PXviUtOmDT8o1kzFkg40AL0znHXM1hB0AlOfom6vutZw6f59lWOZkEWvik+S31QBO3NQLHtd/jZOP
	8glCrdwlCPV5CYmI1m2gehoeekeVI8QhkBD/xkj8YP/P36B00FTVgcgz8KzkbtRfRGf5lVN79YAN+
	8V8wYrWCCWvVYZ3G6sIdhJoQTVkTuWQ6GaN+ivEB5bYvVoaKZdCEj7AFe5zRolvTphrnaKjFbsH/n
	j4hdaZlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdWFH-0000000FFSQ-0vvr;
	Wed, 07 Jan 2026 16:18:51 +0000
Date: Wed, 7 Jan 2026 08:18:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: guzebing <guzebing1612@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	guzebing <guzebing@bytedance.com>,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH] iomap: add allocation cache for iomap_dio
Message-ID: <aV6HawIBiF-fQo31@infradead.org>
References: <20251121090052.384823-1-guzebing1612@gmail.com>
 <aSA9VTO8vDPYZxNx@infradead.org>
 <dc92f814-043c-45b2-8d2a-403f462434d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc92f814-043c-45b2-8d2a-403f462434d4@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 05, 2026 at 05:27:54PM +0800, guzebing wrote:
> Yes, I try to use a dedicated kmem cache to allocate cache for iomap-dio
> structure. However, when system memory is sufficient, kmalloc and kmem cache
> deliver identical performance.

Thanks for benchmarking this.

> > Also any chance you could factor this into common code?
> > 
> For a mempool, we first allocate with kmalloc or kmem cache and finally fall
> back to a reserved cache—this is for reliability. It’s not a great fit for
> our high‑performance scenario.
> 
> Additionally, the current need for frequent allocation/free (hundreds of
> thousands to millions of times per second) may be more suitable for the bio
> or dio structures; beyond those, I’m not sure whether similar scenarios
> exist.
> 
> If we were to extract a generic implementation solely for this, would it
> yield significant benefits? Do you have any good suggestions?


Factoring mean the percpu cache.  But given that it's been so long that
I looked at the code all the defails of this have been paged out from
my brain.  I can take another look when you resend it.

