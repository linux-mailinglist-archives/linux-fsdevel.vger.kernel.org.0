Return-Path: <linux-fsdevel+bounces-7616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10375828831
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B639A1F256C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8935939FFC;
	Tue,  9 Jan 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u05ju9U7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8539FDB;
	Tue,  9 Jan 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LknggBhcXoqAVfUx/eiZL0v95VMCfMsJSCjCKH+cREY=; b=u05ju9U7gbnxlRQ/OUK1KvCOG8
	cDqdbb7UoJdf6bcU61e4xanTqpFuFa8eBLVyqpqWoVDw2Ee8ePbipaTYhrSdsaXf695bsT5yo3Kpi
	nl3wgGNjxQSew2H7PJJSzxJslqcd7576lK65+Vr8PQGZCGajBx1ygvvf9MJEJu/h4z5SlHNIx5mCj
	sEC2o2K3jiNz++3agFJkIaLm8VQ4Gy9l6FMbdxcr1sm6fBXYfAHAR6QVeR6AOsC81bMbNfEuJnDZA
	slpSg+GSuBBm8/sCHAK//PIXO6trM1DRcIHXaM7S1EVsrz1zv35hk91oyK1P3JAYdtfHBK/e77o3V
	e9omKaig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNDB0-009xrQ-RF; Tue, 09 Jan 2024 14:33:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] doc: Improve the description of __folio_mark_dirty
Date: Tue,  9 Jan 2024 14:33:50 +0000
Message-Id: <20240109143357.2375046-2-willy@infradead.org>
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

I've learned why it's safe to call __folio_mark_dirty() from
mark_buffer_dirty() without holding the folio lock, so update
the description to explain why.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cd4e4ae77c40..f09179fca2cf 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2652,11 +2652,15 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
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


