Return-Path: <linux-fsdevel+bounces-17018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB448A617B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFAFAB21C94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356A374EB;
	Tue, 16 Apr 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WWGZ5zPx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41EE17550;
	Tue, 16 Apr 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237485; cv=none; b=oq2E/CgmTP0syFydbS92Qqk7aePBYtichgbYUTHdW2mOyasaSNQ4/ZErSeb1X9lpFe4U5aNf7apvRt5OlIBzpCN6JO44LomOgOwUOBdDBxZQ5AXuFbAf1cMP3DMQMSNfboELfXjO9QmDqkOby1L7UAOWcQEvvu3OvmBVWEkUbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237485; c=relaxed/simple;
	bh=nqkpEUdbg/EMVD3A1w81m+jCUYlbzdILtMgTK3K6UhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEYLBFq5xv7GtUSg0nlDe4favWoCTKJN71pbDG7KfWv7btCCc43K1iqIbWq/aQkDafq5YNI/4a5ki0P/kI3hc2qZLfmCpAnoXUy1OTP0Ry9DGwICIjdh3xDroAnhKgYgTO4pFk4pI1o+q/5T8vS8mUUaTorXQ5jccRaJDzdeHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WWGZ5zPx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GOZyBLWge7qyAz30yvc9tiHbIMnsiWg9t4KEJ/+nXC4=; b=WWGZ5zPxAnL0RNs2k93S9gQ2qz
	FQxUJIOGwQcnZ2tutDutooQ3fBX2ZBHTauGFCLmjtnXT/N/nckX//d5N4D+rpKiOwvcfQvXpRZkpi
	izppwNkjbmUCycM5sZHa6p5qF/NWYKcFjuaBXJEnSucfZtkJCnfMdC27uNMcsxt9RqbxjZcXDFr96
	+f9lR87GqkKJ/PyH8MG4aAF9UvUBILcLC1OHACV0vPt0v8LA7nN6a5hhE3ydSKcb1OeserZ/BVnXt
	xGCwQcK7zjVVxXsSNTijpWPlGjzvNYf51N04GVKfso4jsnxRg0uz9NlSlf6DdAFwaZlsFHrxqn4lH
	Aj00ipVA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKV-0000000H6aw-4AGj;
	Tue, 16 Apr 2024 03:17:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 2/8] buffer: Add kernel-doc for block_dirty_folio()
Date: Tue, 16 Apr 2024 04:17:46 +0100
Message-ID: <20240416031754.4076917-3-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416031754.4076917-1-willy@infradead.org>
References: <20240416031754.4076917-1-willy@infradead.org>
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
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c | 55 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4f73d23c2c46..b08526bdcb54 100644
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


