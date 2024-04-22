Return-Path: <linux-fsdevel+bounces-17424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D660D8AD4E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108631C20F80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8C15535B;
	Mon, 22 Apr 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEKPcy2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0115532F;
	Mon, 22 Apr 2024 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814330; cv=none; b=C2jOud2bF6eLhie0IqlWlpoZO0mnEyS4U33bXAqb5JbWnuHlJIbkLR67FkUs7YCQk+j5jYyVqZ3VP4Xnq0W+3BEpD203xoTNL7FBOgaEC/2jqj8Rip/7uRx7VcXUMMILh+LJpYot/QOeZl6e4+Ak7ktRG8vDRdOXGKMnn2Tr9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814330; c=relaxed/simple;
	bh=iFPo8AzfRg4PHAOoob070kBSgoqO9Ua8EMmLoLzgVMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc3FqZaSBXX/avXvI/FJg+rtEuAjK1EnX0a6Wt0Ie03bJnbyeCIg+F0D7CpiNpdGvs1uK00f4VStpaW0rIo4qX+1w5KOK8jjiic+wH0nxLRfhVlaxvrByZh/2h4TYj/kcTAED7CYXXCLgC+JEfMpO4fK0RRTlUBtYdLup7trpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEKPcy2o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ElyNk+czC1SsaG1zKgGROmJrTjnbDOZyYiye0Bn6G+M=; b=oEKPcy2oAX/8tBN8Hs6wwI3lH8
	NEKZC1oXTdazvGVNoWx7mTuxTz1xwA1ZCr4gBMj75ji4CLS/PcGqNpWVjP+NAD6w6qpbmL4SeSSZj
	qSOATB/ao9oGy1dSN5c3a/keyNhrJDcnGuy7slUe58OF6bBII5KDgqyNGa7Ej4OIXYXR4MHpBqaAW
	dwwhChNUDIMvn64XRzFURwLMAL5tgdA8D/dFoKkXoikbcT1oYkhv0nDLjdMmGfZbCiQfbpBynNQHF
	Aab+n1/KtODGTGEn6zic95RIpHXdcG2DCy5Kkazb+5zlbtZZVVexVHmR2TW9eHEsVUTF60nR+nOG4
	UFCfyw3A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpOC-0mWq;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/11] ntfs3: Convert attr_data_read_resident() to take a folio
Date: Mon, 22 Apr 2024 20:31:53 +0100
Message-ID: <20240422193203.3534108-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
References: <20240422193203.3534108-1-willy@infradead.org>
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
index acee4644fd8d..676489b05a1f 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1240,11 +1240,12 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
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
@@ -1253,25 +1254,15 @@ int attr_data_read_resident(struct ntfs_inode *ni, struct page *page)
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
index 794d2aa3a5ab..b0299c7b59b4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -583,7 +583,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 			err = 0;
 		} else {
 			ni_lock(ni);
-			err = attr_data_read_resident(ni, &folio->page);
+			err = attr_data_read_resident(ni, folio);
 			ni_unlock(ni);
 
 			if (!err)
@@ -717,7 +717,7 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 
 	if (is_resident(ni)) {
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, &folio->page);
+		err = attr_data_read_resident(ni, folio);
 		ni_unlock(ni);
 		if (err != E_NTFS_NONRESIDENT) {
 			folio_unlock(folio);
@@ -923,7 +923,7 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 		}
 
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, &folio->page);
+		err = attr_data_read_resident(ni, folio);
 		ni_unlock(ni);
 
 		if (!err) {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 7fd044fee635..bd8c9b520269 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -445,7 +445,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
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


