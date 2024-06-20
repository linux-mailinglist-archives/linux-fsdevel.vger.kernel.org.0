Return-Path: <linux-fsdevel+bounces-22025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6526910FCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 20:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE087B29D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E91CE9E0;
	Thu, 20 Jun 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOAV5Vji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C001BA863
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904861; cv=none; b=mZK7U9ozgWyrgtBu04Eyi746toD0KHCabjAIBKW+JPAGtY+FC0ZiOsBfnapmLzn7ygXTngbiAPcLD5pBemPfpjbFCA17El5H3T1/nnqZouJD13fl6jFFMH6i2dkchhWLCKV+YUhXTTq54dMdGA8xV4bj5yEIahv+xaq4Ml56kxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904861; c=relaxed/simple;
	bh=UPSCq7VGZv89byTbTB4i4NtDzE8lOeRtna8j2OEi1Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km13wwaFwF9DlPAlEcnhoyX8alVxhnNXgA1no6RjVTY4CkBeKkVZnx18Fsfj8ZWHTFOTNId+676rE8Lb8UBtWwClJi6t4NJAiRhU1sntKj4+enQ6rQwB18Pk8IAoFx3sLae/E2OUJaf1Qb8HFkEIsZGsNMoOjVKBwKyL3EP1rIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOAV5Vji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uR+6EPlHTcAD9HukMoGDWtDn8rsvtq/nTdXRI0bZ5pY=;
	b=fOAV5VjiSd5LJOxbJkhGa1pTzPRKMcBICk/tM+iId0Fm77eGGQoS/byN5Obceuikp1Dnv1
	WdkGsOnDjFJwrzr47o5XXiyQX0Z4Lail87I5LJ/tjrBV098UiZb9ADw2/76ZGCMifri8y+
	nvBsbu9t+mn0PWLAkSeXdr2K0ZIe84E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-Sc2_dRjRNFmQDYFmSMA_Lw-1; Thu,
 20 Jun 2024 13:34:10 -0400
X-MC-Unique: Sc2_dRjRNFmQDYFmSMA_Lw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D906619560B0;
	Thu, 20 Jun 2024 17:34:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CE651956087;
	Thu, 20 Jun 2024 17:34:00 +0000 (UTC)
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
Subject: [PATCH 17/17] netfs: Speed up buffered reading
Date: Thu, 20 Jun 2024 18:31:35 +0100
Message-ID: <20240620173137.610345-18-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

[!!!] NOTE: THIS PATCH IS INCOMPLETE!  Buffered reading mostly works, but
      unbuffered/direct reads don't.  Further, I have not yet
      re-implemented read-retry or tested local caching.

Improve the efficiency of buffered reads in a number of ways:

 (1) Overhaul the algorithm in general so that it's a lot more compact and
     split the read submission code between buffered and unbuffered
     versions.  The unbuffered version can be vastly simplified.

 (2) Get rid of ->clamp_length(), instead calling into ->issue_read() and
     having it return the size of the slice issued.  This gets rid of a
     function pointer.

 (3) After determining the size of the slice it wants, ->issue_read() must
     call netfs_prepare_read_iterator() to load more folios into the buffer
     (if necessary) and to set the iterators.  This allows some of the work
     to be done whilst I/O is in progress.

 (4) netfs_subreq_terminated(), which was used to report termination, is
     replaced with a function, netfs_read_subreq_progress(), that can be
     used to report incomplete progress as well as termination.

     afs can then use this to start unlocking pages as it fills them in as
     its transport has a packetised approach to RPCs rather than complete
     smaller messages favoured by, say, cifs.

 (5) Read-result collection is handed off to a work queue rather than being
     done in the I/O thread.  Multiple subrequests can be processes
     simultaneously.

 (6) When a subrequest is collected, any folios it fully spans are
     collected and "spare" data on either side is donated to either the
     previous or the next subrequest in the sequence.

Notes:

 (*) Readahead expansion is currently not working and needs investigation.

 (*) Unbuffered/direct-I/O reads don't work and need debugging.

 (*) Caching is untested and may not work.

 (*) Failed or partial reads need retrying, but aren't yet.

 (*) RDMA with cifs does appear to work, both with SIW and RXE.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c             |  13 +-
 fs/afs/file.c                |  18 +-
 fs/afs/fsclient.c            |   9 +-
 fs/afs/yfsclient.c           |   9 +-
 fs/ceph/addr.c               |  72 ++---
 fs/netfs/Makefile            |   2 +-
 fs/netfs/buffered_read.c     | 510 +++++++++++++++++++++------------
 fs/netfs/direct_read.c       |  99 ++++++-
 fs/netfs/internal.h          |   6 -
 fs/netfs/io.c                | 528 +----------------------------------
 fs/netfs/iterator.c          |  50 ++++
 fs/netfs/main.c              |   7 +-
 fs/netfs/objects.c           |   1 -
 fs/netfs/read_collect.c      | 450 +++++++++++++++++++++++++++++
 fs/netfs/write_issue.c       |   4 -
 fs/nfs/fscache.c             |  31 +-
 fs/nfs/fscache.h             |   7 +-
 fs/smb/client/cifssmb.c      |   6 +-
 fs/smb/client/file.c         |  69 +++--
 fs/smb/client/smb2pdu.c      |   8 +-
 include/linux/netfs.h        |  19 +-
 include/trace/events/netfs.h |  82 +++++-
 22 files changed, 1171 insertions(+), 829 deletions(-)
 create mode 100644 fs/netfs/read_collect.c

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a97ceb105cd8..829a8215b870 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -64,12 +64,17 @@ static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
  * v9fs_issue_read - Issue a read from 9P
  * @subreq: The read to make
  */
-static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
+static ssize_t v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
+	ssize_t len;
 	int total, err;
 
+	len = netfs_prepare_read_iterator(subreq, ULONG_MAX, 0);
+	if (len < 0)
+		return len;
+
 	total = p9_client_read(fid, subreq->start + subreq->transferred,
 			       &subreq->io_iter, &err);
 
@@ -77,7 +82,11 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	 * cache won't be on server and is zeroes */
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
-	netfs_subreq_terminated(subreq, err ?: total, false);
+	if (!err)
+		subreq->transferred += total;
+
+	netfs_read_subreq_progress(subreq, err, false);
+	return len;
 }
 
 /**
diff --git a/fs/afs/file.c b/fs/afs/file.c
index addb106dba4c..54805a4c6d5c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -243,7 +243,7 @@ static void afs_fetch_data_notify(struct afs_operation *op)
 	req->error = error;
 	if (subreq) {
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-		netfs_subreq_terminated(subreq, error ?: req->actual_len, false);
+		netfs_read_subreq_progress(subreq, error, false);
 		req->subreq = NULL;
 	} else if (req->done) {
 		req->done(req);
@@ -293,7 +293,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	op = afs_alloc_operation(req->key, vnode->volume);
 	if (IS_ERR(op)) {
 		if (req->subreq)
-			netfs_subreq_terminated(req->subreq, PTR_ERR(op), false);
+			netfs_read_subreq_progress(req->subreq, PTR_ERR(op), false);
 		return PTR_ERR(op);
 	}
 
@@ -312,7 +312,7 @@ static void afs_read_worker(struct work_struct *work)
 
 	fsreq = afs_alloc_read(GFP_NOFS);
 	if (!fsreq)
-		return netfs_subreq_terminated(subreq, -ENOMEM, false);
+		return netfs_read_subreq_progress(subreq, -ENOMEM, false);
 
 	fsreq->subreq	= subreq;
 	fsreq->pos	= subreq->start + subreq->transferred;
@@ -325,10 +325,16 @@ static void afs_read_worker(struct work_struct *work)
 	afs_put_read(fsreq);
 }
 
-static void afs_issue_read(struct netfs_io_subrequest *subreq)
+static ssize_t afs_issue_read(struct netfs_io_subrequest *subreq)
 {
-	INIT_WORK(&subreq->work, afs_read_worker);
-	queue_work(system_long_wq, &subreq->work);
+	ssize_t len;
+
+	len = netfs_prepare_read_iterator(subreq, ULONG_MAX, 0);
+	if (len > 0) {
+		INIT_WORK(&subreq->work, afs_read_worker);
+		queue_work(system_long_wq, &subreq->work);
+	}
+	return len;
 }
 
 static int afs_symlink_read_folio(struct file *file, struct folio *folio)
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 79cd30775b7a..55165dc59039 100644
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
+			netfs_read_subreq_progress(req->subreq, -EINPROGRESS, false);
+		}
 		if (ret < 0)
 			return ret;
 
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index f521e66d3bf6..33b1717e56a6 100644
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
+			netfs_read_subreq_progress(req->subreq, -EINPROGRESS, false);
+		}
 		if (ret < 0)
 			return ret;
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8c16bc5250ef..7024dc58b363 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -205,21 +205,6 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
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
@@ -263,7 +248,11 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 				     calc_pages_for(osd_data->alignment,
 					osd_data->length), false);
 	}
-	netfs_subreq_terminated(subreq, err, false);
+	if (err > 0) {
+		subreq->transferred = err;
+		err = 0;
+	}
+	netfs_read_subreq_progress(subreq, err, false);
 	iput(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
@@ -277,7 +266,6 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct iov_iter iter;
 	ssize_t err = 0;
 	size_t len;
 	int mode;
@@ -312,18 +300,21 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
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
+	netfs_read_subreq_progress(subreq, err, false);
 	return true;
 }
 
-static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
+static ssize_t ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
@@ -332,9 +323,11 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_request *req = NULL;
 	struct ceph_vino vino = ceph_vino(inode);
-	struct iov_iter iter;
-	int err = 0;
-	u64 len = subreq->len;
+	ssize_t slice = subreq->len;
+	int err;
+	u64 objno, objoff;
+	u32 xlen;
+	u64 len;
 	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
 	u64 off = subreq->start;
 	int extent_cnt;
@@ -344,9 +337,24 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		goto out;
 	}
 
-	if (ceph_has_inline_data(ci) && ceph_netfs_issue_op_inline(subreq))
-		return;
+	/* Truncate the extent at the end of the current block */
+	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
+				      &objno, &objoff, &xlen);
+	xlen = umin(xlen, fsc->mount_options->rsize);
 
+	slice = netfs_prepare_read_iterator(subreq, xlen, 0);
+	if (slice < 0)
+		return slice;
+
+	if (ceph_has_inline_data(ci) && ceph_netfs_issue_op_inline(subreq))
+		return slice;
+
+	// TODO: This rounding here is slightly dodgy.  It *should* work, for
+	// now, as the cache only deals in blocks that are a multiple of
+	// PAGE_SIZE and fscrypt blocks are at most PAGE_SIZE.  What needs to
+	// happen is for the fscrypt driving to be moved into netfslib and the
+	// data in the cache also to be stored encrypted.
+	len = slice;
 	ceph_fscrypt_adjust_off_and_len(inode, &off, &len);
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino,
@@ -369,8 +377,6 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	doutc(cl, "%llx.%llx pos=%llu orig_len=%zu len=%llu\n",
 	      ceph_vinop(inode), subreq->start, subreq->len, len);
 
-	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
-
 	/*
 	 * FIXME: For now, use CEPH_OSD_DATA_TYPE_PAGES instead of _ITER for
 	 * encrypted inodes. We'd need infrastructure that handles an iov_iter
@@ -382,7 +388,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		struct page **pages;
 		size_t page_off;
 
-		err = iov_iter_get_pages_alloc2(&iter, &pages, len, &page_off);
+		err = iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, len, &page_off);
 		if (err < 0) {
 			doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
 			      ceph_vinop(inode), err);
@@ -397,7 +403,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false,
 						 false);
 	} else {
-		osd_req_op_extent_osd_iter(req, 0, &iter);
+		osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
 	}
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 		err = -EIO;
@@ -412,8 +418,9 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 out:
 	ceph_osdc_put_request(req);
 	if (err)
-		netfs_subreq_terminated(subreq, err, false);
+		netfs_read_subreq_progress(subreq, err, false);
 	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
+	return err < 0 ? err : slice;
 }
 
 static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
@@ -493,7 +500,6 @@ const struct netfs_request_ops ceph_netfs_ops = {
 	.free_request		= ceph_netfs_free_request,
 	.issue_read		= ceph_netfs_issue_read,
 	.expand_readahead	= ceph_netfs_expand_readahead,
-	.clamp_length		= ceph_netfs_clamp_length,
 	.check_write_begin	= ceph_netfs_check_write_begin,
 };
 
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 8e6781e0b10b..0bd2996a2a77 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -5,12 +5,12 @@ netfs-y := \
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
 	write_collect.o \
 	write_issue.o
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a6bb03bea920..aabe79df765a 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -9,126 +9,6 @@
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 
-/*
- * Unlock the folios in a read operation.  We need to set PG_writeback on any
- * folios we're going to write back before we unlock them.
- *
- * Note that if the deprecated NETFS_RREQ_USE_PGPRIV2 is set then we use
- * PG_private_2 and do a direct write to the cache from here instead.
- */
-void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-	struct netfs_folio *finfo;
-	struct folio *folio;
-	pgoff_t start_page = rreq->start / PAGE_SIZE;
-	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
-	size_t account = 0;
-	bool subreq_failed = false;
-
-	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
-
-	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
-		__clear_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
-		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-			__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
-		}
-	}
-
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
-
-	rcu_read_lock();
-	xas_for_each(&xas, folio, last_page) {
-		loff_t pg_end;
-		bool pg_failed = false;
-		bool wback_to_cache = false;
-		bool folio_started = false;
-
-		if (xas_retry(&xas, folio))
-			continue;
-
-		pg_end = folio_pos(folio) + folio_size(folio) - 1;
-
-		for (;;) {
-			loff_t sreq_end;
-
-			if (!subreq) {
-				pg_failed = true;
-				break;
-			}
-			if (test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)) {
-				if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE,
-							       &subreq->flags)) {
-					trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
-					folio_start_private_2(folio);
-					folio_started = true;
-				}
-			} else {
-				wback_to_cache |=
-					test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
-			}
-			pg_failed |= subreq_failed;
-			sreq_end = subreq->start + subreq->len - 1;
-			if (pg_end < sreq_end)
-				break;
-
-			account += subreq->transferred;
-			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-				subreq = list_next_entry(subreq, rreq_link);
-				subreq_failed = (subreq->error < 0);
-			} else {
-				subreq = NULL;
-				subreq_failed = false;
-			}
-
-			if (pg_end == sreq_end)
-				break;
-		}
-
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
-		}
-
-		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-			if (folio->index == rreq->no_unlock_folio &&
-			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
-				_debug("no unlock");
-			else
-				folio_unlock(folio);
-		}
-	}
-	rcu_read_unlock();
-
-	task_io_account_read(account);
-	if (rreq->netfs_ops->done)
-		rreq->netfs_ops->done(rreq);
-}
-
 static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
 					 unsigned long long *_start,
 					 unsigned long long *_len,
@@ -183,6 +63,278 @@ static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_in
 	return fscache_begin_read_operation(&rreq->cache_resources, netfs_i_cookie(ctx));
 }
 
+/*
+ * Decant the list of folios to read into a rolling buffer.
+ */
+static size_t netfs_load_buffer_from_ra(struct netfs_io_request *rreq,
+					struct sheaf *sheaf)
+{
+	unsigned int order, nr;
+	size_t size = 0;
+
+	nr = __readahead_batch(rreq->ractl, (struct page **)sheaf->slots,
+			       ARRAY_SIZE(sheaf->slots));
+	for (int i = 0; i < nr; i++) {
+		struct folio *folio = sheaf_slot_folio(sheaf, i);
+
+		trace_netfs_folio(folio, netfs_folio_trace_read);
+		order = folio_order(folio);
+		sheaf->orders[i] = order;
+		size += PAGE_SIZE << order;
+	}
+
+	for (int i = nr; i < ARRAY_SIZE(sheaf->slots); i++)
+		sheaf_slot_set(sheaf, i, NULL);
+
+	return size;
+}
+
+/**
+ * netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
+ * @subreq: The subrequest to be set up
+ * @rsize: Preferred (and maximum) size
+ * @max_segs: Maximum number of DMA segments (or 0)
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
+ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq, size_t rsize,
+				    unsigned int max_segs)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	rsize = umin(subreq->len, rsize);
+
+	if (rreq->ractl) {
+		/* If we don't have sufficient folios in the rolling buffer,
+		 * extract a sheaf's worth from the readahead region at a time
+		 * into the buffer.  Note that this acquires a ref on each page
+		 * that we will need to release later - but we don't want to do
+		 * that until after we've started the I/O.
+		 */
+		while (rreq->submitted < subreq->start + rsize) {
+			struct sheaf *tail = rreq->buffer_tail, *new;
+			size_t added;
+
+			new = kmalloc(sizeof(*new), GFP_NOFS);
+			if (!new)
+				return -ENOMEM;
+			netfs_stat(&netfs_n_sheaf);
+			new->next = NULL;
+			new->prev = tail;
+			tail->next = new;
+			rreq->buffer_tail = new;
+			added = netfs_load_buffer_from_ra(rreq, new);
+			rreq->iter.count += added;
+			rreq->submitted += added;
+		}
+	}
+
+	subreq->len = rsize;
+	if (unlikely(max_segs)) {
+		size_t limit = netfs_limit_iter(&rreq->iter, 0, rsize, max_segs);
+
+		if (limit < rsize) {
+			subreq->len = limit;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+		}
+	}
+
+	subreq->io_iter	= rreq->iter;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+
+	if (iov_iter_is_sheaf(&subreq->io_iter)) {
+		subreq->curr_sheaf = (struct sheaf *)subreq->io_iter.sheaf;
+		subreq->curr_sheaf_slot = subreq->io_iter.sheaf_slot;
+		subreq->curr_folio_order = subreq->curr_sheaf->orders[subreq->curr_sheaf_slot];
+	}
+
+	iov_iter_truncate(&subreq->io_iter, subreq->len);
+	iov_iter_advance(&rreq->iter, subreq->len);
+	return subreq->len;
+}
+EXPORT_SYMBOL(netfs_prepare_read_iterator);
+
+static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rreq,
+						     struct netfs_io_subrequest *subreq,
+						     loff_t i_size)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+	if (!cres->ops)
+		return NETFS_DOWNLOAD_FROM_SERVER;
+	return cres->ops->prepare_read(subreq, i_size);
+}
+
+static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
+					bool was_async)
+{
+	struct netfs_io_subrequest *subreq = priv;
+
+	if (transferred_or_error < 0)
+		netfs_read_subreq_progress(subreq, transferred_or_error, was_async);
+
+	if (transferred_or_error > 0)
+		subreq->transferred += transferred_or_error;
+	netfs_read_subreq_progress(subreq, 0, was_async);
+}
+
+/*
+ * Issue a read against the cache.
+ * - Eats the caller's ref on subreq.
+ */
+static ssize_t netfs_read_cache_to_pagecache(struct netfs_io_request *rreq,
+					     struct netfs_io_subrequest *subreq)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	ssize_t slice = subreq->len;
+
+	netfs_stat(&netfs_n_rh_read);
+	cres->ops->read(cres, subreq->start, &subreq->io_iter, NETFS_READ_HOLE_IGNORE,
+			netfs_cache_read_terminated, subreq);
+	return slice;
+}
+
+/*
+ * Perform a read to the pagecache from a series of sources of different types,
+ * slicing up the region to be read according to available cache blocks and
+ * network rsize.
+ */
+static int netfs_read_to_pagecache(struct netfs_io_request *rreq)
+{
+	struct netfs_inode *ictx = netfs_inode(rreq->inode);
+	unsigned long long start = rreq->start;
+	ssize_t size = rreq->len;
+
+	/* Chop the readahead request up into subrequests. */
+	do {
+		struct netfs_io_subrequest *subreq;
+		enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
+		ssize_t slice;
+
+		subreq = netfs_alloc_subrequest(rreq);
+		if (!subreq)
+			return -ENOMEM;
+
+		subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
+		subreq->start	= start;
+		subreq->len	= size;
+
+		spin_lock(&rreq->lock);
+		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+		subreq->prev_donated = rreq->prev_donated;
+		rreq->prev_donated = 0;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
+		spin_unlock(&rreq->lock);
+
+		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
+		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
+			if (subreq->start >= ictx->zero_point) {
+				subreq->source = source = NETFS_FILL_WITH_ZEROES;
+				goto fill_with_zeroes;
+			}
+
+			if (subreq->len > ictx->zero_point - subreq->start)
+				subreq->len = ictx->zero_point - subreq->start;
+			if (subreq->len > rreq->i_size - subreq->start)
+				subreq->len = rreq->i_size - subreq->start;
+
+			netfs_stat(&netfs_n_rh_download);
+			slice = rreq->netfs_ops->issue_read(subreq);
+			if (slice <= 0)
+				return slice;
+			goto done;
+		}
+
+	fill_with_zeroes:
+		if (source == NETFS_FILL_WITH_ZEROES) {
+			subreq->source = NETFS_FILL_WITH_ZEROES;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+			netfs_stat(&netfs_n_rh_zero);
+			slice = subreq->len;
+			subreq->transferred = slice;
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+			netfs_read_subreq_progress(subreq, 0, false);
+			goto done;
+		}
+
+		if (source == NETFS_READ_FROM_CACHE) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+			slice = netfs_read_cache_to_pagecache(rreq, subreq);
+			goto done;
+		}
+
+		if (source == NETFS_INVALID_READ)
+			break;
+
+	done:
+		size -= slice;
+		start += slice;
+		cond_resched();
+	} while (size > 0);
+
+	return 0;
+}
+
+/*
+ * Set up the initial sheaf of buffer folios in the rolling buffer and set the
+ * iterator to refer to it.
+ */
+static int netfs_prime_buffer(struct netfs_io_request *rreq)
+{
+	struct sheaf *sheaf;
+	size_t added;
+
+	sheaf = kmalloc(sizeof(*sheaf), GFP_KERNEL);
+	if (!sheaf)
+		return -ENOMEM;
+	netfs_stat(&netfs_n_sheaf);
+	sheaf->next = NULL;
+	sheaf->prev = NULL;
+	rreq->buffer = sheaf;
+	rreq->buffer_tail = sheaf;
+	rreq->submitted = rreq->start;
+	iov_iter_sheaf(&rreq->iter, ITER_DEST, sheaf, 0, 0, 0);
+
+	added = netfs_load_buffer_from_ra(rreq, sheaf);
+	rreq->iter.count += added;
+	rreq->submitted += added;
+	return 0;
+}
+
+/*
+ * Drop the ref on each folio that we inherited from the VM readahead code.  We
+ * still have the folio locks to pin the page until we complete the I/O.
+ */
+static void netfs_put_ra_refs(struct sheaf *sheaf)
+{
+	struct folio_batch fbatch;
+
+	folio_batch_init(&fbatch);
+	while (sheaf) {
+		for (unsigned int slot = 0; slot < sheaf_nr_slots(sheaf); slot++) {
+			if (!sheaf->slots[slot])
+				continue;
+			trace_netfs_folio(sheaf_slot_folio(sheaf, slot),
+					  netfs_folio_trace_read_put);
+			if (!folio_batch_add(&fbatch, sheaf_slot_folio(sheaf, slot)))
+				folio_batch_release(&fbatch);
+		}
+		sheaf = sheaf->next;
+	}
+
+	folio_batch_release(&fbatch);
+}
+
 /**
  * netfs_readahead - Helper to manage a read request
  * @ractl: The description of the readahead request
@@ -201,22 +353,17 @@ static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_in
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
 
@@ -224,20 +371,17 @@ void netfs_readahead(struct readahead_control *ractl)
 	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
 			 netfs_read_trace_readahead);
 
-	netfs_rreq_expand(rreq, ractl);
+	//netfs_rreq_expand(rreq, ractl);
 
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
@@ -246,6 +390,30 @@ void netfs_readahead(struct readahead_control *ractl)
 }
 EXPORT_SYMBOL(netfs_readahead);
 
+/*
+ * Create a rolling buffer with a single occupying folio.
+ */
+static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct folio *folio)
+{
+	struct sheaf *sheaf;
+
+	sheaf = kzalloc(sizeof(*sheaf), GFP_KERNEL);
+	if (!sheaf)
+		return -ENOMEM;
+
+	netfs_stat(&netfs_n_sheaf);
+	sheaf->next = NULL;
+	sheaf->prev = NULL;
+	sheaf_slot_set_folio(sheaf, 0, folio);
+	sheaf->orders[0] = folio_order(folio);
+	rreq->buffer = sheaf;
+	rreq->buffer_tail = sheaf;
+	rreq->submitted = rreq->start + rreq->len;
+	iov_iter_sheaf(&rreq->iter, ITER_DEST, sheaf, 0, 0, rreq->len);
+	rreq->ractl = (struct readahead_control *)1UL;
+	return 0;
+}
+
 /**
  * netfs_read_folio - Helper to manage a read_folio request
  * @file: The file to read from
@@ -326,14 +494,28 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 		if (to < flen)
 			bvec_set_folio(&bvec[i++], folio, flen - to, to);
 		iov_iter_bvec(&rreq->iter, ITER_DEST, bvec, i, rreq->len);
+
+		ret = netfs_read_to_pagecache(rreq);
+
+		if (sink)
+			folio_put(sink);
 	} else {
-		iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
-				rreq->start, rreq->len);
+		ret = netfs_create_singular_buffer(rreq, folio);
+		if (ret < 0)
+			goto discard;
+
+		ret = netfs_read_to_pagecache(rreq);
+	}
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
+	wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS, TASK_UNINTERRUPTIBLE);
+	if (ret == 0)
+		ret = rreq->error;
+	if (ret == 0 && rreq->submitted < rreq->len) {
+		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
+		ret = -EIO;
 	}
 
-	ret = netfs_begin_read(rreq, true);
-	if (sink)
-		folio_put(sink);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret < 0 ? ret : 0;
 
@@ -395,7 +577,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 }
 
 /**
- * netfs_write_begin - Helper to prepare for writing
+ * netfs_write_begin - Helper to prepare for writing [DEPRECATED]
  * @ctx: The netfs context
  * @file: The file to read from
  * @mapping: The mapping to read from
@@ -406,13 +588,10 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
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
@@ -437,8 +616,6 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int ret;
 
-	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
-
 retry:
 	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 				    mapping_gfp_mask(mapping));
@@ -486,22 +663,12 @@ int netfs_write_begin(struct netfs_inode *ctx,
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
+	ret = netfs_read_to_pagecache(rreq);
 	if (ret < 0)
 		goto error;
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
@@ -557,10 +724,11 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	trace_netfs_read(rreq, start, flen, netfs_read_trace_prefetch_for_write);
 
 	/* Set up the output buffer */
-	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
-			rreq->start, rreq->len);
+	ret = netfs_create_singular_buffer(rreq, folio);
+	if (ret < 0)
+		goto error_put;
 
-	ret = netfs_begin_read(rreq, true);
+	ret = netfs_read_to_pagecache(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret;
 
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 10a1e4da6bda..24a74eb25466 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -16,6 +16,103 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+/*
+ * Perform a read to a buffer from the server, slicing up the region to be read
+ * according to the network rsize.
+ */
+static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
+{
+	unsigned long long start = rreq->start;
+	ssize_t size = rreq->len;
+
+	do {
+		struct netfs_io_subrequest *subreq;
+		ssize_t slice;
+
+		subreq = netfs_alloc_subrequest(rreq);
+		if (!subreq)
+			return -ENOMEM;
+
+		subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
+		subreq->start	= start;
+		subreq->len	= size;
+
+		spin_lock(&rreq->lock);
+		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+		subreq->prev_donated = rreq->prev_donated;
+		rreq->prev_donated = 0;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
+		spin_unlock(&rreq->lock);
+
+		if (subreq->len > rreq->i_size - subreq->start)
+			subreq->len = rreq->i_size - subreq->start;
+
+		netfs_stat(&netfs_n_rh_download);
+		slice = rreq->netfs_ops->issue_read(subreq);
+		if (slice <= 0)
+			return slice;
+
+		size -= slice;
+		start += slice;
+
+		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
+		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
+			break;
+		cond_resched();
+	} while (size > 0);
+
+	return 0;
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
+	kenter("R=%x %llx-%llx",
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
+	kleave(" = %d", ret);
+	return ret;
+}
+
 /**
  * netfs_unbuffered_read_iter_locked - Perform an unbuffered or direct I/O read
  * @iocb: The I/O control descriptor describing the read
@@ -81,7 +178,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	if (async)
 		rreq->iocb = iocb;
 
-	ret = netfs_begin_read(rreq, is_sync_kiocb(iocb));
+	ret = netfs_unbuffered_read(rreq, is_sync_kiocb(iocb));
 	if (ret < 0)
 		goto out; /* May be -EIOCBQUEUED */
 	if (!async) {
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index fe0974a95152..c470857bfcf8 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -23,15 +23,9 @@
 /*
  * buffered_read.c
  */
-void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
 
-/*
- * io.c
- */
-int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
-
 /*
  * main.c
  */
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 27dbea0f3867..84392eed87ee 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -16,88 +16,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 
-/*
- * Clear the unread part of an I/O request.
- */
-static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
-{
-	iov_iter_zero(iov_iter_count(&subreq->io_iter), &subreq->io_iter);
-}
-
-static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
-					bool was_async)
-{
-	struct netfs_io_subrequest *subreq = priv;
-
-	netfs_subreq_terminated(subreq, transferred_or_error, was_async);
-}
-
-/*
- * Issue a read against the cache.
- * - Eats the caller's ref on subreq.
- */
-static void netfs_read_from_cache(struct netfs_io_request *rreq,
-				  struct netfs_io_subrequest *subreq,
-				  enum netfs_read_from_hole read_hole)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	netfs_stat(&netfs_n_rh_read);
-	cres->ops->read(cres, subreq->start, &subreq->io_iter, read_hole,
-			netfs_cache_read_terminated, subreq);
-}
-
-/*
- * Fill a subrequest region with zeroes.
- */
-static void netfs_fill_with_zeroes(struct netfs_io_request *rreq,
-				   struct netfs_io_subrequest *subreq)
-{
-	netfs_stat(&netfs_n_rh_zero);
-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	netfs_subreq_terminated(subreq, 0, false);
-}
-
-/*
- * Ask the netfs to issue a read request to the server for us.
- *
- * The netfs is expected to read from subreq->pos + subreq->transferred to
- * subreq->pos + subreq->len - 1.  It may not backtrack and write data into the
- * buffer prior to the transferred point as it might clobber dirty data
- * obtained from the cache.
- *
- * Alternatively, the netfs is allowed to indicate one of two things:
- *
- * - NETFS_SREQ_SHORT_READ: A short read - it will get called again to try and
- *   make progress.
- *
- * - NETFS_SREQ_CLEAR_TAIL: A short read - the rest of the buffer will be
- *   cleared.
- */
-static void netfs_read_from_server(struct netfs_io_request *rreq,
-				   struct netfs_io_subrequest *subreq)
-{
-	netfs_stat(&netfs_n_rh_download);
-
-	if (rreq->origin != NETFS_DIO_READ &&
-	    iov_iter_count(&subreq->io_iter) != subreq->len - subreq->transferred)
-		pr_warn("R=%08x[%u] ITER PRE-MISMATCH %zx != %zx-%zx %lx\n",
-			rreq->debug_id, subreq->debug_index,
-			iov_iter_count(&subreq->io_iter), subreq->len,
-			subreq->transferred, subreq->flags);
-	rreq->netfs_ops->issue_read(subreq);
-}
-
-/*
- * Release those waiting.
- */
-static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
-{
-	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
-	netfs_clear_subrequests(rreq, was_async);
-	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
-}
-
+#if 0
 /*
  * Handle a short read.
  */
@@ -162,8 +81,6 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 	__clear_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
 		if (subreq->error) {
-			if (subreq->source != NETFS_READ_FROM_CACHE)
-				break;
 			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->error = 0;
 			netfs_stat(&netfs_n_rh_download_instead);
@@ -203,445 +120,4 @@ static void netfs_rreq_is_still_valid(struct netfs_io_request *rreq)
 		}
 	}
 }
-
-/*
- * Determine how much we can admit to having read from a DIO read.
- */
-static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-	unsigned int i;
-	size_t transferred = 0;
-
-	for (i = 0; i < rreq->direct_bv_count; i++) {
-		flush_dcache_page(rreq->direct_bv[i].bv_page);
-		// TODO: cifs marks pages in the destination buffer
-		// dirty under some circumstances after a read.  Do we
-		// need to do that too?
-		set_page_dirty(rreq->direct_bv[i].bv_page);
-	}
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		if (subreq->error || subreq->transferred == 0)
-			break;
-		transferred += subreq->transferred;
-		if (subreq->transferred < subreq->len)
-			break;
-	}
-
-	for (i = 0; i < rreq->direct_bv_count; i++)
-		flush_dcache_page(rreq->direct_bv[i].bv_page);
-
-	rreq->transferred = transferred;
-	task_io_account_read(transferred);
-
-	if (rreq->iocb) {
-		rreq->iocb->ki_pos += transferred;
-		if (rreq->iocb->ki_complete)
-			rreq->iocb->ki_complete(
-				rreq->iocb, rreq->error ? rreq->error : transferred);
-	}
-	if (rreq->netfs_ops->done)
-		rreq->netfs_ops->done(rreq);
-	inode_dio_end(rreq->inode);
-}
-
-/*
- * Assess the state of a read request and decide what to do next.
- *
- * Note that we could be in an ordinary kernel thread, on a workqueue or in
- * softirq context at this point.  We inherit a ref from the caller.
- */
-static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
-{
-	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
-
-again:
-	netfs_rreq_is_still_valid(rreq);
-
-	if (!test_bit(NETFS_RREQ_FAILED, &rreq->flags) &&
-	    test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags)) {
-		if (netfs_rreq_perform_resubmissions(rreq))
-			goto again;
-		return;
-	}
-
-	if (rreq->origin != NETFS_DIO_READ)
-		netfs_rreq_unlock_folios(rreq);
-	else
-		netfs_rreq_assess_dio(rreq);
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
-
-	netfs_rreq_completed(rreq, was_async);
-}
-
-static void netfs_rreq_work(struct work_struct *work)
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-	netfs_rreq_assess(rreq, false);
-}
-
-/*
- * Handle the completion of all outstanding I/O operations on a read request.
- * We inherit a ref from the caller.
- */
-static void netfs_rreq_terminated(struct netfs_io_request *rreq,
-				  bool was_async)
-{
-	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
-	    was_async) {
-		if (!queue_work(system_unbound_wq, &rreq->work))
-			BUG();
-	} else {
-		netfs_rreq_assess(rreq, was_async);
-	}
-}
-
-/**
- * netfs_subreq_terminated - Note the termination of an I/O operation.
- * @subreq: The I/O request that has terminated.
- * @transferred_or_error: The amount of data transferred or an error code.
- * @was_async: The termination was asynchronous
- *
- * This tells the read helper that a contributory I/O operation has terminated,
- * one way or another, and that it should integrate the results.
- *
- * The caller indicates in @transferred_or_error the outcome of the operation,
- * supplying a positive value to indicate the number of bytes transferred, 0 to
- * indicate a failure to transfer anything that should be retried or a negative
- * error code.  The helper will look after reissuing I/O operations as
- * appropriate and writing downloaded data to the cache.
- *
- * If @was_async is true, the caller might be running in softirq or interrupt
- * context and we can't sleep.
- */
-void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
-			     ssize_t transferred_or_error,
-			     bool was_async)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	int u;
-
-	_enter("R=%x[%x]{%llx,%lx},%zd",
-	       rreq->debug_id, subreq->debug_index,
-	       subreq->start, subreq->flags, transferred_or_error);
-
-	switch (subreq->source) {
-	case NETFS_READ_FROM_CACHE:
-		netfs_stat(&netfs_n_rh_read_done);
-		break;
-	case NETFS_DOWNLOAD_FROM_SERVER:
-		netfs_stat(&netfs_n_rh_download_done);
-		break;
-	default:
-		break;
-	}
-
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		subreq->error = transferred_or_error;
-		trace_netfs_failure(rreq, subreq, transferred_or_error,
-				    netfs_fail_read);
-		goto failed;
-	}
-
-	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
-		 "Subreq overread: R%x[%x] %zd > %zu - %zu",
-		 rreq->debug_id, subreq->debug_index,
-		 transferred_or_error, subreq->len, subreq->transferred))
-		transferred_or_error = subreq->len - subreq->transferred;
-
-	subreq->error = 0;
-	subreq->transferred += transferred_or_error;
-	if (subreq->transferred < subreq->len)
-		goto incomplete;
-
-complete:
-	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-	if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
-		set_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
-
-out:
-	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
-
-	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
-	u = atomic_dec_return(&rreq->nr_outstanding);
-	if (u == 0)
-		netfs_rreq_terminated(rreq, was_async);
-	else if (u == 1)
-		wake_up_var(&rreq->nr_outstanding);
-
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
-	return;
-
-incomplete:
-	if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
-		netfs_clear_unread(subreq);
-		subreq->transferred = subreq->len;
-		goto complete;
-	}
-
-	if (transferred_or_error == 0) {
-		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
-			subreq->error = -ENODATA;
-			goto failed;
-		}
-	} else {
-		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-	}
-
-	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
-	set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-	goto out;
-
-failed:
-	if (subreq->source == NETFS_READ_FROM_CACHE) {
-		netfs_stat(&netfs_n_rh_read_failed);
-		set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-	} else {
-		netfs_stat(&netfs_n_rh_download_failed);
-		set_bit(NETFS_RREQ_FAILED, &rreq->flags);
-		rreq->error = subreq->error;
-	}
-	goto out;
-}
-EXPORT_SYMBOL(netfs_subreq_terminated);
-
-static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_subrequest *subreq,
-						       loff_t i_size)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	if (cres->ops)
-		return cres->ops->prepare_read(subreq, i_size);
-	if (subreq->start >= rreq->i_size)
-		return NETFS_FILL_WITH_ZEROES;
-	return NETFS_DOWNLOAD_FROM_SERVER;
-}
-
-/*
- * Work out what sort of subrequest the next one will be.
- */
-static enum netfs_io_source
-netfs_rreq_prepare_read(struct netfs_io_request *rreq,
-			struct netfs_io_subrequest *subreq,
-			struct iov_iter *io_iter)
-{
-	enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
-	struct netfs_inode *ictx = netfs_inode(rreq->inode);
-	size_t lsize;
-
-	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
-
-	if (rreq->origin != NETFS_DIO_READ) {
-		source = netfs_cache_prepare_read(subreq, rreq->i_size);
-		if (source == NETFS_INVALID_READ)
-			goto out;
-	}
-
-	if (source == NETFS_DOWNLOAD_FROM_SERVER) {
-		/* Call out to the netfs to let it shrink the request to fit
-		 * its own I/O sizes and boundaries.  If it shinks it here, it
-		 * will be called again to make simultaneous calls; if it wants
-		 * to make serial calls, it can indicate a short read and then
-		 * we will call it again.
-		 */
-		if (rreq->origin != NETFS_DIO_READ) {
-			if (subreq->start >= ictx->zero_point) {
-				source = NETFS_FILL_WITH_ZEROES;
-				goto set;
-			}
-			if (subreq->len > ictx->zero_point - subreq->start)
-				subreq->len = ictx->zero_point - subreq->start;
-		}
-		if (subreq->len > rreq->i_size - subreq->start)
-			subreq->len = rreq->i_size - subreq->start;
-		if (rreq->rsize && subreq->len > rreq->rsize)
-			subreq->len = rreq->rsize;
-
-		if (rreq->netfs_ops->clamp_length &&
-		    !rreq->netfs_ops->clamp_length(subreq)) {
-			source = NETFS_INVALID_READ;
-			goto out;
-		}
-
-		if (rreq->io_streams[0].sreq_max_segs) {
-			lsize = netfs_limit_iter(io_iter, 0, subreq->len,
-						 rreq->io_streams[0].sreq_max_segs);
-			if (subreq->len > lsize) {
-				subreq->len = lsize;
-				trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
-			}
-		}
-	}
-
-set:
-	if (subreq->len > rreq->len)
-		pr_warn("R=%08x[%u] SREQ>RREQ %zx > %llx\n",
-			rreq->debug_id, subreq->debug_index,
-			subreq->len, rreq->len);
-
-	if (WARN_ON(subreq->len == 0)) {
-		source = NETFS_INVALID_READ;
-		goto out;
-	}
-
-	subreq->source = source;
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-
-	subreq->io_iter = *io_iter;
-	iov_iter_truncate(&subreq->io_iter, subreq->len);
-	iov_iter_advance(io_iter, subreq->len);
-out:
-	subreq->source = source;
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-	return source;
-}
-
-/*
- * Slice off a piece of a read request and submit an I/O request for it.
- */
-static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
-				    struct iov_iter *io_iter)
-{
-	struct netfs_io_subrequest *subreq;
-	enum netfs_io_source source;
-
-	subreq = netfs_alloc_subrequest(rreq);
-	if (!subreq)
-		return false;
-
-	subreq->start		= rreq->start + rreq->submitted;
-	subreq->len		= io_iter->count;
-
-	_debug("slice %llx,%zx,%llx", subreq->start, subreq->len, rreq->submitted);
-	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
-
-	/* Call out to the cache to find out what it can do with the remaining
-	 * subset.  It tells us in subreq->flags what it decided should be done
-	 * and adjusts subreq->len down if the subset crosses a cache boundary.
-	 *
-	 * Then when we hand the subset, it can choose to take a subset of that
-	 * (the starts must coincide), in which case, we go around the loop
-	 * again and ask it to download the next piece.
-	 */
-	source = netfs_rreq_prepare_read(rreq, subreq, io_iter);
-	if (source == NETFS_INVALID_READ)
-		goto subreq_failed;
-
-	atomic_inc(&rreq->nr_outstanding);
-
-	rreq->submitted += subreq->len;
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	switch (source) {
-	case NETFS_FILL_WITH_ZEROES:
-		netfs_fill_with_zeroes(rreq, subreq);
-		break;
-	case NETFS_DOWNLOAD_FROM_SERVER:
-		netfs_read_from_server(rreq, subreq);
-		break;
-	case NETFS_READ_FROM_CACHE:
-		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_IGNORE);
-		break;
-	default:
-		BUG();
-	}
-
-	return true;
-
-subreq_failed:
-	rreq->error = subreq->error;
-	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
-	return false;
-}
-
-/*
- * Begin the process of reading in a chunk of data, where that data may be
- * stitched together from multiple sources, including multiple servers and the
- * local cache.
- */
-int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
-{
-	struct iov_iter io_iter;
-	int ret;
-
-	_enter("R=%x %llx-%llx",
-	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
-
-	if (rreq->len == 0) {
-		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
-		return -EIO;
-	}
-
-	if (rreq->origin == NETFS_DIO_READ)
-		inode_dio_begin(rreq->inode);
-
-	// TODO: Use bounce buffer if requested
-	rreq->io_iter = rreq->iter;
-
-	INIT_WORK(&rreq->work, netfs_rreq_work);
-
-	/* Chop the read into slices according to what the cache and the netfs
-	 * want and submit each one.
-	 */
-	netfs_get_request(rreq, netfs_rreq_trace_get_for_outstanding);
-	atomic_set(&rreq->nr_outstanding, 1);
-	io_iter = rreq->io_iter;
-	do {
-		_debug("submit %llx + %llx >= %llx",
-		       rreq->start, rreq->submitted, rreq->i_size);
-		if (rreq->origin == NETFS_DIO_READ &&
-		    rreq->start + rreq->submitted >= rreq->i_size)
-			break;
-		if (!netfs_rreq_submit_slice(rreq, &io_iter))
-			break;
-		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
-		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
-			break;
-
-	} while (rreq->submitted < rreq->len);
-
-	if (!rreq->submitted) {
-		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
-		if (rreq->origin == NETFS_DIO_READ)
-			inode_dio_end(rreq->inode);
-		ret = 0;
-		goto out;
-	}
-
-	if (sync) {
-		/* Keep nr_outstanding incremented so that the ref always
-		 * belongs to us, and the service code isn't punted off to a
-		 * random thread pool to process.  Note that this might start
-		 * further work, such as writing to the cache.
-		 */
-		wait_var_event(&rreq->nr_outstanding,
-			       atomic_read(&rreq->nr_outstanding) == 1);
-		if (atomic_dec_and_test(&rreq->nr_outstanding))
-			netfs_rreq_assess(rreq, false);
-
-		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
-		wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS,
-			    TASK_UNINTERRUPTIBLE);
-
-		ret = rreq->error;
-		if (ret == 0 && rreq->submitted < rreq->len &&
-		    rreq->origin != NETFS_DIO_READ) {
-			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
-			ret = -EIO;
-		}
-	} else {
-		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
-		if (atomic_dec_and_test(&rreq->nr_outstanding))
-			netfs_rreq_assess(rreq, false);
-		ret = -EIOCBQUEUED;
-	}
-
-out:
-	return ret;
-}
+#endif
diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index b781bbbf1d8d..52b7a337e5cd 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -188,9 +188,59 @@ static size_t netfs_limit_xarray(const struct iov_iter *iter, size_t start_offse
 	return min(span, max_size);
 }
 
+/*
+ * Select the span of a sheaf iterator we're going to use.  Limit it by both
+ * maximum size and maximum number of segments.  Returns the size of the span
+ * in bytes.
+ */
+static size_t netfs_limit_sheaf(const struct iov_iter *iter, size_t start_offset,
+				size_t max_size, size_t max_segs)
+{
+	const struct sheaf *sheaf = iter->sheaf;
+	unsigned int nsegs = 0;
+	unsigned int slot = iter->sheaf_slot;
+	size_t span = 0, n = iter->count;
+
+	if (WARN_ON(!iov_iter_is_sheaf(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n == 0)
+		return 0;
+	max_size = umin(max_size, n - start_offset);
+
+	if (slot >= sheaf_nr_slots(sheaf)) {
+		sheaf = sheaf->next;
+		slot = 0;
+	}
+
+	start_offset += iter->iov_offset;
+	do {
+		size_t flen = sheaf_folio_size(sheaf, slot);
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
+		if (slot >= sheaf_nr_slots(sheaf)) {
+			sheaf = sheaf->next;
+			slot = 0;
+		}
+	} while (sheaf);
+
+	return umin(span, max_size);
+}
+
 size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 			size_t max_size, size_t max_segs)
 {
+	if (iov_iter_is_sheaf(iter))
+		return netfs_limit_sheaf(iter, start_offset, max_size, max_segs);
 	if (iov_iter_is_bvec(iter))
 		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
 	if (iov_iter_is_xarray(iter))
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 5f0f438e5d21..b28e601a8386 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -54,21 +54,20 @@ static int netfs_requests_seq_show(struct seq_file *m, void *v)
 
 	if (v == &netfs_io_requests) {
 		seq_puts(m,
-			 "REQUEST  OR REF FL ERR  OPS COVERAGE\n"
-			 "======== == === == ==== === =========\n"
+			 "REQUEST  OR REF FL ERR  COVERAGE\n"
+			 "======== == === == ==== =========\n"
 			 );
 		return 0;
 	}
 
 	rreq = list_entry(v, struct netfs_io_request, proc_link);
 	seq_printf(m,
-		   "%08x %s %3d %2lx %4d %3d @%04llx %llx/%llx",
+		   "%08x %s %3d %2lx %4d @%04llx %llx/%llx",
 		   rreq->debug_id,
 		   netfs_origins[rreq->origin],
 		   refcount_read(&rreq->ref),
 		   rreq->flags,
 		   rreq->error,
-		   atomic_read(&rreq->nr_outstanding),
 		   rreq->start, rreq->submitted, rreq->len);
 	seq_putc(m, '\n');
 	return 0;
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index d148a955fa55..a70d8d092401 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -40,7 +40,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	memset(rreq, 0, kmem_cache_size(cache));
 	rreq->start	= start;
 	rreq->len	= len;
-	rreq->upper_len	= len;
 	rreq->origin	= origin;
 	rreq->netfs_ops	= ctx->ops;
 	rreq->mapping	= mapping;
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
new file mode 100644
index 000000000000..c645fe5ba5b3
--- /dev/null
+++ b/fs/netfs/read_collect.c
@@ -0,0 +1,450 @@
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
+	WARN_ON_ONCE(subreq->len - subreq->transferred != iov_iter_count(&subreq->io_iter));
+	iov_iter_zero(iov_iter_count(&subreq->io_iter), &subreq->io_iter);
+}
+
+/*
+ * Flush, mark and unlock a folio that's now completely read.  If we want to
+ * cache the folio, we set the group to NETFS_FOLIO_COPY_TO_CACHE, mark it
+ * dirty and let writeback handle it.
+ */
+static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
+				    struct netfs_io_request *rreq,
+				    struct folio *folio)
+{
+	struct netfs_folio *finfo;
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
+				filemap_dirty_folio(folio->mapping, folio);
+			}
+		} else {
+			trace_netfs_folio(folio, netfs_folio_trace_read_done);
+		}
+	} else {
+		// TODO: Use of PG_private_2 is deprecated.
+		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
+			trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
+			folio_start_private_2(folio);
+		}
+	}
+
+	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
+		if (folio->index == rreq->no_unlock_folio &&
+		    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
+			_debug("no unlock");
+		else
+			folio_unlock(folio);
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
+	struct sheaf *sheaf = subreq->curr_sheaf;
+	size_t avail, prev_donated, next_donated, fsize, part;
+	loff_t fpos, start;
+	loff_t fend;
+	int slot = subreq->curr_sheaf_slot;
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
+	if (WARN_ON_ONCE(sheaf_slot_folio(sheaf, slot)->index != fpos / PAGE_SIZE)) {
+		printk("R=%08x[%x] s=%llx-%llx ctl=%zx/%zx/%zx sl=%u\n",
+		       rreq->debug_id, subreq->debug_index,
+		       subreq->start, subreq->start + subreq->transferred,
+		       subreq->consumed, subreq->transferred, subreq->len,
+		       slot);
+		printk("folio: %llx-%llx ix=%llx\n",
+		       fpos, fend - 1, folio_pos(sheaf_slot_folio(sheaf, slot)));
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
+			netfs_unlock_read_folio(subreq, rreq, sheaf_slot_folio(sheaf, slot));
+			if (subreq->consumed >= subreq->len)
+				goto remove_subreq;
+		} else if (fpos < start) {
+			size_t excess = fend - subreq->start;
+
+			spin_lock(&rreq->lock);
+			/* If we complete first on a folio split with the
+			 * preceding subreq, donate to that subreq - otherwise
+			 * we get the responsibility.
+			 */
+			if (subreq->prev_donated != prev_donated) {
+				spin_unlock(&rreq->lock);
+				goto donation_changed;
+			}
+
+			prev = list_prev_entry(subreq, rreq_link);
+			WRITE_ONCE(prev->next_donated, prev->next_donated + excess);
+			subreq->consumed = fend - subreq->start;
+			trace_netfs_donate(rreq, subreq, prev, excess,
+					   netfs_trace_donate_tail_to_prev);
+
+			if (subreq->consumed >= subreq->len)
+				goto remove_subreq_locked;
+			spin_unlock(&rreq->lock);
+		} else {
+			pr_err("fpos > start\n");
+			goto bad;
+		}
+
+		/* Advance the rolling buffer to the next folio. */
+		slot++;
+		if (slot >= sheaf_nr_slots(sheaf)) {
+			slot = 0;
+			sheaf = sheaf->next;
+			subreq->curr_sheaf = sheaf;
+		}
+		subreq->curr_sheaf_slot = slot;
+		if (sheaf && sheaf->slots[slot])
+			subreq->curr_folio_order = sheaf->orders[slot];
+		cond_resched();
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
+	spin_lock(&rreq->lock);
+
+	if (subreq->prev_donated != prev_donated ||
+	    subreq->next_donated != next_donated) {
+		spin_unlock(&rreq->lock);
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
+	if (!subreq->consumed) {
+		if (!prev_donated && !next_donated &&
+		    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
+			prev = list_prev_entry(subreq, rreq_link);
+			WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
+			trace_netfs_donate(rreq, subreq, prev, prev->next_donated + subreq->len,
+					   netfs_trace_donate_to_prev);
+			goto remove_subreq_locked;
+		}
+	}
+
+	if (!next_donated) {
+		size_t excess = subreq->len - subreq->consumed;
+
+		if (!subreq->consumed)
+			excess += prev_donated;
+
+		if (list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+			rreq->prev_donated = excess;
+			trace_netfs_donate(rreq, subreq, NULL, excess,
+					   netfs_trace_donate_to_deferred_next);
+		} else {
+			next = list_next_entry(subreq, rreq_link);
+			WRITE_ONCE(next->prev_donated, excess);
+			trace_netfs_donate(rreq, subreq, next, excess,
+					   netfs_trace_donate_to_next);
+		}
+		goto remove_subreq_locked;
+	}
+
+	spin_unlock(&rreq->lock);
+
+bad:
+	/* Errr... prev and next both donated to us, but insufficient to finish
+	 * the folio.
+	 */
+	printk("R=%08x[%x] s=%llx-%llx %zx/%zx/%zx\n",
+	       rreq->debug_id, subreq->debug_index,
+	       subreq->start, subreq->start + subreq->transferred,
+	       subreq->consumed, subreq->transferred, subreq->len);
+	printk("folio: %llx-%llx\n", fpos, fend - 1);
+	printk("donated: prev=%zx next=%zx\n", prev_donated, next_donated);
+	printk("s=%llx av=%zx part=%zx\n", start, avail, part);
+	BUG();
+
+remove_subreq:
+	spin_lock(&rreq->lock);
+remove_subreq_locked:
+	subreq->consumed = subreq->len;
+	list_del(&subreq->rreq_link);
+	spin_unlock(&rreq->lock);
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_consumed);
+	return true;
+}
+
+/*
+ * Release those waiting.
+ */
+static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
+{
+	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
+	netfs_clear_subrequests(rreq, was_async);
+}
+
+/*
+ * Determine how much we can admit to having read from a DIO read.
+ */
+static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	unsigned int i;
+	size_t transferred = 0;
+
+	for (i = 0; i < rreq->direct_bv_count; i++) {
+		flush_dcache_page(rreq->direct_bv[i].bv_page);
+		// TODO: cifs marks pages in the destination buffer
+		// dirty under some circumstances after a read.  Do we
+		// need to do that too?
+		set_page_dirty(rreq->direct_bv[i].bv_page);
+	}
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		if (subreq->error || subreq->transferred == 0)
+			break;
+		transferred += subreq->transferred;
+		if (subreq->transferred < subreq->len)
+			break;
+	}
+
+	for (i = 0; i < rreq->direct_bv_count; i++)
+		flush_dcache_page(rreq->direct_bv[i].bv_page);
+
+	rreq->transferred = transferred;
+
+	if (rreq->iocb) {
+		rreq->iocb->ki_pos += transferred;
+		if (rreq->iocb->ki_complete)
+			rreq->iocb->ki_complete(
+				rreq->iocb, rreq->error ? rreq->error : transferred);
+	}
+	if (rreq->netfs_ops->done)
+		rreq->netfs_ops->done(rreq);
+	inode_dio_end(rreq->inode);
+}
+
+/*
+ * Assess the state of a read request and decide what to do next.
+ *
+ * Note that we could be in an ordinary kernel thread, on a workqueue or in
+ * softirq context at this point.  We inherit a ref from the caller.
+ */
+static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
+{
+	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
+
+	//netfs_rreq_is_still_valid(rreq);
+
+	if (rreq->origin == NETFS_DIO_READ)
+		netfs_rreq_assess_dio(rreq);
+	task_io_account_read(rreq->transferred);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
+	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
+
+	netfs_rreq_completed(rreq, was_async);
+}
+
+static void netfs_rreq_work(struct work_struct *work)
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
+	netfs_rreq_assess(rreq, false);
+}
+
+/*
+ * Handle the completion of all outstanding I/O operations on a read request.
+ * We inherit a ref from the caller.
+ */
+static void netfs_rreq_terminated(struct netfs_io_request *rreq, bool was_async)
+{
+	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
+	    was_async) {
+		INIT_WORK(&rreq->work, netfs_rreq_work);
+		if (!queue_work(system_unbound_wq, &rreq->work))
+			BUG();
+	} else {
+		netfs_rreq_assess(rreq, was_async);
+	}
+}
+
+/**
+ * netfs_read_subreq_progress - Note progress of a read operation.
+ * @subreq: The read request that has terminated.
+ * @error: Completion code or -EAGAIN if just a progress update.
+ * @was_async: The termination was asynchronous
+ *
+ * This tells the read side of netfs lib that a contributory I/O operation has
+ * made progress, one way or another, and that it may be possible to unlock
+ * some folios.
+ *
+ * The caller indicates in @error the state of the operation, supplying 0 to
+ * indicate successful completion of the operation, -EINPROGRESS to indicate
+ * that the operation is still ongoing or some other negative error code on
+ * failure.  The helper will look after reissuing I/O operations as appropriate
+ * and writing downloaded data to the cache.
+ *
+ * The filesystem should update subreq->transferred to track the amount of data
+ * copied into the output buffer.
+ *
+ * If @was_async is true, the caller might be running in softirq or interrupt
+ * context and we can't sleep.
+ */
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
+				int error, bool was_async)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	/* If the read completed validly short, then we can clear the tail
+	 * before going on to unlock the folios.
+	 */
+	if (error == 0 && subreq->transferred < subreq->len &&
+	    test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
+		netfs_clear_unread(subreq);
+		subreq->transferred = subreq->len;
+	}
+
+	if (subreq->transferred > subreq->consumed) {
+		if (rreq->origin != NETFS_DIO_READ)
+			netfs_consume_read_data(subreq, was_async);
+		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+	}
+
+	/* If we had progress, but not completion, then we're done for now. */
+	if (error == -EINPROGRESS)
+		return;
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
+	if (subreq->transferred < subreq->len) {
+		__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
+		set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags))
+			error = -ENODATA;
+	}
+
+	subreq->error = error;
+	if (error < 0) {
+		trace_netfs_failure(rreq, subreq, error, netfs_fail_read);
+		if (subreq->source == NETFS_READ_FROM_CACHE) {
+			netfs_stat(&netfs_n_rh_read_failed);
+			set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+		} else {
+			netfs_stat(&netfs_n_rh_download_failed);
+			set_bit(NETFS_RREQ_FAILED, &rreq->flags);
+			rreq->error = subreq->error;
+		}
+	} else {
+		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+	}
+
+	rreq->transferred += subreq->transferred;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
+
+	if (list_empty(&rreq->subrequests))
+		netfs_rreq_terminated(rreq, was_async);
+
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+}
+EXPORT_SYMBOL(netfs_read_subreq_progress);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index fb92dd8160f3..413199617476 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -158,10 +158,6 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 
 	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
 
-	trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
-			     refcount_read(&subreq->ref),
-			     netfs_sreq_trace_new);
-
 	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
 	stream->sreq_max_len	= UINT_MAX;
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index ddc1ee031955..6d7d04c9eff6 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -286,15 +286,7 @@ static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sre
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
-static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
+static ssize_t nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 {
 	struct nfs_netfs_io_data	*netfs;
 	struct nfs_pageio_descriptor	pgio;
@@ -302,17 +294,26 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 	struct nfs_open_context *ctx = sreq->rreq->netfs_priv;
 	struct page *page;
 	unsigned long idx;
+	pgoff_t start, last;
+	ssize_t len;
 	int err;
-	pgoff_t start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
-	pgoff_t last = ((sreq->start + sreq->len -
-			 sreq->transferred - 1) >> PAGE_SHIFT);
+	
+	err = netfs_prepare_read_iterator(sreq, NFS_SB(sreq->rreq->inode->i_sb)->rsize, 0);
+	if (err < 0)
+		return err;
+
+	len = sreq->len;
+	start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
+	last = ((sreq->start + len - sreq->transferred - 1) >> PAGE_SHIFT);
 
 	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
 	netfs = nfs_netfs_alloc(sreq);
-	if (!netfs)
-		return netfs_subreq_terminated(sreq, -ENOMEM, false);
+	if (!netfs) {
+		netfs_read_subreq_progress(sreq, -ENOMEM, false);
+		return -ENOMEM;
+	}
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
@@ -327,6 +328,7 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 out:
 	nfs_pageio_complete_read(&pgio);
 	nfs_netfs_put(netfs);
+	return len;
 }
 
 void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr)
@@ -377,5 +379,4 @@ const struct netfs_request_ops nfs_netfs_ops = {
 	.init_request		= nfs_netfs_init_request,
 	.free_request		= nfs_netfs_free_request,
 	.issue_read		= nfs_netfs_issue_read,
-	.clamp_length		= nfs_netfs_clamp_length
 };
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index fbed0027996f..20c1d73085cd 100644
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
+	netfs_read_subreq_progress(netfs->sreq, netfs->error, false);
 	kfree(netfs);
 }
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 595c4b673707..ff7f95395239 100644
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
+	netfs_read_subreq_progress(&rdata->subreq, rdata->result, false);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4732c63f7531..f3be9444465a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/mm.h>
+#include <linux/sheaf.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
@@ -125,22 +126,21 @@ static void cifs_issue_write(struct netfs_io_subrequest *subreq)
 }
 
 /*
- * Split the read up according to how many credits we can get for each piece.
- * It's okay to sleep here if we need to wait for more credit to become
- * available.
- *
- * We also choose the server and allocate an operation ID to be cleaned up
- * later.
+ * Issue a read operation on behalf of the netfs helper functions.  We're asked
+ * to make a read of a certain size at a point in the file.  We are permitted
+ * to only read a portion of that, but as long as we read something, the netfs
+ * helper will call us again so that we can issue another read.
  */
-static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
+static ssize_t cifs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_io_stream *stream = &rreq->io_streams[subreq->stream_nr];
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
 	struct TCP_Server_Info *server = req->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	int rc;
+	unsigned int max_segs = 0;
+	size_t rsize, len;
+	int rc = 0;
 
 	rdata->xid = get_xid();
 	rdata->have_xid = true;
@@ -153,52 +153,48 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 
 
 	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
-					   &stream->sreq_max_len, &rdata->credits);
-	if (rc) {
-		subreq->error = rc;
-		return false;
-	}
+					   &rsize, &rdata->credits);
+	if (rc)
+		goto failed;
 
-	subreq->len = umin(subreq->len, stream->sreq_max_len);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->smbd_conn)
-		stream->sreq_max_segs = server->smbd_conn->max_frmr_depth;
+		max_segs = server->smbd_conn->max_frmr_depth;
 #endif
-	return true;
-}
 
-/*
- * Issue a read operation on behalf of the netfs helper functions.  We're asked
- * to make a read of a certain size at a point in the file.  We are permitted
- * to only read a portion of that, but as long as we read something, the netfs
- * helper will call us again so that we can issue another read.
- */
-static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
-	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	int rc = 0;
+	len = netfs_prepare_read_iterator(subreq, rsize, max_segs);
+	if (len < 0) {
+		rc = len;
+		goto failed;
+	}
 
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
 		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
-		 subreq->transferred, subreq->len);
+		 subreq->transferred, len);
+
+	rc = adjust_credits(server, &rdata->credits, len);
+	if (rc)
+		goto failed;
 
 	if (req->cfile->invalidHandle) {
 		do {
 			rc = cifs_reopen_file(req->cfile, true);
 		} while (rc == -EAGAIN);
 		if (rc)
-			goto out;
+			goto failed;
 	}
 
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	rc = rdata->server->ops->async_readv(rdata);
-out:
 	if (rc)
-		netfs_subreq_terminated(subreq, rc, false);
+		goto failed;
+	return len;
+
+failed:
+	netfs_read_subreq_progress(subreq, rc, false);
+	return rc;
 }
 
 /*
@@ -326,8 +322,7 @@ const struct netfs_request_ops cifs_req_ops = {
 	.free_request		= cifs_free_request,
 	.free_subrequest	= cifs_free_subrequest,
 	.expand_readahead	= cifs_expand_readahead,
-	.clamp_length		= cifs_clamp_length,
-	.issue_read		= cifs_req_issue_read,
+	.issue_read		= cifs_issue_read,
 	.done			= cifs_rreq_done,
 	.begin_writeback	= cifs_begin_writeback,
 	.prepare_write		= cifs_prepare_write,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2ae2dbb6202b..14988281cce6 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4489,9 +4489,7 @@ static void smb2_readv_worker(struct work_struct *work)
 	struct cifs_io_subrequest *rdata =
 		container_of(work, struct cifs_io_subrequest, subreq.work);
 
-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result == 0 || rdata->result == -EAGAIN) ?
-				rdata->got_bytes : rdata->result, true);
+	netfs_read_subreq_progress(&rdata->subreq, rdata->result, false);
 }
 
 static void
@@ -4538,6 +4536,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
 		rdata->result = -EAGAIN;
 		if (server->sign && rdata->got_bytes)
 			/* reset bytes number since we can not check a sign */
@@ -4588,6 +4587,8 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			rdata->result = 0;
 	}
 	rdata->credits.value = 0;
+	rdata->subreq.transferred += rdata->got_bytes;
+	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
@@ -4838,6 +4839,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 				      wdata->subreq.start, wdata->subreq.len);
 
 	wdata->credits.value = 0;
+	trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_progress);
 	cifs_write_subrequest_terminated(wdata, result ?: written, true);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b880687bb932..6987c2c02074 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -183,12 +183,18 @@ struct netfs_io_subrequest {
 	unsigned long long	start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
+	size_t			consumed;	/* Amount of read data consumed */
+	unsigned int		prev_donated;	/* Amount of data donated from previous subreq */
+	unsigned int		next_donated;	/* Amount of data donated from next subreq */
 	refcount_t		ref;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
 	unsigned int		nr_segs;	/* Number of segs in io_iter */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* I/O stream this belongs to */
+	unsigned char		curr_sheaf_slot; /* Folio currently being read */
+	unsigned char		curr_folio_order; /* Order of folio */
+	struct sheaf		*curr_sheaf;	/* Sheaf in which current folio resides */
 	unsigned long		flags;
 #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
@@ -229,6 +235,7 @@ struct netfs_io_request {
 	struct address_space	*mapping;	/* The mapping being accessed */
 	struct kiocb		*iocb;		/* AIO completion vector */
 	struct netfs_cache_resources cache_resources;
+	struct readahead_control *ractl;	/* Readahead descriptor */
 	struct list_head	proc_link;	/* Link in netfs_iorequests */
 	struct list_head	subrequests;	/* Contributory I/O operations */
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
@@ -248,9 +255,6 @@ struct netfs_io_request {
 	atomic_t		subreq_counter;	/* Next subreq->debug_index */
 	unsigned int		nr_group_rel;	/* Number of refs to release on ->group */
 	spinlock_t		lock;		/* Lock for queuing subreqs */
-	atomic_t		nr_outstanding;	/* Number of ops in progress */
-	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
-	size_t			upper_len;	/* Length can be extended to here */
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
@@ -265,6 +269,7 @@ struct netfs_io_request {
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
+	unsigned int		prev_donated;	/* Fallback for subreq->prev_donated */
 	refcount_t		ref;
 	unsigned long		flags;
 #define NETFS_RREQ_INCOMPLETE_IO	0	/* Some ioreqs terminated short or with error */
@@ -298,8 +303,7 @@ struct netfs_request_ops {
 
 	/* Read request handling */
 	void (*expand_readahead)(struct netfs_io_request *rreq);
-	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
-	void (*issue_read)(struct netfs_io_subrequest *subreq);
+	ssize_t (*issue_read)(struct netfs_io_subrequest *subreq);
 	bool (*is_still_valid)(struct netfs_io_request *rreq);
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 				 struct folio **foliop, void **_fsdata);
@@ -428,7 +432,10 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
 
 /* (Sub)request management API. */
-void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
+ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq, size_t rsize,
+				    unsigned int max_segs);
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
+				int error, bool was_async);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 64238a64ae5f..6d3403880e0b 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -68,10 +68,14 @@
 	E_(NETFS_INVALID_WRITE,			"INVL")
 
 #define netfs_sreq_traces					\
+	EM(netfs_sreq_trace_added,		"ADD  ")	\
 	EM(netfs_sreq_trace_discard,		"DSCRD")	\
+	EM(netfs_sreq_trace_donate_to_prev,	"DON-P")	\
+	EM(netfs_sreq_trace_donate_to_next,	"DON-N")	\
 	EM(netfs_sreq_trace_download_instead,	"RDOWN")	\
 	EM(netfs_sreq_trace_fail,		"FAIL ")	\
 	EM(netfs_sreq_trace_free,		"FREE ")	\
+	EM(netfs_sreq_trace_io_progress,	"IO   ")	\
 	EM(netfs_sreq_trace_limited,		"LIMIT")	\
 	EM(netfs_sreq_trace_prepare,		"PREP ")	\
 	EM(netfs_sreq_trace_prep_failed,	"PRPFL")	\
@@ -117,7 +121,7 @@
 	EM(netfs_sreq_trace_new,		"NEW        ")	\
 	EM(netfs_sreq_trace_put_cancel,		"PUT CANCEL ")	\
 	EM(netfs_sreq_trace_put_clear,		"PUT CLEAR  ")	\
-	EM(netfs_sreq_trace_put_discard,	"PUT DISCARD")	\
+	EM(netfs_sreq_trace_put_consumed,	"PUT CONSUME")	\
 	EM(netfs_sreq_trace_put_done,		"PUT DONE   ")	\
 	EM(netfs_sreq_trace_put_failed,		"PUT FAILED ")	\
 	EM(netfs_sreq_trace_put_merged,		"PUT MERGED ")	\
@@ -151,7 +155,10 @@
 	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_not_under_wback,	"!wback")	\
+	EM(netfs_folio_trace_read,		"read")		\
+	EM(netfs_folio_trace_read_done,		"read-done")	\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
+	EM(netfs_folio_trace_read_put,		"read-put")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\
 	EM(netfs_folio_trace_store_copy,	"store-copy")	\
@@ -164,6 +171,12 @@
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
 
@@ -181,6 +194,7 @@ enum netfs_rreq_ref_trace { netfs_rreq_ref_traces } __mode(byte);
 enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
 enum netfs_folio_trace { netfs_folio_traces } __mode(byte);
 enum netfs_collect_contig_trace { netfs_collect_contig_traces } __mode(byte);
+enum netfs_donate_trace { netfs_donate_traces } __mode(byte);
 
 #endif
 
@@ -203,6 +217,7 @@ netfs_rreq_ref_traces;
 netfs_sreq_ref_traces;
 netfs_folio_traces;
 netfs_collect_contig_traces;
+netfs_donate_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -651,6 +666,71 @@ TRACE_EVENT(netfs_collect_stream,
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
+		    __entry->slot	= subreq->curr_sheaf_slot;
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


