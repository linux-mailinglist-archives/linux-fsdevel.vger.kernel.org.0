Return-Path: <linux-fsdevel+bounces-2143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EF7E2B54
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71966B21F7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFEC2E3F7;
	Mon,  6 Nov 2023 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4ti3kBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA772D04A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:20 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CDB10FB;
	Mon,  6 Nov 2023 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4uhZUS0AdWumlXemxYuWKBzovY188acPLOiZKj6oePo=; b=d4ti3kBfS7MwI5eFQEiHq5/2ok
	Z/YhG8QJ2Vo3ym7Gw7cAyS9s6Mv2xFuOsmP1K6rS3PYm8lVoNCTMUOZSk2ggqXn5l+G4uR+QiQ1Yx
	bRZnEhWXedopHqc47YjwNGlYS+DalD17IaIINVKeTOum4BSz1N9kEBICLb0tWD8RMWuiKX7mj5prj
	9KBn0E5xmEwtrX2IiXfXt+7PPVDYcxZbS7qIR2Jzy0utzk9k8tHKLmLXps0bCCCJS05k1hregmoMr
	CGS03P9eXP+3cNr5JHEljl94Pg5F1aPJ1q0mov0Wmtqlys5IaUXH7QWjyijeKtNokdzFv12V/0xd7
	T/uyWzoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z8-007HBP-0W; Mon, 06 Nov 2023 17:39:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 32/35] nilfs2: Convert nilfs_empty_dir() to use a folio
Date: Mon,  6 Nov 2023 17:39:00 +0000
Message-Id: <20231106173903.1734114-33-willy@infradead.org>
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

Remove three calls to compound_head() by using the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index fd4f99a7f402..e598431516fc 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -203,17 +203,6 @@ static void *nilfs_get_folio(struct inode *dir, unsigned long n,
 	return ERR_PTR(-EIO);
 }
 
-static void *nilfs_get_page(struct inode *dir, unsigned long n,
-		struct page **pagep)
-{
-	struct folio *folio;
-	void *kaddr = nilfs_get_folio(dir, n, &folio);
-
-	if (!IS_ERR(kaddr))
-		*pagep = &folio->page;
-	return kaddr;
-}
-
 /*
  * NOTE! unlike strncmp, nilfs_match returns 1 for success, 0 for failure.
  *
@@ -613,14 +602,14 @@ int nilfs_make_empty(struct inode *inode, struct inode *parent)
  */
 int nilfs_empty_dir(struct inode *inode)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	char *kaddr;
 	unsigned long i, npages = dir_pages(inode);
 
 	for (i = 0; i < npages; i++) {
 		struct nilfs_dir_entry *de;
 
-		kaddr = nilfs_get_page(inode, i, &page);
+		kaddr = nilfs_get_folio(inode, i, &folio);
 		if (IS_ERR(kaddr))
 			continue;
 
@@ -649,12 +638,12 @@ int nilfs_empty_dir(struct inode *inode)
 			}
 			de = nilfs_next_entry(de);
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 1;
 
 not_empty:
-	unmap_and_put_page(page, kaddr);
+	folio_release_kmap(folio, kaddr);
 	return 0;
 }
 
-- 
2.42.0


