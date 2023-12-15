Return-Path: <linux-fsdevel+bounces-6226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059081515F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7AB1F23A53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6104946558;
	Fri, 15 Dec 2023 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SO4gq+8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341D4644C;
	Fri, 15 Dec 2023 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7B/+tg76sqlbr78CvNOEgzw0co1GVkPr0PmHwZLy0UA=; b=SO4gq+8CP4jx1S3qWoNtH04PFn
	f2HCa1BTYXtgb8tOyUTuKn64mEHMbMtdh3Iv9/MAMI4dzIIb5Ah88orLDqtAuWB5KJgCtoYmpEShi
	pYByuV9eT1/LRH9tFA6gg+V2Au2PCd8vY1v7kjup2Wrs20nrA70Mk180yBv6hdEBa62R+q1KOsBbH
	Qmb6ZQZ+EnjKZnn2v3Km1WcVfRu/trWNy7YcnQStc20rFLlS/Imw7AbNa6QA8LwY/zOAEloDWOlu1
	6foFwzJGuYNtLJDwHcSUaTyMZ+Vrmy65DcDn+sxOHaTuOHocBxslozS8HBaLN+3mLU7XPkeNxAjIY
	goJYYmSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEF5S-003QyW-0A; Fri, 15 Dec 2023 20:47:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nfs: Remove writepage
Date: Fri, 15 Dec 2023 20:47:07 +0000
Message-Id: <20231215204708.818439-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFS already has writepages and migrate_folio, so it does not need to
implement writepage.  The writepage operation is deprecated as it leads
to worse performance under high memory pressure due to folios being
written out in LRU order rather than sequentially within a file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/file.c          |  1 -
 fs/nfs/write.c         | 11 -----------
 include/linux/nfs_fs.h |  1 -
 3 files changed, 13 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index e8cccb94b927..8577ccf621f5 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -558,7 +558,6 @@ const struct address_space_operations nfs_file_aops = {
 	.read_folio = nfs_read_folio,
 	.readahead = nfs_readahead,
 	.dirty_folio = filemap_dirty_folio,
-	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
 	.write_begin = nfs_write_begin,
 	.write_end = nfs_write_end,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 7248705faef4..bb79d3a886ae 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -680,17 +680,6 @@ static int nfs_writepage_locked(struct folio *folio,
 	return err;
 }
 
-int nfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-	int ret;
-
-	ret = nfs_writepage_locked(folio, wbc);
-	if (ret != AOP_WRITEPAGE_ACTIVATE)
-		unlock_page(page);
-	return ret;
-}
-
 static int nfs_writepages_callback(struct folio *folio,
 				   struct writeback_control *wbc, void *data)
 {
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 279262057a92..f5ce7b101146 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -595,7 +595,6 @@ extern void nfs_complete_unlink(struct dentry *dentry, struct inode *);
  * linux/fs/nfs/write.c
  */
 extern int  nfs_congestion_kb;
-extern int  nfs_writepage(struct page *page, struct writeback_control *wbc);
 extern int  nfs_writepages(struct address_space *, struct writeback_control *);
 extern int  nfs_flush_incompatible(struct file *file, struct folio *folio);
 extern int  nfs_update_folio(struct file *file, struct folio *folio,
-- 
2.42.0


