Return-Path: <linux-fsdevel+bounces-30647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCDB98CBD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 06:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9201F2864ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 04:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194C5F873;
	Wed,  2 Oct 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u39QsFMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1970482E4;
	Wed,  2 Oct 2024 04:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841685; cv=none; b=LmZ1ZSjNgVxwViPrSRhN7Y7+gD8cnRiZin8H7j6Y84XqC1v6yalv265FiAKen85Fl1bbr/AzzdTl6cRwX6W1zbi0oliAKYah2SNM30kiiixjcUzO/dKvWkTweohEtF0RBhtZ8W4wZH9J+9BaA8MbYQE4aLBGRbq153e8UPGkRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841685; c=relaxed/simple;
	bh=xjltzcWJmsieOqgwDm3VFkcpMNiWEZSPtgnpm74ni68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXPKNsvlWq4ErwFcXv38SS3sak1X+k41Ynw28eMPnFf8lLPwy/EIoutQ0Eu/z48LVbhlggpuMLPXIQCLkOGUy/S+WnpdxelUiHmivqqO17w5mWhMRuAxJCYc1M8UcAiP1HyXjI5EPbe57uaWBC9+Jbi6tjEOXzV7zE2hFecxjXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u39QsFMw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Qu1H+yLukYt9YwYC/7ESpsAw9sOZjKm/rhqgTzGdqoU=; b=u39QsFMwQ6tIwNI7i/W1K+/pl+
	GvSGrpVMvi9IWupEj7d7hKdghJKrM8TW/XKgZb3bkO1NguUXTBhUJB4Adxa6WXd0ajYBIGzZWnxhW
	H6BXWSuGXsM65J4L5JDKfv0k8YLxibiMMitHwY03iC2W9MLIjhWBnRauq01lxHeU4qd9vVJI0B1z2
	asy96gxHMxcFadkiQTWxzRThGNp0i2aIXcGqBT3UxcxELkkZdMroPgTKm4jlnqW1VhLmrZIv1VoQL
	n+44yDwp5sIhB3WaWM6c4Rg1vTpmuHvSuUmpVzYMZR7W8Jw/e9xFD9YUU3PZANOA6b2Uj9TjSqD3B
	2GXU3Phg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svqY5-00000004I8Z-3vof;
	Wed, 02 Oct 2024 04:01:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/6] btrfs: Switch from using the private_2 flag to owner_2
Date: Wed,  2 Oct 2024 05:01:06 +0100
Message-ID: <20241002040111.1023018-5-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002040111.1023018-1-willy@infradead.org>
References: <20241002040111.1023018-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are close to removing the private_2 flag, so switch btrfs to using
owner_2 for its ordered flag.  This is mostly used by buffer head
filesystems, so btrfs can use it because it doesn't use buffer heads.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/ctree.h        | 13 ++++---------
 fs/btrfs/inode.c        |  8 ++++----
 fs/btrfs/ordered-data.c |  4 ++--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 317a3712270f..307dedf95c70 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -744,16 +744,11 @@ const char *btrfs_super_csum_driver(u16 csum_type);
 size_t __attribute_const__ btrfs_get_num_csums(void);
 
 /*
- * We use page status Private2 to indicate there is an ordered extent with
+ * We use folio flag owner_2 to indicate there is an ordered extent with
  * unfinished IO.
- *
- * Rename the Private2 accessors to Ordered, to improve readability.
  */
-#define PageOrdered(page)		PagePrivate2(page)
-#define SetPageOrdered(page)		SetPagePrivate2(page)
-#define ClearPageOrdered(page)		ClearPagePrivate2(page)
-#define folio_test_ordered(folio)	folio_test_private_2(folio)
-#define folio_set_ordered(folio)	folio_set_private_2(folio)
-#define folio_clear_ordered(folio)	folio_clear_private_2(folio)
+#define folio_test_ordered(folio)	folio_test_owner_2(folio)
+#define folio_set_ordered(folio)	folio_set_owner_2(folio)
+#define folio_clear_ordered(folio)	folio_clear_owner_2(folio)
 
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index edac499fd83d..a4055896261d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1513,7 +1513,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		 * (which the caller expects to stay locked), don't clear any
 		 * dirty bits and don't set any writeback bits
 		 *
-		 * Do set the Ordered (Private2) bit so we know this page was
+		 * Do set the Ordered flag so we know this page was
 		 * properly setup for writepage.
 		 */
 		page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
@@ -7292,7 +7292,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	 *
 	 * But already submitted bio can still be finished on this folio.
 	 * Furthermore, endio function won't skip folio which has Ordered
-	 * (Private2) already cleared, so it's possible for endio and
+	 * already cleared, so it's possible for endio and
 	 * invalidate_folio to do the same ordered extent accounting twice
 	 * on one folio.
 	 *
@@ -7358,7 +7358,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		range_len = range_end + 1 - cur;
 		if (!btrfs_folio_test_ordered(fs_info, folio, cur, range_len)) {
 			/*
-			 * If Ordered (Private2) is cleared, it means endio has
+			 * If Ordered is cleared, it means endio has
 			 * already been executed for the range.
 			 * We can't delete the extent states as
 			 * btrfs_finish_ordered_io() may still use some of them.
@@ -7431,7 +7431,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	}
 	/*
 	 * We have iterated through all ordered extents of the page, the page
-	 * should not have Ordered (Private2) anymore, or the above iteration
+	 * should not have Ordered anymore, or the above iteration
 	 * did something wrong.
 	 */
 	ASSERT(!folio_test_ordered(folio));
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 2104d60c2161..95c8499a159a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -346,10 +346,10 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 		ASSERT(file_offset + len <= folio_pos(folio) + folio_size(folio));
 
 		/*
-		 * Ordered (Private2) bit indicates whether we still have
+		 * Ordered flag indicates whether we still have
 		 * pending io unfinished for the ordered extent.
 		 *
-		 * If there's no such bit, we need to skip to next range.
+		 * If it's not set, we need to skip to next range.
 		 */
 		if (!btrfs_folio_test_ordered(fs_info, folio, file_offset, len))
 			return false;
-- 
2.43.0


