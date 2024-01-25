Return-Path: <linux-fsdevel+bounces-8858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737EB83BCA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5DC1F2A667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6042C68A;
	Thu, 25 Jan 2024 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3rO9V9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B5249FA;
	Thu, 25 Jan 2024 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173146; cv=none; b=Tzzm8vh8xheEP0awdQeijwb3IUuhWAFhEdEUtUvley1Q/KQet0NoOguCkfK+gaEMv7HGx05Mq67vYvH+KMDF9FYmhb6l7+OyItPC86t0dFCCYnw9zx9ARw5qfD8PM4Kt+tgcXc00fxV9aR80mrR2XXlD7r4yxQf9a0YWNaNWcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173146; c=relaxed/simple;
	bh=TI24cJnMdGzsgxQqxt9jvYpBkT4NwKMozelbH1rukDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJTX0rzb37eD+22Rwyd81SfISrBjbciG0vZ4b2Xd9mS750cynFQVBJvtOs3OtsPRxcO0HUjVdaWxwCtLcxPEDJXFg/1ZPbGcuIE2d3NqxCdMVMA+AX6WtYNMGEr0WtbBLAQgf3l5++P24nd5NFUmE7gXO2wMJgXbdKF0TOpDnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d3rO9V9S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6v9XAAhdpH6YgZ+Y+Fwce9RtWvlBgAi1bnWfafXvJ4k=; b=d3rO9V9SsGYi+hKqPmgZ4FhJpC
	YyFmQQC8kw3TEuvhCmh+RIj0Hrq9Ebm6JzPz1TPxhAQSlfikUlvmSe+xMs0a/XuOxlntOrUe/nN2t
	XfoAdRowfYiU1GLgD1pSW+VuuSUkCbuXk6xrF8BvY50J2REvBSgyKCTTmZISVw9vFlrPhyJ8iH7cf
	w6MnhBOjyEnC4JjDEJaTPzWJVOtoA0TtA5FIF1MwPuWIfzvXTFuN4E36VJbjulhSJgIE7ZH/rdZts
	5H90iQduBnFLeqzLgKMDhukwZeWMBi4OvIVlOjKWyANJA6ueQT41NzyScrludnx4YKl6/kzTo8p2q
	YwJDKtiQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZX-007QTL-1B;
	Thu, 25 Jan 2024 08:58:55 +0000
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
Subject: [PATCH 14/19] writeback: Factor writeback_iter_next() out of write_cache_pages()
Date: Thu, 25 Jan 2024 09:57:53 +0100
Message-Id: <20240125085758.2393327-15-hch@lst.de>
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

Pull the post-processing of the writepage_t callback into a separate
function.  That means changing writeback_get_next() to call
writeback_finish() when we naturally run out of folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 85 ++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d170dab07402ce..d5815237fbec29 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2442,8 +2442,10 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
 				wbc_to_tag(wbc), &wbc->fbatch);
 		folio = folio_batch_next(&wbc->fbatch);
-		if (!folio)
+		if (!folio) {
+			writeback_finish(mapping, wbc, 0);
 			return NULL;
+		}
 	}
 
 	folio_lock(folio);
@@ -2472,6 +2474,46 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
+static struct folio *writeback_iter_next(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int error)
+{
+	unsigned long nr = folio_nr_pages(folio);
+
+	wbc->nr_to_write -= nr;
+
+	/*
+	 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
+	 * Eventually all instances should just unlock the folio themselves and
+	 * return 0;
+	 */
+	if (error == AOP_WRITEPAGE_ACTIVATE) {
+		folio_unlock(folio);
+		error = 0;
+	}
+
+	if (error && !wbc->err)
+		wbc->err = error;
+
+	/*
+	 * For integrity sync  we have to keep going until we have written all
+	 * the folios we tagged for writeback prior to entering the writeback
+	 * loop, even if we run past wbc->nr_to_write or encounter errors.
+	 * This is because the file system may still have state to clear for
+	 * each folio.   We'll eventually return the first error encountered.
+	 *
+	 * For background writeback just push done_index past this folio so that
+	 * we can just restart where we left off and media errors won't choke
+	 * writeout for the entire file.
+	 */
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    (wbc->err || wbc->nr_to_write <= 0)) {
+		writeback_finish(mapping, wbc, folio->index + nr);
+		return NULL;
+	}
+
+	return writeback_get_folio(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2512,47 +2554,10 @@ int write_cache_pages(struct address_space *mapping,
 
 	for (folio = writeback_iter_init(mapping, wbc);
 	     folio;
-	     folio = writeback_get_folio(mapping, wbc)) {
-		unsigned long nr;
-
+	     folio = writeback_iter_next(mapping, wbc, folio, error))
 		error = writepage(folio, wbc, data);
-		nr = folio_nr_pages(folio);
-		wbc->nr_to_write -= nr;
-
-		/*
-		 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
-		 * Eventually all instances should just unlock the folio
-		 * themselves and return 0;
-		 */
-		if (error == AOP_WRITEPAGE_ACTIVATE) {
-			folio_unlock(folio);
-			error = 0;
-		}
-
-		if (error && !wbc->err)
-			wbc->err = error;
 
-		/*
-		 * For integrity sync  we have to keep going until we have
-		 * written all the folios we tagged for writeback prior to
-		 * entering this loop, even if we run past wbc->nr_to_write or
-		 * encounter errors.  This is because the file system may still
-		 * have state to clear for each folio.   We'll eventually return
-		 * the first error encountered.
-		 *
-		 * For background writeback just push done_index past this folio
-		 * so that we can just restart where we left off and media
-		 * errors won't choke writeout for the entire file.
-		 */
-		if (wbc->sync_mode == WB_SYNC_NONE &&
-		    (wbc->err || wbc->nr_to_write <= 0)) {
-			writeback_finish(mapping, wbc, folio->index + nr);
-			return error;
-		}
-	}
-
-	writeback_finish(mapping, wbc, 0);
-	return 0;
+	return wbc->err;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


