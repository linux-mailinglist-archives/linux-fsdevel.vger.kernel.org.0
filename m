Return-Path: <linux-fsdevel+bounces-23840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA69933FE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8DC1C210BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047F181D0B;
	Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bN3sarsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A41E86F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231243; cv=none; b=qb071p+x9C/c0ZCKfqrMcDTB/x0TxIM3G5u4sP2VRjFx7I51PSS12PFvv4W7iwzvYVfkE1ojYWyfMkN9VuZqoPGwitvMZhMEwlAVn3gdzofu9oFcVsnJNI3Td5aVK7dp0mWupukDlMIR5Qszog5kr3kIfaUuyRoGfF57L1Zlntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231243; c=relaxed/simple;
	bh=MESjIeQGa+gHKSuBbFvB8Zt6Xs+s/BPVeZS9Ztb1c9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPcgIYCaAoogD5yWLvhHnqrDzXVReC5vNRezwpIETMjRvS2CWxnUQMbeuhk2QAn7280wrXq/F6wHHOU81xy8nswv+z935RD9VeLlsteWOQad5ar3CY0aazPZsa/6hs23CmfYe4v6j3kBxwqsyZekP3KAnroebjKTJh4nyNED2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bN3sarsA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=aHeccN5/+d7/bilRnKB6ssRiH1KEv0uajOLfGSk38es=; b=bN3sarsAQ0bAVXLljjGo8vFnjd
	2W0gq05Djq+UZG/eDcTWdbK53LFspU5fjn4O0R8ePjC7aOFCrWZuSRDkzUpEURVvR/gHZTJV/MNRW
	/MiIE/EKJFXPi+4/CG6VHKZf7Mt25haUdHEYhNUl+2k5jA4H3lAgSENtigNyG3vttL7Zkwj/si9w0
	v0pXvWqA6CYH6Bu+vsa30nxmrvWocJTUU6lRaxIxvNo3B9/pc/yNNhyPCYNToa69b3RgagMBUUIf5
	783eXbGG147qzvTNkQhXT3YadQeY/5WdSMmJmW2QqJK/giR/lFowScasNjEltVIlJ1d2Pi7BK6v7W
	/bdJ4kZA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sB-00000000ztz-3dnw;
	Wed, 17 Jul 2024 15:47:19 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/23] reiserfs: Convert grab_tail_page() to use a folio
Date: Wed, 17 Jul 2024 16:46:51 +0100
Message-ID: <20240717154716.237943-2-willy@infradead.org>
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

Removes a call to grab_cache_page() and a few hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 9b43a81a6488..2d558b2012ea 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2178,7 +2178,7 @@ static int grab_tail_page(struct inode *inode,
 	unsigned long offset = (inode->i_size) & (PAGE_SIZE - 1);
 	struct buffer_head *bh;
 	struct buffer_head *head;
-	struct page *page;
+	struct folio *folio;
 	int error;
 
 	/*
@@ -2190,20 +2190,20 @@ static int grab_tail_page(struct inode *inode,
 	if ((offset & (blocksize - 1)) == 0) {
 		return -ENOENT;
 	}
-	page = grab_cache_page(inode->i_mapping, index);
-	error = -ENOMEM;
-	if (!page) {
-		goto out;
-	}
+	folio = __filemap_get_folio(inode->i_mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(inode->i_mapping));
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 	/* start within the page of the last block in the file */
 	start = (offset / blocksize) * blocksize;
 
-	error = __block_write_begin(page, start, offset - start,
+	error = __block_write_begin(&folio->page, start, offset - start,
 				    reiserfs_get_block_create_0);
 	if (error)
 		goto unlock;
 
-	head = page_buffers(page);
+	head = folio_buffers(folio);
 	bh = head;
 	do {
 		if (pos >= start) {
@@ -2226,14 +2226,13 @@ static int grab_tail_page(struct inode *inode,
 		goto unlock;
 	}
 	*bh_result = bh;
-	*page_result = page;
+	*page_result = &folio->page;
 
-out:
 	return error;
 
 unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return error;
 }
 
-- 
2.43.0


