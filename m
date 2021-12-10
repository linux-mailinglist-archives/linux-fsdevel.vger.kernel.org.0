Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B7846FBD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhLJHkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:46 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60414 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237860AbhLJHkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-80.qr_1639121801;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-80.qr_1639121801)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:42 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 18/19] cachefiles: support on demand read
Date:   Fri, 10 Dec 2021 15:36:18 +0800
Message-Id: <20211210073619.21667-19-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs can call cachefiles_demand_read() helper function to enqueue read
request for demand reading.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 148 +++++++++++++++++++++++++++------------
 fs/cachefiles/internal.h |  16 +++++
 fs/cachefiles/io.c       |  56 +++++++++++++++
 3 files changed, 175 insertions(+), 45 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 951963e72b44..7d174a39cd1c 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -44,6 +44,7 @@ static int cachefiles_daemon_tag(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_mode(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
 static void cachefiles_daemon_unbind(struct cachefiles_cache *);
+static int cachefiles_daemon_done(struct cachefiles_cache *, char *);
 
 static unsigned long cachefiles_open;
 
@@ -77,6 +78,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "secctx",	cachefiles_daemon_secctx	},
 	{ "tag",	cachefiles_daemon_tag		},
 	{ "mode",	cachefiles_daemon_mode		},
+	{ "done",	cachefiles_daemon_done		},
 	{ "",		NULL				}
 };
 
@@ -110,6 +112,8 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&cache->volumes);
 	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
+	idr_init(&cache->reqs);
+	spin_lock_init(&cache->reqs_lock);
 
 	/* set default caching limits
 	 * - limit at 1% free space and/or free files
@@ -144,6 +148,7 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 	cachefiles_daemon_unbind(cache);
 
 	/* clean up the control file interface */
+	idr_destroy(&cache->reqs);
 	cache->cachefilesd = NULL;
 	file->private_data = NULL;
 	cachefiles_open = 0;
@@ -164,6 +169,7 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
 	unsigned long long b_released;
 	unsigned f_released;
 	char buffer[256];
+	void *buf;
 	int n;
 
 	//_enter(",,%zu,", buflen);
@@ -171,38 +177,53 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
 	if (!test_bit(CACHEFILES_READY, &cache->flags))
 		return 0;
 
-	/* check how much space the cache has */
-	cachefiles_has_space(cache, 0, 0, cachefiles_has_space_check);
-
-	/* summarise */
-	f_released = atomic_xchg(&cache->f_released, 0);
-	b_released = atomic_long_xchg(&cache->b_released, 0);
-	clear_bit(CACHEFILES_STATE_CHANGED, &cache->flags);
-
-	n = snprintf(buffer, sizeof(buffer),
-		     "cull=%c"
-		     " frun=%llx"
-		     " fcull=%llx"
-		     " fstop=%llx"
-		     " brun=%llx"
-		     " bcull=%llx"
-		     " bstop=%llx"
-		     " freleased=%x"
-		     " breleased=%llx",
-		     test_bit(CACHEFILES_CULLING, &cache->flags) ? '1' : '0',
-		     (unsigned long long) cache->frun,
-		     (unsigned long long) cache->fcull,
-		     (unsigned long long) cache->fstop,
-		     (unsigned long long) cache->brun,
-		     (unsigned long long) cache->bcull,
-		     (unsigned long long) cache->bstop,
-		     f_released,
-		     b_released);
+	if (cache->mode == CACHEFILES_MODE_CACHE) {
+		/* check how much space the cache has */
+		cachefiles_has_space(cache, 0, 0, cachefiles_has_space_check);
+
+		/* summarise */
+		f_released = atomic_xchg(&cache->f_released, 0);
+		b_released = atomic_long_xchg(&cache->b_released, 0);
+		clear_bit(CACHEFILES_STATE_CHANGED, &cache->flags);
+
+		n = snprintf(buffer, sizeof(buffer),
+				"cull=%c"
+				" frun=%llx"
+				" fcull=%llx"
+				" fstop=%llx"
+				" brun=%llx"
+				" bcull=%llx"
+				" bstop=%llx"
+				" freleased=%x"
+				" breleased=%llx",
+				test_bit(CACHEFILES_CULLING, &cache->flags) ? '1' : '0',
+				(unsigned long long) cache->frun,
+				(unsigned long long) cache->fcull,
+				(unsigned long long) cache->fstop,
+				(unsigned long long) cache->brun,
+				(unsigned long long) cache->bcull,
+				(unsigned long long) cache->bstop,
+				f_released,
+				b_released);
+		buf = buffer;
+	} else {
+		struct cachefiles_req *req;
+		int id = 0;
+
+		spin_lock(&cache->reqs_lock);
+		req = idr_get_next(&cache->reqs, &id);
+		spin_unlock(&cache->reqs_lock);
+		if (!req)
+			return 0;
+
+		buf = &req->req_in;
+		n = sizeof(req->req_in);
+	}
 
 	if (n > buflen)
 		return -EMSGSIZE;
 
-	if (copy_to_user(_buffer, buffer, n) != 0)
+	if (copy_to_user(_buffer, buf, n) != 0)
 		return -EFAULT;
 
 	return n;
@@ -291,7 +312,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
  * - use EPOLLOUT to indicate culling state
  */
 static __poll_t cachefiles_daemon_poll(struct file *file,
-					   struct poll_table_struct *poll)
+				       struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
 	__poll_t mask;
@@ -299,11 +320,16 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
-	if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
-		mask |= EPOLLIN;
+	if (cache->mode == CACHEFILES_MODE_CACHE) {
+		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
+			mask |= EPOLLIN;
 
-	if (test_bit(CACHEFILES_CULLING, &cache->flags))
-		mask |= EPOLLOUT;
+		if (test_bit(CACHEFILES_CULLING, &cache->flags))
+			mask |= EPOLLOUT;
+	} else {
+		if(!idr_is_empty(&cache->reqs))
+			mask |= EPOLLIN;
+	}
 
 	return mask;
 }
@@ -313,7 +339,7 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
  * - can be tail-called
  */
 static int cachefiles_daemon_range_error(struct cachefiles_cache *cache,
-					 char *args)
+		char *args)
 {
 	pr_err("Free space limits must be in range 0%%<=stop<cull<run<100%%\n");
 
@@ -546,6 +572,38 @@ static int cachefiles_daemon_tag(struct cachefiles_cache *cache, char *args)
 	return 0;
 }
 
+/*
+ * Request completion
+ * - command: "done <id>"
+ */
+static int cachefiles_daemon_done(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long id;
+	int ret;
+	struct cachefiles_req *req;
+
+	_enter(",%s", args);
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
+	spin_lock(&cache->reqs_lock);
+	req = idr_remove(&cache->reqs, id);
+	spin_unlock(&cache->reqs_lock);
+	if (!req)
+		return -EINVAL;
+
+	complete(&req->done);
+
+	return 0;
+}
+
 /*
  * Request a node in the cache be culled from the current working directory
  * - command: "cull <name>"
@@ -704,22 +762,22 @@ static int cachefiles_daemon_mode(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 {
 	_enter("{%u,%u,%u,%u,%u,%u},%s",
-	       cache->frun_percent,
-	       cache->fcull_percent,
-	       cache->fstop_percent,
-	       cache->brun_percent,
-	       cache->bcull_percent,
-	       cache->bstop_percent,
-	       args);
+			cache->frun_percent,
+			cache->fcull_percent,
+			cache->fstop_percent,
+			cache->brun_percent,
+			cache->bcull_percent,
+			cache->bstop_percent,
+			args);
 
 	if (cache->fstop_percent >= cache->fcull_percent ||
-	    cache->fcull_percent >= cache->frun_percent ||
-	    cache->frun_percent  >= 100)
+			cache->fcull_percent >= cache->frun_percent ||
+			cache->frun_percent  >= 100)
 		return -ERANGE;
 
 	if (cache->bstop_percent >= cache->bcull_percent ||
-	    cache->bcull_percent >= cache->brun_percent ||
-	    cache->brun_percent  >= 100)
+			cache->bcull_percent >= cache->brun_percent ||
+			cache->brun_percent  >= 100)
 		return -ERANGE;
 
 	if (*args) {
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 1366e4319b4e..72e6e8744788 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,7 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/idr.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -65,6 +66,18 @@ enum cachefiles_mode {
 	CACHEFILES_MODE_DEMAND,	/* demand read for read-only fs */
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
@@ -107,6 +120,9 @@ struct cachefiles_cache {
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+
+	struct idr			reqs;
+	spinlock_t			reqs_lock;
 };
 
 #include <trace/events/cachefiles.h>
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 95e9107dc3bb..b4f6187f4022 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -540,12 +540,68 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
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

