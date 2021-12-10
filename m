Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6146FBBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhLJHkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:31 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:27308 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237801AbhLJHkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8E0Pg_1639121786;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8E0Pg_1639121786)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:27 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 06/19] netfs: add type field to struct netfs_read_request
Date:   Fri, 10 Dec 2021 15:36:06 +0800
Message-Id: <20211210073619.21667-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fscache/cachefiles used to serve as a local cache for remote fs.
This patch set introduces a new use case, in which local read-only
fs could implement demand read with fscache.

Thus 'type' field is used to distinguish which mode netfs API works in.

Besides, in demand-read case, local fs using fscache for demand-read
can't offer and also doesn't need the file handle of the netfs file. The
input folio of netfs_readpage() is may not a page cache inside the
address space of the netfs file, and may be just a temporary page
containing the data. What netfs API needs to do is just move data from
backing file the the input folio. Thus buffer the folio in 'struct
netfs_read_request'.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/netfs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b46c39d98bbd..638ea5d63869 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -148,6 +148,11 @@ struct netfs_read_subrequest {
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
 };
 
+enum netfs_read_request_type {
+	NETFS_TYPE_CACHE,
+	NETFS_TYPE_DEMAND,
+};
+
 /*
  * Descriptor for a read helper request.  This is used to make multiple I/O
  * requests on a variety of sources and then stitch the result together.
@@ -156,6 +161,7 @@ struct netfs_read_request {
 	struct work_struct	work;
 	struct inode		*inode;		/* The file being accessed */
 	struct address_space	*mapping;	/* The mapping being accessed */
+	struct folio		*folio;
 	struct netfs_cache_resources cache_resources;
 	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
 	void			*netfs_priv;	/* Private data for the netfs */
@@ -177,6 +183,7 @@ struct netfs_read_request {
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
 	const struct netfs_read_request_ops *netfs_ops;
+	enum netfs_read_request_type type;
 };
 
 /*
-- 
2.27.0

