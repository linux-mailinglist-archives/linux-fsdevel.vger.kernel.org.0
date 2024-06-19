Return-Path: <linux-fsdevel+bounces-21926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F21AB90F092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 16:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998801F216AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B881C22638;
	Wed, 19 Jun 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R4r5BcDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FF1EEFC;
	Wed, 19 Jun 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807473; cv=none; b=YFjejR7uszx5MkfWLsGEvz++v7+F+UhSE8Gq5/bofHLBuge5eAlYWtPZ4GPKCFME+eQxLRWMCbjPFesqYn2pg2DLRqFixbrec4g1dK9MCnUfeBkTInnOqwv++Da0L2jieuGZlANA7VU3Cq1vqu8NmlkJwYbpAvIqEWnmwMAFSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807473; c=relaxed/simple;
	bh=mokG9KzYjP0FvCT02jJtcqmMzFsJbK0vzKYVHnU0+0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp2N8YnCcl2vPn/iAjolvK+bEEQY9LY5LGVjFU8jrzEsEnOSdTeeMxgsY5SZDI/65tf82G06ylfzfuQSCGfg/jCj0BVI+UicL/1bGZS2fFAkV4lyn8Qf9zlhQaRRgxKU1nU2ec56Yg8YQk6MNI5brwDS2QmEDsBWM9kjojv/6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R4r5BcDg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k2QJ5xt/hfqiRgJyHINubwKNUZB5gV63Z6JjLwesmnA=; b=R4r5BcDgAwMJN1xk3ugg2T0Aw9
	c5BWMg3UufqI+vTsVkZ9VWxJXBsYYo6eYBc/RGQCyMkJKTXTChMm7N1LOeBCjGotF/JIz+nyLHWcR
	GN7evght3t1jERPaYfJBR5y42B5kMenXmNnBfwRYkZSqwUvNbmpeOGIuZ1Yzj+yk1ytiH9skLoxpZ
	B1g9+42p5bCez7TwXjlrEVhY3up8z0biGSSDJFPDZDnJKSjtS/eweJiXxhxOShWkLXwuc3n15eoYN
	4Y+a5IhgmPuuhzXazKfVCrBMM1XBrxEZn3NPuNbgLUO2neSnLmrDGnueV4t+3gY+KWFeaTWfAyllc
	bp8kTHjw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwL5-00000004poA-4BfE;
	Wed, 19 Jun 2024 14:31:08 +0000
Date: Wed, 19 Jun 2024 15:31:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Zhenyu Zhang <zhenyzha@redhat.com>,
	Linux XFS <linux-xfs@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Shaoqin Huang <shahuang@redhat.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
Message-ID: <ZnLrq4vJnfSNZ0wg@casper.infradead.org>
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me>
 <ZRci1L6qneuZA4mo@casper.infradead.org>
 <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com>
 <6d3687fd-e11b-4d78-9944-536bb1d731de@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d3687fd-e11b-4d78-9944-536bb1d731de@redhat.com>

On Wed, Jun 19, 2024 at 11:45:22AM +0200, David Hildenbrand wrote:
> I recall talking to Willy at some point about the problem of order-13 not
> being fully supported by the pagecache right now (IIRC primiarly splitting,
> which should not happen for hugetlb, which is why there it is not a
> problem). And I think we discussed just blocking that for now.
> 
> So we are trying to split an order-13 entry, because we ended up
> allcoating+mapping an order-13 folio previously.
> 
> That's where things got wrong, with the current limitations, maybe?
> 
> #define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> 
> Which would translate to MAX_PAGECACHE_ORDER=13 on aarch64 with 64k.
> 
> Staring at xas_split_alloc:
> 
> 	WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT < order)
> 
> I suspect we don't really support THP on systems with CONFIG_BASE_SMALL.
> So we can assume XA_CHUNK_SHIFT == 6.
> 
> I guess that the maximum order we support for splitting is 12? I got confused
> trying to figure that out. ;)

Actually, it's 11.  We can't split an order-12 folio because we'd have
to allocate two levels of radix tree, and I decided that was too much
work.  Also, I didn't know that ARM used order-13 PMD size at the time.

I think this is the best fix (modulo s/12/11/).  Zi Yan and I discussed
improving split_folio() so that it doesn't need to split the entire
folio to order-N.  But that's for the future, and this is the right fix
for now.

For the interested, when we say "I need to split", usually, we mean "I
need to split _this_ part of the folio to order-N", and we're quite
happy to leave the rest of the folio as intact as possible.  If we do
that, then splitting from order-13 to order-0 becomes quite a tractable
task, since we only need to allocate 2 radix tree nodes, not 65.

/**
 * folio_split - Split a smaller folio out of a larger folio.
 * @folio: The containing folio.
 * @page_nr: The page offset within the folio.
 * @order: The order of the folio to return.
 *
 * Splits a folio of order @order from the containing folio.
 * Will contain the page specified by @page_nr, but that page
 * may not be the first page in the returned folio.
 *
 * Context: Caller must hold a reference on @folio and has the folio
 * locked.  The returned folio will be locked and have an elevated
 * refcount; all other folios created by splitting the containing
 * folio will be unlocked and not have an elevated refcount.
 */
struct folio *folio_split(struct folio *folio, unsigned long page_nr,
		unsiged int order);


> I think this does not apply to hugetlb because we never end up splitting
> entries. But could this also apply to shmem + PMD THP?

Urgh, good point.  We need to make that fail on arm64 with 64KB page
size.  Fortunately, it almost always failed anyway; it's really hard to
allocate 512MB pages.

