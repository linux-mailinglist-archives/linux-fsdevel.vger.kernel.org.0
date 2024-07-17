Return-Path: <linux-fsdevel+bounces-23841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EC933FEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B154B23FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D651E86F;
	Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kPrqjtb5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FE143898
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231243; cv=none; b=svG3Ko8R/UrmBhzcJGWrXmyB0LornoR07d9c3VlZQVaRGXYjbVgOpv8QlNGJOB0g2zqpx/EORyCSBNg0MSN+stKCPHIf5UgC2daZjLO88u7wMLkQFBmzUPl+kt5rXAduZgBhNtLG3gfx9HLtzgeiTyi+RrsjIxW6Pd7Z/tktW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231243; c=relaxed/simple;
	bh=FYELWohWWwePsX2DvSJcFc/ik06zo+KLRbUekiqgz04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHW1hu89YyaTYSH7Xwd0LblmKJirPgzM931A7dEyYXc4bfcNX4MXCpmBrFpHc1kHRN6N6kBm+zRYsUKJQthSQRswXASEdjYUIgjuP0P4Wt/1qzQzXZBigc5Kv1LMI/QF6tsDyB9aSL9ZJ3YCt/L4Qw4T68ucuVFH9B7sZPBXE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kPrqjtb5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XIVsVtZR4sKwoWw0hH3mcinrZ+Qys9S/yre8qbWHDtg=; b=kPrqjtb5D8ZAw23CBFGaijIVqx
	X+4ouPw1oiO5HzMU5Tu/O/Lk9xQ0e1EMtY3+EifFb/z4tqETK/jIVjVHVed9kumrj1Cg7LoH4u35q
	kzlljzqVxKYbasToK94pYwoTn1YIVrU1dPNX6maSdPQXE2wPJ4ZuacXq+ueJK4iUr73hoTWzNRfAd
	7X6EmbtIxQQnYZbEsOrUncw2ukpNAChqqPR3A9JBFpi9didCdSxxa0kmFB2ycHo1ZdeFRLyXHHpWR
	ZQ5Dfg/Zrrz4Ty/qe0uGKeaKJHB+wMEm8jTjndRRms7qly26ljI6kbS4XDg5vEEwI3DQizjHFj75l
	DQlFAfQg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sC-00000000zuO-2GxJ;
	Wed, 17 Jul 2024 15:47:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/23] ntfs3: Remove reset_log_file()
Date: Wed, 17 Jul 2024 16:46:56 +0100
Message-ID: <20240717154716.237943-7-willy@infradead.org>
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

This function has no callers (which will be why nobody noticed that
the page wasn't being unlocked).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c   | 39 ---------------------------------------
 fs/ntfs3/ntfs_fs.h |  1 -
 2 files changed, 40 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 6b0bdc474e76..8eaaf9e465d4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1008,45 +1008,6 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 	return err;
 }
 
-int reset_log_file(struct inode *inode)
-{
-	int err;
-	loff_t pos = 0;
-	u32 log_size = inode->i_size;
-	struct address_space *mapping = inode->i_mapping;
-
-	for (;;) {
-		u32 len;
-		void *kaddr;
-		struct page *page;
-
-		len = pos + PAGE_SIZE > log_size ? (log_size - pos) : PAGE_SIZE;
-
-		err = block_write_begin(mapping, pos, len, &page,
-					ntfs_get_block_write_begin);
-		if (err)
-			goto out;
-
-		kaddr = kmap_atomic(page);
-		memset(kaddr, -1, len);
-		kunmap_atomic(kaddr);
-		flush_dcache_page(page);
-
-		err = block_write_end(NULL, mapping, pos, len, len, page, NULL);
-		if (err < 0)
-			goto out;
-		pos += len;
-
-		if (pos >= log_size)
-			break;
-		balance_dirty_pages_ratelimited(mapping);
-	}
-out:
-	mark_inode_dirty_sync(inode);
-
-	return err;
-}
-
 int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	return _ni_write_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index e5255a251929..4e363b8342d6 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -708,7 +708,6 @@ int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
 struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 			 const struct cpu_str *name);
 int ntfs_set_size(struct inode *inode, u64 new_size);
-int reset_log_file(struct inode *inode);
 int ntfs_get_block(struct inode *inode, sector_t vbn,
 		   struct buffer_head *bh_result, int create);
 int ntfs_write_begin(struct file *file, struct address_space *mapping,
-- 
2.43.0


