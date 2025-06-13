Return-Path: <linux-fsdevel+bounces-51597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A06AD931D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 18:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE2D179398
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D136221FBE;
	Fri, 13 Jun 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l36W5sLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF01E3DCD
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833218; cv=none; b=jEwmMawld6lv3QGNrS0l4kDvFeGtqZZXI7HwsL5l2zR86PDWXpL8eRafxYvIYhYDnkDPzQOKXYl+S83gwJCnJ33aqLMhxYacmT2R8cCoGAzG0Gk1pim56WTAqgKn0enRGJNWOMsRprIVUX2MP57iQ06xGB2cRCcZZwam21i/G9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833218; c=relaxed/simple;
	bh=8uxYu3cD8bzY+sk2oU24qk1ZxULv9RTaNV5gIsZkgoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2+LHBjPPjioCySZhpZnXoTBUs2brsE6gDp+6BkaKovTizqlUl0YNx+fFPr1CwmpjzY/pE+esHR6Gpe+6MJE53OkEVltHOlYx4/9xufMynwKzt64MqIWW+BgpXYkzgIxWOYfXFU/BJkOLhBGTtdJS2OEU9NV7TyQcph/Zg48ut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l36W5sLY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=u+AB0x/VlfeLFEwhFOCxuD7EvEWIJwYAkPAPRPey/8c=; b=l36W5sLYn3+htbfkah319bzUnn
	6OVropwbOhynaHj8p/LBQkrYWLgTAMsfAUEQchHwwXJ929Gki6p/IvK8IfXOpx+H9baEgJEkb3z31
	QkBIRE3NXSQ9icNovLbh8lwlBJ4sJl4lawE2Hy1JObDThH5mDTkjtwdB5d5qrc0hZR9+MTuRXolaV
	PobA7ZxxFjnR9lT/JjFz59z6Apmd7YjXieBEnnrkkQQkmGuFb6Vg0gHpF+akIxZJQCuXgbDm59tuO
	iiocBQ+s8QjI0M5mPF+zUqKg7B4ypRbvTJYER3+TZNZMAGdwpZLMe8cMdRoh8tvoJY8W7Go4HCxf4
	1DLaLKcw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ7YF-0000000DAjx-3jmd;
	Fri, 13 Jun 2025 16:46:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH 2/2] fuse: Use a folio in fuse_readdir_cached()
Date: Fri, 13 Jun 2025 17:46:44 +0100
Message-ID: <20250613164646.3139481-3-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613164646.3139481-1-willy@infradead.org>
References: <20250613164646.3139481-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieve a folio from the page cache and use it throughout.
Removes seven hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/readdir.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 09bed488ee35..37abf4e484ec 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -452,7 +452,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	enum fuse_parse_result res;
 	pgoff_t index;
 	unsigned int size;
-	struct page *page;
+	struct folio *folio;
 	void *addr;
 
 	/* Seeked?  If so, reset the cache stream */
@@ -528,42 +528,42 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	if ((ff->readdir.cache_off & ~PAGE_MASK) == size)
 		return 0;
 
-	page = find_get_page_flags(file->f_mapping, index,
-				   FGP_ACCESSED | FGP_LOCK);
+	folio = __filemap_get_folio(file->f_mapping, index,
+			FGP_ACCESSED | FGP_LOCK, 0);
 	/* Page gone missing, then re-added to cache, but not initialized? */
-	if (page && !PageUptodate(page)) {
-		unlock_page(page);
-		put_page(page);
-		page = NULL;
+	if (folio && !folio_test_uptodate(folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		folio = NULL;
 	}
 	spin_lock(&fi->rdc.lock);
-	if (!page) {
+	if (!folio) {
 		/*
-		 * Uh-oh: page gone missing, cache is useless
+		 * Uh-oh: folio gone missing, cache is useless
 		 */
 		if (fi->rdc.version == ff->readdir.version)
 			fuse_rdc_reset(inode);
 		goto retry_locked;
 	}
 
-	/* Make sure it's still the same version after getting the page. */
+	/* Make sure it's still the same version after getting the folio. */
 	if (ff->readdir.version != fi->rdc.version) {
 		spin_unlock(&fi->rdc.lock);
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		goto retry;
 	}
 	spin_unlock(&fi->rdc.lock);
 
 	/*
-	 * Contents of the page are now protected against changing by holding
-	 * the page lock.
+	 * Contents of the folio are now protected against changing by holding
+	 * the folio lock.
 	 */
-	addr = kmap_local_page(page);
+	addr = kmap_local_folio(folio, 0);
 	res = fuse_parse_cache(ff, addr, size, ctx);
 	kunmap_local(addr);
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (res == FOUND_ERR)
 		return -EIO;
-- 
2.47.2


