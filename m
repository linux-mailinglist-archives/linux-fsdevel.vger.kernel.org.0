Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B0E47FD15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhL0Mz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:58 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46182 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236823AbhL0My6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:54:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.xJoQp_1640609696;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.xJoQp_1640609696)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:54:57 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/23] erofs: add anonymous inode managing page cache of blob file
Date:   Mon, 27 Dec 2021 20:54:31 +0800
Message-Id: <20211227125444.21187-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce one anonymous inode for managing page cache of corresponding
blob file. Then erofs could read directly from the address space of the
anonymous inode when cache hit.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 35 +++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 15c5bb0f8ea5..4dfca7c95710 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -34,6 +34,33 @@ static void erofs_fscache_cleanup_cookie(struct erofs_cookie_ctx *ctx)
 	ctx->cookie = NULL;
 }
 
+static const struct address_space_operations erofs_fscache_aops = {
+};
+
+static int erofs_fscache_get_inode(struct erofs_cookie_ctx *ctx,
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
+	inode->i_mapping->a_ops = &erofs_fscache_aops;
+	mapping_set_gfp_mask(inode->i_mapping,
+			GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
+	ctx->inode = inode;
+	return 0;
+}
+
+static void erofs_fscache_put_inode(struct erofs_cookie_ctx *ctx)
+{
+	iput(ctx->inode);
+	ctx->inode = NULL;
+}
+
 static int erofs_fscahce_init_ctx(struct erofs_cookie_ctx *ctx,
 				  struct super_block *sb, char *path)
 {
@@ -45,12 +72,20 @@ static int erofs_fscahce_init_ctx(struct erofs_cookie_ctx *ctx,
 		return ret;
 	}
 
+	ret = erofs_fscache_get_inode(ctx, sb);
+	if (ret) {
+		erofs_err(sb, "failed to get anonymous inode\n");
+		erofs_fscache_cleanup_cookie(ctx);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void erofs_fscache_cleanup_ctx(struct erofs_cookie_ctx *ctx)
 {
 	erofs_fscache_cleanup_cookie(ctx);
+	erofs_fscache_put_inode(ctx);
 }
 
 struct erofs_cookie_ctx *erofs_fscache_get_ctx(struct super_block *sb,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4179c3dcb7f9..2e4f267b37e7 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -93,6 +93,7 @@ struct erofs_sb_lz4_info {
 
 struct erofs_cookie_ctx {
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 };
 
 struct erofs_sb_info {
-- 
2.27.0

