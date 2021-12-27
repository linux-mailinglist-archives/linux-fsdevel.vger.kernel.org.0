Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E847FCE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhL0MzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:12 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:35575 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236934AbhL0MzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.xJoSA_1640609704;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.xJoSA_1640609704)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:05 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 17/23] netfs: support on demand read
Date:   Mon, 27 Dec 2021 20:54:38 +0800
Message-Id: <20211227125444.21187-18-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add demand_read() callback to netfs_cache_ops to implement demand
reading.

The precondition for implementing demand reading semantic is that, all
blob files are sparse and have been placed under corresponding directory
on the first beginning. When upper fs starts to access the blob file, it
will "cache miss" (hit the hole) and then .issue_op() callback will be
called to prepare the data.

Then the working flow is as described below. The .issue_op() callback
could be implemented by netfs_demand_read() helper, which will in turn
call .demand_read() callback of corresponding fscache backend to prepare
the data.

The implementation of .demand_read() callback can be backend specific.
The following patch will introduce an implementation of .demand_read()
callback for cachefiles, which will notify user daemon the requested
file range to read. The .demand_read() callback will get blocked until
the user daemon has prepared the corresponding data.

Then once .demand_read() callback returns with 0, it is guaranteed that
the requested data has been ready. In this case, transform this IO
request to NETFS_READ_FROM_CACHE state, initiate an incomplete
completion and then retry to read from backing file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 26 ++++++++++++++++++++++++++
 include/linux/netfs.h  |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index ca84918b6b5d..8aac65132b67 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1006,6 +1006,32 @@ int netfs_readpage(struct file *file,
 }
 EXPORT_SYMBOL(netfs_readpage);
 
+void netfs_demand_read(struct netfs_read_subrequest *subreq)
+{
+	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	loff_t start_pos;
+	size_t len;
+	int ret;
+
+	start_pos = subreq->start + subreq->transferred;
+	len = subreq->len - subreq->transferred;
+
+	/*
+	 * In success case (ret == 0), user daemon has downloaded data for us,
+	 * thus transform to NETFS_READ_FROM_CACHE state and advertise that 0
+	 * byte readed, so that the request will enter into INCOMPLETE state and
+	 * retry to read from backing file.
+	 */
+	ret = cres->ops->demand_read(cres, start_pos, len);
+	if (!ret) {
+		subreq->source = NETFS_READ_FROM_CACHE;
+		__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+	}
+
+	netfs_subreq_terminated(subreq, ret, false);
+}
+
 /*
  * Prepare a folio for writing without reading first
  * @folio: The folio being prepared
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b46c39d98bbd..80a738762deb 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -244,6 +244,9 @@ struct netfs_cache_ops {
 	int (*prepare_write)(struct netfs_cache_resources *cres,
 			     loff_t *_start, size_t *_len, loff_t i_size,
 			     bool no_space_allocated_yet);
+
+	int (*demand_read)(struct netfs_cache_resources *cres,
+			   loff_t start_pos, size_t len);
 };
 
 struct readahead_control;
@@ -259,6 +262,7 @@ extern int netfs_write_begin(struct file *, struct address_space *,
 			     void **,
 			     const struct netfs_read_request_ops *,
 			     void *);
+extern void netfs_demand_read(struct netfs_read_subrequest *);
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
-- 
2.27.0

