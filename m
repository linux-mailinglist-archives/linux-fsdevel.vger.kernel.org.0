Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57162BA5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiKPK4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiKPK4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:56:24 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55FC5984C;
        Wed, 16 Nov 2022 02:45:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VUxfD83_1668595505;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUxfD83_1668595505)
          by smtp.aliyun-inc.com;
          Wed, 16 Nov 2022 18:45:06 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, jlayton@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/2] fscache,cachefiles: add prepare_ondemand_read() callback
Date:   Wed, 16 Nov 2022 18:45:01 +0800
Message-Id: <20221116104502.107431-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221116104502.107431-1-jefflexu@linux.alibaba.com>
References: <20221116104502.107431-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add prepare_ondemand_read() callback dedicated for the on-demand read
scenario, so that callers from this scenario can be decoupled from
netfs_io_subrequest.

The original cachefiles_prepare_read() is now refactored to a generic
routine accepting a parameter list instead of netfs_io_subrequest.
There's no logic change, except that some debug info retrieved from
netfs_io_subrequest is removed from trace_cachefiles_prep_read().

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c                | 75 ++++++++++++++++++++-----------
 include/linux/netfs.h             |  7 +++
 include/trace/events/cachefiles.h | 27 ++++++-----
 3 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 000a28f46e59..3eeafef21c4e 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -385,38 +385,35 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 				  term_func, term_func_priv);
 }
 
-/*
- * Prepare a read operation, shortening it to a cached/uncached
- * boundary as appropriate.
- */
-static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
-						      loff_t i_size)
+static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
+					loff_t *_start, size_t *_len,
+					unsigned long *_flags, loff_t i_size)
 {
 	enum cachefiles_prepare_read_trace why;
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	struct cachefiles_object *object;
+	struct cachefiles_object *object = NULL;
 	struct cachefiles_cache *cache;
 	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
 	const struct cred *saved_cred;
 	struct file *file = cachefiles_cres_file(cres);
 	enum netfs_io_source ret = NETFS_DOWNLOAD_FROM_SERVER;
+	loff_t start = *_start;
+	size_t len = *_len;
 	loff_t off, to;
 	ino_t ino = file ? file_inode(file)->i_ino : 0;
 	int rc;
 
-	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
+	_enter("%zx @%llx/%llx", len, start, i_size);
 
-	if (subreq->start >= i_size) {
+	if (start >= i_size) {
 		ret = NETFS_FILL_WITH_ZEROES;
 		why = cachefiles_trace_read_after_eof;
 		goto out_no_object;
 	}
 
 	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
-		__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
+		__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
 		why = cachefiles_trace_read_no_data;
-		if (!test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags))
+		if (!test_bit(NETFS_SREQ_ONDEMAND, _flags))
 			goto out_no_object;
 	}
 
@@ -437,7 +434,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 retry:
 	off = cachefiles_inject_read_error();
 	if (off == 0)
-		off = vfs_llseek(file, subreq->start, SEEK_DATA);
+		off = vfs_llseek(file, start, SEEK_DATA);
 	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
 		if (off == (loff_t)-ENXIO) {
 			why = cachefiles_trace_read_seek_nxio;
@@ -449,21 +446,22 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 		goto out;
 	}
 
-	if (off >= subreq->start + subreq->len) {
+	if (off >= start + len) {
 		why = cachefiles_trace_read_found_hole;
 		goto download_and_store;
 	}
 
-	if (off > subreq->start) {
+	if (off > start) {
 		off = round_up(off, cache->bsize);
-		subreq->len = off - subreq->start;
+		len = off - start;
+		*_len = len;
 		why = cachefiles_trace_read_found_part;
 		goto download_and_store;
 	}
 
 	to = cachefiles_inject_read_error();
 	if (to == 0)
-		to = vfs_llseek(file, subreq->start, SEEK_HOLE);
+		to = vfs_llseek(file, start, SEEK_HOLE);
 	if (to < 0 && to >= (loff_t)-MAX_ERRNO) {
 		trace_cachefiles_io_error(object, file_inode(file), to,
 					  cachefiles_trace_seek_error);
@@ -471,12 +469,13 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 		goto out;
 	}
 
-	if (to < subreq->start + subreq->len) {
-		if (subreq->start + subreq->len >= i_size)
+	if (to < start + len) {
+		if (start + len >= i_size)
 			to = round_up(to, cache->bsize);
 		else
 			to = round_down(to, cache->bsize);
-		subreq->len = to - subreq->start;
+		len = to - start;
+		*_len = len;
 	}
 
 	why = cachefiles_trace_read_have_data;
@@ -484,12 +483,11 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 	goto out;
 
 download_and_store:
-	__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
-	if (test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags)) {
-		rc = cachefiles_ondemand_read(object, subreq->start,
-					      subreq->len);
+	__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
+	if (test_bit(NETFS_SREQ_ONDEMAND, _flags)) {
+		rc = cachefiles_ondemand_read(object, start, len);
 		if (!rc) {
-			__clear_bit(NETFS_SREQ_ONDEMAND, &subreq->flags);
+			__clear_bit(NETFS_SREQ_ONDEMAND, _flags);
 			goto retry;
 		}
 		ret = NETFS_INVALID_READ;
@@ -497,10 +495,32 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 out:
 	cachefiles_end_secure(cache, saved_cred);
 out_no_object:
-	trace_cachefiles_prep_read(subreq, ret, why, ino);
+	trace_cachefiles_prep_read(object, start, len, *_flags, ret, why, ino);
 	return ret;
 }
 
+/*
+ * Prepare a read operation, shortening it to a cached/uncached
+ * boundary as appropriate.
+ */
+static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
+						    loff_t i_size)
+{
+	return cachefiles_do_prepare_read(&subreq->rreq->cache_resources,
+			&subreq->start, &subreq->len, &subreq->flags, i_size);
+}
+
+/*
+ * Prepare an on-demand read operation, shortening it to a cached/uncached
+ * boundary as appropriate.
+ */
+static enum netfs_io_source cachefiles_prepare_ondemand_read(struct netfs_cache_resources *cres,
+			loff_t start, size_t *_len, loff_t i_size)
+{
+	unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
+	return cachefiles_do_prepare_read(cres, &start, _len, &flags, i_size);
+}
+
 /*
  * Prepare for a write to occur.
  */
@@ -621,6 +641,7 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.write			= cachefiles_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
 	.query_occupancy	= cachefiles_query_occupancy,
 };
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f2402ddeafbf..d82071c37133 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -267,6 +267,13 @@ struct netfs_cache_ops {
 			     loff_t *_start, size_t *_len, loff_t i_size,
 			     bool no_space_allocated_yet);
 
+	/* Prepare an on-demand read operation, shortening it to a cached/uncached
+	 * boundary as appropriate.
+	 */
+	enum netfs_io_source (*prepare_ondemand_read)(struct netfs_cache_resources *cres,
+						      loff_t start, size_t *_len,
+						      loff_t i_size);
+
 	/* Query the occupancy of the cache in a region, returning where the
 	 * next chunk of data starts and how long it is.
 	 */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index d8d4d73fe7b6..171c0d7f0bb7 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -428,44 +428,43 @@ TRACE_EVENT(cachefiles_vol_coherency,
 	    );
 
 TRACE_EVENT(cachefiles_prep_read,
-	    TP_PROTO(struct netfs_io_subrequest *sreq,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     loff_t start,
+		     size_t len,
+		     unsigned short flags,
 		     enum netfs_io_source source,
 		     enum cachefiles_prepare_read_trace why,
 		     ino_t cache_inode),
 
-	    TP_ARGS(sreq, source, why, cache_inode),
+	    TP_ARGS(obj, start, len, flags, source, why, cache_inode),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned short,		index		)
+		    __field(unsigned int,		obj		)
 		    __field(unsigned short,		flags		)
 		    __field(enum netfs_io_source,	source		)
 		    __field(enum cachefiles_prepare_read_trace,	why	)
 		    __field(size_t,			len		)
 		    __field(loff_t,			start		)
-		    __field(unsigned int,		netfs_inode	)
 		    __field(unsigned int,		cache_inode	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->rreq	= sreq->rreq->debug_id;
-		    __entry->index	= sreq->debug_index;
-		    __entry->flags	= sreq->flags;
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->flags	= flags;
 		    __entry->source	= source;
 		    __entry->why	= why;
-		    __entry->len	= sreq->len;
-		    __entry->start	= sreq->start;
-		    __entry->netfs_inode = sreq->rreq->inode->i_ino;
+		    __entry->len	= len;
+		    __entry->start	= start;
 		    __entry->cache_inode = cache_inode;
 			   ),
 
-	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx ni=%x B=%x",
-		      __entry->rreq, __entry->index,
+	    TP_printk("o=%08x %s %s f=%02x s=%llx %zx B=%x",
+		      __entry->obj,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __print_symbolic(__entry->why, cachefiles_prepare_read_traces),
 		      __entry->flags,
 		      __entry->start, __entry->len,
-		      __entry->netfs_inode, __entry->cache_inode)
+		      __entry->cache_inode)
 	    );
 
 TRACE_EVENT(cachefiles_read,
-- 
2.19.1.6.gb485710b

