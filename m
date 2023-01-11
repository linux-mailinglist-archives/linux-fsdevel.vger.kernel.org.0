Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B4665620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 09:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjAKIcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 03:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjAKIcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:32:09 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028EFA188;
        Wed, 11 Jan 2023 00:32:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZMeLov_1673425919;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZMeLov_1673425919)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:32:00 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/7] erofs: remove unused device mapping in the meta routine
Date:   Wed, 11 Jan 2023 16:31:52 +0800
Message-Id: <20230111083158.23462-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
References: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there're two anonymous inodes (inode and anon_inode in struct
erofs_fscache) may be used for each blob.  The former is only for
bootstrap and used as the address_space of page cache, while the latter
is used for both bootstrap and data blobs when share domain mode enabled
and behaves as a sentinel in the shared domain.

In prep for the following support for page cache sharing, following
patch will unify these two anonymous inodes.  That is, the unified
anonymous inode not only acts as the address_space of page cache, but
also a sentinel in share domain mode.

However the current meta routine can't work if above change applied.
Current meta routine will make a device mapping, and superblock of the
filesystem is required to do the device mapping.  Currently the
superblock is derived from the input meta folio, which is reasonable
since the anonymous inode (used for the address_space of page cache) is
always allocated from the filesystem's sb.  However after anonymous
inodes are unified, that is no longer always true.  For example, in
share domain mode, the unified anonymous inode will be allocated from
pseudo mnt, and the superblock derived from the folio is actually a
pseudo sb, which can't be used for the device mapping at all.

As for the meta routine itself, currently metadata is always on
bootstrap, which means device mapping is not needed so far.  After
removing the redundant device mapping logic, we can derive the required
fscache_ctx from anonymous inode's i_private.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 014e20962376..03de4dc99302 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -164,18 +164,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 {
 	int ret;
-	struct super_block *sb = folio_mapping(folio)->host->i_sb;
+	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
 	struct erofs_fscache_request *req;
-	struct erofs_map_dev mdev = {
-		.m_deviceid = 0,
-		.m_pa = folio_pos(folio),
-	};
-
-	ret = erofs_map_dev(sb, &mdev);
-	if (ret) {
-		folio_unlock(folio);
-		return ret;
-	}
 
 	req = erofs_fscache_req_alloc(folio_mapping(folio),
 				folio_pos(folio), folio_size(folio));
@@ -184,8 +174,8 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 		return PTR_ERR(req);
 	}
 
-	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-				req, mdev.m_pa, folio_size(folio));
+	ret = erofs_fscache_read_folios_async(ctx->cookie, req,
+				folio_pos(folio), folio_size(folio));
 	if (ret)
 		req->error = ret;
 
@@ -469,6 +459,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 		inode->i_size = OFFSET_MAX;
 		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+		inode->i_private = ctx;
 
 		ctx->inode = inode;
 	}
-- 
2.19.1.6.gb485710b

