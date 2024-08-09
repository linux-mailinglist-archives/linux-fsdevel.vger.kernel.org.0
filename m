Return-Path: <linux-fsdevel+bounces-25526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6F94D1B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3741FB20CD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636BF195FE8;
	Fri,  9 Aug 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeHnQHWG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D1194A48
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211786; cv=none; b=TG317739Izf9rRuMXYceazWUL1xI/ZyNANXBmKYXZ+WgCpA7OfD6uVESWEUrjL1yE2fzAm16gyMpjj7sSk+RSpTbn+bs2OZJwjMGjJ5yO6C+wjqqMgMZ2Tj9muRaGrE5cs3nzHQuvbjsZk2+a9EFcMtb7Ca/NZGTZREoxV+NWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211786; c=relaxed/simple;
	bh=GLNnkj1oYbZiZy4j5Eu0TSV+NeDFNL5rcs9PdWBpS6M=;
	h=To:cc:Subject:MIME-Version:Content-Type:From:Date:Message-ID; b=Qxz5Jnr9ViDvoI51L/vHG4H/JmHU/RwGok/5yNUSyjhZNg8eTTn20xItJcCgHfu/NLftMZiNVemLQ66q2joo7sczaqUwAHWUN+uTVlLKjOBOFwmL+RfafPrOF0NmOqpwqYUVAhN1dnEb2a/bButYm5adHvYvrJGdAL3cGFPAtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeHnQHWG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723211784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=apin+9jgzFuDXSZ4CuNnU6Ut/Wa48SE7YgICxGZt4k8=;
	b=NeHnQHWGVMFzG3r+XmI2e6CD+zgCch2xZ813EI3rwl3sifN2dtkiYWMURDTziyqLtbaW8G
	rYuV1YA9AD4KKzBNlETCIWQDvqnlgJkK7iYwcCAw7UKtDg8f+vweAoIjqp+kZ3kcijWxBe
	Y9Di34X+kHfqctQ96vN4sWy+OJnD62w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-65E9MiYgO2Ox1Cz4ptHNCA-1; Fri,
 09 Aug 2024 09:56:20 -0400
X-MC-Unique: 65E9MiYgO2Ox1Cz4ptHNCA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 589471944B2C;
	Fri,  9 Aug 2024 13:56:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E820F300018D;
	Fri,  9 Aug 2024 13:56:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
To: Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>
cc: dhowells@redhat.com, Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Ilya Dryomov <idryomov@gmail.com>, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev,
    linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: Fix DIO read through netfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1229143.1723211707.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Fri, 09 Aug 2024 14:56:09 +0100
Message-ID: <1229195.1723211769@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Dominique Martinet <asmadeus@codewreck.org>

9p: Fix DIO read through netfs

If a program is watching a file on a 9p mount, it won't see any change in
size if the file being exported by the server is changed directly in the
source filesystem, presumably because 9p doesn't have change notifications=
,
and because netfs skips the reads if the file is empty.

Fix this by attempting to read the full size specified when a DIO read is
requested (such as when 9p is operating in unbuffered mode) and dealing
with a short read if the EOF was less than the expected read.

To make this work, filesystems using netfslib must not set
NETFS_SREQ_CLEAR_TAIL if performing a DIO read where that read hit the EOF=
.
I don't want to mandatorily clear this flag in netfslib for DIO because,
say, ceph might make a read from an object that is not completely filled,
but does not reside at the end of file - and so we need to clear the
excess.

This can be tested by watching an empty file over 9p within a VM (such as
in the ktest framework):

        while true; do read content; if [ -n "$content" ]; then echo $cont=
ent; break; fi; done < /host/tmp/foo

then writing something into the empty file.  The watcher should immediatel=
y
display the file content and break out of the loop.  Without this fix, it
remains in the loop indefinitely.

Fixes: 80105ed2fd27 ("9p: Use netfslib read/write_iter")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218916
Written-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c     |    3 ++-
 fs/afs/file.c        |    3 ++-
 fs/ceph/addr.c       |    6 ++++--
 fs/netfs/io.c        |   17 +++++++++++------
 fs/nfs/fscache.c     |    3 ++-
 fs/smb/client/file.c |    3 ++-
 6 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a97ceb105cd8..24fdc74caeba 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -75,7 +75,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *=
subreq)
 =

 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (subreq->rreq->origin !=3D NETFS_DIO_READ)
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 =

 	netfs_subreq_terminated(subreq, err ?: total, false);
 }
diff --git a/fs/afs/file.c b/fs/afs/file.c
index c3f0c45ae9a9..ec1be0091fdb 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -242,7 +242,8 @@ static void afs_fetch_data_notify(struct afs_operation=
 *op)
 =

 	req->error =3D error;
 	if (subreq) {
-		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		if (subreq->rreq->origin !=3D NETFS_DIO_READ)
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 		netfs_subreq_terminated(subreq, error ?: req->actual_len, false);
 		req->subreq =3D NULL;
 	} else if (req->done) {
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index cc0a2240de98..c4744a02db75 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -246,7 +246,8 @@ static void finish_netfs_read(struct ceph_osd_request =
*req)
 	if (err >=3D 0) {
 		if (sparse && err > 0)
 			err =3D ceph_sparse_ext_map_end(op);
-		if (err < subreq->len)
+		if (err < subreq->len &&
+		    subreq->rreq->origin !=3D NETFS_DIO_READ)
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 		if (IS_ENCRYPTED(inode) && err > 0) {
 			err =3D ceph_fscrypt_decrypt_extents(inode,
@@ -282,7 +283,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io=
_subrequest *subreq)
 	size_t len;
 	int mode;
 =

-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (rreq->origin !=3D NETFS_DIO_READ)
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 =

 	if (subreq->start >=3D inode->i_size)
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index c179a1c73fa7..5367caf3fa28 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -530,7 +530,8 @@ void netfs_subreq_terminated(struct netfs_io_subreques=
t *subreq,
 =

 	if (transferred_or_error =3D=3D 0) {
 		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
-			subreq->error =3D -ENODATA;
+			if (rreq->origin !=3D NETFS_DIO_READ)
+				subreq->error =3D -ENODATA;
 			goto failed;
 		}
 	} else {
@@ -601,9 +602,14 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq=
,
 			}
 			if (subreq->len > ictx->zero_point - subreq->start)
 				subreq->len =3D ictx->zero_point - subreq->start;
+
+			/* We limit buffered reads to the EOF, but let the
+			 * server deal with larger-than-EOF DIO/unbuffered
+			 * reads.
+			 */
+			if (subreq->len > rreq->i_size - subreq->start)
+				subreq->len =3D rreq->i_size - subreq->start;
 		}
-		if (subreq->len > rreq->i_size - subreq->start)
-			subreq->len =3D rreq->i_size - subreq->start;
 		if (rreq->rsize && subreq->len > rreq->rsize)
 			subreq->len =3D rreq->rsize;
 =

@@ -739,11 +745,10 @@ int netfs_begin_read(struct netfs_io_request *rreq, =
bool sync)
 	do {
 		_debug("submit %llx + %llx >=3D %llx",
 		       rreq->start, rreq->submitted, rreq->i_size);
-		if (rreq->origin =3D=3D NETFS_DIO_READ &&
-		    rreq->start + rreq->submitted >=3D rreq->i_size)
-			break;
 		if (!netfs_rreq_submit_slice(rreq, &io_iter))
 			break;
+		if (test_bit(NETFS_SREQ_NO_PROGRESS, &rreq->flags))
+			break;
 		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
 		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
 			break;
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index bf29a65c5027..7a558dea75c4 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -363,7 +363,8 @@ void nfs_netfs_read_completion(struct nfs_pgio_header =
*hdr)
 		return;
 =

 	sreq =3D netfs->sreq;
-	if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
+	if (test_bit(NFS_IOHDR_EOF, &hdr->flags) &&
+	    sreq->rreq->origin !=3D NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &sreq->flags);
 =

 	if (hdr->error)
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b2405dd4d4d4..3f3842e7b44a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -217,7 +217,8 @@ static void cifs_req_issue_read(struct netfs_io_subreq=
uest *subreq)
 			goto out;
 	}
 =

-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (subreq->rreq->origin !=3D NETFS_DIO_READ)
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 =

 	rc =3D rdata->server->ops->async_readv(rdata);
 out:


