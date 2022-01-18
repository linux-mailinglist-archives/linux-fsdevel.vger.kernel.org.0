Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98CB492693
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbiARNMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:12:35 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44644 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242187AbiARNMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2C2ax2_1642511549;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2C2ax2_1642511549)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:30 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/20] erofs: add cookie context helper functions
Date:   Tue, 18 Jan 2022 21:12:07 +0800
Message-Id: <20220118131216.85338-12-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce 'struct erofs_cookie_ctx' for managing cookie for backing
file, and the following introduced API for reading from backing file.

Besides, introduce two helper functions for initializing and cleaning
up erofs_cookie_ctx.

struct erofs_cookie_ctx *
erofs_fscache_get_ctx(struct super_block *sb, char *path);

void erofs_fscache_put_ctx(struct erofs_cookie_ctx *ctx);

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 78 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  8 +++++
 2 files changed, 86 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 9c32f42e1056..10c3f5ea9e24 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,84 @@
 
 static struct fscache_volume *volume;
 
+static int erofs_fscache_init_cookie(struct erofs_fscache_context *ctx,
+				     char *path)
+{
+	struct fscache_cookie *cookie;
+
+	/*
+	 * @object_size shall be non-zero to avoid
+	 * FSCACHE_COOKIE_NO_DATA_TO_READ.
+	 */
+	cookie = fscache_acquire_cookie(volume, 0,
+					path, strlen(path),
+					NULL, 0, -1);
+	if (!cookie)
+		return -EINVAL;
+
+	fscache_use_cookie(cookie, false);
+	ctx->cookie = cookie;
+	return 0;
+}
+
+static inline
+void erofs_fscache_cleanup_cookie(struct erofs_fscache_context *ctx)
+{
+	struct fscache_cookie *cookie = ctx->cookie;
+
+	fscache_unuse_cookie(cookie, NULL, NULL);
+	fscache_relinquish_cookie(cookie, false);
+	ctx->cookie = NULL;
+}
+
+static int erofs_fscahce_init_ctx(struct erofs_fscache_context *ctx,
+				  struct super_block *sb, char *path)
+{
+	int ret;
+
+	ret = erofs_fscache_init_cookie(ctx, path);
+	if (ret) {
+		erofs_err(sb, "failed to init cookie");
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline
+void erofs_fscache_cleanup_ctx(struct erofs_fscache_context *ctx)
+{
+	erofs_fscache_cleanup_cookie(ctx);
+}
+
+struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
+						char *path)
+{
+	struct erofs_fscache_context *ctx;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ret = erofs_fscahce_init_ctx(ctx, sb, path);
+	if (ret) {
+		kfree(ctx);
+		return ERR_PTR(ret);
+	}
+
+	return ctx;
+}
+
+void erofs_fscache_put_ctx(struct erofs_fscache_context *ctx)
+{
+	if (!ctx)
+		return;
+
+	erofs_fscache_cleanup_ctx(ctx);
+	kfree(ctx);
+}
+
 int __init erofs_init_fscache(void)
 {
 	volume = fscache_acquire_volume("erofs", NULL, NULL, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c2608a469107..1f5bc69e8e9f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -97,6 +97,10 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_fscache_context {
+	struct fscache_cookie *cookie;
+};
+
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -621,6 +625,10 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_init_fscache(void);
 void erofs_exit_fscache(void);
 
+struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
+						char *path);
+void erofs_fscache_put_ctx(struct erofs_fscache_context *ctx);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
-- 
2.27.0

