Return-Path: <linux-fsdevel+bounces-23512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8192D897
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 20:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AA8281136
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4206F31C;
	Wed, 10 Jul 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KiXnjDGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08217BDA;
	Wed, 10 Jul 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637168; cv=none; b=DJtko6E6KO02ixVnPW1ytYZ+h2BZqKkGOWIkQm7gTGfTMsPEbhGLaNiZ9YXK/4c4WGf7qU249kyGUoao1FkTiDw168Phcdu33GGuLr+etM+eJto6RA1S6+vvMe4JjU5QZaVjylVjMW5B0Djba9CAfFibz6xY/NBteX1A6w+sHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637168; c=relaxed/simple;
	bh=FYELWohWWwePsX2DvSJcFc/ik06zo+KLRbUekiqgz04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwT/HYbr6T22khuzE0ogajj//HciAXJxUp8h9xObg3ABExZS4uEaIYAxUy+ZJHg2ETim2Eor0lsIF//MdK4v0LvmgirzJBMAZWJwXksNBeVK5z6uROt2MBtOzgnA1dwz1zyFi9Sh2P0sNvtM+GMetlWV/dpKfzG75EOyUoInZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KiXnjDGP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=XIVsVtZR4sKwoWw0hH3mcinrZ+Qys9S/yre8qbWHDtg=; b=KiXnjDGPZbpjea/wFuRTOSRGEN
	/HRPemn9Y7Vlxe0WX7u31wa2s53zszyQ5o0XYFVVuKCv4lWsTNo6rVXwPG/8qSmBPLmWeJ9A7mfjx
	JCwRFJrfnA30bMUFCAti/iKkQAeGaBVJ8u11KyEhiUJz0TewqBbzxwGWICYMr7g4dNpDZUoDEGy1T
	hfypbxJoqPMUTwMjh6AlBDmt79+p+eaNVXqW7G8hkeTXXms/D0FnQiizEE55btU4mRJPad6jmbUL5
	oOlbKwgkxUqxbI/DMjMdRoAM98hPgjg82ZrhX10jE8sYKVxCpnqWliit5q7AfG3vqD7xVJtiIpfef
	1h9sPCLg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRcKJ-00000009gtr-0XS4;
	Wed, 10 Jul 2024 18:46:03 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ntfs3: Remove reset_log_file()
Date: Wed, 10 Jul 2024 19:45:56 +0100
Message-ID: <20240710184558.2309826-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
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


