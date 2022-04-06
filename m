Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460134F5D78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiDFMMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 08:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiDFMLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:11:53 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA816432D4D;
        Wed,  6 Apr 2022 00:56:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9L3PE9_1649231797;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9L3PE9_1649231797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 15:56:38 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v8 16/20] erofs: implement fscache-based metadata read
Date:   Wed,  6 Apr 2022 15:56:08 +0800
Message-Id: <20220406075612.60298-17-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the data plane of reading metadata from primary data blob
over fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 20 ++++++++++++++++++--
 fs/erofs/fscache.c  | 38 ++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  9 +++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 14b64d960541..cb8fe299ad67 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -31,15 +31,26 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 		  erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
-	struct address_space *const mapping = inode->i_mapping;
 	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 
 	if (!page || page->index != index) {
 		erofs_put_metabuf(buf);
-		page = read_cache_page_gfp(mapping, index,
+		if (buf->sb) {
+			struct folio *folio;
+
+			folio = erofs_fscache_get_folio(buf->sb, index);
+			if (IS_ERR(folio))
+				page = ERR_CAST(folio);
+			else
+				page = folio_page(folio, 0);
+		} else {
+			struct address_space *const mapping = inode->i_mapping;
+
+			page = read_cache_page_gfp(mapping, index,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		}
 		if (IS_ERR(page))
 			return page;
 		/* should already be PageUptodate, no need to lock page */
@@ -63,6 +74,11 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
+	if (erofs_is_fscache_mode(sb)) {
+		buf->sb = sb;
+		return erofs_bread(buf, NULL, blkaddr, type);
+	}
+
 	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index d38a6efc8e50..158cc273f8fb 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -34,9 +34,47 @@ static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
 	return ret;
 }
 
+static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
+{
+	int ret;
+	struct super_block *sb = (struct super_block *)data;
+	struct folio *folio = page_folio(page);
+	struct erofs_map_dev mdev = {
+		.m_deviceid = 0,
+		.m_pa = folio_pos(folio),
+	};
+
+	ret = erofs_map_dev(sb, &mdev);
+	if (ret)
+		goto out;
+
+	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
+			folio_file_mapping(folio), folio_pos(folio),
+			folio_size(folio), mdev.m_pa);
+	if (ret)
+		goto out;
+
+	folio_mark_uptodate(folio);
+out:
+	folio_unlock(folio);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
+	.readpage = erofs_fscache_meta_readpage,
 };
 
+/*
+ * Get the page cache of data blob at the index offset.
+ * Return: up to date page on success, ERR_PTR() on failure.
+ */
+struct folio *erofs_fscache_get_folio(struct super_block *sb, pgoff_t index)
+{
+	struct erofs_fscache *ctx = EROFS_SB(sb)->s_fscache;
+
+	return read_mapping_folio(ctx->inode->i_mapping, index, (void *)sb);
+}
+
 /*
  * Create an fscache context for data blob.
  * Return: 0 on success and allocated fscache context is assigned to @fscache,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 90f7d6286a4f..e186051f0640 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -276,6 +276,7 @@ enum erofs_kmap_type {
 };
 
 struct erofs_buf {
+	struct super_block *sb;
 	struct page *page;
 	void *base;
 	enum erofs_kmap_type kmap_type;
@@ -639,6 +640,8 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
 				  char *name, bool need_inode);
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
+
+struct folio *erofs_fscache_get_folio(struct super_block *sb, pgoff_t index);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
@@ -653,6 +656,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
 static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 {
 }
+
+static inline struct folio *erofs_fscache_get_folio(struct super_block *sb,
+						    pgoff_t index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-- 
2.27.0

