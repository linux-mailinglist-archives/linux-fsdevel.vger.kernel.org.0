Return-Path: <linux-fsdevel+bounces-17338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5D8AB8F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55F7280FA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D917582;
	Sat, 20 Apr 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dtLWcxJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30E14A8D;
	Sat, 20 Apr 2024 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581457; cv=none; b=S6arKXVoANlrm7W7sQWZ17ylQK8oHOzH4cOdGf+GBtZRCdam2HNjD2b4v8M0xNiMWwZEAS2f5Zejd0lx5pY2l/Qz0eP4LQh39aGsdNql3z5bIKl8vp7+od5XPVPSCSQIhkAlZ7QxCxedzwL8mUU8VgqGnnWuIVSQtpXX932l/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581457; c=relaxed/simple;
	bh=GTTE/6QERROoY8vZDm/RpX/2qBuGiPz4JEzyCyMc3t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI9WaOZy6xHV6jyxMwxl4jvh0qi+8RwY6PxmirQoPam8Gn+5vcVQpXIbss99fIPsr/41R86Mpgyy0C+Kpx8SO91tae0HDJ6ca90Pj8vPWk2PiouLAQSxHjT0VgWsWUQ4tXWjcYWJl9Etc4GX8OhnGZ4hYuGQnFQoOWvMcYyKXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dtLWcxJ4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=c6SDuXJXlko5thNqbkIQf6N/gYuuZjZ0Ic3NpLHdQ5k=; b=dtLWcxJ4OWxvYGWQHmIs4GDQVZ
	To1sbmpOROnX7Eyc6Whm3uQ/jCnrBWWHEIzTs6kEYx1roTMDmUUZquDcnX+H5FIXNo/eWYDmokJvH
	R9+Ka9v4ZG+5umpMWVJ0fShP/BRjlV21bGHzPY37Ivh53eX/H3aFWIOWh4HExnDwme9dxx+p2pcoA
	gJbsBpc4kyMHi1ixPFJ7Zqbm2qlKcb9GZnjjqi40zmAj5I/blcMaPqk2doeDChieY44XZ2qPxlBb3
	fnHMnDd7XsE6PdIXSpwH6iycvLRCNvpYtXpXoU/FLjnnBL/w/Ov3brcz8CkvHjRc3z9YZ11FFEf+V
	+XHQpxag==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oX-000000095fT-1Khq;
	Sat, 20 Apr 2024 02:50:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 15/30] nfs: Remove calls to folio_set_error
Date: Sat, 20 Apr 2024 03:50:10 +0100
Message-ID: <20240420025029.2166544-16-willy@infradead.org>
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

Common code doesn't test the error flag, so we don't need to set it in
nfs.  We can use folio_end_read() to combine the setting (or not)
of the uptodate flag and clearing the lock flag.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/read.c    |  2 --
 fs/nfs/symlink.c | 12 ++----------
 fs/nfs/write.c   |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a142287d86f6..cca80b5f54e0 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -122,8 +122,6 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 {
 	struct folio *folio = nfs_page_to_folio(req);
 
-	if (nfs_error_is_fatal_on_server(error) && error != -ETIMEDOUT)
-		folio_set_error(folio);
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
 		if (nfs_netfs_folio_unlock(folio))
 			folio_unlock(folio);
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 0e27a2e4e68b..1c62a5a9f51d 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -32,16 +32,8 @@ static int nfs_symlink_filler(struct file *file, struct folio *folio)
 	int error;
 
 	error = NFS_PROTO(inode)->readlink(inode, &folio->page, 0, PAGE_SIZE);
-	if (error < 0)
-		goto error;
-	folio_mark_uptodate(folio);
-	folio_unlock(folio);
-	return 0;
-
-error:
-	folio_set_error(folio);
-	folio_unlock(folio);
-	return -EIO;
+	folio_end_read(folio, error == 0);
+	return error;
 }
 
 static const char *nfs_get_link(struct dentry *dentry,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446..a91463ab87a0 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -311,7 +311,6 @@ static void nfs_mapping_set_error(struct folio *folio, int error)
 {
 	struct address_space *mapping = folio_file_mapping(folio);
 
-	folio_set_error(folio);
 	filemap_set_wb_err(mapping, error);
 	if (mapping->host)
 		errseq_set(&mapping->host->i_sb->s_wb_err,
-- 
2.43.0


