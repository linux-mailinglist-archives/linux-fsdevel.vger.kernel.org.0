Return-Path: <linux-fsdevel+bounces-41884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DF4A38B89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E991890E44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69542376EC;
	Mon, 17 Feb 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pDgZ8Lxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0D235BFF;
	Mon, 17 Feb 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818285; cv=none; b=inxLlfmu2kmlwXlDbzJShK7+MpOrt3HG4rTmmUxONgwHgeJQ3RBky8ByBNpFRxhRg3US8ufzNGnIpuwqq0CiwKzeYvMVteLDvGqe3XsBmrRiXSSNVCOG+JsDh/Uthwmjaml8+0LcnIbNyjPOrai7H/X7jgZvnbtEcXtq5VlqH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818285; c=relaxed/simple;
	bh=um63ps+6Ty0Jw6NrgKh7kZt7QHU1HUsnKEuSN9pw7Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5WU6mz9RFKQoSQpcdB/EgZsPL7qiGYUKbjXu+EZEX4lFVJ0FZIkOM6esKu7AAWgutzveV5PbftTcx1m8lLblqKzprK7utAeUXXP2iO18XpKW871rw7wxn9RbUcy2p9DvL6AJ5KX1KtruKDCNPGleUW2O13OOteVww55g/+xEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pDgZ8Lxi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Uk6Ao1mKqiW/+ZuvgMW/FOEPeLhVTaQLJDYe6cFanyQ=; b=pDgZ8LxifOezmuNuA6kNa71wMI
	/ORJYp5iKXx/OOxgqs64CGSGtSrO+dehHggeMYYaFbHzo7Rtw5neVZs44tKCe2ZPb5pse27piWOKU
	i/WQmnOykTMJBGoYI93Fi6107UAAjt0SB6Ned5nXO8txTU79+Wi0lRWsJJ7ojNjMTU633Kx4A/Nb6
	mn3/TwcWxIhDfmj+Omudsq5HTxkjT6mjcEf8YkDLw97HSZuSTUxSXAnuvugNjFohIyrgI3YTKl1QB
	ZOmaGYlqMd45uSeJ+yryjThkzsTUQ12wrso1OhfdnNHCfEJFSAu4WM2jbi/5onm8M7LNLInRKyT4a
	5PDYB37w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DC-00000001nwI-0RVq;
	Mon, 17 Feb 2025 18:51:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 9/9] ceph: Pass a folio to ceph_allocate_page_array()
Date: Mon, 17 Feb 2025 18:51:17 +0000
Message-ID: <20250217185119.430193-10-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217185119.430193-1-willy@infradead.org>
References: <20250217185119.430193-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove two accesses to page->index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3545eaa416e8..20b6bd8cd004 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1201,7 +1201,7 @@ void __ceph_allocate_page_array(struct ceph_writeback_ctl *ceph_wbc,
 static inline
 void ceph_allocate_page_array(struct address_space *mapping,
 			      struct ceph_writeback_ctl *ceph_wbc,
-			      struct page *page)
+			      struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -1210,13 +1210,13 @@ void ceph_allocate_page_array(struct address_space *mapping,
 	u32 xlen;
 
 	/* prepare async write request */
-	ceph_wbc->offset = (u64)page_offset(page);
+	ceph_wbc->offset = (u64)folio_pos(folio);
 	ceph_calc_file_object_mapping(&ci->i_layout,
 					ceph_wbc->offset, ceph_wbc->wsize,
 					&objnum, &objoff, &xlen);
 
 	ceph_wbc->num_ops = 1;
-	ceph_wbc->strip_unit_end = page->index + ((xlen - 1) >> PAGE_SHIFT);
+	ceph_wbc->strip_unit_end = folio->index + ((xlen - 1) >> PAGE_SHIFT);
 
 	BUG_ON(ceph_wbc->pages);
 	ceph_wbc->max_pages = calc_pages_for(0, (u64)xlen);
@@ -1348,7 +1348,7 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		 * allocate a page array
 		 */
 		if (ceph_wbc->locked_pages == 0) {
-			ceph_allocate_page_array(mapping, ceph_wbc, &folio->page);
+			ceph_allocate_page_array(mapping, ceph_wbc, folio);
 		} else if (!is_folio_index_contiguous(ceph_wbc, folio)) {
 			if (is_num_ops_too_big(ceph_wbc)) {
 				folio_redirty_for_writepage(wbc, folio);
-- 
2.47.2


