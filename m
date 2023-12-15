Return-Path: <linux-fsdevel+bounces-6213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D78150B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6601F27732
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67835F87A;
	Fri, 15 Dec 2023 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZhE/bzSE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8356770;
	Fri, 15 Dec 2023 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/yLVY3qvXTW91YFKY50YK8NtYUoq7IQ3U6zezP7o3zI=; b=ZhE/bzSErGAKIq0i4CqeDdqDHQ
	KHmSkiLt3RL8zX4UJvxKXRLUyQkcSqxbaWnwW7Pir5OAMr9lY7X42cCSJbUdMaIhy/8tiECDoowfP
	jPku2JHA+XmaR8ISU758lnfDj5NCds1wwmjb78TqcGFsucJmlBoQaAt4KzveAP/MqrGBV2gv4Z3QL
	gJsezO8xGGnNXQscv4wG+S8pPN6NEbzALZaEfvsU50ZnpsKClX2SM/suJ2Ytpu7/maynpftI+Nadh
	bcDwVIZMwbq0JAbXowUVwbBWmDkVMElOdoe5QV/ZH4xV6Bdzhw+Us6y09sU6x0dNct69n+qVu99Gl
	xRjaacYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOW-0038jc-AU; Fri, 15 Dec 2023 20:02:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 12/14] ufs: Remove writepage implementation
Date: Fri, 15 Dec 2023 20:02:43 +0000
Message-Id: <20231215200245.748418-13-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the filesystem implements migrate_folio and writepages, there is
no need for a writepage implementation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index ebce93b08281..a7bb2e63cdde 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -35,6 +35,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/buffer_head.h>
+#include <linux/mpage.h>
 #include <linux/writeback.h>
 #include <linux/iversion.h>
 
@@ -390,7 +391,7 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 
 /**
  * ufs_getfrag_block() - `get_block_t' function, interface between UFS and
- * read_folio, writepage and so on
+ * read_folio, writepages and so on
  */
 
 static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
@@ -467,9 +468,10 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 	return 0;
 }
 
-static int ufs_writepage(struct page *page, struct writeback_control *wbc)
+static int ufs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	return block_write_full_page(page,ufs_getfrag_block,wbc);
+	return mpage_writepages(mapping, wbc, ufs_getfrag_block);
 }
 
 static int ufs_read_folio(struct file *file, struct folio *folio)
@@ -528,9 +530,10 @@ const struct address_space_operations ufs_aops = {
 	.dirty_folio = block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = ufs_read_folio,
-	.writepage = ufs_writepage,
+	.writepages = ufs_writepages,
 	.write_begin = ufs_write_begin,
 	.write_end = ufs_write_end,
+	.migrate_folio = buffer_migrate_folio,
 	.bmap = ufs_bmap
 };
 
-- 
2.42.0


