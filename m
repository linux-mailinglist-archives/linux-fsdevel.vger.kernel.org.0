Return-Path: <linux-fsdevel+bounces-37885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CFE9F882F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 23:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25EA16AD3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 22:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F91EE7D3;
	Thu, 19 Dec 2024 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVkWCXVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFF78F4A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649075; cv=none; b=WyfG36dZTxQ+hILboMUgl88/5Lx7n7+qroaj4QESGyP7yjnCnnwCNRevlWTx1b6PYX1H8kmnS0tv0cd7ZvSiVpdBnwl3uqswYGKFLMkudIuHuPKyf+NpYfOyaVAdFNimbwfLv3PlQaTngo9HbhQfsw8Ox697UTZ4ucN2mm77fLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649075; c=relaxed/simple;
	bh=RVNbwD3LyvGM0ku0JM4001S4rukg/ebjE+YuoU21BzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDC05Ala7d4Xqkc2XQHOtE9D9r9mxCmtAVg1t4p48HWcETwkbRuFQ7z5W/2b+Ubc/HekKqScDE4l1WU7rwjtqqB2uPkdIihspFFRG3R+fCdGLwTNBHCwzmR7feNUZChXeOJ92o8rLldWqaY5R/jn1avyyC7djmAIb8BL5sd2Iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RVkWCXVa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=kDqpVmMfkt2AhPmZO9HiKMTJ8MPFb7OtQwdb5+0HSnI=; b=RVkWCXVaXc+2kLkWRbYKDfjzuG
	fzJ8rnUHpz0onHjGTJ5vnTrXVZfnoNa4WVkip6QwkEfkri7RpkRy3+S2u1fmo0Oga9OyCpfBNdCFD
	PTUgAftCAllZBmivux2jTMkf2cnEcX48eUuLxiA0wMg2VkUDe3cMFm3G6hNCJvlStfqtK+bSbDD2D
	xIltOmkUDZgHHTCUqSzhnqYKBLNbgPPJyftlNJBSu+69n3xq7XU72xUTPySjqEnm7uQF1JO31Tmed
	xcSml5GEhcjc1AEvWGjcivABYl5fbRgJpkpeHkTVFZvDSuai6QRKlAJwaMCNmN/OfpuG9LlLMi/T4
	s+sT++Uw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOPSo-000000061fh-1mvj;
	Thu, 19 Dec 2024 22:57:50 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] vboxsf: Convert to writepages
Date: Thu, 19 Dec 2024 22:57:46 +0000
Message-ID: <20241219225748.1436156-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
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
2.45.2


