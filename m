Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24C4F5DA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiDFMOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiDFMOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:14:01 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115A35A87;
        Wed,  6 Apr 2022 00:56:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9LC82N_1649231777;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9LC82N_1649231777)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 15:56:18 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v8 03/20] cachefiles: notify user daemon with anon_fd when looking up cookie
Date:   Wed,  6 Apr 2022 15:55:55 +0800
Message-Id: <20220406075612.60298-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fscache/cachefiles used to serve as a local cache for remote fs. This
patch, along with the following patches, introduces a new on-demand read
mode for cachefiles, which can boost the scenario where on-demand read
semantics is needed, e.g. container image distribution.

The essential difference between the original mode and on-demand read
mode is that, in the original mode, when cache miss, netfs itself will
fetch data from remote, and then write the fetched data into cache file.
While in on-demand read mode, a user daemon is responsible for fetching
data and then writing to the cache file.

As the first step, notify user daemon with anon_fd when looking up
cookie.

Send the anonymous fd to user daemon when looking up cookie, no matter
whether the cache file exists there or not. With the given anonymous fd,
user daemon can fetch and then write data into cache file in advance,
even when cache miss has not happened yet.

Also add one advisory flag (FSCACHE_ADV_WANT_CACHE_SIZE) suggesting that
cache file size shall be retrieved at runtime. This helps the scenario
where one cache file can contain multiple netfs files for the purpose of
deduplication, e.g. In this case, netfs itself has no idea the cache
file size, whilst user daemon needs to offer the hint on the cache file
size.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/Kconfig             |  11 +
 fs/cachefiles/Makefile            |   1 +
 fs/cachefiles/daemon.c            |  77 +++++--
 fs/cachefiles/internal.h          |  43 ++++
 fs/cachefiles/namei.c             |  16 +-
 fs/cachefiles/ondemand.c          | 360 ++++++++++++++++++++++++++++++
 include/linux/fscache.h           |   1 +
 include/trace/events/cachefiles.h |   2 +
 include/uapi/linux/cachefiles.h   |  49 ++++
 9 files changed, 545 insertions(+), 15 deletions(-)
 create mode 100644 fs/cachefiles/ondemand.c
 create mode 100644 include/uapi/linux/cachefiles.h

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 719faeeda168..58aad1fb4c5c 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -26,3 +26,14 @@ config CACHEFILES_ERROR_INJECTION
 	help
 	  This permits error injection to be enabled in cachefiles whilst a
 	  cache is in service.
+
+config CACHEFILES_ONDEMAND
+	bool "Support for on-demand read"
+	depends on CACHEFILES
+	default n
+	help
+	  This permits on-demand read mode of cachefiles. In this mode, when
+	  cache miss, the cachefiles backend instead of netfs, is responsible
+          for fetching data, e.g. through user daemon.
+
+	  If unsure, say N.
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 16d811f1a2fa..c37a7a9af10b 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -16,5 +16,6 @@ cachefiles-y := \
 	xattr.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
+cachefiles-$(CONFIG_CACHEFILES_ONDEMAND) += ondemand.o
 
 obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 7ac04ee2c0a0..d155a6da90d3 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -75,6 +75,9 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "inuse",	cachefiles_daemon_inuse		},
 	{ "secctx",	cachefiles_daemon_secctx	},
 	{ "tag",	cachefiles_daemon_tag		},
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	{ "copen",	cachefiles_ondemand_copen	},
+#endif
 	{ "",		NULL				}
 };
 
@@ -108,6 +111,9 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&cache->volumes);
 	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
+#endif
 
 	/* set default caching limits
 	 * - limit at 1% free space and/or free files
@@ -126,6 +132,27 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static inline void cachefiles_flush_reqs(struct cachefiles_cache *cache)
+{
+	struct xarray *xa = &cache->reqs;
+	struct cachefiles_req *req;
+	unsigned long index;
+
+	/*
+	 * 1) Cache has been marked as dead state, and then 2) flush all
+	 * pending requests in @reqs xarray. The barrier inside set_bit()
+	 * will ensure that above two ops won't be reordered.
+	 */
+	xa_lock(xa);
+	xa_for_each(xa, index, req) {
+		req->error = -EIO;
+		complete(&req->done);
+	}
+	xa_unlock(xa);
+}
+#endif
+
 /*
  * Release a cache.
  */
@@ -139,6 +166,11 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 
 	set_bit(CACHEFILES_DEAD, &cache->flags);
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	cachefiles_flush_reqs(cache);
+	xa_destroy(&cache->reqs);
+#endif
+
 	cachefiles_daemon_unbind(cache);
 
 	/* clean up the control file interface */
@@ -152,23 +184,14 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-/*
- * Read the cache state.
- */
-static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
-				      size_t buflen, loff_t *pos)
+static ssize_t cachefiles_do_daemon_read(struct cachefiles_cache *cache,
+					 char __user *_buffer, size_t buflen)
 {
-	struct cachefiles_cache *cache = file->private_data;
 	unsigned long long b_released;
 	unsigned f_released;
 	char buffer[256];
 	int n;
 
-	//_enter(",,%zu,", buflen);
-
-	if (!test_bit(CACHEFILES_READY, &cache->flags))
-		return 0;
-
 	/* check how much space the cache has */
 	cachefiles_has_space(cache, 0, 0, cachefiles_has_space_check);
 
@@ -206,6 +229,26 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
 	return n;
 }
 
+/*
+ * Read the cache state.
+ */
+static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
+				      size_t buflen, loff_t *pos)
+{
+	struct cachefiles_cache *cache = file->private_data;
+
+	//_enter(",,%zu,", buflen);
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
+	    test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return cachefiles_ondemand_daemon_read(cache, _buffer, buflen);
+	else
+		return cachefiles_do_daemon_read(cache, _buffer, buflen);
+}
+
 /*
  * Take a command from cachefilesd, parse it and act on it.
  */
@@ -297,8 +340,16 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
-	if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
-		mask |= EPOLLIN;
+	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
+	    test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)) {
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+		if (!xa_empty(&cache->reqs))
+			mask |= EPOLLIN;
+#endif
+	} else {
+		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
+			mask |= EPOLLIN;
+	}
 
 	if (test_bit(CACHEFILES_CULLING, &cache->flags))
 		mask |= EPOLLOUT;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e80673d0ab97..7d5c7d391fdb 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,8 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/xarray.h>
+#include <linux/cachefiles.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -58,6 +60,9 @@ struct cachefiles_object {
 	enum cachefiles_content		content_info:8;	/* Info about content presence */
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	int				fd;		/* anonymous fd */
+#endif
 };
 
 /*
@@ -98,11 +103,24 @@ struct cachefiles_cache {
 #define CACHEFILES_DEAD			1	/* T if cache dead */
 #define CACHEFILES_CULLING		2	/* T if cull engaged */
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+#define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	struct xarray			reqs;		/* xarray of pending on-demand requests */
+#endif
 };
 
+struct cachefiles_req {
+	struct cachefiles_object *object;
+	struct completion done;
+	int error;
+	struct cachefiles_msg msg;
+};
+
+#define CACHEFILES_REQ_NEW	XA_MARK_1
+
 #include <trace/events/cachefiles.h>
 
 static inline
@@ -250,6 +268,31 @@ extern struct file *cachefiles_create_tmpfile(struct cachefiles_object *object);
 extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 				      struct cachefiles_object *object);
 
+/*
+ * ondemand.c
+ */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
+					char __user *_buffer, size_t buflen);
+
+extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
+				     char *args);
+
+extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
+
+#else
+static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
+					char __user *_buffer, size_t buflen)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int cachefiles_ondemand_init_object(struct cachefiles_object *object)
+{
+	return 0;
+}
+#endif
+
 /*
  * security.c
  */
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index fe1bab0f36d4..68213304e96b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -452,10 +452,9 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
 	struct file *file;
 	struct path path;
-	uint64_t ni_size = object->cookie->object_size;
+	uint64_t ni_size;
 	long ret;
 
-	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 
 	cachefiles_begin_secure(cache, &saved_cred);
 
@@ -481,6 +480,15 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		goto out_dput;
 	}
 
+	ret = cachefiles_ondemand_init_object(object);
+	if (ret < 0) {
+		file = ERR_PTR(ret);
+		goto out_unuse;
+	}
+
+	ni_size = object->cookie->object_size;
+	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
+
 	if (ni_size > 0) {
 		trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
 				       cachefiles_trunc_expand_tmpfile);
@@ -586,6 +594,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	}
 	_debug("file -> %pd positive", dentry);
 
+	ret = cachefiles_ondemand_init_object(object);
+	if (ret < 0)
+		goto error_fput;
+
 	ret = cachefiles_check_auxdata(object, file);
 	if (ret < 0)
 		goto check_failed;
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
new file mode 100644
index 000000000000..75180d02af91
--- /dev/null
+++ b/fs/cachefiles/ondemand.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022, Alibaba Cloud
+ */
+#include <linux/fdtable.h>
+#include <linux/anon_inodes.h>
+#include <linux/uio.h>
+#include "internal.h"
+
+static int cachefiles_ondemand_fd_release(struct inode *inode,
+					  struct file *file)
+{
+	struct cachefiles_object *object = file->private_data;
+
+	/*
+	 * Uninstall anon_fd to the cachefiles object, so that no further
+	 * associated requests will get enqueued.
+	 */
+	object->fd = -1;
+
+	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
+	return 0;
+}
+
+static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
+						 struct iov_iter *iter)
+{
+	struct cachefiles_object *object = kiocb->ki_filp->private_data;
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct file *file = object->file;
+	size_t len = iter->count;
+	loff_t pos = kiocb->ki_pos;
+	const struct cred *saved_cred;
+	int ret;
+
+	if (!file)
+		return -ENOBUFS;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = __cachefiles_prepare_write(object, file, &pos, &len, true);
+	cachefiles_end_secure(cache, saved_cred);
+	if (ret < 0)
+		return ret;
+
+	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
+	if (!ret)
+		ret = len;
+
+	return ret;
+}
+
+static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
+					    int whence)
+{
+	struct cachefiles_object *object = filp->private_data;
+	struct file *file = object->file;
+
+	if (!file)
+		return -ENOBUFS;
+
+	return vfs_llseek(file, pos, whence);
+}
+
+static const struct file_operations cachefiles_ondemand_fd_fops = {
+	.owner		= THIS_MODULE,
+	.release	= cachefiles_ondemand_fd_release,
+	.write_iter	= cachefiles_ondemand_fd_write_iter,
+	.llseek		= cachefiles_ondemand_fd_llseek,
+};
+
+/*
+ * OPEN request Completion (copen)
+ * - command: "copen <id>,<cache_size>"
+ *   <cache_size> represents the object size if >=0, error code if negative
+ */
+int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+	struct fscache_cookie *cookie;
+	char *pid, *psize;
+	unsigned long id;
+	long size;
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
+	pid = args;
+	psize = strchr(args, ',');
+	if (!psize) {
+		pr_err("Cache size is not specified\n");
+		return -EINVAL;
+	}
+
+	*psize = 0;
+	psize++;
+
+	ret = kstrtoul(pid, 0, &id);
+	if (ret)
+		return ret;
+
+	req = xa_erase(&cache->reqs, id);
+	if (!req)
+		return -EINVAL;
+
+	/* fail OPEN request if copen format is invalid */
+	ret = kstrtol(psize, 0, &size);
+	if (ret) {
+		req->error = ret;
+		goto out;
+	}
+
+	/* fail OPEN request if daemon reports an error */
+	if (size < 0) {
+		if (!IS_ERR_VALUE(size))
+			size = -EINVAL;
+		req->error = size;
+		goto out;
+	}
+
+	cookie = req->object->cookie;
+	cookie->object_size = size;
+	if (size)
+		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	else
+		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+
+out:
+	complete(&req->done);
+	return ret;
+}
+
+static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_open *load;
+	struct file *file;
+	int ret, fd;
+
+	ret = get_unused_fd_flags(O_WRONLY);
+	if (ret < 0)
+		return ret;
+	fd = ret;
+
+	object = cachefiles_grab_object(req->object,
+			cachefiles_obj_get_ondemand_fd);
+
+	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
+				object, O_WRONLY);
+	if (IS_ERR(file)) {
+		cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
+		put_unused_fd(fd);
+		return PTR_ERR(file);
+	}
+
+	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
+	fd_install(fd, file);
+
+	load = (void *)req->msg.data;
+	load->fd = fd;
+	object->fd = fd;
+
+	return 0;
+}
+
+ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
+					char __user *_buffer, size_t buflen)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_msg *msg;
+	unsigned long id = 0;
+	size_t n;
+	int ret = 0;
+	XA_STATE(xas, &cache->reqs, 0);
+
+	/*
+	 * Search for request that has not ever been processed, to prevent
+	 * requests from being sent to user daemon repeatedly.
+	 */
+	xa_lock(&cache->reqs);
+	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
+	if (!req) {
+		xa_unlock(&cache->reqs);
+		return 0;
+	}
+
+	msg = &req->msg;
+	n = msg->len;
+
+	if (n > buflen) {
+		xa_unlock(&cache->reqs);
+		return -EMSGSIZE;
+	}
+
+	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
+	xa_unlock(&cache->reqs);
+
+	msg->id = id = xas.xa_index;
+
+	if (msg->opcode == CACHEFILES_OP_OPEN) {
+		ret = cachefiles_ondemand_get_fd(req);
+		if (ret)
+			goto error;
+	}
+
+	if (copy_to_user(_buffer, msg, n) != 0) {
+		ret = -EFAULT;
+		goto err_put_fd;
+	}
+
+	return n;
+
+err_put_fd:
+	if (msg->opcode == CACHEFILES_OP_OPEN)
+		close_fd(req->object->fd);
+error:
+	xa_erase(&cache->reqs, id);
+	req->error = ret;
+	complete(&req->done);
+	return ret;
+}
+
+typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
+
+static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
+					enum cachefiles_opcode opcode,
+					size_t data_len,
+					init_req_fn init_req,
+					void *private)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct cachefiles_req *req;
+	XA_STATE(xas, &cache->reqs, 0);
+	int ret;
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return 0;
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags))
+		return -EIO;
+
+	req = kzalloc(sizeof(*req) + data_len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->object = object;
+	init_completion(&req->done);
+	req->msg.opcode = opcode;
+	req->msg.len = sizeof(struct cachefiles_msg) + data_len;
+
+	ret = init_req(req, private);
+	if (ret)
+		goto out;
+
+	do {
+		/*
+		 * Stop enqueuing the request when daemon is dying. So we need
+		 * to 1) check cache state, and 2) enqueue request if cache is
+		 * alive.
+		 *
+		 * These two ops need to be atomic as a whole. Otherwise request
+		 * may be enqueued after xarray has been flushed, in which case
+		 * the orphan request will never be completed and thus netfs
+		 * will hang there forever.
+		 */
+		xas_lock(&xas);
+
+		/* recheck dead state with lock held */
+		if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+			xas_unlock(&xas);
+			ret = -EIO;
+			goto out;
+		}
+
+		xas.xa_index = 0;
+		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
+		if (xas.xa_node == XAS_RESTART)
+			xas_set_err(&xas, -EBUSY);
+		xas_store(&xas, req);
+		xas_clear_mark(&xas, XA_FREE_MARK);
+		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	ret = xas_error(&xas);
+	if (ret)
+		goto out;
+
+	wake_up_all(&cache->daemon_pollwq);
+	wait_for_completion(&req->done);
+	ret = req->error;
+out:
+	kfree(req);
+	return ret;
+}
+
+static int init_open_req(struct cachefiles_req *req, void *private)
+{
+	struct cachefiles_object *object = req->object;
+	struct fscache_cookie *cookie = object->cookie;
+	struct fscache_volume *volume = object->volume->vcookie;
+	struct cachefiles_open *load = (void *)req->msg.data;
+	size_t volume_key_size, cookie_key_size;
+	void *volume_key, *cookie_key;
+
+	/*
+	 * Volume key is of string format.
+	 * key[0] stores strlen() of the string, while the remained part stores
+	 * the content of the string (excluding the suffix '\0'). Append the
+	 * suffix '\0' to the output volume_key, so that it's a valid string.
+	 */
+	volume_key_size = volume->key[0] + 1;
+	volume_key = volume->key + 1;
+
+	/* Cookie key is of binary format, which is netfs specific. */
+	cookie_key_size = cookie->key_len;
+	cookie_key = fscache_get_key(cookie);
+
+	if (!(object->cookie->advice & FSCACHE_ADV_WANT_CACHE_SIZE)) {
+		pr_err("WANT_CACHE_SIZE is needed for on-demand mode\n");
+		return -EINVAL;
+	}
+
+	load->volume_key_size = volume_key_size;
+	load->cookie_key_size = cookie_key_size;
+	memcpy(load->data, volume_key, volume_key_size);
+	memcpy(load->data + volume_key_size, cookie_key, cookie_key_size);
+
+	return 0;
+}
+
+int cachefiles_ondemand_init_object(struct cachefiles_object *object)
+{
+	struct fscache_cookie *cookie = object->cookie;
+	struct fscache_volume *volume = object->volume->vcookie;
+	size_t volume_key_size, cookie_key_size, data_len;
+
+	/*
+	 * Cachefiles will firstly check cache file under the root cache
+	 * directory. If coherency check failed, it will fallback to creating a
+	 * new tmpfile as the cache file. Reuse the previously created anon_fd
+	 * if any.
+	 */
+	if (object->fd > 0)
+		return 0;
+
+	volume_key_size = volume->key[0] + 1;
+	cookie_key_size = cookie->key_len;
+	data_len = sizeof(struct cachefiles_open) +
+		   volume_key_size + cookie_key_size;
+
+	return cachefiles_ondemand_send_req(object,
+					    CACHEFILES_OP_OPEN, data_len,
+					    init_open_req, NULL);
+}
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 6727fb0db619..663ab6f2ede6 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -39,6 +39,7 @@ struct fscache_cookie;
 #define FSCACHE_ADV_SINGLE_CHUNK	0x01 /* The object is a single chunk of data */
 #define FSCACHE_ADV_WRITE_CACHE		0x00 /* Do cache if written to locally */
 #define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
+#define FSCACHE_ADV_WANT_CACHE_SIZE	0x04 /* Retrieve cache size at runtime */
 
 #define FSCACHE_INVAL_DIO_WRITE		0x01 /* Invalidate due to DIO write */
 
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 311c14a20e70..93df9391bd7f 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -31,6 +31,8 @@ enum cachefiles_obj_ref_trace {
 	cachefiles_obj_see_lookup_failed,
 	cachefiles_obj_see_withdraw_cookie,
 	cachefiles_obj_see_withdrawal,
+	cachefiles_obj_get_ondemand_fd,
+	cachefiles_obj_put_ondemand_fd,
 };
 
 enum fscache_why_object_killed {
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
new file mode 100644
index 000000000000..41492f2653c9
--- /dev/null
+++ b/include/uapi/linux/cachefiles.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_CACHEFILES_H
+#define _LINUX_CACHEFILES_H
+
+#include <linux/types.h>
+
+/*
+ * Fscache ensures that the maximum length of cookie key is 255. The volume key
+ * is controlled by netfs, and generally no bigger than 255.
+ */
+#define CACHEFILES_MSG_MAX_SIZE	1024
+
+enum cachefiles_opcode {
+	CACHEFILES_OP_OPEN,
+};
+
+/*
+ * Message Header
+ *
+ * @id		a unique ID identifying this message
+ * @opcode	message type, CACHEFILE_OP_*
+ * @len		message length, including message header and following data
+ * @data	message type specific payload
+ */
+struct cachefiles_msg {
+	__u32 id;
+	__u32 opcode;
+	__u32 len;
+	__u8  data[];
+};
+
+/*
+ * @data contains volume_key and cookie_key in sequence.
+ *
+ * volume_key is of string format, with a suffix '\0';
+ * @volume_key_size identifies size of volume key, in bytes.
+ *
+ * cookie_key is of binary format, which is netfs specific;
+ * @cookie_key_size identifies size of cookie key, in bytes.
+ */
+struct cachefiles_open {
+	__u32 volume_key_size;
+	__u32 cookie_key_size;
+	__u32 fd;
+	__u32 flags;
+	__u8  data[];
+};
+
+#endif
-- 
2.27.0

