Return-Path: <linux-fsdevel+bounces-23847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DDE933FF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398AFB242F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0911822EA;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oOWMzVx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D94180A94
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231244; cv=none; b=FvC657pqf97+eqFJ7o8mPUgKn9uDWnHA8YCH2HkpnGL6LNWifQ9hF2QS1QYfwuyS7UeqiXy3aTbW3E1mk6QATCLu0oRIoCJcnD3+6Fjhb/eYElw6fgOyIpgHE0oMY/14fH9/3OgBksk65vu9o31Tc92svvvRu7LOHPuDW2Ci33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231244; c=relaxed/simple;
	bh=+to0gAauLuAZH3poO65e5NxxjZRymZ2M3YL6DSB6blk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJCMHBZ8seK2ChzAQ36+cTg9PBI+uUb8Ejx8KaaiBzSKt9+I8Ir7YWrwvxh3erxgsF8Ji64HjSU9ylt4hUP87Z5e4Z0qRH1lF7A6qrW0UcqI3KqAQqDYHMg7kugnj9i4/ggWoNVoT6+mdvzGMUHRnNn/hB48W0RBgyKx3yTOmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oOWMzVx4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O+dDgfcieFHwP0TagupOraW3Tp4ZP9cjGCKGH4FqAyg=; b=oOWMzVx4/RVS4wzFVO6g8VacjC
	FEaIGd4PVra571MvRcwKNQ/4ofH9+JIz8/2XZq1oYZ3mzVqMDpkZCFrH37Vm913pnvsqCi29wkRQU
	Tn6RIQjwpdogcIVOEgv34VFrj/7/PGiZGS2Wprpc9WJOKwDtANGzS9Qkm79T/mq/gR4L1O9P3pyW3
	WaEaG0BcVFBL/WH56iZ3MNmHZiY0MY27OfbcTfUdVl6KtRwymrjYUdFtt9BjfE3e02mQf07qKt0mY
	m79Ayh65N0n0jC8jysodKTtVJT6VQiJ4HvhBSV+iSJCaMWRm0l4GKxTr33THgpNB/LSRna6wA4yts
	6NH2NEvw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sD-00000000zus-25iw;
	Wed, 17 Jul 2024 15:47:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 12/23] fuse: Convert fuse_write_end() to use a folio
Date: Wed, 17 Jul 2024 16:47:02 +0100
Message-ID: <20240717154716.237943-13-willy@infradead.org>
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

Convert the passed page to a folio and operate on that.
Replaces five calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..f4102c6657af 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2434,29 +2434,30 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, unsigned copied,
 		struct page *page, void *fsdata)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 
 	/* Haven't copied anything?  Skip zeroing, size extending, dirtying. */
 	if (!copied)
 		goto unlock;
 
 	pos += copied;
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		/* Zero any unwritten bytes at the end of the page */
 		size_t endoff = pos & ~PAGE_MASK;
 		if (endoff)
-			zero_user_segment(page, endoff, PAGE_SIZE);
-		SetPageUptodate(page);
+			folio_zero_segment(folio, endoff, PAGE_SIZE);
+		folio_mark_uptodate(folio);
 	}
 
 	if (pos > inode->i_size)
 		i_size_write(inode, pos);
 
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return copied;
 }
-- 
2.43.0


