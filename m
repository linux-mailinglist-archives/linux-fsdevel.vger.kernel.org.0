Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296A34CFED2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 13:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbiCGMfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 07:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242405AbiCGMeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:34:44 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9A41330;
        Mon,  7 Mar 2022 04:33:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6WFbG-_1646656407;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6WFbG-_1646656407)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:33:28 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/21] erofs: implement fscache-based metadata read
Date:   Mon,  7 Mar 2022 20:32:59 +0800
Message-Id: <20220307123305.79520-16-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
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

This patch implements the data plane of reading metadata from bootstrap
blob file over fscache.

Be noted that currently it only supports the scenario where the backing
file has no hole. Once it hits a hole of the backing file, erofs will
fail the IO with -EOPNOTSUPP for now. The following patch will fix this
issue, i.e. implementing the demand reading mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 11 +++++++++--
 fs/erofs/fscache.c  | 24 ++++++++++++++++++++++++
 fs/erofs/internal.h |  3 +++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6e2a28242453..1bff99576883 100644
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
index 3f9f7d6ede57..3f75c1b679e0 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -44,9 +44,33 @@ static inline int erofs_fscache_read_page(struct fscache_cookie *cookie,
 					page_offset(page), PAGE_SIZE, pstart);
 }
 
+static int erofs_fscache_readpage_blob(struct file *data, struct page *page)
+{
+	int ret;
+	struct erofs_fscache_context *ctx =
+		(struct erofs_fscache_context *)data;
+
+	ret = erofs_fscache_read_page(ctx->cookie, page, page_offset(page));
+	if (!ret)
+		SetPageUptodate(page);
+	else
+		SetPageError(page);
+
+	unlock_page(page);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
+	.readpage = erofs_fscache_readpage_blob,
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

