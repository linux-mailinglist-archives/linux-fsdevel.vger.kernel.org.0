Return-Path: <linux-fsdevel+bounces-41398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA33BA2EE77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CE33A5650
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DFB231A2B;
	Mon, 10 Feb 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FH+pl9d0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CD230D30;
	Mon, 10 Feb 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194497; cv=none; b=payIVkv7ve+ixiplWX6ctejbLb+hXU0k/l2xHxRbTza2FwfDESN1LdocbIkY6xRa0VmpnXmIMQeeQrxOwTRbm5xZK7oeP3P4NdfNX3yXqxe/Qc5qm9BPlddFEdbQw44c5I5Z7yjAxouHBwvaojXZU5Jws6nEQmy4lkDxQmwkX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194497; c=relaxed/simple;
	bh=jytbP/7CpqddLcMVzufHIC4HolRZQ1p9IdqKYMkBl10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGEBAoCgpRnELbpFX359gkFUIZfOTQjLKEwk8NXMYJsO5UqAr1D/COnqa+aCgSOoK/S4YdQ3GCFX2UkyqybRLZgn5PIYLYarVQAy6BEYFjJd9tYP0zltDm6KzW88OQZ0XuvKg51X5+4yb0X964b40JVsBKMaCiASwLB8N5TzaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FH+pl9d0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3MHZxmUQgMb6Ftxk2klgrN+WeAlCYx13en5pr+i0su4=; b=FH+pl9d0O8QJOPsBGen7/isv4j
	aZaaVytGw1zqa0OWz5EO/diTaUZcbLW8ONQ+if0oXnE32ESgpePR6ehAk6SZA95WuqWaXT0JuUoKK
	FwMajDkYyvoaE7rp5cO/qG8HZblweOeDYzTrHwPsi2+9kAOMBu8AZqMHwLc/coDfUoQ0p8/QGckBM
	snhfoZY9F/QW3fqmQ/Jkyl/4z30O/D/5venoIjGKMxq1Vs7RiNy1HiQ+VP2B/joDP4jXc1iH0YViu
	5yoUv9BeOjlsFTUBOAUX/ze+p0pjNOtbimW3RvIwkuPUryzktdljToywoJboeeoM+GCyOpxZAEDN7
	IpzPp8Lw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw6-0000000FvaL-2BR3;
	Mon, 10 Feb 2025 13:34:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/8] gfs2: Convert gfs2_meta_read_endio() to use a folio
Date: Mon, 10 Feb 2025 13:34:46 +0000
Message-ID: <20250210133448.3796209-9-willy@infradead.org>
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

Switch from bio_for_each_segment_all() to bio_for_each_folio_all()
which removes a call to page_buffers().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/meta_io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 66db506a5f7f..198cc7056637 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -198,15 +198,14 @@ struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno)
 
 static void gfs2_meta_read_endio(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		struct buffer_head *bh = page_buffers(page);
-		unsigned int len = bvec->bv_len;
+	bio_for_each_folio_all(fi, bio) {
+		struct folio *folio = fi.folio;
+		struct buffer_head *bh = folio_buffers(folio);
+		size_t len = fi.length;
 
-		while (bh_offset(bh) < bvec->bv_offset)
+		while (bh_offset(bh) < fi.offset)
 			bh = bh->b_this_page;
 		do {
 			struct buffer_head *next = bh->b_this_page;
-- 
2.47.2


