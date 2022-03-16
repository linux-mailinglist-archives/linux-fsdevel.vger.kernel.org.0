Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8A4DB119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356336AbiCPNTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356264AbiCPNTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:19:07 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF71B12601;
        Wed, 16 Mar 2022 06:17:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7Mu90V_1647436664;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7Mu90V_1647436664)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 21:17:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
Subject: [PATCH v5 14/22] erofs: add erofs_fscache_read_pages() helper
Date:   Wed, 16 Mar 2022 21:17:15 +0800
Message-Id: <20220316131723.111553-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add erofs_fscache_read_pages() helper reading from fscache. It supports
on-demand read semantics. That is, it will make the backend prepare for
the data when cache miss. Once data ready, it will reinitiate a read
from the cache.

This helper can then be used to implement .readpage()/.readahead() of
on-demand read semantics.

Besides also add erofs_fscache_read_page() wrapper helper.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 684ac6f940bc..38b5a9380092 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,44 @@
 
 static struct fscache_volume *volume;
 
+/*
+ * erofs_fscache_read_pages - Read data from fscache.
+ *
+ * Fill the readed data into page cache described by @start/len, which
+ * shall be both aligned with PAGE_SIZE. @pstart describes the corresponding
+ * physical start address in the cache file.
+ */
+static int erofs_fscache_read_pages(struct fscache_cookie *cookie,
+				    struct address_space *mapping,
+				    loff_t start, size_t len,
+				    loff_t pstart)
+{
+	struct netfs_cache_resources cres;
+	struct iov_iter iter;
+	int ret;
+
+	memset(&cres, 0, sizeof(cres));
+
+	ret = fscache_begin_read_operation(&cres, cookie);
+	if (ret)
+		return ret;
+
+	iov_iter_xarray(&iter, READ, &mapping->i_pages, start, len);
+
+	ret = fscache_read(&cres, pstart, &iter,
+			   NETFS_READ_HOLE_ONDEMAND, NULL, NULL);
+
+	fscache_end_operation(&cres);
+	return ret;
+}
+
+static inline int erofs_fscache_read_page(struct fscache_cookie *cookie,
+					  struct page *page, loff_t pstart)
+{
+	return erofs_fscache_read_pages(cookie, page_file_mapping(page),
+					page_offset(page), PAGE_SIZE, pstart);
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
 };
 
-- 
2.27.0

