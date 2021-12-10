Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2590946FBAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhLJHkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:13 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42965 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237641AbhLJHkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8PLPo_1639121789;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8PLPo_1639121789)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:29 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 08/19] netfs: refactor netfs_clear_unread()
Date:   Fri, 10 Dec 2021 15:36:08 +0800
Message-Id: <20211210073619.21667-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In demand-read case, the input folio of netfs API is may not the page
cache inside the address space of the netfs file. Instead it may be just
a temporary page used to contain the data.

In this case, use bvec based iov_iter.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 33 +++++++++++++++++++++++++++------
 include/linux/netfs.h  |  2 ++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 26fa688f6300..04d0cc2fca83 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -157,6 +157,18 @@ static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
 	netfs_put_read_request(rreq, was_async);
 }
 
+static void netfs_init_iov_iter_bvec(struct netfs_read_subrequest *subreq,
+				     struct iov_iter *iter)
+{
+	struct bio_vec *bvec = &subreq->bvec;
+
+	bvec->bv_page	= folio_page(subreq->rreq->folio, 0);
+	bvec->bv_offset	= subreq->start + subreq->transferred;
+	bvec->bv_len	= subreq->len   - subreq->transferred;
+
+	iov_iter_bvec(iter, READ, bvec, 1, bvec->bv_len);
+}
+
 /*
  * Clear the unread part of an I/O request.
  */
@@ -164,9 +176,14 @@ static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
 {
 	struct iov_iter iter;
 
-	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
-			subreq->start + subreq->transferred,
-			subreq->len   - subreq->transferred);
+	if (subreq->rreq->type == NETFS_TYPE_CACHE) {
+		iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
+				subreq->start + subreq->transferred,
+				subreq->len   - subreq->transferred);
+	} else { /* type == NETFS_TYPE_DEMAND */
+		netfs_init_iov_iter_bvec(subreq, &iter);
+	}
+
 	iov_iter_zero(iov_iter_count(&iter), &iter);
 }
 
@@ -190,9 +207,13 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 	struct iov_iter iter;
 
 	netfs_stat(&netfs_n_rh_read);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
-			subreq->start + subreq->transferred,
-			subreq->len   - subreq->transferred);
+	if (subreq->rreq->type == NETFS_TYPE_CACHE) {
+		iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
+				subreq->start + subreq->transferred,
+				subreq->len   - subreq->transferred);
+	} else { /* type == NETFS_TYPE_DEMAND */
+		netfs_init_iov_iter_bvec(subreq, &iter);
+	}
 
 	cres->ops->read(cres, subreq->start, &iter, read_hole,
 			netfs_cache_read_terminated, subreq);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index de6948bcc80a..5f45eb31defd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/bvec.h>
 
 /*
  * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
@@ -146,6 +147,7 @@ struct netfs_read_subrequest {
 #define NETFS_SREQ_SHORT_READ		2	/* Set if there was a short read from the cache */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
+	struct bio_vec 		bvec;
 };
 
 enum netfs_read_request_type {
-- 
2.27.0

