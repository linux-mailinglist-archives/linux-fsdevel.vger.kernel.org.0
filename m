Return-Path: <linux-fsdevel+bounces-17189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818648A8AA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F395B21D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9E0172BCF;
	Wed, 17 Apr 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vbb8N/E/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD65173325
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376624; cv=none; b=R3zCUh2GP4IZQ3cZqrm33f1aY1YVTmkDCx53uiFXk5nuJnRE4Vd7GySTXcQPBW5be1niv99iqco0nQsVOaaDMN1AYfA7OAMHIMzF4aIC4P9nuqlDM9vEoZExRxq/EdrQgsKXBnRzOXEbEDVACRdX5Cn3A8QB9I3Wi0GYXoQQuSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376624; c=relaxed/simple;
	bh=KnJJCpTcdUhV3W47B8I2pmRC5IRBCRmUcD0PS4pSasY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBM2JgXy0DfOh0+eVhZEeWMafHemJPhCJacDGt8bhhQwTki36Z9u613ZwA+DVNcOW3om8q8WEalDHSdwhaCZxR6wK0sjyQH7F/ovNRljYlSN3KWHJbp7to+eARVm8vMoT2KA2xqeQIg+IsjU9H5SqGxeR1fYMEQonhUM0alFUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vbb8N/E/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=D9EBnQ6ShJLhbDLeJCMWhwk0es97hySDrklC2B03Dko=; b=Vbb8N/E/w2OUUpjUMCnyL+buO3
	azy9Bs3jGF+2O/I001Mr2gugZLIOLqwijoEj8nWhR5anZBgrSZaRRemn9ITIgoKpXDF1kBTkzR1UJ
	ZyOJHYsmpi4bgRIo2N6rZvIcWKpCeCDBqgamTcAk+n1gXJPu7fZTHHeFxAOMHiAWqo9K8MWQ19aRX
	ejtiCwZy57v2nQm1Y7EQXMwySm183oWu319JXi7uX2CpXRsAMzBzx2fBeLcamoxfLsQnN/JebJEAL
	Hn9p5vYgiG+Z5/tja2OSzYkUa8Oz4kN6owy7EJHL6HXGy+Gi96DtYdEVuAmciRWNI95yNYnBzYNNf
	6SLbxC9g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wn-00000003Qt7-1nxp;
	Wed, 17 Apr 2024 17:57:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/13] jfs; Convert release_metapage to use a folio
Date: Wed, 17 Apr 2024 18:56:49 +0100
Message-ID: <20240417175659.818299-6-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert mp->page to a folio and remove 7 hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 6fa7023f5bc9..4515dc1ac40e 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -749,37 +749,35 @@ void put_metapage(struct metapage *mp)
 
 void release_metapage(struct metapage * mp)
 {
-	struct page *page = mp->page;
+	struct folio *folio = page_folio(mp->page);
 	jfs_info("release_metapage: mp = 0x%p, flag = 0x%lx", mp, mp->flag);
 
-	BUG_ON(!page);
-
-	lock_page(page);
+	folio_lock(folio);
 	unlock_metapage(mp);
 
 	assert(mp->count);
 	if (--mp->count || mp->nohomeok) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return;
 	}
 
 	if (test_bit(META_dirty, &mp->flag)) {
-		set_page_dirty(page);
+		folio_mark_dirty(folio);
 		if (test_bit(META_sync, &mp->flag)) {
 			clear_bit(META_sync, &mp->flag);
-			if (metapage_write_one(page))
+			if (metapage_write_one(&folio->page))
 				jfs_error(mp->sb, "metapage_write_one() failed\n");
-			lock_page(page);
+			folio_lock(folio);
 		}
 	} else if (mp->lsn)	/* discard_metapage doesn't remove it */
 		remove_from_logsync(mp);
 
 	/* Try to keep metapages from using up too much memory */
-	drop_metapage(page, mp);
+	drop_metapage(&folio->page, mp);
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
 void __invalidate_metapages(struct inode *ip, s64 addr, int len)
-- 
2.43.0


