Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED04ED900
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiCaMA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiCaMAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:00:19 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B6208C1B;
        Thu, 31 Mar 2022 04:58:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V8imrsv_1648727888;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8imrsv_1648727888)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Mar 2022 19:58:09 +0800
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
Subject: [PATCH v7 10/19] erofs: add fscache context helper functions
Date:   Thu, 31 Mar 2022 19:57:44 +0800
Message-Id: <20220331115753.89431-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a context structure for managing data blobs, and helper
functions for initializing and cleaning up this context structure.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h | 19 +++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 7a6d0239ebb1..67a3c4935245 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,6 +5,52 @@
 #include <linux/fscache.h>
 #include "internal.h"
 
+/*
+ * Create an fscache context for data blob.
+ * Return: 0 on success and allocated fscache context is assigned to @fscache,
+ *	   negative error number on failure.
+ */
+int erofs_fscache_register_cookie(struct super_block *sb,
+				  struct erofs_fscache **fscache, char *name)
+{
+	struct fscache_volume *volume = EROFS_SB(sb)->volume;
+	struct erofs_fscache *ctx;
+	struct fscache_cookie *cookie;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
+					name, strlen(name), NULL, 0, 0);
+	if (!cookie) {
+		erofs_err(sb, "failed to get cookie for %s", name);
+		kfree(name);
+		return -EINVAL;
+	}
+
+	fscache_use_cookie(cookie, false);
+	ctx->cookie = cookie;
+
+	*fscache = ctx;
+	return 0;
+}
+
+void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+{
+	struct erofs_fscache *ctx = *fscache;
+
+	if (!ctx)
+		return;
+
+	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
+	fscache_relinquish_cookie(ctx->cookie, false);
+	ctx->cookie = NULL;
+
+	kfree(ctx);
+	*fscache = NULL;
+}
+
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 952a2f483f94..c6a3351a4d7d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -97,6 +97,10 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_fscache {
+	struct fscache_cookie *cookie;
+};
+
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -626,9 +630,24 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
+
+int erofs_fscache_register_cookie(struct super_block *sb,
+				  struct erofs_fscache **fscache, char *name);
+void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
+
+static inline int erofs_fscache_register_cookie(struct super_block *sb,
+						struct erofs_fscache **fscache,
+						char *name)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+{
+}
 #endif
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-- 
2.27.0

