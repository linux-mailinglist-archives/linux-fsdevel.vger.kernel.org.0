Return-Path: <linux-fsdevel+bounces-23350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA192AEC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B533AB21D80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E453F8F7;
	Tue,  9 Jul 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i+Wa7Eat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606EA38F91
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495837; cv=none; b=Sk9KhIsbam6HSrtwvFAol03p4cXrkzwHnMiCnh8sWKBnv3l6ZeYoD/f/OT9qdGihzj/bh09vVSl/fZcFLwuZpBA1v6XCU2wPIpIzhDpNky6Y0WG5BMlgOFgVt6NL006A2uK+Ylu3WgXB+ZHiEw45nU/5qCuqRXtHFE2DXhyOA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495837; c=relaxed/simple;
	bh=6bXTYSNU9a9xY1F8Ofw/bhzGActM9dRbRzvxjMyJdrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhYDj/DQxF14fesmp2jopp2eD2q98yNkQSxBUxxv5RzVluj6sA2Z/TPburOuOYzvKdwOKRVVZQMxA4PPq6A78KzMHMGaE8SBcLRaC5dVKLTlXJHDDdyDYwOshqk5/BGxKHusCS/smcFByT1oSToL6yY2Sc27SNGk4ngGnZkgdOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i+Wa7Eat; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Z1IDe8LZftlaTrVrHQC0emAEo4+quFPohWu0JQ9EECQ=; b=i+Wa7EatLnGPfrzzh1PB1cfJV6
	f00A1RLRD1Yk2QzH85Dyesiq9oRf52u1xH1ZUhIYVBuCM5FNVKKkhmdKeTj9t95FjUDdJMpWiudHI
	lWrn1yiw88+n+uOtLlMdC2mUSV1+7PR31oS3Jep+r+JNIuVnuPrNlstzEK/Zm31KrIecSxz9PElLG
	2KGX51VhzgJaj9SJ/LWDFqEa0rHyIX2JuLdRGmWd4a7UIHnOMSafb0nkQYSq/bii6t9RNtKoYe1CI
	WY9j+aTk1iQ6Clp2XlsQYimsMnmIu/xK1NByR0CAbbxssAfaDzH7MX9y7rOOuBXXBNGHdKbo6K9EW
	fUdd6R7A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Yl-00000007QSb-1luG;
	Tue, 09 Jul 2024 03:30:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/10] ufs: Convert ufs_check_page() to ufs_check_folio()
Date: Tue,  9 Jul 2024 04:30:20 +0100
Message-ID: <20240709033029.1769992-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709033029.1769992-1-willy@infradead.org>
References: <20240709033029.1769992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Includes large folio support in case we decide to support block size >
PAGE_SIZE (as with ext2, this support will be limited to machines
without HIGHMEM).
---
 fs/ufs/dir.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 6c3235f426ed..287cab597cc1 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -112,20 +112,18 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_handle_dirsync(dir);
 }
 
-
-static bool ufs_check_page(struct page *page)
+static bool ufs_check_folio(struct folio *folio, char *kaddr)
 {
-	struct inode *dir = page->mapping->host;
+	struct inode *dir = folio->mapping->host;
 	struct super_block *sb = dir->i_sb;
-	char *kaddr = page_address(page);
 	unsigned offs, rec_len;
-	unsigned limit = PAGE_SIZE;
+	unsigned limit = folio_size(folio);
 	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
 	struct ufs_dir_entry *p;
 	char *error;
 
-	if ((dir->i_size >> PAGE_SHIFT) == page->index) {
-		limit = dir->i_size & ~PAGE_MASK;
+	if (dir->i_size < folio_pos(folio) + limit) {
+		limit = offset_in_folio(folio, dir->i_size);
 		if (limit & chunk_mask)
 			goto Ebadsize;
 		if (!limit)
@@ -150,13 +148,13 @@ static bool ufs_check_page(struct page *page)
 	if (offs != limit)
 		goto Eend;
 out:
-	SetPageChecked(page);
+	folio_set_checked(folio);
 	return true;
 
 	/* Too bad, we had an error */
 
 Ebadsize:
-	ufs_error(sb, "ufs_check_page",
+	ufs_error(sb, __func__,
 		  "size of directory #%lu is not a multiple of chunk size",
 		  dir->i_ino
 	);
@@ -176,17 +174,17 @@ static bool ufs_check_page(struct page *page)
 Einumber:
 	error = "inode out of bounds";
 bad_entry:
-	ufs_error (sb, "ufs_check_page", "bad entry in directory #%lu: %s - "
-		   "offset=%lu, rec_len=%d, name_len=%d",
-		   dir->i_ino, error, (page->index<<PAGE_SHIFT)+offs,
+	ufs_error(sb, __func__, "bad entry in directory #%lu: %s - "
+		   "offset=%llu, rec_len=%d, name_len=%d",
+		   dir->i_ino, error, folio_pos(folio) + offs,
 		   rec_len, ufs_get_de_namlen(sb, p));
 	goto fail;
 Eend:
 	p = (struct ufs_dir_entry *)(kaddr + offs);
 	ufs_error(sb, __func__,
 		   "entry in directory #%lu spans the page boundary"
-		   "offset=%lu",
-		   dir->i_ino, (page->index<<PAGE_SHIFT)+offs);
+		   "offset=%llu",
+		   dir->i_ino, folio_pos(folio) + offs);
 fail:
 	return false;
 }
@@ -202,7 +200,7 @@ static void *ufs_get_folio(struct inode *dir, unsigned long n,
 		return ERR_CAST(folio);
 	kaddr = kmap(&folio->page);
 	if (unlikely(!folio_test_checked(folio))) {
-		if (!ufs_check_page(&folio->page))
+		if (!ufs_check_folio(folio, kaddr))
 			goto fail;
 	}
 	*foliop = folio;
-- 
2.43.0


