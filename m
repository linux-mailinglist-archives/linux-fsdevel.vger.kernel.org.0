Return-Path: <linux-fsdevel+bounces-17176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961FC8A89F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65B01C22249
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10710172799;
	Wed, 17 Apr 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ikj6U6iA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369E172789;
	Wed, 17 Apr 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373793; cv=none; b=OVglVlvpBnggQvdenr/T8bzV/jD7yznuyrqCdQZvLqKRxCVnYauewn0ZLI5QTWV/umFMKOVID07RyLAgncuuf/UNlZ4wJ1RVA99DTGqIGQY2GS5JX1Tvq025pXlkl22x6f2ClylmvaB7dJ38UMJ/Fycda+PdWJVKWHqWG4rtsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373793; c=relaxed/simple;
	bh=2O5Qj6YrSrtlVlal4UkAPlH0fYWyUVIhsdbsllxGHWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsG5UJ8Nsxp5mWlgGroVnrU2+9iHLkMIf/aclg4XbstLTvn3kZQ0Qjwx200IR17V+OOwN1W3SnKelCeLW0Q9L9Y0MxM2n4uyiOwofuPfkqV3Gzfrx7FgKFbvGhKSFAUXmdjlvxt2QMpoluymHiUXQX97xgeW5pDsdRtpKOprmQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ikj6U6iA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=56DrERYxVwXpnm1O/3ISxLxUBwMsygo3JyURRzZ66aU=; b=ikj6U6iADp/cGQkuVI+v0Mce/L
	LJz3p2vv6ag33vCU03Fg/JSvR6rJYi93274Ya8nawaoP9+MVqDeH6wrPS9WgIXZELgh4KPi/FXhtH
	6fHAS9mMz42wzneuYBdFfXW46CKV7zmjDDbv4l6NrH3Z4+W7IFAu0QXmtz1iF8Na9i76Jz8nL1q/J
	8TUGt4RBHN3fcgouW96Y/hxgkIMA+Y/gzCjA9hSPkFE7NOnk2ZzIt3S0cybK+/8UhOBx2pLlobmtA
	9X7caYn2O36oIj/Cs6vpwE/bO+uILh8h8sQCoUmeDFLw2soTGRJA+C4DFqIpfTmEOzk5V07pouNRd
	bra34HIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8n7-00000003LNM-0aJu;
	Wed, 17 Apr 2024 17:09:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/10] ntfs3: Convert attr_data_read_resident() to take a folio
Date: Wed, 17 Apr 2024 18:09:31 +0100
Message-ID: <20240417170941.797116-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417170941.797116-1-willy@infradead.org>
References: <20240417170941.797116-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all three callers have a folio, pass it in and use
folio_fill_tail() to do the hard work of filling the folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/attrib.c  | 27 +++++++++------------------
 fs/ntfs3/inode.c   |  6 +++---
 fs/ntfs3/ntfs_fs.h |  2 +-
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 7aadf5010999..11f90b140122 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1223,11 +1223,12 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	goto out;
 }
 
-int attr_data_read_resident(struct ntfs_inode *ni, struct page *page)
+int attr_data_read_resident(struct ntfs_inode *ni, struct folio *folio)
 {
 	u64 vbo;
 	struct ATTRIB *attr;
 	u32 data_size;
+	size_t len;
 
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL, NULL);
 	if (!attr)
@@ -1236,25 +1237,15 @@ int attr_data_read_resident(struct ntfs_inode *ni, struct page *page)
 	if (attr->non_res)
 		return E_NTFS_NONRESIDENT;
 
-	vbo = page->index << PAGE_SHIFT;
+	vbo = folio->index << PAGE_SHIFT;
 	data_size = le32_to_cpu(attr->res.data_size);
-	if (vbo < data_size) {
-		const char *data = resident_data(attr);
-		char *kaddr = kmap_atomic(page);
-		u32 use = data_size - vbo;
-
-		if (use > PAGE_SIZE)
-			use = PAGE_SIZE;
+	if (vbo > data_size)
+		len = 0;
+	else
+		len = min(data_size - vbo, folio_size(folio));
 
-		memcpy(kaddr, data + vbo, use);
-		memset(kaddr + use, 0, PAGE_SIZE - use);
-		kunmap_atomic(kaddr);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-	} else if (!PageUptodate(page)) {
-		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
-	}
+	folio_fill_tail(folio, 0, resident_data(attr) + vbo, len);
+	folio_mark_uptodate(folio);
 
 	return 0;
 }
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 25be12e68d6e..1eb11c3b480d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -571,7 +571,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 
 	if (is_resident(ni)) {
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, &folio->page);
+		err = attr_data_read_resident(ni, folio);
 		ni_unlock(ni);
 
 		if (!err)
@@ -705,7 +705,7 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 
 	if (is_resident(ni)) {
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, &folio->page);
+		err = attr_data_read_resident(ni, folio);
 		ni_unlock(ni);
 		if (err != E_NTFS_NONRESIDENT) {
 			folio_unlock(folio);
@@ -911,7 +911,7 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 		}
 
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, &folio->page);
+		err = attr_data_read_resident(ni, folio);
 		ni_unlock(ni);
 
 		if (!err) {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index ea5b5e814e63..0b518bf8182a 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -434,7 +434,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		  struct ATTRIB **ret);
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 			CLST *len, bool *new, bool zero);
-int attr_data_read_resident(struct ntfs_inode *ni, struct page *page);
+int attr_data_read_resident(struct ntfs_inode *ni, struct folio *folio);
 int attr_data_write_resident(struct ntfs_inode *ni, struct page *page);
 int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		       const __le16 *name, u8 name_len, struct runs_tree *run,
-- 
2.43.0


