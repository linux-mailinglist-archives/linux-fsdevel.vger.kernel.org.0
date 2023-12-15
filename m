Return-Path: <linux-fsdevel+bounces-6221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103EC8150CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B3B2876F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC1B697B8;
	Fri, 15 Dec 2023 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Saw/rk8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F2563A9;
	Fri, 15 Dec 2023 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GmcNLU65oEAUUTl/mxQRoWVPOO4x8pF5TdUbIDSNX5c=; b=Saw/rk8lkRD8nFo7Bh7EUFPxjw
	WO26ofxnYr81jYZybxOB70gglbMpOnZFsJVnFizakWiQcRw/HEgJFNEmuPzSWzH/8Dy3IKd9Ah3Qq
	DexWB7ilEHGsFh3uZGQYPH2j68QaBalphRoeG1Vrj667xIeY8ELFPlv1JxQwYlHfcs1Z87QmOeQ+R
	E9CW7vPxXkPnS5bruR45c8QiDwofHAWp/I/TJO3quc+yAqBhvx+5hnN9RkKYNWOKpoap19iGNZrv2
	VlpZMTFkrk29dDtnxhzENmg1QIlQG29VPtq6Lwhz3E0vB3QqkGzax1mLCweWyzmJNxgf4n+LfSDOB
	kEOisUaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038it-IW; Fri, 15 Dec 2023 20:02:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 07/14] hfs: Really remove hfs_writepage
Date: Fri, 15 Dec 2023 20:02:38 +0000
Message-Id: <20231215200245.748418-8-willy@infradead.org>
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

The earlier commit to remove hfs_writepage only removed it from
one of the aops.  Remove it from the btree_aops as well.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hfs/inode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a7bc4690a780..8c34798a0715 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -29,11 +29,6 @@ static const struct inode_operations hfs_file_inode_operations;
 
 #define HFS_VALID_MODE_BITS  (S_IFREG | S_IFDIR | S_IRWXUGO)
 
-static int hfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, hfs_get_block, wbc);
-}
-
 static int hfs_read_folio(struct file *file, struct folio *folio)
 {
 	return block_read_full_folio(folio, hfs_get_block);
@@ -162,9 +157,10 @@ const struct address_space_operations hfs_btree_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= hfs_read_folio,
-	.writepage	= hfs_writepage,
+	.writepages	= hfs_writepages,
 	.write_begin	= hfs_write_begin,
 	.write_end	= generic_write_end,
+	.migrate_folio	= buffer_migrate_folio,
 	.bmap		= hfs_bmap,
 	.release_folio	= hfs_release_folio,
 };
-- 
2.42.0


