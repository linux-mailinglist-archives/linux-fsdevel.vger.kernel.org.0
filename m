Return-Path: <linux-fsdevel+bounces-42306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCC4A40131
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623303B15B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918B202F80;
	Fri, 21 Feb 2025 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFWKTr7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE911D7E2F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170377; cv=none; b=q5/0xt9Q80OAC54joLjJNAZq743GG8rA51+aV6xgwRcWGHRGBBZC+bvpGQkkjInzrfcvvcBQB3uGZqpa/Sr2+lrASAISS6w6tGst5MY30/RWX7TjCLhItW2h7DTH8q1HTJI9kFEDHfQ5CMhdTrMsybRh0v2abtIf8IqMrS4RR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170377; c=relaxed/simple;
	bh=CKaHHsC/+5opx4Q7G+8Xz5B5zLt2kTRecL762gLPuyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFri/PPMGtRgH5dui4gsYJzSTfIFIwH0NxNv9dLPI1Ecq4zaYr4ZVCkMieCCuKj+716mD/YH/HU5CzrR1YEAYqkwP7thxim7AsoglhgdF+KoSxMAWd67suqhoPA6XC9XIm2Pfo1xPh9vdHt3mGkZcnwrdYuxigzt/zj8u1I3x8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QFWKTr7m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5xelXJT1cxcXBZdOywuwjuLun79Us6FI7LK9tha04ys=; b=QFWKTr7mJjSU0oEsxue+07qOlH
	MiiUIRIo8w9I0EBP1RuehgziyKjDJPa37SZf0ZML0lSLbs7dRQAIx3Y80XVZEvabFyArQUt0QsOi4
	Rft7KqU7A4Socwn9pJV9RTUuIODBv47yTbBBlvtAUqyLWQ2P4MktzHCUqvulnvb3AkdAwyhrio0DC
	YdsY6wXU7HAp4lWfKlxqhx6jGcWM1DhL2Fg195p4AauIvBOYGzBq+yqhqqjZDCJ36GAC+TEPUExE0
	OLSYSF+esjDA8fMB+p9RpLZlIZKzl3FIWWhfbVlVD4oNxm06zrai2HQGOV1VO1CndxXAzY0WuSy34
	/XUgNJHA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlZo6-0000000F3bK-1uY8;
	Fri, 21 Feb 2025 20:39:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: Turn page_offset() into a wrapper around folio_pos()
Date: Fri, 21 Feb 2025 20:39:29 +0000
Message-ID: <20250221203932.3588740-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is far less efficient for the lagging filesystems which still
use page_offset(), but it removes an access to page->index.  It also
fixes a bug -- if any filesystem passed a tail page to page_offset(),
it would return garbage which might result in the filesystem choosing
to not writeback a dirty page.  There probably aren't any examples
of this, but I can't be certain.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ad7c0f615e9b..8c52a637d42b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1019,21 +1019,23 @@ static inline pgoff_t page_pgoff(const struct folio *folio,
 	return folio->index + folio_page_idx(folio, page);
 }
 
-/*
- * Return byte-offset into filesystem object for page.
+/**
+ * folio_pos - Returns the byte position of this folio in its file.
+ * @folio: The folio.
  */
-static inline loff_t page_offset(struct page *page)
+static inline loff_t folio_pos(const struct folio *folio)
 {
-	return ((loff_t)page->index) << PAGE_SHIFT;
+	return ((loff_t)folio->index) * PAGE_SIZE;
 }
 
-/**
- * folio_pos - Returns the byte position of this folio in its file.
- * @folio: The folio.
+/*
+ * Return byte-offset into filesystem object for page.
  */
-static inline loff_t folio_pos(struct folio *folio)
+static inline loff_t page_offset(struct page *page)
 {
-	return page_offset(&folio->page);
+	struct folio *folio = page_folio(page);
+
+	return folio_pos(folio) + folio_page_idx(folio, page) * PAGE_SIZE;
 }
 
 /*
-- 
2.47.2


