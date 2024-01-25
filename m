Return-Path: <linux-fsdevel+bounces-8852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D0B83BC90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41131F2735B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61411CD33;
	Thu, 25 Jan 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m/Q1LhPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7C1CD16;
	Thu, 25 Jan 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173129; cv=none; b=fxv9CoMJ4300wzO9DW0pjx0cBS+EDv5BO2+OxI0yLu319D3reHhkXGWvNwoZQ6FQ2zjXQMpJYViJHPbJzj//BwHPGX+66PpGBGEWrM+BTszBRmac8Dkz5v5oE7+DeTal37c18ZdcejZrZVWNl72igHgL6SbCTenR0bfKWEC0J44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173129; c=relaxed/simple;
	bh=+QC8WCxfGqhRmoMuzPSArUDy0kgmehhB1gWLDEEcjf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qc6BWA4dgVPWF9n1B5uyBn6s7ml/vV6rSRkeu6R2b+wJTLAaBU7WoKEsvdxEPmE6lJFUGB1pR9XM53+u+OX+n2Lsh49kwJf8k1CtD262QzuY4Z2CZEJN8LSsQrW3yO1C6lN2/kzYJ6rD/Y5OoSitmiG5j3r2RO9I6U20frPEX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m/Q1LhPC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uF8JIxjy5aR+l38o23/kghoy+Tugnu4jphYuZf7Sd0E=; b=m/Q1LhPC2/vHTSRu90DWvDptL5
	BKQMoE7BL5NkeXAax6P9Yv8CPEYpHoiimUbS48P6z7/UaStZmi3exEaCGCxntBxKnEwJjDTnI5VJP
	Hf/ZvL0N6tR+UAfkRsSsa0kOyxZryKyVHCuJ+SxCxuef8kZRlV6Ym+mhT7BEBLe/BosuzkrdLBmOZ
	nsnk9cVwIBEe3hI5Yr0oDGINfAcHWHBX17YJwjH2PzML7Wnv4py4ZII5IEDM6VZuzb+pM1vr/GPre
	prsVBlnIAvbyHoHFjjv3sboVrNToPf28igDzhaChDmBlBkJfOdLkdbj3l9AHoxNZ8CoaNeULCDXY4
	vuN06pFA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZG-007QKS-21;
	Thu, 25 Jan 2024 08:58:39 +0000
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
Subject: [PATCH 09/19] writeback: Simplify the loops in write_cache_pages()
Date: Thu, 25 Jan 2024 09:57:48 +0100
Message-Id: <20240125085758.2393327-10-hch@lst.de>
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

Collapse the two nested loops into one.  This is needed as a step
towards turning this into an iterator.

Note that this drops the "index <= end" check in the previous outer loop
and just relies on filemap_get_folios_tag() to return 0 entries when
index > end.  This actually has a subtle implication when end == -1
because then the returned index will be -1 as well and thus if there is
page present on index -1, we could be looping indefinitely. But as the
comment in filemap_get_folios_tag documents this as already broken anyway
we should not worry about it here either.  The fix for that would
probably a change to the filemap_get_folios_tag() calling convention.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: updated the commit log based on feedback from Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 94 ++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cec683c7217d2e..d6ac414ddce9ca 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2475,6 +2475,7 @@ int write_cache_pages(struct address_space *mapping,
 {
 	int error;
 	pgoff_t end;		/* Inclusive */
+	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2489,63 +2490,60 @@ int write_cache_pages(struct address_space *mapping,
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	while (wbc->index <= end) {
-		int i;
-
-		writeback_get_batch(mapping, wbc);
+	for (;;) {
+		struct folio *folio;
+		unsigned long nr;
 
+		if (i == wbc->fbatch.nr) {
+			writeback_get_batch(mapping, wbc);
+			i = 0;
+		}
 		if (wbc->fbatch.nr == 0)
 			break;
 
-		for (i = 0; i < wbc->fbatch.nr; i++) {
-			struct folio *folio = wbc->fbatch.folios[i];
-			unsigned long nr;
+		folio = wbc->fbatch.folios[i++];
 
-			folio_lock(folio);
-			if (!folio_prepare_writeback(mapping, wbc, folio)) {
-				folio_unlock(folio);
-				continue;
-			}
+		folio_lock(folio);
+		if (!folio_prepare_writeback(mapping, wbc, folio)) {
+			folio_unlock(folio);
+			continue;
+		}
 
-			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 
-			error = writepage(folio, wbc, data);
-			nr = folio_nr_pages(folio);
-			wbc->nr_to_write -= nr;
+		error = writepage(folio, wbc, data);
+		nr = folio_nr_pages(folio);
+		wbc->nr_to_write -= nr;
 
-			/*
-			 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return
-			 * value.  Eventually all instances should just unlock
-			 * the folio themselves and return 0;
-			 */
-			if (error == AOP_WRITEPAGE_ACTIVATE) {
-				folio_unlock(folio);
-				error = 0;
-			}
-		
-			if (error && !wbc->err)
-				wbc->err = error;
+		/*
+		 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
+		 * Eventually all instances should just unlock the folio
+		 * themselves and return 0;
+		 */
+		if (error == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			error = 0;
+		}
 
-			/*
-			 * For integrity sync  we have to keep going until we
-			 * have written all the folios we tagged for writeback
-			 * prior to entering this loop, even if we run past
-			 * wbc->nr_to_write or encounter errors.  This is
-			 * because the file system may still have state to clear
-			 * for each folio.   We'll eventually return the first
-			 * error encountered.
-			 *
-			 * For background writeback just push done_index past
-			 * this folio so that we can just restart where we left
-			 * off and media errors won't choke writeout for the
-			 * entire file.
-			 */
-			if (wbc->sync_mode == WB_SYNC_NONE &&
-			    (wbc->err || wbc->nr_to_write <= 0)) {
-				writeback_finish(mapping, wbc,
-						folio->index + nr);
-				return error;
-			}
+		if (error && !wbc->err)
+			wbc->err = error;
+
+		/*
+		 * For integrity sync  we have to keep going until we have
+		 * written all the folios we tagged for writeback prior to
+		 * entering this loop, even if we run past wbc->nr_to_write or
+		 * encounter errors.  This is because the file system may still
+		 * have state to clear for each folio.   We'll eventually return
+		 * the first error encountered.
+		 *
+		 * For background writeback just push done_index past this folio
+		 * so that we can just restart where we left off and media
+		 * errors won't choke writeout for the entire file.
+		 */
+		if (wbc->sync_mode == WB_SYNC_NONE &&
+		    (wbc->err || wbc->nr_to_write <= 0)) {
+			writeback_finish(mapping, wbc, folio->index + nr);
+			return error;
 		}
 	}
 
-- 
2.39.2


