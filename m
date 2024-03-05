Return-Path: <linux-fsdevel+bounces-13652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7E78726F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 19:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC34F1C2357C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B311B26E;
	Tue,  5 Mar 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THRcpJQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2C199B9
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664733; cv=none; b=qHwUZ+kJinpE2yfRkLnLL3Ip7ksH0excIyT+mucaswPyUNvvBoaBSFiED+D8zUFxvcr8OWZqi7ncLs/AN8QwYMxX5prJOt1gcvp6D5EZOpKe2frlxrzTLB31gdFCtBv4FxsrOShVo7Aq21tlLcv08K454Rwis8goE3oP6hmSi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664733; c=relaxed/simple;
	bh=wQf3MWW/54swO5cnEq6ID3HxHUXpR0KmFlE7Rsuo9e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enfPHHGQiu7qeGBq6+w/kuicT8dEHfTBdumulWi1YEYVuPBd0bxoWPav1Pwmi4PH0e7U53G8USbr50aU/hWevCGKP+HvlT0vwmgKxBh4ejS79vNV6WBw66oe/eG04rR56gsYvMvjw+LR0gstu3DpdcxuzhmAXjD/HutYqUb0GzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=THRcpJQc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ue5iB0uO2FoDM+bsdoyZ7SlaqVamjZcWsAblsHB5Z5w=; b=THRcpJQcYVuqMaAPuRIyFT7Wso
	82lLeej79F5kIWb/xMrFC7MY6Ks+3mKlC2Dmkw+RVpb8xl6zUOBmu1pfXXZv2sMNBrzZSIYEP9AO9
	C+1QKG33PKj6pthGP83mXVes4L5IQMK4GE/1C+jXd2/vN7+og45+Lb1OhVVXtMO73RvJKqrI/ai+0
	WIKtTTX3raYWsKpOhZe2pIKWfWj1Ez1wbwBFOo9x2mTS1XM1QkJy8yr+IsgWxE6vWWDjUxLeJLvla
	Qntz9i3HP94wd2D8NbyPe4sRpI/lJp710Bo5vXNnar9X7Ts0RkDKj0TJN7lyGp+7IoTxR7kpUNw/7
	Pyia7C5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhZtZ-000000052Ea-1XAQ;
	Tue, 05 Mar 2024 18:52:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: reiserfs_wait_on_write_block@infradead.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] reiserfs: Convert to writepages
Date: Tue,  5 Mar 2024 18:52:05 +0000
Message-ID: <20240305185208.1200166-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use buffer_migrate_folio to handle folio migration instead of writing
out dirty pages and reading them back in again.  Use writepages to write
out folios more efficiently.  We now only do that wait_on_write_block
check once per call to writepages instead of once per page.  It would be
possible to do one transaction per writeback run, but that's a bit of a
big change to do to this old filesystem, so leave it as one transaction
per folio (and leave reiserfs supporting only one page per folio).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 1d825459ee6e..c1daedc50f4c 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2503,8 +2503,8 @@ static int map_block_for_writepage(struct inode *inode,
  * start/recovery path as __block_write_full_folio, along with special
  * code to handle reiserfs tails.
  */
-static int reiserfs_write_full_folio(struct folio *folio,
-				    struct writeback_control *wbc)
+static int reiserfs_write_folio(struct folio *folio,
+		struct writeback_control *wbc, void *data)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned long end_index = inode->i_size >> PAGE_SHIFT;
@@ -2721,12 +2721,11 @@ static int reiserfs_read_folio(struct file *f, struct folio *folio)
 	return block_read_full_folio(folio, reiserfs_get_block);
 }
 
-static int reiserfs_writepage(struct page *page, struct writeback_control *wbc)
+static int reiserfs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
-	struct inode *inode = folio->mapping->host;
-	reiserfs_wait_on_write_block(inode->i_sb);
-	return reiserfs_write_full_folio(folio, wbc);
+	reiserfs_wait_on_write_block(mapping->host->i_sb);
+	return write_cache_pages(mapping, wbc, reiserfs_write_folio, NULL);
 }
 
 static void reiserfs_truncate_failed_write(struct inode *inode)
@@ -3405,7 +3404,7 @@ int reiserfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 }
 
 const struct address_space_operations reiserfs_address_space_operations = {
-	.writepage = reiserfs_writepage,
+	.writepages = reiserfs_writepages,
 	.read_folio = reiserfs_read_folio,
 	.readahead = reiserfs_readahead,
 	.release_folio = reiserfs_release_folio,
@@ -3415,4 +3414,5 @@ const struct address_space_operations reiserfs_address_space_operations = {
 	.bmap = reiserfs_aop_bmap,
 	.direct_IO = reiserfs_direct_IO,
 	.dirty_folio = reiserfs_dirty_folio,
+	.migrate_folio = buffer_migrate_folio,
 };
-- 
2.43.0


