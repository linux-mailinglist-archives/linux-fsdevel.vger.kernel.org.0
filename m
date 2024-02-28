Return-Path: <linux-fsdevel+bounces-13122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA20486B72D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5CC1F269FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4936C4086B;
	Wed, 28 Feb 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KgrFEIPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F240860
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144984; cv=none; b=kFiZbjQsglngnu0LXslXdVfjfmWxWcERiQ+DxI4rYIQ3dleElXXwsby+iiWnxG8CRJE53rlsc6wOiAjKXlk8K54fxzN5x8HYRz/9BPZGADg292Zxdt0J/Ov7+EyUSWCoc25ZfaPhZNDcq9SfHqmVYqwJMsqRMD6vUUsbTSX6odU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144984; c=relaxed/simple;
	bh=DjjX1Ew3xaVRcwlaEI5SUM0zmmbeyQsFZgQzJTx6dBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooGDnNJbvxcqVPPAMEAAuv6xtecroOHhi+sywgvPRnhyP3b3RQH8ZB492ucTGLsZ7tVeDbpQVbyGUhMvZOtAPMZzGH0u9omzb47Xk6Z1haZeh1uVHCQ7xPemAOanmXy0vTGb31+u2lGsddZzNf+vxe/aFlR4MBtLOwPsmpSS/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KgrFEIPm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=R8L+5aqT5rL4TW/wQHrzmUBUS9DiILmVUL3JhzEnKwQ=; b=KgrFEIPmBMzS3/iLfHE0xNz+KP
	6n/t9mQg8aYVNZaXupzK/Qrllzx5ukDipulG4fS+tP9+sYGkiGa/iw+Tf194j6vzY/uFMhM1bOnUU
	zg4ar+j4h+MXxqAtaKDnVvC+p77Eoh2YXcgHENK/Sa0aqvwpzw5vM1EEa1jInEMuCrfl3uQsJ9mid
	Ewe3fSghNl4ILrkPOyb87yDY2UV7j3s8ZD/p1tb7mELGjipEc5ahBQF1CQjFHTw2AKyb2GvpMSScQ
	h1Fa4qyyTktEiH31aElmOwRwc4i3jqYDY8oKqEOuCwDEYCkwKxFUmtFn+TtrwhbGeDo1VwvMWGCKc
	ZihTy3NA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOgX-00000005tPu-1JNx;
	Wed, 28 Feb 2024 18:29:41 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fuse: Remove fuse_writepage
Date: Wed, 28 Feb 2024 18:29:37 +0000
Message-ID: <20240228182940.1404651-1-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The writepage operation is deprecated as it leads to worse performance
under high memory pressure due to folios being written out in LRU order
rather than sequentially within a file.  Use filemap_migrate_folio() to
support dirty folio migration instead of writepage.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7f5d857c5692..340ccaafb3f7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2104,34 +2104,6 @@ static int fuse_writepage_locked(struct page *page)
 	return error;
 }
 
-static int fuse_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct fuse_conn *fc = get_fuse_conn(page->mapping->host);
-	int err;
-
-	if (fuse_page_is_writeback(page->mapping->host, page->index)) {
-		/*
-		 * ->writepages() should be called for sync() and friends.  We
-		 * should only get here on direct reclaim and then we are
-		 * allowed to skip a page which is already in flight
-		 */
-		WARN_ON(wbc->sync_mode == WB_SYNC_ALL);
-
-		redirty_page_for_writepage(wbc, page);
-		unlock_page(page);
-		return 0;
-	}
-
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    fc->num_background >= fc->congestion_threshold)
-		return AOP_WRITEPAGE_ACTIVATE;
-
-	err = fuse_writepage_locked(page);
-	unlock_page(page);
-
-	return err;
-}
-
 struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
@@ -3347,10 +3319,10 @@ static const struct file_operations fuse_file_operations = {
 static const struct address_space_operations fuse_file_aops  = {
 	.read_folio	= fuse_read_folio,
 	.readahead	= fuse_readahead,
-	.writepage	= fuse_writepage,
 	.writepages	= fuse_writepages,
 	.launder_folio	= fuse_launder_folio,
 	.dirty_folio	= filemap_dirty_folio,
+	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
 	.write_begin	= fuse_write_begin,
-- 
2.43.0


