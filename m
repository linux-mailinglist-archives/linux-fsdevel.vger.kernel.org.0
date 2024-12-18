Return-Path: <linux-fsdevel+bounces-37758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED119F6EB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 21:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB54189409A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3311FC7E6;
	Wed, 18 Dec 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R7NGvB9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F61FC7D5;
	Wed, 18 Dec 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552340; cv=none; b=mRXgMpKaXE/S2y5YydgTitzlKCq4j/sfNi8YObUMHeKX95u5A8dyKHLFSmbrFlRkRMBhJdHqVl1pyEAWBCCIOTfvU9R4mOI0Is4R5HlVTk43JmB4jiSygczHIccit54/lF0IC0FXOH6B3iEW3aYX9LhRoAEDfl6PUhLvFin3STU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552340; c=relaxed/simple;
	bh=jwr7VoI8xrDln1LW7FhiygWtBOHRdqVr/6fBs6mNLXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM/nDFTEN713U6syflnTzvHMzPGf+5g/6ohKOlBsUYCEFoSvQNktqMZxRdT9Tw4Q+ytbIkqp66wmnqPBz4FWe6FEVybQZVUBnAfciTtOU9I53tecpHZm1t9Bab4TfCjMG5FOwNQR5dozWubLbOKUL5wfVGpX6YWg+G0JwCPy11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R7NGvB9n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EbdwqBnCPnMA30/eAen6jZBripOiH8JSBeZk3CDGHT0=; b=R7NGvB9nGB2rbrdZXVCuILMXRe
	6fmvKr1WgwvzkZhMhJW1PJzMTyEuJsnWTFwEK82TXW4t5hUGJW7Nexip8W/K1+F1Q12BIglQCnyLF
	SDx+wVu5qUHUgTrgTQ3/tpdPfrIJwQfnAs6JA8eaPfbn+wXalYMY7TLJYsX/0+C6Xc9wMc1dear2s
	7qLxZ9KeymLgW3g3D3K53JGnUkcByEVsfIwGZI/BKzd72GsLBSC+/mVU3RFnOp7NYUUaJqqnJ+4Cr
	Ut9cfQZtp12r2GmgXhlExf2I0wmGOetu+44l4rJptA1C0p/kKg0nEKarItbjCDFvxbUpLQexaLluF
	il4EFXSg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tO0IT-00000000ZPU-10Y0;
	Wed, 18 Dec 2024 20:05:29 +0000
Date: Wed, 18 Dec 2024 20:05:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH 0/5] fs/buffer: strack reduction on async read
Message-ID: <Z2MrCey3RIBJz9_E@casper.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218022626.3668119-1-mcgrof@kernel.org>

On Tue, Dec 17, 2024 at 06:26:21PM -0800, Luis Chamberlain wrote:
> This splits up a minor enhancement from the bs > ps device support
> series into its own series for better review / focus / testing.
> This series just addresses the reducing the array size used and cleaning
> up the async read to be easier to read and maintain.

How about this approach instead -- get rid of the batch entirely?

diff --git a/fs/buffer.c b/fs/buffer.c
index cc8452f60251..f50ebbc1f518 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2361,9 +2361,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head;
 	size_t blocksize;
-	int nr, i;
+	int i, submitted = 0;
 	int fully_mapped = 1;
 	bool page_error = false;
 	loff_t limit = i_size_read(inode);
@@ -2380,7 +2380,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	iblock = div_u64(folio_pos(folio), blocksize);
 	lblock = div_u64(limit + blocksize - 1, blocksize);
 	bh = head;
-	nr = 0;
 	i = 0;
 
 	do {
@@ -2411,40 +2410,30 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 			if (buffer_uptodate(bh))
 				continue;
 		}
-		arr[nr++] = bh;
+
+		lock_buffer(bh);
+		if (buffer_uptodate(bh)) {
+			unlock_buffer(bh);
+			continue;
+		}
+
+		mark_buffer_async_read(bh);
+		submit_bh(REQ_OP_READ, bh);
+		submitted++;
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
 	if (fully_mapped)
 		folio_set_mappedtodisk(folio);
 
-	if (!nr) {
-		/*
-		 * All buffers are uptodate or get_block() returned an
-		 * error when trying to map them - we can finish the read.
-		 */
-		folio_end_read(folio, !page_error);
-		return 0;
-	}
-
-	/* Stage two: lock the buffers */
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
-		lock_buffer(bh);
-		mark_buffer_async_read(bh);
-	}
-
 	/*
-	 * Stage 3: start the IO.  Check for uptodateness
-	 * inside the buffer lock in case another process reading
-	 * the underlying blockdev brought it uptodate (the sct fix).
+	 * All buffers are uptodate or get_block() returned an error
+	 * when trying to map them - we must finish the read because
+	 * end_buffer_async_read() will never be called on any buffer
+	 * in this folio.
 	 */
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
-		if (buffer_uptodate(bh))
-			end_buffer_async_read(bh, 1);
-		else
-			submit_bh(REQ_OP_READ, bh);
-	}
+	if (!submitted)
+		folio_end_read(folio, !page_error);
+
 	return 0;
 }
 EXPORT_SYMBOL(block_read_full_folio);

