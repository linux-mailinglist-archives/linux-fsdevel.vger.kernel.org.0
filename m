Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD260F294
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 10:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiJ0Ig6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiJ0IgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:36:25 -0400
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE097D4C;
        Thu, 27 Oct 2022 01:36:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAlX3P_1666859759;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAlX3P_1666859759)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:36:00 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] fscache,netfs: move "fscache_" prefixed structures to fscache.h
Date:   Thu, 27 Oct 2022 16:35:47 +0800
Message-Id: <20221027083547.46933-10-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since all related structures has been transformed with "fscache_"
prefix, move all these structures to fscache.h as a final cleanup.

Besides, make netfs.h include fscache.h rather than the other way
around.  This is an intuitive change since libnetfs lives one layer
above fscache, accessing backing files with facache.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/afs/internal.h       |  2 +-
 fs/erofs/fscache.c      |  1 +
 fs/nfs/fscache.h        |  2 +-
 include/linux/fscache.h | 80 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/netfs.h   | 80 +----------------------------------------
 5 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 723d162078a3..5d1314265e3d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -14,7 +14,7 @@
 #include <linux/key.h>
 #include <linux/workqueue.h>
 #include <linux/sched.h>
-#include <linux/fscache.h>
+#include <linux/netfs.h>
 #include <linux/backing-dev.h>
 #include <linux/uuid.h>
 #include <linux/mm_types.h>
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index e30a42a35ae7..69531be66b28 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
 #include <linux/fscache.h>
+#include <linux/netfs.h>
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 2a37af880978..a0715f83a529 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -12,7 +12,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
-#include <linux/fscache.h>
+#include <linux/netfs.h>
 #include <linux/iversion.h>
 
 #ifdef CONFIG_NFS_FSCACHE
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 034d009c0de7..457226a396d2 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -15,7 +15,6 @@
 #define _LINUX_FSCACHE_H
 
 #include <linux/fs.h>
-#include <linux/netfs.h>
 #include <linux/writeback.h>
 #include <linux/pagemap.h>
 
@@ -151,6 +150,85 @@ struct fscache_cookie {
 #define FSCACHE_REQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define FSCACHE_REQ_ONDEMAND		1	/* Set if it's from on-demand read mode */
 
+enum fscache_io_source {
+	FSCACHE_FILL_WITH_ZEROES,
+	FSCACHE_DOWNLOAD_FROM_SERVER,
+	FSCACHE_READ_FROM_CACHE,
+	FSCACHE_INVALID_READ,
+} __mode(byte);
+
+typedef void (*fscache_io_terminated_t)(void *priv, ssize_t transferred_or_error,
+				      bool was_async);
+
+/*
+ * Resources required to do operations on a cache.
+ */
+struct fscache_resources {
+	const struct fscache_ops	*ops;
+	void				*cache_priv;
+	void				*cache_priv2;
+	unsigned int			debug_id;	/* Cookie debug ID */
+	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
+};
+
+/*
+ * How to handle reading from a hole.
+ */
+enum fscache_read_from_hole {
+	FSCACHE_READ_HOLE_IGNORE,
+	FSCACHE_READ_HOLE_CLEAR,
+	FSCACHE_READ_HOLE_FAIL,
+};
+
+/*
+ * Table of operations for access to a cache.  This is obtained by
+ * rreq->ops->begin_cache_operation().
+ */
+struct fscache_ops {
+	/* End an operation */
+	void (*end_operation)(struct fscache_resources *cres);
+
+	/* Read data from the cache */
+	int (*read)(struct fscache_resources *cres,
+		    loff_t start_pos,
+		    struct iov_iter *iter,
+		    enum fscache_read_from_hole read_hole,
+		    fscache_io_terminated_t term_func,
+		    void *term_func_priv);
+
+	/* Write data to the cache */
+	int (*write)(struct fscache_resources *cres,
+		     loff_t start_pos,
+		     struct iov_iter *iter,
+		     fscache_io_terminated_t term_func,
+		     void *term_func_priv);
+
+	/* Expand readahead request */
+	void (*expand_readahead)(struct fscache_resources *cres,
+				 loff_t *_start, size_t *_len, loff_t i_size);
+
+	/* Prepare a read operation, shortening it to a cached/uncached
+	 * boundary as appropriate.
+	 */
+	enum fscache_io_source (*prepare_read)(struct fscache_resources *cres,
+					     loff_t *_start, size_t *_len,
+					     unsigned long *_flags, loff_t i_size);
+
+	/* Prepare a write operation, working out what part of the write we can
+	 * actually do.
+	 */
+	int (*prepare_write)(struct fscache_resources *cres,
+			     loff_t *_start, size_t *_len, loff_t i_size,
+			     bool no_space_allocated_yet);
+
+	/* Query the occupancy of the cache in a region, returning where the
+	 * next chunk of data starts and how long it is.
+	 */
+	int (*query_occupancy)(struct fscache_resources *cres,
+			       loff_t start, size_t len, size_t granularity,
+			       loff_t *_data_start, size_t *_data_len);
+};
+
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 2ad4e1e88106..1977f953633a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -16,19 +16,10 @@
 
 #include <linux/workqueue.h>
 #include <linux/fs.h>
+#include <linux/fscache.h>
 
 enum netfs_sreq_ref_trace;
 
-enum fscache_io_source {
-	FSCACHE_FILL_WITH_ZEROES,
-	FSCACHE_DOWNLOAD_FROM_SERVER,
-	FSCACHE_READ_FROM_CACHE,
-	FSCACHE_INVALID_READ,
-} __mode(byte);
-
-typedef void (*fscache_io_terminated_t)(void *priv, ssize_t transferred_or_error,
-				      bool was_async);
-
 /*
  * Per-inode context.  This wraps the VFS inode.
  */
@@ -41,17 +32,6 @@ struct netfs_inode {
 	loff_t			remote_i_size;	/* Size of the remote file */
 };
 
-/*
- * Resources required to do operations on a cache.
- */
-struct fscache_resources {
-	const struct fscache_ops	*ops;
-	void				*cache_priv;
-	void				*cache_priv2;
-	unsigned int			debug_id;	/* Cookie debug ID */
-	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
-};
-
 /*
  * Descriptor for a single component subrequest.
  */
@@ -128,64 +108,6 @@ struct netfs_request_ops {
 	void (*done)(struct netfs_io_request *rreq);
 };
 
-/*
- * How to handle reading from a hole.
- */
-enum fscache_read_from_hole {
-	FSCACHE_READ_HOLE_IGNORE,
-	FSCACHE_READ_HOLE_CLEAR,
-	FSCACHE_READ_HOLE_FAIL,
-};
-
-/*
- * Table of operations for access to a cache.  This is obtained by
- * rreq->ops->begin_cache_operation().
- */
-struct fscache_ops {
-	/* End an operation */
-	void (*end_operation)(struct fscache_resources *cres);
-
-	/* Read data from the cache */
-	int (*read)(struct fscache_resources *cres,
-		    loff_t start_pos,
-		    struct iov_iter *iter,
-		    enum fscache_read_from_hole read_hole,
-		    fscache_io_terminated_t term_func,
-		    void *term_func_priv);
-
-	/* Write data to the cache */
-	int (*write)(struct fscache_resources *cres,
-		     loff_t start_pos,
-		     struct iov_iter *iter,
-		     fscache_io_terminated_t term_func,
-		     void *term_func_priv);
-
-	/* Expand readahead request */
-	void (*expand_readahead)(struct fscache_resources *cres,
-				 loff_t *_start, size_t *_len, loff_t i_size);
-
-	/* Prepare a read operation, shortening it to a cached/uncached
-	 * boundary as appropriate.
-	 */
-	enum fscache_io_source (*prepare_read)(struct fscache_resources *cres,
-					     loff_t *_start, size_t *_len,
-					     unsigned long *_flags, loff_t i_size);
-
-	/* Prepare a write operation, working out what part of the write we can
-	 * actually do.
-	 */
-	int (*prepare_write)(struct fscache_resources *cres,
-			     loff_t *_start, size_t *_len, loff_t i_size,
-			     bool no_space_allocated_yet);
-
-	/* Query the occupancy of the cache in a region, returning where the
-	 * next chunk of data starts and how long it is.
-	 */
-	int (*query_occupancy)(struct fscache_resources *cres,
-			       loff_t start, size_t len, size_t granularity,
-			       loff_t *_data_start, size_t *_data_len);
-};
-
 struct readahead_control;
 void netfs_readahead(struct readahead_control *);
 int netfs_read_folio(struct file *, struct folio *);
-- 
2.19.1.6.gb485710b

