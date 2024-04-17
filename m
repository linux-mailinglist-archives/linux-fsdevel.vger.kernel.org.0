Return-Path: <linux-fsdevel+bounces-17183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726038A89FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DA5B271B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B0D171E41;
	Wed, 17 Apr 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wVteX4Ez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DC172BC3;
	Wed, 17 Apr 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373797; cv=none; b=BVjE8rYr5kHuupZt3KRxbcKskIq9qkAQvSStHSst3oV+aOZmnP6FHIzP8vwHxnPPw62USQYQtHbjhSN0Hcebfq4SCE47g2kVL0nYdqdR1v4ml2wAabs7OwrdPlRxjtr0NfJlcXF4Du4IrssCbYY7BE0m8Z/b/mZ5+Q/5bxWB7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373797; c=relaxed/simple;
	bh=dENt5TGLtcqwH8n2n6+/ROVruoKRRQ0LEMgNut1PvKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtoodMaoHOhd7BICdt+MIzbOFRd22Knv7sVV1OcRgqDnv2rOVHkD00cnWjMqMbyE9Vey2+2DilQnQvuUFDmWK/rlIFpONR7bw5HiRPGrFYRc/3y1EbbA5gfWiZqliWhknyf+ChtErG+2VQAzdwRun+lxqoIR/haAMBni3dnVKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wVteX4Ez; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BcwRdNxr+GiV+q3NXyqNKiazMO4WpYoF8YYTvyFIEjM=; b=wVteX4Ez2wlaKoEBLTUG5gCboI
	ngICImHPkm9hNFVv2MCEI0/MvZk5+sJNJWpK/DZmDMtK2XWJJ+c5KQ/xBXjXCcZsD5COHujZIWsd/
	I0yMKD0mTPZKraai32/4yhMByJIcqvbjFjlQvpWA4wIXyEPzblUjUdx/HuE4ohiD+hMIn48TGogml
	bukd5NH4cE8z/icZkv71cLiAAuYvmEFvFUoB41o+01SOsBHv7WzzpbdJ+M7nQ95I6qoQ7qCDS3BmL
	cVDXH4G0wFX/kD16jnXu5dC9q5mFTivjBSs3W1YseECQy9MQ9Sn7Uz+Spm2tfP0l5TjMR5NQFjGmL
	vygCtB7w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8nA-00000003LNx-3ad3;
	Wed, 17 Apr 2024 17:09:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/10] ntfs3: Remove inode_write_data()
Date: Wed, 17 Apr 2024 18:09:37 +0100
Message-ID: <20240417170941.797116-10-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417170941.797116-1-willy@infradead.org>
References: <20240417170941.797116-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function has no callers, so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c   | 30 ------------------------------
 fs/ntfs3/ntfs_fs.h |  1 -
 2 files changed, 31 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index cd634398d770..693e8b2f562e 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1086,36 +1086,6 @@ int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 	return ret;
 }
 
-int inode_write_data(struct inode *inode, const void *data, size_t bytes)
-{
-	pgoff_t idx;
-
-	/* Write non resident data. */
-	for (idx = 0; bytes; idx++) {
-		size_t op = bytes > PAGE_SIZE ? PAGE_SIZE : bytes;
-		struct page *page = ntfs_map_page(inode->i_mapping, idx);
-
-		if (IS_ERR(page))
-			return PTR_ERR(page);
-
-		lock_page(page);
-		WARN_ON(!PageUptodate(page));
-		ClearPageUptodate(page);
-
-		memcpy(page_address(page), data, op);
-
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-		unlock_page(page);
-
-		ntfs_unmap_page(page);
-
-		bytes -= op;
-		data = Add2Ptr(data, PAGE_SIZE);
-	}
-	return 0;
-}
-
 /*
  * ntfs_reparse_bytes
  *
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index d35dc001c2c0..1582cde21988 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -713,7 +713,6 @@ int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
 int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 		      struct inode *i2);
-int inode_write_data(struct inode *inode, const void *data, size_t bytes);
 struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 				struct dentry *dentry,
 				const struct cpu_str *uni, umode_t mode,
-- 
2.43.0


