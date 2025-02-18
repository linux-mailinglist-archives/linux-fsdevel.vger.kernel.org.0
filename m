Return-Path: <linux-fsdevel+bounces-41956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E3A39341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A793B2835
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC511B4250;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZPYOAog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B81B6D11
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857932; cv=none; b=m7oMQ0hAugPhJVapb4a3U8RI3SP574V8LxS4DqXhPiDpmlICsL0YDszA/M0PFSJ6qy6xSkdr75qLNhhe/TLmTvtmLSz0FRV0ERlFO4CS8924vsCG+kBZnq8JownL5R+E8KFjjnYSUA3tvOzm01wEGsgVyr27PgaEyW/3aiJ3l08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857932; c=relaxed/simple;
	bh=0htEkNEMxfz5Aeg3Ldp7qNqFwmAEYPYk/Ui3/6zYHRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtDg4COidmCEgPBBuusYuYb3nOE/cqq2JEtQ+EGFDozGjcAS/SK2HUoBx9S6/TzALuE/WXG8oyOIOJifHOxIERpFCIpN0VwaBwfPHggtHqHGHkjmxblJqtzMkMG/5/QZY3rxJROSrOlU0zkD145bDhd+cyTfeyfk4var87/k43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kZPYOAog; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TUMziK/MN+dJA5u/Tm7OSGZei6DtomV0hyNLe55qLvc=; b=kZPYOAogxaHpYsVmBqKtxQxMwk
	JCrVeQ4rs64fC0AJmONgXcVDjUYkjXp6b6B13MdUac0xNc5pMFcfDgBaTFwT7h1Wn7LV119mB8Lf8
	LgzyEellQxuR5ZnhzRY/bypo1654dPPWsrJ6859Deu7JhQGM1rh/ouDJ/2rU22Z0t/e94lyDu5S8Q
	+KH5Uwof0vdA4aXE2wlWW6EhXJybyFg7KRJe4OQTvMG+S1XTvx9NWeLszmDHmmssIDu04/m2LT3kP
	9xSGqZ00uvuovIJgIidh2ZCtDXxNiAEn6UVqWCj0mFWaUWFVcpzTnRuF2mDr6GDXTizFxAoxTqLIF
	w5Qih4rQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWe-00000002TtX-3ER8;
	Tue, 18 Feb 2025 05:52:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/27] f2fs: Convert move_data_page() to use a folio
Date: Tue, 18 Feb 2025 05:51:57 +0000
Message-ID: <20250218055203.591403-24-willy@infradead.org>
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

Fetch a folio from the page cache and use it throughout, saving
eight hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/gc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index faf9fa1c804d..d0fffa2bd9f0 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1449,14 +1449,14 @@ static int move_data_block(struct inode *inode, block_t bidx,
 }
 
 static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
-							unsigned int segno, int off)
+						unsigned int segno, int off)
 {
-	struct page *page;
+	struct folio *folio;
 	int err = 0;
 
-	page = f2fs_get_lock_data_page(inode, bidx, true);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	folio = f2fs_get_lock_data_folio(inode, bidx, true);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
 		err = -ENOENT;
@@ -1468,12 +1468,12 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		goto out;
 
 	if (gc_type == BG_GC) {
-		if (folio_test_writeback(page_folio(page))) {
+		if (folio_test_writeback(folio)) {
 			err = -EAGAIN;
 			goto out;
 		}
-		set_page_dirty(page);
-		set_page_private_gcing(page);
+		folio_mark_dirty(folio);
+		set_page_private_gcing(&folio->page);
 	} else {
 		struct f2fs_io_info fio = {
 			.sbi = F2FS_I_SB(inode),
@@ -1483,37 +1483,37 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.op = REQ_OP_WRITE,
 			.op_flags = REQ_SYNC,
 			.old_blkaddr = NULL_ADDR,
-			.page = page,
+			.page = &folio->page,
 			.encrypted_page = NULL,
 			.need_lock = LOCK_REQ,
 			.io_type = FS_GC_DATA_IO,
 		};
-		bool is_dirty = PageDirty(page);
+		bool is_dirty = folio_test_dirty(folio);
 
 retry:
-		f2fs_wait_on_page_writeback(page, DATA, true, true);
+		f2fs_folio_wait_writeback(folio, DATA, true, true);
 
-		set_page_dirty(page);
-		if (clear_page_dirty_for_io(page)) {
+		folio_mark_dirty(folio);
+		if (folio_clear_dirty_for_io(folio)) {
 			inode_dec_dirty_pages(inode);
 			f2fs_remove_dirty_inode(inode);
 		}
 
-		set_page_private_gcing(page);
+		set_page_private_gcing(&folio->page);
 
 		err = f2fs_do_write_data_page(&fio);
 		if (err) {
-			clear_page_private_gcing(page);
+			clear_page_private_gcing(&folio->page);
 			if (err == -ENOMEM) {
 				memalloc_retry_wait(GFP_NOFS);
 				goto retry;
 			}
 			if (is_dirty)
-				set_page_dirty(page);
+				folio_mark_dirty(folio);
 		}
 	}
 out:
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 	return err;
 }
 
-- 
2.47.2


