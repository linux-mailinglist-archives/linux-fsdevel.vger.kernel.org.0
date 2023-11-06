Return-Path: <linux-fsdevel+bounces-2123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A967E2B34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E96C28175B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE47A29D10;
	Mon,  6 Nov 2023 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YIXTxxkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6202C841
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:14 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D5D61;
	Mon,  6 Nov 2023 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6YmJMS1fBEcalQZgaHkW5Vu6KaT+mCK0+GMTsxlbpis=; b=YIXTxxkNUHJkYhj/M9r7nTzTyn
	Tn87sP5iU7OFLTjg2UH242y1hy+QdXTivAgGTotPFYXRVf7HJRStBlZfyr+Al9glP9768YQWXUKYR
	lDt3u0YhVuX6eqbcsL6hIignxfJufP5OVre8tEufe9FcffD8FeCzUQjXmfeQeJMdTpeySHKfBH2zl
	vKCke/3F/eBRvYiJ/60+zGlPNFy407A5ov6PxbhXJZ1AEy0EQdvhT13pOAbyIqg9KfeRFp4phQo4e
	g+NtAYQA2KdloIiikG6+JsLEDWdSzNbQhAJ449ML9qBwvQGbZ21yPtoUj81WFPWYpi92L4pWt3MOS
	B6zS3wTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z4-007H87-AG; Mon, 06 Nov 2023 17:39:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/35] nilfs2: Convert to nilfs_folio_buffers_clean()
Date: Mon,  6 Nov 2023 17:38:33 +0000
Message-Id: <20231106173903.1734114-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of nilfs_page_buffers_clean() now have a folio, so convert
it to take a folio.  While I'm at it, make it return a bool.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/page.c    | 18 +++++++++---------
 fs/nilfs2/page.h    |  2 +-
 fs/nilfs2/segment.c |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 3882acde1b3e..29799a49c234 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -81,7 +81,7 @@ void nilfs_forget_buffer(struct buffer_head *bh)
 
 	lock_buffer(bh);
 	set_mask_bits(&bh->b_state, clear_bits, 0);
-	if (nilfs_page_buffers_clean(&folio->page))
+	if (nilfs_folio_buffers_clean(folio))
 		__nilfs_clear_page_dirty(&folio->page);
 
 	bh->b_blocknr = -1;
@@ -131,23 +131,23 @@ void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
 }
 
 /**
- * nilfs_page_buffers_clean - check if a page has dirty buffers or not.
- * @page: page to be checked
+ * nilfs_folio_buffers_clean - Check if a folio has dirty buffers or not.
+ * @folio: Folio to be checked.
  *
- * nilfs_page_buffers_clean() returns zero if the page has dirty buffers.
- * Otherwise, it returns non-zero value.
+ * nilfs_folio_buffers_clean() returns false if the folio has dirty buffers.
+ * Otherwise, it returns true.
  */
-int nilfs_page_buffers_clean(struct page *page)
+bool nilfs_folio_buffers_clean(struct folio *folio)
 {
 	struct buffer_head *bh, *head;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	do {
 		if (buffer_dirty(bh))
-			return 0;
+			return false;
 		bh = bh->b_this_page;
 	} while (bh != head);
-	return 1;
+	return true;
 }
 
 void nilfs_page_bug(struct page *page)
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index d249ea1cefff..a8ab800e689c 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -36,7 +36,7 @@ struct buffer_head *nilfs_grab_buffer(struct inode *, struct address_space *,
 				      unsigned long, unsigned long);
 void nilfs_forget_buffer(struct buffer_head *);
 void nilfs_copy_buffer(struct buffer_head *, struct buffer_head *);
-int nilfs_page_buffers_clean(struct page *);
+bool nilfs_folio_buffers_clean(struct folio *);
 void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2a058aad5c2d..888b8606a1e8 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1759,7 +1759,7 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 			 * all the buffers get cleaned later.
 			 */
 			folio_lock(folio);
-			if (nilfs_page_buffers_clean(&folio->page))
+			if (nilfs_folio_buffers_clean(folio))
 				__nilfs_clear_page_dirty(&folio->page);
 			folio_unlock(folio);
 		}
@@ -1767,7 +1767,7 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 	}
 
 	if (!err) {
-		if (!nilfs_page_buffers_clean(&folio->page))
+		if (!nilfs_folio_buffers_clean(folio))
 			filemap_dirty_folio(folio->mapping, folio);
 		folio_clear_error(folio);
 	} else {
-- 
2.42.0


