Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF95B4926BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbiARNNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:13:06 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33659 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242296AbiARNMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2C1oyZ_1642511553;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2C1oyZ_1642511553)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:33 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/20] erofs: implement fscache-based metadata read
Date:   Tue, 18 Jan 2022 21:12:10 +0800
Message-Id: <20220118131216.85338-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements the data plane of reading metadata from bootstrap
blob file over fscache.

Be noted that currently it only supports the scenario where the backing
file has no hole. Once it hits a hole of the backing file, erofs will
fail the IO with -EOPNOTSUPP for now. The following patch will fix this
issue, i.e. implementing the demand reading mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 11 +++++++++--
 fs/erofs/fscache.c  | 33 +++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  3 +++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f3aa133866e5..51ccbc02dd73 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -31,15 +31,22 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
-	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 
 	if (!page || page->index != index) {
 		erofs_put_metabuf(buf);
-		page = read_cache_page_gfp(mapping, index,
+		if (erofs_bdev_mode(sb)) {
+			mapping = sb->s_bdev->bd_inode->i_mapping;
+			page = read_cache_page_gfp(mapping, index,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		} else {
+			page = erofs_fscache_read_cache_page(sbi->bootstrap,
+				index);
+		}
 		if (IS_ERR(page))
 			return page;
 		/* should already be PageUptodate, no need to lock page */
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 74683df6144d..5a25ae523e5e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,9 +6,42 @@
 
 static struct fscache_volume *volume;
 
+static int erofs_blob_begin_cache_operation(struct netfs_read_request *rreq)
+{
+	return fscache_begin_read_operation(&rreq->cache_resources,
+					    rreq->netfs_priv);
+}
+
+/* .cleanup() is needed if rreq->netfs_priv is non-NULL */
+static void erofs_noop_cleanup(struct address_space *mapping, void *netfs_priv)
+{
+}
+
+static const struct netfs_read_request_ops erofs_blob_req_ops = {
+	.begin_cache_operation  = erofs_blob_begin_cache_operation,
+	.cleanup		= erofs_noop_cleanup,
+};
+
+static int erofs_fscache_blob_readpage(struct file *data, struct page *page)
+{
+	struct folio *folio = page_folio(page);
+	struct erofs_fscache_context *ctx =
+		(struct erofs_fscache_context *)data;
+
+	return netfs_readpage(NULL, folio, &erofs_blob_req_ops, ctx->cookie);
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
+	.readpage = erofs_fscache_blob_readpage,
 };
 
+struct page *erofs_fscache_read_cache_page(struct erofs_fscache_context *ctx,
+					   pgoff_t index)
+{
+	DBG_BUGON(!ctx->inode);
+	return read_mapping_page(ctx->inode->i_mapping, index, ctx);
+}
+
 static int erofs_fscache_init_cookie(struct erofs_fscache_context *ctx,
 				     char *path)
 {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 277dcd5888ea..fca706cfaf72 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -633,6 +633,9 @@ struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
 						char *path, bool need_inode);
 void erofs_fscache_put_ctx(struct erofs_fscache_context *ctx);
 
+struct page *erofs_fscache_read_cache_page(struct erofs_fscache_context *ctx,
+					   pgoff_t index);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
-- 
2.27.0

