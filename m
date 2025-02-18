Return-Path: <linux-fsdevel+bounces-41942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA33A39331
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3BA189153D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC61BEF7D;
	Tue, 18 Feb 2025 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H8av33G5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC91B21B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857930; cv=none; b=q+0B0e2kcL7Qcf3dPZ2tT8ThpV0Lwh3TXciKg3RIWrMdpYjdNymJHoCSKwwSXFitQTbjil2KVGmrCYSCJTSwXuU78Vh0gXhjwE+OYH57N0jVMFuytskjCxQMzq76fD817mHSw+32uflZs1gnVBMY5XqYVTuOtHYUmEprhLcRiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857930; c=relaxed/simple;
	bh=ihD1JsfMHTejjC1G6/Wghd/s4DIrWbas2w6/cnmu9+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT68RNIge/cXI/WC7y1heV6uzCgCvi2d7AgjQIPt4VyqQEWF7mb/F0gyZiFi03ucDrYponFf1YY/TcSXau/QQkcEsNs1p+iPvBWBfNO53NG5dmxPJgISI/UseAeBpem1oXdhqLSwzEwHBiwuT+1bwzIVRbdY477WoxGrBP2ljrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H8av33G5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=H7K6EgfIuRiAX6QHX/BrtdqUN7aF97jkMBhws3XTybU=; b=H8av33G5aXoCXRyGOWcXbPS/Cq
	IkFprusrFl1Wry6Fv3WjSyxf0hDovUt15KTNu14XZAen0BxBztBQz+1Mz6hisgjhdPd02vP3PtQHU
	A6I0rU+LteCkg/0pOkyG8etBmR9V714sJnKEGB3+EjmH3y00c2cFt50stDwU+/kh9EGxUp89sRawu
	0ueoQkj5zXe2O70vJiBmP1t1RAzGyoWNwaYUl1Lt1wSK27rFf2yTKcbx5AZLvKw1055k8r8BRwxJ1
	qp9l7cn0D0G8gQ05wd8JmyMnEfdoEEcWL2T/dJZS+6jLtWvBkCXzCx0PnZh0cHy0kz7lfUlT2xOTz
	6Mqa28Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWc-00000002TsC-3jwt;
	Tue, 18 Feb 2025 05:52:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/27] f2fs: Use a folio in __get_node_page()
Date: Tue, 18 Feb 2025 05:51:46 +0000
Message-ID: <20250218055203.591403-13-willy@infradead.org>
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

Retrieve a folio from the page cache and use it throughout.  Saves six
hidden calls to compound_head() and removes a reference to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1bd151d71b6b..db97624e30b3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1452,7 +1452,7 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 					struct page *parent, int start)
 {
-	struct page *page;
+	struct folio *folio;
 	int err;
 
 	if (!nid)
@@ -1460,11 +1460,11 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (f2fs_check_nid_range(sbi, nid))
 		return ERR_PTR(-EINVAL);
 repeat:
-	page = f2fs_grab_cache_page(NODE_MAPPING(sbi), nid, false);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
+	folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), nid, false);
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
 
-	err = read_node_page(page, 0);
+	err = read_node_page(&folio->page, 0);
 	if (err < 0) {
 		goto out_put_err;
 	} else if (err == LOCKED_PAGE) {
@@ -1475,40 +1475,40 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (parent)
 		f2fs_ra_node_pages(parent, start + 1, MAX_RA_NODE);
 
-	lock_page(page);
+	folio_lock(folio);
 
-	if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
-		f2fs_put_page(page, 1);
+	if (unlikely(folio->mapping != NODE_MAPPING(sbi))) {
+		f2fs_folio_put(folio, true);
 		goto repeat;
 	}
 
-	if (unlikely(!PageUptodate(page))) {
+	if (unlikely(!folio_test_uptodate(folio))) {
 		err = -EIO;
 		goto out_err;
 	}
 
-	if (!f2fs_inode_chksum_verify(sbi, page)) {
+	if (!f2fs_inode_chksum_verify(sbi, &folio->page)) {
 		err = -EFSBADCRC;
 		goto out_err;
 	}
 page_hit:
-	if (likely(nid == nid_of_node(page)))
-		return page;
+	if (likely(nid == nid_of_node(&folio->page)))
+		return &folio->page;
 
 	f2fs_warn(sbi, "inconsistent node block, nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
-			  nid, nid_of_node(page), ino_of_node(page),
-			  ofs_of_node(page), cpver_of_node(page),
-			  next_blkaddr_of_node(page));
+			  nid, nid_of_node(&folio->page), ino_of_node(&folio->page),
+			  ofs_of_node(&folio->page), cpver_of_node(&folio->page),
+			  next_blkaddr_of_node(&folio->page));
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
 	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 	err = -EFSCORRUPTED;
 out_err:
-	ClearPageUptodate(page);
+	folio_clear_uptodate(folio);
 out_put_err:
 	/* ENOENT comes from read_node_page which is not an error. */
 	if (err != -ENOENT)
-		f2fs_handle_page_eio(sbi, page_folio(page), NODE);
-	f2fs_put_page(page, 1);
+		f2fs_handle_page_eio(sbi, folio, NODE);
+	f2fs_folio_put(folio, true);
 	return ERR_PTR(err);
 }
 
-- 
2.47.2


