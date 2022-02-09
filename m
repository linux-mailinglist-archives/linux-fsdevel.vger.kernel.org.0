Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26B44AE9E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 07:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiBIGFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 01:05:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiBIGB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:01:26 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA3C033267;
        Tue,  8 Feb 2022 22:01:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V3zaQT8_1644386484;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V3zaQT8_1644386484)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 14:01:25 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/22] erofs: add erofs_fscache_read_page() helper
Date:   Wed,  9 Feb 2022 14:00:58 +0800
Message-Id: <20220209060108.43051-13-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add erofs_fscache_read_page() helper reading from fscache. It supports
on-demand read semantics. That is, it will make the backend prepare for
the data when cache miss. Once data ready, it will reinitiate a read
from the cache.

This helper can then be used to implement .readpage() of on-demand
reading semantics.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 3addd9aa549c..f4aade711664 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,42 @@
 
 static struct fscache_volume *volume;
 
+static int erofs_fscache_read_page(struct fscache_cookie *cookie,
+				   struct page *page, loff_t start_pos)
+{
+	struct netfs_cache_resources cres;
+	struct bio_vec bvec[1];
+	struct iov_iter iter;
+	int ret;
+
+	memset(&cres, 0, sizeof(cres));
+
+	ret = fscache_begin_read_operation(&cres, cookie);
+	if (ret)
+		return ret;
+
+	bvec[0].bv_page         = page;
+	bvec[0].bv_offset       = 0;
+	bvec[0].bv_len          = PAGE_SIZE;
+	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = fscache_read(&cres, start_pos, &iter,
+			   NETFS_READ_HOLE_FAIL, NULL, NULL);
+	/*
+	 * -ENODATA will be returned when cache miss. In this case, make the
+	 * backend prepare for the data and then reinitiate a read from cache.
+	 */
+	if (ret == -ENODATA) {
+		ret = fscache_ondemand_read(&cres, start_pos, PAGE_SIZE);
+		if (ret == 0)
+			ret = fscache_read(&cres, start_pos, &iter,
+					   NETFS_READ_HOLE_FAIL, NULL, NULL);
+	}
+
+	fscache_end_operation(&cres);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
 };
 
-- 
2.27.0

