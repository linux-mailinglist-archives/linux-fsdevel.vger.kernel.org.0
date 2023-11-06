Return-Path: <linux-fsdevel+bounces-2122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7AB7E2B31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A002281F19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133142C870;
	Mon,  6 Nov 2023 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pr14DMGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5029D10
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:14 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4280ED71;
	Mon,  6 Nov 2023 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NwhU+RYRS2KqhDUYWGDRZRyMStg4doHH4Ot5RU5n7LI=; b=Pr14DMGc9xyupLqn7HMLmbMg71
	HZwXoeEES9k7lMLdFtH0QaTa5IkOt/MKjRpMZjS3xmY5Y73mIHsJSqH9EYKfbcRybLQsMGRmQlTBG
	mfueIp08Z1pCFT4zMkx0VHhGvPKIaM6fIXEx9oKqUAs1MxK0MwY+AIxN8aKIxDYLQddD6wQ6seu2k
	V6dQTZrwJ7jTZX6bHUR2C6n2PluebKj/Ogw/pcz1kEsL3CmHF+J3rk1wf8flewZOu8F1mqTDkM71C
	4EMicxfaPpvMWnaFkDq8mgXtHgTIUSfChJEY0GbqTK+2ySStDj5izRFVc8xZ5a1OhnmW3bgUQfCdT
	tPpDsZrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z4-007H8K-JP; Mon, 06 Nov 2023 17:39:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/35] nilfs2: Convert nilfs_mdt_write_page() to use a folio
Date: Mon,  6 Nov 2023 17:38:35 +0000
Message-Id: <20231106173903.1734114-8-willy@infradead.org>
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

Convert the incoming page to a folio.  Replaces three calls to
compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/mdt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index c97c77a39668..327408512b86 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -399,7 +399,8 @@ int nilfs_mdt_fetch_dirty(struct inode *inode)
 static int
 nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 	struct super_block *sb;
 	int err = 0;
 
@@ -407,16 +408,16 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		/*
 		 * It means that filesystem was remounted in read-only
 		 * mode because of error or metadata corruption. But we
-		 * have dirty pages that try to be flushed in background.
-		 * So, here we simply discard this dirty page.
+		 * have dirty folios that try to be flushed in background.
+		 * So, here we simply discard this dirty folio.
 		 */
 		nilfs_clear_dirty_page(page, false);
-		unlock_page(page);
+		folio_unlock(folio);
 		return -EROFS;
 	}
 
-	redirty_page_for_writepage(wbc, page);
-	unlock_page(page);
+	folio_redirty_for_writepage(wbc, folio);
+	folio_unlock(folio);
 
 	if (!inode)
 		return 0;
-- 
2.42.0


