Return-Path: <linux-fsdevel+bounces-23856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40224933FF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D9C281F08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFAA183087;
	Wed, 17 Jul 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lpFYga6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C858181D15
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231245; cv=none; b=cFrmFYLeVawh41GZrUtZMET1YM8blqviAbnMIwH1LQZef9WqqVI+q9LupyydRqpzxCwqMyptZFCLB8LPQBi4di/qr6Va6GO8mPWFJz9ASsAyyiQ6QEj8sjsLt0RMT9yyba1PPYb2/cUMxJf27v/6L09cddbIHA+nIn3BHILiU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231245; c=relaxed/simple;
	bh=E/NYT8RjAzJCM/nBqkCD3yCneqKxoPY7xoYcwRLbRFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT+X96OenQ4mvKlTLO1I/1mCA7x8Cso3FAmHaDKTpAUzSJUPuWsvgZmMwYVi3RX9ySOGrZV1CnHaTAnDwAqYwz87yXDnnWuqtt2a6WGoFQKBqSk/IxmhsmYiudINjkHQ0Tb2mxnTY7q7E7mFbNt24/jgfvmbTLxEYURAMJIvEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lpFYga6U; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Z0f/rMchkqiGIS2BpTlSSxbx3gDbESXyS1/CxwHl1G8=; b=lpFYga6Uh899Y2zfDclaKJ2YEM
	H1fWLNYqqk3KTRQE6B1SXIXfnQ5UiCywHjIOK7C/2h3QqGHrptL8/gRgZTkc+0XalfrOhyvJ57MQ3
	XsQgMY5HEoy/pJareYrSkGOtNfkUv0lIrv56fiFZEgp1qq3KE4zqXCTGzhg12DlC0CE/Z4CTUXqr2
	5uV+vlCBTpvxNZQyM5MHcie84SMcv7cdIVdPq/ZBISaVVzxddN+vXeQfOztvWoiKt7otOd5VzwIag
	5FpABrMj1TNd+/PGjkkHRE5cnyCs5nVxpLJR3szf5ZSEqL5sx1fCzHuEgja1eMX9sl1LHEF5PEG1G
	cVV6RtWg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sE-00000000zvk-1kTX;
	Wed, 17 Jul 2024 15:47:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 19/23] vboxsf: Use a folio in vboxsf_write_end()
Date: Wed, 17 Jul 2024 16:47:09 +0100
Message-ID: <20240717154716.237943-20-willy@infradead.org>
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

Because we have to kmap() the page before calling vboxsf_write(), we
can't entirely remove the use of struct page.  But we can eliminate some
uses of old APIs and remove some unnecessary calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/vboxsf/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index fdb4da24d662..029f106d56d9 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -302,16 +302,17 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
 			    loff_t pos, unsigned int len, unsigned int copied,
 			    struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct vboxsf_handle *sf_handle = file->private_data;
-	unsigned int from = pos & ~PAGE_MASK;
+	size_t from = offset_in_folio(folio, pos);
 	u32 nwritten = len;
 	u8 *buf;
 	int err;
 
-	/* zero the stale part of the page if we did a short copy */
-	if (!PageUptodate(page) && copied < len)
-		zero_user(page, from + copied, len - copied);
+	/* zero the stale part of the folio if we did a short copy */
+	if (!folio_test_uptodate(folio) && copied < len)
+		folio_zero_range(folio, from + copied, len - copied);
 
 	buf = kmap(page);
 	err = vboxsf_write(sf_handle->root, sf_handle->handle,
@@ -326,16 +327,16 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
 	/* mtime changed */
 	VBOXSF_I(inode)->force_restat = 1;
 
-	if (!PageUptodate(page) && nwritten == PAGE_SIZE)
-		SetPageUptodate(page);
+	if (!folio_test_uptodate(folio) && nwritten == folio_size(folio))
+		folio_mark_uptodate(folio);
 
 	pos += nwritten;
 	if (pos > inode->i_size)
 		i_size_write(inode, pos);
 
 out:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return nwritten;
 }
@@ -343,7 +344,7 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
 /*
  * Note simple_write_begin does not read the page from disk on partial writes
  * this is ok since vboxsf_write_end only writes the written parts of the
- * page and it does not call SetPageUptodate for partial writes.
+ * page and it does not call folio_mark_uptodate for partial writes.
  */
 const struct address_space_operations vboxsf_reg_aops = {
 	.read_folio = vboxsf_read_folio,
-- 
2.43.0


