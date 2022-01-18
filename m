Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1993B492689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbiARNM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:12:26 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42379 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241959AbiARNMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2C1QwT_1642511538;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2C1QwT_1642511538)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:19 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/20] netfs,cachefiles: manage logical/physical offset separately
Date:   Tue, 18 Jan 2022 21:11:58 +0800
Message-Id: <20220118131216.85338-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently fscache is used in a style that every file in upper fs has a
corresponding backing file in fscache, and the file offset in the upper
file (logical) is always equal to that in the backing file (physical).

While upper fs may implement different backing strategy, the above
assumption can no longer be valid, e.g. multiple upper files can be
packed into one single backing file.

Thus this patch abstracts these two different offsets and manage them
separately, so that upper fs can implement different backing strategy.
For the original users where these two offsets are always equal, no
change is needed. While for the scenario where these two offsets can be
different, upper fs can set a separate logical/physical offset in
ops->begin_cache_operation() if it's needed.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c     | 14 +++++++-------
 fs/netfs/read_helper.c | 16 ++++++++++++----
 include/linux/netfs.h  |  2 ++
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 60b1eac2ce78..5da0bfd78188 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -370,7 +370,7 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 
 	off = cachefiles_inject_read_error();
 	if (off == 0)
-		off = vfs_llseek(file, subreq->start, SEEK_DATA);
+		off = vfs_llseek(file, subreq->p_start, SEEK_DATA);
 	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
 		if (off == (loff_t)-ENXIO) {
 			why = cachefiles_trace_read_seek_nxio;
@@ -382,21 +382,21 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 		goto out;
 	}
 
-	if (off >= subreq->start + subreq->len) {
+	if (off >= subreq->p_start + subreq->len) {
 		why = cachefiles_trace_read_found_hole;
 		goto download_and_store;
 	}
 
-	if (off > subreq->start) {
+	if (off > subreq->p_start) {
 		off = round_up(off, cache->bsize);
-		subreq->len = off - subreq->start;
+		subreq->len = off - subreq->p_start;
 		why = cachefiles_trace_read_found_part;
 		goto download_and_store;
 	}
 
 	to = cachefiles_inject_read_error();
 	if (to == 0)
-		to = vfs_llseek(file, subreq->start, SEEK_HOLE);
+		to = vfs_llseek(file, subreq->p_start, SEEK_HOLE);
 	if (to < 0 && to >= (loff_t)-MAX_ERRNO) {
 		trace_cachefiles_io_error(object, file_inode(file), to,
 					  cachefiles_trace_seek_error);
@@ -404,12 +404,12 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 		goto out;
 	}
 
-	if (to < subreq->start + subreq->len) {
+	if (to < subreq->p_start + subreq->len) {
 		if (subreq->start + subreq->len >= i_size)
 			to = round_up(to, cache->bsize);
 		else
 			to = round_down(to, cache->bsize);
-		subreq->len = to - subreq->start;
+		subreq->len = to - subreq->p_start;
 	}
 
 	why = cachefiles_trace_read_have_data;
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index ca84918b6b5d..077c0ca96612 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -181,7 +181,7 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 			subreq->start + subreq->transferred,
 			subreq->len   - subreq->transferred);
 
-	cres->ops->read(cres, subreq->start, &iter, read_hole,
+	cres->ops->read(cres, subreq->p_start, &iter, read_hole,
 			netfs_cache_read_terminated, subreq);
 }
 
@@ -323,7 +323,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 			netfs_put_subrequest(next, false);
 		}
 
-		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
+		ret = cres->ops->prepare_write(cres, &subreq->p_start, &subreq->len,
 					       rreq->i_size, true);
 		if (ret < 0) {
 			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
@@ -338,7 +338,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 		netfs_stat(&netfs_n_rh_write);
 		netfs_get_read_subrequest(subreq);
 		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
-		cres->ops->write(cres, subreq->start, &iter,
+		cres->ops->write(cres, subreq->p_start, &iter,
 				 netfs_rreq_copy_terminated, subreq);
 	}
 
@@ -760,6 +760,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 
 	subreq->debug_index	= (*_debug_index)++;
 	subreq->start		= rreq->start + rreq->submitted;
+	subreq->p_start		= rreq->p_start + rreq->submitted;
 	subreq->len		= rreq->len   - rreq->submitted;
 
 	_debug("slice %llx,%zx,%zx", subreq->start, subreq->len, rreq->submitted);
@@ -818,8 +819,12 @@ static void netfs_rreq_expand(struct netfs_read_request *rreq,
 {
 	/* Give the cache a chance to change the request parameters.  The
 	 * resultant request must contain the original region.
+	 * Skip expanding if there may be multi-to-multi mapping between
+	 * backing file and backed file.
 	 */
-	netfs_cache_expand_readahead(rreq, &rreq->start, &rreq->len, rreq->i_size);
+	if (rreq->start == rreq->p_start)
+		netfs_cache_expand_readahead(rreq, &rreq->start, &rreq->len,
+					     rreq->i_size);
 
 	/* Give the netfs a chance to change the request parameters.  The
 	 * resultant request must contain the original region.
@@ -884,6 +889,7 @@ void netfs_readahead(struct readahead_control *ractl,
 		goto cleanup;
 	rreq->mapping	= ractl->mapping;
 	rreq->start	= readahead_pos(ractl);
+	rreq->p_start	= rreq->start;
 	rreq->len	= readahead_length(ractl);
 
 	if (ops->begin_cache_operation) {
@@ -964,6 +970,7 @@ int netfs_readpage(struct file *file,
 	}
 	rreq->mapping	= folio_file_mapping(folio);
 	rreq->start	= folio_file_pos(folio);
+	rreq->p_start	= rreq->start;
 	rreq->len	= folio_size(folio);
 
 	if (ops->begin_cache_operation) {
@@ -1129,6 +1136,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		goto error;
 	rreq->mapping		= folio_file_mapping(folio);
 	rreq->start		= folio_file_pos(folio);
+	rreq->p_start		= rreq->start;
 	rreq->len		= folio_size(folio);
 	rreq->no_unlock_folio	= folio_index(folio);
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b46c39d98bbd..a17740b3b9d6 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -134,6 +134,7 @@ struct netfs_read_subrequest {
 	struct netfs_read_request *rreq;	/* Supervising read request */
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	loff_t			start;		/* Where to start the I/O */
+	loff_t			p_start;	/* Start position of backing file */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
 	refcount_t		usage;
@@ -167,6 +168,7 @@ struct netfs_read_request {
 	short			error;		/* 0 or error that occurred */
 	loff_t			i_size;		/* Size of the file */
 	loff_t			start;		/* Start position */
+	loff_t			p_start;	/* Start position of backing file */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
 	refcount_t		usage;
 	unsigned long		flags;
-- 
2.27.0

