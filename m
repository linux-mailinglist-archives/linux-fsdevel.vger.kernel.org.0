Return-Path: <linux-fsdevel+bounces-47135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186AAA99ADE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 23:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC284634C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0FC1FAC42;
	Wed, 23 Apr 2025 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+SydmWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA11F4CA9
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745444306; cv=none; b=MEWmgwmvX8PLKpjLdaoaRh+5khdt0w/A9mvsT5gIYZfdyi1+wXXdujO4xB6MB8bTov1fwATmhRIFJdNwtPEyA4YsxJxLG7RGKBViZ19zdgHGk9QgSULa7uylac7VkolBtqPsDoM5e+RZiT+607OSwEklSTZVq7kh8Ckp6JWn3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745444306; c=relaxed/simple;
	bh=85K7WyKA6eInPZo30SkvbjtkfWHLB5MYQ14pOW006/I=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=cx9SR5SdcHGjmcUgiemdl75O+c3ebywafWBO5/HNWSUzOyryJiiIOpIAamN9jzOZfYMS0sOOP4jcElWC8laZVhKLmJ/hNl70duPjdkxTeubemJ1PsaQPpZsBS2bBOK4WY43NThhkLyYWkL3+RV+Myu9zZ3+jdy03qdwQ9FRggGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+SydmWD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745444303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LEFv/2djugy/485D1mjGAOQrvD7ihlWo25kKbig3wqA=;
	b=P+SydmWDToWnIQugzT0j7N5uodrXTUz4jKrl9D2+J62LfdVCIxyo3NolLDer1Xh328s2C8
	EaEP8v8y2UJ2MAwh5DFTSwcZpuYf3R5PXuzw5Hh2ICD/jugi7aRt6lyts14fBOmhiD/kyS
	PZtJAGMO6pcAAydKH8tzV7PVq2cOY1o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-4wzLRlAeMHmVvBUcOOVGyA-1; Wed,
 23 Apr 2025 17:38:17 -0400
X-MC-Unique: 4wzLRlAeMHmVvBUcOOVGyA-1
X-Mimecast-MFC-AGG-ID: 4wzLRlAeMHmVvBUcOOVGyA_1745444295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D35601800446;
	Wed, 23 Apr 2025 21:38:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C45CC1800873;
	Wed, 23 Apr 2025 21:38:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Paulo Alcantara <pc@manguebit.com>
cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix undifferentiation of DIO reads from unbuffered reads
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3064918.1745444289.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Apr 2025 22:38:09 +0100
Message-ID: <3064919.1745444289@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On cifs, "DIO reads" (specified by O_DIRECT) need to be differentiated fro=
m
"unbuffered reads" (specified by cache=3Dnone in the mount parameters).  T=
he
difference is flagged in the protocol and the server may behave
differently: Windows Server will, for example, mandate that DIO reads are
block aligned.

Fix this by adding a NETFS_UNBUFFERED_READ to differentiate this from
NETFS_DIO_READ, parallelling the write differentiation that already exists=
.

A further patch will be required to make cifs do something different,
depending on the rreq->origin set.

Fixes: 016dc8516aec ("netfs: Implement unbuffered/DIO read support")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c             |    3 ++-
 fs/afs/write.c               |    1 +
 fs/ceph/addr.c               |    4 +++-
 fs/netfs/direct_read.c       |    3 ++-
 fs/netfs/main.c              |    1 +
 fs/netfs/misc.c              |    1 +
 fs/netfs/objects.c           |    1 +
 fs/netfs/read_collect.c      |    7 +++++--
 fs/nfs/fscache.c             |    1 +
 fs/smb/client/file.c         |    3 ++-
 include/linux/netfs.h        |    1 +
 include/trace/events/netfs.h |    1 +
 12 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index b5a4a28e0fe7..e4420591cf35 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -77,7 +77,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *=
subreq)
 =

 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
-	if (subreq->rreq->origin !=3D NETFS_DIO_READ)
+	if (subreq->rreq->origin !=3D NETFS_UNBUFFERED_READ &&
+	    subreq->rreq->origin !=3D NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	if (pos + total >=3D i_size_read(rreq->inode))
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 7df7b2f5e7b2..2e7526ea883a 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -202,6 +202,7 @@ void afs_retry_request(struct netfs_io_request *wreq, =
struct netfs_io_stream *st
 	case NETFS_READ_GAPS:
 	case NETFS_READ_SINGLE:
 	case NETFS_READ_FOR_WRITE:
+	case NETFS_UNBUFFERED_READ:
 	case NETFS_DIO_READ:
 		return;
 	default:
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 557c326561fd..b95c4cb21c13 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -238,6 +238,7 @@ static void finish_netfs_read(struct ceph_osd_request =
*req)
 		if (sparse && err > 0)
 			err =3D ceph_sparse_ext_map_end(op);
 		if (err < subreq->len &&
+		    subreq->rreq->origin !=3D NETFS_UNBUFFERED_READ &&
 		    subreq->rreq->origin !=3D NETFS_DIO_READ)
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 		if (IS_ENCRYPTED(inode) && err > 0) {
@@ -281,7 +282,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io=
_subrequest *subreq)
 	size_t len;
 	int mode;
 =

-	if (rreq->origin !=3D NETFS_DIO_READ)
+	if (rreq->origin !=3D NETFS_UNBUFFERED_READ &&
+	    rreq->origin !=3D NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 =

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a24e63d2c818..9902766195d7 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -188,7 +188,8 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb=
 *iocb, struct iov_iter *i
 =

 	rreq =3D netfs_alloc_request(iocb->ki_filp->f_mapping, iocb->ki_filp,
 				   iocb->ki_pos, orig_count,
-				   NETFS_DIO_READ);
+				   iocb->ki_flags & IOCB_DIRECT ?
+				   NETFS_DIO_READ : NETFS_UNBUFFERED_READ);
 	if (IS_ERR(rreq))
 		return PTR_ERR(rreq);
 =

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 70ecc8f5f210..3db401d269e7 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -39,6 +39,7 @@ static const char *netfs_origins[nr__netfs_io_origin] =3D=
 {
 	[NETFS_READ_GAPS]		=3D "RG",
 	[NETFS_READ_SINGLE]		=3D "R1",
 	[NETFS_READ_FOR_WRITE]		=3D "RW",
+	[NETFS_UNBUFFERED_READ]		=3D "UR",
 	[NETFS_DIO_READ]		=3D "DR",
 	[NETFS_WRITEBACK]		=3D "WB",
 	[NETFS_WRITEBACK_SINGLE]	=3D "W1",
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 77e7f7c79d27..43b67a28a8fa 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -461,6 +461,7 @@ static ssize_t netfs_wait_for_request(struct netfs_io_=
request *rreq,
 		case NETFS_DIO_READ:
 		case NETFS_DIO_WRITE:
 		case NETFS_READ_SINGLE:
+		case NETFS_UNBUFFERED_READ:
 		case NETFS_UNBUFFERED_WRITE:
 			break;
 		default:
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index d3eb9ba3013a..31fa0c81e2a4 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -59,6 +59,7 @@ struct netfs_io_request *netfs_alloc_request(struct addr=
ess_space *mapping,
 	    origin =3D=3D NETFS_READ_GAPS ||
 	    origin =3D=3D NETFS_READ_SINGLE ||
 	    origin =3D=3D NETFS_READ_FOR_WRITE ||
+	    origin =3D=3D NETFS_UNBUFFERED_READ ||
 	    origin =3D=3D NETFS_DIO_READ) {
 		INIT_WORK(&rreq->work, netfs_read_collection_worker);
 		rreq->io_streams[0].avail =3D true;
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 900dd51c3b94..bad677e58a42 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -342,7 +342,8 @@ static void netfs_rreq_assess_dio(struct netfs_io_requ=
est *rreq)
 {
 	unsigned int i;
 =

-	if (rreq->origin =3D=3D NETFS_DIO_READ) {
+	if (rreq->origin =3D=3D NETFS_UNBUFFERED_READ ||
+	    rreq->origin =3D=3D NETFS_DIO_READ) {
 		for (i =3D 0; i < rreq->direct_bv_count; i++) {
 			flush_dcache_page(rreq->direct_bv[i].bv_page);
 			// TODO: cifs marks pages in the destination buffer
@@ -360,7 +361,8 @@ static void netfs_rreq_assess_dio(struct netfs_io_requ=
est *rreq)
 	}
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);
-	if (rreq->origin =3D=3D NETFS_DIO_READ)
+	if (rreq->origin =3D=3D NETFS_UNBUFFERED_READ ||
+	    rreq->origin =3D=3D NETFS_DIO_READ)
 		inode_dio_end(rreq->inode);
 }
 =

@@ -416,6 +418,7 @@ bool netfs_read_collection(struct netfs_io_request *rr=
eq)
 	//netfs_rreq_is_still_valid(rreq);
 =

 	switch (rreq->origin) {
+	case NETFS_UNBUFFERED_READ:
 	case NETFS_DIO_READ:
 	case NETFS_READ_GAPS:
 		netfs_rreq_assess_dio(rreq);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index e278a1ad1ca3..8b0785178731 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -367,6 +367,7 @@ void nfs_netfs_read_completion(struct nfs_pgio_header =
*hdr)
 =

 	sreq =3D netfs->sreq;
 	if (test_bit(NFS_IOHDR_EOF, &hdr->flags) &&
+	    sreq->rreq->origin !=3D NETFS_UNBUFFERED_READ &&
 	    sreq->rreq->origin !=3D NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &sreq->flags);
 =

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 3bd34d2b98d0..76f91ce6b29b 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -219,7 +219,8 @@ static void cifs_issue_read(struct netfs_io_subrequest=
 *subreq)
 			goto failed;
 	}
 =

-	if (subreq->rreq->origin !=3D NETFS_DIO_READ)
+	if (subreq->rreq->origin !=3D NETFS_UNBUFFERED_READ &&
+	    subreq->rreq->origin !=3D NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 =

 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c3f230732f51..1464b3a10498 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -206,6 +206,7 @@ enum netfs_io_origin {
 	NETFS_READ_GAPS,		/* This read is a synchronous read to fill gaps */
 	NETFS_READ_SINGLE,		/* This read should be treated as a single object */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
+	NETFS_UNBUFFERED_READ,		/* This is an unbuffered read */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
 	NETFS_WRITEBACK_SINGLE,		/* This monolithic write was triggered by write=
pages */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 402c5e82e7b8..4175eec40048 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -39,6 +39,7 @@
 	EM(NETFS_READ_GAPS,			"RG")		\
 	EM(NETFS_READ_SINGLE,			"R1")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
+	EM(NETFS_UNBUFFERED_READ,		"UR")		\
 	EM(NETFS_DIO_READ,			"DR")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
 	EM(NETFS_WRITEBACK_SINGLE,		"W1")		\


