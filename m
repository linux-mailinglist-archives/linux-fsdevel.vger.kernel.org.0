Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B630A60F269
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiJ0IgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 04:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiJ0If7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:35:59 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37DD8A7C8;
        Thu, 27 Oct 2022 01:35:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAsArv_1666859753;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAsArv_1666859753)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:54 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] fscache,netfs: rename netfs_read_from_hole as fscache_read_from_hole
Date:   Thu, 27 Oct 2022 16:35:42 +0800
Message-Id: <20221027083547.46933-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename netfs_read_from_hole as fscache_read_from_hole to make raw
fscache APIs more neutral independent on libnetfs.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c      |  6 +++---
 fs/cifs/fscache.c       |  2 +-
 fs/erofs/fscache.c      |  2 +-
 fs/netfs/io.c           |  6 +++---
 fs/nfs/fscache.c        |  2 +-
 include/linux/fscache.h |  8 ++++----
 include/linux/netfs.h   | 10 +++++-----
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 6931032b837c..2dce7af0fbcf 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -73,7 +73,7 @@ static void cachefiles_read_complete(struct kiocb *iocb, long ret)
 static int cachefiles_read(struct netfs_cache_resources *cres,
 			   loff_t start_pos,
 			   struct iov_iter *iter,
-			   enum netfs_read_from_hole read_hole,
+			   enum fscache_read_from_hole read_hole,
 			   fscache_io_terminated_t term_func,
 			   void *term_func_priv)
 {
@@ -98,7 +98,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	/* If the caller asked us to seek for data before doing the read, then
 	 * we should do that now.  If we find a gap, we fill it with zeros.
 	 */
-	if (read_hole != NETFS_READ_HOLE_IGNORE) {
+	if (read_hole != FSCACHE_READ_HOLE_IGNORE) {
 		loff_t off = start_pos, off2;
 
 		off2 = cachefiles_inject_read_error();
@@ -116,7 +116,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			 * return success.
 			 */
 			ret = -ENODATA;
-			if (read_hole == NETFS_READ_HOLE_FAIL)
+			if (read_hole == FSCACHE_READ_HOLE_FAIL)
 				goto presubmission_error;
 
 			iov_iter_zero(len, iter);
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index a1751b956318..3145e0993313 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -156,7 +156,7 @@ static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 	if (ret < 0)
 		return ret;
 
-	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
+	ret = fscache_read(&cres, page_offset(page), &iter, FSCACHE_READ_HOLE_FAIL,
 			   NULL, NULL);
 	fscache_end_operation(&cres);
 	return ret;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bf216478afa2..1cc0437eab50 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -195,7 +195,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 				start + done, subreq->len);
 
 		ret = fscache_read(cres, subreq->start, &iter,
-				   NETFS_READ_HOLE_FAIL,
+				   FSCACHE_READ_HOLE_FAIL,
 				   erofc_fscache_subreq_complete, subreq);
 		if (ret == -EIOCBQUEUED)
 			ret = 0;
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 992f3eebd2ee..2fc211376dc2 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -43,7 +43,7 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
  */
 static void netfs_read_from_cache(struct netfs_io_request *rreq,
 				  struct netfs_io_subrequest *subreq,
-				  enum netfs_read_from_hole read_hole)
+				  enum fscache_read_from_hole read_hole)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct iov_iter iter;
@@ -251,7 +251,7 @@ static void netfs_rreq_short_read(struct netfs_io_request *rreq,
 	netfs_get_subrequest(subreq, netfs_sreq_trace_get_short_read);
 	atomic_inc(&rreq->nr_outstanding);
 	if (subreq->source == FSCACHE_READ_FROM_CACHE)
-		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
+		netfs_read_from_cache(rreq, subreq, FSCACHE_READ_HOLE_CLEAR);
 	else
 		netfs_read_from_server(rreq, subreq);
 }
@@ -580,7 +580,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 		netfs_read_from_server(rreq, subreq);
 		break;
 	case FSCACHE_READ_FROM_CACHE:
-		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_IGNORE);
+		netfs_read_from_cache(rreq, subreq, FSCACHE_READ_HOLE_IGNORE);
 		break;
 	default:
 		BUG();
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index e861d7bae305..509236f8b750 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -258,7 +258,7 @@ static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 	if (ret < 0)
 		return ret;
 
-	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
+	ret = fscache_read(&cres, page_offset(page), &iter, FSCACHE_READ_HOLE_FAIL,
 			   NULL, NULL);
 	fscache_end_operation(&cres);
 	return ret;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index ee8e14f142e8..80455e00c520 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -496,18 +496,18 @@ static inline void fscache_end_operation(struct netfs_cache_resources *cres)
  * @read_hole indicates how a partially populated region in the cache should be
  * handled.  It can be one of a number of settings:
  *
- *	NETFS_READ_HOLE_IGNORE - Just try to read (may return a short read).
+ *	FSCACHE_READ_HOLE_IGNORE - Just try to read (may return a short read).
  *
- *	NETFS_READ_HOLE_CLEAR - Seek for data, clearing the part of the buffer
+ *	FSCACHE_READ_HOLE_CLEAR - Seek for data, clearing the part of the buffer
  *				skipped over, then do as for IGNORE.
  *
- *	NETFS_READ_HOLE_FAIL - Give ENODATA if we encounter a hole.
+ *	FSCACHE_READ_HOLE_FAIL - Give ENODATA if we encounter a hole.
  */
 static inline
 int fscache_read(struct netfs_cache_resources *cres,
 		 loff_t start_pos,
 		 struct iov_iter *iter,
-		 enum netfs_read_from_hole read_hole,
+		 enum fscache_read_from_hole read_hole,
 		 fscache_io_terminated_t term_func,
 		 void *term_func_priv)
 {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 2cac478607a8..998402e34c00 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -221,10 +221,10 @@ struct netfs_request_ops {
 /*
  * How to handle reading from a hole.
  */
-enum netfs_read_from_hole {
-	NETFS_READ_HOLE_IGNORE,
-	NETFS_READ_HOLE_CLEAR,
-	NETFS_READ_HOLE_FAIL,
+enum fscache_read_from_hole {
+	FSCACHE_READ_HOLE_IGNORE,
+	FSCACHE_READ_HOLE_CLEAR,
+	FSCACHE_READ_HOLE_FAIL,
 };
 
 /*
@@ -239,7 +239,7 @@ struct netfs_cache_ops {
 	int (*read)(struct netfs_cache_resources *cres,
 		    loff_t start_pos,
 		    struct iov_iter *iter,
-		    enum netfs_read_from_hole read_hole,
+		    enum fscache_read_from_hole read_hole,
 		    fscache_io_terminated_t term_func,
 		    void *term_func_priv);
 
-- 
2.19.1.6.gb485710b

