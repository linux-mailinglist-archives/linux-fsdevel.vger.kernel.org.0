Return-Path: <linux-fsdevel+bounces-23839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D0933FE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2228A1F24EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DD5181D0E;
	Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cGDGqzht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5222374C2
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231243; cv=none; b=IREWdC2L2wu4sQ7VVKldCJATUGkcp/oFwxIj9NFxW0chkfW26zGc50D9uZ/0OeUmrWsNVQAgPlYIeYb/JcvIgYO63FDDdIuT8r3nEd8XYjX8RtBRGd1nV1QfwE/DAAXFztHaUm1Q1kcB6lvq6c52sWY1ppMZkU/yYFBqOoKK1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231243; c=relaxed/simple;
	bh=4GwxcrEiNgQt3YPoQjxagSJjhw+WhuW1PRKIQz5PSgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/9UqED4qwUK2e1q+EO2ZQqstUswOaRlMDSXDDi3eC3Me2NSzTRtos7kZuDzXX5jl6C4Hxdtl+pTuoCQoauzrU+WXMiZboxrsQ5++mJ0tDoULfjPu7RTen3xOQbFGbSYYJpMUMB627BYJLXS8SxR2bkfwbtrv+gyMGkSlt/HaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cGDGqzht; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gDMQEAmlN0U6YTHZ0c0vxxnxu17y6JrmTkfGqu4rEU4=; b=cGDGqzhtMd57M5vtBGxW7SejzH
	k/N5DR6/ioWBG8p63IKndJyD0pZMNJTMteI8fKZWVqEzx3wMAaBjphfhmYEI+ZTJ5zDHgmRW9o55l
	9TSrgSYpifpzhIiqMIpouyTLU6p73J3kRT5eBiwL4CX5A0nO+eYluJRvnXsf1kx9V31fZn97PkOZM
	7vV96ATCZuL31Sgsje51z0kOxDZXaiSbJ+Ap6qSlsm43OTfer5lWxDEEune0viEPIzlOYDpUK6NIS
	JXit4O0dWcX86twBssoq3PB5cc1yRR8WDEAWvUhMQ10iJ7ZQisOTw2z70mJ18lcAx1jQ9PFtXnLP8
	R/gyZtlA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sC-00000000zu9-0gCh;
	Wed, 17 Jul 2024 15:47:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/23] block: Use a folio in blkdev_write_end()
Date: Wed, 17 Jul 2024 16:46:53 +0100
Message-ID: <20240717154716.237943-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces two hidden calls to compound_head() with one explicit one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/fops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9825c1713a49..da44fedb23e5 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -460,11 +460,12 @@ static int blkdev_write_end(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, unsigned copied, struct page *page,
 		void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	int ret;
 	ret = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return ret;
 }
-- 
2.43.0


