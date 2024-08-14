Return-Path: <linux-fsdevel+bounces-25961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D8A952304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773CF1F25B60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795581C0DCE;
	Wed, 14 Aug 2024 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SGFb0Nic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBCB1BE25F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665570; cv=none; b=AbkKimWGvPoRRAplT0p4Zg+lJNDHXubEEJmbMuH2UmE7aMoEbj8xvRi7paFEaNVRds/HiUxwaXWlgx9MtsZJ5mB3LtPRZ1q3vaHEQahzh5EISISqiaAql38EMJv9Y2sq7U+nRcWF+TUZynlneF9d2nRxNz8IgGTThmiziBXuiT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665570; c=relaxed/simple;
	bh=BSaYuwvct14w0//WzUN0uVvVTt/gVfRWrZKuvROpa2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWvw9MY2DfQxO2OmBLWaLScOErxaQE19jRZK0NB4tZxZk0zuOo3blJ76EPVom0TEiNt79fUupVhyLTrKFQO8kDGN0rKk8zfJtgnoZXmXi4gmtzdtW2RVVOZAe3A8BjF2joxiuZOSM/VRygndMAMbKBLoUMweNCF5gDsLCbdnygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SGFb0Nic; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uV7LvP5jjpQvvHUMOkXdyRNLpd4GhyRBEzDrKs36E8E=; b=SGFb0NicM17bE+zbq2q5jZZYCD
	/GBwKgJIIP/hbRdOG1WGoXdJ5DdEfgth0jh/39pUVpyQhxYPie5+FTOLVR078rN0bAu7ExOx/UOol
	2b5VYXeM+C5wB0JXKk8sFeiiPicgoazGG28RBAYPbpGR4dv/AShtC2us/E8STtD+VbCOQBO4sXcr9
	H15cTZrg/g1FGmulIiiPTfZ10cu6j9VRXt9VQDPHHCV/fl9e2316jCJ11pcDx6BV3ck8UujZQW0J9
	GwrIAWNJk8kkQAHZ5c/i105XBcKBaW5erjDNvWyZT/6XxqZx/5KVQ4r5hqDGjBgoutGi0AL3rrI4Q
	usm15/5w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seK9Q-0000000130U-2HO5;
	Wed, 14 Aug 2024 19:59:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/2] jffs2: Convert jffs2_do_readpage_nolock to take a folio
Date: Wed, 14 Aug 2024 20:59:12 +0100
Message-ID: <20240814195915.249871-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814195915.249871-1-willy@infradead.org>
References: <20240814195915.249871-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers now have a folio, so pass it in.  No effort is made
here to support large folios.  Removes several hidden calls to
compound_head(), two references to page->index and a use of kmap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jffs2/file.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index ada572c466f8..13c18ccc13b0 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -77,29 +77,27 @@ const struct address_space_operations jffs2_file_address_operations =
 	.write_end =	jffs2_write_end,
 };
 
-static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
+static int jffs2_do_readpage_nolock(struct inode *inode, struct folio *folio)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
-	unsigned char *pg_buf;
+	unsigned char *kaddr;
 	int ret;
 
 	jffs2_dbg(2, "%s(): ino #%lu, page at offset 0x%lx\n",
-		  __func__, inode->i_ino, pg->index << PAGE_SHIFT);
+		  __func__, inode->i_ino, folio->index << PAGE_SHIFT);
 
-	BUG_ON(!PageLocked(pg));
+	BUG_ON(!folio_test_locked(folio));
 
-	pg_buf = kmap(pg);
-	/* FIXME: Can kmap fail? */
-
-	ret = jffs2_read_inode_range(c, f, pg_buf, pg->index << PAGE_SHIFT,
+	kaddr = kmap_local_folio(folio, 0);
+	ret = jffs2_read_inode_range(c, f, kaddr, folio->index << PAGE_SHIFT,
 				     PAGE_SIZE);
+	kunmap_local(kaddr);
 
 	if (!ret)
-		SetPageUptodate(pg);
+		folio_mark_uptodate(folio);
 
-	flush_dcache_page(pg);
-	kunmap(pg);
+	flush_dcache_folio(folio);
 
 	jffs2_dbg(2, "readpage finished\n");
 	return ret;
@@ -107,7 +105,7 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 
 int __jffs2_read_folio(struct file *file, struct folio *folio)
 {
-	int ret = jffs2_do_readpage_nolock(folio->mapping->host, &folio->page);
+	int ret = jffs2_do_readpage_nolock(folio->mapping->host, folio);
 	folio_unlock(folio);
 	return ret;
 }
@@ -221,7 +219,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 	 */
 	if (!folio_test_uptodate(folio)) {
 		mutex_lock(&f->sem);
-		ret = jffs2_do_readpage_nolock(inode, &folio->page);
+		ret = jffs2_do_readpage_nolock(inode, folio);
 		mutex_unlock(&f->sem);
 		if (ret) {
 			folio_unlock(folio);
-- 
2.43.0


