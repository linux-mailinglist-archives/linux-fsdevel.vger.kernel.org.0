Return-Path: <linux-fsdevel+bounces-6212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35198150B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA1B281F75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE155F86A;
	Fri, 15 Dec 2023 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NpTWOJG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28C563AE;
	Fri, 15 Dec 2023 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=v+w3jrrOuwEW6c9b12xy+g71WBvRB50BeRcbxotV8AU=; b=NpTWOJG3eqMAQI1Owoek8oh1L6
	jxonRna6pH2XUTTsHx+c91AdAMBru33Ua87kVGfze5tDyfb0tZ2xlIuIWTtyvix2ob7hhWSjHMJs5
	ICHFJo3qav0HVeNEKOmAmcNkdxD/HQBHEKO6LzIHI0P3BJGb9bHKI+XnsTKJpDNhYZChGlbpvFy5D
	LkTfyZjCeyGg2Ps5uJynYPRzfpIEptucW5gkHKTUZ74MUzCBtKYaG19+2TFqj2iqGpyWtU/sMFNX5
	xnvYp3hAl7brxshEuDZL5d8cjNsLtuZAPGZkUYhMJKgC7ZoKkhcxssOsvN50VRJ+RDR8Bnsd/Fc7e
	1H6KDUmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038jA-RE; Fri, 15 Dec 2023 20:02:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 09/14] minix: Remove writepage implementation
Date: Fri, 15 Dec 2023 20:02:40 +0000
Message-Id: <20231215200245.748418-10-willy@infradead.org>
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
 fs/minix/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f8af6c3ae336..73f37f298087 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
+#include <linux/mpage.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>
 
@@ -397,9 +398,10 @@ static int minix_get_block(struct inode *inode, sector_t block,
 		return V2_minix_get_block(inode, block, bh_result, create);
 }
 
-static int minix_writepage(struct page *page, struct writeback_control *wbc)
+static int minix_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	return block_write_full_page(page, minix_get_block, wbc);
+	return mpage_writepages(mapping, wbc, minix_get_block);
 }
 
 static int minix_read_folio(struct file *file, struct folio *folio)
@@ -444,9 +446,10 @@ static const struct address_space_operations minix_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio = minix_read_folio,
-	.writepage = minix_writepage,
+	.writepages = minix_writepages,
 	.write_begin = minix_write_begin,
 	.write_end = generic_write_end,
+	.migrate_folio = buffer_migrate_folio,
 	.bmap = minix_bmap,
 	.direct_IO = noop_direct_IO
 };
-- 
2.42.0


