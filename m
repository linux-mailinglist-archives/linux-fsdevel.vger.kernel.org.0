Return-Path: <linux-fsdevel+bounces-23406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03192BDB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3845285B6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C795F19D079;
	Tue,  9 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WaQPiZof"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBF19CCF4
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537399; cv=none; b=Huielhq5i7zDx46VywPMLLDY6M6x3/qunPmp2slzhzvwYy31EX1tIKXnWNQpDOKzg9Wbynn+sMQvMcquEa/v8swg7gy9jP2v4A3Vwv9hjiRUvO5MkW07LV1bj6fWcdIf/xLCvWAab4UmJ0qwRhnsIO+d12GK5fzseM9ENZUTEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537399; c=relaxed/simple;
	bh=OyBH+sUzL68gX3EQvBjAjSq97byxdrgny3BAk/2KBE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBPDQw1vKceom1xHUwHj98wLACzDiJZR9ZGJGt2111eE1gbN9ATw3D3F1O7y8GYR5eXOTi63/kbgd1cw21sT0Dk3l7eE3RCG/CjaHkBlVOkCtEXciZD7qsQj2/Urx+nXnMe2Ctr2yX/FZyfb6iDn2i2HrMfGtQkww4/5YN3UEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WaQPiZof; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Y9NIrT9bGXXaj8ypo8Ee686FddLu/HsImPyUZW8oGMs=; b=WaQPiZoft9dJ14/aFdcvZWBEPO
	PvRGFRhTDbr9B6p0ueusWCNrejSr1M3E6gsQkpyzs6PU3WSrDcwmD+L8CvAE+0yh7AMtCEmZANiWf
	oOE3KFCfWSYPILZ+cPwjN1Hwv7UXbobGksL7lNKcUlMirssxvb5hW6tngPORLNIvvjKn0sj5nTm0m
	1D2/kRU2YgX6y8+0HNUQOswef7TIrVJTa55WRbKtvftMOhBzV/69rOTIxOhlArUm3LsuDBzpC9L/7
	xL6wxhn/BCpg2HoXtvpAl6Dx4S0VDkwdjExJET5yVM5khF37b4aNYcJPJL3/HUeJayPn0tdGJN0jH
	cOLpX8uQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCNA-00000007zsU-1AbC;
	Tue, 09 Jul 2024 15:03:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/7] sysv: Convert dir_commit_chunk() to take a folio
Date: Tue,  9 Jul 2024 16:03:12 +0100
Message-ID: <20240709150314.1906109-8-willy@infradead.org>
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

All callers now have a folio, so pass it in.  Saves a call to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/sysv/dir.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 43615b803fee..27eaa5273ba7 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -28,17 +28,17 @@ const struct file_operations sysv_dir_operations = {
 	.fsync		= generic_file_fsync,
 };
 
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
 
 static int sysv_handle_dirsync(struct inode *dir)
@@ -219,7 +219,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	memcpy (de->name, name, namelen);
 	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
-	dir_commit_chunk(&folio->page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	err = sysv_handle_dirsync(dir);
@@ -244,7 +244,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct folio *folio)
 		return err;
 	}
 	de->inode = 0;
-	dir_commit_chunk(&folio->page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	return sysv_handle_dirsync(inode);
@@ -275,7 +275,7 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 	strcpy(de->name,"..");
 
 	kunmap_local(kaddr);
-	dir_commit_chunk(&folio->page, 0, 2 * SYSV_DIRSIZE);
+	dir_commit_chunk(folio, 0, 2 * SYSV_DIRSIZE);
 	err = sysv_handle_dirsync(inode);
 fail:
 	folio_put(folio);
@@ -341,7 +341,7 @@ int sysv_set_link(struct sysv_dir_entry *de, struct folio *folio,
 		return err;
 	}
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
-	dir_commit_chunk(&folio->page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	return sysv_handle_dirsync(inode);
-- 
2.43.0


