Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B16ECC1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 14:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjDXMdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 08:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjDXMdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:33:02 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438FF30C5;
        Mon, 24 Apr 2023 05:32:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VguiHQo_1682339570;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VguiHQo_1682339570)
          by smtp.aliyun-inc.com;
          Mon, 24 Apr 2023 20:32:51 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, linux-fsdevel@vger.kernel.org
Cc:     gerry@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: fix return value of inode_inline_reclaim_one_dmap in error path
Date:   Mon, 24 Apr 2023 20:32:50 +0800
Message-Id: <20230424123250.125404-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When range already got reclaimed by somebody else, return NULL so that
the caller could retry to allocate or reclaim another range, instead of
mistakenly returning the range already got reclaimed and reused by
others.

Reported-by: Liu Jiang <gerry@linux.alibaba.com>
Fixes: 9a752d18c85a ("virtiofs: add logic to free up a memory range")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8e74f278a3f6..59aadfd89ee5 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -985,6 +985,7 @@ inode_inline_reclaim_one_dmap(struct fuse_conn_dax *fcd, struct inode *inode,
 	node = interval_tree_iter_first(&fi->dax->tree, start_idx, start_idx);
 	/* Range already got reclaimed by somebody else */
 	if (!node) {
+		dmap = NULL;
 		if (retry)
 			*retry = true;
 		goto out_write_dmap_sem;
-- 
2.19.1.6.gb485710b

