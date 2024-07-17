Return-Path: <linux-fsdevel+bounces-23851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B6933FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C2A281683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF09183061;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkdsx6bE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC1181CE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231245; cv=none; b=c8BbN61raUcSh0gKsH1YTpntD1fht+GTZI8wAg2lkhnn6KcS5PrOW4fhRDxMQOL9ICFG8mX58EG7KkacP+CaQA5A4DEBzBuOlIDzV1H/gUDDtYtq3gHr/2paI7iYBgm3Q1Sjd8K8VMLmIy/ZjpUQ8z8mSaWfD3HCmDzsXRLkOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231245; c=relaxed/simple;
	bh=QSXW8h6A72qWc2d0egKnjMeT7yRAaU0ZiOtxPJ2w88E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2B6hV6PIjBykOD9o2eR5ZkHnJpJnsig107HL/1FS5HR8rRfFZ2j/oLsNlvViTw+L+bSSP4QLH+fpWrsAKhKC+eznGMFgAL+HAeU0g+Q3hc6yKGltbf0skf2kZzqrCsM9/CvjAlFCENxSttJi5oCu6IpAWaDzYKNa7+6e9VT6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dkdsx6bE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/Pz5szaoYe+C3L09gVEueIlnzx8sPhUhWvZbJlz2hhQ=; b=dkdsx6bE22vPnvw1PRAfrdrkcx
	r1B2vSjndkkE03iWg7knlt9Wz2tG6MQ90GjVUZvnmKu4aDuMrPnzcELtd5slSFvqplazMCENgW3/b
	H81UwVCmzFhX5DBf5f5ghUGs7d5OupjzmLWLtAFsntx5a3I+fsIEfnR5ylmapJ3t2sV31fBID3Rg0
	Dr0olACwW+2xpdbLP8AmeIQDT5aiMKzdB8oQeNaG/L+YmzHM6kgNX62GRjEgNRoGnOiuimm34so1O
	Yf/Dj6NAHl5TXzG8A7xH5fks++s08m9k/PHTOUM8J1gt8wgdxMolMzAgWxMx6Jh4ZfwCiEbWDIspD
	nhTxbSCg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sD-00000000zv2-3GAA;
	Wed, 17 Jul 2024 15:47:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 14/23] hostfs: Convert hostfs_write_end() to use a folio
Date: Wed, 17 Jul 2024 16:47:04 +0100
Message-ID: <20240717154716.237943-15-willy@infradead.org>
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

Convert the passed page to a folio and operate on that.
Replaces four calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hostfs/hostfs_kern.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 8bf2dc1f9c01..42b70780282d 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -478,17 +478,18 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
 			    loff_t pos, unsigned len, unsigned copied,
 			    struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	void *buffer;
-	unsigned from = pos & (PAGE_SIZE - 1);
+	size_t from = offset_in_folio(folio, pos);
 	int err;
 
-	buffer = kmap_local_page(page);
-	err = write_file(FILE_HOSTFS_I(file)->fd, &pos, buffer + from, copied);
+	buffer = kmap_local_folio(folio, from);
+	err = write_file(FILE_HOSTFS_I(file)->fd, &pos, buffer, copied);
 	kunmap_local(buffer);
 
-	if (!PageUptodate(page) && err == PAGE_SIZE)
-		SetPageUptodate(page);
+	if (!folio_test_uptodate(folio) && err == folio_size(folio))
+		folio_mark_uptodate(folio);
 
 	/*
 	 * If err > 0, write_file has added err to pos, so we are comparing
@@ -496,8 +497,8 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
 	 */
 	if (err > 0 && (pos > inode->i_size))
 		inode->i_size = pos;
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return err;
 }
-- 
2.43.0


