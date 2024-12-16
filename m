Return-Path: <linux-fsdevel+bounces-37508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B25329F35F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2A67A12BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED91920127A;
	Mon, 16 Dec 2024 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lc3tibBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442977E59A;
	Mon, 16 Dec 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366428; cv=none; b=sjDv7/M6PcNtkMtBszXZjh8SGlYDPe4OY1ErQlQ6Y/yG3OkHX72jM2nsSx99jFMtEMnI0RpT5/G2cUrNuT4HpFfsfgNaVaAjMxFPoL39COKChiBR2fiGco1w46Ht6dad1zJcQXbmfNFRYIr1Y3mirlBDPw40C6WrSrxLaQJDxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366428; c=relaxed/simple;
	bh=AGkB8W8DLcSs6Ao95S1Eu/OTLNLQiDpinLiAz2rZCQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtwcdRkXcrt29HLFech/W4jKX9BDfKEYy2B+q1CA/KbVdhWZsW96yafISIpn2WUjRBUnbqNgKx6otmO3NtWup+fz/zKojUTxUXdh1p7SMQK/tp/5a4AC2gK52Su2yU0UyAXnss1xaX7De84AaHDVAX/ynGiQiwJXToAjHLDxCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lc3tibBp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VPTyDxUHivha6vOfKSiWFl06XFZgbVdwCU6/eNtqKN4=; b=Lc3tibBpW1UW49d2XMpimwGnes
	CannalWtmj3JSZXr2sQajB4R+Oq5xsxzUkSxGNkNprVh/y3Qx4pHgypZiakr9Q0IWWXxF6c/sXjKh
	n14H967WfKO4PistaRZk1ctE2vq773Sv8q7NAnIFGsryfoMel6XY7flrL2ZR04tUBBi41/ZHEML1Y
	GxaPLcNVpV8JdiIu+KydK67ztam7lirenDvLf8fr4H3lUNl8JJIyMLJxooWluYFHU9W+GcskjaOBd
	CyCTRE/wJpjApy5fVUDgFlqyXi/pdkrZN2mQs1lynMwuPV8smd10nS3TjjgVlHEPnzZOB32N0JwKC
	PYACMDqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDw0-00000000EzA-29FW;
	Mon, 16 Dec 2024 16:27:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] squashfs: Convert squashfs_fill_page() to take a folio
Date: Mon, 16 Dec 2024 16:26:59 +0000
Message-ID: <20241216162701.57549-5-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216162701.57549-1-willy@infradead.org>
References: <20241216162701.57549-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

squashfs_fill_page is only used in this file, so make it static.
Use kmap_local instead of kmap_atomic, and return a bool so that
the caller can use folio_end_read() which saves an atomic operation
over calling folio_mark_uptodate() followed by folio_unlock().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c     | 21 ++++++++++++---------
 fs/squashfs/squashfs.h |  1 -
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 1f27e8161319..d363fb26c2c8 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -362,19 +362,21 @@ static int read_blocklist(struct inode *inode, int index, u64 *block)
 	return squashfs_block_size(size);
 }
 
-void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer, int offset, int avail)
+static bool squashfs_fill_page(struct folio *folio,
+		struct squashfs_cache_entry *buffer, size_t offset,
+		size_t avail)
 {
-	int copied;
+	size_t copied;
 	void *pageaddr;
 
-	pageaddr = kmap_atomic(page);
+	pageaddr = kmap_local_folio(folio, 0);
 	copied = squashfs_copy_data(pageaddr, buffer, offset, avail);
 	memset(pageaddr + copied, 0, PAGE_SIZE - copied);
-	kunmap_atomic(pageaddr);
+	kunmap_local(pageaddr);
 
-	flush_dcache_page(page);
-	if (copied == avail)
-		SetPageUptodate(page);
+	flush_dcache_folio(folio);
+
+	return copied == avail;
 }
 
 /* Copy data into page cache  */
@@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
 			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
 		struct folio *push_folio;
 		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
+		bool filled = false;
 
 		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
 
@@ -412,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
 		if (folio_test_uptodate(push_folio))
 			goto skip_folio;
 
-		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
+		filled = squashfs_fill_page(push_folio, buffer, offset, avail);
 skip_folio:
-		folio_unlock(push_folio);
+		folio_end_read(folio, filled);
 		if (i != folio->index)
 			folio_put(push_folio);
 	}
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 9295556ecfd0..37f3518a804a 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -67,7 +67,6 @@ extern __le64 *squashfs_read_fragment_index_table(struct super_block *,
 				u64, u64, unsigned int);
 
 /* file.c */
-void squashfs_fill_page(struct page *, struct squashfs_cache_entry *, int, int);
 void squashfs_copy_cache(struct folio *, struct squashfs_cache_entry *,
 		size_t bytes, size_t offset);
 
-- 
2.45.2


