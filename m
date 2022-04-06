Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583B24F5D4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiDFMOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiDFMNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:13:54 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C56E42540C;
        Wed,  6 Apr 2022 00:56:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9L1BIW_1649231775;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9L1BIW_1649231775)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 15:56:16 +0800
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
Subject: [PATCH v8 02/20] cachefiles: extract write routine
Date:   Wed,  6 Apr 2022 15:55:54 +0800
Message-Id: <20220406075612.60298-3-jefflexu@linux.alibaba.com>
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

Extract the generic routine of writing data to cache files, and make it
generally available.

This will be used by the following patch implementing on-demand read
mode. Since it's called inside cachefiles module in this case, make the
interface generic and unrelated to netfs_cache_resources.

It is worth nothing that, ki->inval_counter is not initialized after
this cleanup. It shall not make any visible difference, since
inval_counter is no longer used in the write completion routine, i.e.
cachefiles_write_complete().

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h | 10 +++++++
 fs/cachefiles/io.c       | 61 +++++++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index c793d33b0224..e80673d0ab97 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -201,6 +201,16 @@ extern void cachefiles_put_object(struct cachefiles_object *object,
  */
 extern bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 				       enum fscache_want_state want_state);
+extern int __cachefiles_prepare_write(struct cachefiles_object *object,
+				      struct file *file,
+				      loff_t *_start, size_t *_len,
+				      bool no_space_allocated_yet);
+extern int __cachefiles_write(struct cachefiles_object *object,
+			      struct file *file,
+			      loff_t start_pos,
+			      struct iov_iter *iter,
+			      netfs_io_terminated_t term_func,
+			      void *term_func_priv);
 
 /*
  * key.c
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 9dc81e781f2b..50a14e8f0aac 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -277,36 +277,33 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 /*
  * Initiate a write to the cache.
  */
-static int cachefiles_write(struct netfs_cache_resources *cres,
-			    loff_t start_pos,
-			    struct iov_iter *iter,
-			    netfs_io_terminated_t term_func,
-			    void *term_func_priv)
+int __cachefiles_write(struct cachefiles_object *object,
+		       struct file *file,
+		       loff_t start_pos,
+		       struct iov_iter *iter,
+		       netfs_io_terminated_t term_func,
+		       void *term_func_priv)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct cachefiles_kiocb *ki;
 	struct inode *inode;
-	struct file *file;
 	unsigned int old_nofs;
-	ssize_t ret = -ENOBUFS;
+	ssize_t ret;
 	size_t len = iov_iter_count(iter);
 
-	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
-		goto presubmission_error;
 	fscache_count_write();
-	object = cachefiles_cres_object(cres);
 	cache = object->volume->cache;
-	file = cachefiles_cres_file(cres);
 
 	_enter("%pD,%li,%llx,%zx/%llx",
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
 
-	ret = -ENOMEM;
 	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
-	if (!ki)
-		goto presubmission_error;
+	if (!ki) {
+		if (term_func)
+			term_func(term_func_priv, -ENOMEM, false);
+		return -ENOMEM;
+	}
 
 	refcount_set(&ki->ki_refcnt, 2);
 	ki->iocb.ki_filp	= file;
@@ -314,7 +311,6 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->object		= object;
-	ki->inval_counter	= cres->inval_counter;
 	ki->start		= start_pos;
 	ki->len			= len;
 	ki->term_func		= term_func;
@@ -369,11 +365,24 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	cachefiles_put_kiocb(ki);
 	_leave(" = %zd", ret);
 	return ret;
+}
 
-presubmission_error:
-	if (term_func)
-		term_func(term_func_priv, ret, false);
-	return ret;
+static int cachefiles_write(struct netfs_cache_resources *cres,
+			    loff_t start_pos,
+			    struct iov_iter *iter,
+			    netfs_io_terminated_t term_func,
+			    void *term_func_priv)
+{
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE)) {
+		if (term_func)
+			term_func(term_func_priv, -ENOBUFS, false);
+		return -ENOBUFS;
+	}
+
+	return __cachefiles_write(cachefiles_cres_object(cres),
+				  cachefiles_cres_file(cres),
+				  start_pos, iter,
+				  term_func, term_func_priv);
 }
 
 /*
@@ -484,13 +493,12 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 /*
  * Prepare for a write to occur.
  */
-static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
-				      loff_t *_start, size_t *_len, loff_t i_size,
-				      bool no_space_allocated_yet)
+int __cachefiles_prepare_write(struct cachefiles_object *object,
+			       struct file *file,
+			       loff_t *_start, size_t *_len,
+			       bool no_space_allocated_yet)
 {
-	struct cachefiles_object *object = cachefiles_cres_object(cres);
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct file *file = cachefiles_cres_file(cres);
 	loff_t start = *_start, pos;
 	size_t len = *_len, down;
 	int ret;
@@ -577,7 +585,8 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	}
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(cres, _start, _len, i_size,
+	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
+					 _start, _len,
 					 no_space_allocated_yet);
 	cachefiles_end_secure(cache, saved_cred);
 	return ret;
-- 
2.27.0

