Return-Path: <linux-fsdevel+bounces-17858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE78B3044
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8889B22FE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 06:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C113A87E;
	Fri, 26 Apr 2024 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wZKm1ytG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD013A3F6;
	Fri, 26 Apr 2024 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112560; cv=none; b=bJXNhmt1jATPH/LnBT5UCdwfxAd/R9KIik786NEsfCi0marLjXbEZzevCerLY0xYCJ2W2ksqhYnGCGDAXEU5vJoZimqM4qNFe+dUgbkoDOBAo17Qn71ypZOR80p4+1u+9XlTehkLx8SJGg94EwEu1szKqI6Q85R82KFCiq2RmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112560; c=relaxed/simple;
	bh=BR48DrtgCPpatn69kUSmi7M2D+owOLBvQdsaqG/9+R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8Q30rSK2vPta8y+2JP7Yx7Fp80GiqXRuk5LX5YAjY8ivMfs0HEh4Q5OZ3h3H8NpEN3Ox0z4nzR/0DeH/h3YTZW1CdpZr4GUdndhz/ovutGqNojmZ6i7YEPlTBBCEvw301AMlB3w7OKcPOOGXXhUwrDv/rZY0P57uu4MbBsJoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wZKm1ytG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OsCAXcsOgjQmywmQiyJHHP0zBpAzxY9THRzdMHy/kms=; b=wZKm1ytG9a1ZnUonedxPFrvO0g
	U6Q9t7hfkAQkIP4+Z8OfwFc8wekHFirxtyScMm48irq7pVsay7NEyvMEpQwDtOdfFm+eVU/RyVmhX
	TjGhLKN66BuY73OHbrT8FobgqymnsDyIHM4d/8fiySCT0VT6qzOWIzO0eU7v4TvYTaFz/Mai9i1SN
	2dEmpYu9o7smJ/sa9OE30EXtdIUA3coUZcGA+lMJhRiSh4PoMESXTlRS+Oxh5fOW112QWNssSuygu
	t3UpOPkOfOd61djqpu1+q/wnQhuEeaG3NkSl4JwjUWNfENMbDcQUoRNaD8nyeMyIU+dDqioWNwFPC
	GsILR2+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Eyh-0000000BI6s-392P;
	Fri, 26 Apr 2024 06:22:35 +0000
Date: Thu, 25 Apr 2024 23:22:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZitIK5OnR7ZNY0IG@infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-8-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-8-kernel@pankajraghav.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 25, 2024 at 01:37:42PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.

So what happened to the plan to making huge_zero_page a folio and have
it available for non-hugetlb setups?  Not only would this be cleaner
and more efficient, but it would actually work for the case where you'd
have to zero more than 1MB on a 4k PAGE_SIZE system, which doesn't
seem impossible with 2MB folios.


