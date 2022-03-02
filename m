Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9474CA735
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbiCBOG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 09:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiCBOGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BED5B8BF51
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646229950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzO02+Wx/GBJ+6okTN+PfsN16PVvlIV/SC/5yps7DtE=;
        b=VCAZ3gdAtlmG5+9OzvYMxYnhXSmRwnodjzRtOWrXQ7gV0HJC33erIrX1l/gB/hzginNHqQ
        8zHJwv3WaQtCA1h2JByzbgo+wixEZ12o3uN5vY+y/NztiFggjoBSZjAK1C8fIE72d9Wif7
        1BFpwBMHTZHcJR4N1lvBrXl46IiTUMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-ZVLYEQyuPx6CG2_6HnKvRg-1; Wed, 02 Mar 2022 09:05:47 -0500
X-MC-Unique: ZVLYEQyuPx6CG2_6HnKvRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAD1F835DE0;
        Wed,  2 Mar 2022 14:05:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C14B47B8D2;
        Wed,  2 Mar 2022 14:05:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/19] netfs: Finish off rename of netfs_read_request to
 netfs_io_request
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Mar 2022 14:05:24 +0000
Message-ID: <164622992433.3564931.6684311087845150271.stgit@warthog.procyon.org.uk>
In-Reply-To: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
References: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust helper function names and comments after mass rename of
struct netfs_read_*request to struct netfs_io_*request.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/9p/vfs_addr.c       |   12 +++---
 fs/afs/file.c          |    8 ++--
 fs/cachefiles/io.c     |    4 +-
 fs/ceph/addr.c         |    6 +--
 fs/netfs/read_helper.c |   99 ++++++++++++++++++++++++------------------------
 include/linux/netfs.h  |   28 +++++++-------
 6 files changed, 79 insertions(+), 78 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 088d37944963..840111da1172 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -28,10 +28,10 @@
 #include "fid.h"
 
 /**
- * v9fs_req_issue_op - Issue a read from 9P
+ * v9fs_issue_read - Issue a read from 9P
  * @subreq: The read to make
  */
-static void v9fs_req_issue_op(struct netfs_io_subrequest *subreq)
+static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
@@ -52,11 +52,11 @@ static void v9fs_req_issue_op(struct netfs_io_subrequest *subreq)
 }
 
 /**
- * v9fs_init_rreq - Initialise a read request
+ * v9fs_init_request - Initialise a read request
  * @rreq: The read request
  * @file: The file being read from
  */
-static void v9fs_init_rreq(struct netfs_io_request *rreq, struct file *file)
+static void v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid = file->private_data;
 
@@ -92,9 +92,9 @@ static int v9fs_begin_cache_operation(struct netfs_io_request *rreq)
 }
 
 const struct netfs_request_ops v9fs_req_ops = {
-	.init_rreq		= v9fs_init_rreq,
+	.init_request		= v9fs_init_request,
 	.begin_cache_operation	= v9fs_begin_cache_operation,
-	.issue_op		= v9fs_req_issue_op,
+	.issue_read		= v9fs_issue_read,
 	.cleanup		= v9fs_req_cleanup,
 };
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 0e247fd0abef..aef0fbbd834d 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -308,7 +308,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	return afs_do_sync_operation(op);
 }
 
-static void afs_req_issue_op(struct netfs_io_subrequest *subreq)
+static void afs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct afs_read *fsreq;
@@ -357,7 +357,7 @@ static int afs_symlink_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-static void afs_init_rreq(struct netfs_io_request *rreq, struct file *file)
+static void afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	rreq->netfs_priv = key_get(afs_file_key(file));
 }
@@ -388,10 +388,10 @@ static void afs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
 }
 
 const struct netfs_request_ops afs_req_ops = {
-	.init_rreq		= afs_init_rreq,
+	.init_request		= afs_init_request,
 	.begin_cache_operation	= afs_begin_cache_operation,
 	.check_write_begin	= afs_check_write_begin,
-	.issue_op		= afs_req_issue_op,
+	.issue_read		= afs_issue_read,
 	.cleanup		= afs_priv_cleanup,
 };
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 6ac6fdbc70d3..b19f496db9ad 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -406,7 +406,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 	}
 
 	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
-		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+		__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 		why = cachefiles_trace_read_no_data;
 		goto out_no_object;
 	}
@@ -475,7 +475,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 	goto out;
 
 download_and_store:
-	__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+	__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 out:
 	cachefiles_end_secure(cache, saved_cred);
 out_no_object:
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a6452ca3482e..78070296447f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -259,7 +259,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	size_t len;
 
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 
 	if (subreq->start >= inode->i_size)
 		goto out;
@@ -298,7 +298,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	return true;
 }
 
-static void ceph_netfs_issue_op(struct netfs_io_subrequest *subreq)
+static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
@@ -366,7 +366,7 @@ static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
 
 const struct netfs_request_ops ceph_netfs_ops = {
 	.begin_cache_operation	= ceph_begin_cache_operation,
-	.issue_op		= ceph_netfs_issue_op,
+	.issue_read		= ceph_netfs_issue_read,
 	.expand_readahead	= ceph_netfs_expand_readahead,
 	.clamp_length		= ceph_netfs_clamp_length,
 	.check_write_begin	= ceph_netfs_check_write_begin,
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 37125ed95d1a..74e510f9e11f 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -36,11 +36,11 @@ static void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 		__netfs_put_subrequest(subreq, was_async);
 }
 
-static struct netfs_io_request *netfs_alloc_read_request(
+static struct netfs_io_request *netfs_alloc_request(
 	struct address_space *mapping,
 	struct file *file,
 	loff_t start, size_t len,
-	enum netfs_read_origin origin)
+	enum netfs_io_origin origin)
 {
 	static atomic_t debug_ids;
 	struct inode *inode = file ? file_inode(file) : mapping->host;
@@ -61,21 +61,20 @@ static struct netfs_io_request *netfs_alloc_read_request(
 		INIT_WORK(&rreq->work, netfs_rreq_work);
 		refcount_set(&rreq->usage, 1);
 		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-		if (ctx->ops->init_rreq)
-			ctx->ops->init_rreq(rreq, file);
+		if (ctx->ops->init_request)
+			ctx->ops->init_request(rreq, file);
 		netfs_stat(&netfs_n_rh_rreq);
 	}
 
 	return rreq;
 }
 
-static void netfs_get_read_request(struct netfs_io_request *rreq)
+static void netfs_get_request(struct netfs_io_request *rreq)
 {
 	refcount_inc(&rreq->usage);
 }
 
-static void netfs_rreq_clear_subreqs(struct netfs_io_request *rreq,
-				     bool was_async)
+static void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
 {
 	struct netfs_io_subrequest *subreq;
 
@@ -87,11 +86,11 @@ static void netfs_rreq_clear_subreqs(struct netfs_io_request *rreq,
 	}
 }
 
-static void netfs_free_read_request(struct work_struct *work)
+static void netfs_free_request(struct work_struct *work)
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
-	netfs_rreq_clear_subreqs(rreq, false);
+	netfs_clear_subrequests(rreq, false);
 	if (rreq->netfs_priv)
 		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
@@ -101,15 +100,15 @@ static void netfs_free_read_request(struct work_struct *work)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
-static void netfs_put_read_request(struct netfs_io_request *rreq, bool was_async)
+static void netfs_put_request(struct netfs_io_request *rreq, bool was_async)
 {
 	if (refcount_dec_and_test(&rreq->usage)) {
 		if (was_async) {
-			rreq->work.func = netfs_free_read_request;
+			rreq->work.func = netfs_free_request;
 			if (!queue_work(system_unbound_wq, &rreq->work))
 				BUG();
 		} else {
-			netfs_free_read_request(&rreq->work);
+			netfs_free_request(&rreq->work);
 		}
 	}
 }
@@ -127,14 +126,14 @@ static struct netfs_io_subrequest *netfs_alloc_subrequest(
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->usage, 2);
 		subreq->rreq = rreq;
-		netfs_get_read_request(rreq);
+		netfs_get_request(rreq);
 		netfs_stat(&netfs_n_rh_sreq);
 	}
 
 	return subreq;
 }
 
-static void netfs_get_read_subrequest(struct netfs_io_subrequest *subreq)
+static void netfs_get_subrequest(struct netfs_io_subrequest *subreq)
 {
 	refcount_inc(&subreq->usage);
 }
@@ -147,7 +146,7 @@ static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
 	kfree(subreq);
 	netfs_stat_d(&netfs_n_rh_sreq);
-	netfs_put_read_request(rreq, was_async);
+	netfs_put_request(rreq, was_async);
 }
 
 /*
@@ -222,7 +221,7 @@ static void netfs_read_from_server(struct netfs_io_request *rreq,
 				   struct netfs_io_subrequest *subreq)
 {
 	netfs_stat(&netfs_n_rh_download);
-	rreq->netfs_ops->issue_op(subreq);
+	rreq->netfs_ops->issue_read(subreq);
 }
 
 /*
@@ -231,8 +230,8 @@ static void netfs_read_from_server(struct netfs_io_request *rreq,
 static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
-	netfs_rreq_clear_subreqs(rreq, was_async);
-	netfs_put_read_request(rreq, was_async);
+	netfs_clear_subrequests(rreq, was_async);
+	netfs_put_request(rreq, was_async);
 }
 
 /*
@@ -312,7 +311,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 	atomic_inc(&rreq->nr_copy_ops);
 
 	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
-		if (!test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
+		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
 			list_del_init(&subreq->rreq_link);
 			netfs_put_subrequest(subreq, false);
 		}
@@ -342,7 +341,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 
 		atomic_inc(&rreq->nr_copy_ops);
 		netfs_stat(&netfs_n_rh_write);
-		netfs_get_read_subrequest(subreq);
+		netfs_get_subrequest(subreq);
 		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
 		cres->ops->write(cres, subreq->start, &iter,
 				 netfs_rreq_copy_terminated, subreq);
@@ -384,9 +383,9 @@ static void netfs_rreq_unlock(struct netfs_io_request *rreq)
 	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
 
 	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
-		__clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
+		__clear_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
 		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-			__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+			__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 		}
 	}
 
@@ -414,7 +413,7 @@ static void netfs_rreq_unlock(struct netfs_io_request *rreq)
 				pg_failed = true;
 				break;
 			}
-			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
+			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
 				folio_start_fscache(folio);
 			pg_failed |= subreq_failed;
 			if (pgend < iopos + subreq->len)
@@ -459,13 +458,13 @@ static void netfs_rreq_unlock(struct netfs_io_request *rreq)
 static void netfs_rreq_short_read(struct netfs_io_request *rreq,
 				  struct netfs_io_subrequest *subreq)
 {
-	__clear_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
+	__clear_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
 	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
 
 	netfs_stat(&netfs_n_rh_short_read);
 	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
 
-	netfs_get_read_subrequest(subreq);
+	netfs_get_subrequest(subreq);
 	atomic_inc(&rreq->nr_outstanding);
 	if (subreq->source == NETFS_READ_FROM_CACHE)
 		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
@@ -499,10 +498,10 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 			subreq->error = 0;
 			netfs_stat(&netfs_n_rh_download_instead);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
-			netfs_get_read_subrequest(subreq);
+			netfs_get_subrequest(subreq);
 			atomic_inc(&rreq->nr_outstanding);
 			netfs_read_from_server(rreq, subreq);
-		} else if (test_bit(NETFS_SREQ_SHORT_READ, &subreq->flags)) {
+		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
 			netfs_rreq_short_read(rreq, subreq);
 		}
 	}
@@ -559,7 +558,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 
-	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags))
+	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags))
 		return netfs_rreq_write_to_cache(rreq);
 
 	netfs_rreq_completed(rreq, was_async);
@@ -648,8 +647,8 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 
 complete:
 	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-	if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
-		set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
+	if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
+		set_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
 
 out:
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
@@ -680,7 +679,7 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 	}
 
-	__set_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
+	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
 	set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
 	goto out;
 
@@ -880,10 +879,10 @@ void netfs_readahead(struct readahead_control *ractl)
 	if (readahead_count(ractl) == 0)
 		return;
 
-	rreq = netfs_alloc_read_request(ractl->mapping, ractl->file,
-					readahead_pos(ractl),
-					readahead_length(ractl),
-					NETFS_READAHEAD);
+	rreq = netfs_alloc_request(ractl->mapping, ractl->file,
+				   readahead_pos(ractl),
+				   readahead_length(ractl),
+				   NETFS_READAHEAD);
 	if (!rreq)
 		return;
 
@@ -918,7 +917,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	return;
 
 cleanup_free:
-	netfs_put_read_request(rreq, false);
+	netfs_put_request(rreq, false);
 	return;
 }
 EXPORT_SYMBOL(netfs_readahead);
@@ -948,8 +947,8 @@ int netfs_readpage(struct file *file, struct page *subpage)
 
 	_enter("%lx", folio_index(folio));
 
-	rreq = netfs_alloc_read_request(mapping, file, folio_file_pos(folio),
-					folio_size(folio), NETFS_READPAGE);
+	rreq = netfs_alloc_request(mapping, file, folio_file_pos(folio),
+				   folio_size(folio), NETFS_READPAGE);
 	if (!rreq)
 		goto nomem;
 
@@ -964,7 +963,7 @@ int netfs_readpage(struct file *file, struct page *subpage)
 	netfs_stat(&netfs_n_rh_readpage);
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
-	netfs_get_read_request(rreq);
+	netfs_get_request(rreq);
 
 	atomic_set(&rreq->nr_outstanding, 1);
 	do {
@@ -978,7 +977,8 @@ int netfs_readpage(struct file *file, struct page *subpage)
 	 * process.
 	 */
 	do {
-		wait_var_event(&rreq->nr_outstanding, atomic_read(&rreq->nr_outstanding) == 1);
+		wait_var_event(&rreq->nr_outstanding,
+			       atomic_read(&rreq->nr_outstanding) == 1);
 		netfs_rreq_assess(rreq, false);
 	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
 
@@ -988,7 +988,7 @@ int netfs_readpage(struct file *file, struct page *subpage)
 		ret = -EIO;
 	}
 out:
-	netfs_put_read_request(rreq, false);
+	netfs_put_request(rreq, false);
 	return ret;
 nomem:
 	folio_unlock(folio);
@@ -1124,8 +1124,8 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 	ret = -ENOMEM;
-	rreq = netfs_alloc_read_request(mapping, file, folio_file_pos(folio),
-					folio_size(folio), NETFS_READ_FOR_WRITE);
+	rreq = netfs_alloc_request(mapping, file, folio_file_pos(folio),
+				   folio_size(folio), NETFS_READ_FOR_WRITE);
 	if (!rreq)
 		goto error;
 	rreq->start		= folio_file_pos(folio);
@@ -1147,7 +1147,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	 */
 	ractl._nr_pages = folio_nr_pages(folio);
 	netfs_rreq_expand(rreq, &ractl);
-	netfs_get_read_request(rreq);
+	netfs_get_request(rreq);
 
 	/* We hold the folio locks, so we can drop the references */
 	folio_get(folio);
@@ -1161,12 +1161,13 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 
 	} while (rreq->submitted < rreq->len);
 
-	/* Keep nr_outstanding incremented so that the ref always belongs to us, and
-	 * the service code isn't punted off to a random thread pool to
+	/* Keep nr_outstanding incremented so that the ref always belongs to
+	 * us, and the service code isn't punted off to a random thread pool to
 	 * process.
 	 */
 	for (;;) {
-		wait_var_event(&rreq->nr_outstanding, atomic_read(&rreq->nr_outstanding) == 1);
+		wait_var_event(&rreq->nr_outstanding,
+			       atomic_read(&rreq->nr_outstanding) == 1);
 		netfs_rreq_assess(rreq, false);
 		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
 			break;
@@ -1178,7 +1179,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_write_begin);
 		ret = -EIO;
 	}
-	netfs_put_read_request(rreq, false);
+	netfs_put_request(rreq, false);
 	if (ret < 0)
 		goto error;
 
@@ -1192,7 +1193,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	return 0;
 
 error_put:
-	netfs_put_read_request(rreq, false);
+	netfs_put_request(rreq, false);
 error:
 	folio_unlock(folio);
 	folio_put(folio);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a5434bc80e1c..8c33777c439e 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -141,7 +141,7 @@ struct netfs_cache_resources {
  * Descriptor for a single component subrequest.
  */
 struct netfs_io_subrequest {
-	struct netfs_io_request *rreq;	/* Supervising read request */
+	struct netfs_io_request *rreq;		/* Supervising I/O request */
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	loff_t			start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
@@ -149,46 +149,46 @@ struct netfs_io_subrequest {
 	refcount_t		usage;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
-	enum netfs_io_source	source;		/* Where to read from */
+	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned long		flags;
-#define NETFS_SREQ_WRITE_TO_CACHE	0	/* Set if should write to cache */
+#define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
-#define NETFS_SREQ_SHORT_READ		2	/* Set if there was a short read from the cache */
+#define NETFS_SREQ_SHORT_IO		2	/* Set if the I/O was short */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
 };
 
-enum netfs_read_origin {
+enum netfs_io_origin {
 	NETFS_READAHEAD,		/* This read was triggered by readahead */
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 } __mode(byte);
 
 /*
- * Descriptor for a read helper request.  This is used to make multiple I/O
- * requests on a variety of sources and then stitch the result together.
+ * Descriptor for an I/O helper request.  This is used to make multiple I/O
+ * operations to a variety of data stores and then stitch the result together.
  */
 struct netfs_io_request {
 	struct work_struct	work;
 	struct inode		*inode;		/* The file being accessed */
 	struct address_space	*mapping;	/* The mapping being accessed */
 	struct netfs_cache_resources cache_resources;
-	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
+	struct list_head	subrequests;	/* Contributory I/O operations */
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;
-	atomic_t		nr_outstanding;	/* Number of read ops in progress */
-	atomic_t		nr_copy_ops;	/* Number of write ops in progress */
+	atomic_t		nr_outstanding;	/* Number of ops in progress */
+	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
-	enum netfs_read_origin	origin;		/* Origin of the read */
+	enum netfs_io_origin	origin;		/* Origin of the I/O */
 	loff_t			i_size;		/* Size of the file */
 	loff_t			start;		/* Start position */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
 	refcount_t		usage;
 	unsigned long		flags;
 #define NETFS_RREQ_INCOMPLETE_IO	0	/* Some ioreqs terminated short or with error */
-#define NETFS_RREQ_WRITE_TO_CACHE	1	/* Need to write to the cache */
+#define NETFS_RREQ_COPY_TO_CACHE	1	/* Need to write to the cache */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
@@ -200,11 +200,11 @@ struct netfs_io_request {
  * Operations the network filesystem can/must provide to the helpers.
  */
 struct netfs_request_ops {
-	void (*init_rreq)(struct netfs_io_request *rreq, struct file *file);
+	void (*init_request)(struct netfs_io_request *rreq, struct file *file);
 	int (*begin_cache_operation)(struct netfs_io_request *rreq);
 	void (*expand_readahead)(struct netfs_io_request *rreq);
 	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
-	void (*issue_op)(struct netfs_io_subrequest *subreq);
+	void (*issue_read)(struct netfs_io_subrequest *subreq);
 	bool (*is_still_valid)(struct netfs_io_request *rreq);
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 				 struct folio *folio, void **_fsdata);


