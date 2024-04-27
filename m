Return-Path: <linux-fsdevel+bounces-17961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D098B4427
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 06:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB33282A10
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 04:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4E3F8DE;
	Sat, 27 Apr 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bPAWAAb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B11E484;
	Sat, 27 Apr 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714193568; cv=none; b=EOZ6Fq1iqDj3ZBkjMEtprpNeC/MsdowP2B3luzMm0/6sDO/GMjP9r5tIyxHmkOXjWrMgY8qwt8j6a9xuB0eoxL7h8TddFW3oyzyylJIZ4XvMVDj6wadIMiHEcrKHAaptKOZu6m0lmgS57RmC87p3cF46fJfmECtThgUth1w1G6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714193568; c=relaxed/simple;
	bh=pEJMKPSL/4T4c39L6pON1wSi92j6YfVi3whE3Qt053Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAlQJXI22CUiBnCJeaGV8aX4h2h6H0FoD9jZtwJg+JrwMMiz46XVANze6vmAcskIvitHhP1YNivp6d6Q2W5KIAgP0H1IW42L1dx90jJNAEYaSZoc96/rKK7mWoxnZg2BC0xcCIGjoYUyUMZXJYMzqesyjOc3pl0oaYZCtBu+cxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bPAWAAb3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cI4NhT54XJQW9j011jj9qavFEqDFKemcmwzLd5Nc2A8=; b=bPAWAAb36C3P7xHAHzgnjaFMDU
	Y3JaYL8W0w6BCbiw4fK0P4bIYdYeAwF+l0SmQteiR75RBPZBMMfqUrWx/kfPkQ5osfV1yOl9/wkDX
	EW5O9JUCXsDVsJAcXVPnT0sOdJoNlEzh5HF319wEqhfI/l+dAt9Z4/BiAMqCRRlxLL7MaCZGBYJ1n
	h9Xo52YenoDDhRkWerBLXskUz0cpjOhMVqsii+9ojdP6kHhvuO5pEkBaJbC39T7laYB9sWswqxRh9
	Jof0E3VnLBsAheIVsnjrMVTF3LSFSWhtmWe3vZJd2REjC3xWJwioZb9+SzISJULpQ9Gg7uMelDVAi
	8K9J4GQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0a3F-0000000EpDA-1S8o;
	Sat, 27 Apr 2024 04:52:41 +0000
Date: Fri, 26 Apr 2024 21:52:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZiyEmb296SOjXBtS@infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-8-kernel@pankajraghav.com>
 <ZitIK5OnR7ZNY0IG@infradead.org>
 <ZixwdKxqYWq4-rxd@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZixwdKxqYWq4-rxd@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 27, 2024 at 04:26:44AM +0100, Matthew Wilcox wrote:
> There's a series of commits in linux-mm with the titles:
> 
>       sparc: use is_huge_zero_pmd()
>       mm: add is_huge_zero_folio()
>       mm: add pmd_folio()
>       mm: convert migrate_vma_collect_pmd to use a folio
>       mm: convert huge_zero_page to huge_zero_folio
>       mm: convert do_huge_pmd_anonymous_page to huge_zero_folio
>       dax: use huge_zero_folio
>       mm: rename mm_put_huge_zero_page to mm_put_huge_zero_folio
> 
> > it available for non-hugetlb setups?  Not only would this be cleaner
> > and more efficient, but it would actually work for the case where you'd
> > have to zero more than 1MB on a 4k PAGE_SIZE system, which doesn't
> > seem impossible with 2MB folios.
> 
> It is available for non-hugetlb setups.  It is however allocated on
> demand, so it might not be available.

We could just export get_huge_zero_page/put_huge_zero_page and make
sure it is is available for block sizse > PAGE_SIZE file systems, or
is there a good argument against that?


