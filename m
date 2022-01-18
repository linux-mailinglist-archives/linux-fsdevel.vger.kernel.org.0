Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9783D49268C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiARNMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:12:32 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41040 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242006AbiARNM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2CR7xi_1642511543;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2CR7xi_1642511543)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:24 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/20] cachefiles: introduce new devnode for on-demand read mode
Date:   Tue, 18 Jan 2022 21:12:02 +0800
Message-Id: <20220118131216.85338-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new devnode 'cachefiles_ondemand' to support the
newly introduced on-demand read mode.

The precondition for on-demand reading semantic is that, all blob files
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
   backing file. Then fscache will re-initiate a read request from the
   backing file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 127 +++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h |  22 +++++++
 fs/cachefiles/io.c       |  68 +++++++++++++++++++++
 fs/cachefiles/main.c     |  27 +++++++++
 4 files changed, 244 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa2e5e354afb..7af3e17e04c8 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -108,6 +108,10 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&cache->volumes);
 	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	idr_init(&cache->reqs);
+	set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+#endif
 
 	/* set default caching limits
 	 * - limit at 1% free space and/or free files
@@ -142,6 +146,9 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 	cachefiles_daemon_unbind(cache);
 
 	/* clean up the control file interface */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	idr_destroy(&cache->reqs);
+#endif
 	cache->cachefilesd = NULL;
 	file->private_data = NULL;
 	cachefiles_open = 0;
@@ -747,3 +754,123 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 
 	_leave("");
 }
+
+#ifdef CONFIG_CACHEFILES_ONDEMAND
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
+	.open		= cachefiles_daemon_open,
+	.release	= cachefiles_daemon_release,
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
+	int n, id = 0;
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags))
+		return 0;
+
+	idr_lock(&cache->reqs);
+	req = idr_get_next(&cache->reqs, &id);
+	idr_unlock(&cache->reqs);
+	if (!req)
+		return 0;
+
+	n = sizeof(req->req_in);
+	if (n > buflen)
+		return -EMSGSIZE;
+
+	if (copy_to_user(_buffer, &req->req_in, n) != 0)
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
+	if (!idr_is_empty(&cache->reqs))
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
+	idr_lock(&cache->reqs);
+	req = idr_remove(&cache->reqs, id);
+	idr_unlock(&cache->reqs);
+	if (!req)
+		return -EINVAL;
+
+	complete(&req->done);
+
+	return 0;
+}
+#endif
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2bb441197106..aa622b966802 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,7 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/idr.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -60,6 +61,20 @@ struct cachefiles_object {
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 };
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
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
+#endif
+
 /*
  * Cache files cache definition
  */
@@ -102,6 +117,10 @@ struct cachefiles_cache {
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	struct idr			reqs;
+#endif
 };
 
 #include <trace/events/cachefiles.h>
@@ -146,6 +165,9 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * daemon.c
  */
 extern const struct file_operations cachefiles_daemon_fops;
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+extern const struct file_operations cachefiles_ondemand_fops;
+#endif
 
 /*
  * error_inject.c
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 5da0bfd78188..f7418d02fde1 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -539,12 +539,80 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 	fscache_end_cookie_access(fscache_cres_cookie(cres), fscache_access_io_end);
 }
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
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
+	strncpy(req_in->path, object->d_name, sizeof(req_in->path) - 1);
+
+	init_completion(&req->done);
+
+	return req;
+}
+
+int cachefiles_ondemand_read(struct netfs_cache_resources *cres,
+			     loff_t start_pos, size_t len)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct cachefiles_req *req;
+	int ret;
+
+	object = cachefiles_cres_object(cres);
+	cache = object->volume->cache;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	req = cachefiles_alloc_req(object, start_pos, len);
+	if (!req)
+		return -ENOMEM;
+
+	idr_preload(GFP_KERNEL);
+	idr_lock(&cache->reqs);
+
+	ret = idr_alloc(&cache->reqs, req, 0, 0, GFP_ATOMIC);
+	if (ret >= 0)
+		req->req_in.id = ret;
+
+	idr_unlock(&cache->reqs);
+	idr_preload_end();
+
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
+#endif
+
 static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
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
-- 
2.27.0

