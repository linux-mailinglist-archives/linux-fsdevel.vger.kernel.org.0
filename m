Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0434C47FCEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhL0MzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:17 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49200 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236957AbhL0MzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.w7GZ4_1640609706;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.w7GZ4_1640609706)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:07 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand read
Date:   Mon, 27 Dec 2021 20:54:40 +0800
Message-Id: <20211227125444.21187-20-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement .demand_read() callback for cachefiels backend.

.demand_read() callback is responsible for notifying user daemon the
pending request to process, and will get blocked until user daemon has
prepared data and filled the hole.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h | 12 +++++++++
 fs/cachefiles/io.c       | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index af8ac8107f77..eeb6ad7dcd49 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -61,6 +61,18 @@ struct cachefiles_object {
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 };
 
+struct cachefiles_req_in {
+	uint64_t id;
+	uint64_t off;
+	uint64_t len;
+	char path[NAME_MAX];
+};
+
+struct cachefiles_req {
+	struct completion done;
+	struct cachefiles_req_in req_in;
+};
+
 /*
  * Cache files cache definition
  */
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 60b1eac2ce78..376603e5ed99 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -539,12 +539,68 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 	fscache_end_cookie_access(fscache_cres_cookie(cres), fscache_access_io_end);
 }
 
+static struct cachefiles_req *cachefiles_alloc_req(struct cachefiles_object *object,
+						   loff_t start_pos,
+						   size_t len)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_req_in *req_in;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return NULL;
+
+	req_in = &req->req_in;
+
+	req_in->off = start_pos;
+	req_in->len = len;
+	strncpy(req_in->path, object->d_name, sizeof(req_in->path));
+
+	init_completion(&req->done);
+
+	return req;
+}
+
+int cachefiles_demand_read(struct netfs_cache_resources *cres,
+			   loff_t start_pos, size_t len)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct cachefiles_req *req;
+	int ret;
+
+	object = cachefiles_cres_object(cres);
+	cache = object->volume->cache;
+
+	req = cachefiles_alloc_req(object, start_pos, len);
+	if (!req)
+		return -ENOMEM;
+
+	spin_lock(&cache->reqs_lock);
+	ret = idr_alloc(&cache->reqs, req, 0, 0, GFP_KERNEL);
+	if (ret >= 0)
+		req->req_in.id = ret;
+	spin_unlock(&cache->reqs_lock);
+	if (ret < 0) {
+		kfree(req);
+		return -ENOMEM;
+	}
+
+	wake_up_all(&cache->daemon_pollwq);
+
+	wait_for_completion(&req->done);
+	kfree(req);
+
+	return 0;
+}
+
 static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.demand_read		= cachefiles_demand_read,
 };
 
 /*
-- 
2.27.0

