Return-Path: <linux-fsdevel+bounces-17430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927448AD4E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5FA28394B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F191553B5;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ee7aJteb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD111155339;
	Mon, 22 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814331; cv=none; b=QHAbt6H7Zw39ymHVPvv4PkbKc/DQszw3/ewcj90VIycPNDNRqYrJMsfKDgjkS25OuAVH/5rUwyWu58az0Yqaq+QA+ip+Cykz+Yc56iKiHlG5s2LFZFrBNV5eNDnkx3yzqVRVKyJcwkGz1NHum397lweax+0Lpsv3hUaFRDYInk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814331; c=relaxed/simple;
	bh=LpZc72gzqE/Pv0ySlYm5ZvuYOTORD1siYYa8+QQwGGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgyTlI9yiYHmC/eVOednC01sJaUoszVTb24z61GoRxHbqihdqsI8PfLa5jOJ3jyqetJuIJll/xwTnAAIU4oJ2sYsS6SQa2icWOr6Xn4BJzZDHNQaBOAIlu9kD8MvbhYNsfx8wdc63hzwxmgVTonumYlHVdCYp9yg1U61fkrLHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ee7aJteb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=awc5S9zitEVRfBIVdnQPa9cbPN2/bjCfocFocfbIYXM=; b=ee7aJtebYNTdZtG9Ms6bpPAYGZ
	2tAZ0gSYMm74xYOD9JbRvAWcSXfibUb1wReLuDEbF799EqW6i16diJth/NdL2k5PMnnup4UJq721y
	FI7pmf3XCUPFetDdg8zUElQ3MR6rSvwRRkmE9TEw5cvVB1hVeNwwIICbwxdy57UAsdOwir6z82eI6
	RmqKoa+j32CH0lfFbbRfEGYAzfVp93eA7CiRdZZG3PP/2rltevyqHvTXOQykNv0dn3hG5k8Jsp8Ri
	NY2r410UZFuhmf+gzSBMM3AW97jHbVSmBxpPphN7/BjbO9qDdmgdiHVQP2bpBJ6h0JAgnjkwBJRiM
	7ZwzDM/g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOa-0000000EpP1-0sNJ;
	Mon, 22 Apr 2024 19:32:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/11] ntfs3: Convert ni_readpage_cmpr() to take a folio
Date: Mon, 22 Apr 2024 20:32:01 +0100
Message-ID: <20240422193203.3534108-12-willy@infradead.org>
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

We still use an array of pages for the decompression, but this removes
a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/frecord.c | 13 +++++++------
 fs/ntfs3/inode.c   |  2 +-
 fs/ntfs3/ntfs_fs.h |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b9b3f1bf1bc4..8b1139fd5359 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2085,12 +2085,12 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
  * When decompressing, we typically obtain more than one page per reference.
  * We inject the additional pages into the page cache.
  */
-int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
+int ni_readpage_cmpr(struct ntfs_inode *ni, struct folio *folio)
 {
 	int err;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
-	struct address_space *mapping = page->mapping;
-	pgoff_t index = page->index;
+	struct address_space *mapping = folio->mapping;
+	pgoff_t index = folio->index;
 	u64 frame_vbo, vbo = (u64)index << PAGE_SHIFT;
 	struct page **pages = NULL; /* Array of at most 16 pages. stack? */
 	u8 frame_bits;
@@ -2100,7 +2100,8 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	struct page *pg;
 
 	if (vbo >= i_size_read(&ni->vfs_inode)) {
-		SetPageUptodate(page);
+		folio_zero_range(folio, 0, folio_size(folio));
+		folio_mark_uptodate(folio);
 		err = 0;
 		goto out;
 	}
@@ -2124,7 +2125,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 		goto out;
 	}
 
-	pages[idx] = page;
+	pages[idx] = &folio->page;
 	index = frame_vbo >> PAGE_SHIFT;
 	gfp_mask = mapping_gfp_mask(mapping);
 
@@ -2154,7 +2155,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 out:
 	/* At this point, err contains 0 or -EIO depending on the "critical" page. */
 	kfree(pages);
-	unlock_page(page);
+	folio_unlock(folio);
 
 	return err;
 }
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 4791a002500b..ef32be41b860 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -727,7 +727,7 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 
 	if (is_compressed(ni)) {
 		ni_lock(ni);
-		err = ni_readpage_cmpr(ni, &folio->page);
+		err = ni_readpage_cmpr(ni, folio);
 		ni_unlock(ni);
 		return err;
 	}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index fbd14776bd28..3b50c4357a46 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -577,7 +577,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint);
 #define _ni_write_inode(i, w) ni_write_inode(i, w, __func__)
 int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len);
-int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page);
+int ni_readpage_cmpr(struct ntfs_inode *ni, struct folio *folio);
 int ni_decompress_file(struct ntfs_inode *ni);
 int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		  u32 pages_per_frame);
-- 
2.43.0


