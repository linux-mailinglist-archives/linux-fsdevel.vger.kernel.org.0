Return-Path: <linux-fsdevel+bounces-17426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C48AD4E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5E51C214F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20074155388;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lsED3wSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBC155336;
	Mon, 22 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814330; cv=none; b=k2B+FKVp8INOHPOWwTvD/yqfGpjg4neldCuquKrO4EwH9PoLeLk9FCQewBMiLJYoo6ACHhhvOCopGGcqnv/a3N9CZ0YmwQfbvw0HvwPNovYxxdZJOcm29Sj555sbIOlyxnop9xCG8UBkolkJ3TCZtWMT+SJkvuEdZ/VH2C9+1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814330; c=relaxed/simple;
	bh=lESpPvk5enNXOw39cgNoRM8fG/IcOuaqmOi+vaI3hnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2NJ40Qjh9ZqrcckkVDmXgxuvSq9av4DYXTiaiVUYBtNqVwKOH/Yh69rc6dayCa/SwdVBFP8asLEUIs0VKnrwMIrBuq7qEdRw+W0WF1lSrk4Ed5QRfBJx8iERVHluFz2EywqoyddRh2F98v1Vz6vzrh4fJsHE4lWN6aatEgOhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lsED3wSO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9c0Y84/1MmmK3Hj02j9ZeCOdjd0HyunQX9phSias8jQ=; b=lsED3wSOF6grGLCjU2CxzsM568
	YCTI9dARTWjNoHZ/tJ59OJlHanh494JjQByLl5DH6og6V2zXkMqzaauuCXRX/aYqAvAdDWcUN7t1P
	Cbq87796lMIR9lgQwHmffLOL6o37tQSqoG6XicEknYHilxzHoTX265GDFpNMybKhvprz2zCz6cKc5
	oLthdoTSo7x2PT23Cmd2yYDbP3C54upapgbKf6xw1H8aXieL6YB93OOaUo9B9MkmLXQsqI4PaC8dV
	Usw4gLs+1Lv7nxIau5bxTnml4CZmaTYlVme79z1FEzD8VOAfh6EHX5GH6wi+I45NfykV31QhfRzA7
	3tjp0PdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpOd-2zav;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/11] ntfs3: Convert inode_read_data() to use folios
Date: Mon, 22 Apr 2024 20:31:57 +0100
Message-ID: <20240422193203.3534108-8-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
References: <20240422193203.3534108-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is now large folio safe, although we're not enabling
large folios yet.  It does eliminate a use of kmap().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 69dd51d7cf83..4791a002500b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1103,25 +1103,23 @@ int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
  */
 int inode_read_data(struct inode *inode, void *data, size_t bytes)
 {
-	pgoff_t idx;
+	pgoff_t idx = 0;
 	struct address_space *mapping = inode->i_mapping;
 
-	for (idx = 0; bytes; idx++) {
-		size_t op = bytes > PAGE_SIZE ? PAGE_SIZE : bytes;
-		struct page *page = read_mapping_page(mapping, idx, NULL);
-		void *kaddr;
+	while (bytes) {
+		struct folio *folio = read_mapping_folio(mapping, idx, NULL);
+		size_t nr;
 
-		if (IS_ERR(page))
-			return PTR_ERR(page);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		kaddr = kmap_atomic(page);
-		memcpy(data, kaddr, op);
-		kunmap_atomic(kaddr);
-
-		put_page(page);
+		nr = min(bytes, folio_size(folio));
+		memcpy_from_folio(data, folio, 0, nr);
+		data += folio_size(folio);
+		idx += folio_nr_pages(folio);
+		folio_put(folio);
 
-		bytes -= op;
-		data = Add2Ptr(data, PAGE_SIZE);
+		bytes -= nr;
 	}
 	return 0;
 }
-- 
2.43.0


