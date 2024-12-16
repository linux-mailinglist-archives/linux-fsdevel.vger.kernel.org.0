Return-Path: <linux-fsdevel+bounces-37507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690509F35FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4E518849EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76501B4124;
	Mon, 16 Dec 2024 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UrW9/DRj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442ED136331;
	Mon, 16 Dec 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366428; cv=none; b=meNfbJE5RFUiuPnfxdfxzp25F3nOSXH/W3P987FuNA5WORKOxCqyUogfjMQWHqQ9FpRmq6+JiRoMaa9wr8dtcB/l3jKDL8VsUCRZlNRk9lae0J7ypYODD//GoEsiUpOV1XdeGJH+dguIbw0AE0jVsK5uDyEG9HR9OhfEaH7LoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366428; c=relaxed/simple;
	bh=+rDGsU6PpbuyrhNX8ezB5JqZ381HzuavhECPID8LAHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYzp3rTs1givabfU7zX6QqdtTXjxekMLUSvsXQuI7XaWozeunGqWSW5kVCwkQ6+xQBmQ/rFISCraWYru1G3NFYsUNChFbXfYbZOyuBOMOQNYJxK3/VVOWX3+gqjKy0SjFkyjMoz3LaQ8WaiMI9x2efo9X60DC6pj2VLqBHJhLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UrW9/DRj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LZ5OrPuIVHgO9uugI8412gKWwbcN2x5YFOCCPNSvsdU=; b=UrW9/DRjnQPLsYP/yd4yQlcHu0
	xPyRAYXC5eCr8izMxP6tUCqLNZBH++WOnbO/MOAg15K4p/sIFNHriClp6x9sMwL+qpM7lkAFEMZn0
	fHkwODU8cl8J78IByFhvU4KsBUUHYuxM1Jv6W99Osq3AlRUO0uQ1NuZNziW/Qz3PSjsusYfmiUeAz
	58s0w2Lf4IME7xurCx5dNnz247V24W5daWZwgp5wzyRrY1JwPZ1gJ10oTP/WQbmXRYektlslayu6S
	O46I9PePGWUlwMciEkqUKQLicaiwzfcvhoEhPLbL2g6PnTcaHET5xBshaB9UBRCiIRuL79F9Qmar+
	iNwh2c7A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDw0-00000000Ez0-1BlL;
	Mon, 16 Dec 2024 16:27:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] squashfs: Pass a folio to squashfs_readpage_fragment()
Date: Mon, 16 Dec 2024 16:26:56 +0000
Message-ID: <20241216162701.57549-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216162701.57549-1-willy@infradead.org>
References: <20241216162701.57549-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove an access to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index bc6598c3a48f..6bd16e12493b 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -417,9 +417,9 @@ void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
 }
 
 /* Read datablock stored packed inside a fragment (tail-end packed block) */
-static int squashfs_readpage_fragment(struct page *page, int expected)
+static int squashfs_readpage_fragment(struct folio *folio, int expected)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode->i_sb,
 		squashfs_i(inode)->fragment_block,
 		squashfs_i(inode)->fragment_size);
@@ -430,7 +430,7 @@ static int squashfs_readpage_fragment(struct page *page, int expected)
 			squashfs_i(inode)->fragment_block,
 			squashfs_i(inode)->fragment_size);
 	else
-		squashfs_copy_cache(page, buffer, expected,
+		squashfs_copy_cache(&folio->page, buffer, expected,
 			squashfs_i(inode)->fragment_offset);
 
 	squashfs_cache_put(buffer);
@@ -474,7 +474,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 		else
 			res = squashfs_readpage_block(&folio->page, block, res, expected);
 	} else
-		res = squashfs_readpage_fragment(&folio->page, expected);
+		res = squashfs_readpage_fragment(folio, expected);
 
 	if (!res)
 		return 0;
-- 
2.45.2


