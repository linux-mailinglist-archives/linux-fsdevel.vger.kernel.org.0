Return-Path: <linux-fsdevel+bounces-23842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54062933FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15D01F251D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09A374C2;
	Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ja4mlRAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05681E492
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231244; cv=none; b=BGu7P3FqZ6JdNV/7IG1jW9fAUPKzTxOwVXgwHgdPiODD6o/BaGTZYW2aBodXtONLQVxOsyaO0eKmFpVEoQ6O2gvSPyew4Q9YVGrEAcQmFWnYFCg9e9quaIQL8k5aiKCcaNc/FE1/aPKwlO6AyIhzgD7VTGi2uJLUjozsq4UIaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231244; c=relaxed/simple;
	bh=nla3jkKNvTYp95HJASorKTmy9W6AOiKgIZbTVI44VME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKw5IpaSl4PQLyTpoCLmuLqoVjsLaHuWERCOavEmGlAlljw3bNzIHuKVCfdI4X17knyqaVxbTzqzXfFQkNeVVA8a013gYrOz0Cb+NnVrcT2YuGE2I631jpcnFiYFFG2gaJ0iyIiI8ndwl8jzdzbJiKcXAajl0Htsc1N/2yzwpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ja4mlRAT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dlnlpZ6iTykzM4N6tcHdTDv51fr2DfDLCkDJBtlFMrI=; b=ja4mlRATwVUfauGMD9t/iYDagy
	rbwL2jflMV9T0myxi5DSZyXSeYKEX3T8HYXlrRtLTuBLw5sOw2UuH7oBPLXKZwGYzIoydad6EVBPj
	5ELlfVRfgN5k3bUf8gFQ34h2QlLAFg1rvnVqp0FT4hEyiqj5W2vTWTsQzoQHb849OAxT8FZeKidih
	bM+4R1/Gpjd9w+d9+mabQtD6Bc0p0V0Y31gHMn+BtAiQpGwTUc3PThJmTrJA0r9G/KaWTpoW9kGhN
	MPb59o1RWwtOaH4BOzLbJm041KJ6afWUnCZaQDOw6xjHPKcAgTQWme2Az/EuH3BUpd6/wMnjR5ZgM
	GqJUZeDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sC-00000000zuE-1Cw3;
	Wed, 17 Jul 2024 15:47:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/23] buffer: Use a folio in generic_write_end()
Date: Wed, 17 Jul 2024 16:46:54 +0100
Message-ID: <20240717154716.237943-5-willy@infradead.org>
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

Replaces two implicit calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a9aeb04da398..448338810802 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2283,6 +2283,7 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
 	bool i_size_changed = false;
@@ -2293,7 +2294,7 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 	 * No need to use i_size_read() here, the i_size cannot change under us
 	 * because we hold i_rwsem.
 	 *
-	 * But it's important to update i_size while still holding page lock:
+	 * But it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 */
 	if (pos + copied > inode->i_size) {
@@ -2301,8 +2302,8 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 		i_size_changed = true;
 	}
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
-- 
2.43.0


