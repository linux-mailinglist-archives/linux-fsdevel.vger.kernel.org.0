Return-Path: <linux-fsdevel+bounces-23857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE12933FFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49771F25B23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82755183088;
	Wed, 17 Jul 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPLg1yH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260E181D19
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231246; cv=none; b=EbqE9+l78zvK8495pcpvaWbmEEHczpDUxJ9hPEWIVtwtoWeLVIdL/uADXda5Cw8i3ff99BNxZZ36bLk94JUvNbsmQBEzIaUiQ8QYnIIQap8OilDQHBKYL3gT+y+npaEzz6lVeVqbhiCjgbF0Km/mW+XpjHPivq4XXSs3Qkizk2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231246; c=relaxed/simple;
	bh=ELnAo8CBmULij/KEc/2lvsUJ+h1V/uEJkQYEymXjj2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1uYeNLYxIPr3eY1GEks4AvTkeUFJYGGPU4U8oa4Ks0qpAqiyRxCtuOqQsKQDShDxHcO20ikWAxxHlkgXbKHTlFwYJt00jeS8DCM2wbAEuqWJATqIVxrB1fNUgVsS1FpTWj6figdcz8cRBMNk53YWhESExjGBYrSk5Hy/gamdJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WPLg1yH+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Pbk1NVlPO/rfZ/ZjiAO6/gIdINndRF77SxQx2CrwxEA=; b=WPLg1yH+REd9dUkjY852fR8E+Y
	qYkQ0hFY2zGnfLhJ5KW141yzt3uNXV6Ndg0bf7ZkKQYjhB7iB7QJgUggszH7dLdyLc2KCzxgbufyr
	kUL1m3jjWZHOSJ6oOz3Iq2lk1oJGr1zKUnh0bHxL36bdfFiF+4Tq360eK1/LHVsgMrj7Z+jhS+Qvw
	bUUR3qyUJ/aCOdL4NX8dT0ykOBw3LXxqILigigqIHwNop64minvfWXa2zEsaXmFGHr/cqKQsQtkCi
	LED3LZqMt+hKdWj1OSkcjiGL17Fcy0uxSKggUtYsjfwI5Rsro6LlleSwFXvR8+kP+cxEwYgEssjyF
	kTX6W6Ig==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sE-00000000zvz-3In7;
	Wed, 17 Jul 2024 15:47:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 22/23] ocfs2: Convert ocfs2_write_zero_page to use a folio
Date: Wed, 17 Jul 2024 16:47:12 +0100
Message-ID: <20240717154716.237943-23-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a conversion of folio to page, and then two hidden conversions
of page back to folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/file.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ccc57038a977..cfec1782ac2a 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -755,7 +755,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 				 u64 abs_to, struct buffer_head *di_bh)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 	unsigned long index = abs_from >> PAGE_SHIFT;
 	handle_t *handle;
 	int ret = 0;
@@ -774,9 +774,10 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 		goto out;
 	}
 
-	page = find_or_create_page(mapping, index, GFP_NOFS);
-	if (!page) {
-		ret = -ENOMEM;
+	folio = __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_NOFS);
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
 		mlog_errno(ret);
 		goto out_commit_trans;
 	}
@@ -803,7 +804,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 		 * __block_write_begin and block_commit_write to zero the
 		 * whole block.
 		 */
-		ret = __block_write_begin(page, block_start + 1, 0,
+		ret = __block_write_begin(&folio->page, block_start + 1, 0,
 					  ocfs2_get_block);
 		if (ret < 0) {
 			mlog_errno(ret);
@@ -812,7 +813,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 
 
 		/* must not update i_size! */
-		block_commit_write(page, block_start + 1, block_start + 1);
+		block_commit_write(&folio->page, block_start + 1, block_start + 1);
 	}
 
 	/*
@@ -833,8 +834,8 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 	}
 
 out_unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 out_commit_trans:
 	if (handle)
 		ocfs2_commit_trans(OCFS2_SB(inode->i_sb), handle);
-- 
2.43.0


