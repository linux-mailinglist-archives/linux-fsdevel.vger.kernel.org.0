Return-Path: <linux-fsdevel+bounces-45531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8195A791BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E83B18946FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374323E332;
	Wed,  2 Apr 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UVlnCqVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76123C8B7
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606019; cv=none; b=CnbGvGqvOk3AZSqENw3YgOQCzdf8+Zb5PeyPOg39O9cyoIQFKrXWell9lt8vz4y7p7d9RrjDJ72o7r2sn5wQ+7g2NVvlKkt9JLtdyk5pfKt2AEObWiEjfqp9wjP9OInTn5nTsrOpeqYW4GW2n3oQj8ySxldf10cjh15+zL0KqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606019; c=relaxed/simple;
	bh=EC8mkrJKFYe9rnrkJN6E8xeNqC15+IMWVPIuaI/TsPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGZJvq694uqR5/h6V1VzFHunzBd1FBIFL58ibt+xmJHdyfH0hlExAW0HrVLErgvzGEkTdNa+tRQfNeOdcabf+xJFqQ5CUkyUIxyiofa2PUnK8tUECQuU/frTg1wZJpSlOMUaMNDg9yCMflAD8BG0JEL5fONUCNKoJ1Gnk79cgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UVlnCqVh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MofhovjlADQCQPqeYMIVdQLieQlnl0tttbSu0oh4ZYs=; b=UVlnCqVhaQJS4HJzwCd3dfa8m3
	Pl780cPiBkPkCd9y3v9/zi1vI+/CXbFmxttgXnfAIt9Ho06rLTH9JbWU2ujRfyWRdj4w2xSDmSdLo
	09wjhqmFORJbT6G1iS+TWFI+6KlmKmFD3JcibDzjT10YbPbv55Oc6W55StfRBRrjhYtDIrPl1Q3kH
	vG24breS4watPawfBwP1ClNNL/BpIJtMt35gD0D7V2Qn5gTZuO/NEjKofMHBlAW9OG3fbTEkNFY9g
	F6b7XFVKro+YZj02ApnZFeY1Oqub0IzNI93DJO3HjLPyBPG0flfd2Wv8XwqT5w4sqWOhUjHISLJdw
	1MOAPOug==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzzZX-00000009gs9-0kYH;
	Wed, 02 Apr 2025 15:00:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/9] vboxsf: Convert to writepages
Date: Wed,  2 Apr 2025 15:59:56 +0100
Message-ID: <20250402150005.2309458-3-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402150005.2309458-1-willy@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
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


