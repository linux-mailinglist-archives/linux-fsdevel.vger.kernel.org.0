Return-Path: <linux-fsdevel+bounces-13210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2986D34F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 20:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F431C21AFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E613C9F2;
	Thu, 29 Feb 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfHiOuS3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F14813774B;
	Thu, 29 Feb 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235443; cv=none; b=FvAwoAIkQUHv1hCNqD7/4Q0dhPpBkjSj4OHR9IfGZS0wbH2jjGpG4dB/Ir18N15PZWTqKkeX+44vvGporCabw1kjLJ7M5POpQokAe3+7IXDnA85927aVV1R06pMZPFqF3EEnoWCBN2+snJhZaUKmnpIbsEPDlkZdREHmb6Qe+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235443; c=relaxed/simple;
	bh=32yj74/3vEglgYQz1Og4De9ujIVTdpiMAur4jWBgQXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by0vYNNZLE0MOulOGqRAN0E9Z/ulZwWumEca1rd8gwJapHHC7mWbM537Q4KAENkPRT//4uTboAG9bQsnPjj5boukEFaBTZNXJQ9Duk6DrqyQ8ooOMYHSmRM3o6gKu9aSaXLB3O17igFg4Drq2kQCsjNo0pApez5elFA7+J4PA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfHiOuS3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8uNmGuKJqG0ZLwvelugqTwty9eAp95ps/IXd1VUbjRE=; b=LfHiOuS377ugSXr21HSPLjoGds
	rRHRotHB6Z2K+UknnXnK+QSxqb+aTii8MgmSzXW1sRNBptAvRcgkCTNz6J+ZbnsCs2gOL69/7CQwh
	HbpeH4t5yDhGvqmnlTjCTBFsDyp9akGVrkIGj6y3BedRK3Vygt5msrjSPEYVN6VtIWpZchOzssQ/V
	WR1aOx0+dyY/SjdSpU3JUwI4U2i/3gjC67frvRbY1ZlyHhnna281LjFJ9s/SzckoOzX+rHWRnRD4q
	DbfpzdwBNaELy6OKw8HL8OqWb7AQNPVnsIkMg3yiwsLXR6E9Xx/G6dwkxCxOWFcKJ/oDRVozID8PI
	7uk/dp4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfmDP-00000008qqb-3bC7;
	Thu, 29 Feb 2024 19:37:11 +0000
Date: Thu, 29 Feb 2024 19:37:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Greg Edwards <gedwards@ddn.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <ZeDc50LQSItEeXY8@casper.infradead.org>
References: <20230814144100.596749-1-willy@infradead.org>
 <170198306635.1954272.10907610290128291539.b4-ty@kernel.dk>
 <20240229182513.GA17355@bobdog.home.arpa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229182513.GA17355@bobdog.home.arpa>

On Thu, Feb 29, 2024 at 11:25:13AM -0700, Greg Edwards wrote:
> > [1/1] block: Remove special-casing of compound pages
> >       commit: 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
> 
> This commit results in a change of behavior for QEMU VMs backed by hugepages
> that open their VM disk image file with O_DIRECT (QEMU cache=none or
> cache.direct=on options).  When the VM shuts down and the QEMU process exits,
> one or two hugepages may fail to free correctly.  It appears to be a race, as
> it doesn't happen every time.

Hi Greg,

By sheer coincidence the very next email after this one was:

https://lore.kernel.org/linux-mm/86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com/T/#u

Can you try Tony's patch and see if it fixes your problem?
I haven't even begun to analyse either your email or his patch,
but there's a strong likelihood that they're the same thing.

