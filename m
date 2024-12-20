Return-Path: <linux-fsdevel+bounces-37991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645B9F9CD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 23:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA9F16BDBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94A7227575;
	Fri, 20 Dec 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EaIJ8fua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660E1C5CBC
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734734801; cv=none; b=kycSuB74SBxflyHDfaJN0MOdrt9opCGfcMUUBATb7iiZhhnRHMVYZb/PZDZ/q7MROBLQsaIz2pgIuX/aC5Wl7jgdvPyll2ouFB9VkMWWiF3cU7GjLZUQXhghgjtEuV8ECSxhatYKDGEUOKC1+9HAE77HsTAMOTaJzzvI/Zrwiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734734801; c=relaxed/simple;
	bh=+rDGsU6PpbuyrhNX8ezB5JqZ381HzuavhECPID8LAHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdbOPp7ISCSPMXm+whLNLtdjYOZA1NUavkOwfHC3SmnESyWaX+ETBuJG6a393lGzKtE+c/U1UCPQP1cj9lzJo0ZKEpDdMdhj3SX/YTHdhZ8FgdhyNYR29YoE0dxjWBtIdfPkqkNiYOWFebZknZeLLDZGBls60XtnGxCk/tFHJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EaIJ8fua; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LZ5OrPuIVHgO9uugI8412gKWwbcN2x5YFOCCPNSvsdU=; b=EaIJ8fuaQQDgwbKZuYiKDTf3pk
	PHhzPzQkPzI209ZB0wjWv4+1J/KB7ocwJB34QB5UJ4up5Jz/7K3MvIW2esZUPxsL2nKWALOkozuFU
	nrfozQTbf7vmmyDreY4Idx+s6USmKkGVc8t5TQtuvjLmLlwpSBF7Fl92XL/CEdA09gR0Am4KidxtF
	FewUlplHQrLVr8PZ4M9M0D4oxZBm0hNMMzgh61Sa/P7og/F/hEDlnc8bUPadx0/C8ueX4fQx3Ky70
	MnvVxkpMKENG6tFzRooWmIQbNZ2XIr56/sLxaKBArIXpR7nU5RcCmA0HVgEC9YwT0PnVioN4CQWm1
	NCYkY1Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOllT-000000032NC-1dzL;
	Fri, 20 Dec 2024 22:46:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/5] squashfs: Pass a folio to squashfs_readpage_fragment()
Date: Fri, 20 Dec 2024 22:46:25 +0000
Message-ID: <20241220224634.723899-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220224634.723899-1-willy@infradead.org>
References: <20241220224634.723899-1-willy@infradead.org>
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


