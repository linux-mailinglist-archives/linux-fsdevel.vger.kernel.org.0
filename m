Return-Path: <linux-fsdevel+bounces-34041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C779C2366
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2009281974
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649320DD78;
	Fri,  8 Nov 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuwZ4Jv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3C20DD5C
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087250; cv=none; b=CoLZCWXNYTFRy4edxeefSEBdLKnS4KhaepzP/iEJtDNEwUZV02/gxxTgILWy7KhliVDk+FNgjUYcfzedE0LeqlMNgSbcKHLP9gKhKPlLTgswoFTmRPbsNHIktkEz61cuMBHG2a/J1kSMJQART7wF/5+Gh07xPuAmtFbp/Z63q+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087250; c=relaxed/simple;
	bh=UY4FIAOMecd1RPE2VIilbpsjd5hNpaTgiF0vreIZSAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB8WDC/LErIaTNndzeG/VQ39nyNR9Z9uoXDZoDBhTadwS73Ijh55tqDH+Q6+QHzDI8zjAgNLr86p6+P1lOAy7oW8QwnYd3ItmRZFxEMM8NC/HlWqbm8/dpeqfcAMuoC2NlruiaFdZg9voVR7JU0nhfvRTUTsPY2e8pTWLUOvVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuwZ4Jv8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGYosp/+kMXcNDFlu6f+dSAs1+3gA++sooPoxXEtOf0=;
	b=VuwZ4Jv8wGTg0FgAEaaxZEXG0SgAbR+q05keRiQkNundt1WRPxX6jO7iyiP5Kd57JZSOQu
	ydBkQAb2D4WgwgxUrJ31XusyAG5hFfVvvaDUG1/L6Qgtf2/5b7tmT5Pr4KwVPiYhx/tNne
	mM1tv4lp/3fgh5MeR3wnbW3s9735VzI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-8pUauU-mODe2UOaqhn2byA-1; Fri,
 08 Nov 2024 12:34:03 -0500
X-MC-Unique: 8pUauU-mODe2UOaqhn2byA-1
X-Mimecast-MFC-AGG-ID: 8pUauU-mODe2UOaqhn2byA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41C241956048;
	Fri,  8 Nov 2024 17:33:59 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD5FA300019F;
	Fri,  8 Nov 2024 17:33:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/33] netfs: Drop the error arg from netfs_read_subreq_terminated()
Date: Fri,  8 Nov 2024 17:32:11 +0000
Message-ID: <20241108173236.1382366-11-dhowells@redhat.com>
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Drop the error argument from netfs_read_subreq_terminated() in favour of
passing the value in subreq->error.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c         |  3 ++-
 fs/afs/file.c            | 15 ++++++++-----
 fs/ceph/addr.c           | 13 +++++++----
 fs/netfs/buffered_read.c | 16 +++++++-------
 fs/netfs/objects.c       | 15 ++++++++++++-
 fs/netfs/read_collect.c  | 47 +++++++++++++++++++++++++---------------
 fs/nfs/fscache.c         |  6 +++--
 fs/nfs/fscache.h         |  3 ++-
 fs/smb/client/cifssmb.c  | 10 +--------
 fs/smb/client/file.c     |  3 ++-
 fs/smb/client/smb2pdu.c  | 10 +--------
 include/linux/netfs.h    |  7 +++---
 12 files changed, 86 insertions(+), 62 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 819c75233235..58a6bd284d88 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -83,7 +83,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	if (!err)
 		subreq->transferred += total;
 
-	netfs_read_subreq_terminated(subreq, err, false);
+	subreq->error = err;
+	netfs_read_subreq_terminated(subreq, false);
 }
 
 /**
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6762eff97517..56248a078bca 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -246,7 +246,8 @@ static void afs_fetch_data_notify(struct afs_operation *op)
 		subreq->rreq->i_size = req->file_size;
 		if (req->pos + req->actual_len >= req->file_size)
 			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
-		netfs_read_subreq_terminated(subreq, error, false);
+		subreq->error = error;
+		netfs_read_subreq_terminated(subreq, false);
 		req->subreq = NULL;
 	} else if (req->done) {
 		req->done(req);
@@ -301,8 +302,10 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 
 	op = afs_alloc_operation(req->key, vnode->volume);
 	if (IS_ERR(op)) {
-		if (req->subreq)
-			netfs_read_subreq_terminated(req->subreq, PTR_ERR(op), false);
+		if (req->subreq) {
+			req->subreq->error = PTR_ERR(op);
+			netfs_read_subreq_terminated(req->subreq, false);
+		}
 		return PTR_ERR(op);
 	}
 
@@ -320,8 +323,10 @@ static void afs_read_worker(struct work_struct *work)
 	struct afs_read *fsreq;
 
 	fsreq = afs_alloc_read(GFP_NOFS);
-	if (!fsreq)
-		return netfs_read_subreq_terminated(subreq, -ENOMEM, false);
+	if (!fsreq) {
+		subreq->error = -ENOMEM;
+		return netfs_read_subreq_terminated(subreq, false);
+	}
 
 	fsreq->subreq	= subreq;
 	fsreq->pos	= subreq->start + subreq->transferred;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c2a9e2cc03de..459249ba6319 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -253,8 +253,9 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 		subreq->transferred = err;
 		err = 0;
 	}
+	subreq->error = err;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
-	netfs_read_subreq_terminated(subreq, err, false);
+	netfs_read_subreq_terminated(subreq, false);
 	iput(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
@@ -314,7 +315,9 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 
 	ceph_mdsc_put_request(req);
 out:
-	netfs_read_subreq_terminated(subreq, err, false);
+	subreq->error = err;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
+	netfs_read_subreq_terminated(subreq, false);
 	return true;
 }
 
@@ -426,8 +429,10 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	ceph_osdc_start_request(req->r_osdc, req);
 out:
 	ceph_osdc_put_request(req);
-	if (err)
-		netfs_read_subreq_terminated(subreq, err, false);
+	if (err) {
+		subreq->error = err;
+		netfs_read_subreq_terminated(subreq, false);
+	}
 	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
 }
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 4cacb46e0cf7..82c3b9957958 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -148,14 +148,13 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
 {
 	struct netfs_io_subrequest *subreq = priv;
 
-	if (transferred_or_error < 0) {
-		netfs_read_subreq_terminated(subreq, transferred_or_error, was_async);
-		return;
-	}
-
-	if (transferred_or_error > 0)
+	if (transferred_or_error > 0) {
 		subreq->transferred += transferred_or_error;
-	netfs_read_subreq_terminated(subreq, 0, was_async);
+		subreq->error = 0;
+	} else {
+		subreq->error = transferred_or_error;
+	}
+	netfs_read_subreq_terminated(subreq, was_async);
 }
 
 /*
@@ -261,7 +260,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			netfs_stat(&netfs_n_rh_zero);
 			slice = netfs_prepare_read_iterator(subreq);
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-			netfs_read_subreq_terminated(subreq, 0, false);
+			subreq->error = 0;
+			netfs_read_subreq_terminated(subreq, false);
 			goto done;
 		}
 
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 5cdddaf1f978..f10fd56efa17 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -191,7 +191,20 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 	}
 
 	memset(subreq, 0, kmem_cache_size(cache));
-	INIT_WORK(&subreq->work, NULL);
+
+	switch (rreq->origin) {
+	case NETFS_READAHEAD:
+	case NETFS_READPAGE:
+	case NETFS_READ_GAPS:
+	case NETFS_READ_FOR_WRITE:
+	case NETFS_DIO_READ:
+		INIT_WORK(&subreq->work, netfs_read_subreq_termination_worker);
+		break;
+	default:
+		INIT_WORK(&subreq->work, NULL);
+		break;
+	}
+
 	INIT_LIST_HEAD(&subreq->rreq_link);
 	refcount_set(&subreq->ref, 2);
 	subreq->rreq = rreq;
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 214f06bba2c7..00358894fac4 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -450,28 +450,26 @@ EXPORT_SYMBOL(netfs_read_subreq_progress);
 /**
  * netfs_read_subreq_terminated - Note the termination of an I/O operation.
  * @subreq: The I/O request that has terminated.
- * @error: Error code indicating type of completion.
- * @was_async: The termination was asynchronous
+ * @was_async: True if we're in an asynchronous context.
  *
  * This tells the read helper that a contributory I/O operation has terminated,
  * one way or another, and that it should integrate the results.
  *
- * The caller indicates the outcome of the operation through @error, supplying
- * 0 to indicate a successful or retryable transfer (if NETFS_SREQ_NEED_RETRY
- * is set) or a negative error code.  The helper will look after reissuing I/O
- * operations as appropriate and writing downloaded data to the cache.
+ * The caller indicates the outcome of the operation through @subreq->error,
+ * supplying 0 to indicate a successful or retryable transfer (if
+ * NETFS_SREQ_NEED_RETRY is set) or a negative error code.  The helper will
+ * look after reissuing I/O operations as appropriate and writing downloaded
+ * data to the cache.
  *
  * Before calling, the filesystem should update subreq->transferred to track
  * the amount of data copied into the output buffer.
- *
- * If @was_async is true, the caller might be running in softirq or interrupt
- * context and we can't sleep.
  */
-void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
-				  int error, bool was_async)
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq, bool was_async)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 
+	might_sleep();
+
 	switch (subreq->source) {
 	case NETFS_READ_FROM_CACHE:
 		netfs_stat(&netfs_n_rh_read_done);
@@ -489,7 +487,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 		 * If the read completed validly short, then we can clear the
 		 * tail before going on to unlock the folios.
 		 */
-		if (error == 0 && subreq->transferred < subreq->len &&
+		if (subreq->error == 0 && subreq->transferred < subreq->len &&
 		    (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags) ||
 		     test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags))) {
 			netfs_clear_unread(subreq);
@@ -509,7 +507,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 	/* Deal with retry requests, short reads and errors.  If we retry
 	 * but don't make progress, we abandon the attempt.
 	 */
-	if (!error && subreq->transferred < subreq->len) {
+	if (!subreq->error && subreq->transferred < subreq->len) {
 		if (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags)) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_hit_eof);
 		} else {
@@ -523,16 +521,15 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
 			} else {
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-				error = -ENODATA;
+				subreq->error = -ENODATA;
 			}
 		}
 	}
 
-	subreq->error = error;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 
-	if (unlikely(error < 0)) {
-		trace_netfs_failure(rreq, subreq, error, netfs_fail_read);
+	if (unlikely(subreq->error < 0)) {
+		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
 		if (subreq->source == NETFS_READ_FROM_CACHE) {
 			netfs_stat(&netfs_n_rh_read_failed);
 		} else {
@@ -548,3 +545,19 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
 }
 EXPORT_SYMBOL(netfs_read_subreq_terminated);
+
+/**
+ * netfs_read_subreq_termination_worker - Workqueue helper for read termination
+ * @work: The subreq->work in the I/O request that has been terminated.
+ *
+ * Helper function to jump to netfs_read_subreq_terminated() from the
+ * subrequest work item.
+ */
+void netfs_read_subreq_termination_worker(struct work_struct *work)
+{
+	struct netfs_io_subrequest *subreq =
+		container_of(work, struct netfs_io_subrequest, work);
+
+	netfs_read_subreq_terminated(subreq, false);
+}
+EXPORT_SYMBOL(netfs_read_subreq_termination_worker);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 810269ee0a50..e585a7bcfe4d 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -307,8 +307,10 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 			     &nfs_async_read_completion_ops);
 
 	netfs = nfs_netfs_alloc(sreq);
-	if (!netfs)
-		return netfs_read_subreq_terminated(sreq, -ENOMEM, false);
+	if (!netfs) {
+		sreq->error = -ENOMEM;
+		return netfs_read_subreq_terminated(sreq, false);
+	}
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 772d485e96d3..1d86f7cc7195 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -74,7 +74,8 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
 	 */
 	netfs->sreq->transferred = min_t(s64, netfs->sreq->len,
 					 atomic64_read(&netfs->transferred));
-	netfs_read_subreq_terminated(netfs->sreq, netfs->error, false);
+	netfs->sreq->error = netfs->error;
+	netfs_read_subreq_terminated(netfs->sreq, false);
 	kfree(netfs);
 }
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index c6f15dbe860a..bdf1933cb0e2 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1261,14 +1261,6 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 	return rc;
 }
 
-static void cifs_readv_worker(struct work_struct *work)
-{
-	struct cifs_io_subrequest *rdata =
-		container_of(work, struct cifs_io_subrequest, subreq.work);
-
-	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
-}
-
 static void
 cifs_readv_callback(struct mid_q_entry *mid)
 {
@@ -1334,8 +1326,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	}
 
 	rdata->credits.value = 0;
+	rdata->subreq.error = rdata->result;
 	rdata->subreq.transferred += rdata->got_bytes;
-	INIT_WORK(&rdata->subreq.work, cifs_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index a58a3333ecc3..10dd440f8178 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -227,7 +227,8 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 	return;
 
 failed:
-	netfs_read_subreq_terminated(subreq, rc, false);
+	subreq->error = rc;
+	netfs_read_subreq_terminated(subreq, false);
 }
 
 /*
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 6584b5cddc28..0166eb42ce94 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4513,14 +4513,6 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	return rc;
 }
 
-static void smb2_readv_worker(struct work_struct *work)
-{
-	struct cifs_io_subrequest *rdata =
-		container_of(work, struct cifs_io_subrequest, subreq.work);
-
-	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
-}
-
 static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
@@ -4633,9 +4625,9 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			      server->credits, server->in_flight,
 			      0, cifs_trace_rw_credits_read_response_clear);
 	rdata->credits.value = 0;
+	rdata->subreq.error = rdata->result;
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
-	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 0d4ed1229024..a3aa36c1869f 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -428,10 +428,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
 
 /* (Sub)request management API. */
-void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
-				bool was_async);
-void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
-				  int error, bool was_async);
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq, bool was_async);
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq, bool was_async);
+void netfs_read_subreq_termination_worker(struct work_struct *work);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,


