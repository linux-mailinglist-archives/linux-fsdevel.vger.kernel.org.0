Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FCB4B6A74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiBOLNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:13:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiBOLNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:13:50 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49532108180;
        Tue, 15 Feb 2022 03:13:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V4YJdH5_1644923615;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4YJdH5_1644923615)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Feb 2022 19:13:36 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/23] cachefiles: introduce new devnode for on-demand read mode
Date:   Tue, 15 Feb 2022 19:13:35 +0800
Message-Id: <20220215111335.123528-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
References: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
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

This patch introduces a new devnode 'cachefiles_ondemand' to support the
newly introduced on-demand read mode.

The precondition for on-demand reading semantics is that, all blob files
have been placed under corresponding directory with correct file size
(sparse files) on the first beginning. When upper fs starts to access
the blob file, it will "cache miss" (hit the hole) and then turn to user
daemon for preparing the data.

The interaction between kernel and user daemon is described as below.
1. Once cache miss, .ondemand_read() callback of corresponding fscache
   backend is called to prepare the data. As for cachefiles, it just
   packages related metadata (file range to read, etc.) into a pending
   read request, and then the process triggering cache miss will fall
   asleep until the corresponding data gets fetched later.
2. User daemon needs to poll on the devnode ('cachefiles_ondemand'),
   waiting for pending read request.
3. Once there's pending read request, user daemon will be notified and
   shall read the devnode ('cachefiles_ondemand') to fetch one pending
   read request to process.
4. For the fetched read request, user daemon need to somehow prepare the
   data (e.g. download from remote through network) and then write the
   fetched data into the backing file to fill the hole.
5. After that, user daemon need to notify cachefiles backend by writing a
   'done' command to devnode ('cachefiles_ondemand'). It will also
   awake the previous asleep process triggering cache miss.
6. By the time the process gets awaken, the data has been ready in the
   backing file. Then process can re-initiate a read request from the
   backing file.

If user daemon exits in advance when upper fs still mounted, no new
on-demand read request can be queued anymore and the existing pending
read requests will fail with -EIO.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c                   | 185 +++++++++++++++++++++++
 fs/cachefiles/internal.h                 |  12 ++
 fs/cachefiles/io.c                       |  64 ++++++++
 fs/cachefiles/main.c                     |  27 ++++
 include/uapi/linux/cachefiles_ondemand.h |  14 ++
 5 files changed, 302 insertions(+)
 create mode 100644 include/uapi/linux/cachefiles_ondemand.h

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 6b8d7c5bbe5d..96aee8e0eb14 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -757,3 +757,188 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 
 	_leave("");
 }
+
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static unsigned long cachefiles_open_ondemand;
+
+static int cachefiles_ondemand_open(struct inode *inode, struct file *file);
+static int cachefiles_ondemand_release(struct inode *inode, struct file *file);
+static ssize_t cachefiles_ondemand_write(struct file *, const char __user *,
+					 size_t, loff_t *);
+static ssize_t cachefiles_ondemand_read(struct file *, char __user *, size_t,
+					loff_t *);
+static __poll_t cachefiles_ondemand_poll(struct file *,
+					 struct poll_table_struct *);
+static int cachefiles_daemon_done(struct cachefiles_cache *, char *);
+
+const struct file_operations cachefiles_ondemand_fops = {
+	.owner		= THIS_MODULE,
+	.open		= cachefiles_ondemand_open,
+	.release	= cachefiles_ondemand_release,
+	.read		= cachefiles_ondemand_read,
+	.write		= cachefiles_ondemand_write,
+	.poll		= cachefiles_ondemand_poll,
+	.llseek		= noop_llseek,
+};
+
+static const struct cachefiles_daemon_cmd cachefiles_ondemand_cmds[] = {
+	{ "bind",	cachefiles_daemon_bind		},
+	{ "brun",	cachefiles_daemon_brun		},
+	{ "bcull",	cachefiles_daemon_bcull		},
+	{ "bstop",	cachefiles_daemon_bstop		},
+	{ "cull",	cachefiles_daemon_cull		},
+	{ "debug",	cachefiles_daemon_debug		},
+	{ "dir",	cachefiles_daemon_dir		},
+	{ "frun",	cachefiles_daemon_frun		},
+	{ "fcull",	cachefiles_daemon_fcull		},
+	{ "fstop",	cachefiles_daemon_fstop		},
+	{ "inuse",	cachefiles_daemon_inuse		},
+	{ "secctx",	cachefiles_daemon_secctx	},
+	{ "tag",	cachefiles_daemon_tag		},
+	{ "done",	cachefiles_daemon_done		},
+	{ "",		NULL				}
+};
+
+static int cachefiles_ondemand_open(struct inode *inode, struct file *file)
+{
+	struct cachefiles_cache *cache;
+
+	_enter("");
+
+	/* only the superuser may do this */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* the cachefiles device may only be open once at a time */
+	if (xchg(&cachefiles_open_ondemand, 1) == 1)
+		return -EBUSY;
+
+	cache = cachefiles_daemon_open_cache();
+	if (!cache) {
+		cachefiles_open_ondemand = 0;
+		return -ENOMEM;
+	}
+
+	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
+	set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+
+	file->private_data = cache;
+	cache->cachefilesd = file;
+	return 0;
+}
+
+static void cachefiles_ondemand_flush_reqs(struct cachefiles_cache *cache)
+{
+	struct cachefiles_req *req;
+	unsigned long index;
+
+	xa_for_each(&cache->reqs, index, req) {
+		req->error = -EIO;
+		complete(&req->done);
+	}
+}
+
+static int cachefiles_ondemand_release(struct inode *inode, struct file *file)
+{
+	struct cachefiles_cache *cache = file->private_data;
+
+	_enter("");
+
+	ASSERT(cache);
+
+	set_bit(CACHEFILES_DEAD, &cache->flags);
+
+	cachefiles_ondemand_flush_reqs(cache);
+	cachefiles_daemon_unbind(cache);
+
+	/* clean up the control file interface */
+	xa_destroy(&cache->reqs);
+	cache->cachefilesd = NULL;
+	file->private_data = NULL;
+	cachefiles_open_ondemand = 0;
+
+	kfree(cache);
+
+	_leave("");
+	return 0;
+}
+
+static ssize_t cachefiles_ondemand_write(struct file *file,
+					 const char __user *_data,
+					 size_t datalen,
+					 loff_t *pos)
+{
+	return cachefiles_daemon_do_write(file, _data, datalen, pos,
+					  cachefiles_ondemand_cmds);
+}
+
+static ssize_t cachefiles_ondemand_read(struct file *file, char __user *_buffer,
+					size_t buflen, loff_t *pos)
+{
+	struct cachefiles_cache *cache = file->private_data;
+	struct cachefiles_req *req;
+	unsigned long id = 0;
+	int n;
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags))
+		return 0;
+
+	req = xa_find(&cache->reqs, &id, UINT_MAX, XA_PRESENT);
+	if (!req)
+		return 0;
+
+	n = sizeof(struct cachefiles_req_in);
+	if (n > buflen)
+		return -EMSGSIZE;
+
+	req->base.id = id;
+	if (copy_to_user(_buffer, &req->base, n) != 0)
+		return -EFAULT;
+
+	return n;
+}
+
+static __poll_t cachefiles_ondemand_poll(struct file *file,
+					 struct poll_table_struct *poll)
+{
+	struct cachefiles_cache *cache = file->private_data;
+	__poll_t mask;
+
+	poll_wait(file, &cache->daemon_pollwq, poll);
+	mask = 0;
+
+	if (!xa_empty(&cache->reqs))
+		mask |= EPOLLIN;
+
+	return mask;
+}
+
+/*
+ * Request completion
+ * - command: "done <id>"
+ */
+static int cachefiles_daemon_done(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+	unsigned long id;
+	int ret;
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
+	req = xa_erase(&cache->reqs, id);
+	if (!req)
+		return -EINVAL;
+
+	complete(&req->done);
+	return 0;
+}
+#endif
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6473634c41a9..59dd11e42cb3 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,8 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/xarray.h>
+#include <linux/cachefiles_ondemand.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -102,6 +104,15 @@ struct cachefiles_cache {
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	struct xarray			reqs;
+#endif
+};
+
+struct cachefiles_req {
+	struct cachefiles_req_in base;
+	struct completion done;
+	int error;
 };
 
 #include <trace/events/cachefiles.h>
@@ -146,6 +157,7 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * daemon.c
  */
 extern const struct file_operations cachefiles_daemon_fops;
+extern const struct file_operations cachefiles_ondemand_fops;
 
 /*
  * error_inject.c
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 753986ea1583..7c51e53d52d1 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -597,6 +597,67 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 	fscache_end_cookie_access(fscache_cres_cookie(cres), fscache_access_io_end);
 }
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static struct cachefiles_req *cachefiles_alloc_req(struct cachefiles_object *object,
+						   loff_t start_pos,
+						   size_t len)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_req_in *base;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return NULL;
+
+	base = &req->base;
+
+	base->off = start_pos;
+	base->len = len;
+	strncpy(base->path, object->d_name, sizeof(base->path) - 1);
+
+	init_completion(&req->done);
+
+	return req;
+}
+
+static int cachefiles_ondemand_read(struct netfs_cache_resources *cres,
+				    loff_t start_pos, size_t len)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct cachefiles_req *req;
+	int ret;
+	u32 id;
+
+	object = cachefiles_cres_object(cres);
+	cache = object->volume->cache;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags))
+		return -EIO;
+
+	req = cachefiles_alloc_req(object, start_pos, len);
+	if (!req)
+		return -ENOMEM;
+
+	ret = xa_alloc(&cache->reqs, &id, req, xa_limit_32b, GFP_KERNEL);
+	if (ret) {
+		kfree(req);
+		return -ENOMEM;
+	}
+
+	wake_up_all(&cache->daemon_pollwq);
+
+	wait_for_completion(&req->done);
+	ret = req->error;
+	kfree(req);
+
+	return ret;
+}
+#endif
+
 static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
@@ -604,6 +665,9 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
 	.query_occupancy	= cachefiles_query_occupancy,
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	.ondemand_read		= cachefiles_ondemand_read,
+#endif
 };
 
 /*
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 3f369c6f816d..eab17c3140d9 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -39,6 +39,27 @@ static struct miscdevice cachefiles_dev = {
 	.fops	= &cachefiles_daemon_fops,
 };
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static struct miscdevice cachefiles_ondemand_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "cachefiles_ondemand",
+	.fops	= &cachefiles_ondemand_fops,
+};
+
+static inline int cachefiles_init_ondemand(void)
+{
+	return misc_register(&cachefiles_ondemand_dev);
+}
+
+static inline void cachefiles_exit_ondemand(void)
+{
+	misc_deregister(&cachefiles_ondemand_dev);
+}
+#else
+static inline int cachefiles_init_ondemand(void) { return 0; }
+static inline void cachefiles_exit_ondemand(void) {}
+#endif
+
 /*
  * initialise the fs caching module
  */
@@ -52,6 +73,9 @@ static int __init cachefiles_init(void)
 	ret = misc_register(&cachefiles_dev);
 	if (ret < 0)
 		goto error_dev;
+	ret = cachefiles_init_ondemand();
+	if (ret < 0)
+		goto error_ondemand_dev;
 
 	/* create an object jar */
 	ret = -ENOMEM;
@@ -68,6 +92,8 @@ static int __init cachefiles_init(void)
 	return 0;
 
 error_object_jar:
+	cachefiles_exit_ondemand();
+error_ondemand_dev:
 	misc_deregister(&cachefiles_dev);
 error_dev:
 	cachefiles_unregister_error_injection();
@@ -86,6 +112,7 @@ static void __exit cachefiles_exit(void)
 	pr_info("Unloading\n");
 
 	kmem_cache_destroy(cachefiles_object_jar);
+	cachefiles_exit_ondemand();
 	misc_deregister(&cachefiles_dev);
 	cachefiles_unregister_error_injection();
 }
diff --git a/include/uapi/linux/cachefiles_ondemand.h b/include/uapi/linux/cachefiles_ondemand.h
new file mode 100644
index 000000000000..e639a82f1098
--- /dev/null
+++ b/include/uapi/linux/cachefiles_ondemand.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_CACHEFILES_ONDEMAND_H
+#define _LINUX_CACHEFILES_ONDEMAND_H
+
+#include <linux/limits.h>
+
+struct cachefiles_req_in {
+	uint64_t id;
+	uint64_t off;
+	uint64_t len;
+	char path[NAME_MAX];
+};
+
+#endif
-- 
2.27.0

