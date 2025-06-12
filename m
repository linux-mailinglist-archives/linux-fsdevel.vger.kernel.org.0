Return-Path: <linux-fsdevel+bounces-51496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F46AD7400
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A554F16AD8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C724DD01;
	Thu, 12 Jun 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qfrKEFtw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218CB24888D;
	Thu, 12 Jun 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738900; cv=none; b=GuzS5jyOOajBWS7CWZOylwLol3769/9QAMfstB0ImtRzcXH/UvHk/DgSbzGzbVpaIV6uCduDrSSRQRJP80QBqshOmI5zmp6E4b5330MpeaLmiCJ4LM4Lk1AnqYnES9S5fzYOjAjaGwUKRvRPKdxQYdKzvvbEOdsF2ik2funHtUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738900; c=relaxed/simple;
	bh=fGAC+1Onekt+wAcr6qj+bFSUd1zQBk8i/pEWKZDm38M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPFFi+IgLeE0eGKoW6gtSq5MylPuaTEuuKgXmjierAILNnLi2texZ0iwWyu38aE5AVUh7iFTaOPAEjJ5EhXIqr75aTh1S/KB+54z1a30uUED8oOzzUUTNmD4tSFeIbpbbcKq3WY42cvS0nZIZLZz+VIg1kOP0xLcd32dltSUWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qfrKEFtw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=A5sgLDe/j2Mx08BUj7TZjE5KbZPw47LyiOmwt83Oy/0=; b=qfrKEFtwnEjcl8+Pl5Jlod98PE
	4247RjMSHuVyPLEOVYesW6ycjeqrA006fTgmEo2ZyXRn52hvAT23OXwSYjb8xwlQDCcP1/trZx42t
	ywkVArol7CRiXVGaY5Q4Ps0OMuwh9y6Od3vHWWqjzbdgteFDWWpdAtIDuq2tuAQlGvhbFb1CehnIr
	p52VRRBqy8PeCfdx3AV5TenUW8NArarUp/imzqZJc8eCS67pz75KrC/gANkgXZmHcvrXZ0BnlxtKv
	i71oImgETuq9D8GOjnIrjZjmXlRKzzZ6IuXF0B2xJtvEcadfm5ZzMtBqGfrw9hkm/o9p6f8QTIvBr
	xHPVyddg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj0y-0000000Bwxq-2RSX;
	Thu, 12 Jun 2025 14:34:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Ira Weiny <ira.weiny@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] ceph: Convert ceph_zero_partial_page() to use a folio
Date: Thu, 12 Jun 2025 15:34:40 +0100
Message-ID: <20250612143443.2848197-5-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612143443.2848197-1-willy@infradead.org>
References: <20250612143443.2848197-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieve a folio from the pagecache instead of a page and operate on it.
Removes several hidden calls to compound_head() along with calls to
deprecated functions like wait_on_page_writeback() and find_lock_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/file.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a7254cab44cc..d5c674d2ba8a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2530,18 +2530,17 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 	return generic_file_llseek(file, offset, whence);
 }
 
-static inline void ceph_zero_partial_page(
-	struct inode *inode, loff_t offset, unsigned size)
+static inline void ceph_zero_partial_page(struct inode *inode,
+		loff_t offset, size_t size)
 {
-	struct page *page;
-	pgoff_t index = offset >> PAGE_SHIFT;
-
-	page = find_lock_page(inode->i_mapping, index);
-	if (page) {
-		wait_on_page_writeback(page);
-		zero_user(page, offset & (PAGE_SIZE - 1), size);
-		unlock_page(page);
-		put_page(page);
+	struct folio *folio;
+
+	folio = filemap_lock_folio(inode->i_mapping, offset >> PAGE_SHIFT);
+	if (folio) {
+		folio_wait_writeback(folio);
+		folio_zero_range(folio, offset_in_folio(folio, offset), size);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 }
 
-- 
2.47.2


