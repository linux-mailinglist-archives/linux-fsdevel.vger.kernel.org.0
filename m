Return-Path: <linux-fsdevel+bounces-25960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93238952305
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168F8B23BD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF41C0DC6;
	Wed, 14 Aug 2024 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VRCUv56r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E71BF317
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665570; cv=none; b=R+9h4Uw9g2CsSDnyP64O4fVI8fN2wqPqj0FNhKstkhd1pQwsQ8+iOri3JLd4ihFB8AdjnGSdgz39kSUpYJ9TvQnbspiEomwKVS5/vg0yimG6Y7L4eC9YOPuvXq5UuUsepxagD+/6FGpztMRzPTRqPIv8yZlbSAR3FxGE2h5Y+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665570; c=relaxed/simple;
	bh=A/XdVMK28JL9n5NkOrpuRxuu4y5RDd31yoFVZJm3/aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XruSnom09vkWoT0Mv6ruaXBYtPaj76UM1UK9qvvLJTzrOuniy8mORX2XSmY1M37ooZ5/eSCGZg+aw5YHu3wtyNPze8q1GSt085OTIxE3gtlZ3NONctRoBcYq7XHgLQaxFQcvahJ8uvLuRxv6VTQV4oirVxUPuOeOUv25F3jXAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VRCUv56r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dyVdPuVZWPTtj3niivHVjJclPba065VEMrZlN/1509Y=; b=VRCUv56rDLppLTGlOUP6XX06FM
	U6UYnFzNg7mdEV7rTY/CqOvFfZj/ZatHbLwxZpWyCDXb6Fda9RgdR8K9Il9fGt3ZNeWgIg2rIhLxY
	9lzbxOEuRHQu5GaMDh8TDnJHCzP/ntxAiS1dpjY6beTXgrD7XRmh+gifXKhEohiwwx1voWmop2zHp
	r6d7rBmbyQW/WpXE6CLHAhTQl/fMXupuGcsC82Xq8VWKi3+37Xi6C2/NshcGOFmYO1NW94PpH7JTk
	YIgSoU1YTqi6jsJzd2YTYMVltGqO578+0efmzfUUCay0y/WXGGZjv//3CcXQGhd2Lfp1uv+iqB91P
	OJTfWX8w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seK9Q-0000000130W-2f8i;
	Wed, 14 Aug 2024 19:59:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/2] jffs2: Use a folio in jffs2_garbage_collect_dnode()
Date: Wed, 14 Aug 2024 20:59:13 +0100
Message-ID: <20240814195915.249871-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814195915.249871-1-willy@infradead.org>
References: <20240814195915.249871-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call read_cache_folio() instead of read_cache_page() to get the folio
containing the page.  No attempt is made here to support large folios
as I assume that will never be interesting for jffs2.  Includes a switch
from kmap to kmap_local which looks safe.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jffs2/gc.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 5c6602f3c189..822949d0eb00 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -1171,7 +1171,7 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 	uint32_t alloclen, offset, orig_end, orig_start;
 	int ret = 0;
 	unsigned char *comprbuf = NULL, *writebuf;
-	struct page *page;
+	struct folio *folio;
 	unsigned char *pg_ptr;
 
 	memset(&ri, 0, sizeof(ri));
@@ -1317,25 +1317,25 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 		BUG_ON(start > orig_start);
 	}
 
-	/* The rules state that we must obtain the page lock *before* f->sem, so
+	/* The rules state that we must obtain the folio lock *before* f->sem, so
 	 * drop f->sem temporarily. Since we also hold c->alloc_sem, nothing's
 	 * actually going to *change* so we're safe; we only allow reading.
 	 *
 	 * It is important to note that jffs2_write_begin() will ensure that its
-	 * page is marked Uptodate before allocating space. That means that if we
-	 * end up here trying to GC the *same* page that jffs2_write_begin() is
-	 * trying to write out, read_cache_page() will not deadlock. */
+	 * folio is marked uptodate before allocating space. That means that if we
+	 * end up here trying to GC the *same* folio that jffs2_write_begin() is
+	 * trying to write out, read_cache_folio() will not deadlock. */
 	mutex_unlock(&f->sem);
-	page = read_cache_page(inode->i_mapping, start >> PAGE_SHIFT,
+	folio = read_cache_folio(inode->i_mapping, start >> PAGE_SHIFT,
 			       __jffs2_read_folio, NULL);
-	if (IS_ERR(page)) {
-		pr_warn("read_cache_page() returned error: %ld\n",
-			PTR_ERR(page));
+	if (IS_ERR(folio)) {
+		pr_warn("read_cache_folio() returned error: %ld\n",
+			PTR_ERR(folio));
 		mutex_lock(&f->sem);
-		return PTR_ERR(page);
+		return PTR_ERR(folio);
 	}
 
-	pg_ptr = kmap(page);
+	pg_ptr = kmap_local_folio(folio, 0);
 	mutex_lock(&f->sem);
 
 	offset = start;
@@ -1400,7 +1400,6 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 		}
 	}
 
-	kunmap(page);
-	put_page(page);
+	folio_release_kmap(folio, pg_ptr);
 	return ret;
 }
-- 
2.43.0


