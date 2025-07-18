Return-Path: <linux-fsdevel+bounces-55473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D754CB0AACF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16648A464B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8DD217F26;
	Fri, 18 Jul 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gHtg3i6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120451DEFF5;
	Fri, 18 Jul 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868445; cv=none; b=ta+5D1UI6WPBQoOH+wwuAKdElb3R1JiYM/tKC2+hznJXJV9E3k5epZFd5fd0+x6J+kv7pCHFHFk5L4sw1GF9MjbdqYSbpGXcOKfpbDsNpV1j/yvgoo4tc0Cx4gQTwwGQZKugq9fMw+K7RmIRxqWehXHsaeW5Kq3Rf52B95ozSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868445; c=relaxed/simple;
	bh=/WHAFsx4WdqEewl7S0+e+oc7sxywSYhayC85RwqOQWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5CPhisMHPRGhkOXhmzNPSiDNkdHS6ntotw3US9mUXM4vZCqn0Q2MizaiM/OknD+n9KkhRsJNp9+uYjEnBNxOG1F+NQwfISjaFnJmcM9mAPQcwCQZlOjJs2zycP3i+Naza/NKRZJBwXDCeL+xVRYqk4c/KttLaWXC1A3ea0hyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gHtg3i6+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ApNnY7BCgQGWFFfXkBaHOXs8NdheDX54mQIM2uSOK6k=; b=gHtg3i6+Nm4DODDutm7HYav9sW
	M2Fy5wHwLcv+JbkUvm8+EfsUKtd34gCryI++Xwo2gwD5hU1oxGkXDw5My2pobc+u3BAfQ/aXhcgGb
	E4X0sHUJDQhWtdatQ/Qvha5m2JrEnI4CXW5sMAj2juw1dr2KtJidhcfFyjGOyYHv/4f+ZOIam+fgw
	SQBAHXUu+Jps9iH3rk4DrtMFoek457zVExVPt8JbCFOGerOdcjXlLhuwQeCWEOdaIGHpuE/JDBRrB
	CAQJmviRc7gorv0N/7xw5CxuWk3BER4FTfCBt0vJmntTle/+rTuMt7Li1s/ujNltNehkAJo+HdAP2
	1/Xa61bA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucr9e-00000008FTV-143D;
	Fri, 18 Jul 2025 19:54:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ntfs: Do not overwrite uptodate pages
Date: Fri, 18 Jul 2025 20:53:58 +0100
Message-ID: <20250718195400.1966070-4-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250718195400.1966070-1-willy@infradead.org>
References: <20250718195400.1966070-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading a compressed file, we may read several pages in addition to
the one requested.  The current code will overwrite pages in the page
cache with the data from disc which can definitely result in changes
that have been made being lost.

For example if we have four consecutie pages ABCD in the file compressed
into a single extent, on first access, we'll bring in ABCD.  Then we
write to page B.  Memory pressure results in the eviction of ACD.
When we attempt to write to page C, we will overwrite the data in page
B with the data currently on disk.

I haven't investigated the decompression code to check whether it's
OK to overwrite a clean page or whether it might be possible to see
corrupt data.  Out of an abundance of caution, decline to overwrite
uptodate pages, not just dirty pages.

Fixes: 4342306f0f0d (fs/ntfs3: Add file operations and implementation)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org
---
 fs/ntfs3/frecord.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 6fc7b2281fed..c3ce9cf4441e 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2020,6 +2020,29 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	return err;
 }
 
+static struct page *ntfs_lock_new_page(struct address_space *mapping,
+		pgoff_t index, gfp_t gfp)
+{
+	struct folio *folio = __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	struct page *page;
+
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
+
+	if (!folio_test_uptodate(folio))
+		return folio_file_page(folio, index);
+
+	/* Use a temporary page to avoid data corruption */
+	folio_unlock(folio);
+	folio_put(folio);
+	page = alloc_page(gfp);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+	__SetPageLocked(page);
+	return page;
+}
+
 /*
  * ni_readpage_cmpr
  *
@@ -2074,9 +2097,9 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct folio *folio)
 		if (i == idx)
 			continue;
 
-		pg = find_or_create_page(mapping, index, gfp_mask);
-		if (!pg) {
-			err = -ENOMEM;
+		pg = ntfs_lock_new_page(mapping, index, gfp_mask);
+		if (IS_ERR(pg)) {
+			err = PTR_ERR(pg);
 			goto out1;
 		}
 		pages[i] = pg;
@@ -2175,13 +2198,13 @@ int ni_decompress_file(struct ntfs_inode *ni)
 		for (i = 0; i < pages_per_frame; i++, index++) {
 			struct page *pg;
 
-			pg = find_or_create_page(mapping, index, gfp_mask);
-			if (!pg) {
+			pg = ntfs_lock_new_page(mapping, index, gfp_mask);
+			if (IS_ERR(pg)) {
 				while (i--) {
 					unlock_page(pages[i]);
 					put_page(pages[i]);
 				}
-				err = -ENOMEM;
+				err = PTR_ERR(pg);
 				goto out;
 			}
 			pages[i] = pg;
-- 
2.47.2


