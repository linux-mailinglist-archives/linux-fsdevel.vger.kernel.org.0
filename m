Return-Path: <linux-fsdevel+bounces-17428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6119F8AD4E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939981C214A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24E1553B4;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUfPNm9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88618155338;
	Mon, 22 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814331; cv=none; b=SBgGhB8qw62/QM9dPK5gtlFAbeYmkouxI4uoLidQ0aeoTG91V0258tE474CFJPMPG12DbVuXn57ivztz5Ai1WEkW8ZkMkEOeSh9mWtuj4PCSbZfo9WogtYGy3vdTWsG5xQeAOsKQEysNu8iHHxBYFF1IW8+j+NK3IWL52co7dJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814331; c=relaxed/simple;
	bh=un/rh+jaMg2zCOO3wQpQ/Sq3RjFUSnYK1x53j/PaT40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR8o6QZ6ZzqTdOzloQJq5fo1/kfn+yIZq3RpzCo0HmEGF6T6dAyQpV4Z35IjYA7S7BV78MAel4h6uo0Aj2w22aqVFN6umNUGNX7SP2oejYvI8FzitBv94Ex6MRRCtczvMVV7VNr5sFuvtpa4mFKVNgPGGoA3/A8kHfCOuMUqzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dUfPNm9w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Gose6lUnx3CFNSZPBuOPgtsBFwb0Mxan46iPwqLycDE=; b=dUfPNm9wOg53t5UlTzINa5VhEP
	YcN/Rcq6GIO3B1vlDWwkWl3hGglRF7zkRPMpHPCMQyB6WKbQfrW8FsivgxGrs75DVejfAUOQPP7jV
	kjzncZ8s7dRbp04bVpX2xaQSHncZ5DULBab+A28OphqE7Oxhv3HxLgziCvbJognjOR40+pP5cfYyC
	ch3xvBnctg/48DN62D9Hn+SxkE7H9yYAg2wJigpPFFxe7USECaPVBOLImEwmLw/FsDv8KUdY0ymse
	JIsRqP2a4bf2hD12sApSgEzTKieT+fgOoytHvjKVNfdxFeSbXFprDpL8oW/392mApB/kbYwmA4yKt
	VhA3GWfA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpOp-3um5;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/11] ntfs3: Convert attr_wof_frame_info() to use a folio
Date: Mon, 22 Apr 2024 20:31:59 +0100
Message-ID: <20240422193203.3534108-10-willy@infradead.org>
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

This involves converting all users of offs_page to offs_folio, but
it's worth it because we get rid of a lot of hidden calls to
compound_head().  We continue to use order-0 folios here, and convert
back to a struct page to call ntfs_bio_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/attrib.c  | 29 +++++++++++++++--------------
 fs/ntfs3/frecord.c | 12 ++++++------
 fs/ntfs3/ntfs_fs.h |  2 +-
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index d253840c26cf..9ea19c834dff 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1380,7 +1380,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 	u32 voff;
 	u8 bytes_per_off;
 	char *addr;
-	struct page *page;
+	struct folio *folio;
 	int i, err;
 	__le32 *off32;
 	__le64 *off64;
@@ -1425,18 +1425,18 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 
 	wof_size = le64_to_cpu(attr->nres.data_size);
 	down_write(&ni->file.run_lock);
-	page = ni->file.offs_page;
-	if (!page) {
-		page = alloc_page(GFP_KERNEL);
-		if (!page) {
+	folio = ni->file.offs_folio;
+	if (!folio) {
+		folio = folio_alloc(GFP_KERNEL, 0);
+		if (!folio) {
 			err = -ENOMEM;
 			goto out;
 		}
-		page->index = -1;
-		ni->file.offs_page = page;
+		folio->index = -1;
+		ni->file.offs_folio = folio;
 	}
-	lock_page(page);
-	addr = page_address(page);
+	folio_lock(folio);
+	addr = folio_address(folio);
 
 	if (vbo[1]) {
 		voff = vbo[1] & (PAGE_SIZE - 1);
@@ -1452,7 +1452,8 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 	do {
 		pgoff_t index = vbo[i] >> PAGE_SHIFT;
 
-		if (index != page->index) {
+		if (index != folio->index) {
+			struct page *page = &folio->page;
 			u64 from = vbo[i] & ~(u64)(PAGE_SIZE - 1);
 			u64 to = min(from + PAGE_SIZE, wof_size);
 
@@ -1465,10 +1466,10 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 			err = ntfs_bio_pages(sbi, run, &page, 1, from,
 					     to - from, REQ_OP_READ);
 			if (err) {
-				page->index = -1;
+				folio->index = -1;
 				goto out1;
 			}
-			page->index = index;
+			folio->index = index;
 		}
 
 		if (i) {
@@ -1506,7 +1507,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 	*ondisk_size = off[1] - off[0];
 
 out1:
-	unlock_page(page);
+	folio_unlock(folio);
 out:
 	up_write(&ni->file.run_lock);
 	return err;
@@ -2645,4 +2646,4 @@ bool attr_check(const struct ATTRIB *attr, struct ntfs_sb_info *sbi,
 
 	ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 	return false;
-}
\ No newline at end of file
+}
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 04a7509c749a..b9b3f1bf1bc4 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -122,10 +122,10 @@ void ni_clear(struct ntfs_inode *ni)
 	else {
 		run_close(&ni->file.run);
 #ifdef CONFIG_NTFS3_LZX_XPRESS
-		if (ni->file.offs_page) {
+		if (ni->file.offs_folio) {
 			/* On-demand allocated page for offsets. */
-			put_page(ni->file.offs_page);
-			ni->file.offs_page = NULL;
+			folio_put(ni->file.offs_folio);
+			ni->file.offs_folio = NULL;
 		}
 #endif
 	}
@@ -2359,9 +2359,9 @@ int ni_decompress_file(struct ntfs_inode *ni)
 
 	/* Clear cached flag. */
 	ni->ni_flags &= ~NI_FLAG_COMPRESSED_MASK;
-	if (ni->file.offs_page) {
-		put_page(ni->file.offs_page);
-		ni->file.offs_page = NULL;
+	if (ni->file.offs_folio) {
+		folio_put(ni->file.offs_folio);
+		ni->file.offs_folio = NULL;
 	}
 	mapping->a_ops = &ntfs_aops;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 275def366443..fbd14776bd28 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -394,7 +394,7 @@ struct ntfs_inode {
 			struct rw_semaphore run_lock;
 			struct runs_tree run;
 #ifdef CONFIG_NTFS3_LZX_XPRESS
-			struct page *offs_page;
+			struct folio *offs_folio;
 #endif
 		} file;
 	};
-- 
2.43.0


