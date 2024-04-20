Return-Path: <linux-fsdevel+bounces-17340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F48AB8F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3AB280FF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5E79DE;
	Sat, 20 Apr 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ruRXVF99"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF72168DD
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581459; cv=none; b=F6Mqdm3BDGxXHYHT535aZ+WrocoF4gxbybBmQCZtlz2+mv6WAGzJAfwYz/TG64giWXBqe32Nhmak35y/Mn4JRnfHzSn1r4LXOlAakIc5hMqu2o2OTNwh4trQHZKG7AOzfulRDTfgTH44BEF7mvFsyhNNCI0LGllw51SCXTswqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581459; c=relaxed/simple;
	bh=KaPNOVuUVuEjTVmcdyO8J4f57l7zVa1j6/lsJSmKYk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOgA9RTnthTFpPVqjYX3ZsEEJbDHsYQfweSw3o0A/9EHd1uwiG6MKnlOKDNdLdlNlOp9BoB2fNkcB0VVVT+hXkPHGgqYYgD3bbCY4qEtTh9znqBGTtmPKr9EJGS0+QcZJMNjCHZU54R+DbtpAXblVRrTpRLOZlMnmzM6zlIZmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ruRXVF99; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MJMENjdS4BJ0YzSSow5tG6Tg5qbkadhyjSdDc4cHqzI=; b=ruRXVF99zXFKvopDQnSF+8Bd9l
	iaWjA2w6KOon8kdBwDUeBM7P54+9T441HzJjm966NQ780OrVhREjfdyujh9ABmi7/L8Gk1KrWYUad
	hy/gsb5FnuaQ3KPDoRjKC1wwq99hk/VJXXHVYOZRMMTLKU7pqScZ8cO8kb0XwPV8e+c/FjKRC9zPc
	rCmyUssApXo1Kq8oYWL4VwQ6s8TNhS/gObU+6MgqWU8pfuDMmcTFZO8W8vmKNHHMm/aPA3ye3Ah+K
	/GyCP1/rWDExRK6Cj9he4RAp06QycdFEv4DHEmo+SIIvTdt3bn9aC4cVY7FI2fXrq/MiZ+4nTK4HZ
	13vFSU8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oZ-000000095fr-0MOh;
	Sat, 20 Apr 2024 02:50:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org
Subject: [PATCH 18/30] orangefs: Remove calls to set/clear the error flag
Date: Sat, 20 Apr 2024 03:50:13 +0100
Message-ID: <20240420025029.2166544-19-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag on orangefs folios, so stop setting and
clearing it.  We can also use folio_end_read() to simplify
orangefs_read_folio().

Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c           | 13 +++----------
 fs/orangefs/orangefs-bufmap.c |  4 +---
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 085912268442..fdb9b65db1de 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -56,7 +56,6 @@ static int orangefs_writepage_locked(struct page *page,
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
 	    len, wr, NULL, NULL);
 	if (ret < 0) {
-		SetPageError(page);
 		mapping_set_error(page->mapping, ret);
 	} else {
 		ret = 0;
@@ -119,7 +118,6 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	    0, &wr, NULL, NULL);
 	if (ret < 0) {
 		for (i = 0; i < ow->npages; i++) {
-			SetPageError(ow->pages[i]);
 			mapping_set_error(ow->pages[i]->mapping, ret);
 			if (PagePrivate(ow->pages[i])) {
 				wrp = (struct orangefs_write_range *)
@@ -303,15 +301,10 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 	iov_iter_zero(~0U, &iter);
 	/* takes care of potential aliasing */
 	flush_dcache_folio(folio);
-	if (ret < 0) {
-		folio_set_error(folio);
-	} else {
-		folio_mark_uptodate(folio);
+	if (ret > 0)
 		ret = 0;
-	}
-	/* unlock the folio after the ->read_folio() routine completes */
-	folio_unlock(folio);
-        return ret;
+	folio_end_read(folio, ret == 0);
+	return ret;
 }
 
 static int orangefs_write_begin(struct file *file,
diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index b501dc07f922..edcca4beb765 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -274,10 +274,8 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
 		gossip_err("orangefs error: asked for %d pages, only got %d.\n",
 				bufmap->page_count, ret);
 
-		for (i = 0; i < ret; i++) {
-			SetPageError(bufmap->page_array[i]);
+		for (i = 0; i < ret; i++)
 			unpin_user_page(bufmap->page_array[i]);
-		}
 		return -ENOMEM;
 	}
 
-- 
2.43.0


