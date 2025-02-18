Return-Path: <linux-fsdevel+bounces-41957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5CBA39342
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655E03B3501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371511CEAD3;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AlVHj72n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE91B393A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857932; cv=none; b=awKs1P2a1YjDi4t7jLbM2n4377MBdf6lXTyx6oeoAGwURxTaw1dSlp9C8a+2YMafcrrKCsiXqyX4Qxg7CgRkDAGtJ9KslzhsS88qOF4pWddj70b57C+uL0EEJvhddiIAU3ItFy+2cY41U/h4vkTZ55jRAnl0UaTBw3dL6B9dIhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857932; c=relaxed/simple;
	bh=pyGxmgAu9YWBXeGhrLatbXS9UlIchAoWqDDfaL2y/8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+SDHKhHn3k9wdI3ZGwQrYpZYgz2k/holYwcB35Nuga7IMKfbkyrVDCz+LJ3giHSvxDysVxpfeKvWDp24ZNFnfX6siC9AJtpL5MgofEhqthwc97N/rBoRCZL5DtqVqkGcm4bZI6uLvWKQaY0WJ4VT1j+7MZWWY98rhOZiYWHM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AlVHj72n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pHzKHgnEZ5wurt4F+CEwoehnkRhO3SEQQCdj/YohkHg=; b=AlVHj72nKrmlohCoQ8noasm5ku
	eFq23dqQHM9xL+nHpLK4vFOkRxjGMopomGKg7ryyTanrrQgjvXv9LJg40WqELhJgKmei03KALucy6
	XQCuJJlk3c6p1BaUBv0g0wIEZD8Pnnta26YMtAqDh+MA3j1hYpKbdFxXfKSLAk+eAPdBuVwUr2WLb
	PbLRIl2d2ByWqCWAu/O4Ecb/n1gXJ8xXYlVW+d3/H80cg29SfAcjBr4kSpkR6EpWVNXR13Bst8eFK
	O0u/HIslyo3vOspFcDrtD5tUat2rcbrxqKnTekILxosKV+74p5xD3KdxZCfzCuAA/zK46KsrroskB
	7Bv/jiFw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWf-00000002Tu1-17tH;
	Tue, 18 Feb 2025 05:52:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 27/27] mm: Remove wait_on_page_locked()
Date: Tue, 18 Feb 2025 05:52:01 +0000
Message-ID: <20250218055203.591403-28-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This compatibility wrapper has no callers left, so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 5 -----
 mm/filemap.c            | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 45817e2106ee..b8c6fa320ee3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1242,11 +1242,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 	return folio_wait_bit_killable(folio, PG_locked);
 }
 
-static inline void wait_on_page_locked(struct page *page)
-{
-	folio_wait_locked(page_folio(page));
-}
-
 void folio_end_read(struct folio *folio, bool success);
 void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index c8fd285c4287..70d0b579cdad 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1380,7 +1380,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * @ptl: already locked ptl. This function will drop the lock.
  *
  * Wait for a migration entry referencing the given page to be removed. This is
- * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
+ * equivalent to folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE) except
  * this can be called without taking a reference on the page. Instead this
  * should be called while holding the ptl for the migration entry referencing
  * the page.
-- 
2.47.2


