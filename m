Return-Path: <linux-fsdevel+bounces-65550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4004EC077DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C08E1C484A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570083451D0;
	Fri, 24 Oct 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5nIVsHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDC343204
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325712; cv=none; b=QiJaj0mjxWXed3Yvg9B2tjXMTXTwpd2arzpKpKy8xTsX9BC/MNmpd628KGzHCyq2m5hBKzv9jjJSYYBXQ3X8j9hhtuNKb6bVMiuYwySCFRbqyuALQTUspIC15bIMVP4pbq1AFx2zGw5XCgFfYJ7VTUQNi1gucpZMCn/ji1GsX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325712; c=relaxed/simple;
	bh=gEGlHSwsX9Zo4tZ5GxaEaAu47VCJj6yIrOZ4KwsZG1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ7aMrbJikt6+LzVtgRfkke89tftAPTcdUidsDoiB95bYTNFZgJmrtTphr/FSmrt4Dt4XET7ICtK5hl55GZ0G3VISBpB0BmGlyHR6tZzn4HGC3DHszsEWA6wclnTirAOMVdhEl6GyygKy3HUr+QIybQkAFwqgnhigrons9utSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J5nIVsHm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5ZW5olhctt8pQPRZxoAAJytfYIV9yoFEgRh2hZHi7Ks=; b=J5nIVsHm9KMzkVsz+UUroU00Fy
	B0yX4QuYTnVGZWEppX1RPvG05Ya1Bnz51s1AJe65eYrxxzRwoCOA4RVt5gmygFvqRUDZFocbE3UQs
	1HVy2IFtL80K6uonYWg1UpSb3rAC2wl6znxX6WucN+F6j43yVzrWRifH7yfcQIhGt5dTTxqUsagLp
	H+n/MYBlKaa+IX6FesApAibC2STndf1Xj3+n7P9XsebBEDOLNFY0QvJiyjezRRCttPrk8YkCDHoYa
	+Ppr0gm4egEcU8CT6D/qzgEWn3ZX+sbq0EEB+zCVXSg8VbPfZIFvepHZcej+Q3hMIN6WWPHB7qfMd
	dA/t7aPA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH7-00000005zMA-2jPO;
	Fri, 24 Oct 2025 17:08:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH 10/10] mm: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:18 +0100
Message-ID: <20251024170822.1427218-11-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024170822.1427218-1-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is one instruction more efficient than open-coding folio_pos() +
folio_size().  It's the equivalent of (x + y) << z rather than
x << z + y << z.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/shmem.c    | 2 +-
 mm/truncate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b9081b817d28..c819cecf1ed9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1133,7 +1133,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
 	folio = shmem_get_partial_folio(inode, lstart >> PAGE_SHIFT);
 	if (folio) {
-		same_folio = lend < folio_pos(folio) + folio_size(folio);
+		same_folio = lend < folio_next_pos(folio);
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start = folio_next_index(folio);
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..a3d673533e32 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -387,7 +387,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
 	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
 	if (!IS_ERR(folio)) {
-		same_folio = lend < folio_pos(folio) + folio_size(folio);
+		same_folio = lend < folio_next_pos(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start = folio_next_index(folio);
 			if (same_folio)
-- 
2.47.2


