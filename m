Return-Path: <linux-fsdevel+bounces-16059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE62D89777B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB5FB2FAD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831C156877;
	Wed,  3 Apr 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FD3R+jeC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB95152175;
	Wed,  3 Apr 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165054; cv=none; b=b1oeVlJBr9M+sX9hK9m1OaoSwsZxHKBapayDBKu/91EmzVxZrTSxhnWHC3a4umaHPrh9Yi5dtxaxYnFQt9A3T2dWXUEcJt3GnU2mlKCvgniwCmxb+SdrCiWbkFoj4d38fam3qV/yJccbsarY1sFgwILGLEBBOyKH4I6xkqUAce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165054; c=relaxed/simple;
	bh=TDaCpini53Mr8yK0eITvdAcgX3FCd3UJWdi7Bjl0CGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWi06EruYpWlrluiy9Zrw92uAa/NVJXEJd627ZyGWBhmgCmb6lX7kQDW8UcvwroefvWB3IMUQGK1KkpHAbdWh7BeTNjFYD7wbUIBkYDj1mq0dzUCxy4BYE1mmAcBd1yNomYqFf4P3KDW2lKPMsJ7A7MI5Gcstt0yolI2cFjjfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FD3R+jeC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7yNU0GNknH4C2nBYMfys3Y9RA2bakiNSz7XulvKIjAs=; b=FD3R+jeCs3z7BLjA73aVZ26ajR
	8ov5O9FcSU4uSDTN43f17vMomrFsmrC1kT2v3/kcTHJXyXhTnF09/0q6r9gPdlLj/6OzxiH7oQ9Nl
	wrYXKUnpomjxPCuthHthTX+Sx3qFWUzZX9MhjexyiRNftneMgZDgw/pnguMpoTHUFQhu5wzwr8iPx
	0t6NIPNFqWuuIOlaE/dafaCa8QQDiVeiX1Sc6+s0xl8eDUx6CNUY25uxSPA6wzZIQ6Zy8E5vaE2wU
	EuTnQScTinOf96a9Msz3UEtGDVd8qYPbuS6ZUWHy3ly/X9sk9jn6D7UWXjxhVFp/QjTxYftqv0hBX
	aDHJwpqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4LE-0000000651d-1r3G;
	Wed, 03 Apr 2024 17:24:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev
Subject: [PATCH 1/4] gfs2: Convert gfs2_page_mkwrite() to use a folio
Date: Wed,  3 Apr 2024 18:23:48 +0100
Message-ID: <20240403172400.1449213-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403172400.1449213-1-willy@infradead.org>
References: <20240403172400.1449213-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the incoming page to a folio and use it throughout saving several
calls to compound_head().  Also use 'pos' for file position rather than
the ambiguou 'offset' and increase 'length' to size_t in cae we get some
truly ridiculous sized folios in future.  This function should now be
large-folio safe, but I may have missed something.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/file.c | 59 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 4c42ada60ae7..08982937b5df 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -376,23 +376,23 @@ static void gfs2_size_hint(struct file *filep, loff_t offset, size_t size)
 }
 
 /**
- * gfs2_allocate_page_backing - Allocate blocks for a write fault
- * @page: The (locked) page to allocate backing for
+ * gfs2_allocate_folio_backing - Allocate blocks for a write fault
+ * @folio: The (locked) folio to allocate backing for
  * @length: Size of the allocation
  *
- * We try to allocate all the blocks required for the page in one go.  This
+ * We try to allocate all the blocks required for the folio in one go.  This
  * might fail for various reasons, so we keep trying until all the blocks to
- * back this page are allocated.  If some of the blocks are already allocated,
+ * back this folio are allocated.  If some of the blocks are already allocated,
  * that is ok too.
  */
-static int gfs2_allocate_page_backing(struct page *page, unsigned int length)
+static int gfs2_allocate_folio_backing(struct folio *folio, size_t length)
 {
-	u64 pos = page_offset(page);
+	u64 pos = folio_pos(folio);
 
 	do {
 		struct iomap iomap = { };
 
-		if (gfs2_iomap_alloc(page->mapping->host, pos, length, &iomap))
+		if (gfs2_iomap_alloc(folio->mapping->host, pos, length, &iomap))
 			return -EIO;
 
 		if (length < iomap.length)
@@ -414,16 +414,16 @@ static int gfs2_allocate_page_backing(struct page *page, unsigned int length)
 
 static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_alloc_parms ap = {};
-	u64 offset = page_offset(page);
+	u64 pos = folio_pos(folio);
 	unsigned int data_blocks, ind_blocks, rblocks;
 	vm_fault_t ret = VM_FAULT_LOCKED;
 	struct gfs2_holder gh;
-	unsigned int length;
+	size_t length;
 	loff_t size;
 	int err;
 
@@ -436,23 +436,23 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 		goto out_uninit;
 	}
 
-	/* Check page index against inode size */
+	/* Check folio index against inode size */
 	size = i_size_read(inode);
-	if (offset >= size) {
+	if (pos >= size) {
 		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
 	}
 
-	/* Update file times before taking page lock */
+	/* Update file times before taking folio lock */
 	file_update_time(vmf->vma->vm_file);
 
-	/* page is wholly or partially inside EOF */
-	if (size - offset < PAGE_SIZE)
-		length = size - offset;
+	/* folio is wholly or partially inside EOF */
+	if (size - pos < folio_size(folio))
+		length = size - pos;
 	else
-		length = PAGE_SIZE;
+		length = folio_size(folio);
 
-	gfs2_size_hint(vmf->vma->vm_file, offset, length);
+	gfs2_size_hint(vmf->vma->vm_file, pos, length);
 
 	set_bit(GLF_DIRTY, &ip->i_gl->gl_flags);
 	set_bit(GIF_SW_PAGED, &ip->i_flags);
@@ -463,11 +463,12 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	 */
 
 	if (!gfs2_is_stuffed(ip) &&
-	    !gfs2_write_alloc_required(ip, offset, length)) {
-		lock_page(page);
-		if (!PageUptodate(page) || page->mapping != inode->i_mapping) {
+	    !gfs2_write_alloc_required(ip, pos, length)) {
+		folio_lock(folio);
+		if (!folio_test_uptodate(folio) ||
+		    folio->mapping != inode->i_mapping) {
 			ret = VM_FAULT_NOPAGE;
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 		goto out_unlock;
 	}
@@ -504,7 +505,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 		goto out_trans_fail;
 	}
 
-	/* Unstuff, if required, and allocate backing blocks for page */
+	/* Unstuff, if required, and allocate backing blocks for folio */
 	if (gfs2_is_stuffed(ip)) {
 		err = gfs2_unstuff_dinode(ip);
 		if (err) {
@@ -513,22 +514,22 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 		}
 	}
 
-	lock_page(page);
+	folio_lock(folio);
 	/* If truncated, we must retry the operation, we may have raced
 	 * with the glock demotion code.
 	 */
-	if (!PageUptodate(page) || page->mapping != inode->i_mapping) {
+	if (!folio_test_uptodate(folio) || folio->mapping != inode->i_mapping) {
 		ret = VM_FAULT_NOPAGE;
 		goto out_page_locked;
 	}
 
-	err = gfs2_allocate_page_backing(page, length);
+	err = gfs2_allocate_folio_backing(folio, length);
 	if (err)
 		ret = vmf_fs_error(err);
 
 out_page_locked:
 	if (ret != VM_FAULT_LOCKED)
-		unlock_page(page);
+		folio_unlock(folio);
 out_trans_end:
 	gfs2_trans_end(sdp);
 out_trans_fail:
@@ -540,8 +541,8 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	if (ret == VM_FAULT_LOCKED) {
-		set_page_dirty(page);
-		wait_for_stable_page(page);
+		folio_mark_dirty(folio);
+		folio_wait_stable(folio);
 	}
 	sb_end_pagefault(inode->i_sb);
 	return ret;
-- 
2.43.0


