Return-Path: <linux-fsdevel+bounces-23457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF592C7E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA271F23AFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22D3848E;
	Wed, 10 Jul 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R/ezJcwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FC161
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574610; cv=none; b=XeOKLOUTFR6UVpgxGDzlaS2s7wOR6W+lsE/lAxKJVsqF3dPyVH8eRy+bu2ECd2iVYO5SQq2qKtgf2ban2oBou6ZZFkweBxFTWSCCMMwfxntmAVQUTy7jL8pGkOZMzHqbbwbjoOSa4yb1Rano92CElwSaiKvUnSkVO7grteoGoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574610; c=relaxed/simple;
	bh=+ADFq/zJRlm0GjW455ZvqAiqba1I/IlVDTpRuckK5Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxTjcvAfkzv0OPXq/vPeWpe5S3h+AWNWdJmcMkZJTkFkoKAdRM2j+w/1D9oCgvZLBj3idNRXezcxJ3GS3UlvGJ9jCDXamZQyc1WQiWPvHKhLaGEuZracxu60rzLP8voqr6uuqM0rJCe5D9EJT/DDyWJQgOB1pnhKM0TjdqJTjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R/ezJcwj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s99geBaEHd3Jj/GLOadEwCGC+Kc34Qbf018qXjTELGY=; b=R/ezJcwjBQju7RIFhPF0XcPuDj
	1LbXs+w/gzt6LdfMOkFZRbpM6lx+JYacvK62pLhsGFy2dVmEcc7+3f+yeGLz2US7qvbYP/tZjO/Z+
	h9NhentWm4RYlZp5Tkhfsb3uVM2f0qEHBllDZvLQ/1ACR2m2ZiK7/WYypUiLNa6MJb4G+gnoKPqQz
	JyRjs5Sv8hqJwCnCXAEF/j6kA+TBzFYSUB8WNKasar31HZ7MQXis3H+86aFMiwE12KPIsvd7tN488
	4t9Vc1DUAK5PAHnjWqaWDZNgPdUC4vceyVWouMQ0H6ShsIOkNPbzNVPMSq9B68kXn8qb+mkxzCLp8
	pJFLdTBw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRM3J-00000008Ya4-2yZ2;
	Wed, 10 Jul 2024 01:23:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/7] minixfs: Convert minix_delete_entry() to work on a folio
Date: Wed, 10 Jul 2024 02:23:18 +0100
Message-ID: <20240710012323.2039519-5-willy@infradead.org>
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

Match ext2 and remove a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/minix/dir.c   | 14 +++++++-------
 fs/minix/minix.h |  2 +-
 fs/minix/namei.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index c32d182c2d74..994bbbd3dea2 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -283,25 +283,25 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	goto out_put;
 }
 
-int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
+int minix_delete_entry(struct minix_dir_entry *de, struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
-	loff_t pos = page_offset(page) + offset_in_page(de);
+	struct inode *inode = folio->mapping->host;
+	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 	unsigned len = sbi->s_dirsize;
 	int err;
 
-	lock_page(page);
-	err = minix_prepare_chunk(page, pos, len);
+	folio_lock(folio);
+	err = minix_prepare_chunk(&folio->page, pos, len);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return err;
 	}
 	if (sbi->s_version == MINIX_V3)
 		((minix3_dirent *)de)->inode = 0;
 	else
 		de->inode = 0;
-	dir_commit_chunk(page, pos, len);
+	dir_commit_chunk(&folio->page, pos, len);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	return minix_handle_dirsync(inode);
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 6ed34209ed33..063bab8faa6b 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -66,7 +66,7 @@ extern unsigned V2_minix_blocks(loff_t, struct super_block *);
 
 struct minix_dir_entry *minix_find_entry(struct dentry *, struct folio **);
 int minix_add_link(struct dentry*, struct inode*);
-int minix_delete_entry(struct minix_dir_entry*, struct page*);
+int minix_delete_entry(struct minix_dir_entry *, struct folio *);
 int minix_make_empty(struct inode*, struct inode*);
 int minix_empty_dir(struct inode*);
 int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index ba82fa3332f1..5d9c1406fe27 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -148,7 +148,7 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 	de = minix_find_entry(dentry, &folio);
 	if (!de)
 		return -ENOENT;
-	err = minix_delete_entry(de, &folio->page);
+	err = minix_delete_entry(de, folio);
 	folio_release_kmap(folio, de);
 
 	if (err)
@@ -228,7 +228,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 			inode_inc_link_count(new_dir);
 	}
 
-	err = minix_delete_entry(old_de, &old_folio->page);
+	err = minix_delete_entry(old_de, old_folio);
 	if (err)
 		goto out_dir;
 
-- 
2.43.0


