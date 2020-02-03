Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716801500C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 04:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBCDjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 22:39:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgBCDjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 22:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VjqPzn+7dA/AhZbAs/fy4ycUJnCi/pTarPPUfYx0mRI=; b=Rz31j39TdBc/NVH+JzHDT9UBi
        jvvSe/azXsS7Oom5NmIczyjg3zM8vt61u2AJ9DNVewIV4Fufsul2T8PCVeUxM6ve+mRh2An5yQyVk
        fhdCR70WB020Tgc5krSd2lVryayT31oI1JFLDhZOraL61adwBmZBHlv08lXifHf0DwqLlXlXhpGrZ
        s0Xq1kLpNx7EPDMI6rxvqAFb3Jhiochrw91jIH6kAB0e3+HCz822EMDqd8CkVfJmfDSGgrIwYY1Bl
        //wsIn0sOOJfs55NdhBCMs9D2m8zSAxmZYh5FFC8pNWXE/PiN3s+NoNbrbeA6iCGDi4ml2ubY+G8q
        F3CWaYacw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iySZj-0001q5-8J; Mon, 03 Feb 2020 03:39:03 +0000
Date:   Sun, 2 Feb 2020 19:39:03 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] f2fs: Make f2fs_readpages readable again
Message-ID: <20200203033903.GB8731@bombadil.infradead.org>
References: <20200201150807.17820-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201150807.17820-1-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Remove the horrendous ifdeffery by slipping an IS_ENABLED into
f2fs_compressed_file().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2: Fix compilation by adding more dummy functions

 fs/f2fs/data.c |  6 ------
 fs/f2fs/f2fs.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 7 deletions(-)

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
index 5355be6b6755..e90d2b3f1d2d 100644
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
 
@@ -3797,6 +3798,13 @@ static inline struct page *f2fs_compress_control_page(struct page *page)
 	WARN_ON_ONCE(1);
 	return ERR_PTR(-EINVAL);
 }
+#define f2fs_cluster_can_merge_page(cc, index)	false
+#define f2fs_read_multi_pages(cc, bio, nr_pages, last, is_ra) 0
+#define f2fs_init_compress_ctx(cc) 0
+#define f2fs_destroy_compress_ctx(cc) (void)0
+#define f2fs_cluster_is_empty(cc) true
+#define f2fs_compress_ctx_add_page(cc, page) (void)0
+#define f2fs_is_compressed_cluster(cc, index) false
 #endif
 
 static inline void set_compress_context(struct inode *inode)
-- 
2.24.1

