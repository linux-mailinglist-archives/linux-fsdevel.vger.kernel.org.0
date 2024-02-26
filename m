Return-Path: <linux-fsdevel+bounces-12821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE0867968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377131F255E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02B12BEA7;
	Mon, 26 Feb 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZCVljQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275C128379;
	Mon, 26 Feb 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958448; cv=none; b=DeK0RbUonks/NN1d1CjSmaT24Dfc4DxLMn9P0R6TsKDbEAxYzwuN4mdT5CPMQLg2r7v0y5s1QaTU7zzUTh8YxhW6dYfBfC/ZdZ52YYvZXMbaRMGBQ19fA08Ydi30ZEzg61pDFcSg5p3M5qYLXLq1nOdLDtuF6OVgxOIWxxJBoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958448; c=relaxed/simple;
	bh=SKSApeOruZLSq1n9l0Dfe1EJrrxjXRO2Y+aMmgRnG+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Px5lWHJ2Oelt3ueLAS8mjkpOJu8YF166iT6FqgDgswqrFSG/XwoOKRgZaNeaEdk0v+c9+rENNKJyAFodQ1qdqsRzAeQk+BXygSN4raQNyYRnO1cGgaJC6ov7fVTKMKrQkCLYa7ktBZ0MpeRyBJznd7eLofHo4Uu2/FoGmKoDlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EZCVljQj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gauGe8/AuKWwXE/zVAiOKHD6lBDudnyYUkAdQbw+0Q0=; b=EZCVljQjaZUEOkxlB+8PNfeRt1
	NQviA1U1m56nvCuj1UZ3e4AkjgDnJFn5grtISYLOThlXZv6PlZaXJpjNypivPEdhPh0mVxz25+8Ay
	opXth4lNOhcTliN3vGJm+HTt8x5Y4NWs0WCYjUVeLzUKY/9vMQnLZt9CPMREiWiuo0PbjUnxdU3gA
	WvwTOKGtNsMpFEQOVpxCRG+9m2rDsPqcKCq89jMOkBTMMTlR794MeF10UDwtGhwZzUaIisCKzdxRy
	yTcksGLDQC+gAMQw/TX7Y2Qn3BRd1rIbv607lZ+3BhHITyihcI/MXS5izrfwSc67yA0OcaWulzIhF
	3gWCr3Mw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rec9q-0000000HPeI-0VQI;
	Mon, 26 Feb 2024 14:40:42 +0000
Date: Mon, 26 Feb 2024 14:40:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, djwong@kernel.org,
	gost.dev@samsung.com, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 03/13] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <Zdyi6lFDAHXi8GPz@casper.infradead.org>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094936.2677493-4-kernel@pankajraghav.com>

On Mon, Feb 26, 2024 at 10:49:26AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Supporting mapping_min_order implies that we guarantee each folio in the
> page cache has at least an order of mapping_min_order. So when adding new
> folios to the page cache we must ensure the index used is aligned to the
> mapping_min_order as the page cache requires the index to be aligned to
> the order of the folio.

This seems like a remarkably complicated way of achieving:

diff --git a/mm/filemap.c b/mm/filemap.c
index 5603ced05fb7..36105dad4440 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2427,9 +2427,11 @@ static int filemap_update_page(struct kiocb *iocb,
 }
 
 static int filemap_create_folio(struct file *file,
-		struct address_space *mapping, pgoff_t index,
+		struct address_space *mapping, loff_t pos,
 		struct folio_batch *fbatch)
 {
+	pgoff_t index;
+	unsigned int min_order;
 	struct folio *folio;
 	int error;
 
@@ -2451,6 +2453,8 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
+	min_order = mapping_min_folio_order(mapping);
+	index = (pos >> (min_order + PAGE_SHIFT)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2511,8 +2515,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;

