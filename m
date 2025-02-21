Return-Path: <linux-fsdevel+bounces-42314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56731A402D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0101891460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07967253F2D;
	Fri, 21 Feb 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T3tx0wBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA704204698;
	Fri, 21 Feb 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177511; cv=none; b=KsO4eXQpxFBr2Hj1v3+9q/zeNX2kZIPg8LQhtVIiypXZikkpG3KYXX9oPHuNGXdJbWPysOdAZtHtlTIKLo6LMnuAO8/CmzNPM0q+P2FJwdCYFsXN8Ks5ZELNVEnQYmF89xCEz1rBIHY6szad/k/DV9eCgxorOKgrCqpMDXqnJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177511; c=relaxed/simple;
	bh=t6TYAnZVnQOFpQ10O87bLj7qiZUW1QA9U/iuFzK5rIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPCUUTg1wX3E0JsZyWbt80/v0RTPn/KBZTgEeP2SsTKZwpzRtboRWsn8BFFydfwGtj1zrZ5fFNQlvpDi0ZUGi85JR5Z+vSzUsn75MyhSVZrPu5hKaJytjtUPSxLnum14NUHne60/DxA1EkJliyo3gwlvbyUhofl8gnUUuGIu6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T3tx0wBJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fpTh1KbPClQQAibvuLbxjJCGXlYIrXiRedMs+nLQf5A=; b=T3tx0wBJhUa4LW3rSL9hlLLjCm
	/nfyI88jHLYZ/es2eDKg6NggJ3wwhw7XRGc9qVH/+wHe3uGIMtnKEORNzbYCn/KloX86/WmPANPs7
	7CeCqTCrLZgF0FO242DBCTVmLUCHi3DOrJhys6RXzmVCZmf+rEuujTDpTM5m58KVPJnnpbo6LE/4a
	Qe3Y7/gGuc3cdgPUzM5kfvJjrBoYZp7pdh+sLmLUqr99v01fYrGwUDVyGYkDmPhIBjj0UVmnNqksP
	k0wOoQC3TfvK+cpGqKrB7zkGYtnNc3C6jcBC20z2UscC1nM0zc6MAjDRzH/oiBZ034AeNwaC5coGX
	CDikMjWw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbf7-000000073D2-3GTV;
	Fri, 21 Feb 2025 22:38:25 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	akpm@linux-foundation.org,
	hare@suse.de,
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
Subject: [PATCH v3 2/8] fs/buffer: remove batching from async read
Date: Fri, 21 Feb 2025 14:38:17 -0800
Message-ID: <20250221223823.1680616-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221223823.1680616-1-mcgrof@kernel.org>
References: <20250221223823.1680616-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Matthew Wilcox <willy@infradead.org>

block_read_full_folio() currently puts all !uptodate buffers into
an array allocated on the stack, then iterates over it twice, first
locking the buffers and then submitting them for read.  We want to
remove this array because it occupies too much stack space on
configurations with a larger PAGE_SIZE (eg 512 bytes with 8 byte
pointers and a 64KiB PAGE_SIZE).

We cannot simply submit buffer heads as we find them as the completion
handler needs to be able to tell when all reads are finished, so it can
end the folio read.  So we keep one buffer in reserve (using the 'prev'
variable) until the end of the function.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
2.47.2


