Return-Path: <linux-fsdevel+bounces-3071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA97EFA23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02418280D63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94574A98E;
	Fri, 17 Nov 2023 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aP5p0wXb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290E1BE6
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+1i5F1S+6wxwGtTBxUYE1F0fETWm68EZav8/D9/C4o=;
	b=aP5p0wXbPQeS3bGEdgYMdcc+3Q92ZUW7YqGYMiK21T1EhtBnXdTLoZPAbDjVJ9aer305jA
	VZ4zwzhnTYDJ2EXi7zT75v25zays7sglxG2QOHeBzxcnb+33t3wlXMGK9Q6EUvigcLfXxI
	IXXfDFv5EbdbUjNzM3UI+ZdK1oZFQZY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-hM-_k96HPC-zHn82lYIZxg-1; Fri,
 17 Nov 2023 16:16:54 -0500
X-MC-Unique: hM-_k96HPC-zHn82lYIZxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63E081C03DA8;
	Fri, 17 Nov 2023 21:16:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B83BCC15881;
	Fri, 17 Nov 2023 21:16:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/51] netfs: Make the refcounting of netfs_begin_read() easier to use
Date: Fri, 17 Nov 2023 21:15:11 +0000
Message-ID: <20231117211544.1740466-20-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Make the refcounting of netfs_begin_read() easier to use by not eating the
caller's ref on the netfs_io_request it's given.  This makes it easier to
use when we need to look in the request struct after.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c     |  6 +++++-
 fs/netfs/io.c                | 28 +++++++++++++---------------
 include/trace/events/netfs.h |  9 +++++----
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3b7eb706f2fe..05824f73cfc7 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -217,6 +217,7 @@ void netfs_readahead(struct readahead_control *ractl)
 		;
 
 	netfs_begin_read(rreq, false);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return;
 
 cleanup_free:
@@ -267,7 +268,9 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
 			rreq->start, rreq->len);
 
-	return netfs_begin_read(rreq, true);
+	ret = netfs_begin_read(rreq, true);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
+	return ret;
 
 discard:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
@@ -436,6 +439,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	ret = netfs_begin_read(rreq, true);
 	if (ret < 0)
 		goto error;
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 
 have_folio:
 	ret = folio_wait_fscache_killable(folio);
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index c80b8eed1209..1795f8679be9 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -362,6 +362,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 
 	netfs_rreq_unlock_folios(rreq);
 
+	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 
@@ -657,7 +658,6 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 
 	if (rreq->len == 0) {
 		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
-		netfs_put_request(rreq, false, netfs_rreq_trace_put_zero_len);
 		return -EIO;
 	}
 
@@ -669,12 +669,10 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 
 	INIT_WORK(&rreq->work, netfs_rreq_work);
 
-	if (sync)
-		netfs_get_request(rreq, netfs_rreq_trace_get_hold);
-
 	/* Chop the read into slices according to what the cache and the netfs
 	 * want and submit each one.
 	 */
+	netfs_get_request(rreq, netfs_rreq_trace_get_for_outstanding);
 	atomic_set(&rreq->nr_outstanding, 1);
 	io_iter = rreq->io_iter;
 	do {
@@ -684,25 +682,25 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	} while (rreq->submitted < rreq->len);
 
 	if (sync) {
-		/* Keep nr_outstanding incremented so that the ref always belongs to
-		 * us, and the service code isn't punted off to a random thread pool to
-		 * process.
+		/* Keep nr_outstanding incremented so that the ref always
+		 * belongs to us, and the service code isn't punted off to a
+		 * random thread pool to process.  Note that this might start
+		 * further work, such as writing to the cache.
 		 */
-		for (;;) {
-			wait_var_event(&rreq->nr_outstanding,
-				       atomic_read(&rreq->nr_outstanding) == 1);
+		wait_var_event(&rreq->nr_outstanding,
+			       atomic_read(&rreq->nr_outstanding) == 1);
+		if (atomic_dec_and_test(&rreq->nr_outstanding))
 			netfs_rreq_assess(rreq, false);
-			if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
-				break;
-			cond_resched();
-		}
+
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
+		wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
 
 		ret = rreq->error;
 		if (ret == 0 && rreq->submitted < rreq->len) {
 			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
 			ret = -EIO;
 		}
-		netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
 	} else {
 		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
 		if (atomic_dec_and_test(&rreq->nr_outstanding))
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 4ea4e34d279f..6daadf2aac8a 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -34,7 +34,9 @@
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
 	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
-	E_(netfs_rreq_trace_unmark,		"UNMARK ")
+	EM(netfs_rreq_trace_unmark,		"UNMARK ")	\
+	EM(netfs_rreq_trace_wait_ip,		"WAIT-IP")	\
+	E_(netfs_rreq_trace_wake_ip,		"WAKE-IP")
 
 #define netfs_sreq_sources					\
 	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
@@ -65,14 +67,13 @@
 	E_(netfs_fail_prepare_write,		"prep-write")
 
 #define netfs_rreq_ref_traces					\
-	EM(netfs_rreq_trace_get_hold,		"GET HOLD   ")	\
+	EM(netfs_rreq_trace_get_for_outstanding,"GET OUTSTND")	\
 	EM(netfs_rreq_trace_get_subreq,		"GET SUBREQ ")	\
 	EM(netfs_rreq_trace_put_complete,	"PUT COMPLT ")	\
 	EM(netfs_rreq_trace_put_discard,	"PUT DISCARD")	\
 	EM(netfs_rreq_trace_put_failed,		"PUT FAILED ")	\
-	EM(netfs_rreq_trace_put_hold,		"PUT HOLD   ")	\
+	EM(netfs_rreq_trace_put_return,		"PUT RETURN ")	\
 	EM(netfs_rreq_trace_put_subreq,		"PUT SUBREQ ")	\
-	EM(netfs_rreq_trace_put_zero_len,	"PUT ZEROLEN")	\
 	E_(netfs_rreq_trace_new,		"NEW        ")
 
 #define netfs_sreq_ref_traces					\


