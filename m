Return-Path: <linux-fsdevel+bounces-2146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D407E2B58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D238C1C20DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5A2E41F;
	Mon,  6 Nov 2023 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gM8/OHfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85202D032
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:18 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0610F2;
	Mon,  6 Nov 2023 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TNJtKlru0Tsq6D54odQRez6pWr4z9Ka0jzU4Cn2l/PY=; b=gM8/OHfZhC7LtdJXfue3UijQ1u
	WlS7ykIXMMvxM3d8kOL0x0YWjNRNfJCmNN6RUYCXdEz3FnDwyMMJYNvnBqsmLsnBaJvSYtxAxhrTd
	RR7sucnQ5I3uJbqUYJeEJIOOkIgVLaq8WRtt3ChJ6G1IzeUHeC3MPPRzYA952tbBZLRkTFckod0kR
	yby+5hR7AJgubYamsEl14Vc3YjraMynmH471iuCcZgrsf/n5NnP5mvAMo1AUe2T2kiofmxaul928Q
	A7EgQ1GCP3qBec0/sb2G40Wzuclg9Ai2dykXDp/Ldg07VxJNbahY3JhCCZS3GONaHj8I+sf37wBQB
	emIIxCDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z7-007HAv-Eo; Mon, 06 Nov 2023 17:39:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 28/35] nilfs2: Convert nilfs_readdir to use a folio
Date: Mon,  6 Nov 2023 17:38:56 +0000
Message-Id: <20231106173903.1734114-29-willy@infradead.org>
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

Use the new folio APIs to remove calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 9e3339123d89..8d74f1d9bb62 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -284,9 +284,9 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct nilfs_dir_entry *de;
-		struct page *page;
+		struct folio *folio;
 
-		kaddr = nilfs_get_page(inode, n, &page);
+		kaddr = nilfs_get_folio(inode, n, &folio);
 		if (IS_ERR(kaddr)) {
 			nilfs_error(sb, "bad page in #%lu", inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
@@ -298,7 +298,7 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 		for ( ; (char *)de <= limit; de = nilfs_next_entry(de)) {
 			if (de->rec_len == 0) {
 				nilfs_error(sb, "zero-length directory entry");
-				unmap_and_put_page(page, kaddr);
+				folio_release_kmap(folio, kaddr);
 				return -EIO;
 			}
 			if (de->inode) {
@@ -311,13 +311,13 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 
 				if (!dir_emit(ctx, de->name, de->name_len,
 						le64_to_cpu(de->inode), t)) {
-					unmap_and_put_page(page, kaddr);
+					folio_release_kmap(folio, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += nilfs_rec_len_from_disk(de->rec_len);
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 0;
 }
-- 
2.42.0


