Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFB4AE9EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 07:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiBIGFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 01:05:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiBIGB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:01:26 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EF4C02B748;
        Tue,  8 Feb 2022 22:01:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V3zeEc2_1644386483;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V3zeEc2_1644386483)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 14:01:23 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/22] erofs: add anonymous inode managing page cache of blob file
Date:   Wed,  9 Feb 2022 14:00:57 +0800
Message-Id: <20220209060108.43051-12-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce one anonymous inode for managing page cache of corresponding
blob file. Then erofs could read directly from the address space of the
anonymous inode when cache hit.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 45 ++++++++++++++++++++++++++++++++++++++++++---
 fs/erofs/internal.h |  3 ++-
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index c043d7709d65..3addd9aa549c 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,9 @@
 
 static struct fscache_volume *volume;
 
+static const struct address_space_operations erofs_fscache_blob_aops = {
+};
+
 static int erofs_fscache_init_cookie(struct erofs_fscache_context *ctx,
 				     char *path)
 {
@@ -36,8 +39,34 @@ void erofs_fscache_cleanup_cookie(struct erofs_fscache_context *ctx)
 	ctx->cookie = NULL;
 }
 
+static int erofs_fscache_get_inode(struct erofs_fscache_context *ctx,
+				   struct super_block *sb)
+{
+	struct inode *const inode = new_inode(sb);
+
+	if (!inode)
+		return -ENOMEM;
+
+	set_nlink(inode, 1);
+	inode->i_size = OFFSET_MAX;
+
+	inode->i_mapping->a_ops = &erofs_fscache_blob_aops;
+	mapping_set_gfp_mask(inode->i_mapping,
+			GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
+	ctx->inode = inode;
+	return 0;
+}
+
+static inline
+void erofs_fscache_put_inode(struct erofs_fscache_context *ctx)
+{
+	iput(ctx->inode);
+	ctx->inode = NULL;
+}
+
 static int erofs_fscache_init_ctx(struct erofs_fscache_context *ctx,
-				  struct super_block *sb, char *path)
+				  struct super_block *sb, char *path,
+				  bool need_inode)
 {
 	int ret;
 
@@ -47,6 +76,15 @@ static int erofs_fscache_init_ctx(struct erofs_fscache_context *ctx,
 		return ret;
 	}
 
+	if (need_inode) {
+		ret = erofs_fscache_get_inode(ctx, sb);
+		if (ret) {
+			erofs_err(sb, "failed to get anonymous inode");
+			erofs_fscache_cleanup_cookie(ctx);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -54,10 +92,11 @@ static inline
 void erofs_fscache_cleanup_ctx(struct erofs_fscache_context *ctx)
 {
 	erofs_fscache_cleanup_cookie(ctx);
+	erofs_fscache_put_inode(ctx);
 }
 
 struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
-						char *path)
+						char *path, bool need_inode)
 {
 	struct erofs_fscache_context *ctx;
 	int ret;
@@ -66,7 +105,7 @@ struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	ret = erofs_fscache_init_ctx(ctx, sb, path);
+	ret = erofs_fscache_init_ctx(ctx, sb, path, need_inode);
 	if (ret) {
 		kfree(ctx);
 		return ERR_PTR(ret);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1f5bc69e8e9f..bb5e992fe0df 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -99,6 +99,7 @@ struct erofs_sb_lz4_info {
 
 struct erofs_fscache_context {
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 };
 
 struct erofs_sb_info {
@@ -626,7 +627,7 @@ int erofs_init_fscache(void);
 void erofs_exit_fscache(void);
 
 struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
-						char *path);
+						char *path, bool need_inode);
 void erofs_fscache_put_ctx(struct erofs_fscache_context *ctx);
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-- 
2.27.0

