Return-Path: <linux-fsdevel+bounces-12068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BA85AFC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 00:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7A1F22E22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EAA56B6D;
	Mon, 19 Feb 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wG7Mlzlg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB74C7B;
	Mon, 19 Feb 2024 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708385377; cv=none; b=U3WtDxTZYcm8EYwtNjTQgAEkreVUYPZr1amRUYIE7X+vGuBwyoVqLrr8619+lKRs9LsFOBakgDolL2L3j+rgxJX9iA6wPWT4b2kXTHUE0z4/Awy1+WcNMD4ZbPIq/oAmwfayVUiLPLO6NxXUWSRJx4jsCmMEJzX+rbGc9ULpZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708385377; c=relaxed/simple;
	bh=i8V14nrM/E+tvLrRXHmRSSpl5SuZOuDZOH3fy7ED6yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faUkZwUqb/rDVJjcwE3YwTkdk63wy+eeEPhv1PIpwJTEQKLjzOI+DHfLNwMleUzZJvz7KEUxammQya3UfTebilkl18d8P9keO3ZQ0mXgUwV9BIrzEFD3EeX6SCdPPAcL2sJ66OOYrfW0uRkSWZuua2ssPga2Koy+betmCLy6IDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wG7Mlzlg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pQGcN+Uz6HGYsAB8kabCZ8iJcwMmaEqSe4r7SLZ/ErI=; b=wG7Mlzlg3GG4pOArHBeQiF0qRp
	CJovwrEayzlRV4lzGLLQadsbwB/kmJ88QPBmEQG2TY7Uvhqrk1u/HenW4d/pIoNPFmwLIyzTrDjRr
	0q8MOyaBQJAlpKxZ7lYNkm2XNtm3RZDLL+zHL72r3bU1a9uYB3ahJWxrKTjlU1R9bGIcVr07A2VBI
	vl5Onpp8nMtIl5Fs2XEzbFKdKZOHAywXXG+3CPBGq/C6n+vUSdnV5J4QIys6OUlG3NzWI+qR4i5T8
	qlZL4lr7UW1K5D0w7Pqh3RQV0J448ka6hiaKyc/SgSZplrLT2FoOllvgM8GiWxjOOiTlbHEGyItyq
	+ApEy5sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcD4k-0000000E4PZ-2NTx;
	Mon, 19 Feb 2024 23:29:30 +0000
Date: Mon, 19 Feb 2024 23:29:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <ZdPkWsxKZN8CvQTN@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
 <Zb9pZTmyb0lPMQs8@kernel.org>
 <ZcACya-MJr_fNRSH@casper.infradead.org>
 <ZcOnEGyr6y3jei68@kernel.org>
 <ZdO2eABfGoPNnR07@casper.infradead.org>
 <170838273655.1530.946393725104206593@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170838273655.1530.946393725104206593@noble.neil.brown.name>

On Tue, Feb 20, 2024 at 09:45:36AM +1100, NeilBrown wrote:
> On Tue, 20 Feb 2024, Matthew Wilcox wrote:
> > The example is filemap_range_has_writeback().  It's EXPORT_SYMBOL_GPL()
> > and it's a helper function for filemap_range_needs_writeback().
> > filemap_range_needs_writeback() has kernel-doc, but nobody should be
> > calling filemap_range_has_writeback() directly, so it shouldn't even
> > exist in the htmldocs.  But we should have a comment on it saying
> > "Use filemap_range_needs_writeback(), don't use this", in case anyone
> > discovers it.  And the existance of that comment should be enough to
> > tell our tools to not flag this as a function that needs kernel-doc.
> > 
> 
> Don't we use a __prefix for internal stuff that shouldn't be used?

No?  Or if we do, we are inconsistent with that convention.  Let's
consider some examples.

__SetPageReferenced -- non-atomic version of SetPageReferenced.
Akin to __set_bit.

__filemap_fdatawrite_range() -- like filemap_fdatawrite_range but
allows the specification of sync_mode

__page_cache_alloc() -- like page_cache_alloc() but takes the gfp mask
directly instead of inferring it from mapping_gfp_mask()

__folio_lock() -- This does fit the "don't call this pattern"!

__set_page_dirty() -- Like set_page_dirty() but allows warn to be
specified.

__filemap_remove_folio() -- Like filemap_remove_folio() but allows it
to be replaced with a shadow entry.

__readahead_folio() -- Another internal one

I mostly confined myself to pagemap.h for this survey, but if you've
conducted a different survey that shows your assertion is generally true
and I've hit on the exceptions to the rule ... ?

