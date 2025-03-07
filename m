Return-Path: <linux-fsdevel+bounces-43428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B02A5698F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918D53AC18D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163721C176;
	Fri,  7 Mar 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P+fhR0DJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9A21ABDF
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355659; cv=none; b=ctSIvZurg3dsM5h10EHqMcabCBhh7CTb7B2gOtg6jbY6rc70AwjMLtFEHSkOuPL/F9Lj1tl3hpic10ozigjykpydLrplwv/p0zBoKFqdxnDtcG0KFuENnnKw9QZp1t2IJUDkMQK590iY1RuvkOLYxOllc7zflUyT70DnRKQgjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355659; c=relaxed/simple;
	bh=xqaO8oqNncJyRRJ4jaLixe2YEvyiUrNlle1x9vdAEW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5qPL3GBV5cK0sUCfG3tkCh5TSCKQUWglco6yS0KgAkbaxFd0J5DZSmjPyiDRWT1PCffHU8J2fWQp1sDLXscx3aynaxo5Tj/R8C5pX65XX9FsKX/D4fcfxQV5h7EZWXszWTVu3kLageL/CmloeDWZ/+N+U/zGDOWApx5mqdwKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P+fhR0DJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BT6OjbtDCOFHHAijJpjMRbh4BDIQM0uytaFHqbNbas4=; b=P+fhR0DJRyfUD/uNdzZFl7spFN
	s9WEWvyhYKjqMt2ZkZIw8P2H8WA9PRUelUHbNbUHUAD74hf7doJwzbkO5RVpwh1XkHE/3eWl4EgAR
	LByuBb7d7QakRILNQYu2zosdstSG2OVQKc8zyUTjASsG/6/FG2aKG5MZ1QnmEiNzxNlLdogOTcFpU
	rgdT+FGNEqYgWAyLW+dRtDMkhZXF+9s+H8tMynfWyjchQ7zGjOtAB+i5XJHklJ9mPx1w8iYJ0xBRJ
	KXvnFMlFbIF1YTpxibbA24zR/zRAq8aVvFNXIby2MHWPnxKh1O0U9YKiSqA0bIUCw55fMQWF4gEki
	y7yrID1w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9Y-0000000CXG8-0H5t;
	Fri, 07 Mar 2025 13:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 04/11] f2fs: Remove f2fs_write_node_page()
Date: Fri,  7 Mar 2025 13:54:04 +0000
Message-ID: <20250307135414.2987755-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mappings which implement writepages should not implement writepage
as it can only harm writeback patterns.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 36614a1c2590..b78c1f95bc04 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1784,13 +1784,6 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 	return err;
 }
 
-static int f2fs_write_node_page(struct page *page,
-				struct writeback_control *wbc)
-{
-	return __write_node_page(page, false, NULL, wbc, false,
-						FS_NODE_IO, NULL);
-}
-
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic,
 			unsigned int *seq_id)
@@ -2217,7 +2210,6 @@ static bool f2fs_dirty_node_folio(struct address_space *mapping,
  * Structure of the f2fs node operations
  */
 const struct address_space_operations f2fs_node_aops = {
-	.writepage	= f2fs_write_node_page,
 	.writepages	= f2fs_write_node_pages,
 	.dirty_folio	= f2fs_dirty_node_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-- 
2.47.2


