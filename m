Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204104618C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378520AbhK2OeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:34:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378423AbhK2OcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqUDgJtO/CPkypB1RXJVK8TOtRi+ehpPTa67zK8la38=;
        b=WFO5ju4qIzisnm/TbUhMgx6sHBN1G3LdBRmrurTeIYUpQvydUQU6qPfqHvtdub8Zv/A1Eb
        H3DUTH7MLjASl5Sehp9ywJ5zzAj2DFYa+AhGVNyigoAn0dPTq7iwR9lYb924N/YBET5FPP
        WAIauD82sNNpl5Ph6sV2bJo8ShvZCgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295--2wXeGztNAGkIR-5aUhB6Q-1; Mon, 29 Nov 2021 09:28:49 -0500
X-MC-Unique: -2wXeGztNAGkIR-5aUhB6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0818F84BA42;
        Mon, 29 Nov 2021 14:28:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1905C1C5;
        Mon, 29 Nov 2021 14:28:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 24/64] netfs: Pass more information on how to deal with a hole
 in the cache
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:28:43 +0000
Message-ID: <163819612321.215744.9738308885948264476.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass more information to the cache on how to deal with a hole if it
encounters one when trying to read from the cache.  Three options are
provided:

 (1) NETFS_READ_HOLE_IGNORE.  Read the hole along with the data, assuming
     it to be a punched-out extent by the backing filesystem.

 (2) NETFS_READ_HOLE_CLEAR.  If there's a hole, erase the requested region
     of the cache and clear the read buffer.

 (3) NETFS_READ_HOLE_FAIL.  Fail the read if a hole is detected.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/netfs/read_helper.c |    8 ++++----
 include/linux/netfs.h  |   11 ++++++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 7dc79fa8a1f3..08df413efdf3 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -170,7 +170,7 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
  */
 static void netfs_read_from_cache(struct netfs_read_request *rreq,
 				  struct netfs_read_subrequest *subreq,
-				  bool seek_data)
+				  enum netfs_read_from_hole read_hole)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct iov_iter iter;
@@ -180,7 +180,7 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 			subreq->start + subreq->transferred,
 			subreq->len   - subreq->transferred);
 
-	cres->ops->read(cres, subreq->start, &iter, seek_data,
+	cres->ops->read(cres, subreq->start, &iter, read_hole,
 			netfs_cache_read_terminated, subreq);
 }
 
@@ -466,7 +466,7 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 	netfs_get_read_subrequest(subreq);
 	atomic_inc(&rreq->nr_rd_ops);
 	if (subreq->source == NETFS_READ_FROM_CACHE)
-		netfs_read_from_cache(rreq, subreq, true);
+		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
 	else
 		netfs_read_from_server(rreq, subreq);
 }
@@ -794,7 +794,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 		netfs_read_from_server(rreq, subreq);
 		break;
 	case NETFS_READ_FROM_CACHE:
-		netfs_read_from_cache(rreq, subreq, false);
+		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_IGNORE);
 		break;
 	default:
 		BUG();
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5a46fde65759..b46c39d98bbd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -196,6 +196,15 @@ struct netfs_read_request_ops {
 	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 };
 
+/*
+ * How to handle reading from a hole.
+ */
+enum netfs_read_from_hole {
+	NETFS_READ_HOLE_IGNORE,
+	NETFS_READ_HOLE_CLEAR,
+	NETFS_READ_HOLE_FAIL,
+};
+
 /*
  * Table of operations for access to a cache.  This is obtained by
  * rreq->ops->begin_cache_operation().
@@ -208,7 +217,7 @@ struct netfs_cache_ops {
 	int (*read)(struct netfs_cache_resources *cres,
 		    loff_t start_pos,
 		    struct iov_iter *iter,
-		    bool seek_data,
+		    enum netfs_read_from_hole read_hole,
 		    netfs_io_terminated_t term_func,
 		    void *term_func_priv);
 


