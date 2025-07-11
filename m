Return-Path: <linux-fsdevel+bounces-54591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0EB0159F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F661C83D72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3120DD52;
	Fri, 11 Jul 2025 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i4/hmafo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180D1FF1C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221443; cv=none; b=d4lov7MCTTAWEwRSule7ge3GImoKCy4aa/TMJRoE2tAvMyyGQ1y99x37JSHtLC+oq+BEcP4NO5qcrX6xj3ihvNfcuvt4Pvwdsr3zRIl3EzaSL54zct8/6h0TU69mkHigzPkPqClUMLCewTRpvlLHrt+8TJWZgyh3F8tUhC0V5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221443; c=relaxed/simple;
	bh=Kwgs7HmejVuybbwSsO6Dj/TOdsQlamsOK+4m7YKIwXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYIFDa5k5Ec7kRxDC2EV5mUp4XV2KjotqZcrrf3+qoyeE+PY8niTDfQ2CIk7JgQyhjzjyqpbE9pVpu8O5q+OlvWKIyNfNmcBEX9Dv+A79mWcgT4pIso/3ZMnd5n8PQ0iYHEZU10MWdZ/EKWbTjp9t+UttT1Mn9E5jtntomS0Rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i4/hmafo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qnEs5arKDmF5W6dQLKY2snkfgpJoEDpuVkxrl3AZkNI=; b=i4/hmafoYCLznRDLfdHPUU1lU7
	rr/XuXOlx2gDrOb58fTb/28CoBd7vJbQdJHeIzE+lNcUqiqqzK3GkAMmsxy3yD0Pnu6uMSff1lj43
	6qGiaMkIKtkjWT+rIP5N9GNrIJR2zs3Px4/b/Bq8u4uqJkigBt7rxE08gMr2GEk6ATdV4sCMTOOxL
	FzNqWhUZecBCkbxcEfVSj1lcsEdeS2pS8d7qw81fEAtwF8wBI6QEBM26E+oKwqvRQ2+FuP/I7S8L7
	m4C8TagyAfu2355ri/ujRN8RafYWOLF5xI7t7fs/HD80LNa1XXfSGayAePdzjPrp8uxmh0wxVsn0M
	y+x8j82w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua8q8-0000000E5Uj-1tNF;
	Fri, 11 Jul 2025 08:10:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: jack@suse.com
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] udf: stop using write_cache_pages
Date: Fri, 11 Jul 2025 10:10:36 +0200
Message-ID: <20250711081036.564232-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Stop using the obsolete write_cache_pages and use writeback_iter directly.
Use the chance to refactor the inacb writeback code to not have a separate
writeback helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/udf/inode.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4386dd845e40..c0975d5dec25 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -181,19 +181,23 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int udf_adinicb_writepage(struct folio *folio,
-				 struct writeback_control *wbc, void *data)
+static int udf_adinicb_writepages(struct address_space *mapping,
+		      struct writeback_control *wbc)
 {
-	struct inode *inode = folio->mapping->host;
+	struct inode *inode = mapping->host;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct folio *folio = NULL;
+	int error = 0;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		BUG_ON(!folio_test_locked(folio));
+		BUG_ON(folio->index != 0);
+		memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio,
+				0, i_size_read(inode));
+		folio_unlock(folio);
+	}
 
-	BUG_ON(!folio_test_locked(folio));
-	BUG_ON(folio->index != 0);
-	memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio, 0,
-		       i_size_read(inode));
-	folio_unlock(folio);
 	mark_inode_dirty(inode);
-
 	return 0;
 }
 
@@ -203,9 +207,9 @@ static int udf_writepages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
-	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB)
-		return mpage_writepages(mapping, wbc, udf_get_block_wb);
-	return write_cache_pages(mapping, wbc, udf_adinicb_writepage, NULL);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		return udf_adinicb_writepages(mapping, wbc);
+	return mpage_writepages(mapping, wbc, udf_get_block_wb);
 }
 
 static void udf_adinicb_read_folio(struct folio *folio)
-- 
2.47.2


