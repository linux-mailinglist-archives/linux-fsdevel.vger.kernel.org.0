Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57D47778F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhLPQN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239150AbhLPQNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639671229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aobPgyUPHrJt0sf3UbSqKjIsee875HOGyoeyzVks3/U=;
        b=VXQLctsXiqxEi2zGEsywxnEyb9oY3fw91Chm3WSbA5i5BQhqBV70w8qIOZ3idh2DXdDYCz
        Sn2eWjNKuHn5JZqRkfSHX7NsN7/ytqCeZ6e8MqMIjslZyNnw5pLlZ5npEhbip6+S0uRZEP
        PVeO/kSm13DWgXsf8Q8aDLlHNG1ZeC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-DaZ0RsQjOTSGHr-VZtfbyA-1; Thu, 16 Dec 2021 11:13:44 -0500
X-MC-Unique: DaZ0RsQjOTSGHr-VZtfbyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18CC894EE0;
        Thu, 16 Dec 2021 16:13:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D8545E482;
        Thu, 16 Dec 2021 16:13:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 24/68] netfs: Pass more information on how to deal with a
 hole in the cache
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
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 16:13:19 +0000
Message-ID: <163967119923.1823006.15637375885194297582.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Link: https://lore.kernel.org/r/163819612321.215744.9738308885948264476.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906914460.143852.6284247083607910189.stgit@warthog.procyon.org.uk/ # v2
---

 fs/netfs/read_helper.c |    8 ++++----
 include/linux/netfs.h  |   11 ++++++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 9dd76b8914f2..6169659857b3 100644
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
 
@@ -461,7 +461,7 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 	netfs_get_read_subrequest(subreq);
 	atomic_inc(&rreq->nr_rd_ops);
 	if (subreq->source == NETFS_READ_FROM_CACHE)
-		netfs_read_from_cache(rreq, subreq, true);
+		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
 	else
 		netfs_read_from_server(rreq, subreq);
 }
@@ -789,7 +789,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
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
 


