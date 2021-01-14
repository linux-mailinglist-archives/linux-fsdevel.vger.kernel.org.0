Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D52F6A64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbhANTCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 14:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbhANTCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:02:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE70C0613C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jan 2021 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Q/TT6MV20P8eRHlRUQdeew9evaFHwu/mZPeqJEfu55o=; b=S6+9Isag0wf1iCUNHuMU3MH19w
        rWTizHmdap2lYgBB8g52v/W7IXwxraYul1yOGdEbEFAn2lP8zfPIN4nX0NgBjpEmh5BvB7j1g6tCL
        cZC9Qvj98ivY2m1Np8xQgMTI8G1GDWZWSli3EJuQWrCndo3Tat7e/iJTvsI6eeFq4W0jI/s4rAID+
        HNUm5w8jG0JF0r8lr9BSUgYfG/OQ8ZITHjWhjZmlES/YlAtSEvHrog8JrIlU6twAAY0USW9UiHe68
        868gJEC1NxhAdWcnBAbSoNg4c6/48/peRGD4tFW3tmPT1Zxm7U3bPdQnTeD0aSa/Mku2psGpzuiJp
        P3zhSp4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l07rZ-007wmU-BC; Thu, 14 Jan 2021 19:00:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] f2fs: Remove readahead collision detection
Date:   Thu, 14 Jan 2021 19:00:51 +0000
Message-Id: <20210114190051.1893991-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the new ->readahead operation, locked pages are added to the page
cache, preventing two threads from racing with each other to read the
same chunk of file, so this is dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c  | 25 -------------------------
 fs/f2fs/f2fs.h  |  1 -
 fs/f2fs/super.c |  2 --
 3 files changed, 28 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4d80f00e5e40..c18248d54020 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2265,11 +2265,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 /*
  * This function was originally taken from fs/mpage.c, and customized for f2fs.
  * Major change was from block_size == page_size in f2fs by default.
- *
- * Note that the aops->readpages() function is ONLY used for read-ahead. If
- * this function ever deviates from doing just read-ahead, it should either
- * use ->readpage() or do the necessary surgery to decouple ->readpages()
- * from read-ahead.
  */
 static int f2fs_mpage_readpages(struct inode *inode,
 		struct readahead_control *rac, struct page *page)
@@ -2292,7 +2287,6 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
-	bool drop_ra = false;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -2303,26 +2297,10 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	map.m_seg_type = NO_CHECK_TYPE;
 	map.m_may_create = false;
 
-	/*
-	 * Two readahead threads for same address range can cause race condition
-	 * which fragments sequential read IOs. So let's avoid each other.
-	 */
-	if (rac && readahead_count(rac)) {
-		if (READ_ONCE(F2FS_I(inode)->ra_offset) == readahead_index(rac))
-			drop_ra = true;
-		else
-			WRITE_ONCE(F2FS_I(inode)->ra_offset,
-						readahead_index(rac));
-	}
-
 	for (; nr_pages; nr_pages--) {
 		if (rac) {
 			page = readahead_page(rac);
 			prefetchw(&page->flags);
-			if (drop_ra) {
-				f2fs_put_page(page, 1);
-				continue;
-			}
 		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -2385,9 +2363,6 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	}
 	if (bio)
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
-
-	if (rac && readahead_count(rac) && !drop_ra)
-		WRITE_ONCE(F2FS_I(inode)->ra_offset, -1);
 	return ret;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 980e061f7968..114a72a99df7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -718,7 +718,6 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
-	pgoff_t ra_offset;		/* ongoing readahead offset */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 
 	/* avoid racing between foreground op and gc */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1d42a59fb982..a25a2db273a3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1156,8 +1156,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
-	fi->ra_offset = -1;
-
 	return &fi->vfs_inode;
 }
 
-- 
2.29.2

