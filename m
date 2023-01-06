Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA166009C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 13:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjAFMxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 07:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjAFMxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:53:39 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F03745B7;
        Fri,  6 Jan 2023 04:53:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZ-Kul8_1673009613;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZ-Kul8_1673009613)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 20:53:34 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 3/6] erofs: alloc anonymous file for blob in share domain mode
Date:   Fri,  6 Jan 2023 20:53:27 +0800
Message-Id: <20230106125330.55529-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
References: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In prep for the following support for page cache sharing based mmap,
allocate an anonymous file for each blob, so that we can link
associated vma to blobs later.

Since page cache sharing will be enabled only for share domain mode,
prepare anonymous file only in share domain mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 24 +++++++++++++++++++++++-
 fs/erofs/internal.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4d7785a70926..ea276884f043 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
 #include <linux/fscache.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
@@ -316,6 +318,8 @@ const struct address_space_operations erofs_fscache_access_aops = {
 	.readahead = erofs_fscache_readahead,
 };
 
+static const struct file_operations erofs_fscache_meta_fops = {};
+
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
 {
 	mutex_lock(&erofs_domain_list_lock);
@@ -428,6 +432,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 	struct fscache_cookie *cookie;
 	struct super_block *psb = sb;
 	struct inode *inode;
+	struct file *file;
 	int ret;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -457,10 +462,24 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	inode->i_private = ctx;
 
+	if (EROFS_SB(sb)->domain_id) {
+		ihold(inode);
+		file = alloc_file_pseudo(inode, erofs_pseudo_mnt, "[erofs]",
+				O_RDONLY, &erofs_fscache_meta_fops);
+		if (IS_ERR(file)) {
+			ret = PTR_ERR(file);
+			iput(inode);
+			goto err_inode;
+		}
+		ctx->file = file;
+	}
+
 	ctx->cookie = cookie;
 	ctx->inode = inode;
 	return ctx;
 
+err_inode:
+	iput(inode);
 err_cookie:
 	fscache_unuse_cookie(cookie, NULL, NULL);
 	fscache_relinquish_cookie(cookie, false);
@@ -473,6 +492,8 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 {
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
+	if (ctx->file)
+		fput(ctx->file);
 	iput(ctx->inode);
 	kfree(ctx->name);
 	kfree(ctx);
@@ -565,7 +586,8 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 		mutex_lock(&erofs_domain_cookies_lock);
 		/* drop the ref for the sentinel in pseudo mount */
 		iput(ctx->inode);
-		drop = atomic_read(&ctx->inode->i_count) == 1;
+		/* one initial ref, and one ref for anonymous file */
+		drop = atomic_read(&ctx->inode->i_count) == 2;
 		if (drop)
 			erofs_fscache_relinquish_cookie(ctx);
 		mutex_unlock(&erofs_domain_cookies_lock);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b3d04bc2d279..24d471fe2fa4 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -109,6 +109,7 @@ struct erofs_domain {
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;	/* anonymous indoe for the blob */
+	struct file *file;	/* anonymous file */
 	struct erofs_domain *domain;
 	char *name;
 };
-- 
2.19.1.6.gb485710b

