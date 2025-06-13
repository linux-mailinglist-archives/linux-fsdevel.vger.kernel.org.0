Return-Path: <linux-fsdevel+bounces-51608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA07AD94FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D823BB77E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF06244676;
	Fri, 13 Jun 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DkJPPJoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15D23E356;
	Fri, 13 Jun 2025 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841640; cv=none; b=UqZSLn2vmN4YJX+p14uG/AAMRiHhkPx7Zf6//tc5L71MUkfAAkTYQ3Eh/2zWT+4PjUeFdHlw8Xwl4L0JX+rW1U6hshBjPjZ7ELoUXx6J/w2IRNnXFfpwLq2BnEWvd6X08S0lNwTBBlJTiLHyEw2qq91DBhNO/TfFMovx9FXzBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841640; c=relaxed/simple;
	bh=dv1OPY/FJMbHxWqVqkCaotFPEeYCpdM+tzNEA/h+vgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T18uTtxj80hYl5WF2+D9kUHw7rA5x6krXvgxrHaF6zlajSEBekNZ7A+enF4vpiWFoT0syKHXEQ04DR8b1MZGKQTft6pm8tRyRw0otr+SnWvfnamRltXuALTfNPe53iWKjPb/411UTWcUqTL3GTn7/Km4JcCkFgZk0nwvBFRTjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DkJPPJoc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ckKoEhdJcVQEiYYwHjazq14sfufSDykbRyLS59gkmQw=; b=DkJPPJocdByMFGIvyWCg+NYgKW
	5pvnqW4SyeuAmpEWujbNiNDew1yuS+FCy+idcXHn/GOmEke+q2cGIpmg75f7FX+clnrzWCZ+z+lF0
	38/vawnWyVUFF3CQeQGyS1mhu30cB6GUAcy/AokdZMQ5KoAOYt417R/EyAdmgLqumzf7OwZJj9TC6
	JAQWsGW4k7u4L7FcA72Sye2XzT5iOKYxlqyKwinvZrZBV2RR8GN/A1F1Y9mPlXHLgxYhMi/DLygoM
	TauaBHc6YH+uKul+Qf4MarzE/CbRj9TRzIhXZimTxvQo2EnOrfg3i0GbODbOOqj0PnR0dTRosu1j3
	X7RYLUYA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ9k3-0000000DHsZ-0VId;
	Fri, 13 Jun 2025 19:07:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] btrfs: Convert test_find_delalloc() to use a folio
Date: Fri, 13 Jun 2025 20:07:00 +0100
Message-ID: <20250613190705.3166969-2-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613190705.3166969-1-willy@infradead.org>
References: <20250613190705.3166969-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the 'locked_page' variable with 'locked_folio'.  Replaces
ten calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/tests/extent-io-tests.c | 47 ++++++++++++++------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 00da54f0164c..8bdf742d90fd 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -112,7 +112,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	struct inode *inode = NULL;
 	struct extent_io_tree *tmp;
 	struct page *page;
-	struct page *locked_page = NULL;
+	struct folio *locked_folio = NULL;
 	unsigned long index = 0;
 	/* In this test we need at least 2 file extents at its maximum size */
 	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
@@ -168,7 +168,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 			unlock_page(page);
 		} else {
 			get_page(page);
-			locked_page = page;
+			locked_folio = page_folio(page);
 		}
 	}
 
@@ -179,8 +179,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	btrfs_set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
 	start = 0;
 	end = start + PAGE_SIZE - 1;
-	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
-					 &end);
+	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
 	if (!found) {
 		test_err("should have found at least one delalloc");
 		goto out_bits;
@@ -191,8 +190,8 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		goto out_bits;
 	}
 	btrfs_unlock_extent(tmp, start, end, NULL);
-	unlock_page(locked_page);
-	put_page(locked_page);
+	folio_unlock(locked_folio);
+	folio_put(locked_folio);
 
 	/*
 	 * Test this scenario
@@ -201,17 +200,16 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 *           |--- search ---|
 	 */
 	test_start = SZ_64M;
-	locked_page = find_lock_page(inode->i_mapping,
+	locked_folio = filemap_lock_folio(inode->i_mapping,
 				     test_start >> PAGE_SHIFT);
-	if (!locked_page) {
-		test_err("couldn't find the locked page");
+	if (!locked_folio) {
+		test_err("couldn't find the locked folio");
 		goto out_bits;
 	}
 	btrfs_set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
-	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
-					 &end);
+	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
 	if (!found) {
 		test_err("couldn't find delalloc in our range");
 		goto out_bits;
@@ -227,8 +225,8 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		goto out_bits;
 	}
 	btrfs_unlock_extent(tmp, start, end, NULL);
-	/* locked_page was unlocked above */
-	put_page(locked_page);
+	/* locked_folio was unlocked above */
+	folio_put(locked_folio);
 
 	/*
 	 * Test this scenario
@@ -236,16 +234,15 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 *                    |--- search ---|
 	 */
 	test_start = max_bytes + sectorsize;
-	locked_page = find_lock_page(inode->i_mapping, test_start >>
-				     PAGE_SHIFT);
-	if (!locked_page) {
-		test_err("couldn't find the locked page");
+	locked_folio = filemap_lock_folio(inode->i_mapping,
+			test_start >> PAGE_SHIFT);
+	if (!locked_folio) {
+		test_err("couldn't find the locked folio");
 		goto out_bits;
 	}
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
-	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
-					 &end);
+	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
 	if (found) {
 		test_err("found range when we shouldn't have");
 		goto out_bits;
@@ -265,8 +262,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	btrfs_set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
-	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
-					 &end);
+	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
 	if (!found) {
 		test_err("didn't find our range");
 		goto out_bits;
@@ -297,7 +293,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	put_page(page);
 
 	/* We unlocked it in the previous test */
-	lock_page(locked_page);
+	folio_lock(locked_folio);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
 	/*
@@ -306,8 +302,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 * this changes at any point in the future we will need to fix this
 	 * tests expected behavior.
 	 */
-	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
-					 &end);
+	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
 	if (!found) {
 		test_err("didn't find our range");
 		goto out_bits;
@@ -328,8 +323,8 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		dump_extent_io_tree(tmp);
 	btrfs_clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
 out:
-	if (locked_page)
-		put_page(locked_page);
+	if (locked_folio)
+		folio_put(locked_folio);
 	process_page_range(inode, 0, total_dirty - 1,
 			   PROCESS_UNLOCK | PROCESS_RELEASE);
 	iput(inode);
-- 
2.47.2


