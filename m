Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A824546FBAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhLJHkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:11 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36090 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237639AbhLJHkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8E0Pr_1639121788;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8E0Pr_1639121788)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:28 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 07/19] netfs: add netfs_readpage_demand()
Date:   Fri, 10 Dec 2021 15:36:07 +0800
Message-Id: <20211210073619.21667-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

netfs_readpage_demand() is the demand-read version of
netfs_readpage().

When netfs API works in demand-read mode, fs using fscache shall call
netfs_readpage_demand() instead.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h  |  3 ++
 2 files changed, 66 insertions(+)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 9240b85548e4..26fa688f6300 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1022,6 +1022,69 @@ int netfs_readpage(struct file *file,
 }
 EXPORT_SYMBOL(netfs_readpage);
 
+int netfs_readpage_demand(struct folio *folio,
+			  const struct netfs_read_request_ops *ops,
+			  void *netfs_priv)
+{
+	struct netfs_read_request *rreq;
+	unsigned int debug_index = 0;
+	int ret;
+
+	_enter("%lx", folio_index(folio));
+
+	rreq = __netfs_alloc_read_request(ops, netfs_priv, NULL);
+	if (!rreq) {
+		if (netfs_priv)
+			ops->cleanup(netfs_priv, folio_file_mapping(folio));
+		folio_unlock(folio);
+		return -ENOMEM;
+	}
+	rreq->type	= NETFS_TYPE_DEMAND;
+	rreq->folio	= folio;
+	rreq->start	= folio_file_pos(folio);
+	rreq->len	= folio_size(folio);
+	__set_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags);
+
+	if (ops->begin_cache_operation) {
+		ret = ops->begin_cache_operation(rreq);
+		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS) {
+			folio_unlock(folio);
+			goto out;
+		}
+	}
+
+	netfs_stat(&netfs_n_rh_readpage);
+	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
+
+	netfs_get_read_request(rreq);
+
+	atomic_set(&rreq->nr_rd_ops, 1);
+	do {
+		if (!netfs_rreq_submit_slice(rreq, &debug_index))
+			break;
+
+	} while (rreq->submitted < rreq->len);
+
+	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	 * the service code isn't punted off to a random thread pool to
+	 * process.
+	 */
+	do {
+		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		netfs_rreq_assess(rreq, false);
+	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
+
+	ret = rreq->error;
+	if (ret == 0 && rreq->submitted < rreq->len) {
+		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_readpage);
+		ret = -EIO;
+	}
+out:
+	netfs_put_read_request(rreq, false);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_readpage_demand);
+
 /*
  * Prepare a folio for writing without reading first
  * @folio: The folio being prepared
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 638ea5d63869..de6948bcc80a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -261,6 +261,9 @@ extern int netfs_readpage(struct file *,
 			  struct folio *,
 			  const struct netfs_read_request_ops *,
 			  void *);
+extern int netfs_readpage_demand(struct folio *,
+				 const struct netfs_read_request_ops *,
+				 void *);
 extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, unsigned int, struct folio **,
 			     void **,
-- 
2.27.0

