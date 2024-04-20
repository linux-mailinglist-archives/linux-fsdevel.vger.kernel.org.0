Return-Path: <linux-fsdevel+bounces-17347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD86A8AB8FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D01C20D35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D10199A2;
	Sat, 20 Apr 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XE0Xk+F0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83217BCC
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581463; cv=none; b=gBHMeCCWAQYiqSuAav+A5PJbkrLBIDygX5pJX/TaDvEukpX5WKelRygML5Xthxz5Bra0iKzmZV+jLHKUsLCGeGPZJvPzVUdFn1uXISS7z3T071bCbuVVe2K7hBdbE2L+7e580Yzrn+rwMgpmd4bMAb+az7bXweUY3gW0AuSbAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581463; c=relaxed/simple;
	bh=HXK9SrkeoGYeQqaRCbDyaBLW2cECSXCKLkdh+hbfB5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elOVkwCEVtfTK9cFAyhKt+4kXm0wKnWUwU5opskNuT1DIBrWY9qGkTOrEFuDioj9qvfHBUx1jzZtn0NUU/VaqbyZceaBVtNrDvB7SwtSn6SdIFb/buJB4bD+LXZbhnNTji5lWqQTImQvKXbnWo16Ah6Axd0G4cRrWxTIs4kNA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XE0Xk+F0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=c7vikNugCgi0jVhZmW+/vu+Luq6OpZDlsK0DHYxWiTc=; b=XE0Xk+F0opaZ/PjSoMRB6WvE/j
	S9w1f2jW0z8uDw1B5SGVpBnWEIenAk+CwgJ73rhRyFPl+GThSQ6RukjWp+44Cf+WBqomV626Y6MmU
	8AP1jb1Z8AybHgM6TlvWYaZzPMswYUumE0osoANrqEvivIJRO45bNX8BULu1oGmIz4Dhk0ufGccia
	wVcqEqtqjYh8vvaXddiI+lDMj/hR1Pry3waENhLLXFkCQaeINaR7GdZPBN7r2ADqJPTQUF2BfvfYX
	LwatmLmyLewvKTeF2pjY4gCt7+WB0O1f2fY24aqb9Pf1sUX5h/B2orJRF+wGIwDw9ESJ+yvFnju+9
	ue8YMSiw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oa-000000095g1-24C9;
	Sat, 20 Apr 2024 02:50:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/30] romfs: Convert romfs_read_folio() to use a folio
Date: Sat, 20 Apr 2024 03:50:15 +0100
Message-ID: <20240420025029.2166544-21-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the conversion back to struct page and use the folio APIs instead
of the page APIs.  It's probably more trouble than it's worth to support
large folios in romfs, so there are still PAGE_SIZE assumptions in
this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/romfs/super.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 2cbb92462074..68758b6fed94 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -101,19 +101,15 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos);
  */
 static int romfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	loff_t offset, size;
 	unsigned long fillsize, pos;
 	void *buf;
 	int ret;
 
-	buf = kmap(page);
-	if (!buf)
-		return -ENOMEM;
+	buf = kmap_local_folio(folio, 0);
 
-	/* 32 bit warning -- but not for us :) */
-	offset = page_offset(page);
+	offset = folio_pos(folio);
 	size = i_size_read(inode);
 	fillsize = 0;
 	ret = 0;
@@ -125,20 +121,14 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
 
 		ret = romfs_dev_read(inode->i_sb, pos, buf, fillsize);
 		if (ret < 0) {
-			SetPageError(page);
 			fillsize = 0;
 			ret = -EIO;
 		}
 	}
 
-	if (fillsize < PAGE_SIZE)
-		memset(buf + fillsize, 0, PAGE_SIZE - fillsize);
-	if (ret == 0)
-		SetPageUptodate(page);
-
-	flush_dcache_page(page);
-	kunmap(page);
-	unlock_page(page);
+	buf = folio_zero_tail(folio, fillsize, buf);
+	kunmap_local(buf);
+	folio_end_read(folio, ret == 0);
 	return ret;
 }
 
-- 
2.43.0


