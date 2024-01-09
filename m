Return-Path: <linux-fsdevel+bounces-7618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E9828838
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EC91C23D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539603A267;
	Tue,  9 Jan 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QprLpERe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67739ACB;
	Tue,  9 Jan 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TCE+5KgYHDY4CxZU9Cz581t8brafbTwNpWCFcRWEPX0=; b=QprLpEReoXz9XO1qo8ivYWUljL
	WEpivWzbQ+yI6DWv13a4pSX7mHzEOA2ggrtVvmM0oT2Ekfgzx3bfl9+7MPsI1DOELJ3giHqy3UlvZ
	H/G92q+Ry9bCNQAf8wAJ8eCSEeOkIVPW3Y/F8cz1mINg3IyFMEAaznImZ57gdDcFaPJRcSwQ7IF7P
	B5q9WLoAdJj6+vQ2tsn0BkwJuCoA2iyZnYPWSbpBROBId7Iddi3eI/6JhYyP0SreMRTemcgzZfeIP
	k1eCKjqGZDUALWkdG1nYcQkSKPlFq5AtPe+JRaxmX5oc/SVvUOYUPMUUaI0dvPcLrwmNqY/tcOy+3
	ZHPtf5JA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNDB0-009xrS-Tw; Tue, 09 Jan 2024 14:33:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] buffer: Add kernel-doc for block_dirty_folio()
Date: Tue,  9 Jan 2024 14:33:51 +0000
Message-Id: <20240109143357.2375046-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240109143357.2375046-1-willy@infradead.org>
References: <20240109143357.2375046-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn the excellent documentation for this function into kernel-doc.
Replace 'page' with 'folio' and make a few other minor updates.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 55 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d3bcf601d3e5..071f01b28c90 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -687,30 +687,37 @@ void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 }
 EXPORT_SYMBOL(mark_buffer_dirty_inode);
 
-/*
- * Add a page to the dirty page list.
- *
- * It is a sad fact of life that this function is called from several places
- * deeply under spinlocking.  It may not sleep.
- *
- * If the page has buffers, the uptodate buffers are set dirty, to preserve
- * dirty-state coherency between the page and the buffers.  It the page does
- * not have buffers then when they are later attached they will all be set
- * dirty.
- *
- * The buffers are dirtied before the page is dirtied.  There's a small race
- * window in which a writepage caller may see the page cleanness but not the
- * buffer dirtiness.  That's fine.  If this code were to set the page dirty
- * before the buffers, a concurrent writepage caller could clear the page dirty
- * bit, see a bunch of clean buffers and we'd end up with dirty buffers/clean
- * page on the dirty page list.
- *
- * We use i_private_lock to lock against try_to_free_buffers while using the
- * page's buffer list.  Also use this to protect against clean buffers being
- * added to the page after it was set dirty.
- *
- * FIXME: may need to call ->reservepage here as well.  That's rather up to the
- * address_space though.
+/**
+ * block_dirty_folio - Mark a folio as dirty.
+ * @mapping: The address space containing this folio.
+ * @folio: The folio to mark dirty.
+ *
+ * Filesystems which use buffer_heads can use this function as their
+ * ->dirty_folio implementation.  Some filesystems need to do a little
+ * work before calling this function.  Filesystems which do not use
+ * buffer_heads should call filemap_dirty_folio() instead.
+ *
+ * If the folio has buffers, the uptodate buffers are set dirty, to
+ * preserve dirty-state coherency between the folio and the buffers.
+ * Buffers added to a dirty folio are created dirty.
+ *
+ * The buffers are dirtied before the folio is dirtied.  There's a small
+ * race window in which writeback may see the folio cleanness but not the
+ * buffer dirtiness.  That's fine.  If this code were to set the folio
+ * dirty before the buffers, writeback could clear the folio dirty flag,
+ * see a bunch of clean buffers and we'd end up with dirty buffers/clean
+ * folio on the dirty folio list.
+ *
+ * We use i_private_lock to lock against try_to_free_buffers() while
+ * using the folio's buffer list.  This also prevents clean buffers
+ * being added to the folio after it was set dirty.
+ *
+ * Context: May only be called from process context.  Does not sleep.
+ * Caller must ensure that @folio cannot be truncated during this call,
+ * typically by holding the folio lock or having a page in the folio
+ * mapped and holding the page table lock.
+ *
+ * Return: True if the folio was dirtied; false if it was already dirtied.
  */
 bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-- 
2.43.0


