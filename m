Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A160F282
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 10:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiJ0IgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 04:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiJ0IgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:36:05 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8728E714;
        Thu, 27 Oct 2022 01:36:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAl7c2_1666859756;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAl7c2_1666859756)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:57 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] fscache,netfs: define flags for prepare_read()
Date:   Thu, 27 Oct 2022 16:35:45 +0800
Message-Id: <20221027083547.46933-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
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

Decouple flags used in prepare_read() from netfs_io_subrequest flags to
make raw fscache APIs more neutral independent on libnetfs.  Currently
only *REQ_[COPY_TO_CACHE|ONDEMAND] flags are exposed to fscache, thus
define these two flags for fscache variant, while keep other
netfs_io_subrequest flags untouched.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c      | 10 +++++-----
 fs/erofs/fscache.c      |  5 +++--
 fs/netfs/io.c           | 14 ++++++++++----
 include/linux/fscache.h |  3 +++
 include/linux/netfs.h   |  1 -
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 9aace92a7503..a9c7463eb3e1 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -415,9 +415,9 @@ static enum fscache_io_source cachefiles_prepare_read(struct fscache_resources *
 	}
 
 	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
-		__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
+		__set_bit(FSCACHE_REQ_COPY_TO_CACHE, _flags);
 		why = cachefiles_trace_read_no_data;
-		if (!test_bit(NETFS_SREQ_ONDEMAND, _flags))
+		if (!test_bit(FSCACHE_REQ_ONDEMAND, _flags))
 			goto out_no_object;
 	}
 
@@ -487,11 +487,11 @@ static enum fscache_io_source cachefiles_prepare_read(struct fscache_resources *
 	goto out;
 
 download_and_store:
-	__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
-	if (test_bit(NETFS_SREQ_ONDEMAND, _flags)) {
+	__set_bit(FSCACHE_REQ_COPY_TO_CACHE, _flags);
+	if (test_bit(FSCACHE_REQ_ONDEMAND, _flags)) {
 		rc = cachefiles_ondemand_read(object, start, len);
 		if (!rc) {
-			__clear_bit(NETFS_SREQ_ONDEMAND, _flags);
+			__clear_bit(FSCACHE_REQ_ONDEMAND, _flags);
 			goto retry;
 		}
 		ret = FSCACHE_INVALID_READ;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 6fbdf067a669..e30a42a35ae7 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -148,6 +148,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 	struct iov_iter iter;
 	loff_t start = rreq->start;
 	size_t len = rreq->len;
+	unsigned long flags;
 	size_t done = 0;
 	int ret;
 
@@ -172,12 +173,12 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 
 		subreq->start = pstart + done;
 		subreq->len	=  len - done;
-		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
 
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 
+		flags = 1 << FSCACHE_REQ_ONDEMAND;
 		source = cres->ops->prepare_read(cres, &subreq->start,
-				&subreq->len, &subreq->flags, LLONG_MAX);
+				&subreq->len, &flags, LLONG_MAX);
 		if (WARN_ON(subreq->len == 0))
 			source = FSCACHE_INVALID_READ;
 		if (source != FSCACHE_READ_FROM_CACHE) {
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 7fd2627e259a..13ac74f2e32f 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -485,10 +485,16 @@ static enum fscache_io_source netfs_cache_prepare_read(struct netfs_io_subreques
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct fscache_resources *cres = &rreq->cache_resources;
-
-	if (cres->ops)
-		return cres->ops->prepare_read(cres, &subreq->start,
-				&subreq->len, &subreq->flags, i_size);
+	enum fscache_io_source source;
+	unsigned long flags = 0;
+
+	if (cres->ops) {
+		source = cres->ops->prepare_read(cres, &subreq->start,
+				&subreq->len, &flags, i_size);
+		if (test_bit(FSCACHE_REQ_COPY_TO_CACHE, &flags))
+			__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
+		return source;
+	}
 	if (subreq->start >= rreq->i_size)
 		return FSCACHE_FILL_WITH_ZEROES;
 	return FSCACHE_DOWNLOAD_FROM_SERVER;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index e955df30845b..9df2988be804 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -147,6 +147,9 @@ struct fscache_cookie {
 	};
 };
 
+#define FSCACHE_REQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
+#define FSCACHE_REQ_ONDEMAND		1	/* Set if it's from on-demand read mode */
+
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 91a4382cbd1f..146a13e6a9d2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -160,7 +160,6 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_SHORT_IO		2	/* Set if the I/O was short */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
-#define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
 };
 
 enum netfs_io_origin {
-- 
2.19.1.6.gb485710b

