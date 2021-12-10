Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E399F46FBB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbhLJHk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:27 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58511 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237797AbhLJHkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8E0RZ_1639121797;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8E0RZ_1639121797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:38 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 15/19] erofs: implement fscache-based metadata read
Date:   Fri, 10 Dec 2021 15:36:15 +0800
Message-Id: <20211210073619.21667-16-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     |  5 +++--
 fs/erofs/fscache.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    | 10 ++++++----
 4 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index cf71082bd52f..47bd3d0ae94c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -12,6 +12,7 @@
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 {
 	struct address_space * mapping;
+	struct erofs_sb_info *sbi;
 	struct page *page;
 
 	if (sb->s_bdev) {
@@ -19,8 +20,8 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 		page = read_cache_page_gfp(mapping, blkaddr,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
 	} else {
-		/* TODO: fscache based data path */
-		page = ERR_PTR(-EINVAL);
+		sbi = EROFS_SB(sb);
+		page = erofs_readpage_from_fscache(sbi->bootstrap, blkaddr);
 	}
 
 	/* should already be PageUptodate */
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index cf550fdedd1e..6fe31d410cbd 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -1,5 +1,50 @@
 #include "internal.h"
 
+static int erofs_begin_cache_operation(struct netfs_read_request *rreq)
+{
+	return fscache_begin_read_operation(&rreq->cache_resources,
+					    rreq->netfs_priv);
+}
+
+static void erofs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
+{
+}
+
+const struct netfs_read_request_ops erofs_req_ops = {
+	.begin_cache_operation  = erofs_begin_cache_operation,
+	.cleanup		= erofs_priv_cleanup,
+};
+
+struct page *erofs_readpage_from_fscache(struct fscache_cookie *cookie,
+					 pgoff_t index)
+{
+	int ret = -ENOMEM;
+	struct folio *folio;
+	struct page *page;
+
+	page = alloc_page(GFP_KERNEL);
+	if (unlikely(!page)) {
+		printk("failed to allocate page\n");
+		goto err;
+	}
+
+	page->index = index;
+	folio = page_folio(page);
+
+	ret = netfs_readpage_demand(folio, &erofs_req_ops, cookie);
+	if (unlikely(ret || !PageUptodate(page))) {
+		printk("failed to read from fscache\n");
+		goto err_page;
+	}
+
+	return page;
+
+err_page:
+	__free_page(page);
+err:
+	return ERR_PTR(ret);
+}
+
 int erofs_fscache_init(struct erofs_sb_info *sbi, char *bootstrap_path)
 {
 	sbi->volume = fscache_acquire_volume("erofs", NULL, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8136ec63a9de..d60d9ffaef2a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -577,6 +577,9 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_fscache_init(struct erofs_sb_info *sbi, char *bootstrap_path);
 void erofs_fscache_cleanup(struct erofs_sb_info *sbi);
 
+struct page *erofs_readpage_from_fscache(struct fscache_cookie *cookie,
+					 pgoff_t index);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f2a5f4cd53fd..bb68bc81a1a7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -330,21 +330,23 @@ static int erofs_init_devices(struct super_block *sb,
 
 static int erofs_read_superblock(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct page *page;
 	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
 	void *data;
 	int ret;
 
-	page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
+	if (sb->s_bdev)
+		page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
+	else
+		page = erofs_readpage_from_fscache(sbi->bootstrap, 0);
+
 	if (IS_ERR(page)) {
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(page);
 	}
 
-	sbi = EROFS_SB(sb);
-
 	data = kmap(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
-- 
2.27.0

