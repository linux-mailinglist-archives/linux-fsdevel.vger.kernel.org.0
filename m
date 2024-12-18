Return-Path: <linux-fsdevel+bounces-37690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F699F5CD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CD17A1BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E750139D1E;
	Wed, 18 Dec 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BkxYihM/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D93597B;
	Wed, 18 Dec 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488792; cv=none; b=s4eixCHwqUf207X8NjHveEvrb+nDUWB3S3u9k5YjDi5EjBwIhLcoBY8NpYwrNgcguA6hAqIOlVv/dIx4lrJMiWqEOuMueSStBsoeRsNPbAXaMMqruW4X3A3EAgcCWIkHS64NaAsnGFmF5FDDrJws1A1d0QaPFFvLEkg59Xvrxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488792; c=relaxed/simple;
	bh=CDDlCAKlASesiZGLekB4AsPrmJInuCb09o/+qxzGaxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYTfYgFEJofYZnTQhRWE3ZSKRH3lvEzLpBF5Q8Djm9b3UAKoztDcaBxB2ehYgQWk/hyGe5QPElX8ct7iya9xzhE43IprKLeawE+fCyaHMjHQa5XnLMKVmgQxvIiIBY3HB/Uu5ItWOI1Bh3jOGEKANuqILOVD/nQV83M5Ftu2tY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BkxYihM/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PAjepITga0a8Mt36xpxUX/NyoUbIA2AsDDdcgVOuJ40=; b=BkxYihM/ixv1x+y1GBn61vuqpI
	9uMGmUbRsMUgI7XBDYzqLUWkOar5BL6dzU9F1tUO4CIA4n0+LWX9pCweVDBnSQEWxMvpWm1n6JBKz
	/Dsn1uG4vzykfhqR7SvsS+CDSJHDeZ+bBrn3s4478DOW2HSvucEKQ5V8SD0zfoIKS0fwbT9gKHRj5
	pLcksMtPjjUZFjz+Q9yHaEizn2AXP9Riv8BG6ZdIhs0Y3hhxRkhmGoPiQMmsLe+a7mNR9wk1km02m
	Itv1KGFNuxgryqijDbmFRyzjE6ia4ohMLRGuTSuLPwnpI0nR6n1/HkGfLKzBMvShiyHd2Jsw3hKxv
	phXnpcCg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjlc-0000000FOFS-0xNt;
	Wed, 18 Dec 2024 02:26:28 +0000
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
Subject: [PATCH 1/5] fs/buffer: move async batch read code into a helper
Date: Tue, 17 Dec 2024 18:26:22 -0800
Message-ID: <20241218022626.3668119-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218022626.3668119-1-mcgrof@kernel.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Move the code from block_read_full_folio() which does a batch of async
reads into a helper.

No functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 79 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index cc8452f60251..7c6aac0742a6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2350,6 +2350,53 @@ bool block_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 }
 EXPORT_SYMBOL(block_is_partially_uptodate);
 
+/*
+ * Stage one is to collect an array of buffer heads which we need a read for,
+ * you can then use this afterwards. On that effort you should also check
+ * to see if you really need a read, and if we are already fully mapped.
+ */
+static void bh_read_batch_async(struct folio *folio,
+				int nr, struct buffer_head *arr[],
+				bool fully_mapped, bool no_reads,
+				bool any_get_block_error)
+{
+	int i;
+	struct buffer_head *bh;
+
+	if (fully_mapped)
+		folio_set_mappedtodisk(folio);
+
+	if (no_reads) {
+		/*
+		 * All buffers are uptodate or get_block() returned an
+		 * error when trying to map them *all* buffers we can
+		 * finish the read.
+		 */
+		folio_end_read(folio, !any_get_block_error);
+		return;
+	}
+
+	/* Stage two: lock the buffers */
+	for (i = 0; i < nr; i++) {
+		bh = arr[i];
+		lock_buffer(bh);
+		mark_buffer_async_read(bh);
+	}
+
+	/*
+	 * Stage three: start the IO.  Check for uptodateness
+	 * inside the buffer lock in case another process reading
+	 * the underlying blockdev brought it uptodate (the sct fix).
+	 */
+	for (i = 0; i < nr; i++) {
+		bh = arr[i];
+		if (buffer_uptodate(bh))
+			end_buffer_async_read(bh, 1);
+		else
+			submit_bh(REQ_OP_READ, bh);
+	}
+}
+
 /*
  * Generic "read_folio" function for block devices that have the normal
  * get_block functionality. This is most of the block device filesystems.
@@ -2383,6 +2430,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	nr = 0;
 	i = 0;
 
+	/* Stage one - collect buffer heads we need issue a read for */
 	do {
 		if (buffer_uptodate(bh))
 			continue;
@@ -2414,37 +2462,8 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 		arr[nr++] = bh;
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
-	if (fully_mapped)
-		folio_set_mappedtodisk(folio);
-
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
+	bh_read_batch_async(folio, nr, arr, fully_mapped, nr == 0, page_error);
 
-	/*
-	 * Stage 3: start the IO.  Check for uptodateness
-	 * inside the buffer lock in case another process reading
-	 * the underlying blockdev brought it uptodate (the sct fix).
-	 */
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
-		if (buffer_uptodate(bh))
-			end_buffer_async_read(bh, 1);
-		else
-			submit_bh(REQ_OP_READ, bh);
-	}
 	return 0;
 }
 EXPORT_SYMBOL(block_read_full_folio);
-- 
2.43.0


