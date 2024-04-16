Return-Path: <linux-fsdevel+bounces-17060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B98A7251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB24281947
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C942133422;
	Tue, 16 Apr 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDgcVT1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B11332A0;
	Tue, 16 Apr 2024 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288554; cv=none; b=bsXPKX3Y/S1/7iukcoYoa9NPmv/LT2UeSwJ6gm/HED/XKTT5f3V3jmEMzos04oMA+Um+5u6UaYZ0R97v12Yn7A97lKtu6bvXaI5WFVrS6KgQ4u2s+pHvVXc5KXJs80HjI8NJmhjQ2NI+Pvh2NJGeJA5uvZkNzjioBFxp4kealBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288554; c=relaxed/simple;
	bh=g+xhBk5j+jN5yiaJw1jundymCmwOEqKML06eqAAdW14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUCjHrmTSNpsR8FsXrpGMulROoCgEK2Wj9eLfvJeSdhcgcKNJ7MW4twpofp3/OqjesgdWxVAqF+uQDKodzmrziemXsJEaMkSoXPDIrujpE6v+4Y7TeaTjurdLG8j1PjSBXXvfb41t9HeJyQagwWXkICszasPIkuH40hlTWT9rWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SDgcVT1k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0qHKz2X3kzYT7/i5QHOS8lY+ZKNNvvsFaCovVPQI96k=; b=SDgcVT1kPvDn4cuJN4fEAEXhVH
	czFKcTfHOY+UsTPVLcYwzaTq7XsrRh4nWr7tADF7+cyP8geENnPQKK2USMxphcMHfq/UewH5L7/aG
	Q2jcrUJnZi/Fy0A9LAU5ixY5bjlxx9xaJpgs7rM8Md9YwVX2XCMz2Hd+wE/HuMJ/0IO52PKOIJisk
	5ZfXb+lgM5s6pSBJa7OQLCsxgg6VmEiJw5wDtSkSmxmifpWGw68r1wlU4xEU8GEZCVfVtyJwwDnCU
	Kr5AEvZPya2XOtTIzaFXJGjF7hDvHFsyEHh/wjqD8bKzq5UdZkExXC2JGFlrh0NXd7mR8LouwGnWb
	w5HkpH2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwmcE-000000011eV-3x9c;
	Tue, 16 Apr 2024 17:29:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] ext4: Convert ext4_mb_init_cache() to take a folio
Date: Tue, 16 Apr 2024 18:28:56 +0100
Message-ID: <20240416172900.244637-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416172900.244637-1-willy@infradead.org>
References: <20240416172900.244637-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers now have a folio, so convert this function from operating on
a page to operating on a folio.  The folio is assumed to be a single page.

Signe-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/mballoc.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 761d8d15b205..50bdf3646d45 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1270,7 +1270,7 @@ static void mb_regenerate_buddy(struct ext4_buddy *e4b)
  * for this page; do not hold this lock when calling this routine!
  */
 
-static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
+static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 {
 	ext4_group_t ngroups;
 	unsigned int blocksize;
@@ -1288,13 +1288,13 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 	char *bitmap;
 	struct ext4_group_info *grinfo;
 
-	inode = page->mapping->host;
+	inode = folio->mapping->host;
 	sb = inode->i_sb;
 	ngroups = ext4_get_groups_count(sb);
 	blocksize = i_blocksize(inode);
 	blocks_per_page = PAGE_SIZE / blocksize;
 
-	mb_debug(sb, "init page %lu\n", page->index);
+	mb_debug(sb, "init folio %lu\n", folio->index);
 
 	groups_per_page = blocks_per_page >> 1;
 	if (groups_per_page == 0)
@@ -1309,9 +1309,9 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 	} else
 		bh = &bhs;
 
-	first_group = page->index * blocks_per_page / 2;
+	first_group = folio->index * blocks_per_page / 2;
 
-	/* read all groups the page covers into the cache */
+	/* read all groups the folio covers into the cache */
 	for (i = 0, group = first_group; i < groups_per_page; i++, group++) {
 		if (group >= ngroups)
 			break;
@@ -1322,10 +1322,11 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		/*
 		 * If page is uptodate then we came here after online resize
 		 * which added some new uninitialized group info structs, so
-		 * we must skip all initialized uptodate buddies on the page,
+		 * we must skip all initialized uptodate buddies on the folio,
 		 * which may be currently in use by an allocating task.
 		 */
-		if (PageUptodate(page) && !EXT4_MB_GRP_NEED_INIT(grinfo)) {
+		if (folio_test_uptodate(folio) &&
+				!EXT4_MB_GRP_NEED_INIT(grinfo)) {
 			bh[i] = NULL;
 			continue;
 		}
@@ -1349,7 +1350,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			err = err2;
 	}
 
-	first_block = page->index * blocks_per_page;
+	first_block = folio->index * blocks_per_page;
 	for (i = 0; i < blocks_per_page; i++) {
 		group = (first_block + i) >> 1;
 		if (group >= ngroups)
@@ -1370,7 +1371,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		 * above
 		 *
 		 */
-		data = page_address(page) + (i * blocksize);
+		data = folio_address(folio) + (i * blocksize);
 		bitmap = bh[group - first_group]->b_data;
 
 		/*
@@ -1385,8 +1386,8 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		if ((first_block + i) & 1) {
 			/* this is block of buddy */
 			BUG_ON(incore == NULL);
-			mb_debug(sb, "put buddy for group %u in page %lu/%x\n",
-				group, page->index, i * blocksize);
+			mb_debug(sb, "put buddy for group %u in folio %lu/%x\n",
+				group, folio->index, i * blocksize);
 			trace_ext4_mb_buddy_bitmap_load(sb, group);
 			grinfo->bb_fragments = 0;
 			memset(grinfo->bb_counters, 0,
@@ -1404,8 +1405,8 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		} else {
 			/* this is block of bitmap */
 			BUG_ON(incore != NULL);
-			mb_debug(sb, "put bitmap for group %u in page %lu/%x\n",
-				group, page->index, i * blocksize);
+			mb_debug(sb, "put bitmap for group %u in folio %lu/%x\n",
+				group, folio->index, i * blocksize);
 			trace_ext4_mb_bitmap_load(sb, group);
 
 			/* see comments in ext4_mb_put_pa() */
@@ -1423,7 +1424,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			incore = data;
 		}
 	}
-	SetPageUptodate(page);
+	folio_mark_uptodate(folio);
 
 out:
 	if (bh) {
@@ -1535,7 +1536,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	}
 
 	folio = e4b.bd_bitmap_folio;
-	ret = ext4_mb_init_cache(&folio->page, NULL, gfp);
+	ret = ext4_mb_init_cache(folio, NULL, gfp);
 	if (ret)
 		goto err;
 	if (!folio_test_uptodate(folio)) {
@@ -1554,7 +1555,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	}
 	/* init buddy cache */
 	folio = e4b.bd_buddy_folio;
-	ret = ext4_mb_init_cache(&folio->page, e4b.bd_bitmap, gfp);
+	ret = ext4_mb_init_cache(folio, e4b.bd_bitmap, gfp);
 	if (ret)
 		goto err;
 	if (!folio_test_uptodate(folio)) {
@@ -1643,7 +1644,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 				goto err;
 			}
 			if (!folio_test_uptodate(folio)) {
-				ret = ext4_mb_init_cache(&folio->page, NULL, gfp);
+				ret = ext4_mb_init_cache(folio, NULL, gfp);
 				if (ret) {
 					folio_unlock(folio);
 					goto err;
@@ -1686,7 +1687,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 				goto err;
 			}
 			if (!folio_test_uptodate(folio)) {
-				ret = ext4_mb_init_cache(&folio->page, e4b->bd_bitmap,
+				ret = ext4_mb_init_cache(folio, e4b->bd_bitmap,
 							 gfp);
 				if (ret) {
 					folio_unlock(folio);
-- 
2.43.0


