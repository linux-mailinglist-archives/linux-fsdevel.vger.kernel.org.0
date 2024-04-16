Return-Path: <linux-fsdevel+bounces-17015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA208A6175
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D0C281231
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57712C1A0;
	Tue, 16 Apr 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AaZld52W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40931C6A8;
	Tue, 16 Apr 2024 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237482; cv=none; b=nvEhLBLbBVm6qGD0/DMRthO4DptJmFVNmDzZxukS4CVMKh49IWLgo72xgMCK+wa/LI4NRnsG1HWBAfDNNMuRigI/IbX3ZG886LbwCm10vgPNDqF7kwWlmTVHLaCyv9FoJW25WnbJDvk8tyTCbAhiomm3NkgUG9Nn3TyLzR0DZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237482; c=relaxed/simple;
	bh=PETw0eDtqxHmcHBtZCsfJPMLTBLDTPyLoOaXeSy7CdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKrmOriUClgTGdUs/tNpvChHIS1abKsmJV2Kbc1bZZkoFpxTdBQCS1TRyR+jgNsu3iyKOr210m7K0G01eFJI2srumPt7Cx7tcOYb1efIPUGZFnO3YCYNiiKyRK8owJIhpn7WLBYtsejuWVhf6VZaOV2zU7w9Vezh4Dw9ylz0kPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AaZld52W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=frJu9FO9nwWcCqa63oYNqDsCSg+xZY7bhlunSAGmIxk=; b=AaZld52WYWilUb4dfckZ0N3fZx
	W+7cQ5V6++2YRA+//80KybGlwsBYXfYYhyjUdjC9qWP3iiWn6lBHAlcgwlxpvy/FY2mLGPElaJbih
	babVqBvhQiZQ93I1K1H9d4yr53b8RrcbzaY4Hei2s5pq496hbe85W5vBqaFX6mXlD2GpD0USO+Vic
	kmshZuRNhM78CBlyejCyoSd0oHIRoEjNJSx3XvibSAAIFeYutSeRUIx6KoMYQvc0NnUn7iT5IEFT9
	PXvCjKacaYzH0bNo2I9ZJohYCf4ga/3fLGDW7E7pHIbUPjWRjsPz04kOTlYkrD2jbdZ1Nw17o+wGi
	6VOIavcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKV-0000000H6au-3oL8;
	Tue, 16 Apr 2024 03:17:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 1/8] doc: Improve the description of __folio_mark_dirty
Date: Tue, 16 Apr 2024 04:17:45 +0100
Message-ID: <20240416031754.4076917-2-willy@infradead.org>
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

I've learned why it's safe to call __folio_mark_dirty() from
mark_buffer_dirty() without holding the folio lock, so update
the description to explain why.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 62f28fe26511..bd91d5761e39 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2706,11 +2706,15 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
  * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
  *
- * The caller must hold folio_memcg_lock().  Most callers have the folio
- * locked.  A few have the folio blocked from truncation through other
- * means (eg zap_vma_pages() has it mapped and is holding the page table
- * lock).  This can also be called from mark_buffer_dirty(), which I
- * cannot prove is always protected against truncate.
+ * The caller must hold folio_memcg_lock().  It is the caller's
+ * responsibility to prevent the folio from being truncated while
+ * this function is in progress, although it may have been truncated
+ * before this function is called.  Most callers have the folio locked.
+ * A few have the folio blocked from truncation through other means (e.g.
+ * zap_vma_pages() has it mapped and is holding the page table lock).
+ * When called from mark_buffer_dirty(), the filesystem should hold a
+ * reference to the buffer_head that is being marked dirty, which causes
+ * try_to_free_buffers() to fail.
  */
 void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 			     int warn)
-- 
2.43.0


