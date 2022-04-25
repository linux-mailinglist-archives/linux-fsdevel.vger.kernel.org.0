Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3376E50E012
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbiDYMZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 08:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiDYMY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:24:58 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA0160065;
        Mon, 25 Apr 2022 05:21:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VBDlJDM_1650889308;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VBDlJDM_1650889308)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 20:21:50 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v10 03/21] cachefiles: unbind cachefiles gracefully in on-demand mode
Date:   Mon, 25 Apr 2022 20:21:25 +0800
Message-Id: <20220425122143.56815-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
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

Add a refcount to avoid the deadlock in on-demand read mode. The
on-demand read mode will pin the corresponding cachefiles object for
each anonymous fd. The cachefiles object is unpinned when the anonymous
fd gets closed. When the user daemon exits and the fd of
"/dev/cachefiles" device node gets closed, it will wait for all
cahcefiles objects getting withdrawn. Then if there's any anonymous fd
getting closed after the fd of the device node, the user daemon will
hang forever, waiting for all objects getting withdrawn.

To fix this, add a refcount indicating if there's any object pinned by
anonymous fds. The cachefiles cache gets unbound and withdrawn when the
refcount is decreased to 0. It won't change the behaviour of the
original mode, in which case the cachefiles cache gets unbound and
withdrawn as long as the fd of the device node gets closed.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 19 ++++++++++++++++---
 fs/cachefiles/internal.h |  3 +++
 fs/cachefiles/ondemand.c |  3 +++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index d5417da7f792..5b1d0642c749 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -111,6 +111,7 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&cache->volumes);
 	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
+	refcount_set(&cache->unbind_pincount, 1);
 	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
 	xa_init_flags(&cache->ondemand_ids, XA_FLAGS_ALLOC1);
 
@@ -164,6 +165,20 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
 	xa_destroy(&cache->ondemand_ids);
 }
 
+void cachefiles_put_unbind_pincount(struct cachefiles_cache *cache)
+{
+	if (refcount_dec_and_test(&cache->unbind_pincount)) {
+		cachefiles_daemon_unbind(cache);
+		cachefiles_open = 0;
+		kfree(cache);
+	}
+}
+
+void cachefiles_get_unbind_pincount(struct cachefiles_cache *cache)
+{
+	refcount_inc(&cache->unbind_pincount);
+}
+
 /*
  * Release a cache.
  */
@@ -179,14 +194,12 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 
 	if (cachefiles_in_ondemand_mode(cache))
 		cachefiles_flush_reqs(cache);
-	cachefiles_daemon_unbind(cache);
 
 	/* clean up the control file interface */
 	cache->cachefilesd = NULL;
 	file->private_data = NULL;
-	cachefiles_open = 0;
 
-	kfree(cache);
+	cachefiles_put_unbind_pincount(cache);
 
 	_leave("");
 	return 0;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4f5150a96849..e5c612888f84 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -109,6 +109,7 @@ struct cachefiles_cache {
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
@@ -171,6 +172,8 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * daemon.c
  */
 extern const struct file_operations cachefiles_daemon_fops;
+extern void cachefiles_get_unbind_pincount(struct cachefiles_cache *cache);
+extern void cachefiles_put_unbind_pincount(struct cachefiles_cache *cache);
 
 /*
  * error_inject.c
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 64fc312b16d3..7946ee6c40be 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -14,6 +14,7 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
 	xa_erase(&cache->ondemand_ids, object_id);
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
+	cachefiles_put_unbind_pincount(cache);
 	return 0;
 }
 
@@ -169,6 +170,8 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	load->fd = fd;
 	req->msg.object_id = object_id;
 	object->ondemand_id = object_id;
+
+	cachefiles_get_unbind_pincount(cache);
 	return 0;
 
 err_put_fd:
-- 
2.27.0

