Return-Path: <linux-fsdevel+bounces-57961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A22B27105
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 23:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3626B5C1EA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A4274FFC;
	Thu, 14 Aug 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeoQYAyF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E491EB1A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207967; cv=none; b=RUZeWXWK49gmHGT7BAONiJN26Ibnqw89l9Jkfc5nGfMLJD2sXRJtLi/xGsju0nvlKx8mlBDOlcSyrzr8lYlMeXCkzhlAo6ZrgOVI3LPD//0gGoNehe4nA/PPzIEn1gWE1tulngjd8w+C5kQYftT7rMXhZmAoN8wZDu5ypQYQGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207967; c=relaxed/simple;
	bh=V6wXdJLrBZ8RcJqkcHRG6ySv0M1Vq3mIHeW4kuR3MGc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=CZSNFT0hFOl70pibqKgcRYiktiuu3Ddai7HZvZTmb7/EYfWlFhFH954KzNq9tnLfikTNSKVOiwvoIl5Im74gDiZqs9m36FRCzbQf3KY9PBV4aGjARAXGXwjrnJywtby8yIef7zukt18mm4x1ZsnxgknmXALThIPK6AWKmkXdwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeoQYAyF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755207962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hMrmnnaTuE7E24vkMuvtxjjxa9pOJBVXm+5edbNayAI=;
	b=IeoQYAyFMoZxz3jWbLVM6OvK3VqoTscAz+IuReRDHdoG0lPzLO0YfGIE6AZgnGe6lw0rVh
	Kzk+acqACKRwBChlETzclDIkoTKnvneoRiPO/2Z+n9nXpZm1vu255jlHqul6GUijnY9eir
	KF3HraGlv1wp3tmo8zT+vdKJch4DxIE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-HEFzikZhPcqMN1yOvb2dkA-1; Thu,
 14 Aug 2025 17:45:56 -0400
X-MC-Unique: HEFzikZhPcqMN1yOvb2dkA-1
X-Mimecast-MFC-AGG-ID: HEFzikZhPcqMN1yOvb2dkA_1755207955
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F63318004A7;
	Thu, 14 Aug 2025 21:45:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61E0730001A2;
	Thu, 14 Aug 2025 21:45:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
    Paulo Alcantara <pc@manguebit.org>, Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Xiaoli Feng <fengxiaoli0714@gmail.com>,
    Shyam Prasad N <sprasad@microsoft.com>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix unbuffered write error handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <915442.1755207950.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Aug 2025 22:45:50 +0100
Message-ID: <915443.1755207950@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

If all the subrequests in an unbuffered write stream fail, the subrequest
collector doesn't update the stream->transferred value and it retains its
initial LONG_MAX value.  Unfortunately, if all active streams fail, then w=
e
take the smallest value of { LONG_MAX, LONG_MAX, ... } as the value to set
in wreq->transferred - which is then returned from ->write_iter().

LONG_MAX was chosen as the initial value so that all the streams can be
quickly assessed by taking the smallest value of all stream->transferred -
but this only works if we've set any of them.

Fix this by adding a flag to indicate whether the value in
stream->transferred is valid and checking that when we integrate the
values.  stream->transferred can then be initialised to zero.

This was found by running the generic/750 xfstest against cifs with
cache=3Dnone.  It splices data to the target file.  Once (if) it has used =
up
all the available scratch space, the writes start failing with ENOSPC.
This causes ->write_iter() to fail.  However, it was returning
wreq->transferred, i.e. LONG_MAX, rather than an error (because it thought
the amount transferred was non-zero) and iter_file_splice_write() would
then try to clean up that amount of pipe bufferage - leading to an oops
when it overran.  The kernel log showed:

    CIFS: VFS: Send error in write =3D -28

followed by:

    BUG: kernel NULL pointer dereference, address: 0000000000000008

with:

    RIP: 0010:iter_file_splice_write+0x3a4/0x520
    do_splice+0x197/0x4e0

or:

    RIP: 0010:pipe_buf_release (include/linux/pipe_fs_i.h:282)
    iter_file_splice_write (fs/splice.c:755)

Also put a warning check into splice to announce if ->write_iter() returne=
d
that it had written more than it was asked to.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Reported-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220445
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/netfs/read_collect.c  |    4 +++-
 fs/netfs/write_collect.c |   10 ++++++++--
 fs/netfs/write_issue.c   |    4 ++--
 fs/splice.c              |    3 +++
 include/linux/netfs.h    |    1 +
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 3e804da1e1eb..a95e7aadafd0 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -281,8 +281,10 @@ static void netfs_collect_read_results(struct netfs_i=
o_request *rreq)
 		} else if (test_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags)) {
 			notes |=3D MADE_PROGRESS;
 		} else {
-			if (!stream->failed)
+			if (!stream->failed) {
 				stream->transferred +=3D transferred;
+				stream->transferred_valid =3D true;
+			}
 			if (front->transferred < front->len)
 				set_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags);
 			notes |=3D MADE_PROGRESS;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 0f3a36852a4d..cbf3d9194c7b 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -254,6 +254,7 @@ static void netfs_collect_write_results(struct netfs_i=
o_request *wreq)
 			if (front->start + front->transferred > stream->collected_to) {
 				stream->collected_to =3D front->start + front->transferred;
 				stream->transferred =3D stream->collected_to - wreq->start;
+				stream->transferred_valid =3D true;
 				notes |=3D MADE_PROGRESS;
 			}
 			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
@@ -356,6 +357,7 @@ bool netfs_write_collection(struct netfs_io_request *w=
req)
 {
 	struct netfs_inode *ictx =3D netfs_inode(wreq->inode);
 	size_t transferred;
+	bool transferred_valid =3D false;
 	int s;
 =

 	_enter("R=3D%x", wreq->debug_id);
@@ -376,12 +378,16 @@ bool netfs_write_collection(struct netfs_io_request =
*wreq)
 			continue;
 		if (!list_empty(&stream->subrequests))
 			return false;
-		if (stream->transferred < transferred)
+		if (stream->transferred_valid &&
+		    stream->transferred < transferred) {
 			transferred =3D stream->transferred;
+			transferred_valid =3D true;
+		}
 	}
 =

 	/* Okay, declare that all I/O is complete. */
-	wreq->transferred =3D transferred;
+	if (transferred_valid)
+		wreq->transferred =3D transferred;
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 =

 	if (wreq->io_streams[1].active &&
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 50bee2c4130d..0584cba1a043 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -118,12 +118,12 @@ struct netfs_io_request *netfs_create_write_req(stru=
ct address_space *mapping,
 	wreq->io_streams[0].prepare_write	=3D ictx->ops->prepare_write;
 	wreq->io_streams[0].issue_write		=3D ictx->ops->issue_write;
 	wreq->io_streams[0].collected_to	=3D start;
-	wreq->io_streams[0].transferred		=3D LONG_MAX;
+	wreq->io_streams[0].transferred		=3D 0;
 =

 	wreq->io_streams[1].stream_nr		=3D 1;
 	wreq->io_streams[1].source		=3D NETFS_WRITE_TO_CACHE;
 	wreq->io_streams[1].collected_to	=3D start;
-	wreq->io_streams[1].transferred		=3D LONG_MAX;
+	wreq->io_streams[1].transferred		=3D 0;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	=3D true;
 		wreq->io_streams[1].active	=3D true;
diff --git a/fs/splice.c b/fs/splice.c
index 4d6df083e0c0..f5094b6d00a0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -739,6 +739,9 @@ iter_file_splice_write(struct pipe_inode_info *pipe, s=
truct file *out,
 		sd.pos =3D kiocb.ki_pos;
 		if (ret <=3D 0)
 			break;
+		WARN_ONCE(ret > sd.total_len - left,
+			  "Splice Exceeded! ret=3D%zd tot=3D%zu left=3D%zu\n",
+			  ret, sd.total_len, left);
 =

 		sd.num_spliced +=3D ret;
 		sd.total_len -=3D ret;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 185bd8196503..98c96d649bf9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -150,6 +150,7 @@ struct netfs_io_stream {
 	bool			active;		/* T if stream is active */
 	bool			need_retry;	/* T if this stream needs retrying */
 	bool			failed;		/* T if this stream failed */
+	bool			transferred_valid; /* T is ->transferred is valid */
 };
 =

 /*


