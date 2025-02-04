Return-Path: <linux-fsdevel+bounces-40859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EBCA27F68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C55161A31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE1C2206B2;
	Tue,  4 Feb 2025 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bLk3usnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A921C9E1;
	Tue,  4 Feb 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710738; cv=none; b=LbbRq/W7s9h+2UrbEc2MlX6tc7M1mpD1vDPXHYBpugcAv94Lqb/hop8v/SclF0YxeXhK0yml2LDN5CT4L24bXIJSNlF7ePemroD/envKwrbl1KVZQnnuruZ/+o50oz3uvhsqJ08YqNJ0NarhShQHLhSmWOK/GmpWhoGX1iATkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710738; c=relaxed/simple;
	bh=dr8CNNrk7V5yLGgUuBtwQy4diHxtVvVQURzGb4Pcjss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2mpRzg7nkY9W+urgFfmycC68I9P5pqrlmYtKI7S5FdUgL2o82jrbu2CuyytJIwNicEZdVr46nuwoLJ5eDTsPx0CUimJOnZWrbRjYjSrLj2d/demKu1i5INM8lfl+y+5aYXfDA2vtDdwwrpp7IeD5i6e5SFj2atrOKJrCck2Lf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bLk3usnU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AJ1b0u4x2rstuiVDqeFM5lSxnt8lCHKW5w+bHMF0FyA=; b=bLk3usnU7zD694D9cQlqCOIrGl
	Zxo2SpJ8CmrEnmdcSP9tTWq9KazLoLEJXfKmVyoWXHcZIIzXjNuhivNzLCD1GkFL9/Kj3aqWK86pS
	EzI+jZTF6PaJ5TBjJC3z7QZZAz2ATQJKMVfE/PH34cMBCPJjo9fAfzGGhOS+pylbC0D2dzUf77w23
	FtQT5QLp0D9jcPgK6T8gfY7FY55KtdBlH01vUDo8v2ESxod5Zu+CxKgNXCTNQ820pC9tUpMAuZ/od
	qo3+wT5PtysGvfbIUhMxWAYLub35Ep2ZoLFFj5hMU+FkI2ef676zc86QDgnz2KnEuAZTgNELMIAL0
	nK7kF1sA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfS5T-00000001nhO-1EZy;
	Tue, 04 Feb 2025 23:12:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v2 2/8] fs/buffer: remove batching from async read
Date: Tue,  4 Feb 2025 15:12:03 -0800
Message-ID: <20250204231209.429356-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204231209.429356-1-mcgrof@kernel.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Matthew Wilcox <willy@infradead.org>

The current implementation of a folio async read in block_read_full_folio()
first batches all buffer-heads which need IOs issued for by putting them on an
array of max size MAX_BUF_PER_PAGE. After collection it locks the batched
buffer-heads and finally submits the pending reads. On systems with CPUs
where the system page size is quite larger like Hexagon with 256 KiB this
batching can lead stack growth warnings so we want to avoid that.

Note the use of folio_end_read() through block_read_full_folio(), its
used either when the folio is determined to be fully uptodate and no
pending read is needed, an IO error happened on get_block(), or an out of
bound read raced against batching collection to make our required reads
uptodate.

We can simplify this logic considerably and remove the stack growth
issues of MAX_BUF_PER_PAGE by just replacing the batched logic with
one which only issues IO for the previous buffer-head keeping in mind
we'll always have one buffer-head (the current one) on the folio with
an async flag, this will prevent any calls to folio_end_read().

So we accomplish two things with this:

 o Avoid large stacks arrays with MAX_BUF_PER_PAGE
 o Make the need for folio_end_read() explicit and easier to read

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 51 +++++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b99560e8a142..167fa3e33566 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2361,9 +2361,8 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head, *prev = NULL;
 	size_t blocksize;
-	int nr, i;
 	int fully_mapped = 1;
 	bool page_error = false;
 	loff_t limit = i_size_read(inode);
@@ -2380,7 +2379,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	iblock = div_u64(folio_pos(folio), blocksize);
 	lblock = div_u64(limit + blocksize - 1, blocksize);
 	bh = head;
-	nr = 0;
 
 	do {
 		if (buffer_uptodate(bh))
@@ -2410,40 +2408,33 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
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
 	} while (iblock++, (bh = bh->b_this_page) != head);
 
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
-- 
2.45.2


