Return-Path: <linux-fsdevel+bounces-41401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED4A2EE64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C231889CC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D033A231A3E;
	Mon, 10 Feb 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0VKP9CN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9422257D;
	Mon, 10 Feb 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194498; cv=none; b=F2fTt2bWs1VL+fO1zL64wqRf+7SGK4cj2UFSjWlCexPUjY5wBYXvkKazXFqlJWlGXHPJpSL2ajG3oFmbsHy7Iz7G666bBX9Wz7dcg26fptJ44CFA8xLsB0QX9lVsx03zTDX9sQjZx+sW36YCTnqcOLhVg1RB/WmH3qf6HmtdCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194498; c=relaxed/simple;
	bh=G5MQAkwjXu7ZUa4H1wMu9ghfVIcxJIvDSwfBOZCIFk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvLQXUuajXzwYAZZ8GLlWS4Ur/xvyWR4xGflKNPMx8ZNPkDuNguSWO02MvvBayi5FbIyxQs5xibXNcB7FV+IVfM99V6AKJwMgbWq5vwS4tUzEQ1lNC1ScMuOQ5Xo6ZXshWu+R2TYn06hYk/KtRTSdwgy9rZWPUApfwC9rMmURG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d0VKP9CN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Hi+jzrMT6xb/lTp/ZUXoNdBN+v14Xu6vELVXoad0c+I=; b=d0VKP9CN3z6w0GxsorO9BHkhjT
	GaCYxLHCxxbg0fV4lJ2gHwD3BdJpGDsh1jA9JSxUnK5eMDjhlwz4IDeVZvwtcT87hedUN/4VXZAL/
	GeKPpDVkqMEZnEG3laPdsv7zNAMy1Ds0BhuzITB4gbgAEIC0RRBivdu+6sdPUYaSvgy7m8hrqRHw9
	JRy3M0QDtGULwGXoBgz/thXI4KM1wjokb9KQwxvDk5hywu5kzAZALfJKReYe0TAxk5czvYniRgL7d
	HXGE9TG2aPvtjrgA/dO3tgCJQfvc75rOoi7ahd1AO+dLIfmaDGx3GE5w+F2QMxRonwJ/+uJ2OiZuy
	VoqcpuFg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw6-0000000Fva3-0YlX;
	Mon, 10 Feb 2025 13:34:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/8] gfs2: Convert gfs2_jhead_pg_srch() to gfs2_jhead_folio_srch()
Date: Mon, 10 Feb 2025 13:34:43 +0000
Message-ID: <20250210133448.3796209-6-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133448.3796209-1-willy@infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass in the folio instead of the page.  Add an assert that this is
not a large folio as we'd need a more complex solution if we wanted to
kmap() each page out of a large folio.  Removes a use of folio->page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/lops.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 4123bfc16680..09e4c5915243 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -406,17 +406,16 @@ static void gfs2_end_log_read(struct bio *bio)
 }
 
 /**
- * gfs2_jhead_pg_srch - Look for the journal head in a given page.
+ * gfs2_jhead_folio_srch - Look for the journal head in a given page.
  * @jd: The journal descriptor
  * @head: The journal head to start from
- * @page: The page to look in
+ * @folio: The folio to look in
  *
  * Returns: 1 if found, 0 otherwise.
  */
-
-static bool gfs2_jhead_pg_srch(struct gfs2_jdesc *jd,
+static bool gfs2_jhead_folio_srch(struct gfs2_jdesc *jd,
 			      struct gfs2_log_header_host *head,
-			      struct page *page)
+			      struct folio *folio)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 	struct gfs2_log_header_host lh;
@@ -424,7 +423,8 @@ static bool gfs2_jhead_pg_srch(struct gfs2_jdesc *jd,
 	unsigned int offset;
 	bool ret = false;
 
-	kaddr = kmap_local_page(page);
+	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
+	kaddr = kmap_local_folio(folio, 0);
 	for (offset = 0; offset < PAGE_SIZE; offset += sdp->sd_sb.sb_bsize) {
 		if (!__get_log_header(sdp, kaddr + offset, 0, &lh)) {
 			if (lh.lh_sequence >= head->lh_sequence)
@@ -472,7 +472,7 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 		*done = true;
 
 	if (!*done)
-		*done = gfs2_jhead_pg_srch(jd, head, &folio->page);
+		*done = gfs2_jhead_folio_srch(jd, head, folio);
 
 	/* filemap_get_folio() and the earlier grab_cache_page() */
 	folio_put_refs(folio, 2);
-- 
2.47.2


