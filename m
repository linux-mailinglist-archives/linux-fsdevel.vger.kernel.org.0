Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FCD4CFEA3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 13:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242353AbiCGMeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 07:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242322AbiCGMeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:34:13 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7B33DA49;
        Mon,  7 Mar 2022 04:33:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6WEily_1646656393;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6WEily_1646656393)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:33:14 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/21] cachefiles: implement on-demand read
Date:   Mon,  7 Mar 2022 20:32:49 +0800
Message-Id: <20220307123305.79520-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
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

Implement the data plane of on-demand read mode.

A new NETFS_READ_HOLE_ONDEMAND flag is introduced to indicate that
on-demand read should be done when a cache miss encountered. In this
case, the read routine will send a READ request to user daemon, along
with the anonymous fd and the file range that shall be read. Now user
daemon is responsible for fetching data in the given file range, and
then writing the fetched data into cache file with the given anonymous
fd.

After sending the READ request, the read routine will hang there, until
the READ request is handled by user daemon. Then it will retry to read
from the same file range. If a cache miss is encountered again on the
same file range, the read routine will fail then.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c          | 98 +++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h        |  8 +++
 fs/cachefiles/io.c              | 11 ++++
 include/linux/netfs.h           |  1 +
 include/uapi/linux/cachefiles.h |  7 +++
 5 files changed, 125 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 72a21942aaf6..36ddf64d5e62 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -46,6 +46,7 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
 static void cachefiles_daemon_unbind(struct cachefiles_cache *);
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 static int cachefiles_ondemand_cinit(struct cachefiles_cache *, char *);
+static int cachefiles_ondemand_cread(struct cachefiles_cache *, char *);
 #endif
 
 static unsigned long cachefiles_open;
@@ -81,6 +82,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "tag",	cachefiles_daemon_tag		},
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	{ "cinit",	cachefiles_ondemand_cinit	},
+	{ "cread",	cachefiles_ondemand_cread	},
 #endif
 	{ "",		NULL				}
 };
@@ -139,6 +141,9 @@ bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, char *args)
 static int cachefiles_ondemand_fd_release(struct inode *inode, struct file *file)
 {
 	struct cachefiles_object *object = file->private_data;
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct cachefiles_req *req;
+	unsigned long index;
 
 	/*
 	 * Uninstall anon_fd to the cachefiles object, so that no further
@@ -146,6 +151,15 @@ static int cachefiles_ondemand_fd_release(struct inode *inode, struct file *file
 	 */
 	object->fd = -1;
 
+	/* complete all associated pending requests */
+	xa_for_each(&cache->reqs, index, req) {
+		if (req->object == object &&
+		    req->msg.opcode == CACHEFILES_OP_READ) {
+			req->error = -EIO;
+			complete(&req->done);
+		}
+	}
+
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
 	return 0;
 }
@@ -261,6 +275,36 @@ static int cachefiles_ondemand_cinit(struct cachefiles_cache *cache, char *args)
 	return ret;
 }
 
+/*
+ * Read request completion
+ * - command: "cread <id>"
+ */
+static int cachefiles_ondemand_cread(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+	unsigned long id;
+	int ret;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	if (!*args) {
+		pr_err("Empty id specified\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtoul(args, 0, &id);
+	if (ret)
+		return ret;
+
+	req = xa_erase(&cache->reqs, id);
+	if (!req)
+		return -EINVAL;
+
+	complete(&req->done);
+	return 0;
+}
+
 static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 {
 	struct cachefiles_init *init;
@@ -460,6 +504,60 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	return ret;
 }
 
+static struct cachefiles_req *
+cachefiles_alloc_read_req(struct cachefiles_object *object,
+			  loff_t pos, size_t len)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_read *read;
+	int fd = object->fd;
+
+	/* Stop enqueuig request when daemon closes anon_fd prematurely. */
+	if (WARN_ON_ONCE(fd == -1))
+		return NULL;
+
+	req = cachefiles_alloc_req(object, CACHEFILES_OP_READ, sizeof(*read));
+	if (!req)
+		return NULL;
+
+	read = (void *)&req->msg.data;
+	read->off = pos;
+	read->len = len;
+	read->fd  = fd;
+
+	return req;
+}
+
+int cachefiles_ondemand_read(struct cachefiles_object *object,
+			     loff_t pos, size_t len)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct cachefiles_req *req;
+	int ret;
+
+	ret = cachefiles_ondemand_check(cache);
+	if (ret)
+		return ret;
+
+	req = cachefiles_alloc_read_req(object, pos, len);
+	if (!req)
+		return -ENOMEM;
+
+	/*
+	 * 1) Checking object->fd and 2) enqueuing request into xarray, is not
+	 * atomic as a whole here. Thus similarly, when anon_fd is closed, it's
+	 * possible that a new request may be enqueued into xarray, after
+	 * associated requests in xarray have already been flushed. But it won't
+	 * cause infinite hang since user daemon will still fetch and handle
+	 * this request. And since the anon_fd has alrady been closed, any
+	 * following file operation with this anon_fd will fail in this case.
+	 */
+	ret = cachefiles_ondemand_send_req(cache, req);
+
+	kfree(req);
+	return ret;
+}
+
 #else
 static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache) {}
 static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache) {}
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 8450ebd77949..5f336ec15cea 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -167,6 +167,8 @@ extern const struct file_operations cachefiles_daemon_fops;
 
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
+extern int cachefiles_ondemand_read(struct cachefiles_object *object,
+				    loff_t pos, size_t len);
 
 #else
 static inline
@@ -174,6 +176,12 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 {
 	return 0;
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
index 8dbc1eb254a3..ee1283ba7a2c 100644
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
+				if (!cachefiles_ondemand_read(object, off, len)) {
+					/* fail the read if no progress achieved */
+					read_hole = NETFS_READ_HOLE_FAIL;
+					goto retry;
+				}
+
+				goto presubmission_error;
+			}
+
 			iov_iter_zero(len, iter);
 			skipped = len;
 			ret = 0;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 614f22213e21..2a9c50d3a928 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -203,6 +203,7 @@ enum netfs_read_from_hole {
 	NETFS_READ_HOLE_IGNORE,
 	NETFS_READ_HOLE_CLEAR,
 	NETFS_READ_HOLE_FAIL,
+	NETFS_READ_HOLE_ONDEMAND,
 };
 
 /*
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
index 759fb6693d75..88a78e9d001f 100644
--- a/include/uapi/linux/cachefiles.h
+++ b/include/uapi/linux/cachefiles.h
@@ -8,6 +8,7 @@
 
 enum cachefiles_opcode {
 	CACHEFILES_OP_INIT,
+	CACHEFILES_OP_READ,
 };
 
 /*
@@ -38,4 +39,10 @@ enum cachefiles_init_flags {
 
 #define CACHEFILES_INIT_FL_WANT_CACHE_SIZE	(1 << CACHEFILES_INIT_WANT_CACHE_SIZE)
 
+struct cachefiles_read {
+	__u64 off;
+	__u64 len;
+	__u32 fd;
+};
+
 #endif
-- 
2.27.0

