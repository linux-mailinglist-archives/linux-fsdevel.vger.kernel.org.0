Return-Path: <linux-fsdevel+bounces-30716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799398DE31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F69A283425
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC991D0BAD;
	Wed,  2 Oct 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZ0BvvvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B151A08A4;
	Wed,  2 Oct 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881247; cv=none; b=cJ3q0gloi9i9ANBGzGdK/dQ3V5ZQt3VQymbkZiHdmLZpMgGqWpdH9dFbT+sBByw48B2rY1/zV8WP5bRF3+dwzxE7fkxUlhTsWeEyq7e5cVr2Bgm1+oQATg6xxs5KO+xRuVxuasNRzIEcSmIoajaO7/G3SxXpHlXtqfoXaRMAnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881247; c=relaxed/simple;
	bh=hViMZ2sOCvgX1ZFhQXfQUllNq8y39vqkYezX2a9Oj04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlG6L4L2wv1OGNua8yFAVBCEEAaERlAp5crGt6jNOqOHNakBwOi+Vo7/BHahQRQmK+7vSull7kd5wffhMXR91JRgEcMkJRCMnSgb0FaFNoV9SzaxI28SwCKcSLk2ioNpLpQo7ERkDbjRZEjVP7eCJd/pAwZsOXHcaaQdXCQAhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dZ0BvvvZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=G4PuZiCscMW/fPgL88BSGegvJtIPL6ozJhgLT9WDKbI=; b=dZ0BvvvZzFu/fWo6XdZOtkp/ue
	szguxemI+hkJJ8URxG5UJHQJEfFjHHtj7hVS7tBvSnrPIGNNZpqPZvWi3DWZH0Jq5zEGIv/NKyCXv
	REN1j8Q2dVcxkkFig32yjf5dQm/1qPKn5paGmeyM+RX5+ICl3QfmHqHBzhOfj8caMNxOMQApUB7Rs
	UHnlqyl/0CyRqxCAJo19NpQY1s23q7d7MouNepvmtKVShtdR35g5Ad3dSr0gtJWsUT6vyWEFHS2Ox
	VAJmNLaht6bLIjbcfdDQFeqQcfL5a4ef8DRbVbnSeSAO6mb6ZtGFpFIkvIc79BN1aPQ4TEaHHOFHy
	XxpDPPzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0qD-00000005cSi-1y6g;
	Wed, 02 Oct 2024 15:00:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org
Subject: [PATCH 1/4] nilfs2: Remove nilfs_writepage
Date: Wed,  2 Oct 2024 16:00:31 +0100
Message-ID: <20241002150036.1339475-2-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002150036.1339475-1-willy@infradead.org>
References: <20241002150036.1339475-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since nilfs2 has a ->writepages operation already, ->writepage is only
called by the migration code.  If we add a ->migrate_folio operation,
it won't even be used for that and so it can be deleted.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/inode.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index be6acf6e2bfc..f1b47b655672 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -170,37 +170,6 @@ static int nilfs_writepages(struct address_space *mapping,
 	return err;
 }
 
-static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-	struct inode *inode = folio->mapping->host;
-	int err;
-
-	if (sb_rdonly(inode->i_sb)) {
-		/*
-		 * It means that filesystem was remounted in read-only
-		 * mode because of error or metadata corruption. But we
-		 * have dirty pages that try to be flushed in background.
-		 * So, here we simply discard this dirty page.
-		 */
-		nilfs_clear_folio_dirty(folio);
-		folio_unlock(folio);
-		return -EROFS;
-	}
-
-	folio_redirty_for_writepage(wbc, folio);
-	folio_unlock(folio);
-
-	if (wbc->sync_mode == WB_SYNC_ALL) {
-		err = nilfs_construct_segment(inode->i_sb);
-		if (unlikely(err))
-			return err;
-	} else if (wbc->for_reclaim)
-		nilfs_flush_segment(inode->i_sb, inode->i_ino);
-
-	return 0;
-}
-
 static bool nilfs_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
@@ -295,7 +264,6 @@ nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 }
 
 const struct address_space_operations nilfs_aops = {
-	.writepage		= nilfs_writepage,
 	.read_folio		= nilfs_read_folio,
 	.writepages		= nilfs_writepages,
 	.dirty_folio		= nilfs_dirty_folio,
@@ -304,6 +272,7 @@ const struct address_space_operations nilfs_aops = {
 	.write_end		= nilfs_write_end,
 	.invalidate_folio	= block_invalidate_folio,
 	.direct_IO		= nilfs_direct_IO,
+	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 };
 
-- 
2.43.0


