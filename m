Return-Path: <linux-fsdevel+bounces-48988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12286AB724F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F2E7ABEE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3027CCE7;
	Wed, 14 May 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mBKt8ER4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0927C173;
	Wed, 14 May 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242381; cv=none; b=bVlCM3sNnphpTv5kVLb6Vyunr8MgZd8e3ZAlRhyPafdWNJj0cA7W+pXbUflXzSxjDS9fLCHOHabDRK2+QFPOc1dMYWs4g7y/3/E3DxUlMir7plrSzsZQfZb/TY1CxS+/BuIQ1LxCc5R6ldIFzacz+VkeTwnB7Kp7Pv7fII2cqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242381; c=relaxed/simple;
	bh=9VZojGIxJQRgdmpOhuLKg/E2/RlZOsj/kKtjcVee1b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GS6lVazIqj1O4bjyjPrXu5rI+M5pZgxSRVZAoPaz0nVWhjLFYfXHmULH1+Q6+kzAmt1PzOHaKdFVe3l5qZ2pNzxHBYiLzA0vStwggqj7frXM+rVI7o4zErdp+zqE0IEHE6lJBJa51j5RqFQiN+ZWqcQ57gqrW3skvphnYtqnuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mBKt8ER4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0ObYEzeGaSZX4ivCXibNuorLDdF24fdziBtN69sHkFw=; b=mBKt8ER4Ztw4U6DWrV3z0UZ8aF
	ugEbly/LvVcAn2zZJ0M9NuBNzOO42aVchXrLt+0ojuOA7Z08d3KijzC4WVgRUJPdc3VPX1QerQdVm
	BgGtE+VKa29iil9xL1lM4aXF1GNfFAZZDApIeUfqNf2FMBbpK3gvwYY9+YWuWzztJzj09G5AaYnWG
	gXstThby14wNQOCP+0PBjs6B2qavaQgJi8MLEvWGXrf4HxAtGGmQVAn0pr5tv6lc/ltCUIHNJJQi6
	C5owuwbXzfnnQ2mq/EmEVSd/0bSPlHiXzsYeY922xT9rARGQX04mZZFge8N9bJYpdBzkMHf6lx1nG
	geeGXCDg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFFYW-0000000CahT-31eh;
	Wed, 14 May 2025 17:06:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 2/3] ntfs3: Use folios more in ntfs_compress_write()
Date: Wed, 14 May 2025 18:06:03 +0100
Message-ID: <20250514170607.3000994-3-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514170607.3000994-1-willy@infradead.org>
References: <20250514170607.3000994-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the local 'page' variable and do everything in terms of folios.
Removes the last user of copy_page_from_iter_atomic() and a hidden
call to compound_head() in ClearPageDirty().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/file.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 9b6a3f8d2e7c..bc6062e0668e 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -998,7 +998,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 valid = ni->i_valid;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
-	struct page *page, **pages = NULL;
+	struct page **pages = NULL;
+	struct folio *folio;
 	size_t written = 0;
 	u8 frame_bits = NTFS_LZNT_CUNIT + sbi->cluster_bits;
 	u32 frame_size = 1u << frame_bits;
@@ -1008,7 +1009,6 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	u64 frame_vbo;
 	pgoff_t index;
 	bool frame_uptodate;
-	struct folio *folio;
 
 	if (frame_size < PAGE_SIZE) {
 		/*
@@ -1062,8 +1062,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 					    pages_per_frame);
 			if (err) {
 				for (ip = 0; ip < pages_per_frame; ip++) {
-					page = pages[ip];
-					folio = page_folio(page);
+					folio = page_folio(pages[ip]);
 					folio_unlock(folio);
 					folio_put(folio);
 				}
@@ -1074,10 +1073,9 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		ip = off >> PAGE_SHIFT;
 		off = offset_in_page(valid);
 		for (; ip < pages_per_frame; ip++, off = 0) {
-			page = pages[ip];
-			folio = page_folio(page);
-			zero_user_segment(page, off, PAGE_SIZE);
-			flush_dcache_page(page);
+			folio = page_folio(pages[ip]);
+			folio_zero_segment(folio, off, PAGE_SIZE);
+			flush_dcache_folio(folio);
 			folio_mark_uptodate(folio);
 		}
 
@@ -1086,8 +1084,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		ni_unlock(ni);
 
 		for (ip = 0; ip < pages_per_frame; ip++) {
-			page = pages[ip];
-			folio = page_folio(page);
+			folio = page_folio(pages[ip]);
 			folio_mark_uptodate(folio);
 			folio_unlock(folio);
 			folio_put(folio);
@@ -1131,8 +1128,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 				if (err) {
 					for (ip = 0; ip < pages_per_frame;
 					     ip++) {
-						page = pages[ip];
-						folio = page_folio(page);
+						folio = page_folio(pages[ip]);
 						folio_unlock(folio);
 						folio_put(folio);
 					}
@@ -1150,10 +1146,10 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		for (;;) {
 			size_t cp, tail = PAGE_SIZE - off;
 
-			page = pages[ip];
-			cp = copy_page_from_iter_atomic(page, off,
+			folio = page_folio(pages[ip]);
+			cp = copy_folio_from_iter_atomic(folio, off,
 							min(tail, bytes), from);
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
 			copied += cp;
 			bytes -= cp;
@@ -1173,9 +1169,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		ni_unlock(ni);
 
 		for (ip = 0; ip < pages_per_frame; ip++) {
-			page = pages[ip];
-			ClearPageDirty(page);
-			folio = page_folio(page);
+			folio = page_folio(pages[ip]);
+			folio_clear_dirty(folio);
 			folio_mark_uptodate(folio);
 			folio_unlock(folio);
 			folio_put(folio);
-- 
2.47.2


