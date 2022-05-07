Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F8151E568
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 10:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiEGIJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383661AbiEGIJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 04:09:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6A3896
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 01:05:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c11so9475249plg.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYcPd0MQxHUPXqVL5jcdvctPEGzrAERH9GCiXfWUSis=;
        b=d4QKikY++YzRipjx9XnndIvQ+TJlZJR9ozfwsPfL2BrB168+B6MHfWaexGxp5rWFGt
         2tuJT3ngQ6PjHhG4+6rJGjTFmc31O3qSs/P1fwGePR8xS4DlA+BZM65dSpJZsuBG3vyW
         gZPol05eRs4AXKDLUlkj5mFVOfM24oy+q0uQ4ifxPPWb1ae4rELinQ34jskh87gFimZ/
         Fs0ZGpoFTTlVlhdWr8CzzVDX2X+j1OhjalYztraUVFxlZdA+UyE2zJSnqvj7+2xLvErQ
         d7kWwIGyF3qLouK3526gqDUnh/4eScjlPb3pV7iDrTjqGXKuVjriFH69IwLsFlBcpY5q
         7+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYcPd0MQxHUPXqVL5jcdvctPEGzrAERH9GCiXfWUSis=;
        b=LAwrm7UzgNtnzBiaIuFy+xpCn4Lll3L6remijx1TCqwH5xdevpgEqyHHD3it86G7g0
         JPj2boP6KO0joWa/YCVu8uTa2wihLyLr6+Suxpylx9C0HP6Pgx3jWATA6w4ZD7Zg5e7m
         MOa20u5JHOQ9JEby1dPBjOmjmqrpg/3OcDk2pkUc3DQs9gNesYPmpu9Aby5VVZwELfGM
         mj1LCk6dqQ7rVYV7NPSoU36+uLTL4fFVwheUUd1oOWQqLy054jupTqnaGNYmHpfA+aOn
         U3xCWv3jWwx5eawL+OX8qUArSFiKLSq/KYlU1rwwG6wi+Gjt+aw9JX1gd80kUpEJoKjW
         9u0w==
X-Gm-Message-State: AOAM533g+iMJvE5qtS0EvfOYTW904ilmWoU0IGDN68xAilxs2lHjvy8j
        Z/s66OeTPpxpxMBwv19EyDBzIw==
X-Google-Smtp-Source: ABdhPJzHIpQmCv80In7saPxlOvp1al9xletYiFnAf1Ensp72xC/47OZ2Li7XRb2TG4U3uQImV8ybeQ==
X-Received: by 2002:a17:902:7e0d:b0:158:cedb:3683 with SMTP id b13-20020a1709027e0d00b00158cedb3683mr7467215plm.108.1651910730500;
        Sat, 07 May 2022 01:05:30 -0700 (PDT)
Received: from yinxin.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902ee4600b0015e8d4eb1desm3047133plo.40.2022.05.07.01.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:05:29 -0700 (PDT)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
        dhowells@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH] erofs: change to use asyncronous io for fscache readpage/readahead
Date:   Sat,  7 May 2022 12:48:09 +0800
Message-Id: <20220507044809.16129-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use asyncronous io to read data from fscache may greatly improve IO
bandwidth for sequential buffer read scenario.

Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
and read data from fscache asyncronously. Make .readpage()/.readahead()
to use this new helper.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
changes from RFC:
1.rebase to fscache,erofs: fscache-based on-demand read semantics v10.
2.fix issues pointed out by Jeffle.
3.simplify parameters, add debug messages for erofs_fscache_read_folios_async.
4.also change .readpage() to use new helper to avoid code duplication.

I verified this patch introduces no regressions with tests in
https://github.com/lostjeffle/demand-read-cachefilesd.
---
 fs/erofs/fscache.c | 267 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 227 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index a402d8f0a063..2606bf4145f8 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,57 +5,231 @@
 #include <linux/fscache.h>
 #include "internal.h"
 
+static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq);
+
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
+static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+
+	while (!list_empty(&rreq->subrequests)) {
+		subreq = list_first_entry(&rreq->subrequests,
+					  struct netfs_io_subrequest, rreq_link);
+		list_del(&subreq->rreq_link);
+		erofs_fscache_put_subrequest(subreq);
+	}
+}
+
+static void erofs_fscache_free_request(struct netfs_io_request *rreq)
+{
+	if (rreq->cache_resources.ops)
+		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
+	kfree(rreq);
+}
+
+static void erofs_fscache_put_request(struct netfs_io_request *rreq)
+{
+	if (refcount_dec_and_test(&rreq->ref))
+		erofs_fscache_free_request(rreq);
+}
+
+
+static struct netfs_io_subrequest *
+	erofs_fscache_alloc_subrequest(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+
+	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
+	if (subreq) {
+		INIT_LIST_HEAD(&subreq->rreq_link);
+		refcount_set(&subreq->ref, 2);
+		subreq->rreq = rreq;
+		refcount_inc(&rreq->ref);
+	}
+
+	return subreq;
+}
+
+static void erofs_fscache_free_subrequest(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	kfree(subreq);
+	erofs_fscache_put_request(rreq);
+}
+
+static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
+{
+	if (refcount_dec_and_test(&subreq->ref))
+		erofs_fscache_free_subrequest(subreq);
+}
+
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
+
+static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
+{
+	erofs_fscache_rreq_unlock_folios(rreq);
+	erofs_fscache_clear_subrequests(rreq);
+	erofs_fscache_put_request(rreq);
+}
+
+static void erofc_fscache_subreq_complete(void *priv, ssize_t transferred_or_error,
+					bool was_async)
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
+	struct netfs_cache_resources *cres;
 	struct iov_iter iter;
+	loff_t start = rreq->start;
+	size_t len = rreq->len;
 	size_t done = 0;
 	int ret;
 
+	atomic_set(&rreq->nr_outstanding, 1);
+
+	cres = &rreq->cache_resources;
 	ret = fscache_begin_read_operation(cres, cookie);
 	if (ret)
-		return ret;
+		goto out;
 
 	while (done < len) {
-		subreq.start = pstart + done;
-		subreq.len = len - done;
-		subreq.flags = 1 << NETFS_SREQ_ONDEMAND;
+		subreq = erofs_fscache_alloc_subrequest(rreq);
+		if (!subreq) {
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
+				   NETFS_READ_HOLE_FAIL, erofc_fscache_subreq_complete, subreq);
+
+		if (ret == -EIOCBQUEUED)
+			ret = 0;
+
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
 
@@ -64,6 +238,7 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
 	int ret;
 	struct folio *folio = page_folio(page);
 	struct super_block *sb = folio_mapping(folio)->host->i_sb;
+	struct netfs_io_request *rreq;
 	struct erofs_map_dev mdev = {
 		.m_deviceid = 0,
 		.m_pa = folio_pos(folio),
@@ -73,11 +248,13 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
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
@@ -117,6 +294,7 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	struct super_block *sb = inode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
+	struct netfs_io_request *rreq;
 	erofs_off_t pos;
 	loff_t pstart;
 	int ret;
@@ -149,10 +327,15 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
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
@@ -162,15 +345,16 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-static void erofs_fscache_unlock_folios(struct readahead_control *rac,
-					size_t len)
+static void erofs_fscache_readahead_folios(struct readahead_control *rac,
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
 
@@ -192,6 +376,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 	do {
 		struct erofs_map_blocks map;
 		struct erofs_map_dev mdev;
+		struct netfs_io_request *rreq;
 
 		pos = start + done;
 		map.m_la = pos;
@@ -211,7 +396,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 					offset, count);
 			iov_iter_zero(count, &iter);
 
-			erofs_fscache_unlock_folios(rac, count);
+			erofs_fscache_readahead_folios(rac, count, true);
 			ret = count;
 			continue;
 		}
@@ -237,15 +422,17 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
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
+		erofs_fscache_readahead_folios(rac, count, false);
+		ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
+					rreq, mdev.m_pa + (pos - map.m_la));
 		if (!ret) {
-			erofs_fscache_unlock_folios(rac, count);
 			ret = count;
 		}
 	} while (ret > 0 && ((done += ret) < len));
-- 
2.11.0

