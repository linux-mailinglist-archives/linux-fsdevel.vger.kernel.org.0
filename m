Return-Path: <linux-fsdevel+bounces-43302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC59A50CCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37E21893111
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49458257ADB;
	Wed,  5 Mar 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QzEX8hLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2051254849
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207661; cv=none; b=CNJ9IjBDLMeBdc6anCRhBNr6Sh2SXVEjcaSpAZju2YvXsaRWrRZEK34CyIHjjZAW+LiLLBxJ+L2W655SuKHduoYTRX6WHFjU9//klqboIGiUFPPn+gZK1v8v7nf824svoxPTcqdYpAT316a34es+Yk7AS24ptOgsJDMi24RTvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207661; c=relaxed/simple;
	bh=q81xkYVbvPKp6+CumDq/mTmccOLJ9q4eur+z/OV7NsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX7SczIjIvfKlrFmI1y4rnXEpZi0eqiU5xP7XhAQB/emXUcA62mp/eUr5ugJ1JRhf8s/1ML9ak2SzHkX3DqRnBDV5t5AKTbjD01uTSq9c4SvrZ4LikI4ec59ciK1f6EXqFFM/8ONMTArbBQuCj+9EHX59rQu924ZqSWOtmhM+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QzEX8hLG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RY60+f7rCMnrhQSH6beFMGF4z+iQ/ynB4ypXkrWpyxQ=; b=QzEX8hLGOMhTyYi4bMKTc8egca
	QPOxQMiiYAPzd2KnWs0dKXxDU4AFrh8v5UU4+UgOHaJDz2/hGx4K8aD3AmbWTkd425GGuApNe0VSI
	dRvUGp4NlPYxnm86zX5xT+9ZCI72s+k6Z93GfmcRMtsHOW/szkUbVO79mQsh8H8JNriDxKXZeQ69N
	fsI/3xOL+K8pcJ+YpU/Wfp6ctsrOR8IUSZzhLxYC273t+FTN8+0v2sK9mdqV0KDlpL0+Javf2yDMj
	Iss/M0Y5yYbc//8R8JUHKKN9NrIS9WEqi4/3+C9yPJw7NN/r0r+7GK9lDIeelb4/hgNLu0SNDH+Cf
	1DeN+5wg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveT-00000006BnF-1X8a;
	Wed, 05 Mar 2025 20:47:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 5/9] orangefs: Convert orangefs_writepage_locked() to take a folio
Date: Wed,  5 Mar 2025 20:47:29 +0000
Message-ID: <20250305204734.1475264-6-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
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
Tested-by: Mike Marshall <hubcap@omnibond.com>
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


