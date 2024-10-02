Return-Path: <linux-fsdevel+bounces-30719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B498DE35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8761C23A2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E6567D;
	Wed,  2 Oct 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZbvmhtxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AD1D0DD0;
	Wed,  2 Oct 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881255; cv=none; b=uzW3mK0eFMyjsp+wNYo4YsOU1MmH50wUSG91Xi3+ITQIwNx+V0PzUczKsw1mL8dbsqexm53SBY9yH4DNkQf4U3MqwrhYdIRt3ih3R644GcIX4mH8uFBw31FC124J4ySlZKBZtHwOKsWmyCscKkC10MgpBU2xrugbbJTEWrszhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881255; c=relaxed/simple;
	bh=JAR2O8Nw6RSpnDpnDzCBuC+IA99gjgpHcrFqm+KZUpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JReegRHRWUzbR5k7LO9SC7kL2FwTCTGoa/f8ZCepdiLQJHCVJWU2/3x/Ktjv0gFNFlmIDKhWVZGImMZSzxRzcmYxiFqOm6Jxb6ATmi6D2nNfU52mfuTI7iEo+pSajv/iYTs7dEs870/lp8CTEI/NY5ioM+0oezlAivacOQc0ZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZbvmhtxO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tLi2ExInWqFu7Rxgxh74FAPUwKB/d58VQE943Or3afI=; b=ZbvmhtxOrswcow64rYE31AlHZW
	hMLLgntSPHGUy4ORZozihFa80cGIF0tCUub3j1xva0HgKj2xBzd7A/ppJahk0qzm4G1OLrcOkoE+/
	lgWgoSMcNKHobixU4v+crUQagQk9klG8y0zltCZFcNg87BTQ7/IbWJOd/WG9ZhSlaXXmTOolBW9rO
	JubkkJ8unvOVN7ry+LzsqNsxDXOs604fdSOYt43G5zlmP3YYm/tHuv04ZQgE0G8RPy9CHpHgz/Ywu
	99FVzJe1yNdjQZBl7JLcPcDrXvzlD4OETMJeAmw8coHB845pxEg2jDBub1/xrXN7/zO65DC8K6tt7
	d0CqwBXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0qD-00000005cSk-2M2J;
	Wed, 02 Oct 2024 15:00:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org
Subject: [PATCH 2/4] nilfs2: Convert nilfs_page_count_clean_buffers() to take a folio
Date: Wed,  2 Oct 2024 16:00:32 +0100
Message-ID: <20241002150036.1339475-3-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002150036.1339475-1-willy@infradead.org>
References: <20241002150036.1339475-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers have a folio, so pass it in and use it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c   | 2 +-
 fs/nilfs2/inode.c | 2 +-
 fs/nilfs2/page.c  | 4 ++--
 fs/nilfs2/page.h  | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index fe5b1a30c509..b1ad4062bbab 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -95,7 +95,7 @@ static void nilfs_commit_chunk(struct folio *folio,
 	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, from, to);
+	nr_dirty = nilfs_page_count_clean_buffers(folio, from, to);
 	copied = block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 	if (pos + copied > dir->i_size)
 		i_size_write(dir, pos + copied);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index f1b47b655672..005dfd1f8fec 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -242,7 +242,7 @@ static int nilfs_write_end(struct file *file, struct address_space *mapping,
 	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, start,
+	nr_dirty = nilfs_page_count_clean_buffers(folio, start,
 						  start + copied);
 	copied = generic_write_end(file, mapping, pos, len, copied, folio,
 				   fsdata);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 16bb82cdbc07..ebd395dd131b 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -419,14 +419,14 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 	__nilfs_clear_folio_dirty(folio);
 }
 
-unsigned int nilfs_page_count_clean_buffers(struct page *page,
+unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
 					    unsigned int from, unsigned int to)
 {
 	unsigned int block_start, block_end;
 	struct buffer_head *bh, *head;
 	unsigned int nc = 0;
 
-	for (bh = head = page_buffers(page), block_start = 0;
+	for (bh = head = folio_buffers(folio), block_start = 0;
 	     bh != head || !block_start;
 	     block_start = block_end, bh = bh->b_this_page) {
 		block_end = block_start + bh->b_size;
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 64521a03a19e..b6d9301f16ae 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -43,8 +43,8 @@ int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
 void nilfs_clear_folio_dirty(struct folio *folio);
 void nilfs_clear_dirty_pages(struct address_space *mapping);
-unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
-					    unsigned int);
+unsigned int nilfs_page_count_clean_buffers(struct folio *,
+		unsigned int from, unsigned int to);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff);
-- 
2.43.0


