Return-Path: <linux-fsdevel+bounces-25981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE49523FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2DD1F22F19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789BD1D174E;
	Wed, 14 Aug 2024 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Abnai2TJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A81C462A
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668100; cv=none; b=SGg2eQyQRTae8xeS4lbh4V97Q9CavnoIrMdzJzqTTBg0DJmrjtXDGNb+ymcVRw2huycOdocdMSmWJln7Ur6WSXCx/usjH0FszJaAdN9I/mD5vv8oam3wtdFetOMXPZEKOO/FA/B1xOk7qvSGVwd0Gcdrt8LkwdPqsq4cCQcMyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668100; c=relaxed/simple;
	bh=l8S2iYCKNnWpN035R+Er8bHfVMmRqpuyZCjMHa5UHYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijQs0ecVXlGMyIHo2R8WKP+5d3rIMy/BqxLDvuGCLAnIrb61XozFXcT82XQCegmLD5iQkPFSqo8BrVgR1Ft5Jus9GUJg7Iztl36PLAQK9Vy8X8kbL6+hAmL/BlhLvVAedUueTSynkNofbjUaDy5yino1lUTukkiuLMsQoO9SEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Abnai2TJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2CkGYFFBDeGUQX5+vS3EcFzWb373y7gmne0MD+WEtE=;
	b=Abnai2TJ/62pzyQHAS7/5KgDfszdNdskJQaF8RH9qnpxzMTuYkXPQF0nSrHVFHiAUJvomz
	ae4cUSa/i3O1mKnCHribk5BjF7yqwer5taGVM9oPdahb4N5rHXqx95ZFYYm0+TtSjvRLUg
	Tlrm2rFCJhg2gCKjEldMHZ53eqUVjf8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642--o7TRWbiM4emMZ6E8iU5dQ-1; Wed,
 14 Aug 2024 16:41:27 -0400
X-MC-Unique: -o7TRWbiM4emMZ6E8iU5dQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 098BC1925387;
	Wed, 14 Aug 2024 20:41:24 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1C5719560A3;
	Wed, 14 Aug 2024 20:41:17 +0000 (UTC)
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
Subject: [PATCH v2 19/25] netfs: Speed up buffered reading
Date: Wed, 14 Aug 2024 21:38:39 +0100
Message-ID: <20240814203850.2240469-20-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Improve the efficiency of buffered reads in a number of ways:

 (1) Overhaul the algorithm in general so that it's a lot more compact and
     split the read submission code between buffered and unbuffered
     versions.  The unbuffered version can be vastly simplified.

 (2) Read-result collection is handed off to a work queue rather than being
     done in the I/O thread.  Multiple subrequests can be processes
     simultaneously.

 (3) When a subrequest is collected, any folios it fully spans are
     collected and "spare" data on either side is donated to either the
     previous or the next subrequest in the sequence.

Notes:

 (*) Readahead expansion is massively slows down fio, presumably because it
     causes a load of extra allocations, both folio and xarray, up front
     before RPC requests can be transmitted.

 (*) RDMA with cifs does appear to work, both with SIW and RXE.

 (*) PG_private_2-based reading and copy-to-cache is split out into its own
     file and altered to use folio_queue.  Note that the copy to the cache
     now creates a new write transaction against the cache and adds the
     folios to be copied into it.  This allows it to use part of the
     writeback I/O code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c             |   5 +-
 fs/afs/file.c                |  21 +-
 fs/afs/fsclient.c            |   9 +-
 fs/afs/yfsclient.c           |   9 +-
 fs/ceph/addr.c               |  76 ++--
 fs/netfs/Makefile            |   4 +-
 fs/netfs/buffered_read.c     | 766 +++++++++++++++++++++--------------
 fs/netfs/direct_read.c       | 147 ++++++-
 fs/netfs/internal.h          |  35 +-
 fs/netfs/iterator.c          |  50 +++
 fs/netfs/main.c              |   4 +-
 fs/netfs/objects.c           |   8 +-
 fs/netfs/read_collect.c      | 544 +++++++++++++++++++++++++
 fs/netfs/read_pgpriv2.c      | 264 ++++++++++++
 fs/netfs/read_retry.c        | 256 ++++++++++++
 fs/netfs/stats.c             |   6 +-
 fs/netfs/write_collect.c     |   9 +-
 fs/netfs/write_issue.c       |  17 +-
 fs/nfs/fscache.c             |  19 +-
 fs/nfs/fscache.h             |   7 +-
 fs/smb/client/cifssmb.c      |   6 +-
 fs/smb/client/file.c         |  57 +--
 fs/smb/client/smb2pdu.c      |  10 +-
 include/linux/folio_queue.h  |  18 +
 include/linux/netfs.h        |  25 +-
 include/trace/events/netfs.h | 103 ++++-
 26 files changed, 2045 insertions(+), 430 deletions(-)
 create mode 100644 fs/netfs/read_collect.c
 create mode 100644 fs/netfs/read_pgpriv2.c
 create mode 100644 fs/netfs/read_retry.c

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 24fdc74caeba..469ea158a73d 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -78,7 +78,10 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	if (subreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
-	netfs_subreq_terminated(subreq, err ?: total, false);
+	if (!err)
+		subreq->transferred += total;
+
+	netfs_read_subreq_terminated(subreq, err, false);
 }
 
 /**
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 5a9d16848ad5..492d857a3fa0 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/netfs.h>
+#include <trace/events/netfs.h>
 #include "internal.h"
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
@@ -242,9 +243,10 @@ static void afs_fetch_data_notify(struct afs_operation *op)
 
 	req->error = error;
 	if (subreq) {
-		if (subreq->rreq->origin != NETFS_DIO_READ)
-			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-		netfs_subreq_terminated(subreq, error ?: req->actual_len, false);
+		subreq->rreq->i_size = req->file_size;
+		if (req->pos + req->actual_len >= req->file_size)
+			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
+		netfs_read_subreq_terminated(subreq, error, false);
 		req->subreq = NULL;
 	} else if (req->done) {
 		req->done(req);
@@ -262,6 +264,12 @@ static void afs_fetch_data_success(struct afs_operation *op)
 	afs_fetch_data_notify(op);
 }
 
+static void afs_fetch_data_aborted(struct afs_operation *op)
+{
+	afs_check_for_remote_deletion(op);
+	afs_fetch_data_notify(op);
+}
+
 static void afs_fetch_data_put(struct afs_operation *op)
 {
 	op->fetch.req->error = afs_op_error(op);
@@ -272,7 +280,7 @@ static const struct afs_operation_ops afs_fetch_data_operation = {
 	.issue_afs_rpc	= afs_fs_fetch_data,
 	.issue_yfs_rpc	= yfs_fs_fetch_data,
 	.success	= afs_fetch_data_success,
-	.aborted	= afs_check_for_remote_deletion,
+	.aborted	= afs_fetch_data_aborted,
 	.failed		= afs_fetch_data_notify,
 	.put		= afs_fetch_data_put,
 };
@@ -294,7 +302,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	op = afs_alloc_operation(req->key, vnode->volume);
 	if (IS_ERR(op)) {
 		if (req->subreq)
-			netfs_subreq_terminated(req->subreq, PTR_ERR(op), false);
+			netfs_read_subreq_terminated(req->subreq, PTR_ERR(op), false);
 		return PTR_ERR(op);
 	}
 
@@ -313,7 +321,7 @@ static void afs_read_worker(struct work_struct *work)
 
 	fsreq = afs_alloc_read(GFP_NOFS);
 	if (!fsreq)
-		return netfs_subreq_terminated(subreq, -ENOMEM, false);
+		return netfs_read_subreq_terminated(subreq, -ENOMEM, false);
 
 	fsreq->subreq	= subreq;
 	fsreq->pos	= subreq->start + subreq->transferred;
@@ -322,6 +330,7 @@ static void afs_read_worker(struct work_struct *work)
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &subreq->io_iter;
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	afs_fetch_data(fsreq->vnode, fsreq);
 	afs_put_read(fsreq);
 }
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 79cd30775b7a..098fa034a1cc 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -304,6 +304,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_read *req = op->fetch.req;
 	const __be32 *bp;
+	size_t count_before;
 	int ret;
 
 	_enter("{%u,%zu,%zu/%llu}",
@@ -345,10 +346,14 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 
 		/* extract the returned data */
 	case 2:
-		_debug("extract data %zu/%llu",
-		       iov_iter_count(call->iter), req->actual_len);
+		count_before = call->iov_len;
+		_debug("extract data %zu/%llu", count_before, req->actual_len);
 
 		ret = afs_extract_data(call, true);
+		if (req->subreq) {
+			req->subreq->transferred += count_before - call->iov_len;
+			netfs_read_subreq_progress(req->subreq, false);
+		}
 		if (ret < 0)
 			return ret;
 
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index f521e66d3bf6..024227aba4cd 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -355,6 +355,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_read *req = op->fetch.req;
 	const __be32 *bp;
+	size_t count_before;
 	int ret;
 
 	_enter("{%u,%zu, %zu/%llu}",
@@ -391,10 +392,14 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 
 		/* extract the returned data */
 	case 2:
-		_debug("extract data %zu/%llu",
-		       iov_iter_count(call->iter), req->actual_len);
+		count_before = call->iov_len;
+		_debug("extract data %zu/%llu", count_before, req->actual_len);
 
 		ret = afs_extract_data(call, true);
+		if (req->subreq) {
+			req->subreq->transferred += count_before - call->iov_len;
+			netfs_read_subreq_progress(req->subreq, false);
+		}
 		if (ret < 0)
 			return ret;
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c4744a02db75..c500c1fd6b9f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -13,6 +13,7 @@
 #include <linux/iversion.h>
 #include <linux/ktime.h>
 #include <linux/netfs.h>
+#include <trace/events/netfs.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -205,21 +206,6 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 	}
 }
 
-static bool ceph_netfs_clamp_length(struct netfs_io_subrequest *subreq)
-{
-	struct inode *inode = subreq->rreq->inode;
-	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	u64 objno, objoff;
-	u32 xlen;
-
-	/* Truncate the extent at the end of the current block */
-	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
-				      &objno, &objoff, &xlen);
-	subreq->len = min(xlen, fsc->mount_options->rsize);
-	return true;
-}
-
 static void finish_netfs_read(struct ceph_osd_request *req)
 {
 	struct inode *inode = req->r_inode;
@@ -264,7 +250,12 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 				     calc_pages_for(osd_data->alignment,
 					osd_data->length), false);
 	}
-	netfs_subreq_terminated(subreq, err, false);
+	if (err > 0) {
+		subreq->transferred = err;
+		err = 0;
+	}
+	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
+	netfs_read_subreq_terminated(subreq, err, false);
 	iput(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
@@ -278,7 +269,6 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct iov_iter iter;
 	ssize_t err = 0;
 	size_t len;
 	int mode;
@@ -301,6 +291,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
 	req->r_num_caps = 2;
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	if (err < 0)
 		goto out;
@@ -314,17 +305,36 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	}
 
 	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
-	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
-	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &iter);
-	if (err == 0)
+	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->io_iter);
+	if (err == 0) {
 		err = -EFAULT;
+	} else {
+		subreq->transferred += err;
+		err = 0;
+	}
 
 	ceph_mdsc_put_request(req);
 out:
-	netfs_subreq_terminated(subreq, err, false);
+	netfs_read_subreq_terminated(subreq, err, false);
 	return true;
 }
 
+static int ceph_netfs_prepare_read(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct inode *inode = rreq->inode;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	u64 objno, objoff;
+	u32 xlen;
+
+	/* Truncate the extent at the end of the current block */
+	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
+				      &objno, &objoff, &xlen);
+	rreq->io_streams[0].sreq_max_len = umin(xlen, fsc->mount_options->rsize);
+	return 0;
+}
+
 static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
@@ -334,9 +344,8 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_request *req = NULL;
 	struct ceph_vino vino = ceph_vino(inode);
-	struct iov_iter iter;
-	int err = 0;
-	u64 len = subreq->len;
+	int err;
+	u64 len;
 	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
 	u64 off = subreq->start;
 	int extent_cnt;
@@ -349,6 +358,12 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	if (ceph_has_inline_data(ci) && ceph_netfs_issue_op_inline(subreq))
 		return;
 
+	// TODO: This rounding here is slightly dodgy.  It *should* work, for
+	// now, as the cache only deals in blocks that are a multiple of
+	// PAGE_SIZE and fscrypt blocks are at most PAGE_SIZE.  What needs to
+	// happen is for the fscrypt driving to be moved into netfslib and the
+	// data in the cache also to be stored encrypted.
+	len = subreq->len;
 	ceph_fscrypt_adjust_off_and_len(inode, &off, &len);
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino,
@@ -371,8 +386,6 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	doutc(cl, "%llx.%llx pos=%llu orig_len=%zu len=%llu\n",
 	      ceph_vinop(inode), subreq->start, subreq->len, len);
 
-	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
-
 	/*
 	 * FIXME: For now, use CEPH_OSD_DATA_TYPE_PAGES instead of _ITER for
 	 * encrypted inodes. We'd need infrastructure that handles an iov_iter
@@ -384,7 +397,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		struct page **pages;
 		size_t page_off;
 
-		err = iov_iter_get_pages_alloc2(&iter, &pages, len, &page_off);
+		err = iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, len, &page_off);
 		if (err < 0) {
 			doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
 			      ceph_vinop(inode), err);
@@ -399,7 +412,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false,
 						 false);
 	} else {
-		osd_req_op_extent_osd_iter(req, 0, &iter);
+		osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
 	}
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 		err = -EIO;
@@ -410,17 +423,19 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	req->r_inode = inode;
 	ihold(inode);
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	ceph_osdc_start_request(req->r_osdc, req);
 out:
 	ceph_osdc_put_request(req);
 	if (err)
-		netfs_subreq_terminated(subreq, err, false);
+		netfs_read_subreq_terminated(subreq, err, false);
 	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
 }
 
 static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct inode *inode = rreq->inode;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int got = 0, want = CEPH_CAP_FILE_CACHE;
 	struct ceph_netfs_request_data *priv;
@@ -472,6 +487,7 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 
 	priv->caps = got;
 	rreq->netfs_priv = priv;
+	rreq->io_streams[0].sreq_max_len = fsc->mount_options->rsize;
 
 out:
 	if (ret < 0)
@@ -496,9 +512,9 @@ static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 const struct netfs_request_ops ceph_netfs_ops = {
 	.init_request		= ceph_init_request,
 	.free_request		= ceph_netfs_free_request,
+	.prepare_read		= ceph_netfs_prepare_read,
 	.issue_read		= ceph_netfs_issue_read,
 	.expand_readahead	= ceph_netfs_expand_readahead,
-	.clamp_length		= ceph_netfs_clamp_length,
 	.check_write_begin	= ceph_netfs_check_write_begin,
 };
 
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 8e6781e0b10b..d08b0bfb6756 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -5,12 +5,14 @@ netfs-y := \
 	buffered_write.o \
 	direct_read.o \
 	direct_write.o \
-	io.o \
 	iterator.o \
 	locking.o \
 	main.o \
 	misc.o \
 	objects.o \
+	read_collect.o \
+	read_pgpriv2.o \
+	read_retry.o \
 	write_collect.o \
 	write_issue.o
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 27c750d39476..c40e226053cc 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -9,266 +9,388 @@
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 
-/*
- * [DEPRECATED] Unlock the folios in a read operation for when the filesystem
- * is using PG_private_2 and direct writing to the cache from here rather than
- * marking the page for writeback.
- *
- * Note that we don't touch folio->private in this code.
- */
-static void netfs_rreq_unlock_folios_pgpriv2(struct netfs_io_request *rreq,
-					     size_t *account)
+static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
+					 unsigned long long *_start,
+					 unsigned long long *_len,
+					 unsigned long long i_size)
 {
-	struct netfs_io_subrequest *subreq;
-	struct folio *folio;
-	pgoff_t start_page = rreq->start / PAGE_SIZE;
-	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
-	bool subreq_failed = false;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
-	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
+	if (cres->ops && cres->ops->expand_readahead)
+		cres->ops->expand_readahead(cres, _start, _len, i_size);
+}
 
-	/* Walk through the pagecache and the I/O request lists simultaneously.
-	 * We may have a mixture of cached and uncached sections and we only
-	 * really want to write out the uncached sections.  This is slightly
-	 * complicated by the possibility that we might have huge pages with a
-	 * mixture inside.
+static void netfs_rreq_expand(struct netfs_io_request *rreq,
+			      struct readahead_control *ractl)
+{
+	/* Give the cache a chance to change the request parameters.  The
+	 * resultant request must contain the original region.
 	 */
-	subreq = list_first_entry(&rreq->subrequests,
-				  struct netfs_io_subrequest, rreq_link);
-	subreq_failed = (subreq->error < 0);
+	netfs_cache_expand_readahead(rreq, &rreq->start, &rreq->len, rreq->i_size);
 
-	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock_pgpriv2);
+	/* Give the netfs a chance to change the request parameters.  The
+	 * resultant request must contain the original region.
+	 */
+	if (rreq->netfs_ops->expand_readahead)
+		rreq->netfs_ops->expand_readahead(rreq);
 
-	rcu_read_lock();
-	xas_for_each(&xas, folio, last_page) {
-		loff_t pg_end;
-		bool pg_failed = false;
-		bool folio_started = false;
+	/* Expand the request if the cache wants it to start earlier.  Note
+	 * that the expansion may get further extended if the VM wishes to
+	 * insert THPs and the preferred start and/or end wind up in the middle
+	 * of THPs.
+	 *
+	 * If this is the case, however, the THP size should be an integer
+	 * multiple of the cache granule size, so we get a whole number of
+	 * granules to deal with.
+	 */
+	if (rreq->start  != readahead_pos(ractl) ||
+	    rreq->len != readahead_length(ractl)) {
+		readahead_expand(ractl, rreq->start, rreq->len);
+		rreq->start  = readahead_pos(ractl);
+		rreq->len = readahead_length(ractl);
 
-		if (xas_retry(&xas, folio))
-			continue;
+		trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
+				 netfs_read_trace_expanded);
+	}
+}
 
-		pg_end = folio_pos(folio) + folio_size(folio) - 1;
+/*
+ * Begin an operation, and fetch the stored zero point value from the cookie if
+ * available.
+ */
+static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_inode *ctx)
+{
+	return fscache_begin_read_operation(&rreq->cache_resources, netfs_i_cookie(ctx));
+}
 
-		for (;;) {
-			loff_t sreq_end;
+/*
+ * Decant the list of folios to read into a rolling buffer.
+ */
+static size_t netfs_load_buffer_from_ra(struct netfs_io_request *rreq,
+					struct folio_queue *folioq)
+{
+	unsigned int order, nr;
+	size_t size = 0;
+
+	nr = __readahead_batch(rreq->ractl, (struct page **)folioq->vec.folios,
+			       ARRAY_SIZE(folioq->vec.folios));
+	folioq->vec.nr = nr;
+	for (int i = 0; i < nr; i++) {
+		struct folio *folio = folioq_folio(folioq, i);
+
+		trace_netfs_folio(folio, netfs_folio_trace_read);
+		order = folio_order(folio);
+		folioq->orders[i] = order;
+		size += PAGE_SIZE << order;
+	}
 
-			if (!subreq) {
-				pg_failed = true;
-				break;
-			}
+	for (int i = nr; i < folioq_nr_slots(folioq); i++)
+		folioq_clear(folioq, i);
 
-			if (!folio_started &&
-			    test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags) &&
-			    fscache_operation_valid(&rreq->cache_resources)) {
-				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
-				folio_start_private_2(folio);
-				folio_started = true;
-			}
+	return size;
+}
 
-			pg_failed |= subreq_failed;
-			sreq_end = subreq->start + subreq->len - 1;
-			if (pg_end < sreq_end)
-				break;
+/*
+ * netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
+ * @subreq: The subrequest to be set up
+ *
+ * Prepare the I/O iterator representing the read buffer on a subrequest for
+ * the filesystem to use for I/O (it can be passed directly to a socket).  This
+ * is intended to be called from the ->issue_read() method once the filesystem
+ * has trimmed the request to the size it wants.
+ *
+ * Returns the limited size if successful and -ENOMEM if insufficient memory
+ * available.
+ *
+ * [!] NOTE: This must be run in the same thread as ->issue_read() was called
+ * in as we access the readahead_control struct.
+ */
+static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	size_t rsize = subreq->len;
+
+	if (subreq->source == NETFS_DOWNLOAD_FROM_SERVER)
+		rsize = umin(rsize, rreq->io_streams[0].sreq_max_len);
+
+	if (rreq->ractl) {
+		/* If we don't have sufficient folios in the rolling buffer,
+		 * extract a folioq's worth from the readahead region at a time
+		 * into the buffer.  Note that this acquires a ref on each page
+		 * that we will need to release later - but we don't want to do
+		 * that until after we've started the I/O.
+		 */
+		while (rreq->submitted < subreq->start + rsize) {
+			struct folio_queue *tail = rreq->buffer_tail, *new;
+			size_t added;
+
+			new = kmalloc(sizeof(*new), GFP_NOFS);
+			if (!new)
+				return -ENOMEM;
+			netfs_stat(&netfs_n_folioq);
+			folioq_init(new);
+			new->prev = tail;
+			tail->next = new;
+			rreq->buffer_tail = new;
+			added = netfs_load_buffer_from_ra(rreq, new);
+			rreq->iter.count += added;
+			rreq->submitted += added;
+		}
+	}
 
-			*account += subreq->transferred;
-			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-				subreq = list_next_entry(subreq, rreq_link);
-				subreq_failed = (subreq->error < 0);
-			} else {
-				subreq = NULL;
-				subreq_failed = false;
-			}
+	subreq->len = rsize;
+	if (unlikely(rreq->io_streams[0].sreq_max_segs)) {
+		size_t limit = netfs_limit_iter(&rreq->iter, 0, rsize,
+						rreq->io_streams[0].sreq_max_segs);
 
-			if (pg_end == sreq_end)
-				break;
+		if (limit < rsize) {
+			subreq->len = limit;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
 		}
+	}
 
-		if (!pg_failed) {
-			flush_dcache_folio(folio);
-			folio_mark_uptodate(folio);
-		}
+	subreq->io_iter	= rreq->iter;
 
-		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-			if (folio->index == rreq->no_unlock_folio &&
-			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
-				_debug("no unlock");
-			else
-				folio_unlock(folio);
+	if (iov_iter_is_folioq(&subreq->io_iter)) {
+		if (subreq->io_iter.folioq_slot >= folioq_nr_slots(subreq->io_iter.folioq)) {
+			subreq->io_iter.folioq = subreq->io_iter.folioq->next;
+			subreq->io_iter.folioq_slot = 0;
 		}
+		subreq->curr_folioq = (struct folio_queue *)subreq->io_iter.folioq;
+		subreq->curr_folioq_slot = subreq->io_iter.folioq_slot;
+		subreq->curr_folio_order = subreq->curr_folioq->orders[subreq->curr_folioq_slot];
 	}
-	rcu_read_unlock();
+
+	iov_iter_truncate(&subreq->io_iter, subreq->len);
+	iov_iter_advance(&rreq->iter, subreq->len);
+	return subreq->len;
 }
 
-/*
- * Unlock the folios in a read operation.  We need to set PG_writeback on any
- * folios we're going to write back before we unlock them.
- *
- * Note that if the deprecated NETFS_RREQ_USE_PGPRIV2 is set then we use
- * PG_private_2 and do a direct write to the cache from here instead.
- */
-void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
+static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rreq,
+						     struct netfs_io_subrequest *subreq,
+						     loff_t i_size)
 {
-	struct netfs_io_subrequest *subreq;
-	struct netfs_folio *finfo;
-	struct folio *folio;
-	pgoff_t start_page = rreq->start / PAGE_SIZE;
-	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
-	size_t account = 0;
-	bool subreq_failed = false;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
-	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
+	if (!cres->ops)
+		return NETFS_DOWNLOAD_FROM_SERVER;
+	return cres->ops->prepare_read(subreq, i_size);
+}
 
-	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
-		__clear_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
-		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-			__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
-		}
-	}
+static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
+					bool was_async)
+{
+	struct netfs_io_subrequest *subreq = priv;
 
-	/* Handle deprecated PG_private_2 case. */
-	if (test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)) {
-		netfs_rreq_unlock_folios_pgpriv2(rreq, &account);
-		goto out;
+	if (transferred_or_error < 0) {
+		netfs_read_subreq_terminated(subreq, transferred_or_error, was_async);
+		return;
 	}
 
-	/* Walk through the pagecache and the I/O request lists simultaneously.
-	 * We may have a mixture of cached and uncached sections and we only
-	 * really want to write out the uncached sections.  This is slightly
-	 * complicated by the possibility that we might have huge pages with a
-	 * mixture inside.
-	 */
-	subreq = list_first_entry(&rreq->subrequests,
-				  struct netfs_io_subrequest, rreq_link);
-	subreq_failed = (subreq->error < 0);
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock);
+	if (transferred_or_error > 0)
+		subreq->transferred += transferred_or_error;
+	netfs_read_subreq_terminated(subreq, 0, was_async);
+}
 
-	rcu_read_lock();
-	xas_for_each(&xas, folio, last_page) {
-		loff_t pg_end;
-		bool pg_failed = false;
-		bool wback_to_cache = false;
+/*
+ * Issue a read against the cache.
+ * - Eats the caller's ref on subreq.
+ */
+static void netfs_read_cache_to_pagecache(struct netfs_io_request *rreq,
+					  struct netfs_io_subrequest *subreq)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
-		if (xas_retry(&xas, folio))
-			continue;
+	netfs_stat(&netfs_n_rh_read);
+	cres->ops->read(cres, subreq->start, &subreq->io_iter, NETFS_READ_HOLE_IGNORE,
+			netfs_cache_read_terminated, subreq);
+}
 
-		pg_end = folio_pos(folio) + folio_size(folio) - 1;
+/*
+ * Perform a read to the pagecache from a series of sources of different types,
+ * slicing up the region to be read according to available cache blocks and
+ * network rsize.
+ */
+static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
+{
+	struct netfs_inode *ictx = netfs_inode(rreq->inode);
+	unsigned long long start = rreq->start;
+	ssize_t size = rreq->len;
+	int ret = 0;
+
+	atomic_inc(&rreq->nr_outstanding);
+
+	do {
+		struct netfs_io_subrequest *subreq;
+		enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
+		ssize_t slice;
+
+		subreq = netfs_alloc_subrequest(rreq);
+		if (!subreq) {
+			ret = -ENOMEM;
+			break;
+		}
 
-		for (;;) {
-			loff_t sreq_end;
+		subreq->start	= start;
+		subreq->len	= size;
+
+		atomic_inc(&rreq->nr_outstanding);
+		spin_lock_bh(&rreq->lock);
+		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+		subreq->prev_donated = rreq->prev_donated;
+		rreq->prev_donated = 0;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
+		spin_unlock_bh(&rreq->lock);
+
+		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
+		subreq->source = source;
+		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
+			unsigned long long zp = umin(ictx->zero_point, rreq->i_size);
+			size_t len = subreq->len;
+
+			if (subreq->start >= zp) {
+				subreq->source = source = NETFS_FILL_WITH_ZEROES;
+				goto fill_with_zeroes;
+			}
 
-			if (!subreq) {
-				pg_failed = true;
+			if (len > zp - subreq->start)
+				len = zp - subreq->start;
+			if (len == 0) {
+				pr_err("ZERO-LEN READ: R=%08x[%x] l=%zx/%zx s=%llx z=%llx i=%llx",
+				       rreq->debug_id, subreq->debug_index,
+				       subreq->len, size,
+				       subreq->start, ictx->zero_point, rreq->i_size);
 				break;
 			}
+			subreq->len = len;
+
+			netfs_stat(&netfs_n_rh_download);
+			if (rreq->netfs_ops->prepare_read) {
+				ret = rreq->netfs_ops->prepare_read(subreq);
+				if (ret < 0) {
+					atomic_dec(&rreq->nr_outstanding);
+					netfs_put_subrequest(subreq, false,
+							     netfs_sreq_trace_put_cancel);
+					break;
+				}
+				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+			}
 
-			wback_to_cache |= test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
-			pg_failed |= subreq_failed;
-			sreq_end = subreq->start + subreq->len - 1;
-			if (pg_end < sreq_end)
+			slice = netfs_prepare_read_iterator(subreq);
+			if (slice < 0) {
+				atomic_dec(&rreq->nr_outstanding);
+				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+				ret = slice;
 				break;
-
-			account += subreq->transferred;
-			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-				subreq = list_next_entry(subreq, rreq_link);
-				subreq_failed = (subreq->error < 0);
-			} else {
-				subreq = NULL;
-				subreq_failed = false;
 			}
 
-			if (pg_end == sreq_end)
-				break;
+			rreq->netfs_ops->issue_read(subreq);
+			goto done;
 		}
 
-		if (!pg_failed) {
-			flush_dcache_folio(folio);
-			finfo = netfs_folio_info(folio);
-			if (finfo) {
-				trace_netfs_folio(folio, netfs_folio_trace_filled_gaps);
-				if (finfo->netfs_group)
-					folio_change_private(folio, finfo->netfs_group);
-				else
-					folio_detach_private(folio);
-				kfree(finfo);
-			}
-			folio_mark_uptodate(folio);
-			if (wback_to_cache && !WARN_ON_ONCE(folio_get_private(folio) != NULL)) {
-				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
-				folio_attach_private(folio, NETFS_FOLIO_COPY_TO_CACHE);
-				filemap_dirty_folio(folio->mapping, folio);
-			}
+	fill_with_zeroes:
+		if (source == NETFS_FILL_WITH_ZEROES) {
+			subreq->source = NETFS_FILL_WITH_ZEROES;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+			netfs_stat(&netfs_n_rh_zero);
+			slice = netfs_prepare_read_iterator(subreq);
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+			netfs_read_subreq_terminated(subreq, 0, false);
+			goto done;
 		}
 
-		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-			if (folio->index == rreq->no_unlock_folio &&
-			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
-				_debug("no unlock");
-			else
-				folio_unlock(folio);
+		if (source == NETFS_READ_FROM_CACHE) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+			slice = netfs_prepare_read_iterator(subreq);
+			netfs_read_cache_to_pagecache(rreq, subreq);
+			goto done;
 		}
-	}
-	rcu_read_unlock();
 
-out:
-	task_io_account_read(account);
-	if (rreq->netfs_ops->done)
-		rreq->netfs_ops->done(rreq);
-}
+		pr_err("Unexpected read source %u\n", source);
+		WARN_ON_ONCE(1);
+		break;
 
-static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
-					 unsigned long long *_start,
-					 unsigned long long *_len,
-					 unsigned long long i_size)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	done:
+		size -= slice;
+		start += slice;
+		cond_resched();
+	} while (size > 0);
 
-	if (cres->ops && cres->ops->expand_readahead)
-		cres->ops->expand_readahead(cres, _start, _len, i_size);
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		netfs_rreq_terminated(rreq, false);
+
+	/* Defer error return as we may need to wait for outstanding I/O. */
+	cmpxchg(&rreq->error, 0, ret);
 }
 
-static void netfs_rreq_expand(struct netfs_io_request *rreq,
-			      struct readahead_control *ractl)
+/*
+ * Wait for the read operation to complete, successfully or otherwise.
+ */
+static int netfs_wait_for_read(struct netfs_io_request *rreq)
 {
-	/* Give the cache a chance to change the request parameters.  The
-	 * resultant request must contain the original region.
-	 */
-	netfs_cache_expand_readahead(rreq, &rreq->start, &rreq->len, rreq->i_size);
+	int ret;
 
-	/* Give the netfs a chance to change the request parameters.  The
-	 * resultant request must contain the original region.
-	 */
-	if (rreq->netfs_ops->expand_readahead)
-		rreq->netfs_ops->expand_readahead(rreq);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
+	wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS, TASK_UNINTERRUPTIBLE);
+	ret = rreq->error;
+	if (ret == 0 && rreq->submitted < rreq->len) {
+		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
+		ret = -EIO;
+	}
 
-	/* Expand the request if the cache wants it to start earlier.  Note
-	 * that the expansion may get further extended if the VM wishes to
-	 * insert THPs and the preferred start and/or end wind up in the middle
-	 * of THPs.
-	 *
-	 * If this is the case, however, the THP size should be an integer
-	 * multiple of the cache granule size, so we get a whole number of
-	 * granules to deal with.
-	 */
-	if (rreq->start  != readahead_pos(ractl) ||
-	    rreq->len != readahead_length(ractl)) {
-		readahead_expand(ractl, rreq->start, rreq->len);
-		rreq->start  = readahead_pos(ractl);
-		rreq->len = readahead_length(ractl);
+	return ret;
+}
 
-		trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
-				 netfs_read_trace_expanded);
-	}
+/*
+ * Set up the initial folioq of buffer folios in the rolling buffer and set the
+ * iterator to refer to it.
+ */
+static int netfs_prime_buffer(struct netfs_io_request *rreq)
+{
+	struct folio_queue *folioq;
+	size_t added;
+
+	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
+	if (!folioq)
+		return -ENOMEM;
+	netfs_stat(&netfs_n_folioq);
+	folioq_init(folioq);
+	rreq->buffer = folioq;
+	rreq->buffer_tail = folioq;
+	rreq->submitted = rreq->start;
+	iov_iter_folio_queue(&rreq->iter, ITER_DEST, folioq, 0, 0, 0);
+
+	added = netfs_load_buffer_from_ra(rreq, folioq);
+	rreq->iter.count += added;
+	rreq->submitted += added;
+	return 0;
 }
 
 /*
- * Begin an operation, and fetch the stored zero point value from the cookie if
- * available.
+ * Drop the ref on each folio that we inherited from the VM readahead code.  We
+ * still have the folio locks to pin the page until we complete the I/O.
+ *
+ * Note that we can't just release the batch in each queue struct as we use the
+ * occupancy count in other places.
  */
-static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_inode *ctx)
+static void netfs_put_ra_refs(struct folio_queue *folioq)
 {
-	return fscache_begin_read_operation(&rreq->cache_resources, netfs_i_cookie(ctx));
+	struct folio_batch fbatch;
+
+	folio_batch_init(&fbatch);
+	while (folioq) {
+		for (unsigned int slot = 0; slot < folioq_count(folioq); slot++) {
+			struct folio *folio = folioq_folio(folioq, slot);
+			if (!folio)
+				continue;
+			trace_netfs_folio(folio, netfs_folio_trace_read_put);
+			if (!folio_batch_add(&fbatch, folio))
+				folio_batch_release(&fbatch);
+		}
+		folioq = folioq->next;
+	}
+
+	folio_batch_release(&fbatch);
 }
 
 /**
@@ -289,22 +411,17 @@ static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_in
 void netfs_readahead(struct readahead_control *ractl)
 {
 	struct netfs_io_request *rreq;
-	struct netfs_inode *ctx = netfs_inode(ractl->mapping->host);
+	struct netfs_inode *ictx = netfs_inode(ractl->mapping->host);
+	unsigned long long start = readahead_pos(ractl);
+	size_t size = readahead_length(ractl);
 	int ret;
 
-	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
-
-	if (readahead_count(ractl) == 0)
-		return;
-
-	rreq = netfs_alloc_request(ractl->mapping, ractl->file,
-				   readahead_pos(ractl),
-				   readahead_length(ractl),
+	rreq = netfs_alloc_request(ractl->mapping, ractl->file, start, size,
 				   NETFS_READAHEAD);
 	if (IS_ERR(rreq))
 		return;
 
-	ret = netfs_begin_cache_read(rreq, ctx);
+	ret = netfs_begin_cache_read(rreq, ictx);
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 		goto cleanup_free;
 
@@ -314,18 +431,15 @@ void netfs_readahead(struct readahead_control *ractl)
 
 	netfs_rreq_expand(rreq, ractl);
 
-	/* Set up the output buffer */
-	iov_iter_xarray(&rreq->iter, ITER_DEST, &ractl->mapping->i_pages,
-			rreq->start, rreq->len);
+	rreq->ractl = ractl;
+	if (netfs_prime_buffer(rreq) < 0)
+		goto cleanup_free;
+	netfs_read_to_pagecache(rreq);
 
-	/* Drop the refs on the folios here rather than in the cache or
-	 * filesystem.  The locks will be dropped in netfs_rreq_unlock().
-	 */
-	while (readahead_folio(ractl))
-		;
+	/* Release the folio refs whilst we're waiting for the I/O. */
+	netfs_put_ra_refs(rreq->buffer);
 
-	netfs_begin_read(rreq, false);
-	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
+	netfs_put_request(rreq, true, netfs_rreq_trace_put_return);
 	return;
 
 cleanup_free:
@@ -334,6 +448,117 @@ void netfs_readahead(struct readahead_control *ractl)
 }
 EXPORT_SYMBOL(netfs_readahead);
 
+/*
+ * Create a rolling buffer with a single occupying folio.
+ */
+static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct folio *folio)
+{
+	struct folio_queue *folioq;
+
+	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
+	if (!folioq)
+		return -ENOMEM;
+
+	netfs_stat(&netfs_n_folioq);
+	folioq_init(folioq);
+	folioq_append(folioq, folio);
+	BUG_ON(folioq_folio(folioq, 0) != folio);
+	BUG_ON(folioq_folio_order(folioq, 0) != folio_order(folio));
+	rreq->buffer = folioq;
+	rreq->buffer_tail = folioq;
+	rreq->submitted = rreq->start + rreq->len;
+	iov_iter_folio_queue(&rreq->iter, ITER_DEST, folioq, 0, 0, rreq->len);
+	rreq->ractl = (struct readahead_control *)1UL;
+	return 0;
+}
+
+/*
+ * Read into gaps in a folio partially filled by a streaming write.
+ */
+static int netfs_read_gaps(struct file *file, struct folio *folio)
+{
+	struct netfs_io_request *rreq;
+	struct address_space *mapping = folio->mapping;
+	struct netfs_folio *finfo = netfs_folio_info(folio);
+	struct netfs_inode *ctx = netfs_inode(mapping->host);
+	struct folio *sink = NULL;
+	struct bio_vec *bvec;
+	unsigned int from = finfo->dirty_offset;
+	unsigned int to = from + finfo->dirty_len;
+	unsigned int off = 0, i = 0;
+	size_t flen = folio_size(folio);
+	size_t nr_bvec = flen / PAGE_SIZE + 2;
+	size_t part;
+	int ret;
+
+	_enter("%lx", folio->index);
+
+	rreq = netfs_alloc_request(mapping, file, folio_pos(folio), flen, NETFS_READ_GAPS);
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
+		goto alloc_error;
+	}
+
+	ret = netfs_begin_cache_read(rreq, ctx);
+	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
+		goto discard;
+
+	netfs_stat(&netfs_n_rh_read_folio);
+	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_read_gaps);
+
+	/* Fiddle the buffer so that a gap at the beginning and/or a gap at the
+	 * end get copied to, but the middle is discarded.
+	 */
+	ret = -ENOMEM;
+	bvec = kmalloc_array(nr_bvec, sizeof(*bvec), GFP_KERNEL);
+	if (!bvec)
+		goto discard;
+
+	sink = folio_alloc(GFP_KERNEL, 0);
+	if (!sink) {
+		kfree(bvec);
+		goto discard;
+	}
+
+	trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
+
+	rreq->direct_bv = bvec;
+	rreq->direct_bv_count = nr_bvec;
+	if (from > 0) {
+		bvec_set_folio(&bvec[i++], folio, from, 0);
+		off = from;
+	}
+	while (off < to) {
+		part = min_t(size_t, to - off, PAGE_SIZE);
+		bvec_set_folio(&bvec[i++], sink, part, 0);
+		off += part;
+	}
+	if (to < flen)
+		bvec_set_folio(&bvec[i++], folio, flen - to, to);
+	iov_iter_bvec(&rreq->iter, ITER_DEST, bvec, i, rreq->len);
+	rreq->submitted = rreq->start + flen;
+
+	netfs_read_to_pagecache(rreq);
+
+	if (sink)
+		folio_put(sink);
+
+	ret = netfs_wait_for_read(rreq);
+	if (ret == 0) {
+		flush_dcache_folio(folio);
+		folio_mark_uptodate(folio);
+	}
+	folio_unlock(folio);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
+	return ret < 0 ? ret : 0;
+
+discard:
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
+alloc_error:
+	folio_unlock(folio);
+	return ret;
+}
+
 /**
  * netfs_read_folio - Helper to manage a read_folio request
  * @file: The file to read from
@@ -353,9 +578,13 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	struct address_space *mapping = folio->mapping;
 	struct netfs_io_request *rreq;
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
-	struct folio *sink = NULL;
 	int ret;
 
+	if (folio_test_dirty(folio)) {
+		trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
+		return netfs_read_gaps(file, folio);
+	}
+
 	_enter("%lx", folio->index);
 
 	rreq = netfs_alloc_request(mapping, file,
@@ -374,54 +603,12 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
 	/* Set up the output buffer */
-	if (folio_test_dirty(folio)) {
-		/* Handle someone trying to read from an unflushed streaming
-		 * write.  We fiddle the buffer so that a gap at the beginning
-		 * and/or a gap at the end get copied to, but the middle is
-		 * discarded.
-		 */
-		struct netfs_folio *finfo = netfs_folio_info(folio);
-		struct bio_vec *bvec;
-		unsigned int from = finfo->dirty_offset;
-		unsigned int to = from + finfo->dirty_len;
-		unsigned int off = 0, i = 0;
-		size_t flen = folio_size(folio);
-		size_t nr_bvec = flen / PAGE_SIZE + 2;
-		size_t part;
-
-		ret = -ENOMEM;
-		bvec = kmalloc_array(nr_bvec, sizeof(*bvec), GFP_KERNEL);
-		if (!bvec)
-			goto discard;
-
-		sink = folio_alloc(GFP_KERNEL, 0);
-		if (!sink)
-			goto discard;
-
-		trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
-
-		rreq->direct_bv = bvec;
-		rreq->direct_bv_count = nr_bvec;
-		if (from > 0) {
-			bvec_set_folio(&bvec[i++], folio, from, 0);
-			off = from;
-		}
-		while (off < to) {
-			part = min_t(size_t, to - off, PAGE_SIZE);
-			bvec_set_folio(&bvec[i++], sink, part, 0);
-			off += part;
-		}
-		if (to < flen)
-			bvec_set_folio(&bvec[i++], folio, flen - to, to);
-		iov_iter_bvec(&rreq->iter, ITER_DEST, bvec, i, rreq->len);
-	} else {
-		iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
-				rreq->start, rreq->len);
-	}
+	ret = netfs_create_singular_buffer(rreq, folio);
+	if (ret < 0)
+		goto discard;
 
-	ret = netfs_begin_read(rreq, true);
-	if (sink)
-		folio_put(sink);
+	netfs_read_to_pagecache(rreq);
+	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret < 0 ? ret : 0;
 
@@ -494,13 +681,10 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
  *
  * Pre-read data for a write-begin request by drawing data from the cache if
  * possible, or the netfs if not.  Space beyond the EOF is zero-filled.
- * Multiple I/O requests from different sources will get munged together.  If
- * necessary, the readahead window can be expanded in either direction to a
- * more convenient alighment for RPC efficiency or to make storage in the cache
- * feasible.
+ * Multiple I/O requests from different sources will get munged together.
  *
  * The calling netfs must provide a table of operations, only one of which,
- * issue_op, is mandatory.
+ * issue_read, is mandatory.
  *
  * The check_write_begin() operation can be provided to check for and flush
  * conflicting writes once the folio is grabbed and locked.  It is passed a
@@ -528,8 +712,6 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int ret;
 
-	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
-
 retry:
 	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 				    mapping_gfp_mask(mapping));
@@ -577,22 +759,13 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	netfs_stat(&netfs_n_rh_write_begin);
 	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
 
-	/* Expand the request to meet caching requirements and download
-	 * preferences.
-	 */
-	ractl._nr_pages = folio_nr_pages(folio);
-	netfs_rreq_expand(rreq, &ractl);
-
 	/* Set up the output buffer */
-	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
-			rreq->start, rreq->len);
-
-	/* We hold the folio locks, so we can drop the references */
-	folio_get(folio);
-	while (readahead_folio(&ractl))
-		;
+	ret = netfs_create_singular_buffer(rreq, folio);
+	if (ret < 0)
+		goto error_put;
 
-	ret = netfs_begin_read(rreq, true);
+	netfs_read_to_pagecache(rreq);
+	ret = netfs_wait_for_read(rreq);
 	if (ret < 0)
 		goto error;
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
@@ -652,10 +825,13 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	trace_netfs_read(rreq, start, flen, netfs_read_trace_prefetch_for_write);
 
 	/* Set up the output buffer */
-	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
-			rreq->start, rreq->len);
+	ret = netfs_create_singular_buffer(rreq, folio);
+	if (ret < 0)
+		goto error_put;
 
-	ret = netfs_begin_read(rreq, true);
+	folioq_mark2(rreq->buffer, 0);
+	netfs_read_to_pagecache(rreq);
+	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret;
 
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 10a1e4da6bda..b1a66a6e6bc2 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -16,6 +16,143 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+static void netfs_prepare_dio_read_iterator(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	size_t rsize;
+
+	rsize = umin(subreq->len, rreq->io_streams[0].sreq_max_len);
+	subreq->len = rsize;
+
+	if (unlikely(rreq->io_streams[0].sreq_max_segs)) {
+		size_t limit = netfs_limit_iter(&rreq->iter, 0, rsize,
+						rreq->io_streams[0].sreq_max_segs);
+
+		if (limit < rsize) {
+			subreq->len = limit;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+		}
+	}
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+
+	subreq->io_iter	= rreq->iter;
+	iov_iter_truncate(&subreq->io_iter, subreq->len);
+	iov_iter_advance(&rreq->iter, subreq->len);
+}
+
+/*
+ * Perform a read to a buffer from the server, slicing up the region to be read
+ * according to the network rsize.
+ */
+static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
+{
+	unsigned long long start = rreq->start;
+	ssize_t size = rreq->len;
+	int ret = 0;
+
+	atomic_set(&rreq->nr_outstanding, 1);
+
+	do {
+		struct netfs_io_subrequest *subreq;
+		ssize_t slice;
+
+		subreq = netfs_alloc_subrequest(rreq);
+		if (!subreq) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
+		subreq->start	= start;
+		subreq->len	= size;
+
+		atomic_inc(&rreq->nr_outstanding);
+		spin_lock_bh(&rreq->lock);
+		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+		subreq->prev_donated = rreq->prev_donated;
+		rreq->prev_donated = 0;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
+		spin_unlock_bh(&rreq->lock);
+
+		netfs_stat(&netfs_n_rh_download);
+		if (rreq->netfs_ops->prepare_read) {
+			ret = rreq->netfs_ops->prepare_read(subreq);
+			if (ret < 0) {
+				atomic_dec(&rreq->nr_outstanding);
+				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+				break;
+			}
+		}
+
+		netfs_prepare_dio_read_iterator(subreq);
+		slice = subreq->len;
+		rreq->netfs_ops->issue_read(subreq);
+
+		size -= slice;
+		start += slice;
+		rreq->submitted += slice;
+
+		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
+		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
+			break;
+		cond_resched();
+	} while (size > 0);
+
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		netfs_rreq_terminated(rreq, false);
+	return ret;
+}
+
+/*
+ * Perform a read to an application buffer, bypassing the pagecache and the
+ * local disk cache.
+ */
+static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
+{
+	int ret;
+
+	_enter("R=%x %llx-%llx",
+	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
+
+	if (rreq->len == 0) {
+		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
+		return -EIO;
+	}
+
+	// TODO: Use bounce buffer if requested
+
+	inode_dio_begin(rreq->inode);
+
+	ret = netfs_dispatch_unbuffered_reads(rreq);
+
+	if (!rreq->submitted) {
+		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
+		inode_dio_end(rreq->inode);
+		ret = 0;
+		goto out;
+	}
+
+	if (sync) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
+		wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
+
+		ret = rreq->error;
+		if (ret == 0 && rreq->submitted < rreq->len &&
+		    rreq->origin != NETFS_DIO_READ) {
+			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
+			ret = -EIO;
+		}
+	} else {
+		ret = -EIOCBQUEUED;
+	}
+
+out:
+	_leave(" = %d", ret);
+	return ret;
+}
+
 /**
  * netfs_unbuffered_read_iter_locked - Perform an unbuffered or direct I/O read
  * @iocb: The I/O control descriptor describing the read
@@ -31,7 +168,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	struct netfs_io_request *rreq;
 	ssize_t ret;
 	size_t orig_count = iov_iter_count(iter);
-	bool async = !is_sync_kiocb(iocb);
+	bool sync = is_sync_kiocb(iocb);
 
 	_enter("");
 
@@ -78,13 +215,13 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 
 	// TODO: Set up bounce buffer if needed
 
-	if (async)
+	if (!sync)
 		rreq->iocb = iocb;
 
-	ret = netfs_begin_read(rreq, is_sync_kiocb(iocb));
+	ret = netfs_unbuffered_read(rreq, sync);
 	if (ret < 0)
 		goto out; /* May be -EIOCBQUEUED */
-	if (!async) {
+	if (sync) {
 		// TODO: Copy from bounce buffer
 		iocb->ki_pos += rreq->transferred;
 		ret = rreq->transferred;
@@ -94,8 +231,6 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	if (ret > 0)
 		orig_count -= ret;
-	if (ret != -EIOCBQUEUED)
-		iov_iter_revert(iter, orig_count - iov_iter_count(iter));
 	return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_read_iter_locked);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 21a3c7d13585..c9f0ed24cb7b 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -23,16 +23,9 @@
 /*
  * buffered_read.c
  */
-void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
 
-/*
- * io.c
- */
-void netfs_rreq_work(struct work_struct *work);
-int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
-
 /*
  * main.c
  */
@@ -90,6 +83,28 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
 	trace_netfs_rreq_ref(rreq->debug_id, refcount_read(&rreq->ref), what);
 }
 
+/*
+ * read_collect.c
+ */
+void netfs_read_termination_worker(struct work_struct *work);
+void netfs_rreq_terminated(struct netfs_io_request *rreq, bool was_async);
+
+/*
+ * read_pgpriv2.c
+ */
+void netfs_pgpriv2_mark_copy_to_cache(struct netfs_io_subrequest *subreq,
+				      struct netfs_io_request *rreq,
+				      struct folio_queue *folioq,
+				      int slot);
+void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq);
+bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq);
+
+/*
+ * read_retry.c
+ */
+void netfs_retry_reads(struct netfs_io_request *rreq);
+void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq);
+
 /*
  * stats.c
  */
@@ -117,6 +132,7 @@ extern atomic_t netfs_n_wh_buffered_write;
 extern atomic_t netfs_n_wh_writethrough;
 extern atomic_t netfs_n_wh_dio_write;
 extern atomic_t netfs_n_wh_writepages;
+extern atomic_t netfs_n_wh_copy_to_cache;
 extern atomic_t netfs_n_wh_wstream_conflict;
 extern atomic_t netfs_n_wh_upload;
 extern atomic_t netfs_n_wh_upload_done;
@@ -162,6 +178,11 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 void netfs_reissue_write(struct netfs_io_stream *stream,
 			 struct netfs_io_subrequest *subreq,
 			 struct iov_iter *source);
+void netfs_issue_write(struct netfs_io_request *wreq,
+		       struct netfs_io_stream *stream);
+int netfs_advance_write(struct netfs_io_request *wreq,
+			struct netfs_io_stream *stream,
+			loff_t start, size_t len, bool to_eof);
 struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
 int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *folio, size_t copied, bool to_page_end,
diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index b781bbbf1d8d..72a435e5fc6d 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -188,9 +188,59 @@ static size_t netfs_limit_xarray(const struct iov_iter *iter, size_t start_offse
 	return min(span, max_size);
 }
 
+/*
+ * Select the span of a folio queue iterator we're going to use.  Limit it by
+ * both maximum size and maximum number of segments.  Returns the size of the
+ * span in bytes.
+ */
+static size_t netfs_limit_folioq(const struct iov_iter *iter, size_t start_offset,
+				 size_t max_size, size_t max_segs)
+{
+	const struct folio_queue *folioq = iter->folioq;
+	unsigned int nsegs = 0;
+	unsigned int slot = iter->folioq_slot;
+	size_t span = 0, n = iter->count;
+
+	if (WARN_ON(!iov_iter_is_folioq(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n == 0)
+		return 0;
+	max_size = umin(max_size, n - start_offset);
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = folioq->next;
+		slot = 0;
+	}
+
+	start_offset += iter->iov_offset;
+	do {
+		size_t flen = folioq_folio_size(folioq, slot);
+
+		if (start_offset < flen) {
+			span += flen - start_offset;
+			nsegs++;
+			start_offset = 0;
+		} else {
+			start_offset -= flen;
+		}
+		if (span >= max_size || nsegs >= max_segs)
+			break;
+
+		slot++;
+		if (slot >= folioq_nr_slots(folioq)) {
+			folioq = folioq->next;
+			slot = 0;
+		}
+	} while (folioq);
+
+	return umin(span, max_size);
+}
+
 size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 			size_t max_size, size_t max_segs)
 {
+	if (iov_iter_is_folioq(iter))
+		return netfs_limit_folioq(iter, start_offset, max_size, max_segs);
 	if (iov_iter_is_bvec(iter))
 		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
 	if (iov_iter_is_xarray(iter))
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 1ee712bb3610..4f7212ca3470 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -36,12 +36,14 @@ DEFINE_SPINLOCK(netfs_proc_lock);
 static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READAHEAD]		= "RA",
 	[NETFS_READPAGE]		= "RP",
+	[NETFS_READ_GAPS]		= "RG",
 	[NETFS_READ_FOR_WRITE]		= "RW",
 	[NETFS_DIO_READ]		= "DR",
 	[NETFS_WRITEBACK]		= "WB",
 	[NETFS_WRITETHROUGH]		= "WT",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
 	[NETFS_DIO_WRITE]		= "DW",
+	[NETFS_PGPRIV2_COPY_TO_CACHE]	= "2C",
 };
 
 /*
@@ -61,7 +63,7 @@ static int netfs_requests_seq_show(struct seq_file *m, void *v)
 
 	rreq = list_entry(v, struct netfs_io_request, proc_link);
 	seq_printf(m,
-		   "%08x %s %3d %2lx %4d %3d @%04llx %llx/%llx",
+		   "%08x %s %3d %2lx %4ld %3d @%04llx %llx/%llx",
 		   rreq->debug_id,
 		   netfs_origins[rreq->origin],
 		   refcount_read(&rreq->ref),
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 4291cd405fc1..31e388ec6e48 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -36,7 +36,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	memset(rreq, 0, kmem_cache_size(cache));
 	rreq->start	= start;
 	rreq->len	= len;
-	rreq->upper_len	= len;
 	rreq->origin	= origin;
 	rreq->netfs_ops	= ctx->ops;
 	rreq->mapping	= mapping;
@@ -44,6 +43,8 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->i_size	= i_size_read(inode);
 	rreq->debug_id	= atomic_inc_return(&debug_ids);
 	rreq->wsize	= INT_MAX;
+	rreq->io_streams[0].sreq_max_len = ULONG_MAX;
+	rreq->io_streams[0].sreq_max_segs = 0;
 	spin_lock_init(&rreq->lock);
 	INIT_LIST_HEAD(&rreq->io_streams[0].subrequests);
 	INIT_LIST_HEAD(&rreq->io_streams[1].subrequests);
@@ -52,9 +53,10 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 
 	if (origin == NETFS_READAHEAD ||
 	    origin == NETFS_READPAGE ||
+	    origin == NETFS_READ_GAPS ||
 	    origin == NETFS_READ_FOR_WRITE ||
 	    origin == NETFS_DIO_READ)
-		INIT_WORK(&rreq->work, netfs_rreq_work);
+		INIT_WORK(&rreq->work, netfs_read_termination_worker);
 	else
 		INIT_WORK(&rreq->work, netfs_write_collection_worker);
 
@@ -163,7 +165,7 @@ void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
 			if (was_async) {
 				rreq->work.func = netfs_free_request;
 				if (!queue_work(system_unbound_wq, &rreq->work))
-					BUG();
+					WARN_ON(1);
 			} else {
 				netfs_free_request(&rreq->work);
 			}
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
new file mode 100644
index 000000000000..b18c65ba5580
--- /dev/null
+++ b/fs/netfs/read_collect.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem read subrequest result collection, assessment and
+ * retrying.
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/task_io_accounting_ops.h>
+#include "internal.h"
+
+/*
+ * Clear the unread part of an I/O request.
+ */
+static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
+{
+	netfs_reset_iter(subreq);
+	WARN_ON_ONCE(subreq->len - subreq->transferred != iov_iter_count(&subreq->io_iter));
+	iov_iter_zero(iov_iter_count(&subreq->io_iter), &subreq->io_iter);
+	if (subreq->start + subreq->transferred >= subreq->rreq->i_size)
+		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
+}
+
+/*
+ * Flush, mark and unlock a folio that's now completely read.  If we want to
+ * cache the folio, we set the group to NETFS_FOLIO_COPY_TO_CACHE, mark it
+ * dirty and let writeback handle it.
+ */
+static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
+				    struct netfs_io_request *rreq,
+				    struct folio_queue *folioq,
+				    int slot)
+{
+	struct netfs_folio *finfo;
+	struct folio *folio = folioq_folio(folioq, slot);
+
+	flush_dcache_folio(folio);
+	folio_mark_uptodate(folio);
+
+	if (!test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)) {
+		finfo = netfs_folio_info(folio);
+		if (finfo) {
+			trace_netfs_folio(folio, netfs_folio_trace_filled_gaps);
+			if (finfo->netfs_group)
+				folio_change_private(folio, finfo->netfs_group);
+			else
+				folio_detach_private(folio);
+			kfree(finfo);
+		}
+
+		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
+			if (!WARN_ON_ONCE(folio_get_private(folio) != NULL)) {
+				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
+				folio_attach_private(folio, NETFS_FOLIO_COPY_TO_CACHE);
+				folio_mark_dirty(folio);
+			}
+		} else {
+			trace_netfs_folio(folio, netfs_folio_trace_read_done);
+		}
+	} else {
+		// TODO: Use of PG_private_2 is deprecated.
+		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
+			netfs_pgpriv2_mark_copy_to_cache(subreq, rreq, folioq, slot);
+	}
+
+	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
+		if (folio->index == rreq->no_unlock_folio &&
+		    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
+			_debug("no unlock");
+		} else {
+			trace_netfs_folio(folio, netfs_folio_trace_read_unlock);
+			folio_unlock(folio);
+		}
+	}
+}
+
+/*
+ * Unlock any folios that are now completely read.  Returns true if the
+ * subrequest is removed from the list.
+ */
+static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was_async)
+{
+	struct netfs_io_subrequest *prev, *next;
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct folio_queue *folioq = subreq->curr_folioq;
+	size_t avail, prev_donated, next_donated, fsize, part, excess;
+	loff_t fpos, start;
+	loff_t fend;
+	int slot = subreq->curr_folioq_slot;
+
+	if (WARN(subreq->transferred > subreq->len,
+		 "Subreq overread: R%x[%x] %zu > %zu",
+		 rreq->debug_id, subreq->debug_index,
+		 subreq->transferred, subreq->len))
+		subreq->transferred = subreq->len;
+
+next_folio:
+	fsize = PAGE_SIZE << subreq->curr_folio_order;
+	fpos = round_down(subreq->start + subreq->consumed, fsize);
+	fend = fpos + fsize;
+
+	if (WARN_ON_ONCE(!folioq) ||
+	    WARN_ON_ONCE(!folioq_folio(folioq, slot)) ||
+	    WARN_ON_ONCE(folioq_folio(folioq, slot)->index != fpos / PAGE_SIZE)) {
+		pr_err("R=%08x[%x] s=%llx-%llx ctl=%zx/%zx/%zx sl=%u\n",
+		       rreq->debug_id, subreq->debug_index,
+		       subreq->start, subreq->start + subreq->transferred - 1,
+		       subreq->consumed, subreq->transferred, subreq->len,
+		       slot);
+		if (folioq) {
+			struct folio *folio = folioq_folio(folioq, slot);
+
+			pr_err("folioq: orders=%02x%02x%02x%02x\n",
+			       folioq->orders[0], folioq->orders[1],
+			       folioq->orders[2], folioq->orders[3]);
+			if (folio)
+				pr_err("folio: %llx-%llx ix=%llx o=%u qo=%u\n",
+				       fpos, fend - 1, folio_pos(folio), folio_order(folio),
+				       folioq_folio_order(folioq, slot));
+		}
+	}
+
+donation_changed:
+	/* Try to consume the current folio if we've hit or passed the end of
+	 * it.  There's a possibility that this subreq doesn't start at the
+	 * beginning of the folio, in which case we need to donate to/from the
+	 * preceding subreq.
+	 *
+	 * We also need to include any potential donation back from the
+	 * following subreq.
+	 */
+	prev_donated = READ_ONCE(subreq->prev_donated);
+	next_donated =  READ_ONCE(subreq->next_donated);
+	if (prev_donated || next_donated) {
+		spin_lock_bh(&rreq->lock);
+		prev_donated = subreq->prev_donated;
+		next_donated =  subreq->next_donated;
+		subreq->start -= prev_donated;
+		subreq->len += prev_donated;
+		subreq->transferred += prev_donated;
+		prev_donated = subreq->prev_donated = 0;
+		if (subreq->transferred == subreq->len) {
+			subreq->len += next_donated;
+			subreq->transferred += next_donated;
+			next_donated = subreq->next_donated = 0;
+		}
+		trace_netfs_sreq(subreq, netfs_sreq_trace_add_donations);
+		spin_unlock_bh(&rreq->lock);
+	}
+
+	avail = subreq->transferred;
+	if (avail == subreq->len)
+		avail += next_donated;
+	start = subreq->start;
+	if (subreq->consumed == 0) {
+		start -= prev_donated;
+		avail += prev_donated;
+	} else {
+		start += subreq->consumed;
+		avail -= subreq->consumed;
+	}
+	part = umin(avail, fsize);
+
+	trace_netfs_progress(subreq, start, avail, part);
+
+	if (start + avail >= fend) {
+		if (fpos == start) {
+			/* Flush, unlock and mark for caching any folio we've just read. */
+			subreq->consumed = fend - subreq->start;
+			netfs_unlock_read_folio(subreq, rreq, folioq, slot);
+			folioq_mark2(folioq, slot);
+			if (subreq->consumed >= subreq->len)
+				goto remove_subreq;
+		} else if (fpos < start) {
+			excess = fend - subreq->start;
+
+			spin_lock_bh(&rreq->lock);
+			/* If we complete first on a folio split with the
+			 * preceding subreq, donate to that subreq - otherwise
+			 * we get the responsibility.
+			 */
+			if (subreq->prev_donated != prev_donated) {
+				spin_unlock_bh(&rreq->lock);
+				goto donation_changed;
+			}
+
+			if (list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
+				spin_unlock_bh(&rreq->lock);
+				pr_err("Can't donate prior to front\n");
+				goto bad;
+			}
+
+			prev = list_prev_entry(subreq, rreq_link);
+			WRITE_ONCE(prev->next_donated, prev->next_donated + excess);
+			subreq->start += excess;
+			subreq->len -= excess;
+			subreq->transferred -= excess;
+			trace_netfs_donate(rreq, subreq, prev, excess,
+					   netfs_trace_donate_tail_to_prev);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
+
+			if (subreq->consumed >= subreq->len)
+				goto remove_subreq_locked;
+			spin_unlock_bh(&rreq->lock);
+		} else {
+			pr_err("fpos > start\n");
+			goto bad;
+		}
+
+		/* Advance the rolling buffer to the next folio. */
+		slot++;
+		if (slot >= folioq_nr_slots(folioq)) {
+			slot = 0;
+			folioq = folioq->next;
+			subreq->curr_folioq = folioq;
+		}
+		subreq->curr_folioq_slot = slot;
+		if (folioq && folioq_folio(folioq, slot))
+			subreq->curr_folio_order = folioq->orders[slot];
+		if (!was_async)
+			cond_resched();
+		goto next_folio;
+	}
+
+	/* Deal with partial progress. */
+	if (subreq->transferred < subreq->len)
+		return false;
+
+	/* Donate the remaining downloaded data to one of the neighbouring
+	 * subrequests.  Note that we may race with them doing the same thing.
+	 */
+	spin_lock_bh(&rreq->lock);
+
+	if (subreq->prev_donated != prev_donated ||
+	    subreq->next_donated != next_donated) {
+		spin_unlock_bh(&rreq->lock);
+		cond_resched();
+		goto donation_changed;
+	}
+
+	/* Deal with the trickiest case: that this subreq is in the middle of a
+	 * folio, not touching either edge, but finishes first.  In such a
+	 * case, we donate to the previous subreq, if there is one, so that the
+	 * donation is only handled when that completes - and remove this
+	 * subreq from the list.
+	 *
+	 * If the previous subreq finished first, we will have acquired their
+	 * donation and should be able to unlock folios and/or donate nextwards.
+	 */
+	if (!subreq->consumed &&
+	    !prev_donated &&
+	    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
+		prev = list_prev_entry(subreq, rreq_link);
+		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
+		subreq->start += subreq->len;
+		subreq->len = 0;
+		subreq->transferred = 0;
+		trace_netfs_donate(rreq, subreq, prev, subreq->len,
+				   netfs_trace_donate_to_prev);
+		trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
+		goto remove_subreq_locked;
+	}
+
+	/* If we can't donate down the chain, donate up the chain instead. */
+	excess = subreq->len - subreq->consumed + next_donated;
+
+	if (!subreq->consumed)
+		excess += prev_donated;
+
+	if (list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+		rreq->prev_donated = excess;
+		trace_netfs_donate(rreq, subreq, NULL, excess,
+				   netfs_trace_donate_to_deferred_next);
+	} else {
+		next = list_next_entry(subreq, rreq_link);
+		WRITE_ONCE(next->prev_donated, excess);
+		trace_netfs_donate(rreq, subreq, next, excess,
+				   netfs_trace_donate_to_next);
+	}
+	trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_next);
+	subreq->len = subreq->consumed;
+	subreq->transferred = subreq->consumed;
+	goto remove_subreq_locked;
+
+remove_subreq:
+	spin_lock_bh(&rreq->lock);
+remove_subreq_locked:
+	subreq->consumed = subreq->len;
+	list_del(&subreq->rreq_link);
+	spin_unlock_bh(&rreq->lock);
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_consumed);
+	return true;
+
+bad:
+	/* Errr... prev and next both donated to us, but insufficient to finish
+	 * the folio.
+	 */
+	printk("R=%08x[%x] s=%llx-%llx %zx/%zx/%zx\n",
+	       rreq->debug_id, subreq->debug_index,
+	       subreq->start, subreq->start + subreq->transferred - 1,
+	       subreq->consumed, subreq->transferred, subreq->len);
+	printk("folio: %llx-%llx\n", fpos, fend - 1);
+	printk("donated: prev=%zx next=%zx\n", prev_donated, next_donated);
+	printk("s=%llx av=%zx part=%zx\n", start, avail, part);
+	BUG();
+}
+
+/*
+ * Do page flushing and suchlike after DIO.
+ */
+static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	unsigned int i;
+
+	/* Collect unbuffered reads and direct reads, adding up the transfer
+	 * sizes until we find the first short or failed subrequest.
+	 */
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		rreq->transferred += subreq->transferred;
+
+		if (subreq->transferred < subreq->len ||
+		    test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
+			rreq->error = subreq->error;
+			break;
+		}
+	}
+
+	if (rreq->origin == NETFS_DIO_READ) {
+		for (i = 0; i < rreq->direct_bv_count; i++) {
+			flush_dcache_page(rreq->direct_bv[i].bv_page);
+			// TODO: cifs marks pages in the destination buffer
+			// dirty under some circumstances after a read.  Do we
+			// need to do that too?
+			set_page_dirty(rreq->direct_bv[i].bv_page);
+		}
+	}
+
+	if (rreq->iocb) {
+		rreq->iocb->ki_pos += rreq->transferred;
+		if (rreq->iocb->ki_complete)
+			rreq->iocb->ki_complete(
+				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+	}
+	if (rreq->netfs_ops->done)
+		rreq->netfs_ops->done(rreq);
+	if (rreq->origin == NETFS_DIO_READ)
+		inode_dio_end(rreq->inode);
+}
+
+/*
+ * Assess the state of a read request and decide what to do next.
+ *
+ * Note that we're in normal kernel thread context at this point, possibly
+ * running on a workqueue.
+ */
+static void netfs_rreq_assess(struct netfs_io_request *rreq)
+{
+	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
+
+	//netfs_rreq_is_still_valid(rreq);
+
+	if (test_and_clear_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags)) {
+		netfs_retry_reads(rreq);
+		return;
+	}
+
+	if (rreq->origin == NETFS_DIO_READ ||
+	    rreq->origin == NETFS_READ_GAPS)
+		netfs_rreq_assess_dio(rreq);
+	task_io_account_read(rreq->transferred);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
+	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
+	netfs_clear_subrequests(rreq, false);
+	netfs_unlock_abandoned_read_pages(rreq);
+	if (unlikely(test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)))
+		netfs_pgpriv2_write_to_the_cache(rreq);
+}
+
+void netfs_read_termination_worker(struct work_struct *work)
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
+	netfs_see_request(rreq, netfs_rreq_trace_see_work);
+	netfs_rreq_assess(rreq);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_work_complete);
+}
+
+/*
+ * Handle the completion of all outstanding I/O operations on a read request.
+ * We inherit a ref from the caller.
+ */
+void netfs_rreq_terminated(struct netfs_io_request *rreq, bool was_async)
+{
+	if (!was_async)
+		return netfs_rreq_assess(rreq);
+	if (!work_pending(&rreq->work)) {
+		netfs_get_request(rreq, netfs_rreq_trace_get_work);
+		if (!queue_work(system_unbound_wq, &rreq->work))
+			netfs_put_request(rreq, was_async, netfs_rreq_trace_put_work_nq);
+	}
+}
+
+/**
+ * netfs_read_subreq_progress - Note progress of a read operation.
+ * @subreq: The read request that has terminated.
+ * @was_async: True if we're in an asynchronous context.
+ *
+ * This tells the read side of netfs lib that a contributory I/O operation has
+ * made some progress and that it may be possible to unlock some folios.
+ *
+ * Before calling, the filesystem should update subreq->transferred to track
+ * the amount of data copied into the output buffer.
+ *
+ * If @was_async is true, the caller might be running in softirq or interrupt
+ * context and we can't sleep.
+ */
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
+				bool was_async)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_progress);
+
+	if (subreq->transferred > subreq->consumed &&
+	    (rreq->origin == NETFS_READAHEAD ||
+	     rreq->origin == NETFS_READPAGE ||
+	     rreq->origin == NETFS_READ_FOR_WRITE)) {
+		netfs_consume_read_data(subreq, was_async);
+		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+	}
+}
+EXPORT_SYMBOL(netfs_read_subreq_progress);
+
+/**
+ * netfs_read_subreq_terminated - Note the termination of an I/O operation.
+ * @subreq: The I/O request that has terminated.
+ * @error: Error code indicating type of completion.
+ * @was_async: The termination was asynchronous
+ *
+ * This tells the read helper that a contributory I/O operation has terminated,
+ * one way or another, and that it should integrate the results.
+ *
+ * The caller indicates the outcome of the operation through @error, supplying
+ * 0 to indicate a successful or retryable transfer (if NETFS_SREQ_NEED_RETRY
+ * is set) or a negative error code.  The helper will look after reissuing I/O
+ * operations as appropriate and writing downloaded data to the cache.
+ *
+ * Before calling, the filesystem should update subreq->transferred to track
+ * the amount of data copied into the output buffer.
+ *
+ * If @was_async is true, the caller might be running in softirq or interrupt
+ * context and we can't sleep.
+ */
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
+				  int error, bool was_async)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	switch (subreq->source) {
+	case NETFS_READ_FROM_CACHE:
+		netfs_stat(&netfs_n_rh_read_done);
+		break;
+	case NETFS_DOWNLOAD_FROM_SERVER:
+		netfs_stat(&netfs_n_rh_download_done);
+		break;
+	default:
+		break;
+	}
+
+	if (rreq->origin != NETFS_DIO_READ) {
+		/* Collect buffered reads.
+		 *
+		 * If the read completed validly short, then we can clear the
+		 * tail before going on to unlock the folios.
+		 */
+		if (error == 0 && subreq->transferred < subreq->len &&
+		    (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags) ||
+		     test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags))) {
+			netfs_clear_unread(subreq);
+			subreq->transferred = subreq->len;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_clear);
+		}
+		if (subreq->transferred > subreq->consumed &&
+		    (rreq->origin == NETFS_READAHEAD ||
+		     rreq->origin == NETFS_READPAGE ||
+		     rreq->origin == NETFS_READ_FOR_WRITE)) {
+			netfs_consume_read_data(subreq, was_async);
+			__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+		}
+		rreq->transferred += subreq->transferred;
+	}
+
+	/* Deal with retry requests, short reads and errors.  If we retry
+	 * but don't make progress, we abandon the attempt.
+	 */
+	if (!error && subreq->transferred < subreq->len) {
+		if (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags)) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_hit_eof);
+		} else {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
+			if (subreq->transferred > subreq->consumed) {
+				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
+				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+			} else {
+				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+				error = -ENODATA;
+			}
+		}
+	}
+
+	subreq->error = error;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
+
+	if (unlikely(error < 0)) {
+		trace_netfs_failure(rreq, subreq, error, netfs_fail_read);
+		if (subreq->source == NETFS_READ_FROM_CACHE) {
+			netfs_stat(&netfs_n_rh_read_failed);
+		} else {
+			netfs_stat(&netfs_n_rh_download_failed);
+			set_bit(NETFS_RREQ_FAILED, &rreq->flags);
+			rreq->error = subreq->error;
+		}
+	}
+
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		netfs_rreq_terminated(rreq, was_async);
+
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+}
+EXPORT_SYMBOL(netfs_read_subreq_terminated);
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
new file mode 100644
index 000000000000..9439461d535f
--- /dev/null
+++ b/fs/netfs/read_pgpriv2.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Read with PG_private_2 [DEPRECATED].
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/task_io_accounting_ops.h>
+#include "internal.h"
+
+/*
+ * [DEPRECATED] Mark page as requiring copy-to-cache using PG_private_2.  The
+ * third mark in the folio queue is used to indicate that this folio needs
+ * writing.
+ */
+void netfs_pgpriv2_mark_copy_to_cache(struct netfs_io_subrequest *subreq,
+				      struct netfs_io_request *rreq,
+				      struct folio_queue *folioq,
+				      int slot)
+{
+	struct folio *folio = folioq_folio(folioq, slot);
+
+	trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
+	folio_start_private_2(folio);
+	folioq_mark3(folioq, slot);
+}
+
+/*
+ * [DEPRECATED] Cancel PG_private_2 on all marked folios in the event of an
+ * unrecoverable error.
+ */
+static void netfs_pgpriv2_cancel(struct folio_queue *folioq)
+{
+	struct folio *folio;
+	int slot;
+
+	while (folioq) {
+		if (!folioq->marks3) {
+			folioq = folioq->next;
+			continue;
+		}
+
+		slot = __ffs(folioq->marks3);
+		folio = folioq_folio(folioq, slot);
+
+		trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
+		folio_end_private_2(folio);
+		folioq_unmark3(folioq, slot);
+	}
+}
+
+/*
+ * [DEPRECATED] Copy a folio to the cache with PG_private_2 set.
+ */
+static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio *folio)
+{
+	struct netfs_io_stream *cache  = &wreq->io_streams[1];
+	size_t fsize = folio_size(folio), flen = fsize;
+	loff_t fpos = folio_pos(folio), i_size;
+	bool to_eof = false;
+
+	_enter("");
+
+	/* netfs_perform_write() may shift i_size around the page or from out
+	 * of the page to beyond it, but cannot move i_size into or through the
+	 * page since we have it locked.
+	 */
+	i_size = i_size_read(wreq->inode);
+
+	if (fpos >= i_size) {
+		/* mmap beyond eof. */
+		_debug("beyond eof");
+		folio_end_private_2(folio);
+		return 0;
+	}
+
+	if (fpos + fsize > wreq->i_size)
+		wreq->i_size = i_size;
+
+	if (flen > i_size - fpos) {
+		flen = i_size - fpos;
+		to_eof = true;
+	} else if (flen == i_size - fpos) {
+		to_eof = true;
+	}
+
+	_debug("folio %zx %zx", flen, fsize);
+
+	trace_netfs_folio(folio, netfs_folio_trace_store_copy);
+
+	/* Attach the folio to the rolling buffer. */
+	if (netfs_buffer_append_folio(wreq, folio, false) < 0)
+		return -ENOMEM;
+
+	cache->submit_max_len = fsize;
+	cache->submit_off = 0;
+	cache->submit_len = flen;
+
+	/* Attach the folio to one or more subrequests.  For a big folio, we
+	 * could end up with thousands of subrequests if the wsize is small -
+	 * but we might need to wait during the creation of subrequests for
+	 * network resources (eg. SMB credits).
+	 */
+	do {
+		ssize_t part;
+
+		wreq->io_iter.iov_offset = cache->submit_off;
+
+		atomic64_set(&wreq->issued_to, fpos + cache->submit_off);
+		part = netfs_advance_write(wreq, cache, fpos + cache->submit_off,
+					   cache->submit_len, to_eof);
+		cache->submit_off += part;
+		cache->submit_max_len -= part;
+		if (part > cache->submit_len)
+			cache->submit_len = 0;
+		else
+			cache->submit_len -= part;
+	} while (cache->submit_len > 0);
+
+	wreq->io_iter.iov_offset = 0;
+	iov_iter_advance(&wreq->io_iter, fsize);
+	atomic64_set(&wreq->issued_to, fpos + fsize);
+
+	if (flen < fsize)
+		netfs_issue_write(wreq, cache);
+
+	_leave(" = 0");
+	return 0;
+}
+
+/*
+ * [DEPRECATED] Go through the buffer and write any folios that are marked with
+ * the third mark to the cache.
+ */
+void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
+{
+	struct netfs_io_request *wreq;
+	struct folio_queue *folioq;
+	struct folio *folio;
+	int error = 0;
+	int slot = 0;
+
+	_enter("");
+
+	if (!fscache_resources_valid(&rreq->cache_resources))
+		goto couldnt_start;
+
+	/* Need the first folio to be able to set up the op. */
+	for (folioq = rreq->buffer; folioq; folioq = folioq->next) {
+		if (folioq->marks3) {
+			slot = __ffs(folioq->marks3);
+			break;
+		}
+	}
+	if (!folioq)
+		return;
+	folio = folioq_folio(folioq, slot);
+
+	wreq = netfs_create_write_req(rreq->mapping, NULL, folio_pos(folio),
+				      NETFS_PGPRIV2_COPY_TO_CACHE);
+	if (IS_ERR(wreq)) {
+		kleave(" [create %ld]", PTR_ERR(wreq));
+		goto couldnt_start;
+	}
+
+	trace_netfs_write(wreq, netfs_write_trace_copy_to_cache);
+	netfs_stat(&netfs_n_wh_copy_to_cache);
+
+	for (;;) {
+		error = netfs_pgpriv2_copy_folio(wreq, folio);
+		if (error < 0)
+			break;
+
+		folioq_unmark3(folioq, slot);
+		if (!folioq->marks3) {
+			folioq = folioq->next;
+			if (!folioq)
+				break;
+		}
+
+		slot = __ffs(folioq->marks3);
+		folio = folioq_folio(folioq, slot);
+	}
+
+	netfs_issue_write(wreq, &wreq->io_streams[1]);
+	smp_wmb(); /* Write lists before ALL_QUEUED. */
+	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+
+	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+	_leave(" = %d", error);
+couldnt_start:
+	netfs_pgpriv2_cancel(rreq->buffer);
+}
+
+/*
+ * [DEPRECATED] Remove the PG_private_2 mark from any folios we've finished
+ * copying.
+ */
+bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
+{
+	struct folio_queue *folioq = wreq->buffer;
+	unsigned long long collected_to = wreq->collected_to;
+	unsigned int slot = wreq->buffer_head_slot;
+	bool made_progress = false;
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = netfs_delete_buffer_head(wreq);
+		slot = 0;
+	}
+
+	for (;;) {
+		struct folio *folio;
+		unsigned long long fpos, fend;
+		size_t fsize, flen;
+
+		folio = folioq_folio(folioq, slot);
+		if (WARN_ONCE(!folio_test_private_2(folio),
+			      "R=%08x: folio %lx is not marked private_2\n",
+			      wreq->debug_id, folio->index))
+			trace_netfs_folio(folio, netfs_folio_trace_not_under_wback);
+
+		fpos = folio_pos(folio);
+		fsize = folio_size(folio);
+		flen = fsize;
+
+		fend = min_t(unsigned long long, fpos + flen, wreq->i_size);
+
+		trace_netfs_collect_folio(wreq, folio, fend, collected_to);
+
+		/* Unlock any folio we've transferred all of. */
+		if (collected_to < fend)
+			break;
+
+		trace_netfs_folio(folio, netfs_folio_trace_end_copy);
+		folio_end_private_2(folio);
+		wreq->cleaned_to = fpos + fsize;
+		made_progress = true;
+
+		/* Clean up the head folioq.  If we clear an entire folioq, then
+		 * we can get rid of it provided it's not also the tail folioq
+		 * being filled by the issuer.
+		 */
+		folioq_clear(folioq, slot);
+		slot++;
+		if (slot >= folioq_nr_slots(folioq)) {
+			if (READ_ONCE(wreq->buffer_tail) == folioq)
+				break;
+			folioq = netfs_delete_buffer_head(wreq);
+			slot = 0;
+		}
+
+		if (fpos + fsize >= collected_to)
+			break;
+	}
+
+	wreq->buffer = folioq;
+	wreq->buffer_head_slot = slot;
+	return made_progress;
+}
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
new file mode 100644
index 000000000000..0350592ea804
--- /dev/null
+++ b/fs/netfs/read_retry.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem read subrequest retrying.
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+static void netfs_reissue_read(struct netfs_io_request *rreq,
+			       struct netfs_io_subrequest *subreq)
+{
+	struct iov_iter *io_iter = &subreq->io_iter;
+
+	if (iov_iter_is_folioq(io_iter)) {
+		subreq->curr_folioq = (struct folio_queue *)io_iter->folioq;
+		subreq->curr_folioq_slot = io_iter->folioq_slot;
+		subreq->curr_folio_order = subreq->curr_folioq->orders[subreq->curr_folioq_slot];
+	}
+
+	atomic_inc(&rreq->nr_outstanding);
+	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+	subreq->rreq->netfs_ops->issue_read(subreq);
+}
+
+/*
+ * Go through the list of failed/short reads, retrying all retryable ones.  We
+ * need to switch failed cache reads to network downloads.
+ */
+static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	struct netfs_io_stream *stream0 = &rreq->io_streams[0];
+	LIST_HEAD(sublist);
+	LIST_HEAD(queue);
+
+	_enter("R=%x", rreq->debug_id);
+
+	if (list_empty(&rreq->subrequests))
+		return;
+
+	if (rreq->netfs_ops->retry_request)
+		rreq->netfs_ops->retry_request(rreq, NULL);
+
+	/* If there's no renegotiation to do, just resend each retryable subreq
+	 * up to the first permanently failed one.
+	 */
+	if (!rreq->netfs_ops->prepare_read &&
+	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
+		struct netfs_io_subrequest *subreq;
+
+		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+				break;
+			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+				netfs_reset_iter(subreq);
+				netfs_reissue_read(rreq, subreq);
+			}
+		}
+		return;
+	}
+
+	/* Okay, we need to renegotiate all the download requests and flip any
+	 * failed cache reads over to being download requests and negotiate
+	 * those also.  All fully successful subreqs have been removed from the
+	 * list and any spare data from those has been donated.
+	 *
+	 * What we do is decant the list and rebuild it one subreq at a time so
+	 * that we don't end up with donations jumping over a gap we're busy
+	 * populating with smaller subrequests.  In the event that the subreq
+	 * we just launched finishes before we insert the next subreq, it'll
+	 * fill in rreq->prev_donated instead.
+
+	 * Note: Alternatively, we could split the tail subrequest right before
+	 * we reissue it and fix up the donations under lock.
+	 */
+	list_splice_init(&rreq->subrequests, &queue);
+
+	do {
+		struct netfs_io_subrequest *from;
+		struct iov_iter source;
+		unsigned long long start, len;
+		size_t part, deferred_next_donated = 0;
+		bool boundary = false;
+
+		/* Go through the subreqs and find the next span of contiguous
+		 * buffer that we then rejig (cifs, for example, needs the
+		 * rsize renegotiating) and reissue.
+		 */
+		from = list_first_entry(&queue, struct netfs_io_subrequest, rreq_link);
+		list_move_tail(&from->rreq_link, &sublist);
+		start = from->start + from->transferred;
+		len   = from->len   - from->transferred;
+
+		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx/%zx",
+		       rreq->debug_id, from->debug_index,
+		       from->start, from->consumed, from->transferred, from->len);
+
+		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
+		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
+			goto abandon;
+
+		deferred_next_donated = from->next_donated;
+		while ((subreq = list_first_entry_or_null(
+				&queue, struct netfs_io_subrequest, rreq_link))) {
+			if (subreq->start != start + len ||
+			    subreq->transferred > 0 ||
+			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
+				break;
+			list_move_tail(&subreq->rreq_link, &sublist);
+			len += subreq->len;
+			deferred_next_donated = subreq->next_donated;
+			if (test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags))
+				break;
+		}
+
+		_debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
+
+		/* Determine the set of buffers we're going to use.  Each
+		 * subreq gets a subset of a single overall contiguous buffer.
+		 */
+		netfs_reset_iter(from);
+		source = from->io_iter;
+		source.count = len;
+
+		/* Work through the sublist. */
+		while ((subreq = list_first_entry_or_null(
+				&sublist, struct netfs_io_subrequest, rreq_link))) {
+			list_del(&subreq->rreq_link);
+
+			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
+			subreq->start	= start - subreq->transferred;
+			subreq->len	= len   + subreq->transferred;
+			stream0->sreq_max_len = subreq->len;
+
+			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+
+			spin_lock_bh(&rreq->lock);
+			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+			subreq->prev_donated += rreq->prev_donated;
+			rreq->prev_donated = 0;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+			spin_unlock_bh(&rreq->lock);
+
+			BUG_ON(!len);
+
+			/* Renegotiate max_len (rsize) */
+			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
+				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
+				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+			}
+
+			part = umin(len, stream0->sreq_max_len);
+			if (unlikely(rreq->io_streams[0].sreq_max_segs))
+				part = netfs_limit_iter(&source, 0, part, stream0->sreq_max_segs);
+			subreq->len = subreq->transferred + part;
+			subreq->io_iter = source;
+			iov_iter_truncate(&subreq->io_iter, part);
+			iov_iter_advance(&source, part);
+			len -= part;
+			start += part;
+			if (!len) {
+				if (boundary)
+					__set_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
+				subreq->next_donated = deferred_next_donated;
+			} else {
+				__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
+				subreq->next_donated = 0;
+			}
+
+			netfs_reissue_read(rreq, subreq);
+			if (!len)
+				break;
+
+			/* If we ran out of subrequests, allocate another. */
+			if (list_empty(&sublist)) {
+				subreq = netfs_alloc_subrequest(rreq);
+				if (!subreq)
+					goto abandon;
+				subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
+				subreq->start = start;
+
+				/* We get two refs, but need just one. */
+				netfs_put_subrequest(subreq, false, netfs_sreq_trace_new);
+				trace_netfs_sreq(subreq, netfs_sreq_trace_split);
+				list_add_tail(&subreq->rreq_link, &sublist);
+			}
+		}
+
+		/* If we managed to use fewer subreqs, we can discard the
+		 * excess.
+		 */
+		while ((subreq = list_first_entry_or_null(
+				&sublist, struct netfs_io_subrequest, rreq_link))) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
+			list_del(&subreq->rreq_link);
+			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
+		}
+
+	} while (!list_empty(&queue));
+
+	return;
+
+	/* If we hit ENOMEM, fail all remaining subrequests */
+abandon:
+	list_splice_init(&sublist, &queue);
+	list_for_each_entry(subreq, &queue, rreq_link) {
+		if (!subreq->error)
+			subreq->error = -ENOMEM;
+		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
+		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+		__clear_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+	}
+	spin_lock_bh(&rreq->lock);
+	list_splice_tail_init(&queue, &rreq->subrequests);
+	spin_unlock_bh(&rreq->lock);
+}
+
+/*
+ * Retry reads.
+ */
+void netfs_retry_reads(struct netfs_io_request *rreq)
+{
+	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
+
+	atomic_inc(&rreq->nr_outstanding);
+
+	netfs_retry_read_subrequests(rreq);
+
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		netfs_rreq_terminated(rreq, false);
+}
+
+/*
+ * Unlock any the pages that haven't been unlocked yet due to abandoned
+ * subrequests.
+ */
+void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq)
+{
+	struct folio_queue *p;
+
+	for (p = rreq->buffer; p; p = p->next) {
+		for (int slot = 0; slot < folioq_count(p); slot++) {
+			struct folio *folio = folioq_folio(p, slot);
+
+			if (folio && !folioq_is_marked2(p, slot)) {
+				trace_netfs_folio(folio, netfs_folio_trace_abandon);
+				folio_unlock(folio);
+			}
+		}
+	}
+}
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 5065289f5555..8e63516b40f6 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -32,6 +32,7 @@ atomic_t netfs_n_wh_buffered_write;
 atomic_t netfs_n_wh_writethrough;
 atomic_t netfs_n_wh_dio_write;
 atomic_t netfs_n_wh_writepages;
+atomic_t netfs_n_wh_copy_to_cache;
 atomic_t netfs_n_wh_wstream_conflict;
 atomic_t netfs_n_wh_upload;
 atomic_t netfs_n_wh_upload_done;
@@ -51,11 +52,12 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_rh_read_folio),
 		   atomic_read(&netfs_n_rh_write_begin),
 		   atomic_read(&netfs_n_rh_write_zskip));
-	seq_printf(m, "Writes : BW=%u WT=%u DW=%u WP=%u\n",
+	seq_printf(m, "Writes : BW=%u WT=%u DW=%u WP=%u 2C=%u\n",
 		   atomic_read(&netfs_n_wh_buffered_write),
 		   atomic_read(&netfs_n_wh_writethrough),
 		   atomic_read(&netfs_n_wh_dio_write),
-		   atomic_read(&netfs_n_wh_writepages));
+		   atomic_read(&netfs_n_wh_writepages),
+		   atomic_read(&netfs_n_wh_copy_to_cache));
 	seq_printf(m, "ZeroOps: ZR=%u sh=%u sk=%u\n",
 		   atomic_read(&netfs_n_rh_zero),
 		   atomic_read(&netfs_n_rh_short_read),
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 0116b336fa07..e4ac7f68450a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -80,6 +80,12 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 	unsigned long long collected_to = wreq->collected_to;
 	unsigned int slot = wreq->buffer_head_slot;
 
+	if (wreq->origin == NETFS_PGPRIV2_COPY_TO_CACHE) {
+		if (netfs_pgpriv2_unlock_copied_folios(wreq))
+			*notes |= MADE_PROGRESS;
+		return;
+	}
+
 	if (slot >= folioq_nr_slots(folioq)) {
 		folioq = netfs_delete_buffer_head(wreq);
 		slot = 0;
@@ -376,7 +382,8 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	smp_rmb();
 	collected_to = ULLONG_MAX;
 	if (wreq->origin == NETFS_WRITEBACK ||
-	    wreq->origin == NETFS_WRITETHROUGH)
+	    wreq->origin == NETFS_WRITETHROUGH ||
+	    wreq->origin == NETFS_PGPRIV2_COPY_TO_CACHE)
 		notes = BUFFERED;
 	else
 		notes = 0;
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 25fb7e166cc0..975436d3dc3f 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -95,7 +95,8 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	struct netfs_io_request *wreq;
 	struct netfs_inode *ictx;
 	bool is_buffered = (origin == NETFS_WRITEBACK ||
-			    origin == NETFS_WRITETHROUGH);
+			    origin == NETFS_WRITETHROUGH ||
+			    origin == NETFS_PGPRIV2_COPY_TO_CACHE);
 
 	wreq = netfs_alloc_request(mapping, file, start, 0, origin);
 	if (IS_ERR(wreq))
@@ -161,10 +162,6 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 
 	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
 
-	trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
-			     refcount_read(&subreq->ref),
-			     netfs_sreq_trace_new);
-
 	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
 	stream->sreq_max_len	= UINT_MAX;
@@ -241,8 +238,8 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	netfs_do_issue_write(stream, subreq);
 }
 
-static void netfs_issue_write(struct netfs_io_request *wreq,
-			      struct netfs_io_stream *stream)
+void netfs_issue_write(struct netfs_io_request *wreq,
+		       struct netfs_io_stream *stream)
 {
 	struct netfs_io_subrequest *subreq = stream->construct;
 
@@ -259,9 +256,9 @@ static void netfs_issue_write(struct netfs_io_request *wreq,
  * we can avoid overrunning the credits obtained (cifs) and try to parallelise
  * content-crypto preparation with network writes.
  */
-static int netfs_advance_write(struct netfs_io_request *wreq,
-			       struct netfs_io_stream *stream,
-			       loff_t start, size_t len, bool to_eof)
+int netfs_advance_write(struct netfs_io_request *wreq,
+			struct netfs_io_stream *stream,
+			loff_t start, size_t len, bool to_eof)
 {
 	struct netfs_io_subrequest *subreq = stream->construct;
 	size_t part;
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 7a558dea75c4..810269ee0a50 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -267,6 +267,7 @@ static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *fi
 	rreq->debug_id = atomic_inc_return(&nfs_netfs_debug_id);
 	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
 	__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
+	rreq->io_streams[0].sreq_max_len = NFS_SB(rreq->inode->i_sb)->rsize;
 
 	return 0;
 }
@@ -288,14 +289,6 @@ static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sre
 	return netfs;
 }
 
-static bool nfs_netfs_clamp_length(struct netfs_io_subrequest *sreq)
-{
-	size_t	rsize = NFS_SB(sreq->rreq->inode->i_sb)->rsize;
-
-	sreq->len = min(sreq->len, rsize);
-	return true;
-}
-
 static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 {
 	struct nfs_netfs_io_data	*netfs;
@@ -304,17 +297,18 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 	struct nfs_open_context *ctx = sreq->rreq->netfs_priv;
 	struct page *page;
 	unsigned long idx;
+	pgoff_t start, last;
 	int err;
-	pgoff_t start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
-	pgoff_t last = ((sreq->start + sreq->len -
-			 sreq->transferred - 1) >> PAGE_SHIFT);
+
+	start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
+	last = ((sreq->start + sreq->len - sreq->transferred - 1) >> PAGE_SHIFT);
 
 	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
 	netfs = nfs_netfs_alloc(sreq);
 	if (!netfs)
-		return netfs_subreq_terminated(sreq, -ENOMEM, false);
+		return netfs_read_subreq_terminated(sreq, -ENOMEM, false);
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
@@ -380,5 +374,4 @@ const struct netfs_request_ops nfs_netfs_ops = {
 	.init_request		= nfs_netfs_init_request,
 	.free_request		= nfs_netfs_free_request,
 	.issue_read		= nfs_netfs_issue_read,
-	.clamp_length		= nfs_netfs_clamp_length
 };
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index e8adae1bc260..772d485e96d3 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -60,8 +60,6 @@ static inline void nfs_netfs_get(struct nfs_netfs_io_data *netfs)
 
 static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
 {
-	ssize_t final_len;
-
 	/* Only the last RPC completion should call netfs_subreq_terminated() */
 	if (!refcount_dec_and_test(&netfs->refcount))
 		return;
@@ -74,8 +72,9 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
 	 * Correct the final length here to be no larger than the netfs subrequest
 	 * length, and thus avoid netfs's "Subreq overread" warning message.
 	 */
-	final_len = min_t(s64, netfs->sreq->len, atomic64_read(&netfs->transferred));
-	netfs_subreq_terminated(netfs->sreq, netfs->error ?: final_len, false);
+	netfs->sreq->transferred = min_t(s64, netfs->sreq->len,
+					 atomic64_read(&netfs->transferred));
+	netfs_read_subreq_terminated(netfs->sreq, netfs->error, false);
 	kfree(netfs);
 }
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 595c4b673707..d5e1bbefd5e8 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1309,10 +1309,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	if (rdata->result == 0 || rdata->result == -EAGAIN)
 		iov_iter_advance(&rdata->subreq.io_iter, rdata->got_bytes);
 	rdata->credits.value = 0;
-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result == 0 || rdata->result == -EAGAIN) ?
-				rdata->got_bytes : rdata->result,
-				false);
+	rdata->subreq.transferred += rdata->got_bytes;
+	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 0ff1a286e9ee..59ac02bbdd19 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -140,25 +140,22 @@ static void cifs_netfs_invalidate_cache(struct netfs_io_request *wreq)
 }
 
 /*
- * Split the read up according to how many credits we can get for each piece.
- * It's okay to sleep here if we need to wait for more credit to become
- * available.
- *
- * We also choose the server and allocate an operation ID to be cleaned up
- * later.
+ * Negotiate the size of a read operation on behalf of the netfs library.
  */
-static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
+static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_io_stream *stream = &rreq->io_streams[subreq->stream_nr];
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
 	struct TCP_Server_Info *server = req->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	int rc;
+	size_t size;
+	int rc = 0;
 
-	rdata->xid = get_xid();
-	rdata->have_xid = true;
+	if (!rdata->have_xid) {
+		rdata->xid = get_xid();
+		rdata->have_xid = true;
+	}
 	rdata->server = server;
 
 	if (cifs_sb->ctx->rsize == 0)
@@ -166,13 +163,12 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 			server->ops->negotiate_rsize(tlink_tcon(req->cfile->tlink),
 						     cifs_sb->ctx);
 
-
 	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
-					   &stream->sreq_max_len, &rdata->credits);
-	if (rc) {
-		subreq->error = rc;
-		return false;
-	}
+					   &size, &rdata->credits);
+	if (rc)
+		return rc;
+
+	rreq->io_streams[0].sreq_max_len = size;
 
 	rdata->credits.in_flight_check = 1;
 	rdata->credits.rreq_debug_id = rreq->debug_id;
@@ -184,13 +180,11 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 			      server->credits, server->in_flight, 0,
 			      cifs_trace_rw_credits_read_submit);
 
-	subreq->len = umin(subreq->len, stream->sreq_max_len);
-
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->smbd_conn)
-		stream->sreq_max_segs = server->smbd_conn->max_frmr_depth;
+		rreq->io_streams[0].sreq_max_segs = server->smbd_conn->max_frmr_depth;
 #endif
-	return true;
+	return 0;
 }
 
 /*
@@ -199,32 +193,41 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
  * to only read a portion of that, but as long as we read something, the netfs
  * helper will call us again so that we can issue another read.
  */
-static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
+static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
+	struct TCP_Server_Info *server = req->server;
 	int rc = 0;
 
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
 		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
 		 subreq->transferred, subreq->len);
 
+	rc = adjust_credits(server, rdata, cifs_trace_rw_credits_issue_read_adjust);
+	if (rc)
+		goto failed;
+
 	if (req->cfile->invalidHandle) {
 		do {
 			rc = cifs_reopen_file(req->cfile, true);
 		} while (rc == -EAGAIN);
 		if (rc)
-			goto out;
+			goto failed;
 	}
 
 	if (subreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	rc = rdata->server->ops->async_readv(rdata);
-out:
 	if (rc)
-		netfs_subreq_terminated(subreq, rc, false);
+		goto failed;
+	return;
+
+failed:
+	netfs_read_subreq_terminated(subreq, rc, false);
 }
 
 /*
@@ -331,8 +334,8 @@ const struct netfs_request_ops cifs_req_ops = {
 	.init_request		= cifs_init_request,
 	.free_request		= cifs_free_request,
 	.free_subrequest	= cifs_free_subrequest,
-	.clamp_length		= cifs_clamp_length,
-	.issue_read		= cifs_req_issue_read,
+	.prepare_read		= cifs_prepare_read,
+	.issue_read		= cifs_issue_read,
 	.done			= cifs_rreq_done,
 	.begin_writeback	= cifs_begin_writeback,
 	.prepare_write		= cifs_prepare_write,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 83facb54276a..ff0c0017417b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4498,9 +4498,7 @@ static void smb2_readv_worker(struct work_struct *work)
 	struct cifs_io_subrequest *rdata =
 		container_of(work, struct cifs_io_subrequest, subreq.work);
 
-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result == 0 || rdata->result == -EAGAIN) ?
-				rdata->got_bytes : rdata->result, true);
+	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
 }
 
 static void
@@ -4554,6 +4552,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
 		rdata->result = -EAGAIN;
 		if (server->sign && rdata->got_bytes)
 			/* reset bytes number since we can not check a sign */
@@ -4607,6 +4606,10 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			      server->credits, server->in_flight,
 			      0, cifs_trace_rw_credits_read_response_clear);
 	rdata->credits.value = 0;
+	rdata->subreq.transferred += rdata->got_bytes;
+	if (rdata->subreq.start + rdata->subreq.transferred >= rdata->subreq.rreq->i_size)
+		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
@@ -4870,6 +4873,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 			      server->credits, server->in_flight,
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
+	trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_progress);
 	cifs_write_subrequest_terminated(wdata, result ?: written, true);
 	release_mid(mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
index 52773613bf23..955680c3bb5f 100644
--- a/include/linux/folio_queue.h
+++ b/include/linux/folio_queue.h
@@ -27,6 +27,7 @@ struct folio_queue {
 	struct folio_queue	*prev;		/* Previous queue segment of NULL */
 	unsigned long		marks;		/* 1-bit mark per folio */
 	unsigned long		marks2;		/* Second 1-bit mark per folio */
+	unsigned long		marks3;		/* Third 1-bit mark per folio */
 #if PAGEVEC_SIZE > BITS_PER_LONG
 #error marks is not big enough
 #endif
@@ -39,6 +40,7 @@ static inline void folioq_init(struct folio_queue *folioq)
 	folioq->prev = NULL;
 	folioq->marks = 0;
 	folioq->marks2 = 0;
+	folioq->marks3 = 0;
 }
 
 static inline unsigned int folioq_nr_slots(const struct folio_queue *folioq)
@@ -87,6 +89,21 @@ static inline void folioq_unmark2(struct folio_queue *folioq, unsigned int slot)
 	clear_bit(slot, &folioq->marks2);
 }
 
+static inline bool folioq_is_marked3(const struct folio_queue *folioq, unsigned int slot)
+{
+	return test_bit(slot, &folioq->marks3);
+}
+
+static inline void folioq_mark3(struct folio_queue *folioq, unsigned int slot)
+{
+	set_bit(slot, &folioq->marks3);
+}
+
+static inline void folioq_unmark3(struct folio_queue *folioq, unsigned int slot)
+{
+	clear_bit(slot, &folioq->marks3);
+}
+
 static inline unsigned int __folio_order(struct folio *folio)
 {
 	if (!folio_test_large(folio))
@@ -133,6 +150,7 @@ static inline void folioq_clear(struct folio_queue *folioq, unsigned int slot)
 	folioq->vec.folios[slot] = NULL;
 	folioq_unmark(folioq, slot);
 	folioq_unmark2(folioq, slot);
+	folioq_unmark3(folioq, slot);
 }
 
 #endif /* _LINUX_FOLIO_QUEUE_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 348f8f5ab5e6..c0f0c9c87d86 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -178,20 +178,26 @@ struct netfs_io_subrequest {
 	unsigned long long	start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
+	size_t			consumed;	/* Amount of read data consumed */
+	size_t			prev_donated;	/* Amount of data donated from previous subreq */
+	size_t			next_donated;	/* Amount of data donated from next subreq */
 	refcount_t		ref;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
 	unsigned int		nr_segs;	/* Number of segs in io_iter */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* I/O stream this belongs to */
+	unsigned char		curr_folioq_slot; /* Folio currently being read */
+	unsigned char		curr_folio_order; /* Order of folio */
+	struct folio_queue	*curr_folioq;	/* Queue segment in which current folio resides */
 	unsigned long		flags;
 #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
-#define NETFS_SREQ_SHORT_IO		2	/* Set if the I/O was short */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
 #define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
 #define NETFS_SREQ_BOUNDARY		6	/* Set if ends on hard boundary (eg. ceph object) */
+#define NETFS_SREQ_HIT_EOF		7	/* Set if short due to EOF */
 #define NETFS_SREQ_IN_PROGRESS		8	/* Unlocked when the subrequest completes */
 #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
 #define NETFS_SREQ_RETRYING		10	/* Set if we're retrying */
@@ -201,12 +207,14 @@ struct netfs_io_subrequest {
 enum netfs_io_origin {
 	NETFS_READAHEAD,		/* This read was triggered by readahead */
 	NETFS_READPAGE,			/* This read is a synchronous read */
+	NETFS_READ_GAPS,		/* This read is a synchronous read to fill gaps */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
 	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_WRITE,		/* This is a direct I/O write */
+	NETFS_PGPRIV2_COPY_TO_CACHE,	/* [DEPRECATED] This is writing read data to the cache */
 	nr__netfs_io_origin
 } __mode(byte);
 
@@ -223,6 +231,7 @@ struct netfs_io_request {
 	struct address_space	*mapping;	/* The mapping being accessed */
 	struct kiocb		*iocb;		/* AIO completion vector */
 	struct netfs_cache_resources cache_resources;
+	struct readahead_control *ractl;	/* Readahead descriptor */
 	struct list_head	proc_link;	/* Link in netfs_iorequests */
 	struct list_head	subrequests;	/* Contributory I/O operations */
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
@@ -243,12 +252,10 @@ struct netfs_io_request {
 	unsigned int		nr_group_rel;	/* Number of refs to release on ->group */
 	spinlock_t		lock;		/* Lock for queuing subreqs */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
-	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
-	size_t			upper_len;	/* Length can be extended to here */
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
-	short			error;		/* 0 or error that occurred */
+	long			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	u8			buffer_head_slot; /* First slot in ->buffer */
@@ -259,9 +266,9 @@ struct netfs_io_request {
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
+	size_t			prev_donated;	/* Fallback for subreq->prev_donated */
 	refcount_t		ref;
 	unsigned long		flags;
-#define NETFS_RREQ_INCOMPLETE_IO	0	/* Some ioreqs terminated short or with error */
 #define NETFS_RREQ_COPY_TO_CACHE	1	/* Need to write to the cache */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
@@ -273,6 +280,7 @@ struct netfs_io_request {
 #define NETFS_RREQ_PAUSE		11	/* Pause subrequest generation */
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
 #define NETFS_RREQ_ALL_QUEUED		13	/* All subreqs are now queued */
+#define NETFS_RREQ_NEED_RETRY		14	/* Need to try retrying */
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
@@ -291,7 +299,7 @@ struct netfs_request_ops {
 
 	/* Read request handling */
 	void (*expand_readahead)(struct netfs_io_request *rreq);
-	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
+	int (*prepare_read)(struct netfs_io_subrequest *subreq);
 	void (*issue_read)(struct netfs_io_subrequest *subreq);
 	bool (*is_still_valid)(struct netfs_io_request *rreq);
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
@@ -421,7 +429,10 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
 
 /* (Sub)request management API. */
-void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
+				bool was_async);
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
+				  int error, bool was_async);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 58bf23002fc1..7b26463cb98f 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -20,6 +20,7 @@
 	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
 	EM(netfs_read_trace_readahead,		"READAHEAD")	\
 	EM(netfs_read_trace_readpage,		"READPAGE ")	\
+	EM(netfs_read_trace_read_gaps,		"READ-GAPS")	\
 	EM(netfs_read_trace_prefetch_for_write,	"PREFETCHW")	\
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
@@ -33,12 +34,14 @@
 #define netfs_rreq_origins					\
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
+	EM(NETFS_READ_GAPS,			"RG")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
 	EM(NETFS_DIO_READ,			"DR")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
 	EM(NETFS_WRITETHROUGH,			"WT")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
-	E_(NETFS_DIO_WRITE,			"DW")
+	EM(NETFS_DIO_WRITE,			"DW")		\
+	E_(NETFS_PGPRIV2_COPY_TO_CACHE,		"2C")
 
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
@@ -69,15 +72,25 @@
 	E_(NETFS_INVALID_WRITE,			"INVL")
 
 #define netfs_sreq_traces					\
+	EM(netfs_sreq_trace_add_donations,	"+DON ")	\
+	EM(netfs_sreq_trace_added,		"ADD  ")	\
+	EM(netfs_sreq_trace_clear,		"CLEAR")	\
 	EM(netfs_sreq_trace_discard,		"DSCRD")	\
+	EM(netfs_sreq_trace_donate_to_prev,	"DON-P")	\
+	EM(netfs_sreq_trace_donate_to_next,	"DON-N")	\
 	EM(netfs_sreq_trace_download_instead,	"RDOWN")	\
 	EM(netfs_sreq_trace_fail,		"FAIL ")	\
 	EM(netfs_sreq_trace_free,		"FREE ")	\
+	EM(netfs_sreq_trace_hit_eof,		"EOF  ")	\
+	EM(netfs_sreq_trace_io_progress,	"IO   ")	\
 	EM(netfs_sreq_trace_limited,		"LIMIT")	\
 	EM(netfs_sreq_trace_prepare,		"PREP ")	\
 	EM(netfs_sreq_trace_prep_failed,	"PRPFL")	\
-	EM(netfs_sreq_trace_resubmit_short,	"SHORT")	\
+	EM(netfs_sreq_trace_progress,		"PRGRS")	\
+	EM(netfs_sreq_trace_reprep_failed,	"REPFL")	\
 	EM(netfs_sreq_trace_retry,		"RETRY")	\
+	EM(netfs_sreq_trace_short,		"SHORT")	\
+	EM(netfs_sreq_trace_split,		"SPLIT")	\
 	EM(netfs_sreq_trace_submit,		"SUBMT")	\
 	EM(netfs_sreq_trace_terminated,		"TERM ")	\
 	EM(netfs_sreq_trace_write,		"WRITE")	\
@@ -118,7 +131,7 @@
 	EM(netfs_sreq_trace_new,		"NEW        ")	\
 	EM(netfs_sreq_trace_put_cancel,		"PUT CANCEL ")	\
 	EM(netfs_sreq_trace_put_clear,		"PUT CLEAR  ")	\
-	EM(netfs_sreq_trace_put_discard,	"PUT DISCARD")	\
+	EM(netfs_sreq_trace_put_consumed,	"PUT CONSUME")	\
 	EM(netfs_sreq_trace_put_done,		"PUT DONE   ")	\
 	EM(netfs_sreq_trace_put_failed,		"PUT FAILED ")	\
 	EM(netfs_sreq_trace_put_merged,		"PUT MERGED ")	\
@@ -138,6 +151,7 @@
 	EM(netfs_flush_content,			"flush")	\
 	EM(netfs_streaming_filled_page,		"mod-streamw-f") \
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
+	EM(netfs_folio_trace_abandon,		"abandon")	\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
@@ -154,7 +168,11 @@
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_not_under_wback,	"!wback")	\
 	EM(netfs_folio_trace_put,		"put")		\
+	EM(netfs_folio_trace_read,		"read")		\
+	EM(netfs_folio_trace_read_done,		"read-done")	\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
+	EM(netfs_folio_trace_read_put,		"read-put")	\
+	EM(netfs_folio_trace_read_unlock,	"read-unlock")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\
 	EM(netfs_folio_trace_store_copy,	"store-copy")	\
@@ -167,6 +185,12 @@
 	EM(netfs_contig_trace_jump,		"-->JUMP-->")	\
 	E_(netfs_contig_trace_unlock,		"Unlock")
 
+#define netfs_donate_traces					\
+	EM(netfs_trace_donate_tail_to_prev,	"tail-to-prev")	\
+	EM(netfs_trace_donate_to_prev,		"to-prev")	\
+	EM(netfs_trace_donate_to_next,		"to-next")	\
+	E_(netfs_trace_donate_to_deferred_next,	"defer-next")
+
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
@@ -184,6 +208,7 @@ enum netfs_rreq_ref_trace { netfs_rreq_ref_traces } __mode(byte);
 enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
 enum netfs_folio_trace { netfs_folio_traces } __mode(byte);
 enum netfs_collect_contig_trace { netfs_collect_contig_traces } __mode(byte);
+enum netfs_donate_trace { netfs_donate_traces } __mode(byte);
 
 #endif
 
@@ -206,6 +231,7 @@ netfs_rreq_ref_traces;
 netfs_sreq_ref_traces;
 netfs_folio_traces;
 netfs_collect_contig_traces;
+netfs_donate_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -226,6 +252,7 @@ TRACE_EVENT(netfs_read,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		rreq		)
 		    __field(unsigned int,		cookie		)
+		    __field(loff_t,			i_size		)
 		    __field(loff_t,			start		)
 		    __field(size_t,			len		)
 		    __field(enum netfs_read_trace,	what		)
@@ -235,18 +262,19 @@ TRACE_EVENT(netfs_read,
 	    TP_fast_assign(
 		    __entry->rreq	= rreq->debug_id;
 		    __entry->cookie	= rreq->cache_resources.debug_id;
+		    __entry->i_size	= rreq->i_size;
 		    __entry->start	= start;
 		    __entry->len	= len;
 		    __entry->what	= what;
 		    __entry->netfs_inode = rreq->inode->i_ino;
 			   ),
 
-	    TP_printk("R=%08x %s c=%08x ni=%x s=%llx %zx",
+	    TP_printk("R=%08x %s c=%08x ni=%x s=%llx l=%zx sz=%llx",
 		      __entry->rreq,
 		      __print_symbolic(__entry->what, netfs_read_traces),
 		      __entry->cookie,
 		      __entry->netfs_inode,
-		      __entry->start, __entry->len)
+		      __entry->start, __entry->len, __entry->i_size)
 	    );
 
 TRACE_EVENT(netfs_rreq,
@@ -651,6 +679,71 @@ TRACE_EVENT(netfs_collect_stream,
 		      __entry->collected_to, __entry->front)
 	    );
 
+TRACE_EVENT(netfs_progress,
+	    TP_PROTO(const struct netfs_io_subrequest *subreq,
+		     unsigned long long start, size_t avail, size_t part),
+
+	    TP_ARGS(subreq, start, avail, part),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		subreq)
+		    __field(unsigned int,		consumed)
+		    __field(unsigned int,		transferred)
+		    __field(unsigned long long,		f_start)
+		    __field(unsigned int,		f_avail)
+		    __field(unsigned int,		f_part)
+		    __field(unsigned char,		slot)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= subreq->rreq->debug_id;
+		    __entry->subreq	= subreq->debug_index;
+		    __entry->consumed	= subreq->consumed;
+		    __entry->transferred = subreq->transferred;
+		    __entry->f_start	= start;
+		    __entry->f_avail	= avail;
+		    __entry->f_part	= part;
+		    __entry->slot	= subreq->curr_folioq_slot;
+			   ),
+
+	    TP_printk("R=%08x[%02x] s=%llx ct=%x/%x pa=%x/%x sl=%x",
+		      __entry->rreq, __entry->subreq, __entry->f_start,
+		      __entry->consumed, __entry->transferred,
+		      __entry->f_part, __entry->f_avail,  __entry->slot)
+	    );
+
+TRACE_EVENT(netfs_donate,
+	    TP_PROTO(const struct netfs_io_request *rreq,
+		     const struct netfs_io_subrequest *from,
+		     const struct netfs_io_subrequest *to,
+		     size_t amount,
+		     enum netfs_donate_trace trace),
+
+	    TP_ARGS(rreq, from, to, amount, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		from)
+		    __field(unsigned int,		to)
+		    __field(unsigned int,		amount)
+		    __field(enum netfs_donate_trace,	trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= rreq->debug_id;
+		    __entry->from	= from->debug_index;
+		    __entry->to		= to ? to->debug_index : -1;
+		    __entry->amount	= amount;
+		    __entry->trace	= trace;
+			   ),
+
+	    TP_printk("R=%08x[%02x] -> [%02x] %s am=%x",
+		      __entry->rreq, __entry->from, __entry->to,
+		      __print_symbolic(__entry->trace, netfs_donate_traces),
+		      __entry->amount)
+	    );
+
 #undef EM
 #undef E_
 #endif /* _TRACE_NETFS_H */


