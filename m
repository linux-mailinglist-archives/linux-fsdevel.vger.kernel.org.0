Return-Path: <linux-fsdevel+bounces-42295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938BA3FF2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 19:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804B97AE780
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C842512FA;
	Fri, 21 Feb 2025 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNuPejVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327F2512F9;
	Fri, 21 Feb 2025 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164341; cv=none; b=OSRyT+yNiXqzkTUxhystuBGuMdPFwcTWDY1gj9TYENbJ/rRXiZvRns5Cb5ZAbE7BM4OMIRPpLetI/yGUXXKemhNGeP3Bu+Aps4avQfSI+CFNJuO4QDgYZPCnSt4KBegUCVtWF3FsWKYyIEWOourewr6FQeFh65zeXzcV1j2bYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164341; c=relaxed/simple;
	bh=D1gndCuNHXnXWR+5KjZLuhUrgN/6gjce6B2PXKEtvJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmTdYVazS/Ti2dOgAjQFYEjmqmm+txNzW+BHXsvTqJaucCyFfRD1YDTH1IdD77UHyF1rtIqW04GiMUnJlG4h2GSB8sm95GXZvMYdPt1LhaeanRinLmMLutjolHfvcDW1/yNiqFs2djG6eJ3rPiphoyU/YmS4O2oHPqcpkyMAgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNuPejVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E0CC4CED6;
	Fri, 21 Feb 2025 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740164340;
	bh=D1gndCuNHXnXWR+5KjZLuhUrgN/6gjce6B2PXKEtvJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNuPejVA8VhXg7mw02ryLSNiBIcvpQV48LtkfBDqGeg9IP/S8FDcIKl29JlXQPvvI
	 3i4e3mveISKcofvf4+fqwGBKOTwXPw11yGMfNkkFwGO4w0EANJPg+LocjTt76vAkJF
	 qtbWYFpBFNXI4oNjBalh0O/OcmHrCdXnjDz/tjz1VxHUV4ZUP4ORNH3t4e2QQVwYxD
	 70HC1j/43KbjRK3DBh4xCcvkpN6JL817QUmba+A2MnskvoVrwUuoXqnSgisJ/9a9kl
	 nPAOgnPPC2W6arLJAs1ly2MSuBTv/qY7/274FMQFx8qutbw1w+rNzZL5eb5k5a4JFa
	 2F1wx1fBfZI+w==
Date: Fri, 21 Feb 2025 10:58:58 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, dave@stgolabs.net,
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org,
	john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH v2 4/8] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <Z7jM8p5boAOOxz_j@bombadil.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-5-mcgrof@kernel.org>
 <Z7Ow_ib2GDobCXdP@casper.infradead.org>
 <a4ba2d82-1f42-4d70-bf66-56ef9c037cca@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ba2d82-1f42-4d70-bf66-56ef9c037cca@suse.de>

On Tue, Feb 18, 2025 at 04:02:43PM +0100, Hannes Reinecke wrote:
> On 2/17/25 22:58, Matthew Wilcox wrote:
> > On Tue, Feb 04, 2025 at 03:12:05PM -0800, Luis Chamberlain wrote:
> > > @@ -182,7 +182,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
> > >   		goto confused;
> > >   	block_in_file = folio_pos(folio) >> blkbits;
> > > -	last_block = block_in_file + args->nr_pages * blocks_per_page;
> > > +	last_block = block_in_file + args->nr_pages * blocks_per_folio;
> > 
> > In mpage_readahead(), we set args->nr_pages to the nunber of pages (not
> > folios) being requested.  In mpage_read_folio() we currently set it to
> > 1.  So this is going to read too far ahead for readahead if using large
> > folios.
> > 
> > I think we need to make nr_pages continue to mean nr_pages.  Or we pass
> > in nr_bytes or nr_blocks.
> > 
> I had been pondering this, too, while developing the patch.
> The idea I had here was to change counting by pages over to counting by
> folios, as then the logic is essentially unchanged.
> 
> Not a big fan of 'nr_pages', as then the question really is how much
> data we should read at the end of the day. So I'd rather go with 'nr_blocks'
> to avoid any confusion.

I think the easier answer is to adjust nr_pages in terms of min-order
requirements and fix last_block computation so we don't lie for large
folios as follows. While at it, I noticed a folio_zero_segment() was
missing folio_size().

diff --git a/fs/mpage.c b/fs/mpage.c
index c17d7a724e4b..624bf30f0b2e 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -152,6 +152,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 {
 	struct folio *folio = args->folio;
 	struct inode *inode = folio->mapping->host;
+	const unsigned min_nrpages = mapping_min_folio_nrpages(folio->mapping);
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
@@ -172,6 +173,8 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 	/* MAX_BUF_PER_PAGE, for example */
 	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
+	VM_BUG_ON_FOLIO(args->nr_pages < min_nrpages, folio);
+	VM_BUG_ON_FOLIO(!IS_ALIGNED(args->nr_pages, min_nrpages), folio);
 
 	if (args->is_readahead) {
 		opf |= REQ_RAHEAD;
@@ -182,7 +185,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		goto confused;
 
 	block_in_file = folio_pos(folio) >> blkbits;
-	last_block = block_in_file + args->nr_pages * blocks_per_folio;
+	last_block = block_in_file + ((args->nr_pages * PAGE_SIZE) >> blkbits);
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
@@ -269,7 +272,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	}
 
 	if (first_hole != blocks_per_folio) {
-		folio_zero_segment(folio, first_hole << blkbits, PAGE_SIZE);
+		folio_zero_segment(folio, first_hole << blkbits, folio_size(folio));
 		if (first_hole == 0) {
 			folio_mark_uptodate(folio);
 			folio_unlock(folio);
@@ -385,7 +388,7 @@ int mpage_read_folio(struct folio *folio, get_block_t get_block)
 {
 	struct mpage_readpage_args args = {
 		.folio = folio,
-		.nr_pages = 1,
+		.nr_pages = mapping_min_folio_nrpages(folio->mapping),
 		.get_block = get_block,
 	};
 

