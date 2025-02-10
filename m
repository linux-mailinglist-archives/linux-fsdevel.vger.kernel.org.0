Return-Path: <linux-fsdevel+bounces-41400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E049A2EE78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7739D3A96F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33F5231A3A;
	Mon, 10 Feb 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t5S7TjhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55353230D18;
	Mon, 10 Feb 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194498; cv=none; b=L1v7BlZPzPF91quDQ7OxBuOBBJXDnZZtWILMb4QM/1pD6KZAY0PYXx8goDdcRMFBm2JPwj2skAFcgw3Qo6L5Itcps1aoRsX6ATljQlxO1x8f78mKkF8nU00XiUa+Sa2kpqJl1x+bPak+SfV6ZEvCHuSHeUE1IF13SwQj7VUHE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194498; c=relaxed/simple;
	bh=UU7syauqzVZwhsnjUqsoUUOJI9XblAScW2ZLMVEjF/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKnLFjrmY/l4rcn7qnFsoei6seDN7M8irJpRnKx2nE7/k675FsJsfM+dJ3ifRSMoCT40pU9NyjdFoYDYB7mG70UYFvS0yFcDNvKNNvX/U9UZMpPrEqdeqxwOCdC68yxI3Q9wnufiW8rocWanSQSjPi5R/uiAJZYXdoKohUlqKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t5S7TjhD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9Am55nrwyi7Dlm+nrNHLjnahw8j8cNtEuVddBLL3rhI=; b=t5S7TjhDfbXNpdL2zMZGTdS8/N
	DH/5gjDU/uq1y4hZsJ1OsLRNSKJLVEpbzejezbXb5kCzYYym4SIG6r6GbLA842vf/yIBBVn55MAfT
	jkeQA73/n/fA2ESO8X1K4eYZtGF1ZVLyYtxld4HXIbbX4dGAOzU6pALjZT4ez2q8uPtrHkK0lg3Ty
	iXguy8zBt458BtRDqqgxBIPMKvbPEEQGTDI7tWASmUOE5tRYnmnwFVrPfLM5VZHB+QgAwgUqQ6U6d
	IG1ksVAVVo1rfbT7m5mmmC+bRxlTCQGZz8zQ/MqfF6LqM+2HBDmI8ogzGPLQ1uwVkI86wm6pVMW54
	Cxj6BTZg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw6-0000000FvaF-1e3m;
	Mon, 10 Feb 2025 13:34:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
Date: Mon, 10 Feb 2025 13:34:45 +0000
Message-ID: <20250210133448.3796209-8-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133448.3796209-1-willy@infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_end_log_write() has to handle bios which consist of both pages
which belong to folios and pages which were allocated from a mempool and
do not belong to a folio.  It would be cleaner to have separate endio
handlers which handle each type, but it's not clear to me whether that's
even possible.

This patch is slightly forward-looking in that page_folio() cannot
currently return NULL, but it will return NULL in the future for pages
which do not belong to a folio.

This was the last user of page_has_buffers(), so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/lops.c              | 28 ++++++++++++++--------------
 include/linux/buffer_head.h |  1 -
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 30597b0f7cc3..8b46bd01a448 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -157,7 +157,9 @@ u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int lblock)
 /**
  * gfs2_end_log_write_bh - end log write of pagecache data with buffers
  * @sdp: The superblock
- * @bvec: The bio_vec
+ * @folio: The folio
+ * @offset: The first byte within the folio that completed
+ * @size: The number of bytes that completed
  * @error: The i/o status
  *
  * This finds the relevant buffers and unlocks them and sets the
@@ -166,17 +168,13 @@ u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int lblock)
  * that is pinned in the pagecache.
  */
 
-static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp,
-				  struct bio_vec *bvec,
-				  blk_status_t error)
+static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp, struct folio *folio,
+		size_t offset, size_t size, blk_status_t error)
 {
 	struct buffer_head *bh, *next;
-	struct page *page = bvec->bv_page;
-	unsigned size;
 
-	bh = page_buffers(page);
-	size = bvec->bv_len;
-	while (bh_offset(bh) < bvec->bv_offset)
+	bh = folio_buffers(folio);
+	while (bh_offset(bh) < offset)
 		bh = bh->b_this_page;
 	do {
 		if (error)
@@ -186,7 +184,7 @@ static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp,
 		size -= bh->b_size;
 		brelse(bh);
 		bh = next;
-	} while(bh && size);
+	} while (bh && size);
 }
 
 /**
@@ -203,7 +201,6 @@ static void gfs2_end_log_write(struct bio *bio)
 {
 	struct gfs2_sbd *sdp = bio->bi_private;
 	struct bio_vec *bvec;
-	struct page *page;
 	struct bvec_iter_all iter_all;
 
 	if (bio->bi_status) {
@@ -217,9 +214,12 @@ static void gfs2_end_log_write(struct bio *bio)
 	}
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		page = bvec->bv_page;
-		if (page_has_buffers(page))
-			gfs2_end_log_write_bh(sdp, bvec, bio->bi_status);
+		struct page *page = bvec->bv_page;
+		struct folio *folio = page_folio(page);
+
+		if (folio && folio_buffers(folio))
+			gfs2_end_log_write_bh(sdp, folio, bvec->bv_offset,
+					bvec->bv_len, bio->bi_status);
 		else
 			mempool_free(page, gfs2_page_pool);
 	}
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 932139c5d46f..fab70b26e131 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -182,7 +182,6 @@ static inline unsigned long bh_offset(const struct buffer_head *bh)
 		BUG_ON(!PagePrivate(page));			\
 		((struct buffer_head *)page_private(page));	\
 	})
-#define page_has_buffers(page)	PagePrivate(page)
 #define folio_buffers(folio)		folio_get_private(folio)
 
 void buffer_check_dirty_writeback(struct folio *folio,
-- 
2.47.2


