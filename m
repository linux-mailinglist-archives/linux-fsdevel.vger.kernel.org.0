Return-Path: <linux-fsdevel+bounces-20576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D18D53BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458E6B24FE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B265167D96;
	Thu, 30 May 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iWllsKEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B645158DD8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100481; cv=none; b=klml3pKRgNj4JYgoNa8zZ6iW7AXqLRprHaX+qAdqhugTl0VBILK8RmEzRr6b3YkL6FtsujsjcdqRVUVBBCBDFdBHD9eZuA0bm4MeTSUHmrN8BaIaURJjRBHOmMJ89BKOmvZ1P/qhyfIbH6BJqm8StDCz0XrcHsagpncX++EziuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100481; c=relaxed/simple;
	bh=HXK9SrkeoGYeQqaRCbDyaBLW2cECSXCKLkdh+hbfB5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXUjkZDhiqvjDLfI8yi0ofuBv4bPxEfFc6hqDqDV4yhNJNgfdKKHNb4smPO5ipFH810rH1KQ9AxsbwtvYkRHVM7CIL3ZXln6pcgD8UTK/cjhCL0bDf44rZXEMcKtPnr5G7D85uex6PPvd+fpq+E3MbvKdcKaw9kmvPVKfVV0Lfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iWllsKEW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=c7vikNugCgi0jVhZmW+/vu+Luq6OpZDlsK0DHYxWiTc=; b=iWllsKEW/Za59bCRtpFF6Ms2Mf
	M7a1WaxTVZXbkTzVn1OX4WhHEmVMbtLsyrWSuD7N4NEGBlHIC969OwLmislF2ll+Y6zQdMX2oHlAH
	pG5KlDLN8NImAAGCBWNhuD3Hogesf4LNjRcIQLuSCYhiD1PLs+NsOasIw1bZpNgxkvGSm2RRl6IKH
	Ft18ocAHGMCv2VbHyUYzOMr294xkNuLMsTPya0emFiNBZIfclH3BxW76U782pbhJm5uh6WTBsPoe1
	QKeyl8j4LgmdGF0RHJu8XLLb+XGCLDD/zmy1kfZHkwBFCce6PDzKiviDv7//z2vT5q5mOEQKd949u
	6YvmrqWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH0-0000000B8LW-1qBb;
	Thu, 30 May 2024 20:21:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/16] romfs: Convert romfs_read_folio() to use a folio
Date: Thu, 30 May 2024 21:21:04 +0100
Message-ID: <20240530202110.2653630-13-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the conversion back to struct page and use the folio APIs instead
of the page APIs.  It's probably more trouble than it's worth to support
large folios in romfs, so there are still PAGE_SIZE assumptions in
this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/romfs/super.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 2cbb92462074..68758b6fed94 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -101,19 +101,15 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos);
  */
 static int romfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	loff_t offset, size;
 	unsigned long fillsize, pos;
 	void *buf;
 	int ret;
 
-	buf = kmap(page);
-	if (!buf)
-		return -ENOMEM;
+	buf = kmap_local_folio(folio, 0);
 
-	/* 32 bit warning -- but not for us :) */
-	offset = page_offset(page);
+	offset = folio_pos(folio);
 	size = i_size_read(inode);
 	fillsize = 0;
 	ret = 0;
@@ -125,20 +121,14 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
 
 		ret = romfs_dev_read(inode->i_sb, pos, buf, fillsize);
 		if (ret < 0) {
-			SetPageError(page);
 			fillsize = 0;
 			ret = -EIO;
 		}
 	}
 
-	if (fillsize < PAGE_SIZE)
-		memset(buf + fillsize, 0, PAGE_SIZE - fillsize);
-	if (ret == 0)
-		SetPageUptodate(page);
-
-	flush_dcache_page(page);
-	kunmap(page);
-	unlock_page(page);
+	buf = folio_zero_tail(folio, fillsize, buf);
+	kunmap_local(buf);
+	folio_end_read(folio, ret == 0);
 	return ret;
 }
 
-- 
2.43.0


