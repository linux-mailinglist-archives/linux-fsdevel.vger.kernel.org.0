Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D64CFE8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 13:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiCGMeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 07:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbiCGMeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:34:09 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E53C4AD;
        Mon,  7 Mar 2022 04:33:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6VOena_1646656390;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6VOena_1646656390)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:33:11 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/21] cachefiles: introduce on-demand read mode
Date:   Mon,  7 Mar 2022 20:32:47 +0800
Message-Id: <20220307123305.79520-4-jefflexu@linux.alibaba.com>
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

Fscache/cachefiles used to serve as a local cache for remote fs. This
patch, along with the following patches, introduces a new on-demand read
mode for cachefiles, which can boost the scenario where on-demand read
semantics is needed, e.g. container image distribution.

The essential difference between the original mode and on-demand read
mode is that, in the original mode, when cache miss, netfs itself will
fetch data from remote, and then write the fetched data into cache file.
While in on-demand read mode, a user daemon is responsible for fetching
data and then writing to the cache file.

This patch only adds the command to enable on-demand read mode. An
optional parameter to "bind" command is added. On-demand mode will be
turned on when this optional argument matches "ondemand" exactly, i.e.
"bind ondemand". Otherwise cachefiles will keep working in the original
mode.

The following patches will implement the data plane of on-demand read
mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/Kconfig    |  11 ++++
 fs/cachefiles/daemon.c   | 132 +++++++++++++++++++++++++++++++--------
 fs/cachefiles/internal.h |   6 ++
 3 files changed, 124 insertions(+), 25 deletions(-)

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
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 7ac04ee2c0a0..c0c3a3cbee28 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -78,6 +78,65 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "",		NULL				}
 };
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache)
+{
+	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
+	rwlock_init(&cache->reqs_lock);
+}
+
+static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache)
+{
+	xa_destroy(&cache->reqs);
+}
+
+static inline __poll_t cachefiles_ondemand_mask(struct cachefiles_cache *cache)
+{
+	__poll_t mask = 0;
+
+	if (!xa_empty(&cache->reqs))
+		mask |= EPOLLIN;
+
+	if (test_bit(CACHEFILES_CULLING, &cache->flags))
+		mask |= EPOLLOUT;
+
+	return mask;
+}
+
+static inline
+bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, char *args)
+{
+	if (!strcmp(args, "ondemand")) {
+		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+		return true;
+	}
+
+	return false;
+}
+
+#else
+static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache) {}
+static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache) {}
+
+static inline
+__poll_t cachefiles_ondemand_mask(struct cachefiles_cache *cache)
+{
+	return 0;
+}
+
+static inline
+bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, char *args)
+{
+	return false;
+}
+#endif
+
+static inline
+ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
+					char __user *_buffer, size_t buflen)
+{
+	return -EOPNOTSUPP;
+}
 
 /*
  * Prepare a cache for caching.
@@ -108,6 +167,7 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&cache->volumes);
 	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
+	cachefiles_ondemand_open(cache);
 
 	/* set default caching limits
 	 * - limit at 1% free space and/or free files
@@ -139,6 +199,7 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 
 	set_bit(CACHEFILES_DEAD, &cache->flags);
 
+	cachefiles_ondemand_release(cache);
 	cachefiles_daemon_unbind(cache);
 
 	/* clean up the control file interface */
@@ -152,23 +213,15 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-/*
- * Read the cache state.
- */
-static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
-				      size_t buflen, loff_t *pos)
+static ssize_t cachefiles_do_daemon_read(struct cachefiles_cache *cache,
+					 char __user *_buffer,
+					 size_t buflen)
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
 
@@ -206,6 +259,25 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
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
+	if (likely(!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)))
+		return cachefiles_do_daemon_read(cache, _buffer, buflen);
+	else
+		return cachefiles_ondemand_daemon_read(cache, _buffer, buflen);
+}
+
 /*
  * Take a command from cachefilesd, parse it and act on it.
  */
@@ -284,6 +356,21 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 	goto error;
 }
 
+
+static inline
+__poll_t cachefiles_daemon_mask(struct cachefiles_cache *cache)
+{
+	__poll_t mask = 0;
+
+	if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
+		mask |= EPOLLIN;
+
+	if (test_bit(CACHEFILES_CULLING, &cache->flags))
+		mask |= EPOLLOUT;
+
+	return mask;
+}
+
 /*
  * Poll for culling state
  * - use EPOLLOUT to indicate culling state
@@ -292,18 +379,13 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
-	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
-	mask = 0;
-
-	if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
-		mask |= EPOLLIN;
-
-	if (test_bit(CACHEFILES_CULLING, &cache->flags))
-		mask |= EPOLLOUT;
 
-	return mask;
+	if (likely(!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)))
+		return cachefiles_daemon_mask(cache);
+	else
+		return cachefiles_ondemand_mask(cache);
 }
 
 /*
@@ -687,11 +769,6 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 	    cache->brun_percent  >= 100)
 		return -ERANGE;
 
-	if (*args) {
-		pr_err("'bind' command doesn't take an argument\n");
-		return -EINVAL;
-	}
-
 	if (!cache->rootdirname) {
 		pr_err("No cache directory specified\n");
 		return -EINVAL;
@@ -703,6 +780,11 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 		return -EBUSY;
 	}
 
+	if (!cachefiles_ondemand_daemon_bind(cache, args) && *args) {
+		pr_err("'bind' command doesn't take an argument\n");
+		return -EINVAL;
+	}
+
 	/* Make sure we have copies of the tag string */
 	if (!cache->tag) {
 		/*
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e80673d0ab97..3f791882fa3f 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,7 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/xarray.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -98,9 +99,14 @@ struct cachefiles_cache {
 #define CACHEFILES_DEAD			1	/* T if cache dead */
 #define CACHEFILES_CULLING		2	/* T if cull engaged */
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+#define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+	struct xarray			reqs;		/* xarray of pending on-demand requests */
+	rwlock_t			reqs_lock;	/* Lock for reqs xarray */
+#endif
 };
 
 #include <trace/events/cachefiles.h>
-- 
2.27.0

