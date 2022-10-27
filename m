Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E2E60F263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 10:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiJ0If7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiJ0If4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:35:56 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13E08B2E4;
        Thu, 27 Oct 2022 01:35:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAlX.h_1666859748;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAlX.h_1666859748)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:49 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] fscache: decouple prepare_read() from netfs_io_subrequest
Date:   Thu, 27 Oct 2022 16:35:39 +0800
Message-Id: <20221027083547.46933-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
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

All methods except prepare_read() of netfs_cache_ops works without
netfs_io_request/netfs_io_subrequest, which accept netfs_cache_resources
and a file range to be handled.

As fscache is now also used for local fs (e.g. erofs) in on-demand read
scenarios, we'd better make raw fscache APIs more neutral independent on
libnetfs.  Thus decouple prepare_read() from netfs_io_subrequest, just
like other methods do.

This is a cleanup without logic change, except that some debug info
retrieved from netfs_io_subrequest is removed from
trace_cachefiles_prep_read().

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c                | 46 ++++++++++++++++---------------
 fs/erofs/fscache.c                |  3 +-
 fs/netfs/io.c                     |  3 +-
 include/linux/netfs.h             |  5 ++--
 include/trace/events/cachefiles.h | 23 ++++++----------
 5 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 000a28f46e59..d5b6a2a75161 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -389,34 +389,35 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
  * Prepare a read operation, shortening it to a cached/uncached
  * boundary as appropriate.
  */
-static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
-						      loff_t i_size)
+static enum netfs_io_source cachefiles_prepare_read(struct netfs_cache_resources *cres,
+					loff_t *_start, size_t *_len,
+					unsigned long *_flags, loff_t i_size)
 {
 	enum cachefiles_prepare_read_trace why;
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct cachefiles_object *object;
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
 
@@ -437,7 +438,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 retry:
 	off = cachefiles_inject_read_error();
 	if (off == 0)
-		off = vfs_llseek(file, subreq->start, SEEK_DATA);
+		off = vfs_llseek(file, start, SEEK_DATA);
 	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
 		if (off == (loff_t)-ENXIO) {
 			why = cachefiles_trace_read_seek_nxio;
@@ -449,21 +450,22 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
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
@@ -471,12 +473,13 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
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
@@ -484,12 +487,11 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
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
@@ -497,7 +499,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 out:
 	cachefiles_end_secure(cache, saved_cred);
 out_no_object:
-	trace_cachefiles_prep_read(subreq, ret, why, ino);
+	trace_cachefiles_prep_read(start, len, *_flags, ret, why, ino);
 	return ret;
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fe05bc51f9f2..a4013f9bdb5c 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -176,7 +176,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 
-		source = cres->ops->prepare_read(subreq, LLONG_MAX);
+		source = cres->ops->prepare_read(cres, &subreq->start,
+				&subreq->len, &subreq->flags, LLONG_MAX);
 		if (WARN_ON(subreq->len == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 428925899282..297423220fb1 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -487,7 +487,8 @@ static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_subrequest
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
 	if (cres->ops)
-		return cres->ops->prepare_read(subreq, i_size);
+		return cres->ops->prepare_read(cres, &subreq->start,
+				&subreq->len, &subreq->flags, i_size);
 	if (subreq->start >= rreq->i_size)
 		return NETFS_FILL_WITH_ZEROES;
 	return NETFS_DOWNLOAD_FROM_SERVER;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f2402ddeafbf..b8171b3b9e2d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -257,8 +257,9 @@ struct netfs_cache_ops {
 	/* Prepare a read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
-	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
-					     loff_t i_size);
+	enum netfs_io_source (*prepare_read)(struct netfs_cache_resources *cres,
+					     loff_t *_start, size_t *_len,
+					     unsigned long *_flags, loff_t i_size);
 
 	/* Prepare a write operation, working out what part of the write we can
 	 * actually do.
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index d8d4d73fe7b6..62da0596f65b 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -428,44 +428,39 @@ TRACE_EVENT(cachefiles_vol_coherency,
 	    );
 
 TRACE_EVENT(cachefiles_prep_read,
-	    TP_PROTO(struct netfs_io_subrequest *sreq,
+	    TP_PROTO(loff_t start,
+		     size_t len,
+		     unsigned short flags,
 		     enum netfs_io_source source,
 		     enum cachefiles_prepare_read_trace why,
 		     ino_t cache_inode),
 
-	    TP_ARGS(sreq, source, why, cache_inode),
+	    TP_ARGS(start, len, flags, source, why, cache_inode),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned short,		index		)
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
+	    TP_printk("%s %s f=%02x s=%llx %zx B=%x",
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

