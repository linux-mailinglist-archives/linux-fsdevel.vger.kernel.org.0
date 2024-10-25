Return-Path: <linux-fsdevel+bounces-32942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1509B0DF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1643D2863BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A576620EA56;
	Fri, 25 Oct 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q3fJalPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8220EA53;
	Fri, 25 Oct 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883310; cv=none; b=T+TZE1HyYiPt3Xyn4A2Pf8bz91M7FyNpTFczo/ZwlEIzIisXWLmJ4z6OaNzHUpYT1VnvXmJ8M0iL1w5kImXJDIG67VgM0JmZooFlCC6o7m65SNcFOyQLUuM+NGQrBBEQzGlU2ywgY13DptWZPJr6IO+IHtA5IsuIgGYrs9a+4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883310; c=relaxed/simple;
	bh=O23Gy//oeLZ55SVeNW28SgBcNWSa8ozwd5Oo71wrXH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPE+X8FEQ+yQvl7kiBTyvIFntpLDa8MBhK5f7fbFUh6TUiVRU2qpZlxyVeLfulOMYzBuYk8822YkA0WPwBJK2AdiasOfj8uxMig03VetCTCL+mEPpkBN9/BQOONcjV4SddbfiUpJ/hBGncQxvzlDP9MK0ys1OUATof4JhNE4w/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q3fJalPh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QvXLg6hq5jvQb9bvdZtTJRsSaVrN4g0Ygii5MFDj5NA=; b=q3fJalPh2j4HuO/lfwDBj2gn0o
	oSo/l/oQzMzQQS+BgYDt4YwYBgiqPrqIDG0KCeUD1jZ0W7RKyciRCjtEab2dkZE8iTjaHqA01OJgk
	mUvBXdt5K8l+JorgyTxS3zCi80AQfMBauEaJT4fS/sexNieoHxKqQiel+wfIoVuCQXOd5xa518Wcw
	GlVMWh3NFFIWTHQwm+Ef/4p1wAPEDdMFFFQFFgE4CPTLxKuwmjJPqH1gB3xtVor1FrNIhZvaA2wPY
	P9bYlK11K0XvkQSOPIk/eo9fENxCAtEuLylRooX/ME9NTnbZYYFwrDp9ZnNP1p3qyktmZ8ZBpyiFk
	Qrr5AFvw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfb-00000005XB2-2MGJ;
	Fri, 25 Oct 2024 19:08:23 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/10] ecryptfs: Convert ecryptfs_writepage() to ecryptfs_writepages()
Date: Fri, 25 Oct 2024 20:08:11 +0100
Message-ID: <20241025190822.1319162-2-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241025190822.1319162-1-willy@infradead.org>
References: <20241025190822.1319162-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By adding a ->migrate_folio implementation, theree is no need to keep
the ->writepage implementation.  The new writepages removes the
unnecessary call to SetPageUptodate(); the folio should already be
uptodate at this point.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/mmap.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index ceda5555971a..92ea39d907de 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -38,32 +38,30 @@ struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index)
 	return page;
 }
 
-/**
- * ecryptfs_writepage
- * @page: Page that is locked before this call is made
- * @wbc: Write-back control structure
- *
- * Returns zero on success; non-zero otherwise
- *
+/*
  * This is where we encrypt the data and pass the encrypted data to
  * the lower filesystem.  In OpenPGP-compatible mode, we operate on
  * entire underlying packets.
  */
-static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
+static int ecryptfs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	int rc;
-
-	rc = ecryptfs_encrypt_page(page);
-	if (rc) {
-		ecryptfs_printk(KERN_WARNING, "Error encrypting "
-				"page (upper index [0x%.16lx])\n", page->index);
-		ClearPageUptodate(page);
-		goto out;
+	struct folio *folio = NULL;
+	int error;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		error = ecryptfs_encrypt_page(&folio->page);
+		if (error) {
+			ecryptfs_printk(KERN_WARNING,
+				"Error encrypting folio (index [0x%.16lx])\n",
+				folio->index);
+			folio_clear_uptodate(folio);
+			mapping_set_error(mapping, error);
+		}
+		folio_unlock(folio);
 	}
-	SetPageUptodate(page);
-out:
-	unlock_page(page);
-	return rc;
+
+	return error;
 }
 
 static void strip_xattr_flag(char *page_virt,
@@ -548,9 +546,10 @@ const struct address_space_operations ecryptfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 #endif
-	.writepage = ecryptfs_writepage,
+	.writepages = ecryptfs_writepages,
 	.read_folio = ecryptfs_read_folio,
 	.write_begin = ecryptfs_write_begin,
 	.write_end = ecryptfs_write_end,
+	.migrate_folio = filemap_migrate_folio,
 	.bmap = ecryptfs_bmap,
 };
-- 
2.43.0


