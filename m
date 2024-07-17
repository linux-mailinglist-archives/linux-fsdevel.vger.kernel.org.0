Return-Path: <linux-fsdevel+bounces-23849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31841933FF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622C91C219FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFA7182A6C;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BtO3jPaB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD05181B8E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231244; cv=none; b=anmoDaQwm2COJ8EtQQsw+ZiegOxEY0bOWoXbVQiPvc8cbtK3kKV2M2bNCZTf3cM8/d91ZKR8j+GHtzZSu3hXTpazogEkpwMgVSmlIYOwHpWhy4ki40r6F+wFdOveCf3ck45BuQ4EKFJjSzmzovOg6Y9UhWtj3I7BaxSPjp6xjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231244; c=relaxed/simple;
	bh=ICebjmjr7TFeZArGZzUPLCNbeosOQwVEOmX5du7p89g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi+2FROnxqfdpC89pAVe5zM+ga1kebN5LwRI05e0LjGncMrpV3+dV2Wgdqlz6qGaunTMD3Pmy4KTitQoAqiIu/3vZOrB5wm0DXCeHdWXwzCp+1cVgyd8kmN1iedd3gtVnloIxEKza4dIyT4r8uIwn2v7bKsMuHvd3Y6atA3rsbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BtO3jPaB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/dUO/I4CT8Q4zZqJxusWfxrmgzlLL14Xx6hnkzaPW/M=; b=BtO3jPaBYtLwRw9MHm39JDk0eR
	RPjTtYUUIFwSrEejAwjxQY9FOqdJFEcJs77XsRe08bSAE9oGxFgKKQWQq/lFxKIlpf05TegzeVuCx
	NAs1ziXJmSkt8xK7Kcxu4ZD5kVTyuJaSkd2p8UDUToE7iJCQK6fCz4Yy72k6ZoVSik3/wTXoJCWF2
	g4mRoa4z1ZwBUREoQXlvRE2LovIhDqK9yZMjgYMlIa5yTFXiv11s3YBpdtH8gxkpWvtkzh24UjeuT
	kWo93BfNOxbmX6HDxT15VC4flF32Kn9FmjnDaBdaopo139bF3hOGlHG0nmL3WNYTVf+YCRO9wDg91
	0K6Dt7rg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sD-00000000zux-2f8y;
	Wed, 17 Jul 2024 15:47:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 13/23] fuse: Convert fuse_write_begin() to use a folio
Date: Wed, 17 Jul 2024 16:47:03 +0100
Message-ID: <20240717154716.237943-14-willy@infradead.org>
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

Fetch a folio from the page cache instead of a page and use it throughout
removing several calls to compound_head() and supporting large folios
(in this function).  We still have to convert back to a page for calling
internal fuse functions, but hopefully they will be converted soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f4102c6657af..137485999d3d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2391,41 +2391,42 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
-	struct page *page;
+	struct folio *folio;
 	loff_t fsize;
 	int err = -ENOMEM;
 
 	WARN_ON(!fc->writeback_cache);
 
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
 		goto error;
 
-	fuse_wait_on_page_writeback(mapping->host, page->index);
+	fuse_wait_on_page_writeback(mapping->host, folio->index);
 
-	if (PageUptodate(page) || len == PAGE_SIZE)
+	if (folio_test_uptodate(folio) || len >= folio_size(folio))
 		goto success;
 	/*
-	 * Check if the start this page comes after the end of file, in which
-	 * case the readpage can be optimized away.
+	 * Check if the start of this folio comes after the end of file,
+	 * in which case the readpage can be optimized away.
 	 */
 	fsize = i_size_read(mapping->host);
-	if (fsize <= (pos & PAGE_MASK)) {
-		size_t off = pos & ~PAGE_MASK;
+	if (fsize <= folio_pos(folio)) {
+		size_t off = offset_in_folio(folio, pos);
 		if (off)
-			zero_user_segment(page, 0, off);
+			folio_zero_segment(folio, 0, off);
 		goto success;
 	}
-	err = fuse_do_readpage(file, page);
+	err = fuse_do_readpage(file, &folio->page);
 	if (err)
 		goto cleanup;
 success:
-	*pagep = page;
+	*pagep = &folio->page;
 	return 0;
 
 cleanup:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 error:
 	return err;
 }
-- 
2.43.0


