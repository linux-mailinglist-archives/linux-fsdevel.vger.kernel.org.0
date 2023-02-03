Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931EF688DA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 04:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjBCDBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 22:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjBCDBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:01:49 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA1010A9D;
        Thu,  2 Feb 2023 19:01:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VampZ0n_1675393304;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VampZ0n_1675393304)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:01:45 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/9] erofs: support readahead in meta routine
Date:   Fri,  3 Feb 2023 11:01:35 +0800
Message-Id: <20230203030143.73105-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
References: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
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

In prep for the following support for readahead for page cache sharing,
add support for readahead in meta routine.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 014e20962376..e2ebe8f7dbe9 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -193,6 +193,30 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 	return ret;
 }
 
+static void erofs_fscache_meta_readahead(struct readahead_control *rac)
+{
+	int ret;
+	struct erofs_fscache *ctx = rac->mapping->host->i_private;
+	struct erofs_fscache_request *req;
+
+	if (!readahead_count(rac))
+		return;
+
+	req = erofs_fscache_req_alloc(rac->mapping,
+			readahead_pos(rac), readahead_length(rac));
+	if (IS_ERR(req))
+		return;
+
+	/* The request completion will drop refs on the folios. */
+	while (readahead_folio(rac))
+		;
+
+	ret = erofs_fscache_read_folios_async(ctx->cookie, req, req->start, req->len);
+	if (ret)
+		req->error = ret;
+	erofs_fscache_req_put(req);
+}
+
 static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 {
 	struct address_space *mapping = primary->mapping;
@@ -319,6 +343,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 
 static const struct address_space_operations erofs_fscache_meta_aops = {
 	.read_folio = erofs_fscache_meta_read_folio,
+	.readahead  = erofs_fscache_meta_readahead,
 };
 
 const struct address_space_operations erofs_fscache_access_aops = {
-- 
2.19.1.6.gb485710b

