Return-Path: <linux-fsdevel+bounces-23859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D9933FFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7581F25C81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6D18309C;
	Wed, 17 Jul 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pbnu44b5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECB181B99
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231246; cv=none; b=bh4QAGurvgYhfKmjd3H4AW4xj43HAVvKwHo2eiaTdfa8+SpunpxIMeMQ9GdrcaJVyStdjY1l+IbdZseUTZkXa2drz9iIMsc7YTgo7+LWz7SaIE16aE1CPLiOkccc8gdDml3VSxT58rwxZ1Hp3S0XZqwZthd3NK2lVDji/lojaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231246; c=relaxed/simple;
	bh=Y9SeGpyWlCI/z6jP9rM5us0crqpVOsdu5rC+QpRmYP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdGDjjf7K3vRjpIW+b9pN1SWOIyzx5Cxq/eFXFKqdmjqF10gv4GyR0yryRHLDedUCMFbx2GDLodaSCTUWMLYOQniGfgOGQzPiwBpmDlWbqhR9r1wQfrNYDsihs2pIBTc3E7cYsFqW1ADCgrzJYzcUnGzpXQ97h5uk1pnfFbGg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pbnu44b5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LCQbJSmPVtCf3rNm91eDzIlvzSXeMf+zulSpc1msIT8=; b=pbnu44b5Hei7R39ikfVyv9Vlr9
	Kr8iQQsFOM2ig/Sqq1+PvRLyQC/iaUYB73gbXkeD91nyHZNUqu85ob3g/3tvv0ZW1cgZYABW0PwX/
	CGmxzryWT/QTYZeQsMM9Ax9GoTpbD+QPreZY+JACSksBF70TSifz1tJVMsyUnPc83bBWxUiZDhStB
	YtcI64hgzO6fHP5tE+uAHaJOYEwooSLMPBJzRhCedJXa1JsMOx2uu+tsy9ht/avi/ES3l+JMQIaxj
	+JeFP29qYBVjsEVujWto5DdmDWQdic0q7Jd+jvA6T4G8mF5W4elY06blpcrfciPv20/z6MfIYSaIk
	0jGX9ixA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sD-00000000zv7-3pBx;
	Wed, 17 Jul 2024 15:47:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/23] jffs2: Convert jffs2_write_end() to use a folio
Date: Wed, 17 Jul 2024 16:47:05 +0100
Message-ID: <20240717154716.237943-16-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the passed page to a folio and operate on that.
Replaces six calls to compound_head() with one.
Also use kmap_local instead of kmap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jffs2/file.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index e12cb145147e..1a7dbf846c7c 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -240,6 +240,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *pg, void *fsdata)
 {
+	struct folio *folio = page_folio(pg);
 	/* Actually commit the write from the page cache page we're looking at.
 	 * For now, we write the full page out each time. It sucks, but it's simple
 	 */
@@ -252,16 +253,17 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 	unsigned aligned_start = start & ~3;
 	int ret = 0;
 	uint32_t writtenlen = 0;
+	void *buf;
 
-	jffs2_dbg(1, "%s(): ino #%lu, page at 0x%lx, range %d-%d, flags %lx\n",
-		  __func__, inode->i_ino, pg->index << PAGE_SHIFT,
-		  start, end, pg->flags);
+	jffs2_dbg(1, "%s(): ino #%lu, page at 0x%llx, range %d-%d, flags %lx\n",
+		  __func__, inode->i_ino, folio_pos(folio),
+		  start, end, folio->flags);
 
 	/* We need to avoid deadlock with page_cache_read() in
-	   jffs2_garbage_collect_pass(). So the page must be
+	   jffs2_garbage_collect_pass(). So the folio must be
 	   up to date to prevent page_cache_read() from trying
 	   to re-lock it. */
-	BUG_ON(!PageUptodate(pg));
+	BUG_ON(!folio_test_uptodate(folio));
 
 	if (end == PAGE_SIZE) {
 		/* When writing out the end of a page, write out the
@@ -276,8 +278,8 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 	if (!ri) {
 		jffs2_dbg(1, "%s(): Allocation of raw inode failed\n",
 			  __func__);
-		unlock_page(pg);
-		put_page(pg);
+		folio_unlock(folio);
+		folio_put(folio);
 		return -ENOMEM;
 	}
 
@@ -289,15 +291,11 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 	ri->isize = cpu_to_je32((uint32_t)inode->i_size);
 	ri->atime = ri->ctime = ri->mtime = cpu_to_je32(JFFS2_NOW());
 
-	/* In 2.4, it was already kmapped by generic_file_write(). Doesn't
-	   hurt to do it again. The alternative is ifdefs, which are ugly. */
-	kmap(pg);
-
-	ret = jffs2_write_inode_range(c, f, ri, page_address(pg) + aligned_start,
-				      (pg->index << PAGE_SHIFT) + aligned_start,
+	buf = kmap_local_folio(folio, aligned_start);
+	ret = jffs2_write_inode_range(c, f, ri, buf,
+				      folio_pos(folio) + aligned_start,
 				      end - aligned_start, &writtenlen);
-
-	kunmap(pg);
+	kunmap_local(buf);
 
 	if (ret)
 		mapping_set_error(mapping, ret);
@@ -323,12 +321,12 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 		   it gets reread */
 		jffs2_dbg(1, "%s(): Not all bytes written. Marking page !uptodate\n",
 			__func__);
-		ClearPageUptodate(pg);
+		folio_clear_uptodate(folio);
 	}
 
 	jffs2_dbg(1, "%s() returning %d\n",
 		  __func__, writtenlen > 0 ? writtenlen : ret);
-	unlock_page(pg);
-	put_page(pg);
+	folio_unlock(folio);
+	folio_put(folio);
 	return writtenlen > 0 ? writtenlen : ret;
 }
-- 
2.43.0


