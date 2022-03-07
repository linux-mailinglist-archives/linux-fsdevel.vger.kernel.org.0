Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF56C4CFE93
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 13:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbiCGMeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 07:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbiCGMeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:34:13 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05A33CFDC;
        Mon,  7 Mar 2022 04:33:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6WEilm_1646656391;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6WEilm_1646656391)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:33:12 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/21] cachefiles: notify user daemon with anon_fd when opening cache file
Date:   Mon,  7 Mar 2022 20:32:48 +0800
Message-Id: <20220307123305.79520-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
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

Send the anonymous fd to user daemon when opening cache file for the
first time, no matter whether the cache file exist there or not. With
the given anonymous fd, user daemon can fetch and then write data into
cache file in advance, even when cache miss has not happended yet.

Also add one advisory flag (FSCACHE_ADV_WANT_CACHE_SIZE) suggesting that
cache file size shall be retrieved at runtime. This helps the scenario
where one cache file can contain multiple netfs files for the purpose of
deduplication, e.g. In this case, netfs itself may has no idea the cache
file size, whilst user daemon needs to offer the hint on the cache file
size.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c            | 348 +++++++++++++++++++++++++++++-
 fs/cachefiles/internal.h          |  24 +++
 fs/cachefiles/namei.c             |  16 +-
 include/linux/fscache.h           |   1 +
 include/trace/events/cachefiles.h |   2 +
 include/uapi/linux/cachefiles.h   |  41 ++++
 6 files changed, 429 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/cachefiles.h

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index c0c3a3cbee28..72a21942aaf6 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -19,6 +19,7 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/fs_struct.h>
+#include <linux/anon_inodes.h>
 #include "internal.h"
 
 static int cachefiles_daemon_open(struct inode *, struct file *);
@@ -43,6 +44,9 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_tag(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
 static void cachefiles_daemon_unbind(struct cachefiles_cache *);
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static int cachefiles_ondemand_cinit(struct cachefiles_cache *, char *);
+#endif
 
 static unsigned long cachefiles_open;
 
@@ -75,6 +79,9 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "inuse",	cachefiles_daemon_inuse		},
 	{ "secctx",	cachefiles_daemon_secctx	},
 	{ "tag",	cachefiles_daemon_tag		},
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	{ "cinit",	cachefiles_ondemand_cinit	},
+#endif
 	{ "",		NULL				}
 };
 
@@ -87,6 +94,21 @@ static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache)
 
 static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache)
 {
+	struct cachefiles_req *req;
+	unsigned long index;
+
+	/*
+	 * 1) Cache has been marked as dead state, and then 2) flush all pending
+	 * requests in @reqs xarray. The barrier inside set_bit() will ensure
+	 * that above two ops won't be reordered.
+	 */
+	write_lock(&cache->reqs_lock);
+	xa_for_each(&cache->reqs, index, req) {
+		req->error = -EIO;
+		complete(&req->done);
+	}
+	write_unlock(&cache->reqs_lock);
+
 	xa_destroy(&cache->reqs);
 }
 
@@ -114,6 +136,330 @@ bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, char *args)
 	return false;
 }
 
+static int cachefiles_ondemand_fd_release(struct inode *inode, struct file *file)
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
+static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos, int whence)
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
+ * Init request completion
+ * - command: "cinit <id>[,<cache_size>]"
+ */
+static int cachefiles_ondemand_cinit(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_init *init;
+	struct fscache_cookie *cookie;
+	char *tmp, *pid, *psize;
+	unsigned long id, size = 0;
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
+	tmp = kstrdup(args, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	pid = tmp;
+	psize = strchr(tmp, ',');
+	if (psize) {
+		*psize = 0;
+		psize++;
+
+		ret = kstrtoul(psize, 0, &size);
+		if (ret)
+			goto out;
+	}
+
+	ret = kstrtoul(pid, 0, &id);
+	if (ret)
+		goto out;
+
+	req = xa_erase(&cache->reqs, id);
+	if (!req) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	init = (void *)req->msg.data;
+	if (init->flags & CACHEFILES_INIT_FL_WANT_CACHE_SIZE) {
+		if (WARN_ON_ONCE(!size)) {
+			req->error = -EINVAL;
+		} else {
+			cookie = req->object->cookie;
+			cookie->object_size = size;
+			if (size)
+				set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+			else
+				clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+		}
+	}
+
+	complete(&req->done);
+out:
+	kfree(tmp);
+	return ret;
+}
+
+static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
+{
+	struct cachefiles_init *init;
+	struct cachefiles_object *object;
+	struct fd f;
+	int ret;
+
+	object = cachefiles_grab_object(req->object,
+			cachefiles_obj_get_ondemand_fd);
+
+	ret = anon_inode_getfd("[cachefiles]", &cachefiles_ondemand_fd_fops,
+				object, O_WRONLY);
+	if (ret < 0) {
+		cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
+		return ret;
+	}
+
+	f = fdget_pos(ret);
+	if (WARN_ON_ONCE(!f.file))
+		return -EBADFD;
+
+	f.file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
+	fdput_pos(f);
+
+	init = (void *)req->msg.data;
+	init->fd = object->fd = ret;
+
+	return 0;
+}
+
+static ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
+					       char __user *_buffer,
+					       size_t buflen)
+{
+	struct cachefiles_req *req;
+	struct cachefiles_msg *msg;
+	unsigned long id = 0;
+	size_t n;
+	int ret = 0;
+
+	/*
+	 * Search for request that has not ever been processed, to prevent
+	 * requests from being sent to user daemon repeatedly.
+	 */
+	req = xa_find(&cache->reqs, &id, UINT_MAX, CACHEFILES_REQ_NEW);
+	if (!req)
+		return 0;
+
+	msg = &req->msg;
+	msg->id = id;
+
+	n = msg->len;
+	if (n > buflen)
+		return -EMSGSIZE;
+
+	if (msg->opcode == CACHEFILES_OP_INIT) {
+		ret = cachefiles_ondemand_get_fd(req);
+		if (ret) {
+			req = xa_erase(&cache->reqs, id);
+			if (WARN_ON_ONCE(!req))
+				return ret;
+
+			req->error = ret;
+			complete(&req->done);
+			return ret;
+		}
+	}
+
+	if (copy_to_user(_buffer, msg, n) != 0)
+		return -EFAULT;
+
+	xa_clear_mark(&cache->reqs, id, CACHEFILES_REQ_NEW);
+	return n;
+}
+
+static inline int cachefiles_ondemand_check(struct cachefiles_cache *cache)
+{
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags))
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Stop enqueuing requests when daemon is dying. So we need to 1) check cache
+ * state, and 2) enqueue request only if cache is not in dead state. The above
+ * two ops need to be atomic as a whole. @reqs_lock is used here to ensure that.
+ * Otherwise, request may be enqueued after @reqs xarray has been flushed, in
+ * which case the orphan request will never be completed and thus netfs will
+ * hang there forever.
+ */
+static int cachefiles_ondemand_send_req(struct cachefiles_cache *cache,
+					struct cachefiles_req *req)
+{
+	struct xarray *xa = &cache->reqs;
+	int ret;
+	u32 id;
+
+	read_lock(&cache->reqs_lock);
+
+	/* recheck dead state under lock */
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		read_unlock(&cache->reqs_lock);
+		return -EIO;
+	}
+
+	xa_lock(xa);
+	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
+	if (!ret)
+		__xa_set_mark(xa, id, CACHEFILES_REQ_NEW);
+	xa_unlock(xa);
+
+	read_unlock(&cache->reqs_lock);
+
+	if (!ret) {
+		wake_up_all(&cache->daemon_pollwq);
+		wait_for_completion(&req->done);
+		ret = req->error;
+	}
+
+	return ret;
+}
+
+static inline
+struct cachefiles_req *cachefiles_alloc_req(struct cachefiles_object *object,
+					    enum cachefiles_opcode opcode,
+					    size_t data_len)
+{
+	struct cachefiles_req *req;
+
+	req = kzalloc(sizeof(*req) + data_len, GFP_KERNEL);
+	if (req) {
+		req->object = object;
+		init_completion(&req->done);
+		req->msg.opcode = opcode;
+		req->msg.len = sizeof(struct cachefiles_msg) + data_len;
+	}
+
+	return req;
+}
+
+static struct cachefiles_req *
+cachefiles_alloc_init_req(struct cachefiles_object *object)
+{
+	struct fscache_cookie *cookie = object->cookie;
+	struct fscache_volume *volume = object->volume->vcookie;
+	struct cachefiles_req *req;
+	struct cachefiles_init *init;
+	void *volume_key, *cookie_key;
+	size_t volume_key_len, cookie_key_len, data_len;
+
+	/* volume key is of string format */
+	volume_key_len = volume->key[0] + 1;
+	volume_key = volume->key + 1;
+
+	/* cookie key is of binary format */
+	cookie_key_len = cookie->key_len;
+	cookie_key = fscache_get_key(cookie);
+
+	data_len = sizeof(*init) + volume_key_len + cookie_key_len;
+	req = cachefiles_alloc_req(object, CACHEFILES_OP_INIT, data_len);
+	if (!req)
+		return NULL;
+
+	init = (void *)req->msg.data;
+	init->volume_key_len = volume_key_len;
+	init->cookie_key_len = cookie_key_len;
+	memcpy(init->data, volume_key, volume_key_len);
+	memcpy(init->data + volume_key_len, cookie_key, cookie_key_len);
+
+	if (object->cookie->advice & FSCACHE_ADV_WANT_CACHE_SIZE)
+		init->flags |= CACHEFILES_INIT_FL_WANT_CACHE_SIZE;
+
+	return req;
+}
+
+int cachefiles_ondemand_init_object(struct cachefiles_object *object)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct cachefiles_req *req;
+	int ret;
+
+	ret = cachefiles_ondemand_check(cache);
+	if (ret)
+		return ret;
+
+	req = cachefiles_alloc_init_req(object);
+	if (!req)
+		return -ENOMEM;
+
+	ret = cachefiles_ondemand_send_req(cache, req);
+
+	kfree(req);
+	return ret;
+}
+
 #else
 static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache) {}
 static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache) {}
@@ -129,7 +475,6 @@ bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, char *args)
 {
 	return false;
 }
-#endif
 
 static inline
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
@@ -137,6 +482,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 {
 	return -EOPNOTSUPP;
 }
+#endif
 
 /*
  * Prepare a cache for caching.
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 3f791882fa3f..8450ebd77949 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -16,6 +16,7 @@
 #include <linux/cred.h>
 #include <linux/security.h>
 #include <linux/xarray.h>
+#include <linux/cachefiles.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -59,6 +60,9 @@ struct cachefiles_object {
 	enum cachefiles_content		content_info:8;	/* Info about content presence */
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	int				fd;		/* anonymous fd */
+#endif
 };
 
 /*
@@ -109,6 +113,15 @@ struct cachefiles_cache {
 #endif
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
@@ -152,6 +165,17 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  */
 extern const struct file_operations cachefiles_daemon_fops;
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
+
+#else
+static inline
+int cachefiles_ondemand_init_object(struct cachefiles_object *object)
+{
+	return 0;
+}
+#endif
+
 /*
  * error_inject.c
  */
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f256c8aff7bb..22aba4c6a762 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -444,10 +444,9 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
 	struct file *file;
 	struct path path;
-	uint64_t ni_size = object->cookie->object_size;
+	uint64_t ni_size;
 	long ret;
 
-	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 
 	cachefiles_begin_secure(cache, &saved_cred);
 
@@ -473,6 +472,15 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		goto out_dput;
 	}
 
+	ret = cachefiles_ondemand_init_object(object);
+	if (ret < 0) {
+		file = ERR_PTR(ret);
+		goto out_dput;
+	}
+
+	ni_size = object->cookie->object_size;
+	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
+
 	if (ni_size > 0) {
 		trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
 				       cachefiles_trunc_expand_tmpfile);
@@ -573,6 +581,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	}
 	_debug("file -> %pd positive", dentry);
 
+	ret = cachefiles_ondemand_init_object(object);
+	if (ret < 0)
+		goto error_fput;
+
 	ret = cachefiles_check_auxdata(object, file);
 	if (ret < 0)
 		goto check_failed;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index d2430da8aa67..a330354f33ca 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -39,6 +39,7 @@ struct fscache_cookie;
 #define FSCACHE_ADV_SINGLE_CHUNK	0x01 /* The object is a single chunk of data */
 #define FSCACHE_ADV_WRITE_CACHE		0x00 /* Do cache if written to locally */
 #define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
+#define FSCACHE_ADV_WANT_CACHE_SIZE	0x04 /* Retrieve cache size at runtime */
 
 #define FSCACHE_INVAL_DIO_WRITE		0x01 /* Invalidate due to DIO write */
 
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index c6f5aa74db89..371e5816e98c 100644
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
index 000000000000..759fb6693d75
--- /dev/null
+++ b/include/uapi/linux/cachefiles.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_CACHEFILES_H
+#define _LINUX_CACHEFILES_H
+
+#include <linux/types.h>
+
+#define CACHEFILES_MSG_MAX_SIZE	512
+
+enum cachefiles_opcode {
+	CACHEFILES_OP_INIT,
+};
+
+/*
+ * @id		identifying position of this message in the radix tree
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
+struct cachefiles_init {
+	__u32 volume_key_len;
+	__u32 cookie_key_len;
+	__u32 fd;
+	__u32 flags;
+	/* following data contains volume_key and cookie_key in sequence */
+	__u8  data[];
+};
+
+enum cachefiles_init_flags {
+	CACHEFILES_INIT_WANT_CACHE_SIZE,
+};
+
+#define CACHEFILES_INIT_FL_WANT_CACHE_SIZE	(1 << CACHEFILES_INIT_WANT_CACHE_SIZE)
+
+#endif
-- 
2.27.0

