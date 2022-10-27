Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8960F274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiJ0IgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 04:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiJ0IgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:36:01 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A33A8E7A9;
        Thu, 27 Oct 2022 01:35:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAtIeX_1666859754;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAtIeX_1666859754)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:55 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] fscache,netfs: rename netfs_cache_ops as fscache_ops
Date:   Thu, 27 Oct 2022 16:35:43 +0800
Message-Id: <20221027083547.46933-6-jefflexu@linux.alibaba.com>
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

Rename netfs_cache_ops as fscache_ops to make raw fscache APIs more
neutral independent on libnetfs.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c      | 4 ++--
 include/linux/fscache.h | 8 ++++----
 include/linux/netfs.h   | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 2dce7af0fbcf..ff4d8a309d51 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -617,7 +617,7 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 	fscache_end_cookie_access(fscache_cres_cookie(cres), fscache_access_io_end);
 }
 
-static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
+static const struct fscache_ops cachefiles_fscache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
@@ -635,7 +635,7 @@ bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 	struct cachefiles_object *object = cachefiles_cres_object(cres);
 
 	if (!cachefiles_cres_file(cres)) {
-		cres->ops = &cachefiles_netfs_cache_ops;
+		cres->ops = &cachefiles_fscache_ops;
 		if (object->file) {
 			spin_lock(&object->lock);
 			if (!cres->cache_priv2 && object->file)
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 80455e00c520..d6546dc714b8 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -423,7 +423,7 @@ void fscache_invalidate(struct fscache_cookie *cookie,
  * Returns a pointer to the operations table if usable or NULL if not.
  */
 static inline
-const struct netfs_cache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
+const struct fscache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
 {
 	return fscache_resources_valid(cres) ? cres->ops : NULL;
 }
@@ -466,7 +466,7 @@ int fscache_begin_read_operation(struct netfs_cache_resources *cres,
  */
 static inline void fscache_end_operation(struct netfs_cache_resources *cres)
 {
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	const struct fscache_ops *ops = fscache_operation_valid(cres);
 
 	if (ops)
 		ops->end_operation(cres);
@@ -511,7 +511,7 @@ int fscache_read(struct netfs_cache_resources *cres,
 		 fscache_io_terminated_t term_func,
 		 void *term_func_priv)
 {
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	const struct fscache_ops *ops = fscache_operation_valid(cres);
 	return ops->read(cres, start_pos, iter, read_hole,
 			 term_func, term_func_priv);
 }
@@ -569,7 +569,7 @@ int fscache_write(struct netfs_cache_resources *cres,
 		  fscache_io_terminated_t term_func,
 		  void *term_func_priv)
 {
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	const struct fscache_ops *ops = fscache_operation_valid(cres);
 	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
 }
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 998402e34c00..2ff3a65458a6 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -134,7 +134,7 @@ struct netfs_inode {
  * Resources required to do operations on a cache.
  */
 struct netfs_cache_resources {
-	const struct netfs_cache_ops	*ops;
+	const struct fscache_ops	*ops;
 	void				*cache_priv;
 	void				*cache_priv2;
 	unsigned int			debug_id;	/* Cookie debug ID */
@@ -231,7 +231,7 @@ enum fscache_read_from_hole {
  * Table of operations for access to a cache.  This is obtained by
  * rreq->ops->begin_cache_operation().
  */
-struct netfs_cache_ops {
+struct fscache_ops {
 	/* End an operation */
 	void (*end_operation)(struct netfs_cache_resources *cres);
 
-- 
2.19.1.6.gb485710b

