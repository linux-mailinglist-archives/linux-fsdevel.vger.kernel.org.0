Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77951F652
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiEIIDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 04:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiEIHpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 03:45:04 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A123179;
        Mon,  9 May 2022 00:41:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VCgwzGy_1652082063;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VCgwzGy_1652082063)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 15:41:04 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v11 22/22] erofs: change to use asynchronous io for fscache readpage/readahead
Date:   Mon,  9 May 2022 15:40:28 +0800
Message-Id: <20220509074028.74954-23-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
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

From: Xin Yin <yinxin.x@bytedance.com>

Use asynchronous io to read data from fscache may greatly improve IO
bandwidth for sequential buffer read scenario.

Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
and read data from fscache asynchronously.
Make .readpage()/.readahead() to use this new helper.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 239 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 199 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index a402d8f0a063..f23fde003c6d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,57 +5,203 @@
 #include <linux/fscache.h>
 #include "internal.h"
 
+static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
+					     loff_t start, size_t len)
+{
+	struct netfs_io_request *rreq;
+
+	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
+	if (!rreq)
+		return ERR_PTR(-ENOMEM);
+
+	rreq->start	= start;
+	rreq->len	= len;
+	rreq->mapping	= mapping;
+	INIT_LIST_HEAD(&rreq->subrequests);
+	refcount_set(&rreq->ref, 1);
+
+	return rreq;
+}
+
+static void erofs_fscache_put_request(struct netfs_io_request *rreq)
+{
+	if (refcount_dec_and_test(&rreq->ref)) {
+		if (rreq->cache_resources.ops)
+			rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
+		kfree(rreq);
+	}
+}
+
+static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
+{
+	if (refcount_dec_and_test(&subreq->ref)) {
+		erofs_fscache_put_request(subreq->rreq);
+		kfree(subreq);
+	}
+}
+
+static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+
+	while (!list_empty(&rreq->subrequests)) {
+		subreq = list_first_entry(&rreq->subrequests,
+				struct netfs_io_subrequest, rreq_link);
+		list_del(&subreq->rreq_link);
+		erofs_fscache_put_subrequest(subreq);
+	}
+}
+
+static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	struct folio *folio;
+	unsigned int iopos;
+	pgoff_t start_page = rreq->start / PAGE_SIZE;
+	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
+	bool subreq_failed = false;
+
+	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
+
+	subreq = list_first_entry(&rreq->subrequests,
+				  struct netfs_io_subrequest, rreq_link);
+	iopos = 0;
+	subreq_failed = (subreq->error < 0);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, last_page) {
+		unsigned int pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
+		unsigned int pgend = pgpos + folio_size(folio);
+		bool pg_failed = false;
+
+		for (;;) {
+			if (!subreq) {
+				pg_failed = true;
+				break;
+			}
+
+			pg_failed |= subreq_failed;
+			if (pgend < iopos + subreq->len)
+				break;
+
+			iopos += subreq->len;
+			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+				subreq = list_next_entry(subreq, rreq_link);
+				subreq_failed = (subreq->error < 0);
+			} else {
+				subreq = NULL;
+				subreq_failed = false;
+			}
+			if (pgend == iopos)
+				break;
+		}
+
+		if (!pg_failed)
+			folio_mark_uptodate(folio);
+
+		folio_unlock(folio);
+	}
+	rcu_read_unlock();
+}
+
+static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
+{
+	erofs_fscache_rreq_unlock_folios(rreq);
+	erofs_fscache_clear_subrequests(rreq);
+	erofs_fscache_put_request(rreq);
+}
+
+static void erofc_fscache_subreq_complete(void *priv,
+		ssize_t transferred_or_error, bool was_async)
+{
+	struct netfs_io_subrequest *subreq = priv;
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	if (IS_ERR_VALUE(transferred_or_error))
+		subreq->error = transferred_or_error;
+
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		erofs_fscache_rreq_complete(rreq);
+
+	erofs_fscache_put_subrequest(subreq);
+}
+
 /*
  * Read data from fscache and fill the read data into page cache described by
- * @start/len, which shall be both aligned with PAGE_SIZE. @pstart describes
+ * @rreq, which shall be both aligned with PAGE_SIZE. @pstart describes
  * the start physical address in the cache file.
  */
-static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
-				     struct address_space *mapping,
-				     loff_t start, size_t len,
+static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
+				     struct netfs_io_request *rreq,
 				     loff_t pstart)
 {
 	enum netfs_io_source source;
-	struct netfs_io_request rreq = {};
-	struct netfs_io_subrequest subreq = { .rreq = &rreq, };
-	struct netfs_cache_resources *cres = &rreq.cache_resources;
-	struct super_block *sb = mapping->host->i_sb;
+	struct super_block *sb = rreq->mapping->host->i_sb;
+	struct netfs_io_subrequest *subreq;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct iov_iter iter;
+	loff_t start = rreq->start;
+	size_t len = rreq->len;
 	size_t done = 0;
 	int ret;
 
+	atomic_set(&rreq->nr_outstanding, 1);
+
 	ret = fscache_begin_read_operation(cres, cookie);
 	if (ret)
-		return ret;
+		goto out;
 
 	while (done < len) {
-		subreq.start = pstart + done;
-		subreq.len = len - done;
-		subreq.flags = 1 << NETFS_SREQ_ONDEMAND;
+		subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
+		if (subreq) {
+			INIT_LIST_HEAD(&subreq->rreq_link);
+			refcount_set(&subreq->ref, 2);
+			subreq->rreq = rreq;
+			refcount_inc(&rreq->ref);
+		} else {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		subreq->start = pstart + done;
+		subreq->len	=  len - done;
+		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
 
-		source = cres->ops->prepare_read(&subreq, LLONG_MAX);
-		if (WARN_ON(subreq.len == 0))
+		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+
+		source = cres->ops->prepare_read(subreq, LLONG_MAX);
+		if (WARN_ON(subreq->len == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
 			erofs_err(sb, "failed to fscache prepare_read (source %d)",
 				  source);
 			ret = -EIO;
+			subreq->error = ret;
+			erofs_fscache_put_subrequest(subreq);
 			goto out;
 		}
 
-		iov_iter_xarray(&iter, READ, &mapping->i_pages,
-				start + done, subreq.len);
-		ret = fscache_read(cres, subreq.start, &iter,
-				   NETFS_READ_HOLE_FAIL, NULL, NULL);
+		atomic_inc(&rreq->nr_outstanding);
+
+		iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
+				start + done, subreq->len);
+
+		ret = fscache_read(cres, subreq->start, &iter,
+				   NETFS_READ_HOLE_FAIL,
+				   erofc_fscache_subreq_complete, subreq);
+		if (ret == -EIOCBQUEUED)
+			ret = 0;
 		if (ret) {
 			erofs_err(sb, "failed to fscache_read (ret %d)", ret);
 			goto out;
 		}
 
-		done += subreq.len;
+		done += subreq->len;
 	}
 out:
-	fscache_end_operation(cres);
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		erofs_fscache_rreq_complete(rreq);
+
 	return ret;
 }
 
@@ -64,6 +210,7 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
 	int ret;
 	struct folio *folio = page_folio(page);
 	struct super_block *sb = folio_mapping(folio)->host->i_sb;
+	struct netfs_io_request *rreq;
 	struct erofs_map_dev mdev = {
 		.m_deviceid = 0,
 		.m_pa = folio_pos(folio),
@@ -73,11 +220,13 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
 	if (ret)
 		goto out;
 
-	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
-			folio_mapping(folio), folio_pos(folio),
-			folio_size(folio), mdev.m_pa);
-	if (!ret)
-		folio_mark_uptodate(folio);
+	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
+				folio_pos(folio), folio_size(folio));
+	if (IS_ERR(rreq))
+		goto out;
+
+	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
+				rreq, mdev.m_pa);
 out:
 	folio_unlock(folio);
 	return ret;
@@ -117,6 +266,7 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	struct super_block *sb = inode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
+	struct netfs_io_request *rreq;
 	erofs_off_t pos;
 	loff_t pstart;
 	int ret;
@@ -149,10 +299,15 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	if (ret)
 		goto out_unlock;
 
+
+	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
+				folio_pos(folio), folio_size(folio));
+	if (IS_ERR(rreq))
+		goto out_unlock;
+
 	pstart = mdev.m_pa + (pos - map.m_la);
-	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
-			folio_mapping(folio), folio_pos(folio),
-			folio_size(folio), pstart);
+	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
+				rreq, pstart);
 
 out_uptodate:
 	if (!ret)
@@ -162,15 +317,16 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-static void erofs_fscache_unlock_folios(struct readahead_control *rac,
-					size_t len)
+static void erofs_fscache_advance_folios(struct readahead_control *rac,
+					size_t len, bool unlock)
 {
 	while (len) {
 		struct folio *folio = readahead_folio(rac);
-
 		len -= folio_size(folio);
-		folio_mark_uptodate(folio);
-		folio_unlock(folio);
+		if (unlock) {
+			folio_mark_uptodate(folio);
+			folio_unlock(folio);
+		}
 	}
 }
 
@@ -192,6 +348,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 	do {
 		struct erofs_map_blocks map;
 		struct erofs_map_dev mdev;
+		struct netfs_io_request *rreq;
 
 		pos = start + done;
 		map.m_la = pos;
@@ -211,7 +368,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 					offset, count);
 			iov_iter_zero(count, &iter);
 
-			erofs_fscache_unlock_folios(rac, count);
+			erofs_fscache_advance_folios(rac, count, true);
 			ret = count;
 			continue;
 		}
@@ -237,15 +394,17 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 		if (ret)
 			return;
 
-		ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
-				rac->mapping, offset, count,
-				mdev.m_pa + (pos - map.m_la));
+		rreq = erofs_fscache_alloc_request(rac->mapping, offset, count);
+		if (IS_ERR(rreq))
+			return;
 		/*
-		 * For the error cases, the folios will be unlocked when
-		 * .readahead() returns.
+		 * Drop the ref of folios here. Unlock them in
+		 * rreq_unlock_folios() when rreq complete.
 		 */
+		erofs_fscache_advance_folios(rac, count, false);
+		ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
+					rreq, mdev.m_pa + (pos - map.m_la));
 		if (!ret) {
-			erofs_fscache_unlock_folios(rac, count);
 			ret = count;
 		}
 	} while (ret > 0 && ((done += ret) < len));
-- 
2.27.0

