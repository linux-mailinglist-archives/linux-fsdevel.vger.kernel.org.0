Return-Path: <linux-fsdevel+bounces-17151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4E58A86F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180851C21877
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E3146A9A;
	Wed, 17 Apr 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cxPKqzo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52953146A9E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366262; cv=none; b=ufYgYtngrBPI/jT+/BBr2PNStCZ9184D++bft1HemGmyGrI2xYMytPrXKxbtcqhIjPc0kzi4Bgoo71UCw7euqRhNF/qeueYnrWAp7uXohuKQomKfYh6CLKuZg1OAmYSrHoOfg+CfDg81Rfco+FoqreoBtNRcHxAkS+QBGWQggvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366262; c=relaxed/simple;
	bh=7O0u5lB+BmlszWBGnHO/LsZjCsJNEOZv+Oo0NZvOvuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbmKpR7+3aeCeY6aHv4mACb9BcqwDPGbPMvaaRJx1YMqL3QBanpOmkxDLohyby2NwyKXF/FVcLjkjjo6rhDTzP8mTchOJHHY8ZTQ03NuUWjc/6yTWbmtcR/gWqjkJGxglBinfvLp0f7O8v/Zj5N7LH4WtO6dQDdP0NuPv8oOLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cxPKqzo/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0o+p509pKU2i7VIZ+04GOQ1tLaLmzCNckDGYLl7pmZs=; b=cxPKqzo/+sQOaHo3GBHlQZBSR4
	It5ICjihkJSAa00dQaIpDidALWqN3A+zpHjb77XwTZJpL0LmPFpDqjApTUfQUXvrtldhkRLJiy6uj
	azsfQp0xGuL4jq9vOfUqXBsYYBxrnendf884IzrUztIDX5K2qr2PqiIsWqAMvLuxUeVB/7O9qkZvf
	wGR1jbhOALsunI80Yb9D0dCRiBOxmCpiax+gZKANTHE149+yRn+TM7kQiaYeYP1m7V82Aj05vI7o1
	4KUsyUediumsbUv8ylUHgxAwtxALn7OypKH/vP7rKjafj8OSqTyQwr9gqQ8Ii2gVzUkcfuuvdG/G+
	Fdb13ykg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6pe-000000039sp-1c44;
	Wed, 17 Apr 2024 15:04:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] udf: Convert udf_adinicb_readpage() to udf_adinicb_read_folio()
Date: Wed, 17 Apr 2024 16:04:10 +0100
Message-ID: <20240417150416.752929-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417150416.752929-1-willy@infradead.org>
References: <20240417150416.752929-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all three callers have a folio, convert this function to
take a folio, and use the folio APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/inode.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 59215494e6f6..d34562156522 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -208,19 +208,14 @@ static int udf_writepages(struct address_space *mapping,
 	return write_cache_pages(mapping, wbc, udf_adinicb_writepage, NULL);
 }
 
-static void udf_adinicb_readpage(struct page *page)
+static void udf_adinicb_read_folio(struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
-	char *kaddr;
+	struct inode *inode = folio->mapping->host;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	loff_t isize = i_size_read(inode);
 
-	kaddr = kmap_local_page(page);
-	memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr, isize);
-	memset(kaddr + isize, 0, PAGE_SIZE - isize);
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-	kunmap_local(kaddr);
+	folio_fill_tail(folio, 0, iinfo->i_data + iinfo->i_lenEAttr, isize);
+	folio_mark_uptodate(folio);
 }
 
 static int udf_read_folio(struct file *file, struct folio *folio)
@@ -228,7 +223,7 @@ static int udf_read_folio(struct file *file, struct folio *folio)
 	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-		udf_adinicb_readpage(&folio->page);
+		udf_adinicb_read_folio(folio);
 		folio_unlock(folio);
 		return 0;
 	}
@@ -272,7 +267,7 @@ static int udf_write_begin(struct file *file, struct address_space *mapping,
 		return PTR_ERR(folio);
 	*pagep = &folio->page;
 	if (!folio_test_uptodate(folio))
-		udf_adinicb_readpage(&folio->page);
+		udf_adinicb_read_folio(folio);
 	return 0;
 }
 
@@ -364,7 +359,7 @@ int udf_expand_file_adinicb(struct inode *inode)
 		return PTR_ERR(folio);
 
 	if (!folio_test_uptodate(folio))
-		udf_adinicb_readpage(&folio->page);
+		udf_adinicb_read_folio(folio);
 	down_write(&iinfo->i_data_sem);
 	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
 	       iinfo->i_lenAlloc);
-- 
2.43.0


