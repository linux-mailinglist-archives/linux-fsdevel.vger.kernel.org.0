Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60794502A2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 14:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353721AbiDOMja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353568AbiDOMi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:38:59 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932061A06F;
        Fri, 15 Apr 2022 05:36:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VA7GjGJ_1650026182;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VA7GjGJ_1650026182)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 20:36:23 +0800
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
Subject: [PATCH v9 05/21] cachefiles: implement on-demand read
Date:   Fri, 15 Apr 2022 20:35:58 +0800
Message-Id: <20220415123614.54024-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the data plane of on-demand read mode.

The early implementation [1] place the entry to
cachefiles_ondemand_read() in fscache_read(). However, fscache_read()
can only detect if the requested file range is fully cache miss, whilst
we need to notify the user daemon as long as there's a hole inside the
requested file range.

Thus the entry is now placed in cachefiles_prepare_read(). When working
in on-demand read mode, once a hole detected, the read routine will send
a READ request to the user daemon. The user daemon needs to fetch the
data and write it to the cache file. After sending the READ request, the
read routine will hang there, until the READ request is handled by the
user daemon. Then it will retry to read from the same file range. If no
progress encountered, the read routine will fail then.

A new NETFS_SREQ_ONDEMAND flag is introduced to indicate that on-demand
read should be done when a cache miss encountered.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
[1] https://lore.kernel.org/all/20220406075612.60298-6-jefflexu@linux.alibaba.com/ #v8
---
 fs/cachefiles/internal.h        |  9 ++++
 fs/cachefiles/io.c              | 26 ++++++++++-
 fs/cachefiles/ondemand.c        | 77 +++++++++++++++++++++++++++++++++
 include/linux/netfs.h           |  2 +
 include/uapi/linux/cachefiles.h | 17 ++++++++
 5 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 15332eae43c0..3025556ff7d4 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -288,6 +288,9 @@ extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
+extern int cachefiles_ondemand_read(struct cachefiles_object *object,
+				    loff_t pos, size_t len);
+
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
@@ -303,6 +306,12 @@ static inline int cachefiles_ondemand_init_object(struct cachefiles_object *obje
 static inline void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 {
 }
+
+static inline int cachefiles_ondemand_read(struct cachefiles_object *object,
+					   loff_t pos, size_t len)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 50a14e8f0aac..ccf77a969653 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -95,6 +95,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
 
+retry:
 	/* If the caller asked us to seek for data before doing the read, then
 	 * we should do that now.  If we find a gap, we fill it with zeros.
 	 */
@@ -119,6 +120,16 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			if (read_hole == NETFS_READ_HOLE_FAIL)
 				goto presubmission_error;
 
+			if (read_hole == NETFS_READ_HOLE_ONDEMAND) {
+				ret = cachefiles_ondemand_read(object, off, len);
+				if (ret)
+					goto presubmission_error;
+
+				/* fail the read if no progress achieved */
+				read_hole = NETFS_READ_HOLE_FAIL;
+				goto retry;
+			}
+
 			iov_iter_zero(len, iter);
 			skipped = len;
 			ret = 0;
@@ -403,6 +414,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 	enum netfs_io_source ret = NETFS_DOWNLOAD_FROM_SERVER;
 	loff_t off, to;
 	ino_t ino = file ? file_inode(file)->i_ino : 0;
+	int rc;
 
 	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
 
@@ -415,7 +427,8 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
 		__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 		why = cachefiles_trace_read_no_data;
-		goto out_no_object;
+		if (!test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags))
+			goto out_no_object;
 	}
 
 	/* The object and the file may be being created in the background. */
@@ -432,7 +445,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 	object = cachefiles_cres_object(cres);
 	cache = object->volume->cache;
 	cachefiles_begin_secure(cache, &saved_cred);
-
+retry:
 	off = cachefiles_inject_read_error();
 	if (off == 0)
 		off = vfs_llseek(file, subreq->start, SEEK_DATA);
@@ -483,6 +496,15 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 
 download_and_store:
 	__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
+	if (test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags)) {
+		rc = cachefiles_ondemand_read(object, subreq->start,
+					      subreq->len);
+		if (!rc) {
+			__clear_bit(NETFS_SREQ_ONDEMAND, &subreq->flags);
+			goto retry;
+		}
+		ret = NETFS_INVALID_READ;
+	}
 out:
 	cachefiles_end_secure(cache, saved_cred);
 out_no_object:
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 7ce383536f27..10bdac26ce23 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -10,8 +10,25 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 	struct cachefiles_object *object = file->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	int object_id = object->ondemand_id;
+	struct cachefiles_req *req;
+	XA_STATE(xas, &cache->reqs, 0);
 
+	xa_lock(&cache->reqs);
 	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+
+	/*
+	 * Flush all pending READ requests since their completion depends on
+	 * anon_fd.
+	 */
+	xas_for_each(&xas, req, ULONG_MAX) {
+		if (req->msg.opcode == CACHEFILES_OP_READ) {
+			req->error = -EIO;
+			complete(&req->done);
+			xas_store(&xas, NULL);
+		}
+	}
+	xa_unlock(&cache->reqs);
+
 	xa_erase(&cache->ondemand_ids, object_id);
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
 	cachefiles_put_unbind_pincount(cache);
@@ -57,11 +74,35 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
 	return vfs_llseek(file, pos, whence);
 }
 
+static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
+					 unsigned long arg)
+{
+	struct cachefiles_object *object = filp->private_data;
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct cachefiles_req *req;
+	unsigned long id;
+
+	if (ioctl != CACHEFILES_IOC_CREAD)
+		return -EINVAL;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	id = arg;
+	req = xa_erase(&cache->reqs, id);
+	if (!req)
+		return -EINVAL;
+
+	complete(&req->done);
+	return 0;
+}
+
 static const struct file_operations cachefiles_ondemand_fd_fops = {
 	.owner		= THIS_MODULE,
 	.release	= cachefiles_ondemand_fd_release,
 	.write_iter	= cachefiles_ondemand_fd_write_iter,
 	.llseek		= cachefiles_ondemand_fd_llseek,
+	.unlocked_ioctl	= cachefiles_ondemand_fd_ioctl,
 };
 
 /*
@@ -381,6 +422,32 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	return 0;
 }
 
+struct cachefiles_read_ctx {
+	loff_t off;
+	size_t len;
+};
+
+static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
+					     void *private)
+{
+	struct cachefiles_object *object = req->object;
+	struct cachefiles_read *load = (void *)req->msg.data;
+	struct cachefiles_read_ctx *read_ctx = private;
+	int object_id = object->ondemand_id;
+
+	/* Stop enqueuing requests when daemon has closed anon_fd. */
+	if (object_id <= 0) {
+		WARN_ON_ONCE(object_id == 0);
+		pr_info_once("READ: anonymous fd closed prematurely.\n");
+		return -EIO;
+	}
+
+	req->msg.object_id = object_id;
+	load->off = read_ctx->off;
+	load->len = read_ctx->len;
+	return 0;
+}
+
 int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
@@ -410,3 +477,13 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
 			cachefiles_ondemand_init_close_req, NULL);
 }
+
+int cachefiles_ondemand_read(struct cachefiles_object *object,
+			     loff_t pos, size_t len)
+{
+	struct cachefiles_read_ctx read_ctx = {pos, len};
+
+	return cachefiles_ondemand_send_req(object, CACHEFILES_OP_READ,
+			sizeof(struct cachefiles_read),
+			cachefiles_ondemand_init_read_req, &read_ctx);
+}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c7bf1eaf51d5..02dbde48bb68 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -159,6 +159,7 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_SHORT_IO		2	/* Set if the I/O was short */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
+#define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
 };
 
 enum netfs_io_origin {
@@ -222,6 +223,7 @@ enum netfs_read_from_hole {
 	NETFS_READ_HOLE_IGNORE,
 	NETFS_READ_HOLE_CLEAR,
 	NETFS_READ_HOLE_FAIL,
+	NETFS_READ_HOLE_ONDEMAND,
 };
 
 /*
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
index 37a0071037c8..028fbf15e02b 100644
--- a/include/uapi/linux/cachefiles.h
+++ b/include/uapi/linux/cachefiles.h
@@ -3,6 +3,7 @@
 #define _LINUX_CACHEFILES_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
 
 /*
  * Fscache ensures that the maximum length of cookie key is 255. The volume key
@@ -13,6 +14,7 @@
 enum cachefiles_opcode {
 	CACHEFILES_OP_OPEN,
 	CACHEFILES_OP_CLOSE,
+	CACHEFILES_OP_READ,
 };
 
 /*
@@ -48,4 +50,19 @@ struct cachefiles_open {
 	__u8  data[];
 };
 
+/*
+ * @off		indicates the starting offset of the requested file range
+ * @len		indicates the length of the requested file range
+ */
+struct cachefiles_read {
+	__u64 off;
+	__u64 len;
+};
+
+/*
+ * Reply for READ request (Completion for READ)
+ * arg for CACHEFILES_IOC_CREAD ioctl is the @id field of READ request.
+ */
+#define CACHEFILES_IOC_CREAD	_IOW(0x98, 1, int)
+
 #endif
-- 
2.27.0

