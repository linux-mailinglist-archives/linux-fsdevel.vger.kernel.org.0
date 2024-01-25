Return-Path: <linux-fsdevel+bounces-8849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7883BC86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE0628D869
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BDD1BC57;
	Thu, 25 Jan 2024 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M2BAjIGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593271B966;
	Thu, 25 Jan 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173113; cv=none; b=kf7nGZ2iSOGiGdA2+T63Y3Z74BUR6YzPii+yFY6K/fHv1ZA9X7tItUUF4ExQcdmVI4n2c7OUiZ6Bja1Ucr0pqP1ivNc6mcyC6QNA6616fIVuQItxw2w1ATwGIu8RJEDVpHhqbceqFnYU8JxF4Xnuav6szl9KyCDz4uwcoctaywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173113; c=relaxed/simple;
	bh=qaq77U3fnU73uWxlfzqMNre8TtM0t/yuh9HrRXGrPQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfK+4qMkM6tNAok5JoNYGV2ugIdn/Xjn0j5Z8YHYxBnYXDxVXkYZ55ZObMSX5oNNNzl9GHXm52d4MbvRma5XAgx1GjL0upV5hRjRbOPsRLXW+uEm/umBZDmacLLoJEeBp0FzLJIImlJwEqGJ4qS5jgEeq2YO8auS7I6tNvV4jWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M2BAjIGA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Vkaa3agK4bmExpMMpwz6raRR84eX1JPD0T6pdU6vMG0=; b=M2BAjIGAHnJ1E+ndMgAiCOjjYp
	1a+nS3OdgBz8+6pf3SQxZDnckkrJM9+/8/o7yfitpdM+slw3S/cxglf8duyGyWNHivAuCeIQ0hBka
	5zjfblB5iys/OqtNw3HsMQFxI1q7UhTSjlehkJhmeryqswG1YOAGC0KJnH5LeDkL1RKTzqXvV+xI4
	lGFpynQi3ruaXpEk9G6tEusnvGA4IkCRSO2MGmqi/vhP2a0hMR3Vs9ztPcuS13v3qC2y9e5faOubW
	RnDjBphg9mhBmn8msek0d6YR3AwsDL+dmrJtKFhBgM70Rw9kRaBaVThf1Ai1b/8smeMnJDxmKIfLz
	Nv/zZssQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZ3-007QGN-10;
	Thu, 25 Jan 2024 08:58:25 +0000
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
Subject: [PATCH 06/19] writeback: Factor out writeback_finish()
Date: Thu, 25 Jan 2024 09:57:45 +0100
Message-Id: <20240125085758.2393327-7-hch@lst.de>
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

Instead of having a 'done' variable that controls the nested loops,
have a writeback_finish() that can be returned directly.  This involves
keeping more things in writeback_control, but it's just moving stuff
allocated on the stack to being allocated slightly earlier on the stack.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: heavily rebased, reordered and commented struct writeback_control]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h |  6 +++
 mm/page-writeback.c       | 79 ++++++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 4b8cf9e4810bad..7d60a68fa4ea47 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,6 +11,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
+#include <linux/pagevec.h>
 
 struct bio;
 
@@ -40,6 +41,7 @@ enum writeback_sync_modes {
  * in a manner such that unspecified fields are set to zero.
  */
 struct writeback_control {
+	/* public fields that can be set and/or consumed by the caller: */
 	long nr_to_write;		/* Write this many pages, and decrement
 					   this for each page written */
 	long pages_skipped;		/* Pages which were not written */
@@ -77,6 +79,10 @@ struct writeback_control {
 	 */
 	struct swap_iocb **swap_plug;
 
+	/* internal fields used by the ->writepages implementation: */
+	struct folio_batch fbatch;
+	int err;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 437745a511c634..fcd90a176d806c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,6 +2360,29 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
+static void writeback_finish(struct address_space *mapping,
+		struct writeback_control *wbc, pgoff_t done_index)
+{
+	folio_batch_release(&wbc->fbatch);
+
+	/*
+	 * For range cyclic writeback we need to remember where we stopped so
+	 * that we can continue there next time we are called.  If  we hit the
+	 * last page and there is more work to be done, wrap back to the start
+	 * of the file.
+	 *
+	 * For non-cyclic writeback we always start looking up at the beginning
+	 * of the file if we are called again, which can only happen due to
+	 * -ENOMEM from the file system.
+	 */
+	if (wbc->range_cyclic) {
+		if (wbc->err || wbc->nr_to_write <= 0)
+			mapping->writeback_index = done_index;
+		else
+			mapping->writeback_index = 0;
+	}
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2395,17 +2418,12 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
-	int ret = 0;
-	int done = 0;
 	int error;
-	struct folio_batch fbatch;
 	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	pgoff_t done_index;
 	xa_mark_t tag;
 
-	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* prev offset */
 		end = -1;
@@ -2419,22 +2437,23 @@ int write_cache_pages(struct address_space *mapping,
 	} else {
 		tag = PAGECACHE_TAG_DIRTY;
 	}
-	done_index = index;
-	while (!done && (index <= end)) {
+
+	folio_batch_init(&wbc->fbatch);
+	wbc->err = 0;
+
+	while (index <= end) {
 		int i;
 
 		nr_folios = filemap_get_folios_tag(mapping, &index, end,
-				tag, &fbatch);
+				tag, &wbc->fbatch);
 
 		if (nr_folios == 0)
 			break;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+			struct folio *folio = wbc->fbatch.folios[i];
 			unsigned long nr;
 
-			done_index = folio->index;
-
 			folio_lock(folio);
 
 			/*
@@ -2481,6 +2500,9 @@ int write_cache_pages(struct address_space *mapping,
 				folio_unlock(folio);
 				error = 0;
 			}
+		
+			if (error && !wbc->err)
+				wbc->err = error;
 
 			/*
 			 * For integrity sync  we have to keep going until we
@@ -2496,38 +2518,19 @@ int write_cache_pages(struct address_space *mapping,
 			 * off and media errors won't choke writeout for the
 			 * entire file.
 			 */
-			if (error && !ret)
-				ret = error;
-			if (wbc->sync_mode == WB_SYNC_NONE) {
-				if (ret || wbc->nr_to_write <= 0) {
-					done_index = folio->index + nr;
-					done = 1;
-					break;
-				}
+			if (wbc->sync_mode == WB_SYNC_NONE &&
+			    (wbc->err || wbc->nr_to_write <= 0)) {
+				writeback_finish(mapping, wbc,
+						folio->index + nr);
+				return error;
 			}
 		}
-		folio_batch_release(&fbatch);
+		folio_batch_release(&wbc->fbatch);
 		cond_resched();
 	}
 
-	/*
-	 * For range cyclic writeback we need to remember where we stopped so
-	 * that we can continue there next time we are called.  If  we hit the
-	 * last page and there is more work to be done, wrap back to the start
-	 * of the file.
-	 *
-	 * For non-cyclic writeback we always start looking up at the beginning
-	 * of the file if we are called again, which can only happen due to
-	 * -ENOMEM from the file system.
-	 */
-	if (wbc->range_cyclic) {
-		if (done)
-			mapping->writeback_index = done_index;
-		else
-			mapping->writeback_index = 0;
-	}
-
-	return ret;
+	writeback_finish(mapping, wbc, 0);
+	return 0;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


