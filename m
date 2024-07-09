Return-Path: <linux-fsdevel+bounces-23404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CE92BDB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E3C1F26460
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C819CCFA;
	Tue,  9 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vyZWr6Sf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F919B5A7
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537399; cv=none; b=KYvNiUIMkX8HnYiktK42+j1mIS9PF9JFZNMBmblyNR4nrz/SmTbSSPOOz4r2MxU2AsGbsEdM8evJVuJ8cc09NW+fN2MLMPRhAEynApH3bi5EwrkeE1WNUHolGTybAArtU71hE+KBJVPz1oiFR+mgeKu+xguhnW6/UmnOdnF2q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537399; c=relaxed/simple;
	bh=pR/evf6fgpCcR4KJcPc68T0ddSvcCZOTsd0g8PTsJEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5jgYCYWQvW+I8aVclbH8XMROiZ+NiMlSd+XRrZlUg6hXcsehE2hVgTK71jiYyBvq9HCxaod5EJucQjwH1LizqKw8pbbXvOnvlO7nZAYeXcKilgTgclOR42pkCRPygpIkXvrnL0wxcKuIgQID/lP/RtDfujTHoFYtsPT+wt7TUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vyZWr6Sf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=N/jZsrB0iio5olmL2oPkcxaiTdmgwtyxJM489B0zWkc=; b=vyZWr6SftOn5H5j4YAOMbUe3Rx
	r7urs2REIC5GMYdojM+lGx+us8ekcv34aiv0clDORqNMg/YNIk6aMChLXKk+iLox9rJO8BGtjY9qH
	cNTRFR3FeYHCi+UfFPRQG1D1WZDvuTfdcc3ufygst2VtCQLHTIVT10tpoazZYlsaRbiaGfWa3fzNO
	8yAY7doZL3T02S6C3aZPS2tHNlXfV7rIZYPyStz4K5ULRNWuPiABBnN3da4BePhhLHkCphb4y2NlL
	mkOl1/cURLwVRiArhzrZDJWAPWHgoNDFrVo6UeIRh42B0Z3gPC/LpA20Nb4g3Y4SHFvNUdMMq5V+f
	dF+5qyCg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCN9-00000007zs9-3ql8;
	Tue, 09 Jul 2024 15:03:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/7] sysv: Convert sysv_delete_entry() to work on a folio
Date: Tue,  9 Jul 2024 16:03:09 +0100
Message-ID: <20240709150314.1906109-5-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709150314.1906109-1-willy@infradead.org>
References: <20240709150314.1906109-1-willy@infradead.org>
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
 fs/sysv/dir.c   | 14 +++++++-------
 fs/sysv/namei.c |  4 ++--
 fs/sysv/sysv.h  |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index ebccf7bb5b69..0b5727510bdd 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -231,20 +231,20 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	goto out_folio;
 }
 
-int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
+int sysv_delete_entry(struct sysv_dir_entry *de, struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
-	loff_t pos = page_offset(page) + offset_in_page(de);
+	struct inode *inode = folio->mapping->host;
+	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
 	int err;
 
-	lock_page(page);
-	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
+	folio_lock(folio);
+	err = sysv_prepare_chunk(&folio->page, pos, SYSV_DIRSIZE);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return err;
 	}
 	de->inode = 0;
-	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(&folio->page, pos, SYSV_DIRSIZE);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	return sysv_handle_dirsync(inode);
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index ef4d91431225..fb8bd8437872 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -159,7 +159,7 @@ static int sysv_unlink(struct inode * dir, struct dentry * dentry)
 	if (!de)
 		return -ENOENT;
 
-	err = sysv_delete_entry(de, &folio->page);
+	err = sysv_delete_entry(de, folio);
 	if (!err) {
 		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 		inode_dec_link_count(inode);
@@ -242,7 +242,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			inode_inc_link_count(new_dir);
 	}
 
-	err = sysv_delete_entry(old_de, &old_folio->page);
+	err = sysv_delete_entry(old_de, old_folio);
 	if (err)
 		goto out_dir;
 
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index ee90af7dbed9..fec9f6b883d5 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -150,7 +150,7 @@ extern void sysv_destroy_icache(void);
 /* dir.c */
 struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct folio **);
 int sysv_add_link(struct dentry *, struct inode *);
-int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
+int sysv_delete_entry(struct sysv_dir_entry *, struct folio *);
 int sysv_make_empty(struct inode *, struct inode *);
 int sysv_empty_dir(struct inode *);
 int sysv_set_link(struct sysv_dir_entry *, struct folio *,
-- 
2.43.0


