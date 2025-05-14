Return-Path: <linux-fsdevel+bounces-48990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E4AB7281
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4654B4C38DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247A028032A;
	Wed, 14 May 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vpxhpA6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5217993;
	Wed, 14 May 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242800; cv=none; b=gr+o7ioYQklLaIsRimXedZeGvdwlegAUBNdvDOFZEuuMIH8Rasvmynn8RqjAxb84OCLYelbt5Pca0aZiWBxZ5Ss3XKZvi0Gfk3rB+KH1IELXtFaTfwU0UyCK+3r2Dr0T9GSdKdAMj7Q3Qc8CC6/uIkgOoLd4jMWiegVCcevIMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242800; c=relaxed/simple;
	bh=cc/e8ZODh0HDp9ldUjRIj86MH1C0t0rckiMFUyz/T2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixN4InZoFO2jGHrhfqJHm6evCcjN2wvcnPL2+kMvP+nj/NJbf8yEOUPwTBnwndh40BGlCQ30klEhQFovGrj5nFwVndD1UYd9deW9i00+lXUCq41OkTnmmv6/AGnvI462+BHATrFaw0BNB5pISUX/oBSYlSkSPxLiKULjwqE6N8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vpxhpA6C; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JMstG3TNL/bO+62E7PEXf1sn1bVXriwilGJSBMk3WEc=; b=vpxhpA6C+nlN2NRTfEiYMrpJ8j
	bIN5m0zDswJf7GZcUpKSzFOs+1miQNneDpuCdxImwteHG9Cnggb1jV7pKEZl5YeVurpmoQGccsdeQ
	JEuzqd7pzEGBJhUMwE/CUHk0wqu4PHOV4L4HeCy5auWHeUsfmH3asjzNv3Z6Bemc55YilnevmcoOv
	QXdHKCseTxnkEusDR0MEcXzS8EBrpUO2quqc1mio6yCeEocb2WQZLMHUihYh+JiUt0EP/neCM1tnS
	1E1jufjyyoN70NMQxn+XO2kJ9mUXsgXKjGIY628srz5TgzsV/DBPS8qvkqks712Jb15JA3IJRw26F
	8SeNQhQw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFFfR-0000000CbCd-1rUj;
	Wed, 14 May 2025 17:13:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] fs: Convert __page_get_link() to use a folio
Date: Wed, 14 May 2025 18:13:12 +0100
Message-ID: <20250514171316.3002934-2-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514171316.3002934-1-willy@infradead.org>
References: <20250514171316.3002934-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieve a folio from the page cache instead of a page and operate
on it.  Removes two hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/namei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 84a0e0b0111c..8e82aa7ecb82 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5403,25 +5403,25 @@ EXPORT_SYMBOL(vfs_get_link);
 static char *__page_get_link(struct dentry *dentry, struct inode *inode,
 			     struct delayed_call *callback)
 {
-	struct page *page;
+	struct folio *folio;
 	struct address_space *mapping = inode->i_mapping;
 
 	if (!dentry) {
-		page = find_get_page(mapping, 0);
-		if (!page)
+		folio = filemap_get_folio(mapping, 0);
+		if (IS_ERR(folio))
 			return ERR_PTR(-ECHILD);
-		if (!PageUptodate(page)) {
-			put_page(page);
+		if (!folio_test_uptodate(folio)) {
+			folio_put(folio);
 			return ERR_PTR(-ECHILD);
 		}
 	} else {
-		page = read_mapping_page(mapping, 0, NULL);
-		if (IS_ERR(page))
-			return (char*)page;
+		folio = read_mapping_folio(mapping, 0, NULL);
+		if (IS_ERR(folio))
+			return ERR_CAST(folio);
 	}
-	set_delayed_call(callback, page_put_link, page);
+	set_delayed_call(callback, page_put_link, &folio->page);
 	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
-	return page_address(page);
+	return folio_address(folio);
 }
 
 const char *page_get_link_raw(struct dentry *dentry, struct inode *inode,
-- 
2.47.2


