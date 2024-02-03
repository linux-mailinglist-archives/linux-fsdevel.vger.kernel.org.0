Return-Path: <linux-fsdevel+bounces-10130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B234848440
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF9F1C24D08
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6950A8F;
	Sat,  3 Feb 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QtHTeuf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725295025C;
	Sat,  3 Feb 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944352; cv=none; b=ZY+11VaAdoXxr8+lAi3WowBdSkIx0a0u66hYv/BAZjvEygnd6KhiCAHTfj19VhoA0xoQu/Y5SpgsSt4ei4CI1SibHyhGzeENkCORf4R9B/OoYlPaxr/qaHMKVLQnL2BgIKsidXc412Freog7DQgfKHUVaDliwypWHZpsC7KI0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944352; c=relaxed/simple;
	bh=1v22MW2g70qIZzRnC2FfK5fA1jdl1UfKC8ZDQkFezDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqFKaN5M8gucjlrITWO+3HN023Ju0SQXCW0vg9JMPlhYKeAgL5/Fdfe/zOvDf4HBZS2mKviGyJ0QP1wpz9fdIvRc74qyYIm8JfL9hv8bcYepAZnfRkqZa0n60mMwBv+L60djrqcGQyUyNQ1Uz3AaTDOZ0EGlXcIw3eJkJMkZN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QtHTeuf+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jfeyOGGqJMEhwjwDWY78Dxs/MD9XWP1Zn49OkkJuspU=; b=QtHTeuf+5e3JSMI6nOmskVdXn2
	G8jz9FhabBgFanvh596iAi7noXgATwCi8VOdtCyLoUHl0L23Nt+Egfg2/qpZAHF/W78ZpJNpLkMwB
	tWjQjqHjUneWK8LK2zuwoMrnCEyUN+CmhqZ4ZRSFYbptSY4swVURu/4e3Wboeen9MkaDWNvQqFMcN
	dJYtx4TWqYx60UTzX1pE7h6Qqr6AZd0lfbtQep3EuRDdIA4AR7a8KjkW2ll/n7LfL6rU4nSfL1ow2
	tWQyVWXrjWKzWGksYBzaHtM9g2dn5LHuKdQbFjjcm3XvN0izvhzgH9QM6RVm05E3b4IZ19SOjZh9w
	dmh0Pezg==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWACQ-0000000Fk6W-3iJc;
	Sat, 03 Feb 2024 07:12:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 06/13] writeback: Factor folio_prepare_writeback() out of write_cache_pages()
Date: Sat,  3 Feb 2024 08:11:40 +0100
Message-Id: <20240203071147.862076-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240203071147.862076-1-hch@lst.de>
References: <20240203071147.862076-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Reduce write_cache_pages() by about 30 lines; much of it is commentary,
but it all bundles nicely into an obvious function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: rename should_writeback_folio to folio_prepare_writeback based on
      a comment from Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 88b2c4c111c01b..949193624baa38 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,6 +2360,38 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
+static bool folio_prepare_writeback(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio)
+{
+	/*
+	 * Folio truncated or invalidated. We can freely skip it then,
+	 * even for data integrity operations: the folio has disappeared
+	 * concurrently, so there could be no real expectation of this
+	 * data integrity operation even if there is now a new, dirty
+	 * folio at the same pagecache index.
+	 */
+	if (unlikely(folio->mapping != mapping))
+		return false;
+
+	/*
+	 * Did somebody else write it for us?
+	 */
+	if (!folio_test_dirty(folio))
+		return false;
+
+	if (folio_test_writeback(folio)) {
+		if (wbc->sync_mode == WB_SYNC_NONE)
+			return false;
+		folio_wait_writeback(folio);
+	}
+	BUG_ON(folio_test_writeback(folio));
+
+	if (!folio_clear_dirty_for_io(folio))
+		return false;
+
+	return true;
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2430,38 +2462,13 @@ int write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			folio = fbatch.folios[i];
 			folio_lock(folio);
-
-			/*
-			 * Page truncated or invalidated. We can freely skip it
-			 * then, even for data integrity operations: the page
-			 * has disappeared concurrently, so there could be no
-			 * real expectation of this data integrity operation
-			 * even if there is now a new, dirty page at the same
-			 * pagecache address.
-			 */
-			if (unlikely(folio->mapping != mapping)) {
-continue_unlock:
+			if (!folio_prepare_writeback(mapping, wbc, folio)) {
 				folio_unlock(folio);
 				continue;
 			}
 
-			if (!folio_test_dirty(folio)) {
-				/* someone wrote it for us */
-				goto continue_unlock;
-			}
-
-			if (folio_test_writeback(folio)) {
-				if (wbc->sync_mode != WB_SYNC_NONE)
-					folio_wait_writeback(folio);
-				else
-					goto continue_unlock;
-			}
-
-			BUG_ON(folio_test_writeback(folio));
-			if (!folio_clear_dirty_for_io(folio))
-				goto continue_unlock;
-
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+
 			error = writepage(folio, wbc, data);
 			wbc->nr_to_write -= folio_nr_pages(folio);
 
-- 
2.39.2


