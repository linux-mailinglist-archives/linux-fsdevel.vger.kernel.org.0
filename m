Return-Path: <linux-fsdevel+bounces-51605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E4AD94F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78A51E348B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67384239E79;
	Fri, 13 Jun 2025 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="teuY59d7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA62E555;
	Fri, 13 Jun 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841633; cv=none; b=atq6JNRTrwewmrv3gJjuYM25eb7LmZtnsU+QgBMsmmFmZLOP2oqmXeV6o0Q2tuUb1oH3MQMi7i7rq/XgECjBb92SCdavyDr6TyUbnabE/iMGrxB1R9BDK1MLXiX8iK/FnhaTf4xAA2Fjb/dogqjqTIcTIe7vOTxVaitAuQxb+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841633; c=relaxed/simple;
	bh=0upAW4LAclTdF9vsUvzCmnLb74Xz69Ug5rHwth06G/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0Os8j0INhFMUI8pny849T4Fx/qBfTF+MCEQSELN+hznoAsxXmxGZ8siZddh8avZw3JxTpy3zLH8QGUbCXlFdj6Tnc0EShfJyaPjwJZETfJrMf3WrU+H0nb781L2bQtNuekoxw6y8Y+a5UrLHssm1RQywIUYDiq/PczL/1NaJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=teuY59d7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fHQIwQd/uaGecizhn0Y3isTSa7RX9yw72MA+E8n8NT4=; b=teuY59d7sHbEEURs+Btb2p7kqd
	9qfqMCmLJfP6xav0M3KTktVx6But4yy24CC0aldIaxpNdWmyoNpacByK7LKeGxUDSNjG2oFu8QdLi
	JDeVHh9LCkh3eU0ft5DUcp1iNrgvVh+yMjdiSgLEmkpo3WD2uar4rFFdIkRKWAx+r6Ac+1Y2uzD4z
	oqaBnP5kB8Ol1ix0dBPd6wNXZr/qdZTgcTuRgZR1toze9c6J1+o5HDtwvJmZ/kq5FADoSFvpKoUii
	q1rZNVdQtLtaAwC6Pl0WW7Qo/GgaO7g9cfvmGTkmFJD44EoGwJSIqLDWDL51ds2JnBu/IiBKZSPcU
	oAv/Kp7w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ9k3-0000000DHsb-0zQG;
	Fri, 13 Jun 2025 19:07:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] btrfs: Convert test_find_delalloc() to use a folio, part two
Date: Fri, 13 Jun 2025 20:07:01 +0100
Message-ID: <20250613190705.3166969-3-willy@infradead.org>
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

Replace the 'page' variable with 'folio'.  Removes six calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/tests/extent-io-tests.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 8bdf742d90fd..36720b77b440 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -111,7 +111,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	struct btrfs_root *root = NULL;
 	struct inode *inode = NULL;
 	struct extent_io_tree *tmp;
-	struct page *page;
+	struct folio *folio;
 	struct folio *locked_folio = NULL;
 	unsigned long index = 0;
 	/* In this test we need at least 2 file extents at its maximum size */
@@ -152,23 +152,25 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	btrfs_extent_io_tree_init(NULL, tmp, IO_TREE_SELFTEST);
 
 	/*
-	 * First go through and create and mark all of our pages dirty, we pin
-	 * everything to make sure our pages don't get evicted and screw up our
+	 * First go through and create and mark all of our folios dirty, we pin
+	 * everything to make sure our folios don't get evicted and screw up our
 	 * test.
 	 */
 	for (index = 0; index < (total_dirty >> PAGE_SHIFT); index++) {
-		page = find_or_create_page(inode->i_mapping, index, GFP_KERNEL);
-		if (!page) {
-			test_err("failed to allocate test page");
+		folio = __filemap_get_folio(inode->i_mapping, index,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				GFP_KERNEL);
+		if (!folio) {
+			test_err("failed to allocate test folio");
 			ret = -ENOMEM;
 			goto out;
 		}
-		SetPageDirty(page);
+		folio_mark_dirty(folio);
 		if (index) {
-			unlock_page(page);
+			folio_unlock(folio);
 		} else {
-			get_page(page);
-			locked_folio = page_folio(page);
+			folio_get(folio);
+			locked_folio = folio;
 		}
 	}
 
@@ -283,14 +285,14 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 * Now to test where we run into a page that is no longer dirty in the
 	 * range we want to find.
 	 */
-	page = find_get_page(inode->i_mapping,
+	folio = filemap_get_folio(inode->i_mapping,
 			     (max_bytes + SZ_1M) >> PAGE_SHIFT);
-	if (!page) {
-		test_err("couldn't find our page");
+	if (!folio) {
+		test_err("couldn't find our folio");
 		goto out_bits;
 	}
-	ClearPageDirty(page);
-	put_page(page);
+	folio_clear_dirty(folio);
+	folio_put(folio);
 
 	/* We unlocked it in the previous test */
 	folio_lock(locked_folio);
-- 
2.47.2


