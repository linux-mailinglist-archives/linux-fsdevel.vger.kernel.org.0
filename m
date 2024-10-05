Return-Path: <linux-fsdevel+bounces-31070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A5E991965
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265B11C20EBC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D6E15957E;
	Sat,  5 Oct 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QzPJpljA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498614C5AF;
	Sat,  5 Oct 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152593; cv=none; b=hrCO9yDdxDP8olaNIJxoNikKbRqP/l/+/WSvWWud6/KQ/A6R4AZQB/XyAt4vXi7RG5z6IFbg7RRUkkAp5Ztnuh7mrZtLeFDCEr6W67aHK39vTg7D+DofOOdCgOMyjiFf8p+SzyjymGZzRuca6Gdwv2fUgeZOJCDLc1ApWUOLG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152593; c=relaxed/simple;
	bh=PXuiujFwWzpItEPq1UPYxLIcU7HElA51JtDFSLY2/U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqrV3tAnmqSRiuDvNub6qrKYyMEPVm09RWHHZ/9bO5dQEci3+rWqqzLfi1P5YSBBWj7UJScb0J0DVLlYO4ezIKozN6XZmwgnaM9rCCRkiL61p4cSBtDpottzqUHcHfpP7/xbt9d0cbd40TS1z06Hm1wtWkDvLMBOel1v/S5UeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QzPJpljA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hatWCb0adjweeI0RuXy1B2AriOu0/g40e2M7PFr5fPc=; b=QzPJpljA5DLUa9HZ0ad5UDXnNi
	RUiymF227H6q7Y6DKkefcX79fcoeERNg741bK9t+nYOi9HJkvi1+Gbdkm5V2L6GeYzWij8BekNw7I
	ijIZnzlHt/xuzxMaDt8C/0DMeTSCg0LoVysWU3ebwYfa43JCmWFw2Q6BlnNupVhD3gxvXDaYczB1m
	5OFiowJLSCWC2D9zDw9PdRWtm7Sc+zUdTrjaHqyQeIjintACBpthsPAycR0v17aOLnbbHFYbRwA2g
	cS2jbVMmaYqEnD/ejOt3jo4lj2RaVuuVaHmgQ9DbU1hy7Owzsx4StWB7DHzz8Sois7WjpLEh0NTd+
	mOpnKmqA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx9Qs-0000000DNyT-0aTP;
	Sat, 05 Oct 2024 18:23:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] netfs: Fix a few minor bugs in netfs_page_mkwrite()
Date: Sat,  5 Oct 2024 19:23:04 +0100
Message-ID: <20241005182307.3190401-3-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241005182307.3190401-1-willy@infradead.org>
References: <20241005182307.3190401-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't return with VM_FAULT_SIGBUS | VM_FAULT_LOCKED; the core
code will not unlock the folio in this instance.  Introduce a new
"unlock" error exit to handle this case.  Use it to handle
the "folio is truncated" check, and change the "writeback interrupted
by a fatal signal" to do a NOPAGE exit instead of letting the core
code install the folio currently under writeback before killing the
process.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/netfs/buffered_write.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b3910dfcb56d..ff2814da88b1 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -491,7 +491,9 @@ EXPORT_SYMBOL(netfs_file_write_iter);
 
 /*
  * Notification that a previously read-only page is about to become writable.
- * Note that the caller indicates a single page of a multipage folio.
+ * The caller indicates the precise page that needs to be written to, but
+ * we only track group on a per-folio basis, so we block more often than
+ * we might otherwise.
  */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
 {
@@ -501,7 +503,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = file_inode(file);
 	struct netfs_inode *ictx = netfs_inode(inode);
-	vm_fault_t ret = VM_FAULT_RETRY;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	int err;
 
 	_enter("%lx", folio->index);
@@ -510,21 +512,15 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (folio_lock_killable(folio) < 0)
 		goto out;
-	if (folio->mapping != mapping) {
-		folio_unlock(folio);
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
-	if (folio_wait_writeback_killable(folio)) {
-		ret = VM_FAULT_LOCKED;
-		goto out;
-	}
+	if (folio->mapping != mapping)
+		goto unlock;
+	if (folio_wait_writeback_killable(folio) < 0)
+		goto unlock;
 
 	/* Can we see a streaming write here? */
 	if (WARN_ON(!folio_test_uptodate(folio))) {
-		ret = VM_FAULT_SIGBUS | VM_FAULT_LOCKED;
-		goto out;
+		ret = VM_FAULT_SIGBUS;
+		goto unlock;
 	}
 
 	group = netfs_folio_group(folio);
@@ -559,5 +555,8 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 out:
 	sb_end_pagefault(inode->i_sb);
 	return ret;
+unlock:
+	folio_unlock(folio);
+	goto out;
 }
 EXPORT_SYMBOL(netfs_page_mkwrite);
-- 
2.43.0


