Return-Path: <linux-fsdevel+bounces-17956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB98B43ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 05:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9ED1F227BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A698E3C06B;
	Sat, 27 Apr 2024 03:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SAuVtdZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DFB383B1;
	Sat, 27 Apr 2024 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714188417; cv=none; b=G5e2nXRJvSbSPymOApFAHFTQVY+Mb/YWYehM0LIsG444VIVIAQvxTlC2t5whitpnaVhW0fjV/A+axp/EiqldAAzsKv8BSufWRxgRfc1aBwMVtpM77gZgMHiP8vl6Qi7v0GciMCYt26TzS5WHm4Q/9qLQJ53Dnk/n93fdbXgJu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714188417; c=relaxed/simple;
	bh=rpuR8yy1xjzC30bcQqsO07LuNXGEevgvwHEcSYerdeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8jLS6Jcbl9UM3hn410zKo4Ovz9OzaOPHObeGswpHtNkJYAU1LfiePMkRhTkM1iwis8vF73ZiNdyN1NjmIt0TwFklXRCfrSuM9M4cmMwfW3C6SiSn46cEikSb24qp9gNqj7dI9vrrN5UpJfvgl3/9uJlH2ZVCn5L8FM3b/J29Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SAuVtdZF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5v6AQgZQjyOeRuTWmiZF8n0lMYbUyrVMuDyPiZp+bGA=; b=SAuVtdZFgtlC5/s8e3mzOSRlKV
	BnMVkhauKdWMzRFJO8w3xTA2ElRZcxShO2vVWW+uCiwumTOxuOfwej3B9mS+FNlQRDe/NR0Zw6e8C
	z1Jx6rtjKX5dFDw21FlGbF4hQLH33bThbEbQcxeGrFnNnYoLjkplh4uw3lCpfNlH66LuFAPoneK5n
	b3KhG/3zzpCwzWKR60npeaC1LfLPK5NEM8LdCZozpP2F9JlIxtvO+4/kmpZIGhyt8uHVay8rOD77X
	mfivdSttI7aE7keKZm0sWYxdsPgMuNFZHYq1VvNtHBwEF6vzdapQMvt+tjyn/bFTvc8QRK/YEwXwk
	8Nm4zGQg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Yi4-00000006aiS-2RiT;
	Sat, 27 Apr 2024 03:26:44 +0000
Date: Sat, 27 Apr 2024 04:26:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, djwong@kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZixwdKxqYWq4-rxd@casper.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-8-kernel@pankajraghav.com>
 <ZitIK5OnR7ZNY0IG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZitIK5OnR7ZNY0IG@infradead.org>

On Thu, Apr 25, 2024 at 11:22:35PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 25, 2024 at 01:37:42PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> > < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> > size < page_size. This is true for most filesystems at the moment.
> > 
> > If the block size > page size, this will send the contents of the page
> > next to zero page(as len > PAGE_SIZE) to the underlying block device,
> > causing FS corruption.
> > 
> > iomap is a generic infrastructure and it should not make any assumptions
> > about the fs block size and the page size of the system.
> 
> So what happened to the plan to making huge_zero_page a folio and have

There's a series of commits in linux-mm with the titles:

      sparc: use is_huge_zero_pmd()
      mm: add is_huge_zero_folio()
      mm: add pmd_folio()
      mm: convert migrate_vma_collect_pmd to use a folio
      mm: convert huge_zero_page to huge_zero_folio
      mm: convert do_huge_pmd_anonymous_page to huge_zero_folio
      dax: use huge_zero_folio
      mm: rename mm_put_huge_zero_page to mm_put_huge_zero_folio

> it available for non-hugetlb setups?  Not only would this be cleaner
> and more efficient, but it would actually work for the case where you'd
> have to zero more than 1MB on a 4k PAGE_SIZE system, which doesn't
> seem impossible with 2MB folios.

It is available for non-hugetlb setups.  It is however allocated on
demand, so it might not be available.

