Return-Path: <linux-fsdevel+bounces-31071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC8991966
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B7B1F2245C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F015958D;
	Sat,  5 Oct 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQuQM+O/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346B1798C;
	Sat,  5 Oct 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152593; cv=none; b=s8Sy2ZGNvmETuKe18BFDa7CMc7iE0pRgnjYtWyouYUPLoLlmLgQpuvruQWNKu7KG7rrKpbvmqrOtn7wNtQo0zxnlzfAckVsXFgrm9kAvee/UAWtNrEeyExtW/zg5jHcmqyYUwcoCfXhSZL/RTesr5900J/COR9r4+JFKcpPDwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152593; c=relaxed/simple;
	bh=Bkfc98jvsr99Q1J+52LHAqxCauq9ipRT7C/V1lH2kyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs0kertE5D1sfHlO6t2EhoUbbSsRrOKc3RiNejP21pWW2mFoe51Ba0cTDSfqGxQ/ADszaiQxEiiONimd415WbTCvpAbLeeQLytvfIUDdCqxrDyPw6HuWQKoatPLmQrJP5ulPdAzXiLTwUc8YpEim+WHmk31oiNSKAMSzLbpzzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dQuQM+O/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=38iyqFmBi6nr0q6R/nMSDCTMhx6kS48rE2gRZaxGkRc=; b=dQuQM+O/cFuQ3lPszMxrC+Uvz9
	19QEI2c0LiTiafw+hmHSp63DUGy3lyZFGACGJYoIyRUdLJe/YpPhqC26CvSqW37PyHo1WRYSjIuft
	Iei3nkq9zeF7zfqX76kgd1/XEtUludoYGlV3yh8uDAXmJ+S5BNpkYb4lIlBv6JG3XUKvKJSdneIub
	H0UYaM6jbp7szkYUU2yFXwKlzRJHJ05rcVuZgULI7ooa7Vje//dcb6JaqhBHPC/EYW+gCyzBWnRcL
	IVa/L9mWKDeHJY+B+96hzPil9ocgcTyw6FJepr57APon/TmBrAvnlBU1pjeMP3Qc7uwA0lTtlUHi/
	yJBopNsA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx9Qs-0000000DNyV-0yLM;
	Sat, 05 Oct 2024 18:23:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] netfs: Remove unnecessary references to pages
Date: Sat,  5 Oct 2024 19:23:05 +0100
Message-ID: <20241005182307.3190401-4-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241005182307.3190401-1-willy@infradead.org>
References: <20241005182307.3190401-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These places should all use folios instead of pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/netfs/buffered_read.c  |  8 ++++----
 fs/netfs/buffered_write.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c40e226053cc..17aaec00002b 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -646,7 +646,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 	if (unlikely(always_fill)) {
 		if (pos - offset + len <= i_size)
 			return false; /* Page entirely before EOF */
-		zero_user_segment(&folio->page, 0, plen);
+		folio_zero_segment(folio, 0, plen);
 		folio_mark_uptodate(folio);
 		return true;
 	}
@@ -665,7 +665,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 
 	return false;
 zero_out:
-	zero_user_segments(&folio->page, 0, offset, offset + len, plen);
+	folio_zero_segments(folio, 0, offset, offset + len, plen);
 	return true;
 }
 
@@ -732,7 +732,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (folio_test_uptodate(folio))
 		goto have_folio;
 
-	/* If the page is beyond the EOF, we want to clear it - unless it's
+	/* If the folio is beyond the EOF, we want to clear it - unless it's
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
@@ -792,7 +792,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 EXPORT_SYMBOL(netfs_write_begin);
 
 /*
- * Preload the data into a page we're proposing to write into.
+ * Preload the data into a folio we're proposing to write into.
  */
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len)
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index ff2814da88b1..b4826360a411 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -83,13 +83,13 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
  * netfs_perform_write - Copy data into the pagecache.
  * @iocb: The operation parameters
  * @iter: The source buffer
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
- * Copy data into pagecache pages attached to the inode specified by @iocb.
+ * Copy data into pagecache folios attached to the inode specified by @iocb.
  * The caller must hold appropriate inode locks.
  *
- * Dirty pages are tagged with a netfs_folio struct if they're not up to date
- * to indicate the range modified.  Dirty pages may also be tagged with a
+ * Dirty folios are tagged with a netfs_folio struct if they're not up to date
+ * to indicate the range modified.  Dirty folios may also be tagged with a
  * netfs-specific grouping such that data from an old group gets flushed before
  * a new one is started.
  */
@@ -223,11 +223,11 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * we try to read it.
 		 */
 		if (fpos >= ctx->zero_point) {
-			zero_user_segment(&folio->page, 0, offset);
+			folio_zero_segment(folio, 0, offset);
 			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
 			if (unlikely(copied == 0))
 				goto copy_failed;
-			zero_user_segment(&folio->page, offset + copied, flen);
+			folio_zero_segment(folio, offset + copied, flen);
 			__netfs_set_group(folio, netfs_group);
 			folio_mark_uptodate(folio);
 			trace_netfs_folio(folio, netfs_modify_and_clear);
@@ -407,7 +407,7 @@ EXPORT_SYMBOL(netfs_perform_write);
  * netfs_buffered_write_iter_locked - write data to a file
  * @iocb:	IO state structure (file, offset, etc.)
  * @from:	iov_iter with data to write
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
  * This function does all the work needed for actually writing data to a
  * file. It does all basic checks, removes SUID from the file, updates
-- 
2.43.0


