Return-Path: <linux-fsdevel+bounces-8850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC583BC8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1424A1F20FF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95681CAA1;
	Thu, 25 Jan 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U9NfiMtZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB91CA8D;
	Thu, 25 Jan 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173118; cv=none; b=UhT9m8oOO3iqUpA22TAPqK0OTd+x8rzIONrt97BGyp+H7Y7L9tjpZBjkYS766toswUiKIsJylYtYe4FfHw7AfQ0jE09tVfKmWx3BNZG/gf0s4lcfby4SWhOYJKFd3oEHts7fEbUHde5Z3v0r3fjWW4t8Grc7hvlDjKRjt6An8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173118; c=relaxed/simple;
	bh=g1UDv4713PpO3A6j8Nk1UOqquwSD1Z+a1rgo9Z/pEm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSFUiZC9lhmJLcsldKWyXJOHsTwcqpU0ptRtwLzZeyVA6TU8OV5RgZjrsVLmaTIFM78CjxC8e8MD58urcY6lasVu1CBWg5SV8U+RXwy86keuEgCbiJgz/qDNmanesmlJfsdF5Go9uPuZpLADNgl6FXwuzZSmmzjYU5n6bnF4AUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U9NfiMtZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MhbOOusfwIyRDrId1i1glf9YHzO3PaLh+M9tTsTFsQo=; b=U9NfiMtZibO0s0QeoA5Pg1gJ5C
	rwwipdwF3Yn3mroMwF8qnFXyn5wCHy3BqYKg+BCIcX6hOa1gQqLQnK17/j3HVJFACNTRbYVxreETo
	FoHGqXvJjMgcyt8QKXxryhIxQgTHmkmXz6pB2L0XcO+XaHUxXg2MAKxMQtr2HLZj86MKZqMfxBeYN
	veKzugZU0wuKWSfKTTlfHMFKuaujyn4wB47NCJc4dPXOGbPd5X5Ymzp8ioS9tD1mEIvXDZvHkdkks
	8DEWuOOCs+emJnWaZ1PQRPsF5CGm3a8HBqC9G4V1PCe72r2mNpd4fxHNaD3GgVSOSBIgJM4qal1vG
	lCzYLbVw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZA-007QIu-0t;
	Thu, 25 Jan 2024 08:58:32 +0000
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
Subject: [PATCH 08/19] writeback: Factor folio_prepare_writeback() out of write_cache_pages()
Date: Thu, 25 Jan 2024 09:57:47 +0100
Message-Id: <20240125085758.2393327-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125085758.2393327-1-hch@lst.de>
References: <20240125085758.2393327-1-hch@lst.de>
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
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 426d929741e46e..cec683c7217d2e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2397,6 +2397,38 @@ static pgoff_t wbc_end(struct writeback_control *wbc)
 	return wbc->range_end >> PAGE_SHIFT;
 }
 
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
 static void writeback_get_batch(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
@@ -2470,38 +2502,13 @@ int write_cache_pages(struct address_space *mapping,
 			unsigned long nr;
 
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
 			nr = folio_nr_pages(folio);
 			wbc->nr_to_write -= nr;
-- 
2.39.2


