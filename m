Return-Path: <linux-fsdevel+bounces-8846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA39C83BC7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B4D1C2626C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3991BF5B;
	Thu, 25 Jan 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eLUk9fi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03421BF45;
	Thu, 25 Jan 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173105; cv=none; b=a8VjLZgOyNLy3cri+fRg/dDDiOIUJCScXxzV0WdYC+ixvbpXnDvDaXFl9KVtA80NgI260j6J1M6VtymTDjIW7SXTOBrWwXcXAWnu3DfuWycoHm6oz7wV7UjzuEReXnFXF4I7aFrAaXYa8Rv0nk2cTp6Rs6N8OcdWbEWxxmydF/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173105; c=relaxed/simple;
	bh=hzS0BoSMLypvHLXEl5/9NFfG6nKnH4cz3IBwzSS/0fY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPvYWZoZNFihw40OfvFcEDy0Bhe7g+Cd0QjXwCEw+HZ1ebX/FLp6eACsizMxK0tZIBpvrTK0ndbFBJj+timO8pVaCYJACohf5wR3QKWVwgCmS8OmvTT4GSK6FpXzcfy4++fNPVH8gO5G7uaJGJlPmcuFB4gKdh/u3jzq0IPYSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eLUk9fi9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/IByKLVlZu2F9wnx0I/UOWkm2jwSLHoNKmPo511TdLQ=; b=eLUk9fi9CgDuij9FcAeuvwTARz
	8KJIalgD3lOvEQm62ev1whPRxGCnYvwgCXnYzGxY1Z6XK6kDAd0yo6bkm/gDeVk4+WaNIWOruRjDR
	+PJz06AgPTbEXqLs6VfmjRGGKBwIEbksUcd/Ru6/Y/JbLCVPoWmLWB0G2xnFny5y3sNQS9CbxmziL
	vBeQXKMKuN80WJXNn3pF4wB7Sq7vQUp6A4jX8BqdR2HVFnfnseHhUI+shRy1FgbiGcOHEaPeKL7Ol
	8NQzQW3x+PqYfF4RYL4DqXwQnSf3SROFvkZuWlvr4ns6fBtbtLuO793R5ioUD12tlhVWFya9qiyKG
	rFxgu+YQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvYs-007QBY-2m;
	Thu, 25 Jan 2024 08:58:15 +0000
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
Subject: [PATCH 03/19] writeback: rework the loop termination condition in write_cache_pages
Date: Thu, 25 Jan 2024 09:57:42 +0100
Message-Id: <20240125085758.2393327-4-hch@lst.de>
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

Rework the way we deal with the cleanup after the writepage call.

First handle the magic AOP_WRITEPAGE_ACTIVATE separately from real error
returns to get it out of the way of the actual error handling path.
Then merge the code to set ret for integrity vs non-integrity writeback.
For non-integrity writeback the loop is terminated on the first error, so
ret will never be non-zero.  Then use a single block to check for
non-integrity writewack to consolidate the cases where it returns for
either an error or running off the end of nr_to_write.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 62 +++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0c1e9c016bc48f..259c37bc34d2a7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2474,43 +2474,39 @@ int write_cache_pages(struct address_space *mapping,
 			error = writepage(folio, wbc, data);
 			nr = folio_nr_pages(folio);
 			wbc->nr_to_write -= nr;
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
+
+			/*
+			 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return
+			 * value.  Eventually all instances should just unlock
+			 * the folio themselves and return 0;
+			 */
+			if (error == AOP_WRITEPAGE_ACTIVATE) {
+				folio_unlock(folio);
+				error = 0;
 			}
 
 			/*
-			 * We stop writing back only if we are not doing
-			 * integrity sync. In case of integrity sync we have to
-			 * keep going until we have written all the pages
-			 * we tagged for writeback prior to entering this loop.
+			 * For integrity sync  we have to keep going until we
+			 * have written all the folios we tagged for writeback
+			 * prior to entering this loop, even if we run past
+			 * wbc->nr_to_write or encounter errors.  This is
+			 * because the file system may still have state to clear
+			 * for each folio.   We'll eventually return the first
+			 * error encountered.
+			 *
+			 * For background writeback just push done_index past
+			 * this folio so that we can just restart where we left
+			 * off and media errors won't choke writeout for the
+			 * entire file.
 			 */
-			done_index = folio->index + nr;
-			if (wbc->nr_to_write <= 0 &&
-			    wbc->sync_mode == WB_SYNC_NONE) {
-				done = 1;
-				break;
+			if (error && !ret)
+				ret = error;
+			if (wbc->sync_mode == WB_SYNC_NONE) {
+				if (ret || wbc->nr_to_write <= 0) {
+					done_index = folio->index + nr;
+					done = 1;
+					break;
+				}
 			}
 		}
 		folio_batch_release(&fbatch);
-- 
2.39.2


