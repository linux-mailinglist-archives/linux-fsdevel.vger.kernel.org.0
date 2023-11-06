Return-Path: <linux-fsdevel+bounces-2134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F487E2B4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69698B21B85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50C2D7A4;
	Mon,  6 Nov 2023 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBU9S/ha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365D2C86E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:16 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9B10C7;
	Mon,  6 Nov 2023 09:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6f31LpAk04SjO1wv4hq8iHBkCZDYWo/mqrg8dAuvBXA=; b=JBU9S/haJTAdpaIbZb2u5PX9hN
	mr73CG9SWl2lgPNQuXT3sLt1xExgNhnAYx8r1Cr4A5TLqsni9n2wAaWRXMwrgn+LMzARnmEUyNFNF
	avWtJcXOEIV5v+GRBHPPAoMMHUcLIBvcPVeHSafgaloWO5ff5kQxRaTCyKN3y4unPb2jQ4rSveSjJ
	UW4TAZ1RUtRp1vrdOZbBQQyziMcoZKVhataeGhckjyxmzQvCxfie+tJ0qSRbgDcMuOMS5tVguDOjG
	RPp8wNuW0jLXwRa0KmCR98MAuxSX0k7HEtb5n4QIPn6LMhjdox1R+eT4eRd68GbBwJVbFQM86R6z9
	toJH8uWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z6-007H9g-2U; Mon, 06 Nov 2023 17:39:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/35] nilfs2: Convert nilfs_btnode_prepare_change_key to use a folio
Date: Mon,  6 Nov 2023 17:38:46 +0000
Message-Id: <20231106173903.1734114-19-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Saves three calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/btnode.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index e077d4a7a11c..da3e4366625f 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -185,23 +185,23 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 	ctxt->newbh = NULL;
 
 	if (inode->i_blkbits == PAGE_SHIFT) {
-		struct page *opage = obh->b_page;
-		lock_page(opage);
+		struct folio *ofolio = obh->b_folio;
+		folio_lock(ofolio);
 retry:
 		/* BUG_ON(oldkey != obh->b_folio->index); */
-		if (unlikely(oldkey != opage->index))
-			NILFS_PAGE_BUG(opage,
+		if (unlikely(oldkey != ofolio->index))
+			NILFS_PAGE_BUG(&ofolio->page,
 				       "invalid oldkey %lld (newkey=%lld)",
 				       (unsigned long long)oldkey,
 				       (unsigned long long)newkey);
 
 		xa_lock_irq(&btnc->i_pages);
-		err = __xa_insert(&btnc->i_pages, newkey, opage, GFP_NOFS);
+		err = __xa_insert(&btnc->i_pages, newkey, ofolio, GFP_NOFS);
 		xa_unlock_irq(&btnc->i_pages);
 		/*
-		 * Note: page->index will not change to newkey until
+		 * Note: folio->index will not change to newkey until
 		 * nilfs_btnode_commit_change_key() will be called.
-		 * To protect the page in intermediate state, the page lock
+		 * To protect the folio in intermediate state, the folio lock
 		 * is held.
 		 */
 		if (!err)
@@ -213,7 +213,7 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 		if (!err)
 			goto retry;
 		/* fallback to copy mode */
-		unlock_page(opage);
+		folio_unlock(ofolio);
 	}
 
 	nbh = nilfs_btnode_create_block(btnc, newkey);
@@ -225,7 +225,7 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 	return 0;
 
  failed_unlock:
-	unlock_page(obh->b_page);
+	folio_unlock(obh->b_folio);
 	return err;
 }
 
-- 
2.42.0


