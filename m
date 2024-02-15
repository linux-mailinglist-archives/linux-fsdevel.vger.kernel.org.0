Return-Path: <linux-fsdevel+bounces-11647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B68855A91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C581F2CCEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168AD29E;
	Thu, 15 Feb 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGTJ9HLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF1C17742;
	Thu, 15 Feb 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979038; cv=none; b=kXMVEQ0TF9fyDDjpQxiHNA4a3fFcE+47CbNuo1j9x5wK5s/s24Mk1TORvO7uZMRumVYQCRrh/kwOvb4qDuuyaaZDoFfsnG8oujmEB3tu5U1E4JlwNRt263xHqoFloryYj3JT1TwQFrXqaYwygFu2FS2BkAi43Jtb+72lwshInqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979038; c=relaxed/simple;
	bh=U2rS9/K1coWZ56MO+WKtKLhXT+/Cb7NdBdAn2GCoYRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6RzW1FwEyrrGrJ/MK26ponood3QT1k6q/HcliizTw9isI5r5KjuiUVY6+oM5cvgySZNoEA9IF41XNgvB571hDee/zotvTFvK+hWAq8MMU+o4jFJRfWkP85lvQq7wMQRfO+iBi1UPpYO/Xhr3892g9hsPO+3rWWo1oGJTtT1UJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GGTJ9HLd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rJ/bHu0SmYtGFgvaRb+fv4HTWCusH5CJuQRO0eXVfZ0=; b=GGTJ9HLdBqJtjEDdAZPFyCXJKz
	5OpCGv6U6mxH7l0ON1NV9hf/LGAvWPmgLT5xEtpqFEdbTb3JgxbZtpqS6QErp9Yn7+xFzbLI5X8Gy
	Kf/P1l06aiZEP55CJiJ/1dn82k66gidI9kL49JKCNwGP0FmjQLuAYAaSB4pTo5WloYMO5+NumsjRB
	0U6k9DH+J1Dg67Xev9cQ1i4nBYi7tNwUyF3AcqlRBNqUINiRl+AdCmdy0Gv9to8alx4PFHbzgtWqo
	3gs1KYgVW425l2kLMfdn98G37mY25LpqEV+C07/CBp/lAPCNv7QImxzejpnNHH6nTNXu+iu9/sGGI
	xs1Epexg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVMv-0000000F6ss-1jAV;
	Thu, 15 Feb 2024 06:37:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 06/14] writeback: rework the loop termination condition in write_cache_pages
Date: Thu, 15 Feb 2024 07:36:41 +0100
Message-Id: <20240215063649.2164017-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215063649.2164017-1-hch@lst.de>
References: <20240215063649.2164017-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Rework the way we deal with the cleanup after the writepage call.

First handle the magic AOP_WRITEPAGE_ACTIVATE separately from real error
returns to get it out of the way of the actual error handling path.

The split the handling on intgrity vs non-integrity branches first,
and return early using a goto for the non-ingegrity early loop condition
to remove the need for the done and done_index local variables, and for
assigning the error to ret when we can just return error directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 84 ++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f02014007b57cc..3a1e23bed4052c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2396,13 +2396,12 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int ret = 0;
-	int done = 0;
 	int error;
 	struct folio_batch fbatch;
+	struct folio *folio;
 	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	pgoff_t done_index;
 	xa_mark_t tag;
 
 	folio_batch_init(&fbatch);
@@ -2419,8 +2418,7 @@ int write_cache_pages(struct address_space *mapping,
 	} else {
 		tag = PAGECACHE_TAG_DIRTY;
 	}
-	done_index = index;
-	while (!done && (index <= end)) {
+	while (index <= end) {
 		int i;
 
 		nr_folios = filemap_get_folios_tag(mapping, &index, end,
@@ -2430,11 +2428,7 @@ int write_cache_pages(struct address_space *mapping,
 			break;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
-			unsigned long nr;
-
-			done_index = folio->index;
-
+			folio = fbatch.folios[i];
 			folio_lock(folio);
 
 			/*
@@ -2469,45 +2463,32 @@ int write_cache_pages(struct address_space *mapping,
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 			error = writepage(folio, wbc, data);
-			nr = folio_nr_pages(folio);
-			wbc->nr_to_write -= nr;
-			if (unlikely(error)) {
-				/*
-				 * Handle errors according to the type of
-				 * writeback. There's no need to continue for
-				 * background writeback. Just push done_index
-				 * past this page so media errors won't choke
-				 * writeout for the entire file. For integrity
-				 * writeback, we must process the entire dirty
-				 * set regardless of errors because the fs may
-				 * still have state to clear for each page. In
-				 * that case we continue processing and return
-				 * the first error.
-				 */
-				if (error == AOP_WRITEPAGE_ACTIVATE) {
-					folio_unlock(folio);
-					error = 0;
-				} else if (wbc->sync_mode != WB_SYNC_ALL) {
-					ret = error;
-					done_index = folio->index + nr;
-					done = 1;
-					break;
-				}
-				if (!ret)
-					ret = error;
+			wbc->nr_to_write -= folio_nr_pages(folio);
+
+			if (error == AOP_WRITEPAGE_ACTIVATE) {
+				folio_unlock(folio);
+				error = 0;
 			}
 
 			/*
-			 * We stop writing back only if we are not doing
-			 * integrity sync. In case of integrity sync we have to
-			 * keep going until we have written all the pages
-			 * we tagged for writeback prior to entering this loop.
+			 * For integrity writeback we have to keep going until
+			 * we have written all the folios we tagged for
+			 * writeback above, even if we run past wbc->nr_to_write
+			 * or encounter errors.
+			 * We stash away the first error we encounter in
+			 * wbc->saved_err so that it can be retrieved when we're
+			 * done.  This is because the file system may still have
+			 * state to clear for each folio.
+			 *
+			 * For background writeback we exit as soon as we run
+			 * past wbc->nr_to_write or encounter the first error.
 			 */
-			done_index = folio->index + nr;
-			if (wbc->nr_to_write <= 0 &&
-			    wbc->sync_mode == WB_SYNC_NONE) {
-				done = 1;
-				break;
+			if (wbc->sync_mode == WB_SYNC_ALL) {
+				if (error && !ret)
+					ret = error;
+			} else {
+				if (error || wbc->nr_to_write <= 0)
+					goto done;
 			}
 		}
 		folio_batch_release(&fbatch);
@@ -2524,14 +2505,15 @@ int write_cache_pages(struct address_space *mapping,
 	 * of the file if we are called again, which can only happen due to
 	 * -ENOMEM from the file system.
 	 */
-	if (wbc->range_cyclic) {
-		if (done)
-			mapping->writeback_index = done_index;
-		else
-			mapping->writeback_index = 0;
-	}
-
+	if (wbc->range_cyclic)
+		mapping->writeback_index = 0;
 	return ret;
+
+done:
+	if (wbc->range_cyclic)
+		mapping->writeback_index = folio->index + folio_nr_pages(folio);
+	folio_batch_release(&fbatch);
+	return error;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


