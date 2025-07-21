Return-Path: <linux-fsdevel+bounces-55620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF7FB0CC14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 22:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FE01659D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE11203710;
	Mon, 21 Jul 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cmg47XtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4092557A
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130786; cv=none; b=rwwp2Ladirrq65223A22kG7qBhvcKzbdpIK5sfgQSIqVpDmFJcChAURMqEB22dtKUKOol88ENgUEq2oIAjfwHiWFdwVzFzYEdvMHI2rJkdNkdrv5vhX74dPghCJMTmY0Xg270nucC2erBVo4Fg30uD2LTLnBY9YztdCPEhlfFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130786; c=relaxed/simple;
	bh=X7bD7c8s/ZUq7wg4TmHX4vbVe2+HxMuvM7qKJlQzOMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIk2ZxpswLoyK5Z1NiW1KhHoqnHDZzuPjd8RblfWfVmoi5wlVETLtr1PiUbB4OeTS6dR8rZAL6qqVfNyJYyTClUXIQpAcagQwPcAiflgItw6YF8fDKvvkvADvtP64xNiykgdinZ9cZNPjwzXR0JIBVy6r3rhw9l0QHouZvqipdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cmg47XtR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5gvso2s+VoajEmfGpzQ+NxfLY/p5U8zPq+da+4rZmQA=; b=cmg47XtRUn44ysP8cRNpRCT+Hm
	2OKvJM4NcbpXpVEVEtZM4IFTfO9Gsbtzpw+tJgYyNnsq8nRFAQ6OsA0XbUjsbjO8nNdEJcmQFSlUb
	ntw6kfZn6H9WDciHkXHaxF1NLJOzcoolsasg+IT0Sl+jMBzb95xXxq92t40v1ldNY5t76BTS7Zu4k
	qu3gliiq4Gpf6JJX24wSWEhvaDw46GvGHhurYgROJGSNpyHGsGwIbIlTZqaGYu7OXRymiFQELChjV
	fItgjjdtBT8fCHkKu/YMnhN3CgAFPQp0HIHyKfk1oqCeyjCreiIwL8TD0C5V/2TLtEwCS70hx5nbN
	DCm5Lzzw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udxOv-00000000gfU-1Zzw;
	Mon, 21 Jul 2025 20:46:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm: Remove grab_cache_page()
Date: Mon, 21 Jul 2025 21:46:18 +0100
Message-ID: <20250721204619.163883-1-willy@infradead.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers have been converted to use filemap_grab_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f..a5c5af8d70d1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -878,7 +878,8 @@ static inline struct page *find_or_create_page(struct address_space *mapping,
  * @mapping: target address_space
  * @index: the page index
  *
- * Same as grab_cache_page(), but do not wait if the page is unavailable.
+ * Returns locked page at given index in given cache, creating it if
+ * needed, but do not wait if the page is locked or to reclaim memory.
  * This is intended for speculative data generators, where the data can
  * be regenerated if the page couldn't be grabbed.  This routine should
  * be safe to call while holding the lock for another page.
@@ -942,15 +943,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 
-/*
- * Returns locked page at given index in given cache, creating it if needed.
- */
-static inline struct page *grab_cache_page(struct address_space *mapping,
-								pgoff_t index)
-{
-	return find_or_create_page(mapping, index, mapping_gfp_mask(mapping));
-}
-
 struct folio *read_cache_folio(struct address_space *, pgoff_t index,
 		filler_t *filler, struct file *file);
 struct folio *mapping_read_folio_gfp(struct address_space *, pgoff_t index,
-- 
2.47.2


