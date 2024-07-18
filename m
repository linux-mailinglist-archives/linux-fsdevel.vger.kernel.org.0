Return-Path: <linux-fsdevel+bounces-23971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B864D9370A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99281C21936
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CE1465BC;
	Thu, 18 Jul 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m1kf3OgL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9677F2C;
	Thu, 18 Jul 2024 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341820; cv=none; b=JAQsMHefOqVKtKfUrdC6hckyl2QGp8sG3VORqnrGR5HVpZvsVpfLHFQzszvsoOUoPaOzwcdffNSQ8dh4+SeAfOe74V/UErW3k10a9Oun+yqL41jYVsqelplaF8Xqwkv+Zu3xEoJ2eTE7H3N2xXZS9zhVXtDzXTm9Uj1/u8zIVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341820; c=relaxed/simple;
	bh=AR2LyEnpG9JWUDbvRTmOR7bkHSuIwVYAk5WGLXCT6NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkcKbYnncpCqF2VF+pZ0jFvM2KFn7ezj7eq1DP6etmHYOg3F0Pdx6LbkOCMOmchgv8a6MhuYCUPeg/3RQfAk7f/HSWdycA4rHD0mFqv3q+8eLAglGrmTZzELXiQWdPfbwoArkiN4z7Yxjj7iAUsnC3EOnP6LSqI6vMl+1Ac/LOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m1kf3OgL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VN24yx9tPzrfoWtcytnmHecpiKvPA8Lp+lwa5uBWGQE=; b=m1kf3OgLqqQOF+Afj18UMtuGyY
	eVymTHVe+xIWAMZYC7YBc2fWb3jOlnHdW+GbgyIH0iWYx3S9uRpyjq3UprrdtsZ3v5M00jdomE4/I
	zl4bsZFxfsjRU5ErGrCWfOi23NOWCFv7dAJrtZOzd075oI0BHpynzJcObJwMIkXhuntMr8I+Jyj9x
	10WAnzTjy+Nw1f7pOV7nJq/tUTa7+ydwXqvnKZPmfeOnz0aY7+4nHTeX4RPhe7AzGzcwVa0s3uX2O
	hL/RUPH6z4xbK59s5/Dfk/M7OgB3/2Rdf0/iPsNHKNa1Er7sVwqibmAL3UQeF9+6a0i7gwHc5bnQk
	0XaZVRww==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUZdX-00000002O0Q-0JPP;
	Thu, 18 Jul 2024 22:30:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 3/4] ext4: Remove array of buffer_heads from mext_page_mkuptodate()
Date: Thu, 18 Jul 2024 23:30:01 +0100
Message-ID: <20240718223005.568869-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718223005.568869-1-willy@infradead.org>
References: <20240718223005.568869-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterate the folio's list of buffer_heads twice instead of keeping
an array of pointers.  This solves a too-large-array-for-stack problem
on architectures with a ridiculoously large PAGE_SIZE and prepares
ext4 to support larger folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 6d651ad788ac..660bf34a5c4b 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -166,15 +166,14 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 	return 0;
 }
 
-/* Force page buffers uptodate w/o dropping page's lock */
-static int
-mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
+/* Force folio buffers uptodate w/o dropping folio's lock */
+static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t block;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head;
 	unsigned int blocksize, block_start, block_end;
-	int i, nr = 0;
+	int nr = 0;
 	bool partial = false;
 
 	BUG_ON(!folio_test_locked(folio));
@@ -215,20 +214,23 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 			continue;
 		}
 		ext4_read_bh_nowait(bh, 0, NULL);
-		BUG_ON(nr >= MAX_BUF_PER_PAGE);
-		arr[nr++] = bh;
+		nr++;
 	}
 	/* No io required */
 	if (!nr)
 		goto out;
 
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
+	bh = head;
+	do {
+		if (bh_offset(bh) + blocksize <= from)
+			continue;
+		if (bh_offset(bh) > to)
+			break;
 		wait_on_buffer(bh);
 		if (buffer_uptodate(bh))
 			continue;
 		return -EIO;
-	}
+	} while ((bh = bh->b_this_page) != head);
 out:
 	if (!partial)
 		folio_mark_uptodate(folio);
-- 
2.43.0


