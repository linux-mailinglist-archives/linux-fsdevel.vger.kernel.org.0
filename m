Return-Path: <linux-fsdevel+bounces-37693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5389F5CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDAF1892AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048E13F42F;
	Wed, 18 Dec 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rOCE0qvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748785FEED;
	Wed, 18 Dec 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488792; cv=none; b=hXVoV4rPDtmUip9wiTv8X5tjUvBuZQMNYx2Bmf1UT04XDYj4jXMXI247yLRcvRlS0dMRtdnVK2/sMyP7H9lla8S3s0bD5EvlqLR5mexj0GonnpVilpSEDzjxOA3CBdAghmIg98DvXWxXOR6X7i34KhpnG5tF1RuJpHlxdvBMkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488792; c=relaxed/simple;
	bh=zoKQiCdk3zMvemNYIWb1hXPGTcHsahTKaEEV/z8Mr5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjAfTvim4eSDyuTTlhHzPVjfn47Rzn/8OKJR5v4GTHAQON+dQHAQKiXtZhPTtjA2tUfPtLPqVYfsaQA1cICXb/T1MX1DG3ePtZ/U4d3VKvAXIgVgmmkmhekayDK+owHoq5lnDwKZiaAeXBHJO9il5/spHJUthRSAl/IivvhFwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rOCE0qvP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZbUYX9Sq5KIho4Fukut+jcN4YUtrDSxc8GT+CZTyNJI=; b=rOCE0qvP1bit6BhC2nOW+ZmD1C
	MjnSDQBMGg0LebsCOfpJZS5VU+y1MF9ftXASeJHmNQu668uZk62viyqP2nWwMFil83pO0XL6VaLcc
	7ebXitKACjEMvt3i+W7gaNBm8ysthbep6l4kO2V96ZIJETU/OEl0ofk9QvN1ogbhPTg9gLYq3LVfy
	i3b8vLmSXM3vSiaWT0vzDdfIPVuI6xps08Qj8YCSppp+iiqyXLC7IjPxC+NEq3/4A7ICfNRpO6GM4
	QYbvzZjEM7IFZaFXNlhwvIVOtZZTL9Kmwf2IQlX1GUowQNUkXADtFpVK9hUCgEOLpdmccNaGqUWra
	0NvGIbdA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjlc-0000000FOFb-1UCn;
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
Subject: [PATCH 5/5] fs/buffer: reduce stack usage on bh_read_iter()
Date: Tue, 17 Dec 2024 18:26:26 -0800
Message-ID: <20241218022626.3668119-6-mcgrof@kernel.org>
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

Now that we can read asynchronously buffer heads from a folio in
chunks,  we can chop up bh_read_iter() with a smaller array size.
Use an array of 8 to avoid stack growth warnings on systems with
huge base page sizes.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b8ba72f2f211..bfa9c09b8597 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2415,7 +2415,10 @@ static void bh_read_batch_async(struct folio *folio,
          (__tmp);					\
          (__tmp) = bh_next(__tmp, __head))
 
+#define MAX_BUF_CHUNK 8
+
 struct bh_iter {
+	int chunk_number;
 	sector_t iblock;
 	get_block_t *get_block;
 	bool any_get_block_error;
@@ -2424,7 +2427,7 @@ struct bh_iter {
 };
 
 /*
- * Reads up to MAX_BUF_PER_PAGE buffer heads at a time on a folio on the given
+ * Reads up to MAX_BUF_CHUNK buffer heads at a time on a folio on the given
  * block range iblock to lblock and helps update the number of buffer-heads
  * which were not uptodate or unmapped for which we issued an async read for
  * on iter->bh_folio_reads for the full folio. Returns the last buffer-head we
@@ -2436,10 +2439,11 @@ static struct buffer_head *bh_read_iter(struct folio *folio,
 					struct inode *inode,
 					struct bh_iter *iter, sector_t lblock)
 {
-	struct buffer_head *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *arr[MAX_BUF_CHUNK];
 	struct buffer_head *bh = pivot, *last;
 	int nr = 0, i = 0;
 	size_t blocksize = head->b_size;
+	int chunk_idx = MAX_BUF_CHUNK * iter->chunk_number;
 	bool no_reads = false;
 	bool fully_mapped = false;
 
@@ -2447,7 +2451,8 @@ static struct buffer_head *bh_read_iter(struct folio *folio,
 
 	/* collect buffers not uptodate and not mapped yet */
 	for_each_bh_pivot(bh, last, head) {
-		BUG_ON(nr >= MAX_BUF_PER_PAGE);
+		if (nr >= MAX_BUF_CHUNK)
+			break;
 
 		if (buffer_uptodate(bh)) {
 			iter->iblock++;
@@ -2487,8 +2492,7 @@ static struct buffer_head *bh_read_iter(struct folio *folio,
 	}
 
 	iter->bh_folio_reads += nr;
-
-	WARN_ON_ONCE(!bh_is_last(last, head));
+	iter->chunk_number++;
 
 	if (bh_is_last(last, head)) {
 		if (!iter->bh_folio_reads)
@@ -2518,6 +2522,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	struct buffer_head *bh, *head;
 	struct bh_iter iter = {
 		.get_block = get_block,
+		.chunk_number = 0,
 		.unmapped = 0,
 		.any_get_block_error = false,
 		.bh_folio_reads = 0,
-- 
2.43.0


