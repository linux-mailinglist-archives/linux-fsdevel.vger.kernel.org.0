Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53A14F82F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgBAPIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 10:08:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgBAPIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Oin9omXum+K1vH3lIpfU4JhSOHeXHB2IvOy+kBmeirY=; b=PpI0y0aBsE6Y602fQ4rH5EZff
        iaqvLOaNDrb0ZLJFmk6+Hr0Qn04JlYzFLXKwGa2kuizi92mOUR/DmJ1+ss0rC2nu9OcHz0GseFKve
        EuvAeX418NwSs4ncInCjGkocnIZQsjHPInqkRdDCIq6Fe1mZ4THnf+YfJ36RIxT/JGMC2driUPaF2
        coau+YuI1FCzeCCyWk3pj/d+pZrx8llnXof2UfSYyyJNwSgrxYWWEK6BFCDhDHDLvZ2cifPT77FX/
        VeuIo8B7GLPFha2ji58aWIwAMzbBUwzeWKjcKWtNqq7HMqQEHw7apEmLHpHv7f4dI6xTOdiMZD/DS
        TS9Jn8spw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixuNa-0004fn-Ja; Sat, 01 Feb 2020 15:08:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] f2fs: Make f2fs_readpages readable again
Date:   Sat,  1 Feb 2020 07:08:07 -0800
Message-Id: <20200201150807.17820-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove the horrendous ifdeffery by slipping an IS_ENABLED into
f2fs_compressed_file().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 6 ------
 fs/f2fs/f2fs.h | 3 ++-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8bd9afa81c54..41156a8f60a7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2203,7 +2203,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 				goto next_page;
 		}
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
 			/* there are remained comressed pages, submit them */
 			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
@@ -2230,14 +2229,11 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 			goto next_page;
 		}
 read_single_page:
-#endif
 
 		ret = f2fs_read_single_page(inode, page, max_nr_pages, &map,
 					&bio, &last_block_in_bio, is_readahead);
 		if (ret) {
-#ifdef CONFIG_F2FS_FS_COMPRESSION
 set_error_page:
-#endif
 			SetPageError(page);
 			zero_user_segment(page, 0, PAGE_SIZE);
 			unlock_page(page);
@@ -2246,7 +2242,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 		if (pages)
 			put_page(page);
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
 			/* last page */
 			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
@@ -2257,7 +2252,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 				f2fs_destroy_compress_ctx(&cc);
 			}
 		}
-#endif
 	}
 	BUG_ON(pages && !list_empty(pages));
 	if (bio)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5355be6b6755..398d5a1f2867 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2706,7 +2706,8 @@ static inline int f2fs_has_inline_xattr(struct inode *inode)
 
 static inline int f2fs_compressed_file(struct inode *inode)
 {
-	return S_ISREG(inode->i_mode) &&
+	return IS_ENABLED(CONFIG_F2FS_FS_COMPRESSION) &&
+		S_ISREG(inode->i_mode) &&
 		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
 }
 
-- 
2.24.1

