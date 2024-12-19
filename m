Return-Path: <linux-fsdevel+bounces-37775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49539F7380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 04:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D17188EC82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 03:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35514A60F;
	Thu, 19 Dec 2024 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfP6ELbn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2E54727;
	Thu, 19 Dec 2024 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734580304; cv=none; b=K93EKCn5hD4Y5CFAD5Th1FEzUpvHFo9myFfYzjeRyrAMFog2dH+cyFxN3n/pA614knSQ8IDCo+d69bAC4ya8fcFbFeNCWtLB/IECWKLG8VgZZKfDlXNePL/vbEpI8ncH8I4vHCPzTchV3+zKeQc+nyolFSc8tlG4lQIO0UT+aig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734580304; c=relaxed/simple;
	bh=FuLoU7U0xMRNGmCKElRECU7Kfai8vIdgxthTaTR16+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opaqBXsCfChSVxM4b4bBhWuDTHjMX9w2tAG6GNRmRMn0EzXK6zQJY4uIagpgO393U4u8O6+lM/k4SQfPAUKlmq1k7L8qF4UNP2jy348SiYOOOi4McdHQxfAapOX8SF6MtdDaCe/IScpf07MWGAdvm7lH3xLx51BxVAyZGoN9W6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfP6ELbn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aSFlG7F9RzIzrW9Hgf/vG0f//Q9KVoULX33zB6BeU64=; b=LfP6ELbnHPNdNQWgkQVyW+k95b
	n+Al8AAcP6xhm5f/VqJq8bnnGo8i+kc+QAXLppn7Q3vLY9QDt1vFe8eFksJyJ4iy/S1SSmhIYhSzJ
	6zQElKG2GQ6gkzOKlzY/d+O5h/7Rg55NckHN67uxrWpGg35nJl3Bg3tLmMTVTzFBkITiSnDrIbmYY
	UDsOp7RB5PvXuA8ir72a5yOOt+kjzYUr/cNpOHx72BneZAcCd9gDIAKb9fMWVr3Tbdn43iURjZZX7
	ovE+rajnMBeTuXTBWYLWiKxHW0I0QHJMWbnytmM5J2sfgRlmPYz8tkq4weeMcYgb5S4I8DJAyxxGL
	PMH/XEMA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tO7ZW-00000001VPq-3dSV;
	Thu, 19 Dec 2024 03:51:34 +0000
Date: Thu, 19 Dec 2024 03:51:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH 0/5] fs/buffer: strack reduction on async read
Message-ID: <Z2OYRkpRcUFIOFog@casper.infradead.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
 <Z2MrCey3RIBJz9_E@casper.infradead.org>
 <Z2OEmALBGB8ARLlc@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2OEmALBGB8ARLlc@bombadil.infradead.org>

On Wed, Dec 18, 2024 at 06:27:36PM -0800, Luis Chamberlain wrote:
> On Wed, Dec 18, 2024 at 08:05:29PM +0000, Matthew Wilcox wrote:
> > On Tue, Dec 17, 2024 at 06:26:21PM -0800, Luis Chamberlain wrote:
> > > This splits up a minor enhancement from the bs > ps device support
> > > series into its own series for better review / focus / testing.
> > > This series just addresses the reducing the array size used and cleaning
> > > up the async read to be easier to read and maintain.
> > 
> > How about this approach instead -- get rid of the batch entirely?
> 
> Less is more! I wish it worked, but we end up with a null pointer on
> ext4/032 (and indeed this is the test that helped me find most bugs in
> what I was working on):

Yeah, I did no testing; just wanted to give people a different approach
to consider.

> [  106.034851] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  106.046300] RIP: 0010:end_buffer_async_read_io+0x11/0x90
> [  106.047819] Code: f2 ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 48 8b 47 10 48 89 fb 48 8b 40 18 <48> 8b 00 f6 40 0d 40 74 0d 0f b7 00 66 25 00 f0 66 3d 00 80 74 09

That decodes as:

   5:	53                   	push   %rbx
   6:	48 8b 47 10          	mov    0x10(%rdi),%rax
   a:	48 89 fb             	mov    %rdi,%rbx
   d:	48 8b 40 18          	mov    0x18(%rax),%rax
  11:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
  14:	f6 40 0d 40          	testb  $0x40,0xd(%rax)

6: bh->b_folio
d: b_folio->mapping
11: mapping->host

So folio->mapping is NULL.

Ah, I see the problem.  end_buffer_async_read() uses the buffer_async_read
test to decide if all buffers on the page are uptodate or not.  So both
having no batch (ie this patch) and having a batch which is smaller than
the number of buffers in the folio can lead to folio_end_read() being
called prematurely (ie we'll unlock the folio before finishing reading
every buffer in the folio).

Once the folio is unlocked, it can be truncated.  That's a second-order
problem, but it's the one your test happened to hit.


This should fix the problem; we always have at least one BH held in
the submission path with the async_read flag set, so
end_buffer_async_read() will not end it prematurely.

By the way, do you have CONFIG_VM_DEBUG enabled in your testing?

        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
in folio_end_read() should have tripped before hitting the race with
truncate.

diff --git a/fs/buffer.c b/fs/buffer.c
index cc8452f60251..fd2633e4a5d2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2361,9 +2361,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head, *prev = NULL;
 	size_t blocksize;
-	int nr, i;
+	int i;
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
@@ -2411,40 +2410,33 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
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
+		if (prev)
+			submit_bh(REQ_OP_READ, prev);
+		prev = bh;
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
+	if (prev)
+		submit_bh(REQ_OP_READ, prev);
+	else
+		folio_end_read(folio, !page_error);
+
 	return 0;
 }
 EXPORT_SYMBOL(block_read_full_folio);

