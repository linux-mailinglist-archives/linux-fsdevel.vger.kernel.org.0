Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E06688DB1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 04:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjBCDCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 22:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjBCDBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:01:52 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B38694;
        Thu,  2 Feb 2023 19:01:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VamyBZB_1675393308;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VamyBZB_1675393308)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:01:48 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 5/9] erofs: set accurate anony inode size for page cache sharing
Date:   Fri,  3 Feb 2023 11:01:39 +0800
Message-Id: <20230203030143.73105-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
References: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
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

In prep for the following support for readahead for page cache sharing,
we need accurate inode size of the anonymous inode, or the readahead
algorithm may exceed EOF of blobs if the inode size is OFFSET_MAX magic.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 9 +++++++++
 fs/erofs/internal.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bed02b21978a..4fe7f23b022e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -554,6 +554,15 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	inode->i_private = ctx;
 
+	if (test_opt(&EROFS_SB(sb)->opt, SHARE_CACHE)) {
+		struct netfs_cache_resources cres;
+		ret = fscache_begin_read_operation(&cres, cookie);
+		if (ret)
+			goto err_cookie;
+		fscache_end_operation(&cres);
+		inode->i_size = cookie->object_size;
+	}
+
 	ctx->cookie = cookie;
 	ctx->inode = inode;
 	return ctx;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7c6a7a2d9acf..60d14561fb46 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -181,6 +181,7 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
+#define EROFS_MOUNT_SHARE_CACHE		0x00000100
 
 #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
-- 
2.19.1.6.gb485710b

