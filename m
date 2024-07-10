Return-Path: <linux-fsdevel+bounces-23456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FC92C7E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC69F1F23BC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952D0443D;
	Wed, 10 Jul 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGmkEOMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F24404
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574610; cv=none; b=nl2IeRGnv5dAB3H/1dq8l6uTCH69CROI0nQDPWxLqAp9bKQoTulpeksr5+qY2nmWT9j0kgltgVMo50Ys/XEifUx1qjfmYSxfKwC5/nM0Ube6pwVZhWF+gk4PWASMaON4JlhAzu+Kclna4+B/5o2KzzNfJMDmET3GO4f7MBo7YTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574610; c=relaxed/simple;
	bh=Hf4RMDAzB6taNFp95sdzEHYjPc/97ix66CTFGOU4K2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhN1+GX30C6Llihrg1Cf/iTDcMBn8ElUQSdQyJr21M2VbH2gLUBuLqWpUcKyJKStCVNcGcDDYF7PRHMbLkiG7a/IRe+SrBYoJCebOzITNb7VPY1+FuH80k01FWTdgTZzWOp835wDc/OLAnMxcmpKSZ/kxycxBoL9qX/nIRMVWfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GGmkEOMQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O5l/mAhq29kMWF4ipW8yxBh9WqFVmHcoBQ77yoDMVcI=; b=GGmkEOMQQ09SHvgq86eN9zpfpe
	UcQii31iIbrKV1FrJmI09PaH+vJcevDaS6rdIX6CVsq4nEb5lBSZENrj8VfZyN1UV2Bt6mOG3bZQb
	q9yfr1M23uBfEEtlSxqjG9ax0AkMFZV9wQBxs/+pmVvKTcHNp6t7q8rWteZnbqyiAWKVnB0gib6bW
	DQg9xNu2c3gMbkh/grlBTAd0pDP5C+1wNgQNvvtk2+pWr4lwq5ELhhBd8P2usp32aNxyAMeIpOyJn
	yoqavyhJJ4TMJQRvUXdeUidYHAEydnSyhA0gJvFFBi5y99bArve1budY++HCbG1vY6fmWNLKul8sS
	UhSa1nyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRM3K-00000008YaS-0Cyq;
	Wed, 10 Jul 2024 01:23:26 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/7] minixfs: Convert dir_commit_chunk() to take a folio
Date: Wed, 10 Jul 2024 02:23:21 +0100
Message-ID: <20240710012323.2039519-8-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710012323.2039519-1-willy@infradead.org>
References: <20240710012323.2039519-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers now have a folio, so pass it in.  Saves a call to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/minix/dir.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 26bfea508028..5f9e2fc91003 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -40,18 +40,18 @@ minix_last_byte(struct inode *inode, unsigned long page_nr)
 	return last_byte;
 }
 
-static void dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
+static void dir_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct inode *dir = mapping->host;
 
-	block_write_end(NULL, mapping, pos, len, len, page, NULL);
+	block_write_end(NULL, mapping, pos, len, len, &folio->page, NULL);
 
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
 		mark_inode_dirty(dir);
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 }
 
 static int minix_handle_dirsync(struct inode *dir)
@@ -271,7 +271,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 		memset (namx + namelen, 0, sbi->s_dirsize - namelen - 2);
 		de->inode = inode->i_ino;
 	}
-	dir_commit_chunk(&folio->page, pos, sbi->s_dirsize);
+	dir_commit_chunk(folio, pos, sbi->s_dirsize);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	err = minix_handle_dirsync(dir);
@@ -301,7 +301,7 @@ int minix_delete_entry(struct minix_dir_entry *de, struct folio *folio)
 		((minix3_dirent *)de)->inode = 0;
 	else
 		de->inode = 0;
-	dir_commit_chunk(&folio->page, pos, len);
+	dir_commit_chunk(folio, pos, len);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	return minix_handle_dirsync(inode);
@@ -344,7 +344,7 @@ int minix_make_empty(struct inode *inode, struct inode *dir)
 	}
 	kunmap_local(kaddr);
 
-	dir_commit_chunk(&folio->page, 0, 2 * sbi->s_dirsize);
+	dir_commit_chunk(folio, 0, 2 * sbi->s_dirsize);
 	err = minix_handle_dirsync(inode);
 fail:
 	folio_put(folio);
@@ -422,7 +422,7 @@ int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 		((minix3_dirent *)de)->inode = inode->i_ino;
 	else
 		de->inode = inode->i_ino;
-	dir_commit_chunk(&folio->page, pos, sbi->s_dirsize);
+	dir_commit_chunk(folio, pos, sbi->s_dirsize);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	return minix_handle_dirsync(dir);
-- 
2.43.0


