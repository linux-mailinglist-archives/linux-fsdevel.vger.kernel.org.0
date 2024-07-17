Return-Path: <linux-fsdevel+bounces-23855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B4933FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471781F259D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96B183078;
	Wed, 17 Jul 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gEC/YNT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864918130F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231245; cv=none; b=PC4L5GCsHxXGY4ALn5poWkJPmYNR5fbg0RhlVBgC1Y5rP3+6+RbmsEWON/NVYRZWCV0CZwlZNnUOUAvTQc6WzrdDKBfg40BwelKcnL5plKDk73E8mVJwoyDg3B6tL1vnVk35nZSuf/EPhgDcx1XsrQM/cjBC53rqzxcJowal5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231245; c=relaxed/simple;
	bh=61GmWkPNRObgCEJRGCUptigNT1ArqsY+iiTTaov8waM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnrgbwrsrHf7u3htF8S9xkV69W3xEf2j1Fg4ITH/+r2O9DIVxED3UXrBZAimG02n0Tokv20VoW1uy6xXOU2uwRG73fR8RE932sgrKDtnOi+9IdDqQqU+XoD03VKkllWZWHZhVWRVf0xarnPmlxIL2em/J7PliK/4tNpeayTcQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gEC/YNT6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=os2R35SM0Bbh6DKtdqifgsKjeLQQ8Ojotg5tPeyWj8o=; b=gEC/YNT6EzWX/3FTozV/jIsVJI
	3OEcI3bePGjfPgfx7JtseEaA2XvV5HibkjV4+JdQnDiNgclUnMeq+fO0Eu6K+Q3BH5MK7+5pMKwVB
	6rUt4yb7pY0y2VAnKtRd9fC0Jge3vbqnRBF4l5VoGxmwwCWpILXEcnq9tg7VSBV1fX9i8rQvRDMxn
	QPEzIla4pqKDzcejxk3GVxvPbxH2NGCXGesjP+rtNqBvN/1V/ZH57DNA132JPc5znVVI7+h5zAY95
	eNYZYHbVVk1lnZbuY8E1F2vUPf7ZXC+JcB02SU0PZ1Zv9tby6g/bhr+bQ8lZkxbjXuCXgKghxiPa2
	Ht+NAfgA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sD-00000000zui-10WW;
	Wed, 17 Jul 2024 15:47:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/23] f2fs: Convert f2fs_write_end() to use a folio
Date: Wed, 17 Jul 2024 16:47:00 +0100
Message-ID: <20240717154716.237943-11-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the passed page to a folio and operate on that.
Replaces five calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6457e5bca9c9..58ac23e124a5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3687,7 +3687,8 @@ static int f2fs_write_end(struct file *file,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 
 	trace_f2fs_write_end(inode, pos, len, copied);
 
@@ -3696,17 +3697,17 @@ static int f2fs_write_end(struct file *file,
 	 * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
 	 * let generic_perform_write() try to copy data again through copied=0.
 	 */
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		if (unlikely(copied != len))
 			copied = 0;
 		else
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* overwrite compressed file */
 	if (f2fs_compressed_file(inode) && fsdata) {
-		f2fs_compress_write_end(inode, fsdata, page->index, copied);
+		f2fs_compress_write_end(inode, fsdata, folio->index, copied);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 		if (pos + copied > i_size_read(inode) &&
@@ -3719,7 +3720,7 @@ static int f2fs_write_end(struct file *file,
 	if (!copied)
 		goto unlock_out;
 
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 	if (pos + copied > i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
@@ -3729,7 +3730,8 @@ static int f2fs_write_end(struct file *file,
 					pos + copied);
 	}
 unlock_out:
-	f2fs_put_page(page, 1);
+	folio_unlock(folio);
+	folio_put(folio);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return copied;
 }
-- 
2.43.0


