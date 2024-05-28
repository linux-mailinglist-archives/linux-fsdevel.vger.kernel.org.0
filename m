Return-Path: <linux-fsdevel+bounces-20374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2A8D26B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 23:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E6B1C26A43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7C17B430;
	Tue, 28 May 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="onSQaaX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096B17B41C;
	Tue, 28 May 2024 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930261; cv=none; b=OnmGa8hLkekArIw77h2/oXjMACjl5NjBsgSSlyjScYlaADV0CNetecy3/Ag7uedR8rbTAi9bZS/HbEUDyGkoSL9Al1AB8k5L67YLb73v4KjNH2nf62uQq1Fw5r8H2q6CzPREqAE5a6tSGMkoAeFsCvZ3dQz4Bs19zXeYRR56PFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930261; c=relaxed/simple;
	bh=RJ/CQkZjFiXuinzKk7Iejje+UsZczuR8IPM9Px01j8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/Kt5w4GY6XYnXT3imefyCn5XatwzW3H480HWd+Ezd8Jiy8RXM9d0xWM6/Q0lxsZm8Jsh7ltdvA3Ovx5X23NPJnWmWEGgzfrsiGPwo8oowyDSFITJVogbkVCHuP8AeBEcKRkVqzLgVZreuJAIJ+tVF/abwkZxvrOERYeZcp6yvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=onSQaaX1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IbBjjdFJMfmL/+GMfORVSWgGlekJR5vTI9wlUJ5rqis=; b=onSQaaX1o3zLTcYXMNBiIiBSQm
	aA+xXiq53aBOY0ZbFEP5yVh1q2nOMX7DWJ38e5laOk520SWA44jx78MSN7JPFnz5FWXUyRVk7pj3h
	EVBDZiX5ny3fmBsLGn35IRzbVR4+Ryi0OYlunDdGhxvw2oMxXSaahDlnY/jbjWDJ0LbampR2ZoHaK
	5ZoaIgCfVWDHP2wepMjbP02b5gXuad+V+a11ZFz0yniJSdghBmAnVEHPsAKneqFZdwzRuS3CfVmte
	cGQEmZeTDz4vQXwVtQHsCkuOYxZ8eXC8jIBFLOjZoHLdfmZp8p9pkxfraxWHJUbwenPK/DOVR3pmG
	X4a7v/PA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC3zT-000000093ho-0o6P;
	Tue, 28 May 2024 21:04:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] nfs: Fix misuses of folio_shift() and folio_order()
Date: Tue, 28 May 2024 22:03:15 +0100
Message-ID: <20240528210407.2158964-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240527163616.1135968-1-hch@lst.de>
References: <20240527163616.1135968-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page cache indices are in units of PAGE_SIZE, not in units of
the folio size.  Revert the change in nfs_grow_file(), and
pass the inode to nfs_folio_length() so it can be reimplemented
in terms of folio_mkwrite_check_truncate() which handles this
correctly.

Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 fs/nfs/file.c           |  6 +++---
 fs/nfs/internal.h       | 16 +++++-----------
 fs/nfs/read.c           |  2 +-
 fs/nfs/write.c          |  9 +++++----
 include/linux/pagemap.h |  4 ++--
 5 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 6bd127e6683d..723d78bbfe3f 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -301,7 +301,7 @@ EXPORT_SYMBOL_GPL(nfs_file_fsync);
 static bool nfs_folio_is_full_write(struct folio *folio, loff_t pos,
 				    unsigned int len)
 {
-	unsigned int pglen = nfs_folio_length(folio);
+	unsigned int pglen = nfs_folio_length(folio, folio->mapping->host);
 	unsigned int offset = offset_in_folio(folio, pos);
 	unsigned int end = offset + len;
 
@@ -386,7 +386,7 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 	 */
 	if (!folio_test_uptodate(folio)) {
 		size_t fsize = folio_size(folio);
-		unsigned pglen = nfs_folio_length(folio);
+		unsigned pglen = nfs_folio_length(folio, mapping->host);
 		unsigned end = offset + copied;
 
 		if (pglen == 0) {
@@ -610,7 +610,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	folio_wait_writeback(folio);
 
-	pagelen = nfs_folio_length(folio);
+	pagelen = nfs_folio_length(folio, inode);
 	if (pagelen == 0)
 		goto out_unlock;
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9f0f4534744b..3b0236e67257 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -819,19 +819,13 @@ unsigned int nfs_page_length(struct page *page)
 /*
  * Determine the number of bytes of data the page contains
  */
-static inline size_t nfs_folio_length(struct folio *folio)
+static inline size_t nfs_folio_length(struct folio *folio, struct inode *inode)
 {
-	loff_t i_size = i_size_read(folio_file_mapping(folio)->host);
+	ssize_t ret = folio_mkwrite_check_truncate(folio, inode);
 
-	if (i_size > 0) {
-		pgoff_t index = folio_index(folio) >> folio_order(folio);
-		pgoff_t end_index = (i_size - 1) >> folio_shift(folio);
-		if (index < end_index)
-			return folio_size(folio);
-		if (index == end_index)
-			return offset_in_folio(folio, i_size - 1) + 1;
-	}
-	return 0;
+	if (ret < 0)
+		ret = 0;
+	return ret;
 }
 
 /*
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a142287d86f6..ba3bb496f832 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -296,7 +296,7 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 	unsigned int len, aligned_len;
 	int error;
 
-	len = nfs_folio_length(folio);
+	len = nfs_folio_length(folio, inode);
 	if (len == 0)
 		return nfs_return_empty_folio(folio);
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446..7713ce7c5b3a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -278,8 +278,8 @@ static void nfs_grow_file(struct folio *folio, unsigned int offset,
 
 	spin_lock(&inode->i_lock);
 	i_size = i_size_read(inode);
-	end_index = ((i_size - 1) >> folio_shift(folio)) << folio_order(folio);
-	if (i_size > 0 && folio_index(folio) < end_index)
+	end_index = (i_size - 1) >> PAGE_SHIFT;
+	if (i_size > 0 && folio->index < end_index)
 		goto out;
 	end = folio_file_pos(folio) + (loff_t)offset + (loff_t)count;
 	if (i_size >= end)
@@ -358,7 +358,8 @@ nfs_page_group_search_locked(struct nfs_page *head, unsigned int page_offset)
  */
 static bool nfs_page_group_covers_page(struct nfs_page *req)
 {
-	unsigned int len = nfs_folio_length(nfs_page_to_folio(req));
+	struct folio *folio = nfs_page_to_folio(req);
+	unsigned int len = nfs_folio_length(folio, folio->mapping->host);
 	struct nfs_page *tmp;
 	unsigned int pos = 0;
 
@@ -1356,7 +1357,7 @@ int nfs_update_folio(struct file *file, struct folio *folio,
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	struct address_space *mapping = folio_file_mapping(folio);
 	struct inode *inode = mapping->host;
-	unsigned int pagelen = nfs_folio_length(folio);
+	unsigned int pagelen = nfs_folio_length(folio, inode);
 	int		status = 0;
 
 	nfs_inc_stats(inode, NFSIOS_VFSUPDATEPAGE);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c6aaceed0de6..df57d7361a9a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -212,8 +212,8 @@ enum mapping_flags {
 	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
 };
 
-#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
-#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
+#define AS_FOLIO_ORDER_MIN_MASK (31 << AS_FOLIO_ORDER_MIN)
+#define AS_FOLIO_ORDER_MAX_MASK (31 << AS_FOLIO_ORDER_MAX)
 #define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
 
 /**
-- 
2.43.0


