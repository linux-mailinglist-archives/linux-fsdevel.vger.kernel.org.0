Return-Path: <linux-fsdevel+bounces-17345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D398AB8FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E41B221D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFA217C7B;
	Sat, 20 Apr 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GreEqp1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF99749F
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581463; cv=none; b=HCH7GIOK3vYAFlGrEWWSZl9HvReK+KUROcMfHwH6/kXr5gHnv3/U8imFwJzN+0uHUdT6WJOwTV5wEf3+jQxk3WVljlxMWnPQJLvLvOi1AsrXInv5KRERd/W4aC4pRzGVit7KiSVP3cvzxCtjYvL9sZa9IVgcCxLI805IgE1OsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581463; c=relaxed/simple;
	bh=7HzCLQSXn37UUZWfG5ccEbWidAJkw8qNX3ExDEFU1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjrLOPnK4mgVYRE1J3IGaQny/BnPUuFpfm/Mamw5JzsDnJiz/8BCX3MFnWm+iGKTIaYCvmmCwcOlYCHYGW5wTo56GasaN74A2hF9mSeorIoxWfqwtU245kz1EQDVyVzGUzom+8LCls4xnx6ZYS3+7qgDHF/73p8Nc+hSyB4KgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GreEqp1e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NqXmKbkf+s1gTN27JESMQN4qHz7HkPL9j1SqSG/y14M=; b=GreEqp1emdsLOnFLp8y7LUaYX+
	zzyqKbA104KPWpdzsBWpI+T5UTZAHrU0n49bmIc/jiMVWCEpwM+sw/0jC5Tty5v7wJWc+z5ukfcMZ
	t9Pyuo8/EG6WNoZ5HtoToUbOguFEYrCGMuVnF7IEnCyxQnW+PwPwZB0+iLOBqZRtn+bx03AEoFhaz
	YNC4K5qrAcaqPLvub8a7k8cnbQk55kXZpQZkzkpluRMHuA7akjOdz34oFQgN01FxPckzpIkL0/RVs
	39434OTrrf3KI2lEI1z4pk+39dGYqORix7wFqzZ09C2fWqz9a1V9QR5t4nq7VM1VWNLM+miYtdOfI
	Io5UTovg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oc-000000095gR-3sz1;
	Sat, 20 Apr 2024 02:50:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 23/30] squashfs: Remove calls to set the folio error flag
Date: Sat, 20 Apr 2024 03:50:18 +0100
Message-ID: <20240420025029.2166544-24-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag on squashfs folios, so stop setting it.

Cc: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c        | 6 +-----
 fs/squashfs/file_direct.c | 3 +--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index e8df6430444b..a8c1e7f9a609 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -375,8 +375,6 @@ void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer,
 	flush_dcache_page(page);
 	if (copied == avail)
 		SetPageUptodate(page);
-	else
-		SetPageError(page);
 }
 
 /* Copy data into page cache  */
@@ -471,7 +469,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 
 		res = read_blocklist(inode, index, &block);
 		if (res < 0)
-			goto error_out;
+			goto out;
 
 		if (res == 0)
 			res = squashfs_readpage_sparse(page, expected);
@@ -483,8 +481,6 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	if (!res)
 		return 0;
 
-error_out:
-	SetPageError(page);
 out:
 	pageaddr = kmap_atomic(page);
 	memset(pageaddr, 0, PAGE_SIZE);
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 763a3f7a75f6..2a689ce71de9 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -106,14 +106,13 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	return 0;
 
 mark_errored:
-	/* Decompression failed, mark pages as errored.  Target_page is
+	/* Decompression failed.  Target_page is
 	 * dealt with by the caller
 	 */
 	for (i = 0; i < pages; i++) {
 		if (page[i] == NULL || page[i] == target_page)
 			continue;
 		flush_dcache_page(page[i]);
-		SetPageError(page[i]);
 		unlock_page(page[i]);
 		put_page(page[i]);
 	}
-- 
2.43.0


