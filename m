Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCE83570D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353802AbhDGPr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353789AbhDGPrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617810462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiuRmufkWbAF/P5fv+FTWWGz5mEQGJitqsQ8zQ9bbKc=;
        b=Ju4dvwAeEsYV5eXdH2/gXHFtIQ3NV6at1Ztr6FjTavKCfB4xYyKbZwobWBVEUoVNNikTf6
        +KA+dJWRw3rCMJpaIaXdDxztZ3UEATa+Scb0gil9J32cXHjW0JcOcJpI0PDkG3VcGzHn+U
        G3AyM64HgkDpA+WGQCRj79ErOGFu/a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-6yC77ApMNtG5iGDj-xwNhA-1; Wed, 07 Apr 2021 11:47:39 -0400
X-MC-Unique: 6yC77ApMNtG5iGDj-xwNhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56324801F98;
        Wed,  7 Apr 2021 15:47:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 097585C1C4;
        Wed,  7 Apr 2021 15:47:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/5] netfs: Call trace_netfs_read() after
 ->begin_cache_operation()
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     dwysocha@redhat.com, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:47:31 +0100
Message-ID: <161781045123.463527.14533348855710902201.stgit@warthog.procyon.org.uk>
In-Reply-To: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
References: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reorder the netfs library API functions slightly to log the netfs_read
tracepoint after calling out to the network filesystem to begin a caching
operation.  This sets rreq->cookie_debug_id so that it can be logged in
tracepoints.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/read_helper.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 0066db21aa11..8040b76da1b6 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -890,15 +890,16 @@ void netfs_readahead(struct readahead_control *ractl,
 	rreq->start	= readahead_pos(ractl);
 	rreq->len	= readahead_length(ractl);
 
-	netfs_stat(&netfs_n_rh_readahead);
-	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
-			 netfs_read_trace_readahead);
-
 	if (ops->begin_cache_operation) {
 		ret = ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 			goto cleanup_free;
 	}
+
+	netfs_stat(&netfs_n_rh_readahead);
+	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
+			 netfs_read_trace_readahead);
+
 	netfs_rreq_expand(rreq, ractl);
 
 	atomic_set(&rreq->nr_rd_ops, 1);
@@ -968,9 +969,6 @@ int netfs_readpage(struct file *file,
 	rreq->start	= page_index(page) * PAGE_SIZE;
 	rreq->len	= thp_size(page);
 
-	netfs_stat(&netfs_n_rh_readpage);
-	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
-
 	if (ops->begin_cache_operation) {
 		ret = ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS) {
@@ -979,6 +977,9 @@ int netfs_readpage(struct file *file,
 		}
 	}
 
+	netfs_stat(&netfs_n_rh_readpage);
+	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
+
 	netfs_get_read_request(rreq);
 
 	atomic_set(&rreq->nr_rd_ops, 1);
@@ -1111,15 +1112,15 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	__set_bit(NETFS_RREQ_NO_UNLOCK_PAGE, &rreq->flags);
 	netfs_priv = NULL;
 
-	netfs_stat(&netfs_n_rh_write_begin);
-	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
-
 	if (ops->begin_cache_operation) {
 		ret = ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
-			goto error;
+			goto error_put;
 	}
 
+	netfs_stat(&netfs_n_rh_write_begin);
+	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
+
 	/* Expand the request to meet caching requirements and download
 	 * preferences.
 	 */


