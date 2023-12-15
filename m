Return-Path: <linux-fsdevel+bounces-6215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4808150C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286F6286A40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F167E78;
	Fri, 15 Dec 2023 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eCGDYeSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A01563B5;
	Fri, 15 Dec 2023 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SCryoIsThT1F2D/n8Lhi4Jv7COeVsife5aCkou7x9Bc=; b=eCGDYeSt9PCLn0V6USNBSuUOiJ
	9tz1Ngb/YuMDZJR/S7oHDoEQrlMShjf4X5PlnYMHT5HcK4ItcnpGMiAPGEV4WgYvdI8Bpti/NRbq8
	7wPzUAwjW4ddyf+o2Vm5X3E5mp13Jh2td2CMVnN+0VgHizYSYCchr1GOB2zNxTWCsGjSgILGUAGs/
	/QWg32SkO8XGYsYotHsjxH9zfe/I33oXv9Dpym9mAqYZ2wdLZqLvy1a19zcWIXmhFrw9DHtncKD/2
	q/v8t0mby8FoaMV10K0hzLdxXPl1YtOvbJncVj6PrZYZW9NNpJ9myN7pEwQsnHnM8LeD6+wVFns/a
	ulHDJMeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038jK-Va; Fri, 15 Dec 2023 20:02:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 10/14] ocfs2: Remove writepage implementation
Date: Fri, 15 Dec 2023 20:02:41 +0000
Message-Id: <20231215200245.748418-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the filesystem implements migrate_folio and writepages, there is
no need for a writepage implementation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/aops.c        | 15 ++++++---------
 fs/ocfs2/ocfs2_trace.h |  2 --
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 795997806326..b82185075de7 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -389,21 +389,18 @@ static void ocfs2_readahead(struct readahead_control *rac)
 /* Note: Because we don't support holes, our allocation has
  * already happened (allocation writes zeros to the file data)
  * so we don't have to worry about ordered writes in
- * ocfs2_writepage.
+ * ocfs2_writepages.
  *
- * ->writepage is called during the process of invalidating the page cache
+ * ->writepages is called during the process of invalidating the page cache
  * during blocked lock processing.  It can't block on any cluster locks
  * to during block mapping.  It's relying on the fact that the block
  * mapping can't have disappeared under the dirty pages that it is
  * being asked to write back.
  */
-static int ocfs2_writepage(struct page *page, struct writeback_control *wbc)
+static int ocfs2_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	trace_ocfs2_writepage(
-		(unsigned long long)OCFS2_I(page->mapping->host)->ip_blkno,
-		page->index);
-
-	return block_write_full_page(page, ocfs2_get_block, wbc);
+	return mpage_writepages(mapping, wbc, ocfs2_get_block);
 }
 
 /* Taken from ext3. We don't necessarily need the full blown
@@ -2471,7 +2468,7 @@ const struct address_space_operations ocfs2_aops = {
 	.dirty_folio		= block_dirty_folio,
 	.read_folio		= ocfs2_read_folio,
 	.readahead		= ocfs2_readahead,
-	.writepage		= ocfs2_writepage,
+	.writepages		= ocfs2_writepages,
 	.write_begin		= ocfs2_write_begin,
 	.write_end		= ocfs2_write_end,
 	.bmap			= ocfs2_bmap,
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index ac4fd1d5b128..9898c11bdfa1 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -1157,8 +1157,6 @@ DEFINE_OCFS2_ULL_ULL_EVENT(ocfs2_get_block_end);
 
 DEFINE_OCFS2_ULL_ULL_EVENT(ocfs2_readpage);
 
-DEFINE_OCFS2_ULL_ULL_EVENT(ocfs2_writepage);
-
 DEFINE_OCFS2_ULL_ULL_EVENT(ocfs2_bmap);
 
 TRACE_EVENT(ocfs2_try_to_write_inline_data,
-- 
2.42.0


