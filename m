Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9F4E733B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359093AbiCYMYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359047AbiCYMYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:24:44 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA8BD5E88;
        Fri, 25 Mar 2022 05:22:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V89aFt._1648210964;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V89aFt._1648210964)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 20:22:45 +0800
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
Subject: [PATCH v6 13/22] erofs: add anonymous inode managing page cache of blob file
Date:   Fri, 25 Mar 2022 20:22:14 +0800
Message-Id: <20220325122223.102958-14-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
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

Introduce one anonymous inode for managing page cache of corresponding
blob file. Then erofs could read directly from the address space of the
anonymous inode when cache hit.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/internal.h |  7 +++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 73235fd43bf6..30383d9adb62 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -7,6 +7,9 @@
 
 static struct fscache_volume *volume;
 
+static const struct address_space_operations erofs_fscache_blob_aops = {
+};
+
 static int erofs_fscache_init_cookie(struct erofs_fscache *ctx, char *path)
 {
 	struct fscache_cookie *cookie;
@@ -31,6 +34,29 @@ static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
 	ctx->cookie = NULL;
 }
 
+static int erofs_fscache_get_inode(struct erofs_fscache *ctx,
+				   struct super_block *sb)
+{
+	struct inode *const inode = new_inode(sb);
+
+	if (!inode)
+		return -ENOMEM;
+
+	set_nlink(inode, 1);
+	inode->i_size = OFFSET_MAX;
+	inode->i_mapping->a_ops = &erofs_fscache_blob_aops;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+
+	ctx->inode = inode;
+	return 0;
+}
+
+static inline void erofs_fscache_put_inode(struct erofs_fscache *ctx)
+{
+	iput(ctx->inode);
+	ctx->inode = NULL;
+}
+
 /*
  * erofs_fscache_get - create an fscache context for blob file
  * @sb:		superblock
@@ -38,7 +64,8 @@ static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
  *
  * Return: fscache context on success, ERR_PTR() on failure.
  */
-struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
+struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path,
+					bool need_inode)
 {
 	struct erofs_fscache *ctx;
 	int ret;
@@ -53,7 +80,18 @@ struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
 		goto err;
 	}
 
+	if (need_inode) {
+		ret = erofs_fscache_get_inode(ctx, sb);
+		if (ret) {
+			erofs_err(sb, "failed to get anonymous inode");
+			goto err_cookie;
+		}
+	}
+
 	return ctx;
+
+err_cookie:
+	erofs_fscache_cleanup_cookie(ctx);
 err:
 	kfree(ctx);
 	return ERR_PTR(ret);
@@ -65,6 +103,7 @@ void erofs_fscache_put(struct erofs_fscache *ctx)
 		return;
 
 	erofs_fscache_cleanup_cookie(ctx);
+	erofs_fscache_put_inode(ctx);
 	kfree(ctx);
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d4f2b43cedae..459f31803c3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -98,6 +98,7 @@ struct erofs_sb_lz4_info {
 
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 };
 
 struct erofs_sb_info {
@@ -625,14 +626,16 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_init_fscache(void);
 void erofs_exit_fscache(void);
 
-struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path);
+struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path,
+					bool need_inode);
 void erofs_fscache_put(struct erofs_fscache *ctx);
 #else
 static inline int erofs_init_fscache(void) { return 0; }
 static inline void erofs_exit_fscache(void) {}
 
 static inline struct erofs_fscache *erofs_fscache_get(struct super_block *sb,
-						      char *path)
+						      char *path,
+						      bool need_inode)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.27.0

