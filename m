Return-Path: <linux-fsdevel+bounces-43435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23356A56996
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24B73ACBEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C721CA0D;
	Fri,  7 Mar 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AiRyjb9p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915C21ADBC
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355661; cv=none; b=MLKbvWLvwlpJF435K13qStqAYvN2LZT2MOZGCHv1JHdUbWk4VqgKcshZ/i+zVevk6hptQLuJx1vPIwkR+2DgoYp6f/u7WYS4ZBu+46lp06oZ47Q614Y7qGyisYsFkq+PnbV7xJ8EW3zazQ6A1u1fTHflgkpH4o31Fr5Oi0smGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355661; c=relaxed/simple;
	bh=EC8mkrJKFYe9rnrkJN6E8xeNqC15+IMWVPIuaI/TsPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efbGGIsxx29IdPnll0ahBOJ14XC88xFRR+eSyMpNqDhL7YzM7rhqHea0IoBEwYZ2YMwGp/hM3u7LaHYcebOqUtH+mVE3C3vjAYUZG+vrxtbJQjuxryI+jUesJmq+BOK9ScMJCm0qmtE+LTZarC5oZUwT9XWYcqPt2Bheg3l11hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AiRyjb9p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MofhovjlADQCQPqeYMIVdQLieQlnl0tttbSu0oh4ZYs=; b=AiRyjb9pnJivKUulf3/TkIqiUa
	7bhUXqQ56kgH5be5/6hPtgs3OfvkXoqoxzjwP6dDK1dCxb8eB+fgx4Si+OXoXbWx/4QXbPkcf2f8H
	Tx5q9E1QnRnNoJzPSNY/L6g0oQta0BR7vhffZTsRhpB93XUAkEOKHR0z5mH+o6gXbRpVJdaWM4Uo9
	5UUVoisF5QVZ5H8bexl780zg4hPo3PCV+RPFrP9zQf2Hk34Mi7a9GHfCGByUnfGbeU/WpgTVjsbcW
	MvndBuaq0WiuOxnS0t0xcPqBydhg6nU8rOrVyZMSsSxwtvudPIMEXontGuVzP4owwFrlrBVWrTH/l
	x4M1cLcA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9Y-0000000CXGF-0qyX;
	Fri, 07 Mar 2025 13:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 05/11] vboxsf: Convert to writepages
Date: Fri,  7 Mar 2025 13:54:05 +0000
Message-ID: <20250307135414.2987755-6-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we add a migrate_folio operation, we can convert the writepage
operation to writepages.  Further, this lets us optimise by using
the same write handle for multiple folios.  The large folio support here
is illusory; we would need to kmap each page in turn for proper support.
But we do remove a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/vboxsf/file.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index b780deb81b02..b492794f8e9a 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -262,40 +262,42 @@ static struct vboxsf_handle *vboxsf_get_write_handle(struct vboxsf_inode *sf_i)
 	return sf_handle;
 }
 
-static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
+static int vboxsf_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = mapping->host;
+	struct folio *folio = NULL;
 	struct vboxsf_inode *sf_i = VBOXSF_I(inode);
 	struct vboxsf_handle *sf_handle;
-	loff_t off = page_offset(page);
 	loff_t size = i_size_read(inode);
-	u32 nwrite = PAGE_SIZE;
-	u8 *buf;
-	int err;
-
-	if (off + PAGE_SIZE > size)
-		nwrite = size & ~PAGE_MASK;
+	int error;
 
 	sf_handle = vboxsf_get_write_handle(sf_i);
 	if (!sf_handle)
 		return -EBADF;
 
-	buf = kmap(page);
-	err = vboxsf_write(sf_handle->root, sf_handle->handle,
-			   off, &nwrite, buf);
-	kunmap(page);
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		loff_t off = folio_pos(folio);
+		u32 nwrite = folio_size(folio);
+		u8 *buf;
 
-	kref_put(&sf_handle->refcount, vboxsf_handle_release);
+		if (nwrite > size - off)
+			nwrite = size - off;
 
-	if (err == 0) {
-		/* mtime changed */
-		sf_i->force_restat = 1;
-	} else {
-		ClearPageUptodate(page);
+		buf = kmap_local_folio(folio, 0);
+		error = vboxsf_write(sf_handle->root, sf_handle->handle,
+				off, &nwrite, buf);
+		kunmap_local(buf);
+
+		folio_unlock(folio);
 	}
 
-	unlock_page(page);
-	return err;
+	kref_put(&sf_handle->refcount, vboxsf_handle_release);
+
+	/* mtime changed */
+	if (error == 0)
+		sf_i->force_restat = 1;
+	return error;
 }
 
 static int vboxsf_write_end(struct file *file, struct address_space *mapping,
@@ -347,10 +349,11 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
  */
 const struct address_space_operations vboxsf_reg_aops = {
 	.read_folio = vboxsf_read_folio,
-	.writepage = vboxsf_writepage,
+	.writepages = vboxsf_writepages,
 	.dirty_folio = filemap_dirty_folio,
 	.write_begin = simple_write_begin,
 	.write_end = vboxsf_write_end,
+	.migrate_folio = filemap_migrate_folio,
 };
 
 static const char *vboxsf_get_link(struct dentry *dentry, struct inode *inode,
-- 
2.47.2


