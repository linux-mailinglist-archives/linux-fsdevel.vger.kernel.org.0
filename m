Return-Path: <linux-fsdevel+bounces-42481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5848A42AA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931E77A763D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDCB265CD4;
	Mon, 24 Feb 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F1QHePDH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174E265603
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420336; cv=none; b=eSCvQ1oEYKwm17ymffO89wEVgBdeYfDjG0MvX823aMKxgdrKOGgLt+Md3nljkW1rY0gL3bcLJBiROvVH+nx3B1NijdsiVwQrVHkECcasts04bLSUm8rpjgjn5ZURl1yrpUZ6RcQPSzm7Nh/RcdR61elP3gVraj2j5Adg+LCznjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420336; c=relaxed/simple;
	bh=yGGjdX9HvJRAEkjkwLPdlp7qlZfB667cDjZxQg9TTlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nF057WXoOXXkB2xP2Q5k2Oh2SjGFCAKIFgu7WjpQ4WYjRixlShMBgd/YFTGMvKIziV3I5R63z190rDVDGHtBnZIqLmXw1/prqj4C2S5v6buRZpLWkBd3vRl59NiWM/OabJ486iP4yfEgEMIzJqXdNPLTDIIM7PvcHudAG0f7zbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F1QHePDH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=i8KrJFZirtzTPYZjDNis+V3O7zfYTDu7Pud1q33pqiE=; b=F1QHePDH9Uh1jti3wA0FRNovJB
	stzlyOw1vSbgDdhCU+EV3XuT6XTTudxa8zVBRda7Pr8j3xkXGV6wLIp7Wp42uce7A8BFPqvX5xiyX
	lgHdHWGhwHfdJoCyqOSIsyl2po1wZiMW3iijTqkiKJ7uEo0jcGErqiECluBVTXa1wb3nuocLS0UsB
	LNMW6yaydyoTW/r+dZydNjSEdz1A6IYwrNC2F8PPjyNtJzR4EEcU1KuL8/6cl3kgK+b1Bn/vToPlp
	3UX5m9bxKKpV/X5qBEmIitx90o35W/K9ceBstW0Cic52SVyxB5k7hxaQaBMP6NN12PsGTKMM/2VSH
	+jAu8GCA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcpg-000000082g2-2W3M;
	Mon, 24 Feb 2025 18:05:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] orangefs: Convert orangefs_writepage_locked() to take a folio
Date: Mon, 24 Feb 2025 18:05:23 +0000
Message-ID: <20250224180529.1916812-6-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180529.1916812-1-willy@infradead.org>
References: <20250224180529.1916812-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers have a folio, pass it in and use it inside
orangefs_writepage_locked().  Removes a few hidden calls to
compound_head() and accesses to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4ad049d5cc9c..90db1d705fe8 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -16,10 +16,10 @@
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
 
-static int orangefs_writepage_locked(struct page *page,
-    struct writeback_control *wbc)
+static int orangefs_writepage_locked(struct folio *folio,
+		struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct orangefs_write_range *wr = NULL;
 	struct iov_iter iter;
 	struct bio_vec bv;
@@ -27,11 +27,11 @@ static int orangefs_writepage_locked(struct page *page,
 	ssize_t ret;
 	loff_t len, off;
 
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 
 	len = i_size_read(inode);
-	if (PagePrivate(page)) {
-		wr = (struct orangefs_write_range *)page_private(page);
+	if (folio->private) {
+		wr = folio->private;
 		WARN_ON(wr->pos >= len);
 		off = wr->pos;
 		if (off + wr->len > len)
@@ -40,27 +40,27 @@ static int orangefs_writepage_locked(struct page *page,
 			wlen = wr->len;
 	} else {
 		WARN_ON(1);
-		off = page_offset(page);
-		if (off + PAGE_SIZE > len)
+		off = folio_pos(folio);
+		wlen = folio_size(folio);
+
+		if (wlen > len - off)
 			wlen = len - off;
-		else
-			wlen = PAGE_SIZE;
 	}
 	/* Should've been handled in orangefs_invalidate_folio. */
 	WARN_ON(off == len || off + wlen > len);
 
 	WARN_ON(wlen == 0);
-	bvec_set_page(&bv, page, wlen, off % PAGE_SIZE);
+	bvec_set_folio(&bv, folio, wlen, offset_in_folio(folio, off));
 	iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
 	    len, wr, NULL, NULL);
 	if (ret < 0) {
-		mapping_set_error(page->mapping, ret);
+		mapping_set_error(folio->mapping, ret);
 	} else {
 		ret = 0;
 	}
-	kfree(detach_page_private(page));
+	kfree(folio_detach_private(folio));
 	return ret;
 }
 
@@ -179,7 +179,7 @@ static int orangefs_writepages_callback(struct folio *folio,
 			orangefs_writepages_work(ow, wbc);
 			ow->npages = 0;
 		}
-		ret = orangefs_writepage_locked(&folio->page, wbc);
+		ret = orangefs_writepage_locked(folio, wbc);
 		mapping_set_error(folio->mapping, ret);
 		folio_unlock(folio);
 		folio_end_writeback(folio);
@@ -474,7 +474,7 @@ static int orangefs_launder_folio(struct folio *folio)
 	};
 	folio_wait_writeback(folio);
 	if (folio_clear_dirty_for_io(folio)) {
-		r = orangefs_writepage_locked(&folio->page, &wbc);
+		r = orangefs_writepage_locked(folio, &wbc);
 		folio_end_writeback(folio);
 	}
 	return r;
-- 
2.47.2


