Return-Path: <linux-fsdevel+bounces-20584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39278D53C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE9228476F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9635015AAD6;
	Thu, 30 May 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MPwcYHY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025615B574;
	Thu, 30 May 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100483; cv=none; b=oTfPpne0GHmYKx1s4kyr0TlfdkTPiIhOp6vZU+ec9h2/Zv8QKukpivlnHGy+U3T+LCsoDKTsIssl+z27EydzynAa3wEND+O34I5jolBVRNY9f4zt0qqrOT3eeq5yvLJsRlVzrb14SgiiDCvmH0ecpat8NrLDgNasXzhJXGxk2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100483; c=relaxed/simple;
	bh=awnQuNFNAj1xMVjEOM16pvrQcZGtiTlqQft8kIwYekQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeQetMoIPJqoVnz9Grnr8/o8dl/UcHF216iAsn7tluAMmQK3iEknA7mkgo3xXH1+y5pyyLtSz+MrENUUxhCQ2ifWes2hRdNdZY8fixgOMe267y2dqHQebS7KVe31OA8clhzgfiFJ3UXvlD1zWtxSoImhgH1tBzuK+sDjz3JJEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MPwcYHY+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2tXTCaKONv/xd3aviOhqWrMWUBzDVFqCaPB0En8yrzE=; b=MPwcYHY+fLGlCRbSr0pUM8lp+a
	US7P8gjZ6+P3lgaxS4U1naFRFepz3ISNdsdBrgkQvRZHT+mqQ4Xav4+2Xslk6e5+Op28k53A8AbDO
	AB1D8T9J+ZTyD7VHnIsnpzxut56v96kijSYCfe2ZgHceeQBaT8d1KqMqMFasGD2EdqLoHQe2XHVFd
	vZWRs5VhlmmyIoOSnriQQOT7SqYLfRYZuLv9HaAYks4yuz4jGaQgXi225rnKfTII+wSJ9tvXbnWZL
	okWNE+onNO4U9n4jSeI26I2hYTOY1/enGrucnFctzrFi+74pmHyLI2BzCaDA4jj7t8Ffvvopap2ne
	zYHW7N8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8LQ-49Y8;
	Thu, 30 May 2024 20:21:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 09/16] nfs: Remove calls to folio_set_error
Date: Thu, 30 May 2024 21:21:01 +0100
Message-ID: <20240530202110.2653630-10-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
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
index 3573cdc4b28f..85cddb2a6135 100644
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


