Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC9047FCD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhL0MzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:02 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:57114 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232241AbhL0My5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:54:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.wf8ne_1640609695;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.wf8ne_1640609695)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:54:55 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/23] erofs: add cookie context helper functions
Date:   Mon, 27 Dec 2021 20:54:30 +0800
Message-Id: <20211227125444.21187-10-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
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
 fs/erofs/fscache.c  | 75 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  8 +++++
 2 files changed, 83 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index cdbbe3f15a20..15c5bb0f8ea5 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,81 @@
 
 static struct fscache_volume *volume;
 
+static int erofs_fscache_init_cookie(struct erofs_cookie_ctx *ctx, char *path)
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
+static void erofs_fscache_cleanup_cookie(struct erofs_cookie_ctx *ctx)
+{
+	struct fscache_cookie *cookie = ctx->cookie;
+
+	fscache_unuse_cookie(cookie, NULL, NULL);
+	fscache_relinquish_cookie(cookie, false);
+	ctx->cookie = NULL;
+}
+
+static int erofs_fscahce_init_ctx(struct erofs_cookie_ctx *ctx,
+				  struct super_block *sb, char *path)
+{
+	int ret;
+
+	ret = erofs_fscache_init_cookie(ctx, path);
+	if (ret) {
+		erofs_err(sb, "failed to init cookie\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void erofs_fscache_cleanup_ctx(struct erofs_cookie_ctx *ctx)
+{
+	erofs_fscache_cleanup_cookie(ctx);
+}
+
+struct erofs_cookie_ctx *erofs_fscache_get_ctx(struct super_block *sb,
+					       char *path)
+{
+	struct erofs_cookie_ctx *ctx;
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
+void erofs_fscache_put_ctx(struct erofs_cookie_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	erofs_fscache_cleanup_ctx(ctx);
+	kfree(ctx);
+}
+
 int __init erofs_fscache_init(void)
 {
 	volume = fscache_acquire_volume("erofs", NULL, NULL, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d464642e9d35..4179c3dcb7f9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -91,6 +91,10 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_cookie_ctx {
+	struct fscache_cookie *cookie;
+};
+
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -574,6 +578,10 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_fscache_init(void);
 void erofs_fscache_cleanup(void);
 
+struct erofs_cookie_ctx *erofs_fscache_get_ctx(struct super_block *sb,
+					       char *path);
+void erofs_fscache_put_ctx(struct erofs_cookie_ctx *ctx);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
-- 
2.27.0

