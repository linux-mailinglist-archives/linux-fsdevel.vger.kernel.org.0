Return-Path: <linux-fsdevel+bounces-37407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ACC9F1C46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B508516AB31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2136D83CA0;
	Sat, 14 Dec 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DUwsEwV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86BD1B59A;
	Sat, 14 Dec 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145860; cv=none; b=V1FTcWhlPJZqYhKemOH4OG+wvscCIZS8dG+c8HFi/BrL15THJkJyHnw1yuUYZJBEgfUT+gZItE1bdxsnO1w2jqkY7sPLnkEq90d4pLlEnsAKKHJhJYMQnPBLnKGIOuvZocZ6Swl4xPtndovepsvSLFHGkDYGrZvVIMet4IdXb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145860; c=relaxed/simple;
	bh=4GsMPiZMYzBUymOr893Sq86sStZdqDjFqsXKQduu+2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR/iSmGMmYkQk/aT8kXAxW8UnCEPlAoaJkQWG2PDbNGykLJjezcPMv6tk4eQR13ucS0tgui8IjL3tI6WP13LE8al/HJEG0O10TGMDIezKKJL3FGgbcMLvUgYolFypjHOL7ghsv/1MdT98s6PaoR0DcQG9bKOrfkNVwYtecHCHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DUwsEwV0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7VkY/OzBoZXEa2cuwiycPcKImztiWgLu3Zlcz14G1p4=; b=DUwsEwV079VBpxwAvrs6U6I8Cu
	+yB5Af7X5dyJDHK+0BxH0M7EaxriNLYaJvIdNxNvPOrYxYSQH/jU6jB8GynWgvVdzNF+teFgMqOkz
	mjPRr02cXWTdhinHpXpBhT4dzbeSTZFB7pJuqYAnEpNKz8fKfY9zR9r1IIknCnCbVnL2MuibGND6h
	Zeje92OBV13LXKmVEQ6HFBf9qbrjM5QFgsqwfDPfPRBUdVSwCTMN+0mmrrEp5a7iPTJDQkb1vIBl1
	IWJrME7NwGx/w9FAz1UoW5zrg8+kESNsILRCVqNAQZjRAt/wB6HzCQ9sloAPF0+rCThoEaLmed8nf
	eYOcYkpA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYN-00000005c3d-3dl7;
	Sat, 14 Dec 2024 03:10:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC v2 04/11] fs/buffer: reduce stack usage on bh_read_iter()
Date: Fri, 13 Dec 2024 19:10:42 -0800
Message-ID: <20241214031050.1337920-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214031050.1337920-1-mcgrof@kernel.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
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

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f8e6a5454dbb..b4994c48e6ee 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2410,7 +2410,10 @@ static void bh_read_batch_async(struct folio *folio,
          (__tmp);					\
          (__tmp) = bh_next(__tmp, __head))
 
+#define MAX_BUF_CHUNK 8
+
 struct bh_iter {
+	int chunk_number;
 	sector_t iblock;
 	get_block_t *get_block;
 	bool any_get_block_error;
@@ -2419,7 +2422,7 @@ struct bh_iter {
 };
 
 /*
- * Reads up to MAX_BUF_PER_PAGE buffer heads at a time on a folio on the given
+ * Reads up to MAX_BUF_CHUNK buffer heads at a time on a folio on the given
  * block range iblock to lblock and helps update the number of buffer-heads
  * which were not uptodate or unmapped for which we issued an async read for
  * on iter->bh_folio_reads for the full folio. Returns the last buffer-head we
@@ -2431,16 +2434,18 @@ static struct buffer_head *bh_read_iter(struct folio *folio,
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
 
 	/* collect buffers not uptodate and not mapped yet */
 	for_each_bh_pivot(bh, last, head) {
-		BUG_ON(nr >= MAX_BUF_PER_PAGE);
+		if (nr >= MAX_BUF_CHUNK)
+			break;
 
 		if (buffer_uptodate(bh))
 			continue;
@@ -2457,7 +2462,8 @@ static struct buffer_head *bh_read_iter(struct folio *folio,
 					iter->any_get_block_error = true;
 			}
 			if (!buffer_mapped(bh)) {
-				folio_zero_range(folio, i * blocksize,
+				folio_zero_range(folio,
+						(i + chunk_idx) * blocksize,
 						blocksize);
 				if (!err)
 					set_buffer_uptodate(bh);
@@ -2476,8 +2482,7 @@ static struct buffer_head *bh_read_iter(struct folio *folio,
 	}
 
 	iter->bh_folio_reads += nr;
-
-	WARN_ON_ONCE(!bh_is_last(last, head));
+	iter->chunk_number++;
 
 	if (bh_is_last(last, head)) {
 		if (!iter->bh_folio_reads)
@@ -2507,6 +2512,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	struct buffer_head *bh, *head;
 	struct bh_iter iter = {
 		.get_block = get_block,
+		.chunk_number = 0,
 		.unmapped = 0,
 		.any_get_block_error = false,
 		.bh_folio_reads = 0,
-- 
2.43.0


