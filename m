Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7151F656
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiEIIDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 04:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiEIHo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 03:44:58 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1FB17073;
        Mon,  9 May 2022 00:41:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VCfxsaA_1652082049;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VCfxsaA_1652082049)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 15:40:50 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v11 13/22] erofs: add anonymous inode caching metadata for data blobs
Date:   Mon,  9 May 2022 15:40:19 +0800
Message-Id: <20220509074028.74954-14-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce one anonymous inode for data blobs so that erofs can cache
metadata directly within such anonymous inode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 39 ++++++++++++++++++++++++++++++++++++---
 fs/erofs/internal.h |  6 ++++--
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index dfff245b006b..26f038d9c4e1 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,12 +5,17 @@
 #include <linux/fscache.h>
 #include "internal.h"
 
+static const struct address_space_operations erofs_fscache_meta_aops = {
+};
+
 int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache, char *name)
+				  struct erofs_fscache **fscache,
+				  char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
 	struct fscache_cookie *cookie;
+	int ret;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -20,15 +25,40 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 					name, strlen(name), NULL, 0, 0);
 	if (!cookie) {
 		erofs_err(sb, "failed to get cookie for %s", name);
-		kfree(name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	fscache_use_cookie(cookie, false);
 	ctx->cookie = cookie;
 
+	if (need_inode) {
+		struct inode *const inode = new_inode(sb);
+
+		if (!inode) {
+			erofs_err(sb, "failed to get anon inode for %s", name);
+			ret = -ENOMEM;
+			goto err_cookie;
+		}
+
+		set_nlink(inode, 1);
+		inode->i_size = OFFSET_MAX;
+		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+
+		ctx->inode = inode;
+	}
+
 	*fscache = ctx;
 	return 0;
+
+err_cookie:
+	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
+	fscache_relinquish_cookie(ctx->cookie, false);
+	ctx->cookie = NULL;
+err:
+	kfree(ctx);
+	return ret;
 }
 
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
@@ -42,6 +72,9 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 	fscache_relinquish_cookie(ctx->cookie, false);
 	ctx->cookie = NULL;
 
+	iput(ctx->inode);
+	ctx->inode = NULL;
+
 	kfree(ctx);
 	*fscache = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b1f19f058503..5867cb63fd74 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -99,6 +99,7 @@ struct erofs_sb_lz4_info {
 
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 };
 
 struct erofs_sb_info {
@@ -632,7 +633,8 @@ int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
 int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache, char *name);
+				  struct erofs_fscache **fscache,
+				  char *name, bool need_inode);
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
@@ -643,7 +645,7 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
 static inline int erofs_fscache_register_cookie(struct super_block *sb,
 						struct erofs_fscache **fscache,
-						char *name)
+						char *name, bool need_inode)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.27.0

