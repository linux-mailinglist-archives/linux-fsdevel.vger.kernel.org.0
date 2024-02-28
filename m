Return-Path: <linux-fsdevel+bounces-13123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846486B72E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D4D2876D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EB40877;
	Wed, 28 Feb 2024 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t3MJjnJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BF79B70
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144985; cv=none; b=giCIvqwbzTd1KwkNADRLnf4iB8cTc8D0sSloKmdFTV3JmgRcA8a6enpkSYYOMraFaiSCjR81bbaecXR1xOs/MgzJDpOLDtxdLXsWgSbpuyyIU8qoUJTnzWWFdWh/i946XFcZiba4oKxXExcsSbAkV/Dt0qyub4ALMzD5So89rEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144985; c=relaxed/simple;
	bh=JbOpf1pjC8ljPxfA/o7PWs5iR8hzW/qw7zMh6CGtXZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzWwzZxl2uqcs3RCkytOWrU1TG6EbNQU9KM776tUjkkpcTXn8gyhuk5OVOa+uByRLRrIyb8n6sIiELMlYc3PUgTjleZw8YAmEP3ElRHq/FDn60tJ6lKIb6v7QUd8ilKSQc8ui4lvYVA+BoEAJTTDsExYKBtA54GA3Nq0Uuce43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t3MJjnJ6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9U5Qifk3QD2V4GuPABiqeEJKLm0WoZSxs7fBlUlx29Q=; b=t3MJjnJ6em6M3CTzYI6EhwYFrz
	Uv3BKMZdOKJwk9qsDqMPjZWSUpjfwH3r+TC+uT2D2J4i0WdnOvZOzqGcRcgN9VXYmTzbROjsZkGoa
	80E1wRQZex+DrwFUo0+g+9Jvvc0Gh3CIyJrenFwLPBpoCJus9oV/b4vI6DbCZSSUVW+/BjmLQCfpv
	zzrNmR1x9mZwFO1RYD9u+LOXk53wU/xyc4MQri6Rd7eNLGGhKGtiZ3V8Og04KrDSNZHzsss9ev6Mo
	uW95VTokIsV/SR109GfAg8vGLpYwXnBT9sv0YRgCNBdZfU/GeGwO67ifYEImPbyxH3Jl0395xCXQO
	Nmuqq+oQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOgY-00000005tQ0-0jSi;
	Wed, 28 Feb 2024 18:29:42 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fuse: Convert fuse_writepage_locked to take a folio
Date: Wed, 28 Feb 2024 18:29:38 +0000
Message-ID: <20240228182940.1404651-2-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228182940.1404651-1-willy@infradead.org>
References: <20240228182940.1404651-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The one remaining caller of fuse_writepage_locked() already has a folio,
so convert this function entirely.  Saves a few calls to compound_head()
but no attempt is made to support large folios in this patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 340ccaafb3f7..f173cbce1d31 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2040,26 +2040,26 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
 	rcu_read_unlock();
 }
 
-static int fuse_writepage_locked(struct page *page)
+static int fuse_writepage_locked(struct folio *folio)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_writepage_args *wpa;
 	struct fuse_args_pages *ap;
-	struct page *tmp_page;
+	struct folio *tmp_folio;
 	int error = -ENOMEM;
 
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 
 	wpa = fuse_writepage_args_alloc();
 	if (!wpa)
 		goto err;
 	ap = &wpa->ia.ap;
 
-	tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
-	if (!tmp_page)
+	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
+	if (!tmp_folio)
 		goto err_free;
 
 	error = -EIO;
@@ -2068,21 +2068,21 @@ static int fuse_writepage_locked(struct page *page)
 		goto err_nofile;
 
 	fuse_writepage_add_to_bucket(fc, wpa);
-	fuse_write_args_fill(&wpa->ia, wpa->ia.ff, page_offset(page), 0);
+	fuse_write_args_fill(&wpa->ia, wpa->ia.ff, folio_pos(folio), 0);
 
-	copy_highpage(tmp_page, page);
+	folio_copy(tmp_folio, folio);
 	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 	wpa->next = NULL;
 	ap->args.in_pages = true;
 	ap->num_pages = 1;
-	ap->pages[0] = tmp_page;
+	ap->pages[0] = &tmp_folio->page;
 	ap->descs[0].offset = 0;
 	ap->descs[0].length = PAGE_SIZE;
 	ap->args.end = fuse_writepage_end;
 	wpa->inode = inode;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
+	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
 
 	spin_lock(&fi->lock);
 	tree_insert(&fi->writepages, wpa);
@@ -2090,17 +2090,17 @@ static int fuse_writepage_locked(struct page *page)
 	fuse_flush_writepages(inode);
 	spin_unlock(&fi->lock);
 
-	end_page_writeback(page);
+	folio_end_writeback(folio);
 
 	return 0;
 
 err_nofile:
-	__free_page(tmp_page);
+	folio_put(tmp_folio);
 err_free:
 	kfree(wpa);
 err:
-	mapping_set_error(page->mapping, error);
-	end_page_writeback(page);
+	mapping_set_error(folio->mapping, error);
+	folio_end_writeback(folio);
 	return error;
 }
 
@@ -2466,7 +2466,7 @@ static int fuse_launder_folio(struct folio *folio)
 
 		/* Serialize with pending writeback for the same page */
 		fuse_wait_on_page_writeback(inode, folio->index);
-		err = fuse_writepage_locked(&folio->page);
+		err = fuse_writepage_locked(folio);
 		if (!err)
 			fuse_wait_on_page_writeback(inode, folio->index);
 	}
-- 
2.43.0


