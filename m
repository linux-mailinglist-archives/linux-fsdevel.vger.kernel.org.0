Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4525146C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355459AbiD2K3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 06:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357175AbiD2K3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:29:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5E90CCC
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 03:26:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s14so6758033plk.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7v46THN9FW5FCtzg2pkw8vTHUChlhQMuA6c8DpWkVlI=;
        b=4mF8fW6SoHrUXtxgzOmHn08NiAe8Kib3bUIdrSzR4zWQ3Pi0r/PA2LbM4j87mWjnX7
         OU3IgsFoOILD4g8Yq0sjwXibVXE1WMrqR8ARow6hPfO0ZSwYJsuzWnReAcin0F8kGvET
         2StVLsEbt/3RRXcXqcHSq3A6/S96aCKU38knLIjPP8ZqR32cGjK4Mjw4nEwicQ9B9VRc
         rfW3TdzbE+i0oKHxKp/gwPZ8st9OT1pAV7BW4F+dNpY9/sXDbE6g7z7S4hcS+oui6AJB
         v64WhdAzA6DxOOMVxwC2/n5Sp/qZWxVZOJytRnLomT4gcQ5jUostmPtdjHW1+ueEOwbe
         qrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7v46THN9FW5FCtzg2pkw8vTHUChlhQMuA6c8DpWkVlI=;
        b=LwTZwdwpkt/1BUgXoY0XZ7y8Ez6+AUxX9gG6vtQ1Qfn+r+/7eXPqyYQvvGE6ImeQCJ
         Xl5HT22NlvYBHe2f5Yy78LPQU/1pcnog4d3BT1cP/FlsDuA6Y5eOWNyXzqubseEmRZ8h
         sEU/GQJxSEmEx94MUytmVObF3I9i22/HgYlhmoxnKQ/TlH8oLY0WzZszwq7ipMKjgAQL
         g2nhD7Rim1OYyIwZ1Ow8vImagfmHIEaD9xAE27y5uXl/J0VlZhJhaA9IBJy+y1hYPNaQ
         lIKniv3K9D/ZxAv1KqzRVy+m/ZVqyldJh4jy04zOtMpTtcwYpMfNLJSs21C1+cIUkJVP
         ZGiQ==
X-Gm-Message-State: AOAM533ivQDiSF9W6SkYzgA/yQkjIU2EYXSKSPwsle1hLzH/Ne3qwnQF
        jcnCMkPbVtLOJfaTaIE2GSUKK9sO0bwpww==
X-Google-Smtp-Source: ABdhPJwbs+BsnrXencDJYY7fXsOiBR5tkGzb+MXY1lSDTrJ3nAc6riAD7LUMe2iAvSm0446/tTgIeg==
X-Received: by 2002:a17:90b:1a8f:b0:1d2:acdc:71d2 with SMTP id ng15-20020a17090b1a8f00b001d2acdc71d2mr3106237pjb.41.1651227978278;
        Fri, 29 Apr 2022 03:26:18 -0700 (PDT)
Received: from yinxin.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id l5-20020a63ea45000000b003c1b2bea056sm1042659pgk.84.2022.04.29.03.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 03:26:17 -0700 (PDT)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     jefflexu@linux.alibaba.com, xiang@kernel.org, dhowells@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, Xin Yin <yinxin.x@bytedance.com>
Subject: [RFC PATCH 1/1] erofs: change to use asynchronous io for fscache readahead
Date:   Fri, 29 Apr 2022 07:38:49 +0800
Message-Id: <20220428233849.321495-2-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428233849.321495-1-yinxin.x@bytedance.com>
References: <20220428233849.321495-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add erofs_fscache_read_folios_async helper which has same on-demand
read logic with erofs_fscache_read_folios, also support asynchronously
read data from fscache.And change .readahead() to use this new helper.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/erofs/fscache.c | 256 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 245 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index eaa50692ddba..4241f1cdc30b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,6 +5,231 @@
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
+	erofs_fscache_clear_subrequests(rreq);
+	if (rreq->cache_resources.ops)
+		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
+	kfree(rreq);
+}
+
+static void erofs_fscache_put_request(struct netfs_io_request *rreq)
+{
+	bool dead;
+
+	dead = refcount_dec_and_test(&rreq->ref);
+	if (dead)
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
+	bool dead;
+
+	dead = refcount_dec_and_test(&subreq->ref);
+	if (dead)
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
+static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
+				     struct netfs_io_request *rreq,
+				     loff_t start, size_t len,
+				     loff_t pstart)
+{
+	enum netfs_io_source source;
+	struct netfs_io_subrequest *subreq;
+	struct netfs_cache_resources *cres;
+	struct iov_iter iter;
+	size_t done = 0;
+	int ret;
+
+	atomic_set(&rreq->nr_outstanding, 1);
+
+	cres = &rreq->cache_resources;
+	ret = fscache_begin_read_operation(cres, cookie);
+	if (ret)
+		goto out;
+
+	while (done < len) {
+		subreq = erofs_fscache_alloc_subrequest(rreq);
+		if (!subreq) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		subreq->start = pstart + done;
+		subreq->len	=  len - done;
+		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
+
+		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+
+		source = cres->ops->prepare_read(subreq, LLONG_MAX);
+		if (WARN_ON(subreq->len == 0))
+			source = NETFS_INVALID_READ;
+		if (source != NETFS_READ_FROM_CACHE) {
+			ret = -EIO;
+			erofs_fscache_put_subrequest(subreq);
+			goto out;
+		}
+
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
+		if (ret) {
+			erofs_fscache_put_subrequest(subreq);
+			goto out;
+		}
+
+		done += subreq->len;
+	}
+out:
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		erofs_fscache_rreq_complete(rreq);
+
+	return ret;
+}
+
 /*
  * Read data from fscache and fill the read data into page cache described by
  * @start/len, which shall be both aligned with PAGE_SIZE. @pstart describes
@@ -163,15 +388,16 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
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
 
@@ -193,6 +419,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 	do {
 		struct erofs_map_blocks map;
 		struct erofs_map_dev mdev;
+		struct netfs_io_request *rreq;
 
 		pos = start + done;
 		map.m_la = pos;
@@ -212,7 +439,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 					offset, count);
 			iov_iter_zero(count, &iter);
 
-			erofs_fscache_unlock_folios(rac, count);
+			erofs_fscache_readahead_folios(rac, count, true);
 			ret = count;
 			continue;
 		}
@@ -238,13 +465,20 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 		if (ret)
 			return;
 
-		ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
-				rac->mapping, offset, count,
+		rreq = erofs_fscache_alloc_request(rac->mapping, offset, count);
+		if (IS_ERR(rreq))
+			return;
+		/*
+		 * Drop the ref of folios here. Unlock them in
+		 * rreq_unlock_folios() when rreq complete.
+		 */
+		erofs_fscache_readahead_folios(rac, count, false);
+		ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
+				rreq, offset, count,
 				mdev.m_pa + (pos - map.m_la));
-		if (!ret) {
-			erofs_fscache_unlock_folios(rac, count);
+
+		if (!ret)
 			ret = count;
-		}
 	} while (ret > 0 && ((done += ret) < len));
 }
 
-- 
2.11.0

