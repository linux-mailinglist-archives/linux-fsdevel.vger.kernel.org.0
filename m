Return-Path: <linux-fsdevel+bounces-57465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79173B21F61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427C82A54FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A12DF3F8;
	Tue, 12 Aug 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LIB6XCvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D1029994B;
	Tue, 12 Aug 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983416; cv=none; b=dZdzZAdUkvQhM4t/Ekw5gNoO2MT5vPq+l0JHtp7ms3EQGo0CQ53MW1e5SdZZ5aF5oUWB69DvvEZXDgIlQbcc3YoL760LgcLQ6GVqjgkMCmTWcXhwUi7Pad91yj/s0PksGUHhlYGWb0HPMXQtlPIHv8zmBUq+U1lJw4KScyME26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983416; c=relaxed/simple;
	bh=nBGWP0q0mITF3G1m5AiD+VlIrHp9Mf0Y+NqFxf5vcwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDeg1WPRq6kpmIw44N/Ljeo7niVtpnFGv6ByggNDkQ7jCgy9inGEH/TCUqiZ62NIbMRBFwc9ZhA1P4yMaoJ0/YZPcjyGODKcMx8kPp9DD6pnqUZoXuRpiSigCo2HGw+YX+BXVWeIiD7GTuZ91dGn2yJOgcp5cX2lKao3rFRm0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LIB6XCvE; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ak
	a2tvGvdvr+T6MVzxzapn/JbQtAeasW67ww2wlOOMM=; b=LIB6XCvE+rue3Zqmhd
	HLSen+jg4n/Gj4dfQKF+GL493C3pwhNKeIjzxEW8mJaPkpK3wdKBJWIXAERnSZ+u
	JvPu/I0k79YoL8rDjEgBLMPAV8HjH3oUJO8Zzt0z9VNxGCY7IFcp0MWKmHL+Fjc2
	x211Tm5yM4WSk0zny5MKNZiTU=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3RSPN65pon26ABQ--.34118S3;
	Tue, 12 Aug 2025 15:22:54 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH 2/3] mpage: clean up do_mpage_readpage()
Date: Tue, 12 Aug 2025 15:22:24 +0800
Message-ID: <20250812072225.181798-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812072225.181798-1-chizhiling@163.com>
References: <20250812072225.181798-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3RSPN65pon26ABQ--.34118S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry3try5ZrWxtFykZF45Awb_yoW5CFy3p3
	9IyFnxurn7G34Sva47Jrn8Zr1SgwnxGFWUZFyfAa4fW34Utw1fu3Z7X3Z8ZFWUtF9rZFn8
	XF4Fqry8JF1DWrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCeHkUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBawKnnWia6QNKpwABsn

From: Chi Zhiling <chizhiling@kylinos.cn>

Replace two loop iterations with direct calculations.
The variable nblocks now represents the number of avalid blocks we can
obtain from map_bh. no functional change.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/mpage.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index b6510b8dfa2b..a81a71de8f59 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -158,7 +158,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	struct buffer_head *map_bh = &args->map_bh;
 	sector_t block_in_file;
 	sector_t last_block;
-	sector_t last_block_in_file;
 	sector_t first_block;
 	unsigned page_block;
 	unsigned first_hole = blocks_per_folio;
@@ -180,9 +179,8 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 	block_in_file = folio_pos(folio) >> blkbits;
 	last_block = block_in_file + ((args->nr_pages * PAGE_SIZE) >> blkbits);
-	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
-	if (last_block > last_block_in_file)
-		last_block = last_block_in_file;
+	last_block = min_t(sector_t, last_block,
+			   (i_size_read(inode) + blocksize - 1) >> blkbits);
 	page_block = 0;
 
 	/*
@@ -193,19 +191,15 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			block_in_file > args->first_logical_block &&
 			block_in_file < (args->first_logical_block + nblocks)) {
 		unsigned map_offset = block_in_file - args->first_logical_block;
-		unsigned last = nblocks - map_offset;
 
 		first_block = map_bh->b_blocknr + map_offset;
-		for (relative_block = 0; ; relative_block++) {
-			if (relative_block == last) {
-				clear_buffer_mapped(map_bh);
-				break;
-			}
-			if (page_block == blocks_per_folio)
-				break;
-			page_block++;
-			block_in_file++;
-		}
+		nblocks -= map_offset;
+		if (nblocks > blocks_per_folio - page_block)
+			nblocks = blocks_per_folio - page_block;
+		else
+			clear_buffer_mapped(map_bh);
+		page_block += nblocks;
+		block_in_file += nblocks;
 		bdev = map_bh->b_bdev;
 	}
 
@@ -243,7 +237,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			map_buffer_to_folio(folio, map_bh, page_block);
 			goto confused;
 		}
-	
+
 		if (first_hole != blocks_per_folio)
 			goto confused;		/* hole -> non-hole */
 
@@ -252,16 +246,14 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			first_block = map_bh->b_blocknr;
 		else if (first_block + page_block != map_bh->b_blocknr)
 			goto confused;
+
 		nblocks = map_bh->b_size >> blkbits;
-		for (relative_block = 0; ; relative_block++) {
-			if (relative_block == nblocks) {
-				clear_buffer_mapped(map_bh);
-				break;
-			} else if (page_block == blocks_per_folio)
-				break;
-			page_block++;
-			block_in_file++;
-		}
+		if (nblocks > blocks_per_folio - page_block)
+			nblocks = blocks_per_folio - page_block;
+		else
+			clear_buffer_mapped(map_bh);
+		page_block += nblocks;
+		block_in_file += nblocks;
 		bdev = map_bh->b_bdev;
 	}
 
-- 
2.43.0


