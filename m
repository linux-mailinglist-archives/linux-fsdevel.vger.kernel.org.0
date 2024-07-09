Return-Path: <linux-fsdevel+bounces-23342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F892AEBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6B42822B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218980604;
	Tue,  9 Jul 2024 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/Q9BtEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062464A
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495835; cv=none; b=V3TfIbxFfafld/mFfdJ9M38XBbyj4NljJhEnKK3AEUAo2W7kUpozw4XkqotPhSs+PlyLhWm+xXBZ5Jo5knMknXF07P4Qpf3zhQln8tU+OGNagsNErHCtY2tyoxAVJAWNL9J0knvPNiYulHybwIzwLRngjsPpu8n45dnwG9bB1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495835; c=relaxed/simple;
	bh=8bHZbJId0ovgon4/9AKw2LyS5x+UiiIv5uSOyjTJI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKvnXDuakbXciCyJYUtfvFn3gL6BQKd//9xPeSVc+WjDS2YVvCAcUxvdV/25f+8sRwwd3UFtq+KsfkIJJhKKFx6RXnpFxuZiYozVFsvK/qtFP7GGger6f1MXbnpPSssN0XAXoW/mBpxIxXvqNex2LAouMVDFEyQZnrgRwxgs0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c/Q9BtEM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=joDbiTqAQWjjgZNLC481R5u1YNLWqgIKDhlOHrSPA7Q=; b=c/Q9BtEMm6X/TU5uYOR85N7Zte
	gQdQTtdYOesQ+HxKNOQXhGIly21qmkWEKPKbuVx/uOxDkJnx4D9VFJXFsiUg0ZKcrLYaGhreMazPV
	TXrSfsk1zTyIKIPlMp5pVIf6eyUG+hb9sHDboM3JapD7VRtQAWqqvn+bNrNJs/MUVUfBcKJOCG2ll
	Wvb0IBF3vWeT+SOHcXwRtDKm0Ar6bOkTVfwB1F1WKq2wVfLn8HomyRDpXvcpMtIOBcAM0Hl31kfJ9
	iZk6mILNsUoQpaiIYTlskvsUuxrSKydxrH8Y7s3BwAjmgIGBw8PX3VBOp39FxOV5YeZfJEp2yHv+4
	MKIcCvbw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Yl-00000007QSX-162W;
	Tue, 09 Jul 2024 03:30:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/10] ufs: Convert ufs_get_page() to use a folio
Date: Tue,  9 Jul 2024 04:30:18 +0100
Message-ID: <20240709033029.1769992-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709033029.1769992-1-willy@infradead.org>
References: <20240709033029.1769992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a call to read_mapping_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 61f25d3cf3f7..0705848899c1 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -194,18 +194,19 @@ static bool ufs_check_page(struct page *page)
 static struct page *ufs_get_page(struct inode *dir, unsigned long n)
 {
 	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (!IS_ERR(page)) {
-		kmap(page);
-		if (unlikely(!PageChecked(page))) {
-			if (!ufs_check_page(page))
-				goto fail;
-		}
+	struct folio *folio = read_mapping_folio(mapping, n, NULL);
+
+	if (IS_ERR(folio))
+		return &folio->page;
+	kmap(&folio->page);
+	if (unlikely(!folio_test_checked(folio))) {
+		if (!ufs_check_page(&folio->page))
+			goto fail;
 	}
-	return page;
+	return &folio->page;
 
 fail:
-	ufs_put_page(page);
+	ufs_put_page(&folio->page);
 	return ERR_PTR(-EIO);
 }
 
-- 
2.43.0


