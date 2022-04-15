Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A542502A21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353587AbiDOMjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353689AbiDOMj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:39:27 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965DDC6EE1;
        Fri, 15 Apr 2022 05:36:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VA7Ug1q_1650026197;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VA7Ug1q_1650026197)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 20:36:38 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: [PATCH v9 14/21] erofs: add erofs_fscache_read_folios() helper
Date:   Fri, 15 Apr 2022 20:36:07 +0800
Message-Id: <20220415123614.54024-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
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

Add erofs_fscache_read_folios() helper reading from fscache. It supports
on-demand read semantics. That is, it will make the backend prepare for
the data when cache miss. Once data ready, it will read from the cache.

This helper can then be used to implement .readpage()/.readahead() of
on-demand read semantics.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fscache.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 1c88614203d2..066f68c062e2 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,6 +5,59 @@
 #include <linux/fscache.h>
 #include "internal.h"
 
+/*
+ * Read data from fscache and fill the read data into page cache described by
+ * @start/len, which shall be both aligned with PAGE_SIZE. @pstart describes
+ * the start physical address in the cache file.
+ */
+static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
+				     struct address_space *mapping,
+				     loff_t start, size_t len,
+				     loff_t pstart)
+{
+	enum netfs_io_source source;
+	struct netfs_io_subrequest subreq;
+	struct netfs_io_request rreq;
+	struct netfs_cache_resources *cres = &rreq.cache_resources;
+	struct iov_iter iter;
+	size_t done = 0;
+	int ret;
+
+	memset(&rreq, 0, sizeof(rreq));
+	memset(&subreq, 0, sizeof(subreq));
+	subreq.rreq = &rreq;
+
+	ret = fscache_begin_read_operation(cres, cookie);
+	if (ret)
+		return ret;
+
+	while (done < len) {
+		subreq.start = pstart + done;
+		subreq.len = len - done;
+		subreq.flags = 1 << NETFS_SREQ_ONDEMAND;
+
+		source = cres->ops->prepare_read(&subreq, LLONG_MAX);
+		if (WARN_ON(subreq.len == 0))
+			source = NETFS_INVALID_READ;
+		if (source != NETFS_READ_FROM_CACHE) {
+			ret = -EIO;
+			goto out;
+		}
+
+		iov_iter_xarray(&iter, READ, &mapping->i_pages,
+				start + done, subreq.len);
+		ret = fscache_read(cres, subreq.start, &iter,
+				   NETFS_READ_HOLE_FAIL, NULL, NULL);
+		if (ret)
+			goto out;
+
+		done += subreq.len;
+	}
+out:
+	fscache_end_operation(cres);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
 };
 
-- 
2.27.0

