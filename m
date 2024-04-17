Return-Path: <linux-fsdevel+bounces-17150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6C18A86F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDCF1F22C38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3162147C6B;
	Wed, 17 Apr 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AncebMGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FF146D40
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366262; cv=none; b=qaEb51ux8/PXk3pOzxzCK79el9AuWvAF8TPQhsPgEP4+SxIz1/ZCGj1siS1MBhwm+DCmoofMg7QB5Z+gOymC3bsJgFgWzrfI09Q5hZ+xdk2AG4a5f5iG22tZxfv+yAqJ3LWZ7v/H4apNhlS3sjTSgzja+eG6mW1/FsoAf6oLlfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366262; c=relaxed/simple;
	bh=CKnFD4W3HDhCyIRZ0petwnRRfYgEsVpZNgTNAZ3PHXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfCeamgQy8o+6/2xR/iQpcHTW+y06BdGfJehLyVpi63/VaqgjgnHTGFDPyMbktcY2Zr0wh54aptdbLzTq87YdnjAIJLWTqnWiDma/8I/VDlEkB/tI/Gg3rAPp64c2fxLibs+O5wfzlqWPDgLTOAM6Lo6j5a2lfWXrbI4/iUheeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AncebMGz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5exut3IUoYS+5VCh4E/3WqH0HK1vj6xrm96VSe/1PFM=; b=AncebMGzDAN0LyVTM9cEp2aVJT
	lzatPHQcBkQ/4YE9540FOjnyQ9kwU5Xyfy3UPQjbtvSjWrPSmAGmzDACZycukTsSWhEqlOcYlIQMn
	eEqC/kn09JXBywG45WLt5njWgGk/42Xhtd1YJ7pBIBaFv2YcOlsH7OiFeiEKJew6kOF9swDIr9ak5
	qgRSqTkmgnODhw7d7fsH74pNS8JFIHkj42jud5Hr8FZnZqiRJT4BZxZUl65CHMIZsqZmz1RbDYPpo
	y5cfX+Y3DwWm81ALjaYMQrIfG4ewubKN2ASO+zalt5PrNjY7Joj6QU0yV5jaV5IDlPXzeP7eHFgKa
	NDQmzACg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6pe-000000039t1-2erw;
	Wed, 17 Apr 2024 15:04:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] udf: Convert udf_page_mkwrite() to use a folio
Date: Wed, 17 Apr 2024 16:04:12 +0100
Message-ID: <20240417150416.752929-7-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417150416.752929-1-willy@infradead.org>
References: <20240417150416.752929-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the vm_fault page to a folio, then use it throughout.
Replaces five calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 0ceac4b5937c..97c59585208c 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -39,7 +39,7 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	loff_t size;
 	unsigned int end;
 	vm_fault_t ret = VM_FAULT_LOCKED;
@@ -48,31 +48,31 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 	filemap_invalidate_lock_shared(mapping);
-	lock_page(page);
+	folio_lock(folio);
 	size = i_size_read(inode);
-	if (page->mapping != inode->i_mapping || page_offset(page) >= size) {
-		unlock_page(page);
+	if (folio->mapping != inode->i_mapping || folio_pos(folio) >= size) {
+		folio_unlock(folio);
 		ret = VM_FAULT_NOPAGE;
 		goto out_unlock;
 	}
 	/* Space is already allocated for in-ICB file */
 	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
 		goto out_dirty;
-	if (page->index == size >> PAGE_SHIFT)
+	if (folio->index == size >> PAGE_SHIFT)
 		end = size & ~PAGE_MASK;
 	else
 		end = PAGE_SIZE;
-	err = __block_write_begin(page, 0, end, udf_get_block);
+	err = __block_write_begin(&folio->page, 0, end, udf_get_block);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		ret = vmf_fs_error(err);
 		goto out_unlock;
 	}
 
-	block_commit_write(page, 0, end);
+	block_commit_write(&folio->page, 0, end);
 out_dirty:
-	set_page_dirty(page);
-	wait_for_stable_page(page);
+	folio_mark_dirty(folio);
+	folio_wait_stable(folio);
 out_unlock:
 	filemap_invalidate_unlock_shared(mapping);
 	sb_end_pagefault(inode->i_sb);
-- 
2.43.0


