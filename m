Return-Path: <linux-fsdevel+bounces-41950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED7A39338
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EFA1891A67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663C1C75E2;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZKxBPk0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC811B4250
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857931; cv=none; b=Pzh14BZLhCJIYQgVZPzUV02PeXu0dSGaxwJC4zQivwuYGo14i07WaOoCDeAAXC5Etn/rQgs7baiWt36mvZwKIxnH9x9bsvKaJgGVpf2DU0SjidvURkOezOB6tE1ODAAgAWw4eX3sfHImpSHfD4OkA60gkz5bbfptQXr9drJw90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857931; c=relaxed/simple;
	bh=Bg51OPNOfxihQohcXlX2I3Ef0asxs7kqlI1KmOoT7mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axJbQKrhmI4rkTQChYgEHARNMcL5QNL4RAkkOrZf3Eq5ntLPqgHJ4gOiqWYF/YQlCCLw+Fkvq6HhsJ1Ibcpn4WStIJzjueervuZFFaTwEVA88ZCw1ZsXsP97yWxHfubevihsBBDgWDKzq+LNqpXn7D3Xqi64RKe+YeSF+fpme8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZKxBPk0C; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rWNu7qNlUy9eZpc8cnoo4lLYHZu+JSVNKjH/qLD5qHg=; b=ZKxBPk0C5i9y6fJB6p1xOoTcux
	CDpKSdoQD/3ZdIR86vKSGfMwCIA/R81dH4J3nqemUZLO/Z4XEolqXwVI4knG3b9RcIoY4D/RGb5Z3
	X2vlOhuVS7vtNWwJSCLWHjbntPkPW+vClxD2CrP01QVsdhU9V8ZpSJaFyTkkG/ZBHsPV9hHy21gLp
	OIoSNtN/9Hqm2bEYp6CIyJfUmAZWDjJTdR0aKCSW7RRSIuoVy136Mvt0y/urWjY83skxnnMLkuXFN
	d8tFwIniWHIqxj3K7ZRGeKA0AXswCjt9wNzqbCGtn1PyQbNPRGXIiCthNFV8styd7FSZjps7qZ5AS
	ZW3ZTd5A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWe-00000002Tt1-0EvV;
	Tue, 18 Feb 2025 05:52:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/27] f2fs: Use a folio throughout __get_meta_page()
Date: Tue, 18 Feb 2025 05:51:53 +0000
Message-ID: <20250218055203.591403-20-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use f2fs_grab_cache_folio() to get a folio and use it throughout,
removing seven calls to compound_head() and a reference to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bd890738b94d..75b7196d2c81 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -58,7 +58,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 							bool is_meta)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	struct page *page;
+	struct folio *folio;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.type = META,
@@ -74,37 +74,37 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	if (unlikely(!is_meta))
 		fio.op_flags &= ~REQ_META;
 repeat:
-	page = f2fs_grab_cache_page(mapping, index, false);
-	if (!page) {
+	folio = f2fs_grab_cache_folio(mapping, index, false);
+	if (IS_ERR(folio)) {
 		cond_resched();
 		goto repeat;
 	}
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		goto out;
 
-	fio.page = page;
+	fio.page = &folio->page;
 
 	err = f2fs_submit_page_bio(&fio);
 	if (err) {
-		f2fs_put_page(page, 1);
+		f2fs_folio_put(folio, true);
 		return ERR_PTR(err);
 	}
 
 	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE);
 
-	lock_page(page);
-	if (unlikely(page->mapping != mapping)) {
-		f2fs_put_page(page, 1);
+	folio_lock(folio);
+	if (unlikely(folio->mapping != mapping)) {
+		f2fs_folio_put(folio, true);
 		goto repeat;
 	}
 
-	if (unlikely(!PageUptodate(page))) {
-		f2fs_handle_page_eio(sbi, page_folio(page), META);
-		f2fs_put_page(page, 1);
+	if (unlikely(!folio_test_uptodate(folio))) {
+		f2fs_handle_page_eio(sbi, folio, META);
+		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
 	}
 out:
-	return page;
+	return &folio->page;
 }
 
 struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
-- 
2.47.2


