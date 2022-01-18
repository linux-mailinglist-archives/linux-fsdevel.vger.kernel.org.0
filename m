Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76604492687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbiARNMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:12:25 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49075 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242031AbiARNMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2C5CnK_1642511540;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2C5CnK_1642511540)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:20 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/20] netfs,fscache: support on-demand reading
Date:   Tue, 18 Jan 2022 21:11:59 +0800
Message-Id: <20220118131216.85338-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add ondemand_read() callback to netfs_cache_ops to implement on-demand
reading.

The precondition for implementing on-demand reading semantic is that,
all blob files have been placed under corresponding directory with
correct file size (sparse files) on the first beginning. When upper fs
starts to access the blob file, it will "cache miss" (hit the hole) and
then .issue_op() callback will be called to prepare the data.

The following working flow is described as below. The .issue_op()
callback could be implemented by netfs_ondemand_read() helper, which
will in turn call .ondemand_read() callback of corresponding fscache
backend to prepare the data.

The implementation of .ondemand_read() callback can be backend specific.
The following patch will introduce an implementation of .ondemand_read()
callback for cachefiles, which will notify user daemon the requested
file range to read. The .ondemand_read() callback will get blocked until
the user daemon has prepared the corresponding data.

Then once .ondemand_read() callback returns with 0, it is guaranteed
that the requested data has been ready. In this case, transform this IO
request to NETFS_READ_FROM_CACHE state, initiate an incomplete
completion and then retry to read from backing file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fscache/Kconfig     |  8 ++++++++
 fs/netfs/Kconfig       |  8 ++++++++
 fs/netfs/read_helper.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h  |  8 ++++++++
 4 files changed, 61 insertions(+)

diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index 76316c4a3fb7..f6b5396759ee 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -41,3 +41,11 @@ config FSCACHE_DEBUG
 
 config FSCACHE_OLD_API
 	bool
+
+config FSCACHE_ONDEMAND
+	bool "Support for on-demand reading"
+	depends on FSCACHE
+	select NETFS_ONDEMAND
+	help
+	  This permits on-demand reading with fscache.
+	  If unsure, say N.
diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index b4db21022cb4..c4bdd0b032dd 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -21,3 +21,11 @@ config NETFS_STATS
 	  multi-CPU system these may be on cachelines that keep bouncing
 	  between CPUs.  On the other hand, the stats are very useful for
 	  debugging purposes.  Saying 'Y' here is recommended.
+
+config NETFS_ONDEMAND
+	bool "Support for on-demand reading"
+	depends on NETFS_SUPPORT
+	default n
+	help
+	  This enables on-demand reading with netfs API.
+	  If unsure, say N.
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 077c0ca96612..b84c184c365d 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1013,6 +1013,43 @@ int netfs_readpage(struct file *file,
 }
 EXPORT_SYMBOL(netfs_readpage);
 
+#ifdef CONFIG_NETFS_ONDEMAND
+void netfs_ondemand_read(struct netfs_read_subrequest *subreq)
+{
+	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	loff_t start_pos;
+	size_t len;
+	int ret = -ENOBUFS;
+
+	/* The cache backend may not be accessible at this moment. */
+	if (!cres->ops)
+		goto out;
+
+	if (!cres->ops->ondemand_read) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	start_pos = subreq->p_start + subreq->transferred;
+	len = subreq->len - subreq->transferred;
+
+	/*
+	 * In success case (ret == 0), user daemon has prepared data for
+	 * us, thus transform to NETFS_READ_FROM_CACHE state and
+	 * advertise that 0 byte readed, so that the request will enter
+	 * into INCOMPLETE state and retry to read from backing file.
+	 */
+	ret = cres->ops->ondemand_read(cres, start_pos, len);
+	if (!ret) {
+		subreq->source = NETFS_READ_FROM_CACHE;
+		__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+	}
+out:
+	netfs_subreq_terminated(subreq, ret, false);
+}
+#endif
+
 /*
  * Prepare a folio for writing without reading first
  * @folio: The folio being prepared
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a17740b3b9d6..d6e041293dcc 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -246,6 +246,11 @@ struct netfs_cache_ops {
 	int (*prepare_write)(struct netfs_cache_resources *cres,
 			     loff_t *_start, size_t *_len, loff_t i_size,
 			     bool no_space_allocated_yet);
+
+#ifdef CONFIG_NETFS_ONDEMAND
+	int (*ondemand_read)(struct netfs_cache_resources *cres,
+			     loff_t start_pos, size_t len);
+#endif
 };
 
 struct readahead_control;
@@ -261,6 +266,9 @@ extern int netfs_write_begin(struct file *, struct address_space *,
 			     void **,
 			     const struct netfs_read_request_ops *,
 			     void *);
+#ifdef CONFIG_NETFS_ONDEMAND
+extern void netfs_ondemand_read(struct netfs_read_subrequest *);
+#endif
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
-- 
2.27.0

