Return-Path: <linux-fsdevel+bounces-23968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B49370A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BA71F22762
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE959146019;
	Thu, 18 Jul 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INY0UkJX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470F12C7F9;
	Thu, 18 Jul 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341813; cv=none; b=eqU1/UmwpeUPnuvTNwR9bm4yV140TfTHOGqYIIKGlDKomLyzk90xzGyRXqMyJYmr7mrBowtFTDuYaURblGd348Cn0Sjd0a4fgGF7z2Xtwdn2vdNXe63c8p4ZyVLiLTmizJAy3HGSZ1TrH3pTnaBnvcIl0rtK1rwSVZ01rTQzfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341813; c=relaxed/simple;
	bh=SCb1EseGsn+5pBi2dIrMkxVwkS+8MSH1I9q1XdPH1UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUSqmSGEQh78GwY1cLjZCdRkXdzeGgnoCljXzBtVxK/T1w6baL9KlMdXHuA8GdF4d2nW/XqQ2vdixEA4DKZA647XCOFp+AqmkP4ry4GvS5ZQUHJEh9UL1QVUIC8o3lex1CCbhPW5vf8BKeZVT4s+ovj+rv/YmCU7wBF/aI2ZmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=INY0UkJX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NKLp7cFT6stArnXInmDhzYdpMNjqgCzvn8nHi4aXK7E=; b=INY0UkJXSStgnuwdwD/l53f+2e
	Gk75AwO5jeXk1mNbepCXj3ET8s3IQgAUYdTIplQjbr4VLwnTIv43LPJFiYto0LQILxY+v5hss4iXp
	2pYt6urNDgN9BRtkRE8WaJcFjqkL7StVIYlUMnDhCtd8nVM3NiCCQME26x0UwQd2PwP1mq4SatZLE
	9RQPtzODUQvT5u1O+oZ2t9fr3+JUkNga3t0D9xCaTVAIA3gjyzVBJappPOt2ClidLsDsZ05Mu01Kd
	xwZ5+EUEu5SYP+IHXH0/ol9eI3B/uUZ212k8fMzsxioRSYZb5ZonvkTol7KT5/iJaw2qxzx6zppC5
	ZZYykMRg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUZdX-00000002O0S-0hRq;
	Thu, 18 Jul 2024 22:30:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 4/4] ext4: Tidy the BH loop in mext_page_mkuptodate()
Date: Thu, 18 Jul 2024 23:30:02 +0100
Message-ID: <20240718223005.568869-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718223005.568869-1-willy@infradead.org>
References: <20240718223005.568869-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This for loop is somewhat hard to read; turn it into a normal BH
do-while loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 660bf34a5c4b..516897b0218e 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -187,9 +187,11 @@ static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
 	if (!head)
 		head = create_empty_buffers(folio, blocksize, 0);
 
-	block = (sector_t)folio->index << (PAGE_SHIFT - inode->i_blkbits);
-	for (bh = head, block_start = 0; bh != head || !block_start;
-	     block++, block_start = block_end, bh = bh->b_this_page) {
+	block = folio_pos(folio) >> inode->i_blkbits;
+	block_end = 0;
+	bh = head;
+	do {
+		block_start = block_end;
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
 			if (!buffer_uptodate(bh))
@@ -215,7 +217,8 @@ static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
 		}
 		ext4_read_bh_nowait(bh, 0, NULL);
 		nr++;
-	}
+	} while (block++, (bh = bh->b_this_page) != head);
+
 	/* No io required */
 	if (!nr)
 		goto out;
-- 
2.43.0


