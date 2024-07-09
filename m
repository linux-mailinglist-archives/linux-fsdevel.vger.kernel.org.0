Return-Path: <linux-fsdevel+bounces-23348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71B92AEC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B111C20CA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7712CD96;
	Tue,  9 Jul 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KB54zUT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AB42067
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495836; cv=none; b=d9H3d15nKJmHHpwwYmMskxBj2RE2buz16EHPfx4+MnbXQQLKgKH2lWFWwlX20MI3NAFss1xp/AY/Uf9YgYm6R3iu6tUDX+fCc29CmX57EUuFd1WLQ8QrJL0PBSJ6REWHGrVJ4DlAK2QpdzCYLlEgEtyDGsjCMpGY3+km/v39RII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495836; c=relaxed/simple;
	bh=YsBuYwNxyCtU1ndknAGW867NljFfrltww4qmsIB/LJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu7Xqn7phHlO0ru4RxQham7StHctyYgf/MF8FtfNDOWgUKZ0zFwHxsknJTp6fpv+qIkk6bBmRLq+PZImh1IXIIwOLm9nU4JF4/DjM4nI1ghGlhggc11T4vBdXYLG9yL0URZ5oGCPPh2qEkbc6iItVZ0XXwKNgflmmP0EKa4awFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KB54zUT4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GQY9LoA8hNCAWXgQD5p24hGXMklnNxC7e+IGOlnepnU=; b=KB54zUT4pn/6itZOFfUbtNKg9n
	kAlauTauiRimnCzq4b0LhaDSs9bVnKuO2hkUZBrJtg3n3+bSQ6yHdvMGoqx+Sj45jbI4RkWP9RRVP
	DDji/smsFCMZq529lH/joHnZUttN8Eu/FwdeQwoESMkmu1yauAuf4dUoLcfWsIy+Mz8DnpG9q2Lmb
	gERpZws6eJAvZKeqew+fi6rDGPm7OX0SeQsPPt+fy3J+oxj+9sYA0J6tOZNaWcVvlM0QOy0lC3riq
	IhV9WUJ507uMy8cmLqjAgcD5HGXL4GRzjvuSzUgAhKCdud+4Q5RWbclk07zwpBscs+Msgjv65ub0e
	DAKz6pIA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Ym-00000007QTJ-0t0T;
	Tue, 09 Jul 2024 03:30:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/10] ufs; Convert ufs_commit_chunk() to take a folio
Date: Tue,  9 Jul 2024 04:30:26 +0100
Message-ID: <20240709033029.1769992-10-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709033029.1769992-1-willy@infradead.org>
References: <20240709033029.1769992-1-willy@infradead.org>
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
 fs/ufs/dir.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index a20f66351c66..71685491d5f6 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -42,18 +42,18 @@ static inline int ufs_match(struct super_block *sb, int len,
 	return !memcmp(name, de->d_name, len);
 }
 
-static void ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
+static void ufs_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct inode *dir = mapping->host;
 
 	inode_inc_iversion(dir);
-	block_write_end(NULL, mapping, pos, len, len, page, NULL);
+	block_write_end(NULL, mapping, pos, len, len, &folio->page, NULL);
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
 		mark_inode_dirty(dir);
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 }
 
 static int ufs_handle_dirsync(struct inode *dir)
@@ -103,7 +103,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
-	ufs_commit_chunk(&folio->page, pos, len);
+	ufs_commit_chunk(folio, pos, len);
 	ufs_put_page(&folio->page);
 	if (update_times)
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
@@ -383,7 +383,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);
 
-	ufs_commit_chunk(&folio->page, pos, rec_len);
+	ufs_commit_chunk(folio, pos, rec_len);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	mark_inode_dirty(dir);
@@ -526,7 +526,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	if (pde)
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
 	dir->d_ino = 0;
-	ufs_commit_chunk(&folio->page, pos, to - from);
+	ufs_commit_chunk(folio, pos, to - from);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	err = ufs_handle_dirsync(inode);
@@ -574,7 +574,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	strcpy (de->d_name, "..");
 	kunmap_local(kaddr);
 
-	ufs_commit_chunk(&folio->page, 0, chunk_size);
+	ufs_commit_chunk(folio, 0, chunk_size);
 	err = ufs_handle_dirsync(inode);
 fail:
 	folio_put(folio);
-- 
2.43.0


