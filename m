Return-Path: <linux-fsdevel+bounces-473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B729A7CB40F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFD2281934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3157736B0D;
	Mon, 16 Oct 2023 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ff3w/lmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748BC381A5
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:31 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F60FFE;
	Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1Qmaj5woCknpqJNFRJKv0P5B8IW/icZejqOhxCQNhr0=; b=Ff3w/lmZD39hmW/uMppRtz2aDk
	JmhIApYj0wIh0qa9OgFFBAsoszVNIh+zOILxo35m0POZnjdkK3/Y8S4VxeD8GrZTaIW8KQJeFi/73
	QbqKknupzVLjAVAJZ5qWUpTJTnYHeLeeieI0S52apbLidzDj7XCKKRfuqONYx6eRkNKVw1b715ZFJ
	IfL7S9sgDSI8PqWJPe4PDggP/oAbn6bmjpdvC4rSz4ff8QnbEezQpkRrVnM57OUCM4NNpboXXZ+cJ
	fpvrUTe1OyXftZWPsn8CIzlmADkDiDTx+ZDMzz/cZeSq0JQlRppDEzlYOiQV0cDPOQNjjBiQJEXhv
	FLJ8mMmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvp-0085ag-8T; Mon, 16 Oct 2023 20:11:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	reiserfs-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 07/27] gfs2: Convert gfs2_getbuf() to folios
Date: Mon, 16 Oct 2023 21:10:54 +0100
Message-Id: <20231016201114.1928083-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231016201114.1928083-1-willy@infradead.org>
References: <20231016201114.1928083-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove several folio->page->folio conversions.  Also use __GFP_NOFAIL
instead of calling yield() and the new get_nth_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/meta_io.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 924361fa510b..f1fac1b45059 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -115,7 +115,7 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 {
 	struct address_space *mapping = gfs2_glock2aspace(gl);
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct page *page;
+	struct folio *folio;
 	struct buffer_head *bh;
 	unsigned int shift;
 	unsigned long index;
@@ -129,36 +129,31 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 	bufnum = blkno - (index << shift);  /* block buf index within page */
 
 	if (create) {
-		for (;;) {
-			page = grab_cache_page(mapping, index);
-			if (page)
-				break;
-			yield();
-		}
-		if (!page_has_buffers(page))
-			create_empty_buffers(page, sdp->sd_sb.sb_bsize, 0);
+		folio = __filemap_get_folio(mapping, index,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_mask(mapping) | __GFP_NOFAIL);
+		bh = folio_buffers(folio);
+		if (!bh)
+			bh = folio_create_empty_buffers(folio,
+				sdp->sd_sb.sb_bsize, 0);
 	} else {
-		page = find_get_page_flags(mapping, index,
-						FGP_LOCK|FGP_ACCESSED);
-		if (!page)
+		folio = __filemap_get_folio(mapping, index,
+				FGP_LOCK | FGP_ACCESSED, 0);
+		if (IS_ERR(folio))
 			return NULL;
-		if (!page_has_buffers(page)) {
-			bh = NULL;
-			goto out_unlock;
-		}
+		bh = folio_buffers(folio);
 	}
 
-	/* Locate header for our buffer within our page */
-	for (bh = page_buffers(page); bufnum--; bh = bh->b_this_page)
-		/* Do nothing */;
-	get_bh(bh);
+	if (!bh)
+		goto out_unlock;
 
+	bh = get_nth_bh(bh, bufnum);
 	if (!buffer_mapped(bh))
 		map_bh(bh, sdp->sd_vfs, blkno);
 
 out_unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return bh;
 }
-- 
2.40.1


