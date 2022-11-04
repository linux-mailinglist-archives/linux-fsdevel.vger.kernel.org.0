Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FCB6191DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 08:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKDH1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 03:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDH0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:26:46 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7B16364;
        Fri,  4 Nov 2022 00:26:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTvrbHT_1667546800;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTvrbHT_1667546800)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 15:26:41 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, jlayton@kernel.org, xiang@kernel.org,
        chao@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] erofs: switch to prepare_ondemand_read() in fscache mode
Date:   Fri,  4 Nov 2022 15:26:37 +0800
Message-Id: <20221104072637.72375-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
References: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
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

Switch to prepare_ondemand_read() interface and a self-contained request
completion to get rid of netfs_io_[request|subrequest].

The whole request will still be split into slices (subrequest) according
to the cache state of the backing file.  As long as one of the
subrequests fails, the whole request will be marked as failed. Besides
it will not retry for short read.  Similarly the whole request will fail
if that really happens.  Thus the subrequest structure is not a
necessity here.  What we need is just to hold one refcount to the
request for each subrequest during the slicing, and put the refcount
back during the completion.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 257 ++++++++++++++++-----------------------------
 1 file changed, 92 insertions(+), 165 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 260fa4737fc0..7fc9cd35ab76 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -11,253 +11,176 @@ static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
-static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
+struct erofs_fscache_request {
+	struct netfs_cache_resources cache_resources;
+	struct address_space	*mapping;	/* The mapping being accessed */
+	loff_t			start;		/* Start position */
+	size_t			len;		/* Length of the request */
+	size_t			submitted;	/* Length of submitted */
+	short			error;		/* 0 or error that occurred */
+	refcount_t		ref;
+};
+
+static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_space *mapping,
 					     loff_t start, size_t len)
 {
-	struct netfs_io_request *rreq;
+	struct erofs_fscache_request *req;
 
-	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
-	if (!rreq)
+	req = kzalloc(sizeof(struct erofs_fscache_request), GFP_KERNEL);
+	if (!req)
 		return ERR_PTR(-ENOMEM);
 
-	rreq->start	= start;
-	rreq->len	= len;
-	rreq->mapping	= mapping;
-	rreq->inode	= mapping->host;
-	INIT_LIST_HEAD(&rreq->subrequests);
-	refcount_set(&rreq->ref, 1);
-	return rreq;
-}
-
-static void erofs_fscache_put_request(struct netfs_io_request *rreq)
-{
-	if (!refcount_dec_and_test(&rreq->ref))
-		return;
-	if (rreq->cache_resources.ops)
-		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
-	kfree(rreq);
-}
-
-static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
-{
-	if (!refcount_dec_and_test(&subreq->ref))
-		return;
-	erofs_fscache_put_request(subreq->rreq);
-	kfree(subreq);
-}
-
-static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
+	req->mapping = mapping;
+	req->start   = start;
+	req->len     = len;
+	refcount_set(&req->ref, 1);
 
-	while (!list_empty(&rreq->subrequests)) {
-		subreq = list_first_entry(&rreq->subrequests,
-				struct netfs_io_subrequest, rreq_link);
-		list_del(&subreq->rreq_link);
-		erofs_fscache_put_subrequest(subreq);
-	}
+	return req;
 }
 
-static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
+static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
 {
-	struct netfs_io_subrequest *subreq;
 	struct folio *folio;
-	unsigned int iopos = 0;
-	pgoff_t start_page = rreq->start / PAGE_SIZE;
-	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
-	bool subreq_failed = false;
-
-	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
+	pgoff_t start_page = req->start / PAGE_SIZE;
+	pgoff_t last_page = ((req->start + req->len) / PAGE_SIZE) - 1;
+	bool failed = req->error;
 
-	subreq = list_first_entry(&rreq->subrequests,
-				  struct netfs_io_subrequest, rreq_link);
-	subreq_failed = (subreq->error < 0);
+	XA_STATE(xas, &req->mapping->i_pages, start_page);
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, last_page) {
-		unsigned int pgpos =
-			(folio_index(folio) - start_page) * PAGE_SIZE;
-		unsigned int pgend = pgpos + folio_size(folio);
-		bool pg_failed = false;
-
-		for (;;) {
-			if (!subreq) {
-				pg_failed = true;
-				break;
-			}
-
-			pg_failed |= subreq_failed;
-			if (pgend < iopos + subreq->len)
-				break;
-
-			iopos += subreq->len;
-			if (!list_is_last(&subreq->rreq_link,
-					  &rreq->subrequests)) {
-				subreq = list_next_entry(subreq, rreq_link);
-				subreq_failed = (subreq->error < 0);
-			} else {
-				subreq = NULL;
-				subreq_failed = false;
-			}
-			if (pgend == iopos)
-				break;
-		}
-
-		if (!pg_failed)
+		if (!failed)
 			folio_mark_uptodate(folio);
-
 		folio_unlock(folio);
 	}
 	rcu_read_unlock();
+
+	if (req->cache_resources.ops)
+		req->cache_resources.ops->end_operation(&req->cache_resources);
+
+	kfree(req);
 }
 
-static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
+static void erofs_fscache_req_put(struct erofs_fscache_request *req)
 {
-	erofs_fscache_rreq_unlock_folios(rreq);
-	erofs_fscache_clear_subrequests(rreq);
-	erofs_fscache_put_request(rreq);
+	if (refcount_dec_and_test(&req->ref))
+		erofs_fscache_req_complete(req);
 }
 
-static void erofc_fscache_subreq_complete(void *priv,
+static void erofs_fscache_subreq_complete(void *priv,
 		ssize_t transferred_or_error, bool was_async)
 {
-	struct netfs_io_subrequest *subreq = priv;
-	struct netfs_io_request *rreq = subreq->rreq;
+	struct erofs_fscache_request *req = priv;
 
 	if (IS_ERR_VALUE(transferred_or_error))
-		subreq->error = transferred_or_error;
-
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		erofs_fscache_rreq_complete(rreq);
-
-	erofs_fscache_put_subrequest(subreq);
+		req->error = transferred_or_error;
+	erofs_fscache_req_put(req);
 }
 
 /*
- * Read data from fscache and fill the read data into page cache described by
- * @rreq, which shall be both aligned with PAGE_SIZE. @pstart describes
- * the start physical address in the cache file.
+ * Read data from fscache (cookie, pstart, len), and fill the read data into
+ * page cache described by (req->mapping, lstart, len). @pstart describeis the
+ * start physical address in the cache file.
  */
 static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
-				struct netfs_io_request *rreq, loff_t pstart)
+		struct erofs_fscache_request *req, loff_t pstart, size_t len)
 {
 	enum netfs_io_source source;
-	struct super_block *sb = rreq->mapping->host->i_sb;
-	struct netfs_io_subrequest *subreq;
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	struct super_block *sb = req->mapping->host->i_sb;
+	struct netfs_cache_resources *cres = &req->cache_resources;
 	struct iov_iter iter;
-	loff_t start = rreq->start;
-	size_t len = rreq->len;
+	loff_t lstart = req->start + req->submitted;
 	size_t done = 0;
 	int ret;
 
-	atomic_set(&rreq->nr_outstanding, 1);
+	DBG_BUGON(len > req->len - req->submitted);
 
 	ret = fscache_begin_read_operation(cres, cookie);
 	if (ret)
-		goto out;
+		return ret;
 
 	while (done < len) {
-		subreq = kzalloc(sizeof(struct netfs_io_subrequest),
-				 GFP_KERNEL);
-		if (subreq) {
-			INIT_LIST_HEAD(&subreq->rreq_link);
-			refcount_set(&subreq->ref, 2);
-			subreq->rreq = rreq;
-			refcount_inc(&rreq->ref);
-		} else {
-			ret = -ENOMEM;
-			goto out;
-		}
+		loff_t sstart = pstart + done;
+		size_t slen = len - done;
 
-		subreq->start = pstart + done;
-		subreq->len	=  len - done;
-		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
-
-		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
-
-		source = cres->ops->prepare_read(subreq, LLONG_MAX);
-		if (WARN_ON(subreq->len == 0))
+		source = cres->ops->prepare_ondemand_read(cres, sstart, &slen, LLONG_MAX);
+		if (WARN_ON(slen == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
-			erofs_err(sb, "failed to fscache prepare_read (source %d)",
-				  source);
-			ret = -EIO;
-			subreq->error = ret;
-			erofs_fscache_put_subrequest(subreq);
-			goto out;
+			erofs_err(sb, "failed to fscache prepare_read (source %d)", source);
+			return -EIO;
 		}
 
-		atomic_inc(&rreq->nr_outstanding);
+		refcount_inc(&req->ref);
+		iov_iter_xarray(&iter, READ, &req->mapping->i_pages,
+				lstart + done, slen);
 
-		iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
-				start + done, subreq->len);
-
-		ret = fscache_read(cres, subreq->start, &iter,
-				   NETFS_READ_HOLE_FAIL,
-				   erofc_fscache_subreq_complete, subreq);
+		ret = fscache_read(cres, sstart, &iter, NETFS_READ_HOLE_FAIL,
+				   erofs_fscache_subreq_complete, req);
 		if (ret == -EIOCBQUEUED)
 			ret = 0;
 		if (ret) {
 			erofs_err(sb, "failed to fscache_read (ret %d)", ret);
-			goto out;
+			return ret;
 		}
 
-		done += subreq->len;
+		done += slen;
 	}
-out:
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		erofs_fscache_rreq_complete(rreq);
-
-	return ret;
+	DBG_BUGON(done != len);
+	req->submitted += len;
+	return 0;
 }
 
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 {
 	int ret;
 	struct super_block *sb = folio_mapping(folio)->host->i_sb;
-	struct netfs_io_request *rreq;
+	struct erofs_fscache_request *req;
 	struct erofs_map_dev mdev = {
 		.m_deviceid = 0,
 		.m_pa = folio_pos(folio),
 	};
 
 	ret = erofs_map_dev(sb, &mdev);
-	if (ret)
-		goto out;
+	if (ret) {
+		folio_unlock(folio);
+		return ret;
+	}
 
-	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
+	req = erofs_fscache_req_alloc(folio_mapping(folio),
 				folio_pos(folio), folio_size(folio));
-	if (IS_ERR(rreq)) {
-		ret = PTR_ERR(rreq);
-		goto out;
+	if (IS_ERR(req)) {
+		folio_unlock(folio);
+		return PTR_ERR(req);
 	}
 
-	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-				rreq, mdev.m_pa);
-out:
-	folio_unlock(folio);
+	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
+				req, mdev.m_pa, folio_size(folio));
+	if (ret)
+		req->error = ret;
+
+	erofs_fscache_req_put(req);
 	return ret;
 }
 
 /*
  * Read into page cache in the range described by (@pos, @len).
  *
- * On return, the caller is responsible for page unlocking if the output @unlock
- * is true, or the callee will take this responsibility through netfs_io_request
- * interface.
+ * On return, if the output @unlock is true, the caller is responsible for page
+ * unlocking; otherwise the callee will take this responsibility through request
+ * completion.
  *
  * The return value is the number of bytes successfully handled, or negative
  * error code on failure. The only exception is that, the length of the range
- * instead of the error code is returned on failure after netfs_io_request is
- * allocated, so that .readahead() could advance rac accordingly.
+ * instead of the error code is returned on failure after request is allocated,
+ * so that .readahead() could advance rac accordingly.
  */
 static int erofs_fscache_data_read(struct address_space *mapping,
 				   loff_t pos, size_t len, bool *unlock)
 {
 	struct inode *inode = mapping->host;
 	struct super_block *sb = inode->i_sb;
-	struct netfs_io_request *rreq;
+	struct erofs_fscache_request *req;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
 	struct iov_iter iter;
@@ -314,13 +237,17 @@ static int erofs_fscache_data_read(struct address_space *mapping,
 	if (ret)
 		return ret;
 
-	rreq = erofs_fscache_alloc_request(mapping, pos, count);
-	if (IS_ERR(rreq))
-		return PTR_ERR(rreq);
+	req = erofs_fscache_req_alloc(mapping, pos, count);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	*unlock = false;
-	erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-			rreq, mdev.m_pa + (pos - map.m_la));
+	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
+			req, mdev.m_pa + (pos - map.m_la), count);
+	if (ret)
+		req->error = ret;
+
+	erofs_fscache_req_put(req);
 	return count;
 }
 
-- 
2.19.1.6.gb485710b

