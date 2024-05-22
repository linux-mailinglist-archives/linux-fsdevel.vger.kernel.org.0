Return-Path: <linux-fsdevel+bounces-19942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A574D8CB66F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 02:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110531F22016
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 00:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA72C9D;
	Wed, 22 May 2024 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOq4aALs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C728629
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716336159; cv=none; b=itxP5AUeahdei6SOpiJj/Tls1v+W2/24jydGBIbLvqS+3Ts6zInCtmgyNWlnU5GF8tO9ny2SifPiFQOkNRsPYZGYdJUeLrnNAsz77WQCEYKM7Gm8vlnXFecYCzDUoQ9l2Rf/gI10mEcvEo0Q8I/1ZvdmWg8fU0sPbxNnwZxhaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716336159; c=relaxed/simple;
	bh=mFQLmK0u0L6PeEG0M4FAs/47qdfzUrU/wDLiUWnZizc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=tQuqhZwaA5g9b0JCwIOM+0qKlmKIEbW8x0zV85hCoHOz22+cUnyLYt9UnRAJOqnX4HhZe8FdPZMMWXORzH+5KVX9LwkfJbtRonaNG3AuBvlHgB/EGDjy+YaL0pbWKKvHb3BL4YCn7Xdp5zNgwPcDQ81qvD1tY3OUWssM0kGB188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOq4aALs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716336156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oDcaJ/Lp2AwW/U3NTUWORaonQ76tpE8JccALy7WD+Ks=;
	b=VOq4aALsL1HASHQNGbfGCMkM3w+WtgG8nfK3at0YKSk+PRkRyosJl9Kj62K6v78YOmZhbr
	bJNkFR9ReQlpl5kbYhasc+Ny9BWbEarNhqmuOupo7hWoDtxcRZYGDLR+cMPpZ2cCSr+4yw
	54pkFiogBNPSReCrwkvWJXBWV9FFwo4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-CnM72DXNOiq9R9tznT5T_A-1; Tue, 21 May 2024 20:02:32 -0400
X-MC-Unique: CnM72DXNOiq9R9tznT5T_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52DEC812296;
	Wed, 22 May 2024 00:02:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 03A3C492BC6;
	Wed, 22 May 2024 00:02:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Enzo Matsumiya <ematsumiya@suse.de>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] netfs: Fix io_uring based write-through
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <351481.1716336150.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 May 2024 01:02:30 +0100
Message-ID: <351482.1716336150@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

This can be triggered by mounting a cifs filesystem with a cache=3Dstrict
mount option and then, using the fsx program from xfstests, doing:

        ltp/fsx -A -d -N 1000 -S 11463 -P /tmp /cifs-mount/foo \
          --replay-ops=3Dgen112-fsxops

Where gen112-fsxops holds:

        fallocate 0x6be7 0x8fc5 0x377d3
        copy_range 0x9c71 0x77e8 0x2edaf 0x377d3
        write 0x2776d 0x8f65 0x377d3

The problem is that netfs_io_request::len is being used for two purposes
and ends up getting set to the amount of data we transferred, not the
amount of data the caller asked to be transferred (for various reasons,
such as mmap'd writes, we might end up rounding out the data written to th=
e
server to include the entire folio at each end).

Fix this by keeping the amount we were asked to write in ->len and using
->submitted to track what we issued ops for.  Then, when we come to callin=
g
->ki_complete(), ->len is the right size.

This also required netfs_cleanup_dio_write() to change since we're no
longer advancing wreq->len.  Use wreq->transferred instead as we might hav=
e
done a short read and wreq->len must be set when setting up a direct write=
.

With this, the generic/112 xfstest passes if cifs is forced to put all
non-DIO opens into write-through mode.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <stfrench@microsoft.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/295086.1716298663@warthog.procyon.org.uk/ =
# v1
---
 Changes
 =3D=3D=3D=3D=3D=3D=3D
 ver #2)
  - Set wreq->len when doing direct writes.

 fs/netfs/direct_write.c  |    5 +++--
 fs/netfs/write_collect.c |    7 ++++---
 fs/netfs/write_issue.c   |    2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 608ba6416919..93b41e121042 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -12,7 +12,7 @@
 static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
 {
 	struct inode *inode =3D wreq->inode;
-	unsigned long long end =3D wreq->start + wreq->len;
+	unsigned long long end =3D wreq->start + wreq->transferred;
 =

 	if (!wreq->error &&
 	    i_size_read(inode) < end) {
@@ -92,8 +92,9 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct=
 kiocb *iocb, struct iov
 	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
 	if (async)
 		wreq->iocb =3D iocb;
+	wreq->len =3D iov_iter_count(&wreq->io_iter);
 	wreq->cleanup =3D netfs_cleanup_dio_write;
-	ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), iov_iter_count=
(&wreq->io_iter));
+	ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
 	if (ret < 0) {
 		_debug("begin =3D %zd", ret);
 		goto out;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 60112e4b2c5e..426cf87aaf2e 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -510,7 +510,7 @@ static void netfs_collect_write_results(struct netfs_i=
o_request *wreq)
 	 * stream has a gap that can be jumped.
 	 */
 	if (notes & SOME_EMPTY) {
-		unsigned long long jump_to =3D wreq->start + wreq->len;
+		unsigned long long jump_to =3D wreq->start + READ_ONCE(wreq->submitted)=
;
 =

 		for (s =3D 0; s < NR_IO_STREAMS; s++) {
 			stream =3D &wreq->io_streams[s];
@@ -690,10 +690,11 @@ void netfs_write_collection_worker(struct work_struc=
t *work)
 	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
 =

 	if (wreq->iocb) {
-		wreq->iocb->ki_pos +=3D wreq->transferred;
+		size_t written =3D min(wreq->transferred, wreq->len);
+		wreq->iocb->ki_pos +=3D written;
 		if (wreq->iocb->ki_complete)
 			wreq->iocb->ki_complete(
-				wreq->iocb, wreq->error ? wreq->error : wreq->transferred);
+				wreq->iocb, wreq->error ? wreq->error : written);
 		wreq->iocb =3D VFS_PTR_POISON;
 	}
 =

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index acbfd1f5ee9d..3aa86e268f40 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -254,7 +254,7 @@ static void netfs_issue_write(struct netfs_io_request =
*wreq,
 	stream->construct =3D NULL;
 =

 	if (subreq->start + subreq->len > wreq->start + wreq->submitted)
-		wreq->len =3D wreq->submitted =3D subreq->start + subreq->len - wreq->s=
tart;
+		WRITE_ONCE(wreq->submitted, subreq->start + subreq->len - wreq->start);
 	netfs_do_issue_write(stream, subreq);
 }
 =


